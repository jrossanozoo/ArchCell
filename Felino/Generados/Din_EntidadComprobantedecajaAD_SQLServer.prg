
define class Din_EntidadCOMPROBANTEDECAJAAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_COMPROBANTEDECAJA'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = []
	cExpresionCCPorCampos = []
	cTagClaveCandidata = ''
	cTagClavePk = '_038PK'
	cTablaPrincipal = 'COMPCAJA'
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
			local  lxCompcajaFaltafw, lxCompcajaFechaori, lxCompcajaFecexpo, lxCompcajaFecimpo, lxCompcajaFmodifw, lxCompcajaFectrans, lxCompcajaCotiz, lxCompcajaTimestamp, lxCompcajaCodigoori, lxCompcajaSignomov, lxCompcajaDescfw, lxCompcajaHmodifw, lxCompcajaSaltafw, lxCompcajaZadsfw, lxCompcajaValtafw, lxCompcajaUmodifw, lxCompcajaVmodifw, lxCompcajaUaltafw, lxCompcajaHoraimpo, lxCompcajaSmodifw, lxCompcajaEsttrans, lxCompcajaHoraexpo, lxCompcajaBdaltafw, lxCompcajaBdmodifw, lxCompcajaHaltafw, lxCompcajaMonsis, lxCompcajaMoneda, lxCompcajaCobs, lxCompcajaFecha, lxCompcajaOrigdest, lxCompcajaCodigo, lxCompcajaConcepto, lxCompcajaTipo, lxCompcajaNumero, lxCompcajaCajaorig, lxCompcajaCajadest, lxCompcajaVendedor
				lxCompcajaFaltafw =  .Fechaaltafw			lxCompcajaFechaori =  .Fechaoriginal			lxCompcajaFecexpo =  .Fechaexpo			lxCompcajaFecimpo =  .Fechaimpo			lxCompcajaFmodifw =  .Fechamodificacionfw			lxCompcajaFectrans =  .Fechatransferencia			lxCompcajaCotiz =  .Cotizacion			lxCompcajaTimestamp = goLibrerias.ObtenerTimestamp()			lxCompcajaCodigoori =  .Codigooriginal			lxCompcajaSignomov =  .Signodemovimiento			lxCompcajaDescfw =  .Descripcionfw			lxCompcajaHmodifw =  .Horamodificacionfw			lxCompcajaSaltafw =  .Seriealtafw			lxCompcajaZadsfw =  .Zadsfw			lxCompcajaValtafw =  .Versionaltafw			lxCompcajaUmodifw =  .Usuariomodificacionfw			lxCompcajaVmodifw =  .Versionmodificacionfw			lxCompcajaUaltafw =  .Usuarioaltafw			lxCompcajaHoraimpo =  .Horaimpo			lxCompcajaSmodifw =  .Seriemodificacionfw			lxCompcajaEsttrans =  .Estadotransferencia			lxCompcajaHoraexpo =  .Horaexpo			lxCompcajaBdaltafw =  .Basededatosaltafw			lxCompcajaBdmodifw =  .Basededatosmodificacionfw			lxCompcajaHaltafw =  .Horaaltafw			lxCompcajaMonsis =  upper( .MonedaSistema_PK ) 			lxCompcajaMoneda =  upper( .MonedaComprobante_PK ) 			lxCompcajaCobs =  .Observacion			lxCompcajaFecha =  .Fecha			lxCompcajaOrigdest =  upper( .OrigenDestino_PK ) 			lxCompcajaCodigo =  .Identificador			lxCompcajaConcepto =  upper( .Concepto_PK ) 			lxCompcajaTipo =  .Tipo			lxCompcajaNumero =  .Numero			lxCompcajaCajaorig =  .Cajaorigen_PK 			lxCompcajaCajadest =  .Cajadestino_PK 			lxCompcajaVendedor =  upper( .Vendedor_PK ) 
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxCompcajaCodigo = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.COMPCAJA ( "Faltafw","Fechaori","Fecexpo","Fecimpo","Fmodifw","Fectrans","Cotiz","Timestamp","Codigoori","Signomov","Descfw","Hmodifw","Saltafw","Zadsfw","Valtafw","Umodifw","Vmodifw","Ualtafw","Horaimpo","Smodifw","Esttrans","Horaexpo","Bdaltafw","Bdmodifw","Haltafw","Monsis","Moneda","Cobs","Fecha","Origdest","Codigo","Concepto","Tipo","Numero","Cajaorig","Cajadest","Vendedor" ) values ( <<"'" + this.ConvertirDateSql( lxCompcajaFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCompcajaFechaori ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCompcajaFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCompcajaFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCompcajaFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCompcajaFectrans ) + "'" >>, <<lxCompcajaCotiz >>, <<lxCompcajaTimestamp >>, <<"'" + this.FormatearTextoSql( lxCompcajaCodigoori ) + "'" >>, <<lxCompcajaSignomov >>, <<"'" + this.FormatearTextoSql( lxCompcajaDescfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompcajaHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompcajaSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompcajaZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompcajaValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompcajaUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompcajaVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompcajaUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompcajaHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompcajaSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompcajaEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompcajaHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompcajaBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompcajaBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompcajaHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompcajaMonsis ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompcajaMoneda ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompcajaCobs ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCompcajaFecha ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompcajaOrigdest ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompcajaCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompcajaConcepto ) + "'" >>, <<lxCompcajaTipo >>, <<lxCompcajaNumero >>, <<lxCompcajaCajaorig >>, <<lxCompcajaCajadest >>, <<"'" + this.FormatearTextoSql( lxCompcajaVendedor ) + "'" >> )
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
		this.ComprobarTransaccion()
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.IDENTIFICADOR
			lcValorClavePrimariaString = lxValorClavePrimaria

			.GenerarSentenciasComponentes()
			.EjecutarSentencias( This.ColSentencias )
		this.ComprobarTransaccion()

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.Valores
				if this.oEntidad.Valores.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxFechacomp = loItem.Fechacomp
					lxCaja_PK = loItem.Caja_PK
					lxCajavalor = loItem.Cajavalor
					lxNroitem = lnContadorNroItem
					lxTotal = loItem.Total
					lxTipo = loItem.Tipo
					lxChequeelectronico = loItem.Chequeelectronico
					lxNumerochequepropio_PK = loItem.Numerochequepropio_PK
					lxNumerocheque_PK = loItem.Numerocheque_PK
					lxValor_PK = loItem.Valor_PK
					lxValordetalle = loItem.Valordetalle
					lxFecha = loItem.Fecha
					lxNumerointerno = loItem.Numerointerno
					lxMonto = loItem.Monto
					lxCotiza = loItem.Cotiza
					lxMontoamonedasistema = loItem.Montoamonedasistema
					lxIditemcomponente = loItem.Iditemcomponente
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.CompCajaDet("JJfecha","IdCaja","CajaVal","NROITEM","cTotal","Tipo","CElectro","NroChProp","NroCheque","CodDetVal","CodVal","Descrip","Fecha","NroInterno","monto","Cotiza","Montosiste","guidComp" ) values ( <<"'" + this.ConvertirDateSql( lxFechacomp ) + "'">>, <<lxCaja_PK>>, <<lxCajavalor>>, <<lxNroitem>>, <<lxTotal>>, <<lxTipo>>, <<iif( lxChequeelectronico, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxNumerochequepropio_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerocheque_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxValor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValordetalle ) + "'">>, <<"'" + this.ConvertirDateSql( lxFecha ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerointerno ) + "'">>, <<lxMonto>>, <<lxCotiza>>, <<lxMontoamonedasistema>>, <<"'" + this.FormatearTextoSql( lxIditemcomponente ) + "'">> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.COMPAFEC
				if this.oEntidad.COMPAFEC.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxTipocomprobante = loItem.Tipocomprobante
					lxTipocompcaracter = loItem.Tipocompcaracter
					lxLetra = loItem.Letra
					lxPuntodeventa = loItem.Puntodeventa
					lxNumero = loItem.Numero
					lxFecha = loItem.Fecha
					lxTotal = loItem.Total
					lxVendedor = loItem.Vendedor
					lxTipo = loItem.Tipo
					lxAfecta = loItem.Afecta
					lxInterviniente = loItem.Interviniente
					lxNombreentidad = loItem.Nombreentidad
					lxCodigoentidad = loItem.Codigoentidad
					lxOrigen = loItem.Origen
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.CompAfe("NROITEM","Codigo","AfeTipoCom","AfeComprob","AfeLETRA","AfePTOVEN","AfeNUMCOM","afefecha","afetotal","afevend","afetipo","Afecta","DescInter","NomInter","CodInter","Origen" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<lxTipocomprobante>>, <<"'" + this.FormatearTextoSql( lxTipocompcaracter ) + "'">>, <<"'" + this.FormatearTextoSql( lxLetra ) + "'">>, <<lxPuntodeventa>>, <<lxNumero>>, <<"'" + this.ConvertirDateSql( lxFecha ) + "'">>, <<lxTotal>>, <<"'" + this.FormatearTextoSql( lxVendedor ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipo ) + "'">>, <<"'" + this.FormatearTextoSql( lxAfecta ) + "'">>, <<"'" + this.FormatearTextoSql( lxInterviniente ) + "'">>, <<"'" + this.FormatearTextoSql( lxNombreentidad ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigoentidad ) + "'">>, <<"'" + this.FormatearTextoSql( lxOrigen ) + "'">> ) 
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
		this.oEntidad.Timestamp = lxCompcajaTimestamp
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
			this.GenerarSentenciasComponentes()
			local  lxCompcajaFaltafw, lxCompcajaFechaori, lxCompcajaFecexpo, lxCompcajaFecimpo, lxCompcajaFmodifw, lxCompcajaFectrans, lxCompcajaCotiz, lxCompcajaTimestamp, lxCompcajaCodigoori, lxCompcajaSignomov, lxCompcajaDescfw, lxCompcajaHmodifw, lxCompcajaSaltafw, lxCompcajaZadsfw, lxCompcajaValtafw, lxCompcajaUmodifw, lxCompcajaVmodifw, lxCompcajaUaltafw, lxCompcajaHoraimpo, lxCompcajaSmodifw, lxCompcajaEsttrans, lxCompcajaHoraexpo, lxCompcajaBdaltafw, lxCompcajaBdmodifw, lxCompcajaHaltafw, lxCompcajaMonsis, lxCompcajaMoneda, lxCompcajaCobs, lxCompcajaFecha, lxCompcajaOrigdest, lxCompcajaCodigo, lxCompcajaConcepto, lxCompcajaTipo, lxCompcajaNumero, lxCompcajaCajaorig, lxCompcajaCajadest, lxCompcajaVendedor
				lxCompcajaFaltafw =  .Fechaaltafw			lxCompcajaFechaori =  .Fechaoriginal			lxCompcajaFecexpo =  .Fechaexpo			lxCompcajaFecimpo =  .Fechaimpo			lxCompcajaFmodifw =  .Fechamodificacionfw			lxCompcajaFectrans =  .Fechatransferencia			lxCompcajaCotiz =  .Cotizacion			lxCompcajaTimestamp = goLibrerias.ObtenerTimestamp()			lxCompcajaCodigoori =  .Codigooriginal			lxCompcajaSignomov =  .Signodemovimiento			lxCompcajaDescfw =  .Descripcionfw			lxCompcajaHmodifw =  .Horamodificacionfw			lxCompcajaSaltafw =  .Seriealtafw			lxCompcajaZadsfw =  .Zadsfw			lxCompcajaValtafw =  .Versionaltafw			lxCompcajaUmodifw =  .Usuariomodificacionfw			lxCompcajaVmodifw =  .Versionmodificacionfw			lxCompcajaUaltafw =  .Usuarioaltafw			lxCompcajaHoraimpo =  .Horaimpo			lxCompcajaSmodifw =  .Seriemodificacionfw			lxCompcajaEsttrans =  .Estadotransferencia			lxCompcajaHoraexpo =  .Horaexpo			lxCompcajaBdaltafw =  .Basededatosaltafw			lxCompcajaBdmodifw =  .Basededatosmodificacionfw			lxCompcajaHaltafw =  .Horaaltafw			lxCompcajaMonsis =  upper( .MonedaSistema_PK ) 			lxCompcajaMoneda =  upper( .MonedaComprobante_PK ) 			lxCompcajaCobs =  .Observacion			lxCompcajaFecha =  .Fecha			lxCompcajaOrigdest =  upper( .OrigenDestino_PK ) 			lxCompcajaCodigo =  .Identificador			lxCompcajaConcepto =  upper( .Concepto_PK ) 			lxCompcajaTipo =  .Tipo			lxCompcajaNumero =  .Numero			lxCompcajaCajaorig =  .Cajaorigen_PK 			lxCompcajaCajadest =  .Cajadestino_PK 			lxCompcajaVendedor =  upper( .Vendedor_PK ) 
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
				update ZooLogic.COMPCAJA set "Faltafw" = <<"'" + this.ConvertirDateSql( lxCompcajaFaltafw ) + "'">>,"Fechaori" = <<"'" + this.ConvertirDateSql( lxCompcajaFechaori ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxCompcajaFecexpo ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxCompcajaFecimpo ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxCompcajaFmodifw ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxCompcajaFectrans ) + "'">>,"Cotiz" = <<lxCompcajaCotiz>>,"Timestamp" = <<lxCompcajaTimestamp>>,"Codigoori" = <<"'" + this.FormatearTextoSql( lxCompcajaCodigoori ) + "'">>,"Signomov" = <<lxCompcajaSignomov>>,"Descfw" = <<"'" + this.FormatearTextoSql( lxCompcajaDescfw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxCompcajaHmodifw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxCompcajaSaltafw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxCompcajaZadsfw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxCompcajaValtafw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxCompcajaUmodifw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxCompcajaVmodifw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxCompcajaUaltafw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxCompcajaHoraimpo ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxCompcajaSmodifw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxCompcajaEsttrans ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxCompcajaHoraexpo ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxCompcajaBdaltafw ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxCompcajaBdmodifw ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxCompcajaHaltafw ) + "'">>,"Monsis" = <<"'" + this.FormatearTextoSql( lxCompcajaMonsis ) + "'">>,"Moneda" = <<"'" + this.FormatearTextoSql( lxCompcajaMoneda ) + "'">>,"Cobs" = <<"'" + this.FormatearTextoSql( lxCompcajaCobs ) + "'">>,"Fecha" = <<"'" + this.ConvertirDateSql( lxCompcajaFecha ) + "'">>,"Origdest" = <<"'" + this.FormatearTextoSql( lxCompcajaOrigdest ) + "'">>,"Codigo" = <<"'" + this.FormatearTextoSql( lxCompcajaCodigo ) + "'">>,"Concepto" = <<"'" + this.FormatearTextoSql( lxCompcajaConcepto ) + "'">>,"Tipo" = <<lxCompcajaTipo>>,"Numero" = <<lxCompcajaNumero>>,"Cajaorig" = <<lxCompcajaCajaorig>>,"Cajadest" = <<lxCompcajaCajadest>>,"Vendedor" = <<"'" + this.FormatearTextoSql( lxCompcajaVendedor ) + "'">> where "Codigo" = <<"'" + this.FormatearTextoSql( lxCompcajaCodigo ) + "'">> and  COMPCAJA.CODIGO != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			this.ComprobarResultadoDeEjecucionDelUpdate()
		this.ComprobarTransaccion()
			.EjecutarSentencias( This.ColSentencias )
		this.ComprobarTransaccion()
			this.oConexion.EjecutarSql( 'delete from ZooLogic.CompCajaDet where "CodDetVal" = ' + "'" + this.FormatearTextoSql( .oEntidad.IDENTIFICADOR ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.CompAfe where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.IDENTIFICADOR ) + "'" )

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.Valores
				if this.oEntidad.Valores.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxFechacomp = loItem.Fechacomp
					lxCaja_PK = loItem.Caja_PK
					lxCajavalor = loItem.Cajavalor
					lxNroitem = lnContadorNroItem
					lxTotal = loItem.Total
					lxTipo = loItem.Tipo
					lxChequeelectronico = loItem.Chequeelectronico
					lxNumerochequepropio_PK = loItem.Numerochequepropio_PK
					lxNumerocheque_PK = loItem.Numerocheque_PK
					lxValor_PK = loItem.Valor_PK
					lxValordetalle = loItem.Valordetalle
					lxFecha = loItem.Fecha
					lxNumerointerno = loItem.Numerointerno
					lxMonto = loItem.Monto
					lxCotiza = loItem.Cotiza
					lxMontoamonedasistema = loItem.Montoamonedasistema
					lxIditemcomponente = loItem.Iditemcomponente
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.CompCajaDet("JJfecha","IdCaja","CajaVal","NROITEM","cTotal","Tipo","CElectro","NroChProp","NroCheque","CodDetVal","CodVal","Descrip","Fecha","NroInterno","monto","Cotiza","Montosiste","guidComp" ) values ( <<"'" + this.ConvertirDateSql( lxFechacomp ) + "'">>, <<lxCaja_PK>>, <<lxCajavalor>>, <<lxNroitem>>, <<lxTotal>>, <<lxTipo>>, <<iif( lxChequeelectronico, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxNumerochequepropio_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerocheque_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxValor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValordetalle ) + "'">>, <<"'" + this.ConvertirDateSql( lxFecha ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerointerno ) + "'">>, <<lxMonto>>, <<lxCotiza>>, <<lxMontoamonedasistema>>, <<"'" + this.FormatearTextoSql( lxIditemcomponente ) + "'">> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.COMPAFEC
				if this.oEntidad.COMPAFEC.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxTipocomprobante = loItem.Tipocomprobante
					lxTipocompcaracter = loItem.Tipocompcaracter
					lxLetra = loItem.Letra
					lxPuntodeventa = loItem.Puntodeventa
					lxNumero = loItem.Numero
					lxFecha = loItem.Fecha
					lxTotal = loItem.Total
					lxVendedor = loItem.Vendedor
					lxTipo = loItem.Tipo
					lxAfecta = loItem.Afecta
					lxInterviniente = loItem.Interviniente
					lxNombreentidad = loItem.Nombreentidad
					lxCodigoentidad = loItem.Codigoentidad
					lxOrigen = loItem.Origen
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.CompAfe("NROITEM","Codigo","AfeTipoCom","AfeComprob","AfeLETRA","AfePTOVEN","AfeNUMCOM","afefecha","afetotal","afevend","afetipo","Afecta","DescInter","NomInter","CodInter","Origen" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<lxTipocomprobante>>, <<"'" + this.FormatearTextoSql( lxTipocompcaracter ) + "'">>, <<"'" + this.FormatearTextoSql( lxLetra ) + "'">>, <<lxPuntodeventa>>, <<lxNumero>>, <<"'" + this.ConvertirDateSql( lxFecha ) + "'">>, <<lxTotal>>, <<"'" + this.FormatearTextoSql( lxVendedor ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipo ) + "'">>, <<"'" + this.FormatearTextoSql( lxAfecta ) + "'">>, <<"'" + this.FormatearTextoSql( lxInterviniente ) + "'">>, <<"'" + this.FormatearTextoSql( lxNombreentidad ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigoentidad ) + "'">>, <<"'" + this.FormatearTextoSql( lxOrigen ) + "'">> ) 
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
		this.oEntidad.Timestamp = lxCompcajaTimestamp
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 Codigo from ZooLogic.COMPCAJA where " + this.ConvertirFuncionesSql( " COMPCAJA.CODIGO != ''" ) )
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
			Local lxCompcajaCodigo
			lxCompcajaCodigo = .Identificador

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Faltafw" as "Fechaaltafw", "Fechaori" as "Fechaoriginal", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Cotiz" as "Cotizacion", "Timestamp" as "Timestamp", "Codigoori" as "Codigooriginal", "Signomov" as "Signodemovimiento", "Descfw" as "Descripcionfw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Ualtafw" as "Usuarioaltafw", "Horaimpo" as "Horaimpo", "Smodifw" as "Seriemodificacionfw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Haltafw" as "Horaaltafw", "Monsis" as "Monedasistema", "Moneda" as "Monedacomprobante", "Cobs" as "Observacion", "Fecha" as "Fecha", "Origdest" as "Origendestino", "Codigo" as "Identificador", "Concepto" as "Concepto", "Tipo" as "Tipo", "Numero" as "Numero", "Cajaorig" as "Cajaorigen", "Cajadest" as "Cajadestino", "Vendedor" as "Vendedor" from ZooLogic.COMPCAJA where "Codigo" = <<"'" + this.FormatearTextoSql( lxCompcajaCodigo ) + "'">> and  COMPCAJA.CODIGO != ''
			endtext
			use in select('c_COMPROBANTEDECAJA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMPROBANTEDECAJA', set( 'Datasession' ) )

			if reccount( 'c_COMPROBANTEDECAJA' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Jjfecha" as "Fechacomp", "Idcaja" as "Caja", "Cajaval" as "Cajavalor", "Nroitem" as "Nroitem", "Ctotal" as "Total", "Tipo" as "Tipo", "Celectro" as "Chequeelectronico", "Nrochprop" as "Numerochequepropio", "Nrocheque" as "Numerocheque", "Coddetval" as "Numero", "Codval" as "Valor", "Descrip" as "Valordetalle", "Fecha" as "Fecha", "Nrointerno" as "Numerointerno", "Monto" as "Monto", "Cotiza" as "Cotiza", "Montosiste" as "Montoamonedasistema", "Guidcomp" as "Iditemcomponente" from ZooLogic.CompCajaDet where CodDetVal = <<"'" + this.FormatearTextoSql( c_COMPROBANTEDECAJA.IDENTIFICADOR ) + "'">> Order by NroItem
			endtext
			use in select('c_Valores')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Valores', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Valores
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afetipocom" as "Tipocomprobante", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen" from ZooLogic.CompAfe where Codigo = <<"'" + this.FormatearTextoSql( c_COMPROBANTEDECAJA.IDENTIFICADOR ) + "'">> Order by NroItem
			endtext
			use in select('c_COMPAFEC')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMPAFEC', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_COMPAFEC
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ConsultarPorClaveCandidata() as Boolean
		local llRetorno as Boolean
		llRetorno = .t.
		with this.oEntidad
			Local lxCompCajaNumero As Variant
			lxCompCajaNumero = .Numero
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Faltafw" as "Fechaaltafw", "Fechaori" as "Fechaoriginal", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Cotiz" as "Cotizacion", "Timestamp" as "Timestamp", "Codigoori" as "Codigooriginal", "Signomov" as "Signodemovimiento", "Descfw" as "Descripcionfw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Ualtafw" as "Usuarioaltafw", "Horaimpo" as "Horaimpo", "Smodifw" as "Seriemodificacionfw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Haltafw" as "Horaaltafw", "Monsis" as "Monedasistema", "Moneda" as "Monedacomprobante", "Cobs" as "Observacion", "Fecha" as "Fecha", "Origdest" as "Origendestino", "Codigo" as "Identificador", "Concepto" as "Concepto", "Tipo" as "Tipo", "Numero" as "Numero", "Cajaorig" as "Cajaorigen", "Cajadest" as "Cajadestino", "Vendedor" as "Vendedor" from ZooLogic.COMPCAJA where  COMPCAJA.CODIGO != '' And Numero = <<lxCompCajaNumero>>
			endtext
			use in select('c_COMPROBANTEDECAJA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMPROBANTEDECAJA', set( 'Datasession' ) )
			if reccount( 'c_COMPROBANTEDECAJA' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Jjfecha" as "Fechacomp", "Idcaja" as "Caja", "Cajaval" as "Cajavalor", "Nroitem" as "Nroitem", "Ctotal" as "Total", "Tipo" as "Tipo", "Celectro" as "Chequeelectronico", "Nrochprop" as "Numerochequepropio", "Nrocheque" as "Numerocheque", "Coddetval" as "Numero", "Codval" as "Valor", "Descrip" as "Valordetalle", "Fecha" as "Fecha", "Nrointerno" as "Numerointerno", "Monto" as "Monto", "Cotiza" as "Cotiza", "Montosiste" as "Montoamonedasistema", "Guidcomp" as "Iditemcomponente" from ZooLogic.CompCajaDet where CodDetVal = <<"'" + this.FormatearTextoSql( c_COMPROBANTEDECAJA.IDENTIFICADOR ) + "'">> Order by NroItem
			endtext
			use in select('c_Valores')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Valores', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Valores
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afetipocom" as "Tipocomprobante", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen" from ZooLogic.CompAfe where Codigo = <<"'" + this.FormatearTextoSql( c_COMPROBANTEDECAJA.IDENTIFICADOR ) + "'">> Order by NroItem
			endtext
			use in select('c_COMPAFEC')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMPAFEC', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_COMPAFEC
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxCompcajaCodigo as Variant
		llRetorno = .t.
		lxCompcajaCodigo = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.COMPCAJA where "Codigo" = <<"'" + this.FormatearTextoSql( lxCompcajaCodigo ) + "'">> and  COMPCAJA.CODIGO != ''
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
				select top 1 "Faltafw" as "Fechaaltafw", "Fechaori" as "Fechaoriginal", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Cotiz" as "Cotizacion", "Timestamp" as "Timestamp", "Codigoori" as "Codigooriginal", "Signomov" as "Signodemovimiento", "Descfw" as "Descripcionfw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Ualtafw" as "Usuarioaltafw", "Horaimpo" as "Horaimpo", "Smodifw" as "Seriemodificacionfw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Haltafw" as "Horaaltafw", "Monsis" as "Monedasistema", "Moneda" as "Monedacomprobante", "Cobs" as "Observacion", "Fecha" as "Fecha", "Origdest" as "Origendestino", "Codigo" as "Identificador", "Concepto" as "Concepto", "Tipo" as "Tipo", "Numero" as "Numero", "Cajaorig" as "Cajaorigen", "Cajadest" as "Cajadestino", "Vendedor" as "Vendedor" from ZooLogic.COMPCAJA where  COMPCAJA.CODIGO != '' order by Codigo
			endtext
			use in select('c_COMPROBANTEDECAJA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMPROBANTEDECAJA', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Jjfecha" as "Fechacomp", "Idcaja" as "Caja", "Cajaval" as "Cajavalor", "Nroitem" as "Nroitem", "Ctotal" as "Total", "Tipo" as "Tipo", "Celectro" as "Chequeelectronico", "Nrochprop" as "Numerochequepropio", "Nrocheque" as "Numerocheque", "Coddetval" as "Numero", "Codval" as "Valor", "Descrip" as "Valordetalle", "Fecha" as "Fecha", "Nrointerno" as "Numerointerno", "Monto" as "Monto", "Cotiza" as "Cotiza", "Montosiste" as "Montoamonedasistema", "Guidcomp" as "Iditemcomponente" from ZooLogic.CompCajaDet where CodDetVal = <<"'" + this.FormatearTextoSql( c_COMPROBANTEDECAJA.IDENTIFICADOR ) + "'">> Order by NroItem
			endtext
			use in select('c_Valores')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Valores', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Valores
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afetipocom" as "Tipocomprobante", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen" from ZooLogic.CompAfe where Codigo = <<"'" + this.FormatearTextoSql( c_COMPROBANTEDECAJA.IDENTIFICADOR ) + "'">> Order by NroItem
			endtext
			use in select('c_COMPAFEC')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMPAFEC', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_COMPAFEC
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
				select top 1 "Faltafw" as "Fechaaltafw", "Fechaori" as "Fechaoriginal", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Cotiz" as "Cotizacion", "Timestamp" as "Timestamp", "Codigoori" as "Codigooriginal", "Signomov" as "Signodemovimiento", "Descfw" as "Descripcionfw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Ualtafw" as "Usuarioaltafw", "Horaimpo" as "Horaimpo", "Smodifw" as "Seriemodificacionfw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Haltafw" as "Horaaltafw", "Monsis" as "Monedasistema", "Moneda" as "Monedacomprobante", "Cobs" as "Observacion", "Fecha" as "Fecha", "Origdest" as "Origendestino", "Codigo" as "Identificador", "Concepto" as "Concepto", "Tipo" as "Tipo", "Numero" as "Numero", "Cajaorig" as "Cajaorigen", "Cajadest" as "Cajadestino", "Vendedor" as "Vendedor" from ZooLogic.COMPCAJA where  funciones.padr( Codigo, 20, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  COMPCAJA.CODIGO != '' order by Codigo
			endtext
			use in select('c_COMPROBANTEDECAJA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMPROBANTEDECAJA', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Jjfecha" as "Fechacomp", "Idcaja" as "Caja", "Cajaval" as "Cajavalor", "Nroitem" as "Nroitem", "Ctotal" as "Total", "Tipo" as "Tipo", "Celectro" as "Chequeelectronico", "Nrochprop" as "Numerochequepropio", "Nrocheque" as "Numerocheque", "Coddetval" as "Numero", "Codval" as "Valor", "Descrip" as "Valordetalle", "Fecha" as "Fecha", "Nrointerno" as "Numerointerno", "Monto" as "Monto", "Cotiza" as "Cotiza", "Montosiste" as "Montoamonedasistema", "Guidcomp" as "Iditemcomponente" from ZooLogic.CompCajaDet where CodDetVal = <<"'" + this.FormatearTextoSql( c_COMPROBANTEDECAJA.IDENTIFICADOR ) + "'">> Order by NroItem
			endtext
			use in select('c_Valores')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Valores', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Valores
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afetipocom" as "Tipocomprobante", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen" from ZooLogic.CompAfe where Codigo = <<"'" + this.FormatearTextoSql( c_COMPROBANTEDECAJA.IDENTIFICADOR ) + "'">> Order by NroItem
			endtext
			use in select('c_COMPAFEC')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMPAFEC', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_COMPAFEC
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
				select top 1 "Faltafw" as "Fechaaltafw", "Fechaori" as "Fechaoriginal", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Cotiz" as "Cotizacion", "Timestamp" as "Timestamp", "Codigoori" as "Codigooriginal", "Signomov" as "Signodemovimiento", "Descfw" as "Descripcionfw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Ualtafw" as "Usuarioaltafw", "Horaimpo" as "Horaimpo", "Smodifw" as "Seriemodificacionfw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Haltafw" as "Horaaltafw", "Monsis" as "Monedasistema", "Moneda" as "Monedacomprobante", "Cobs" as "Observacion", "Fecha" as "Fecha", "Origdest" as "Origendestino", "Codigo" as "Identificador", "Concepto" as "Concepto", "Tipo" as "Tipo", "Numero" as "Numero", "Cajaorig" as "Cajaorigen", "Cajadest" as "Cajadestino", "Vendedor" as "Vendedor" from ZooLogic.COMPCAJA where  funciones.padr( Codigo, 20, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  COMPCAJA.CODIGO != '' order by Codigo desc
			endtext
			use in select('c_COMPROBANTEDECAJA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMPROBANTEDECAJA', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Jjfecha" as "Fechacomp", "Idcaja" as "Caja", "Cajaval" as "Cajavalor", "Nroitem" as "Nroitem", "Ctotal" as "Total", "Tipo" as "Tipo", "Celectro" as "Chequeelectronico", "Nrochprop" as "Numerochequepropio", "Nrocheque" as "Numerocheque", "Coddetval" as "Numero", "Codval" as "Valor", "Descrip" as "Valordetalle", "Fecha" as "Fecha", "Nrointerno" as "Numerointerno", "Monto" as "Monto", "Cotiza" as "Cotiza", "Montosiste" as "Montoamonedasistema", "Guidcomp" as "Iditemcomponente" from ZooLogic.CompCajaDet where CodDetVal = <<"'" + this.FormatearTextoSql( c_COMPROBANTEDECAJA.IDENTIFICADOR ) + "'">> Order by NroItem
			endtext
			use in select('c_Valores')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Valores', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Valores
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afetipocom" as "Tipocomprobante", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen" from ZooLogic.CompAfe where Codigo = <<"'" + this.FormatearTextoSql( c_COMPROBANTEDECAJA.IDENTIFICADOR ) + "'">> Order by NroItem
			endtext
			use in select('c_COMPAFEC')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMPAFEC', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_COMPAFEC
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
				select top 1 "Faltafw" as "Fechaaltafw", "Fechaori" as "Fechaoriginal", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Cotiz" as "Cotizacion", "Timestamp" as "Timestamp", "Codigoori" as "Codigooriginal", "Signomov" as "Signodemovimiento", "Descfw" as "Descripcionfw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Ualtafw" as "Usuarioaltafw", "Horaimpo" as "Horaimpo", "Smodifw" as "Seriemodificacionfw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Haltafw" as "Horaaltafw", "Monsis" as "Monedasistema", "Moneda" as "Monedacomprobante", "Cobs" as "Observacion", "Fecha" as "Fecha", "Origdest" as "Origendestino", "Codigo" as "Identificador", "Concepto" as "Concepto", "Tipo" as "Tipo", "Numero" as "Numero", "Cajaorig" as "Cajaorigen", "Cajadest" as "Cajadestino", "Vendedor" as "Vendedor" from ZooLogic.COMPCAJA where  COMPCAJA.CODIGO != '' order by Codigo desc
			endtext
			use in select('c_COMPROBANTEDECAJA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMPROBANTEDECAJA', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Jjfecha" as "Fechacomp", "Idcaja" as "Caja", "Cajaval" as "Cajavalor", "Nroitem" as "Nroitem", "Ctotal" as "Total", "Tipo" as "Tipo", "Celectro" as "Chequeelectronico", "Nrochprop" as "Numerochequepropio", "Nrocheque" as "Numerocheque", "Coddetval" as "Numero", "Codval" as "Valor", "Descrip" as "Valordetalle", "Fecha" as "Fecha", "Nrointerno" as "Numerointerno", "Monto" as "Monto", "Cotiza" as "Cotiza", "Montosiste" as "Montoamonedasistema", "Guidcomp" as "Iditemcomponente" from ZooLogic.CompCajaDet where CodDetVal = <<"'" + this.FormatearTextoSql( c_COMPROBANTEDECAJA.IDENTIFICADOR ) + "'">> Order by NroItem
			endtext
			use in select('c_Valores')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Valores', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Valores
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afetipocom" as "Tipocomprobante", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen" from ZooLogic.CompAfe where Codigo = <<"'" + this.FormatearTextoSql( c_COMPROBANTEDECAJA.IDENTIFICADOR ) + "'">> Order by NroItem
			endtext
			use in select('c_COMPAFEC')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMPAFEC', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_COMPAFEC
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
			lcXml = this.oConexion.EjecutarSql( "select Faltafw,Fechaori,Fecexpo,Fecimpo,Fmodifw,Fectrans,Cotiz,Timestamp,Codigoori,Signomov,Descfw," + ;
"Hmodifw,Saltafw,Zadsfw,Valtafw,Umodifw,Vmodifw,Ualtafw,Horaimpo,Smodifw,Esttrans,Horaexpo,Bdaltafw,B" + ;
"dmodifw,Haltafw,Monsis,Moneda,Cobs,Fecha,Origdest,Codigo,Concepto,Tipo,Numero,Cajaorig,Cajadest,Vend" + ;
"edor" + ;
" from ZooLogic.COMPCAJA where  COMPCAJA.CODIGO != '' and " + lcFiltro )
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
			local  lxCompcajaFaltafw, lxCompcajaFechaori, lxCompcajaFecexpo, lxCompcajaFecimpo, lxCompcajaFmodifw, lxCompcajaFectrans, lxCompcajaCotiz, lxCompcajaTimestamp, lxCompcajaCodigoori, lxCompcajaSignomov, lxCompcajaDescfw, lxCompcajaHmodifw, lxCompcajaSaltafw, lxCompcajaZadsfw, lxCompcajaValtafw, lxCompcajaUmodifw, lxCompcajaVmodifw, lxCompcajaUaltafw, lxCompcajaHoraimpo, lxCompcajaSmodifw, lxCompcajaEsttrans, lxCompcajaHoraexpo, lxCompcajaBdaltafw, lxCompcajaBdmodifw, lxCompcajaHaltafw, lxCompcajaMonsis, lxCompcajaMoneda, lxCompcajaCobs, lxCompcajaFecha, lxCompcajaOrigdest, lxCompcajaCodigo, lxCompcajaConcepto, lxCompcajaTipo, lxCompcajaNumero, lxCompcajaCajaorig, lxCompcajaCajadest, lxCompcajaVendedor
				lxCompcajaFaltafw = ctod( '  /  /    ' )			lxCompcajaFechaori = ctod( '  /  /    ' )			lxCompcajaFecexpo = ctod( '  /  /    ' )			lxCompcajaFecimpo = ctod( '  /  /    ' )			lxCompcajaFmodifw = ctod( '  /  /    ' )			lxCompcajaFectrans = ctod( '  /  /    ' )			lxCompcajaCotiz = 0			lxCompcajaTimestamp = goLibrerias.ObtenerTimestamp()			lxCompcajaCodigoori = []			lxCompcajaSignomov = 0			lxCompcajaDescfw = []			lxCompcajaHmodifw = []			lxCompcajaSaltafw = []			lxCompcajaZadsfw = []			lxCompcajaValtafw = []			lxCompcajaUmodifw = []			lxCompcajaVmodifw = []			lxCompcajaUaltafw = []			lxCompcajaHoraimpo = []			lxCompcajaSmodifw = []			lxCompcajaEsttrans = []			lxCompcajaHoraexpo = []			lxCompcajaBdaltafw = []			lxCompcajaBdmodifw = []			lxCompcajaHaltafw = []			lxCompcajaMonsis = []			lxCompcajaMoneda = []			lxCompcajaCobs = []			lxCompcajaFecha = ctod( '  /  /    ' )			lxCompcajaOrigdest = []			lxCompcajaCodigo = []			lxCompcajaConcepto = []			lxCompcajaTipo = 0			lxCompcajaNumero = 0			lxCompcajaCajaorig = 0			lxCompcajaCajadest = 0			lxCompcajaVendedor = []
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.CompCajaDet where "CodDetVal" = ' + "'" + this.FormatearTextoSql( .oEntidad.IDENTIFICADOR ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.CompAfe where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.IDENTIFICADOR ) + "'" )
			this.oConexion.EjecutarSql( [delete from ZooLogic.COMPCAJA where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.IDENTIFICADOR ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'COMPCAJA' + '_' + tcCampo
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
		lcWhere = " Where  COMPCAJA.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Faltafw" as "Fechaaltafw", "Fechaori" as "Fechaoriginal", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Cotiz" as "Cotizacion", "Timestamp" as "Timestamp", "Codigoori" as "Codigooriginal", "Signomov" as "Signodemovimiento", "Descfw" as "Descripcionfw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Ualtafw" as "Usuarioaltafw", "Horaimpo" as "Horaimpo", "Smodifw" as "Seriemodificacionfw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Haltafw" as "Horaaltafw", "Monsis" as "Monedasistema", "Moneda" as "Monedacomprobante", "Cobs" as "Observacion", "Fecha" as "Fecha", "Origdest" as "Origendestino", "Codigo" as "Identificador", "Concepto" as "Concepto", "Tipo" as "Tipo", "Numero" as "Numero", "Cajaorig" as "Cajaorigen", "Cajadest" as "Cajadestino", "Vendedor" as "Vendedor"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'COMPCAJA', '', tnTope )
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
	Function ObtenerDatosDetalleValores( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  COMPCAJADET.CODDETVAL != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Jjfecha" as "Fechacomp", "Idcaja" as "Caja", "Cajaval" as "Cajavalor", "Nroitem" as "Nroitem", "Ctotal" as "Total", "Tipo" as "Tipo", "Celectro" as "Chequeelectronico", "Nrochprop" as "Numerochequepropio", "Nrocheque" as "Numerocheque", "Coddetval" as "Numero", "Codval" as "Valor", "Descrip" as "Valordetalle", "Fecha" as "Fecha", "Nrointerno" as "Numerointerno", "Monto" as "Monto", "Cotiza" as "Cotiza", "Montosiste" as "Montoamonedasistema", "Guidcomp" as "Iditemcomponente"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleValores( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'CompCajaDet', 'Valores', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleValores( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleValores( lcAtributo )
		endfor
		lcSelect = substr( lcSelect, 2 )
		return lcSelect
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosDetalleCOMPAFEC( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  COMPAFE.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afetipocom" as "Tipocomprobante", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleCOMPAFEC( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'CompAfe', 'COMPAFEC', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleCOMPAFEC( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleCOMPAFEC( lcAtributo )
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
				Case lcAtributo == 'FECHAORIGINAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHAORI AS FECHAORIGINAL'
				Case lcAtributo == 'FECHAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECEXPO AS FECHAEXPO'
				Case lcAtributo == 'FECHAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECIMPO AS FECHAIMPO'
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'FECHATRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRANS AS FECHATRANSFERENCIA'
				Case lcAtributo == 'COTIZACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COTIZ AS COTIZACION'
				Case lcAtributo == 'TIMESTAMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIMESTAMP AS TIMESTAMP'
				Case lcAtributo == 'CODIGOORIGINAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGOORI AS CODIGOORIGINAL'
				Case lcAtributo == 'SIGNODEMOVIMIENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SIGNOMOV AS SIGNODEMOVIMIENTO'
				Case lcAtributo == 'DESCRIPCIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCFW AS DESCRIPCIONFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'MONEDASISTEMA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONSIS AS MONEDASISTEMA'
				Case lcAtributo == 'MONEDACOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONEDA AS MONEDACOMPROBANTE'
				Case lcAtributo == 'OBSERVACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COBS AS OBSERVACION'
				Case lcAtributo == 'FECHA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHA AS FECHA'
				Case lcAtributo == 'ORIGENDESTINO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ORIGDEST AS ORIGENDESTINO'
				Case lcAtributo == 'IDENTIFICADOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS IDENTIFICADOR'
				Case lcAtributo == 'CONCEPTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CONCEPTO AS CONCEPTO'
				Case lcAtributo == 'TIPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPO AS TIPO'
				Case lcAtributo == 'NUMERO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NUMERO AS NUMERO'
				Case lcAtributo == 'CAJAORIGEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CAJAORIG AS CAJAORIGEN'
				Case lcAtributo == 'CAJADESTINO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CAJADEST AS CAJADESTINO'
				Case lcAtributo == 'VENDEDOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VENDEDOR AS VENDEDOR'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleValores( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'FECHACOMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'JJFECHA AS FECHACOMP'
				Case lcAtributo == 'CAJA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDCAJA AS CAJA'
				Case lcAtributo == 'CAJAVALOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CAJAVAL AS CAJAVALOR'
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'TOTAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CTOTAL AS TOTAL'
				Case lcAtributo == 'TIPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPO AS TIPO'
				Case lcAtributo == 'CHEQUEELECTRONICO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CELECTRO AS CHEQUEELECTRONICO'
				Case lcAtributo == 'NUMEROCHEQUEPROPIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROCHPROP AS NUMEROCHEQUEPROPIO'
				Case lcAtributo == 'NUMEROCHEQUE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROCHEQUE AS NUMEROCHEQUE'
				Case lcAtributo == 'NUMERO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODDETVAL AS NUMERO'
				Case lcAtributo == 'VALOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODVAL AS VALOR'
				Case lcAtributo == 'VALORDETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCRIP AS VALORDETALLE'
				Case lcAtributo == 'FECHA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHA AS FECHA'
				Case lcAtributo == 'NUMEROINTERNO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROINTERNO AS NUMEROINTERNO'
				Case lcAtributo == 'MONTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONTO AS MONTO'
				Case lcAtributo == 'COTIZA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COTIZA AS COTIZA'
				Case lcAtributo == 'MONTOAMONEDASISTEMA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONTOSISTE AS MONTOAMONEDASISTEMA'
				Case lcAtributo == 'IDITEMCOMPONENTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'GUIDCOMP AS IDITEMCOMPONENTE'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleCOMPAFEC( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'TIPOCOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFETIPOCOM AS TIPOCOMPROBANTE'
				Case lcAtributo == 'TIPOCOMPCARACTER'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFECOMPROB AS TIPOCOMPCARACTER'
				Case lcAtributo == 'LETRA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFELETRA AS LETRA'
				Case lcAtributo == 'PUNTODEVENTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFEPTOVEN AS PUNTODEVENTA'
				Case lcAtributo == 'NUMERO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFENUMCOM AS NUMERO'
				Case lcAtributo == 'FECHA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFEFECHA AS FECHA'
				Case lcAtributo == 'TOTAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFETOTAL AS TOTAL'
				Case lcAtributo == 'VENDEDOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFEVEND AS VENDEDOR'
				Case lcAtributo == 'TIPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFETIPO AS TIPO'
				Case lcAtributo == 'AFECTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFECTA AS AFECTA'
				Case lcAtributo == 'INTERVINIENTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCINTER AS INTERVINIENTE'
				Case lcAtributo == 'NOMBREENTIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NOMINTER AS NOMBREENTIDAD'
				Case lcAtributo == 'CODIGOENTIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODINTER AS CODIGOENTIDAD'
				Case lcAtributo == 'ORIGEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ORIGEN AS ORIGEN'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHAORIGINAL'
				lcCampo = 'FECHAORI'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEXPO'
				lcCampo = 'FECEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAIMPO'
				lcCampo = 'FECIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'COTIZACION'
				lcCampo = 'COTIZ'
			Case upper( alltrim( tcAtributo ) ) == 'TIMESTAMP'
				lcCampo = 'TIMESTAMP'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGOORIGINAL'
				lcCampo = 'CODIGOORI'
			Case upper( alltrim( tcAtributo ) ) == 'SIGNODEMOVIMIENTO'
				lcCampo = 'SIGNOMOV'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCIONFW'
				lcCampo = 'DESCFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'MONEDASISTEMA'
				lcCampo = 'MONSIS'
			Case upper( alltrim( tcAtributo ) ) == 'MONEDACOMPROBANTE'
				lcCampo = 'MONEDA'
			Case upper( alltrim( tcAtributo ) ) == 'OBSERVACION'
				lcCampo = 'COBS'
			Case upper( alltrim( tcAtributo ) ) == 'FECHA'
				lcCampo = 'FECHA'
			Case upper( alltrim( tcAtributo ) ) == 'ORIGENDESTINO'
				lcCampo = 'ORIGDEST'
			Case upper( alltrim( tcAtributo ) ) == 'IDENTIFICADOR'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'CONCEPTO'
				lcCampo = 'CONCEPTO'
			Case upper( alltrim( tcAtributo ) ) == 'TIPO'
				lcCampo = 'TIPO'
			Case upper( alltrim( tcAtributo ) ) == 'NUMERO'
				lcCampo = 'NUMERO'
			Case upper( alltrim( tcAtributo ) ) == 'CAJAORIGEN'
				lcCampo = 'CAJAORIG'
			Case upper( alltrim( tcAtributo ) ) == 'CAJADESTINO'
				lcCampo = 'CAJADEST'
			Case upper( alltrim( tcAtributo ) ) == 'VENDEDOR'
				lcCampo = 'VENDEDOR'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleValores( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'FECHACOMP'
				lcCampo = 'JJFECHA'
			Case upper( alltrim( tcAtributo ) ) == 'CAJA'
				lcCampo = 'IDCAJA'
			Case upper( alltrim( tcAtributo ) ) == 'CAJAVALOR'
				lcCampo = 'CAJAVAL'
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'TOTAL'
				lcCampo = 'CTOTAL'
			Case upper( alltrim( tcAtributo ) ) == 'TIPO'
				lcCampo = 'TIPO'
			Case upper( alltrim( tcAtributo ) ) == 'CHEQUEELECTRONICO'
				lcCampo = 'CELECTRO'
			Case upper( alltrim( tcAtributo ) ) == 'NUMEROCHEQUEPROPIO'
				lcCampo = 'NROCHPROP'
			Case upper( alltrim( tcAtributo ) ) == 'NUMEROCHEQUE'
				lcCampo = 'NROCHEQUE'
			Case upper( alltrim( tcAtributo ) ) == 'NUMERO'
				lcCampo = 'CODDETVAL'
			Case upper( alltrim( tcAtributo ) ) == 'VALOR'
				lcCampo = 'CODVAL'
			Case upper( alltrim( tcAtributo ) ) == 'VALORDETALLE'
				lcCampo = 'DESCRIP'
			Case upper( alltrim( tcAtributo ) ) == 'FECHA'
				lcCampo = 'FECHA'
			Case upper( alltrim( tcAtributo ) ) == 'NUMEROINTERNO'
				lcCampo = 'NROINTERNO'
			Case upper( alltrim( tcAtributo ) ) == 'MONTO'
				lcCampo = 'MONTO'
			Case upper( alltrim( tcAtributo ) ) == 'COTIZA'
				lcCampo = 'COTIZA'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOAMONEDASISTEMA'
				lcCampo = 'MONTOSISTE'
			Case upper( alltrim( tcAtributo ) ) == 'IDITEMCOMPONENTE'
				lcCampo = 'GUIDCOMP'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleCOMPAFEC( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOCOMPROBANTE'
				lcCampo = 'AFETIPOCOM'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOCOMPCARACTER'
				lcCampo = 'AFECOMPROB'
			Case upper( alltrim( tcAtributo ) ) == 'LETRA'
				lcCampo = 'AFELETRA'
			Case upper( alltrim( tcAtributo ) ) == 'PUNTODEVENTA'
				lcCampo = 'AFEPTOVEN'
			Case upper( alltrim( tcAtributo ) ) == 'NUMERO'
				lcCampo = 'AFENUMCOM'
			Case upper( alltrim( tcAtributo ) ) == 'FECHA'
				lcCampo = 'AFEFECHA'
			Case upper( alltrim( tcAtributo ) ) == 'TOTAL'
				lcCampo = 'AFETOTAL'
			Case upper( alltrim( tcAtributo ) ) == 'VENDEDOR'
				lcCampo = 'AFEVEND'
			Case upper( alltrim( tcAtributo ) ) == 'TIPO'
				lcCampo = 'AFETIPO'
			Case upper( alltrim( tcAtributo ) ) == 'AFECTA'
				lcCampo = 'AFECTA'
			Case upper( alltrim( tcAtributo ) ) == 'INTERVINIENTE'
				lcCampo = 'DESCINTER'
			Case upper( alltrim( tcAtributo ) ) == 'NOMBREENTIDAD'
				lcCampo = 'NOMINTER'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGOENTIDAD'
				lcCampo = 'CODINTER'
			Case upper( alltrim( tcAtributo ) ) == 'ORIGEN'
				lcCampo = 'ORIGEN'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerTablaDetalle( tcDetalle as string ) as String
		local lcRetorno as string
		lcRetorno = ''
		if upper( alltrim( tcDetalle ) ) == 'VALORES'
			lcRetorno = 'COMPCAJADET'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'COMPAFEC'
			lcRetorno = 'COMPAFE'
		EndIf
		return lcRetorno
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasInsert() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcSentencia as string, loItem as object
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxCompcajaFaltafw, lxCompcajaFechaori, lxCompcajaFecexpo, lxCompcajaFecimpo, lxCompcajaFmodifw, lxCompcajaFectrans, lxCompcajaCotiz, lxCompcajaTimestamp, lxCompcajaCodigoori, lxCompcajaSignomov, lxCompcajaDescfw, lxCompcajaHmodifw, lxCompcajaSaltafw, lxCompcajaZadsfw, lxCompcajaValtafw, lxCompcajaUmodifw, lxCompcajaVmodifw, lxCompcajaUaltafw, lxCompcajaHoraimpo, lxCompcajaSmodifw, lxCompcajaEsttrans, lxCompcajaHoraexpo, lxCompcajaBdaltafw, lxCompcajaBdmodifw, lxCompcajaHaltafw, lxCompcajaMonsis, lxCompcajaMoneda, lxCompcajaCobs, lxCompcajaFecha, lxCompcajaOrigdest, lxCompcajaCodigo, lxCompcajaConcepto, lxCompcajaTipo, lxCompcajaNumero, lxCompcajaCajaorig, lxCompcajaCajadest, lxCompcajaVendedor
				lxCompcajaFaltafw =  .Fechaaltafw			lxCompcajaFechaori =  .Fechaoriginal			lxCompcajaFecexpo =  .Fechaexpo			lxCompcajaFecimpo =  .Fechaimpo			lxCompcajaFmodifw =  .Fechamodificacionfw			lxCompcajaFectrans =  .Fechatransferencia			lxCompcajaCotiz =  .Cotizacion			lxCompcajaTimestamp = goLibrerias.ObtenerTimestamp()			lxCompcajaCodigoori =  .Codigooriginal			lxCompcajaSignomov =  .Signodemovimiento			lxCompcajaDescfw =  .Descripcionfw			lxCompcajaHmodifw =  .Horamodificacionfw			lxCompcajaSaltafw =  .Seriealtafw			lxCompcajaZadsfw =  .Zadsfw			lxCompcajaValtafw =  .Versionaltafw			lxCompcajaUmodifw =  .Usuariomodificacionfw			lxCompcajaVmodifw =  .Versionmodificacionfw			lxCompcajaUaltafw =  .Usuarioaltafw			lxCompcajaHoraimpo =  .Horaimpo			lxCompcajaSmodifw =  .Seriemodificacionfw			lxCompcajaEsttrans =  .Estadotransferencia			lxCompcajaHoraexpo =  .Horaexpo			lxCompcajaBdaltafw =  .Basededatosaltafw			lxCompcajaBdmodifw =  .Basededatosmodificacionfw			lxCompcajaHaltafw =  .Horaaltafw			lxCompcajaMonsis =  upper( .MonedaSistema_PK ) 			lxCompcajaMoneda =  upper( .MonedaComprobante_PK ) 			lxCompcajaCobs =  .Observacion			lxCompcajaFecha =  .Fecha			lxCompcajaOrigdest =  upper( .OrigenDestino_PK ) 			lxCompcajaCodigo =  .Identificador			lxCompcajaConcepto =  upper( .Concepto_PK ) 			lxCompcajaTipo =  .Tipo			lxCompcajaNumero =  .Numero			lxCompcajaCajaorig =  .Cajaorigen_PK 			lxCompcajaCajadest =  .Cajadestino_PK 			lxCompcajaVendedor =  upper( .Vendedor_PK ) 
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.COMPCAJA ( "Faltafw","Fechaori","Fecexpo","Fecimpo","Fmodifw","Fectrans","Cotiz","Timestamp","Codigoori","Signomov","Descfw","Hmodifw","Saltafw","Zadsfw","Valtafw","Umodifw","Vmodifw","Ualtafw","Horaimpo","Smodifw","Esttrans","Horaexpo","Bdaltafw","Bdmodifw","Haltafw","Monsis","Moneda","Cobs","Fecha","Origdest","Codigo","Concepto","Tipo","Numero","Cajaorig","Cajadest","Vendedor" ) values ( <<"'" + this.ConvertirDateSql( lxCompcajaFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCompcajaFechaori ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCompcajaFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCompcajaFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCompcajaFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCompcajaFectrans ) + "'" >>, <<lxCompcajaCotiz >>, <<lxCompcajaTimestamp >>, <<"'" + this.FormatearTextoSql( lxCompcajaCodigoori ) + "'" >>, <<lxCompcajaSignomov >>, <<"'" + this.FormatearTextoSql( lxCompcajaDescfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompcajaHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompcajaSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompcajaZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompcajaValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompcajaUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompcajaVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompcajaUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompcajaHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompcajaSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompcajaEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompcajaHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompcajaBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompcajaBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompcajaHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompcajaMonsis ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompcajaMoneda ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompcajaCobs ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCompcajaFecha ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompcajaOrigdest ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompcajaCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompcajaConcepto ) + "'" >>, <<lxCompcajaTipo >>, <<lxCompcajaNumero >>, <<lxCompcajaCajaorig >>, <<lxCompcajaCajadest >>, <<"'" + this.FormatearTextoSql( lxCompcajaVendedor ) + "'" >> )
		endtext
		loColeccion.cTabla = 'COMPCAJA' 
		loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		With this
			local lcValorClavePrimariaString as String
			lcValorClavePrimariaString = "'" + this.oEntidad.IDENTIFICADOR + "'"

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.Valores
				if this.oEntidad.Valores.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxFechacomp = loItem.Fechacomp
					lxCaja_PK = loItem.Caja_PK
					lxCajavalor = loItem.Cajavalor
					lxNroitem = lnContadorNroItem
					lxTotal = loItem.Total
					lxTipo = loItem.Tipo
					lxChequeelectronico = loItem.Chequeelectronico
					lxNumerochequepropio_PK = loItem.Numerochequepropio_PK
					lxNumerocheque_PK = loItem.Numerocheque_PK
					lxValor_PK = loItem.Valor_PK
					lxValordetalle = loItem.Valordetalle
					lxFecha = loItem.Fecha
					lxNumerointerno = loItem.Numerointerno
					lxMonto = loItem.Monto
					lxCotiza = loItem.Cotiza
					lxMontoamonedasistema = loItem.Montoamonedasistema
					lxIditemcomponente = loItem.Iditemcomponente
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.CompCajaDet("JJfecha","IdCaja","CajaVal","NROITEM","cTotal","Tipo","CElectro","NroChProp","NroCheque","CodDetVal","CodVal","Descrip","Fecha","NroInterno","monto","Cotiza","Montosiste","guidComp" ) values ( <<"'" + this.ConvertirDateSql( lxFechacomp ) + "'">>, <<lxCaja_PK>>, <<lxCajavalor>>, <<lxNroitem>>, <<lxTotal>>, <<lxTipo>>, <<iif( lxChequeelectronico, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxNumerochequepropio_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerocheque_PK ) + "'">>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxValor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValordetalle ) + "'">>, <<"'" + this.ConvertirDateSql( lxFecha ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerointerno ) + "'">>, <<lxMonto>>, <<lxCotiza>>, <<lxMontoamonedasistema>>, <<"'" + this.FormatearTextoSql( lxIditemcomponente ) + "'">> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.COMPAFEC
				if this.oEntidad.COMPAFEC.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxTipocomprobante = loItem.Tipocomprobante
					lxTipocompcaracter = loItem.Tipocompcaracter
					lxLetra = loItem.Letra
					lxPuntodeventa = loItem.Puntodeventa
					lxNumero = loItem.Numero
					lxFecha = loItem.Fecha
					lxTotal = loItem.Total
					lxVendedor = loItem.Vendedor
					lxTipo = loItem.Tipo
					lxAfecta = loItem.Afecta
					lxInterviniente = loItem.Interviniente
					lxNombreentidad = loItem.Nombreentidad
					lxCodigoentidad = loItem.Codigoentidad
					lxOrigen = loItem.Origen
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.CompAfe("NROITEM","Codigo","AfeTipoCom","AfeComprob","AfeLETRA","AfePTOVEN","AfeNUMCOM","afefecha","afetotal","afevend","afetipo","Afecta","DescInter","NomInter","CodInter","Origen" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<lxTipocomprobante>>, <<"'" + this.FormatearTextoSql( lxTipocompcaracter ) + "'">>, <<"'" + this.FormatearTextoSql( lxLetra ) + "'">>, <<lxPuntodeventa>>, <<lxNumero>>, <<"'" + this.ConvertirDateSql( lxFecha ) + "'">>, <<lxTotal>>, <<"'" + this.FormatearTextoSql( lxVendedor ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipo ) + "'">>, <<"'" + this.FormatearTextoSql( lxAfecta ) + "'">>, <<"'" + this.FormatearTextoSql( lxInterviniente ) + "'">>, <<"'" + this.FormatearTextoSql( lxNombreentidad ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigoentidad ) + "'">>, <<"'" + this.FormatearTextoSql( lxOrigen ) + "'">> ) 
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
			local  lxCompcajaFaltafw, lxCompcajaFechaori, lxCompcajaFecexpo, lxCompcajaFecimpo, lxCompcajaFmodifw, lxCompcajaFectrans, lxCompcajaCotiz, lxCompcajaTimestamp, lxCompcajaCodigoori, lxCompcajaSignomov, lxCompcajaDescfw, lxCompcajaHmodifw, lxCompcajaSaltafw, lxCompcajaZadsfw, lxCompcajaValtafw, lxCompcajaUmodifw, lxCompcajaVmodifw, lxCompcajaUaltafw, lxCompcajaHoraimpo, lxCompcajaSmodifw, lxCompcajaEsttrans, lxCompcajaHoraexpo, lxCompcajaBdaltafw, lxCompcajaBdmodifw, lxCompcajaHaltafw, lxCompcajaMonsis, lxCompcajaMoneda, lxCompcajaCobs, lxCompcajaFecha, lxCompcajaOrigdest, lxCompcajaCodigo, lxCompcajaConcepto, lxCompcajaTipo, lxCompcajaNumero, lxCompcajaCajaorig, lxCompcajaCajadest, lxCompcajaVendedor
				lxCompcajaFaltafw =  .Fechaaltafw			lxCompcajaFechaori =  .Fechaoriginal			lxCompcajaFecexpo =  .Fechaexpo			lxCompcajaFecimpo =  .Fechaimpo			lxCompcajaFmodifw =  .Fechamodificacionfw			lxCompcajaFectrans =  .Fechatransferencia			lxCompcajaCotiz =  .Cotizacion			lxCompcajaTimestamp = goLibrerias.ObtenerTimestamp()			lxCompcajaCodigoori =  .Codigooriginal			lxCompcajaSignomov =  .Signodemovimiento			lxCompcajaDescfw =  .Descripcionfw			lxCompcajaHmodifw =  .Horamodificacionfw			lxCompcajaSaltafw =  .Seriealtafw			lxCompcajaZadsfw =  .Zadsfw			lxCompcajaValtafw =  .Versionaltafw			lxCompcajaUmodifw =  .Usuariomodificacionfw			lxCompcajaVmodifw =  .Versionmodificacionfw			lxCompcajaUaltafw =  .Usuarioaltafw			lxCompcajaHoraimpo =  .Horaimpo			lxCompcajaSmodifw =  .Seriemodificacionfw			lxCompcajaEsttrans =  .Estadotransferencia			lxCompcajaHoraexpo =  .Horaexpo			lxCompcajaBdaltafw =  .Basededatosaltafw			lxCompcajaBdmodifw =  .Basededatosmodificacionfw			lxCompcajaHaltafw =  .Horaaltafw			lxCompcajaMonsis =  upper( .MonedaSistema_PK ) 			lxCompcajaMoneda =  upper( .MonedaComprobante_PK ) 			lxCompcajaCobs =  .Observacion			lxCompcajaFecha =  .Fecha			lxCompcajaOrigdest =  upper( .OrigenDestino_PK ) 			lxCompcajaCodigo =  .Identificador			lxCompcajaConcepto =  upper( .Concepto_PK ) 			lxCompcajaTipo =  .Tipo			lxCompcajaNumero =  .Numero			lxCompcajaCajaorig =  .Cajaorigen_PK 			lxCompcajaCajadest =  .Cajadestino_PK 			lxCompcajaVendedor =  upper( .Vendedor_PK ) 
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.IDENTIFICADOR
			lcValorClavePrimariaString = "'" + this.oEntidad.IDENTIFICADOR + "'"

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  COMPCAJA.CODIGO != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.COMPCAJA set "Faltafw" = <<"'" + this.ConvertirDateSql( lxCompcajaFaltafw ) + "'">>, "Fechaori" = <<"'" + this.ConvertirDateSql( lxCompcajaFechaori ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxCompcajaFecexpo ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxCompcajaFecimpo ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxCompcajaFmodifw ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxCompcajaFectrans ) + "'">>, "Cotiz" = <<lxCompcajaCotiz>>, "Timestamp" = <<lxCompcajaTimestamp>>, "Codigoori" = <<"'" + this.FormatearTextoSql( lxCompcajaCodigoori ) + "'">>, "Signomov" = <<lxCompcajaSignomov>>, "Descfw" = <<"'" + this.FormatearTextoSql( lxCompcajaDescfw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxCompcajaHmodifw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxCompcajaSaltafw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxCompcajaZadsfw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxCompcajaValtafw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxCompcajaUmodifw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxCompcajaVmodifw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxCompcajaUaltafw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxCompcajaHoraimpo ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxCompcajaSmodifw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxCompcajaEsttrans ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxCompcajaHoraexpo ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxCompcajaBdaltafw ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxCompcajaBdmodifw ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxCompcajaHaltafw ) + "'">>, "Monsis" = <<"'" + this.FormatearTextoSql( lxCompcajaMonsis ) + "'">>, "Moneda" = <<"'" + this.FormatearTextoSql( lxCompcajaMoneda ) + "'">>, "Cobs" = <<"'" + this.FormatearTextoSql( lxCompcajaCobs ) + "'">>, "Fecha" = <<"'" + this.ConvertirDateSql( lxCompcajaFecha ) + "'">>, "Origdest" = <<"'" + this.FormatearTextoSql( lxCompcajaOrigdest ) + "'">>, "Codigo" = <<"'" + this.FormatearTextoSql( lxCompcajaCodigo ) + "'">>, "Concepto" = <<"'" + this.FormatearTextoSql( lxCompcajaConcepto ) + "'">>, "Tipo" = <<lxCompcajaTipo>>, "Numero" = <<lxCompcajaNumero>>, "Cajaorig" = <<lxCompcajaCajaorig>>, "Cajadest" = <<lxCompcajaCajadest>>, "Vendedor" = <<"'" + this.FormatearTextoSql( lxCompcajaVendedor ) + "'">> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'COMPCAJA' 
		loColeccion.agregar( strtran(  lcSentencia, chr( 9 ), '' ) )
			loColeccion.Agregar([delete from ZooLogic.CompCajaDet where "CodDetVal" = ] + "'" + this.FormatearTextoSql( .oEntidad.IDENTIFICADOR ) + "'")
			loColeccion.Agregar([delete from ZooLogic.CompAfe where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.IDENTIFICADOR ) + "'")

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.Valores
				if this.oEntidad.Valores.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxFechacomp = loItem.Fechacomp
					lxCaja_PK = loItem.Caja_PK
					lxCajavalor = loItem.Cajavalor
					lxNroitem = lnContadorNroItem
					lxTotal = loItem.Total
					lxTipo = loItem.Tipo
					lxChequeelectronico = loItem.Chequeelectronico
					lxNumerochequepropio_PK = loItem.Numerochequepropio_PK
					lxNumerocheque_PK = loItem.Numerocheque_PK
					lxValor_PK = loItem.Valor_PK
					lxValordetalle = loItem.Valordetalle
					lxFecha = loItem.Fecha
					lxNumerointerno = loItem.Numerointerno
					lxMonto = loItem.Monto
					lxCotiza = loItem.Cotiza
					lxMontoamonedasistema = loItem.Montoamonedasistema
					lxIditemcomponente = loItem.Iditemcomponente
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.CompCajaDet("JJfecha","IdCaja","CajaVal","NROITEM","cTotal","Tipo","CElectro","NroChProp","NroCheque","CodDetVal","CodVal","Descrip","Fecha","NroInterno","monto","Cotiza","Montosiste","guidComp" ) values ( <<"'" + this.ConvertirDateSql( lxFechacomp ) + "'">>, <<lxCaja_PK>>, <<lxCajavalor>>, <<lxNroitem>>, <<lxTotal>>, <<lxTipo>>, <<iif( lxChequeelectronico, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxNumerochequepropio_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerocheque_PK ) + "'">>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxValor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValordetalle ) + "'">>, <<"'" + this.ConvertirDateSql( lxFecha ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerointerno ) + "'">>, <<lxMonto>>, <<lxCotiza>>, <<lxMontoamonedasistema>>, <<"'" + this.FormatearTextoSql( lxIditemcomponente ) + "'">> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.COMPAFEC
				if this.oEntidad.COMPAFEC.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxTipocomprobante = loItem.Tipocomprobante
					lxTipocompcaracter = loItem.Tipocompcaracter
					lxLetra = loItem.Letra
					lxPuntodeventa = loItem.Puntodeventa
					lxNumero = loItem.Numero
					lxFecha = loItem.Fecha
					lxTotal = loItem.Total
					lxVendedor = loItem.Vendedor
					lxTipo = loItem.Tipo
					lxAfecta = loItem.Afecta
					lxInterviniente = loItem.Interviniente
					lxNombreentidad = loItem.Nombreentidad
					lxCodigoentidad = loItem.Codigoentidad
					lxOrigen = loItem.Origen
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.CompAfe("NROITEM","Codigo","AfeTipoCom","AfeComprob","AfeLETRA","AfePTOVEN","AfeNUMCOM","afefecha","afetotal","afevend","afetipo","Afecta","DescInter","NomInter","CodInter","Origen" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<lxTipocomprobante>>, <<"'" + this.FormatearTextoSql( lxTipocompcaracter ) + "'">>, <<"'" + this.FormatearTextoSql( lxLetra ) + "'">>, <<lxPuntodeventa>>, <<lxNumero>>, <<"'" + this.ConvertirDateSql( lxFecha ) + "'">>, <<lxTotal>>, <<"'" + this.FormatearTextoSql( lxVendedor ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipo ) + "'">>, <<"'" + this.FormatearTextoSql( lxAfecta ) + "'">>, <<"'" + this.FormatearTextoSql( lxInterviniente ) + "'">>, <<"'" + this.FormatearTextoSql( lxNombreentidad ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigoentidad ) + "'">>, <<"'" + this.FormatearTextoSql( lxOrigen ) + "'">> ) 
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
			lxValorClavePrimaria = this.oEntidad.IDENTIFICADOR
			lcValorClavePrimariaString = "'" + this.oEntidad.IDENTIFICADOR + "'"

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  COMPCAJA.CODIGO != '']
		loColeccion.Agregar( 'delete from ZooLogic.COMPCAJA where ' + lcFiltro )
			loColeccion.Agregar([delete from ZooLogic.CompCajaDet where "CodDetVal" = ] + "'" + this.FormatearTextoSql( .oEntidad.IDENTIFICADOR ) + "'")
			loColeccion.Agregar([delete from ZooLogic.CompAfe where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.IDENTIFICADOR ) + "'")
			loColeccion.cTabla = 'COMPCAJA' 
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
		
			.oCompArqueodecaja.lNuevo = .EsNuevo()
			.oCompArqueodecaja.lEdicion = .EsEdicion()
			.oCompArqueodecaja.lEliminar = .lEliminar
			.oCompArqueodecaja.lAnular = .lAnular
			loColSentencias = .oCompArqueodecaja.grabar()
			for each lcItem in loColSentencias
				this.colSentencias.Agregar( lcItem )
			endfor
			
			.oCompCuentabancariacomprobantecaja.lNuevo = .EsNuevo()
			.oCompCuentabancariacomprobantecaja.lEdicion = .EsEdicion()
			.oCompCuentabancariacomprobantecaja.lEliminar = .lEliminar
			.oCompCuentabancariacomprobantecaja.lAnular = .lAnular
			loColSentencias = .oCompCuentabancariacomprobantecaja.grabar()
			for each lcItem in loColSentencias
				this.colSentencias.Agregar( lcItem )
			endfor
			
		endwith
		
		with this.oEntidad
			.Valores.oItem.oCompCajero.lNuevo = .EsNuevo()
			.Valores.oItem.oCompCajero.lEdicion = .EsEdicion()
			.Valores.oItem.oCompCajero.lEliminar = .lEliminar
			.Valores.oItem.oCompCajero.lAnular = .lAnular
			loColSentencias = .Valores.oItem.oCompCajero.grabar()
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
			lcRetorno = [update ZooLogic.COMPCAJA set TimeStamp = ] + transform( lnTimeStamp ) + lcUpdateRealTime + [ where Codigo = ] + "'" + this.FormatearTextoSql( .Identificador ) + "'" + [ and  COMPCAJA.CODIGO != ''] + goServicios.RealTime.ObtenerTagEstimulo( .cNombre )
		
		endwith
		return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function ObtenerCantidadRegistros() as integer
		local lnCantReg as integer
			local lcXml as string
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.COMPCAJA where  COMPCAJA.CODIGO != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.COMPCAJA where Codigo = " + "'" + this.FormatearTextoSql( this.oEntidad.IDENTIFICADOR ) + "'"+ " and  COMPCAJA.CODIGO != ''" )
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
		local lcCursor as String, ldFecha as Date, lcHora as string, lcValorABuscar As String, lxValorClavePK As variant, lxValorClavePrimaria As variant, lcIdentificadorParaLoguear as string, lcMensajeExtra as String
		lcValorABuscar = ''
		lxValorClavePK = ''
		lcMensajeExtra = ''
		lcCursor = This.oEntidad.cPrefijoRecibir + 'COMPROBANTEDECAJA'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.COMPCAJA Where Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'", 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				if This.ActualizaEnRecepcion() 
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					this.oConexion.EjecutarSql( [UPDATE ZooLogic.COMPCAJA set  FECHAORI = ] + "'" + this.ConvertirDateSql( &lcCursor..FECHAORI ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, Cotiz = ] + transform( &lcCursor..Cotiz )+ [, TIMESTAMP = ] + transform( &lcCursor..TIMESTAMP )+ [, CODIGOORI = ] + "'" + this.FormatearTextoSql( &lcCursor..CODIGOORI ) + "'"+ [, signoMov = ] + transform( &lcCursor..signoMov )+ [, DescFW = ] + "'" + this.FormatearTextoSql( &lcCursor..DescFW ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, MonSis = ] + "'" + this.FormatearTextoSql( &lcCursor..MonSis ) + "'"+ [, Moneda = ] + "'" + this.FormatearTextoSql( &lcCursor..Moneda ) + "'"+ [, CObs = ] + "'" + this.FormatearTextoSql( &lcCursor..CObs ) + "'"+ [, Fecha = ] + "'" + this.ConvertirDateSql( &lcCursor..Fecha ) + "'"+ [, ORIGDEST = ] + "'" + this.FormatearTextoSql( &lcCursor..ORIGDEST ) + "'"+ [, Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'"+ [, Concepto = ] + "'" + this.FormatearTextoSql( &lcCursor..Concepto ) + "'"+ [, Tipo = ] + transform( &lcCursor..Tipo )+ [, Numero = ] + transform( &lcCursor..Numero )+ [, CajaOrig = ] + transform( &lcCursor..CajaOrig )+ [, CajaDest = ] + transform( &lcCursor..CajaDest )+ [, Vendedor = ] + "'" + this.FormatearTextoSql( &lcCursor..Vendedor ) + "'" + [ Where Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'" )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
				endIf
			else
				Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
				Text to lcCampos noShow
					 FALTAFW, FECHAORI, FECEXPO, FECIMPO, FMODIFW, FECTRANS, Cotiz, TIMESTAMP, CODIGOORI, signoMov, DescFW, HMODIFW, SALTAFW, ZADSFW, VALTAFW, UMODIFW, VMODIFW, UALTAFW, HORAIMPO, SMODIFW, ESTTRANS, HORAEXPO, BDALTAFW, BDMODIFW, HALTAFW, MonSis, Moneda, CObs, Fecha, ORIGDEST, Codigo, Concepto, Tipo, Numero, CajaOrig, CajaDest, Vendedor
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECHAORI ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + transform( &lcCursor..Cotiz )
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..TIMESTAMP ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..CODIGOORI ) + "'" + ',' + transform( &lcCursor..signoMov ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..DescFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..MonSis ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Moneda ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CObs ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..Fecha ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ORIGDEST ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Concepto ) + "'" + ',' + transform( &lcCursor..Tipo ) + ',' + transform( &lcCursor..Numero ) + ',' + transform( &lcCursor..CajaOrig ) + ',' + transform( &lcCursor..CajaDest )
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..Vendedor ) + "'"
lcValoresCampos = substr(lcValoresCampos,2) 

				this.oConexion.EjecutarSql( [Insert into ZooLogic.COMPCAJA ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
				this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'COMPROBANTEDECAJA'
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
			this.oConexion.EjecutarSql( [Delete From ZooLogic.CompCajaDet Where CodDetVal] + lcIn  )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.CompAfe Where Codigo] + lcIn  )
			endfor
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'COMMIT TRANSACTION' )
			endif
		EndIf
	endif
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMVALORESCAJA'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where CodDetVal in ( select Codigo from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"JJfecha","IdCaja","CajaVal","NROITEM","cTotal","Tipo","CElectro","NroChProp","NroCheque","CodDetVal","CodVal","Descrip","Fecha","NroInterno","monto","Cotiza","Montosiste","guidComp"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.CompCajaDet ( ] + lcCamposInsert + [ ) values ( ] +  "'" + this.ConvertirDateSql( cDetallesExistentes.JJfecha    ) + "'" + ',' + transform( cDetallesExistentes.IdCaja     ) + ',' + transform( cDetallesExistentes.CajaVal    ) + ',' + transform( cDetallesExistentes.NROITEM    ) + ',' + transform( cDetallesExistentes.cTotal     ) + ',' + transform( cDetallesExistentes.Tipo       ) + ',' + Transform( iif( cDetallesExistentes.CElectro  , 1, 0 )) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.NroChProp  ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.NroCheque  ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CodDetVal  ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CodVal     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Descrip    ) + "'" + ',' + "'" + this.ConvertirDateSql( cDetallesExistentes.Fecha      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.NroInterno ) + "'" + ',' + transform( cDetallesExistentes.monto      ) + ',' + transform( cDetallesExistentes.Cotiza     ) + ',' + transform( cDetallesExistentes.Montosiste ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.guidComp   ) + "'" + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMCOMPROBANTE'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where Codigo in ( select Codigo from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"NROITEM","Codigo","AfeTipoCom","AfeComprob","AfeLETRA","AfePTOVEN","AfeNUMCOM","afefecha","afetotal","afevend","afetipo","Afecta","DescInter","NomInter","CodInter","Origen"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.CompAfe ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Codigo     ) + "'" + ',' + transform( cDetallesExistentes.AfeTipoCom ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.AfeComprob ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.AfeLETRA   ) + "'" + ',' + transform( cDetallesExistentes.AfePTOVEN  ) + ',' + transform( cDetallesExistentes.AfeNUMCOM  ) + ',' + "'" + this.ConvertirDateSql( cDetallesExistentes.afefecha   ) + "'" + ',' + transform( cDetallesExistentes.afetotal   ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.afevend    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.afetipo    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Afecta     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.DescInter  ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.NomInter   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CodInter   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Origen     ) + "'" + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	Use in select( 'cExistentes' )
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearCursorMemo( tcCursorACrear as String, tcTablaConMemo as String ) as Void
		create cursor &tcCursorACrear ( Codigo C (20) , Orden N(16), texto C(80))
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirComponentes() As Void
		this.oEntidad.Valores.oItem.oCompCajero.Recibir( this.oEntidad, 'Valores',this.oEntidad.cPrefijoRecibir + 'ITEMVALORESCAJA',this.oEntidad.cPrefijoRecibir + 'COMPROBANTEDECAJA')
		
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
			Case  lcAlias == lcPrefijo + 'COMPROBANTEDECAJA'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'COMPROBANTEDECAJA_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'COMPROBANTEDECAJA_COBS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMVALORESCAJA'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMCOMPROBANTE'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_CompCaja')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'COMPROBANTEDECAJA'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..Codigo
		llCondicion = isnull( lxVar )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad COMPROBANTEDECAJA. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'COMPROBANTEDECAJA'
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
			lcCursor = This.oEntidad.cPrefijoRecibir + 'COMPROBANTEDECAJA'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FECHAORI  
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  Fecha     
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_CompCaja') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_CompCaja
Create Table ZooLogic.TablaTrabajo_CompCaja ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"faltafw" datetime  null, 
"fechaori" datetime  null, 
"fecexpo" datetime  null, 
"fecimpo" datetime  null, 
"fmodifw" datetime  null, 
"fectrans" datetime  null, 
"cotiz" numeric( 15, 5 )  null, 
"timestamp" numeric( 20, 0 )  null, 
"codigoori" char( 20 )  null, 
"signomov" numeric( 2, 0 )  null, 
"descfw" char( 200 )  null, 
"hmodifw" char( 8 )  null, 
"saltafw" char( 7 )  null, 
"zadsfw" varchar(max)  null, 
"valtafw" char( 13 )  null, 
"umodifw" char( 100 )  null, 
"vmodifw" char( 13 )  null, 
"ualtafw" char( 100 )  null, 
"horaimpo" char( 8 )  null, 
"smodifw" char( 7 )  null, 
"esttrans" char( 20 )  null, 
"horaexpo" char( 8 )  null, 
"bdaltafw" char( 8 )  null, 
"bdmodifw" char( 8 )  null, 
"haltafw" char( 8 )  null, 
"monsis" char( 10 )  null, 
"moneda" char( 10 )  null, 
"cobs" varchar(max)  null, 
"fecha" datetime  null, 
"origdest" char( 8 )  null, 
"codigo" char( 20 )  null, 
"concepto" char( 10 )  null, 
"tipo" numeric( 1, 0 )  null, 
"numero" numeric( 10, 0 )  null, 
"cajaorig" numeric( 2, 0 )  null, 
"cajadest" numeric( 2, 0 )  null, 
"vendedor" char( 5 )  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_CompCaja' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_CompCaja' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'COMPROBANTEDECAJA'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		with loManejador
			if this.oEntidad.VerificarContexto( 'CB' )
			else
				.AgregarMapeo('Nrolinea','Nrolinea')
			endif
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('fechaori','fechaori')
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('cotiz','cotiz')
			.AgregarMapeo('timestamp','timestamp')
			.AgregarMapeo('codigoori','codigoori')
			.AgregarMapeo('signomov','signomov')
			.AgregarMapeo('descfw','descfw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('monsis','monsis')
			.AgregarMapeo('moneda','moneda')
			.AgregarMapeo('cobs','cobs')
			.AgregarMapeo('fecha','fecha')
			.AgregarMapeo('origdest','origdest')
			.AgregarMapeo('codigo','codigo')
			.AgregarMapeo('concepto','concepto')
			.AgregarMapeo('tipo','tipo')
			.AgregarMapeo('numero','numero')
			.AgregarMapeo('cajaorig','cajaorig')
			.AgregarMapeo('cajadest','cajadest')
			.AgregarMapeo('vendedor','vendedor')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_CompCaja'
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
				Update t Set t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FECHAORI = isnull( d.FECHAORI, t.FECHAORI ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.COTIZ = isnull( d.COTIZ, t.COTIZ ),t.TIMESTAMP = isnull( d.TIMESTAMP, t.TIMESTAMP ),t.CODIGOORI = isnull( d.CODIGOORI, t.CODIGOORI ),t.SIGNOMOV = isnull( d.SIGNOMOV, t.SIGNOMOV ),t.DESCFW = isnull( d.DESCFW, t.DESCFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.MONSIS = isnull( d.MONSIS, t.MONSIS ),t.MONEDA = isnull( d.MONEDA, t.MONEDA ),t.COBS = isnull( d.COBS, t.COBS ),t.FECHA = isnull( d.FECHA, t.FECHA ),t.ORIGDEST = isnull( d.ORIGDEST, t.ORIGDEST ),t.CODIGO = isnull( d.CODIGO, t.CODIGO ),t.CONCEPTO = isnull( d.CONCEPTO, t.CONCEPTO ),t.TIPO = isnull( d.TIPO, t.TIPO ),t.NUMERO = isnull( d.NUMERO, t.NUMERO ),t.CAJAORIG = isnull( d.CAJAORIG, t.CAJAORIG ),t.CAJADEST = isnull( d.CAJADEST, t.CAJADEST ),t.VENDEDOR = isnull( d.VENDEDOR, t.VENDEDOR )
					from ZooLogic.COMPCAJA t inner join deleted d 
							 on t.Codigo = d.Codigo
				-- Fin Updates
				insert into ZooLogic.COMPCAJA(Faltafw,Fechaori,Fecexpo,Fecimpo,Fmodifw,Fectrans,Cotiz,Timestamp,Codigoori,Signomov,Descfw,Hmodifw,Saltafw,Zadsfw,Valtafw,Umodifw,Vmodifw,Ualtafw,Horaimpo,Smodifw,Esttrans,Horaexpo,Bdaltafw,Bdmodifw,Haltafw,Monsis,Moneda,Cobs,Fecha,Origdest,Codigo,Concepto,Tipo,Numero,Cajaorig,Cajadest,Vendedor)
					Select CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FECHAORI,''),isnull( d.FECEXPO,''),isnull( d.FECIMPO,''),isnull( d.FMODIFW,''),isnull( d.FECTRANS,''),isnull( d.COTIZ,0),isnull( d.TIMESTAMP,0),isnull( d.CODIGOORI,''),isnull( d.SIGNOMOV,0),isnull( d.DESCFW,''),isnull( d.HMODIFW,''),isnull( d.SALTAFW,''),isnull( d.ZADSFW,''),isnull( d.VALTAFW,''),isnull( d.UMODIFW,''),isnull( d.VMODIFW,''),isnull( d.UALTAFW,''),isnull( d.HORAIMPO,''),isnull( d.SMODIFW,''),isnull( d.ESTTRANS,''),isnull( d.HORAEXPO,''),isnull( d.BDALTAFW,''),isnull( d.BDMODIFW,''),convert( char(8), getdate(), 108 ),isnull( d.MONSIS,''),isnull( d.MONEDA,''),isnull( d.COBS,''),isnull( d.FECHA,''),isnull( d.ORIGDEST,''),isnull( d.CODIGO,''),isnull( d.CONCEPTO,''),isnull( d.TIPO,0),isnull( d.NUMERO,0),isnull( d.CAJAORIG,0),isnull( d.CAJADEST,0),isnull( d.VENDEDOR,'')
						From deleted d left join ZooLogic.COMPCAJA pk 
							 on d.Codigo = pk.Codigo
						Where pk.Codigo Is Null 
				-- Fin Inserts
			End
		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_CompCajaDet( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_COMPCAJA_CompCajaDet
ON ZooLogic.TablaTrabajo_COMPCAJA_CompCajaDet
AFTER DELETE
As
Begin
Update t Set 
t.JJFECHA = isnull( d.JJFECHA, t.JJFECHA ),
t.IDCAJA = isnull( d.IDCAJA, t.IDCAJA ),
t.CAJAVAL = isnull( d.CAJAVAL, t.CAJAVAL ),
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.CTOTAL = isnull( d.CTOTAL, t.CTOTAL ),
t.TIPO = isnull( d.TIPO, t.TIPO ),
t.CELECTRO = isnull( d.CELECTRO, t.CELECTRO ),
t.NROCHPROP = isnull( d.NROCHPROP, t.NROCHPROP ),
t.NROCHEQUE = isnull( d.NROCHEQUE, t.NROCHEQUE ),
t.CODDETVAL = isnull( d.CODDETVAL, t.CODDETVAL ),
t.CODVAL = isnull( d.CODVAL, t.CODVAL ),
t.DESCRIP = isnull( d.DESCRIP, t.DESCRIP ),
t.FECHA = isnull( d.FECHA, t.FECHA ),
t.NROINTERNO = isnull( d.NROINTERNO, t.NROINTERNO ),
t.MONTO = isnull( d.MONTO, t.MONTO ),
t.COTIZA = isnull( d.COTIZA, t.COTIZA ),
t.MONTOSISTE = isnull( d.MONTOSISTE, t.MONTOSISTE ),
t.GUIDCOMP = isnull( d.GUIDCOMP, t.GUIDCOMP )
from ZooLogic.CompCajaDet t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.CompCajaDet
( 
"JJFECHA",
"IDCAJA",
"CAJAVAL",
"NROITEM",
"CTOTAL",
"TIPO",
"CELECTRO",
"NROCHPROP",
"NROCHEQUE",
"CODDETVAL",
"CODVAL",
"DESCRIP",
"FECHA",
"NROINTERNO",
"MONTO",
"COTIZA",
"MONTOSISTE",
"GUIDCOMP"
 )
Select 
d.JJFECHA,
d.IDCAJA,
d.CAJAVAL,
d.NROITEM,
d.CTOTAL,
d.TIPO,
d.CELECTRO,
d.NROCHPROP,
d.NROCHEQUE,
d.CODDETVAL,
d.CODVAL,
d.DESCRIP,
d.FECHA,
d.NROINTERNO,
d.MONTO,
d.COTIZA,
d.MONTOSISTE,
d.GUIDCOMP
From deleted d left join ZooLogic.CompCajaDet pk 
 on d.CODIGO = pk.CODIGO
Where pk.CODIGO Is Null 
-- Fin Inserts
End

		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_CompAfe( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_COMPCAJA_CompAfe
ON ZooLogic.TablaTrabajo_COMPCAJA_CompAfe
AFTER DELETE
As
Begin
Update t Set 
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.CODIGO = isnull( d.CODIGO, t.CODIGO ),
t.AFETIPOCOM = isnull( d.AFETIPOCOM, t.AFETIPOCOM ),
t.AFECOMPROB = isnull( d.AFECOMPROB, t.AFECOMPROB ),
t.AFELETRA = isnull( d.AFELETRA, t.AFELETRA ),
t.AFEPTOVEN = isnull( d.AFEPTOVEN, t.AFEPTOVEN ),
t.AFENUMCOM = isnull( d.AFENUMCOM, t.AFENUMCOM ),
t.AFEFECHA = isnull( d.AFEFECHA, t.AFEFECHA ),
t.AFETOTAL = isnull( d.AFETOTAL, t.AFETOTAL ),
t.AFEVEND = isnull( d.AFEVEND, t.AFEVEND ),
t.AFETIPO = isnull( d.AFETIPO, t.AFETIPO ),
t.AFECTA = isnull( d.AFECTA, t.AFECTA ),
t.DESCINTER = isnull( d.DESCINTER, t.DESCINTER ),
t.NOMINTER = isnull( d.NOMINTER, t.NOMINTER ),
t.CODINTER = isnull( d.CODINTER, t.CODINTER ),
t.ORIGEN = isnull( d.ORIGEN, t.ORIGEN )
from ZooLogic.CompAfe t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.CompAfe
( 
"NROITEM",
"CODIGO",
"AFETIPOCOM",
"AFECOMPROB",
"AFELETRA",
"AFEPTOVEN",
"AFENUMCOM",
"AFEFECHA",
"AFETOTAL",
"AFEVEND",
"AFETIPO",
"AFECTA",
"DESCINTER",
"NOMINTER",
"CODINTER",
"ORIGEN"
 )
Select 
d.NROITEM,
d.CODIGO,
d.AFETIPOCOM,
d.AFECOMPROB,
d.AFELETRA,
d.AFEPTOVEN,
d.AFENUMCOM,
d.AFEFECHA,
d.AFETOTAL,
d.AFEVEND,
d.AFETIPO,
d.AFECTA,
d.DESCINTER,
d.NOMINTER,
d.CODINTER,
d.ORIGEN
From deleted d left join ZooLogic.CompAfe pk 
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_CompCaja') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_CompCaja
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_COMPROBANTEDECAJA' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_COMPROBANTEDECAJA.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechaoriginal = GoLibrerias.ObtenerFechaFormateada( nvl( c_COMPROBANTEDECAJA.Fechaoriginal, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_COMPROBANTEDECAJA.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_COMPROBANTEDECAJA.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_COMPROBANTEDECAJA.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_COMPROBANTEDECAJA.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Valores.Limpiar()
					.Valores.SetearEsNavegacion( .lProcesando )
					.Valores.Cargar()
					.Cotizacion = nvl( c_COMPROBANTEDECAJA.Cotizacion, 0 )
					.Compafec.Limpiar()
					.Compafec.SetearEsNavegacion( .lProcesando )
					.Compafec.Cargar()
					.Timestamp = nvl( c_COMPROBANTEDECAJA.Timestamp, 0 )
					.Codigooriginal = nvl( c_COMPROBANTEDECAJA.Codigooriginal, [] )
					.Signodemovimiento = nvl( c_COMPROBANTEDECAJA.Signodemovimiento, 0 )
					.Descripcionfw = nvl( c_COMPROBANTEDECAJA.Descripcionfw, [] )
					.Horamodificacionfw = nvl( c_COMPROBANTEDECAJA.Horamodificacionfw, [] )
					.Seriealtafw = nvl( c_COMPROBANTEDECAJA.Seriealtafw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Versionaltafw = nvl( c_COMPROBANTEDECAJA.Versionaltafw, [] )
					.Usuariomodificacionfw = nvl( c_COMPROBANTEDECAJA.Usuariomodificacionfw, [] )
					.Versionmodificacionfw = nvl( c_COMPROBANTEDECAJA.Versionmodificacionfw, [] )
					.Usuarioaltafw = nvl( c_COMPROBANTEDECAJA.Usuarioaltafw, [] )
					.Horaimpo = nvl( c_COMPROBANTEDECAJA.Horaimpo, [] )
					.Seriemodificacionfw = nvl( c_COMPROBANTEDECAJA.Seriemodificacionfw, [] )
					.Estadotransferencia = nvl( c_COMPROBANTEDECAJA.Estadotransferencia, [] )
					.Horaexpo = nvl( c_COMPROBANTEDECAJA.Horaexpo, [] )
					.Basededatosaltafw = nvl( c_COMPROBANTEDECAJA.Basededatosaltafw, [] )
					.Basededatosmodificacionfw = nvl( c_COMPROBANTEDECAJA.Basededatosmodificacionfw, [] )
					.Horaaltafw = nvl( c_COMPROBANTEDECAJA.Horaaltafw, [] )
					.Monedasistema_PK =  nvl( c_COMPROBANTEDECAJA.Monedasistema, [] )
					.Monedacomprobante_PK =  nvl( c_COMPROBANTEDECAJA.Monedacomprobante, [] )
					lcValor = This.ObtenerMemo( 'c_Observacion')
					.Observacion = lcValor 
					.Fecha = GoLibrerias.ObtenerFechaFormateada( nvl( c_COMPROBANTEDECAJA.Fecha, ctod( '  /  /    ' ) ) )
					.Origendestino_PK =  nvl( c_COMPROBANTEDECAJA.Origendestino, [] )
					.Identificador = nvl( c_COMPROBANTEDECAJA.Identificador, [] )
					.Concepto_PK =  nvl( c_COMPROBANTEDECAJA.Concepto, [] )
					.Tipo = nvl( c_COMPROBANTEDECAJA.Tipo, 0 )
					.Numero = nvl( c_COMPROBANTEDECAJA.Numero, 0 )
					.Cajaorigen_PK =  nvl( c_COMPROBANTEDECAJA.Cajaorigen, 0 )
					.Cajadestino_PK =  nvl( c_COMPROBANTEDECAJA.Cajadestino, 0 )
					.Vendedor_PK =  nvl( c_COMPROBANTEDECAJA.Vendedor, [] )
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
			lxRetorno = c_COMPROBANTEDECAJA.IDENTIFICADOR
		endif
		return lxRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function ActualizarLosNROItemDeLosDetalles() as void
		local loDetalle as object, loItem as object, lnContadorNroItem as integer, lnIndex as integer
		
		loDetalle = this.oEntidad.Valores
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

		loDetalle = this.oEntidad.COMPAFEC
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
		return c_COMPROBANTEDECAJA.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.COMPCAJA' )
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
								from ZooLogic.COMPCAJA 
								Where   COMPCAJA.CODIGO != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "COMPCAJA", "", lcCursor, set("Datasession") )
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
			"Faltafw" as "Fechaaltafw", "Fechaori" as "Fechaoriginal", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Cotiz" as "Cotizacion", "Timestamp" as "Timestamp", "Codigoori" as "Codigooriginal", "Signomov" as "Signodemovimiento", "Descfw" as "Descripcionfw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Ualtafw" as "Usuarioaltafw", "Horaimpo" as "Horaimpo", "Smodifw" as "Seriemodificacionfw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Haltafw" as "Horaaltafw", "Monsis" as "Monedasistema", "Moneda" as "Monedacomprobante", "Cobs" as "Observacion", "Fecha" as "Fecha", "Origdest" as "Origendestino", "Codigo" as "Identificador", "Concepto" as "Concepto", "Tipo" as "Tipo", "Numero" as "Numero", "Cajaorig" as "Cajaorigen", "Cajadest" as "Cajadestino", "Vendedor" as "Vendedor"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.COMPCAJA 
								Where   COMPCAJA.CODIGO != ''
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
	Tabla = 'COMPCAJA'
	Filtro = " COMPCAJA.CODIGO != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " COMPCAJA.CODIGO != ''"
	AnchoCampo = 13
	Caracteres = 13
	nrodecolumnas = 0
	signopregunta = .T.
	signopregunta2 = .t.
	TablaAuxiliar = .f.
	cOrden = "CompCaja.Numero"
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
	<row entidad="COMPROBANTEDECAJA                       " atributo="FECHAALTAFW                             " tabla="COMPCAJA       " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTEDECAJA                       " atributo="FECHAORIGINAL                           " tabla="COMPCAJA       " campo="FECHAORI  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha Original                                                                                                                                                  " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTEDECAJA                       " atributo="FECHAEXPO                               " tabla="COMPCAJA       " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTEDECAJA                       " atributo="FECHAIMPO                               " tabla="COMPCAJA       " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTEDECAJA                       " atributo="FECHAMODIFICACIONFW                     " tabla="COMPCAJA       " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTEDECAJA                       " atributo="FECHATRANSFERENCIA                      " tabla="COMPCAJA       " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha transferencia                                                                                                                                             " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTEDECAJA                       " atributo="VALORES                                 " tabla="COMPCAJADET    " campo="CODDETVAL " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="Detalle de Valores                                                                                                                                              " dominio="DETALLEITEMVALORESCAJA        " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTEDECAJA                       " atributo="COTIZACION                              " tabla="COMPCAJA       " campo="COTIZ     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="5" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICONONEGATIVO            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTEDECAJA                       " atributo="COMPAFEC                                " tabla="COMPAFE        " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="DETALLEITEMCOMPROBANTE        " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTEDECAJA                       " atributo="TIMESTAMP                               " tabla="COMPCAJA       " campo="TIMESTAMP " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTEDECAJA                       " atributo="CODIGOORIGINAL                          " tabla="COMPCAJA       " campo="CODIGOORI " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Número Original                                                                                                                                                 " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTEDECAJA                       " atributo="SIGNODEMOVIMIENTO                       " tabla="COMPCAJA       " campo="SIGNOMOV  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="1                                                                                                                                                                                                                                                             " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTEDECAJA                       " atributo="DESCRIPCIONFW                           " tabla="COMPCAJA       " campo="DESCFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="200" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTEDECAJA                       " atributo="HORAMODIFICACIONFW                      " tabla="COMPCAJA       " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTEDECAJA                       " atributo="SERIEALTAFW                             " tabla="COMPCAJA       " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTEDECAJA                       " atributo="ZADSFW                                  " tabla="COMPCAJA       " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTEDECAJA                       " atributo="VERSIONALTAFW                           " tabla="COMPCAJA       " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTEDECAJA                       " atributo="USUARIOMODIFICACIONFW                   " tabla="COMPCAJA       " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTEDECAJA                       " atributo="VERSIONMODIFICACIONFW                   " tabla="COMPCAJA       " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTEDECAJA                       " atributo="USUARIOALTAFW                           " tabla="COMPCAJA       " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTEDECAJA                       " atributo="HORAIMPO                                " tabla="COMPCAJA       " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTEDECAJA                       " atributo="SERIEMODIFICACIONFW                     " tabla="COMPCAJA       " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTEDECAJA                       " atributo="ESTADOTRANSFERENCIA                     " tabla="COMPCAJA       " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado transferencia                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTEDECAJA                       " atributo="HORAEXPO                                " tabla="COMPCAJA       " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTEDECAJA                       " atributo="BASEDEDATOSALTAFW                       " tabla="COMPCAJA       " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTEDECAJA                       " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="COMPCAJA       " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTEDECAJA                       " atributo="HORAALTAFW                              " tabla="COMPCAJA       " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTEDECAJA                       " atributo="MONEDASISTEMA                           " tabla="COMPCAJA       " campo="MONSIS    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="MONEDA                                  " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTEDECAJA                       " atributo="MONEDACOMPROBANTE                       " tabla="COMPCAJA       " campo="MONEDA    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="MONEDA                                  " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTEDECAJA                       " atributo="OBSERVACION                             " tabla="COMPCAJA       " campo="COBS      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="402" etiqueta="Observaciones                                                                                                                                                   " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTEDECAJA                       " atributo="FECHA                                   " tabla="COMPCAJA       " campo="FECHA     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goServicios.Librerias.ObtenerFecha()                                                                                                                                                                                                                         " obligatorio="true" admitebusqueda="4" etiqueta="Fecha                                                                                                                                                           " dominio="FECHACOMPROBANTE              " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTEDECAJA                       " atributo="ORIGENDESTINO                           " tabla="COMPCAJA       " campo="ORIGDEST  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="ORIGENDEDATOS                           " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="404" etiqueta="Origen Destino                                                                                                                                                  " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTEDECAJA                       " atributo="IDENTIFICADOR                           " tabla="COMPCAJA       " campo="CODIGO    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="2" etiqueta="Identificador                                                                                                                                                   " dominio="CODIGONUMERICO                " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="2" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTEDECAJA                       " atributo="CONCEPTO                                " tabla="COMPCAJA       " campo="CONCEPTO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CONCEPTOCAJA                            " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="8" etiqueta="Concepto                                                                                                                                                        " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTEDECAJA                       " atributo="TIPO                                    " tabla="COMPCAJA       " campo="TIPO      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="6" etiqueta="Tipo                                                                                                                                                            " dominio="COMBOXML                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTEDECAJA                       " atributo="NUMERO                                  " tabla="COMPCAJA       " campo="NUMERO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="10" decimales="0" valorsugerido="@ObtenerSiguienteNumerico()                                                                                                                                                                                                                                   " obligatorio="true" admitebusqueda="4" etiqueta="Número                                                                                                                                                          " dominio="CLAVEDEBUSQUEDA               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTEDECAJA                       " atributo="CAJAORIGEN                              " tabla="COMPCAJA       " campo="CAJAORIG  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CAJAESTADO                              " tipodato="N         " longitud="2" decimales="0" valorsugerido="this.ObtenerCajaOrigen()                                                                                                                                                                                                                                      " obligatorio="true" admitebusqueda="12" etiqueta="Caja origen                                                                                                                                                     " dominio="CODIGONUMERICO                " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTEDECAJA                       " atributo="CAJADESTINO                             " tabla="COMPCAJA       " campo="CAJADEST  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CAJAESTADO                              " tipodato="N         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="406" etiqueta="Caja destino                                                                                                                                                    " dominio="CODIGONUMERICO                " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTEDECAJA                       " atributo="VENDEDOR                                " tabla="COMPCAJA       " campo="VENDEDOR  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="VENDEDOR                                " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="408" etiqueta="Vendedor                                                                                                                                                        " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORIGENDEDATOS                           " atributo="DESCRIPCION                             " tabla="ORDAT          " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="405" etiqueta="Detalle Ori.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join ORDAT On COMPCAJA.ORIGDEST = ORDAT.codigo And  ORDAT.CODIGO != ''                                                                                                                                                                                  " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONCEPTOCAJA                            " atributo="DESCRIPCION                             " tabla="CONCECAJA      " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="9" etiqueta="Detalle Con.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CONCECAJA On COMPCAJA.CONCEPTO = CONCECAJA.Codigo And  CONCECAJA.CODIGO != ''                                                                                                                                                                      " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAJAESTADO                              " atributo="DESCRIPCION                             " tabla="CAJAESTA       " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="13" etiqueta="Detalle Caj.                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CAJAESTA On COMPCAJA.CAJAORIG = CAJAESTA.NumCaja And  CAJAESTA.NUMCAJA != 0                                                                                                                                                                        " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAJAESTADO                              " atributo="DESCRIPCION                             " tabla="CAJAESTA       " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="407" etiqueta="Detalle Caj.                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CAJAESTA On COMPCAJA.CAJADEST = CAJAESTA.NumCaja And  CAJAESTA.NUMCAJA != 0                                                                                                                                                                        " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VENDEDOR                                " atributo="NOMBRE                                  " tabla="VEN            " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="409" etiqueta="Detalle Ven.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join VEN On COMPCAJA.VENDEDOR = VEN.CLCOD And  VEN.CLCOD != ''                                                                                                                                                                                          " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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