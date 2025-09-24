
define class Din_EntidadPAGOAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_PAGO'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = [str( TipoComprobante, 2, 0) + Letra + str( PuntoDeVenta, 4, 0) + str( Numero, 10, 0)]
	cExpresionCCPorCampos = [str( #tabla#.FACTTIPO, 2, 0) + #tabla#.FLETRA + str( #tabla#.FPTOVEN, 4, 0) + str( #tabla#.FNUMCOMP, 10, 0)]
	cTagClaveCandidata = '_PAGCC'
	cTagClavePk = '_PAGPK'
	cTablaPrincipal = 'PAGO'
	cCampoCodigoWH = 'CODIGO'
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
			local  lxPagoFmodifw, lxPagoFecexpo, lxPagoFectrans, lxPagoFecimpo, lxPagoHoraimpo, lxPagoHoraexpo, lxPagoSaltafw, lxPagoHmodifw, lxPagoZadsfw, lxPagoDescfw, lxPagoVmodifw, lxPagoValtafw, lxPagoUaltafw, lxPagoUmodifw, lxPagoSmodifw, lxPagoHaltafw, lxPagoEsttrans, lxPagoFaltafw, lxPagoBdaltafw, lxPagoBdmodifw, lxPagoTimestamp, lxPagoFacttipo, lxPagoOpago, lxPagoFletra, lxPagoFperson, lxPagoFptoven, lxPagoMoneda, lxPagoFopobs, lxPagoFfch, lxPagoFnumcomp, lxPagoFechap, lxPagoCotiz, lxPagoRecibo, lxPagoFtotal, lxPagoAnulado, lxPagoFobs, lxPagoCodigo
				lxPagoFmodifw =  .Fechamodificacionfw			lxPagoFecexpo =  .Fechaexpo			lxPagoFectrans =  .Fechatransferencia			lxPagoFecimpo =  .Fechaimpo			lxPagoHoraimpo =  .Horaimpo			lxPagoHoraexpo =  .Horaexpo			lxPagoSaltafw =  .Seriealtafw			lxPagoHmodifw =  .Horamodificacionfw			lxPagoZadsfw =  .Zadsfw			lxPagoDescfw =  .Descripcionfw			lxPagoVmodifw =  .Versionmodificacionfw			lxPagoValtafw =  .Versionaltafw			lxPagoUaltafw =  .Usuarioaltafw			lxPagoUmodifw =  .Usuariomodificacionfw			lxPagoSmodifw =  .Seriemodificacionfw			lxPagoHaltafw =  .Horaaltafw			lxPagoEsttrans =  .Estadotransferencia			lxPagoFaltafw =  .Fechaaltafw			lxPagoBdaltafw =  .Basededatosaltafw			lxPagoBdmodifw =  .Basededatosmodificacionfw			lxPagoTimestamp = goLibrerias.ObtenerTimestamp()			lxPagoFacttipo =  .Tipocomprobante			lxPagoOpago =  upper( .OrdenDePago_PK ) 			lxPagoFletra =  .Letra			lxPagoFperson =  upper( .OrdenDePago_Proveedor_PK ) 			lxPagoFptoven =  .Puntodeventa			lxPagoMoneda =  upper( .OrdenDePago_MonedaComprobante_PK ) 			lxPagoFopobs =  .Ordendepago_obs			lxPagoFfch =  .Ordendepago_fecha			lxPagoFnumcomp =  .Numero			lxPagoFechap =  .Fecha			lxPagoCotiz =  .Ordendepago_cotizacion			lxPagoRecibo =  .Recibo			lxPagoFtotal =  .Ordendepago_total			lxPagoAnulado =  .Anulado			lxPagoFobs =  .Observacion			lxPagoCodigo =  .Codigo
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxPagoCodigo = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.PAGO ( "Fmodifw","Fecexpo","Fectrans","Fecimpo","Horaimpo","Horaexpo","Saltafw","Hmodifw","Zadsfw","Descfw","Vmodifw","Valtafw","Ualtafw","Umodifw","Smodifw","Haltafw","Esttrans","Faltafw","Bdaltafw","Bdmodifw","Timestamp","Facttipo","Opago","Fletra","Fperson","Fptoven","Moneda","Fopobs","Ffch","Fnumcomp","Fechap","Cotiz","Recibo","Ftotal","Anulado","Fobs","Codigo" ) values ( <<"'" + this.ConvertirDateSql( lxPagoFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxPagoFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxPagoFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxPagoFecimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPagoHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPagoHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPagoSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPagoHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPagoZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPagoDescfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPagoVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPagoValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPagoUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPagoUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPagoSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPagoHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPagoEsttrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxPagoFaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPagoBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPagoBdmodifw ) + "'" >>, <<lxPagoTimestamp >>, <<lxPagoFacttipo >>, <<"'" + this.FormatearTextoSql( lxPagoOpago ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPagoFletra ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPagoFperson ) + "'" >>, <<lxPagoFptoven >>, <<"'" + this.FormatearTextoSql( lxPagoMoneda ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPagoFopobs ) + "'" >>, <<"'" + this.ConvertirDateSql( lxPagoFfch ) + "'" >>, <<lxPagoFnumcomp >>, <<"'" + this.ConvertirDateSql( lxPagoFechap ) + "'" >>, <<lxPagoCotiz >>, <<"'" + this.FormatearTextoSql( lxPagoRecibo ) + "'" >>, <<lxPagoFtotal >>, <<iif( lxPagoAnulado, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxPagoFobs ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPagoCodigo ) + "'" >> )
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
			for each loItem in this.oEntidad.OrdenDePago_PagoDetalle
				if this.oEntidad.OrdenDePago_PagoDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxFecha = loItem.Fecha
					lxCaja_PK = loItem.Caja_PK
					lxCodigocomprobante = loItem.Codigocomprobante
					lxTipodecomprobante = loItem.Tipodecomprobante
					lxLetra = loItem.Letra
					lxNumerodecomprobante = loItem.Numerodecomprobante
					lxNroitem = lnContadorNroItem
					lxTipo = loItem.Tipo
					lxPuntodeventa = loItem.Puntodeventa
					lxEspagoacuenta = loItem.Espagoacuenta
					lxValor_PK = loItem.Valor_PK
					lxEmision = loItem.Emision
					lxVencimiento = loItem.Vencimiento
					lxDescripcion = loItem.Descripcion
					lxAnotacion = loItem.Anotacion
					lxSaldoaux = loItem.Saldoaux
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.PagoDet("Fecha","IdCaja","CodComp","Tipo","LetraAfec","Numafec","NROITEM","Rtipo","PtoAfec","lPagoACta","RVal","CODIGO","FecEmi","RFecVen","Descrip","anotacion","SaldoAux","RMonto" ) values ( <<"'" + this.ConvertirDateSql( lxFecha ) + "'">>, <<lxCaja_PK>>, <<"'" + this.FormatearTextoSql( lxCodigocomprobante ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipodecomprobante ) + "'">>, <<"'" + this.FormatearTextoSql( lxLetra ) + "'">>, <<lxNumerodecomprobante>>, <<lxNroitem>>, <<lxTipo>>, <<lxPuntodeventa>>, <<iif( lxEspagoacuenta, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxValor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.ConvertirDateSql( lxEmision ) + "'">>, <<"'" + this.ConvertirDateSql( lxVencimiento ) + "'">>, <<"'" + this.FormatearTextoSql( lxDescripcion ) + "'">>, <<"'" + this.FormatearTextoSql( lxAnotacion ) + "'">>, <<lxSaldoaux>>, <<lxMonto>> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.OrdenDePago_ValoresDetalle
				if this.oEntidad.OrdenDePago_ValoresDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxFechaultcotizacion = loItem.Fechaultcotizacion
					lxFechacomp = loItem.Fechacomp
					lxCaja_PK = loItem.Caja_PK
					lxTipodocumento = loItem.Tipodocumento
					lxVendedor = loItem.Vendedor
					lxNumerotarjeta = loItem.Numerotarjeta
					lxTipodecomprobante = loItem.Tipodecomprobante
					lxLetra = loItem.Letra
					lxNrodocumento = loItem.Nrodocumento
					lxUltimacotizacion = loItem.Ultimacotizacion
					lxNumerocupon = loItem.Numerocupon
					lxCotiza = loItem.Cotiza
					lxNroitem = lnContadorNroItem
					lxSigno = loItem.Signo
					lxNumerodecomprobante = loItem.Numerodecomprobante
					lxPesosalcambio = loItem.Pesosalcambio
					lxTipo = loItem.Tipo
					lxPuntodeventa = loItem.Puntodeventa
					lxTurno = loItem.Turno
					lxVisualizarenestadodecaja = loItem.Visualizarenestadodecaja
					lxChequeelectronico = loItem.Chequeelectronico
					lxPersonalizarcomprobante = loItem.Personalizarcomprobante
					lxNumerochequepropio_PK = loItem.Numerochequepropio_PK
					lxNumerocheque_PK = loItem.Numerocheque_PK
					lxValor_PK = loItem.Valor_PK
					lxValordetalle = loItem.Valordetalle
					lxFecha = loItem.Fecha
					lxNumerointerno = loItem.Numerointerno
					lxMonto = loItem.Monto
					lxRecargoporcentaje = loItem.Recargoporcentaje
					lxRecargomonto = loItem.Recargomonto
					lxTotal = loItem.Total
					lxRecargomontosinimpuestos = loItem.Recargomontosinimpuestos
					lxRecargosinpercepciones = loItem.Recargosinpercepciones
					lxIditemcomponente = loItem.Iditemcomponente
					lxPermitevuelto = loItem.Permitevuelto
					lxNumerovaledecambio_PK = loItem.Numerovaledecambio_PK
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.PagoVal("FechCoti","JJfecha","IdCaja","TipoDoc","JJVen","NroTarjeta","TIPCOMP","Letra","NroDoc","Cotiza","NroCupon","JJCotiz","NroItem","Signo","NumCompr","Pesos","JJT","PtoVenta","JJTurno","VisualCaja","CElectro","PersComp","NroChProp","JJNUM","NroCheque","JJCO","JJDE","JJFE","NroInterno","JJM","jrecporc","jrecmnt","JJTotFac","jrecmntsi","jrrecsperc","guidComp","permvuelto","ValeCambio" ) values ( <<"'" + this.ConvertirDateSql( lxFechaultcotizacion ) + "'">>, <<"'" + this.ConvertirDateSql( lxFechacomp ) + "'">>, <<lxCaja_PK>>, <<"'" + this.FormatearTextoSql( lxTipodocumento ) + "'">>, <<"'" + this.FormatearTextoSql( lxVendedor ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerotarjeta ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipodecomprobante ) + "'">>, <<"'" + this.FormatearTextoSql( lxLetra ) + "'">>, <<"'" + this.FormatearTextoSql( lxNrodocumento ) + "'">>, <<lxUltimacotizacion>>, <<lxNumerocupon>>, <<lxCotiza>>, <<lxNroitem>>, <<lxSigno>>, <<lxNumerodecomprobante>>, <<lxPesosalcambio>>, <<lxTipo>>, <<lxPuntodeventa>>, <<lxTurno>>, <<iif( lxVisualizarenestadodecaja, 1, 0 )>>, <<iif( lxChequeelectronico, 1, 0 )>>, <<iif( lxPersonalizarcomprobante, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxNumerochequepropio_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerocheque_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValordetalle ) + "'">>, <<"'" + this.ConvertirDateSql( lxFecha ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerointerno ) + "'">>, <<lxMonto>>, <<lxRecargoporcentaje>>, <<lxRecargomonto>>, <<lxTotal>>, <<lxRecargomontosinimpuestos>>, <<lxRecargosinpercepciones>>, <<"'" + this.FormatearTextoSql( lxIditemcomponente ) + "'">>, <<iif( lxPermitevuelto, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxNumerovaledecambio_PK ) + "'">> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.OrdenDePago_ImpuestosComprobante
				if this.oEntidad.OrdenDePago_ImpuestosComprobante.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxCodimp_PK = loItem.Codimp_PK
					lxCodimpdetalle = loItem.Codimpdetalle
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.PagoImp("NROITEM","Codigo","CodImp","Descri","Monto" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodimp_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodimpdetalle ) + "'">>, <<lxMonto>> ) 
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
		this.oEntidad.Timestamp = lxPagoTimestamp
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
			local  lxPagoFmodifw, lxPagoFecexpo, lxPagoFectrans, lxPagoFecimpo, lxPagoHoraimpo, lxPagoHoraexpo, lxPagoSaltafw, lxPagoHmodifw, lxPagoZadsfw, lxPagoDescfw, lxPagoVmodifw, lxPagoValtafw, lxPagoUaltafw, lxPagoUmodifw, lxPagoSmodifw, lxPagoHaltafw, lxPagoEsttrans, lxPagoFaltafw, lxPagoBdaltafw, lxPagoBdmodifw, lxPagoTimestamp, lxPagoFacttipo, lxPagoOpago, lxPagoFletra, lxPagoFperson, lxPagoFptoven, lxPagoMoneda, lxPagoFopobs, lxPagoFfch, lxPagoFnumcomp, lxPagoFechap, lxPagoCotiz, lxPagoRecibo, lxPagoFtotal, lxPagoAnulado, lxPagoFobs, lxPagoCodigo
				lxPagoFmodifw =  .Fechamodificacionfw			lxPagoFecexpo =  .Fechaexpo			lxPagoFectrans =  .Fechatransferencia			lxPagoFecimpo =  .Fechaimpo			lxPagoHoraimpo =  .Horaimpo			lxPagoHoraexpo =  .Horaexpo			lxPagoSaltafw =  .Seriealtafw			lxPagoHmodifw =  .Horamodificacionfw			lxPagoZadsfw =  .Zadsfw			lxPagoDescfw =  .Descripcionfw			lxPagoVmodifw =  .Versionmodificacionfw			lxPagoValtafw =  .Versionaltafw			lxPagoUaltafw =  .Usuarioaltafw			lxPagoUmodifw =  .Usuariomodificacionfw			lxPagoSmodifw =  .Seriemodificacionfw			lxPagoHaltafw =  .Horaaltafw			lxPagoEsttrans =  .Estadotransferencia			lxPagoFaltafw =  .Fechaaltafw			lxPagoBdaltafw =  .Basededatosaltafw			lxPagoBdmodifw =  .Basededatosmodificacionfw			lxPagoTimestamp = goLibrerias.ObtenerTimestamp()			lxPagoFacttipo =  .Tipocomprobante			lxPagoOpago =  upper( .OrdenDePago_PK ) 			lxPagoFletra =  .Letra			lxPagoFperson =  upper( .OrdenDePago_Proveedor_PK ) 			lxPagoFptoven =  .Puntodeventa			lxPagoMoneda =  upper( .OrdenDePago_MonedaComprobante_PK ) 			lxPagoFopobs =  .Ordendepago_obs			lxPagoFfch =  .Ordendepago_fecha			lxPagoFnumcomp =  .Numero			lxPagoFechap =  .Fecha			lxPagoCotiz =  .Ordendepago_cotizacion			lxPagoRecibo =  .Recibo			lxPagoFtotal =  .Ordendepago_total			lxPagoAnulado =  .Anulado			lxPagoFobs =  .Observacion			lxPagoCodigo =  .Codigo
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
				update ZooLogic.PAGO set "Fmodifw" = <<"'" + this.ConvertirDateSql( lxPagoFmodifw ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxPagoFecexpo ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxPagoFectrans ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxPagoFecimpo ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxPagoHoraimpo ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxPagoHoraexpo ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxPagoSaltafw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxPagoHmodifw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxPagoZadsfw ) + "'">>,"Descfw" = <<"'" + this.FormatearTextoSql( lxPagoDescfw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxPagoVmodifw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxPagoValtafw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxPagoUaltafw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxPagoUmodifw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxPagoSmodifw ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxPagoHaltafw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxPagoEsttrans ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxPagoFaltafw ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxPagoBdaltafw ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxPagoBdmodifw ) + "'">>,"Timestamp" = <<lxPagoTimestamp>>,"Facttipo" = <<lxPagoFacttipo>>,"Opago" = <<"'" + this.FormatearTextoSql( lxPagoOpago ) + "'">>,"Fletra" = <<"'" + this.FormatearTextoSql( lxPagoFletra ) + "'">>,"Fperson" = <<"'" + this.FormatearTextoSql( lxPagoFperson ) + "'">>,"Fptoven" = <<lxPagoFptoven>>,"Moneda" = <<"'" + this.FormatearTextoSql( lxPagoMoneda ) + "'">>,"Fopobs" = <<"'" + this.FormatearTextoSql( lxPagoFopobs ) + "'">>,"Ffch" = <<"'" + this.ConvertirDateSql( lxPagoFfch ) + "'">>,"Fnumcomp" = <<lxPagoFnumcomp>>,"Fechap" = <<"'" + this.ConvertirDateSql( lxPagoFechap ) + "'">>,"Cotiz" = <<lxPagoCotiz>>,"Recibo" = <<"'" + this.FormatearTextoSql( lxPagoRecibo ) + "'">>,"Ftotal" = <<lxPagoFtotal>>,"Anulado" = <<iif( lxPagoAnulado, 1, 0 )>>,"Fobs" = <<"'" + this.FormatearTextoSql( lxPagoFobs ) + "'">>,"Codigo" = <<"'" + this.FormatearTextoSql( lxPagoCodigo ) + "'">> where "Codigo" = <<"'" + this.FormatearTextoSql( lxPagoCodigo ) + "'">> and  PAGO.CODIGO != '' AND PAGO.FACTTIPO = 37 << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			this.ComprobarResultadoDeEjecucionDelUpdate()
		this.ComprobarTransaccion()
			.EjecutarSentencias( This.ColSentencias )
		this.ComprobarTransaccion()
			this.oConexion.EjecutarSql( 'delete from ZooLogic.PagoDet where "CODIGO" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.PagoVal where "JJNUM" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.PagoImp where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.OrdenDePago_PagoDetalle
				if this.oEntidad.OrdenDePago_PagoDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxFecha = loItem.Fecha
					lxCaja_PK = loItem.Caja_PK
					lxCodigocomprobante = loItem.Codigocomprobante
					lxTipodecomprobante = loItem.Tipodecomprobante
					lxLetra = loItem.Letra
					lxNumerodecomprobante = loItem.Numerodecomprobante
					lxNroitem = lnContadorNroItem
					lxTipo = loItem.Tipo
					lxPuntodeventa = loItem.Puntodeventa
					lxEspagoacuenta = loItem.Espagoacuenta
					lxValor_PK = loItem.Valor_PK
					lxEmision = loItem.Emision
					lxVencimiento = loItem.Vencimiento
					lxDescripcion = loItem.Descripcion
					lxAnotacion = loItem.Anotacion
					lxSaldoaux = loItem.Saldoaux
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.PagoDet("Fecha","IdCaja","CodComp","Tipo","LetraAfec","Numafec","NROITEM","Rtipo","PtoAfec","lPagoACta","RVal","CODIGO","FecEmi","RFecVen","Descrip","anotacion","SaldoAux","RMonto" ) values ( <<"'" + this.ConvertirDateSql( lxFecha ) + "'">>, <<lxCaja_PK>>, <<"'" + this.FormatearTextoSql( lxCodigocomprobante ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipodecomprobante ) + "'">>, <<"'" + this.FormatearTextoSql( lxLetra ) + "'">>, <<lxNumerodecomprobante>>, <<lxNroitem>>, <<lxTipo>>, <<lxPuntodeventa>>, <<iif( lxEspagoacuenta, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxValor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.ConvertirDateSql( lxEmision ) + "'">>, <<"'" + this.ConvertirDateSql( lxVencimiento ) + "'">>, <<"'" + this.FormatearTextoSql( lxDescripcion ) + "'">>, <<"'" + this.FormatearTextoSql( lxAnotacion ) + "'">>, <<lxSaldoaux>>, <<lxMonto>> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.OrdenDePago_ValoresDetalle
				if this.oEntidad.OrdenDePago_ValoresDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxFechaultcotizacion = loItem.Fechaultcotizacion
					lxFechacomp = loItem.Fechacomp
					lxCaja_PK = loItem.Caja_PK
					lxTipodocumento = loItem.Tipodocumento
					lxVendedor = loItem.Vendedor
					lxNumerotarjeta = loItem.Numerotarjeta
					lxTipodecomprobante = loItem.Tipodecomprobante
					lxLetra = loItem.Letra
					lxNrodocumento = loItem.Nrodocumento
					lxUltimacotizacion = loItem.Ultimacotizacion
					lxNumerocupon = loItem.Numerocupon
					lxCotiza = loItem.Cotiza
					lxNroitem = lnContadorNroItem
					lxSigno = loItem.Signo
					lxNumerodecomprobante = loItem.Numerodecomprobante
					lxPesosalcambio = loItem.Pesosalcambio
					lxTipo = loItem.Tipo
					lxPuntodeventa = loItem.Puntodeventa
					lxTurno = loItem.Turno
					lxVisualizarenestadodecaja = loItem.Visualizarenestadodecaja
					lxChequeelectronico = loItem.Chequeelectronico
					lxPersonalizarcomprobante = loItem.Personalizarcomprobante
					lxNumerochequepropio_PK = loItem.Numerochequepropio_PK
					lxNumerocheque_PK = loItem.Numerocheque_PK
					lxValor_PK = loItem.Valor_PK
					lxValordetalle = loItem.Valordetalle
					lxFecha = loItem.Fecha
					lxNumerointerno = loItem.Numerointerno
					lxMonto = loItem.Monto
					lxRecargoporcentaje = loItem.Recargoporcentaje
					lxRecargomonto = loItem.Recargomonto
					lxTotal = loItem.Total
					lxRecargomontosinimpuestos = loItem.Recargomontosinimpuestos
					lxRecargosinpercepciones = loItem.Recargosinpercepciones
					lxIditemcomponente = loItem.Iditemcomponente
					lxPermitevuelto = loItem.Permitevuelto
					lxNumerovaledecambio_PK = loItem.Numerovaledecambio_PK
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.PagoVal("FechCoti","JJfecha","IdCaja","TipoDoc","JJVen","NroTarjeta","TIPCOMP","Letra","NroDoc","Cotiza","NroCupon","JJCotiz","NroItem","Signo","NumCompr","Pesos","JJT","PtoVenta","JJTurno","VisualCaja","CElectro","PersComp","NroChProp","JJNUM","NroCheque","JJCO","JJDE","JJFE","NroInterno","JJM","jrecporc","jrecmnt","JJTotFac","jrecmntsi","jrrecsperc","guidComp","permvuelto","ValeCambio" ) values ( <<"'" + this.ConvertirDateSql( lxFechaultcotizacion ) + "'">>, <<"'" + this.ConvertirDateSql( lxFechacomp ) + "'">>, <<lxCaja_PK>>, <<"'" + this.FormatearTextoSql( lxTipodocumento ) + "'">>, <<"'" + this.FormatearTextoSql( lxVendedor ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerotarjeta ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipodecomprobante ) + "'">>, <<"'" + this.FormatearTextoSql( lxLetra ) + "'">>, <<"'" + this.FormatearTextoSql( lxNrodocumento ) + "'">>, <<lxUltimacotizacion>>, <<lxNumerocupon>>, <<lxCotiza>>, <<lxNroitem>>, <<lxSigno>>, <<lxNumerodecomprobante>>, <<lxPesosalcambio>>, <<lxTipo>>, <<lxPuntodeventa>>, <<lxTurno>>, <<iif( lxVisualizarenestadodecaja, 1, 0 )>>, <<iif( lxChequeelectronico, 1, 0 )>>, <<iif( lxPersonalizarcomprobante, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxNumerochequepropio_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerocheque_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValordetalle ) + "'">>, <<"'" + this.ConvertirDateSql( lxFecha ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerointerno ) + "'">>, <<lxMonto>>, <<lxRecargoporcentaje>>, <<lxRecargomonto>>, <<lxTotal>>, <<lxRecargomontosinimpuestos>>, <<lxRecargosinpercepciones>>, <<"'" + this.FormatearTextoSql( lxIditemcomponente ) + "'">>, <<iif( lxPermitevuelto, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxNumerovaledecambio_PK ) + "'">> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.OrdenDePago_ImpuestosComprobante
				if this.oEntidad.OrdenDePago_ImpuestosComprobante.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxCodimp_PK = loItem.Codimp_PK
					lxCodimpdetalle = loItem.Codimpdetalle
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.PagoImp("NROITEM","Codigo","CodImp","Descri","Monto" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodimp_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodimpdetalle ) + "'">>, <<lxMonto>> ) 
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
		this.oEntidad.Timestamp = lxPagoTimestamp
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 CODIGO from ZooLogic.PAGO where " + this.ConvertirFuncionesSql( " PAGO.CODIGO != '' AND PAGO.FACTTIPO = 37" ) )
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
			Local lxPagoCodigo
			lxPagoCodigo = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Zadsfw" as "Zadsfw", "Descfw" as "Descripcionfw", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Haltafw" as "Horaaltafw", "Esttrans" as "Estadotransferencia", "Faltafw" as "Fechaaltafw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Timestamp" as "Timestamp", "Facttipo" as "Tipocomprobante", "Opago" as "Ordendepago", "Fletra" as "Letra", "Fperson" as "Ordendepago_proveedor", "Fptoven" as "Puntodeventa", "Moneda" as "Ordendepago_monedacomprobante", "Fopobs" as "Ordendepago_obs", "Ffch" as "Ordendepago_fecha", "Fnumcomp" as "Numero", "Fechap" as "Fecha", "Cotiz" as "Ordendepago_cotizacion", "Recibo" as "Recibo", "Ftotal" as "Ordendepago_total", "Anulado" as "Anulado", "Fobs" as "Observacion", "Codigo" as "Codigo" from ZooLogic.PAGO where "Codigo" = <<"'" + this.FormatearTextoSql( lxPagoCodigo ) + "'">> and  PAGO.CODIGO != '' AND PAGO.FACTTIPO = 37
			endtext
			use in select('c_PAGO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_PAGO', set( 'Datasession' ) )

			if reccount( 'c_PAGO' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecha" as "Fecha", "Idcaja" as "Caja", "Codcomp" as "Codigocomprobante", "Tipo" as "Tipodecomprobante", "Letraafec" as "Letra", "Numafec" as "Numerodecomprobante", "Nroitem" as "Nroitem", "Rtipo" as "Tipo", "Ptoafec" as "Puntodeventa", "Lpagoacta" as "Espagoacuenta", "Rval" as "Valor", "Codigo" as "Codigo", "Fecemi" as "Emision", "Rfecven" as "Vencimiento", "Descrip" as "Descripcion", "Anotacion" as "Anotacion", "Saldoaux" as "Saldoaux", "Rmonto" as "Monto" from ZooLogic.PagoDet where CODIGO = <<"'" + this.FormatearTextoSql( c_PAGO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_OrdenDePago_PagoDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_OrdenDePago_PagoDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_OrdenDePago_PagoDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fechcoti" as "Fechaultcotizacion", "Jjfecha" as "Fechacomp", "Idcaja" as "Caja", "Tipodoc" as "Tipodocumento", "Jjven" as "Vendedor", "Nrotarjeta" as "Numerotarjeta", "Tipcomp" as "Tipodecomprobante", "Letra" as "Letra", "Nrodoc" as "Nrodocumento", "Cotiza" as "Ultimacotizacion", "Nrocupon" as "Numerocupon", "Jjcotiz" as "Cotiza", "Nroitem" as "Nroitem", "Signo" as "Signo", "Numcompr" as "Numerodecomprobante", "Pesos" as "Pesosalcambio", "Jjt" as "Tipo", "Ptoventa" as "Puntodeventa", "Jjturno" as "Turno", "Visualcaja" as "Visualizarenestadodecaja", "Celectro" as "Chequeelectronico", "Perscomp" as "Personalizarcomprobante", "Nrochprop" as "Numerochequepropio", "Jjnum" as "Codigo", "Nrocheque" as "Numerocheque", "Jjco" as "Valor", "Jjde" as "Valordetalle", "Jjfe" as "Fecha", "Nrointerno" as "Numerointerno", "Jjm" as "Monto", "Jrecporc" as "Recargoporcentaje", "Jrecmnt" as "Recargomonto", "Jjtotfac" as "Total", "Jrecmntsi" as "Recargomontosinimpuestos", "Jrrecsperc" as "Recargosinpercepciones", "Guidcomp" as "Iditemcomponente", "Permvuelto" as "Permitevuelto", "Valecambio" as "Numerovaledecambio" from ZooLogic.PagoVal where JJNUM = <<"'" + this.FormatearTextoSql( c_PAGO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_OrdenDePago_ValoresDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_OrdenDePago_ValoresDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_OrdenDePago_ValoresDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Codimp" as "Codimp", "Descri" as "Codimpdetalle", "Monto" as "Monto" from ZooLogic.PagoImp where Codigo = <<"'" + this.FormatearTextoSql( c_PAGO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_OrdenDePago_ImpuestosComprobante')
			this.oConexion.EjecutarSql( lcSentencia, 'c_OrdenDePago_ImpuestosComprobante', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_OrdenDePago_ImpuestosComprobante
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ConsultarPorClaveCandidata() as Boolean
		local llRetorno as Boolean
		llRetorno = .t.
		with this.oEntidad
			Local lxPagoFACTTIPO As Variant, lxPagoFLETRA As Variant, lxPagoFPTOVEN As Variant, lxPagoFNUMCOMP As Variant
			lxPagoFACTTIPO = .TipoComprobante
			lxPagoFLETRA = .Letra
			lxPagoFPTOVEN = .PuntoDeVenta
			lxPagoFNUMCOMP = .Numero
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Zadsfw" as "Zadsfw", "Descfw" as "Descripcionfw", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Haltafw" as "Horaaltafw", "Esttrans" as "Estadotransferencia", "Faltafw" as "Fechaaltafw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Timestamp" as "Timestamp", "Facttipo" as "Tipocomprobante", "Opago" as "Ordendepago", "Fletra" as "Letra", "Fperson" as "Ordendepago_proveedor", "Fptoven" as "Puntodeventa", "Moneda" as "Ordendepago_monedacomprobante", "Fopobs" as "Ordendepago_obs", "Ffch" as "Ordendepago_fecha", "Fnumcomp" as "Numero", "Fechap" as "Fecha", "Cotiz" as "Ordendepago_cotizacion", "Recibo" as "Recibo", "Ftotal" as "Ordendepago_total", "Anulado" as "Anulado", "Fobs" as "Observacion", "Codigo" as "Codigo" from ZooLogic.PAGO where  PAGO.CODIGO != '' AND PAGO.FACTTIPO = 37 And FACTTIPO = <<lxPagoFACTTIPO>> and FLETRA = <<"'" + this.FormatearTextoSql( lxPagoFLETRA ) + "'">> and FPTOVEN = <<lxPagoFPTOVEN>> and FNUMCOMP = <<lxPagoFNUMCOMP>>
			endtext
			use in select('c_PAGO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_PAGO', set( 'Datasession' ) )
			if reccount( 'c_PAGO' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecha" as "Fecha", "Idcaja" as "Caja", "Codcomp" as "Codigocomprobante", "Tipo" as "Tipodecomprobante", "Letraafec" as "Letra", "Numafec" as "Numerodecomprobante", "Nroitem" as "Nroitem", "Rtipo" as "Tipo", "Ptoafec" as "Puntodeventa", "Lpagoacta" as "Espagoacuenta", "Rval" as "Valor", "Codigo" as "Codigo", "Fecemi" as "Emision", "Rfecven" as "Vencimiento", "Descrip" as "Descripcion", "Anotacion" as "Anotacion", "Saldoaux" as "Saldoaux", "Rmonto" as "Monto" from ZooLogic.PagoDet where CODIGO = <<"'" + this.FormatearTextoSql( c_PAGO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_OrdenDePago_PagoDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_OrdenDePago_PagoDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_OrdenDePago_PagoDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fechcoti" as "Fechaultcotizacion", "Jjfecha" as "Fechacomp", "Idcaja" as "Caja", "Tipodoc" as "Tipodocumento", "Jjven" as "Vendedor", "Nrotarjeta" as "Numerotarjeta", "Tipcomp" as "Tipodecomprobante", "Letra" as "Letra", "Nrodoc" as "Nrodocumento", "Cotiza" as "Ultimacotizacion", "Nrocupon" as "Numerocupon", "Jjcotiz" as "Cotiza", "Nroitem" as "Nroitem", "Signo" as "Signo", "Numcompr" as "Numerodecomprobante", "Pesos" as "Pesosalcambio", "Jjt" as "Tipo", "Ptoventa" as "Puntodeventa", "Jjturno" as "Turno", "Visualcaja" as "Visualizarenestadodecaja", "Celectro" as "Chequeelectronico", "Perscomp" as "Personalizarcomprobante", "Nrochprop" as "Numerochequepropio", "Jjnum" as "Codigo", "Nrocheque" as "Numerocheque", "Jjco" as "Valor", "Jjde" as "Valordetalle", "Jjfe" as "Fecha", "Nrointerno" as "Numerointerno", "Jjm" as "Monto", "Jrecporc" as "Recargoporcentaje", "Jrecmnt" as "Recargomonto", "Jjtotfac" as "Total", "Jrecmntsi" as "Recargomontosinimpuestos", "Jrrecsperc" as "Recargosinpercepciones", "Guidcomp" as "Iditemcomponente", "Permvuelto" as "Permitevuelto", "Valecambio" as "Numerovaledecambio" from ZooLogic.PagoVal where JJNUM = <<"'" + this.FormatearTextoSql( c_PAGO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_OrdenDePago_ValoresDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_OrdenDePago_ValoresDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_OrdenDePago_ValoresDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Codimp" as "Codimp", "Descri" as "Codimpdetalle", "Monto" as "Monto" from ZooLogic.PagoImp where Codigo = <<"'" + this.FormatearTextoSql( c_PAGO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_OrdenDePago_ImpuestosComprobante')
			this.oConexion.EjecutarSql( lcSentencia, 'c_OrdenDePago_ImpuestosComprobante', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_OrdenDePago_ImpuestosComprobante
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxPagoCodigo as Variant
		llRetorno = .t.
		lxPagoCodigo = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.PAGO where "Codigo" = <<"'" + this.FormatearTextoSql( lxPagoCodigo ) + "'">> and  PAGO.CODIGO != '' AND PAGO.FACTTIPO = 37
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
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Zadsfw" as "Zadsfw", "Descfw" as "Descripcionfw", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Haltafw" as "Horaaltafw", "Esttrans" as "Estadotransferencia", "Faltafw" as "Fechaaltafw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Timestamp" as "Timestamp", "Facttipo" as "Tipocomprobante", "Opago" as "Ordendepago", "Fletra" as "Letra", "Fperson" as "Ordendepago_proveedor", "Fptoven" as "Puntodeventa", "Moneda" as "Ordendepago_monedacomprobante", "Fopobs" as "Ordendepago_obs", "Ffch" as "Ordendepago_fecha", "Fnumcomp" as "Numero", "Fechap" as "Fecha", "Cotiz" as "Ordendepago_cotizacion", "Recibo" as "Recibo", "Ftotal" as "Ordendepago_total", "Anulado" as "Anulado", "Fobs" as "Observacion", "Codigo" as "Codigo" from ZooLogic.PAGO where  PAGO.CODIGO != '' AND PAGO.FACTTIPO = 37 order by FAltaFW,HAltaFW,CODIGO
			endtext
			use in select('c_PAGO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_PAGO', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecha" as "Fecha", "Idcaja" as "Caja", "Codcomp" as "Codigocomprobante", "Tipo" as "Tipodecomprobante", "Letraafec" as "Letra", "Numafec" as "Numerodecomprobante", "Nroitem" as "Nroitem", "Rtipo" as "Tipo", "Ptoafec" as "Puntodeventa", "Lpagoacta" as "Espagoacuenta", "Rval" as "Valor", "Codigo" as "Codigo", "Fecemi" as "Emision", "Rfecven" as "Vencimiento", "Descrip" as "Descripcion", "Anotacion" as "Anotacion", "Saldoaux" as "Saldoaux", "Rmonto" as "Monto" from ZooLogic.PagoDet where CODIGO = <<"'" + this.FormatearTextoSql( c_PAGO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_OrdenDePago_PagoDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_OrdenDePago_PagoDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_OrdenDePago_PagoDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fechcoti" as "Fechaultcotizacion", "Jjfecha" as "Fechacomp", "Idcaja" as "Caja", "Tipodoc" as "Tipodocumento", "Jjven" as "Vendedor", "Nrotarjeta" as "Numerotarjeta", "Tipcomp" as "Tipodecomprobante", "Letra" as "Letra", "Nrodoc" as "Nrodocumento", "Cotiza" as "Ultimacotizacion", "Nrocupon" as "Numerocupon", "Jjcotiz" as "Cotiza", "Nroitem" as "Nroitem", "Signo" as "Signo", "Numcompr" as "Numerodecomprobante", "Pesos" as "Pesosalcambio", "Jjt" as "Tipo", "Ptoventa" as "Puntodeventa", "Jjturno" as "Turno", "Visualcaja" as "Visualizarenestadodecaja", "Celectro" as "Chequeelectronico", "Perscomp" as "Personalizarcomprobante", "Nrochprop" as "Numerochequepropio", "Jjnum" as "Codigo", "Nrocheque" as "Numerocheque", "Jjco" as "Valor", "Jjde" as "Valordetalle", "Jjfe" as "Fecha", "Nrointerno" as "Numerointerno", "Jjm" as "Monto", "Jrecporc" as "Recargoporcentaje", "Jrecmnt" as "Recargomonto", "Jjtotfac" as "Total", "Jrecmntsi" as "Recargomontosinimpuestos", "Jrrecsperc" as "Recargosinpercepciones", "Guidcomp" as "Iditemcomponente", "Permvuelto" as "Permitevuelto", "Valecambio" as "Numerovaledecambio" from ZooLogic.PagoVal where JJNUM = <<"'" + this.FormatearTextoSql( c_PAGO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_OrdenDePago_ValoresDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_OrdenDePago_ValoresDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_OrdenDePago_ValoresDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Codimp" as "Codimp", "Descri" as "Codimpdetalle", "Monto" as "Monto" from ZooLogic.PagoImp where Codigo = <<"'" + this.FormatearTextoSql( c_PAGO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_OrdenDePago_ImpuestosComprobante')
			this.oConexion.EjecutarSql( lcSentencia, 'c_OrdenDePago_ImpuestosComprobante', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_OrdenDePago_ImpuestosComprobante
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
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Zadsfw" as "Zadsfw", "Descfw" as "Descripcionfw", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Haltafw" as "Horaaltafw", "Esttrans" as "Estadotransferencia", "Faltafw" as "Fechaaltafw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Timestamp" as "Timestamp", "Facttipo" as "Tipocomprobante", "Opago" as "Ordendepago", "Fletra" as "Letra", "Fperson" as "Ordendepago_proveedor", "Fptoven" as "Puntodeventa", "Moneda" as "Ordendepago_monedacomprobante", "Fopobs" as "Ordendepago_obs", "Ffch" as "Ordendepago_fecha", "Fnumcomp" as "Numero", "Fechap" as "Fecha", "Cotiz" as "Ordendepago_cotizacion", "Recibo" as "Recibo", "Ftotal" as "Ordendepago_total", "Anulado" as "Anulado", "Fobs" as "Observacion", "Codigo" as "Codigo" from ZooLogic.PAGO where  funciones.dtos( FAltaFW ) + funciones.padr( HAltaFW, 8, ' ' ) + funciones.padr( CODIGO, 38, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  PAGO.CODIGO != '' AND PAGO.FACTTIPO = 37 order by FAltaFW,HAltaFW,CODIGO
			endtext
			use in select('c_PAGO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_PAGO', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecha" as "Fecha", "Idcaja" as "Caja", "Codcomp" as "Codigocomprobante", "Tipo" as "Tipodecomprobante", "Letraafec" as "Letra", "Numafec" as "Numerodecomprobante", "Nroitem" as "Nroitem", "Rtipo" as "Tipo", "Ptoafec" as "Puntodeventa", "Lpagoacta" as "Espagoacuenta", "Rval" as "Valor", "Codigo" as "Codigo", "Fecemi" as "Emision", "Rfecven" as "Vencimiento", "Descrip" as "Descripcion", "Anotacion" as "Anotacion", "Saldoaux" as "Saldoaux", "Rmonto" as "Monto" from ZooLogic.PagoDet where CODIGO = <<"'" + this.FormatearTextoSql( c_PAGO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_OrdenDePago_PagoDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_OrdenDePago_PagoDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_OrdenDePago_PagoDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fechcoti" as "Fechaultcotizacion", "Jjfecha" as "Fechacomp", "Idcaja" as "Caja", "Tipodoc" as "Tipodocumento", "Jjven" as "Vendedor", "Nrotarjeta" as "Numerotarjeta", "Tipcomp" as "Tipodecomprobante", "Letra" as "Letra", "Nrodoc" as "Nrodocumento", "Cotiza" as "Ultimacotizacion", "Nrocupon" as "Numerocupon", "Jjcotiz" as "Cotiza", "Nroitem" as "Nroitem", "Signo" as "Signo", "Numcompr" as "Numerodecomprobante", "Pesos" as "Pesosalcambio", "Jjt" as "Tipo", "Ptoventa" as "Puntodeventa", "Jjturno" as "Turno", "Visualcaja" as "Visualizarenestadodecaja", "Celectro" as "Chequeelectronico", "Perscomp" as "Personalizarcomprobante", "Nrochprop" as "Numerochequepropio", "Jjnum" as "Codigo", "Nrocheque" as "Numerocheque", "Jjco" as "Valor", "Jjde" as "Valordetalle", "Jjfe" as "Fecha", "Nrointerno" as "Numerointerno", "Jjm" as "Monto", "Jrecporc" as "Recargoporcentaje", "Jrecmnt" as "Recargomonto", "Jjtotfac" as "Total", "Jrecmntsi" as "Recargomontosinimpuestos", "Jrrecsperc" as "Recargosinpercepciones", "Guidcomp" as "Iditemcomponente", "Permvuelto" as "Permitevuelto", "Valecambio" as "Numerovaledecambio" from ZooLogic.PagoVal where JJNUM = <<"'" + this.FormatearTextoSql( c_PAGO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_OrdenDePago_ValoresDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_OrdenDePago_ValoresDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_OrdenDePago_ValoresDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Codimp" as "Codimp", "Descri" as "Codimpdetalle", "Monto" as "Monto" from ZooLogic.PagoImp where Codigo = <<"'" + this.FormatearTextoSql( c_PAGO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_OrdenDePago_ImpuestosComprobante')
			this.oConexion.EjecutarSql( lcSentencia, 'c_OrdenDePago_ImpuestosComprobante', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_OrdenDePago_ImpuestosComprobante
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
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Zadsfw" as "Zadsfw", "Descfw" as "Descripcionfw", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Haltafw" as "Horaaltafw", "Esttrans" as "Estadotransferencia", "Faltafw" as "Fechaaltafw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Timestamp" as "Timestamp", "Facttipo" as "Tipocomprobante", "Opago" as "Ordendepago", "Fletra" as "Letra", "Fperson" as "Ordendepago_proveedor", "Fptoven" as "Puntodeventa", "Moneda" as "Ordendepago_monedacomprobante", "Fopobs" as "Ordendepago_obs", "Ffch" as "Ordendepago_fecha", "Fnumcomp" as "Numero", "Fechap" as "Fecha", "Cotiz" as "Ordendepago_cotizacion", "Recibo" as "Recibo", "Ftotal" as "Ordendepago_total", "Anulado" as "Anulado", "Fobs" as "Observacion", "Codigo" as "Codigo" from ZooLogic.PAGO where  funciones.dtos( FAltaFW ) + funciones.padr( HAltaFW, 8, ' ' ) + funciones.padr( CODIGO, 38, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  PAGO.CODIGO != '' AND PAGO.FACTTIPO = 37 order by FAltaFW desc,HAltaFW desc,CODIGO desc
			endtext
			use in select('c_PAGO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_PAGO', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecha" as "Fecha", "Idcaja" as "Caja", "Codcomp" as "Codigocomprobante", "Tipo" as "Tipodecomprobante", "Letraafec" as "Letra", "Numafec" as "Numerodecomprobante", "Nroitem" as "Nroitem", "Rtipo" as "Tipo", "Ptoafec" as "Puntodeventa", "Lpagoacta" as "Espagoacuenta", "Rval" as "Valor", "Codigo" as "Codigo", "Fecemi" as "Emision", "Rfecven" as "Vencimiento", "Descrip" as "Descripcion", "Anotacion" as "Anotacion", "Saldoaux" as "Saldoaux", "Rmonto" as "Monto" from ZooLogic.PagoDet where CODIGO = <<"'" + this.FormatearTextoSql( c_PAGO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_OrdenDePago_PagoDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_OrdenDePago_PagoDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_OrdenDePago_PagoDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fechcoti" as "Fechaultcotizacion", "Jjfecha" as "Fechacomp", "Idcaja" as "Caja", "Tipodoc" as "Tipodocumento", "Jjven" as "Vendedor", "Nrotarjeta" as "Numerotarjeta", "Tipcomp" as "Tipodecomprobante", "Letra" as "Letra", "Nrodoc" as "Nrodocumento", "Cotiza" as "Ultimacotizacion", "Nrocupon" as "Numerocupon", "Jjcotiz" as "Cotiza", "Nroitem" as "Nroitem", "Signo" as "Signo", "Numcompr" as "Numerodecomprobante", "Pesos" as "Pesosalcambio", "Jjt" as "Tipo", "Ptoventa" as "Puntodeventa", "Jjturno" as "Turno", "Visualcaja" as "Visualizarenestadodecaja", "Celectro" as "Chequeelectronico", "Perscomp" as "Personalizarcomprobante", "Nrochprop" as "Numerochequepropio", "Jjnum" as "Codigo", "Nrocheque" as "Numerocheque", "Jjco" as "Valor", "Jjde" as "Valordetalle", "Jjfe" as "Fecha", "Nrointerno" as "Numerointerno", "Jjm" as "Monto", "Jrecporc" as "Recargoporcentaje", "Jrecmnt" as "Recargomonto", "Jjtotfac" as "Total", "Jrecmntsi" as "Recargomontosinimpuestos", "Jrrecsperc" as "Recargosinpercepciones", "Guidcomp" as "Iditemcomponente", "Permvuelto" as "Permitevuelto", "Valecambio" as "Numerovaledecambio" from ZooLogic.PagoVal where JJNUM = <<"'" + this.FormatearTextoSql( c_PAGO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_OrdenDePago_ValoresDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_OrdenDePago_ValoresDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_OrdenDePago_ValoresDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Codimp" as "Codimp", "Descri" as "Codimpdetalle", "Monto" as "Monto" from ZooLogic.PagoImp where Codigo = <<"'" + this.FormatearTextoSql( c_PAGO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_OrdenDePago_ImpuestosComprobante')
			this.oConexion.EjecutarSql( lcSentencia, 'c_OrdenDePago_ImpuestosComprobante', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_OrdenDePago_ImpuestosComprobante
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
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Zadsfw" as "Zadsfw", "Descfw" as "Descripcionfw", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Haltafw" as "Horaaltafw", "Esttrans" as "Estadotransferencia", "Faltafw" as "Fechaaltafw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Timestamp" as "Timestamp", "Facttipo" as "Tipocomprobante", "Opago" as "Ordendepago", "Fletra" as "Letra", "Fperson" as "Ordendepago_proveedor", "Fptoven" as "Puntodeventa", "Moneda" as "Ordendepago_monedacomprobante", "Fopobs" as "Ordendepago_obs", "Ffch" as "Ordendepago_fecha", "Fnumcomp" as "Numero", "Fechap" as "Fecha", "Cotiz" as "Ordendepago_cotizacion", "Recibo" as "Recibo", "Ftotal" as "Ordendepago_total", "Anulado" as "Anulado", "Fobs" as "Observacion", "Codigo" as "Codigo" from ZooLogic.PAGO where  PAGO.CODIGO != '' AND PAGO.FACTTIPO = 37 order by FAltaFW desc,HAltaFW desc,CODIGO desc
			endtext
			use in select('c_PAGO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_PAGO', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecha" as "Fecha", "Idcaja" as "Caja", "Codcomp" as "Codigocomprobante", "Tipo" as "Tipodecomprobante", "Letraafec" as "Letra", "Numafec" as "Numerodecomprobante", "Nroitem" as "Nroitem", "Rtipo" as "Tipo", "Ptoafec" as "Puntodeventa", "Lpagoacta" as "Espagoacuenta", "Rval" as "Valor", "Codigo" as "Codigo", "Fecemi" as "Emision", "Rfecven" as "Vencimiento", "Descrip" as "Descripcion", "Anotacion" as "Anotacion", "Saldoaux" as "Saldoaux", "Rmonto" as "Monto" from ZooLogic.PagoDet where CODIGO = <<"'" + this.FormatearTextoSql( c_PAGO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_OrdenDePago_PagoDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_OrdenDePago_PagoDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_OrdenDePago_PagoDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fechcoti" as "Fechaultcotizacion", "Jjfecha" as "Fechacomp", "Idcaja" as "Caja", "Tipodoc" as "Tipodocumento", "Jjven" as "Vendedor", "Nrotarjeta" as "Numerotarjeta", "Tipcomp" as "Tipodecomprobante", "Letra" as "Letra", "Nrodoc" as "Nrodocumento", "Cotiza" as "Ultimacotizacion", "Nrocupon" as "Numerocupon", "Jjcotiz" as "Cotiza", "Nroitem" as "Nroitem", "Signo" as "Signo", "Numcompr" as "Numerodecomprobante", "Pesos" as "Pesosalcambio", "Jjt" as "Tipo", "Ptoventa" as "Puntodeventa", "Jjturno" as "Turno", "Visualcaja" as "Visualizarenestadodecaja", "Celectro" as "Chequeelectronico", "Perscomp" as "Personalizarcomprobante", "Nrochprop" as "Numerochequepropio", "Jjnum" as "Codigo", "Nrocheque" as "Numerocheque", "Jjco" as "Valor", "Jjde" as "Valordetalle", "Jjfe" as "Fecha", "Nrointerno" as "Numerointerno", "Jjm" as "Monto", "Jrecporc" as "Recargoporcentaje", "Jrecmnt" as "Recargomonto", "Jjtotfac" as "Total", "Jrecmntsi" as "Recargomontosinimpuestos", "Jrrecsperc" as "Recargosinpercepciones", "Guidcomp" as "Iditemcomponente", "Permvuelto" as "Permitevuelto", "Valecambio" as "Numerovaledecambio" from ZooLogic.PagoVal where JJNUM = <<"'" + this.FormatearTextoSql( c_PAGO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_OrdenDePago_ValoresDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_OrdenDePago_ValoresDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_OrdenDePago_ValoresDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Codimp" as "Codimp", "Descri" as "Codimpdetalle", "Monto" as "Monto" from ZooLogic.PagoImp where Codigo = <<"'" + this.FormatearTextoSql( c_PAGO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_OrdenDePago_ImpuestosComprobante')
			this.oConexion.EjecutarSql( lcSentencia, 'c_OrdenDePago_ImpuestosComprobante', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_OrdenDePago_ImpuestosComprobante
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
			lcXml = this.oConexion.EjecutarSql( "select Fmodifw,Fecexpo,Fectrans,Fecimpo,Horaimpo,Horaexpo,Saltafw,Hmodifw,Zadsfw,Descfw,Vmodifw,Val" + ;
"tafw,Ualtafw,Umodifw,Smodifw,Haltafw,Esttrans,Faltafw,Bdaltafw,Bdmodifw,Timestamp,Facttipo,Opago,Fle" + ;
"tra,Fperson,Fptoven,Moneda,Fopobs,Ffch,Fnumcomp,Fechap,Cotiz,Recibo,Ftotal,Anulado,Fobs,Codigo" + ;
" from ZooLogic.PAGO where  PAGO.CODIGO != '' AND PAGO.FACTTIPO = 37 and " + lcFiltro )
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
			local  lxPagoFmodifw, lxPagoFecexpo, lxPagoFectrans, lxPagoFecimpo, lxPagoHoraimpo, lxPagoHoraexpo, lxPagoSaltafw, lxPagoHmodifw, lxPagoZadsfw, lxPagoDescfw, lxPagoVmodifw, lxPagoValtafw, lxPagoUaltafw, lxPagoUmodifw, lxPagoSmodifw, lxPagoHaltafw, lxPagoEsttrans, lxPagoFaltafw, lxPagoBdaltafw, lxPagoBdmodifw, lxPagoTimestamp, lxPagoFacttipo, lxPagoOpago, lxPagoFletra, lxPagoFperson, lxPagoFptoven, lxPagoMoneda, lxPagoFopobs, lxPagoFfch, lxPagoFnumcomp, lxPagoFechap, lxPagoCotiz, lxPagoRecibo, lxPagoFtotal, lxPagoAnulado, lxPagoFobs, lxPagoCodigo
				lxPagoFmodifw = ctod( '  /  /    ' )			lxPagoFecexpo = ctod( '  /  /    ' )			lxPagoFectrans = ctod( '  /  /    ' )			lxPagoFecimpo = ctod( '  /  /    ' )			lxPagoHoraimpo = []			lxPagoHoraexpo = []			lxPagoSaltafw = []			lxPagoHmodifw = []			lxPagoZadsfw = []			lxPagoDescfw = []			lxPagoVmodifw = []			lxPagoValtafw = []			lxPagoUaltafw = []			lxPagoUmodifw = []			lxPagoSmodifw = []			lxPagoHaltafw = []			lxPagoEsttrans = []			lxPagoFaltafw = ctod( '  /  /    ' )			lxPagoBdaltafw = []			lxPagoBdmodifw = []			lxPagoTimestamp = goLibrerias.ObtenerTimestamp()			lxPagoFacttipo = 0			lxPagoOpago = []			lxPagoFletra = []			lxPagoFperson = []			lxPagoFptoven = 0			lxPagoMoneda = []			lxPagoFopobs = []			lxPagoFfch = ctod( '  /  /    ' )			lxPagoFnumcomp = 0			lxPagoFechap = ctod( '  /  /    ' )			lxPagoCotiz = 0			lxPagoRecibo = []			lxPagoFtotal = 0			lxPagoAnulado = .F.			lxPagoFobs = []			lxPagoCodigo = []
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.PagoDet where "CODIGO" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.PagoVal where "JJNUM" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.PagoImp where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( [delete from ZooLogic.PAGO where "CODIGO" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'PAGO' + '_' + tcCampo
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
		lcWhere = " Where  PAGO.CODIGO != '' AND PAGO.FACTTIPO = 37"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Zadsfw" as "Zadsfw", "Descfw" as "Descripcionfw", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Haltafw" as "Horaaltafw", "Esttrans" as "Estadotransferencia", "Faltafw" as "Fechaaltafw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Timestamp" as "Timestamp", "Facttipo" as "Tipocomprobante", "Opago" as "Ordendepago", "Fletra" as "Letra", "Fperson" as "Ordendepago_proveedor", "Fptoven" as "Puntodeventa", "Moneda" as "Ordendepago_monedacomprobante", "Fopobs" as "Ordendepago_obs", "Ffch" as "Ordendepago_fecha", "Fnumcomp" as "Numero", "Fechap" as "Fecha", "Cotiz" as "Ordendepago_cotizacion", "Recibo" as "Recibo", "Ftotal" as "Ordendepago_total", "Anulado" as "Anulado", "Fobs" as "Observacion", "Codigo" as "Codigo"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'PAGO', '', tnTope )
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
	Function ObtenerDatosDetalleOrdenDePago_PagoDetalle( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  PAGODET.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fecha" as "Fecha", "Idcaja" as "Caja", "Codcomp" as "Codigocomprobante", "Tipo" as "Tipodecomprobante", "Letraafec" as "Letra", "Numafec" as "Numerodecomprobante", "Nroitem" as "Nroitem", "Rtipo" as "Tipo", "Ptoafec" as "Puntodeventa", "Lpagoacta" as "Espagoacuenta", "Rval" as "Valor", "Codigo" as "Codigo", "Fecemi" as "Emision", "Rfecven" as "Vencimiento", "Descrip" as "Descripcion", "Anotacion" as "Anotacion", "Saldoaux" as "Saldoaux", "Rmonto" as "Monto"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleOrdenDePago_PagoDetalle( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'PagoDet', 'OrdenDePago_PagoDetalle', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleOrdenDePago_PagoDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleOrdenDePago_PagoDetalle( lcAtributo )
		endfor
		lcSelect = substr( lcSelect, 2 )
		return lcSelect
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosDetalleOrdenDePago_ValoresDetalle( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  PAGOVAL.JJNUM != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fechcoti" as "Fechaultcotizacion", "Jjfecha" as "Fechacomp", "Idcaja" as "Caja", "Tipodoc" as "Tipodocumento", "Jjven" as "Vendedor", "Nrotarjeta" as "Numerotarjeta", "Tipcomp" as "Tipodecomprobante", "Letra" as "Letra", "Nrodoc" as "Nrodocumento", "Cotiza" as "Ultimacotizacion", "Nrocupon" as "Numerocupon", "Jjcotiz" as "Cotiza", "Nroitem" as "Nroitem", "Signo" as "Signo", "Numcompr" as "Numerodecomprobante", "Pesos" as "Pesosalcambio", "Jjt" as "Tipo", "Ptoventa" as "Puntodeventa", "Jjturno" as "Turno", "Visualcaja" as "Visualizarenestadodecaja", "Celectro" as "Chequeelectronico", "Perscomp" as "Personalizarcomprobante", "Nrochprop" as "Numerochequepropio", "Jjnum" as "Codigo", "Nrocheque" as "Numerocheque", "Jjco" as "Valor", "Jjde" as "Valordetalle", "Jjfe" as "Fecha", "Nrointerno" as "Numerointerno", "Jjm" as "Monto", "Jrecporc" as "Recargoporcentaje", "Jrecmnt" as "Recargomonto", "Jjtotfac" as "Total", "Jrecmntsi" as "Recargomontosinimpuestos", "Jrrecsperc" as "Recargosinpercepciones", "Guidcomp" as "Iditemcomponente", "Permvuelto" as "Permitevuelto", "Valecambio" as "Numerovaledecambio"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleOrdenDePago_ValoresDetalle( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'PagoVal', 'OrdenDePago_ValoresDetalle', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleOrdenDePago_ValoresDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleOrdenDePago_ValoresDetalle( lcAtributo )
		endfor
		lcSelect = substr( lcSelect, 2 )
		return lcSelect
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosDetalleOrdenDePago_ImpuestosComprobante( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  PAGOIMP.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Nroitem" as "Nroitem", "Codigo" as "Codigo", "Codimp" as "Codimp", "Descri" as "Codimpdetalle", "Monto" as "Monto"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleOrdenDePago_ImpuestosComprobante( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'PagoImp', 'OrdenDePago_ImpuestosComprobante', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleOrdenDePago_ImpuestosComprobante( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleOrdenDePago_ImpuestosComprobante( lcAtributo )
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
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'FECHAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECEXPO AS FECHAEXPO'
				Case lcAtributo == 'FECHATRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRANS AS FECHATRANSFERENCIA'
				Case lcAtributo == 'FECHAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECIMPO AS FECHAIMPO'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'DESCRIPCIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCFW AS DESCRIPCIONFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'TIMESTAMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIMESTAMP AS TIMESTAMP'
				Case lcAtributo == 'TIPOCOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FACTTIPO AS TIPOCOMPROBANTE'
				Case lcAtributo == 'ORDENDEPAGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'OPAGO AS ORDENDEPAGO'
				Case lcAtributo == 'LETRA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FLETRA AS LETRA'
				Case lcAtributo == 'ORDENDEPAGO_PROVEEDOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPERSON AS ORDENDEPAGO_PROVEEDOR'
				Case lcAtributo == 'PUNTODEVENTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPTOVEN AS PUNTODEVENTA'
				Case lcAtributo == 'ORDENDEPAGO_MONEDACOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONEDA AS ORDENDEPAGO_MONEDACOMPROBANTE'
				Case lcAtributo == 'ORDENDEPAGO_OBS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FOPOBS AS ORDENDEPAGO_OBS'
				Case lcAtributo == 'ORDENDEPAGO_FECHA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FFCH AS ORDENDEPAGO_FECHA'
				Case lcAtributo == 'NUMERO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FNUMCOMP AS NUMERO'
				Case lcAtributo == 'FECHA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHAP AS FECHA'
				Case lcAtributo == 'ORDENDEPAGO_COTIZACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COTIZ AS ORDENDEPAGO_COTIZACION'
				Case lcAtributo == 'RECIBO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RECIBO AS RECIBO'
				Case lcAtributo == 'ORDENDEPAGO_TOTAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FTOTAL AS ORDENDEPAGO_TOTAL'
				Case lcAtributo == 'ANULADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ANULADO AS ANULADO'
				Case lcAtributo == 'OBSERVACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FOBS AS OBSERVACION'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleOrdenDePago_PagoDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'FECHA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHA AS FECHA'
				Case lcAtributo == 'CAJA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDCAJA AS CAJA'
				Case lcAtributo == 'CODIGOCOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODCOMP AS CODIGOCOMPROBANTE'
				Case lcAtributo == 'TIPODECOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPO AS TIPODECOMPROBANTE'
				Case lcAtributo == 'LETRA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LETRAAFEC AS LETRA'
				Case lcAtributo == 'NUMERODECOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NUMAFEC AS NUMERODECOMPROBANTE'
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'TIPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RTIPO AS TIPO'
				Case lcAtributo == 'PUNTODEVENTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PTOAFEC AS PUNTODEVENTA'
				Case lcAtributo == 'ESPAGOACUENTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LPAGOACTA AS ESPAGOACUENTA'
				Case lcAtributo == 'VALOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RVAL AS VALOR'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'EMISION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECEMI AS EMISION'
				Case lcAtributo == 'VENCIMIENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RFECVEN AS VENCIMIENTO'
				Case lcAtributo == 'DESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCRIP AS DESCRIPCION'
				Case lcAtributo == 'ANOTACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ANOTACION AS ANOTACION'
				Case lcAtributo == 'SALDOAUX'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALDOAUX AS SALDOAUX'
				Case lcAtributo == 'MONTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RMONTO AS MONTO'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleOrdenDePago_ValoresDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'FECHAULTCOTIZACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHCOTI AS FECHAULTCOTIZACION'
				Case lcAtributo == 'FECHACOMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'JJFECHA AS FECHACOMP'
				Case lcAtributo == 'CAJA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDCAJA AS CAJA'
				Case lcAtributo == 'TIPODOCUMENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPODOC AS TIPODOCUMENTO'
				Case lcAtributo == 'VENDEDOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'JJVEN AS VENDEDOR'
				Case lcAtributo == 'NUMEROTARJETA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROTARJETA AS NUMEROTARJETA'
				Case lcAtributo == 'TIPODECOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPCOMP AS TIPODECOMPROBANTE'
				Case lcAtributo == 'LETRA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LETRA AS LETRA'
				Case lcAtributo == 'NRODOCUMENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NRODOC AS NRODOCUMENTO'
				Case lcAtributo == 'ULTIMACOTIZACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COTIZA AS ULTIMACOTIZACION'
				Case lcAtributo == 'NUMEROCUPON'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROCUPON AS NUMEROCUPON'
				Case lcAtributo == 'COTIZA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'JJCOTIZ AS COTIZA'
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'SIGNO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SIGNO AS SIGNO'
				Case lcAtributo == 'NUMERODECOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NUMCOMPR AS NUMERODECOMPROBANTE'
				Case lcAtributo == 'PESOSALCAMBIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PESOS AS PESOSALCAMBIO'
				Case lcAtributo == 'TIPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'JJT AS TIPO'
				Case lcAtributo == 'PUNTODEVENTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PTOVENTA AS PUNTODEVENTA'
				Case lcAtributo == 'TURNO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'JJTURNO AS TURNO'
				Case lcAtributo == 'VISUALIZARENESTADODECAJA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VISUALCAJA AS VISUALIZARENESTADODECAJA'
				Case lcAtributo == 'CHEQUEELECTRONICO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CELECTRO AS CHEQUEELECTRONICO'
				Case lcAtributo == 'PERSONALIZARCOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PERSCOMP AS PERSONALIZARCOMPROBANTE'
				Case lcAtributo == 'NUMEROCHEQUEPROPIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROCHPROP AS NUMEROCHEQUEPROPIO'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'JJNUM AS CODIGO'
				Case lcAtributo == 'NUMEROCHEQUE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROCHEQUE AS NUMEROCHEQUE'
				Case lcAtributo == 'VALOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'JJCO AS VALOR'
				Case lcAtributo == 'VALORDETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'JJDE AS VALORDETALLE'
				Case lcAtributo == 'FECHA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'JJFE AS FECHA'
				Case lcAtributo == 'NUMEROINTERNO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROINTERNO AS NUMEROINTERNO'
				Case lcAtributo == 'MONTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'JJM AS MONTO'
				Case lcAtributo == 'RECARGOPORCENTAJE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'JRECPORC AS RECARGOPORCENTAJE'
				Case lcAtributo == 'RECARGOMONTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'JRECMNT AS RECARGOMONTO'
				Case lcAtributo == 'TOTAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'JJTOTFAC AS TOTAL'
				Case lcAtributo == 'RECARGOMONTOSINIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'JRECMNTSI AS RECARGOMONTOSINIMPUESTOS'
				Case lcAtributo == 'RECARGOSINPERCEPCIONES'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'JRRECSPERC AS RECARGOSINPERCEPCIONES'
				Case lcAtributo == 'IDITEMCOMPONENTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'GUIDCOMP AS IDITEMCOMPONENTE'
				Case lcAtributo == 'PERMITEVUELTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PERMVUELTO AS PERMITEVUELTO'
				Case lcAtributo == 'NUMEROVALEDECAMBIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALECAMBIO AS NUMEROVALEDECAMBIO'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleOrdenDePago_ImpuestosComprobante( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'CODIMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIMP AS CODIMP'
				Case lcAtributo == 'CODIMPDETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCRI AS CODIMPDETALLE'
				Case lcAtributo == 'MONTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONTO AS MONTO'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoEntidad( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEXPO'
				lcCampo = 'FECEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAIMPO'
				lcCampo = 'FECIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCIONFW'
				lcCampo = 'DESCFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'TIMESTAMP'
				lcCampo = 'TIMESTAMP'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOCOMPROBANTE'
				lcCampo = 'FACTTIPO'
			Case upper( alltrim( tcAtributo ) ) == 'ORDENDEPAGO'
				lcCampo = 'OPAGO'
			Case upper( alltrim( tcAtributo ) ) == 'LETRA'
				lcCampo = 'FLETRA'
			Case upper( alltrim( tcAtributo ) ) == 'ORDENDEPAGO_PROVEEDOR'
				lcCampo = 'FPERSON'
			Case upper( alltrim( tcAtributo ) ) == 'PUNTODEVENTA'
				lcCampo = 'FPTOVEN'
			Case upper( alltrim( tcAtributo ) ) == 'ORDENDEPAGO_MONEDACOMPROBANTE'
				lcCampo = 'MONEDA'
			Case upper( alltrim( tcAtributo ) ) == 'ORDENDEPAGO_OBS'
				lcCampo = 'FOPOBS'
			Case upper( alltrim( tcAtributo ) ) == 'ORDENDEPAGO_FECHA'
				lcCampo = 'FFCH'
			Case upper( alltrim( tcAtributo ) ) == 'NUMERO'
				lcCampo = 'FNUMCOMP'
			Case upper( alltrim( tcAtributo ) ) == 'FECHA'
				lcCampo = 'FECHAP'
			Case upper( alltrim( tcAtributo ) ) == 'ORDENDEPAGO_COTIZACION'
				lcCampo = 'COTIZ'
			Case upper( alltrim( tcAtributo ) ) == 'RECIBO'
				lcCampo = 'RECIBO'
			Case upper( alltrim( tcAtributo ) ) == 'ORDENDEPAGO_TOTAL'
				lcCampo = 'FTOTAL'
			Case upper( alltrim( tcAtributo ) ) == 'ANULADO'
				lcCampo = 'ANULADO'
			Case upper( alltrim( tcAtributo ) ) == 'OBSERVACION'
				lcCampo = 'FOBS'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleOrdenDePago_PagoDetalle( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'FECHA'
				lcCampo = 'FECHA'
			Case upper( alltrim( tcAtributo ) ) == 'CAJA'
				lcCampo = 'IDCAJA'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGOCOMPROBANTE'
				lcCampo = 'CODCOMP'
			Case upper( alltrim( tcAtributo ) ) == 'TIPODECOMPROBANTE'
				lcCampo = 'TIPO'
			Case upper( alltrim( tcAtributo ) ) == 'LETRA'
				lcCampo = 'LETRAAFEC'
			Case upper( alltrim( tcAtributo ) ) == 'NUMERODECOMPROBANTE'
				lcCampo = 'NUMAFEC'
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'TIPO'
				lcCampo = 'RTIPO'
			Case upper( alltrim( tcAtributo ) ) == 'PUNTODEVENTA'
				lcCampo = 'PTOAFEC'
			Case upper( alltrim( tcAtributo ) ) == 'ESPAGOACUENTA'
				lcCampo = 'LPAGOACTA'
			Case upper( alltrim( tcAtributo ) ) == 'VALOR'
				lcCampo = 'RVAL'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'EMISION'
				lcCampo = 'FECEMI'
			Case upper( alltrim( tcAtributo ) ) == 'VENCIMIENTO'
				lcCampo = 'RFECVEN'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCION'
				lcCampo = 'DESCRIP'
			Case upper( alltrim( tcAtributo ) ) == 'ANOTACION'
				lcCampo = 'ANOTACION'
			Case upper( alltrim( tcAtributo ) ) == 'SALDOAUX'
				lcCampo = 'SALDOAUX'
			Case upper( alltrim( tcAtributo ) ) == 'MONTO'
				lcCampo = 'RMONTO'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleOrdenDePago_ValoresDetalle( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'FECHAULTCOTIZACION'
				lcCampo = 'FECHCOTI'
			Case upper( alltrim( tcAtributo ) ) == 'FECHACOMP'
				lcCampo = 'JJFECHA'
			Case upper( alltrim( tcAtributo ) ) == 'CAJA'
				lcCampo = 'IDCAJA'
			Case upper( alltrim( tcAtributo ) ) == 'TIPODOCUMENTO'
				lcCampo = 'TIPODOC'
			Case upper( alltrim( tcAtributo ) ) == 'VENDEDOR'
				lcCampo = 'JJVEN'
			Case upper( alltrim( tcAtributo ) ) == 'NUMEROTARJETA'
				lcCampo = 'NROTARJETA'
			Case upper( alltrim( tcAtributo ) ) == 'TIPODECOMPROBANTE'
				lcCampo = 'TIPCOMP'
			Case upper( alltrim( tcAtributo ) ) == 'LETRA'
				lcCampo = 'LETRA'
			Case upper( alltrim( tcAtributo ) ) == 'NRODOCUMENTO'
				lcCampo = 'NRODOC'
			Case upper( alltrim( tcAtributo ) ) == 'ULTIMACOTIZACION'
				lcCampo = 'COTIZA'
			Case upper( alltrim( tcAtributo ) ) == 'NUMEROCUPON'
				lcCampo = 'NROCUPON'
			Case upper( alltrim( tcAtributo ) ) == 'COTIZA'
				lcCampo = 'JJCOTIZ'
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'SIGNO'
				lcCampo = 'SIGNO'
			Case upper( alltrim( tcAtributo ) ) == 'NUMERODECOMPROBANTE'
				lcCampo = 'NUMCOMPR'
			Case upper( alltrim( tcAtributo ) ) == 'PESOSALCAMBIO'
				lcCampo = 'PESOS'
			Case upper( alltrim( tcAtributo ) ) == 'TIPO'
				lcCampo = 'JJT'
			Case upper( alltrim( tcAtributo ) ) == 'PUNTODEVENTA'
				lcCampo = 'PTOVENTA'
			Case upper( alltrim( tcAtributo ) ) == 'TURNO'
				lcCampo = 'JJTURNO'
			Case upper( alltrim( tcAtributo ) ) == 'VISUALIZARENESTADODECAJA'
				lcCampo = 'VISUALCAJA'
			Case upper( alltrim( tcAtributo ) ) == 'CHEQUEELECTRONICO'
				lcCampo = 'CELECTRO'
			Case upper( alltrim( tcAtributo ) ) == 'PERSONALIZARCOMPROBANTE'
				lcCampo = 'PERSCOMP'
			Case upper( alltrim( tcAtributo ) ) == 'NUMEROCHEQUEPROPIO'
				lcCampo = 'NROCHPROP'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'JJNUM'
			Case upper( alltrim( tcAtributo ) ) == 'NUMEROCHEQUE'
				lcCampo = 'NROCHEQUE'
			Case upper( alltrim( tcAtributo ) ) == 'VALOR'
				lcCampo = 'JJCO'
			Case upper( alltrim( tcAtributo ) ) == 'VALORDETALLE'
				lcCampo = 'JJDE'
			Case upper( alltrim( tcAtributo ) ) == 'FECHA'
				lcCampo = 'JJFE'
			Case upper( alltrim( tcAtributo ) ) == 'NUMEROINTERNO'
				lcCampo = 'NROINTERNO'
			Case upper( alltrim( tcAtributo ) ) == 'MONTO'
				lcCampo = 'JJM'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOPORCENTAJE'
				lcCampo = 'JRECPORC'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOMONTO'
				lcCampo = 'JRECMNT'
			Case upper( alltrim( tcAtributo ) ) == 'TOTAL'
				lcCampo = 'JJTOTFAC'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOMONTOSINIMPUESTOS'
				lcCampo = 'JRECMNTSI'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOSINPERCEPCIONES'
				lcCampo = 'JRRECSPERC'
			Case upper( alltrim( tcAtributo ) ) == 'IDITEMCOMPONENTE'
				lcCampo = 'GUIDCOMP'
			Case upper( alltrim( tcAtributo ) ) == 'PERMITEVUELTO'
				lcCampo = 'PERMVUELTO'
			Case upper( alltrim( tcAtributo ) ) == 'NUMEROVALEDECAMBIO'
				lcCampo = 'VALECAMBIO'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleOrdenDePago_ImpuestosComprobante( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'CODIMP'
				lcCampo = 'CODIMP'
			Case upper( alltrim( tcAtributo ) ) == 'CODIMPDETALLE'
				lcCampo = 'DESCRI'
			Case upper( alltrim( tcAtributo ) ) == 'MONTO'
				lcCampo = 'MONTO'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerTablaDetalle( tcDetalle as string ) as String
		local lcRetorno as string
		lcRetorno = ''
		if upper( alltrim( tcDetalle ) ) == 'ORDENDEPAGO_PAGODETALLE'
			lcRetorno = 'PAGODET'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'ORDENDEPAGO_VALORESDETALLE'
			lcRetorno = 'PAGOVAL'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'ORDENDEPAGO_IMPUESTOSCOMPROBANTE'
			lcRetorno = 'PAGOIMP'
		EndIf
		return lcRetorno
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasInsert() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcSentencia as string, loItem as object
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxPagoFmodifw, lxPagoFecexpo, lxPagoFectrans, lxPagoFecimpo, lxPagoHoraimpo, lxPagoHoraexpo, lxPagoSaltafw, lxPagoHmodifw, lxPagoZadsfw, lxPagoDescfw, lxPagoVmodifw, lxPagoValtafw, lxPagoUaltafw, lxPagoUmodifw, lxPagoSmodifw, lxPagoHaltafw, lxPagoEsttrans, lxPagoFaltafw, lxPagoBdaltafw, lxPagoBdmodifw, lxPagoTimestamp, lxPagoFacttipo, lxPagoOpago, lxPagoFletra, lxPagoFperson, lxPagoFptoven, lxPagoMoneda, lxPagoFopobs, lxPagoFfch, lxPagoFnumcomp, lxPagoFechap, lxPagoCotiz, lxPagoRecibo, lxPagoFtotal, lxPagoAnulado, lxPagoFobs, lxPagoCodigo
				lxPagoFmodifw =  .Fechamodificacionfw			lxPagoFecexpo =  .Fechaexpo			lxPagoFectrans =  .Fechatransferencia			lxPagoFecimpo =  .Fechaimpo			lxPagoHoraimpo =  .Horaimpo			lxPagoHoraexpo =  .Horaexpo			lxPagoSaltafw =  .Seriealtafw			lxPagoHmodifw =  .Horamodificacionfw			lxPagoZadsfw =  .Zadsfw			lxPagoDescfw =  .Descripcionfw			lxPagoVmodifw =  .Versionmodificacionfw			lxPagoValtafw =  .Versionaltafw			lxPagoUaltafw =  .Usuarioaltafw			lxPagoUmodifw =  .Usuariomodificacionfw			lxPagoSmodifw =  .Seriemodificacionfw			lxPagoHaltafw =  .Horaaltafw			lxPagoEsttrans =  .Estadotransferencia			lxPagoFaltafw =  .Fechaaltafw			lxPagoBdaltafw =  .Basededatosaltafw			lxPagoBdmodifw =  .Basededatosmodificacionfw			lxPagoTimestamp = goLibrerias.ObtenerTimestamp()			lxPagoFacttipo =  .Tipocomprobante			lxPagoOpago =  upper( .OrdenDePago_PK ) 			lxPagoFletra =  .Letra			lxPagoFperson =  upper( .OrdenDePago_Proveedor_PK ) 			lxPagoFptoven =  .Puntodeventa			lxPagoMoneda =  upper( .OrdenDePago_MonedaComprobante_PK ) 			lxPagoFopobs =  .Ordendepago_obs			lxPagoFfch =  .Ordendepago_fecha			lxPagoFnumcomp =  .Numero			lxPagoFechap =  .Fecha			lxPagoCotiz =  .Ordendepago_cotizacion			lxPagoRecibo =  .Recibo			lxPagoFtotal =  .Ordendepago_total			lxPagoAnulado =  .Anulado			lxPagoFobs =  .Observacion			lxPagoCodigo =  .Codigo
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.PAGO ( "Fmodifw","Fecexpo","Fectrans","Fecimpo","Horaimpo","Horaexpo","Saltafw","Hmodifw","Zadsfw","Descfw","Vmodifw","Valtafw","Ualtafw","Umodifw","Smodifw","Haltafw","Esttrans","Faltafw","Bdaltafw","Bdmodifw","Timestamp","Facttipo","Opago","Fletra","Fperson","Fptoven","Moneda","Fopobs","Ffch","Fnumcomp","Fechap","Cotiz","Recibo","Ftotal","Anulado","Fobs","Codigo" ) values ( <<"'" + this.ConvertirDateSql( lxPagoFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxPagoFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxPagoFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxPagoFecimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPagoHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPagoHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPagoSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPagoHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPagoZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPagoDescfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPagoVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPagoValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPagoUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPagoUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPagoSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPagoHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPagoEsttrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxPagoFaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPagoBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPagoBdmodifw ) + "'" >>, <<lxPagoTimestamp >>, <<lxPagoFacttipo >>, <<"'" + this.FormatearTextoSql( lxPagoOpago ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPagoFletra ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPagoFperson ) + "'" >>, <<lxPagoFptoven >>, <<"'" + this.FormatearTextoSql( lxPagoMoneda ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPagoFopobs ) + "'" >>, <<"'" + this.ConvertirDateSql( lxPagoFfch ) + "'" >>, <<lxPagoFnumcomp >>, <<"'" + this.ConvertirDateSql( lxPagoFechap ) + "'" >>, <<lxPagoCotiz >>, <<"'" + this.FormatearTextoSql( lxPagoRecibo ) + "'" >>, <<lxPagoFtotal >>, <<iif( lxPagoAnulado, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxPagoFobs ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPagoCodigo ) + "'" >> )
		endtext
		loColeccion.cTabla = 'PAGO' 
		loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		With this
			local lcValorClavePrimariaString as String
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.OrdenDePago_PagoDetalle
				if this.oEntidad.OrdenDePago_PagoDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxFecha = loItem.Fecha
					lxCaja_PK = loItem.Caja_PK
					lxCodigocomprobante = loItem.Codigocomprobante
					lxTipodecomprobante = loItem.Tipodecomprobante
					lxLetra = loItem.Letra
					lxNumerodecomprobante = loItem.Numerodecomprobante
					lxNroitem = lnContadorNroItem
					lxTipo = loItem.Tipo
					lxPuntodeventa = loItem.Puntodeventa
					lxEspagoacuenta = loItem.Espagoacuenta
					lxValor_PK = loItem.Valor_PK
					lxEmision = loItem.Emision
					lxVencimiento = loItem.Vencimiento
					lxDescripcion = loItem.Descripcion
					lxAnotacion = loItem.Anotacion
					lxSaldoaux = loItem.Saldoaux
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.PagoDet("Fecha","IdCaja","CodComp","Tipo","LetraAfec","Numafec","NROITEM","Rtipo","PtoAfec","lPagoACta","RVal","CODIGO","FecEmi","RFecVen","Descrip","anotacion","SaldoAux","RMonto" ) values ( <<"'" + this.ConvertirDateSql( lxFecha ) + "'">>, <<lxCaja_PK>>, <<"'" + this.FormatearTextoSql( lxCodigocomprobante ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipodecomprobante ) + "'">>, <<"'" + this.FormatearTextoSql( lxLetra ) + "'">>, <<lxNumerodecomprobante>>, <<lxNroitem>>, <<lxTipo>>, <<lxPuntodeventa>>, <<iif( lxEspagoacuenta, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxValor_PK ) + "'">>, << lcValorClavePrimariaString >>, <<"'" + this.ConvertirDateSql( lxEmision ) + "'">>, <<"'" + this.ConvertirDateSql( lxVencimiento ) + "'">>, <<"'" + this.FormatearTextoSql( lxDescripcion ) + "'">>, <<"'" + this.FormatearTextoSql( lxAnotacion ) + "'">>, <<lxSaldoaux>>, <<lxMonto>> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.OrdenDePago_ValoresDetalle
				if this.oEntidad.OrdenDePago_ValoresDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxFechaultcotizacion = loItem.Fechaultcotizacion
					lxFechacomp = loItem.Fechacomp
					lxCaja_PK = loItem.Caja_PK
					lxTipodocumento = loItem.Tipodocumento
					lxVendedor = loItem.Vendedor
					lxNumerotarjeta = loItem.Numerotarjeta
					lxTipodecomprobante = loItem.Tipodecomprobante
					lxLetra = loItem.Letra
					lxNrodocumento = loItem.Nrodocumento
					lxUltimacotizacion = loItem.Ultimacotizacion
					lxNumerocupon = loItem.Numerocupon
					lxCotiza = loItem.Cotiza
					lxNroitem = lnContadorNroItem
					lxSigno = loItem.Signo
					lxNumerodecomprobante = loItem.Numerodecomprobante
					lxPesosalcambio = loItem.Pesosalcambio
					lxTipo = loItem.Tipo
					lxPuntodeventa = loItem.Puntodeventa
					lxTurno = loItem.Turno
					lxVisualizarenestadodecaja = loItem.Visualizarenestadodecaja
					lxChequeelectronico = loItem.Chequeelectronico
					lxPersonalizarcomprobante = loItem.Personalizarcomprobante
					lxNumerochequepropio_PK = loItem.Numerochequepropio_PK
					lxNumerocheque_PK = loItem.Numerocheque_PK
					lxValor_PK = loItem.Valor_PK
					lxValordetalle = loItem.Valordetalle
					lxFecha = loItem.Fecha
					lxNumerointerno = loItem.Numerointerno
					lxMonto = loItem.Monto
					lxRecargoporcentaje = loItem.Recargoporcentaje
					lxRecargomonto = loItem.Recargomonto
					lxTotal = loItem.Total
					lxRecargomontosinimpuestos = loItem.Recargomontosinimpuestos
					lxRecargosinpercepciones = loItem.Recargosinpercepciones
					lxIditemcomponente = loItem.Iditemcomponente
					lxPermitevuelto = loItem.Permitevuelto
					lxNumerovaledecambio_PK = loItem.Numerovaledecambio_PK
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.PagoVal("FechCoti","JJfecha","IdCaja","TipoDoc","JJVen","NroTarjeta","TIPCOMP","Letra","NroDoc","Cotiza","NroCupon","JJCotiz","NroItem","Signo","NumCompr","Pesos","JJT","PtoVenta","JJTurno","VisualCaja","CElectro","PersComp","NroChProp","JJNUM","NroCheque","JJCO","JJDE","JJFE","NroInterno","JJM","jrecporc","jrecmnt","JJTotFac","jrecmntsi","jrrecsperc","guidComp","permvuelto","ValeCambio" ) values ( <<"'" + this.ConvertirDateSql( lxFechaultcotizacion ) + "'">>, <<"'" + this.ConvertirDateSql( lxFechacomp ) + "'">>, <<lxCaja_PK>>, <<"'" + this.FormatearTextoSql( lxTipodocumento ) + "'">>, <<"'" + this.FormatearTextoSql( lxVendedor ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerotarjeta ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipodecomprobante ) + "'">>, <<"'" + this.FormatearTextoSql( lxLetra ) + "'">>, <<"'" + this.FormatearTextoSql( lxNrodocumento ) + "'">>, <<lxUltimacotizacion>>, <<lxNumerocupon>>, <<lxCotiza>>, <<lxNroitem>>, <<lxSigno>>, <<lxNumerodecomprobante>>, <<lxPesosalcambio>>, <<lxTipo>>, <<lxPuntodeventa>>, <<lxTurno>>, <<iif( lxVisualizarenestadodecaja, 1, 0 )>>, <<iif( lxChequeelectronico, 1, 0 )>>, <<iif( lxPersonalizarcomprobante, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxNumerochequepropio_PK ) + "'">>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxNumerocheque_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValordetalle ) + "'">>, <<"'" + this.ConvertirDateSql( lxFecha ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerointerno ) + "'">>, <<lxMonto>>, <<lxRecargoporcentaje>>, <<lxRecargomonto>>, <<lxTotal>>, <<lxRecargomontosinimpuestos>>, <<lxRecargosinpercepciones>>, <<"'" + this.FormatearTextoSql( lxIditemcomponente ) + "'">>, <<iif( lxPermitevuelto, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxNumerovaledecambio_PK ) + "'">> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.OrdenDePago_ImpuestosComprobante
				if this.oEntidad.OrdenDePago_ImpuestosComprobante.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxCodimp_PK = loItem.Codimp_PK
					lxCodimpdetalle = loItem.Codimpdetalle
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.PagoImp("NROITEM","Codigo","CodImp","Descri","Monto" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxCodimp_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodimpdetalle ) + "'">>, <<lxMonto>> ) 
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
			local  lxPagoFmodifw, lxPagoFecexpo, lxPagoFectrans, lxPagoFecimpo, lxPagoHoraimpo, lxPagoHoraexpo, lxPagoSaltafw, lxPagoHmodifw, lxPagoZadsfw, lxPagoDescfw, lxPagoVmodifw, lxPagoValtafw, lxPagoUaltafw, lxPagoUmodifw, lxPagoSmodifw, lxPagoHaltafw, lxPagoEsttrans, lxPagoFaltafw, lxPagoBdaltafw, lxPagoBdmodifw, lxPagoTimestamp, lxPagoFacttipo, lxPagoOpago, lxPagoFletra, lxPagoFperson, lxPagoFptoven, lxPagoMoneda, lxPagoFopobs, lxPagoFfch, lxPagoFnumcomp, lxPagoFechap, lxPagoCotiz, lxPagoRecibo, lxPagoFtotal, lxPagoAnulado, lxPagoFobs, lxPagoCodigo
				lxPagoFmodifw =  .Fechamodificacionfw			lxPagoFecexpo =  .Fechaexpo			lxPagoFectrans =  .Fechatransferencia			lxPagoFecimpo =  .Fechaimpo			lxPagoHoraimpo =  .Horaimpo			lxPagoHoraexpo =  .Horaexpo			lxPagoSaltafw =  .Seriealtafw			lxPagoHmodifw =  .Horamodificacionfw			lxPagoZadsfw =  .Zadsfw			lxPagoDescfw =  .Descripcionfw			lxPagoVmodifw =  .Versionmodificacionfw			lxPagoValtafw =  .Versionaltafw			lxPagoUaltafw =  .Usuarioaltafw			lxPagoUmodifw =  .Usuariomodificacionfw			lxPagoSmodifw =  .Seriemodificacionfw			lxPagoHaltafw =  .Horaaltafw			lxPagoEsttrans =  .Estadotransferencia			lxPagoFaltafw =  .Fechaaltafw			lxPagoBdaltafw =  .Basededatosaltafw			lxPagoBdmodifw =  .Basededatosmodificacionfw			lxPagoTimestamp = goLibrerias.ObtenerTimestamp()			lxPagoFacttipo =  .Tipocomprobante			lxPagoOpago =  upper( .OrdenDePago_PK ) 			lxPagoFletra =  .Letra			lxPagoFperson =  upper( .OrdenDePago_Proveedor_PK ) 			lxPagoFptoven =  .Puntodeventa			lxPagoMoneda =  upper( .OrdenDePago_MonedaComprobante_PK ) 			lxPagoFopobs =  .Ordendepago_obs			lxPagoFfch =  .Ordendepago_fecha			lxPagoFnumcomp =  .Numero			lxPagoFechap =  .Fecha			lxPagoCotiz =  .Ordendepago_cotizacion			lxPagoRecibo =  .Recibo			lxPagoFtotal =  .Ordendepago_total			lxPagoAnulado =  .Anulado			lxPagoFobs =  .Observacion			lxPagoCodigo =  .Codigo
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  PAGO.CODIGO != '' AND PAGO.FACTTIPO = 37]
			text to lcSentencia noshow textmerge
				update ZooLogic.PAGO set "Fmodifw" = <<"'" + this.ConvertirDateSql( lxPagoFmodifw ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxPagoFecexpo ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxPagoFectrans ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxPagoFecimpo ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxPagoHoraimpo ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxPagoHoraexpo ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxPagoSaltafw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxPagoHmodifw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxPagoZadsfw ) + "'">>, "Descfw" = <<"'" + this.FormatearTextoSql( lxPagoDescfw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxPagoVmodifw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxPagoValtafw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxPagoUaltafw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxPagoUmodifw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxPagoSmodifw ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxPagoHaltafw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxPagoEsttrans ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxPagoFaltafw ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxPagoBdaltafw ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxPagoBdmodifw ) + "'">>, "Timestamp" = <<lxPagoTimestamp>>, "Facttipo" = <<lxPagoFacttipo>>, "Opago" = <<"'" + this.FormatearTextoSql( lxPagoOpago ) + "'">>, "Fletra" = <<"'" + this.FormatearTextoSql( lxPagoFletra ) + "'">>, "Fperson" = <<"'" + this.FormatearTextoSql( lxPagoFperson ) + "'">>, "Fptoven" = <<lxPagoFptoven>>, "Moneda" = <<"'" + this.FormatearTextoSql( lxPagoMoneda ) + "'">>, "Fopobs" = <<"'" + this.FormatearTextoSql( lxPagoFopobs ) + "'">>, "Ffch" = <<"'" + this.ConvertirDateSql( lxPagoFfch ) + "'">>, "Fnumcomp" = <<lxPagoFnumcomp>>, "Fechap" = <<"'" + this.ConvertirDateSql( lxPagoFechap ) + "'">>, "Cotiz" = <<lxPagoCotiz>>, "Recibo" = <<"'" + this.FormatearTextoSql( lxPagoRecibo ) + "'">>, "Ftotal" = <<lxPagoFtotal>>, "Anulado" = <<iif( lxPagoAnulado, 1, 0 )>>, "Fobs" = <<"'" + this.FormatearTextoSql( lxPagoFobs ) + "'">>, "Codigo" = <<"'" + this.FormatearTextoSql( lxPagoCodigo ) + "'">> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'PAGO' 
		loColeccion.agregar( strtran(  lcSentencia, chr( 9 ), '' ) )
			loColeccion.Agregar([delete from ZooLogic.PagoDet where "CODIGO" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.PagoVal where "JJNUM" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.PagoImp where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.OrdenDePago_PagoDetalle
				if this.oEntidad.OrdenDePago_PagoDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxFecha = loItem.Fecha
					lxCaja_PK = loItem.Caja_PK
					lxCodigocomprobante = loItem.Codigocomprobante
					lxTipodecomprobante = loItem.Tipodecomprobante
					lxLetra = loItem.Letra
					lxNumerodecomprobante = loItem.Numerodecomprobante
					lxNroitem = lnContadorNroItem
					lxTipo = loItem.Tipo
					lxPuntodeventa = loItem.Puntodeventa
					lxEspagoacuenta = loItem.Espagoacuenta
					lxValor_PK = loItem.Valor_PK
					lxEmision = loItem.Emision
					lxVencimiento = loItem.Vencimiento
					lxDescripcion = loItem.Descripcion
					lxAnotacion = loItem.Anotacion
					lxSaldoaux = loItem.Saldoaux
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.PagoDet("Fecha","IdCaja","CodComp","Tipo","LetraAfec","Numafec","NROITEM","Rtipo","PtoAfec","lPagoACta","RVal","CODIGO","FecEmi","RFecVen","Descrip","anotacion","SaldoAux","RMonto" ) values ( <<"'" + this.ConvertirDateSql( lxFecha ) + "'">>, <<lxCaja_PK>>, <<"'" + this.FormatearTextoSql( lxCodigocomprobante ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipodecomprobante ) + "'">>, <<"'" + this.FormatearTextoSql( lxLetra ) + "'">>, <<lxNumerodecomprobante>>, <<lxNroitem>>, <<lxTipo>>, <<lxPuntodeventa>>, <<iif( lxEspagoacuenta, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxValor_PK ) + "'">>, << lcValorClavePrimariaString >>, <<"'" + this.ConvertirDateSql( lxEmision ) + "'">>, <<"'" + this.ConvertirDateSql( lxVencimiento ) + "'">>, <<"'" + this.FormatearTextoSql( lxDescripcion ) + "'">>, <<"'" + this.FormatearTextoSql( lxAnotacion ) + "'">>, <<lxSaldoaux>>, <<lxMonto>> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.OrdenDePago_ValoresDetalle
				if this.oEntidad.OrdenDePago_ValoresDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxFechaultcotizacion = loItem.Fechaultcotizacion
					lxFechacomp = loItem.Fechacomp
					lxCaja_PK = loItem.Caja_PK
					lxTipodocumento = loItem.Tipodocumento
					lxVendedor = loItem.Vendedor
					lxNumerotarjeta = loItem.Numerotarjeta
					lxTipodecomprobante = loItem.Tipodecomprobante
					lxLetra = loItem.Letra
					lxNrodocumento = loItem.Nrodocumento
					lxUltimacotizacion = loItem.Ultimacotizacion
					lxNumerocupon = loItem.Numerocupon
					lxCotiza = loItem.Cotiza
					lxNroitem = lnContadorNroItem
					lxSigno = loItem.Signo
					lxNumerodecomprobante = loItem.Numerodecomprobante
					lxPesosalcambio = loItem.Pesosalcambio
					lxTipo = loItem.Tipo
					lxPuntodeventa = loItem.Puntodeventa
					lxTurno = loItem.Turno
					lxVisualizarenestadodecaja = loItem.Visualizarenestadodecaja
					lxChequeelectronico = loItem.Chequeelectronico
					lxPersonalizarcomprobante = loItem.Personalizarcomprobante
					lxNumerochequepropio_PK = loItem.Numerochequepropio_PK
					lxNumerocheque_PK = loItem.Numerocheque_PK
					lxValor_PK = loItem.Valor_PK
					lxValordetalle = loItem.Valordetalle
					lxFecha = loItem.Fecha
					lxNumerointerno = loItem.Numerointerno
					lxMonto = loItem.Monto
					lxRecargoporcentaje = loItem.Recargoporcentaje
					lxRecargomonto = loItem.Recargomonto
					lxTotal = loItem.Total
					lxRecargomontosinimpuestos = loItem.Recargomontosinimpuestos
					lxRecargosinpercepciones = loItem.Recargosinpercepciones
					lxIditemcomponente = loItem.Iditemcomponente
					lxPermitevuelto = loItem.Permitevuelto
					lxNumerovaledecambio_PK = loItem.Numerovaledecambio_PK
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.PagoVal("FechCoti","JJfecha","IdCaja","TipoDoc","JJVen","NroTarjeta","TIPCOMP","Letra","NroDoc","Cotiza","NroCupon","JJCotiz","NroItem","Signo","NumCompr","Pesos","JJT","PtoVenta","JJTurno","VisualCaja","CElectro","PersComp","NroChProp","JJNUM","NroCheque","JJCO","JJDE","JJFE","NroInterno","JJM","jrecporc","jrecmnt","JJTotFac","jrecmntsi","jrrecsperc","guidComp","permvuelto","ValeCambio" ) values ( <<"'" + this.ConvertirDateSql( lxFechaultcotizacion ) + "'">>, <<"'" + this.ConvertirDateSql( lxFechacomp ) + "'">>, <<lxCaja_PK>>, <<"'" + this.FormatearTextoSql( lxTipodocumento ) + "'">>, <<"'" + this.FormatearTextoSql( lxVendedor ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerotarjeta ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipodecomprobante ) + "'">>, <<"'" + this.FormatearTextoSql( lxLetra ) + "'">>, <<"'" + this.FormatearTextoSql( lxNrodocumento ) + "'">>, <<lxUltimacotizacion>>, <<lxNumerocupon>>, <<lxCotiza>>, <<lxNroitem>>, <<lxSigno>>, <<lxNumerodecomprobante>>, <<lxPesosalcambio>>, <<lxTipo>>, <<lxPuntodeventa>>, <<lxTurno>>, <<iif( lxVisualizarenestadodecaja, 1, 0 )>>, <<iif( lxChequeelectronico, 1, 0 )>>, <<iif( lxPersonalizarcomprobante, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxNumerochequepropio_PK ) + "'">>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxNumerocheque_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValordetalle ) + "'">>, <<"'" + this.ConvertirDateSql( lxFecha ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerointerno ) + "'">>, <<lxMonto>>, <<lxRecargoporcentaje>>, <<lxRecargomonto>>, <<lxTotal>>, <<lxRecargomontosinimpuestos>>, <<lxRecargosinpercepciones>>, <<"'" + this.FormatearTextoSql( lxIditemcomponente ) + "'">>, <<iif( lxPermitevuelto, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxNumerovaledecambio_PK ) + "'">> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.OrdenDePago_ImpuestosComprobante
				if this.oEntidad.OrdenDePago_ImpuestosComprobante.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxCodimp_PK = loItem.Codimp_PK
					lxCodimpdetalle = loItem.Codimpdetalle
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.PagoImp("NROITEM","Codigo","CodImp","Descri","Monto" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxCodimp_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodimpdetalle ) + "'">>, <<lxMonto>> ) 
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

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  PAGO.CODIGO != '' AND PAGO.FACTTIPO = 37]
		loColeccion.Agregar( 'delete from ZooLogic.PAGO where ' + lcFiltro )
			loColeccion.Agregar([delete from ZooLogic.PagoDet where "CODIGO" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.PagoVal where "JJNUM" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.PagoImp where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.cTabla = 'PAGO' 
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
			.OrdenDePago_ValoresDetalle.oItem.oCompCajero.lNuevo = .EsNuevo()
			.OrdenDePago_ValoresDetalle.oItem.oCompCajero.lEdicion = .EsEdicion()
			.OrdenDePago_ValoresDetalle.oItem.oCompCajero.lEliminar = .lEliminar
			.OrdenDePago_ValoresDetalle.oItem.oCompCajero.lAnular = .lAnular
			loColSentencias = .OrdenDePago_ValoresDetalle.oItem.oCompCajero.grabar()
			for each lcItem in loColSentencias
				this.colSentencias.Agregar( lcItem )
			endfor
			
			.OrdenDePago_PagoDetalle.oItem.oCompCuentacorrientepagocompras.lNuevo = .EsNuevo()
			.OrdenDePago_PagoDetalle.oItem.oCompCuentacorrientepagocompras.lEdicion = .EsEdicion()
			.OrdenDePago_PagoDetalle.oItem.oCompCuentacorrientepagocompras.lEliminar = .lEliminar
			.OrdenDePago_PagoDetalle.oItem.oCompCuentacorrientepagocompras.lAnular = .lAnular
			loColSentencias = .OrdenDePago_PagoDetalle.oItem.oCompCuentacorrientepagocompras.grabar()
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
			lcRetorno = [update ZooLogic.PAGO set TimeStamp = ] + transform( lnTimeStamp ) + lcUpdateRealTime + [ where CODIGO = ] + "'" + this.FormatearTextoSql( .Codigo ) + "'" + [ and  PAGO.CODIGO != '' AND PAGO.FACTTIPO = 37] + goServicios.RealTime.ObtenerTagEstimulo( .cNombre )
		
		endwith
		return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function ObtenerCantidadRegistros() as integer
		local lnCantReg as integer
			local lcXml as string
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.PAGO where  PAGO.CODIGO != '' AND PAGO.FACTTIPO = 37" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.PAGO where CODIGO = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  PAGO.CODIGO != '' AND PAGO.FACTTIPO = 37" )
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
		local lcCursor as String, ldFecha as Date, lcHora as string, lcValorABuscar As String, lxValorClavePK As variant, lxValorClavePrimaria As variant, lcIdentificadorParaLoguear as string, lxPagoFACTTIPO as variant, lxPagoFLETRA as variant, lxPagoFPTOVEN as variant, lxPagoFNUMCOMP as variant, lcMensajeExtra as String
		lcValorABuscar = ''
		lxValorClavePK = ''
		lcMensajeExtra = ''
		lcCursor = This.oEntidad.cPrefijoRecibir + 'PAGO'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.PAGO Where  FACTTIPO = ] + transform( &lcCursor..FACTTIPO   ) + [ and FLETRA = ] + "'" + this.FormatearTextoSql( &lcCursor..FLETRA     ) + "'" + [ and FPTOVEN = ] + transform( &lcCursor..FPTOVEN    ) + [ and FNUMCOMP = ] + transform( &lcCursor..FNUMCOMP   ), 'curSeek', this.datasessionid )
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
								this.oConexion.EjecutarSql( [UPDATE ZooLogic.PAGO set  FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, DescFW = ] + "'" + this.FormatearTextoSql( &lcCursor..DescFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, TIMESTAMP = ] + transform( &lcCursor..TIMESTAMP )+ [, FACTTIPO = ] + transform( &lcCursor..FACTTIPO )+ [, OPago = ] + "'" + this.FormatearTextoSql( &lcCursor..OPago ) + "'"+ [, FLETRA = ] + "'" + this.FormatearTextoSql( &lcCursor..FLETRA ) + "'"+ [, FPerson = ] + "'" + this.FormatearTextoSql( &lcCursor..FPerson ) + "'"+ [, FPTOVEN = ] + transform( &lcCursor..FPTOVEN )+ [, Moneda = ] + "'" + this.FormatearTextoSql( &lcCursor..Moneda ) + "'"+ [, FOPObs = ] + "'" + this.FormatearTextoSql( &lcCursor..FOPObs ) + "'"+ [, FFCH = ] + "'" + this.ConvertirDateSql( &lcCursor..FFCH ) + "'"+ [, FNUMCOMP = ] + transform( &lcCursor..FNUMCOMP )+ [, FechaP = ] + "'" + this.ConvertirDateSql( &lcCursor..FechaP ) + "'"+ [, Cotiz = ] + transform( &lcCursor..Cotiz )+ [, Recibo = ] + "'" + this.FormatearTextoSql( &lcCursor..Recibo ) + "'"+ [, FTotal = ] + transform( &lcCursor..FTotal )+ [, Anulado = ] + Transform( iif( &lcCursor..Anulado, 1, 0 ))+ [, FOBS = ] + "'" + this.FormatearTextoSql( &lcCursor..FOBS ) + "'"+ [, CODIGO = ] + "'" + this.FormatearTextoSql( &lcCursor..CODIGO ) + "'" + [ Where CODIGO = ] + "'" + this.FormatearTextoSql( lcValorABuscar ) + "'" )
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
				this.oConexion.EjecutarSql( [Select * From ZooLogic.PAGO Where CODIGO = ] + "'" + this.FormatearTextoSql( &lcCursor..CODIGO ) + "'", 'curSeek', this.datasessionid )
				if reccount( 'curSeek' ) > 0
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir como alta porque la clave principal ya existe', tlLoguear )
				Else
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					Text to lcCampos noShow
						 FMODIFW, FECEXPO, FECTRANS, FECIMPO, HORAIMPO, HORAEXPO, SALTAFW, HMODIFW, ZADSFW, DescFW, VMODIFW, VALTAFW, UALTAFW, UMODIFW, SMODIFW, HAltaFW, ESTTRANS, FAltaFW, BDALTAFW, BDMODIFW, TIMESTAMP, FACTTIPO, OPago, FLETRA, FPerson, FPTOVEN, Moneda, FOPObs, FFCH, FNUMCOMP, FechaP, Cotiz, Recibo, FTotal, Anulado, FOBS, CODIGO
					EndText
					local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..DescFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HAltaFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FAltaFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + transform( &lcCursor..TIMESTAMP )
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..FACTTIPO ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..OPago ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..FLETRA ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..FPerson ) + "'" + ',' + transform( &lcCursor..FPTOVEN ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..Moneda ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..FOPObs ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FFCH ) + "'" + ',' + transform( &lcCursor..FNUMCOMP ) + ',' + "'" + this.ConvertirDateSql( &lcCursor..FechaP ) + "'" + ',' + transform( &lcCursor..Cotiz ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..Recibo ) + "'" + ',' + transform( &lcCursor..FTotal ) + ',' + Transform( iif( &lcCursor..Anulado, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..FOBS ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..CODIGO ) + "'"
lcValoresCampos = substr(lcValoresCampos,2) 

					this.oConexion.EjecutarSql( [Insert into ZooLogic.PAGO ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
					lcCampo = lcCursor + '.' + this.cCampoCodigoWH
					this.AgregarMensajeWebHook( 'INGRESAR', &lcCampo )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
				EndIf
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'PAGO'
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
			this.oConexion.EjecutarSql( [Delete From ZooLogic.PagoDet Where CODIGO] + lcIn  )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.PagoVal Where JJNUM] + lcIn  )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.PagoImp Where Codigo] + lcIn  )
			endfor
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'COMMIT TRANSACTION' )
			endif
		EndIf
	endif
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMPAGO'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where CODIGO in ( select CODIGO from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"Fecha","IdCaja","CodComp","Tipo","LetraAfec","Numafec","NROITEM","Rtipo","PtoAfec","lPagoACta","RVal","CODIGO","FecEmi","RFecVen","Descrip","anotacion","SaldoAux","RMonto"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.PagoDet ( ] + lcCamposInsert + [ ) values ( ] +  "'" + this.ConvertirDateSql( cDetallesExistentes.Fecha      ) + "'" + ',' + transform( cDetallesExistentes.IdCaja     ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CodComp    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Tipo       ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.LetraAfec  ) + "'" + ',' + transform( cDetallesExistentes.Numafec    ) + ',' + transform( cDetallesExistentes.NROITEM    ) + ',' + transform( cDetallesExistentes.Rtipo      ) + ',' + transform( cDetallesExistentes.PtoAfec    ) + ',' + Transform( iif( cDetallesExistentes.lPagoACta , 1, 0 )) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.RVal       ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CODIGO     ) + "'" + ',' + "'" + this.ConvertirDateSql( cDetallesExistentes.FecEmi     ) + "'" + ',' + "'" + this.ConvertirDateSql( cDetallesExistentes.RFecVen    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Descrip    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.anotacion  ) + "'" + ',' + transform( cDetallesExistentes.SaldoAux   ) + ',' + transform( cDetallesExistentes.RMonto     ) + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMPAGOVALORES'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where JJNUM in ( select CODIGO from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"FechCoti","JJfecha","IdCaja","TipoDoc","JJVen","NroTarjeta","TIPCOMP","Letra","NroDoc","Cotiza","NroCupon","JJCotiz","NroItem","Signo","NumCompr","Pesos","JJT","PtoVenta","JJTurno","VisualCaja","CElectro","PersComp","NroChProp","JJNUM","NroCheque","JJCO","JJDE","JJFE","NroInterno","JJM","jrecporc","jrecmnt","JJTotFac","jrecmntsi","jrrecsperc","guidComp","permvuelto","ValeCambio"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.PagoVal ( ] + lcCamposInsert + [ ) values ( ] +  "'" + this.ConvertirDateSql( cDetallesExistentes.FechCoti   ) + "'" + ',' + "'" + this.ConvertirDateSql( cDetallesExistentes.JJfecha    ) + "'" + ',' + transform( cDetallesExistentes.IdCaja     ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.TipoDoc    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.JJVen      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.NroTarjeta ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.TIPCOMP    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Letra      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.NroDoc     ) + "'" + ',' + transform( cDetallesExistentes.Cotiza     ) + ',' + transform( cDetallesExistentes.NroCupon   ) + ',' + transform( cDetallesExistentes.JJCotiz    ) + ',' + transform( cDetallesExistentes.NroItem    ) + ',' + transform( cDetallesExistentes.Signo      ) + ',' + transform( cDetallesExistentes.NumCompr   ) + ',' + transform( cDetallesExistentes.Pesos      ) + ',' + transform( cDetallesExistentes.JJT        ) + ',' + transform( cDetallesExistentes.PtoVenta   ) + ',' + transform( cDetallesExistentes.JJTurno    ) + ',' + Transform( iif( cDetallesExistentes.VisualCaja, 1, 0 )) + ',' + Transform( iif( cDetallesExistentes.CElectro  , 1, 0 )) + ',' + Transform( iif( cDetallesExistentes.PersComp  , 1, 0 )) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.NroChProp  ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.JJNUM      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.NroCheque  ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.JJCO       ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.JJDE       ) + "'" + ',' + "'" + this.ConvertirDateSql( cDetallesExistentes.JJFE       ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.NroInterno ) + "'" + ',' + transform( cDetallesExistentes.JJM        ) + ',' + transform( cDetallesExistentes.jrecporc   ) + ',' + transform( cDetallesExistentes.jrecmnt    ) + ',' + transform( cDetallesExistentes.JJTotFac   ) + ',' + transform( cDetallesExistentes.jrecmntsi  ) + ',' + transform( cDetallesExistentes.jrrecsperc ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.guidComp   ) + "'" + ',' + Transform( iif( cDetallesExistentes.permvuelto, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ValeCambio ) + "'" + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMIMPUESTOPAGO'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where Codigo in ( select CODIGO from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"NROITEM","Codigo","CodImp","Descri","Monto"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.PagoImp ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Codigo     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CodImp     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Descri     ) + "'" + ',' + transform( cDetallesExistentes.Monto      ) + ' )'  )
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
		this.oEntidad.OrdenDePago_ValoresDetalle.oItem.oCompCajero.Recibir( this.oEntidad, 'OrdenDePago_ValoresDetalle',this.oEntidad.cPrefijoRecibir + 'ITEMPAGOVALORES',this.oEntidad.cPrefijoRecibir + 'PAGO')
		this.oEntidad.OrdenDePago_PagoDetalle.oItem.oCompCuentacorrientepagocompras.Recibir( this.oEntidad, 'OrdenDePago_PagoDetalle',this.oEntidad.cPrefijoRecibir + 'ITEMPAGO',this.oEntidad.cPrefijoRecibir + 'PAGO')
		
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function ObtenerIdentificadorParaLoguear( tcCursor as String ) As String
		local lcRetorno as String, lnCC as String , loCC as Object, lni as Integer, lcSecuencia as String
		lcRetorno = this.oEntidad.cDescripcion 
		lcRetorno = lcRetorno + ' - Letra: ' + transform( &tcCursor..FLETRA     )
		lcRetorno = lcRetorno + ' - Punto de venta: ' + transform( &tcCursor..FPTOVEN    )
		lcRetorno = lcRetorno + ' - Número: ' + transform( &tcCursor..FNUMCOMP   )
		Return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function AgregarMensajeWebHook( tcEvento as String, tcCodigo as String ) As Void

		if ( alltrim( tcEvento ) = 'MODIFICAR' and this.oEntidad.lWHModificar ) or ( alltrim( tcEvento ) = 'INGRESAR' and this.oEntidad.lWHIngresar )
			goServicios.WebHook.AgregarMensajeALaCola( tcEvento, tcCodigo, this.oEntidad.cNombre )
		endif
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function EnviarColaWebHook() As Void
		goServicios.WebHook.EnviarColaDeMensajes( this.oEntidad.cNombre )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EsAliasDeProceso( tcAlias As String, tcPrefijo as string ) As Boolean
		local llRetorno as Boolean, lcAlias as String, lcPrefijo As String
		llRetorno = .F.
		lcAlias = upper( alltrim( tcAlias ) )
		lcPrefijo = upper( alltrim( tcPrefijo ) )
		Do Case
			Case  lcAlias == lcPrefijo + 'PAGO'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'PAGO_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'PAGO_FOPOBS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'PAGO_FOBS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMPAGO'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMPAGOVALORES'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMIMPUESTOPAGO'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_Pago')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'PAGO'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..CODIGO
		llCondicion = isnull( lxVar ) or isnull( &lcCursor..FACTTIPO ) or isnull( &lcCursor..FLETRA ) or isnull( &lcCursor..FPTOVEN ) or isnull( &lcCursor..FNUMCOMP )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad PAGO. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'PAGO'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		select recno() as _Rec, * from &lcCursor into cursor CurConRecno
		select max( _Rec ) as Maximo,CODIGO as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( CODIGO, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		select max( _Rec ) as Maximo,str( FACTTIPO, 2, 0) + FLETRA + str( FPTOVEN, 4, 0) + str( FNUMCOMP, 10, 0) as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( str( FACTTIPO, 2, 0) + FLETRA + str( FPTOVEN, 4, 0) + str( FNUMCOMP, 10, 0), 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		Use in select( 'CurConRecno' )
		Use in select( 'RepMax' )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDatosInvalidos( toConexion as Object ) as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'PAGO'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FAltaFW   
		* Validar ANTERIORES A 1/1/1753  FFCH      
		* Validar ANTERIORES A 1/1/1753  FechaP    
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_Pago') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_Pago
Create Table ZooLogic.TablaTrabajo_Pago ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fmodifw" datetime  null, 
"fecexpo" datetime  null, 
"fectrans" datetime  null, 
"fecimpo" datetime  null, 
"horaimpo" char( 8 )  null, 
"horaexpo" char( 8 )  null, 
"saltafw" char( 7 )  null, 
"hmodifw" char( 8 )  null, 
"zadsfw" varchar(max)  null, 
"descfw" char( 200 )  null, 
"vmodifw" char( 13 )  null, 
"valtafw" char( 13 )  null, 
"ualtafw" char( 100 )  null, 
"umodifw" char( 100 )  null, 
"smodifw" char( 7 )  null, 
"haltafw" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"faltafw" datetime  null, 
"bdaltafw" char( 8 )  null, 
"bdmodifw" char( 8 )  null, 
"timestamp" numeric( 20, 0 )  null, 
"facttipo" numeric( 2, 0 )  null, 
"opago" char( 38 )  null, 
"fletra" char( 1 )  null, 
"fperson" char( 10 )  null, 
"fptoven" numeric( 4, 0 )  null, 
"moneda" char( 10 )  null, 
"fopobs" varchar(max)  null, 
"ffch" datetime  null, 
"fnumcomp" numeric( 10, 0 )  null, 
"fechap" datetime  null, 
"cotiz" numeric( 15, 5 )  null, 
"recibo" char( 50 )  null, 
"ftotal" numeric( 15, 2 )  null, 
"anulado" bit  null, 
"fobs" varchar(max)  null, 
"codigo" char( 38 )  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_Pago' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_Pago' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'PAGO'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		with loManejador
			if this.oEntidad.VerificarContexto( 'CB' )
			else
				.AgregarMapeo('Nrolinea','Nrolinea')
			endif
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('descfw','descfw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('timestamp','timestamp')
			.AgregarMapeo('facttipo','facttipo')
			.AgregarMapeo('opago','opago')
			.AgregarMapeo('fletra','fletra')
			.AgregarMapeo('fperson','fperson')
			.AgregarMapeo('fptoven','fptoven')
			.AgregarMapeo('moneda','moneda')
			.AgregarMapeo('fopobs','fopobs')
			.AgregarMapeo('ffch','ffch')
			.AgregarMapeo('fnumcomp','fnumcomp')
			.AgregarMapeo('fechap','fechap')
			.AgregarMapeo('cotiz','cotiz')
			.AgregarMapeo('recibo','recibo')
			.AgregarMapeo('ftotal','ftotal')
			.AgregarMapeo('anulado','anulado')
			.AgregarMapeo('fobs','fobs')
			.AgregarMapeo('codigo','codigo')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_Pago'
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
				Update t Set t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.DESCFW = isnull( d.DESCFW, t.DESCFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.TIMESTAMP = isnull( d.TIMESTAMP, t.TIMESTAMP ),t.FACTTIPO = isnull( d.FACTTIPO, t.FACTTIPO ),t.OPAGO = isnull( d.OPAGO, t.OPAGO ),t.FLETRA = isnull( d.FLETRA, t.FLETRA ),t.FPERSON = isnull( d.FPERSON, t.FPERSON ),t.FPTOVEN = isnull( d.FPTOVEN, t.FPTOVEN ),t.MONEDA = isnull( d.MONEDA, t.MONEDA ),t.FOPOBS = isnull( d.FOPOBS, t.FOPOBS ),t.FFCH = isnull( d.FFCH, t.FFCH ),t.FNUMCOMP = isnull( d.FNUMCOMP, t.FNUMCOMP ),t.FECHAP = isnull( d.FECHAP, t.FECHAP ),t.COTIZ = isnull( d.COTIZ, t.COTIZ ),t.RECIBO = isnull( d.RECIBO, t.RECIBO ),t.FTOTAL = isnull( d.FTOTAL, t.FTOTAL ),t.ANULADO = isnull( d.ANULADO, t.ANULADO ),t.FOBS = isnull( d.FOBS, t.FOBS ),t.CODIGO = isnull( d.CODIGO, t.CODIGO )
					from ZooLogic.PAGO t inner join deleted d 
							 on t.CODIGO = d.CODIGO
							 and  t.FACTTIPO = d.FACTTIPO
							 and  t.FLETRA = d.FLETRA
							 and  t.FPTOVEN = d.FPTOVEN
							 and  t.FNUMCOMP = d.FNUMCOMP
				-- Fin Updates
				insert into ZooLogic.PAGO(Fmodifw,Fecexpo,Fectrans,Fecimpo,Horaimpo,Horaexpo,Saltafw,Hmodifw,Zadsfw,Descfw,Vmodifw,Valtafw,Ualtafw,Umodifw,Smodifw,Haltafw,Esttrans,Faltafw,Bdaltafw,Bdmodifw,Timestamp,Facttipo,Opago,Fletra,Fperson,Fptoven,Moneda,Fopobs,Ffch,Fnumcomp,Fechap,Cotiz,Recibo,Ftotal,Anulado,Fobs,Codigo)
					Select isnull( d.FMODIFW,''),isnull( d.FECEXPO,''),isnull( d.FECTRANS,''),isnull( d.FECIMPO,''),isnull( d.HORAIMPO,''),isnull( d.HORAEXPO,''),isnull( d.SALTAFW,''),isnull( d.HMODIFW,''),isnull( d.ZADSFW,''),isnull( d.DESCFW,''),isnull( d.VMODIFW,''),isnull( d.VALTAFW,''),isnull( d.UALTAFW,''),isnull( d.UMODIFW,''),isnull( d.SMODIFW,''),convert( char(8), getdate(), 108 ),isnull( d.ESTTRANS,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.BDALTAFW,''),isnull( d.BDMODIFW,''),isnull( d.TIMESTAMP,0),isnull( d.FACTTIPO,0),isnull( d.OPAGO,''),isnull( d.FLETRA,''),isnull( d.FPERSON,''),isnull( d.FPTOVEN,0),isnull( d.MONEDA,''),isnull( d.FOPOBS,''),isnull( d.FFCH,''),isnull( d.FNUMCOMP,0),isnull( d.FECHAP,''),isnull( d.COTIZ,0),isnull( d.RECIBO,''),isnull( d.FTOTAL,0),isnull( d.ANULADO,0),isnull( d.FOBS,''),isnull( d.CODIGO,'')
						From deleted d left join ZooLogic.PAGO pk 
							 on d.CODIGO = pk.CODIGO
						 left join ZooLogic.PAGO cc 
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
					'<<loLogueo.UsuarioPc>>','<<loLogueo.OrigenLogueo>>','No se pudo importar la entidad <<lcEntidad>>: TIPO DE COMPROBANTE ' + cast( d.FACTTIPO as Varchar(2) ) + ', LETRA ' + cast( d.FLETRA as Varchar(1) ) + ', PUNTO DE VENTA ' + cast( d.FPTOVEN as Varchar(4) ) + ', NÚMERO ' + cast( d.FNUMCOMP as Varchar(10) ) + '','La clave principal no es la esperada'
					from ZooLogic.PAGO t inner join deleted d 
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
					'<<loLogueo.UsuarioPc>>','<<loLogueo.OrigenLogueo>>','No se pudo importar la entidad <<lcEntidad>>: TIPO DE COMPROBANTE ' + cast( d.FACTTIPO as Varchar(2) ) + ', LETRA ' + cast( d.FLETRA as Varchar(1) ) + ', PUNTO DE VENTA ' + cast( d.FPTOVEN as Varchar(4) ) + ', NÚMERO ' + cast( d.FNUMCOMP as Varchar(10) ) + '','La clave principal a importar ya existe'
					from ZooLogic.PAGO t inner join deleted d 
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
	function ObtenerTriggerDeleteImportacion_PagoDet( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_PAGO_PagoDet
ON ZooLogic.TablaTrabajo_PAGO_PagoDet
AFTER DELETE
As
Begin
Update t Set 
t.FECHA = isnull( d.FECHA, t.FECHA ),
t.IDCAJA = isnull( d.IDCAJA, t.IDCAJA ),
t.CODCOMP = isnull( d.CODCOMP, t.CODCOMP ),
t.TIPO = isnull( d.TIPO, t.TIPO ),
t.LETRAAFEC = isnull( d.LETRAAFEC, t.LETRAAFEC ),
t.NUMAFEC = isnull( d.NUMAFEC, t.NUMAFEC ),
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.RTIPO = isnull( d.RTIPO, t.RTIPO ),
t.PTOAFEC = isnull( d.PTOAFEC, t.PTOAFEC ),
t.LPAGOACTA = isnull( d.LPAGOACTA, t.LPAGOACTA ),
t.RVAL = isnull( d.RVAL, t.RVAL ),
t.CODIGO = isnull( d.CODIGO, t.CODIGO ),
t.FECEMI = isnull( d.FECEMI, t.FECEMI ),
t.RFECVEN = isnull( d.RFECVEN, t.RFECVEN ),
t.DESCRIP = isnull( d.DESCRIP, t.DESCRIP ),
t.ANOTACION = isnull( d.ANOTACION, t.ANOTACION ),
t.SALDOAUX = isnull( d.SALDOAUX, t.SALDOAUX ),
t.RMONTO = isnull( d.RMONTO, t.RMONTO )
from ZooLogic.PagoDet t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.PagoDet
( 
"FECHA",
"IDCAJA",
"CODCOMP",
"TIPO",
"LETRAAFEC",
"NUMAFEC",
"NROITEM",
"RTIPO",
"PTOAFEC",
"LPAGOACTA",
"RVAL",
"CODIGO",
"FECEMI",
"RFECVEN",
"DESCRIP",
"ANOTACION",
"SALDOAUX",
"RMONTO"
 )
Select 
d.FECHA,
d.IDCAJA,
d.CODCOMP,
d.TIPO,
d.LETRAAFEC,
d.NUMAFEC,
d.NROITEM,
d.RTIPO,
d.PTOAFEC,
d.LPAGOACTA,
d.RVAL,
d.CODIGO,
d.FECEMI,
d.RFECVEN,
d.DESCRIP,
d.ANOTACION,
d.SALDOAUX,
d.RMONTO
From deleted d left join ZooLogic.PagoDet pk 
 on d.CODIGO = pk.CODIGO
Where pk.CODIGO Is Null 
-- Fin Inserts
End

		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_PagoVal( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_PAGO_PagoVal
ON ZooLogic.TablaTrabajo_PAGO_PagoVal
AFTER DELETE
As
Begin
Update t Set 
t.FECHCOTI = isnull( d.FECHCOTI, t.FECHCOTI ),
t.JJFECHA = isnull( d.JJFECHA, t.JJFECHA ),
t.IDCAJA = isnull( d.IDCAJA, t.IDCAJA ),
t.TIPODOC = isnull( d.TIPODOC, t.TIPODOC ),
t.JJVEN = isnull( d.JJVEN, t.JJVEN ),
t.NROTARJETA = isnull( d.NROTARJETA, t.NROTARJETA ),
t.TIPCOMP = isnull( d.TIPCOMP, t.TIPCOMP ),
t.LETRA = isnull( d.LETRA, t.LETRA ),
t.NRODOC = isnull( d.NRODOC, t.NRODOC ),
t.COTIZA = isnull( d.COTIZA, t.COTIZA ),
t.NROCUPON = isnull( d.NROCUPON, t.NROCUPON ),
t.JJCOTIZ = isnull( d.JJCOTIZ, t.JJCOTIZ ),
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.SIGNO = isnull( d.SIGNO, t.SIGNO ),
t.NUMCOMPR = isnull( d.NUMCOMPR, t.NUMCOMPR ),
t.PESOS = isnull( d.PESOS, t.PESOS ),
t.JJT = isnull( d.JJT, t.JJT ),
t.PTOVENTA = isnull( d.PTOVENTA, t.PTOVENTA ),
t.JJTURNO = isnull( d.JJTURNO, t.JJTURNO ),
t.VISUALCAJA = isnull( d.VISUALCAJA, t.VISUALCAJA ),
t.CELECTRO = isnull( d.CELECTRO, t.CELECTRO ),
t.PERSCOMP = isnull( d.PERSCOMP, t.PERSCOMP ),
t.NROCHPROP = isnull( d.NROCHPROP, t.NROCHPROP ),
t.JJNUM = isnull( d.JJNUM, t.JJNUM ),
t.NROCHEQUE = isnull( d.NROCHEQUE, t.NROCHEQUE ),
t.JJCO = isnull( d.JJCO, t.JJCO ),
t.JJDE = isnull( d.JJDE, t.JJDE ),
t.JJFE = isnull( d.JJFE, t.JJFE ),
t.NROINTERNO = isnull( d.NROINTERNO, t.NROINTERNO ),
t.JJM = isnull( d.JJM, t.JJM ),
t.JRECPORC = isnull( d.JRECPORC, t.JRECPORC ),
t.JRECMNT = isnull( d.JRECMNT, t.JRECMNT ),
t.JJTOTFAC = isnull( d.JJTOTFAC, t.JJTOTFAC ),
t.JRECMNTSI = isnull( d.JRECMNTSI, t.JRECMNTSI ),
t.JRRECSPERC = isnull( d.JRRECSPERC, t.JRRECSPERC ),
t.GUIDCOMP = isnull( d.GUIDCOMP, t.GUIDCOMP ),
t.PERMVUELTO = isnull( d.PERMVUELTO, t.PERMVUELTO ),
t.VALECAMBIO = isnull( d.VALECAMBIO, t.VALECAMBIO )
from ZooLogic.PagoVal t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.PagoVal
( 
"FECHCOTI",
"JJFECHA",
"IDCAJA",
"TIPODOC",
"JJVEN",
"NROTARJETA",
"TIPCOMP",
"LETRA",
"NRODOC",
"COTIZA",
"NROCUPON",
"JJCOTIZ",
"NROITEM",
"SIGNO",
"NUMCOMPR",
"PESOS",
"JJT",
"PTOVENTA",
"JJTURNO",
"VISUALCAJA",
"CELECTRO",
"PERSCOMP",
"NROCHPROP",
"JJNUM",
"NROCHEQUE",
"JJCO",
"JJDE",
"JJFE",
"NROINTERNO",
"JJM",
"JRECPORC",
"JRECMNT",
"JJTOTFAC",
"JRECMNTSI",
"JRRECSPERC",
"GUIDCOMP",
"PERMVUELTO",
"VALECAMBIO"
 )
Select 
d.FECHCOTI,
d.JJFECHA,
d.IDCAJA,
d.TIPODOC,
d.JJVEN,
d.NROTARJETA,
d.TIPCOMP,
d.LETRA,
d.NRODOC,
d.COTIZA,
d.NROCUPON,
d.JJCOTIZ,
d.NROITEM,
d.SIGNO,
d.NUMCOMPR,
d.PESOS,
d.JJT,
d.PTOVENTA,
d.JJTURNO,
d.VISUALCAJA,
d.CELECTRO,
d.PERSCOMP,
d.NROCHPROP,
d.JJNUM,
d.NROCHEQUE,
d.JJCO,
d.JJDE,
d.JJFE,
d.NROINTERNO,
d.JJM,
d.JRECPORC,
d.JRECMNT,
d.JJTOTFAC,
d.JRECMNTSI,
d.JRRECSPERC,
d.GUIDCOMP,
d.PERMVUELTO,
d.VALECAMBIO
From deleted d left join ZooLogic.PagoVal pk 
 on d.CODIGO = pk.CODIGO
Where pk.CODIGO Is Null 
-- Fin Inserts
End

		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_PagoImp( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_PAGO_PagoImp
ON ZooLogic.TablaTrabajo_PAGO_PagoImp
AFTER DELETE
As
Begin
Update t Set 
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.CODIGO = isnull( d.CODIGO, t.CODIGO ),
t.CODIMP = isnull( d.CODIMP, t.CODIMP ),
t.DESCRI = isnull( d.DESCRI, t.DESCRI ),
t.MONTO = isnull( d.MONTO, t.MONTO )
from ZooLogic.PagoImp t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.PagoImp
( 
"NROITEM",
"CODIGO",
"CODIMP",
"DESCRI",
"MONTO"
 )
Select 
d.NROITEM,
d.CODIGO,
d.CODIMP,
d.DESCRI,
d.MONTO
From deleted d left join ZooLogic.PagoImp pk 
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_Pago') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_Pago
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_PAGO' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_PAGO.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_PAGO.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_PAGO.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_PAGO.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Horaimpo = nvl( c_PAGO.Horaimpo, [] )
					.Horaexpo = nvl( c_PAGO.Horaexpo, [] )
					.Seriealtafw = nvl( c_PAGO.Seriealtafw, [] )
					.Horamodificacionfw = nvl( c_PAGO.Horamodificacionfw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Descripcionfw = nvl( c_PAGO.Descripcionfw, [] )
					.Versionmodificacionfw = nvl( c_PAGO.Versionmodificacionfw, [] )
					.Versionaltafw = nvl( c_PAGO.Versionaltafw, [] )
					.Usuarioaltafw = nvl( c_PAGO.Usuarioaltafw, [] )
					.Usuariomodificacionfw = nvl( c_PAGO.Usuariomodificacionfw, [] )
					.Seriemodificacionfw = nvl( c_PAGO.Seriemodificacionfw, [] )
					.Horaaltafw = nvl( c_PAGO.Horaaltafw, [] )
					.Estadotransferencia = nvl( c_PAGO.Estadotransferencia, [] )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_PAGO.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Basededatosaltafw = nvl( c_PAGO.Basededatosaltafw, [] )
					.Basededatosmodificacionfw = nvl( c_PAGO.Basededatosmodificacionfw, [] )
					.Timestamp = nvl( c_PAGO.Timestamp, 0 )
					.Tipocomprobante = nvl( c_PAGO.Tipocomprobante, 0 )
					.Ordendepago_pagodetalle.Limpiar()
					.Ordendepago_pagodetalle.SetearEsNavegacion( .lProcesando )
					.Ordendepago_pagodetalle.Cargar()
					.Ordendepago_PK =  nvl( c_PAGO.Ordendepago, [] )
					.Letra = nvl( c_PAGO.Letra, [] )
					.Ordendepago_valoresdetalle.Limpiar()
					.Ordendepago_valoresdetalle.SetearEsNavegacion( .lProcesando )
					.Ordendepago_valoresdetalle.Cargar()
					.Ordendepago_impuestoscomprobante.Limpiar()
					.Ordendepago_impuestoscomprobante.SetearEsNavegacion( .lProcesando )
					.Ordendepago_impuestoscomprobante.Cargar()
					.Ordendepago_proveedor_PK =  nvl( c_PAGO.Ordendepago_proveedor, [] )
					.Puntodeventa = nvl( c_PAGO.Puntodeventa, 0 )
					.Ordendepago_monedacomprobante_PK =  nvl( c_PAGO.Ordendepago_monedacomprobante, [] )
					lcValor = This.ObtenerMemo( 'c_Ordendepago_obs')
					.Ordendepago_obs = lcValor 
					.Ordendepago_fecha = GoLibrerias.ObtenerFechaFormateada( nvl( c_PAGO.Ordendepago_fecha, ctod( '  /  /    ' ) ) )
					.Numero = nvl( c_PAGO.Numero, 0 )
					.Fecha = GoLibrerias.ObtenerFechaFormateada( nvl( c_PAGO.Fecha, ctod( '  /  /    ' ) ) )
					.Ordendepago_cotizacion = nvl( c_PAGO.Ordendepago_cotizacion, 0 )
					.Recibo = nvl( c_PAGO.Recibo, [] )
					.Ordendepago_total = nvl( c_PAGO.Ordendepago_total, 0 )
					.Anulado = nvl( c_PAGO.Anulado, .F. )
					lcValor = This.ObtenerMemo( 'c_Observacion')
					.Observacion = lcValor 
					.Codigo = nvl( c_PAGO.Codigo, [] )
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
			lxRetorno = c_PAGO.CODIGO
		endif
		return lxRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function ActualizarLosNROItemDeLosDetalles() as void
		local loDetalle as object, loItem as object, lnContadorNroItem as integer, lnIndex as integer
		
		loDetalle = this.oEntidad.OrdenDePago_PagoDetalle
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

		loDetalle = this.oEntidad.OrdenDePago_ValoresDetalle
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

		loDetalle = this.oEntidad.OrdenDePago_ImpuestosComprobante
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
		return c_PAGO.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.PAGO' )
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
								from ZooLogic.PAGO 
								Where   PAGO.CODIGO != '' AND PAGO.FACTTIPO = 37
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "PAGO", "", lcCursor, set("Datasession") )
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
			"Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Zadsfw" as "Zadsfw", "Descfw" as "Descripcionfw", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Haltafw" as "Horaaltafw", "Esttrans" as "Estadotransferencia", "Faltafw" as "Fechaaltafw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Timestamp" as "Timestamp", "Facttipo" as "Tipocomprobante", "Opago" as "Ordendepago", "Fletra" as "Letra", "Fperson" as "Ordendepago_proveedor", "Fptoven" as "Puntodeventa", "Moneda" as "Ordendepago_monedacomprobante", "Fopobs" as "Ordendepago_obs", "Ffch" as "Ordendepago_fecha", "Fnumcomp" as "Numero", "Fechap" as "Fecha", "Cotiz" as "Ordendepago_cotizacion", "Recibo" as "Recibo", "Ftotal" as "Ordendepago_total", "Anulado" as "Anulado", "Fobs" as "Observacion", "Codigo" as "Codigo"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.PAGO 
								Where   PAGO.CODIGO != '' AND PAGO.FACTTIPO = 37
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
	Tabla = 'PAGO'
	Filtro = " PAGO.CODIGO != '' AND PAGO.FACTTIPO = 37"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " PAGO.CODIGO != '' AND PAGO.FACTTIPO = 37"
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
	<row entidad="PAGO                                    " atributo="FECHAMODIFICACIONFW                     " tabla="PAGO           " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PAGO                                    " atributo="FECHAEXPO                               " tabla="PAGO           " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PAGO                                    " atributo="FECHATRANSFERENCIA                      " tabla="PAGO           " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha de novedad                                                                                                                                                " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PAGO                                    " atributo="FECHAIMPO                               " tabla="PAGO           " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PAGO                                    " atributo="HORAIMPO                                " tabla="PAGO           " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PAGO                                    " atributo="HORAEXPO                                " tabla="PAGO           " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PAGO                                    " atributo="SERIEALTAFW                             " tabla="PAGO           " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PAGO                                    " atributo="HORAMODIFICACIONFW                      " tabla="PAGO           " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PAGO                                    " atributo="ZADSFW                                  " tabla="PAGO           " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PAGO                                    " atributo="DESCRIPCIONFW                           " tabla="PAGO           " campo="DESCFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="200" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PAGO                                    " atributo="VERSIONMODIFICACIONFW                   " tabla="PAGO           " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PAGO                                    " atributo="VERSIONALTAFW                           " tabla="PAGO           " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PAGO                                    " atributo="USUARIOALTAFW                           " tabla="PAGO           " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PAGO                                    " atributo="USUARIOMODIFICACIONFW                   " tabla="PAGO           " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PAGO                                    " atributo="SERIEMODIFICACIONFW                     " tabla="PAGO           " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PAGO                                    " atributo="HORAALTAFW                              " tabla="PAGO           " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="=goservicios.librerias.obtenerHora()                                                                                                                                                                                                                          " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PAGO                                    " atributo="ESTADOTRANSFERENCIA                     " tabla="PAGO           " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado de novedad                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PAGO                                    " atributo="FECHAALTAFW                             " tabla="PAGO           " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goservicios.librerias.obtenerFecha()                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PAGO                                    " atributo="BASEDEDATOSALTAFW                       " tabla="PAGO           " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PAGO                                    " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="PAGO           " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PAGO                                    " atributo="TIMESTAMP                               " tabla="PAGO           " campo="TIMESTAMP " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PAGO                                    " atributo="TIPOCOMPROBANTE                         " tabla="PAGO           " campo="FACTTIPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="=37                                                                                                                                                                                                                                                           " obligatorio="false" admitebusqueda="12" etiqueta="Tipo de comprobante                                                                                                                                             " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="1" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PAGO                                    " atributo="ORDENDEPAGO_PAGODETALLE                 " tabla="PAGODET        " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="Detalle                                                                                                                                                         " dominio="DETALLEITEMPAGO               " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PAGO                                    " atributo="ORDENDEPAGO                             " tabla="PAGO           " campo="OPAGO     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="ORDENDEPAGO                             " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="402" etiqueta="Orden de pago                                                                                                                                                   " dominio="CODIGOSINALTASEGUNPARAMETRO   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="X 9999-9999999999        " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PAGO                                    " atributo="LETRA                                   " tabla="PAGO           " campo="FLETRA    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="1" decimales="0" valorsugerido="=&quot;X&quot;                                                                                                                                                                                                                                                          " obligatorio="true" admitebusqueda="6" etiqueta="Letra                                                                                                                                                           " dominio="NUMEROCOMPROBANTE             " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="2" mascara="X 9999-9999999999        " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PAGO                                    " atributo="ORDENDEPAGO_VALORESDETALLE              " tabla="PAGOVAL        " campo="JJNUM     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="404" etiqueta="Valor                                                                                                                                                           " dominio="DETALLEITEMPAGOVALORES        " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="2" orden="1" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PAGO                                    " atributo="ORDENDEPAGO_IMPUESTOSCOMPROBANTE        " tabla="PAGOIMP        " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="406" etiqueta="Impuesto                                                                                                                                                        " dominio="DETALLEITEMIMPUESTOPAGO       " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="8" orden="1" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PAGO                                    " atributo="ORDENDEPAGO_PROVEEDOR                   " tabla="PAGO           " campo="FPERSON   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="PROVEEDOR                               " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="8" etiqueta="Proveedor                                                                                                                                                       " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="OrdendePago.Proveedor                                                                                                                                                                                                                                         " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PAGO                                    " atributo="PUNTODEVENTA                            " tabla="PAGO           " campo="FPTOVEN   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="4" decimales="0" valorsugerido="goServicios.Parametros.felino.Numeraciones.BocaDeExpendio                                                                                                                                                                                                     " obligatorio="true" admitebusqueda="4" etiqueta="Punto de venta                                                                                                                                                  " dominio="NUMEROCOMPROBANTE             " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="3" mascara="X 9999-9999999999        " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PAGO                                    " atributo="ORDENDEPAGO_MONEDACOMPROBANTE           " tabla="PAGO           " campo="MONEDA    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="MONEDA                                  " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="408" etiqueta="Moneda                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="OrdendePago.MonedaComprobante                                                                                                                                                                                                                                 " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PAGO                                    " atributo="ORDENDEPAGO_OBS                         " tabla="PAGO           " campo="FOPOBS    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="410" etiqueta="Obs. orden de pago                                                                                                                                              " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="OrdendePago.Obs                                                                                                                                                                                                                                               " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="2" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PAGO                                    " atributo="ORDENDEPAGO_FECHA                       " tabla="PAGO           " campo="FFCH      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="412" etiqueta="Fecha de la orden de pago                                                                                                                                       " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="OrdendePago.Fecha                                                                                                                                                                                                                                             " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PAGO                                    " atributo="NUMERO                                  " tabla="PAGO           " campo="FNUMCOMP  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="2" etiqueta="Número                                                                                                                                                          " dominio="NUMEROCOMPROBANTE             " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="4" mascara="X 9999-9999999999        " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PAGO                                    " atributo="FECHA                                   " tabla="PAGO           " campo="FECHAP    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=GOLIBRERIAS.OBTENERFECHA()                                                                                                                                                                                                                                   " obligatorio="true" admitebusqueda="414" etiqueta="Fecha de pago                                                                                                                                                   " dominio="FECHACOMPROBANTE              " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PAGO                                    " atributo="ORDENDEPAGO_COTIZACION                  " tabla="PAGO           " campo="COTIZ     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="5" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="416" etiqueta="Cotización                                                                                                                                                      " dominio="NUMERICONONEGATIVO            " detalle="false" tipo="E" atributoforaneo="OrdendePago.Cotizacion                                                                                                                                                                                                                                        " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PAGO                                    " atributo="RECIBO                                  " tabla="PAGO           " campo="RECIBO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="10" etiqueta="Recibo                                                                                                                                                          " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PAGO                                    " atributo="ORDENDEPAGO_TOTAL                       " tabla="PAGO           " campo="FTOTAL    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="418" etiqueta="Total                                                                                                                                                           " dominio="TOTALMULTIMONEDA              " detalle="false" tipo="E" atributoforaneo="OrdendePago.Total                                                                                                                                                                                                                                             " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="4" subgrupo="0" orden="8" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PAGO                                    " atributo="ANULADO                                 " tabla="PAGO           " campo="ANULADO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Anulado                                                                                                                                                         " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="13" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PAGO                                    " atributo="OBSERVACION                             " tabla="PAGO           " campo="FOBS      " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="420" etiqueta="Obs.                                                                                                                                                            " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="4" subgrupo="1" orden="13" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PAGO                                    " atributo="CODIGO                                  " tabla="PAGO           " campo="CODIGO    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="0" etiqueta="Código                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="15" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPAGO                             " atributo="USUARIO                                 " tabla="ORDPAGO        " campo="FVEN      " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="=goServicios.Seguridad.cUsuarioLogueado                                                                                                                                                                                                                       " obligatorio="false" admitebusqueda="403" etiqueta="Detalle Ord.                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join ORDPAGO On PAGO.OPAGO = ORDPAGO.CODIGO And  ORDPAGO.CODIGO != '' AND ORDPAGO.FACTTIPO = 31                                                                                                                                                         " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="NOMBRE                                  " tabla="PROV           " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="9" etiqueta="Detalle Pro.                                                                                                                                                    " dominio="TEXTOBUSQUEDA                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join PROV On PAGO.FPERSON = PROV.CLCOD And  PROV.CLCOD != ''                                                                                                                                                                                            " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="5" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MONEDA                                  " atributo="DESCRIPCION                             " tabla="MONEDA         " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="409" etiqueta="Detalle Mon.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join MONEDA On PAGO.MONEDA = MONEDA.Codigo And  MONEDA.CODIGO != ''                                                                                                                                                                                     " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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