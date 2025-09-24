
define class Din_EntidadCANCELACIONDESENIASAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_CANCELACIONDESENIAS'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = [Letra + str( PuntoDeVenta, 4, 0) + str( Numero, 8, 0)]
	cExpresionCCPorCampos = [#tabla#.Letra + str( #tabla#.PtoVenta, 4, 0) + str( #tabla#.Numero, 8, 0)]
	cTagClaveCandidata = '_CDSCC'
	cTagClavePk = '_CDSPK'
	cTablaPrincipal = 'CANSENIA'
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
			local  lxCanseniaFecimpo, lxCanseniaFectrans, lxCanseniaFecexpo, lxCanseniaFmodifw, lxCanseniaTimestamp, lxCanseniaFacttipo, lxCanseniaHmodifw, lxCanseniaHoraimpo, lxCanseniaSaltafw, lxCanseniaVmodifw, lxCanseniaZadsfw, lxCanseniaDescfw, lxCanseniaUmodifw, lxCanseniaValtafw, lxCanseniaSmodifw, lxCanseniaUaltafw, lxCanseniaBdmodifw, lxCanseniaHoraexpo, lxCanseniaHaltafw, lxCanseniaFaltafw, lxCanseniaEsttrans, lxCanseniaBdaltafw, lxCanseniaCliente, lxCanseniaNumero, lxCanseniaCliedesde, lxCanseniaFfch, lxCanseniaCliehasta, lxCanseniaVigencia, lxCanseniaCodigo, lxCanseniaLetra, lxCanseniaPtoventa, lxCanseniaObs, lxCanseniaAnulado
				lxCanseniaFecimpo =  .Fechaimpo			lxCanseniaFectrans =  .Fechatransferencia			lxCanseniaFecexpo =  .Fechaexpo			lxCanseniaFmodifw =  .Fechamodificacionfw			lxCanseniaTimestamp = goLibrerias.ObtenerTimestamp()			lxCanseniaFacttipo =  .Tipocomprobante			lxCanseniaHmodifw =  .Horamodificacionfw			lxCanseniaHoraimpo =  .Horaimpo			lxCanseniaSaltafw =  .Seriealtafw			lxCanseniaVmodifw =  .Versionmodificacionfw			lxCanseniaZadsfw =  .Zadsfw			lxCanseniaDescfw =  .Descripcionfw			lxCanseniaUmodifw =  .Usuariomodificacionfw			lxCanseniaValtafw =  .Versionaltafw			lxCanseniaSmodifw =  .Seriemodificacionfw			lxCanseniaUaltafw =  .Usuarioaltafw			lxCanseniaBdmodifw =  .Basededatosmodificacionfw			lxCanseniaHoraexpo =  .Horaexpo			lxCanseniaHaltafw =  .Horaaltafw			lxCanseniaFaltafw =  .Fechaaltafw			lxCanseniaEsttrans =  .Estadotransferencia			lxCanseniaBdaltafw =  .Basededatosaltafw			lxCanseniaCliente =  upper( .Cliente_PK ) 			lxCanseniaNumero =  .Numero			lxCanseniaCliedesde =  .Clientedesde			lxCanseniaFfch =  .Fecha			lxCanseniaCliehasta =  .Clientehasta			lxCanseniaVigencia =  .Vigencia			lxCanseniaCodigo =  .Codigo			lxCanseniaLetra =  .Letra			lxCanseniaPtoventa =  .Puntodeventa			lxCanseniaObs =  .Observacion			lxCanseniaAnulado =  .Anulado
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxCanseniaCodigo = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.CANSENIA ( "Fecimpo","Fectrans","Fecexpo","Fmodifw","Timestamp","Facttipo","Hmodifw","Horaimpo","Saltafw","Vmodifw","Zadsfw","Descfw","Umodifw","Valtafw","Smodifw","Ualtafw","Bdmodifw","Horaexpo","Haltafw","Faltafw","Esttrans","Bdaltafw","Cliente","Numero","Cliedesde","Ffch","Cliehasta","Vigencia","Codigo","Letra","Ptoventa","Obs","Anulado" ) values ( <<"'" + this.ConvertirDateSql( lxCanseniaFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCanseniaFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCanseniaFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCanseniaFmodifw ) + "'" >>, <<lxCanseniaTimestamp >>, <<lxCanseniaFacttipo >>, <<"'" + this.FormatearTextoSql( lxCanseniaHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanseniaHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanseniaSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanseniaVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanseniaZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanseniaDescfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanseniaUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanseniaValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanseniaSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanseniaUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanseniaBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanseniaHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanseniaHaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCanseniaFaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanseniaEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanseniaBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanseniaCliente ) + "'" >>, <<lxCanseniaNumero >>, <<"'" + this.FormatearTextoSql( lxCanseniaCliedesde ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCanseniaFfch ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanseniaCliehasta ) + "'" >>, <<lxCanseniaVigencia >>, <<"'" + this.FormatearTextoSql( lxCanseniaCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanseniaLetra ) + "'" >>, <<lxCanseniaPtoventa >>, <<"'" + this.FormatearTextoSql( lxCanseniaObs ) + "'" >>, <<iif( lxCanseniaAnulado, 1, 0 ) >> )
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
			for each loItem in this.oEntidad.SeniasCancDetalle
				if this.oEntidad.SeniasCancDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxIdseniacancelada = loItem.Idseniacancelada
					lxCliente_PK = loItem.Cliente_PK
					lxClientedetalle = loItem.Clientedetalle
					lxComprobante = loItem.Comprobante
					lxFechaalta = loItem.Fechaalta
					lxFechavto = loItem.Fechavto
					lxImporte = loItem.Importe
					lxSeleccionada = loItem.Seleccionada
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.detcansenia("NROITEM","Codigo","IdSenia","cliente","cliedesc","Comprob","FechaAlta","FechaVto","Importe","Seleccion" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxIdseniacancelada ) + "'">>, <<"'" + this.FormatearTextoSql( lxCliente_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxClientedetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxComprobante ) + "'">>, <<"'" + this.ConvertirDateSql( lxFechaalta ) + "'">>, <<"'" + this.ConvertirDateSql( lxFechavto ) + "'">>, <<lxImporte>>, <<iif( lxSeleccionada, 1, 0 )>> ) 
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
		this.oEntidad.Timestamp = lxCanseniaTimestamp
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
			local  lxCanseniaFecimpo, lxCanseniaFectrans, lxCanseniaFecexpo, lxCanseniaFmodifw, lxCanseniaTimestamp, lxCanseniaFacttipo, lxCanseniaHmodifw, lxCanseniaHoraimpo, lxCanseniaSaltafw, lxCanseniaVmodifw, lxCanseniaZadsfw, lxCanseniaDescfw, lxCanseniaUmodifw, lxCanseniaValtafw, lxCanseniaSmodifw, lxCanseniaUaltafw, lxCanseniaBdmodifw, lxCanseniaHoraexpo, lxCanseniaHaltafw, lxCanseniaFaltafw, lxCanseniaEsttrans, lxCanseniaBdaltafw, lxCanseniaCliente, lxCanseniaNumero, lxCanseniaCliedesde, lxCanseniaFfch, lxCanseniaCliehasta, lxCanseniaVigencia, lxCanseniaCodigo, lxCanseniaLetra, lxCanseniaPtoventa, lxCanseniaObs, lxCanseniaAnulado
				lxCanseniaFecimpo =  .Fechaimpo			lxCanseniaFectrans =  .Fechatransferencia			lxCanseniaFecexpo =  .Fechaexpo			lxCanseniaFmodifw =  .Fechamodificacionfw			lxCanseniaTimestamp = goLibrerias.ObtenerTimestamp()			lxCanseniaFacttipo =  .Tipocomprobante			lxCanseniaHmodifw =  .Horamodificacionfw			lxCanseniaHoraimpo =  .Horaimpo			lxCanseniaSaltafw =  .Seriealtafw			lxCanseniaVmodifw =  .Versionmodificacionfw			lxCanseniaZadsfw =  .Zadsfw			lxCanseniaDescfw =  .Descripcionfw			lxCanseniaUmodifw =  .Usuariomodificacionfw			lxCanseniaValtafw =  .Versionaltafw			lxCanseniaSmodifw =  .Seriemodificacionfw			lxCanseniaUaltafw =  .Usuarioaltafw			lxCanseniaBdmodifw =  .Basededatosmodificacionfw			lxCanseniaHoraexpo =  .Horaexpo			lxCanseniaHaltafw =  .Horaaltafw			lxCanseniaFaltafw =  .Fechaaltafw			lxCanseniaEsttrans =  .Estadotransferencia			lxCanseniaBdaltafw =  .Basededatosaltafw			lxCanseniaCliente =  upper( .Cliente_PK ) 			lxCanseniaNumero =  .Numero			lxCanseniaCliedesde =  .Clientedesde			lxCanseniaFfch =  .Fecha			lxCanseniaCliehasta =  .Clientehasta			lxCanseniaVigencia =  .Vigencia			lxCanseniaCodigo =  .Codigo			lxCanseniaLetra =  .Letra			lxCanseniaPtoventa =  .Puntodeventa			lxCanseniaObs =  .Observacion			lxCanseniaAnulado =  .Anulado
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
				update ZooLogic.CANSENIA set "Fecimpo" = <<"'" + this.ConvertirDateSql( lxCanseniaFecimpo ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxCanseniaFectrans ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxCanseniaFecexpo ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxCanseniaFmodifw ) + "'">>,"Timestamp" = <<lxCanseniaTimestamp>>,"Facttipo" = <<lxCanseniaFacttipo>>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxCanseniaHmodifw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxCanseniaHoraimpo ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxCanseniaSaltafw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxCanseniaVmodifw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxCanseniaZadsfw ) + "'">>,"Descfw" = <<"'" + this.FormatearTextoSql( lxCanseniaDescfw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxCanseniaUmodifw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxCanseniaValtafw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxCanseniaSmodifw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxCanseniaUaltafw ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxCanseniaBdmodifw ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxCanseniaHoraexpo ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxCanseniaHaltafw ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxCanseniaFaltafw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxCanseniaEsttrans ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxCanseniaBdaltafw ) + "'">>,"Cliente" = <<"'" + this.FormatearTextoSql( lxCanseniaCliente ) + "'">>,"Numero" = <<lxCanseniaNumero>>,"Cliedesde" = <<"'" + this.FormatearTextoSql( lxCanseniaCliedesde ) + "'">>,"Ffch" = <<"'" + this.ConvertirDateSql( lxCanseniaFfch ) + "'">>,"Cliehasta" = <<"'" + this.FormatearTextoSql( lxCanseniaCliehasta ) + "'">>,"Vigencia" = <<lxCanseniaVigencia>>,"Codigo" = <<"'" + this.FormatearTextoSql( lxCanseniaCodigo ) + "'">>,"Letra" = <<"'" + this.FormatearTextoSql( lxCanseniaLetra ) + "'">>,"Ptoventa" = <<lxCanseniaPtoventa>>,"Obs" = <<"'" + this.FormatearTextoSql( lxCanseniaObs ) + "'">>,"Anulado" = <<iif( lxCanseniaAnulado, 1, 0 )>> where "Codigo" = <<"'" + this.FormatearTextoSql( lxCanseniaCodigo ) + "'">> and  CANSENIA.CODIGO != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			this.ComprobarResultadoDeEjecucionDelUpdate()
		this.ComprobarTransaccion()
			.EjecutarSentencias( This.ColSentencias )
		this.ComprobarTransaccion()
			this.oConexion.EjecutarSql( 'delete from ZooLogic.detcansenia where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.SeniasCancDetalle
				if this.oEntidad.SeniasCancDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxIdseniacancelada = loItem.Idseniacancelada
					lxCliente_PK = loItem.Cliente_PK
					lxClientedetalle = loItem.Clientedetalle
					lxComprobante = loItem.Comprobante
					lxFechaalta = loItem.Fechaalta
					lxFechavto = loItem.Fechavto
					lxImporte = loItem.Importe
					lxSeleccionada = loItem.Seleccionada
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.detcansenia("NROITEM","Codigo","IdSenia","cliente","cliedesc","Comprob","FechaAlta","FechaVto","Importe","Seleccion" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxIdseniacancelada ) + "'">>, <<"'" + this.FormatearTextoSql( lxCliente_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxClientedetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxComprobante ) + "'">>, <<"'" + this.ConvertirDateSql( lxFechaalta ) + "'">>, <<"'" + this.ConvertirDateSql( lxFechavto ) + "'">>, <<lxImporte>>, <<iif( lxSeleccionada, 1, 0 )>> ) 
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
		this.oEntidad.Timestamp = lxCanseniaTimestamp
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 Codigo from ZooLogic.CANSENIA where " + this.ConvertirFuncionesSql( " CANSENIA.CODIGO != ''" ) )
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
			Local lxCanseniaCodigo
			lxCanseniaCodigo = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Timestamp" as "Timestamp", "Facttipo" as "Tipocomprobante", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Descfw" as "Descripcionfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Faltafw" as "Fechaaltafw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Cliente" as "Cliente", "Numero" as "Numero", "Cliedesde" as "Clientedesde", "Ffch" as "Fecha", "Cliehasta" as "Clientehasta", "Vigencia" as "Vigencia", "Codigo" as "Codigo", "Letra" as "Letra", "Ptoventa" as "Puntodeventa", "Obs" as "Observacion", "Anulado" as "Anulado" from ZooLogic.CANSENIA where "Codigo" = <<"'" + this.FormatearTextoSql( lxCanseniaCodigo ) + "'">> and  CANSENIA.CODIGO != ''
			endtext
			use in select('c_CANCELACIONDESENIAS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CANCELACIONDESENIAS', set( 'Datasession' ) )

			if reccount( 'c_CANCELACIONDESENIAS' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Idsenia" as "Idseniacancelada", "Cliente" as "Cliente", "Cliedesc" as "Clientedetalle", "Comprob" as "Comprobante", "Fechaalta" as "Fechaalta", "Fechavto" as "Fechavto", "Importe" as "Importe", "Seleccion" as "Seleccionada" from ZooLogic.detcansenia where Codigo = <<"'" + this.FormatearTextoSql( c_CANCELACIONDESENIAS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_SeniasCancDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_SeniasCancDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_SeniasCancDetalle
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ConsultarPorClaveCandidata() as Boolean
		local llRetorno as Boolean
		llRetorno = .t.
		with this.oEntidad
			Local lxcanseniaLetra As Variant, lxcanseniaPtoVenta As Variant, lxcanseniaNumero As Variant
			lxcanseniaLetra = .Letra
			lxcanseniaPtoVenta = .PuntoDeVenta
			lxcanseniaNumero = .Numero
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Timestamp" as "Timestamp", "Facttipo" as "Tipocomprobante", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Descfw" as "Descripcionfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Faltafw" as "Fechaaltafw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Cliente" as "Cliente", "Numero" as "Numero", "Cliedesde" as "Clientedesde", "Ffch" as "Fecha", "Cliehasta" as "Clientehasta", "Vigencia" as "Vigencia", "Codigo" as "Codigo", "Letra" as "Letra", "Ptoventa" as "Puntodeventa", "Obs" as "Observacion", "Anulado" as "Anulado" from ZooLogic.CANSENIA where  CANSENIA.CODIGO != '' And Letra = <<"'" + this.FormatearTextoSql( lxcanseniaLetra ) + "'">> and PtoVenta = <<lxcanseniaPtoVenta>> and Numero = <<lxcanseniaNumero>>
			endtext
			use in select('c_CANCELACIONDESENIAS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CANCELACIONDESENIAS', set( 'Datasession' ) )
			if reccount( 'c_CANCELACIONDESENIAS' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Idsenia" as "Idseniacancelada", "Cliente" as "Cliente", "Cliedesc" as "Clientedetalle", "Comprob" as "Comprobante", "Fechaalta" as "Fechaalta", "Fechavto" as "Fechavto", "Importe" as "Importe", "Seleccion" as "Seleccionada" from ZooLogic.detcansenia where Codigo = <<"'" + this.FormatearTextoSql( c_CANCELACIONDESENIAS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_SeniasCancDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_SeniasCancDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_SeniasCancDetalle
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxCanseniaCodigo as Variant
		llRetorno = .t.
		lxCanseniaCodigo = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.CANSENIA where "Codigo" = <<"'" + this.FormatearTextoSql( lxCanseniaCodigo ) + "'">> and  CANSENIA.CODIGO != ''
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
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Timestamp" as "Timestamp", "Facttipo" as "Tipocomprobante", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Descfw" as "Descripcionfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Faltafw" as "Fechaaltafw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Cliente" as "Cliente", "Numero" as "Numero", "Cliedesde" as "Clientedesde", "Ffch" as "Fecha", "Cliehasta" as "Clientehasta", "Vigencia" as "Vigencia", "Codigo" as "Codigo", "Letra" as "Letra", "Ptoventa" as "Puntodeventa", "Obs" as "Observacion", "Anulado" as "Anulado" from ZooLogic.CANSENIA where  CANSENIA.CODIGO != '' order by FAltaFW,HAltaFW,Codigo
			endtext
			use in select('c_CANCELACIONDESENIAS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CANCELACIONDESENIAS', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Idsenia" as "Idseniacancelada", "Cliente" as "Cliente", "Cliedesc" as "Clientedetalle", "Comprob" as "Comprobante", "Fechaalta" as "Fechaalta", "Fechavto" as "Fechavto", "Importe" as "Importe", "Seleccion" as "Seleccionada" from ZooLogic.detcansenia where Codigo = <<"'" + this.FormatearTextoSql( c_CANCELACIONDESENIAS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_SeniasCancDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_SeniasCancDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_SeniasCancDetalle
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
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Timestamp" as "Timestamp", "Facttipo" as "Tipocomprobante", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Descfw" as "Descripcionfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Faltafw" as "Fechaaltafw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Cliente" as "Cliente", "Numero" as "Numero", "Cliedesde" as "Clientedesde", "Ffch" as "Fecha", "Cliehasta" as "Clientehasta", "Vigencia" as "Vigencia", "Codigo" as "Codigo", "Letra" as "Letra", "Ptoventa" as "Puntodeventa", "Obs" as "Observacion", "Anulado" as "Anulado" from ZooLogic.CANSENIA where  funciones.dtos( FAltaFW ) + funciones.padr( HAltaFW, 8, ' ' ) + funciones.padr( Codigo, 38, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  CANSENIA.CODIGO != '' order by FAltaFW,HAltaFW,Codigo
			endtext
			use in select('c_CANCELACIONDESENIAS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CANCELACIONDESENIAS', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Idsenia" as "Idseniacancelada", "Cliente" as "Cliente", "Cliedesc" as "Clientedetalle", "Comprob" as "Comprobante", "Fechaalta" as "Fechaalta", "Fechavto" as "Fechavto", "Importe" as "Importe", "Seleccion" as "Seleccionada" from ZooLogic.detcansenia where Codigo = <<"'" + this.FormatearTextoSql( c_CANCELACIONDESENIAS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_SeniasCancDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_SeniasCancDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_SeniasCancDetalle
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
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Timestamp" as "Timestamp", "Facttipo" as "Tipocomprobante", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Descfw" as "Descripcionfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Faltafw" as "Fechaaltafw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Cliente" as "Cliente", "Numero" as "Numero", "Cliedesde" as "Clientedesde", "Ffch" as "Fecha", "Cliehasta" as "Clientehasta", "Vigencia" as "Vigencia", "Codigo" as "Codigo", "Letra" as "Letra", "Ptoventa" as "Puntodeventa", "Obs" as "Observacion", "Anulado" as "Anulado" from ZooLogic.CANSENIA where  funciones.dtos( FAltaFW ) + funciones.padr( HAltaFW, 8, ' ' ) + funciones.padr( Codigo, 38, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  CANSENIA.CODIGO != '' order by FAltaFW desc,HAltaFW desc,Codigo desc
			endtext
			use in select('c_CANCELACIONDESENIAS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CANCELACIONDESENIAS', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Idsenia" as "Idseniacancelada", "Cliente" as "Cliente", "Cliedesc" as "Clientedetalle", "Comprob" as "Comprobante", "Fechaalta" as "Fechaalta", "Fechavto" as "Fechavto", "Importe" as "Importe", "Seleccion" as "Seleccionada" from ZooLogic.detcansenia where Codigo = <<"'" + this.FormatearTextoSql( c_CANCELACIONDESENIAS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_SeniasCancDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_SeniasCancDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_SeniasCancDetalle
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
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Timestamp" as "Timestamp", "Facttipo" as "Tipocomprobante", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Descfw" as "Descripcionfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Faltafw" as "Fechaaltafw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Cliente" as "Cliente", "Numero" as "Numero", "Cliedesde" as "Clientedesde", "Ffch" as "Fecha", "Cliehasta" as "Clientehasta", "Vigencia" as "Vigencia", "Codigo" as "Codigo", "Letra" as "Letra", "Ptoventa" as "Puntodeventa", "Obs" as "Observacion", "Anulado" as "Anulado" from ZooLogic.CANSENIA where  CANSENIA.CODIGO != '' order by FAltaFW desc,HAltaFW desc,Codigo desc
			endtext
			use in select('c_CANCELACIONDESENIAS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CANCELACIONDESENIAS', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Idsenia" as "Idseniacancelada", "Cliente" as "Cliente", "Cliedesc" as "Clientedetalle", "Comprob" as "Comprobante", "Fechaalta" as "Fechaalta", "Fechavto" as "Fechavto", "Importe" as "Importe", "Seleccion" as "Seleccionada" from ZooLogic.detcansenia where Codigo = <<"'" + this.FormatearTextoSql( c_CANCELACIONDESENIAS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_SeniasCancDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_SeniasCancDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_SeniasCancDetalle
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
			lcXml = this.oConexion.EjecutarSql( "select Fecimpo,Fectrans,Fecexpo,Fmodifw,Timestamp,Facttipo,Hmodifw,Horaimpo,Saltafw,Vmodifw,Zadsfw," + ;
"Descfw,Umodifw,Valtafw,Smodifw,Ualtafw,Bdmodifw,Horaexpo,Haltafw,Faltafw,Esttrans,Bdaltafw,Cliente,N" + ;
"umero,Cliedesde,Ffch,Cliehasta,Vigencia,Codigo,Letra,Ptoventa,Obs,Anulado" + ;
" from ZooLogic.CANSENIA where  CANSENIA.CODIGO != '' and " + lcFiltro )
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
			local  lxCanseniaFecimpo, lxCanseniaFectrans, lxCanseniaFecexpo, lxCanseniaFmodifw, lxCanseniaTimestamp, lxCanseniaFacttipo, lxCanseniaHmodifw, lxCanseniaHoraimpo, lxCanseniaSaltafw, lxCanseniaVmodifw, lxCanseniaZadsfw, lxCanseniaDescfw, lxCanseniaUmodifw, lxCanseniaValtafw, lxCanseniaSmodifw, lxCanseniaUaltafw, lxCanseniaBdmodifw, lxCanseniaHoraexpo, lxCanseniaHaltafw, lxCanseniaFaltafw, lxCanseniaEsttrans, lxCanseniaBdaltafw, lxCanseniaCliente, lxCanseniaNumero, lxCanseniaCliedesde, lxCanseniaFfch, lxCanseniaCliehasta, lxCanseniaVigencia, lxCanseniaCodigo, lxCanseniaLetra, lxCanseniaPtoventa, lxCanseniaObs, lxCanseniaAnulado
				lxCanseniaFecimpo = ctod( '  /  /    ' )			lxCanseniaFectrans = ctod( '  /  /    ' )			lxCanseniaFecexpo = ctod( '  /  /    ' )			lxCanseniaFmodifw = ctod( '  /  /    ' )			lxCanseniaTimestamp = goLibrerias.ObtenerTimestamp()			lxCanseniaFacttipo = 0			lxCanseniaHmodifw = []			lxCanseniaHoraimpo = []			lxCanseniaSaltafw = []			lxCanseniaVmodifw = []			lxCanseniaZadsfw = []			lxCanseniaDescfw = []			lxCanseniaUmodifw = []			lxCanseniaValtafw = []			lxCanseniaSmodifw = []			lxCanseniaUaltafw = []			lxCanseniaBdmodifw = []			lxCanseniaHoraexpo = []			lxCanseniaHaltafw = []			lxCanseniaFaltafw = ctod( '  /  /    ' )			lxCanseniaEsttrans = []			lxCanseniaBdaltafw = []			lxCanseniaCliente = []			lxCanseniaNumero = 0			lxCanseniaCliedesde = []			lxCanseniaFfch = ctod( '  /  /    ' )			lxCanseniaCliehasta = []			lxCanseniaVigencia = 0			lxCanseniaCodigo = []			lxCanseniaLetra = []			lxCanseniaPtoventa = 0			lxCanseniaObs = []			lxCanseniaAnulado = .F.
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.detcansenia where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( [delete from ZooLogic.CANSENIA where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'CANSENIA' + '_' + tcCampo
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
		lcWhere = " Where  CANSENIA.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Timestamp" as "Timestamp", "Facttipo" as "Tipocomprobante", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Descfw" as "Descripcionfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Faltafw" as "Fechaaltafw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Cliente" as "Cliente", "Numero" as "Numero", "Cliedesde" as "Clientedesde", "Ffch" as "Fecha", "Cliehasta" as "Clientehasta", "Vigencia" as "Vigencia", "Codigo" as "Codigo", "Letra" as "Letra", "Ptoventa" as "Puntodeventa", "Obs" as "Observacion", "Anulado" as "Anulado"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'CANSENIA', '', tnTope )
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
	Function ObtenerDatosDetalleSeniasCancDetalle( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  DETCANSENIA.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Nroitem" as "Nroitem", "Codigo" as "Codigo", "Idsenia" as "Idseniacancelada", "Cliente" as "Cliente", "Cliedesc" as "Clientedetalle", "Comprob" as "Comprobante", "Fechaalta" as "Fechaalta", "Fechavto" as "Fechavto", "Importe" as "Importe", "Seleccion" as "Seleccionada"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleSeniasCancDetalle( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'detcansenia', 'SeniasCancDetalle', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleSeniasCancDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleSeniasCancDetalle( lcAtributo )
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
				Case lcAtributo == 'FECHAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECEXPO AS FECHAEXPO'
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'TIMESTAMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIMESTAMP AS TIMESTAMP'
				Case lcAtributo == 'TIPOCOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FACTTIPO AS TIPOCOMPROBANTE'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'DESCRIPCIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCFW AS DESCRIPCIONFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'CLIENTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLIENTE AS CLIENTE'
				Case lcAtributo == 'NUMERO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NUMERO AS NUMERO'
				Case lcAtributo == 'CLIENTEDESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLIEDESDE AS CLIENTEDESDE'
				Case lcAtributo == 'FECHA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FFCH AS FECHA'
				Case lcAtributo == 'CLIENTEHASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLIEHASTA AS CLIENTEHASTA'
				Case lcAtributo == 'VIGENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VIGENCIA AS VIGENCIA'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'LETRA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LETRA AS LETRA'
				Case lcAtributo == 'PUNTODEVENTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PTOVENTA AS PUNTODEVENTA'
				Case lcAtributo == 'OBSERVACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'OBS AS OBSERVACION'
				Case lcAtributo == 'ANULADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ANULADO AS ANULADO'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleSeniasCancDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'IDSENIACANCELADA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDSENIA AS IDSENIACANCELADA'
				Case lcAtributo == 'CLIENTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLIENTE AS CLIENTE'
				Case lcAtributo == 'CLIENTEDETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLIEDESC AS CLIENTEDETALLE'
				Case lcAtributo == 'COMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COMPROB AS COMPROBANTE'
				Case lcAtributo == 'FECHAALTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHAALTA AS FECHAALTA'
				Case lcAtributo == 'FECHAVTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHAVTO AS FECHAVTO'
				Case lcAtributo == 'IMPORTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IMPORTE AS IMPORTE'
				Case lcAtributo == 'SELECCIONADA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SELECCION AS SELECCIONADA'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEXPO'
				lcCampo = 'FECEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'TIMESTAMP'
				lcCampo = 'TIMESTAMP'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOCOMPROBANTE'
				lcCampo = 'FACTTIPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCIONFW'
				lcCampo = 'DESCFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'CLIENTE'
				lcCampo = 'CLIENTE'
			Case upper( alltrim( tcAtributo ) ) == 'NUMERO'
				lcCampo = 'NUMERO'
			Case upper( alltrim( tcAtributo ) ) == 'CLIENTEDESDE'
				lcCampo = 'CLIEDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'FECHA'
				lcCampo = 'FFCH'
			Case upper( alltrim( tcAtributo ) ) == 'CLIENTEHASTA'
				lcCampo = 'CLIEHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'VIGENCIA'
				lcCampo = 'VIGENCIA'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'LETRA'
				lcCampo = 'LETRA'
			Case upper( alltrim( tcAtributo ) ) == 'PUNTODEVENTA'
				lcCampo = 'PTOVENTA'
			Case upper( alltrim( tcAtributo ) ) == 'OBSERVACION'
				lcCampo = 'OBS'
			Case upper( alltrim( tcAtributo ) ) == 'ANULADO'
				lcCampo = 'ANULADO'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleSeniasCancDetalle( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'IDSENIACANCELADA'
				lcCampo = 'IDSENIA'
			Case upper( alltrim( tcAtributo ) ) == 'CLIENTE'
				lcCampo = 'CLIENTE'
			Case upper( alltrim( tcAtributo ) ) == 'CLIENTEDETALLE'
				lcCampo = 'CLIEDESC'
			Case upper( alltrim( tcAtributo ) ) == 'COMPROBANTE'
				lcCampo = 'COMPROB'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTA'
				lcCampo = 'FECHAALTA'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAVTO'
				lcCampo = 'FECHAVTO'
			Case upper( alltrim( tcAtributo ) ) == 'IMPORTE'
				lcCampo = 'IMPORTE'
			Case upper( alltrim( tcAtributo ) ) == 'SELECCIONADA'
				lcCampo = 'SELECCION'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerTablaDetalle( tcDetalle as string ) as String
		local lcRetorno as string
		lcRetorno = ''
		if upper( alltrim( tcDetalle ) ) == 'SENIASCANCDETALLE'
			lcRetorno = 'DETCANSENIA'
		EndIf
		return lcRetorno
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasInsert() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcSentencia as string, loItem as object
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxCanseniaFecimpo, lxCanseniaFectrans, lxCanseniaFecexpo, lxCanseniaFmodifw, lxCanseniaTimestamp, lxCanseniaFacttipo, lxCanseniaHmodifw, lxCanseniaHoraimpo, lxCanseniaSaltafw, lxCanseniaVmodifw, lxCanseniaZadsfw, lxCanseniaDescfw, lxCanseniaUmodifw, lxCanseniaValtafw, lxCanseniaSmodifw, lxCanseniaUaltafw, lxCanseniaBdmodifw, lxCanseniaHoraexpo, lxCanseniaHaltafw, lxCanseniaFaltafw, lxCanseniaEsttrans, lxCanseniaBdaltafw, lxCanseniaCliente, lxCanseniaNumero, lxCanseniaCliedesde, lxCanseniaFfch, lxCanseniaCliehasta, lxCanseniaVigencia, lxCanseniaCodigo, lxCanseniaLetra, lxCanseniaPtoventa, lxCanseniaObs, lxCanseniaAnulado
				lxCanseniaFecimpo =  .Fechaimpo			lxCanseniaFectrans =  .Fechatransferencia			lxCanseniaFecexpo =  .Fechaexpo			lxCanseniaFmodifw =  .Fechamodificacionfw			lxCanseniaTimestamp = goLibrerias.ObtenerTimestamp()			lxCanseniaFacttipo =  .Tipocomprobante			lxCanseniaHmodifw =  .Horamodificacionfw			lxCanseniaHoraimpo =  .Horaimpo			lxCanseniaSaltafw =  .Seriealtafw			lxCanseniaVmodifw =  .Versionmodificacionfw			lxCanseniaZadsfw =  .Zadsfw			lxCanseniaDescfw =  .Descripcionfw			lxCanseniaUmodifw =  .Usuariomodificacionfw			lxCanseniaValtafw =  .Versionaltafw			lxCanseniaSmodifw =  .Seriemodificacionfw			lxCanseniaUaltafw =  .Usuarioaltafw			lxCanseniaBdmodifw =  .Basededatosmodificacionfw			lxCanseniaHoraexpo =  .Horaexpo			lxCanseniaHaltafw =  .Horaaltafw			lxCanseniaFaltafw =  .Fechaaltafw			lxCanseniaEsttrans =  .Estadotransferencia			lxCanseniaBdaltafw =  .Basededatosaltafw			lxCanseniaCliente =  upper( .Cliente_PK ) 			lxCanseniaNumero =  .Numero			lxCanseniaCliedesde =  .Clientedesde			lxCanseniaFfch =  .Fecha			lxCanseniaCliehasta =  .Clientehasta			lxCanseniaVigencia =  .Vigencia			lxCanseniaCodigo =  .Codigo			lxCanseniaLetra =  .Letra			lxCanseniaPtoventa =  .Puntodeventa			lxCanseniaObs =  .Observacion			lxCanseniaAnulado =  .Anulado
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.CANSENIA ( "Fecimpo","Fectrans","Fecexpo","Fmodifw","Timestamp","Facttipo","Hmodifw","Horaimpo","Saltafw","Vmodifw","Zadsfw","Descfw","Umodifw","Valtafw","Smodifw","Ualtafw","Bdmodifw","Horaexpo","Haltafw","Faltafw","Esttrans","Bdaltafw","Cliente","Numero","Cliedesde","Ffch","Cliehasta","Vigencia","Codigo","Letra","Ptoventa","Obs","Anulado" ) values ( <<"'" + this.ConvertirDateSql( lxCanseniaFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCanseniaFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCanseniaFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCanseniaFmodifw ) + "'" >>, <<lxCanseniaTimestamp >>, <<lxCanseniaFacttipo >>, <<"'" + this.FormatearTextoSql( lxCanseniaHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanseniaHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanseniaSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanseniaVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanseniaZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanseniaDescfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanseniaUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanseniaValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanseniaSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanseniaUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanseniaBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanseniaHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanseniaHaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCanseniaFaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanseniaEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanseniaBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanseniaCliente ) + "'" >>, <<lxCanseniaNumero >>, <<"'" + this.FormatearTextoSql( lxCanseniaCliedesde ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCanseniaFfch ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanseniaCliehasta ) + "'" >>, <<lxCanseniaVigencia >>, <<"'" + this.FormatearTextoSql( lxCanseniaCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanseniaLetra ) + "'" >>, <<lxCanseniaPtoventa >>, <<"'" + this.FormatearTextoSql( lxCanseniaObs ) + "'" >>, <<iif( lxCanseniaAnulado, 1, 0 ) >> )
		endtext
		loColeccion.cTabla = 'CANSENIA' 
		loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		With this
			local lcValorClavePrimariaString as String
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.SeniasCancDetalle
				if this.oEntidad.SeniasCancDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxIdseniacancelada = loItem.Idseniacancelada
					lxCliente_PK = loItem.Cliente_PK
					lxClientedetalle = loItem.Clientedetalle
					lxComprobante = loItem.Comprobante
					lxFechaalta = loItem.Fechaalta
					lxFechavto = loItem.Fechavto
					lxImporte = loItem.Importe
					lxSeleccionada = loItem.Seleccionada
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.detcansenia("NROITEM","Codigo","IdSenia","cliente","cliedesc","Comprob","FechaAlta","FechaVto","Importe","Seleccion" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxIdseniacancelada ) + "'">>, <<"'" + this.FormatearTextoSql( lxCliente_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxClientedetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxComprobante ) + "'">>, <<"'" + this.ConvertirDateSql( lxFechaalta ) + "'">>, <<"'" + this.ConvertirDateSql( lxFechavto ) + "'">>, <<lxImporte>>, <<iif( lxSeleccionada, 1, 0 )>> ) 
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
			local  lxCanseniaFecimpo, lxCanseniaFectrans, lxCanseniaFecexpo, lxCanseniaFmodifw, lxCanseniaTimestamp, lxCanseniaFacttipo, lxCanseniaHmodifw, lxCanseniaHoraimpo, lxCanseniaSaltafw, lxCanseniaVmodifw, lxCanseniaZadsfw, lxCanseniaDescfw, lxCanseniaUmodifw, lxCanseniaValtafw, lxCanseniaSmodifw, lxCanseniaUaltafw, lxCanseniaBdmodifw, lxCanseniaHoraexpo, lxCanseniaHaltafw, lxCanseniaFaltafw, lxCanseniaEsttrans, lxCanseniaBdaltafw, lxCanseniaCliente, lxCanseniaNumero, lxCanseniaCliedesde, lxCanseniaFfch, lxCanseniaCliehasta, lxCanseniaVigencia, lxCanseniaCodigo, lxCanseniaLetra, lxCanseniaPtoventa, lxCanseniaObs, lxCanseniaAnulado
				lxCanseniaFecimpo =  .Fechaimpo			lxCanseniaFectrans =  .Fechatransferencia			lxCanseniaFecexpo =  .Fechaexpo			lxCanseniaFmodifw =  .Fechamodificacionfw			lxCanseniaTimestamp = goLibrerias.ObtenerTimestamp()			lxCanseniaFacttipo =  .Tipocomprobante			lxCanseniaHmodifw =  .Horamodificacionfw			lxCanseniaHoraimpo =  .Horaimpo			lxCanseniaSaltafw =  .Seriealtafw			lxCanseniaVmodifw =  .Versionmodificacionfw			lxCanseniaZadsfw =  .Zadsfw			lxCanseniaDescfw =  .Descripcionfw			lxCanseniaUmodifw =  .Usuariomodificacionfw			lxCanseniaValtafw =  .Versionaltafw			lxCanseniaSmodifw =  .Seriemodificacionfw			lxCanseniaUaltafw =  .Usuarioaltafw			lxCanseniaBdmodifw =  .Basededatosmodificacionfw			lxCanseniaHoraexpo =  .Horaexpo			lxCanseniaHaltafw =  .Horaaltafw			lxCanseniaFaltafw =  .Fechaaltafw			lxCanseniaEsttrans =  .Estadotransferencia			lxCanseniaBdaltafw =  .Basededatosaltafw			lxCanseniaCliente =  upper( .Cliente_PK ) 			lxCanseniaNumero =  .Numero			lxCanseniaCliedesde =  .Clientedesde			lxCanseniaFfch =  .Fecha			lxCanseniaCliehasta =  .Clientehasta			lxCanseniaVigencia =  .Vigencia			lxCanseniaCodigo =  .Codigo			lxCanseniaLetra =  .Letra			lxCanseniaPtoventa =  .Puntodeventa			lxCanseniaObs =  .Observacion			lxCanseniaAnulado =  .Anulado
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  CANSENIA.CODIGO != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.CANSENIA set "Fecimpo" = <<"'" + this.ConvertirDateSql( lxCanseniaFecimpo ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxCanseniaFectrans ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxCanseniaFecexpo ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxCanseniaFmodifw ) + "'">>, "Timestamp" = <<lxCanseniaTimestamp>>, "Facttipo" = <<lxCanseniaFacttipo>>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxCanseniaHmodifw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxCanseniaHoraimpo ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxCanseniaSaltafw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxCanseniaVmodifw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxCanseniaZadsfw ) + "'">>, "Descfw" = <<"'" + this.FormatearTextoSql( lxCanseniaDescfw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxCanseniaUmodifw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxCanseniaValtafw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxCanseniaSmodifw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxCanseniaUaltafw ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxCanseniaBdmodifw ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxCanseniaHoraexpo ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxCanseniaHaltafw ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxCanseniaFaltafw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxCanseniaEsttrans ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxCanseniaBdaltafw ) + "'">>, "Cliente" = <<"'" + this.FormatearTextoSql( lxCanseniaCliente ) + "'">>, "Numero" = <<lxCanseniaNumero>>, "Cliedesde" = <<"'" + this.FormatearTextoSql( lxCanseniaCliedesde ) + "'">>, "Ffch" = <<"'" + this.ConvertirDateSql( lxCanseniaFfch ) + "'">>, "Cliehasta" = <<"'" + this.FormatearTextoSql( lxCanseniaCliehasta ) + "'">>, "Vigencia" = <<lxCanseniaVigencia>>, "Codigo" = <<"'" + this.FormatearTextoSql( lxCanseniaCodigo ) + "'">>, "Letra" = <<"'" + this.FormatearTextoSql( lxCanseniaLetra ) + "'">>, "Ptoventa" = <<lxCanseniaPtoventa>>, "Obs" = <<"'" + this.FormatearTextoSql( lxCanseniaObs ) + "'">>, "Anulado" = <<iif( lxCanseniaAnulado, 1, 0 )>> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'CANSENIA' 
		loColeccion.agregar( strtran(  lcSentencia, chr( 9 ), '' ) )
			loColeccion.Agregar([delete from ZooLogic.detcansenia where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.SeniasCancDetalle
				if this.oEntidad.SeniasCancDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxIdseniacancelada = loItem.Idseniacancelada
					lxCliente_PK = loItem.Cliente_PK
					lxClientedetalle = loItem.Clientedetalle
					lxComprobante = loItem.Comprobante
					lxFechaalta = loItem.Fechaalta
					lxFechavto = loItem.Fechavto
					lxImporte = loItem.Importe
					lxSeleccionada = loItem.Seleccionada
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.detcansenia("NROITEM","Codigo","IdSenia","cliente","cliedesc","Comprob","FechaAlta","FechaVto","Importe","Seleccion" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxIdseniacancelada ) + "'">>, <<"'" + this.FormatearTextoSql( lxCliente_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxClientedetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxComprobante ) + "'">>, <<"'" + this.ConvertirDateSql( lxFechaalta ) + "'">>, <<"'" + this.ConvertirDateSql( lxFechavto ) + "'">>, <<lxImporte>>, <<iif( lxSeleccionada, 1, 0 )>> ) 
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

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  CANSENIA.CODIGO != '']
		loColeccion.Agregar( 'delete from ZooLogic.CANSENIA where ' + lcFiltro )
			loColeccion.Agregar([delete from ZooLogic.detcansenia where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.cTabla = 'CANSENIA' 
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
		
			.oCompSeniasvencidas.lNuevo = .EsNuevo()
			.oCompSeniasvencidas.lEdicion = .EsEdicion()
			.oCompSeniasvencidas.lEliminar = .lEliminar
			.oCompSeniasvencidas.lAnular = .lAnular
			loColSentencias = .oCompSeniasvencidas.grabar()
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
			lcRetorno = [update ZooLogic.CANSENIA set TimeStamp = ] + transform( lnTimeStamp ) + lcUpdateRealTime + [ where Codigo = ] + "'" + this.FormatearTextoSql( .Codigo ) + "'" + [ and  CANSENIA.CODIGO != ''] + goServicios.RealTime.ObtenerTagEstimulo( .cNombre )
		
		endwith
		return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function ObtenerCantidadRegistros() as integer
		local lnCantReg as integer
			local lcXml as string
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.CANSENIA where  CANSENIA.CODIGO != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.CANSENIA where Codigo = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  CANSENIA.CODIGO != ''" )
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
		local lcCursor as String, ldFecha as Date, lcHora as string, lcValorABuscar As String, lxValorClavePK As variant, lxValorClavePrimaria As variant, lcIdentificadorParaLoguear as string, lxcanseniaNumero as variant, lxcanseniaLetra as variant, lxcanseniaPtoVenta as variant, lcMensajeExtra as String
		lcValorABuscar = ''
		lxValorClavePK = ''
		lcMensajeExtra = ''
		lcCursor = This.oEntidad.cPrefijoRecibir + 'CANCELACIONDESENIAS'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.CANSENIA Where  Letra = ] + "'" + this.FormatearTextoSql( &lcCursor..Letra      ) + "'" + [ and PtoVenta = ] + transform( &lcCursor..PtoVenta   ) + [ and Numero = ] + transform( &lcCursor..Numero     ), 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				lxValorClavePK = &lcCursor..Codigo
				if lxValorClavePK == curSeek.Codigo or this.oEntidad.lIgnorarClaveprimariaEnRecepcionBD 
					if lxValorClavePK != curSeek.Codigo and this.oEntidad.lIgnorarClaveprimariaEnRecepcionBD 
						lcValorABuscar = curSeek.Codigo
					else 
						lcValorABuscar = lxValorClavePK 
					endif 
					if This.ActualizaEnRecepcion() 
						if this.oEntidad.cContexto == 'C'
							if curSeek.ANULADO
								Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
								this.oConexion.EjecutarSql( [UPDATE ZooLogic.CANSENIA set  FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, TIMESTAMP = ] + transform( &lcCursor..TIMESTAMP )+ [, FACTTIPO = ] + transform( &lcCursor..FACTTIPO )+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, DescFW = ] + "'" + this.FormatearTextoSql( &lcCursor..DescFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, Cliente = ] + "'" + this.FormatearTextoSql( &lcCursor..Cliente ) + "'"+ [, Numero = ] + transform( &lcCursor..Numero )+ [, Cliedesde = ] + "'" + this.FormatearTextoSql( &lcCursor..Cliedesde ) + "'"+ [, FFCH = ] + "'" + this.ConvertirDateSql( &lcCursor..FFCH ) + "'"+ [, Cliehasta = ] + "'" + this.FormatearTextoSql( &lcCursor..Cliehasta ) + "'"+ [, vigencia = ] + transform( &lcCursor..vigencia )+ [, Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'"+ [, Letra = ] + "'" + this.FormatearTextoSql( &lcCursor..Letra ) + "'"+ [, PtoVenta = ] + transform( &lcCursor..PtoVenta )+ [, Obs = ] + "'" + this.FormatearTextoSql( &lcCursor..Obs ) + "'"+ [, Anulado = ] + Transform( iif( &lcCursor..Anulado, 1, 0 )) + [ Where Codigo = ] + "'" + this.FormatearTextoSql( lcValorABuscar ) + "'" )
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
				this.oConexion.EjecutarSql( [Select * From ZooLogic.CANSENIA Where Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'", 'curSeek', this.datasessionid )
				if reccount( 'curSeek' ) > 0
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir como alta porque la clave principal ya existe', tlLoguear )
				Else
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					Text to lcCampos noShow
						 FECIMPO, FECTRANS, FECEXPO, FMODIFW, TIMESTAMP, FACTTIPO, HMODIFW, HORAIMPO, SALTAFW, VMODIFW, ZADSFW, DescFW, UMODIFW, VALTAFW, SMODIFW, UALTAFW, BDMODIFW, HORAEXPO, HAltaFW, FAltaFW, ESTTRANS, BDALTAFW, Cliente, Numero, Cliedesde, FFCH, Cliehasta, vigencia, Codigo, Letra, PtoVenta, Obs, Anulado
					EndText
					local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + transform( &lcCursor..TIMESTAMP ) + ',' + transform( &lcCursor..FACTTIPO ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..DescFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HAltaFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FAltaFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Cliente ) + "'" + ',' + transform( &lcCursor..Numero ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..Cliedesde ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FFCH ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Cliehasta ) + "'" + ',' + transform( &lcCursor..vigencia )
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Letra ) + "'" + ',' + transform( &lcCursor..PtoVenta ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..Obs ) + "'" + ',' + Transform( iif( &lcCursor..Anulado, 1, 0 ))
lcValoresCampos = substr(lcValoresCampos,2) 

					this.oConexion.EjecutarSql( [Insert into ZooLogic.CANSENIA ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
				EndIf
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'CANCELACIONDESENIAS'
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
			this.oConexion.EjecutarSql( [Delete From ZooLogic.detcansenia Where Codigo] + lcIn  )
			endfor
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'COMMIT TRANSACTION' )
			endif
		EndIf
	endif
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMCANCELACIONDESENIAS'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where Codigo in ( select Codigo from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"NROITEM","Codigo","IdSenia","cliente","cliedesc","Comprob","FechaAlta","FechaVto","Importe","Seleccion"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.detcansenia ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Codigo     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.IdSenia    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.cliente    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.cliedesc   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Comprob    ) + "'" + ',' + "'" + this.ConvertirDateSql( cDetallesExistentes.FechaAlta  ) + "'" + ',' + "'" + this.ConvertirDateSql( cDetallesExistentes.FechaVto   ) + "'" + ',' + transform( cDetallesExistentes.Importe    ) + ',' + Transform( iif( cDetallesExistentes.Seleccion , 1, 0 )) + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	Use in select( 'cExistentes' )
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearCursorMemo( tcCursorACrear as String, tcTablaConMemo as String ) as Void
		create cursor &tcCursorACrear ( Codigo C (38) , Orden N(16), texto C(80))
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirComponentes() As Void
		
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function ObtenerIdentificadorParaLoguear( tcCursor as String ) As String
		local lcRetorno as String, lnCC as String , loCC as Object, lni as Integer, lcSecuencia as String
		lcRetorno = this.oEntidad.cDescripcion 
		lcRetorno = lcRetorno + ' - Letra de comprobante: ' + transform( &tcCursor..Letra      )
		lcRetorno = lcRetorno + ' - Pto. venta: ' + transform( &tcCursor..PtoVenta   )
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
			Case  lcAlias == lcPrefijo + 'CANCELACIONDESENIAS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'CANCELACIONDESENIAS_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'CANCELACIONDESENIAS_OBS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMCANCELACIONDESENIAS'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_cansenia')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'CANCELACIONDESENIAS'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..Codigo
		llCondicion = isnull( lxVar ) or isnull( &lcCursor..Letra ) or isnull( &lcCursor..PtoVenta ) or isnull( &lcCursor..Numero )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad CANCELACIONDESENIAS. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'CANCELACIONDESENIAS'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		select recno() as _Rec, * from &lcCursor into cursor CurConRecno
		select max( _Rec ) as Maximo,Codigo as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( Codigo, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		select max( _Rec ) as Maximo,Letra + str( PtoVenta, 4, 0) + str( Numero, 8, 0) as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( Letra + str( PtoVenta, 4, 0) + str( Numero, 8, 0), 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		Use in select( 'CurConRecno' )
		Use in select( 'RepMax' )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDatosInvalidos( toConexion as Object ) as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'CANCELACIONDESENIAS'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FAltaFW   
		* Validar ANTERIORES A 1/1/1753  FFCH      
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_cansenia') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_cansenia
Create Table ZooLogic.TablaTrabajo_cansenia ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fecimpo" datetime  null, 
"fectrans" datetime  null, 
"fecexpo" datetime  null, 
"fmodifw" datetime  null, 
"timestamp" numeric( 20, 0 )  null, 
"facttipo" numeric( 2, 0 )  null, 
"hmodifw" char( 8 )  null, 
"horaimpo" char( 8 )  null, 
"saltafw" char( 7 )  null, 
"vmodifw" char( 13 )  null, 
"zadsfw" varchar(max)  null, 
"descfw" char( 200 )  null, 
"umodifw" char( 100 )  null, 
"valtafw" char( 13 )  null, 
"smodifw" char( 7 )  null, 
"ualtafw" char( 100 )  null, 
"bdmodifw" char( 8 )  null, 
"horaexpo" char( 8 )  null, 
"haltafw" char( 8 )  null, 
"faltafw" datetime  null, 
"esttrans" char( 20 )  null, 
"bdaltafw" char( 8 )  null, 
"cliente" char( 5 )  null, 
"numero" numeric( 8, 0 )  null, 
"cliedesde" char( 5 )  null, 
"ffch" datetime  null, 
"cliehasta" char( 5 )  null, 
"vigencia" numeric( 2, 0 )  null, 
"codigo" char( 38 )  null, 
"letra" char( 1 )  null, 
"ptoventa" numeric( 4, 0 )  null, 
"obs" varchar(max)  null, 
"anulado" bit  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_cansenia' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_cansenia' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'CANCELACIONDESENIAS'
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
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('timestamp','timestamp')
			.AgregarMapeo('facttipo','facttipo')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('descfw','descfw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('cliente','cliente')
			.AgregarMapeo('numero','numero')
			.AgregarMapeo('cliedesde','cliedesde')
			.AgregarMapeo('ffch','ffch')
			.AgregarMapeo('cliehasta','cliehasta')
			.AgregarMapeo('vigencia','vigencia')
			.AgregarMapeo('codigo','codigo')
			.AgregarMapeo('letra','letra')
			.AgregarMapeo('ptoventa','ptoventa')
			.AgregarMapeo('obs','obs')
			.AgregarMapeo('anulado','anulado')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_cansenia'
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
				Update t Set t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.TIMESTAMP = isnull( d.TIMESTAMP, t.TIMESTAMP ),t.FACTTIPO = isnull( d.FACTTIPO, t.FACTTIPO ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.DESCFW = isnull( d.DESCFW, t.DESCFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.CLIENTE = isnull( d.CLIENTE, t.CLIENTE ),t.NUMERO = isnull( d.NUMERO, t.NUMERO ),t.CLIEDESDE = isnull( d.CLIEDESDE, t.CLIEDESDE ),t.FFCH = isnull( d.FFCH, t.FFCH ),t.CLIEHASTA = isnull( d.CLIEHASTA, t.CLIEHASTA ),t.VIGENCIA = isnull( d.VIGENCIA, t.VIGENCIA ),t.CODIGO = isnull( d.CODIGO, t.CODIGO ),t.LETRA = isnull( d.LETRA, t.LETRA ),t.PTOVENTA = isnull( d.PTOVENTA, t.PTOVENTA ),t.OBS = isnull( d.OBS, t.OBS ),t.ANULADO = isnull( d.ANULADO, t.ANULADO )
					from ZooLogic.CANSENIA t inner join deleted d 
							 on t.Codigo = d.Codigo
							 and  t.Letra = d.Letra
							 and  t.PtoVenta = d.PtoVenta
							 and  t.Numero = d.Numero
				-- Fin Updates
				insert into ZooLogic.CANSENIA(Fecimpo,Fectrans,Fecexpo,Fmodifw,Timestamp,Facttipo,Hmodifw,Horaimpo,Saltafw,Vmodifw,Zadsfw,Descfw,Umodifw,Valtafw,Smodifw,Ualtafw,Bdmodifw,Horaexpo,Haltafw,Faltafw,Esttrans,Bdaltafw,Cliente,Numero,Cliedesde,Ffch,Cliehasta,Vigencia,Codigo,Letra,Ptoventa,Obs,Anulado)
					Select isnull( d.FECIMPO,''),isnull( d.FECTRANS,''),isnull( d.FECEXPO,''),isnull( d.FMODIFW,''),isnull( d.TIMESTAMP,0),isnull( d.FACTTIPO,0),isnull( d.HMODIFW,''),isnull( d.HORAIMPO,''),isnull( d.SALTAFW,''),isnull( d.VMODIFW,''),isnull( d.ZADSFW,''),isnull( d.DESCFW,''),isnull( d.UMODIFW,''),isnull( d.VALTAFW,''),isnull( d.SMODIFW,''),isnull( d.UALTAFW,''),isnull( d.BDMODIFW,''),isnull( d.HORAEXPO,''),convert( char(8), getdate(), 108 ),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.ESTTRANS,''),isnull( d.BDALTAFW,''),isnull( d.CLIENTE,''),isnull( d.NUMERO,0),isnull( d.CLIEDESDE,''),isnull( d.FFCH,''),isnull( d.CLIEHASTA,''),isnull( d.VIGENCIA,0),isnull( d.CODIGO,''),isnull( d.LETRA,''),isnull( d.PTOVENTA,0),isnull( d.OBS,''),isnull( d.ANULADO,0)
						From deleted d left join ZooLogic.CANSENIA pk 
							 on d.Codigo = pk.Codigo
						 left join ZooLogic.CANSENIA cc 
							 on  d.Letra = cc.Letra
							 and  d.PtoVenta = cc.PtoVenta
							 and  d.Numero = cc.Numero
						Where pk.Codigo Is Null 
							 and cc.Letra Is Null 
							 and cc.PtoVenta Is Null 
							 and cc.Numero Is Null 
				-- Fin Inserts
				Insert into ZooLogic.Logueos ( Fecha, Nivel, Logger, Accion, BaseDeDatos, 
					EstadoDelSistema, Aplicacion, Version, 
					Serie, Usuario, NombrePc, 
					UsuarioPc, OrigenLogueo, Mensaje, Excepcion)
				select GetDate(), 'INFO', '', 'Importación <<lcEntidad>>','<<loLogueo.BaseDatos>>',
					<<loLogueo.EstadoSistema>>,'<<loLogueo.Aplicacion>>','<<loLogueo.Version>>',
					'<<loLogueo.Serie>>','<<loLogueo.Usuario>>','<<loLogueo.NombrePc>>',
					'<<loLogueo.UsuarioPc>>','<<loLogueo.OrigenLogueo>>','No se pudo importar la entidad <<lcEntidad>>: LETRA DE COMPROBANTE ' + cast( d.Letra as Varchar(1) ) + ', PTO. VENTA ' + cast( d.PtoVenta as Varchar(4) ) + ', NÚMERO ' + cast( d.Numero as Varchar(8) ) + '','La clave principal no es la esperada'
					from ZooLogic.CANSENIA t inner join deleted d 
							on   t.Letra = d.Letra
							 and  t.PtoVenta = d.PtoVenta
							 and  t.Numero = d.Numero
						left join deleted h 
							 on t.Codigo = h.Codigo
							 where h.Codigo is null 
				Insert into ZooLogic.Logueos ( Fecha, Nivel, Logger, Accion, BaseDeDatos, 
					EstadoDelSistema, Aplicacion, Version, 
					Serie, Usuario, NombrePc, 
					UsuarioPc, OrigenLogueo, Mensaje, Excepcion)
				select GetDate(), 'INFO', '', 'Importación <<lcEntidad>>','<<loLogueo.BaseDatos>>',
					<<loLogueo.EstadoSistema>>,'<<loLogueo.Aplicacion>>','<<loLogueo.Version>>',
					'<<loLogueo.Serie>>','<<loLogueo.Usuario>>','<<loLogueo.NombrePc>>',
					'<<loLogueo.UsuarioPc>>','<<loLogueo.OrigenLogueo>>','No se pudo importar la entidad <<lcEntidad>>: LETRA DE COMPROBANTE ' + cast( d.Letra as Varchar(1) ) + ', PTO. VENTA ' + cast( d.PtoVenta as Varchar(4) ) + ', NÚMERO ' + cast( d.Numero as Varchar(8) ) + '','La clave principal a importar ya existe'
					from ZooLogic.CANSENIA t inner join deleted d 
							 on t.Codigo = d.Codigo
						left join deleted h 
							on   t.Letra = h.Letra
							 and   t.PtoVenta = h.PtoVenta
							 and   t.Numero = h.Numero
							where   h.Letra is null 
							 and   h.PtoVenta is null 
							 and   h.Numero is null 
			End
		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_detcansenia( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_CANSENIA_detcansenia
ON ZooLogic.TablaTrabajo_CANSENIA_detcansenia
AFTER DELETE
As
Begin
Update t Set 
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.CODIGO = isnull( d.CODIGO, t.CODIGO ),
t.IDSENIA = isnull( d.IDSENIA, t.IDSENIA ),
t.CLIENTE = isnull( d.CLIENTE, t.CLIENTE ),
t.CLIEDESC = isnull( d.CLIEDESC, t.CLIEDESC ),
t.COMPROB = isnull( d.COMPROB, t.COMPROB ),
t.FECHAALTA = isnull( d.FECHAALTA, t.FECHAALTA ),
t.FECHAVTO = isnull( d.FECHAVTO, t.FECHAVTO ),
t.IMPORTE = isnull( d.IMPORTE, t.IMPORTE ),
t.SELECCION = isnull( d.SELECCION, t.SELECCION )
from ZooLogic.detcansenia t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.detcansenia
( 
"NROITEM",
"CODIGO",
"IDSENIA",
"CLIENTE",
"CLIEDESC",
"COMPROB",
"FECHAALTA",
"FECHAVTO",
"IMPORTE",
"SELECCION"
 )
Select 
d.NROITEM,
d.CODIGO,
d.IDSENIA,
d.CLIENTE,
d.CLIEDESC,
d.COMPROB,
d.FECHAALTA,
d.FECHAVTO,
d.IMPORTE,
d.SELECCION
From deleted d left join ZooLogic.detcansenia pk 
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_cansenia') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_cansenia
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_CANCELACIONDESENIAS' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_CANCELACIONDESENIAS.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_CANCELACIONDESENIAS.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_CANCELACIONDESENIAS.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_CANCELACIONDESENIAS.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Timestamp = nvl( c_CANCELACIONDESENIAS.Timestamp, 0 )
					.Tipocomprobante = nvl( c_CANCELACIONDESENIAS.Tipocomprobante, 0 )
					.Horamodificacionfw = nvl( c_CANCELACIONDESENIAS.Horamodificacionfw, [] )
					.Horaimpo = nvl( c_CANCELACIONDESENIAS.Horaimpo, [] )
					.Seriealtafw = nvl( c_CANCELACIONDESENIAS.Seriealtafw, [] )
					.Versionmodificacionfw = nvl( c_CANCELACIONDESENIAS.Versionmodificacionfw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Descripcionfw = nvl( c_CANCELACIONDESENIAS.Descripcionfw, [] )
					.Usuariomodificacionfw = nvl( c_CANCELACIONDESENIAS.Usuariomodificacionfw, [] )
					.Versionaltafw = nvl( c_CANCELACIONDESENIAS.Versionaltafw, [] )
					.Seriemodificacionfw = nvl( c_CANCELACIONDESENIAS.Seriemodificacionfw, [] )
					.Usuarioaltafw = nvl( c_CANCELACIONDESENIAS.Usuarioaltafw, [] )
					.Basededatosmodificacionfw = nvl( c_CANCELACIONDESENIAS.Basededatosmodificacionfw, [] )
					.Horaexpo = nvl( c_CANCELACIONDESENIAS.Horaexpo, [] )
					.Horaaltafw = nvl( c_CANCELACIONDESENIAS.Horaaltafw, [] )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_CANCELACIONDESENIAS.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Estadotransferencia = nvl( c_CANCELACIONDESENIAS.Estadotransferencia, [] )
					.Basededatosaltafw = nvl( c_CANCELACIONDESENIAS.Basededatosaltafw, [] )
					.Cliente_PK =  nvl( c_CANCELACIONDESENIAS.Cliente, [] )
					.Numero = nvl( c_CANCELACIONDESENIAS.Numero, 0 )
					.Clientedesde = nvl( c_CANCELACIONDESENIAS.Clientedesde, [] )
					.Fecha = GoLibrerias.ObtenerFechaFormateada( nvl( c_CANCELACIONDESENIAS.Fecha, ctod( '  /  /    ' ) ) )
					.Clientehasta = nvl( c_CANCELACIONDESENIAS.Clientehasta, [] )
					.Vigencia = nvl( c_CANCELACIONDESENIAS.Vigencia, 0 )
					.Codigo = nvl( c_CANCELACIONDESENIAS.Codigo, [] )
					.Letra = nvl( c_CANCELACIONDESENIAS.Letra, [] )
					.Puntodeventa = nvl( c_CANCELACIONDESENIAS.Puntodeventa, 0 )
					.Seniascancdetalle.Limpiar()
					.Seniascancdetalle.SetearEsNavegacion( .lProcesando )
					.Seniascancdetalle.Cargar()
					lcValor = This.ObtenerMemo( 'c_Observacion')
					.Observacion = lcValor 
					.Anulado = nvl( c_CANCELACIONDESENIAS.Anulado, .F. )
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
			lxRetorno = c_CANCELACIONDESENIAS.CODIGO
		endif
		return lxRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function ActualizarLosNROItemDeLosDetalles() as void
		local loDetalle as object, loItem as object, lnContadorNroItem as integer, lnIndex as integer
		
		loDetalle = this.oEntidad.SeniasCancDetalle
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
		return c_CANCELACIONDESENIAS.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.CANSENIA' )
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
								from ZooLogic.CANSENIA 
								Where   CANSENIA.CODIGO != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "CANSENIA", "", lcCursor, set("Datasession") )
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
			"Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Timestamp" as "Timestamp", "Facttipo" as "Tipocomprobante", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Descfw" as "Descripcionfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Faltafw" as "Fechaaltafw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Cliente" as "Cliente", "Numero" as "Numero", "Cliedesde" as "Clientedesde", "Ffch" as "Fecha", "Cliehasta" as "Clientehasta", "Vigencia" as "Vigencia", "Codigo" as "Codigo", "Letra" as "Letra", "Ptoventa" as "Puntodeventa", "Obs" as "Observacion", "Anulado" as "Anulado"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.CANSENIA 
								Where   CANSENIA.CODIGO != ''
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
	Tabla = 'CANSENIA'
	Filtro = " CANSENIA.CODIGO != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " CANSENIA.CODIGO != ''"
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
	<row entidad="CANCELACIONDESENIAS                     " atributo="FECHAIMPO                               " tabla="CANSENIA       " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANCELACIONDESENIAS                     " atributo="FECHATRANSFERENCIA                      " tabla="CANSENIA       " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha transferencia                                                                                                                                             " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANCELACIONDESENIAS                     " atributo="FECHAEXPO                               " tabla="CANSENIA       " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANCELACIONDESENIAS                     " atributo="FECHAMODIFICACIONFW                     " tabla="CANSENIA       " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANCELACIONDESENIAS                     " atributo="TIMESTAMP                               " tabla="CANSENIA       " campo="TIMESTAMP " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANCELACIONDESENIAS                     " atributo="TIPOCOMPROBANTE                         " tabla="CANSENIA       " campo="FACTTIPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="=45                                                                                                                                                                                                                                                           " obligatorio="false" admitebusqueda="0" etiqueta="Tipo de comprobante                                                                                                                                             " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANCELACIONDESENIAS                     " atributo="HORAMODIFICACIONFW                      " tabla="CANSENIA       " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANCELACIONDESENIAS                     " atributo="HORAIMPO                                " tabla="CANSENIA       " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANCELACIONDESENIAS                     " atributo="SERIEALTAFW                             " tabla="CANSENIA       " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANCELACIONDESENIAS                     " atributo="VERSIONMODIFICACIONFW                   " tabla="CANSENIA       " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANCELACIONDESENIAS                     " atributo="ZADSFW                                  " tabla="CANSENIA       " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANCELACIONDESENIAS                     " atributo="DESCRIPCIONFW                           " tabla="CANSENIA       " campo="DESCFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="200" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANCELACIONDESENIAS                     " atributo="USUARIOMODIFICACIONFW                   " tabla="CANSENIA       " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANCELACIONDESENIAS                     " atributo="VERSIONALTAFW                           " tabla="CANSENIA       " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANCELACIONDESENIAS                     " atributo="SERIEMODIFICACIONFW                     " tabla="CANSENIA       " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANCELACIONDESENIAS                     " atributo="USUARIOALTAFW                           " tabla="CANSENIA       " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANCELACIONDESENIAS                     " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="CANSENIA       " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANCELACIONDESENIAS                     " atributo="HORAEXPO                                " tabla="CANSENIA       " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANCELACIONDESENIAS                     " atributo="HORAALTAFW                              " tabla="CANSENIA       " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="=goservicios.librerias.obtenerHora()                                                                                                                                                                                                                          " obligatorio="false" admitebusqueda="0" etiqueta="Hora FW                                                                                                                                                         " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANCELACIONDESENIAS                     " atributo="FECHAALTAFW                             " tabla="CANSENIA       " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goservicios.librerias.obtenerFecha()                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="0" etiqueta="Fecha FW                                                                                                                                                        " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANCELACIONDESENIAS                     " atributo="ESTADOTRANSFERENCIA                     " tabla="CANSENIA       " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado transferencia                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANCELACIONDESENIAS                     " atributo="BASEDEDATOSALTAFW                       " tabla="CANSENIA       " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANCELACIONDESENIAS                     " atributo="CLIENTE                                 " tabla="CANSENIA       " campo="CLIENTE   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CLIENTE                                 " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="8" etiqueta="Cliente                                                                                                                                                         " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANCELACIONDESENIAS                     " atributo="NUMERO                                  " tabla="CANSENIA       " campo="NUMERO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="6" etiqueta="Número                                                                                                                                                          " dominio="NUMEROCOMPROBANTE             " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="3" mascara="X 9999-99999999          " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANCELACIONDESENIAS                     " atributo="CLIENTEDESDE                            " tabla="CANSENIA       " campo="CLIEDESDE " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="8" etiqueta="Cliente desde                                                                                                                                                   " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANCELACIONDESENIAS                     " atributo="FECHA                                   " tabla="CANSENIA       " campo="FFCH      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goServicios.librerias.ObtenerFecha()                                                                                                                                                                                                                         " obligatorio="true" admitebusqueda="10" etiqueta="Fecha                                                                                                                                                           " dominio="FECHACALENDARIO               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANCELACIONDESENIAS                     " atributo="CLIENTEHASTA                            " tabla="CANSENIA       " campo="CLIEHASTA " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="5" decimales="0" valorsugerido="ZZZZZZZZZZ                                                                                                                                                                                                                                                    " obligatorio="false" admitebusqueda="8" etiqueta="Cliente hasta                                                                                                                                                   " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANCELACIONDESENIAS                     " atributo="VIGENCIA                                " tabla="CANSENIA       " campo="VIGENCIA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="8" etiqueta="Vigencia                                                                                                                                                        " dominio="COMBOXML                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANCELACIONDESENIAS                     " atributo="CODIGO                                  " tabla="CANSENIA       " campo="CODIGO    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Código                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="10" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANCELACIONDESENIAS                     " atributo="LETRA                                   " tabla="CANSENIA       " campo="LETRA     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="1" decimales="0" valorsugerido="='X'                                                                                                                                                                                                                                                          " obligatorio="false" admitebusqueda="2" etiqueta="Letra de comprobante                                                                                                                                            " dominio="NUMEROCOMPROBANTE             " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="1" mascara="X 9999-99999999          " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="11" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANCELACIONDESENIAS                     " atributo="PUNTODEVENTA                            " tabla="CANSENIA       " campo="PTOVENTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="4" decimales="0" valorsugerido="=goServicios.Parametros.felino.Numeraciones.BocaDeExpendio                                                                                                                                                                                                    " obligatorio="false" admitebusqueda="4" etiqueta="Pto. venta                                                                                                                                                      " dominio="NUMEROCOMPROBANTE             " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="2" mascara="X 9999-99999999          " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="12" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANCELACIONDESENIAS                     " atributo="SENIASCANCDETALLE                       " tabla="DETCANSENIA    " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="Artículos señados                                                                                                                                               " dominio="DETALLEITEMCANCELACIONDESENIAS" detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="1" orden="20" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANCELACIONDESENIAS                     " atributo="OBSERVACION                             " tabla="CANSENIA       " campo="OBS       " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="402" etiqueta="Observación                                                                                                                                                     " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="4" orden="30" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANCELACIONDESENIAS                     " atributo="ANULADO                                 " tabla="CANSENIA       " campo="ANULADO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="14" etiqueta="Esta anulado                                                                                                                                                    " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="60" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="NOMBRE                                  " tabla="CLI            " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="9" etiqueta="Detalle Cli.                                                                                                                                                    " dominio="TEXTOBUSQUEDA                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CLI On CANSENIA.CLIENTE = CLI.CLCOD And  CLI.CLCOD != ''                                                                                                                                                                                           " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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