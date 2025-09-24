
define class Din_EntidadCANJEDECUPONESAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_CANJEDECUPONES'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = [str( TipoComprobante, 2, 0) + Letra + str( PuntoDeVenta, 4, 0) + str( Numero, 12, 0)]
	cExpresionCCPorCampos = [str( #tabla#.FACTTIPO, 2, 0) + #tabla#.FLETRA + str( #tabla#.FPTOVEN, 4, 0) + str( #tabla#.Numero, 12, 0)]
	cTagClaveCandidata = '_CDVCC'
	cTagClavePk = '_CDVPK'
	cTablaPrincipal = 'CANJECUPONES'
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
			local  lxCanjecuponesFaltafw, lxCanjecuponesFectrans, lxCanjecuponesFecexpo, lxCanjecuponesFecimpo, lxCanjecuponesFmodifw, lxCanjecuponesFacttipo, lxCanjecuponesValtip, lxCanjecuponesSigno, lxCanjecuponesHoraexpo, lxCanjecuponesHoraimpo, lxCanjecuponesBdaltafw, lxCanjecuponesHaltafw, lxCanjecuponesEsttrans, lxCanjecuponesBdmodifw, lxCanjecuponesValordet, lxCanjecuponesZadsfw, lxCanjecuponesHmodifw, lxCanjecuponesUaltafw, lxCanjecuponesUmodifw, lxCanjecuponesSmodifw, lxCanjecuponesVmodifw, lxCanjecuponesValtafw, lxCanjecuponesDescfw, lxCanjecuponesSaltafw, lxCanjecuponesCupon, lxCanjecuponesIdcaja, lxCanjecuponesCodigo, lxCanjecuponesMoneda, lxCanjecuponesValor, lxCanjecuponesFletra, lxCanjecuponesComptipo, lxCanjecuponesCliente, lxCanjecuponesObs, lxCanjecuponesFptoven, lxCanjecuponesLetra, lxCanjecuponesProveedor, lxCanjecuponesNumero, lxCanjecuponesFecha, lxCanjecuponesPtoven, lxCanjecuponesTipo, lxCanjecuponesConcepto, lxCanjecuponesNumcomp, lxCanjecuponesNumerocup, lxCanjecuponesVendedor, lxCanjecuponesFechacomp, lxCanjecuponesFechacup, lxCanjecuponesBasedatos, lxCanjecuponesFtotal, lxCanjecuponesHora, lxCanjecuponesSerie, lxCanjecuponesMonto, lxCanjecuponesAnulado
				lxCanjecuponesFaltafw =  .Fechaaltafw			lxCanjecuponesFectrans =  .Fechatransferencia			lxCanjecuponesFecexpo =  .Fechaexpo			lxCanjecuponesFecimpo =  .Fechaimpo			lxCanjecuponesFmodifw =  .Fechamodificacionfw			lxCanjecuponesFacttipo =  .Tipocomprobante			lxCanjecuponesValtip =  .Cuponvalortipo			lxCanjecuponesSigno =  .Signodemovimiento			lxCanjecuponesHoraexpo =  .Horaexpo			lxCanjecuponesHoraimpo =  .Horaimpo			lxCanjecuponesBdaltafw =  .Basededatosaltafw			lxCanjecuponesHaltafw =  .Horaaltafw			lxCanjecuponesEsttrans =  .Estadotransferencia			lxCanjecuponesBdmodifw =  .Basededatosmodificacionfw			lxCanjecuponesValordet =  .Cuponvalordetalle			lxCanjecuponesZadsfw =  .Zadsfw			lxCanjecuponesHmodifw =  .Horamodificacionfw			lxCanjecuponesUaltafw =  .Usuarioaltafw			lxCanjecuponesUmodifw =  .Usuariomodificacionfw			lxCanjecuponesSmodifw =  .Seriemodificacionfw			lxCanjecuponesVmodifw =  .Versionmodificacionfw			lxCanjecuponesValtafw =  .Versionaltafw			lxCanjecuponesDescfw =  .Descripcionfw			lxCanjecuponesSaltafw =  .Seriealtafw			lxCanjecuponesCupon =  upper( .Cupon_PK ) 			lxCanjecuponesIdcaja =  .Cuponidcaja_PK 			lxCanjecuponesCodigo =  .Codigo			lxCanjecuponesMoneda =  upper( .MonedaComprobante_PK ) 			lxCanjecuponesValor =  upper( .CuponValor_PK ) 			lxCanjecuponesFletra =  .Letra			lxCanjecuponesComptipo =  .Cupontipocomprobante			lxCanjecuponesCliente =  upper( .Cliente_PK ) 			lxCanjecuponesObs =  .Obs			lxCanjecuponesFptoven =  .Puntodeventa			lxCanjecuponesLetra =  .Cuponletracomprobante			lxCanjecuponesProveedor =  upper( .Proveedor_PK ) 			lxCanjecuponesNumero =  .Numero			lxCanjecuponesFecha =  .Fecha			lxCanjecuponesPtoven =  .Cuponpuntodeventacomprobante			lxCanjecuponesTipo =  .Cupontipo			lxCanjecuponesConcepto =  upper( .Concepto_PK ) 			lxCanjecuponesNumcomp =  .Cuponnumerocomprobante			lxCanjecuponesNumerocup =  .Cuponnumerocupon			lxCanjecuponesVendedor =  upper( .Vendedor_PK ) 			lxCanjecuponesFechacomp =  .Cuponfechacomprobante			lxCanjecuponesFechacup =  .Cuponfecha			lxCanjecuponesBasedatos =  .Cuponbasededatos			lxCanjecuponesFtotal =  .Total			lxCanjecuponesHora =  .Cuponhora			lxCanjecuponesSerie =  .Cuponserieorigen			lxCanjecuponesMonto =  .Cuponmonto			lxCanjecuponesAnulado =  .Anulado
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxCanjecuponesCodigo = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.CANJECUPONES ( "Faltafw","Fectrans","Fecexpo","Fecimpo","Fmodifw","Facttipo","Valtip","Signo","Horaexpo","Horaimpo","Bdaltafw","Haltafw","Esttrans","Bdmodifw","Valordet","Zadsfw","Hmodifw","Ualtafw","Umodifw","Smodifw","Vmodifw","Valtafw","Descfw","Saltafw","Cupon","Idcaja","Codigo","Moneda","Valor","Fletra","Comptipo","Cliente","Obs","Fptoven","Letra","Proveedor","Numero","Fecha","Ptoven","Tipo","Concepto","Numcomp","Numerocup","Vendedor","Fechacomp","Fechacup","Basedatos","Ftotal","Hora","Serie","Monto","Anulado" ) values ( <<"'" + this.ConvertirDateSql( lxCanjecuponesFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCanjecuponesFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCanjecuponesFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCanjecuponesFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCanjecuponesFmodifw ) + "'" >>, <<lxCanjecuponesFacttipo >>, <<lxCanjecuponesValtip >>, <<lxCanjecuponesSigno >>, <<"'" + this.FormatearTextoSql( lxCanjecuponesHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanjecuponesHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanjecuponesBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanjecuponesHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanjecuponesEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanjecuponesBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanjecuponesValordet ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanjecuponesZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanjecuponesHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanjecuponesUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanjecuponesUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanjecuponesSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanjecuponesVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanjecuponesValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanjecuponesDescfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanjecuponesSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanjecuponesCupon ) + "'" >>, <<lxCanjecuponesIdcaja >>, <<"'" + this.FormatearTextoSql( lxCanjecuponesCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanjecuponesMoneda ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanjecuponesValor ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanjecuponesFletra ) + "'" >>, <<lxCanjecuponesComptipo >>, <<"'" + this.FormatearTextoSql( lxCanjecuponesCliente ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanjecuponesObs ) + "'" >>, <<lxCanjecuponesFptoven >>, <<"'" + this.FormatearTextoSql( lxCanjecuponesLetra ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanjecuponesProveedor ) + "'" >>, <<lxCanjecuponesNumero >>, <<"'" + this.ConvertirDateSql( lxCanjecuponesFecha ) + "'" >>, <<lxCanjecuponesPtoven >>, <<"'" + this.FormatearTextoSql( lxCanjecuponesTipo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanjecuponesConcepto ) + "'" >>, <<lxCanjecuponesNumcomp >>, <<lxCanjecuponesNumerocup >>, <<"'" + this.FormatearTextoSql( lxCanjecuponesVendedor ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCanjecuponesFechacomp ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCanjecuponesFechacup ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanjecuponesBasedatos ) + "'" >>, <<lxCanjecuponesFtotal >>, <<"'" + this.FormatearTextoSql( lxCanjecuponesHora ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanjecuponesSerie ) + "'" >>, <<lxCanjecuponesMonto >>, <<iif( lxCanjecuponesAnulado, 1, 0 ) >> )
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
			for each loItem in this.oEntidad.ValoresDetalle
				if this.oEntidad.ValoresDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxFechaultcotizacion = loItem.Fechaultcotizacion
					lxFechacomp = loItem.Fechacomp
					lxCaja_PK = loItem.Caja_PK
					lxTipo = loItem.Tipo
					lxUltimacotizacion = loItem.Ultimacotizacion
					lxSigno = loItem.Signo
					lxTurno = loItem.Turno
					lxPuntodeventa = loItem.Puntodeventa
					lxCotiza = loItem.Cotiza
					lxNroitem = lnContadorNroItem
					lxNumerocupon = loItem.Numerocupon
					lxNumerodecomprobante = loItem.Numerodecomprobante
					lxAutorizacionpos = loItem.Autorizacionpos
					lxPersonalizarcomprobante = loItem.Personalizarcomprobante
					lxVisualizarenestadodecaja = loItem.Visualizarenestadodecaja
					lxChequeelectronico = loItem.Chequeelectronico
					lxLetra = loItem.Letra
					lxNrodocumento = loItem.Nrodocumento
					lxTipodecomprobante = loItem.Tipodecomprobante
					lxNumerotarjeta = loItem.Numerotarjeta
					lxVendedor = loItem.Vendedor
					lxTipodocumento = loItem.Tipodocumento
					lxNumerocheque_PK = loItem.Numerocheque_PK
					lxNumerochequepropio_PK = loItem.Numerochequepropio_PK
					lxValor_PK = loItem.Valor_PK
					lxValordetalle = loItem.Valordetalle
					lxFecha = loItem.Fecha
					lxNumerointerno = loItem.Numerointerno
					lxMonto = loItem.Monto
					lxRecargoporcentaje = loItem.Recargoporcentaje
					lxRecargomonto = loItem.Recargomonto
					lxTotal = loItem.Total
					lxPesosalcambio = loItem.Pesosalcambio
					lxRecargomontosinimpuestos = loItem.Recargomontosinimpuestos
					lxMontoamonedasistema = loItem.Montoamonedasistema
					lxRecargosinpercepciones = loItem.Recargosinpercepciones
					lxPermitevuelto = loItem.Permitevuelto
					lxIditemcomponente = loItem.Iditemcomponente
					lxCodigodecupon = loItem.Codigodecupon
					lxCupon_PK = loItem.Cupon_PK
					lxNumerovaledecambio_PK = loItem.Numerovaledecambio_PK
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.CanjeCuponesDet("FechCoti","JJfecha","IdCaja","JJT","Cotiza","Signo","JJTurno","PtoVenta","JJCotiz","NroItem","NroCupon","NumCompr","Autorizado","PersComp","VisualCaja","CElectro","Letra","NroDoc","TIPCOMP","NroTarjeta","JJVen","TipoDoc","JJNUM","NroCheque","NroChProp","JJCO","JJDE","JJFE","NroInterno","JJM","jrecporc","jrecmnt","JJTotFac","Pesos","jrecmntsi","Montosiste","jrrecsperc","permvuelto","guidComp","guidCupon","Cupon","ValeCambio" ) values ( <<"'" + this.ConvertirDateSql( lxFechaultcotizacion ) + "'">>, <<"'" + this.ConvertirDateSql( lxFechacomp ) + "'">>, <<lxCaja_PK>>, <<lxTipo>>, <<lxUltimacotizacion>>, <<lxSigno>>, <<lxTurno>>, <<lxPuntodeventa>>, <<lxCotiza>>, <<lxNroitem>>, <<lxNumerocupon>>, <<lxNumerodecomprobante>>, <<iif( lxAutorizacionpos, 1, 0 )>>, <<iif( lxPersonalizarcomprobante, 1, 0 )>>, <<iif( lxVisualizarenestadodecaja, 1, 0 )>>, <<iif( lxChequeelectronico, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxLetra ) + "'">>, <<"'" + this.FormatearTextoSql( lxNrodocumento ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipodecomprobante ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerotarjeta ) + "'">>, <<"'" + this.FormatearTextoSql( lxVendedor ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipodocumento ) + "'">>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerocheque_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerochequepropio_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValordetalle ) + "'">>, <<"'" + this.ConvertirDateSql( lxFecha ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerointerno ) + "'">>, <<lxMonto>>, <<lxRecargoporcentaje>>, <<lxRecargomonto>>, <<lxTotal>>, <<lxPesosalcambio>>, <<lxRecargomontosinimpuestos>>, <<lxMontoamonedasistema>>, <<lxRecargosinpercepciones>>, <<iif( lxPermitevuelto, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxIditemcomponente ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigodecupon ) + "'">>, <<"'" + this.FormatearTextoSql( lxCupon_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerovaledecambio_PK ) + "'">> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ValoresAEnt
				if this.oEntidad.ValoresAEnt.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxFechacomp = loItem.Fechacomp
					lxFechaultcotizacion = loItem.Fechaultcotizacion
					lxCaja_PK = loItem.Caja_PK
					lxSignodemovimiento = loItem.Signodemovimiento
					lxNumerocupon = loItem.Numerocupon
					lxUltimacotizacion = loItem.Ultimacotizacion
					lxCotiza = loItem.Cotiza
					lxNroitem = lnContadorNroItem
					lxTipo = loItem.Tipo
					lxAutorizacionpos = loItem.Autorizacionpos
					lxChequeelectronico = loItem.Chequeelectronico
					lxVisualizarenestadodecaja = loItem.Visualizarenestadodecaja
					lxNumerotarjeta = loItem.Numerotarjeta
					lxValor_PK = loItem.Valor_PK
					lxNumerochequepropio_PK = loItem.Numerochequepropio_PK
					lxNumerocheque_PK = loItem.Numerocheque_PK
					lxLetracomprobante = loItem.Letracomprobante
					lxValordetalle = loItem.Valordetalle
					lxFecha = loItem.Fecha
					lxPuntodeventacomprobante = loItem.Puntodeventacomprobante
					lxNrocomprobante = loItem.Nrocomprobante
					lxNumerointerno = loItem.Numerointerno
					lxCupontipo = loItem.Cupontipo
					lxFechacomprobante = loItem.Fechacomprobante
					lxTipocomprobante = loItem.Tipocomprobante
					lxBasededatosorigen = loItem.Basededatosorigen
					lxHora = loItem.Hora
					lxMonto = loItem.Monto
					lxTotal = loItem.Total
					lxSerieorigen = loItem.Serieorigen
					lxPesosalcambio = loItem.Pesosalcambio
					lxMontoamonedasistema = loItem.Montoamonedasistema
					lxMontocupon = loItem.Montocupon
					lxIditemcomponente = loItem.Iditemcomponente
					lxCodigodecupon = loItem.Codigodecupon
					lxCupon_PK = loItem.Cupon_PK
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.CanjeCuponesEnt("JJfecha","FechCoti","IdCaja","Signo","NroCupon","Cotiza","JJCotiz","NROITEM","JJT","Autorizado","CElectro","VisualCaja","NroTarjeta","JJCO","Codigo","NroChProp","NroCheque","Letra","JJDE","JJFE","PtoVen","NumCompr","NroInterno","tipo","FechaComp","TipComp","BaseDatos","Hora","JJM","JJTotFac","Serie","Pesos","Montosiste","MonCupon","guidComp","guidCupon","Cupon" ) values ( <<"'" + this.ConvertirDateSql( lxFechacomp ) + "'">>, <<"'" + this.ConvertirDateSql( lxFechaultcotizacion ) + "'">>, <<lxCaja_PK>>, <<lxSignodemovimiento>>, <<lxNumerocupon>>, <<lxUltimacotizacion>>, <<lxCotiza>>, <<lxNroitem>>, <<lxTipo>>, <<iif( lxAutorizacionpos, 1, 0 )>>, <<iif( lxChequeelectronico, 1, 0 )>>, <<iif( lxVisualizarenestadodecaja, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxNumerotarjeta ) + "'">>, <<"'" + this.FormatearTextoSql( lxValor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerochequepropio_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerocheque_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxLetracomprobante ) + "'">>, <<"'" + this.FormatearTextoSql( lxValordetalle ) + "'">>, <<"'" + this.ConvertirDateSql( lxFecha ) + "'">>, <<lxPuntodeventacomprobante>>, <<lxNrocomprobante>>, <<"'" + this.FormatearTextoSql( lxNumerointerno ) + "'">>, <<"'" + this.FormatearTextoSql( lxCupontipo ) + "'">>, <<"'" + this.ConvertirDateSql( lxFechacomprobante ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipocomprobante ) + "'">>, <<"'" + this.FormatearTextoSql( lxBasededatosorigen ) + "'">>, <<"'" + this.FormatearTextoSql( lxHora ) + "'">>, <<lxMonto>>, <<lxTotal>>, <<"'" + this.FormatearTextoSql( lxSerieorigen ) + "'">>, <<lxPesosalcambio>>, <<lxMontoamonedasistema>>, <<lxMontocupon>>, <<"'" + this.FormatearTextoSql( lxIditemcomponente ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigodecupon ) + "'">>, <<"'" + this.FormatearTextoSql( lxCupon_PK ) + "'">> ) 
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
			local  lxCanjecuponesFaltafw, lxCanjecuponesFectrans, lxCanjecuponesFecexpo, lxCanjecuponesFecimpo, lxCanjecuponesFmodifw, lxCanjecuponesFacttipo, lxCanjecuponesValtip, lxCanjecuponesSigno, lxCanjecuponesHoraexpo, lxCanjecuponesHoraimpo, lxCanjecuponesBdaltafw, lxCanjecuponesHaltafw, lxCanjecuponesEsttrans, lxCanjecuponesBdmodifw, lxCanjecuponesValordet, lxCanjecuponesZadsfw, lxCanjecuponesHmodifw, lxCanjecuponesUaltafw, lxCanjecuponesUmodifw, lxCanjecuponesSmodifw, lxCanjecuponesVmodifw, lxCanjecuponesValtafw, lxCanjecuponesDescfw, lxCanjecuponesSaltafw, lxCanjecuponesCupon, lxCanjecuponesIdcaja, lxCanjecuponesCodigo, lxCanjecuponesMoneda, lxCanjecuponesValor, lxCanjecuponesFletra, lxCanjecuponesComptipo, lxCanjecuponesCliente, lxCanjecuponesObs, lxCanjecuponesFptoven, lxCanjecuponesLetra, lxCanjecuponesProveedor, lxCanjecuponesNumero, lxCanjecuponesFecha, lxCanjecuponesPtoven, lxCanjecuponesTipo, lxCanjecuponesConcepto, lxCanjecuponesNumcomp, lxCanjecuponesNumerocup, lxCanjecuponesVendedor, lxCanjecuponesFechacomp, lxCanjecuponesFechacup, lxCanjecuponesBasedatos, lxCanjecuponesFtotal, lxCanjecuponesHora, lxCanjecuponesSerie, lxCanjecuponesMonto, lxCanjecuponesAnulado
				lxCanjecuponesFaltafw =  .Fechaaltafw			lxCanjecuponesFectrans =  .Fechatransferencia			lxCanjecuponesFecexpo =  .Fechaexpo			lxCanjecuponesFecimpo =  .Fechaimpo			lxCanjecuponesFmodifw =  .Fechamodificacionfw			lxCanjecuponesFacttipo =  .Tipocomprobante			lxCanjecuponesValtip =  .Cuponvalortipo			lxCanjecuponesSigno =  .Signodemovimiento			lxCanjecuponesHoraexpo =  .Horaexpo			lxCanjecuponesHoraimpo =  .Horaimpo			lxCanjecuponesBdaltafw =  .Basededatosaltafw			lxCanjecuponesHaltafw =  .Horaaltafw			lxCanjecuponesEsttrans =  .Estadotransferencia			lxCanjecuponesBdmodifw =  .Basededatosmodificacionfw			lxCanjecuponesValordet =  .Cuponvalordetalle			lxCanjecuponesZadsfw =  .Zadsfw			lxCanjecuponesHmodifw =  .Horamodificacionfw			lxCanjecuponesUaltafw =  .Usuarioaltafw			lxCanjecuponesUmodifw =  .Usuariomodificacionfw			lxCanjecuponesSmodifw =  .Seriemodificacionfw			lxCanjecuponesVmodifw =  .Versionmodificacionfw			lxCanjecuponesValtafw =  .Versionaltafw			lxCanjecuponesDescfw =  .Descripcionfw			lxCanjecuponesSaltafw =  .Seriealtafw			lxCanjecuponesCupon =  upper( .Cupon_PK ) 			lxCanjecuponesIdcaja =  .Cuponidcaja_PK 			lxCanjecuponesCodigo =  .Codigo			lxCanjecuponesMoneda =  upper( .MonedaComprobante_PK ) 			lxCanjecuponesValor =  upper( .CuponValor_PK ) 			lxCanjecuponesFletra =  .Letra			lxCanjecuponesComptipo =  .Cupontipocomprobante			lxCanjecuponesCliente =  upper( .Cliente_PK ) 			lxCanjecuponesObs =  .Obs			lxCanjecuponesFptoven =  .Puntodeventa			lxCanjecuponesLetra =  .Cuponletracomprobante			lxCanjecuponesProveedor =  upper( .Proveedor_PK ) 			lxCanjecuponesNumero =  .Numero			lxCanjecuponesFecha =  .Fecha			lxCanjecuponesPtoven =  .Cuponpuntodeventacomprobante			lxCanjecuponesTipo =  .Cupontipo			lxCanjecuponesConcepto =  upper( .Concepto_PK ) 			lxCanjecuponesNumcomp =  .Cuponnumerocomprobante			lxCanjecuponesNumerocup =  .Cuponnumerocupon			lxCanjecuponesVendedor =  upper( .Vendedor_PK ) 			lxCanjecuponesFechacomp =  .Cuponfechacomprobante			lxCanjecuponesFechacup =  .Cuponfecha			lxCanjecuponesBasedatos =  .Cuponbasededatos			lxCanjecuponesFtotal =  .Total			lxCanjecuponesHora =  .Cuponhora			lxCanjecuponesSerie =  .Cuponserieorigen			lxCanjecuponesMonto =  .Cuponmonto			lxCanjecuponesAnulado =  .Anulado
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()
			lxValorClavePrimaria = .oEntidad.CODIGO
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ZooLogic.CANJECUPONES set "Faltafw" = <<"'" + this.ConvertirDateSql( lxCanjecuponesFaltafw ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxCanjecuponesFectrans ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxCanjecuponesFecexpo ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxCanjecuponesFecimpo ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxCanjecuponesFmodifw ) + "'">>,"Facttipo" = <<lxCanjecuponesFacttipo>>,"Valtip" = <<lxCanjecuponesValtip>>,"Signo" = <<lxCanjecuponesSigno>>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxCanjecuponesHoraexpo ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxCanjecuponesHoraimpo ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxCanjecuponesBdaltafw ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxCanjecuponesHaltafw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxCanjecuponesEsttrans ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxCanjecuponesBdmodifw ) + "'">>,"Valordet" = <<"'" + this.FormatearTextoSql( lxCanjecuponesValordet ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxCanjecuponesZadsfw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxCanjecuponesHmodifw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxCanjecuponesUaltafw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxCanjecuponesUmodifw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxCanjecuponesSmodifw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxCanjecuponesVmodifw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxCanjecuponesValtafw ) + "'">>,"Descfw" = <<"'" + this.FormatearTextoSql( lxCanjecuponesDescfw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxCanjecuponesSaltafw ) + "'">>,"Cupon" = <<"'" + this.FormatearTextoSql( lxCanjecuponesCupon ) + "'">>,"Idcaja" = <<lxCanjecuponesIdcaja>>,"Codigo" = <<"'" + this.FormatearTextoSql( lxCanjecuponesCodigo ) + "'">>,"Moneda" = <<"'" + this.FormatearTextoSql( lxCanjecuponesMoneda ) + "'">>,"Valor" = <<"'" + this.FormatearTextoSql( lxCanjecuponesValor ) + "'">>,"Fletra" = <<"'" + this.FormatearTextoSql( lxCanjecuponesFletra ) + "'">>,"Comptipo" = <<lxCanjecuponesComptipo>>,"Cliente" = <<"'" + this.FormatearTextoSql( lxCanjecuponesCliente ) + "'">>,"Obs" = <<"'" + this.FormatearTextoSql( lxCanjecuponesObs ) + "'">>,"Fptoven" = <<lxCanjecuponesFptoven>>,"Letra" = <<"'" + this.FormatearTextoSql( lxCanjecuponesLetra ) + "'">>,"Proveedor" = <<"'" + this.FormatearTextoSql( lxCanjecuponesProveedor ) + "'">>,"Numero" = <<lxCanjecuponesNumero>>,"Fecha" = <<"'" + this.ConvertirDateSql( lxCanjecuponesFecha ) + "'">>,"Ptoven" = <<lxCanjecuponesPtoven>>,"Tipo" = <<"'" + this.FormatearTextoSql( lxCanjecuponesTipo ) + "'">>,"Concepto" = <<"'" + this.FormatearTextoSql( lxCanjecuponesConcepto ) + "'">>,"Numcomp" = <<lxCanjecuponesNumcomp>>,"Numerocup" = <<lxCanjecuponesNumerocup>>,"Vendedor" = <<"'" + this.FormatearTextoSql( lxCanjecuponesVendedor ) + "'">>,"Fechacomp" = <<"'" + this.ConvertirDateSql( lxCanjecuponesFechacomp ) + "'">>,"Fechacup" = <<"'" + this.ConvertirDateSql( lxCanjecuponesFechacup ) + "'">>,"Basedatos" = <<"'" + this.FormatearTextoSql( lxCanjecuponesBasedatos ) + "'">>,"Ftotal" = <<lxCanjecuponesFtotal>>,"Hora" = <<"'" + this.FormatearTextoSql( lxCanjecuponesHora ) + "'">>,"Serie" = <<"'" + this.FormatearTextoSql( lxCanjecuponesSerie ) + "'">>,"Monto" = <<lxCanjecuponesMonto>>,"Anulado" = <<iif( lxCanjecuponesAnulado, 1, 0 )>> where "Codigo" = <<"'" + this.FormatearTextoSql( lxCanjecuponesCodigo ) + "'">> and  CANJECUPONES.CODIGO != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			this.ComprobarResultadoDeEjecucionDelUpdate()
		this.ComprobarTransaccion()
			.EjecutarSentencias( This.ColSentencias )
		this.ComprobarTransaccion()
			this.oConexion.EjecutarSql( 'delete from ZooLogic.CanjeCuponesDet where "JJNUM" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.CanjeCuponesEnt where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ValoresDetalle
				if this.oEntidad.ValoresDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxFechaultcotizacion = loItem.Fechaultcotizacion
					lxFechacomp = loItem.Fechacomp
					lxCaja_PK = loItem.Caja_PK
					lxTipo = loItem.Tipo
					lxUltimacotizacion = loItem.Ultimacotizacion
					lxSigno = loItem.Signo
					lxTurno = loItem.Turno
					lxPuntodeventa = loItem.Puntodeventa
					lxCotiza = loItem.Cotiza
					lxNroitem = lnContadorNroItem
					lxNumerocupon = loItem.Numerocupon
					lxNumerodecomprobante = loItem.Numerodecomprobante
					lxAutorizacionpos = loItem.Autorizacionpos
					lxPersonalizarcomprobante = loItem.Personalizarcomprobante
					lxVisualizarenestadodecaja = loItem.Visualizarenestadodecaja
					lxChequeelectronico = loItem.Chequeelectronico
					lxLetra = loItem.Letra
					lxNrodocumento = loItem.Nrodocumento
					lxTipodecomprobante = loItem.Tipodecomprobante
					lxNumerotarjeta = loItem.Numerotarjeta
					lxVendedor = loItem.Vendedor
					lxTipodocumento = loItem.Tipodocumento
					lxNumerocheque_PK = loItem.Numerocheque_PK
					lxNumerochequepropio_PK = loItem.Numerochequepropio_PK
					lxValor_PK = loItem.Valor_PK
					lxValordetalle = loItem.Valordetalle
					lxFecha = loItem.Fecha
					lxNumerointerno = loItem.Numerointerno
					lxMonto = loItem.Monto
					lxRecargoporcentaje = loItem.Recargoporcentaje
					lxRecargomonto = loItem.Recargomonto
					lxTotal = loItem.Total
					lxPesosalcambio = loItem.Pesosalcambio
					lxRecargomontosinimpuestos = loItem.Recargomontosinimpuestos
					lxMontoamonedasistema = loItem.Montoamonedasistema
					lxRecargosinpercepciones = loItem.Recargosinpercepciones
					lxPermitevuelto = loItem.Permitevuelto
					lxIditemcomponente = loItem.Iditemcomponente
					lxCodigodecupon = loItem.Codigodecupon
					lxCupon_PK = loItem.Cupon_PK
					lxNumerovaledecambio_PK = loItem.Numerovaledecambio_PK
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.CanjeCuponesDet("FechCoti","JJfecha","IdCaja","JJT","Cotiza","Signo","JJTurno","PtoVenta","JJCotiz","NroItem","NroCupon","NumCompr","Autorizado","PersComp","VisualCaja","CElectro","Letra","NroDoc","TIPCOMP","NroTarjeta","JJVen","TipoDoc","JJNUM","NroCheque","NroChProp","JJCO","JJDE","JJFE","NroInterno","JJM","jrecporc","jrecmnt","JJTotFac","Pesos","jrecmntsi","Montosiste","jrrecsperc","permvuelto","guidComp","guidCupon","Cupon","ValeCambio" ) values ( <<"'" + this.ConvertirDateSql( lxFechaultcotizacion ) + "'">>, <<"'" + this.ConvertirDateSql( lxFechacomp ) + "'">>, <<lxCaja_PK>>, <<lxTipo>>, <<lxUltimacotizacion>>, <<lxSigno>>, <<lxTurno>>, <<lxPuntodeventa>>, <<lxCotiza>>, <<lxNroitem>>, <<lxNumerocupon>>, <<lxNumerodecomprobante>>, <<iif( lxAutorizacionpos, 1, 0 )>>, <<iif( lxPersonalizarcomprobante, 1, 0 )>>, <<iif( lxVisualizarenestadodecaja, 1, 0 )>>, <<iif( lxChequeelectronico, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxLetra ) + "'">>, <<"'" + this.FormatearTextoSql( lxNrodocumento ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipodecomprobante ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerotarjeta ) + "'">>, <<"'" + this.FormatearTextoSql( lxVendedor ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipodocumento ) + "'">>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerocheque_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerochequepropio_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValordetalle ) + "'">>, <<"'" + this.ConvertirDateSql( lxFecha ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerointerno ) + "'">>, <<lxMonto>>, <<lxRecargoporcentaje>>, <<lxRecargomonto>>, <<lxTotal>>, <<lxPesosalcambio>>, <<lxRecargomontosinimpuestos>>, <<lxMontoamonedasistema>>, <<lxRecargosinpercepciones>>, <<iif( lxPermitevuelto, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxIditemcomponente ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigodecupon ) + "'">>, <<"'" + this.FormatearTextoSql( lxCupon_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerovaledecambio_PK ) + "'">> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ValoresAEnt
				if this.oEntidad.ValoresAEnt.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxFechacomp = loItem.Fechacomp
					lxFechaultcotizacion = loItem.Fechaultcotizacion
					lxCaja_PK = loItem.Caja_PK
					lxSignodemovimiento = loItem.Signodemovimiento
					lxNumerocupon = loItem.Numerocupon
					lxUltimacotizacion = loItem.Ultimacotizacion
					lxCotiza = loItem.Cotiza
					lxNroitem = lnContadorNroItem
					lxTipo = loItem.Tipo
					lxAutorizacionpos = loItem.Autorizacionpos
					lxChequeelectronico = loItem.Chequeelectronico
					lxVisualizarenestadodecaja = loItem.Visualizarenestadodecaja
					lxNumerotarjeta = loItem.Numerotarjeta
					lxValor_PK = loItem.Valor_PK
					lxNumerochequepropio_PK = loItem.Numerochequepropio_PK
					lxNumerocheque_PK = loItem.Numerocheque_PK
					lxLetracomprobante = loItem.Letracomprobante
					lxValordetalle = loItem.Valordetalle
					lxFecha = loItem.Fecha
					lxPuntodeventacomprobante = loItem.Puntodeventacomprobante
					lxNrocomprobante = loItem.Nrocomprobante
					lxNumerointerno = loItem.Numerointerno
					lxCupontipo = loItem.Cupontipo
					lxFechacomprobante = loItem.Fechacomprobante
					lxTipocomprobante = loItem.Tipocomprobante
					lxBasededatosorigen = loItem.Basededatosorigen
					lxHora = loItem.Hora
					lxMonto = loItem.Monto
					lxTotal = loItem.Total
					lxSerieorigen = loItem.Serieorigen
					lxPesosalcambio = loItem.Pesosalcambio
					lxMontoamonedasistema = loItem.Montoamonedasistema
					lxMontocupon = loItem.Montocupon
					lxIditemcomponente = loItem.Iditemcomponente
					lxCodigodecupon = loItem.Codigodecupon
					lxCupon_PK = loItem.Cupon_PK
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.CanjeCuponesEnt("JJfecha","FechCoti","IdCaja","Signo","NroCupon","Cotiza","JJCotiz","NROITEM","JJT","Autorizado","CElectro","VisualCaja","NroTarjeta","JJCO","Codigo","NroChProp","NroCheque","Letra","JJDE","JJFE","PtoVen","NumCompr","NroInterno","tipo","FechaComp","TipComp","BaseDatos","Hora","JJM","JJTotFac","Serie","Pesos","Montosiste","MonCupon","guidComp","guidCupon","Cupon" ) values ( <<"'" + this.ConvertirDateSql( lxFechacomp ) + "'">>, <<"'" + this.ConvertirDateSql( lxFechaultcotizacion ) + "'">>, <<lxCaja_PK>>, <<lxSignodemovimiento>>, <<lxNumerocupon>>, <<lxUltimacotizacion>>, <<lxCotiza>>, <<lxNroitem>>, <<lxTipo>>, <<iif( lxAutorizacionpos, 1, 0 )>>, <<iif( lxChequeelectronico, 1, 0 )>>, <<iif( lxVisualizarenestadodecaja, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxNumerotarjeta ) + "'">>, <<"'" + this.FormatearTextoSql( lxValor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerochequepropio_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerocheque_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxLetracomprobante ) + "'">>, <<"'" + this.FormatearTextoSql( lxValordetalle ) + "'">>, <<"'" + this.ConvertirDateSql( lxFecha ) + "'">>, <<lxPuntodeventacomprobante>>, <<lxNrocomprobante>>, <<"'" + this.FormatearTextoSql( lxNumerointerno ) + "'">>, <<"'" + this.FormatearTextoSql( lxCupontipo ) + "'">>, <<"'" + this.ConvertirDateSql( lxFechacomprobante ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipocomprobante ) + "'">>, <<"'" + this.FormatearTextoSql( lxBasededatosorigen ) + "'">>, <<"'" + this.FormatearTextoSql( lxHora ) + "'">>, <<lxMonto>>, <<lxTotal>>, <<"'" + this.FormatearTextoSql( lxSerieorigen ) + "'">>, <<lxPesosalcambio>>, <<lxMontoamonedasistema>>, <<lxMontocupon>>, <<"'" + this.FormatearTextoSql( lxIditemcomponente ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigodecupon ) + "'">>, <<"'" + this.FormatearTextoSql( lxCupon_PK ) + "'">> ) 
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 Codigo from ZooLogic.CANJECUPONES where " + this.ConvertirFuncionesSql( " CANJECUPONES.CODIGO != ''" ) )
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
			Local lxCanjecuponesCodigo
			lxCanjecuponesCodigo = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Facttipo" as "Tipocomprobante", "Valtip" as "Cuponvalortipo", "Signo" as "Signodemovimiento", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Bdaltafw" as "Basededatosaltafw", "Haltafw" as "Horaaltafw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Valordet" as "Cuponvalordetalle", "Zadsfw" as "Zadsfw", "Hmodifw" as "Horamodificacionfw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Descfw" as "Descripcionfw", "Saltafw" as "Seriealtafw", "Cupon" as "Cupon", "Idcaja" as "Cuponidcaja", "Codigo" as "Codigo", "Moneda" as "Monedacomprobante", "Valor" as "Cuponvalor", "Fletra" as "Letra", "Comptipo" as "Cupontipocomprobante", "Cliente" as "Cliente", "Obs" as "Obs", "Fptoven" as "Puntodeventa", "Letra" as "Cuponletracomprobante", "Proveedor" as "Proveedor", "Numero" as "Numero", "Fecha" as "Fecha", "Ptoven" as "Cuponpuntodeventacomprobante", "Tipo" as "Cupontipo", "Concepto" as "Concepto", "Numcomp" as "Cuponnumerocomprobante", "Numerocup" as "Cuponnumerocupon", "Vendedor" as "Vendedor", "Fechacomp" as "Cuponfechacomprobante", "Fechacup" as "Cuponfecha", "Basedatos" as "Cuponbasededatos", "Ftotal" as "Total", "Hora" as "Cuponhora", "Serie" as "Cuponserieorigen", "Monto" as "Cuponmonto", "Anulado" as "Anulado" from ZooLogic.CANJECUPONES where "Codigo" = <<"'" + this.FormatearTextoSql( lxCanjecuponesCodigo ) + "'">> and  CANJECUPONES.CODIGO != ''
			endtext
			use in select('c_CANJEDECUPONES')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CANJEDECUPONES', set( 'Datasession' ) )

			if reccount( 'c_CANJEDECUPONES' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fechcoti" as "Fechaultcotizacion", "Jjfecha" as "Fechacomp", "Idcaja" as "Caja", "Jjt" as "Tipo", "Cotiza" as "Ultimacotizacion", "Signo" as "Signo", "Jjturno" as "Turno", "Ptoventa" as "Puntodeventa", "Jjcotiz" as "Cotiza", "Nroitem" as "Nroitem", "Nrocupon" as "Numerocupon", "Numcompr" as "Numerodecomprobante", "Autorizado" as "Autorizacionpos", "Perscomp" as "Personalizarcomprobante", "Visualcaja" as "Visualizarenestadodecaja", "Celectro" as "Chequeelectronico", "Letra" as "Letra", "Nrodoc" as "Nrodocumento", "Tipcomp" as "Tipodecomprobante", "Nrotarjeta" as "Numerotarjeta", "Jjven" as "Vendedor", "Tipodoc" as "Tipodocumento", "Jjnum" as "Codigo", "Nrocheque" as "Numerocheque", "Nrochprop" as "Numerochequepropio", "Jjco" as "Valor", "Jjde" as "Valordetalle", "Jjfe" as "Fecha", "Nrointerno" as "Numerointerno", "Jjm" as "Monto", "Jrecporc" as "Recargoporcentaje", "Jrecmnt" as "Recargomonto", "Jjtotfac" as "Total", "Pesos" as "Pesosalcambio", "Jrecmntsi" as "Recargomontosinimpuestos", "Montosiste" as "Montoamonedasistema", "Jrrecsperc" as "Recargosinpercepciones", "Permvuelto" as "Permitevuelto", "Guidcomp" as "Iditemcomponente", "Guidcupon" as "Codigodecupon", "Cupon" as "Cupon", "Valecambio" as "Numerovaledecambio" from ZooLogic.CanjeCuponesDet where JJNUM = <<"'" + this.FormatearTextoSql( c_CANJEDECUPONES.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ValoresDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ValoresDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ValoresDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Jjfecha" as "Fechacomp", "Fechcoti" as "Fechaultcotizacion", "Idcaja" as "Caja", "Signo" as "Signodemovimiento", "Nrocupon" as "Numerocupon", "Cotiza" as "Ultimacotizacion", "Jjcotiz" as "Cotiza", "Nroitem" as "Nroitem", "Jjt" as "Tipo", "Autorizado" as "Autorizacionpos", "Celectro" as "Chequeelectronico", "Visualcaja" as "Visualizarenestadodecaja", "Nrotarjeta" as "Numerotarjeta", "Jjco" as "Valor", "Codigo" as "Codigo", "Nrochprop" as "Numerochequepropio", "Nrocheque" as "Numerocheque", "Letra" as "Letracomprobante", "Jjde" as "Valordetalle", "Jjfe" as "Fecha", "Ptoven" as "Puntodeventacomprobante", "Numcompr" as "Nrocomprobante", "Nrointerno" as "Numerointerno", "Tipo" as "Cupontipo", "Fechacomp" as "Fechacomprobante", "Tipcomp" as "Tipocomprobante", "Basedatos" as "Basededatosorigen", "Hora" as "Hora", "Jjm" as "Monto", "Jjtotfac" as "Total", "Serie" as "Serieorigen", "Pesos" as "Pesosalcambio", "Montosiste" as "Montoamonedasistema", "Moncupon" as "Montocupon", "Guidcomp" as "Iditemcomponente", "Guidcupon" as "Codigodecupon", "Cupon" as "Cupon" from ZooLogic.CanjeCuponesEnt where Codigo = <<"'" + this.FormatearTextoSql( c_CANJEDECUPONES.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ValoresAEnt')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ValoresAEnt', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ValoresAEnt
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ConsultarPorClaveCandidata() as Boolean
		local llRetorno as Boolean
		llRetorno = .t.
		with this.oEntidad
			Local lxCanjeCuponesFACTTIPO As Variant, lxCanjeCuponesFLETRA As Variant, lxCanjeCuponesFPTOVEN As Variant, lxCanjeCuponesNumero As Variant
			lxCanjeCuponesFACTTIPO = .TipoComprobante
			lxCanjeCuponesFLETRA = .Letra
			lxCanjeCuponesFPTOVEN = .PuntoDeVenta
			lxCanjeCuponesNumero = .Numero
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Facttipo" as "Tipocomprobante", "Valtip" as "Cuponvalortipo", "Signo" as "Signodemovimiento", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Bdaltafw" as "Basededatosaltafw", "Haltafw" as "Horaaltafw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Valordet" as "Cuponvalordetalle", "Zadsfw" as "Zadsfw", "Hmodifw" as "Horamodificacionfw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Descfw" as "Descripcionfw", "Saltafw" as "Seriealtafw", "Cupon" as "Cupon", "Idcaja" as "Cuponidcaja", "Codigo" as "Codigo", "Moneda" as "Monedacomprobante", "Valor" as "Cuponvalor", "Fletra" as "Letra", "Comptipo" as "Cupontipocomprobante", "Cliente" as "Cliente", "Obs" as "Obs", "Fptoven" as "Puntodeventa", "Letra" as "Cuponletracomprobante", "Proveedor" as "Proveedor", "Numero" as "Numero", "Fecha" as "Fecha", "Ptoven" as "Cuponpuntodeventacomprobante", "Tipo" as "Cupontipo", "Concepto" as "Concepto", "Numcomp" as "Cuponnumerocomprobante", "Numerocup" as "Cuponnumerocupon", "Vendedor" as "Vendedor", "Fechacomp" as "Cuponfechacomprobante", "Fechacup" as "Cuponfecha", "Basedatos" as "Cuponbasededatos", "Ftotal" as "Total", "Hora" as "Cuponhora", "Serie" as "Cuponserieorigen", "Monto" as "Cuponmonto", "Anulado" as "Anulado" from ZooLogic.CANJECUPONES where  CANJECUPONES.CODIGO != '' And FACTTIPO = <<lxCanjeCuponesFACTTIPO>> and FLETRA = <<"'" + this.FormatearTextoSql( lxCanjeCuponesFLETRA ) + "'">> and FPTOVEN = <<lxCanjeCuponesFPTOVEN>> and Numero = <<lxCanjeCuponesNumero>>
			endtext
			use in select('c_CANJEDECUPONES')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CANJEDECUPONES', set( 'Datasession' ) )
			if reccount( 'c_CANJEDECUPONES' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fechcoti" as "Fechaultcotizacion", "Jjfecha" as "Fechacomp", "Idcaja" as "Caja", "Jjt" as "Tipo", "Cotiza" as "Ultimacotizacion", "Signo" as "Signo", "Jjturno" as "Turno", "Ptoventa" as "Puntodeventa", "Jjcotiz" as "Cotiza", "Nroitem" as "Nroitem", "Nrocupon" as "Numerocupon", "Numcompr" as "Numerodecomprobante", "Autorizado" as "Autorizacionpos", "Perscomp" as "Personalizarcomprobante", "Visualcaja" as "Visualizarenestadodecaja", "Celectro" as "Chequeelectronico", "Letra" as "Letra", "Nrodoc" as "Nrodocumento", "Tipcomp" as "Tipodecomprobante", "Nrotarjeta" as "Numerotarjeta", "Jjven" as "Vendedor", "Tipodoc" as "Tipodocumento", "Jjnum" as "Codigo", "Nrocheque" as "Numerocheque", "Nrochprop" as "Numerochequepropio", "Jjco" as "Valor", "Jjde" as "Valordetalle", "Jjfe" as "Fecha", "Nrointerno" as "Numerointerno", "Jjm" as "Monto", "Jrecporc" as "Recargoporcentaje", "Jrecmnt" as "Recargomonto", "Jjtotfac" as "Total", "Pesos" as "Pesosalcambio", "Jrecmntsi" as "Recargomontosinimpuestos", "Montosiste" as "Montoamonedasistema", "Jrrecsperc" as "Recargosinpercepciones", "Permvuelto" as "Permitevuelto", "Guidcomp" as "Iditemcomponente", "Guidcupon" as "Codigodecupon", "Cupon" as "Cupon", "Valecambio" as "Numerovaledecambio" from ZooLogic.CanjeCuponesDet where JJNUM = <<"'" + this.FormatearTextoSql( c_CANJEDECUPONES.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ValoresDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ValoresDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ValoresDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Jjfecha" as "Fechacomp", "Fechcoti" as "Fechaultcotizacion", "Idcaja" as "Caja", "Signo" as "Signodemovimiento", "Nrocupon" as "Numerocupon", "Cotiza" as "Ultimacotizacion", "Jjcotiz" as "Cotiza", "Nroitem" as "Nroitem", "Jjt" as "Tipo", "Autorizado" as "Autorizacionpos", "Celectro" as "Chequeelectronico", "Visualcaja" as "Visualizarenestadodecaja", "Nrotarjeta" as "Numerotarjeta", "Jjco" as "Valor", "Codigo" as "Codigo", "Nrochprop" as "Numerochequepropio", "Nrocheque" as "Numerocheque", "Letra" as "Letracomprobante", "Jjde" as "Valordetalle", "Jjfe" as "Fecha", "Ptoven" as "Puntodeventacomprobante", "Numcompr" as "Nrocomprobante", "Nrointerno" as "Numerointerno", "Tipo" as "Cupontipo", "Fechacomp" as "Fechacomprobante", "Tipcomp" as "Tipocomprobante", "Basedatos" as "Basededatosorigen", "Hora" as "Hora", "Jjm" as "Monto", "Jjtotfac" as "Total", "Serie" as "Serieorigen", "Pesos" as "Pesosalcambio", "Montosiste" as "Montoamonedasistema", "Moncupon" as "Montocupon", "Guidcomp" as "Iditemcomponente", "Guidcupon" as "Codigodecupon", "Cupon" as "Cupon" from ZooLogic.CanjeCuponesEnt where Codigo = <<"'" + this.FormatearTextoSql( c_CANJEDECUPONES.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ValoresAEnt')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ValoresAEnt', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ValoresAEnt
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxCanjecuponesCodigo as Variant
		llRetorno = .t.
		lxCanjecuponesCodigo = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.CANJECUPONES where "Codigo" = <<"'" + this.FormatearTextoSql( lxCanjecuponesCodigo ) + "'">> and  CANJECUPONES.CODIGO != ''
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
				lcOrden =  str( .TipoComprobante, 2, 0) + .Letra + str( .PuntoDeVenta, 4, 0) + str( .Numero, 12, 0)
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Facttipo" as "Tipocomprobante", "Valtip" as "Cuponvalortipo", "Signo" as "Signodemovimiento", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Bdaltafw" as "Basededatosaltafw", "Haltafw" as "Horaaltafw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Valordet" as "Cuponvalordetalle", "Zadsfw" as "Zadsfw", "Hmodifw" as "Horamodificacionfw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Descfw" as "Descripcionfw", "Saltafw" as "Seriealtafw", "Cupon" as "Cupon", "Idcaja" as "Cuponidcaja", "Codigo" as "Codigo", "Moneda" as "Monedacomprobante", "Valor" as "Cuponvalor", "Fletra" as "Letra", "Comptipo" as "Cupontipocomprobante", "Cliente" as "Cliente", "Obs" as "Obs", "Fptoven" as "Puntodeventa", "Letra" as "Cuponletracomprobante", "Proveedor" as "Proveedor", "Numero" as "Numero", "Fecha" as "Fecha", "Ptoven" as "Cuponpuntodeventacomprobante", "Tipo" as "Cupontipo", "Concepto" as "Concepto", "Numcomp" as "Cuponnumerocomprobante", "Numerocup" as "Cuponnumerocupon", "Vendedor" as "Vendedor", "Fechacomp" as "Cuponfechacomprobante", "Fechacup" as "Cuponfecha", "Basedatos" as "Cuponbasededatos", "Ftotal" as "Total", "Hora" as "Cuponhora", "Serie" as "Cuponserieorigen", "Monto" as "Cuponmonto", "Anulado" as "Anulado" from ZooLogic.CANJECUPONES where  CANJECUPONES.CODIGO != '' order by FACTTIPO,FLETRA,FPTOVEN,Numero
			endtext
			use in select('c_CANJEDECUPONES')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CANJEDECUPONES', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fechcoti" as "Fechaultcotizacion", "Jjfecha" as "Fechacomp", "Idcaja" as "Caja", "Jjt" as "Tipo", "Cotiza" as "Ultimacotizacion", "Signo" as "Signo", "Jjturno" as "Turno", "Ptoventa" as "Puntodeventa", "Jjcotiz" as "Cotiza", "Nroitem" as "Nroitem", "Nrocupon" as "Numerocupon", "Numcompr" as "Numerodecomprobante", "Autorizado" as "Autorizacionpos", "Perscomp" as "Personalizarcomprobante", "Visualcaja" as "Visualizarenestadodecaja", "Celectro" as "Chequeelectronico", "Letra" as "Letra", "Nrodoc" as "Nrodocumento", "Tipcomp" as "Tipodecomprobante", "Nrotarjeta" as "Numerotarjeta", "Jjven" as "Vendedor", "Tipodoc" as "Tipodocumento", "Jjnum" as "Codigo", "Nrocheque" as "Numerocheque", "Nrochprop" as "Numerochequepropio", "Jjco" as "Valor", "Jjde" as "Valordetalle", "Jjfe" as "Fecha", "Nrointerno" as "Numerointerno", "Jjm" as "Monto", "Jrecporc" as "Recargoporcentaje", "Jrecmnt" as "Recargomonto", "Jjtotfac" as "Total", "Pesos" as "Pesosalcambio", "Jrecmntsi" as "Recargomontosinimpuestos", "Montosiste" as "Montoamonedasistema", "Jrrecsperc" as "Recargosinpercepciones", "Permvuelto" as "Permitevuelto", "Guidcomp" as "Iditemcomponente", "Guidcupon" as "Codigodecupon", "Cupon" as "Cupon", "Valecambio" as "Numerovaledecambio" from ZooLogic.CanjeCuponesDet where JJNUM = <<"'" + this.FormatearTextoSql( c_CANJEDECUPONES.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ValoresDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ValoresDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ValoresDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Jjfecha" as "Fechacomp", "Fechcoti" as "Fechaultcotizacion", "Idcaja" as "Caja", "Signo" as "Signodemovimiento", "Nrocupon" as "Numerocupon", "Cotiza" as "Ultimacotizacion", "Jjcotiz" as "Cotiza", "Nroitem" as "Nroitem", "Jjt" as "Tipo", "Autorizado" as "Autorizacionpos", "Celectro" as "Chequeelectronico", "Visualcaja" as "Visualizarenestadodecaja", "Nrotarjeta" as "Numerotarjeta", "Jjco" as "Valor", "Codigo" as "Codigo", "Nrochprop" as "Numerochequepropio", "Nrocheque" as "Numerocheque", "Letra" as "Letracomprobante", "Jjde" as "Valordetalle", "Jjfe" as "Fecha", "Ptoven" as "Puntodeventacomprobante", "Numcompr" as "Nrocomprobante", "Nrointerno" as "Numerointerno", "Tipo" as "Cupontipo", "Fechacomp" as "Fechacomprobante", "Tipcomp" as "Tipocomprobante", "Basedatos" as "Basededatosorigen", "Hora" as "Hora", "Jjm" as "Monto", "Jjtotfac" as "Total", "Serie" as "Serieorigen", "Pesos" as "Pesosalcambio", "Montosiste" as "Montoamonedasistema", "Moncupon" as "Montocupon", "Guidcomp" as "Iditemcomponente", "Guidcupon" as "Codigodecupon", "Cupon" as "Cupon" from ZooLogic.CanjeCuponesEnt where Codigo = <<"'" + this.FormatearTextoSql( c_CANJEDECUPONES.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ValoresAEnt')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ValoresAEnt', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ValoresAEnt
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
				lcOrden =  str( .TipoComprobante, 2, 0) + .Letra + str( .PuntoDeVenta, 4, 0) + str( .Numero, 12, 0)
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Facttipo" as "Tipocomprobante", "Valtip" as "Cuponvalortipo", "Signo" as "Signodemovimiento", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Bdaltafw" as "Basededatosaltafw", "Haltafw" as "Horaaltafw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Valordet" as "Cuponvalordetalle", "Zadsfw" as "Zadsfw", "Hmodifw" as "Horamodificacionfw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Descfw" as "Descripcionfw", "Saltafw" as "Seriealtafw", "Cupon" as "Cupon", "Idcaja" as "Cuponidcaja", "Codigo" as "Codigo", "Moneda" as "Monedacomprobante", "Valor" as "Cuponvalor", "Fletra" as "Letra", "Comptipo" as "Cupontipocomprobante", "Cliente" as "Cliente", "Obs" as "Obs", "Fptoven" as "Puntodeventa", "Letra" as "Cuponletracomprobante", "Proveedor" as "Proveedor", "Numero" as "Numero", "Fecha" as "Fecha", "Ptoven" as "Cuponpuntodeventacomprobante", "Tipo" as "Cupontipo", "Concepto" as "Concepto", "Numcomp" as "Cuponnumerocomprobante", "Numerocup" as "Cuponnumerocupon", "Vendedor" as "Vendedor", "Fechacomp" as "Cuponfechacomprobante", "Fechacup" as "Cuponfecha", "Basedatos" as "Cuponbasededatos", "Ftotal" as "Total", "Hora" as "Cuponhora", "Serie" as "Cuponserieorigen", "Monto" as "Cuponmonto", "Anulado" as "Anulado" from ZooLogic.CANJECUPONES where  str( FACTTIPO, 2, 0) + funciones.padr( FLETRA, 1, ' ' ) + str( FPTOVEN, 4, 0) + str( Numero, 12, 0) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  CANJECUPONES.CODIGO != '' order by FACTTIPO,FLETRA,FPTOVEN,Numero
			endtext
			use in select('c_CANJEDECUPONES')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CANJEDECUPONES', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fechcoti" as "Fechaultcotizacion", "Jjfecha" as "Fechacomp", "Idcaja" as "Caja", "Jjt" as "Tipo", "Cotiza" as "Ultimacotizacion", "Signo" as "Signo", "Jjturno" as "Turno", "Ptoventa" as "Puntodeventa", "Jjcotiz" as "Cotiza", "Nroitem" as "Nroitem", "Nrocupon" as "Numerocupon", "Numcompr" as "Numerodecomprobante", "Autorizado" as "Autorizacionpos", "Perscomp" as "Personalizarcomprobante", "Visualcaja" as "Visualizarenestadodecaja", "Celectro" as "Chequeelectronico", "Letra" as "Letra", "Nrodoc" as "Nrodocumento", "Tipcomp" as "Tipodecomprobante", "Nrotarjeta" as "Numerotarjeta", "Jjven" as "Vendedor", "Tipodoc" as "Tipodocumento", "Jjnum" as "Codigo", "Nrocheque" as "Numerocheque", "Nrochprop" as "Numerochequepropio", "Jjco" as "Valor", "Jjde" as "Valordetalle", "Jjfe" as "Fecha", "Nrointerno" as "Numerointerno", "Jjm" as "Monto", "Jrecporc" as "Recargoporcentaje", "Jrecmnt" as "Recargomonto", "Jjtotfac" as "Total", "Pesos" as "Pesosalcambio", "Jrecmntsi" as "Recargomontosinimpuestos", "Montosiste" as "Montoamonedasistema", "Jrrecsperc" as "Recargosinpercepciones", "Permvuelto" as "Permitevuelto", "Guidcomp" as "Iditemcomponente", "Guidcupon" as "Codigodecupon", "Cupon" as "Cupon", "Valecambio" as "Numerovaledecambio" from ZooLogic.CanjeCuponesDet where JJNUM = <<"'" + this.FormatearTextoSql( c_CANJEDECUPONES.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ValoresDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ValoresDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ValoresDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Jjfecha" as "Fechacomp", "Fechcoti" as "Fechaultcotizacion", "Idcaja" as "Caja", "Signo" as "Signodemovimiento", "Nrocupon" as "Numerocupon", "Cotiza" as "Ultimacotizacion", "Jjcotiz" as "Cotiza", "Nroitem" as "Nroitem", "Jjt" as "Tipo", "Autorizado" as "Autorizacionpos", "Celectro" as "Chequeelectronico", "Visualcaja" as "Visualizarenestadodecaja", "Nrotarjeta" as "Numerotarjeta", "Jjco" as "Valor", "Codigo" as "Codigo", "Nrochprop" as "Numerochequepropio", "Nrocheque" as "Numerocheque", "Letra" as "Letracomprobante", "Jjde" as "Valordetalle", "Jjfe" as "Fecha", "Ptoven" as "Puntodeventacomprobante", "Numcompr" as "Nrocomprobante", "Nrointerno" as "Numerointerno", "Tipo" as "Cupontipo", "Fechacomp" as "Fechacomprobante", "Tipcomp" as "Tipocomprobante", "Basedatos" as "Basededatosorigen", "Hora" as "Hora", "Jjm" as "Monto", "Jjtotfac" as "Total", "Serie" as "Serieorigen", "Pesos" as "Pesosalcambio", "Montosiste" as "Montoamonedasistema", "Moncupon" as "Montocupon", "Guidcomp" as "Iditemcomponente", "Guidcupon" as "Codigodecupon", "Cupon" as "Cupon" from ZooLogic.CanjeCuponesEnt where Codigo = <<"'" + this.FormatearTextoSql( c_CANJEDECUPONES.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ValoresAEnt')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ValoresAEnt', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ValoresAEnt
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
				lcOrden =  str( .TipoComprobante, 2, 0) + .Letra + str( .PuntoDeVenta, 4, 0) + str( .Numero, 12, 0)
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Facttipo" as "Tipocomprobante", "Valtip" as "Cuponvalortipo", "Signo" as "Signodemovimiento", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Bdaltafw" as "Basededatosaltafw", "Haltafw" as "Horaaltafw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Valordet" as "Cuponvalordetalle", "Zadsfw" as "Zadsfw", "Hmodifw" as "Horamodificacionfw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Descfw" as "Descripcionfw", "Saltafw" as "Seriealtafw", "Cupon" as "Cupon", "Idcaja" as "Cuponidcaja", "Codigo" as "Codigo", "Moneda" as "Monedacomprobante", "Valor" as "Cuponvalor", "Fletra" as "Letra", "Comptipo" as "Cupontipocomprobante", "Cliente" as "Cliente", "Obs" as "Obs", "Fptoven" as "Puntodeventa", "Letra" as "Cuponletracomprobante", "Proveedor" as "Proveedor", "Numero" as "Numero", "Fecha" as "Fecha", "Ptoven" as "Cuponpuntodeventacomprobante", "Tipo" as "Cupontipo", "Concepto" as "Concepto", "Numcomp" as "Cuponnumerocomprobante", "Numerocup" as "Cuponnumerocupon", "Vendedor" as "Vendedor", "Fechacomp" as "Cuponfechacomprobante", "Fechacup" as "Cuponfecha", "Basedatos" as "Cuponbasededatos", "Ftotal" as "Total", "Hora" as "Cuponhora", "Serie" as "Cuponserieorigen", "Monto" as "Cuponmonto", "Anulado" as "Anulado" from ZooLogic.CANJECUPONES where  str( FACTTIPO, 2, 0) + funciones.padr( FLETRA, 1, ' ' ) + str( FPTOVEN, 4, 0) + str( Numero, 12, 0) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  CANJECUPONES.CODIGO != '' order by FACTTIPO desc,FLETRA desc,FPTOVEN desc,Numero desc
			endtext
			use in select('c_CANJEDECUPONES')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CANJEDECUPONES', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fechcoti" as "Fechaultcotizacion", "Jjfecha" as "Fechacomp", "Idcaja" as "Caja", "Jjt" as "Tipo", "Cotiza" as "Ultimacotizacion", "Signo" as "Signo", "Jjturno" as "Turno", "Ptoventa" as "Puntodeventa", "Jjcotiz" as "Cotiza", "Nroitem" as "Nroitem", "Nrocupon" as "Numerocupon", "Numcompr" as "Numerodecomprobante", "Autorizado" as "Autorizacionpos", "Perscomp" as "Personalizarcomprobante", "Visualcaja" as "Visualizarenestadodecaja", "Celectro" as "Chequeelectronico", "Letra" as "Letra", "Nrodoc" as "Nrodocumento", "Tipcomp" as "Tipodecomprobante", "Nrotarjeta" as "Numerotarjeta", "Jjven" as "Vendedor", "Tipodoc" as "Tipodocumento", "Jjnum" as "Codigo", "Nrocheque" as "Numerocheque", "Nrochprop" as "Numerochequepropio", "Jjco" as "Valor", "Jjde" as "Valordetalle", "Jjfe" as "Fecha", "Nrointerno" as "Numerointerno", "Jjm" as "Monto", "Jrecporc" as "Recargoporcentaje", "Jrecmnt" as "Recargomonto", "Jjtotfac" as "Total", "Pesos" as "Pesosalcambio", "Jrecmntsi" as "Recargomontosinimpuestos", "Montosiste" as "Montoamonedasistema", "Jrrecsperc" as "Recargosinpercepciones", "Permvuelto" as "Permitevuelto", "Guidcomp" as "Iditemcomponente", "Guidcupon" as "Codigodecupon", "Cupon" as "Cupon", "Valecambio" as "Numerovaledecambio" from ZooLogic.CanjeCuponesDet where JJNUM = <<"'" + this.FormatearTextoSql( c_CANJEDECUPONES.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ValoresDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ValoresDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ValoresDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Jjfecha" as "Fechacomp", "Fechcoti" as "Fechaultcotizacion", "Idcaja" as "Caja", "Signo" as "Signodemovimiento", "Nrocupon" as "Numerocupon", "Cotiza" as "Ultimacotizacion", "Jjcotiz" as "Cotiza", "Nroitem" as "Nroitem", "Jjt" as "Tipo", "Autorizado" as "Autorizacionpos", "Celectro" as "Chequeelectronico", "Visualcaja" as "Visualizarenestadodecaja", "Nrotarjeta" as "Numerotarjeta", "Jjco" as "Valor", "Codigo" as "Codigo", "Nrochprop" as "Numerochequepropio", "Nrocheque" as "Numerocheque", "Letra" as "Letracomprobante", "Jjde" as "Valordetalle", "Jjfe" as "Fecha", "Ptoven" as "Puntodeventacomprobante", "Numcompr" as "Nrocomprobante", "Nrointerno" as "Numerointerno", "Tipo" as "Cupontipo", "Fechacomp" as "Fechacomprobante", "Tipcomp" as "Tipocomprobante", "Basedatos" as "Basededatosorigen", "Hora" as "Hora", "Jjm" as "Monto", "Jjtotfac" as "Total", "Serie" as "Serieorigen", "Pesos" as "Pesosalcambio", "Montosiste" as "Montoamonedasistema", "Moncupon" as "Montocupon", "Guidcomp" as "Iditemcomponente", "Guidcupon" as "Codigodecupon", "Cupon" as "Cupon" from ZooLogic.CanjeCuponesEnt where Codigo = <<"'" + this.FormatearTextoSql( c_CANJEDECUPONES.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ValoresAEnt')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ValoresAEnt', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ValoresAEnt
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
				lcOrden =  str( .TipoComprobante, 2, 0) + .Letra + str( .PuntoDeVenta, 4, 0) + str( .Numero, 12, 0)
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Facttipo" as "Tipocomprobante", "Valtip" as "Cuponvalortipo", "Signo" as "Signodemovimiento", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Bdaltafw" as "Basededatosaltafw", "Haltafw" as "Horaaltafw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Valordet" as "Cuponvalordetalle", "Zadsfw" as "Zadsfw", "Hmodifw" as "Horamodificacionfw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Descfw" as "Descripcionfw", "Saltafw" as "Seriealtafw", "Cupon" as "Cupon", "Idcaja" as "Cuponidcaja", "Codigo" as "Codigo", "Moneda" as "Monedacomprobante", "Valor" as "Cuponvalor", "Fletra" as "Letra", "Comptipo" as "Cupontipocomprobante", "Cliente" as "Cliente", "Obs" as "Obs", "Fptoven" as "Puntodeventa", "Letra" as "Cuponletracomprobante", "Proveedor" as "Proveedor", "Numero" as "Numero", "Fecha" as "Fecha", "Ptoven" as "Cuponpuntodeventacomprobante", "Tipo" as "Cupontipo", "Concepto" as "Concepto", "Numcomp" as "Cuponnumerocomprobante", "Numerocup" as "Cuponnumerocupon", "Vendedor" as "Vendedor", "Fechacomp" as "Cuponfechacomprobante", "Fechacup" as "Cuponfecha", "Basedatos" as "Cuponbasededatos", "Ftotal" as "Total", "Hora" as "Cuponhora", "Serie" as "Cuponserieorigen", "Monto" as "Cuponmonto", "Anulado" as "Anulado" from ZooLogic.CANJECUPONES where  CANJECUPONES.CODIGO != '' order by FACTTIPO desc,FLETRA desc,FPTOVEN desc,Numero desc
			endtext
			use in select('c_CANJEDECUPONES')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CANJEDECUPONES', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fechcoti" as "Fechaultcotizacion", "Jjfecha" as "Fechacomp", "Idcaja" as "Caja", "Jjt" as "Tipo", "Cotiza" as "Ultimacotizacion", "Signo" as "Signo", "Jjturno" as "Turno", "Ptoventa" as "Puntodeventa", "Jjcotiz" as "Cotiza", "Nroitem" as "Nroitem", "Nrocupon" as "Numerocupon", "Numcompr" as "Numerodecomprobante", "Autorizado" as "Autorizacionpos", "Perscomp" as "Personalizarcomprobante", "Visualcaja" as "Visualizarenestadodecaja", "Celectro" as "Chequeelectronico", "Letra" as "Letra", "Nrodoc" as "Nrodocumento", "Tipcomp" as "Tipodecomprobante", "Nrotarjeta" as "Numerotarjeta", "Jjven" as "Vendedor", "Tipodoc" as "Tipodocumento", "Jjnum" as "Codigo", "Nrocheque" as "Numerocheque", "Nrochprop" as "Numerochequepropio", "Jjco" as "Valor", "Jjde" as "Valordetalle", "Jjfe" as "Fecha", "Nrointerno" as "Numerointerno", "Jjm" as "Monto", "Jrecporc" as "Recargoporcentaje", "Jrecmnt" as "Recargomonto", "Jjtotfac" as "Total", "Pesos" as "Pesosalcambio", "Jrecmntsi" as "Recargomontosinimpuestos", "Montosiste" as "Montoamonedasistema", "Jrrecsperc" as "Recargosinpercepciones", "Permvuelto" as "Permitevuelto", "Guidcomp" as "Iditemcomponente", "Guidcupon" as "Codigodecupon", "Cupon" as "Cupon", "Valecambio" as "Numerovaledecambio" from ZooLogic.CanjeCuponesDet where JJNUM = <<"'" + this.FormatearTextoSql( c_CANJEDECUPONES.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ValoresDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ValoresDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ValoresDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Jjfecha" as "Fechacomp", "Fechcoti" as "Fechaultcotizacion", "Idcaja" as "Caja", "Signo" as "Signodemovimiento", "Nrocupon" as "Numerocupon", "Cotiza" as "Ultimacotizacion", "Jjcotiz" as "Cotiza", "Nroitem" as "Nroitem", "Jjt" as "Tipo", "Autorizado" as "Autorizacionpos", "Celectro" as "Chequeelectronico", "Visualcaja" as "Visualizarenestadodecaja", "Nrotarjeta" as "Numerotarjeta", "Jjco" as "Valor", "Codigo" as "Codigo", "Nrochprop" as "Numerochequepropio", "Nrocheque" as "Numerocheque", "Letra" as "Letracomprobante", "Jjde" as "Valordetalle", "Jjfe" as "Fecha", "Ptoven" as "Puntodeventacomprobante", "Numcompr" as "Nrocomprobante", "Nrointerno" as "Numerointerno", "Tipo" as "Cupontipo", "Fechacomp" as "Fechacomprobante", "Tipcomp" as "Tipocomprobante", "Basedatos" as "Basededatosorigen", "Hora" as "Hora", "Jjm" as "Monto", "Jjtotfac" as "Total", "Serie" as "Serieorigen", "Pesos" as "Pesosalcambio", "Montosiste" as "Montoamonedasistema", "Moncupon" as "Montocupon", "Guidcomp" as "Iditemcomponente", "Guidcupon" as "Codigodecupon", "Cupon" as "Cupon" from ZooLogic.CanjeCuponesEnt where Codigo = <<"'" + this.FormatearTextoSql( c_CANJEDECUPONES.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ValoresAEnt')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ValoresAEnt', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ValoresAEnt
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
			lcXml = this.oConexion.EjecutarSql( "select Faltafw,Fectrans,Fecexpo,Fecimpo,Fmodifw,Facttipo,Valtip,Signo,Horaexpo,Horaimpo,Bdaltafw,Ha" + ;
"ltafw,Esttrans,Bdmodifw,Valordet,Zadsfw,Hmodifw,Ualtafw,Umodifw,Smodifw,Vmodifw,Valtafw,Descfw,Salta" + ;
"fw,Cupon,Idcaja,Codigo,Moneda,Valor,Fletra,Comptipo,Cliente,Obs,Fptoven,Letra,Proveedor,Numero,Fecha" + ;
",Ptoven,Tipo,Concepto,Numcomp,Numerocup,Vendedor,Fechacomp,Fechacup,Basedatos,Ftotal,Hora,Serie,Mont" + ;
"o,Anulado" + ;
" from ZooLogic.CANJECUPONES where  CANJECUPONES.CODIGO != '' and " + lcFiltro )
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
			local  lxCanjecuponesFaltafw, lxCanjecuponesFectrans, lxCanjecuponesFecexpo, lxCanjecuponesFecimpo, lxCanjecuponesFmodifw, lxCanjecuponesFacttipo, lxCanjecuponesValtip, lxCanjecuponesSigno, lxCanjecuponesHoraexpo, lxCanjecuponesHoraimpo, lxCanjecuponesBdaltafw, lxCanjecuponesHaltafw, lxCanjecuponesEsttrans, lxCanjecuponesBdmodifw, lxCanjecuponesValordet, lxCanjecuponesZadsfw, lxCanjecuponesHmodifw, lxCanjecuponesUaltafw, lxCanjecuponesUmodifw, lxCanjecuponesSmodifw, lxCanjecuponesVmodifw, lxCanjecuponesValtafw, lxCanjecuponesDescfw, lxCanjecuponesSaltafw, lxCanjecuponesCupon, lxCanjecuponesIdcaja, lxCanjecuponesCodigo, lxCanjecuponesMoneda, lxCanjecuponesValor, lxCanjecuponesFletra, lxCanjecuponesComptipo, lxCanjecuponesCliente, lxCanjecuponesObs, lxCanjecuponesFptoven, lxCanjecuponesLetra, lxCanjecuponesProveedor, lxCanjecuponesNumero, lxCanjecuponesFecha, lxCanjecuponesPtoven, lxCanjecuponesTipo, lxCanjecuponesConcepto, lxCanjecuponesNumcomp, lxCanjecuponesNumerocup, lxCanjecuponesVendedor, lxCanjecuponesFechacomp, lxCanjecuponesFechacup, lxCanjecuponesBasedatos, lxCanjecuponesFtotal, lxCanjecuponesHora, lxCanjecuponesSerie, lxCanjecuponesMonto, lxCanjecuponesAnulado
				lxCanjecuponesFaltafw = ctod( '  /  /    ' )			lxCanjecuponesFectrans = ctod( '  /  /    ' )			lxCanjecuponesFecexpo = ctod( '  /  /    ' )			lxCanjecuponesFecimpo = ctod( '  /  /    ' )			lxCanjecuponesFmodifw = ctod( '  /  /    ' )			lxCanjecuponesFacttipo = 0			lxCanjecuponesValtip = 0			lxCanjecuponesSigno = 0			lxCanjecuponesHoraexpo = []			lxCanjecuponesHoraimpo = []			lxCanjecuponesBdaltafw = []			lxCanjecuponesHaltafw = []			lxCanjecuponesEsttrans = []			lxCanjecuponesBdmodifw = []			lxCanjecuponesValordet = []			lxCanjecuponesZadsfw = []			lxCanjecuponesHmodifw = []			lxCanjecuponesUaltafw = []			lxCanjecuponesUmodifw = []			lxCanjecuponesSmodifw = []			lxCanjecuponesVmodifw = []			lxCanjecuponesValtafw = []			lxCanjecuponesDescfw = []			lxCanjecuponesSaltafw = []			lxCanjecuponesCupon = []			lxCanjecuponesIdcaja = 0			lxCanjecuponesCodigo = []			lxCanjecuponesMoneda = []			lxCanjecuponesValor = []			lxCanjecuponesFletra = []			lxCanjecuponesComptipo = 0			lxCanjecuponesCliente = []			lxCanjecuponesObs = []			lxCanjecuponesFptoven = 0			lxCanjecuponesLetra = []			lxCanjecuponesProveedor = []			lxCanjecuponesNumero = 0			lxCanjecuponesFecha = ctod( '  /  /    ' )			lxCanjecuponesPtoven = 0			lxCanjecuponesTipo = []			lxCanjecuponesConcepto = []			lxCanjecuponesNumcomp = 0			lxCanjecuponesNumerocup = 0			lxCanjecuponesVendedor = []			lxCanjecuponesFechacomp = ctod( '  /  /    ' )			lxCanjecuponesFechacup = ctod( '  /  /    ' )			lxCanjecuponesBasedatos = []			lxCanjecuponesFtotal = 0			lxCanjecuponesHora = []			lxCanjecuponesSerie = []			lxCanjecuponesMonto = 0			lxCanjecuponesAnulado = .F.
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.CanjeCuponesDet where "JJNUM" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.CanjeCuponesEnt where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( [delete from ZooLogic.CANJECUPONES where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'CANJECUPONES' + '_' + tcCampo
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
		lcWhere = " Where  CANJECUPONES.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Facttipo" as "Tipocomprobante", "Valtip" as "Cuponvalortipo", "Signo" as "Signodemovimiento", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Bdaltafw" as "Basededatosaltafw", "Haltafw" as "Horaaltafw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Valordet" as "Cuponvalordetalle", "Zadsfw" as "Zadsfw", "Hmodifw" as "Horamodificacionfw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Descfw" as "Descripcionfw", "Saltafw" as "Seriealtafw", "Cupon" as "Cupon", "Idcaja" as "Cuponidcaja", "Codigo" as "Codigo", "Moneda" as "Monedacomprobante", "Valor" as "Cuponvalor", "Fletra" as "Letra", "Comptipo" as "Cupontipocomprobante", "Cliente" as "Cliente", "Obs" as "Obs", "Fptoven" as "Puntodeventa", "Letra" as "Cuponletracomprobante", "Proveedor" as "Proveedor", "Numero" as "Numero", "Fecha" as "Fecha", "Ptoven" as "Cuponpuntodeventacomprobante", "Tipo" as "Cupontipo", "Concepto" as "Concepto", "Numcomp" as "Cuponnumerocomprobante", "Numerocup" as "Cuponnumerocupon", "Vendedor" as "Vendedor", "Fechacomp" as "Cuponfechacomprobante", "Fechacup" as "Cuponfecha", "Basedatos" as "Cuponbasededatos", "Ftotal" as "Total", "Hora" as "Cuponhora", "Serie" as "Cuponserieorigen", "Monto" as "Cuponmonto", "Anulado" as "Anulado"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'CANJECUPONES', '', tnTope )
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
	Function ObtenerDatosDetalleValoresDetalle( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  CANJECUPONESDET.JJNUM != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fechcoti" as "Fechaultcotizacion", "Jjfecha" as "Fechacomp", "Idcaja" as "Caja", "Jjt" as "Tipo", "Cotiza" as "Ultimacotizacion", "Signo" as "Signo", "Jjturno" as "Turno", "Ptoventa" as "Puntodeventa", "Jjcotiz" as "Cotiza", "Nroitem" as "Nroitem", "Nrocupon" as "Numerocupon", "Numcompr" as "Numerodecomprobante", "Autorizado" as "Autorizacionpos", "Perscomp" as "Personalizarcomprobante", "Visualcaja" as "Visualizarenestadodecaja", "Celectro" as "Chequeelectronico", "Letra" as "Letra", "Nrodoc" as "Nrodocumento", "Tipcomp" as "Tipodecomprobante", "Nrotarjeta" as "Numerotarjeta", "Jjven" as "Vendedor", "Tipodoc" as "Tipodocumento", "Jjnum" as "Codigo", "Nrocheque" as "Numerocheque", "Nrochprop" as "Numerochequepropio", "Jjco" as "Valor", "Jjde" as "Valordetalle", "Jjfe" as "Fecha", "Nrointerno" as "Numerointerno", "Jjm" as "Monto", "Jrecporc" as "Recargoporcentaje", "Jrecmnt" as "Recargomonto", "Jjtotfac" as "Total", "Pesos" as "Pesosalcambio", "Jrecmntsi" as "Recargomontosinimpuestos", "Montosiste" as "Montoamonedasistema", "Jrrecsperc" as "Recargosinpercepciones", "Permvuelto" as "Permitevuelto", "Guidcomp" as "Iditemcomponente", "Guidcupon" as "Codigodecupon", "Cupon" as "Cupon", "Valecambio" as "Numerovaledecambio"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleValoresDetalle( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'CanjeCuponesDet', 'ValoresDetalle', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleValoresDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleValoresDetalle( lcAtributo )
		endfor
		lcSelect = substr( lcSelect, 2 )
		return lcSelect
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosDetalleValoresAEnt( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  CANJECUPONESENT.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Jjfecha" as "Fechacomp", "Fechcoti" as "Fechaultcotizacion", "Idcaja" as "Caja", "Signo" as "Signodemovimiento", "Nrocupon" as "Numerocupon", "Cotiza" as "Ultimacotizacion", "Jjcotiz" as "Cotiza", "Nroitem" as "Nroitem", "Jjt" as "Tipo", "Autorizado" as "Autorizacionpos", "Celectro" as "Chequeelectronico", "Visualcaja" as "Visualizarenestadodecaja", "Nrotarjeta" as "Numerotarjeta", "Jjco" as "Valor", "Codigo" as "Codigo", "Nrochprop" as "Numerochequepropio", "Nrocheque" as "Numerocheque", "Letra" as "Letracomprobante", "Jjde" as "Valordetalle", "Jjfe" as "Fecha", "Ptoven" as "Puntodeventacomprobante", "Numcompr" as "Nrocomprobante", "Nrointerno" as "Numerointerno", "Tipo" as "Cupontipo", "Fechacomp" as "Fechacomprobante", "Tipcomp" as "Tipocomprobante", "Basedatos" as "Basededatosorigen", "Hora" as "Hora", "Jjm" as "Monto", "Jjtotfac" as "Total", "Serie" as "Serieorigen", "Pesos" as "Pesosalcambio", "Montosiste" as "Montoamonedasistema", "Moncupon" as "Montocupon", "Guidcomp" as "Iditemcomponente", "Guidcupon" as "Codigodecupon", "Cupon" as "Cupon"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleValoresAEnt( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'CanjeCuponesEnt', 'ValoresAEnt', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleValoresAEnt( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleValoresAEnt( lcAtributo )
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
				Case lcAtributo == 'FECHATRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRANS AS FECHATRANSFERENCIA'
				Case lcAtributo == 'FECHAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECEXPO AS FECHAEXPO'
				Case lcAtributo == 'FECHAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECIMPO AS FECHAIMPO'
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'TIPOCOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FACTTIPO AS TIPOCOMPROBANTE'
				Case lcAtributo == 'CUPONVALORTIPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTIP AS CUPONVALORTIPO'
				Case lcAtributo == 'SIGNODEMOVIMIENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SIGNO AS SIGNODEMOVIMIENTO'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'CUPONVALORDETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALORDET AS CUPONVALORDETALLE'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'DESCRIPCIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCFW AS DESCRIPCIONFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'CUPON'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CUPON AS CUPON'
				Case lcAtributo == 'CUPONIDCAJA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDCAJA AS CUPONIDCAJA'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'MONEDACOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONEDA AS MONEDACOMPROBANTE'
				Case lcAtributo == 'CUPONVALOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALOR AS CUPONVALOR'
				Case lcAtributo == 'LETRA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FLETRA AS LETRA'
				Case lcAtributo == 'CUPONTIPOCOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COMPTIPO AS CUPONTIPOCOMPROBANTE'
				Case lcAtributo == 'CLIENTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLIENTE AS CLIENTE'
				Case lcAtributo == 'OBS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'OBS AS OBS'
				Case lcAtributo == 'PUNTODEVENTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPTOVEN AS PUNTODEVENTA'
				Case lcAtributo == 'CUPONLETRACOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LETRA AS CUPONLETRACOMPROBANTE'
				Case lcAtributo == 'PROVEEDOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PROVEEDOR AS PROVEEDOR'
				Case lcAtributo == 'NUMERO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NUMERO AS NUMERO'
				Case lcAtributo == 'FECHA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHA AS FECHA'
				Case lcAtributo == 'CUPONPUNTODEVENTACOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PTOVEN AS CUPONPUNTODEVENTACOMPROBANTE'
				Case lcAtributo == 'CUPONTIPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPO AS CUPONTIPO'
				Case lcAtributo == 'CONCEPTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CONCEPTO AS CONCEPTO'
				Case lcAtributo == 'CUPONNUMEROCOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NUMCOMP AS CUPONNUMEROCOMPROBANTE'
				Case lcAtributo == 'CUPONNUMEROCUPON'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NUMEROCUP AS CUPONNUMEROCUPON'
				Case lcAtributo == 'VENDEDOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VENDEDOR AS VENDEDOR'
				Case lcAtributo == 'CUPONFECHACOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHACOMP AS CUPONFECHACOMPROBANTE'
				Case lcAtributo == 'CUPONFECHA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHACUP AS CUPONFECHA'
				Case lcAtributo == 'CUPONBASEDEDATOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BASEDATOS AS CUPONBASEDEDATOS'
				Case lcAtributo == 'TOTAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FTOTAL AS TOTAL'
				Case lcAtributo == 'CUPONHORA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORA AS CUPONHORA'
				Case lcAtributo == 'CUPONSERIEORIGEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SERIE AS CUPONSERIEORIGEN'
				Case lcAtributo == 'CUPONMONTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONTO AS CUPONMONTO'
				Case lcAtributo == 'ANULADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ANULADO AS ANULADO'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleValoresDetalle( tcCampos As String ) As String
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
				Case lcAtributo == 'TIPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'JJT AS TIPO'
				Case lcAtributo == 'ULTIMACOTIZACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COTIZA AS ULTIMACOTIZACION'
				Case lcAtributo == 'SIGNO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SIGNO AS SIGNO'
				Case lcAtributo == 'TURNO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'JJTURNO AS TURNO'
				Case lcAtributo == 'PUNTODEVENTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PTOVENTA AS PUNTODEVENTA'
				Case lcAtributo == 'COTIZA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'JJCOTIZ AS COTIZA'
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'NUMEROCUPON'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROCUPON AS NUMEROCUPON'
				Case lcAtributo == 'NUMERODECOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NUMCOMPR AS NUMERODECOMPROBANTE'
				Case lcAtributo == 'AUTORIZACIONPOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AUTORIZADO AS AUTORIZACIONPOS'
				Case lcAtributo == 'PERSONALIZARCOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PERSCOMP AS PERSONALIZARCOMPROBANTE'
				Case lcAtributo == 'VISUALIZARENESTADODECAJA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VISUALCAJA AS VISUALIZARENESTADODECAJA'
				Case lcAtributo == 'CHEQUEELECTRONICO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CELECTRO AS CHEQUEELECTRONICO'
				Case lcAtributo == 'LETRA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LETRA AS LETRA'
				Case lcAtributo == 'NRODOCUMENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NRODOC AS NRODOCUMENTO'
				Case lcAtributo == 'TIPODECOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPCOMP AS TIPODECOMPROBANTE'
				Case lcAtributo == 'NUMEROTARJETA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROTARJETA AS NUMEROTARJETA'
				Case lcAtributo == 'VENDEDOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'JJVEN AS VENDEDOR'
				Case lcAtributo == 'TIPODOCUMENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPODOC AS TIPODOCUMENTO'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'JJNUM AS CODIGO'
				Case lcAtributo == 'NUMEROCHEQUE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROCHEQUE AS NUMEROCHEQUE'
				Case lcAtributo == 'NUMEROCHEQUEPROPIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROCHPROP AS NUMEROCHEQUEPROPIO'
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
				Case lcAtributo == 'PESOSALCAMBIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PESOS AS PESOSALCAMBIO'
				Case lcAtributo == 'RECARGOMONTOSINIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'JRECMNTSI AS RECARGOMONTOSINIMPUESTOS'
				Case lcAtributo == 'MONTOAMONEDASISTEMA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONTOSISTE AS MONTOAMONEDASISTEMA'
				Case lcAtributo == 'RECARGOSINPERCEPCIONES'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'JRRECSPERC AS RECARGOSINPERCEPCIONES'
				Case lcAtributo == 'PERMITEVUELTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PERMVUELTO AS PERMITEVUELTO'
				Case lcAtributo == 'IDITEMCOMPONENTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'GUIDCOMP AS IDITEMCOMPONENTE'
				Case lcAtributo == 'CODIGODECUPON'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'GUIDCUPON AS CODIGODECUPON'
				Case lcAtributo == 'CUPON'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CUPON AS CUPON'
				Case lcAtributo == 'NUMEROVALEDECAMBIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALECAMBIO AS NUMEROVALEDECAMBIO'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleValoresAEnt( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'FECHACOMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'JJFECHA AS FECHACOMP'
				Case lcAtributo == 'FECHAULTCOTIZACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHCOTI AS FECHAULTCOTIZACION'
				Case lcAtributo == 'CAJA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDCAJA AS CAJA'
				Case lcAtributo == 'SIGNODEMOVIMIENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SIGNO AS SIGNODEMOVIMIENTO'
				Case lcAtributo == 'NUMEROCUPON'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROCUPON AS NUMEROCUPON'
				Case lcAtributo == 'ULTIMACOTIZACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COTIZA AS ULTIMACOTIZACION'
				Case lcAtributo == 'COTIZA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'JJCOTIZ AS COTIZA'
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'TIPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'JJT AS TIPO'
				Case lcAtributo == 'AUTORIZACIONPOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AUTORIZADO AS AUTORIZACIONPOS'
				Case lcAtributo == 'CHEQUEELECTRONICO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CELECTRO AS CHEQUEELECTRONICO'
				Case lcAtributo == 'VISUALIZARENESTADODECAJA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VISUALCAJA AS VISUALIZARENESTADODECAJA'
				Case lcAtributo == 'NUMEROTARJETA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROTARJETA AS NUMEROTARJETA'
				Case lcAtributo == 'VALOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'JJCO AS VALOR'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'NUMEROCHEQUEPROPIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROCHPROP AS NUMEROCHEQUEPROPIO'
				Case lcAtributo == 'NUMEROCHEQUE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROCHEQUE AS NUMEROCHEQUE'
				Case lcAtributo == 'LETRACOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LETRA AS LETRACOMPROBANTE'
				Case lcAtributo == 'VALORDETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'JJDE AS VALORDETALLE'
				Case lcAtributo == 'FECHA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'JJFE AS FECHA'
				Case lcAtributo == 'PUNTODEVENTACOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PTOVEN AS PUNTODEVENTACOMPROBANTE'
				Case lcAtributo == 'NROCOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NUMCOMPR AS NROCOMPROBANTE'
				Case lcAtributo == 'NUMEROINTERNO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROINTERNO AS NUMEROINTERNO'
				Case lcAtributo == 'CUPONTIPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPO AS CUPONTIPO'
				Case lcAtributo == 'FECHACOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHACOMP AS FECHACOMPROBANTE'
				Case lcAtributo == 'TIPOCOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPCOMP AS TIPOCOMPROBANTE'
				Case lcAtributo == 'BASEDEDATOSORIGEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BASEDATOS AS BASEDEDATOSORIGEN'
				Case lcAtributo == 'HORA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORA AS HORA'
				Case lcAtributo == 'MONTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'JJM AS MONTO'
				Case lcAtributo == 'TOTAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'JJTOTFAC AS TOTAL'
				Case lcAtributo == 'SERIEORIGEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SERIE AS SERIEORIGEN'
				Case lcAtributo == 'PESOSALCAMBIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PESOS AS PESOSALCAMBIO'
				Case lcAtributo == 'MONTOAMONEDASISTEMA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONTOSISTE AS MONTOAMONEDASISTEMA'
				Case lcAtributo == 'MONTOCUPON'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONCUPON AS MONTOCUPON'
				Case lcAtributo == 'IDITEMCOMPONENTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'GUIDCOMP AS IDITEMCOMPONENTE'
				Case lcAtributo == 'CODIGODECUPON'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'GUIDCUPON AS CODIGODECUPON'
				Case lcAtributo == 'CUPON'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CUPON AS CUPON'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEXPO'
				lcCampo = 'FECEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAIMPO'
				lcCampo = 'FECIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOCOMPROBANTE'
				lcCampo = 'FACTTIPO'
			Case upper( alltrim( tcAtributo ) ) == 'CUPONVALORTIPO'
				lcCampo = 'VALTIP'
			Case upper( alltrim( tcAtributo ) ) == 'SIGNODEMOVIMIENTO'
				lcCampo = 'SIGNO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'CUPONVALORDETALLE'
				lcCampo = 'VALORDET'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCIONFW'
				lcCampo = 'DESCFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'CUPON'
				lcCampo = 'CUPON'
			Case upper( alltrim( tcAtributo ) ) == 'CUPONIDCAJA'
				lcCampo = 'IDCAJA'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'MONEDACOMPROBANTE'
				lcCampo = 'MONEDA'
			Case upper( alltrim( tcAtributo ) ) == 'CUPONVALOR'
				lcCampo = 'VALOR'
			Case upper( alltrim( tcAtributo ) ) == 'LETRA'
				lcCampo = 'FLETRA'
			Case upper( alltrim( tcAtributo ) ) == 'CUPONTIPOCOMPROBANTE'
				lcCampo = 'COMPTIPO'
			Case upper( alltrim( tcAtributo ) ) == 'CLIENTE'
				lcCampo = 'CLIENTE'
			Case upper( alltrim( tcAtributo ) ) == 'OBS'
				lcCampo = 'OBS'
			Case upper( alltrim( tcAtributo ) ) == 'PUNTODEVENTA'
				lcCampo = 'FPTOVEN'
			Case upper( alltrim( tcAtributo ) ) == 'CUPONLETRACOMPROBANTE'
				lcCampo = 'LETRA'
			Case upper( alltrim( tcAtributo ) ) == 'PROVEEDOR'
				lcCampo = 'PROVEEDOR'
			Case upper( alltrim( tcAtributo ) ) == 'NUMERO'
				lcCampo = 'NUMERO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHA'
				lcCampo = 'FECHA'
			Case upper( alltrim( tcAtributo ) ) == 'CUPONPUNTODEVENTACOMPROBANTE'
				lcCampo = 'PTOVEN'
			Case upper( alltrim( tcAtributo ) ) == 'CUPONTIPO'
				lcCampo = 'TIPO'
			Case upper( alltrim( tcAtributo ) ) == 'CONCEPTO'
				lcCampo = 'CONCEPTO'
			Case upper( alltrim( tcAtributo ) ) == 'CUPONNUMEROCOMPROBANTE'
				lcCampo = 'NUMCOMP'
			Case upper( alltrim( tcAtributo ) ) == 'CUPONNUMEROCUPON'
				lcCampo = 'NUMEROCUP'
			Case upper( alltrim( tcAtributo ) ) == 'VENDEDOR'
				lcCampo = 'VENDEDOR'
			Case upper( alltrim( tcAtributo ) ) == 'CUPONFECHACOMPROBANTE'
				lcCampo = 'FECHACOMP'
			Case upper( alltrim( tcAtributo ) ) == 'CUPONFECHA'
				lcCampo = 'FECHACUP'
			Case upper( alltrim( tcAtributo ) ) == 'CUPONBASEDEDATOS'
				lcCampo = 'BASEDATOS'
			Case upper( alltrim( tcAtributo ) ) == 'TOTAL'
				lcCampo = 'FTOTAL'
			Case upper( alltrim( tcAtributo ) ) == 'CUPONHORA'
				lcCampo = 'HORA'
			Case upper( alltrim( tcAtributo ) ) == 'CUPONSERIEORIGEN'
				lcCampo = 'SERIE'
			Case upper( alltrim( tcAtributo ) ) == 'CUPONMONTO'
				lcCampo = 'MONTO'
			Case upper( alltrim( tcAtributo ) ) == 'ANULADO'
				lcCampo = 'ANULADO'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleValoresDetalle( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'FECHAULTCOTIZACION'
				lcCampo = 'FECHCOTI'
			Case upper( alltrim( tcAtributo ) ) == 'FECHACOMP'
				lcCampo = 'JJFECHA'
			Case upper( alltrim( tcAtributo ) ) == 'CAJA'
				lcCampo = 'IDCAJA'
			Case upper( alltrim( tcAtributo ) ) == 'TIPO'
				lcCampo = 'JJT'
			Case upper( alltrim( tcAtributo ) ) == 'ULTIMACOTIZACION'
				lcCampo = 'COTIZA'
			Case upper( alltrim( tcAtributo ) ) == 'SIGNO'
				lcCampo = 'SIGNO'
			Case upper( alltrim( tcAtributo ) ) == 'TURNO'
				lcCampo = 'JJTURNO'
			Case upper( alltrim( tcAtributo ) ) == 'PUNTODEVENTA'
				lcCampo = 'PTOVENTA'
			Case upper( alltrim( tcAtributo ) ) == 'COTIZA'
				lcCampo = 'JJCOTIZ'
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'NUMEROCUPON'
				lcCampo = 'NROCUPON'
			Case upper( alltrim( tcAtributo ) ) == 'NUMERODECOMPROBANTE'
				lcCampo = 'NUMCOMPR'
			Case upper( alltrim( tcAtributo ) ) == 'AUTORIZACIONPOS'
				lcCampo = 'AUTORIZADO'
			Case upper( alltrim( tcAtributo ) ) == 'PERSONALIZARCOMPROBANTE'
				lcCampo = 'PERSCOMP'
			Case upper( alltrim( tcAtributo ) ) == 'VISUALIZARENESTADODECAJA'
				lcCampo = 'VISUALCAJA'
			Case upper( alltrim( tcAtributo ) ) == 'CHEQUEELECTRONICO'
				lcCampo = 'CELECTRO'
			Case upper( alltrim( tcAtributo ) ) == 'LETRA'
				lcCampo = 'LETRA'
			Case upper( alltrim( tcAtributo ) ) == 'NRODOCUMENTO'
				lcCampo = 'NRODOC'
			Case upper( alltrim( tcAtributo ) ) == 'TIPODECOMPROBANTE'
				lcCampo = 'TIPCOMP'
			Case upper( alltrim( tcAtributo ) ) == 'NUMEROTARJETA'
				lcCampo = 'NROTARJETA'
			Case upper( alltrim( tcAtributo ) ) == 'VENDEDOR'
				lcCampo = 'JJVEN'
			Case upper( alltrim( tcAtributo ) ) == 'TIPODOCUMENTO'
				lcCampo = 'TIPODOC'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'JJNUM'
			Case upper( alltrim( tcAtributo ) ) == 'NUMEROCHEQUE'
				lcCampo = 'NROCHEQUE'
			Case upper( alltrim( tcAtributo ) ) == 'NUMEROCHEQUEPROPIO'
				lcCampo = 'NROCHPROP'
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
			Case upper( alltrim( tcAtributo ) ) == 'PESOSALCAMBIO'
				lcCampo = 'PESOS'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOMONTOSINIMPUESTOS'
				lcCampo = 'JRECMNTSI'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOAMONEDASISTEMA'
				lcCampo = 'MONTOSISTE'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOSINPERCEPCIONES'
				lcCampo = 'JRRECSPERC'
			Case upper( alltrim( tcAtributo ) ) == 'PERMITEVUELTO'
				lcCampo = 'PERMVUELTO'
			Case upper( alltrim( tcAtributo ) ) == 'IDITEMCOMPONENTE'
				lcCampo = 'GUIDCOMP'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGODECUPON'
				lcCampo = 'GUIDCUPON'
			Case upper( alltrim( tcAtributo ) ) == 'CUPON'
				lcCampo = 'CUPON'
			Case upper( alltrim( tcAtributo ) ) == 'NUMEROVALEDECAMBIO'
				lcCampo = 'VALECAMBIO'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleValoresAEnt( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'FECHACOMP'
				lcCampo = 'JJFECHA'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAULTCOTIZACION'
				lcCampo = 'FECHCOTI'
			Case upper( alltrim( tcAtributo ) ) == 'CAJA'
				lcCampo = 'IDCAJA'
			Case upper( alltrim( tcAtributo ) ) == 'SIGNODEMOVIMIENTO'
				lcCampo = 'SIGNO'
			Case upper( alltrim( tcAtributo ) ) == 'NUMEROCUPON'
				lcCampo = 'NROCUPON'
			Case upper( alltrim( tcAtributo ) ) == 'ULTIMACOTIZACION'
				lcCampo = 'COTIZA'
			Case upper( alltrim( tcAtributo ) ) == 'COTIZA'
				lcCampo = 'JJCOTIZ'
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'TIPO'
				lcCampo = 'JJT'
			Case upper( alltrim( tcAtributo ) ) == 'AUTORIZACIONPOS'
				lcCampo = 'AUTORIZADO'
			Case upper( alltrim( tcAtributo ) ) == 'CHEQUEELECTRONICO'
				lcCampo = 'CELECTRO'
			Case upper( alltrim( tcAtributo ) ) == 'VISUALIZARENESTADODECAJA'
				lcCampo = 'VISUALCAJA'
			Case upper( alltrim( tcAtributo ) ) == 'NUMEROTARJETA'
				lcCampo = 'NROTARJETA'
			Case upper( alltrim( tcAtributo ) ) == 'VALOR'
				lcCampo = 'JJCO'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'NUMEROCHEQUEPROPIO'
				lcCampo = 'NROCHPROP'
			Case upper( alltrim( tcAtributo ) ) == 'NUMEROCHEQUE'
				lcCampo = 'NROCHEQUE'
			Case upper( alltrim( tcAtributo ) ) == 'LETRACOMPROBANTE'
				lcCampo = 'LETRA'
			Case upper( alltrim( tcAtributo ) ) == 'VALORDETALLE'
				lcCampo = 'JJDE'
			Case upper( alltrim( tcAtributo ) ) == 'FECHA'
				lcCampo = 'JJFE'
			Case upper( alltrim( tcAtributo ) ) == 'PUNTODEVENTACOMPROBANTE'
				lcCampo = 'PTOVEN'
			Case upper( alltrim( tcAtributo ) ) == 'NROCOMPROBANTE'
				lcCampo = 'NUMCOMPR'
			Case upper( alltrim( tcAtributo ) ) == 'NUMEROINTERNO'
				lcCampo = 'NROINTERNO'
			Case upper( alltrim( tcAtributo ) ) == 'CUPONTIPO'
				lcCampo = 'TIPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHACOMPROBANTE'
				lcCampo = 'FECHACOMP'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOCOMPROBANTE'
				lcCampo = 'TIPCOMP'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSORIGEN'
				lcCampo = 'BASEDATOS'
			Case upper( alltrim( tcAtributo ) ) == 'HORA'
				lcCampo = 'HORA'
			Case upper( alltrim( tcAtributo ) ) == 'MONTO'
				lcCampo = 'JJM'
			Case upper( alltrim( tcAtributo ) ) == 'TOTAL'
				lcCampo = 'JJTOTFAC'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEORIGEN'
				lcCampo = 'SERIE'
			Case upper( alltrim( tcAtributo ) ) == 'PESOSALCAMBIO'
				lcCampo = 'PESOS'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOAMONEDASISTEMA'
				lcCampo = 'MONTOSISTE'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOCUPON'
				lcCampo = 'MONCUPON'
			Case upper( alltrim( tcAtributo ) ) == 'IDITEMCOMPONENTE'
				lcCampo = 'GUIDCOMP'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGODECUPON'
				lcCampo = 'GUIDCUPON'
			Case upper( alltrim( tcAtributo ) ) == 'CUPON'
				lcCampo = 'CUPON'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerTablaDetalle( tcDetalle as string ) as String
		local lcRetorno as string
		lcRetorno = ''
		if upper( alltrim( tcDetalle ) ) == 'VALORESDETALLE'
			lcRetorno = 'CANJECUPONESDET'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'VALORESAENT'
			lcRetorno = 'CANJECUPONESENT'
		EndIf
		return lcRetorno
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasInsert() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcSentencia as string, loItem as object
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxCanjecuponesFaltafw, lxCanjecuponesFectrans, lxCanjecuponesFecexpo, lxCanjecuponesFecimpo, lxCanjecuponesFmodifw, lxCanjecuponesFacttipo, lxCanjecuponesValtip, lxCanjecuponesSigno, lxCanjecuponesHoraexpo, lxCanjecuponesHoraimpo, lxCanjecuponesBdaltafw, lxCanjecuponesHaltafw, lxCanjecuponesEsttrans, lxCanjecuponesBdmodifw, lxCanjecuponesValordet, lxCanjecuponesZadsfw, lxCanjecuponesHmodifw, lxCanjecuponesUaltafw, lxCanjecuponesUmodifw, lxCanjecuponesSmodifw, lxCanjecuponesVmodifw, lxCanjecuponesValtafw, lxCanjecuponesDescfw, lxCanjecuponesSaltafw, lxCanjecuponesCupon, lxCanjecuponesIdcaja, lxCanjecuponesCodigo, lxCanjecuponesMoneda, lxCanjecuponesValor, lxCanjecuponesFletra, lxCanjecuponesComptipo, lxCanjecuponesCliente, lxCanjecuponesObs, lxCanjecuponesFptoven, lxCanjecuponesLetra, lxCanjecuponesProveedor, lxCanjecuponesNumero, lxCanjecuponesFecha, lxCanjecuponesPtoven, lxCanjecuponesTipo, lxCanjecuponesConcepto, lxCanjecuponesNumcomp, lxCanjecuponesNumerocup, lxCanjecuponesVendedor, lxCanjecuponesFechacomp, lxCanjecuponesFechacup, lxCanjecuponesBasedatos, lxCanjecuponesFtotal, lxCanjecuponesHora, lxCanjecuponesSerie, lxCanjecuponesMonto, lxCanjecuponesAnulado
				lxCanjecuponesFaltafw =  .Fechaaltafw			lxCanjecuponesFectrans =  .Fechatransferencia			lxCanjecuponesFecexpo =  .Fechaexpo			lxCanjecuponesFecimpo =  .Fechaimpo			lxCanjecuponesFmodifw =  .Fechamodificacionfw			lxCanjecuponesFacttipo =  .Tipocomprobante			lxCanjecuponesValtip =  .Cuponvalortipo			lxCanjecuponesSigno =  .Signodemovimiento			lxCanjecuponesHoraexpo =  .Horaexpo			lxCanjecuponesHoraimpo =  .Horaimpo			lxCanjecuponesBdaltafw =  .Basededatosaltafw			lxCanjecuponesHaltafw =  .Horaaltafw			lxCanjecuponesEsttrans =  .Estadotransferencia			lxCanjecuponesBdmodifw =  .Basededatosmodificacionfw			lxCanjecuponesValordet =  .Cuponvalordetalle			lxCanjecuponesZadsfw =  .Zadsfw			lxCanjecuponesHmodifw =  .Horamodificacionfw			lxCanjecuponesUaltafw =  .Usuarioaltafw			lxCanjecuponesUmodifw =  .Usuariomodificacionfw			lxCanjecuponesSmodifw =  .Seriemodificacionfw			lxCanjecuponesVmodifw =  .Versionmodificacionfw			lxCanjecuponesValtafw =  .Versionaltafw			lxCanjecuponesDescfw =  .Descripcionfw			lxCanjecuponesSaltafw =  .Seriealtafw			lxCanjecuponesCupon =  upper( .Cupon_PK ) 			lxCanjecuponesIdcaja =  .Cuponidcaja_PK 			lxCanjecuponesCodigo =  .Codigo			lxCanjecuponesMoneda =  upper( .MonedaComprobante_PK ) 			lxCanjecuponesValor =  upper( .CuponValor_PK ) 			lxCanjecuponesFletra =  .Letra			lxCanjecuponesComptipo =  .Cupontipocomprobante			lxCanjecuponesCliente =  upper( .Cliente_PK ) 			lxCanjecuponesObs =  .Obs			lxCanjecuponesFptoven =  .Puntodeventa			lxCanjecuponesLetra =  .Cuponletracomprobante			lxCanjecuponesProveedor =  upper( .Proveedor_PK ) 			lxCanjecuponesNumero =  .Numero			lxCanjecuponesFecha =  .Fecha			lxCanjecuponesPtoven =  .Cuponpuntodeventacomprobante			lxCanjecuponesTipo =  .Cupontipo			lxCanjecuponesConcepto =  upper( .Concepto_PK ) 			lxCanjecuponesNumcomp =  .Cuponnumerocomprobante			lxCanjecuponesNumerocup =  .Cuponnumerocupon			lxCanjecuponesVendedor =  upper( .Vendedor_PK ) 			lxCanjecuponesFechacomp =  .Cuponfechacomprobante			lxCanjecuponesFechacup =  .Cuponfecha			lxCanjecuponesBasedatos =  .Cuponbasededatos			lxCanjecuponesFtotal =  .Total			lxCanjecuponesHora =  .Cuponhora			lxCanjecuponesSerie =  .Cuponserieorigen			lxCanjecuponesMonto =  .Cuponmonto			lxCanjecuponesAnulado =  .Anulado
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.CANJECUPONES ( "Faltafw","Fectrans","Fecexpo","Fecimpo","Fmodifw","Facttipo","Valtip","Signo","Horaexpo","Horaimpo","Bdaltafw","Haltafw","Esttrans","Bdmodifw","Valordet","Zadsfw","Hmodifw","Ualtafw","Umodifw","Smodifw","Vmodifw","Valtafw","Descfw","Saltafw","Cupon","Idcaja","Codigo","Moneda","Valor","Fletra","Comptipo","Cliente","Obs","Fptoven","Letra","Proveedor","Numero","Fecha","Ptoven","Tipo","Concepto","Numcomp","Numerocup","Vendedor","Fechacomp","Fechacup","Basedatos","Ftotal","Hora","Serie","Monto","Anulado" ) values ( <<"'" + this.ConvertirDateSql( lxCanjecuponesFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCanjecuponesFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCanjecuponesFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCanjecuponesFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCanjecuponesFmodifw ) + "'" >>, <<lxCanjecuponesFacttipo >>, <<lxCanjecuponesValtip >>, <<lxCanjecuponesSigno >>, <<"'" + this.FormatearTextoSql( lxCanjecuponesHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanjecuponesHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanjecuponesBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanjecuponesHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanjecuponesEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanjecuponesBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanjecuponesValordet ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanjecuponesZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanjecuponesHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanjecuponesUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanjecuponesUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanjecuponesSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanjecuponesVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanjecuponesValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanjecuponesDescfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanjecuponesSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanjecuponesCupon ) + "'" >>, <<lxCanjecuponesIdcaja >>, <<"'" + this.FormatearTextoSql( lxCanjecuponesCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanjecuponesMoneda ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanjecuponesValor ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanjecuponesFletra ) + "'" >>, <<lxCanjecuponesComptipo >>, <<"'" + this.FormatearTextoSql( lxCanjecuponesCliente ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanjecuponesObs ) + "'" >>, <<lxCanjecuponesFptoven >>, <<"'" + this.FormatearTextoSql( lxCanjecuponesLetra ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanjecuponesProveedor ) + "'" >>, <<lxCanjecuponesNumero >>, <<"'" + this.ConvertirDateSql( lxCanjecuponesFecha ) + "'" >>, <<lxCanjecuponesPtoven >>, <<"'" + this.FormatearTextoSql( lxCanjecuponesTipo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanjecuponesConcepto ) + "'" >>, <<lxCanjecuponesNumcomp >>, <<lxCanjecuponesNumerocup >>, <<"'" + this.FormatearTextoSql( lxCanjecuponesVendedor ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCanjecuponesFechacomp ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCanjecuponesFechacup ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanjecuponesBasedatos ) + "'" >>, <<lxCanjecuponesFtotal >>, <<"'" + this.FormatearTextoSql( lxCanjecuponesHora ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanjecuponesSerie ) + "'" >>, <<lxCanjecuponesMonto >>, <<iif( lxCanjecuponesAnulado, 1, 0 ) >> )
		endtext
		loColeccion.cTabla = 'CANJECUPONES' 
		loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		With this
			local lcValorClavePrimariaString as String
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ValoresDetalle
				if this.oEntidad.ValoresDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxFechaultcotizacion = loItem.Fechaultcotizacion
					lxFechacomp = loItem.Fechacomp
					lxCaja_PK = loItem.Caja_PK
					lxTipo = loItem.Tipo
					lxUltimacotizacion = loItem.Ultimacotizacion
					lxSigno = loItem.Signo
					lxTurno = loItem.Turno
					lxPuntodeventa = loItem.Puntodeventa
					lxCotiza = loItem.Cotiza
					lxNroitem = lnContadorNroItem
					lxNumerocupon = loItem.Numerocupon
					lxNumerodecomprobante = loItem.Numerodecomprobante
					lxAutorizacionpos = loItem.Autorizacionpos
					lxPersonalizarcomprobante = loItem.Personalizarcomprobante
					lxVisualizarenestadodecaja = loItem.Visualizarenestadodecaja
					lxChequeelectronico = loItem.Chequeelectronico
					lxLetra = loItem.Letra
					lxNrodocumento = loItem.Nrodocumento
					lxTipodecomprobante = loItem.Tipodecomprobante
					lxNumerotarjeta = loItem.Numerotarjeta
					lxVendedor = loItem.Vendedor
					lxTipodocumento = loItem.Tipodocumento
					lxNumerocheque_PK = loItem.Numerocheque_PK
					lxNumerochequepropio_PK = loItem.Numerochequepropio_PK
					lxValor_PK = loItem.Valor_PK
					lxValordetalle = loItem.Valordetalle
					lxFecha = loItem.Fecha
					lxNumerointerno = loItem.Numerointerno
					lxMonto = loItem.Monto
					lxRecargoporcentaje = loItem.Recargoporcentaje
					lxRecargomonto = loItem.Recargomonto
					lxTotal = loItem.Total
					lxPesosalcambio = loItem.Pesosalcambio
					lxRecargomontosinimpuestos = loItem.Recargomontosinimpuestos
					lxMontoamonedasistema = loItem.Montoamonedasistema
					lxRecargosinpercepciones = loItem.Recargosinpercepciones
					lxPermitevuelto = loItem.Permitevuelto
					lxIditemcomponente = loItem.Iditemcomponente
					lxCodigodecupon = loItem.Codigodecupon
					lxCupon_PK = loItem.Cupon_PK
					lxNumerovaledecambio_PK = loItem.Numerovaledecambio_PK
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.CanjeCuponesDet("FechCoti","JJfecha","IdCaja","JJT","Cotiza","Signo","JJTurno","PtoVenta","JJCotiz","NroItem","NroCupon","NumCompr","Autorizado","PersComp","VisualCaja","CElectro","Letra","NroDoc","TIPCOMP","NroTarjeta","JJVen","TipoDoc","JJNUM","NroCheque","NroChProp","JJCO","JJDE","JJFE","NroInterno","JJM","jrecporc","jrecmnt","JJTotFac","Pesos","jrecmntsi","Montosiste","jrrecsperc","permvuelto","guidComp","guidCupon","Cupon","ValeCambio" ) values ( <<"'" + this.ConvertirDateSql( lxFechaultcotizacion ) + "'">>, <<"'" + this.ConvertirDateSql( lxFechacomp ) + "'">>, <<lxCaja_PK>>, <<lxTipo>>, <<lxUltimacotizacion>>, <<lxSigno>>, <<lxTurno>>, <<lxPuntodeventa>>, <<lxCotiza>>, <<lxNroitem>>, <<lxNumerocupon>>, <<lxNumerodecomprobante>>, <<iif( lxAutorizacionpos, 1, 0 )>>, <<iif( lxPersonalizarcomprobante, 1, 0 )>>, <<iif( lxVisualizarenestadodecaja, 1, 0 )>>, <<iif( lxChequeelectronico, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxLetra ) + "'">>, <<"'" + this.FormatearTextoSql( lxNrodocumento ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipodecomprobante ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerotarjeta ) + "'">>, <<"'" + this.FormatearTextoSql( lxVendedor ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipodocumento ) + "'">>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxNumerocheque_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerochequepropio_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValordetalle ) + "'">>, <<"'" + this.ConvertirDateSql( lxFecha ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerointerno ) + "'">>, <<lxMonto>>, <<lxRecargoporcentaje>>, <<lxRecargomonto>>, <<lxTotal>>, <<lxPesosalcambio>>, <<lxRecargomontosinimpuestos>>, <<lxMontoamonedasistema>>, <<lxRecargosinpercepciones>>, <<iif( lxPermitevuelto, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxIditemcomponente ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigodecupon ) + "'">>, <<"'" + this.FormatearTextoSql( lxCupon_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerovaledecambio_PK ) + "'">> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ValoresAEnt
				if this.oEntidad.ValoresAEnt.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxFechacomp = loItem.Fechacomp
					lxFechaultcotizacion = loItem.Fechaultcotizacion
					lxCaja_PK = loItem.Caja_PK
					lxSignodemovimiento = loItem.Signodemovimiento
					lxNumerocupon = loItem.Numerocupon
					lxUltimacotizacion = loItem.Ultimacotizacion
					lxCotiza = loItem.Cotiza
					lxNroitem = lnContadorNroItem
					lxTipo = loItem.Tipo
					lxAutorizacionpos = loItem.Autorizacionpos
					lxChequeelectronico = loItem.Chequeelectronico
					lxVisualizarenestadodecaja = loItem.Visualizarenestadodecaja
					lxNumerotarjeta = loItem.Numerotarjeta
					lxValor_PK = loItem.Valor_PK
					lxNumerochequepropio_PK = loItem.Numerochequepropio_PK
					lxNumerocheque_PK = loItem.Numerocheque_PK
					lxLetracomprobante = loItem.Letracomprobante
					lxValordetalle = loItem.Valordetalle
					lxFecha = loItem.Fecha
					lxPuntodeventacomprobante = loItem.Puntodeventacomprobante
					lxNrocomprobante = loItem.Nrocomprobante
					lxNumerointerno = loItem.Numerointerno
					lxCupontipo = loItem.Cupontipo
					lxFechacomprobante = loItem.Fechacomprobante
					lxTipocomprobante = loItem.Tipocomprobante
					lxBasededatosorigen = loItem.Basededatosorigen
					lxHora = loItem.Hora
					lxMonto = loItem.Monto
					lxTotal = loItem.Total
					lxSerieorigen = loItem.Serieorigen
					lxPesosalcambio = loItem.Pesosalcambio
					lxMontoamonedasistema = loItem.Montoamonedasistema
					lxMontocupon = loItem.Montocupon
					lxIditemcomponente = loItem.Iditemcomponente
					lxCodigodecupon = loItem.Codigodecupon
					lxCupon_PK = loItem.Cupon_PK
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.CanjeCuponesEnt("JJfecha","FechCoti","IdCaja","Signo","NroCupon","Cotiza","JJCotiz","NROITEM","JJT","Autorizado","CElectro","VisualCaja","NroTarjeta","JJCO","Codigo","NroChProp","NroCheque","Letra","JJDE","JJFE","PtoVen","NumCompr","NroInterno","tipo","FechaComp","TipComp","BaseDatos","Hora","JJM","JJTotFac","Serie","Pesos","Montosiste","MonCupon","guidComp","guidCupon","Cupon" ) values ( <<"'" + this.ConvertirDateSql( lxFechacomp ) + "'">>, <<"'" + this.ConvertirDateSql( lxFechaultcotizacion ) + "'">>, <<lxCaja_PK>>, <<lxSignodemovimiento>>, <<lxNumerocupon>>, <<lxUltimacotizacion>>, <<lxCotiza>>, <<lxNroitem>>, <<lxTipo>>, <<iif( lxAutorizacionpos, 1, 0 )>>, <<iif( lxChequeelectronico, 1, 0 )>>, <<iif( lxVisualizarenestadodecaja, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxNumerotarjeta ) + "'">>, <<"'" + this.FormatearTextoSql( lxValor_PK ) + "'">>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxNumerochequepropio_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerocheque_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxLetracomprobante ) + "'">>, <<"'" + this.FormatearTextoSql( lxValordetalle ) + "'">>, <<"'" + this.ConvertirDateSql( lxFecha ) + "'">>, <<lxPuntodeventacomprobante>>, <<lxNrocomprobante>>, <<"'" + this.FormatearTextoSql( lxNumerointerno ) + "'">>, <<"'" + this.FormatearTextoSql( lxCupontipo ) + "'">>, <<"'" + this.ConvertirDateSql( lxFechacomprobante ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipocomprobante ) + "'">>, <<"'" + this.FormatearTextoSql( lxBasededatosorigen ) + "'">>, <<"'" + this.FormatearTextoSql( lxHora ) + "'">>, <<lxMonto>>, <<lxTotal>>, <<"'" + this.FormatearTextoSql( lxSerieorigen ) + "'">>, <<lxPesosalcambio>>, <<lxMontoamonedasistema>>, <<lxMontocupon>>, <<"'" + this.FormatearTextoSql( lxIditemcomponente ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigodecupon ) + "'">>, <<"'" + this.FormatearTextoSql( lxCupon_PK ) + "'">> ) 
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
			local  lxCanjecuponesFaltafw, lxCanjecuponesFectrans, lxCanjecuponesFecexpo, lxCanjecuponesFecimpo, lxCanjecuponesFmodifw, lxCanjecuponesFacttipo, lxCanjecuponesValtip, lxCanjecuponesSigno, lxCanjecuponesHoraexpo, lxCanjecuponesHoraimpo, lxCanjecuponesBdaltafw, lxCanjecuponesHaltafw, lxCanjecuponesEsttrans, lxCanjecuponesBdmodifw, lxCanjecuponesValordet, lxCanjecuponesZadsfw, lxCanjecuponesHmodifw, lxCanjecuponesUaltafw, lxCanjecuponesUmodifw, lxCanjecuponesSmodifw, lxCanjecuponesVmodifw, lxCanjecuponesValtafw, lxCanjecuponesDescfw, lxCanjecuponesSaltafw, lxCanjecuponesCupon, lxCanjecuponesIdcaja, lxCanjecuponesCodigo, lxCanjecuponesMoneda, lxCanjecuponesValor, lxCanjecuponesFletra, lxCanjecuponesComptipo, lxCanjecuponesCliente, lxCanjecuponesObs, lxCanjecuponesFptoven, lxCanjecuponesLetra, lxCanjecuponesProveedor, lxCanjecuponesNumero, lxCanjecuponesFecha, lxCanjecuponesPtoven, lxCanjecuponesTipo, lxCanjecuponesConcepto, lxCanjecuponesNumcomp, lxCanjecuponesNumerocup, lxCanjecuponesVendedor, lxCanjecuponesFechacomp, lxCanjecuponesFechacup, lxCanjecuponesBasedatos, lxCanjecuponesFtotal, lxCanjecuponesHora, lxCanjecuponesSerie, lxCanjecuponesMonto, lxCanjecuponesAnulado
				lxCanjecuponesFaltafw =  .Fechaaltafw			lxCanjecuponesFectrans =  .Fechatransferencia			lxCanjecuponesFecexpo =  .Fechaexpo			lxCanjecuponesFecimpo =  .Fechaimpo			lxCanjecuponesFmodifw =  .Fechamodificacionfw			lxCanjecuponesFacttipo =  .Tipocomprobante			lxCanjecuponesValtip =  .Cuponvalortipo			lxCanjecuponesSigno =  .Signodemovimiento			lxCanjecuponesHoraexpo =  .Horaexpo			lxCanjecuponesHoraimpo =  .Horaimpo			lxCanjecuponesBdaltafw =  .Basededatosaltafw			lxCanjecuponesHaltafw =  .Horaaltafw			lxCanjecuponesEsttrans =  .Estadotransferencia			lxCanjecuponesBdmodifw =  .Basededatosmodificacionfw			lxCanjecuponesValordet =  .Cuponvalordetalle			lxCanjecuponesZadsfw =  .Zadsfw			lxCanjecuponesHmodifw =  .Horamodificacionfw			lxCanjecuponesUaltafw =  .Usuarioaltafw			lxCanjecuponesUmodifw =  .Usuariomodificacionfw			lxCanjecuponesSmodifw =  .Seriemodificacionfw			lxCanjecuponesVmodifw =  .Versionmodificacionfw			lxCanjecuponesValtafw =  .Versionaltafw			lxCanjecuponesDescfw =  .Descripcionfw			lxCanjecuponesSaltafw =  .Seriealtafw			lxCanjecuponesCupon =  upper( .Cupon_PK ) 			lxCanjecuponesIdcaja =  .Cuponidcaja_PK 			lxCanjecuponesCodigo =  .Codigo			lxCanjecuponesMoneda =  upper( .MonedaComprobante_PK ) 			lxCanjecuponesValor =  upper( .CuponValor_PK ) 			lxCanjecuponesFletra =  .Letra			lxCanjecuponesComptipo =  .Cupontipocomprobante			lxCanjecuponesCliente =  upper( .Cliente_PK ) 			lxCanjecuponesObs =  .Obs			lxCanjecuponesFptoven =  .Puntodeventa			lxCanjecuponesLetra =  .Cuponletracomprobante			lxCanjecuponesProveedor =  upper( .Proveedor_PK ) 			lxCanjecuponesNumero =  .Numero			lxCanjecuponesFecha =  .Fecha			lxCanjecuponesPtoven =  .Cuponpuntodeventacomprobante			lxCanjecuponesTipo =  .Cupontipo			lxCanjecuponesConcepto =  upper( .Concepto_PK ) 			lxCanjecuponesNumcomp =  .Cuponnumerocomprobante			lxCanjecuponesNumerocup =  .Cuponnumerocupon			lxCanjecuponesVendedor =  upper( .Vendedor_PK ) 			lxCanjecuponesFechacomp =  .Cuponfechacomprobante			lxCanjecuponesFechacup =  .Cuponfecha			lxCanjecuponesBasedatos =  .Cuponbasededatos			lxCanjecuponesFtotal =  .Total			lxCanjecuponesHora =  .Cuponhora			lxCanjecuponesSerie =  .Cuponserieorigen			lxCanjecuponesMonto =  .Cuponmonto			lxCanjecuponesAnulado =  .Anulado
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  CANJECUPONES.CODIGO != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.CANJECUPONES set "Faltafw" = <<"'" + this.ConvertirDateSql( lxCanjecuponesFaltafw ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxCanjecuponesFectrans ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxCanjecuponesFecexpo ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxCanjecuponesFecimpo ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxCanjecuponesFmodifw ) + "'">>, "Facttipo" = <<lxCanjecuponesFacttipo>>, "Valtip" = <<lxCanjecuponesValtip>>, "Signo" = <<lxCanjecuponesSigno>>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxCanjecuponesHoraexpo ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxCanjecuponesHoraimpo ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxCanjecuponesBdaltafw ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxCanjecuponesHaltafw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxCanjecuponesEsttrans ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxCanjecuponesBdmodifw ) + "'">>, "Valordet" = <<"'" + this.FormatearTextoSql( lxCanjecuponesValordet ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxCanjecuponesZadsfw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxCanjecuponesHmodifw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxCanjecuponesUaltafw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxCanjecuponesUmodifw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxCanjecuponesSmodifw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxCanjecuponesVmodifw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxCanjecuponesValtafw ) + "'">>, "Descfw" = <<"'" + this.FormatearTextoSql( lxCanjecuponesDescfw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxCanjecuponesSaltafw ) + "'">>, "Cupon" = <<"'" + this.FormatearTextoSql( lxCanjecuponesCupon ) + "'">>, "Idcaja" = <<lxCanjecuponesIdcaja>>, "Codigo" = <<"'" + this.FormatearTextoSql( lxCanjecuponesCodigo ) + "'">>, "Moneda" = <<"'" + this.FormatearTextoSql( lxCanjecuponesMoneda ) + "'">>, "Valor" = <<"'" + this.FormatearTextoSql( lxCanjecuponesValor ) + "'">>, "Fletra" = <<"'" + this.FormatearTextoSql( lxCanjecuponesFletra ) + "'">>, "Comptipo" = <<lxCanjecuponesComptipo>>, "Cliente" = <<"'" + this.FormatearTextoSql( lxCanjecuponesCliente ) + "'">>, "Obs" = <<"'" + this.FormatearTextoSql( lxCanjecuponesObs ) + "'">>, "Fptoven" = <<lxCanjecuponesFptoven>>, "Letra" = <<"'" + this.FormatearTextoSql( lxCanjecuponesLetra ) + "'">>, "Proveedor" = <<"'" + this.FormatearTextoSql( lxCanjecuponesProveedor ) + "'">>, "Numero" = <<lxCanjecuponesNumero>>, "Fecha" = <<"'" + this.ConvertirDateSql( lxCanjecuponesFecha ) + "'">>, "Ptoven" = <<lxCanjecuponesPtoven>>, "Tipo" = <<"'" + this.FormatearTextoSql( lxCanjecuponesTipo ) + "'">>, "Concepto" = <<"'" + this.FormatearTextoSql( lxCanjecuponesConcepto ) + "'">>, "Numcomp" = <<lxCanjecuponesNumcomp>>, "Numerocup" = <<lxCanjecuponesNumerocup>>, "Vendedor" = <<"'" + this.FormatearTextoSql( lxCanjecuponesVendedor ) + "'">>, "Fechacomp" = <<"'" + this.ConvertirDateSql( lxCanjecuponesFechacomp ) + "'">>, "Fechacup" = <<"'" + this.ConvertirDateSql( lxCanjecuponesFechacup ) + "'">>, "Basedatos" = <<"'" + this.FormatearTextoSql( lxCanjecuponesBasedatos ) + "'">>, "Ftotal" = <<lxCanjecuponesFtotal>>, "Hora" = <<"'" + this.FormatearTextoSql( lxCanjecuponesHora ) + "'">>, "Serie" = <<"'" + this.FormatearTextoSql( lxCanjecuponesSerie ) + "'">>, "Monto" = <<lxCanjecuponesMonto>>, "Anulado" = <<iif( lxCanjecuponesAnulado, 1, 0 )>> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'CANJECUPONES' 
		loColeccion.agregar( strtran(  lcSentencia, chr( 9 ), '' ) )
			loColeccion.Agregar([delete from ZooLogic.CanjeCuponesDet where "JJNUM" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.CanjeCuponesEnt where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ValoresDetalle
				if this.oEntidad.ValoresDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxFechaultcotizacion = loItem.Fechaultcotizacion
					lxFechacomp = loItem.Fechacomp
					lxCaja_PK = loItem.Caja_PK
					lxTipo = loItem.Tipo
					lxUltimacotizacion = loItem.Ultimacotizacion
					lxSigno = loItem.Signo
					lxTurno = loItem.Turno
					lxPuntodeventa = loItem.Puntodeventa
					lxCotiza = loItem.Cotiza
					lxNroitem = lnContadorNroItem
					lxNumerocupon = loItem.Numerocupon
					lxNumerodecomprobante = loItem.Numerodecomprobante
					lxAutorizacionpos = loItem.Autorizacionpos
					lxPersonalizarcomprobante = loItem.Personalizarcomprobante
					lxVisualizarenestadodecaja = loItem.Visualizarenestadodecaja
					lxChequeelectronico = loItem.Chequeelectronico
					lxLetra = loItem.Letra
					lxNrodocumento = loItem.Nrodocumento
					lxTipodecomprobante = loItem.Tipodecomprobante
					lxNumerotarjeta = loItem.Numerotarjeta
					lxVendedor = loItem.Vendedor
					lxTipodocumento = loItem.Tipodocumento
					lxNumerocheque_PK = loItem.Numerocheque_PK
					lxNumerochequepropio_PK = loItem.Numerochequepropio_PK
					lxValor_PK = loItem.Valor_PK
					lxValordetalle = loItem.Valordetalle
					lxFecha = loItem.Fecha
					lxNumerointerno = loItem.Numerointerno
					lxMonto = loItem.Monto
					lxRecargoporcentaje = loItem.Recargoporcentaje
					lxRecargomonto = loItem.Recargomonto
					lxTotal = loItem.Total
					lxPesosalcambio = loItem.Pesosalcambio
					lxRecargomontosinimpuestos = loItem.Recargomontosinimpuestos
					lxMontoamonedasistema = loItem.Montoamonedasistema
					lxRecargosinpercepciones = loItem.Recargosinpercepciones
					lxPermitevuelto = loItem.Permitevuelto
					lxIditemcomponente = loItem.Iditemcomponente
					lxCodigodecupon = loItem.Codigodecupon
					lxCupon_PK = loItem.Cupon_PK
					lxNumerovaledecambio_PK = loItem.Numerovaledecambio_PK
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.CanjeCuponesDet("FechCoti","JJfecha","IdCaja","JJT","Cotiza","Signo","JJTurno","PtoVenta","JJCotiz","NroItem","NroCupon","NumCompr","Autorizado","PersComp","VisualCaja","CElectro","Letra","NroDoc","TIPCOMP","NroTarjeta","JJVen","TipoDoc","JJNUM","NroCheque","NroChProp","JJCO","JJDE","JJFE","NroInterno","JJM","jrecporc","jrecmnt","JJTotFac","Pesos","jrecmntsi","Montosiste","jrrecsperc","permvuelto","guidComp","guidCupon","Cupon","ValeCambio" ) values ( <<"'" + this.ConvertirDateSql( lxFechaultcotizacion ) + "'">>, <<"'" + this.ConvertirDateSql( lxFechacomp ) + "'">>, <<lxCaja_PK>>, <<lxTipo>>, <<lxUltimacotizacion>>, <<lxSigno>>, <<lxTurno>>, <<lxPuntodeventa>>, <<lxCotiza>>, <<lxNroitem>>, <<lxNumerocupon>>, <<lxNumerodecomprobante>>, <<iif( lxAutorizacionpos, 1, 0 )>>, <<iif( lxPersonalizarcomprobante, 1, 0 )>>, <<iif( lxVisualizarenestadodecaja, 1, 0 )>>, <<iif( lxChequeelectronico, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxLetra ) + "'">>, <<"'" + this.FormatearTextoSql( lxNrodocumento ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipodecomprobante ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerotarjeta ) + "'">>, <<"'" + this.FormatearTextoSql( lxVendedor ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipodocumento ) + "'">>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxNumerocheque_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerochequepropio_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValordetalle ) + "'">>, <<"'" + this.ConvertirDateSql( lxFecha ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerointerno ) + "'">>, <<lxMonto>>, <<lxRecargoporcentaje>>, <<lxRecargomonto>>, <<lxTotal>>, <<lxPesosalcambio>>, <<lxRecargomontosinimpuestos>>, <<lxMontoamonedasistema>>, <<lxRecargosinpercepciones>>, <<iif( lxPermitevuelto, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxIditemcomponente ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigodecupon ) + "'">>, <<"'" + this.FormatearTextoSql( lxCupon_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerovaledecambio_PK ) + "'">> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ValoresAEnt
				if this.oEntidad.ValoresAEnt.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxFechacomp = loItem.Fechacomp
					lxFechaultcotizacion = loItem.Fechaultcotizacion
					lxCaja_PK = loItem.Caja_PK
					lxSignodemovimiento = loItem.Signodemovimiento
					lxNumerocupon = loItem.Numerocupon
					lxUltimacotizacion = loItem.Ultimacotizacion
					lxCotiza = loItem.Cotiza
					lxNroitem = lnContadorNroItem
					lxTipo = loItem.Tipo
					lxAutorizacionpos = loItem.Autorizacionpos
					lxChequeelectronico = loItem.Chequeelectronico
					lxVisualizarenestadodecaja = loItem.Visualizarenestadodecaja
					lxNumerotarjeta = loItem.Numerotarjeta
					lxValor_PK = loItem.Valor_PK
					lxNumerochequepropio_PK = loItem.Numerochequepropio_PK
					lxNumerocheque_PK = loItem.Numerocheque_PK
					lxLetracomprobante = loItem.Letracomprobante
					lxValordetalle = loItem.Valordetalle
					lxFecha = loItem.Fecha
					lxPuntodeventacomprobante = loItem.Puntodeventacomprobante
					lxNrocomprobante = loItem.Nrocomprobante
					lxNumerointerno = loItem.Numerointerno
					lxCupontipo = loItem.Cupontipo
					lxFechacomprobante = loItem.Fechacomprobante
					lxTipocomprobante = loItem.Tipocomprobante
					lxBasededatosorigen = loItem.Basededatosorigen
					lxHora = loItem.Hora
					lxMonto = loItem.Monto
					lxTotal = loItem.Total
					lxSerieorigen = loItem.Serieorigen
					lxPesosalcambio = loItem.Pesosalcambio
					lxMontoamonedasistema = loItem.Montoamonedasistema
					lxMontocupon = loItem.Montocupon
					lxIditemcomponente = loItem.Iditemcomponente
					lxCodigodecupon = loItem.Codigodecupon
					lxCupon_PK = loItem.Cupon_PK
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.CanjeCuponesEnt("JJfecha","FechCoti","IdCaja","Signo","NroCupon","Cotiza","JJCotiz","NROITEM","JJT","Autorizado","CElectro","VisualCaja","NroTarjeta","JJCO","Codigo","NroChProp","NroCheque","Letra","JJDE","JJFE","PtoVen","NumCompr","NroInterno","tipo","FechaComp","TipComp","BaseDatos","Hora","JJM","JJTotFac","Serie","Pesos","Montosiste","MonCupon","guidComp","guidCupon","Cupon" ) values ( <<"'" + this.ConvertirDateSql( lxFechacomp ) + "'">>, <<"'" + this.ConvertirDateSql( lxFechaultcotizacion ) + "'">>, <<lxCaja_PK>>, <<lxSignodemovimiento>>, <<lxNumerocupon>>, <<lxUltimacotizacion>>, <<lxCotiza>>, <<lxNroitem>>, <<lxTipo>>, <<iif( lxAutorizacionpos, 1, 0 )>>, <<iif( lxChequeelectronico, 1, 0 )>>, <<iif( lxVisualizarenestadodecaja, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxNumerotarjeta ) + "'">>, <<"'" + this.FormatearTextoSql( lxValor_PK ) + "'">>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxNumerochequepropio_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerocheque_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxLetracomprobante ) + "'">>, <<"'" + this.FormatearTextoSql( lxValordetalle ) + "'">>, <<"'" + this.ConvertirDateSql( lxFecha ) + "'">>, <<lxPuntodeventacomprobante>>, <<lxNrocomprobante>>, <<"'" + this.FormatearTextoSql( lxNumerointerno ) + "'">>, <<"'" + this.FormatearTextoSql( lxCupontipo ) + "'">>, <<"'" + this.ConvertirDateSql( lxFechacomprobante ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipocomprobante ) + "'">>, <<"'" + this.FormatearTextoSql( lxBasededatosorigen ) + "'">>, <<"'" + this.FormatearTextoSql( lxHora ) + "'">>, <<lxMonto>>, <<lxTotal>>, <<"'" + this.FormatearTextoSql( lxSerieorigen ) + "'">>, <<lxPesosalcambio>>, <<lxMontoamonedasistema>>, <<lxMontocupon>>, <<"'" + this.FormatearTextoSql( lxIditemcomponente ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigodecupon ) + "'">>, <<"'" + this.FormatearTextoSql( lxCupon_PK ) + "'">> ) 
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

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  CANJECUPONES.CODIGO != '']
		loColeccion.Agregar( 'delete from ZooLogic.CANJECUPONES where ' + lcFiltro )
			loColeccion.Agregar([delete from ZooLogic.CanjeCuponesDet where "JJNUM" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.CanjeCuponesEnt where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.cTabla = 'CANJECUPONES' 
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
		
			.oCompCanjedecupones.lNuevo = .EsNuevo()
			.oCompCanjedecupones.lEdicion = .EsEdicion()
			.oCompCanjedecupones.lEliminar = .lEliminar
			.oCompCanjedecupones.lAnular = .lAnular
			loColSentencias = .oCompCanjedecupones.grabar()
			for each lcItem in loColSentencias
				this.colSentencias.Agregar( lcItem )
			endfor
			
		endwith
		
		with this.oEntidad
			.ValoresDetalle.oItem.oCompCajero.lNuevo = .EsNuevo()
			.ValoresDetalle.oItem.oCompCajero.lEdicion = .EsEdicion()
			.ValoresDetalle.oItem.oCompCajero.lEliminar = .lEliminar
			.ValoresDetalle.oItem.oCompCajero.lAnular = .lAnular
			loColSentencias = .ValoresDetalle.oItem.oCompCajero.grabar()
			for each lcItem in loColSentencias
				this.colSentencias.Agregar( lcItem )
			endfor
			
			.ValoresAEnt.oItem.oCompCajero.lNuevo = .EsNuevo()
			.ValoresAEnt.oItem.oCompCajero.lEdicion = .EsEdicion()
			.ValoresAEnt.oItem.oCompCajero.lEliminar = .lEliminar
			.ValoresAEnt.oItem.oCompCajero.lAnular = .lAnular
			loColSentencias = .ValoresAEnt.oItem.oCompCajero.grabar()
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
			lcRetorno = [update ZooLogic.CANJECUPONES set TimeStamp = ] + transform( lnTimeStamp ) + lcUpdateRealTime + [ where Codigo = ] + "'" + this.FormatearTextoSql( .Codigo ) + "'" + [ and  CANJECUPONES.CODIGO != ''] + goServicios.RealTime.ObtenerTagEstimulo( .cNombre )
		
		endwith
		return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function ObtenerCantidadRegistros() as integer
		local lnCantReg as integer
			local lcXml as string
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.CANJECUPONES where  CANJECUPONES.CODIGO != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.CANJECUPONES where Codigo = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  CANJECUPONES.CODIGO != ''" )
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
		local lcCursor as String, ldFecha as Date, lcHora as string, lcValorABuscar As String, lxValorClavePK As variant, lxValorClavePrimaria As variant, lcIdentificadorParaLoguear as string, lxCanjeCuponesFACTTIPO as variant, lxCanjeCuponesFLETRA as variant, lxCanjeCuponesFPTOVEN as variant, lxCanjeCuponesNumero as variant, lcMensajeExtra as String
		lcValorABuscar = ''
		lxValorClavePK = ''
		lcMensajeExtra = ''
		lcCursor = This.oEntidad.cPrefijoRecibir + 'CANJEDECUPONES'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.CANJECUPONES Where  FACTTIPO = ] + transform( &lcCursor..FACTTIPO   ) + [ and FLETRA = ] + "'" + this.FormatearTextoSql( &lcCursor..FLETRA     ) + "'" + [ and FPTOVEN = ] + transform( &lcCursor..FPTOVEN    ) + [ and Numero = ] + transform( &lcCursor..Numero     ), 'curSeek', this.datasessionid )
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
								this.oConexion.EjecutarSql( [UPDATE ZooLogic.CANJECUPONES set  FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FACTTIPO = ] + transform( &lcCursor..FACTTIPO )+ [, ValTip = ] + transform( &lcCursor..ValTip )+ [, Signo = ] + transform( &lcCursor..Signo )+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, ValorDet = ] + "'" + this.FormatearTextoSql( &lcCursor..ValorDet ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, DescFW = ] + "'" + this.FormatearTextoSql( &lcCursor..DescFW ) + "'"+ [, Cupon = ] + "'" + this.FormatearTextoSql( &lcCursor..Cupon ) + "'"+ [, IdCaja = ] + transform( &lcCursor..IdCaja )+ [, Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'"+ [, Moneda = ] + "'" + this.FormatearTextoSql( &lcCursor..Moneda ) + "'"+ [, Valor = ] + "'" + this.FormatearTextoSql( &lcCursor..Valor ) + "'"+ [, FLETRA = ] + "'" + this.FormatearTextoSql( &lcCursor..FLETRA ) + "'"+ [, CompTipo = ] + transform( &lcCursor..CompTipo )+ [, Cliente = ] + "'" + this.FormatearTextoSql( &lcCursor..Cliente ) + "'"+ [, Obs = ] + "'" + this.FormatearTextoSql( &lcCursor..Obs ) + "'"+ [, FPTOVEN = ] + transform( &lcCursor..FPTOVEN )+ [, Letra = ] + "'" + this.FormatearTextoSql( &lcCursor..Letra ) + "'"+ [, Proveedor = ] + "'" + this.FormatearTextoSql( &lcCursor..Proveedor ) + "'"+ [, Numero = ] + transform( &lcCursor..Numero )+ [, Fecha = ] + "'" + this.ConvertirDateSql( &lcCursor..Fecha ) + "'"+ [, PtoVen = ] + transform( &lcCursor..PtoVen )+ [, tipo = ] + "'" + this.FormatearTextoSql( &lcCursor..tipo ) + "'"+ [, Concepto = ] + "'" + this.FormatearTextoSql( &lcCursor..Concepto ) + "'"+ [, NumComp = ] + transform( &lcCursor..NumComp )+ [, NumeroCup = ] + transform( &lcCursor..NumeroCup )+ [, Vendedor = ] + "'" + this.FormatearTextoSql( &lcCursor..Vendedor ) + "'"+ [, FechaComp = ] + "'" + this.ConvertirDateSql( &lcCursor..FechaComp ) + "'"+ [, FechaCup = ] + "'" + this.ConvertirDateSql( &lcCursor..FechaCup ) + "'"+ [, BaseDatos = ] + "'" + this.FormatearTextoSql( &lcCursor..BaseDatos ) + "'"+ [, FTotal = ] + transform( &lcCursor..FTotal )+ [, Hora = ] + "'" + this.FormatearTextoSql( &lcCursor..Hora ) + "'"+ [, Serie = ] + "'" + this.FormatearTextoSql( &lcCursor..Serie ) + "'"+ [, Monto = ] + transform( &lcCursor..Monto )+ [, Anulado = ] + Transform( iif( &lcCursor..Anulado, 1, 0 )) + [ Where Codigo = ] + "'" + this.FormatearTextoSql( lcValorABuscar ) + "'" )
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
				this.oConexion.EjecutarSql( [Select * From ZooLogic.CANJECUPONES Where Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'", 'curSeek', this.datasessionid )
				if reccount( 'curSeek' ) > 0
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir como alta porque la clave principal ya existe', tlLoguear )
				Else
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					Text to lcCampos noShow
						 FALTAFW, FECTRANS, FECEXPO, FECIMPO, FMODIFW, FACTTIPO, ValTip, Signo, HORAEXPO, HORAIMPO, BDALTAFW, HALTAFW, ESTTRANS, BDMODIFW, ValorDet, ZADSFW, HMODIFW, UALTAFW, UMODIFW, SMODIFW, VMODIFW, VALTAFW, DescFW, SALTAFW, Cupon, IdCaja, Codigo, Moneda, Valor, FLETRA, CompTipo, Cliente, Obs, FPTOVEN, Letra, Proveedor, Numero, Fecha, PtoVen, tipo, Concepto, NumComp, NumeroCup, Vendedor, FechaComp, FechaCup, BaseDatos, FTotal, Hora, Serie, Monto, Anulado
					EndText
					local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + transform( &lcCursor..FACTTIPO ) + ',' + transform( &lcCursor..ValTip )
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..Signo ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..ValorDet ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..DescFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Cupon ) + "'" + ',' + transform( &lcCursor..IdCaja ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Moneda ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..Valor ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..FLETRA ) + "'" + ',' + transform( &lcCursor..CompTipo ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..Cliente ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Obs ) + "'" + ',' + transform( &lcCursor..FPTOVEN ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..Letra ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Proveedor ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..Numero ) + ',' + "'" + this.ConvertirDateSql( &lcCursor..Fecha ) + "'" + ',' + transform( &lcCursor..PtoVen ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..tipo ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Concepto ) + "'" + ',' + transform( &lcCursor..NumComp ) + ',' + transform( &lcCursor..NumeroCup ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..Vendedor ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FechaComp ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FechaCup ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BaseDatos ) + "'" + ',' + transform( &lcCursor..FTotal ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..Hora ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Serie ) + "'" + ',' + transform( &lcCursor..Monto ) + ',' + Transform( iif( &lcCursor..Anulado, 1, 0 ))
lcValoresCampos = substr(lcValoresCampos,2) 

					this.oConexion.EjecutarSql( [Insert into ZooLogic.CANJECUPONES ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
				EndIf
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'CANJEDECUPONES'
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
			this.oConexion.EjecutarSql( [Delete From ZooLogic.CanjeCuponesDet Where JJNUM] + lcIn  )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.CanjeCuponesEnt Where Codigo] + lcIn  )
			endfor
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'COMMIT TRANSACTION' )
			endif
		EndIf
	endif
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMCANJECUPONES'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where JJNUM in ( select Codigo from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"FechCoti","JJfecha","IdCaja","JJT","Cotiza","Signo","JJTurno","PtoVenta","JJCotiz","NroItem","NroCupon","NumCompr","Autorizado","PersComp","VisualCaja","CElectro","Letra","NroDoc","TIPCOMP","NroTarjeta","JJVen","TipoDoc","JJNUM","NroCheque","NroChProp","JJCO","JJDE","JJFE","NroInterno","JJM","jrecporc","jrecmnt","JJTotFac","Pesos","jrecmntsi","Montosiste","jrrecsperc","permvuelto","guidComp","guidCupon","Cupon","ValeCambio"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.CanjeCuponesDet ( ] + lcCamposInsert + [ ) values ( ] +  "'" + this.ConvertirDateSql( cDetallesExistentes.FechCoti   ) + "'" + ',' + "'" + this.ConvertirDateSql( cDetallesExistentes.JJfecha    ) + "'" + ',' + transform( cDetallesExistentes.IdCaja     ) + ',' + transform( cDetallesExistentes.JJT        ) + ',' + transform( cDetallesExistentes.Cotiza     ) + ',' + transform( cDetallesExistentes.Signo      ) + ',' + transform( cDetallesExistentes.JJTurno    ) + ',' + transform( cDetallesExistentes.PtoVenta   ) + ',' + transform( cDetallesExistentes.JJCotiz    ) + ',' + transform( cDetallesExistentes.NroItem    ) + ',' + transform( cDetallesExistentes.NroCupon   ) + ',' + transform( cDetallesExistentes.NumCompr   ) + ',' + Transform( iif( cDetallesExistentes.Autorizado, 1, 0 )) + ',' + Transform( iif( cDetallesExistentes.PersComp  , 1, 0 )) + ',' + Transform( iif( cDetallesExistentes.VisualCaja, 1, 0 )) + ',' + Transform( iif( cDetallesExistentes.CElectro  , 1, 0 )) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Letra      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.NroDoc     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.TIPCOMP    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.NroTarjeta ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.JJVen      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.TipoDoc    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.JJNUM      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.NroCheque  ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.NroChProp  ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.JJCO       ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.JJDE       ) + "'" + ',' + "'" + this.ConvertirDateSql( cDetallesExistentes.JJFE       ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.NroInterno ) + "'" + ',' + transform( cDetallesExistentes.JJM        ) + ',' + transform( cDetallesExistentes.jrecporc   ) + ',' + transform( cDetallesExistentes.jrecmnt    ) + ',' + transform( cDetallesExistentes.JJTotFac   ) + ',' + transform( cDetallesExistentes.Pesos      ) + ',' + transform( cDetallesExistentes.jrecmntsi  ) + ',' + transform( cDetallesExistentes.Montosiste ) + ',' + transform( cDetallesExistentes.jrrecsperc ) + ',' + Transform( iif( cDetallesExistentes.permvuelto, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.guidComp   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.guidCupon  ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Cupon      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ValeCambio ) + "'" + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMVALORESAENT'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where Codigo in ( select Codigo from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"JJfecha","FechCoti","IdCaja","Signo","NroCupon","Cotiza","JJCotiz","NROITEM","JJT","Autorizado","CElectro","VisualCaja","NroTarjeta","JJCO","Codigo","NroChProp","NroCheque","Letra","JJDE","JJFE","PtoVen","NumCompr","NroInterno","tipo","FechaComp","TipComp","BaseDatos","Hora","JJM","JJTotFac","Serie","Pesos","Montosiste","MonCupon","guidComp","guidCupon","Cupon"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.CanjeCuponesEnt ( ] + lcCamposInsert + [ ) values ( ] +  "'" + this.ConvertirDateSql( cDetallesExistentes.JJfecha    ) + "'" + ',' + "'" + this.ConvertirDateSql( cDetallesExistentes.FechCoti   ) + "'" + ',' + transform( cDetallesExistentes.IdCaja     ) + ',' + transform( cDetallesExistentes.Signo      ) + ',' + transform( cDetallesExistentes.NroCupon   ) + ',' + transform( cDetallesExistentes.Cotiza     ) + ',' + transform( cDetallesExistentes.JJCotiz    ) + ',' + transform( cDetallesExistentes.NROITEM    ) + ',' + transform( cDetallesExistentes.JJT        ) + ',' + Transform( iif( cDetallesExistentes.Autorizado, 1, 0 )) + ',' + Transform( iif( cDetallesExistentes.CElectro  , 1, 0 )) + ',' + Transform( iif( cDetallesExistentes.VisualCaja, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.NroTarjeta ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.JJCO       ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Codigo     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.NroChProp  ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.NroCheque  ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Letra      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.JJDE       ) + "'" + ',' + "'" + this.ConvertirDateSql( cDetallesExistentes.JJFE       ) + "'" + ',' + transform( cDetallesExistentes.PtoVen     ) + ',' + transform( cDetallesExistentes.NumCompr   ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.NroInterno ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.tipo       ) + "'" + ',' + "'" + this.ConvertirDateSql( cDetallesExistentes.FechaComp  ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.TipComp    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.BaseDatos  ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Hora       ) + "'" + ',' + transform( cDetallesExistentes.JJM        ) + ',' + transform( cDetallesExistentes.JJTotFac   ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Serie      ) + "'" + ',' + transform( cDetallesExistentes.Pesos      ) + ',' + transform( cDetallesExistentes.Montosiste ) + ',' + transform( cDetallesExistentes.MonCupon   ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.guidComp   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.guidCupon  ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Cupon      ) + "'" + ' )'  )
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
		this.oEntidad.ValoresDetalle.oItem.oCompCajero.Recibir( this.oEntidad, 'ValoresDetalle',this.oEntidad.cPrefijoRecibir + 'ITEMCANJECUPONES',this.oEntidad.cPrefijoRecibir + 'CANJEDECUPONES')
		this.oEntidad.ValoresAEnt.oItem.oCompCajero.Recibir( this.oEntidad, 'ValoresAEnt',this.oEntidad.cPrefijoRecibir + 'ITEMVALORESAENT',this.oEntidad.cPrefijoRecibir + 'CANJEDECUPONES')
		
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function ObtenerIdentificadorParaLoguear( tcCursor as String ) As String
		local lcRetorno as String, lnCC as String , loCC as Object, lni as Integer, lcSecuencia as String
		lcRetorno = this.oEntidad.cDescripcion 
		lcRetorno = lcRetorno + ' - Letra: ' + transform( &tcCursor..FLETRA     )
		lcRetorno = lcRetorno + ' - Pto. Venta: ' + transform( &tcCursor..FPTOVEN    )
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
			Case  lcAlias == lcPrefijo + 'CANJEDECUPONES'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'CANJEDECUPONES_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'CANJEDECUPONES_OBS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMCANJECUPONES'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMVALORESAENT'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_CanjeCupones')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'CANJEDECUPONES'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..Codigo
		llCondicion = isnull( lxVar ) or isnull( &lcCursor..FACTTIPO ) or isnull( &lcCursor..FLETRA ) or isnull( &lcCursor..FPTOVEN ) or isnull( &lcCursor..Numero )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad CANJEDECUPONES. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'CANJEDECUPONES'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		select recno() as _Rec, * from &lcCursor into cursor CurConRecno
		select max( _Rec ) as Maximo,Codigo as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( Codigo, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		select max( _Rec ) as Maximo,str( FACTTIPO, 2, 0) + FLETRA + str( FPTOVEN, 4, 0) + str( Numero, 12, 0) as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( str( FACTTIPO, 2, 0) + FLETRA + str( FPTOVEN, 4, 0) + str( Numero, 12, 0), 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		Use in select( 'CurConRecno' )
		Use in select( 'RepMax' )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDatosInvalidos( toConexion as Object ) as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'CANJEDECUPONES'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  Fecha     
		* Validar ANTERIORES A 1/1/1753  FechaComp 
		* Validar ANTERIORES A 1/1/1753  FechaCup  
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_CanjeCupones') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_CanjeCupones
Create Table ZooLogic.TablaTrabajo_CanjeCupones ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"faltafw" datetime  null, 
"fectrans" datetime  null, 
"fecexpo" datetime  null, 
"fecimpo" datetime  null, 
"fmodifw" datetime  null, 
"facttipo" numeric( 2, 0 )  null, 
"valtip" numeric( 2, 0 )  null, 
"signo" numeric( 2, 0 )  null, 
"horaexpo" char( 8 )  null, 
"horaimpo" char( 8 )  null, 
"bdaltafw" char( 8 )  null, 
"haltafw" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"bdmodifw" char( 8 )  null, 
"valordet" char( 30 )  null, 
"zadsfw" varchar(max)  null, 
"hmodifw" char( 8 )  null, 
"ualtafw" char( 100 )  null, 
"umodifw" char( 100 )  null, 
"smodifw" char( 7 )  null, 
"vmodifw" char( 13 )  null, 
"valtafw" char( 13 )  null, 
"descfw" char( 200 )  null, 
"saltafw" char( 7 )  null, 
"cupon" char( 38 )  null, 
"idcaja" numeric( 2, 0 )  null, 
"codigo" char( 38 )  null, 
"moneda" char( 10 )  null, 
"valor" char( 5 )  null, 
"fletra" char( 1 )  null, 
"comptipo" numeric( 2, 0 )  null, 
"cliente" char( 5 )  null, 
"obs" varchar(max)  null, 
"fptoven" numeric( 4, 0 )  null, 
"letra" char( 1 )  null, 
"proveedor" char( 5 )  null, 
"numero" numeric( 12, 0 )  null, 
"fecha" datetime  null, 
"ptoven" numeric( 4, 0 )  null, 
"tipo" char( 2 )  null, 
"concepto" char( 10 )  null, 
"numcomp" numeric( 8, 0 )  null, 
"numerocup" numeric( 12, 0 )  null, 
"vendedor" char( 5 )  null, 
"fechacomp" datetime  null, 
"fechacup" datetime  null, 
"basedatos" char( 8 )  null, 
"ftotal" numeric( 15, 2 )  null, 
"hora" char( 5 )  null, 
"serie" char( 10 )  null, 
"monto" numeric( 17, 2 )  null, 
"anulado" bit  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_CanjeCupones' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_CanjeCupones' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'CANJEDECUPONES'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		with loManejador
			if this.oEntidad.VerificarContexto( 'CB' )
			else
				.AgregarMapeo('Nrolinea','Nrolinea')
			endif
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('facttipo','facttipo')
			.AgregarMapeo('valtip','valtip')
			.AgregarMapeo('signo','signo')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('valordet','valordet')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('descfw','descfw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('cupon','cupon')
			.AgregarMapeo('idcaja','idcaja')
			.AgregarMapeo('codigo','codigo')
			.AgregarMapeo('moneda','moneda')
			.AgregarMapeo('valor','valor')
			.AgregarMapeo('fletra','fletra')
			.AgregarMapeo('comptipo','comptipo')
			.AgregarMapeo('cliente','cliente')
			.AgregarMapeo('obs','obs')
			.AgregarMapeo('fptoven','fptoven')
			.AgregarMapeo('letra','letra')
			.AgregarMapeo('proveedor','proveedor')
			.AgregarMapeo('numero','numero')
			.AgregarMapeo('fecha','fecha')
			.AgregarMapeo('ptoven','ptoven')
			.AgregarMapeo('tipo','tipo')
			.AgregarMapeo('concepto','concepto')
			.AgregarMapeo('numcomp','numcomp')
			.AgregarMapeo('numerocup','numerocup')
			.AgregarMapeo('vendedor','vendedor')
			.AgregarMapeo('fechacomp','fechacomp')
			.AgregarMapeo('fechacup','fechacup')
			.AgregarMapeo('basedatos','basedatos')
			.AgregarMapeo('ftotal','ftotal')
			.AgregarMapeo('hora','hora')
			.AgregarMapeo('serie','serie')
			.AgregarMapeo('monto','monto')
			.AgregarMapeo('anulado','anulado')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_CanjeCupones'
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
				Update t Set t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FACTTIPO = isnull( d.FACTTIPO, t.FACTTIPO ),t.VALTIP = isnull( d.VALTIP, t.VALTIP ),t.SIGNO = isnull( d.SIGNO, t.SIGNO ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.VALORDET = isnull( d.VALORDET, t.VALORDET ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.DESCFW = isnull( d.DESCFW, t.DESCFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.CUPON = isnull( d.CUPON, t.CUPON ),t.IDCAJA = isnull( d.IDCAJA, t.IDCAJA ),t.CODIGO = isnull( d.CODIGO, t.CODIGO ),t.MONEDA = isnull( d.MONEDA, t.MONEDA ),t.VALOR = isnull( d.VALOR, t.VALOR ),t.FLETRA = isnull( d.FLETRA, t.FLETRA ),t.COMPTIPO = isnull( d.COMPTIPO, t.COMPTIPO ),t.CLIENTE = isnull( d.CLIENTE, t.CLIENTE ),t.OBS = isnull( d.OBS, t.OBS ),t.FPTOVEN = isnull( d.FPTOVEN, t.FPTOVEN ),t.LETRA = isnull( d.LETRA, t.LETRA ),t.PROVEEDOR = isnull( d.PROVEEDOR, t.PROVEEDOR ),t.NUMERO = isnull( d.NUMERO, t.NUMERO ),t.FECHA = isnull( d.FECHA, t.FECHA ),t.PTOVEN = isnull( d.PTOVEN, t.PTOVEN ),t.TIPO = isnull( d.TIPO, t.TIPO ),t.CONCEPTO = isnull( d.CONCEPTO, t.CONCEPTO ),t.NUMCOMP = isnull( d.NUMCOMP, t.NUMCOMP ),t.NUMEROCUP = isnull( d.NUMEROCUP, t.NUMEROCUP ),t.VENDEDOR = isnull( d.VENDEDOR, t.VENDEDOR ),t.FECHACOMP = isnull( d.FECHACOMP, t.FECHACOMP ),t.FECHACUP = isnull( d.FECHACUP, t.FECHACUP ),t.BASEDATOS = isnull( d.BASEDATOS, t.BASEDATOS ),t.FTOTAL = isnull( d.FTOTAL, t.FTOTAL ),t.HORA = isnull( d.HORA, t.HORA ),t.SERIE = isnull( d.SERIE, t.SERIE ),t.MONTO = isnull( d.MONTO, t.MONTO ),t.ANULADO = isnull( d.ANULADO, t.ANULADO )
					from ZooLogic.CANJECUPONES t inner join deleted d 
							 on t.Codigo = d.Codigo
							 and  t.FACTTIPO = d.FACTTIPO
							 and  t.FLETRA = d.FLETRA
							 and  t.FPTOVEN = d.FPTOVEN
							 and  t.Numero = d.Numero
				-- Fin Updates
				insert into ZooLogic.CANJECUPONES(Faltafw,Fectrans,Fecexpo,Fecimpo,Fmodifw,Facttipo,Valtip,Signo,Horaexpo,Horaimpo,Bdaltafw,Haltafw,Esttrans,Bdmodifw,Valordet,Zadsfw,Hmodifw,Ualtafw,Umodifw,Smodifw,Vmodifw,Valtafw,Descfw,Saltafw,Cupon,Idcaja,Codigo,Moneda,Valor,Fletra,Comptipo,Cliente,Obs,Fptoven,Letra,Proveedor,Numero,Fecha,Ptoven,Tipo,Concepto,Numcomp,Numerocup,Vendedor,Fechacomp,Fechacup,Basedatos,Ftotal,Hora,Serie,Monto,Anulado)
					Select CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FECTRANS,''),isnull( d.FECEXPO,''),isnull( d.FECIMPO,''),isnull( d.FMODIFW,''),isnull( d.FACTTIPO,0),isnull( d.VALTIP,0),isnull( d.SIGNO,0),isnull( d.HORAEXPO,''),isnull( d.HORAIMPO,''),isnull( d.BDALTAFW,''),convert( char(8), getdate(), 108 ),isnull( d.ESTTRANS,''),isnull( d.BDMODIFW,''),isnull( d.VALORDET,''),isnull( d.ZADSFW,''),isnull( d.HMODIFW,''),isnull( d.UALTAFW,''),isnull( d.UMODIFW,''),isnull( d.SMODIFW,''),isnull( d.VMODIFW,''),isnull( d.VALTAFW,''),isnull( d.DESCFW,''),isnull( d.SALTAFW,''),isnull( d.CUPON,''),isnull( d.IDCAJA,0),isnull( d.CODIGO,''),isnull( d.MONEDA,''),isnull( d.VALOR,''),isnull( d.FLETRA,''),isnull( d.COMPTIPO,0),isnull( d.CLIENTE,''),isnull( d.OBS,''),isnull( d.FPTOVEN,0),isnull( d.LETRA,''),isnull( d.PROVEEDOR,''),isnull( d.NUMERO,0),isnull( d.FECHA,''),isnull( d.PTOVEN,0),isnull( d.TIPO,''),isnull( d.CONCEPTO,''),isnull( d.NUMCOMP,0),isnull( d.NUMEROCUP,0),isnull( d.VENDEDOR,''),isnull( d.FECHACOMP,''),isnull( d.FECHACUP,''),isnull( d.BASEDATOS,''),isnull( d.FTOTAL,0),isnull( d.HORA,''),isnull( d.SERIE,''),isnull( d.MONTO,0),isnull( d.ANULADO,0)
						From deleted d left join ZooLogic.CANJECUPONES pk 
							 on d.Codigo = pk.Codigo
						 left join ZooLogic.CANJECUPONES cc 
							 on  d.FACTTIPO = cc.FACTTIPO
							 and  d.FLETRA = cc.FLETRA
							 and  d.FPTOVEN = cc.FPTOVEN
							 and  d.Numero = cc.Numero
						Where pk.Codigo Is Null 
							 and cc.FACTTIPO Is Null 
							 and cc.FLETRA Is Null 
							 and cc.FPTOVEN Is Null 
							 and cc.Numero Is Null 
				-- Fin Inserts
				Insert into ZooLogic.Logueos ( Fecha, Nivel, Logger, Accion, BaseDeDatos, 
					EstadoDelSistema, Aplicacion, Version, 
					Serie, Usuario, NombrePc, 
					UsuarioPc, OrigenLogueo, Mensaje, Excepcion)
				select GetDate(), 'INFO', '', 'Importación <<lcEntidad>>','<<loLogueo.BaseDatos>>',
					<<loLogueo.EstadoSistema>>,'<<loLogueo.Aplicacion>>','<<loLogueo.Version>>',
					'<<loLogueo.Serie>>','<<loLogueo.Usuario>>','<<loLogueo.NombrePc>>',
					'<<loLogueo.UsuarioPc>>','<<loLogueo.OrigenLogueo>>','No se pudo importar la entidad <<lcEntidad>>:  ' + cast( d.FACTTIPO as Varchar(2) ) + ', LETRA ' + cast( d.FLETRA as Varchar(1) ) + ', PTO. VENTA ' + cast( d.FPTOVEN as Varchar(4) ) + ', NÚMERO ' + cast( d.Numero as Varchar(12) ) + '','La clave principal no es la esperada'
					from ZooLogic.CANJECUPONES t inner join deleted d 
							on   t.FACTTIPO = d.FACTTIPO
							 and  t.FLETRA = d.FLETRA
							 and  t.FPTOVEN = d.FPTOVEN
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
					'<<loLogueo.UsuarioPc>>','<<loLogueo.OrigenLogueo>>','No se pudo importar la entidad <<lcEntidad>>:  ' + cast( d.FACTTIPO as Varchar(2) ) + ', LETRA ' + cast( d.FLETRA as Varchar(1) ) + ', PTO. VENTA ' + cast( d.FPTOVEN as Varchar(4) ) + ', NÚMERO ' + cast( d.Numero as Varchar(12) ) + '','La clave principal a importar ya existe'
					from ZooLogic.CANJECUPONES t inner join deleted d 
							 on t.Codigo = d.Codigo
						left join deleted h 
							on   t.FACTTIPO = h.FACTTIPO
							 and   t.FLETRA = h.FLETRA
							 and   t.FPTOVEN = h.FPTOVEN
							 and   t.Numero = h.Numero
							where   h.FACTTIPO is null 
							 and   h.FLETRA is null 
							 and   h.FPTOVEN is null 
							 and   h.Numero is null 
			End
		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_CanjeCuponesDet( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_CANJECUPONES_CanjeCuponesDet
ON ZooLogic.TablaTrabajo_CANJECUPONES_CanjeCuponesDet
AFTER DELETE
As
Begin
Update t Set 
t.FECHCOTI = isnull( d.FECHCOTI, t.FECHCOTI ),
t.JJFECHA = isnull( d.JJFECHA, t.JJFECHA ),
t.IDCAJA = isnull( d.IDCAJA, t.IDCAJA ),
t.JJT = isnull( d.JJT, t.JJT ),
t.COTIZA = isnull( d.COTIZA, t.COTIZA ),
t.SIGNO = isnull( d.SIGNO, t.SIGNO ),
t.JJTURNO = isnull( d.JJTURNO, t.JJTURNO ),
t.PTOVENTA = isnull( d.PTOVENTA, t.PTOVENTA ),
t.JJCOTIZ = isnull( d.JJCOTIZ, t.JJCOTIZ ),
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.NROCUPON = isnull( d.NROCUPON, t.NROCUPON ),
t.NUMCOMPR = isnull( d.NUMCOMPR, t.NUMCOMPR ),
t.AUTORIZADO = isnull( d.AUTORIZADO, t.AUTORIZADO ),
t.PERSCOMP = isnull( d.PERSCOMP, t.PERSCOMP ),
t.VISUALCAJA = isnull( d.VISUALCAJA, t.VISUALCAJA ),
t.CELECTRO = isnull( d.CELECTRO, t.CELECTRO ),
t.LETRA = isnull( d.LETRA, t.LETRA ),
t.NRODOC = isnull( d.NRODOC, t.NRODOC ),
t.TIPCOMP = isnull( d.TIPCOMP, t.TIPCOMP ),
t.NROTARJETA = isnull( d.NROTARJETA, t.NROTARJETA ),
t.JJVEN = isnull( d.JJVEN, t.JJVEN ),
t.TIPODOC = isnull( d.TIPODOC, t.TIPODOC ),
t.JJNUM = isnull( d.JJNUM, t.JJNUM ),
t.NROCHEQUE = isnull( d.NROCHEQUE, t.NROCHEQUE ),
t.NROCHPROP = isnull( d.NROCHPROP, t.NROCHPROP ),
t.JJCO = isnull( d.JJCO, t.JJCO ),
t.JJDE = isnull( d.JJDE, t.JJDE ),
t.JJFE = isnull( d.JJFE, t.JJFE ),
t.NROINTERNO = isnull( d.NROINTERNO, t.NROINTERNO ),
t.JJM = isnull( d.JJM, t.JJM ),
t.JRECPORC = isnull( d.JRECPORC, t.JRECPORC ),
t.JRECMNT = isnull( d.JRECMNT, t.JRECMNT ),
t.JJTOTFAC = isnull( d.JJTOTFAC, t.JJTOTFAC ),
t.PESOS = isnull( d.PESOS, t.PESOS ),
t.JRECMNTSI = isnull( d.JRECMNTSI, t.JRECMNTSI ),
t.MONTOSISTE = isnull( d.MONTOSISTE, t.MONTOSISTE ),
t.JRRECSPERC = isnull( d.JRRECSPERC, t.JRRECSPERC ),
t.PERMVUELTO = isnull( d.PERMVUELTO, t.PERMVUELTO ),
t.GUIDCOMP = isnull( d.GUIDCOMP, t.GUIDCOMP ),
t.GUIDCUPON = isnull( d.GUIDCUPON, t.GUIDCUPON ),
t.CUPON = isnull( d.CUPON, t.CUPON ),
t.VALECAMBIO = isnull( d.VALECAMBIO, t.VALECAMBIO )
from ZooLogic.CanjeCuponesDet t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.CanjeCuponesDet
( 
"FECHCOTI",
"JJFECHA",
"IDCAJA",
"JJT",
"COTIZA",
"SIGNO",
"JJTURNO",
"PTOVENTA",
"JJCOTIZ",
"NROITEM",
"NROCUPON",
"NUMCOMPR",
"AUTORIZADO",
"PERSCOMP",
"VISUALCAJA",
"CELECTRO",
"LETRA",
"NRODOC",
"TIPCOMP",
"NROTARJETA",
"JJVEN",
"TIPODOC",
"JJNUM",
"NROCHEQUE",
"NROCHPROP",
"JJCO",
"JJDE",
"JJFE",
"NROINTERNO",
"JJM",
"JRECPORC",
"JRECMNT",
"JJTOTFAC",
"PESOS",
"JRECMNTSI",
"MONTOSISTE",
"JRRECSPERC",
"PERMVUELTO",
"GUIDCOMP",
"GUIDCUPON",
"CUPON",
"VALECAMBIO"
 )
Select 
d.FECHCOTI,
d.JJFECHA,
d.IDCAJA,
d.JJT,
d.COTIZA,
d.SIGNO,
d.JJTURNO,
d.PTOVENTA,
d.JJCOTIZ,
d.NROITEM,
d.NROCUPON,
d.NUMCOMPR,
d.AUTORIZADO,
d.PERSCOMP,
d.VISUALCAJA,
d.CELECTRO,
d.LETRA,
d.NRODOC,
d.TIPCOMP,
d.NROTARJETA,
d.JJVEN,
d.TIPODOC,
d.JJNUM,
d.NROCHEQUE,
d.NROCHPROP,
d.JJCO,
d.JJDE,
d.JJFE,
d.NROINTERNO,
d.JJM,
d.JRECPORC,
d.JRECMNT,
d.JJTOTFAC,
d.PESOS,
d.JRECMNTSI,
d.MONTOSISTE,
d.JRRECSPERC,
d.PERMVUELTO,
d.GUIDCOMP,
d.GUIDCUPON,
d.CUPON,
d.VALECAMBIO
From deleted d left join ZooLogic.CanjeCuponesDet pk 
 on d.CODIGO = pk.CODIGO
Where pk.CODIGO Is Null 
-- Fin Inserts
End

		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_CanjeCuponesEnt( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_CANJECUPONES_CanjeCuponesEnt
ON ZooLogic.TablaTrabajo_CANJECUPONES_CanjeCuponesEnt
AFTER DELETE
As
Begin
Update t Set 
t.JJFECHA = isnull( d.JJFECHA, t.JJFECHA ),
t.FECHCOTI = isnull( d.FECHCOTI, t.FECHCOTI ),
t.IDCAJA = isnull( d.IDCAJA, t.IDCAJA ),
t.SIGNO = isnull( d.SIGNO, t.SIGNO ),
t.NROCUPON = isnull( d.NROCUPON, t.NROCUPON ),
t.COTIZA = isnull( d.COTIZA, t.COTIZA ),
t.JJCOTIZ = isnull( d.JJCOTIZ, t.JJCOTIZ ),
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.JJT = isnull( d.JJT, t.JJT ),
t.AUTORIZADO = isnull( d.AUTORIZADO, t.AUTORIZADO ),
t.CELECTRO = isnull( d.CELECTRO, t.CELECTRO ),
t.VISUALCAJA = isnull( d.VISUALCAJA, t.VISUALCAJA ),
t.NROTARJETA = isnull( d.NROTARJETA, t.NROTARJETA ),
t.JJCO = isnull( d.JJCO, t.JJCO ),
t.CODIGO = isnull( d.CODIGO, t.CODIGO ),
t.NROCHPROP = isnull( d.NROCHPROP, t.NROCHPROP ),
t.NROCHEQUE = isnull( d.NROCHEQUE, t.NROCHEQUE ),
t.LETRA = isnull( d.LETRA, t.LETRA ),
t.JJDE = isnull( d.JJDE, t.JJDE ),
t.JJFE = isnull( d.JJFE, t.JJFE ),
t.PTOVEN = isnull( d.PTOVEN, t.PTOVEN ),
t.NUMCOMPR = isnull( d.NUMCOMPR, t.NUMCOMPR ),
t.NROINTERNO = isnull( d.NROINTERNO, t.NROINTERNO ),
t.TIPO = isnull( d.TIPO, t.TIPO ),
t.FECHACOMP = isnull( d.FECHACOMP, t.FECHACOMP ),
t.TIPCOMP = isnull( d.TIPCOMP, t.TIPCOMP ),
t.BASEDATOS = isnull( d.BASEDATOS, t.BASEDATOS ),
t.HORA = isnull( d.HORA, t.HORA ),
t.JJM = isnull( d.JJM, t.JJM ),
t.JJTOTFAC = isnull( d.JJTOTFAC, t.JJTOTFAC ),
t.SERIE = isnull( d.SERIE, t.SERIE ),
t.PESOS = isnull( d.PESOS, t.PESOS ),
t.MONTOSISTE = isnull( d.MONTOSISTE, t.MONTOSISTE ),
t.MONCUPON = isnull( d.MONCUPON, t.MONCUPON ),
t.GUIDCOMP = isnull( d.GUIDCOMP, t.GUIDCOMP ),
t.GUIDCUPON = isnull( d.GUIDCUPON, t.GUIDCUPON ),
t.CUPON = isnull( d.CUPON, t.CUPON )
from ZooLogic.CanjeCuponesEnt t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.CanjeCuponesEnt
( 
"JJFECHA",
"FECHCOTI",
"IDCAJA",
"SIGNO",
"NROCUPON",
"COTIZA",
"JJCOTIZ",
"NROITEM",
"JJT",
"AUTORIZADO",
"CELECTRO",
"VISUALCAJA",
"NROTARJETA",
"JJCO",
"CODIGO",
"NROCHPROP",
"NROCHEQUE",
"LETRA",
"JJDE",
"JJFE",
"PTOVEN",
"NUMCOMPR",
"NROINTERNO",
"TIPO",
"FECHACOMP",
"TIPCOMP",
"BASEDATOS",
"HORA",
"JJM",
"JJTOTFAC",
"SERIE",
"PESOS",
"MONTOSISTE",
"MONCUPON",
"GUIDCOMP",
"GUIDCUPON",
"CUPON"
 )
Select 
d.JJFECHA,
d.FECHCOTI,
d.IDCAJA,
d.SIGNO,
d.NROCUPON,
d.COTIZA,
d.JJCOTIZ,
d.NROITEM,
d.JJT,
d.AUTORIZADO,
d.CELECTRO,
d.VISUALCAJA,
d.NROTARJETA,
d.JJCO,
d.CODIGO,
d.NROCHPROP,
d.NROCHEQUE,
d.LETRA,
d.JJDE,
d.JJFE,
d.PTOVEN,
d.NUMCOMPR,
d.NROINTERNO,
d.TIPO,
d.FECHACOMP,
d.TIPCOMP,
d.BASEDATOS,
d.HORA,
d.JJM,
d.JJTOTFAC,
d.SERIE,
d.PESOS,
d.MONTOSISTE,
d.MONCUPON,
d.GUIDCOMP,
d.GUIDCUPON,
d.CUPON
From deleted d left join ZooLogic.CanjeCuponesEnt pk 
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_CanjeCupones') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_CanjeCupones
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_CANJEDECUPONES' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_CANJEDECUPONES.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_CANJEDECUPONES.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_CANJEDECUPONES.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_CANJEDECUPONES.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_CANJEDECUPONES.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Tipocomprobante = nvl( c_CANJEDECUPONES.Tipocomprobante, 0 )
					.Cuponvalortipo = nvl( c_CANJEDECUPONES.Cuponvalortipo, 0 )
					.Signodemovimiento = nvl( c_CANJEDECUPONES.Signodemovimiento, 0 )
					.Horaexpo = nvl( c_CANJEDECUPONES.Horaexpo, [] )
					.Horaimpo = nvl( c_CANJEDECUPONES.Horaimpo, [] )
					.Basededatosaltafw = nvl( c_CANJEDECUPONES.Basededatosaltafw, [] )
					.Horaaltafw = nvl( c_CANJEDECUPONES.Horaaltafw, [] )
					.Estadotransferencia = nvl( c_CANJEDECUPONES.Estadotransferencia, [] )
					.Basededatosmodificacionfw = nvl( c_CANJEDECUPONES.Basededatosmodificacionfw, [] )
					.Cuponvalordetalle = nvl( c_CANJEDECUPONES.Cuponvalordetalle, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Horamodificacionfw = nvl( c_CANJEDECUPONES.Horamodificacionfw, [] )
					.Usuarioaltafw = nvl( c_CANJEDECUPONES.Usuarioaltafw, [] )
					.Usuariomodificacionfw = nvl( c_CANJEDECUPONES.Usuariomodificacionfw, [] )
					.Seriemodificacionfw = nvl( c_CANJEDECUPONES.Seriemodificacionfw, [] )
					.Versionmodificacionfw = nvl( c_CANJEDECUPONES.Versionmodificacionfw, [] )
					.Versionaltafw = nvl( c_CANJEDECUPONES.Versionaltafw, [] )
					.Descripcionfw = nvl( c_CANJEDECUPONES.Descripcionfw, [] )
					.Seriealtafw = nvl( c_CANJEDECUPONES.Seriealtafw, [] )
					.Cupon_PK =  nvl( c_CANJEDECUPONES.Cupon, [] )
					.Cuponidcaja_PK =  nvl( c_CANJEDECUPONES.Cuponidcaja, 0 )
					.Codigo = nvl( c_CANJEDECUPONES.Codigo, [] )
					.Monedacomprobante_PK =  nvl( c_CANJEDECUPONES.Monedacomprobante, [] )
					.Cuponvalor_PK =  nvl( c_CANJEDECUPONES.Cuponvalor, [] )
					.Letra = nvl( c_CANJEDECUPONES.Letra, [] )
					.Cupontipocomprobante = nvl( c_CANJEDECUPONES.Cupontipocomprobante, 0 )
					.Valoresdetalle.Limpiar()
					.Valoresdetalle.SetearEsNavegacion( .lProcesando )
					.Valoresdetalle.Cargar()
					.Cliente_PK =  nvl( c_CANJEDECUPONES.Cliente, [] )
					lcValor = This.ObtenerMemo( 'c_Obs')
					.Obs = lcValor 
					.Valoresaent.Limpiar()
					.Valoresaent.SetearEsNavegacion( .lProcesando )
					.Valoresaent.Cargar()
					.Puntodeventa = nvl( c_CANJEDECUPONES.Puntodeventa, 0 )
					.Cuponletracomprobante = nvl( c_CANJEDECUPONES.Cuponletracomprobante, [] )
					.Proveedor_PK =  nvl( c_CANJEDECUPONES.Proveedor, [] )
					.Numero = nvl( c_CANJEDECUPONES.Numero, 0 )
					.Fecha = GoLibrerias.ObtenerFechaFormateada( nvl( c_CANJEDECUPONES.Fecha, ctod( '  /  /    ' ) ) )
					.Cuponpuntodeventacomprobante = nvl( c_CANJEDECUPONES.Cuponpuntodeventacomprobante, 0 )
					.Cupontipo = nvl( c_CANJEDECUPONES.Cupontipo, [] )
					.Concepto_PK =  nvl( c_CANJEDECUPONES.Concepto, [] )
					.Cuponnumerocomprobante = nvl( c_CANJEDECUPONES.Cuponnumerocomprobante, 0 )
					.Cuponnumerocupon = nvl( c_CANJEDECUPONES.Cuponnumerocupon, 0 )
					.Vendedor_PK =  nvl( c_CANJEDECUPONES.Vendedor, [] )
					.Cuponfechacomprobante = GoLibrerias.ObtenerFechaFormateada( nvl( c_CANJEDECUPONES.Cuponfechacomprobante, ctod( '  /  /    ' ) ) )
					.Cuponfecha = GoLibrerias.ObtenerFechaFormateada( nvl( c_CANJEDECUPONES.Cuponfecha, ctod( '  /  /    ' ) ) )
					.Cuponbasededatos = nvl( c_CANJEDECUPONES.Cuponbasededatos, [] )
					.Total = nvl( c_CANJEDECUPONES.Total, 0 )
					.Cuponhora = nvl( c_CANJEDECUPONES.Cuponhora, [] )
					.Cuponserieorigen = nvl( c_CANJEDECUPONES.Cuponserieorigen, [] )
					.Cuponmonto = nvl( c_CANJEDECUPONES.Cuponmonto, 0 )
					.Anulado = nvl( c_CANJEDECUPONES.Anulado, .F. )
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
			lxRetorno = c_CANJEDECUPONES.CODIGO
		endif
		return lxRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function ActualizarLosNROItemDeLosDetalles() as void
		local loDetalle as object, loItem as object, lnContadorNroItem as integer, lnIndex as integer
		
		loDetalle = this.oEntidad.ValoresDetalle
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

		loDetalle = this.oEntidad.ValoresAEnt
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
		return c_CANJEDECUPONES.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.CANJECUPONES' )
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
								from ZooLogic.CANJECUPONES 
								Where   CANJECUPONES.CODIGO != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "CANJECUPONES", "", lcCursor, set("Datasession") )
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
			"Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Facttipo" as "Tipocomprobante", "Valtip" as "Cuponvalortipo", "Signo" as "Signodemovimiento", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Bdaltafw" as "Basededatosaltafw", "Haltafw" as "Horaaltafw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Valordet" as "Cuponvalordetalle", "Zadsfw" as "Zadsfw", "Hmodifw" as "Horamodificacionfw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Descfw" as "Descripcionfw", "Saltafw" as "Seriealtafw", "Cupon" as "Cupon", "Idcaja" as "Cuponidcaja", "Codigo" as "Codigo", "Moneda" as "Monedacomprobante", "Valor" as "Cuponvalor", "Fletra" as "Letra", "Comptipo" as "Cupontipocomprobante", "Cliente" as "Cliente", "Obs" as "Obs", "Fptoven" as "Puntodeventa", "Letra" as "Cuponletracomprobante", "Proveedor" as "Proveedor", "Numero" as "Numero", "Fecha" as "Fecha", "Ptoven" as "Cuponpuntodeventacomprobante", "Tipo" as "Cupontipo", "Concepto" as "Concepto", "Numcomp" as "Cuponnumerocomprobante", "Numerocup" as "Cuponnumerocupon", "Vendedor" as "Vendedor", "Fechacomp" as "Cuponfechacomprobante", "Fechacup" as "Cuponfecha", "Basedatos" as "Cuponbasededatos", "Ftotal" as "Total", "Hora" as "Cuponhora", "Serie" as "Cuponserieorigen", "Monto" as "Cuponmonto", "Anulado" as "Anulado"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.CANJECUPONES 
								Where   CANJECUPONES.CODIGO != ''
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
	Tabla = 'CANJECUPONES'
	Filtro = " CANJECUPONES.CODIGO != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " CANJECUPONES.CODIGO != ''"
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
	<row entidad="CANJEDECUPONES                          " atributo="FECHAALTAFW                             " tabla="CANJECUPONES   " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANJEDECUPONES                          " atributo="FECHATRANSFERENCIA                      " tabla="CANJECUPONES   " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha transferencia                                                                                                                                             " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANJEDECUPONES                          " atributo="FECHAEXPO                               " tabla="CANJECUPONES   " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANJEDECUPONES                          " atributo="FECHAIMPO                               " tabla="CANJECUPONES   " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANJEDECUPONES                          " atributo="FECHAMODIFICACIONFW                     " tabla="CANJECUPONES   " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANJEDECUPONES                          " atributo="TIPOCOMPROBANTE                         " tabla="CANJECUPONES   " campo="FACTTIPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="=32                                                                                                                                                                                                                                                           " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="1" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANJEDECUPONES                          " atributo="CUPONVALORTIPO                          " tabla="CANJECUPONES   " campo="VALTIP    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="Cupon.Valor.Tipo                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANJEDECUPONES                          " atributo="SIGNODEMOVIMIENTO                       " tabla="CANJECUPONES   " campo="SIGNO     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="1                                                                                                                                                                                                                                                             " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANJEDECUPONES                          " atributo="HORAEXPO                                " tabla="CANJECUPONES   " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANJEDECUPONES                          " atributo="HORAIMPO                                " tabla="CANJECUPONES   " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANJEDECUPONES                          " atributo="BASEDEDATOSALTAFW                       " tabla="CANJECUPONES   " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANJEDECUPONES                          " atributo="HORAALTAFW                              " tabla="CANJECUPONES   " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANJEDECUPONES                          " atributo="ESTADOTRANSFERENCIA                     " tabla="CANJECUPONES   " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado transferencia                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANJEDECUPONES                          " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="CANJECUPONES   " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANJEDECUPONES                          " atributo="CUPONVALORDETALLE                       " tabla="CANJECUPONES   " campo="VALORDET  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="Cupon.Valor.Descripcion                                                                                                                                                                                                                                       " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANJEDECUPONES                          " atributo="ZADSFW                                  " tabla="CANJECUPONES   " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANJEDECUPONES                          " atributo="HORAMODIFICACIONFW                      " tabla="CANJECUPONES   " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANJEDECUPONES                          " atributo="USUARIOALTAFW                           " tabla="CANJECUPONES   " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANJEDECUPONES                          " atributo="USUARIOMODIFICACIONFW                   " tabla="CANJECUPONES   " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANJEDECUPONES                          " atributo="SERIEMODIFICACIONFW                     " tabla="CANJECUPONES   " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANJEDECUPONES                          " atributo="VERSIONMODIFICACIONFW                   " tabla="CANJECUPONES   " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANJEDECUPONES                          " atributo="VERSIONALTAFW                           " tabla="CANJECUPONES   " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANJEDECUPONES                          " atributo="DESCRIPCIONFW                           " tabla="CANJECUPONES   " campo="DESCFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="200" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANJEDECUPONES                          " atributo="SERIEALTAFW                             " tabla="CANJECUPONES   " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANJEDECUPONES                          " atributo="CUPON                                   " tabla="CANJECUPONES   " campo="CUPON     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CUPON                                   " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Número Interno                                                                                                                                                  " dominio="CODIGOSINALTA                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="X999-99999999            " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANJEDECUPONES                          " atributo="CUPONIDCAJA                             " tabla="CANJECUPONES   " campo="IDCAJA    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CAJAESTADO                              " tipodato="N         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="Cupon.IdCaja                                                                                                                                                                                                                                                  " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANJEDECUPONES                          " atributo="CODIGO                                  " tabla="CANJECUPONES   " campo="CODIGO    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Código                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANJEDECUPONES                          " atributo="MONEDACOMPROBANTE                       " tabla="CANJECUPONES   " campo="MONEDA    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="MONEDA                                  " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="Cupon.SimboloMonetario                                                                                                                                                                                                                                        " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANJEDECUPONES                          " atributo="CUPONVALOR                              " tabla="CANJECUPONES   " campo="VALOR     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="VALOR                                   " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="Cupon.Valor                                                                                                                                                                                                                                                   " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANJEDECUPONES                          " atributo="LETRA                                   " tabla="CANJECUPONES   " campo="FLETRA    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="6" etiqueta="Letra                                                                                                                                                           " dominio="NUMEROCOMPROBANTELIMITADO     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="2" mascara="X 9999-99999999          " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANJEDECUPONES                          " atributo="CUPONTIPOCOMPROBANTE                    " tabla="CANJECUPONES   " campo="COMPTIPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="10" etiqueta="Tipo de comprobante                                                                                                                                             " dominio="COMBOTIPOCOMPROBANTE          " detalle="false" tipo="E" atributoforaneo="Cupon.TipoComprobante                                                                                                                                                                                                                                         " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="1" orden="1" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANJEDECUPONES                          " atributo="VALORESDETALLE                          " tabla="CANJECUPONESDET" campo="JJNUM     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="Valores a recibir                                                                                                                                               " dominio="DETALLEITEMCANJECUPONES       " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="2" orden="1" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANJEDECUPONES                          " atributo="CLIENTE                                 " tabla="CANJECUPONES   " campo="CLIENTE   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CLIENTE                                 " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="402" etiqueta="Cliente                                                                                                                                                         " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANJEDECUPONES                          " atributo="OBS                                     " tabla="CANJECUPONES   " campo="OBS       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="404" etiqueta="Observación                                                                                                                                                     " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="4" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANJEDECUPONES                          " atributo="VALORESAENT                             " tabla="CANJECUPONESENT" campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="406" etiqueta="Valores a entregar                                                                                                                                              " dominio="DETALLEITEMVALORESAENT        " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANJEDECUPONES                          " atributo="PUNTODEVENTA                            " tabla="CANJECUPONES   " campo="FPTOVEN   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="4" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="4" etiqueta="Pto. Venta                                                                                                                                                      " dominio="NUMEROCOMPROBANTELIMITADO     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="3" mascara="X 9999-99999999          " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANJEDECUPONES                          " atributo="CUPONLETRACOMPROBANTE                   " tabla="CANJECUPONES   " campo="LETRA     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="12" etiqueta="Número comprobante                                                                                                                                              " dominio="NUMEROCOMPROBANTE             " detalle="false" tipo="E" atributoforaneo="Cupon.LetraComprobante                                                                                                                                                                                                                                        " clavecandidata="0" mascara="X 9999-99999999          " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="1" orden="2" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANJEDECUPONES                          " atributo="DIFERENCIA                              " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="408" etiqueta="Dif.                                                                                                                                                            " dominio="TOTALMULTIMONEDA              " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="4" subgrupo="1" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANJEDECUPONES                          " atributo="PROVEEDOR                               " tabla="CANJECUPONES   " campo="PROVEEDOR " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="PROVEEDOR                               " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="410" etiqueta="Proveedor                                                                                                                                                       " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANJEDECUPONES                          " atributo="NUMERO                                  " tabla="CANJECUPONES   " campo="NUMERO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="12" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="4" etiqueta="Número                                                                                                                                                          " dominio="NUMEROCOMPROBANTELIMITADO     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="4" mascara="X 9999-99999999          " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANJEDECUPONES                          " atributo="FECHA                                   " tabla="CANJECUPONES   " campo="FECHA     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goServicios.Librerias.ObtenerFecha()                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="412" etiqueta="Fecha                                                                                                                                                           " dominio="FECHACALENDARIO               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANJEDECUPONES                          " atributo="CUPONPUNTODEVENTACOMPROBANTE            " tabla="CANJECUPONES   " campo="PTOVEN    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="4" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="14" etiqueta="Pto. venta                                                                                                                                                      " dominio="NUMEROCOMPROBANTE             " detalle="false" tipo="E" atributoforaneo="Cupon.PuntoDeVentaComprobante                                                                                                                                                                                                                                 " clavecandidata="0" mascara="X 9999-99999999          " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="1" orden="3" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANJEDECUPONES                          " atributo="CUPONTIPO                               " tabla="CANJECUPONES   " campo="TIPO      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Tipo                                                                                                                                                            " dominio="COMBOTIPOCUPON                " detalle="false" tipo="E" atributoforaneo="Cupon.TipoCupon                                                                                                                                                                                                                                               " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="0" orden="3" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANJEDECUPONES                          " atributo="CONCEPTO                                " tabla="CANJECUPONES   " campo="CONCEPTO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CONCEPTOCAJA                            " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Concepto                                                                                                                                                        " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="&quot;CONCECAJA.CtaBanc = ''&quot;                                                                                                                                                                                " grupo="0" subgrupo="0" orden="3" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANJEDECUPONES                          " atributo="CUPONNUMEROCOMPROBANTE                  " tabla="CANJECUPONES   " campo="NUMCOMP   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="16" etiqueta="Número comprobante                                                                                                                                              " dominio="NUMEROCOMPROBANTE             " detalle="false" tipo="E" atributoforaneo="Cupon.NumeroComprobante                                                                                                                                                                                                                                       " clavecandidata="0" mascara="X 9999-99999999          " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="1" orden="4" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANJEDECUPONES                          " atributo="CUPONNUMEROCUPON                        " tabla="CANJECUPONES   " campo="NUMEROCUP " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="12" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="6" etiqueta="Número                                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="Cupon.NumeroCupon                                                                                                                                                                                                                                             " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="0" orden="4" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANJEDECUPONES                          " atributo="VENDEDOR                                " tabla="CANJECUPONES   " campo="VENDEDOR  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="VENDEDOR                                " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="414" etiqueta="Vendedor                                                                                                                                                        " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANJEDECUPONES                          " atributo="CUPONFECHACOMPROBANTE                   " tabla="CANJECUPONES   " campo="FECHACOMP " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="8" etiqueta="Fecha                                                                                                                                                           " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="Cupon.FechaComprobante                                                                                                                                                                                                                                        " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="1" orden="5" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANJEDECUPONES                          " atributo="CUPONFECHA                              " tabla="CANJECUPONES   " campo="FECHACUP  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha                                                                                                                                                           " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="Cupon.FechaCupon                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="0" orden="6" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANJEDECUPONES                          " atributo="CUPONBASEDEDATOS                        " tabla="CANJECUPONES   " campo="BASEDATOS " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos                                                                                                                                                   " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="Cupon.BaseDeDatos                                                                                                                                                                                                                                             " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="1" orden="6" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANJEDECUPONES                          " atributo="TOTAL                                   " tabla="CANJECUPONES   " campo="FTOTAL    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="10" etiqueta="Total                                                                                                                                                           " dominio="TOTALMULTIMONEDA              " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="4" subgrupo="0" orden="7" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANJEDECUPONES                          " atributo="CUPONHORA                               " tabla="CANJECUPONES   " campo="HORA      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora                                                                                                                                                            " dominio="HORA                          " detalle="false" tipo="E" atributoforaneo="Cupon.HoraCupon                                                                                                                                                                                                                                               " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="0" orden="7" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANJEDECUPONES                          " atributo="CUPONSERIEORIGEN                        " tabla="CANJECUPONES   " campo="SERIE     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="20" etiqueta="Serie                                                                                                                                                           " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="Cupon.SerieOrigen                                                                                                                                                                                                                                             " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="1" orden="7" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANJEDECUPONES                          " atributo="CUPONMONTO                              " tabla="CANJECUPONES   " campo="MONTO     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="17" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="18" etiqueta="Monto                                                                                                                                                           " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="Cupon.Monto                                                                                                                                                                                                                                                   " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="0" orden="8" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANJEDECUPONES                          " atributo="ANULADO                                 " tabla="CANJECUPONES   " campo="ANULADO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Anulado                                                                                                                                                         " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="13" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="NOMBRE                                  " tabla="CLI            " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="403" etiqueta="Detalle Cli.                                                                                                                                                    " dominio="TEXTOBUSQUEDA                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CLI On CANJECUPONES.CLIENTE = CLI.CLCOD And  CLI.CLCOD != ''                                                                                                                                                                                       " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="NOMBRE                                  " tabla="PROVEED        " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="411" etiqueta="Detalle Pro.                                                                                                                                                    " dominio="TEXTOBUSQUEDA                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join PROVEED On CANJECUPONES.PROVEEDOR = PROVEED.CLCOD And  PROVEED.CLCOD != ''                                                                                                                                                                         " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VENDEDOR                                " atributo="NOMBRE                                  " tabla="VEN            " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="415" etiqueta="Detalle Ven.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join VEN On CANJECUPONES.VENDEDOR = VEN.CLCOD And  VEN.CLCOD != ''                                                                                                                                                                                      " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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