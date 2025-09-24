
define class Din_EntidadAJUSTECCCLIENTEAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_AJUSTECCCLIENTE'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = [str( TipoComprobante, 2, 0) + Letra + str( PuntoDeVenta, 4, 0) + str( Numero, 8, 0)]
	cExpresionCCPorCampos = [str( #tabla#.FACTTIPO, 2, 0) + #tabla#.FLETRA + str( #tabla#.FPTOVEN, 4, 0) + str( #tabla#.FNUMCOMP, 8, 0)]
	cTagClaveCandidata = '_AJUCC'
	cTagClavePk = '_AJUPK'
	cTablaPrincipal = 'AJUCCCLI'
	*--------------------------------------------------------------------------------------------------------
	function Inicializar() as boolean
		local loError as Exception, loEx as Exception

		dodefault()

		with this
			.cArchivoLogPrueba = SYS(0) + '_' + transform( date() ) + '_' + strtran( time(), ':', '.' ) + '_' + transform( golibrerias.obtenertimestamp() ) + '.txt' 
			.cArchivoLogPrueba = strtran( strtran( strtran( .cArchivoLogPrueba, '/', '-' ), ' ', '' ), '#', '' )
			.ColSentencias = _screen.zoo.crearobjeto('zooColeccion')
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
			local  lxAjucccliFectrans, lxAjucccliFecexpo, lxAjucccliFmodifw, lxAjucccliFecimpo, lxAjucccliHoraimpo, lxAjucccliHoraexpo, lxAjucccliHmodifw, lxAjucccliValtafw, lxAjucccliSaltafw, lxAjucccliZadsfw, lxAjucccliDescfw, lxAjucccliUmodifw, lxAjucccliVmodifw, lxAjucccliSmodifw, lxAjucccliUaltafw, lxAjucccliBdaltafw, lxAjucccliFaltafw, lxAjucccliEsttrans, lxAjucccliHaltafw, lxAjucccliBdmodifw, lxAjucccliTimestamp, lxAjucccliAnulado, lxAjucccliValor, lxAjucccliMoneda, lxAjucccliMotivo, lxAjucccliFacttipo, lxAjucccliFletra, lxAjucccliFptoven, lxAjucccliFnumcomp, lxAjucccliFfch, lxAjucccliCodigo, lxAjucccliFobs
				lxAjucccliFectrans =  .Fechatransferencia			lxAjucccliFecexpo =  .Fechaexpo			lxAjucccliFmodifw =  .Fechamodificacionfw			lxAjucccliFecimpo =  .Fechaimpo			lxAjucccliHoraimpo =  .Horaimpo			lxAjucccliHoraexpo =  .Horaexpo			lxAjucccliHmodifw =  .Horamodificacionfw			lxAjucccliValtafw =  .Versionaltafw			lxAjucccliSaltafw =  .Seriealtafw			lxAjucccliZadsfw =  .Zadsfw			lxAjucccliDescfw =  .Descripcionfw			lxAjucccliUmodifw =  .Usuariomodificacionfw			lxAjucccliVmodifw =  .Versionmodificacionfw			lxAjucccliSmodifw =  .Seriemodificacionfw			lxAjucccliUaltafw =  .Usuarioaltafw			lxAjucccliBdaltafw =  .Basededatosaltafw			lxAjucccliFaltafw =  .Fechaaltafw			lxAjucccliEsttrans =  .Estadotransferencia			lxAjucccliHaltafw =  .Horaaltafw			lxAjucccliBdmodifw =  .Basededatosmodificacionfw			lxAjucccliTimestamp = goLibrerias.ObtenerTimestamp()			lxAjucccliAnulado =  .Anulado			lxAjucccliValor =  upper( .Valor_PK ) 			lxAjucccliMoneda =  upper( .MonedaComprobante_PK ) 			lxAjucccliMotivo =  upper( .Motivo_PK ) 			lxAjucccliFacttipo =  .Tipocomprobante			lxAjucccliFletra =  .Letra			lxAjucccliFptoven =  .Puntodeventa			lxAjucccliFnumcomp =  .Numero			lxAjucccliFfch =  .Fecha			lxAjucccliCodigo =  .Codigo			lxAjucccliFobs =  .Obs
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxAjucccliCodigo = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.AJUCCCLI ( "Fectrans","Fecexpo","Fmodifw","Fecimpo","Horaimpo","Horaexpo","Hmodifw","Valtafw","Saltafw","Zadsfw","Descfw","Umodifw","Vmodifw","Smodifw","Ualtafw","Bdaltafw","Faltafw","Esttrans","Haltafw","Bdmodifw","Timestamp","Anulado","Valor","Moneda","Motivo","Facttipo","Fletra","Fptoven","Fnumcomp","Ffch","Codigo","Fobs" ) values ( <<"'" + this.ConvertirDateSql( lxAjucccliFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAjucccliFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAjucccliFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAjucccliFecimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjucccliHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjucccliHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjucccliHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjucccliValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjucccliSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjucccliZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjucccliDescfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjucccliUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjucccliVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjucccliSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjucccliUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjucccliBdaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAjucccliFaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjucccliEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjucccliHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjucccliBdmodifw ) + "'" >>, <<lxAjucccliTimestamp >>, <<iif( lxAjucccliAnulado, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxAjucccliValor ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjucccliMoneda ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjucccliMotivo ) + "'" >>, <<lxAjucccliFacttipo >>, <<"'" + this.FormatearTextoSql( lxAjucccliFletra ) + "'" >>, <<lxAjucccliFptoven >>, <<lxAjucccliFnumcomp >>, <<"'" + this.ConvertirDateSql( lxAjucccliFfch ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjucccliCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjucccliFobs ) + "'" >> )
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
		this.ComprobarTransaccion()
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = lxValorClavePrimaria

			.GenerarSentenciasComponentes()
			.EjecutarSentencias( This.ColSentencias )
		this.ComprobarTransaccion()

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.AjusteDetalle
				if this.oEntidad.AjusteDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxCliente_PK = loItem.Cliente_PK
					lxClientedetalle = loItem.Clientedetalle
					lxFechavencimiento = loItem.Fechavencimiento
					lxDescripcion = loItem.Descripcion
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.detajucccli("NROITEM","FPerson","FCLIENTE","FechaVto","Descrip","RMonto","CODIGO" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxCliente_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxClientedetalle ) + "'">>, <<"'" + this.ConvertirDateSql( lxFechavencimiento ) + "'">>, <<"'" + this.FormatearTextoSql( lxDescripcion ) + "'">>, <<lxMonto>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">> ) 
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
		this.oEntidad.Timestamp = lxAjucccliTimestamp
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
		return this.oEntidad.CODIGO
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function Actualizar() as boolean
	local loError as Exception, loEx as Exception, lxValorClavePrimaria as variant, lnI as Integer, loSentenciasTriggers as zoocoleccion OF zoocoleccion.prg, lcSentencia as string

		with this.oEntidad
			this.GenerarSentenciasComponentes()
			if .lAnular
				.Limpiar()
				.CargarAtributosAnulacion()
			endif
			local  lxAjucccliFectrans, lxAjucccliFecexpo, lxAjucccliFmodifw, lxAjucccliFecimpo, lxAjucccliHoraimpo, lxAjucccliHoraexpo, lxAjucccliHmodifw, lxAjucccliValtafw, lxAjucccliSaltafw, lxAjucccliZadsfw, lxAjucccliDescfw, lxAjucccliUmodifw, lxAjucccliVmodifw, lxAjucccliSmodifw, lxAjucccliUaltafw, lxAjucccliBdaltafw, lxAjucccliFaltafw, lxAjucccliEsttrans, lxAjucccliHaltafw, lxAjucccliBdmodifw, lxAjucccliTimestamp, lxAjucccliAnulado, lxAjucccliValor, lxAjucccliMoneda, lxAjucccliMotivo, lxAjucccliFacttipo, lxAjucccliFletra, lxAjucccliFptoven, lxAjucccliFnumcomp, lxAjucccliFfch, lxAjucccliCodigo, lxAjucccliFobs
				lxAjucccliFectrans =  .Fechatransferencia			lxAjucccliFecexpo =  .Fechaexpo			lxAjucccliFmodifw =  .Fechamodificacionfw			lxAjucccliFecimpo =  .Fechaimpo			lxAjucccliHoraimpo =  .Horaimpo			lxAjucccliHoraexpo =  .Horaexpo			lxAjucccliHmodifw =  .Horamodificacionfw			lxAjucccliValtafw =  .Versionaltafw			lxAjucccliSaltafw =  .Seriealtafw			lxAjucccliZadsfw =  .Zadsfw			lxAjucccliDescfw =  .Descripcionfw			lxAjucccliUmodifw =  .Usuariomodificacionfw			lxAjucccliVmodifw =  .Versionmodificacionfw			lxAjucccliSmodifw =  .Seriemodificacionfw			lxAjucccliUaltafw =  .Usuarioaltafw			lxAjucccliBdaltafw =  .Basededatosaltafw			lxAjucccliFaltafw =  .Fechaaltafw			lxAjucccliEsttrans =  .Estadotransferencia			lxAjucccliHaltafw =  .Horaaltafw			lxAjucccliBdmodifw =  .Basededatosmodificacionfw			lxAjucccliTimestamp = goLibrerias.ObtenerTimestamp()			lxAjucccliAnulado =  .Anulado			lxAjucccliValor =  upper( .Valor_PK ) 			lxAjucccliMoneda =  upper( .MonedaComprobante_PK ) 			lxAjucccliMotivo =  upper( .Motivo_PK ) 			lxAjucccliFacttipo =  .Tipocomprobante			lxAjucccliFletra =  .Letra			lxAjucccliFptoven =  .Puntodeventa			lxAjucccliFnumcomp =  .Numero			lxAjucccliFfch =  .Fecha			lxAjucccliCodigo =  .Codigo			lxAjucccliFobs =  .Obs
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
				update ZooLogic.AJUCCCLI set "Fectrans" = <<"'" + this.ConvertirDateSql( lxAjucccliFectrans ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxAjucccliFecexpo ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxAjucccliFmodifw ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxAjucccliFecimpo ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxAjucccliHoraimpo ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxAjucccliHoraexpo ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxAjucccliHmodifw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxAjucccliValtafw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxAjucccliSaltafw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxAjucccliZadsfw ) + "'">>,"Descfw" = <<"'" + this.FormatearTextoSql( lxAjucccliDescfw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxAjucccliUmodifw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxAjucccliVmodifw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxAjucccliSmodifw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxAjucccliUaltafw ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxAjucccliBdaltafw ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxAjucccliFaltafw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxAjucccliEsttrans ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxAjucccliHaltafw ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxAjucccliBdmodifw ) + "'">>,"Timestamp" = <<lxAjucccliTimestamp>>,"Anulado" = <<iif( lxAjucccliAnulado, 1, 0 )>>,"Valor" = <<"'" + this.FormatearTextoSql( lxAjucccliValor ) + "'">>,"Moneda" = <<"'" + this.FormatearTextoSql( lxAjucccliMoneda ) + "'">>,"Motivo" = <<"'" + this.FormatearTextoSql( lxAjucccliMotivo ) + "'">>,"Facttipo" = <<lxAjucccliFacttipo>>,"Fletra" = <<"'" + this.FormatearTextoSql( lxAjucccliFletra ) + "'">>,"Fptoven" = <<lxAjucccliFptoven>>,"Fnumcomp" = <<lxAjucccliFnumcomp>>,"Ffch" = <<"'" + this.ConvertirDateSql( lxAjucccliFfch ) + "'">>,"Codigo" = <<"'" + this.FormatearTextoSql( lxAjucccliCodigo ) + "'">>,"Fobs" = <<"'" + this.FormatearTextoSql( lxAjucccliFobs ) + "'">> where "Codigo" = <<"'" + this.FormatearTextoSql( lxAjucccliCodigo ) + "'">> and  AJUCCCLI.CODIGO != '' AND AJUCCCLI.FACTTIPO = 43 << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			this.ComprobarResultadoDeEjecucionDelUpdate()
		this.ComprobarTransaccion()
			.EjecutarSentencias( This.ColSentencias )
		this.ComprobarTransaccion()
			this.oConexion.EjecutarSql( 'delete from ZooLogic.detajucccli where "CODIGO" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.AjusteDetalle
				if this.oEntidad.AjusteDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxCliente_PK = loItem.Cliente_PK
					lxClientedetalle = loItem.Clientedetalle
					lxFechavencimiento = loItem.Fechavencimiento
					lxDescripcion = loItem.Descripcion
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.detajucccli("NROITEM","FPerson","FCLIENTE","FechaVto","Descrip","RMonto","CODIGO" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxCliente_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxClientedetalle ) + "'">>, <<"'" + this.ConvertirDateSql( lxFechavencimiento ) + "'">>, <<"'" + this.FormatearTextoSql( lxDescripcion ) + "'">>, <<lxMonto>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">> ) 
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
		this.oEntidad.Timestamp = lxAjucccliTimestamp
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 CODIGO from ZooLogic.AJUCCCLI where " + this.ConvertirFuncionesSql( " AJUCCCLI.CODIGO != '' AND AJUCCCLI.FACTTIPO = 43" ) )
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
			Local lxAjucccliCodigo
			lxAjucccliCodigo = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Valtafw" as "Versionaltafw", "Saltafw" as "Seriealtafw", "Zadsfw" as "Zadsfw", "Descfw" as "Descripcionfw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Bdaltafw" as "Basededatosaltafw", "Faltafw" as "Fechaaltafw", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Timestamp" as "Timestamp", "Anulado" as "Anulado", "Valor" as "Valor", "Moneda" as "Monedacomprobante", "Motivo" as "Motivo", "Facttipo" as "Tipocomprobante", "Fletra" as "Letra", "Fptoven" as "Puntodeventa", "Fnumcomp" as "Numero", "Ffch" as "Fecha", "Codigo" as "Codigo", "Fobs" as "Obs" from ZooLogic.AJUCCCLI where "Codigo" = <<"'" + this.FormatearTextoSql( lxAjucccliCodigo ) + "'">> and  AJUCCCLI.CODIGO != '' AND AJUCCCLI.FACTTIPO = 43
			endtext
			use in select('c_AJUSTECCCLIENTE')
			this.oConexion.EjecutarSql( lcSentencia, 'c_AJUSTECCCLIENTE', set( 'Datasession' ) )

			if reccount( 'c_AJUSTECCCLIENTE' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Fperson" as "Cliente", "Fcliente" as "Clientedetalle", "Fechavto" as "Fechavencimiento", "Descrip" as "Descripcion", "Rmonto" as "Monto", "Codigo" as "Codigo" from ZooLogic.detajucccli where CODIGO = <<"'" + this.FormatearTextoSql( c_AJUSTECCCLIENTE.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_AjusteDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_AjusteDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_AjusteDetalle
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ConsultarPorClaveCandidata() as Boolean
		local llRetorno as Boolean
		llRetorno = .t.
		with this.oEntidad
			Local lxajucccliFACTTIPO As Variant, lxajucccliFLETRA As Variant, lxajucccliFPTOVEN As Variant, lxajucccliFNUMCOMP As Variant
			lxajucccliFACTTIPO = .TipoComprobante
			lxajucccliFLETRA = .Letra
			lxajucccliFPTOVEN = .PuntoDeVenta
			lxajucccliFNUMCOMP = .Numero
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Valtafw" as "Versionaltafw", "Saltafw" as "Seriealtafw", "Zadsfw" as "Zadsfw", "Descfw" as "Descripcionfw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Bdaltafw" as "Basededatosaltafw", "Faltafw" as "Fechaaltafw", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Timestamp" as "Timestamp", "Anulado" as "Anulado", "Valor" as "Valor", "Moneda" as "Monedacomprobante", "Motivo" as "Motivo", "Facttipo" as "Tipocomprobante", "Fletra" as "Letra", "Fptoven" as "Puntodeventa", "Fnumcomp" as "Numero", "Ffch" as "Fecha", "Codigo" as "Codigo", "Fobs" as "Obs" from ZooLogic.AJUCCCLI where  AJUCCCLI.CODIGO != '' AND AJUCCCLI.FACTTIPO = 43 And FACTTIPO = <<lxajucccliFACTTIPO>> and FLETRA = <<"'" + this.FormatearTextoSql( lxajucccliFLETRA ) + "'">> and FPTOVEN = <<lxajucccliFPTOVEN>> and FNUMCOMP = <<lxajucccliFNUMCOMP>>
			endtext
			use in select('c_AJUSTECCCLIENTE')
			this.oConexion.EjecutarSql( lcSentencia, 'c_AJUSTECCCLIENTE', set( 'Datasession' ) )
			if reccount( 'c_AJUSTECCCLIENTE' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Fperson" as "Cliente", "Fcliente" as "Clientedetalle", "Fechavto" as "Fechavencimiento", "Descrip" as "Descripcion", "Rmonto" as "Monto", "Codigo" as "Codigo" from ZooLogic.detajucccli where CODIGO = <<"'" + this.FormatearTextoSql( c_AJUSTECCCLIENTE.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_AjusteDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_AjusteDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_AjusteDetalle
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxAjucccliCodigo as Variant
		llRetorno = .t.
		lxAjucccliCodigo = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.AJUCCCLI where "Codigo" = <<"'" + this.FormatearTextoSql( lxAjucccliCodigo ) + "'">> and  AJUCCCLI.CODIGO != '' AND AJUCCCLI.FACTTIPO = 43
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
				lcOrden =   iif( empty( .FechaAltaFW ), dtos( evaluate( goRegistry.Nucleo.FechaEnBlancoParaSqlServer ) ), dtos( .FechaAltaFW ) ) + .HoraAltaFW + .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Valtafw" as "Versionaltafw", "Saltafw" as "Seriealtafw", "Zadsfw" as "Zadsfw", "Descfw" as "Descripcionfw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Bdaltafw" as "Basededatosaltafw", "Faltafw" as "Fechaaltafw", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Timestamp" as "Timestamp", "Anulado" as "Anulado", "Valor" as "Valor", "Moneda" as "Monedacomprobante", "Motivo" as "Motivo", "Facttipo" as "Tipocomprobante", "Fletra" as "Letra", "Fptoven" as "Puntodeventa", "Fnumcomp" as "Numero", "Ffch" as "Fecha", "Codigo" as "Codigo", "Fobs" as "Obs" from ZooLogic.AJUCCCLI where  AJUCCCLI.CODIGO != '' AND AJUCCCLI.FACTTIPO = 43 order by FAltaFW,HAltaFW,CODIGO
			endtext
			use in select('c_AJUSTECCCLIENTE')
			this.oConexion.EjecutarSql( lcSentencia, 'c_AJUSTECCCLIENTE', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Fperson" as "Cliente", "Fcliente" as "Clientedetalle", "Fechavto" as "Fechavencimiento", "Descrip" as "Descripcion", "Rmonto" as "Monto", "Codigo" as "Codigo" from ZooLogic.detajucccli where CODIGO = <<"'" + this.FormatearTextoSql( c_AJUSTECCCLIENTE.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_AjusteDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_AjusteDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_AjusteDetalle
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
				lcOrden =   iif( empty( .FechaAltaFW ), dtos( evaluate( goRegistry.Nucleo.FechaEnBlancoParaSqlServer ) ), dtos( .FechaAltaFW ) ) + .HoraAltaFW + .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Valtafw" as "Versionaltafw", "Saltafw" as "Seriealtafw", "Zadsfw" as "Zadsfw", "Descfw" as "Descripcionfw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Bdaltafw" as "Basededatosaltafw", "Faltafw" as "Fechaaltafw", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Timestamp" as "Timestamp", "Anulado" as "Anulado", "Valor" as "Valor", "Moneda" as "Monedacomprobante", "Motivo" as "Motivo", "Facttipo" as "Tipocomprobante", "Fletra" as "Letra", "Fptoven" as "Puntodeventa", "Fnumcomp" as "Numero", "Ffch" as "Fecha", "Codigo" as "Codigo", "Fobs" as "Obs" from ZooLogic.AJUCCCLI where  funciones.dtos( FAltaFW ) + funciones.padr( HAltaFW, 8, ' ' ) + funciones.padr( CODIGO, 38, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  AJUCCCLI.CODIGO != '' AND AJUCCCLI.FACTTIPO = 43 order by FAltaFW,HAltaFW,CODIGO
			endtext
			use in select('c_AJUSTECCCLIENTE')
			this.oConexion.EjecutarSql( lcSentencia, 'c_AJUSTECCCLIENTE', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Fperson" as "Cliente", "Fcliente" as "Clientedetalle", "Fechavto" as "Fechavencimiento", "Descrip" as "Descripcion", "Rmonto" as "Monto", "Codigo" as "Codigo" from ZooLogic.detajucccli where CODIGO = <<"'" + this.FormatearTextoSql( c_AJUSTECCCLIENTE.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_AjusteDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_AjusteDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_AjusteDetalle
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
				lcOrden =   iif( empty( .FechaAltaFW ), dtos( evaluate( goRegistry.Nucleo.FechaEnBlancoParaSqlServer ) ), dtos( .FechaAltaFW ) ) + .HoraAltaFW + .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Valtafw" as "Versionaltafw", "Saltafw" as "Seriealtafw", "Zadsfw" as "Zadsfw", "Descfw" as "Descripcionfw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Bdaltafw" as "Basededatosaltafw", "Faltafw" as "Fechaaltafw", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Timestamp" as "Timestamp", "Anulado" as "Anulado", "Valor" as "Valor", "Moneda" as "Monedacomprobante", "Motivo" as "Motivo", "Facttipo" as "Tipocomprobante", "Fletra" as "Letra", "Fptoven" as "Puntodeventa", "Fnumcomp" as "Numero", "Ffch" as "Fecha", "Codigo" as "Codigo", "Fobs" as "Obs" from ZooLogic.AJUCCCLI where  funciones.dtos( FAltaFW ) + funciones.padr( HAltaFW, 8, ' ' ) + funciones.padr( CODIGO, 38, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  AJUCCCLI.CODIGO != '' AND AJUCCCLI.FACTTIPO = 43 order by FAltaFW desc,HAltaFW desc,CODIGO desc
			endtext
			use in select('c_AJUSTECCCLIENTE')
			this.oConexion.EjecutarSql( lcSentencia, 'c_AJUSTECCCLIENTE', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Fperson" as "Cliente", "Fcliente" as "Clientedetalle", "Fechavto" as "Fechavencimiento", "Descrip" as "Descripcion", "Rmonto" as "Monto", "Codigo" as "Codigo" from ZooLogic.detajucccli where CODIGO = <<"'" + this.FormatearTextoSql( c_AJUSTECCCLIENTE.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_AjusteDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_AjusteDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_AjusteDetalle
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
				lcOrden =   iif( empty( .FechaAltaFW ), dtos( evaluate( goRegistry.Nucleo.FechaEnBlancoParaSqlServer ) ), dtos( .FechaAltaFW ) ) + .HoraAltaFW + .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Valtafw" as "Versionaltafw", "Saltafw" as "Seriealtafw", "Zadsfw" as "Zadsfw", "Descfw" as "Descripcionfw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Bdaltafw" as "Basededatosaltafw", "Faltafw" as "Fechaaltafw", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Timestamp" as "Timestamp", "Anulado" as "Anulado", "Valor" as "Valor", "Moneda" as "Monedacomprobante", "Motivo" as "Motivo", "Facttipo" as "Tipocomprobante", "Fletra" as "Letra", "Fptoven" as "Puntodeventa", "Fnumcomp" as "Numero", "Ffch" as "Fecha", "Codigo" as "Codigo", "Fobs" as "Obs" from ZooLogic.AJUCCCLI where  AJUCCCLI.CODIGO != '' AND AJUCCCLI.FACTTIPO = 43 order by FAltaFW desc,HAltaFW desc,CODIGO desc
			endtext
			use in select('c_AJUSTECCCLIENTE')
			this.oConexion.EjecutarSql( lcSentencia, 'c_AJUSTECCCLIENTE', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Fperson" as "Cliente", "Fcliente" as "Clientedetalle", "Fechavto" as "Fechavencimiento", "Descrip" as "Descripcion", "Rmonto" as "Monto", "Codigo" as "Codigo" from ZooLogic.detajucccli where CODIGO = <<"'" + this.FormatearTextoSql( c_AJUSTECCCLIENTE.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_AjusteDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_AjusteDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_AjusteDetalle
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
			lcXml = this.oConexion.EjecutarSql( "select Fectrans,Fecexpo,Fmodifw,Fecimpo,Horaimpo,Horaexpo,Hmodifw,Valtafw,Saltafw,Zadsfw,Descfw,Umo" + ;
"difw,Vmodifw,Smodifw,Ualtafw,Bdaltafw,Faltafw,Esttrans,Haltafw,Bdmodifw,Timestamp,Anulado,Valor,Mone" + ;
"da,Motivo,Facttipo,Fletra,Fptoven,Fnumcomp,Ffch,Codigo,Fobs" + ;
" from ZooLogic.AJUCCCLI where  AJUCCCLI.CODIGO != '' AND AJUCCCLI.FACTTIPO = 43 and " + lcFiltro )
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
			local  lxAjucccliFectrans, lxAjucccliFecexpo, lxAjucccliFmodifw, lxAjucccliFecimpo, lxAjucccliHoraimpo, lxAjucccliHoraexpo, lxAjucccliHmodifw, lxAjucccliValtafw, lxAjucccliSaltafw, lxAjucccliZadsfw, lxAjucccliDescfw, lxAjucccliUmodifw, lxAjucccliVmodifw, lxAjucccliSmodifw, lxAjucccliUaltafw, lxAjucccliBdaltafw, lxAjucccliFaltafw, lxAjucccliEsttrans, lxAjucccliHaltafw, lxAjucccliBdmodifw, lxAjucccliTimestamp, lxAjucccliAnulado, lxAjucccliValor, lxAjucccliMoneda, lxAjucccliMotivo, lxAjucccliFacttipo, lxAjucccliFletra, lxAjucccliFptoven, lxAjucccliFnumcomp, lxAjucccliFfch, lxAjucccliCodigo, lxAjucccliFobs
				lxAjucccliFectrans = ctod( '  /  /    ' )			lxAjucccliFecexpo = ctod( '  /  /    ' )			lxAjucccliFmodifw = ctod( '  /  /    ' )			lxAjucccliFecimpo = ctod( '  /  /    ' )			lxAjucccliHoraimpo = []			lxAjucccliHoraexpo = []			lxAjucccliHmodifw = []			lxAjucccliValtafw = []			lxAjucccliSaltafw = []			lxAjucccliZadsfw = []			lxAjucccliDescfw = []			lxAjucccliUmodifw = []			lxAjucccliVmodifw = []			lxAjucccliSmodifw = []			lxAjucccliUaltafw = []			lxAjucccliBdaltafw = []			lxAjucccliFaltafw = ctod( '  /  /    ' )			lxAjucccliEsttrans = []			lxAjucccliHaltafw = []			lxAjucccliBdmodifw = []			lxAjucccliTimestamp = goLibrerias.ObtenerTimestamp()			lxAjucccliAnulado = .F.			lxAjucccliValor = []			lxAjucccliMoneda = []			lxAjucccliMotivo = []			lxAjucccliFacttipo = 0			lxAjucccliFletra = []			lxAjucccliFptoven = 0			lxAjucccliFnumcomp = 0			lxAjucccliFfch = ctod( '  /  /    ' )			lxAjucccliCodigo = []			lxAjucccliFobs = []
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.detajucccli where "CODIGO" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( [delete from ZooLogic.AJUCCCLI where "CODIGO" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			.GenerarSentenciasComponentes()
			.EjecutarSentencias( This.ColSentencias )
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
			lcTabla = 'AJUCCCLI' + '_' + tcCampo
			lcMemoAscii = ''

			lnIndice = alen(.aSqlMemos)
			lnIndice = iif(lnIndice = 1, 1, lnIndice + 1 )
			dimension .aSqlMemos(lnIndice)

			.aSqlMemos(lnIndice) = 'delete from ' + lcTabla + ' where CODIGO = ' + txValorClavePrimaria
			.GenerarSentenciasInsertTablaMemo( lcValor, lcTabla, txValorClavePrimaria )
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerSentenciaInsertMemo( tcTabla as String, txValorClavePrimaria as String, tcOrden as String, tcTexto as String ) as String
		return "Insert  into " + tcTabla + "(CODIGO, Orden, texto ) values ( " + txValorClavePrimaria + "," + tcOrden + ",'"+ tcTexto + "')"
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosEntidad( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  AJUCCCLI.CODIGO != '' AND AJUCCCLI.FACTTIPO = 43"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Valtafw" as "Versionaltafw", "Saltafw" as "Seriealtafw", "Zadsfw" as "Zadsfw", "Descfw" as "Descripcionfw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Bdaltafw" as "Basededatosaltafw", "Faltafw" as "Fechaaltafw", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Timestamp" as "Timestamp", "Anulado" as "Anulado", "Valor" as "Valor", "Moneda" as "Monedacomprobante", "Motivo" as "Motivo", "Facttipo" as "Tipocomprobante", "Fletra" as "Letra", "Fptoven" as "Puntodeventa", "Fnumcomp" as "Numero", "Ffch" as "Fecha", "Codigo" as "Codigo", "Fobs" as "Obs"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'AJUCCCLI', '', tnTope )
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
	Function ObtenerDatosDetalleAjusteDetalle( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  DETAJUCCCLI.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Nroitem" as "Nroitem", "Fperson" as "Cliente", "Fcliente" as "Clientedetalle", "Fechavto" as "Fechavencimiento", "Descrip" as "Descripcion", "Rmonto" as "Monto", "Codigo" as "Codigo"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleAjusteDetalle( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'detajucccli', 'AjusteDetalle', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleAjusteDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleAjusteDetalle( lcAtributo )
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
				Case lcAtributo == 'FECHAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECEXPO AS FECHAEXPO'
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'FECHAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECIMPO AS FECHAIMPO'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'DESCRIPCIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCFW AS DESCRIPCIONFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'TIMESTAMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIMESTAMP AS TIMESTAMP'
				Case lcAtributo == 'ANULADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ANULADO AS ANULADO'
				Case lcAtributo == 'VALOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALOR AS VALOR'
				Case lcAtributo == 'MONEDACOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONEDA AS MONEDACOMPROBANTE'
				Case lcAtributo == 'MOTIVO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MOTIVO AS MOTIVO'
				Case lcAtributo == 'TIPOCOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FACTTIPO AS TIPOCOMPROBANTE'
				Case lcAtributo == 'LETRA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FLETRA AS LETRA'
				Case lcAtributo == 'PUNTODEVENTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPTOVEN AS PUNTODEVENTA'
				Case lcAtributo == 'NUMERO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FNUMCOMP AS NUMERO'
				Case lcAtributo == 'FECHA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FFCH AS FECHA'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'OBS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FOBS AS OBS'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleAjusteDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'CLIENTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPERSON AS CLIENTE'
				Case lcAtributo == 'CLIENTEDETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FCLIENTE AS CLIENTEDETALLE'
				Case lcAtributo == 'FECHAVENCIMIENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHAVTO AS FECHAVENCIMIENTO'
				Case lcAtributo == 'DESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCRIP AS DESCRIPCION'
				Case lcAtributo == 'MONTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RMONTO AS MONTO'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEXPO'
				lcCampo = 'FECEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAIMPO'
				lcCampo = 'FECIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCIONFW'
				lcCampo = 'DESCFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'TIMESTAMP'
				lcCampo = 'TIMESTAMP'
			Case upper( alltrim( tcAtributo ) ) == 'ANULADO'
				lcCampo = 'ANULADO'
			Case upper( alltrim( tcAtributo ) ) == 'VALOR'
				lcCampo = 'VALOR'
			Case upper( alltrim( tcAtributo ) ) == 'MONEDACOMPROBANTE'
				lcCampo = 'MONEDA'
			Case upper( alltrim( tcAtributo ) ) == 'MOTIVO'
				lcCampo = 'MOTIVO'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOCOMPROBANTE'
				lcCampo = 'FACTTIPO'
			Case upper( alltrim( tcAtributo ) ) == 'LETRA'
				lcCampo = 'FLETRA'
			Case upper( alltrim( tcAtributo ) ) == 'PUNTODEVENTA'
				lcCampo = 'FPTOVEN'
			Case upper( alltrim( tcAtributo ) ) == 'NUMERO'
				lcCampo = 'FNUMCOMP'
			Case upper( alltrim( tcAtributo ) ) == 'FECHA'
				lcCampo = 'FFCH'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'OBS'
				lcCampo = 'FOBS'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleAjusteDetalle( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'CLIENTE'
				lcCampo = 'FPERSON'
			Case upper( alltrim( tcAtributo ) ) == 'CLIENTEDETALLE'
				lcCampo = 'FCLIENTE'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAVENCIMIENTO'
				lcCampo = 'FECHAVTO'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCION'
				lcCampo = 'DESCRIP'
			Case upper( alltrim( tcAtributo ) ) == 'MONTO'
				lcCampo = 'RMONTO'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerTablaDetalle( tcDetalle as string ) as String
		local lcRetorno as string
		lcRetorno = ''
		if upper( alltrim( tcDetalle ) ) == 'AJUSTEDETALLE'
			lcRetorno = 'DETAJUCCCLI'
		EndIf
		return lcRetorno
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasInsert() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcSentencia as string, loItem as object
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxAjucccliFectrans, lxAjucccliFecexpo, lxAjucccliFmodifw, lxAjucccliFecimpo, lxAjucccliHoraimpo, lxAjucccliHoraexpo, lxAjucccliHmodifw, lxAjucccliValtafw, lxAjucccliSaltafw, lxAjucccliZadsfw, lxAjucccliDescfw, lxAjucccliUmodifw, lxAjucccliVmodifw, lxAjucccliSmodifw, lxAjucccliUaltafw, lxAjucccliBdaltafw, lxAjucccliFaltafw, lxAjucccliEsttrans, lxAjucccliHaltafw, lxAjucccliBdmodifw, lxAjucccliTimestamp, lxAjucccliAnulado, lxAjucccliValor, lxAjucccliMoneda, lxAjucccliMotivo, lxAjucccliFacttipo, lxAjucccliFletra, lxAjucccliFptoven, lxAjucccliFnumcomp, lxAjucccliFfch, lxAjucccliCodigo, lxAjucccliFobs
				lxAjucccliFectrans =  .Fechatransferencia			lxAjucccliFecexpo =  .Fechaexpo			lxAjucccliFmodifw =  .Fechamodificacionfw			lxAjucccliFecimpo =  .Fechaimpo			lxAjucccliHoraimpo =  .Horaimpo			lxAjucccliHoraexpo =  .Horaexpo			lxAjucccliHmodifw =  .Horamodificacionfw			lxAjucccliValtafw =  .Versionaltafw			lxAjucccliSaltafw =  .Seriealtafw			lxAjucccliZadsfw =  .Zadsfw			lxAjucccliDescfw =  .Descripcionfw			lxAjucccliUmodifw =  .Usuariomodificacionfw			lxAjucccliVmodifw =  .Versionmodificacionfw			lxAjucccliSmodifw =  .Seriemodificacionfw			lxAjucccliUaltafw =  .Usuarioaltafw			lxAjucccliBdaltafw =  .Basededatosaltafw			lxAjucccliFaltafw =  .Fechaaltafw			lxAjucccliEsttrans =  .Estadotransferencia			lxAjucccliHaltafw =  .Horaaltafw			lxAjucccliBdmodifw =  .Basededatosmodificacionfw			lxAjucccliTimestamp = goLibrerias.ObtenerTimestamp()			lxAjucccliAnulado =  .Anulado			lxAjucccliValor =  upper( .Valor_PK ) 			lxAjucccliMoneda =  upper( .MonedaComprobante_PK ) 			lxAjucccliMotivo =  upper( .Motivo_PK ) 			lxAjucccliFacttipo =  .Tipocomprobante			lxAjucccliFletra =  .Letra			lxAjucccliFptoven =  .Puntodeventa			lxAjucccliFnumcomp =  .Numero			lxAjucccliFfch =  .Fecha			lxAjucccliCodigo =  .Codigo			lxAjucccliFobs =  .Obs
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.AJUCCCLI ( "Fectrans","Fecexpo","Fmodifw","Fecimpo","Horaimpo","Horaexpo","Hmodifw","Valtafw","Saltafw","Zadsfw","Descfw","Umodifw","Vmodifw","Smodifw","Ualtafw","Bdaltafw","Faltafw","Esttrans","Haltafw","Bdmodifw","Timestamp","Anulado","Valor","Moneda","Motivo","Facttipo","Fletra","Fptoven","Fnumcomp","Ffch","Codigo","Fobs" ) values ( <<"'" + this.ConvertirDateSql( lxAjucccliFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAjucccliFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAjucccliFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAjucccliFecimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjucccliHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjucccliHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjucccliHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjucccliValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjucccliSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjucccliZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjucccliDescfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjucccliUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjucccliVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjucccliSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjucccliUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjucccliBdaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAjucccliFaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjucccliEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjucccliHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjucccliBdmodifw ) + "'" >>, <<lxAjucccliTimestamp >>, <<iif( lxAjucccliAnulado, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxAjucccliValor ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjucccliMoneda ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjucccliMotivo ) + "'" >>, <<lxAjucccliFacttipo >>, <<"'" + this.FormatearTextoSql( lxAjucccliFletra ) + "'" >>, <<lxAjucccliFptoven >>, <<lxAjucccliFnumcomp >>, <<"'" + this.ConvertirDateSql( lxAjucccliFfch ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjucccliCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAjucccliFobs ) + "'" >> )
		endtext
		loColeccion.cTabla = 'AJUCCCLI' 
		loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		With this
			local lcValorClavePrimariaString as String
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.AjusteDetalle
				if this.oEntidad.AjusteDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxCliente_PK = loItem.Cliente_PK
					lxClientedetalle = loItem.Clientedetalle
					lxFechavencimiento = loItem.Fechavencimiento
					lxDescripcion = loItem.Descripcion
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.detajucccli("NROITEM","FPerson","FCLIENTE","FechaVto","Descrip","RMonto","CODIGO" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxCliente_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxClientedetalle ) + "'">>, <<"'" + this.ConvertirDateSql( lxFechavencimiento ) + "'">>, <<"'" + this.FormatearTextoSql( lxDescripcion ) + "'">>, <<lxMonto>>, << lcValorClavePrimariaString >> ) 
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
			if .lAnular
				.oAtributosAnulacion = .CrearObjeto( 'zooColeccion' )
				.ObtenerAtributosAnulacion()
				.Limpiar()
				.CargarAtributosAnulacion()
			endif
			local  lxAjucccliFectrans, lxAjucccliFecexpo, lxAjucccliFmodifw, lxAjucccliFecimpo, lxAjucccliHoraimpo, lxAjucccliHoraexpo, lxAjucccliHmodifw, lxAjucccliValtafw, lxAjucccliSaltafw, lxAjucccliZadsfw, lxAjucccliDescfw, lxAjucccliUmodifw, lxAjucccliVmodifw, lxAjucccliSmodifw, lxAjucccliUaltafw, lxAjucccliBdaltafw, lxAjucccliFaltafw, lxAjucccliEsttrans, lxAjucccliHaltafw, lxAjucccliBdmodifw, lxAjucccliTimestamp, lxAjucccliAnulado, lxAjucccliValor, lxAjucccliMoneda, lxAjucccliMotivo, lxAjucccliFacttipo, lxAjucccliFletra, lxAjucccliFptoven, lxAjucccliFnumcomp, lxAjucccliFfch, lxAjucccliCodigo, lxAjucccliFobs
				lxAjucccliFectrans =  .Fechatransferencia			lxAjucccliFecexpo =  .Fechaexpo			lxAjucccliFmodifw =  .Fechamodificacionfw			lxAjucccliFecimpo =  .Fechaimpo			lxAjucccliHoraimpo =  .Horaimpo			lxAjucccliHoraexpo =  .Horaexpo			lxAjucccliHmodifw =  .Horamodificacionfw			lxAjucccliValtafw =  .Versionaltafw			lxAjucccliSaltafw =  .Seriealtafw			lxAjucccliZadsfw =  .Zadsfw			lxAjucccliDescfw =  .Descripcionfw			lxAjucccliUmodifw =  .Usuariomodificacionfw			lxAjucccliVmodifw =  .Versionmodificacionfw			lxAjucccliSmodifw =  .Seriemodificacionfw			lxAjucccliUaltafw =  .Usuarioaltafw			lxAjucccliBdaltafw =  .Basededatosaltafw			lxAjucccliFaltafw =  .Fechaaltafw			lxAjucccliEsttrans =  .Estadotransferencia			lxAjucccliHaltafw =  .Horaaltafw			lxAjucccliBdmodifw =  .Basededatosmodificacionfw			lxAjucccliTimestamp = goLibrerias.ObtenerTimestamp()			lxAjucccliAnulado =  .Anulado			lxAjucccliValor =  upper( .Valor_PK ) 			lxAjucccliMoneda =  upper( .MonedaComprobante_PK ) 			lxAjucccliMotivo =  upper( .Motivo_PK ) 			lxAjucccliFacttipo =  .Tipocomprobante			lxAjucccliFletra =  .Letra			lxAjucccliFptoven =  .Puntodeventa			lxAjucccliFnumcomp =  .Numero			lxAjucccliFfch =  .Fecha			lxAjucccliCodigo =  .Codigo			lxAjucccliFobs =  .Obs
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  AJUCCCLI.CODIGO != '' AND AJUCCCLI.FACTTIPO = 43]
			text to lcSentencia noshow textmerge
				update ZooLogic.AJUCCCLI set "Fectrans" = <<"'" + this.ConvertirDateSql( lxAjucccliFectrans ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxAjucccliFecexpo ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxAjucccliFmodifw ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxAjucccliFecimpo ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxAjucccliHoraimpo ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxAjucccliHoraexpo ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxAjucccliHmodifw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxAjucccliValtafw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxAjucccliSaltafw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxAjucccliZadsfw ) + "'">>, "Descfw" = <<"'" + this.FormatearTextoSql( lxAjucccliDescfw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxAjucccliUmodifw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxAjucccliVmodifw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxAjucccliSmodifw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxAjucccliUaltafw ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxAjucccliBdaltafw ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxAjucccliFaltafw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxAjucccliEsttrans ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxAjucccliHaltafw ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxAjucccliBdmodifw ) + "'">>, "Timestamp" = <<lxAjucccliTimestamp>>, "Anulado" = <<iif( lxAjucccliAnulado, 1, 0 )>>, "Valor" = <<"'" + this.FormatearTextoSql( lxAjucccliValor ) + "'">>, "Moneda" = <<"'" + this.FormatearTextoSql( lxAjucccliMoneda ) + "'">>, "Motivo" = <<"'" + this.FormatearTextoSql( lxAjucccliMotivo ) + "'">>, "Facttipo" = <<lxAjucccliFacttipo>>, "Fletra" = <<"'" + this.FormatearTextoSql( lxAjucccliFletra ) + "'">>, "Fptoven" = <<lxAjucccliFptoven>>, "Fnumcomp" = <<lxAjucccliFnumcomp>>, "Ffch" = <<"'" + this.ConvertirDateSql( lxAjucccliFfch ) + "'">>, "Codigo" = <<"'" + this.FormatearTextoSql( lxAjucccliCodigo ) + "'">>, "Fobs" = <<"'" + this.FormatearTextoSql( lxAjucccliFobs ) + "'">> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'AJUCCCLI' 
		loColeccion.agregar( strtran(  lcSentencia, chr( 9 ), '' ) )
			loColeccion.Agregar([delete from ZooLogic.detajucccli where "CODIGO" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.AjusteDetalle
				if this.oEntidad.AjusteDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxCliente_PK = loItem.Cliente_PK
					lxClientedetalle = loItem.Clientedetalle
					lxFechavencimiento = loItem.Fechavencimiento
					lxDescripcion = loItem.Descripcion
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.detajucccli("NROITEM","FPerson","FCLIENTE","FechaVto","Descrip","RMonto","CODIGO" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxCliente_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxClientedetalle ) + "'">>, <<"'" + this.ConvertirDateSql( lxFechavencimiento ) + "'">>, <<"'" + this.FormatearTextoSql( lxDescripcion ) + "'">>, <<lxMonto>>, << lcValorClavePrimariaString >> ) 
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

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  AJUCCCLI.CODIGO != '' AND AJUCCCLI.FACTTIPO = 43]
		loColeccion.Agregar( 'delete from ZooLogic.AJUCCCLI where ' + lcFiltro )
			loColeccion.Agregar([delete from ZooLogic.detajucccli where "CODIGO" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.cTabla = 'AJUCCCLI' 
		EndWith
		return loColeccion
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerObjetoBusqueda() as Void
		return newobject( 'ObjetoBusqueda', '', '', this.oEntidad )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function GenerarSentenciasComponentes() as void
		local loColSentencias as ZooColeccion of zooColeccion.prg, lcItem as String
		dodefault()
		this.colSentencias.Remove( -1 )

		with this.oEntidad
		
			.oCompAjusteccvaloresventas.lNuevo = .EsNuevo()
			.oCompAjusteccvaloresventas.lEdicion = .EsEdicion()
			.oCompAjusteccvaloresventas.lEliminar = .lEliminar
			.oCompAjusteccvaloresventas.lAnular = .lAnular
			loColSentencias = .oCompAjusteccvaloresventas.grabar()
			for each lcItem in loColSentencias
				this.colSentencias.Agregar( lcItem )
			endfor
			
		endwith
		
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ObtenerSentenciaActualizacionTimeStamp() As String
		local lnTimeStamp as integer, lcRetorno as string, lcUpdateRealTime as string
		with this.oEntidad
		
			lnTimeStamp = goLibrerias.ObtenerTimestamp()
			lcUpdateRealTime = ", "+this.obtenercampoentidad("fechamodificacionfw")+" = "+goServicios.Datos.ObtenerFechaFormateada(goServicios.Librerias.ObtenerFecha());
			+ ", "+this.obtenercampoentidad("horamodificacionfw")+" = '"+goServicios.Librerias.ObtenerHora()+"'"
			lcRetorno = [update ZooLogic.AJUCCCLI set TimeStamp = ] + transform( lnTimeStamp ) + lcUpdateRealTime + [ where CODIGO = ] + "'" + this.FormatearTextoSql( .Codigo ) + "'" + [ and  AJUCCCLI.CODIGO != '' AND AJUCCCLI.FACTTIPO = 43] + goServicios.RealTime.ObtenerTagEstimulo( .cNombre )
		
		endwith
		return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function ObtenerCantidadRegistros() as integer
		local lnCantReg as integer
			local lcXml as string
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.AJUCCCLI where  AJUCCCLI.CODIGO != '' AND AJUCCCLI.FACTTIPO = 43" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.AJUCCCLI where CODIGO = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  AJUCCCLI.CODIGO != '' AND AJUCCCLI.FACTTIPO = 43" )
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
		local lcCursor as String, ldFecha as Date, lcHora as string, lcValorABuscar As String, lxValorClavePK As variant, lxValorClavePrimaria As variant, lcIdentificadorParaLoguear as string, lxajucccliFACTTIPO as variant, lxajucccliFLETRA as variant, lxajucccliFPTOVEN as variant, lxajucccliFNUMCOMP as variant, lcMensajeExtra as String
		lcValorABuscar = ''
		lxValorClavePK = ''
		lcMensajeExtra = ''
		lcCursor = This.oEntidad.cPrefijoRecibir + 'AJUSTECCCLIENTE'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.AJUCCCLI Where  FACTTIPO = ] + transform( &lcCursor..FACTTIPO   ) + [ and FLETRA = ] + "'" + this.FormatearTextoSql( &lcCursor..FLETRA     ) + "'" + [ and FPTOVEN = ] + transform( &lcCursor..FPTOVEN    ) + [ and FNUMCOMP = ] + transform( &lcCursor..FNUMCOMP   ), 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				lxValorClavePK = &lcCursor..CODIGO
				if lxValorClavePK == curSeek.CODIGO or this.oEntidad.lIgnorarClaveprimariaEnRecepcionBD 
					if lxValorClavePK != curSeek.CODIGO and this.oEntidad.lIgnorarClaveprimariaEnRecepcionBD 
						lcValorABuscar = curSeek.CODIGO
					else 
						lcValorABuscar = lxValorClavePK 
					endif 
					if This.ActualizaEnRecepcion() 
						if this.oEntidad.cContexto == 'C'
							if curSeek.ANULADO
								Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
								this.oConexion.EjecutarSql( [UPDATE ZooLogic.AJUCCCLI set  FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, DescFW = ] + "'" + this.FormatearTextoSql( &lcCursor..DescFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, TIMESTAMP = ] + transform( &lcCursor..TIMESTAMP )+ [, Anulado = ] + Transform( iif( &lcCursor..Anulado, 1, 0 ))+ [, VALOR = ] + "'" + this.FormatearTextoSql( &lcCursor..VALOR ) + "'"+ [, Moneda = ] + "'" + this.FormatearTextoSql( &lcCursor..Moneda ) + "'"+ [, MOTIVO = ] + "'" + this.FormatearTextoSql( &lcCursor..MOTIVO ) + "'"+ [, FACTTIPO = ] + transform( &lcCursor..FACTTIPO )+ [, FLETRA = ] + "'" + this.FormatearTextoSql( &lcCursor..FLETRA ) + "'"+ [, FPTOVEN = ] + transform( &lcCursor..FPTOVEN )+ [, FNUMCOMP = ] + transform( &lcCursor..FNUMCOMP )+ [, FFCH = ] + "'" + this.ConvertirDateSql( &lcCursor..FFCH ) + "'"+ [, CODIGO = ] + "'" + this.FormatearTextoSql( &lcCursor..CODIGO ) + "'"+ [, FObs = ] + "'" + this.FormatearTextoSql( &lcCursor..FObs ) + "'" + [ Where CODIGO = ] + "'" + this.FormatearTextoSql( lcValorABuscar ) + "'" )
								this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica anulado ).', tlLoguear )
							else
								this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir porque ya existe y no esta anulado.', tlLoguear )
							endif
						else
							this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir porque ya existe.', tlLoguear )
						endif
					else
						this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
					endIf
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir porque no coincide la clave principal.', tlLoguear )
				endIf
			else
				this.oConexion.EjecutarSql( [Select * From ZooLogic.AJUCCCLI Where CODIGO = ] + "'" + this.FormatearTextoSql( &lcCursor..CODIGO ) + "'", 'curSeek', this.datasessionid )
				if reccount( 'curSeek' ) > 0
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir como alta porque la clave principal ya existe', tlLoguear )
				Else
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					Text to lcCampos noShow
						 FECTRANS, FECEXPO, FMODIFW, FECIMPO, HORAIMPO, HORAEXPO, HMODIFW, VALTAFW, SALTAFW, ZADSFW, DescFW, UMODIFW, VMODIFW, SMODIFW, UALTAFW, BDALTAFW, FAltaFW, ESTTRANS, HAltaFW, BDMODIFW, TIMESTAMP, Anulado, VALOR, Moneda, MOTIVO, FACTTIPO, FLETRA, FPTOVEN, FNUMCOMP, FFCH, CODIGO, FObs
					EndText
					local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..DescFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FAltaFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HAltaFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + transform( &lcCursor..TIMESTAMP )
lcValoresCampos = lcValoresCampos  + ',' + Transform( iif( &lcCursor..Anulado, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALOR ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Moneda ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..MOTIVO ) + "'" + ',' + transform( &lcCursor..FACTTIPO ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..FLETRA ) + "'" + ',' + transform( &lcCursor..FPTOVEN ) + ',' + transform( &lcCursor..FNUMCOMP )
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FFCH ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CODIGO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..FObs ) + "'"
lcValoresCampos = substr(lcValoresCampos,2) 

					this.oConexion.EjecutarSql( [Insert into ZooLogic.AJUCCCLI ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
				EndIf
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'AJUSTECCCLIENTE'
		if This.ActualizaEnRecepcion()
		Local lcIn as String, lcCantRegistros as Integer
		Select( lcCursor )
		Count to lcCantRegistros
		If lcCantRegistros > 0
			lcIn = This.ObtenerInSqlServer( lcCursor, 'CODIGO','C')
			lnFragmento = goRegistry.nucleo.cantidadDeElementosEnSentenciaInSQL
			loIn = this.ObtenerColeccionInSqlServer( lcCursor,'','CODIGO')
			llEjecutaEnTransaccion = loIn.count > 0
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'BEGIN TRANSACTION' )
			endif
			for i = 1 to loIn.count step lnFragmento
				lcIn = this.ObtenerFragmentoColeccionInSqlServer( loIn, i, lnFragmento )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.detajucccli Where CODIGO] + lcIn  )
			endfor
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'COMMIT TRANSACTION' )
			endif
		EndIf
	endif
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMAJUSTECCCLIENTE'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where CODIGO in ( select CODIGO from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"NROITEM","FPerson","FCLIENTE","FechaVto","Descrip","RMonto","CODIGO"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.detajucccli ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.FPerson    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.FCLIENTE   ) + "'" + ',' + "'" + this.ConvertirDateSql( cDetallesExistentes.FechaVto   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Descrip    ) + "'" + ',' + transform( cDetallesExistentes.RMonto     ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CODIGO     ) + "'" + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	Use in select( 'cExistentes' )
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearCursorMemo( tcCursorACrear as String, tcTablaConMemo as String ) as Void
		create cursor &tcCursorACrear ( CODIGO C (38) , Orden N(16), texto C(80))
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirComponentes() As Void
		
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function ObtenerIdentificadorParaLoguear( tcCursor as String ) As String
		local lcRetorno as String, lnCC as String , loCC as Object, lni as Integer, lcSecuencia as String
		lcRetorno = this.oEntidad.cDescripcion 
		lcRetorno = lcRetorno + ' - Letra de comprobante: ' + transform( &tcCursor..FLETRA     )
		lcRetorno = lcRetorno + ' - Pto. venta: ' + transform( &tcCursor..FPTOVEN    )
		lcRetorno = lcRetorno + ' - Número: ' + transform( &tcCursor..FNUMCOMP   )
		Return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EsAliasDeProceso( tcAlias As String, tcPrefijo as string ) As Boolean
		local llRetorno as Boolean, lcAlias as String, lcPrefijo As String
		llRetorno = .F.
		lcAlias = upper( alltrim( tcAlias ) )
		lcPrefijo = upper( alltrim( tcPrefijo ) )
		Do Case
			Case  lcAlias == lcPrefijo + 'AJUSTECCCLIENTE'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'AJUSTECCCLIENTE_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMAJUSTECCCLIENTE'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_ajucccli')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'AJUSTECCCLIENTE'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..CODIGO
		llCondicion = isnull( lxVar ) or isnull( &lcCursor..FACTTIPO ) or isnull( &lcCursor..FLETRA ) or isnull( &lcCursor..FPTOVEN ) or isnull( &lcCursor..FNUMCOMP )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad AJUSTECCCLIENTE. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'AJUSTECCCLIENTE'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		select recno() as _Rec, * from &lcCursor into cursor CurConRecno
		select max( _Rec ) as Maximo,CODIGO as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( CODIGO, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		select max( _Rec ) as Maximo,str( FACTTIPO, 2, 0) + FLETRA + str( FPTOVEN, 4, 0) + str( FNUMCOMP, 8, 0) as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( str( FACTTIPO, 2, 0) + FLETRA + str( FPTOVEN, 4, 0) + str( FNUMCOMP, 8, 0), 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		Use in select( 'CurConRecno' )
		Use in select( 'RepMax' )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDatosInvalidos( toConexion as Object ) as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'AJUSTECCCLIENTE'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FAltaFW   
		* Validar ANTERIORES A 1/1/1753  FFCH      
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_ajucccli') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_ajucccli
Create Table ZooLogic.TablaTrabajo_ajucccli ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fectrans" datetime  null, 
"fecexpo" datetime  null, 
"fmodifw" datetime  null, 
"fecimpo" datetime  null, 
"horaimpo" char( 8 )  null, 
"horaexpo" char( 8 )  null, 
"hmodifw" char( 8 )  null, 
"valtafw" char( 13 )  null, 
"saltafw" char( 7 )  null, 
"zadsfw" varchar(max)  null, 
"descfw" char( 200 )  null, 
"umodifw" char( 100 )  null, 
"vmodifw" char( 13 )  null, 
"smodifw" char( 7 )  null, 
"ualtafw" char( 100 )  null, 
"bdaltafw" char( 8 )  null, 
"faltafw" datetime  null, 
"esttrans" char( 20 )  null, 
"haltafw" char( 8 )  null, 
"bdmodifw" char( 8 )  null, 
"timestamp" numeric( 20, 0 )  null, 
"anulado" bit  null, 
"valor" char( 5 )  null, 
"moneda" char( 10 )  null, 
"motivo" char( 3 )  null, 
"facttipo" numeric( 2, 0 )  null, 
"fletra" char( 1 )  null, 
"fptoven" numeric( 4, 0 )  null, 
"fnumcomp" numeric( 8, 0 )  null, 
"ffch" datetime  null, 
"codigo" char( 38 )  null, 
"fobs" char( 254 )  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_ajucccli' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_ajucccli' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'AJUSTECCCLIENTE'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		with loManejador
			if this.oEntidad.VerificarContexto( 'CB' )
			else
				.AgregarMapeo('Nrolinea','Nrolinea')
			endif
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('descfw','descfw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('timestamp','timestamp')
			.AgregarMapeo('anulado','anulado')
			.AgregarMapeo('valor','valor')
			.AgregarMapeo('moneda','moneda')
			.AgregarMapeo('motivo','motivo')
			.AgregarMapeo('facttipo','facttipo')
			.AgregarMapeo('fletra','fletra')
			.AgregarMapeo('fptoven','fptoven')
			.AgregarMapeo('fnumcomp','fnumcomp')
			.AgregarMapeo('ffch','ffch')
			.AgregarMapeo('codigo','codigo')
			.AgregarMapeo('fobs','fobs')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_ajucccli'
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
				Update t Set t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.DESCFW = isnull( d.DESCFW, t.DESCFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.TIMESTAMP = isnull( d.TIMESTAMP, t.TIMESTAMP ),t.ANULADO = isnull( d.ANULADO, t.ANULADO ),t.VALOR = isnull( d.VALOR, t.VALOR ),t.MONEDA = isnull( d.MONEDA, t.MONEDA ),t.MOTIVO = isnull( d.MOTIVO, t.MOTIVO ),t.FACTTIPO = isnull( d.FACTTIPO, t.FACTTIPO ),t.FLETRA = isnull( d.FLETRA, t.FLETRA ),t.FPTOVEN = isnull( d.FPTOVEN, t.FPTOVEN ),t.FNUMCOMP = isnull( d.FNUMCOMP, t.FNUMCOMP ),t.FFCH = isnull( d.FFCH, t.FFCH ),t.CODIGO = isnull( d.CODIGO, t.CODIGO ),t.FOBS = isnull( d.FOBS, t.FOBS )
					from ZooLogic.AJUCCCLI t inner join deleted d 
							 on t.CODIGO = d.CODIGO
							 and  t.FACTTIPO = d.FACTTIPO
							 and  t.FLETRA = d.FLETRA
							 and  t.FPTOVEN = d.FPTOVEN
							 and  t.FNUMCOMP = d.FNUMCOMP
				-- Fin Updates
				insert into ZooLogic.AJUCCCLI(Fectrans,Fecexpo,Fmodifw,Fecimpo,Horaimpo,Horaexpo,Hmodifw,Valtafw,Saltafw,Zadsfw,Descfw,Umodifw,Vmodifw,Smodifw,Ualtafw,Bdaltafw,Faltafw,Esttrans,Haltafw,Bdmodifw,Timestamp,Anulado,Valor,Moneda,Motivo,Facttipo,Fletra,Fptoven,Fnumcomp,Ffch,Codigo,Fobs)
					Select isnull( d.FECTRANS,''),isnull( d.FECEXPO,''),isnull( d.FMODIFW,''),isnull( d.FECIMPO,''),isnull( d.HORAIMPO,''),isnull( d.HORAEXPO,''),isnull( d.HMODIFW,''),isnull( d.VALTAFW,''),isnull( d.SALTAFW,''),isnull( d.ZADSFW,''),isnull( d.DESCFW,''),isnull( d.UMODIFW,''),isnull( d.VMODIFW,''),isnull( d.SMODIFW,''),isnull( d.UALTAFW,''),isnull( d.BDALTAFW,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.ESTTRANS,''),convert( char(8), getdate(), 108 ),isnull( d.BDMODIFW,''),isnull( d.TIMESTAMP,0),isnull( d.ANULADO,0),isnull( d.VALOR,''),isnull( d.MONEDA,''),isnull( d.MOTIVO,''),isnull( d.FACTTIPO,0),isnull( d.FLETRA,''),isnull( d.FPTOVEN,0),isnull( d.FNUMCOMP,0),isnull( d.FFCH,''),isnull( d.CODIGO,''),isnull( d.FOBS,'')
						From deleted d left join ZooLogic.AJUCCCLI pk 
							 on d.CODIGO = pk.CODIGO
						 left join ZooLogic.AJUCCCLI cc 
							 on  d.FACTTIPO = cc.FACTTIPO
							 and  d.FLETRA = cc.FLETRA
							 and  d.FPTOVEN = cc.FPTOVEN
							 and  d.FNUMCOMP = cc.FNUMCOMP
						Where pk.CODIGO Is Null 
							 and cc.FACTTIPO Is Null 
							 and cc.FLETRA Is Null 
							 and cc.FPTOVEN Is Null 
							 and cc.FNUMCOMP Is Null 
				-- Fin Inserts
				Insert into ZooLogic.Logueos ( Fecha, Nivel, Logger, Accion, BaseDeDatos, 
					EstadoDelSistema, Aplicacion, Version, 
					Serie, Usuario, NombrePc, 
					UsuarioPc, OrigenLogueo, Mensaje, Excepcion)
				select GetDate(), 'INFO', '', 'Importación <<lcEntidad>>','<<loLogueo.BaseDatos>>',
					<<loLogueo.EstadoSistema>>,'<<loLogueo.Aplicacion>>','<<loLogueo.Version>>',
					'<<loLogueo.Serie>>','<<loLogueo.Usuario>>','<<loLogueo.NombrePc>>',
					'<<loLogueo.UsuarioPc>>','<<loLogueo.OrigenLogueo>>','No se pudo importar la entidad <<lcEntidad>>: TIPO DE COMPROBANTE ' + cast( d.FACTTIPO as Varchar(2) ) + ', LETRA DE COMPROBANTE ' + cast( d.FLETRA as Varchar(1) ) + ', PTO. VENTA ' + cast( d.FPTOVEN as Varchar(4) ) + ', NÚMERO ' + cast( d.FNUMCOMP as Varchar(8) ) + '','La clave principal no es la esperada'
					from ZooLogic.AJUCCCLI t inner join deleted d 
							on   t.FACTTIPO = d.FACTTIPO
							 and  t.FLETRA = d.FLETRA
							 and  t.FPTOVEN = d.FPTOVEN
							 and  t.FNUMCOMP = d.FNUMCOMP
						left join deleted h 
							 on t.CODIGO = h.CODIGO
							 where h.CODIGO is null 
				Insert into ZooLogic.Logueos ( Fecha, Nivel, Logger, Accion, BaseDeDatos, 
					EstadoDelSistema, Aplicacion, Version, 
					Serie, Usuario, NombrePc, 
					UsuarioPc, OrigenLogueo, Mensaje, Excepcion)
				select GetDate(), 'INFO', '', 'Importación <<lcEntidad>>','<<loLogueo.BaseDatos>>',
					<<loLogueo.EstadoSistema>>,'<<loLogueo.Aplicacion>>','<<loLogueo.Version>>',
					'<<loLogueo.Serie>>','<<loLogueo.Usuario>>','<<loLogueo.NombrePc>>',
					'<<loLogueo.UsuarioPc>>','<<loLogueo.OrigenLogueo>>','No se pudo importar la entidad <<lcEntidad>>: TIPO DE COMPROBANTE ' + cast( d.FACTTIPO as Varchar(2) ) + ', LETRA DE COMPROBANTE ' + cast( d.FLETRA as Varchar(1) ) + ', PTO. VENTA ' + cast( d.FPTOVEN as Varchar(4) ) + ', NÚMERO ' + cast( d.FNUMCOMP as Varchar(8) ) + '','La clave principal a importar ya existe'
					from ZooLogic.AJUCCCLI t inner join deleted d 
							 on t.CODIGO = d.CODIGO
						left join deleted h 
							on   t.FACTTIPO = h.FACTTIPO
							 and   t.FLETRA = h.FLETRA
							 and   t.FPTOVEN = h.FPTOVEN
							 and   t.FNUMCOMP = h.FNUMCOMP
							where   h.FACTTIPO is null 
							 and   h.FLETRA is null 
							 and   h.FPTOVEN is null 
							 and   h.FNUMCOMP is null 
			End
		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_detajucccli( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_AJUCCCLI_detajucccli
ON ZooLogic.TablaTrabajo_AJUCCCLI_detajucccli
AFTER DELETE
As
Begin
Update t Set 
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.FPERSON = isnull( d.FPERSON, t.FPERSON ),
t.FCLIENTE = isnull( d.FCLIENTE, t.FCLIENTE ),
t.FECHAVTO = isnull( d.FECHAVTO, t.FECHAVTO ),
t.DESCRIP = isnull( d.DESCRIP, t.DESCRIP ),
t.RMONTO = isnull( d.RMONTO, t.RMONTO ),
t.CODIGO = isnull( d.CODIGO, t.CODIGO )
from ZooLogic.detajucccli t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.detajucccli
( 
"NROITEM",
"FPERSON",
"FCLIENTE",
"FECHAVTO",
"DESCRIP",
"RMONTO",
"CODIGO"
 )
Select 
d.NROITEM,
d.FPERSON,
d.FCLIENTE,
d.FECHAVTO,
d.DESCRIP,
d.RMONTO,
d.CODIGO
From deleted d left join ZooLogic.detajucccli pk 
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_ajucccli') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_ajucccli
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_AJUSTECCCLIENTE' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_AJUSTECCCLIENTE.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_AJUSTECCCLIENTE.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_AJUSTECCCLIENTE.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_AJUSTECCCLIENTE.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Horaimpo = nvl( c_AJUSTECCCLIENTE.Horaimpo, [] )
					.Horaexpo = nvl( c_AJUSTECCCLIENTE.Horaexpo, [] )
					.Horamodificacionfw = nvl( c_AJUSTECCCLIENTE.Horamodificacionfw, [] )
					.Versionaltafw = nvl( c_AJUSTECCCLIENTE.Versionaltafw, [] )
					.Seriealtafw = nvl( c_AJUSTECCCLIENTE.Seriealtafw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Descripcionfw = nvl( c_AJUSTECCCLIENTE.Descripcionfw, [] )
					.Usuariomodificacionfw = nvl( c_AJUSTECCCLIENTE.Usuariomodificacionfw, [] )
					.Versionmodificacionfw = nvl( c_AJUSTECCCLIENTE.Versionmodificacionfw, [] )
					.Seriemodificacionfw = nvl( c_AJUSTECCCLIENTE.Seriemodificacionfw, [] )
					.Usuarioaltafw = nvl( c_AJUSTECCCLIENTE.Usuarioaltafw, [] )
					.Basededatosaltafw = nvl( c_AJUSTECCCLIENTE.Basededatosaltafw, [] )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_AJUSTECCCLIENTE.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Estadotransferencia = nvl( c_AJUSTECCCLIENTE.Estadotransferencia, [] )
					.Horaaltafw = nvl( c_AJUSTECCCLIENTE.Horaaltafw, [] )
					.Basededatosmodificacionfw = nvl( c_AJUSTECCCLIENTE.Basededatosmodificacionfw, [] )
					.Timestamp = nvl( c_AJUSTECCCLIENTE.Timestamp, 0 )
					.Anulado = nvl( c_AJUSTECCCLIENTE.Anulado, .F. )
					.Valor_PK =  nvl( c_AJUSTECCCLIENTE.Valor, [] )
					.Monedacomprobante_PK =  nvl( c_AJUSTECCCLIENTE.Monedacomprobante, [] )
					.Motivo_PK =  nvl( c_AJUSTECCCLIENTE.Motivo, [] )
					.Tipocomprobante = nvl( c_AJUSTECCCLIENTE.Tipocomprobante, 0 )
					.Letra = nvl( c_AJUSTECCCLIENTE.Letra, [] )
					.Puntodeventa = nvl( c_AJUSTECCCLIENTE.Puntodeventa, 0 )
					.Numero = nvl( c_AJUSTECCCLIENTE.Numero, 0 )
					.Fecha = GoLibrerias.ObtenerFechaFormateada( nvl( c_AJUSTECCCLIENTE.Fecha, ctod( '  /  /    ' ) ) )
					.Codigo = nvl( c_AJUSTECCCLIENTE.Codigo, [] )
					.Ajustedetalle.Limpiar()
					.Ajustedetalle.SetearEsNavegacion( .lProcesando )
					.Ajustedetalle.Cargar()
					.Obs = nvl( c_AJUSTECCCLIENTE.Obs, [] )
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
			lxRetorno = c_AJUSTECCCLIENTE.CODIGO
		endif
		return lxRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function ActualizarLosNROItemDeLosDetalles() as void
		local loDetalle as object, loItem as object, lnContadorNroItem as integer, lnIndex as integer
		
		loDetalle = this.oEntidad.AjusteDetalle
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
		return c_AJUSTECCCLIENTE.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.AJUCCCLI' )
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
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "CODIGO"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
		text to lcSQL textmerge noshow
				SELECT nro,totalRegistros,CODIGO as Id
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    CODIGO from (
							select * 
								from ZooLogic.AJUCCCLI 
								Where   AJUCCCLI.CODIGO != '' AND AJUCCCLI.FACTTIPO = 43
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "AJUCCCLI", "", lcCursor, set("Datasession") )
		lcXml = this.CursorAXml( lcCursor )
		
		use in select( lcCursor )
		
		Return lcXml 
		
	endfunc
	*-----------------------------------------------------------------------------------------
	function ObtenerDatosEntidadPaginado( tcOrderBy as String, tcFiltro as String, tnCantidad as Integer, tnPagina as Integer )  as String
		local lcOrderBy as String, lnCuantos as Integer, lnPagina as Integer, lnTope as Integer, lnDesde as Integer, lcSQL as String, lcCursor as String, lcXml as String
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "CODIGO"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
			text to lcAtributos textmerge noshow
			"Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Valtafw" as "Versionaltafw", "Saltafw" as "Seriealtafw", "Zadsfw" as "Zadsfw", "Descfw" as "Descripcionfw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Bdaltafw" as "Basededatosaltafw", "Faltafw" as "Fechaaltafw", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Timestamp" as "Timestamp", "Anulado" as "Anulado", "Valor" as "Valor", "Moneda" as "Monedacomprobante", "Motivo" as "Motivo", "Facttipo" as "Tipocomprobante", "Fletra" as "Letra", "Fptoven" as "Puntodeventa", "Fnumcomp" as "Numero", "Ffch" as "Fecha", "Codigo" as "Codigo", "Fobs" as "Obs"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.AJUCCCLI 
								Where   AJUCCCLI.CODIGO != '' AND AJUCCCLI.FACTTIPO = 43
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
	Tabla = 'AJUCCCLI'
	Filtro = " AJUCCCLI.CODIGO != '' AND AJUCCCLI.FACTTIPO = 43"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " AJUCCCLI.CODIGO != '' AND AJUCCCLI.FACTTIPO = 43"
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
	<row entidad="AJUSTECCCLIENTE                         " atributo="FECHATRANSFERENCIA                      " tabla="AJUCCCLI       " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha de novedad                                                                                                                                                " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTECCCLIENTE                         " atributo="FECHAEXPO                               " tabla="AJUCCCLI       " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTECCCLIENTE                         " atributo="FECHAMODIFICACIONFW                     " tabla="AJUCCCLI       " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTECCCLIENTE                         " atributo="FECHAIMPO                               " tabla="AJUCCCLI       " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTECCCLIENTE                         " atributo="HORAIMPO                                " tabla="AJUCCCLI       " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTECCCLIENTE                         " atributo="HORAEXPO                                " tabla="AJUCCCLI       " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTECCCLIENTE                         " atributo="HORAMODIFICACIONFW                      " tabla="AJUCCCLI       " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTECCCLIENTE                         " atributo="VERSIONALTAFW                           " tabla="AJUCCCLI       " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTECCCLIENTE                         " atributo="SERIEALTAFW                             " tabla="AJUCCCLI       " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTECCCLIENTE                         " atributo="ZADSFW                                  " tabla="AJUCCCLI       " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTECCCLIENTE                         " atributo="DESCRIPCIONFW                           " tabla="AJUCCCLI       " campo="DESCFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="200" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTECCCLIENTE                         " atributo="USUARIOMODIFICACIONFW                   " tabla="AJUCCCLI       " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTECCCLIENTE                         " atributo="VERSIONMODIFICACIONFW                   " tabla="AJUCCCLI       " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTECCCLIENTE                         " atributo="SERIEMODIFICACIONFW                     " tabla="AJUCCCLI       " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTECCCLIENTE                         " atributo="USUARIOALTAFW                           " tabla="AJUCCCLI       " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTECCCLIENTE                         " atributo="BASEDEDATOSALTAFW                       " tabla="AJUCCCLI       " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTECCCLIENTE                         " atributo="FECHAALTAFW                             " tabla="AJUCCCLI       " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goservicios.librerias.obtenerFecha()                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTECCCLIENTE                         " atributo="ESTADOTRANSFERENCIA                     " tabla="AJUCCCLI       " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado de novedad                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTECCCLIENTE                         " atributo="HORAALTAFW                              " tabla="AJUCCCLI       " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="=goservicios.librerias.obtenerHora()                                                                                                                                                                                                                          " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTECCCLIENTE                         " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="AJUCCCLI       " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTECCCLIENTE                         " atributo="TIMESTAMP                               " tabla="AJUCCCLI       " campo="TIMESTAMP " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTECCCLIENTE                         " atributo="ANULADO                                 " tabla="AJUCCCLI       " campo="ANULADO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Anulado                                                                                                                                                         " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTECCCLIENTE                         " atributo="VALOR                                   " tabla="AJUCCCLI       " campo="VALOR     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="VALOR                                   " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="10" etiqueta="Valor                                                                                                                                                           " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="20" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTECCCLIENTE                         " atributo="MONEDACOMPROBANTE                       " tabla="AJUCCCLI       " campo="MONEDA    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="MONEDA                                  " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="400" etiqueta="Moneda                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="30" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTECCCLIENTE                         " atributo="MOTIVO                                  " tabla="AJUCCCLI       " campo="MOTIVO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="MOTIVO                                  " tipodato="C         " longitud="3" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="402" etiqueta="Motivo                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="40" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTECCCLIENTE                         " atributo="TIPOCOMPROBANTE                         " tabla="AJUCCCLI       " campo="FACTTIPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="=43                                                                                                                                                                                                                                                           " obligatorio="false" admitebusqueda="8" etiqueta="Tipo de comprobante                                                                                                                                             " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="1" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="50" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTECCCLIENTE                         " atributo="LETRA                                   " tabla="AJUCCCLI       " campo="FLETRA    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="1" decimales="0" valorsugerido="=&quot;X&quot;                                                                                                                                                                                                                                                          " obligatorio="true" admitebusqueda="2" etiqueta="Letra de comprobante                                                                                                                                            " dominio="NUMEROCOMPROBANTE             " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="2" mascara="X 9999-99999999          " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="60" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTECCCLIENTE                         " atributo="PUNTODEVENTA                            " tabla="AJUCCCLI       " campo="FPTOVEN   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="4" decimales="0" valorsugerido="=goServicios.Parametros.Felino.Numeraciones.BocaDeExpendio                                                                                                                                                                                                    " obligatorio="true" admitebusqueda="4" etiqueta="Pto. venta                                                                                                                                                      " dominio="NUMEROCOMPROBANTE             " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="3" mascara="X 9999-99999999          " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="70" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTECCCLIENTE                         " atributo="NUMERO                                  " tabla="AJUCCCLI       " campo="FNUMCOMP  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="6" etiqueta="Número                                                                                                                                                          " dominio="NUMEROCOMPROBANTE             " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="4" mascara="X 9999-99999999          " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="80" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTECCCLIENTE                         " atributo="FECHAVENCIMIENTO                        " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha de vencimiento                                                                                                                                            " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="90" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTECCCLIENTE                         " atributo="FECHA                                   " tabla="AJUCCCLI       " campo="FFCH      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=GOLIBRERIAS.OBTENERFECHA()                                                                                                                                                                                                                                   " obligatorio="true" admitebusqueda="404" etiqueta="Fecha                                                                                                                                                           " dominio="FECHACOMPROBANTE              " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="100" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTECCCLIENTE                         " atributo="CLIENTE                                 " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CLIENTE                                 " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Cliente                                                                                                                                                         " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="110" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTECCCLIENTE                         " atributo="CODIGO                                  " tabla="AJUCCCLI       " campo="CODIGO    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="0" etiqueta="Nro. Interno                                                                                                                                                    " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="120" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTECCCLIENTE                         " atributo="AJUSTEDETALLE                           " tabla="DETAJUCCCLI    " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="406" etiqueta="Detalle                                                                                                                                                         " dominio="DETALLEITEMAJUSTECCCLIENTE    " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="130" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTECCCLIENTE                         " atributo="OBS                                     " tabla="AJUCCCLI       " campo="FOBS      " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="254" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="408" etiqueta="Observaciones                                                                                                                                                   " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="0" orden="140" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="AJUSTECCCLIENTE                         " atributo="SIMBOLOMONETARIOCOMPROBANTE             " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="3" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="270" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="DESCRIPCION                             " tabla="XVAL           " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="11" etiqueta="Detalle Val.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join XVAL On AJUCCCLI.VALOR = XVAL.CLCOD And  XVAL.CLCOD != ''                                                                                                                                                                                          " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MONEDA                                  " atributo="DESCRIPCION                             " tabla="MONEDA         " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="401" etiqueta="Detalle Mon.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join MONEDA On AJUCCCLI.MONEDA = MONEDA.Codigo And  MONEDA.CODIGO != ''                                                                                                                                                                                 " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MOTIVO                                  " atributo="DESCRIPCION                             " tabla="MOTIVO         " campo="MOTDES    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="403" etiqueta="Detalle Mot.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join MOTIVO On AJUCCCLI.MOTIVO = MOTIVO.MOTCOD And  MOTIVO.MOTCOD != ''                                                                                                                                                                                 " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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