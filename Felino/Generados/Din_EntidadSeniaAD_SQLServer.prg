
define class Din_EntidadSENIAAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_SENIA'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = [str( TipoComprobanteOrigen, 2, 0) + LetraOrigen + str( PuntoDeVentaOrigen, 4, 0) + str( NumeroOrigen, 8, 0)]
	cExpresionCCPorCampos = [str( #tabla#.FACTTIPO, 2, 0) + #tabla#.FLETRA + str( #tabla#.FPTOVEN, 4, 0) + str( #tabla#.FNUMCOMP, 8, 0)]
	cTagClaveCandidata = '_SENCC'
	cTagClavePk = '_SENPK'
	cTablaPrincipal = 'SENIA'
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

		with this.oEntidad
			local  lxSeniaFecimpo, lxSeniaFmodifw, lxSeniaFectrans, lxSeniaFecexpo, lxSeniaFaltafw, lxSeniaTasaimpint, lxSeniaMtoimpint, lxSeniaMtoiva, lxSeniaPreciocisr, lxSeniaPorciva, lxSeniaCondiva, lxSeniaPreciosr, lxSeniaPreciosisr, lxSeniaPrunsinimp, lxSeniaPrunconimp, lxSeniaAnulado, lxSeniaValtafw, lxSeniaZadsfw, lxSeniaDescfw, lxSeniaVmodifw, lxSeniaSmodifw, lxSeniaUmodifw, lxSeniaHmodifw, lxSeniaHoraimpo, lxSeniaHaltafw, lxSeniaEsttrans, lxSeniaHoraexpo, lxSeniaSaltafw, lxSeniaUaltafw, lxSeniaCompa, lxSeniaComp, lxSeniaBdmodifw, lxSeniaBdaltafw, lxSeniaCodigo, lxSeniaFletraa, lxSeniaFletra, lxSeniaObs, lxSeniaFptovena, lxSeniaFptoven, lxSeniaFnumcompa, lxSeniaFnumcomp, lxSeniaFacttipoa, lxSeniaFacttipo, lxSeniaCoriabrev, lxSeniaCafeabrev, lxSeniaFechaa, lxSeniaFecha, lxSeniaCseriea, lxSeniaCserie, lxSeniaCversion, lxSeniaCversiona, lxSeniaCbasededat, lxSeniaCbdedata, lxSeniaCliente, lxSeniaFechavenci, lxSeniaFprecio, lxSeniaMoneda
				lxSeniaFecimpo =  .Fechaimpo			lxSeniaFmodifw =  .Fechamodificacionfw			lxSeniaFectrans =  .Fechatransferencia			lxSeniaFecexpo =  .Fechaexpo			lxSeniaFaltafw =  .Fechaaltafw			lxSeniaTasaimpint =  .Tasaimpuestointerno			lxSeniaMtoimpint =  .Montoimpuestointerno			lxSeniaMtoiva =  .Montoiva			lxSeniaPreciocisr =  .Precioconimpuestossinredondear			lxSeniaPorciva =  .Porcentajeiva			lxSeniaCondiva =  .Condicioniva			lxSeniaPreciosr =  .Preciosinredondear			lxSeniaPreciosisr =  .Preciosinimpuestossinredondear			lxSeniaPrunsinimp =  .Preciosinimpuestos			lxSeniaPrunconimp =  .Precioconimpuestos			lxSeniaAnulado =  .Anulado			lxSeniaValtafw =  .Versionaltafw			lxSeniaZadsfw =  .Zadsfw			lxSeniaDescfw =  .Descripcionfw			lxSeniaVmodifw =  .Versionmodificacionfw			lxSeniaSmodifw =  .Seriemodificacionfw			lxSeniaUmodifw =  .Usuariomodificacionfw			lxSeniaHmodifw =  .Horamodificacionfw			lxSeniaHoraimpo =  .Horaimpo			lxSeniaHaltafw =  .Horaaltafw			lxSeniaEsttrans =  .Estadotransferencia			lxSeniaHoraexpo =  .Horaexpo			lxSeniaSaltafw =  .Seriealtafw			lxSeniaUaltafw =  .Usuarioaltafw			lxSeniaCompa =  .Comprobanteafectante			lxSeniaComp =  .Comprobanteorigen			lxSeniaBdmodifw =  .Basededatosmodificacionfw			lxSeniaBdaltafw =  .Basededatosaltafw			lxSeniaCodigo =  .Codigo			lxSeniaFletraa =  .Letraafectante			lxSeniaFletra =  .Letraorigen			lxSeniaObs =  .Observacion			lxSeniaFptovena =  .Puntodeventaafectante			lxSeniaFptoven =  .Puntodeventaorigen			lxSeniaFnumcompa =  .Numeroafectante			lxSeniaFnumcomp =  .Numeroorigen			lxSeniaFacttipoa =  .Tipocomprobanteafectante			lxSeniaFacttipo =  .Tipocomprobanteorigen			lxSeniaCoriabrev =  .Tipocomprobanteorigenabreviado			lxSeniaCafeabrev =  .Tipocomprobanteafectanteabreviado			lxSeniaFechaa =  .Fechaafectante			lxSeniaFecha =  .Fechaorigen			lxSeniaCseriea =  .Cserieafectante			lxSeniaCserie =  .Cserieorigen			lxSeniaCversion =  .Cversionorigen			lxSeniaCversiona =  .Cversionafectante			lxSeniaCbasededat =  .Cbasededatosorigen			lxSeniaCbdedata =  .Cbasededatosafectante			lxSeniaCliente =  upper( .Cliente_PK ) 			lxSeniaFechavenci =  .Fechavencimiento			lxSeniaFprecio =  .Precio			lxSeniaMoneda =  upper( .Moneda_PK ) 
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxSeniaCodigo = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.SENIA ( "Fecimpo","Fmodifw","Fectrans","Fecexpo","Faltafw","Tasaimpint","Mtoimpint","Mtoiva","Preciocisr","Porciva","Condiva","Preciosr","Preciosisr","Prunsinimp","Prunconimp","Anulado","Valtafw","Zadsfw","Descfw","Vmodifw","Smodifw","Umodifw","Hmodifw","Horaimpo","Haltafw","Esttrans","Horaexpo","Saltafw","Ualtafw","Compa","Comp","Bdmodifw","Bdaltafw","Codigo","Fletraa","Fletra","Obs","Fptovena","Fptoven","Fnumcompa","Fnumcomp","Facttipoa","Facttipo","Coriabrev","Cafeabrev","Fechaa","Fecha","Cseriea","Cserie","Cversion","Cversiona","Cbasededat","Cbdedata","Cliente","Fechavenci","Fprecio","Moneda" ) values ( <<"'" + this.ConvertirDateSql( lxSeniaFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxSeniaFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxSeniaFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxSeniaFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxSeniaFaltafw ) + "'" >>, <<lxSeniaTasaimpint >>, <<lxSeniaMtoimpint >>, <<lxSeniaMtoiva >>, <<lxSeniaPreciocisr >>, <<lxSeniaPorciva >>, <<lxSeniaCondiva >>, <<lxSeniaPreciosr >>, <<lxSeniaPreciosisr >>, <<lxSeniaPrunsinimp >>, <<lxSeniaPrunconimp >>, <<iif( lxSeniaAnulado, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxSeniaValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSeniaZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSeniaDescfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSeniaVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSeniaSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSeniaUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSeniaHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSeniaHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSeniaHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSeniaEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSeniaHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSeniaSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSeniaUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSeniaCompa ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSeniaComp ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSeniaBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSeniaBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSeniaCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSeniaFletraa ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSeniaFletra ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSeniaObs ) + "'" >>, <<lxSeniaFptovena >>, <<lxSeniaFptoven >>, <<lxSeniaFnumcompa >>, <<lxSeniaFnumcomp >>, <<lxSeniaFacttipoa >>, <<lxSeniaFacttipo >>, <<"'" + this.FormatearTextoSql( lxSeniaCoriabrev ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSeniaCafeabrev ) + "'" >>, <<"'" + this.ConvertirDateSql( lxSeniaFechaa ) + "'" >>, <<"'" + this.ConvertirDateSql( lxSeniaFecha ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSeniaCseriea ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSeniaCserie ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSeniaCversion ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSeniaCversiona ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSeniaCbasededat ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSeniaCbdedata ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSeniaCliente ) + "'" >>, <<"'" + this.ConvertirDateSql( lxSeniaFechavenci ) + "'" >>, <<lxSeniaFprecio >>, <<"'" + this.FormatearTextoSql( lxSeniaMoneda ) + "'" >> )
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
			for each loItem in this.oEntidad.ArticulosDetalle
				if this.oEntidad.ArticulosDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxPreciosinimpuestossinredondear = loItem.Preciosinimpuestossinredondear
					lxArticulo_condicionivaventas = loItem.Articulo_condicionivaventas
					lxTasaimpuestointerno = loItem.Tasaimpuestointerno
					lxComportamiento = loItem.Comportamiento
					lxArticulo_porcentajeivaventas = loItem.Articulo_porcentajeivaventas
					lxPrecioconimpuestossinredondear = loItem.Precioconimpuestossinredondear
					lxPreciosinredondear = loItem.Preciosinredondear
					lxPreciosinimpuestos = loItem.Preciosinimpuestos
					lxPreciounitario = loItem.Preciounitario
					lxMontoporcentajedescuentoconimpuesto = loItem.Montoporcentajedescuentoconimpuesto
					lxMontodto1 = loItem.Montodto1
					lxMontocfi = loItem.Montocfi
					lxNroitem = lnContadorNroItem
					lxPrecioconimpuestos = loItem.Precioconimpuestos
					lxPorcentajecfi = loItem.Porcentajecfi
					lxPorcentajedto1 = loItem.Porcentajedto1
					lxNoprocesarstock = loItem.Noprocesarstock
					lxCodigomotivodevolucion_PK = loItem.Codigomotivodevolucion_PK
					lxArticulo_PK = loItem.Articulo_PK
					lxCodigomotivodescuento_PK = loItem.Codigomotivodescuento_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxTalle = loItem.Talle
					lxDescuento = loItem.Descuento
					lxMontodescuento = loItem.Montodescuento
					lxCantidad = loItem.Cantidad
					lxPrecio = loItem.Precio
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.SeniaDet("PRECIOSISR","ACondIvaV","tasaimpint","COMP","APorcIvaV","PRECIOCISR","PRECIOSR","Prunsinimp","FPRUN","FCFITot","FmtoDTO1","FmtoCFI","NroItem","prunconimp","FporCFI","FporDTO1","ProcStock","MotDevol","CODIGO","FART","MotDescu","FTXT","FCOLO","FCOTXT","FTALL","FCFI","MNTDES","FCANT","FPRECIO","FMONTO" ) values ( <<lxPreciosinimpuestossinredondear>>, <<lxArticulo_condicionivaventas>>, <<lxTasaimpuestointerno>>, <<lxComportamiento>>, <<lxArticulo_porcentajeivaventas>>, <<lxPrecioconimpuestossinredondear>>, <<lxPreciosinredondear>>, <<lxPreciosinimpuestos>>, <<lxPreciounitario>>, <<lxMontoporcentajedescuentoconimpuesto>>, <<lxMontodto1>>, <<lxMontocfi>>, <<lxNroitem>>, <<lxPrecioconimpuestos>>, <<lxPorcentajecfi>>, <<lxPorcentajedto1>>, <<iif( lxNoprocesarstock, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxCodigomotivodevolucion_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigomotivodescuento_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle ) + "'">>, <<lxDescuento>>, <<lxMontodescuento>>, <<lxCantidad>>, <<lxPrecio>>, <<lxMonto>> ) 
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
				lcError  = this.oEntidad.ObtenerMensajeClaveCandidataExistente()
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
			local  lxSeniaFecimpo, lxSeniaFmodifw, lxSeniaFectrans, lxSeniaFecexpo, lxSeniaFaltafw, lxSeniaTasaimpint, lxSeniaMtoimpint, lxSeniaMtoiva, lxSeniaPreciocisr, lxSeniaPorciva, lxSeniaCondiva, lxSeniaPreciosr, lxSeniaPreciosisr, lxSeniaPrunsinimp, lxSeniaPrunconimp, lxSeniaAnulado, lxSeniaValtafw, lxSeniaZadsfw, lxSeniaDescfw, lxSeniaVmodifw, lxSeniaSmodifw, lxSeniaUmodifw, lxSeniaHmodifw, lxSeniaHoraimpo, lxSeniaHaltafw, lxSeniaEsttrans, lxSeniaHoraexpo, lxSeniaSaltafw, lxSeniaUaltafw, lxSeniaCompa, lxSeniaComp, lxSeniaBdmodifw, lxSeniaBdaltafw, lxSeniaCodigo, lxSeniaFletraa, lxSeniaFletra, lxSeniaObs, lxSeniaFptovena, lxSeniaFptoven, lxSeniaFnumcompa, lxSeniaFnumcomp, lxSeniaFacttipoa, lxSeniaFacttipo, lxSeniaCoriabrev, lxSeniaCafeabrev, lxSeniaFechaa, lxSeniaFecha, lxSeniaCseriea, lxSeniaCserie, lxSeniaCversion, lxSeniaCversiona, lxSeniaCbasededat, lxSeniaCbdedata, lxSeniaCliente, lxSeniaFechavenci, lxSeniaFprecio, lxSeniaMoneda
				lxSeniaFecimpo =  .Fechaimpo			lxSeniaFmodifw =  .Fechamodificacionfw			lxSeniaFectrans =  .Fechatransferencia			lxSeniaFecexpo =  .Fechaexpo			lxSeniaFaltafw =  .Fechaaltafw			lxSeniaTasaimpint =  .Tasaimpuestointerno			lxSeniaMtoimpint =  .Montoimpuestointerno			lxSeniaMtoiva =  .Montoiva			lxSeniaPreciocisr =  .Precioconimpuestossinredondear			lxSeniaPorciva =  .Porcentajeiva			lxSeniaCondiva =  .Condicioniva			lxSeniaPreciosr =  .Preciosinredondear			lxSeniaPreciosisr =  .Preciosinimpuestossinredondear			lxSeniaPrunsinimp =  .Preciosinimpuestos			lxSeniaPrunconimp =  .Precioconimpuestos			lxSeniaAnulado =  .Anulado			lxSeniaValtafw =  .Versionaltafw			lxSeniaZadsfw =  .Zadsfw			lxSeniaDescfw =  .Descripcionfw			lxSeniaVmodifw =  .Versionmodificacionfw			lxSeniaSmodifw =  .Seriemodificacionfw			lxSeniaUmodifw =  .Usuariomodificacionfw			lxSeniaHmodifw =  .Horamodificacionfw			lxSeniaHoraimpo =  .Horaimpo			lxSeniaHaltafw =  .Horaaltafw			lxSeniaEsttrans =  .Estadotransferencia			lxSeniaHoraexpo =  .Horaexpo			lxSeniaSaltafw =  .Seriealtafw			lxSeniaUaltafw =  .Usuarioaltafw			lxSeniaCompa =  .Comprobanteafectante			lxSeniaComp =  .Comprobanteorigen			lxSeniaBdmodifw =  .Basededatosmodificacionfw			lxSeniaBdaltafw =  .Basededatosaltafw			lxSeniaCodigo =  .Codigo			lxSeniaFletraa =  .Letraafectante			lxSeniaFletra =  .Letraorigen			lxSeniaObs =  .Observacion			lxSeniaFptovena =  .Puntodeventaafectante			lxSeniaFptoven =  .Puntodeventaorigen			lxSeniaFnumcompa =  .Numeroafectante			lxSeniaFnumcomp =  .Numeroorigen			lxSeniaFacttipoa =  .Tipocomprobanteafectante			lxSeniaFacttipo =  .Tipocomprobanteorigen			lxSeniaCoriabrev =  .Tipocomprobanteorigenabreviado			lxSeniaCafeabrev =  .Tipocomprobanteafectanteabreviado			lxSeniaFechaa =  .Fechaafectante			lxSeniaFecha =  .Fechaorigen			lxSeniaCseriea =  .Cserieafectante			lxSeniaCserie =  .Cserieorigen			lxSeniaCversion =  .Cversionorigen			lxSeniaCversiona =  .Cversionafectante			lxSeniaCbasededat =  .Cbasededatosorigen			lxSeniaCbdedata =  .Cbasededatosafectante			lxSeniaCliente =  upper( .Cliente_PK ) 			lxSeniaFechavenci =  .Fechavencimiento			lxSeniaFprecio =  .Precio			lxSeniaMoneda =  upper( .Moneda_PK ) 
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()
			lxValorClavePrimaria = .oEntidad.CODIGO
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ZooLogic.SENIA set "Fecimpo" = <<"'" + this.ConvertirDateSql( lxSeniaFecimpo ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxSeniaFmodifw ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxSeniaFectrans ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxSeniaFecexpo ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxSeniaFaltafw ) + "'">>,"Tasaimpint" = <<lxSeniaTasaimpint>>,"Mtoimpint" = <<lxSeniaMtoimpint>>,"Mtoiva" = <<lxSeniaMtoiva>>,"Preciocisr" = <<lxSeniaPreciocisr>>,"Porciva" = <<lxSeniaPorciva>>,"Condiva" = <<lxSeniaCondiva>>,"Preciosr" = <<lxSeniaPreciosr>>,"Preciosisr" = <<lxSeniaPreciosisr>>,"Prunsinimp" = <<lxSeniaPrunsinimp>>,"Prunconimp" = <<lxSeniaPrunconimp>>,"Anulado" = <<iif( lxSeniaAnulado, 1, 0 )>>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxSeniaValtafw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxSeniaZadsfw ) + "'">>,"Descfw" = <<"'" + this.FormatearTextoSql( lxSeniaDescfw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxSeniaVmodifw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxSeniaSmodifw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxSeniaUmodifw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxSeniaHmodifw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxSeniaHoraimpo ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxSeniaHaltafw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxSeniaEsttrans ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxSeniaHoraexpo ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxSeniaSaltafw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxSeniaUaltafw ) + "'">>,"Compa" = <<"'" + this.FormatearTextoSql( lxSeniaCompa ) + "'">>,"Comp" = <<"'" + this.FormatearTextoSql( lxSeniaComp ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxSeniaBdmodifw ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxSeniaBdaltafw ) + "'">>,"Codigo" = <<"'" + this.FormatearTextoSql( lxSeniaCodigo ) + "'">>,"Fletraa" = <<"'" + this.FormatearTextoSql( lxSeniaFletraa ) + "'">>,"Fletra" = <<"'" + this.FormatearTextoSql( lxSeniaFletra ) + "'">>,"Obs" = <<"'" + this.FormatearTextoSql( lxSeniaObs ) + "'">>,"Fptovena" = <<lxSeniaFptovena>>,"Fptoven" = <<lxSeniaFptoven>>,"Fnumcompa" = <<lxSeniaFnumcompa>>,"Fnumcomp" = <<lxSeniaFnumcomp>>,"Facttipoa" = <<lxSeniaFacttipoa>>,"Facttipo" = <<lxSeniaFacttipo>>,"Coriabrev" = <<"'" + this.FormatearTextoSql( lxSeniaCoriabrev ) + "'">>,"Cafeabrev" = <<"'" + this.FormatearTextoSql( lxSeniaCafeabrev ) + "'">>,"Fechaa" = <<"'" + this.ConvertirDateSql( lxSeniaFechaa ) + "'">>,"Fecha" = <<"'" + this.ConvertirDateSql( lxSeniaFecha ) + "'">>,"Cseriea" = <<"'" + this.FormatearTextoSql( lxSeniaCseriea ) + "'">>,"Cserie" = <<"'" + this.FormatearTextoSql( lxSeniaCserie ) + "'">>,"Cversion" = <<"'" + this.FormatearTextoSql( lxSeniaCversion ) + "'">>,"Cversiona" = <<"'" + this.FormatearTextoSql( lxSeniaCversiona ) + "'">>,"Cbasededat" = <<"'" + this.FormatearTextoSql( lxSeniaCbasededat ) + "'">>,"Cbdedata" = <<"'" + this.FormatearTextoSql( lxSeniaCbdedata ) + "'">>,"Cliente" = <<"'" + this.FormatearTextoSql( lxSeniaCliente ) + "'">>,"Fechavenci" = <<"'" + this.ConvertirDateSql( lxSeniaFechavenci ) + "'">>,"Fprecio" = <<lxSeniaFprecio>>,"Moneda" = <<"'" + this.FormatearTextoSql( lxSeniaMoneda ) + "'">> where "Codigo" = <<"'" + this.FormatearTextoSql( lxSeniaCodigo ) + "'">> and  SENIA.CODIGO != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			this.ComprobarResultadoDeEjecucionDelUpdate()
		this.ComprobarTransaccion()
			.EjecutarSentencias( This.ColSentencias )
		this.ComprobarTransaccion()
			this.oConexion.EjecutarSql( 'delete from ZooLogic.SeniaDet where "CODIGO" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ArticulosDetalle
				if this.oEntidad.ArticulosDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxPreciosinimpuestossinredondear = loItem.Preciosinimpuestossinredondear
					lxArticulo_condicionivaventas = loItem.Articulo_condicionivaventas
					lxTasaimpuestointerno = loItem.Tasaimpuestointerno
					lxComportamiento = loItem.Comportamiento
					lxArticulo_porcentajeivaventas = loItem.Articulo_porcentajeivaventas
					lxPrecioconimpuestossinredondear = loItem.Precioconimpuestossinredondear
					lxPreciosinredondear = loItem.Preciosinredondear
					lxPreciosinimpuestos = loItem.Preciosinimpuestos
					lxPreciounitario = loItem.Preciounitario
					lxMontoporcentajedescuentoconimpuesto = loItem.Montoporcentajedescuentoconimpuesto
					lxMontodto1 = loItem.Montodto1
					lxMontocfi = loItem.Montocfi
					lxNroitem = lnContadorNroItem
					lxPrecioconimpuestos = loItem.Precioconimpuestos
					lxPorcentajecfi = loItem.Porcentajecfi
					lxPorcentajedto1 = loItem.Porcentajedto1
					lxNoprocesarstock = loItem.Noprocesarstock
					lxCodigomotivodevolucion_PK = loItem.Codigomotivodevolucion_PK
					lxArticulo_PK = loItem.Articulo_PK
					lxCodigomotivodescuento_PK = loItem.Codigomotivodescuento_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxTalle = loItem.Talle
					lxDescuento = loItem.Descuento
					lxMontodescuento = loItem.Montodescuento
					lxCantidad = loItem.Cantidad
					lxPrecio = loItem.Precio
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.SeniaDet("PRECIOSISR","ACondIvaV","tasaimpint","COMP","APorcIvaV","PRECIOCISR","PRECIOSR","Prunsinimp","FPRUN","FCFITot","FmtoDTO1","FmtoCFI","NroItem","prunconimp","FporCFI","FporDTO1","ProcStock","MotDevol","CODIGO","FART","MotDescu","FTXT","FCOLO","FCOTXT","FTALL","FCFI","MNTDES","FCANT","FPRECIO","FMONTO" ) values ( <<lxPreciosinimpuestossinredondear>>, <<lxArticulo_condicionivaventas>>, <<lxTasaimpuestointerno>>, <<lxComportamiento>>, <<lxArticulo_porcentajeivaventas>>, <<lxPrecioconimpuestossinredondear>>, <<lxPreciosinredondear>>, <<lxPreciosinimpuestos>>, <<lxPreciounitario>>, <<lxMontoporcentajedescuentoconimpuesto>>, <<lxMontodto1>>, <<lxMontocfi>>, <<lxNroitem>>, <<lxPrecioconimpuestos>>, <<lxPorcentajecfi>>, <<lxPorcentajedto1>>, <<iif( lxNoprocesarstock, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxCodigomotivodevolucion_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigomotivodescuento_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle ) + "'">>, <<lxDescuento>>, <<lxMontodescuento>>, <<lxCantidad>>, <<lxPrecio>>, <<lxMonto>> ) 
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 Codigo from ZooLogic.SENIA where " + this.ConvertirFuncionesSql( " SENIA.CODIGO != ''" ) )
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
			Local lxSeniaCodigo
			lxSeniaCodigo = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Tasaimpint" as "Tasaimpuestointerno", "Mtoimpint" as "Montoimpuestointerno", "Mtoiva" as "Montoiva", "Preciocisr" as "Precioconimpuestossinredondear", "Porciva" as "Porcentajeiva", "Condiva" as "Condicioniva", "Preciosr" as "Preciosinredondear", "Preciosisr" as "Preciosinimpuestossinredondear", "Prunsinimp" as "Preciosinimpuestos", "Prunconimp" as "Precioconimpuestos", "Anulado" as "Anulado", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Descfw" as "Descripcionfw", "Vmodifw" as "Versionmodificacionfw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Compa" as "Comprobanteafectante", "Comp" as "Comprobanteorigen", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Codigo" as "Codigo", "Fletraa" as "Letraafectante", "Fletra" as "Letraorigen", "Obs" as "Observacion", "Fptovena" as "Puntodeventaafectante", "Fptoven" as "Puntodeventaorigen", "Fnumcompa" as "Numeroafectante", "Fnumcomp" as "Numeroorigen", "Facttipoa" as "Tipocomprobanteafectante", "Facttipo" as "Tipocomprobanteorigen", "Coriabrev" as "Tipocomprobanteorigenabreviado", "Cafeabrev" as "Tipocomprobanteafectanteabreviado", "Fechaa" as "Fechaafectante", "Fecha" as "Fechaorigen", "Cseriea" as "Cserieafectante", "Cserie" as "Cserieorigen", "Cversion" as "Cversionorigen", "Cversiona" as "Cversionafectante", "Cbasededat" as "Cbasededatosorigen", "Cbdedata" as "Cbasededatosafectante", "Cliente" as "Cliente", "Fechavenci" as "Fechavencimiento", "Fprecio" as "Precio", "Moneda" as "Moneda" from ZooLogic.SENIA where "Codigo" = <<"'" + this.FormatearTextoSql( lxSeniaCodigo ) + "'">> and  SENIA.CODIGO != ''
			endtext
			use in select('c_SENIA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_SENIA', set( 'Datasession' ) )

			if reccount( 'c_SENIA' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Preciosisr" as "Preciosinimpuestossinredondear", "Acondivav" as "Articulo_condicionivaventas", "Tasaimpint" as "Tasaimpuestointerno", "Comp" as "Comportamiento", "Aporcivav" as "Articulo_porcentajeivaventas", "Preciocisr" as "Precioconimpuestossinredondear", "Preciosr" as "Preciosinredondear", "Prunsinimp" as "Preciosinimpuestos", "Fprun" as "Preciounitario", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Fmtodto1" as "Montodto1", "Fmtocfi" as "Montocfi", "Nroitem" as "Nroitem", "Prunconimp" as "Precioconimpuestos", "Fporcfi" as "Porcentajecfi", "Fpordto1" as "Porcentajedto1", "Procstock" as "Noprocesarstock", "Motdevol" as "Codigomotivodevolucion", "Codigo" as "Codigo", "Fart" as "Articulo", "Motdescu" as "Codigomotivodescuento", "Ftxt" as "Articulodetalle", "Fcolo" as "Color", "Fcotxt" as "Colordetalle", "Ftall" as "Talle", "Fcfi" as "Descuento", "Mntdes" as "Montodescuento", "Fcant" as "Cantidad", "Fprecio" as "Precio", "Fmonto" as "Monto" from ZooLogic.SeniaDet where CODIGO = <<"'" + this.FormatearTextoSql( c_SENIA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ArticulosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ArticulosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ArticulosDetalle
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ConsultarPorClaveCandidata() as Boolean
		local llRetorno as Boolean
		llRetorno = .t.
		with this.oEntidad
			Local lxseniaFACTTIPO As Variant, lxseniaFLETRA As Variant, lxseniaFPTOVEN As Variant, lxseniaFNUMCOMP As Variant
			lxseniaFACTTIPO = .TipoComprobanteOrigen
			lxseniaFLETRA = .LetraOrigen
			lxseniaFPTOVEN = .PuntoDeVentaOrigen
			lxseniaFNUMCOMP = .NumeroOrigen
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Tasaimpint" as "Tasaimpuestointerno", "Mtoimpint" as "Montoimpuestointerno", "Mtoiva" as "Montoiva", "Preciocisr" as "Precioconimpuestossinredondear", "Porciva" as "Porcentajeiva", "Condiva" as "Condicioniva", "Preciosr" as "Preciosinredondear", "Preciosisr" as "Preciosinimpuestossinredondear", "Prunsinimp" as "Preciosinimpuestos", "Prunconimp" as "Precioconimpuestos", "Anulado" as "Anulado", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Descfw" as "Descripcionfw", "Vmodifw" as "Versionmodificacionfw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Compa" as "Comprobanteafectante", "Comp" as "Comprobanteorigen", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Codigo" as "Codigo", "Fletraa" as "Letraafectante", "Fletra" as "Letraorigen", "Obs" as "Observacion", "Fptovena" as "Puntodeventaafectante", "Fptoven" as "Puntodeventaorigen", "Fnumcompa" as "Numeroafectante", "Fnumcomp" as "Numeroorigen", "Facttipoa" as "Tipocomprobanteafectante", "Facttipo" as "Tipocomprobanteorigen", "Coriabrev" as "Tipocomprobanteorigenabreviado", "Cafeabrev" as "Tipocomprobanteafectanteabreviado", "Fechaa" as "Fechaafectante", "Fecha" as "Fechaorigen", "Cseriea" as "Cserieafectante", "Cserie" as "Cserieorigen", "Cversion" as "Cversionorigen", "Cversiona" as "Cversionafectante", "Cbasededat" as "Cbasededatosorigen", "Cbdedata" as "Cbasededatosafectante", "Cliente" as "Cliente", "Fechavenci" as "Fechavencimiento", "Fprecio" as "Precio", "Moneda" as "Moneda" from ZooLogic.SENIA where  SENIA.CODIGO != '' And FACTTIPO = <<lxseniaFACTTIPO>> and FLETRA = <<"'" + this.FormatearTextoSql( lxseniaFLETRA ) + "'">> and FPTOVEN = <<lxseniaFPTOVEN>> and FNUMCOMP = <<lxseniaFNUMCOMP>>
			endtext
			use in select('c_SENIA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_SENIA', set( 'Datasession' ) )
			if reccount( 'c_SENIA' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Preciosisr" as "Preciosinimpuestossinredondear", "Acondivav" as "Articulo_condicionivaventas", "Tasaimpint" as "Tasaimpuestointerno", "Comp" as "Comportamiento", "Aporcivav" as "Articulo_porcentajeivaventas", "Preciocisr" as "Precioconimpuestossinredondear", "Preciosr" as "Preciosinredondear", "Prunsinimp" as "Preciosinimpuestos", "Fprun" as "Preciounitario", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Fmtodto1" as "Montodto1", "Fmtocfi" as "Montocfi", "Nroitem" as "Nroitem", "Prunconimp" as "Precioconimpuestos", "Fporcfi" as "Porcentajecfi", "Fpordto1" as "Porcentajedto1", "Procstock" as "Noprocesarstock", "Motdevol" as "Codigomotivodevolucion", "Codigo" as "Codigo", "Fart" as "Articulo", "Motdescu" as "Codigomotivodescuento", "Ftxt" as "Articulodetalle", "Fcolo" as "Color", "Fcotxt" as "Colordetalle", "Ftall" as "Talle", "Fcfi" as "Descuento", "Mntdes" as "Montodescuento", "Fcant" as "Cantidad", "Fprecio" as "Precio", "Fmonto" as "Monto" from ZooLogic.SeniaDet where CODIGO = <<"'" + this.FormatearTextoSql( c_SENIA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ArticulosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ArticulosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ArticulosDetalle
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxSeniaCodigo as Variant
		llRetorno = .t.
		lxSeniaCodigo = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.SENIA where "Codigo" = <<"'" + this.FormatearTextoSql( lxSeniaCodigo ) + "'">> and  SENIA.CODIGO != ''
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
				lcOrden =  .LetraOrigen + str( .PuntoDeVentaOrigen, 4, 0) + str( .NumeroOrigen, 8, 0) + .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Tasaimpint" as "Tasaimpuestointerno", "Mtoimpint" as "Montoimpuestointerno", "Mtoiva" as "Montoiva", "Preciocisr" as "Precioconimpuestossinredondear", "Porciva" as "Porcentajeiva", "Condiva" as "Condicioniva", "Preciosr" as "Preciosinredondear", "Preciosisr" as "Preciosinimpuestossinredondear", "Prunsinimp" as "Preciosinimpuestos", "Prunconimp" as "Precioconimpuestos", "Anulado" as "Anulado", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Descfw" as "Descripcionfw", "Vmodifw" as "Versionmodificacionfw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Compa" as "Comprobanteafectante", "Comp" as "Comprobanteorigen", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Codigo" as "Codigo", "Fletraa" as "Letraafectante", "Fletra" as "Letraorigen", "Obs" as "Observacion", "Fptovena" as "Puntodeventaafectante", "Fptoven" as "Puntodeventaorigen", "Fnumcompa" as "Numeroafectante", "Fnumcomp" as "Numeroorigen", "Facttipoa" as "Tipocomprobanteafectante", "Facttipo" as "Tipocomprobanteorigen", "Coriabrev" as "Tipocomprobanteorigenabreviado", "Cafeabrev" as "Tipocomprobanteafectanteabreviado", "Fechaa" as "Fechaafectante", "Fecha" as "Fechaorigen", "Cseriea" as "Cserieafectante", "Cserie" as "Cserieorigen", "Cversion" as "Cversionorigen", "Cversiona" as "Cversionafectante", "Cbasededat" as "Cbasededatosorigen", "Cbdedata" as "Cbasededatosafectante", "Cliente" as "Cliente", "Fechavenci" as "Fechavencimiento", "Fprecio" as "Precio", "Moneda" as "Moneda" from ZooLogic.SENIA where  SENIA.CODIGO != '' order by FLETRA,FPTOVEN,FNUMCOMP,Codigo
			endtext
			use in select('c_SENIA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_SENIA', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Preciosisr" as "Preciosinimpuestossinredondear", "Acondivav" as "Articulo_condicionivaventas", "Tasaimpint" as "Tasaimpuestointerno", "Comp" as "Comportamiento", "Aporcivav" as "Articulo_porcentajeivaventas", "Preciocisr" as "Precioconimpuestossinredondear", "Preciosr" as "Preciosinredondear", "Prunsinimp" as "Preciosinimpuestos", "Fprun" as "Preciounitario", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Fmtodto1" as "Montodto1", "Fmtocfi" as "Montocfi", "Nroitem" as "Nroitem", "Prunconimp" as "Precioconimpuestos", "Fporcfi" as "Porcentajecfi", "Fpordto1" as "Porcentajedto1", "Procstock" as "Noprocesarstock", "Motdevol" as "Codigomotivodevolucion", "Codigo" as "Codigo", "Fart" as "Articulo", "Motdescu" as "Codigomotivodescuento", "Ftxt" as "Articulodetalle", "Fcolo" as "Color", "Fcotxt" as "Colordetalle", "Ftall" as "Talle", "Fcfi" as "Descuento", "Mntdes" as "Montodescuento", "Fcant" as "Cantidad", "Fprecio" as "Precio", "Fmonto" as "Monto" from ZooLogic.SeniaDet where CODIGO = <<"'" + this.FormatearTextoSql( c_SENIA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ArticulosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ArticulosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ArticulosDetalle
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
				lcOrden =  .LetraOrigen + str( .PuntoDeVentaOrigen, 4, 0) + str( .NumeroOrigen, 8, 0) + .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Tasaimpint" as "Tasaimpuestointerno", "Mtoimpint" as "Montoimpuestointerno", "Mtoiva" as "Montoiva", "Preciocisr" as "Precioconimpuestossinredondear", "Porciva" as "Porcentajeiva", "Condiva" as "Condicioniva", "Preciosr" as "Preciosinredondear", "Preciosisr" as "Preciosinimpuestossinredondear", "Prunsinimp" as "Preciosinimpuestos", "Prunconimp" as "Precioconimpuestos", "Anulado" as "Anulado", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Descfw" as "Descripcionfw", "Vmodifw" as "Versionmodificacionfw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Compa" as "Comprobanteafectante", "Comp" as "Comprobanteorigen", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Codigo" as "Codigo", "Fletraa" as "Letraafectante", "Fletra" as "Letraorigen", "Obs" as "Observacion", "Fptovena" as "Puntodeventaafectante", "Fptoven" as "Puntodeventaorigen", "Fnumcompa" as "Numeroafectante", "Fnumcomp" as "Numeroorigen", "Facttipoa" as "Tipocomprobanteafectante", "Facttipo" as "Tipocomprobanteorigen", "Coriabrev" as "Tipocomprobanteorigenabreviado", "Cafeabrev" as "Tipocomprobanteafectanteabreviado", "Fechaa" as "Fechaafectante", "Fecha" as "Fechaorigen", "Cseriea" as "Cserieafectante", "Cserie" as "Cserieorigen", "Cversion" as "Cversionorigen", "Cversiona" as "Cversionafectante", "Cbasededat" as "Cbasededatosorigen", "Cbdedata" as "Cbasededatosafectante", "Cliente" as "Cliente", "Fechavenci" as "Fechavencimiento", "Fprecio" as "Precio", "Moneda" as "Moneda" from ZooLogic.SENIA where  funciones.padr( FLETRA, 1, ' ' ) + str( FPTOVEN, 4, 0) + str( FNUMCOMP, 8, 0) + funciones.padr( Codigo, 38, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  SENIA.CODIGO != '' order by FLETRA,FPTOVEN,FNUMCOMP,Codigo
			endtext
			use in select('c_SENIA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_SENIA', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Preciosisr" as "Preciosinimpuestossinredondear", "Acondivav" as "Articulo_condicionivaventas", "Tasaimpint" as "Tasaimpuestointerno", "Comp" as "Comportamiento", "Aporcivav" as "Articulo_porcentajeivaventas", "Preciocisr" as "Precioconimpuestossinredondear", "Preciosr" as "Preciosinredondear", "Prunsinimp" as "Preciosinimpuestos", "Fprun" as "Preciounitario", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Fmtodto1" as "Montodto1", "Fmtocfi" as "Montocfi", "Nroitem" as "Nroitem", "Prunconimp" as "Precioconimpuestos", "Fporcfi" as "Porcentajecfi", "Fpordto1" as "Porcentajedto1", "Procstock" as "Noprocesarstock", "Motdevol" as "Codigomotivodevolucion", "Codigo" as "Codigo", "Fart" as "Articulo", "Motdescu" as "Codigomotivodescuento", "Ftxt" as "Articulodetalle", "Fcolo" as "Color", "Fcotxt" as "Colordetalle", "Ftall" as "Talle", "Fcfi" as "Descuento", "Mntdes" as "Montodescuento", "Fcant" as "Cantidad", "Fprecio" as "Precio", "Fmonto" as "Monto" from ZooLogic.SeniaDet where CODIGO = <<"'" + this.FormatearTextoSql( c_SENIA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ArticulosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ArticulosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ArticulosDetalle
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
				lcOrden =  .LetraOrigen + str( .PuntoDeVentaOrigen, 4, 0) + str( .NumeroOrigen, 8, 0) + .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Tasaimpint" as "Tasaimpuestointerno", "Mtoimpint" as "Montoimpuestointerno", "Mtoiva" as "Montoiva", "Preciocisr" as "Precioconimpuestossinredondear", "Porciva" as "Porcentajeiva", "Condiva" as "Condicioniva", "Preciosr" as "Preciosinredondear", "Preciosisr" as "Preciosinimpuestossinredondear", "Prunsinimp" as "Preciosinimpuestos", "Prunconimp" as "Precioconimpuestos", "Anulado" as "Anulado", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Descfw" as "Descripcionfw", "Vmodifw" as "Versionmodificacionfw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Compa" as "Comprobanteafectante", "Comp" as "Comprobanteorigen", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Codigo" as "Codigo", "Fletraa" as "Letraafectante", "Fletra" as "Letraorigen", "Obs" as "Observacion", "Fptovena" as "Puntodeventaafectante", "Fptoven" as "Puntodeventaorigen", "Fnumcompa" as "Numeroafectante", "Fnumcomp" as "Numeroorigen", "Facttipoa" as "Tipocomprobanteafectante", "Facttipo" as "Tipocomprobanteorigen", "Coriabrev" as "Tipocomprobanteorigenabreviado", "Cafeabrev" as "Tipocomprobanteafectanteabreviado", "Fechaa" as "Fechaafectante", "Fecha" as "Fechaorigen", "Cseriea" as "Cserieafectante", "Cserie" as "Cserieorigen", "Cversion" as "Cversionorigen", "Cversiona" as "Cversionafectante", "Cbasededat" as "Cbasededatosorigen", "Cbdedata" as "Cbasededatosafectante", "Cliente" as "Cliente", "Fechavenci" as "Fechavencimiento", "Fprecio" as "Precio", "Moneda" as "Moneda" from ZooLogic.SENIA where  funciones.padr( FLETRA, 1, ' ' ) + str( FPTOVEN, 4, 0) + str( FNUMCOMP, 8, 0) + funciones.padr( Codigo, 38, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  SENIA.CODIGO != '' order by FLETRA desc,FPTOVEN desc,FNUMCOMP desc,Codigo desc
			endtext
			use in select('c_SENIA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_SENIA', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Preciosisr" as "Preciosinimpuestossinredondear", "Acondivav" as "Articulo_condicionivaventas", "Tasaimpint" as "Tasaimpuestointerno", "Comp" as "Comportamiento", "Aporcivav" as "Articulo_porcentajeivaventas", "Preciocisr" as "Precioconimpuestossinredondear", "Preciosr" as "Preciosinredondear", "Prunsinimp" as "Preciosinimpuestos", "Fprun" as "Preciounitario", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Fmtodto1" as "Montodto1", "Fmtocfi" as "Montocfi", "Nroitem" as "Nroitem", "Prunconimp" as "Precioconimpuestos", "Fporcfi" as "Porcentajecfi", "Fpordto1" as "Porcentajedto1", "Procstock" as "Noprocesarstock", "Motdevol" as "Codigomotivodevolucion", "Codigo" as "Codigo", "Fart" as "Articulo", "Motdescu" as "Codigomotivodescuento", "Ftxt" as "Articulodetalle", "Fcolo" as "Color", "Fcotxt" as "Colordetalle", "Ftall" as "Talle", "Fcfi" as "Descuento", "Mntdes" as "Montodescuento", "Fcant" as "Cantidad", "Fprecio" as "Precio", "Fmonto" as "Monto" from ZooLogic.SeniaDet where CODIGO = <<"'" + this.FormatearTextoSql( c_SENIA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ArticulosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ArticulosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ArticulosDetalle
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
				lcOrden =  .LetraOrigen + str( .PuntoDeVentaOrigen, 4, 0) + str( .NumeroOrigen, 8, 0) + .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Tasaimpint" as "Tasaimpuestointerno", "Mtoimpint" as "Montoimpuestointerno", "Mtoiva" as "Montoiva", "Preciocisr" as "Precioconimpuestossinredondear", "Porciva" as "Porcentajeiva", "Condiva" as "Condicioniva", "Preciosr" as "Preciosinredondear", "Preciosisr" as "Preciosinimpuestossinredondear", "Prunsinimp" as "Preciosinimpuestos", "Prunconimp" as "Precioconimpuestos", "Anulado" as "Anulado", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Descfw" as "Descripcionfw", "Vmodifw" as "Versionmodificacionfw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Compa" as "Comprobanteafectante", "Comp" as "Comprobanteorigen", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Codigo" as "Codigo", "Fletraa" as "Letraafectante", "Fletra" as "Letraorigen", "Obs" as "Observacion", "Fptovena" as "Puntodeventaafectante", "Fptoven" as "Puntodeventaorigen", "Fnumcompa" as "Numeroafectante", "Fnumcomp" as "Numeroorigen", "Facttipoa" as "Tipocomprobanteafectante", "Facttipo" as "Tipocomprobanteorigen", "Coriabrev" as "Tipocomprobanteorigenabreviado", "Cafeabrev" as "Tipocomprobanteafectanteabreviado", "Fechaa" as "Fechaafectante", "Fecha" as "Fechaorigen", "Cseriea" as "Cserieafectante", "Cserie" as "Cserieorigen", "Cversion" as "Cversionorigen", "Cversiona" as "Cversionafectante", "Cbasededat" as "Cbasededatosorigen", "Cbdedata" as "Cbasededatosafectante", "Cliente" as "Cliente", "Fechavenci" as "Fechavencimiento", "Fprecio" as "Precio", "Moneda" as "Moneda" from ZooLogic.SENIA where  SENIA.CODIGO != '' order by FLETRA desc,FPTOVEN desc,FNUMCOMP desc,Codigo desc
			endtext
			use in select('c_SENIA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_SENIA', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Preciosisr" as "Preciosinimpuestossinredondear", "Acondivav" as "Articulo_condicionivaventas", "Tasaimpint" as "Tasaimpuestointerno", "Comp" as "Comportamiento", "Aporcivav" as "Articulo_porcentajeivaventas", "Preciocisr" as "Precioconimpuestossinredondear", "Preciosr" as "Preciosinredondear", "Prunsinimp" as "Preciosinimpuestos", "Fprun" as "Preciounitario", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Fmtodto1" as "Montodto1", "Fmtocfi" as "Montocfi", "Nroitem" as "Nroitem", "Prunconimp" as "Precioconimpuestos", "Fporcfi" as "Porcentajecfi", "Fpordto1" as "Porcentajedto1", "Procstock" as "Noprocesarstock", "Motdevol" as "Codigomotivodevolucion", "Codigo" as "Codigo", "Fart" as "Articulo", "Motdescu" as "Codigomotivodescuento", "Ftxt" as "Articulodetalle", "Fcolo" as "Color", "Fcotxt" as "Colordetalle", "Ftall" as "Talle", "Fcfi" as "Descuento", "Mntdes" as "Montodescuento", "Fcant" as "Cantidad", "Fprecio" as "Precio", "Fmonto" as "Monto" from ZooLogic.SeniaDet where CODIGO = <<"'" + this.FormatearTextoSql( c_SENIA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ArticulosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ArticulosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ArticulosDetalle
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
			lcXml = this.oConexion.EjecutarSql( "select Fecimpo,Fmodifw,Fectrans,Fecexpo,Faltafw,Tasaimpint,Mtoimpint,Mtoiva,Preciocisr,Porciva,Cond" + ;
"iva,Preciosr,Preciosisr,Prunsinimp,Prunconimp,Anulado,Valtafw,Zadsfw,Descfw,Vmodifw,Smodifw,Umodifw," + ;
"Hmodifw,Horaimpo,Haltafw,Esttrans,Horaexpo,Saltafw,Ualtafw,Compa,Comp,Bdmodifw,Bdaltafw,Codigo,Fletr" + ;
"aa,Fletra,Obs,Fptovena,Fptoven,Fnumcompa,Fnumcomp,Facttipoa,Facttipo,Coriabrev,Cafeabrev,Fechaa,Fech" + ;
"a,Cseriea,Cserie,Cversion,Cversiona,Cbasededat,Cbdedata,Cliente,Fechavenci,Fprecio,Moneda" + ;
" from ZooLogic.SENIA where  SENIA.CODIGO != '' and " + lcFiltro )
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
			local  lxSeniaFecimpo, lxSeniaFmodifw, lxSeniaFectrans, lxSeniaFecexpo, lxSeniaFaltafw, lxSeniaTasaimpint, lxSeniaMtoimpint, lxSeniaMtoiva, lxSeniaPreciocisr, lxSeniaPorciva, lxSeniaCondiva, lxSeniaPreciosr, lxSeniaPreciosisr, lxSeniaPrunsinimp, lxSeniaPrunconimp, lxSeniaAnulado, lxSeniaValtafw, lxSeniaZadsfw, lxSeniaDescfw, lxSeniaVmodifw, lxSeniaSmodifw, lxSeniaUmodifw, lxSeniaHmodifw, lxSeniaHoraimpo, lxSeniaHaltafw, lxSeniaEsttrans, lxSeniaHoraexpo, lxSeniaSaltafw, lxSeniaUaltafw, lxSeniaCompa, lxSeniaComp, lxSeniaBdmodifw, lxSeniaBdaltafw, lxSeniaCodigo, lxSeniaFletraa, lxSeniaFletra, lxSeniaObs, lxSeniaFptovena, lxSeniaFptoven, lxSeniaFnumcompa, lxSeniaFnumcomp, lxSeniaFacttipoa, lxSeniaFacttipo, lxSeniaCoriabrev, lxSeniaCafeabrev, lxSeniaFechaa, lxSeniaFecha, lxSeniaCseriea, lxSeniaCserie, lxSeniaCversion, lxSeniaCversiona, lxSeniaCbasededat, lxSeniaCbdedata, lxSeniaCliente, lxSeniaFechavenci, lxSeniaFprecio, lxSeniaMoneda
				lxSeniaFecimpo = ctod( '  /  /    ' )			lxSeniaFmodifw = ctod( '  /  /    ' )			lxSeniaFectrans = ctod( '  /  /    ' )			lxSeniaFecexpo = ctod( '  /  /    ' )			lxSeniaFaltafw = ctod( '  /  /    ' )			lxSeniaTasaimpint = 0			lxSeniaMtoimpint = 0			lxSeniaMtoiva = 0			lxSeniaPreciocisr = 0			lxSeniaPorciva = 0			lxSeniaCondiva = 0			lxSeniaPreciosr = 0			lxSeniaPreciosisr = 0			lxSeniaPrunsinimp = 0			lxSeniaPrunconimp = 0			lxSeniaAnulado = .F.			lxSeniaValtafw = []			lxSeniaZadsfw = []			lxSeniaDescfw = []			lxSeniaVmodifw = []			lxSeniaSmodifw = []			lxSeniaUmodifw = []			lxSeniaHmodifw = []			lxSeniaHoraimpo = []			lxSeniaHaltafw = []			lxSeniaEsttrans = []			lxSeniaHoraexpo = []			lxSeniaSaltafw = []			lxSeniaUaltafw = []			lxSeniaCompa = []			lxSeniaComp = []			lxSeniaBdmodifw = []			lxSeniaBdaltafw = []			lxSeniaCodigo = []			lxSeniaFletraa = []			lxSeniaFletra = []			lxSeniaObs = []			lxSeniaFptovena = 0			lxSeniaFptoven = 0			lxSeniaFnumcompa = 0			lxSeniaFnumcomp = 0			lxSeniaFacttipoa = 0			lxSeniaFacttipo = 0			lxSeniaCoriabrev = []			lxSeniaCafeabrev = []			lxSeniaFechaa = ctod( '  /  /    ' )			lxSeniaFecha = ctod( '  /  /    ' )			lxSeniaCseriea = []			lxSeniaCserie = []			lxSeniaCversion = []			lxSeniaCversiona = []			lxSeniaCbasededat = []			lxSeniaCbdedata = []			lxSeniaCliente = []			lxSeniaFechavenci = ctod( '  /  /    ' )			lxSeniaFprecio = 0			lxSeniaMoneda = []
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.SeniaDet where "CODIGO" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( [delete from ZooLogic.SENIA where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			.GenerarSentenciasComponentes()
			.EjecutarSentencias( This.ColSentencias )
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
			lcTabla = 'SENIA' + '_' + tcCampo
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
		lcWhere = " Where  SENIA.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Tasaimpint" as "Tasaimpuestointerno", "Mtoimpint" as "Montoimpuestointerno", "Mtoiva" as "Montoiva", "Preciocisr" as "Precioconimpuestossinredondear", "Porciva" as "Porcentajeiva", "Condiva" as "Condicioniva", "Preciosr" as "Preciosinredondear", "Preciosisr" as "Preciosinimpuestossinredondear", "Prunsinimp" as "Preciosinimpuestos", "Prunconimp" as "Precioconimpuestos", "Anulado" as "Anulado", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Descfw" as "Descripcionfw", "Vmodifw" as "Versionmodificacionfw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Compa" as "Comprobanteafectante", "Comp" as "Comprobanteorigen", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Codigo" as "Codigo", "Fletraa" as "Letraafectante", "Fletra" as "Letraorigen", "Obs" as "Observacion", "Fptovena" as "Puntodeventaafectante", "Fptoven" as "Puntodeventaorigen", "Fnumcompa" as "Numeroafectante", "Fnumcomp" as "Numeroorigen", "Facttipoa" as "Tipocomprobanteafectante", "Facttipo" as "Tipocomprobanteorigen", "Coriabrev" as "Tipocomprobanteorigenabreviado", "Cafeabrev" as "Tipocomprobanteafectanteabreviado", "Fechaa" as "Fechaafectante", "Fecha" as "Fechaorigen", "Cseriea" as "Cserieafectante", "Cserie" as "Cserieorigen", "Cversion" as "Cversionorigen", "Cversiona" as "Cversionafectante", "Cbasededat" as "Cbasededatosorigen", "Cbdedata" as "Cbasededatosafectante", "Cliente" as "Cliente", "Fechavenci" as "Fechavencimiento", "Fprecio" as "Precio", "Moneda" as "Moneda"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'SENIA', '', tnTope )
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
	Function ObtenerDatosDetalleArticulosDetalle( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  SENIADET.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Preciosisr" as "Preciosinimpuestossinredondear", "Acondivav" as "Articulo_condicionivaventas", "Tasaimpint" as "Tasaimpuestointerno", "Comp" as "Comportamiento", "Aporcivav" as "Articulo_porcentajeivaventas", "Preciocisr" as "Precioconimpuestossinredondear", "Preciosr" as "Preciosinredondear", "Prunsinimp" as "Preciosinimpuestos", "Fprun" as "Preciounitario", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Fmtodto1" as "Montodto1", "Fmtocfi" as "Montocfi", "Nroitem" as "Nroitem", "Prunconimp" as "Precioconimpuestos", "Fporcfi" as "Porcentajecfi", "Fpordto1" as "Porcentajedto1", "Procstock" as "Noprocesarstock", "Motdevol" as "Codigomotivodevolucion", "Codigo" as "Codigo", "Fart" as "Articulo", "Motdescu" as "Codigomotivodescuento", "Ftxt" as "Articulodetalle", "Fcolo" as "Color", "Fcotxt" as "Colordetalle", "Ftall" as "Talle", "Fcfi" as "Descuento", "Mntdes" as "Montodescuento", "Fcant" as "Cantidad", "Fprecio" as "Precio", "Fmonto" as "Monto"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleArticulosDetalle( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'SeniaDet', 'ArticulosDetalle', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleArticulosDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleArticulosDetalle( lcAtributo )
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
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'FECHATRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRANS AS FECHATRANSFERENCIA'
				Case lcAtributo == 'FECHAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECEXPO AS FECHAEXPO'
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'TASAIMPUESTOINTERNO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TASAIMPINT AS TASAIMPUESTOINTERNO'
				Case lcAtributo == 'MONTOIMPUESTOINTERNO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MTOIMPINT AS MONTOIMPUESTOINTERNO'
				Case lcAtributo == 'MONTOIVA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MTOIVA AS MONTOIVA'
				Case lcAtributo == 'PRECIOCONIMPUESTOSSINREDONDEAR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PRECIOCISR AS PRECIOCONIMPUESTOSSINREDONDEAR'
				Case lcAtributo == 'PORCENTAJEIVA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PORCIVA AS PORCENTAJEIVA'
				Case lcAtributo == 'CONDICIONIVA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CONDIVA AS CONDICIONIVA'
				Case lcAtributo == 'PRECIOSINREDONDEAR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PRECIOSR AS PRECIOSINREDONDEAR'
				Case lcAtributo == 'PRECIOSINIMPUESTOSSINREDONDEAR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PRECIOSISR AS PRECIOSINIMPUESTOSSINREDONDEAR'
				Case lcAtributo == 'PRECIOSINIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PRUNSINIMP AS PRECIOSINIMPUESTOS'
				Case lcAtributo == 'PRECIOCONIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PRUNCONIMP AS PRECIOCONIMPUESTOS'
				Case lcAtributo == 'ANULADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ANULADO AS ANULADO'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'DESCRIPCIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCFW AS DESCRIPCIONFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'COMPROBANTEAFECTANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COMPA AS COMPROBANTEAFECTANTE'
				Case lcAtributo == 'COMPROBANTEORIGEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COMP AS COMPROBANTEORIGEN'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'LETRAAFECTANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FLETRAA AS LETRAAFECTANTE'
				Case lcAtributo == 'LETRAORIGEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FLETRA AS LETRAORIGEN'
				Case lcAtributo == 'OBSERVACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'OBS AS OBSERVACION'
				Case lcAtributo == 'PUNTODEVENTAAFECTANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPTOVENA AS PUNTODEVENTAAFECTANTE'
				Case lcAtributo == 'PUNTODEVENTAORIGEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPTOVEN AS PUNTODEVENTAORIGEN'
				Case lcAtributo == 'NUMEROAFECTANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FNUMCOMPA AS NUMEROAFECTANTE'
				Case lcAtributo == 'NUMEROORIGEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FNUMCOMP AS NUMEROORIGEN'
				Case lcAtributo == 'TIPOCOMPROBANTEAFECTANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FACTTIPOA AS TIPOCOMPROBANTEAFECTANTE'
				Case lcAtributo == 'TIPOCOMPROBANTEORIGEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FACTTIPO AS TIPOCOMPROBANTEORIGEN'
				Case lcAtributo == 'TIPOCOMPROBANTEORIGENABREVIADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CORIABREV AS TIPOCOMPROBANTEORIGENABREVIADO'
				Case lcAtributo == 'TIPOCOMPROBANTEAFECTANTEABREVIADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CAFEABREV AS TIPOCOMPROBANTEAFECTANTEABREVIADO'
				Case lcAtributo == 'FECHAAFECTANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHAA AS FECHAAFECTANTE'
				Case lcAtributo == 'FECHAORIGEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHA AS FECHAORIGEN'
				Case lcAtributo == 'CSERIEAFECTANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CSERIEA AS CSERIEAFECTANTE'
				Case lcAtributo == 'CSERIEORIGEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CSERIE AS CSERIEORIGEN'
				Case lcAtributo == 'CVERSIONORIGEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CVERSION AS CVERSIONORIGEN'
				Case lcAtributo == 'CVERSIONAFECTANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CVERSIONA AS CVERSIONAFECTANTE'
				Case lcAtributo == 'CBASEDEDATOSORIGEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CBASEDEDAT AS CBASEDEDATOSORIGEN'
				Case lcAtributo == 'CBASEDEDATOSAFECTANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CBDEDATA AS CBASEDEDATOSAFECTANTE'
				Case lcAtributo == 'CLIENTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLIENTE AS CLIENTE'
				Case lcAtributo == 'FECHAVENCIMIENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHAVENCI AS FECHAVENCIMIENTO'
				Case lcAtributo == 'PRECIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPRECIO AS PRECIO'
				Case lcAtributo == 'MONEDA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONEDA AS MONEDA'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleArticulosDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'PRECIOSINIMPUESTOSSINREDONDEAR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PRECIOSISR AS PRECIOSINIMPUESTOSSINREDONDEAR'
				Case lcAtributo == 'ARTICULO_CONDICIONIVAVENTAS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ACONDIVAV AS ARTICULO_CONDICIONIVAVENTAS'
				Case lcAtributo == 'TASAIMPUESTOINTERNO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TASAIMPINT AS TASAIMPUESTOINTERNO'
				Case lcAtributo == 'COMPORTAMIENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COMP AS COMPORTAMIENTO'
				Case lcAtributo == 'ARTICULO_PORCENTAJEIVAVENTAS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'APORCIVAV AS ARTICULO_PORCENTAJEIVAVENTAS'
				Case lcAtributo == 'PRECIOCONIMPUESTOSSINREDONDEAR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PRECIOCISR AS PRECIOCONIMPUESTOSSINREDONDEAR'
				Case lcAtributo == 'PRECIOSINREDONDEAR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PRECIOSR AS PRECIOSINREDONDEAR'
				Case lcAtributo == 'PRECIOSINIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PRUNSINIMP AS PRECIOSINIMPUESTOS'
				Case lcAtributo == 'PRECIOUNITARIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPRUN AS PRECIOUNITARIO'
				Case lcAtributo == 'MONTOPORCENTAJEDESCUENTOCONIMPUESTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FCFITOT AS MONTOPORCENTAJEDESCUENTOCONIMPUESTO'
				Case lcAtributo == 'MONTODTO1'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMTODTO1 AS MONTODTO1'
				Case lcAtributo == 'MONTOCFI'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMTOCFI AS MONTOCFI'
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'PRECIOCONIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PRUNCONIMP AS PRECIOCONIMPUESTOS'
				Case lcAtributo == 'PORCENTAJECFI'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPORCFI AS PORCENTAJECFI'
				Case lcAtributo == 'PORCENTAJEDTO1'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPORDTO1 AS PORCENTAJEDTO1'
				Case lcAtributo == 'NOPROCESARSTOCK'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PROCSTOCK AS NOPROCESARSTOCK'
				Case lcAtributo == 'CODIGOMOTIVODEVOLUCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MOTDEVOL AS CODIGOMOTIVODEVOLUCION'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'ARTICULO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FART AS ARTICULO'
				Case lcAtributo == 'CODIGOMOTIVODESCUENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MOTDESCU AS CODIGOMOTIVODESCUENTO'
				Case lcAtributo == 'ARTICULODETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FTXT AS ARTICULODETALLE'
				Case lcAtributo == 'COLOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FCOLO AS COLOR'
				Case lcAtributo == 'COLORDETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FCOTXT AS COLORDETALLE'
				Case lcAtributo == 'TALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FTALL AS TALLE'
				Case lcAtributo == 'DESCUENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FCFI AS DESCUENTO'
				Case lcAtributo == 'MONTODESCUENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MNTDES AS MONTODESCUENTO'
				Case lcAtributo == 'CANTIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FCANT AS CANTIDAD'
				Case lcAtributo == 'PRECIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPRECIO AS PRECIO'
				Case lcAtributo == 'MONTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMONTO AS MONTO'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEXPO'
				lcCampo = 'FECEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'TASAIMPUESTOINTERNO'
				lcCampo = 'TASAIMPINT'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOIMPUESTOINTERNO'
				lcCampo = 'MTOIMPINT'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOIVA'
				lcCampo = 'MTOIVA'
			Case upper( alltrim( tcAtributo ) ) == 'PRECIOCONIMPUESTOSSINREDONDEAR'
				lcCampo = 'PRECIOCISR'
			Case upper( alltrim( tcAtributo ) ) == 'PORCENTAJEIVA'
				lcCampo = 'PORCIVA'
			Case upper( alltrim( tcAtributo ) ) == 'CONDICIONIVA'
				lcCampo = 'CONDIVA'
			Case upper( alltrim( tcAtributo ) ) == 'PRECIOSINREDONDEAR'
				lcCampo = 'PRECIOSR'
			Case upper( alltrim( tcAtributo ) ) == 'PRECIOSINIMPUESTOSSINREDONDEAR'
				lcCampo = 'PRECIOSISR'
			Case upper( alltrim( tcAtributo ) ) == 'PRECIOSINIMPUESTOS'
				lcCampo = 'PRUNSINIMP'
			Case upper( alltrim( tcAtributo ) ) == 'PRECIOCONIMPUESTOS'
				lcCampo = 'PRUNCONIMP'
			Case upper( alltrim( tcAtributo ) ) == 'ANULADO'
				lcCampo = 'ANULADO'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCIONFW'
				lcCampo = 'DESCFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'COMPROBANTEAFECTANTE'
				lcCampo = 'COMPA'
			Case upper( alltrim( tcAtributo ) ) == 'COMPROBANTEORIGEN'
				lcCampo = 'COMP'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'LETRAAFECTANTE'
				lcCampo = 'FLETRAA'
			Case upper( alltrim( tcAtributo ) ) == 'LETRAORIGEN'
				lcCampo = 'FLETRA'
			Case upper( alltrim( tcAtributo ) ) == 'OBSERVACION'
				lcCampo = 'OBS'
			Case upper( alltrim( tcAtributo ) ) == 'PUNTODEVENTAAFECTANTE'
				lcCampo = 'FPTOVENA'
			Case upper( alltrim( tcAtributo ) ) == 'PUNTODEVENTAORIGEN'
				lcCampo = 'FPTOVEN'
			Case upper( alltrim( tcAtributo ) ) == 'NUMEROAFECTANTE'
				lcCampo = 'FNUMCOMPA'
			Case upper( alltrim( tcAtributo ) ) == 'NUMEROORIGEN'
				lcCampo = 'FNUMCOMP'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOCOMPROBANTEAFECTANTE'
				lcCampo = 'FACTTIPOA'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOCOMPROBANTEORIGEN'
				lcCampo = 'FACTTIPO'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOCOMPROBANTEORIGENABREVIADO'
				lcCampo = 'CORIABREV'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOCOMPROBANTEAFECTANTEABREVIADO'
				lcCampo = 'CAFEABREV'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAAFECTANTE'
				lcCampo = 'FECHAA'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAORIGEN'
				lcCampo = 'FECHA'
			Case upper( alltrim( tcAtributo ) ) == 'CSERIEAFECTANTE'
				lcCampo = 'CSERIEA'
			Case upper( alltrim( tcAtributo ) ) == 'CSERIEORIGEN'
				lcCampo = 'CSERIE'
			Case upper( alltrim( tcAtributo ) ) == 'CVERSIONORIGEN'
				lcCampo = 'CVERSION'
			Case upper( alltrim( tcAtributo ) ) == 'CVERSIONAFECTANTE'
				lcCampo = 'CVERSIONA'
			Case upper( alltrim( tcAtributo ) ) == 'CBASEDEDATOSORIGEN'
				lcCampo = 'CBASEDEDAT'
			Case upper( alltrim( tcAtributo ) ) == 'CBASEDEDATOSAFECTANTE'
				lcCampo = 'CBDEDATA'
			Case upper( alltrim( tcAtributo ) ) == 'CLIENTE'
				lcCampo = 'CLIENTE'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAVENCIMIENTO'
				lcCampo = 'FECHAVENCI'
			Case upper( alltrim( tcAtributo ) ) == 'PRECIO'
				lcCampo = 'FPRECIO'
			Case upper( alltrim( tcAtributo ) ) == 'MONEDA'
				lcCampo = 'MONEDA'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleArticulosDetalle( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'PRECIOSINIMPUESTOSSINREDONDEAR'
				lcCampo = 'PRECIOSISR'
			Case upper( alltrim( tcAtributo ) ) == 'ARTICULO_CONDICIONIVAVENTAS'
				lcCampo = 'ACONDIVAV'
			Case upper( alltrim( tcAtributo ) ) == 'TASAIMPUESTOINTERNO'
				lcCampo = 'TASAIMPINT'
			Case upper( alltrim( tcAtributo ) ) == 'COMPORTAMIENTO'
				lcCampo = 'COMP'
			Case upper( alltrim( tcAtributo ) ) == 'ARTICULO_PORCENTAJEIVAVENTAS'
				lcCampo = 'APORCIVAV'
			Case upper( alltrim( tcAtributo ) ) == 'PRECIOCONIMPUESTOSSINREDONDEAR'
				lcCampo = 'PRECIOCISR'
			Case upper( alltrim( tcAtributo ) ) == 'PRECIOSINREDONDEAR'
				lcCampo = 'PRECIOSR'
			Case upper( alltrim( tcAtributo ) ) == 'PRECIOSINIMPUESTOS'
				lcCampo = 'PRUNSINIMP'
			Case upper( alltrim( tcAtributo ) ) == 'PRECIOUNITARIO'
				lcCampo = 'FPRUN'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOPORCENTAJEDESCUENTOCONIMPUESTO'
				lcCampo = 'FCFITOT'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODTO1'
				lcCampo = 'FMTODTO1'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOCFI'
				lcCampo = 'FMTOCFI'
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'PRECIOCONIMPUESTOS'
				lcCampo = 'PRUNCONIMP'
			Case upper( alltrim( tcAtributo ) ) == 'PORCENTAJECFI'
				lcCampo = 'FPORCFI'
			Case upper( alltrim( tcAtributo ) ) == 'PORCENTAJEDTO1'
				lcCampo = 'FPORDTO1'
			Case upper( alltrim( tcAtributo ) ) == 'NOPROCESARSTOCK'
				lcCampo = 'PROCSTOCK'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGOMOTIVODEVOLUCION'
				lcCampo = 'MOTDEVOL'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'ARTICULO'
				lcCampo = 'FART'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGOMOTIVODESCUENTO'
				lcCampo = 'MOTDESCU'
			Case upper( alltrim( tcAtributo ) ) == 'ARTICULODETALLE'
				lcCampo = 'FTXT'
			Case upper( alltrim( tcAtributo ) ) == 'COLOR'
				lcCampo = 'FCOLO'
			Case upper( alltrim( tcAtributo ) ) == 'COLORDETALLE'
				lcCampo = 'FCOTXT'
			Case upper( alltrim( tcAtributo ) ) == 'TALLE'
				lcCampo = 'FTALL'
			Case upper( alltrim( tcAtributo ) ) == 'DESCUENTO'
				lcCampo = 'FCFI'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTO'
				lcCampo = 'MNTDES'
			Case upper( alltrim( tcAtributo ) ) == 'CANTIDAD'
				lcCampo = 'FCANT'
			Case upper( alltrim( tcAtributo ) ) == 'PRECIO'
				lcCampo = 'FPRECIO'
			Case upper( alltrim( tcAtributo ) ) == 'MONTO'
				lcCampo = 'FMONTO'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerTablaDetalle( tcDetalle as string ) as String
		local lcRetorno as string
		lcRetorno = ''
		if upper( alltrim( tcDetalle ) ) == 'ARTICULOSDETALLE'
			lcRetorno = 'SENIADET'
		EndIf
		return lcRetorno
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasInsert() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcSentencia as string, loItem as object
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxSeniaFecimpo, lxSeniaFmodifw, lxSeniaFectrans, lxSeniaFecexpo, lxSeniaFaltafw, lxSeniaTasaimpint, lxSeniaMtoimpint, lxSeniaMtoiva, lxSeniaPreciocisr, lxSeniaPorciva, lxSeniaCondiva, lxSeniaPreciosr, lxSeniaPreciosisr, lxSeniaPrunsinimp, lxSeniaPrunconimp, lxSeniaAnulado, lxSeniaValtafw, lxSeniaZadsfw, lxSeniaDescfw, lxSeniaVmodifw, lxSeniaSmodifw, lxSeniaUmodifw, lxSeniaHmodifw, lxSeniaHoraimpo, lxSeniaHaltafw, lxSeniaEsttrans, lxSeniaHoraexpo, lxSeniaSaltafw, lxSeniaUaltafw, lxSeniaCompa, lxSeniaComp, lxSeniaBdmodifw, lxSeniaBdaltafw, lxSeniaCodigo, lxSeniaFletraa, lxSeniaFletra, lxSeniaObs, lxSeniaFptovena, lxSeniaFptoven, lxSeniaFnumcompa, lxSeniaFnumcomp, lxSeniaFacttipoa, lxSeniaFacttipo, lxSeniaCoriabrev, lxSeniaCafeabrev, lxSeniaFechaa, lxSeniaFecha, lxSeniaCseriea, lxSeniaCserie, lxSeniaCversion, lxSeniaCversiona, lxSeniaCbasededat, lxSeniaCbdedata, lxSeniaCliente, lxSeniaFechavenci, lxSeniaFprecio, lxSeniaMoneda
				lxSeniaFecimpo =  .Fechaimpo			lxSeniaFmodifw =  .Fechamodificacionfw			lxSeniaFectrans =  .Fechatransferencia			lxSeniaFecexpo =  .Fechaexpo			lxSeniaFaltafw =  .Fechaaltafw			lxSeniaTasaimpint =  .Tasaimpuestointerno			lxSeniaMtoimpint =  .Montoimpuestointerno			lxSeniaMtoiva =  .Montoiva			lxSeniaPreciocisr =  .Precioconimpuestossinredondear			lxSeniaPorciva =  .Porcentajeiva			lxSeniaCondiva =  .Condicioniva			lxSeniaPreciosr =  .Preciosinredondear			lxSeniaPreciosisr =  .Preciosinimpuestossinredondear			lxSeniaPrunsinimp =  .Preciosinimpuestos			lxSeniaPrunconimp =  .Precioconimpuestos			lxSeniaAnulado =  .Anulado			lxSeniaValtafw =  .Versionaltafw			lxSeniaZadsfw =  .Zadsfw			lxSeniaDescfw =  .Descripcionfw			lxSeniaVmodifw =  .Versionmodificacionfw			lxSeniaSmodifw =  .Seriemodificacionfw			lxSeniaUmodifw =  .Usuariomodificacionfw			lxSeniaHmodifw =  .Horamodificacionfw			lxSeniaHoraimpo =  .Horaimpo			lxSeniaHaltafw =  .Horaaltafw			lxSeniaEsttrans =  .Estadotransferencia			lxSeniaHoraexpo =  .Horaexpo			lxSeniaSaltafw =  .Seriealtafw			lxSeniaUaltafw =  .Usuarioaltafw			lxSeniaCompa =  .Comprobanteafectante			lxSeniaComp =  .Comprobanteorigen			lxSeniaBdmodifw =  .Basededatosmodificacionfw			lxSeniaBdaltafw =  .Basededatosaltafw			lxSeniaCodigo =  .Codigo			lxSeniaFletraa =  .Letraafectante			lxSeniaFletra =  .Letraorigen			lxSeniaObs =  .Observacion			lxSeniaFptovena =  .Puntodeventaafectante			lxSeniaFptoven =  .Puntodeventaorigen			lxSeniaFnumcompa =  .Numeroafectante			lxSeniaFnumcomp =  .Numeroorigen			lxSeniaFacttipoa =  .Tipocomprobanteafectante			lxSeniaFacttipo =  .Tipocomprobanteorigen			lxSeniaCoriabrev =  .Tipocomprobanteorigenabreviado			lxSeniaCafeabrev =  .Tipocomprobanteafectanteabreviado			lxSeniaFechaa =  .Fechaafectante			lxSeniaFecha =  .Fechaorigen			lxSeniaCseriea =  .Cserieafectante			lxSeniaCserie =  .Cserieorigen			lxSeniaCversion =  .Cversionorigen			lxSeniaCversiona =  .Cversionafectante			lxSeniaCbasededat =  .Cbasededatosorigen			lxSeniaCbdedata =  .Cbasededatosafectante			lxSeniaCliente =  upper( .Cliente_PK ) 			lxSeniaFechavenci =  .Fechavencimiento			lxSeniaFprecio =  .Precio			lxSeniaMoneda =  upper( .Moneda_PK ) 
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.SENIA ( "Fecimpo","Fmodifw","Fectrans","Fecexpo","Faltafw","Tasaimpint","Mtoimpint","Mtoiva","Preciocisr","Porciva","Condiva","Preciosr","Preciosisr","Prunsinimp","Prunconimp","Anulado","Valtafw","Zadsfw","Descfw","Vmodifw","Smodifw","Umodifw","Hmodifw","Horaimpo","Haltafw","Esttrans","Horaexpo","Saltafw","Ualtafw","Compa","Comp","Bdmodifw","Bdaltafw","Codigo","Fletraa","Fletra","Obs","Fptovena","Fptoven","Fnumcompa","Fnumcomp","Facttipoa","Facttipo","Coriabrev","Cafeabrev","Fechaa","Fecha","Cseriea","Cserie","Cversion","Cversiona","Cbasededat","Cbdedata","Cliente","Fechavenci","Fprecio","Moneda" ) values ( <<"'" + this.ConvertirDateSql( lxSeniaFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxSeniaFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxSeniaFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxSeniaFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxSeniaFaltafw ) + "'" >>, <<lxSeniaTasaimpint >>, <<lxSeniaMtoimpint >>, <<lxSeniaMtoiva >>, <<lxSeniaPreciocisr >>, <<lxSeniaPorciva >>, <<lxSeniaCondiva >>, <<lxSeniaPreciosr >>, <<lxSeniaPreciosisr >>, <<lxSeniaPrunsinimp >>, <<lxSeniaPrunconimp >>, <<iif( lxSeniaAnulado, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxSeniaValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSeniaZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSeniaDescfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSeniaVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSeniaSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSeniaUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSeniaHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSeniaHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSeniaHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSeniaEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSeniaHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSeniaSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSeniaUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSeniaCompa ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSeniaComp ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSeniaBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSeniaBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSeniaCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSeniaFletraa ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSeniaFletra ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSeniaObs ) + "'" >>, <<lxSeniaFptovena >>, <<lxSeniaFptoven >>, <<lxSeniaFnumcompa >>, <<lxSeniaFnumcomp >>, <<lxSeniaFacttipoa >>, <<lxSeniaFacttipo >>, <<"'" + this.FormatearTextoSql( lxSeniaCoriabrev ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSeniaCafeabrev ) + "'" >>, <<"'" + this.ConvertirDateSql( lxSeniaFechaa ) + "'" >>, <<"'" + this.ConvertirDateSql( lxSeniaFecha ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSeniaCseriea ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSeniaCserie ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSeniaCversion ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSeniaCversiona ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSeniaCbasededat ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSeniaCbdedata ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSeniaCliente ) + "'" >>, <<"'" + this.ConvertirDateSql( lxSeniaFechavenci ) + "'" >>, <<lxSeniaFprecio >>, <<"'" + this.FormatearTextoSql( lxSeniaMoneda ) + "'" >> )
		endtext
		loColeccion.cTabla = 'SENIA' 
		loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		With this
			local lcValorClavePrimariaString as String
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ArticulosDetalle
				if this.oEntidad.ArticulosDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxPreciosinimpuestossinredondear = loItem.Preciosinimpuestossinredondear
					lxArticulo_condicionivaventas = loItem.Articulo_condicionivaventas
					lxTasaimpuestointerno = loItem.Tasaimpuestointerno
					lxComportamiento = loItem.Comportamiento
					lxArticulo_porcentajeivaventas = loItem.Articulo_porcentajeivaventas
					lxPrecioconimpuestossinredondear = loItem.Precioconimpuestossinredondear
					lxPreciosinredondear = loItem.Preciosinredondear
					lxPreciosinimpuestos = loItem.Preciosinimpuestos
					lxPreciounitario = loItem.Preciounitario
					lxMontoporcentajedescuentoconimpuesto = loItem.Montoporcentajedescuentoconimpuesto
					lxMontodto1 = loItem.Montodto1
					lxMontocfi = loItem.Montocfi
					lxNroitem = lnContadorNroItem
					lxPrecioconimpuestos = loItem.Precioconimpuestos
					lxPorcentajecfi = loItem.Porcentajecfi
					lxPorcentajedto1 = loItem.Porcentajedto1
					lxNoprocesarstock = loItem.Noprocesarstock
					lxCodigomotivodevolucion_PK = loItem.Codigomotivodevolucion_PK
					lxArticulo_PK = loItem.Articulo_PK
					lxCodigomotivodescuento_PK = loItem.Codigomotivodescuento_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxTalle = loItem.Talle
					lxDescuento = loItem.Descuento
					lxMontodescuento = loItem.Montodescuento
					lxCantidad = loItem.Cantidad
					lxPrecio = loItem.Precio
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.SeniaDet("PRECIOSISR","ACondIvaV","tasaimpint","COMP","APorcIvaV","PRECIOCISR","PRECIOSR","Prunsinimp","FPRUN","FCFITot","FmtoDTO1","FmtoCFI","NroItem","prunconimp","FporCFI","FporDTO1","ProcStock","MotDevol","CODIGO","FART","MotDescu","FTXT","FCOLO","FCOTXT","FTALL","FCFI","MNTDES","FCANT","FPRECIO","FMONTO" ) values ( <<lxPreciosinimpuestossinredondear>>, <<lxArticulo_condicionivaventas>>, <<lxTasaimpuestointerno>>, <<lxComportamiento>>, <<lxArticulo_porcentajeivaventas>>, <<lxPrecioconimpuestossinredondear>>, <<lxPreciosinredondear>>, <<lxPreciosinimpuestos>>, <<lxPreciounitario>>, <<lxMontoporcentajedescuentoconimpuesto>>, <<lxMontodto1>>, <<lxMontocfi>>, <<lxNroitem>>, <<lxPrecioconimpuestos>>, <<lxPorcentajecfi>>, <<lxPorcentajedto1>>, <<iif( lxNoprocesarstock, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxCodigomotivodevolucion_PK ) + "'">>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigomotivodescuento_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle ) + "'">>, <<lxDescuento>>, <<lxMontodescuento>>, <<lxCantidad>>, <<lxPrecio>>, <<lxMonto>> ) 
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
			local  lxSeniaFecimpo, lxSeniaFmodifw, lxSeniaFectrans, lxSeniaFecexpo, lxSeniaFaltafw, lxSeniaTasaimpint, lxSeniaMtoimpint, lxSeniaMtoiva, lxSeniaPreciocisr, lxSeniaPorciva, lxSeniaCondiva, lxSeniaPreciosr, lxSeniaPreciosisr, lxSeniaPrunsinimp, lxSeniaPrunconimp, lxSeniaAnulado, lxSeniaValtafw, lxSeniaZadsfw, lxSeniaDescfw, lxSeniaVmodifw, lxSeniaSmodifw, lxSeniaUmodifw, lxSeniaHmodifw, lxSeniaHoraimpo, lxSeniaHaltafw, lxSeniaEsttrans, lxSeniaHoraexpo, lxSeniaSaltafw, lxSeniaUaltafw, lxSeniaCompa, lxSeniaComp, lxSeniaBdmodifw, lxSeniaBdaltafw, lxSeniaCodigo, lxSeniaFletraa, lxSeniaFletra, lxSeniaObs, lxSeniaFptovena, lxSeniaFptoven, lxSeniaFnumcompa, lxSeniaFnumcomp, lxSeniaFacttipoa, lxSeniaFacttipo, lxSeniaCoriabrev, lxSeniaCafeabrev, lxSeniaFechaa, lxSeniaFecha, lxSeniaCseriea, lxSeniaCserie, lxSeniaCversion, lxSeniaCversiona, lxSeniaCbasededat, lxSeniaCbdedata, lxSeniaCliente, lxSeniaFechavenci, lxSeniaFprecio, lxSeniaMoneda
				lxSeniaFecimpo =  .Fechaimpo			lxSeniaFmodifw =  .Fechamodificacionfw			lxSeniaFectrans =  .Fechatransferencia			lxSeniaFecexpo =  .Fechaexpo			lxSeniaFaltafw =  .Fechaaltafw			lxSeniaTasaimpint =  .Tasaimpuestointerno			lxSeniaMtoimpint =  .Montoimpuestointerno			lxSeniaMtoiva =  .Montoiva			lxSeniaPreciocisr =  .Precioconimpuestossinredondear			lxSeniaPorciva =  .Porcentajeiva			lxSeniaCondiva =  .Condicioniva			lxSeniaPreciosr =  .Preciosinredondear			lxSeniaPreciosisr =  .Preciosinimpuestossinredondear			lxSeniaPrunsinimp =  .Preciosinimpuestos			lxSeniaPrunconimp =  .Precioconimpuestos			lxSeniaAnulado =  .Anulado			lxSeniaValtafw =  .Versionaltafw			lxSeniaZadsfw =  .Zadsfw			lxSeniaDescfw =  .Descripcionfw			lxSeniaVmodifw =  .Versionmodificacionfw			lxSeniaSmodifw =  .Seriemodificacionfw			lxSeniaUmodifw =  .Usuariomodificacionfw			lxSeniaHmodifw =  .Horamodificacionfw			lxSeniaHoraimpo =  .Horaimpo			lxSeniaHaltafw =  .Horaaltafw			lxSeniaEsttrans =  .Estadotransferencia			lxSeniaHoraexpo =  .Horaexpo			lxSeniaSaltafw =  .Seriealtafw			lxSeniaUaltafw =  .Usuarioaltafw			lxSeniaCompa =  .Comprobanteafectante			lxSeniaComp =  .Comprobanteorigen			lxSeniaBdmodifw =  .Basededatosmodificacionfw			lxSeniaBdaltafw =  .Basededatosaltafw			lxSeniaCodigo =  .Codigo			lxSeniaFletraa =  .Letraafectante			lxSeniaFletra =  .Letraorigen			lxSeniaObs =  .Observacion			lxSeniaFptovena =  .Puntodeventaafectante			lxSeniaFptoven =  .Puntodeventaorigen			lxSeniaFnumcompa =  .Numeroafectante			lxSeniaFnumcomp =  .Numeroorigen			lxSeniaFacttipoa =  .Tipocomprobanteafectante			lxSeniaFacttipo =  .Tipocomprobanteorigen			lxSeniaCoriabrev =  .Tipocomprobanteorigenabreviado			lxSeniaCafeabrev =  .Tipocomprobanteafectanteabreviado			lxSeniaFechaa =  .Fechaafectante			lxSeniaFecha =  .Fechaorigen			lxSeniaCseriea =  .Cserieafectante			lxSeniaCserie =  .Cserieorigen			lxSeniaCversion =  .Cversionorigen			lxSeniaCversiona =  .Cversionafectante			lxSeniaCbasededat =  .Cbasededatosorigen			lxSeniaCbdedata =  .Cbasededatosafectante			lxSeniaCliente =  upper( .Cliente_PK ) 			lxSeniaFechavenci =  .Fechavencimiento			lxSeniaFprecio =  .Precio			lxSeniaMoneda =  upper( .Moneda_PK ) 
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  SENIA.CODIGO != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.SENIA set "Fecimpo" = <<"'" + this.ConvertirDateSql( lxSeniaFecimpo ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxSeniaFmodifw ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxSeniaFectrans ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxSeniaFecexpo ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxSeniaFaltafw ) + "'">>, "Tasaimpint" = <<lxSeniaTasaimpint>>, "Mtoimpint" = <<lxSeniaMtoimpint>>, "Mtoiva" = <<lxSeniaMtoiva>>, "Preciocisr" = <<lxSeniaPreciocisr>>, "Porciva" = <<lxSeniaPorciva>>, "Condiva" = <<lxSeniaCondiva>>, "Preciosr" = <<lxSeniaPreciosr>>, "Preciosisr" = <<lxSeniaPreciosisr>>, "Prunsinimp" = <<lxSeniaPrunsinimp>>, "Prunconimp" = <<lxSeniaPrunconimp>>, "Anulado" = <<iif( lxSeniaAnulado, 1, 0 )>>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxSeniaValtafw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxSeniaZadsfw ) + "'">>, "Descfw" = <<"'" + this.FormatearTextoSql( lxSeniaDescfw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxSeniaVmodifw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxSeniaSmodifw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxSeniaUmodifw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxSeniaHmodifw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxSeniaHoraimpo ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxSeniaHaltafw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxSeniaEsttrans ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxSeniaHoraexpo ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxSeniaSaltafw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxSeniaUaltafw ) + "'">>, "Compa" = <<"'" + this.FormatearTextoSql( lxSeniaCompa ) + "'">>, "Comp" = <<"'" + this.FormatearTextoSql( lxSeniaComp ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxSeniaBdmodifw ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxSeniaBdaltafw ) + "'">>, "Codigo" = <<"'" + this.FormatearTextoSql( lxSeniaCodigo ) + "'">>, "Fletraa" = <<"'" + this.FormatearTextoSql( lxSeniaFletraa ) + "'">>, "Fletra" = <<"'" + this.FormatearTextoSql( lxSeniaFletra ) + "'">>, "Obs" = <<"'" + this.FormatearTextoSql( lxSeniaObs ) + "'">>, "Fptovena" = <<lxSeniaFptovena>>, "Fptoven" = <<lxSeniaFptoven>>, "Fnumcompa" = <<lxSeniaFnumcompa>>, "Fnumcomp" = <<lxSeniaFnumcomp>>, "Facttipoa" = <<lxSeniaFacttipoa>>, "Facttipo" = <<lxSeniaFacttipo>>, "Coriabrev" = <<"'" + this.FormatearTextoSql( lxSeniaCoriabrev ) + "'">>, "Cafeabrev" = <<"'" + this.FormatearTextoSql( lxSeniaCafeabrev ) + "'">>, "Fechaa" = <<"'" + this.ConvertirDateSql( lxSeniaFechaa ) + "'">>, "Fecha" = <<"'" + this.ConvertirDateSql( lxSeniaFecha ) + "'">>, "Cseriea" = <<"'" + this.FormatearTextoSql( lxSeniaCseriea ) + "'">>, "Cserie" = <<"'" + this.FormatearTextoSql( lxSeniaCserie ) + "'">>, "Cversion" = <<"'" + this.FormatearTextoSql( lxSeniaCversion ) + "'">>, "Cversiona" = <<"'" + this.FormatearTextoSql( lxSeniaCversiona ) + "'">>, "Cbasededat" = <<"'" + this.FormatearTextoSql( lxSeniaCbasededat ) + "'">>, "Cbdedata" = <<"'" + this.FormatearTextoSql( lxSeniaCbdedata ) + "'">>, "Cliente" = <<"'" + this.FormatearTextoSql( lxSeniaCliente ) + "'">>, "Fechavenci" = <<"'" + this.ConvertirDateSql( lxSeniaFechavenci ) + "'">>, "Fprecio" = <<lxSeniaFprecio>>, "Moneda" = <<"'" + this.FormatearTextoSql( lxSeniaMoneda ) + "'">> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'SENIA' 
		loColeccion.agregar( strtran(  lcSentencia, chr( 9 ), '' ) )
			loColeccion.Agregar([delete from ZooLogic.SeniaDet where "CODIGO" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ArticulosDetalle
				if this.oEntidad.ArticulosDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxPreciosinimpuestossinredondear = loItem.Preciosinimpuestossinredondear
					lxArticulo_condicionivaventas = loItem.Articulo_condicionivaventas
					lxTasaimpuestointerno = loItem.Tasaimpuestointerno
					lxComportamiento = loItem.Comportamiento
					lxArticulo_porcentajeivaventas = loItem.Articulo_porcentajeivaventas
					lxPrecioconimpuestossinredondear = loItem.Precioconimpuestossinredondear
					lxPreciosinredondear = loItem.Preciosinredondear
					lxPreciosinimpuestos = loItem.Preciosinimpuestos
					lxPreciounitario = loItem.Preciounitario
					lxMontoporcentajedescuentoconimpuesto = loItem.Montoporcentajedescuentoconimpuesto
					lxMontodto1 = loItem.Montodto1
					lxMontocfi = loItem.Montocfi
					lxNroitem = lnContadorNroItem
					lxPrecioconimpuestos = loItem.Precioconimpuestos
					lxPorcentajecfi = loItem.Porcentajecfi
					lxPorcentajedto1 = loItem.Porcentajedto1
					lxNoprocesarstock = loItem.Noprocesarstock
					lxCodigomotivodevolucion_PK = loItem.Codigomotivodevolucion_PK
					lxArticulo_PK = loItem.Articulo_PK
					lxCodigomotivodescuento_PK = loItem.Codigomotivodescuento_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxTalle = loItem.Talle
					lxDescuento = loItem.Descuento
					lxMontodescuento = loItem.Montodescuento
					lxCantidad = loItem.Cantidad
					lxPrecio = loItem.Precio
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.SeniaDet("PRECIOSISR","ACondIvaV","tasaimpint","COMP","APorcIvaV","PRECIOCISR","PRECIOSR","Prunsinimp","FPRUN","FCFITot","FmtoDTO1","FmtoCFI","NroItem","prunconimp","FporCFI","FporDTO1","ProcStock","MotDevol","CODIGO","FART","MotDescu","FTXT","FCOLO","FCOTXT","FTALL","FCFI","MNTDES","FCANT","FPRECIO","FMONTO" ) values ( <<lxPreciosinimpuestossinredondear>>, <<lxArticulo_condicionivaventas>>, <<lxTasaimpuestointerno>>, <<lxComportamiento>>, <<lxArticulo_porcentajeivaventas>>, <<lxPrecioconimpuestossinredondear>>, <<lxPreciosinredondear>>, <<lxPreciosinimpuestos>>, <<lxPreciounitario>>, <<lxMontoporcentajedescuentoconimpuesto>>, <<lxMontodto1>>, <<lxMontocfi>>, <<lxNroitem>>, <<lxPrecioconimpuestos>>, <<lxPorcentajecfi>>, <<lxPorcentajedto1>>, <<iif( lxNoprocesarstock, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxCodigomotivodevolucion_PK ) + "'">>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigomotivodescuento_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle ) + "'">>, <<lxDescuento>>, <<lxMontodescuento>>, <<lxCantidad>>, <<lxPrecio>>, <<lxMonto>> ) 
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

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  SENIA.CODIGO != '']
		loColeccion.Agregar( 'delete from ZooLogic.SENIA where ' + lcFiltro )
			loColeccion.Agregar([delete from ZooLogic.SeniaDet where "CODIGO" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.cTabla = 'SENIA' 
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
			.ArticulosDetalle.oItem.oCompStock.lNuevo = .EsNuevo()
			.ArticulosDetalle.oItem.oCompStock.lEdicion = .EsEdicion()
			.ArticulosDetalle.oItem.oCompStock.lEliminar = .lEliminar
			.ArticulosDetalle.oItem.oCompStock.lAnular = .lAnular
			loColSentencias = .ArticulosDetalle.oItem.oCompStock.grabar()
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
			lcRetorno = [update ZooLogic.SENIA set TimeStamp = ] + transform( lnTimeStamp ) + lcUpdateRealTime + [ where Codigo = ] + "'" + this.FormatearTextoSql( .Codigo ) + "'" + [ and  SENIA.CODIGO != ''] + goServicios.RealTime.ObtenerTagEstimulo( .cNombre )
		
		endwith
		return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function ObtenerCantidadRegistros() as integer
		local lnCantReg as integer
			local lcXml as string
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.SENIA where  SENIA.CODIGO != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.SENIA where Codigo = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  SENIA.CODIGO != ''" )
			this.xmlacursor( lcXml, lcCursor )
		if reccount( lcCursor ) > 0
			lnTimeStamp = &lcCursor..Timestamp
		endif
		use in select( lcCursor )

		return lnTimeStamp 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirCabecera( tlLoguear as Boolean ) As Void
		local lcCursor as String, ldFecha as Date, lcHora as string, lcValorABuscar As String, lxValorClavePK As variant, lxValorClavePrimaria As variant, lcIdentificadorParaLoguear as string, lxseniaFLETRA as variant, lxseniaFPTOVEN as variant, lxseniaFNUMCOMP as variant, lxseniaFACTTIPO as variant, lcMensajeExtra as String
		lcValorABuscar = ''
		lxValorClavePK = ''
		lcMensajeExtra = ''
		lcCursor = This.oEntidad.cPrefijoRecibir + 'SENIA'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.SENIA Where  FACTTIPO = ] + transform( &lcCursor..FACTTIPO   ) + [ and FLETRA = ] + "'" + this.FormatearTextoSql( &lcCursor..FLETRA     ) + "'" + [ and FPTOVEN = ] + transform( &lcCursor..FPTOVEN    ) + [ and FNUMCOMP = ] + transform( &lcCursor..FNUMCOMP   ), 'curSeek', this.datasessionid )
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
								this.oConexion.EjecutarSql( [UPDATE ZooLogic.SENIA set  FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, tasaimpint = ] + transform( &lcCursor..tasaimpint )+ [, mtoimpint = ] + transform( &lcCursor..mtoimpint )+ [, MtoIva = ] + transform( &lcCursor..MtoIva )+ [, PRECIOCISR = ] + transform( &lcCursor..PRECIOCISR )+ [, PorcIva = ] + transform( &lcCursor..PorcIva )+ [, CondIva = ] + transform( &lcCursor..CondIva )+ [, PRECIOSR = ] + transform( &lcCursor..PRECIOSR )+ [, PRECIOSISR = ] + transform( &lcCursor..PRECIOSISR )+ [, Prunsinimp = ] + transform( &lcCursor..Prunsinimp )+ [, prunconimp = ] + transform( &lcCursor..prunconimp )+ [, Anulado = ] + Transform( iif( &lcCursor..Anulado, 1, 0 ))+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, DescFW = ] + "'" + this.FormatearTextoSql( &lcCursor..DescFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, CompA = ] + "'" + this.FormatearTextoSql( &lcCursor..CompA ) + "'"+ [, Comp = ] + "'" + this.FormatearTextoSql( &lcCursor..Comp ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'"+ [, FLETRAA = ] + "'" + this.FormatearTextoSql( &lcCursor..FLETRAA ) + "'"+ [, FLETRA = ] + "'" + this.FormatearTextoSql( &lcCursor..FLETRA ) + "'"+ [, Obs = ] + "'" + this.FormatearTextoSql( &lcCursor..Obs ) + "'"+ [, FPTOVENA = ] + transform( &lcCursor..FPTOVENA )+ [, FPTOVEN = ] + transform( &lcCursor..FPTOVEN )+ [, FNUMCOMPA = ] + transform( &lcCursor..FNUMCOMPA )+ [, FNUMCOMP = ] + transform( &lcCursor..FNUMCOMP )+ [, FACTTIPOA = ] + transform( &lcCursor..FACTTIPOA )+ [, FACTTIPO = ] + transform( &lcCursor..FACTTIPO )+ [, COriAbrev = ] + "'" + this.FormatearTextoSql( &lcCursor..COriAbrev ) + "'"+ [, CAfeAbrev = ] + "'" + this.FormatearTextoSql( &lcCursor..CAfeAbrev ) + "'"+ [, FechaA = ] + "'" + this.ConvertirDateSql( &lcCursor..FechaA ) + "'"+ [, Fecha = ] + "'" + this.ConvertirDateSql( &lcCursor..Fecha ) + "'"+ [, CSERIEA = ] + "'" + this.FormatearTextoSql( &lcCursor..CSERIEA ) + "'"+ [, CSERIE = ] + "'" + this.FormatearTextoSql( &lcCursor..CSERIE ) + "'"+ [, CVERSION = ] + "'" + this.FormatearTextoSql( &lcCursor..CVERSION ) + "'"+ [, CVERSIONA = ] + "'" + this.FormatearTextoSql( &lcCursor..CVERSIONA ) + "'"+ [, cBaseDeDat = ] + "'" + this.FormatearTextoSql( &lcCursor..cBaseDeDat ) + "'"+ [, cBDeDatA = ] + "'" + this.FormatearTextoSql( &lcCursor..cBDeDatA ) + "'"+ [, Cliente = ] + "'" + this.FormatearTextoSql( &lcCursor..Cliente ) + "'"+ [, FechaVenci = ] + "'" + this.ConvertirDateSql( &lcCursor..FechaVenci ) + "'"+ [, FPRECIO = ] + transform( &lcCursor..FPRECIO )+ [, moneda = ] + "'" + this.FormatearTextoSql( &lcCursor..moneda ) + "'" + [ Where Codigo = ] + "'" + this.FormatearTextoSql( lcValorABuscar ) + "'" )
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
				this.oConexion.EjecutarSql( [Select * From ZooLogic.SENIA Where Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'", 'curSeek', this.datasessionid )
				if reccount( 'curSeek' ) > 0
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir como alta porque la clave principal ya existe', tlLoguear )
				Else
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					Text to lcCampos noShow
						 FECIMPO, FMODIFW, FECTRANS, FECEXPO, FALTAFW, tasaimpint, mtoimpint, MtoIva, PRECIOCISR, PorcIva, CondIva, PRECIOSR, PRECIOSISR, Prunsinimp, prunconimp, Anulado, VALTAFW, ZADSFW, DescFW, VMODIFW, SMODIFW, UMODIFW, HMODIFW, HORAIMPO, HALTAFW, ESTTRANS, HORAEXPO, SALTAFW, UALTAFW, CompA, Comp, BDMODIFW, BDALTAFW, Codigo, FLETRAA, FLETRA, Obs, FPTOVENA, FPTOVEN, FNUMCOMPA, FNUMCOMP, FACTTIPOA, FACTTIPO, COriAbrev, CAfeAbrev, FechaA, Fecha, CSERIEA, CSERIE, CVERSION, CVERSIONA, cBaseDeDat, cBDeDatA, Cliente, FechaVenci, FPRECIO, moneda
					EndText
					local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + transform( &lcCursor..tasaimpint ) + ',' + transform( &lcCursor..mtoimpint )
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..MtoIva ) + ',' + transform( &lcCursor..PRECIOCISR ) + ',' + transform( &lcCursor..PorcIva ) + ',' + transform( &lcCursor..CondIva ) + ',' + transform( &lcCursor..PRECIOSR ) + ',' + transform( &lcCursor..PRECIOSISR ) + ',' + transform( &lcCursor..Prunsinimp ) + ',' + transform( &lcCursor..prunconimp ) + ',' + Transform( iif( &lcCursor..Anulado, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..DescFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CompA ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Comp ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..FLETRAA ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..FLETRA ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Obs ) + "'" + ',' + transform( &lcCursor..FPTOVENA )
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..FPTOVEN ) + ',' + transform( &lcCursor..FNUMCOMPA ) + ',' + transform( &lcCursor..FNUMCOMP ) + ',' + transform( &lcCursor..FACTTIPOA ) + ',' + transform( &lcCursor..FACTTIPO ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..COriAbrev ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CAfeAbrev ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FechaA ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..Fecha ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CSERIEA ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CSERIE ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CVERSION ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CVERSIONA ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..cBaseDeDat ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..cBDeDatA ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..Cliente ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FechaVenci ) + "'" + ',' + transform( &lcCursor..FPRECIO ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..moneda ) + "'"
lcValoresCampos = substr(lcValoresCampos,2) 

					this.oConexion.EjecutarSql( [Insert into ZooLogic.SENIA ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
				EndIf
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'SENIA'
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
			this.oConexion.EjecutarSql( [Delete From ZooLogic.SeniaDet Where CODIGO] + lcIn  )
			endfor
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'COMMIT TRANSACTION' )
			endif
		EndIf
	endif
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMSENIAS'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where CODIGO in ( select Codigo from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"PRECIOSISR","ACondIvaV","tasaimpint","COMP","APorcIvaV","PRECIOCISR","PRECIOSR","Prunsinimp","FPRUN","FCFITot","FmtoDTO1","FmtoCFI","NroItem","prunconimp","FporCFI","FporDTO1","ProcStock","MotDevol","CODIGO","FART","MotDescu","FTXT","FCOLO","FCOTXT","FTALL","FCFI","MNTDES","FCANT","FPRECIO","FMONTO"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.SeniaDet ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.PRECIOSISR ) + ',' + transform( cDetallesExistentes.ACondIvaV  ) + ',' + transform( cDetallesExistentes.tasaimpint ) + ',' + transform( cDetallesExistentes.COMP       ) + ',' + transform( cDetallesExistentes.APorcIvaV  ) + ',' + transform( cDetallesExistentes.PRECIOCISR ) + ',' + transform( cDetallesExistentes.PRECIOSR   ) + ',' + transform( cDetallesExistentes.Prunsinimp ) + ',' + transform( cDetallesExistentes.FPRUN      ) + ',' + transform( cDetallesExistentes.FCFITot    ) + ',' + transform( cDetallesExistentes.FmtoDTO1   ) + ',' + transform( cDetallesExistentes.FmtoCFI    ) + ',' + transform( cDetallesExistentes.NroItem    ) + ',' + transform( cDetallesExistentes.prunconimp ) + ',' + transform( cDetallesExistentes.FporCFI    ) + ',' + transform( cDetallesExistentes.FporDTO1   ) + ',' + Transform( iif( cDetallesExistentes.ProcStock , 1, 0 )) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.MotDevol   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CODIGO     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.FART       ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.MotDescu   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.FTXT       ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.FCOLO      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.FCOTXT     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.FTALL      ) + "'" + ',' + transform( cDetallesExistentes.FCFI       ) + ',' + transform( cDetallesExistentes.MNTDES     ) + ',' + transform( cDetallesExistentes.FCANT      ) + ',' + transform( cDetallesExistentes.FPRECIO    ) + ',' + transform( cDetallesExistentes.FMONTO     ) + ' )'  )
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
		this.oEntidad.ArticulosDetalle.oItem.oCompStock.Recibir( this.oEntidad, 'ArticulosDetalle',this.oEntidad.cPrefijoRecibir + 'ITEMSENIAS',this.oEntidad.cPrefijoRecibir + 'SENIA')
		
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function ObtenerIdentificadorParaLoguear( tcCursor as String ) As String
		local lcRetorno as String, lnCC as String , loCC as Object, lni as Integer, lcSecuencia as String
		lcRetorno = this.oEntidad.cDescripcion 
		lcRetorno = lcRetorno + ' - Comprobante: ' + transform( &tcCursor..FLETRA     )
		lcRetorno = lcRetorno + ' - Pto. Venta: ' + transform( &tcCursor..FPTOVEN    )
		lcRetorno = lcRetorno + ' - Comprobante: ' + transform( &tcCursor..FNUMCOMP   )
		Return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EsAliasDeProceso( tcAlias As String, tcPrefijo as string ) As Boolean
		local llRetorno as Boolean, lcAlias as String, lcPrefijo As String
		llRetorno = .F.
		lcAlias = upper( alltrim( tcAlias ) )
		lcPrefijo = upper( alltrim( tcPrefijo ) )
		Do Case
			Case  lcAlias == lcPrefijo + 'SENIA'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'SENIA_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'SENIA_OBS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMSENIAS'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_senia')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'SENIA'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..Codigo
		llCondicion = isnull( lxVar ) or isnull( &lcCursor..FACTTIPO ) or isnull( &lcCursor..FLETRA ) or isnull( &lcCursor..FPTOVEN ) or isnull( &lcCursor..FNUMCOMP )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad SENIA. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'SENIA'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		select recno() as _Rec, * from &lcCursor into cursor CurConRecno
		select max( _Rec ) as Maximo,Codigo as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( Codigo, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
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
			lcCursor = This.oEntidad.cPrefijoRecibir + 'SENIA'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FechaA    
		* Validar ANTERIORES A 1/1/1753  Fecha     
		* Validar ANTERIORES A 1/1/1753  FechaVenci
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_senia') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_senia
Create Table ZooLogic.TablaTrabajo_senia ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fecimpo" datetime  null, 
"fmodifw" datetime  null, 
"fectrans" datetime  null, 
"fecexpo" datetime  null, 
"faltafw" datetime  null, 
"tasaimpint" numeric( 7, 4 )  null, 
"mtoimpint" numeric( 15, 4 )  null, 
"mtoiva" numeric( 15, 4 )  null, 
"preciocisr" numeric( 15, 6 )  null, 
"porciva" numeric( 6, 2 )  null, 
"condiva" numeric( 1, 0 )  null, 
"preciosr" numeric( 15, 6 )  null, 
"preciosisr" numeric( 15, 6 )  null, 
"prunsinimp" numeric( 15, 4 )  null, 
"prunconimp" numeric( 15, 4 )  null, 
"anulado" bit  null, 
"valtafw" char( 13 )  null, 
"zadsfw" varchar(max)  null, 
"descfw" char( 200 )  null, 
"vmodifw" char( 13 )  null, 
"smodifw" char( 7 )  null, 
"umodifw" char( 100 )  null, 
"hmodifw" char( 8 )  null, 
"horaimpo" char( 8 )  null, 
"haltafw" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"horaexpo" char( 8 )  null, 
"saltafw" char( 7 )  null, 
"ualtafw" char( 100 )  null, 
"compa" char( 38 )  null, 
"comp" char( 38 )  null, 
"bdmodifw" char( 8 )  null, 
"bdaltafw" char( 8 )  null, 
"codigo" char( 38 )  null, 
"fletraa" char( 1 )  null, 
"fletra" char( 1 )  null, 
"obs" varchar(max)  null, 
"fptovena" numeric( 4, 0 )  null, 
"fptoven" numeric( 4, 0 )  null, 
"fnumcompa" numeric( 8, 0 )  null, 
"fnumcomp" numeric( 8, 0 )  null, 
"facttipoa" numeric( 2, 0 )  null, 
"facttipo" numeric( 2, 0 )  null, 
"coriabrev" char( 3 )  null, 
"cafeabrev" char( 3 )  null, 
"fechaa" datetime  null, 
"fecha" datetime  null, 
"cseriea" char( 10 )  null, 
"cserie" char( 10 )  null, 
"cversion" char( 13 )  null, 
"cversiona" char( 13 )  null, 
"cbasededat" char( 8 )  null, 
"cbdedata" char( 8 )  null, 
"cliente" char( 5 )  null, 
"fechavenci" datetime  null, 
"fprecio" numeric( 8, 2 )  null, 
"moneda" char( 10 )  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_senia' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_senia' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'SENIA'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		with loManejador
			if this.oEntidad.VerificarContexto( 'CB' )
			else
				.AgregarMapeo('Nrolinea','Nrolinea')
			endif
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('tasaimpint','tasaimpint')
			.AgregarMapeo('mtoimpint','mtoimpint')
			.AgregarMapeo('mtoiva','mtoiva')
			.AgregarMapeo('preciocisr','preciocisr')
			.AgregarMapeo('porciva','porciva')
			.AgregarMapeo('condiva','condiva')
			.AgregarMapeo('preciosr','preciosr')
			.AgregarMapeo('preciosisr','preciosisr')
			.AgregarMapeo('prunsinimp','prunsinimp')
			.AgregarMapeo('prunconimp','prunconimp')
			.AgregarMapeo('anulado','anulado')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('descfw','descfw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('compa','compa')
			.AgregarMapeo('comp','comp')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('codigo','codigo')
			.AgregarMapeo('fletraa','fletraa')
			.AgregarMapeo('fletra','fletra')
			.AgregarMapeo('obs','obs')
			.AgregarMapeo('fptovena','fptovena')
			.AgregarMapeo('fptoven','fptoven')
			.AgregarMapeo('fnumcompa','fnumcompa')
			.AgregarMapeo('fnumcomp','fnumcomp')
			.AgregarMapeo('facttipoa','facttipoa')
			.AgregarMapeo('facttipo','facttipo')
			.AgregarMapeo('coriabrev','coriabrev')
			.AgregarMapeo('cafeabrev','cafeabrev')
			.AgregarMapeo('fechaa','fechaa')
			.AgregarMapeo('fecha','fecha')
			.AgregarMapeo('cseriea','cseriea')
			.AgregarMapeo('cserie','cserie')
			.AgregarMapeo('cversion','cversion')
			.AgregarMapeo('cversiona','cversiona')
			.AgregarMapeo('cbasededat','cbasededat')
			.AgregarMapeo('cbdedata','cbdedata')
			.AgregarMapeo('cliente','cliente')
			.AgregarMapeo('fechavenci','fechavenci')
			.AgregarMapeo('fprecio','fprecio')
			.AgregarMapeo('moneda','moneda')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_senia'
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
				Update t Set t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.TASAIMPINT = isnull( d.TASAIMPINT, t.TASAIMPINT ),t.MTOIMPINT = isnull( d.MTOIMPINT, t.MTOIMPINT ),t.MTOIVA = isnull( d.MTOIVA, t.MTOIVA ),t.PRECIOCISR = isnull( d.PRECIOCISR, t.PRECIOCISR ),t.PORCIVA = isnull( d.PORCIVA, t.PORCIVA ),t.CONDIVA = isnull( d.CONDIVA, t.CONDIVA ),t.PRECIOSR = isnull( d.PRECIOSR, t.PRECIOSR ),t.PRECIOSISR = isnull( d.PRECIOSISR, t.PRECIOSISR ),t.PRUNSINIMP = isnull( d.PRUNSINIMP, t.PRUNSINIMP ),t.PRUNCONIMP = isnull( d.PRUNCONIMP, t.PRUNCONIMP ),t.ANULADO = isnull( d.ANULADO, t.ANULADO ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.DESCFW = isnull( d.DESCFW, t.DESCFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.COMPA = isnull( d.COMPA, t.COMPA ),t.COMP = isnull( d.COMP, t.COMP ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.CODIGO = isnull( d.CODIGO, t.CODIGO ),t.FLETRAA = isnull( d.FLETRAA, t.FLETRAA ),t.FLETRA = isnull( d.FLETRA, t.FLETRA ),t.OBS = isnull( d.OBS, t.OBS ),t.FPTOVENA = isnull( d.FPTOVENA, t.FPTOVENA ),t.FPTOVEN = isnull( d.FPTOVEN, t.FPTOVEN ),t.FNUMCOMPA = isnull( d.FNUMCOMPA, t.FNUMCOMPA ),t.FNUMCOMP = isnull( d.FNUMCOMP, t.FNUMCOMP ),t.FACTTIPOA = isnull( d.FACTTIPOA, t.FACTTIPOA ),t.FACTTIPO = isnull( d.FACTTIPO, t.FACTTIPO ),t.CORIABREV = isnull( d.CORIABREV, t.CORIABREV ),t.CAFEABREV = isnull( d.CAFEABREV, t.CAFEABREV ),t.FECHAA = isnull( d.FECHAA, t.FECHAA ),t.FECHA = isnull( d.FECHA, t.FECHA ),t.CSERIEA = isnull( d.CSERIEA, t.CSERIEA ),t.CSERIE = isnull( d.CSERIE, t.CSERIE ),t.CVERSION = isnull( d.CVERSION, t.CVERSION ),t.CVERSIONA = isnull( d.CVERSIONA, t.CVERSIONA ),t.CBASEDEDAT = isnull( d.CBASEDEDAT, t.CBASEDEDAT ),t.CBDEDATA = isnull( d.CBDEDATA, t.CBDEDATA ),t.CLIENTE = isnull( d.CLIENTE, t.CLIENTE ),t.FECHAVENCI = isnull( d.FECHAVENCI, t.FECHAVENCI ),t.FPRECIO = isnull( d.FPRECIO, t.FPRECIO ),t.MONEDA = isnull( d.MONEDA, t.MONEDA )
					from ZooLogic.SENIA t inner join deleted d 
							 on t.Codigo = d.Codigo
							 and  t.FACTTIPO = d.FACTTIPO
							 and  t.FLETRA = d.FLETRA
							 and  t.FPTOVEN = d.FPTOVEN
							 and  t.FNUMCOMP = d.FNUMCOMP
				-- Fin Updates
				insert into ZooLogic.SENIA(Fecimpo,Fmodifw,Fectrans,Fecexpo,Faltafw,Tasaimpint,Mtoimpint,Mtoiva,Preciocisr,Porciva,Condiva,Preciosr,Preciosisr,Prunsinimp,Prunconimp,Anulado,Valtafw,Zadsfw,Descfw,Vmodifw,Smodifw,Umodifw,Hmodifw,Horaimpo,Haltafw,Esttrans,Horaexpo,Saltafw,Ualtafw,Compa,Comp,Bdmodifw,Bdaltafw,Codigo,Fletraa,Fletra,Obs,Fptovena,Fptoven,Fnumcompa,Fnumcomp,Facttipoa,Facttipo,Coriabrev,Cafeabrev,Fechaa,Fecha,Cseriea,Cserie,Cversion,Cversiona,Cbasededat,Cbdedata,Cliente,Fechavenci,Fprecio,Moneda)
					Select isnull( d.FECIMPO,''),isnull( d.FMODIFW,''),isnull( d.FECTRANS,''),isnull( d.FECEXPO,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.TASAIMPINT,0),isnull( d.MTOIMPINT,0),isnull( d.MTOIVA,0),isnull( d.PRECIOCISR,0),isnull( d.PORCIVA,0),isnull( d.CONDIVA,0),isnull( d.PRECIOSR,0),isnull( d.PRECIOSISR,0),isnull( d.PRUNSINIMP,0),isnull( d.PRUNCONIMP,0),isnull( d.ANULADO,0),isnull( d.VALTAFW,''),isnull( d.ZADSFW,''),isnull( d.DESCFW,''),isnull( d.VMODIFW,''),isnull( d.SMODIFW,''),isnull( d.UMODIFW,''),isnull( d.HMODIFW,''),isnull( d.HORAIMPO,''),convert( char(8), getdate(), 108 ),isnull( d.ESTTRANS,''),isnull( d.HORAEXPO,''),isnull( d.SALTAFW,''),isnull( d.UALTAFW,''),isnull( d.COMPA,''),isnull( d.COMP,''),isnull( d.BDMODIFW,''),isnull( d.BDALTAFW,''),isnull( d.CODIGO,''),isnull( d.FLETRAA,''),isnull( d.FLETRA,''),isnull( d.OBS,''),isnull( d.FPTOVENA,0),isnull( d.FPTOVEN,0),isnull( d.FNUMCOMPA,0),isnull( d.FNUMCOMP,0),isnull( d.FACTTIPOA,0),isnull( d.FACTTIPO,0),isnull( d.CORIABREV,''),isnull( d.CAFEABREV,''),isnull( d.FECHAA,''),isnull( d.FECHA,''),isnull( d.CSERIEA,''),isnull( d.CSERIE,''),isnull( d.CVERSION,''),isnull( d.CVERSIONA,''),isnull( d.CBASEDEDAT,''),isnull( d.CBDEDATA,''),isnull( d.CLIENTE,''),isnull( d.FECHAVENCI,''),isnull( d.FPRECIO,0),isnull( d.MONEDA,'')
						From deleted d left join ZooLogic.SENIA pk 
							 on d.Codigo = pk.Codigo
						 left join ZooLogic.SENIA cc 
							 on  d.FACTTIPO = cc.FACTTIPO
							 and  d.FLETRA = cc.FLETRA
							 and  d.FPTOVEN = cc.FPTOVEN
							 and  d.FNUMCOMP = cc.FNUMCOMP
						Where pk.Codigo Is Null 
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
					'<<loLogueo.UsuarioPc>>','<<loLogueo.OrigenLogueo>>','No se pudo importar la entidad <<lcEntidad>>: TIPO ' + cast( d.FACTTIPO as Varchar(2) ) + ', COMPROBANTE ' + cast( d.FLETRA as Varchar(1) ) + ', PTO. VENTA ' + cast( d.FPTOVEN as Varchar(4) ) + ', COMPROBANTE ' + cast( d.FNUMCOMP as Varchar(8) ) + '','La clave principal no es la esperada'
					from ZooLogic.SENIA t inner join deleted d 
							on   t.FACTTIPO = d.FACTTIPO
							 and  t.FLETRA = d.FLETRA
							 and  t.FPTOVEN = d.FPTOVEN
							 and  t.FNUMCOMP = d.FNUMCOMP
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
					'<<loLogueo.UsuarioPc>>','<<loLogueo.OrigenLogueo>>','No se pudo importar la entidad <<lcEntidad>>: TIPO ' + cast( d.FACTTIPO as Varchar(2) ) + ', COMPROBANTE ' + cast( d.FLETRA as Varchar(1) ) + ', PTO. VENTA ' + cast( d.FPTOVEN as Varchar(4) ) + ', COMPROBANTE ' + cast( d.FNUMCOMP as Varchar(8) ) + '','La clave principal a importar ya existe'
					from ZooLogic.SENIA t inner join deleted d 
							 on t.Codigo = d.Codigo
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
	function ObtenerTriggerDeleteImportacion_SeniaDet( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_SENIA_SeniaDet
ON ZooLogic.TablaTrabajo_SENIA_SeniaDet
AFTER DELETE
As
Begin
Update t Set 
t.PRECIOSISR = isnull( d.PRECIOSISR, t.PRECIOSISR ),
t.ACONDIVAV = isnull( d.ACONDIVAV, t.ACONDIVAV ),
t.TASAIMPINT = isnull( d.TASAIMPINT, t.TASAIMPINT ),
t.COMP = isnull( d.COMP, t.COMP ),
t.APORCIVAV = isnull( d.APORCIVAV, t.APORCIVAV ),
t.PRECIOCISR = isnull( d.PRECIOCISR, t.PRECIOCISR ),
t.PRECIOSR = isnull( d.PRECIOSR, t.PRECIOSR ),
t.PRUNSINIMP = isnull( d.PRUNSINIMP, t.PRUNSINIMP ),
t.FPRUN = isnull( d.FPRUN, t.FPRUN ),
t.FCFITOT = isnull( d.FCFITOT, t.FCFITOT ),
t.FMTODTO1 = isnull( d.FMTODTO1, t.FMTODTO1 ),
t.FMTOCFI = isnull( d.FMTOCFI, t.FMTOCFI ),
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.PRUNCONIMP = isnull( d.PRUNCONIMP, t.PRUNCONIMP ),
t.FPORCFI = isnull( d.FPORCFI, t.FPORCFI ),
t.FPORDTO1 = isnull( d.FPORDTO1, t.FPORDTO1 ),
t.PROCSTOCK = isnull( d.PROCSTOCK, t.PROCSTOCK ),
t.MOTDEVOL = isnull( d.MOTDEVOL, t.MOTDEVOL ),
t.CODIGO = isnull( d.CODIGO, t.CODIGO ),
t.FART = isnull( d.FART, t.FART ),
t.MOTDESCU = isnull( d.MOTDESCU, t.MOTDESCU ),
t.FTXT = isnull( d.FTXT, t.FTXT ),
t.FCOLO = isnull( d.FCOLO, t.FCOLO ),
t.FCOTXT = isnull( d.FCOTXT, t.FCOTXT ),
t.FTALL = isnull( d.FTALL, t.FTALL ),
t.FCFI = isnull( d.FCFI, t.FCFI ),
t.MNTDES = isnull( d.MNTDES, t.MNTDES ),
t.FCANT = isnull( d.FCANT, t.FCANT ),
t.FPRECIO = isnull( d.FPRECIO, t.FPRECIO ),
t.FMONTO = isnull( d.FMONTO, t.FMONTO )
from ZooLogic.SeniaDet t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.SeniaDet
( 
"PRECIOSISR",
"ACONDIVAV",
"TASAIMPINT",
"COMP",
"APORCIVAV",
"PRECIOCISR",
"PRECIOSR",
"PRUNSINIMP",
"FPRUN",
"FCFITOT",
"FMTODTO1",
"FMTOCFI",
"NROITEM",
"PRUNCONIMP",
"FPORCFI",
"FPORDTO1",
"PROCSTOCK",
"MOTDEVOL",
"CODIGO",
"FART",
"MOTDESCU",
"FTXT",
"FCOLO",
"FCOTXT",
"FTALL",
"FCFI",
"MNTDES",
"FCANT",
"FPRECIO",
"FMONTO"
 )
Select 
d.PRECIOSISR,
d.ACONDIVAV,
d.TASAIMPINT,
d.COMP,
d.APORCIVAV,
d.PRECIOCISR,
d.PRECIOSR,
d.PRUNSINIMP,
d.FPRUN,
d.FCFITOT,
d.FMTODTO1,
d.FMTOCFI,
d.NROITEM,
d.PRUNCONIMP,
d.FPORCFI,
d.FPORDTO1,
d.PROCSTOCK,
d.MOTDEVOL,
d.CODIGO,
d.FART,
d.MOTDESCU,
d.FTXT,
d.FCOLO,
d.FCOTXT,
d.FTALL,
d.FCFI,
d.MNTDES,
d.FCANT,
d.FPRECIO,
d.FMONTO
From deleted d left join ZooLogic.SeniaDet pk 
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_senia') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_senia
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_SENIA' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_SENIA.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_SENIA.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_SENIA.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_SENIA.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_SENIA.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Tasaimpuestointerno = nvl( c_SENIA.Tasaimpuestointerno, 0 )
					.Montoimpuestointerno = nvl( c_SENIA.Montoimpuestointerno, 0 )
					.Montoiva = nvl( c_SENIA.Montoiva, 0 )
					.Precioconimpuestossinredondear = nvl( c_SENIA.Precioconimpuestossinredondear, 0 )
					.Porcentajeiva = nvl( c_SENIA.Porcentajeiva, 0 )
					.Condicioniva = nvl( c_SENIA.Condicioniva, 0 )
					.Preciosinredondear = nvl( c_SENIA.Preciosinredondear, 0 )
					.Preciosinimpuestossinredondear = nvl( c_SENIA.Preciosinimpuestossinredondear, 0 )
					.Preciosinimpuestos = nvl( c_SENIA.Preciosinimpuestos, 0 )
					.Precioconimpuestos = nvl( c_SENIA.Precioconimpuestos, 0 )
					.Anulado = nvl( c_SENIA.Anulado, .F. )
					.Versionaltafw = nvl( c_SENIA.Versionaltafw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Descripcionfw = nvl( c_SENIA.Descripcionfw, [] )
					.Versionmodificacionfw = nvl( c_SENIA.Versionmodificacionfw, [] )
					.Seriemodificacionfw = nvl( c_SENIA.Seriemodificacionfw, [] )
					.Usuariomodificacionfw = nvl( c_SENIA.Usuariomodificacionfw, [] )
					.Horamodificacionfw = nvl( c_SENIA.Horamodificacionfw, [] )
					.Horaimpo = nvl( c_SENIA.Horaimpo, [] )
					.Horaaltafw = nvl( c_SENIA.Horaaltafw, [] )
					.Estadotransferencia = nvl( c_SENIA.Estadotransferencia, [] )
					.Horaexpo = nvl( c_SENIA.Horaexpo, [] )
					.Seriealtafw = nvl( c_SENIA.Seriealtafw, [] )
					.Usuarioaltafw = nvl( c_SENIA.Usuarioaltafw, [] )
					.Comprobanteafectante = nvl( c_SENIA.Comprobanteafectante, [] )
					.Comprobanteorigen = nvl( c_SENIA.Comprobanteorigen, [] )
					.Basededatosmodificacionfw = nvl( c_SENIA.Basededatosmodificacionfw, [] )
					.Basededatosaltafw = nvl( c_SENIA.Basededatosaltafw, [] )
					.Codigo = nvl( c_SENIA.Codigo, [] )
					.Letraafectante = nvl( c_SENIA.Letraafectante, [] )
					.Letraorigen = nvl( c_SENIA.Letraorigen, [] )
					.Articulosdetalle.Limpiar()
					.Articulosdetalle.SetearEsNavegacion( .lProcesando )
					.Articulosdetalle.Cargar()
					lcValor = This.ObtenerMemo( 'c_Observacion')
					.Observacion = lcValor 
					.Puntodeventaafectante = nvl( c_SENIA.Puntodeventaafectante, 0 )
					.Puntodeventaorigen = nvl( c_SENIA.Puntodeventaorigen, 0 )
					.Numeroafectante = nvl( c_SENIA.Numeroafectante, 0 )
					.Numeroorigen = nvl( c_SENIA.Numeroorigen, 0 )
					.Tipocomprobanteafectante = nvl( c_SENIA.Tipocomprobanteafectante, 0 )
					.Tipocomprobanteorigen = nvl( c_SENIA.Tipocomprobanteorigen, 0 )
					.Tipocomprobanteorigenabreviado = nvl( c_SENIA.Tipocomprobanteorigenabreviado, [] )
					.Tipocomprobanteafectanteabreviado = nvl( c_SENIA.Tipocomprobanteafectanteabreviado, [] )
					.Fechaafectante = GoLibrerias.ObtenerFechaFormateada( nvl( c_SENIA.Fechaafectante, ctod( '  /  /    ' ) ) )
					.Fechaorigen = GoLibrerias.ObtenerFechaFormateada( nvl( c_SENIA.Fechaorigen, ctod( '  /  /    ' ) ) )
					.Cserieafectante = nvl( c_SENIA.Cserieafectante, [] )
					.Cserieorigen = nvl( c_SENIA.Cserieorigen, [] )
					.Cversionorigen = nvl( c_SENIA.Cversionorigen, [] )
					.Cversionafectante = nvl( c_SENIA.Cversionafectante, [] )
					.Cbasededatosorigen = nvl( c_SENIA.Cbasededatosorigen, [] )
					.Cbasededatosafectante = nvl( c_SENIA.Cbasededatosafectante, [] )
					.Cliente_PK =  nvl( c_SENIA.Cliente, [] )
					.Fechavencimiento = GoLibrerias.ObtenerFechaFormateada( nvl( c_SENIA.Fechavencimiento, ctod( '  /  /    ' ) ) )
					.Precio = nvl( c_SENIA.Precio, 0 )
					.Moneda_PK =  nvl( c_SENIA.Moneda, [] )
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
			lxRetorno = c_SENIA.CODIGO
		endif
		return lxRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function ActualizarLosNROItemDeLosDetalles() as void
		local loDetalle as object, loItem as object, lnContadorNroItem as integer, lnIndex as integer
		
		loDetalle = this.oEntidad.ArticulosDetalle
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
		return c_SENIA.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.SENIA' )
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
								from ZooLogic.SENIA 
								Where   SENIA.CODIGO != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "SENIA", "", lcCursor, set("Datasession") )
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
			"Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Tasaimpint" as "Tasaimpuestointerno", "Mtoimpint" as "Montoimpuestointerno", "Mtoiva" as "Montoiva", "Preciocisr" as "Precioconimpuestossinredondear", "Porciva" as "Porcentajeiva", "Condiva" as "Condicioniva", "Preciosr" as "Preciosinredondear", "Preciosisr" as "Preciosinimpuestossinredondear", "Prunsinimp" as "Preciosinimpuestos", "Prunconimp" as "Precioconimpuestos", "Anulado" as "Anulado", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Descfw" as "Descripcionfw", "Vmodifw" as "Versionmodificacionfw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Compa" as "Comprobanteafectante", "Comp" as "Comprobanteorigen", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Codigo" as "Codigo", "Fletraa" as "Letraafectante", "Fletra" as "Letraorigen", "Obs" as "Observacion", "Fptovena" as "Puntodeventaafectante", "Fptoven" as "Puntodeventaorigen", "Fnumcompa" as "Numeroafectante", "Fnumcomp" as "Numeroorigen", "Facttipoa" as "Tipocomprobanteafectante", "Facttipo" as "Tipocomprobanteorigen", "Coriabrev" as "Tipocomprobanteorigenabreviado", "Cafeabrev" as "Tipocomprobanteafectanteabreviado", "Fechaa" as "Fechaafectante", "Fecha" as "Fechaorigen", "Cseriea" as "Cserieafectante", "Cserie" as "Cserieorigen", "Cversion" as "Cversionorigen", "Cversiona" as "Cversionafectante", "Cbasededat" as "Cbasededatosorigen", "Cbdedata" as "Cbasededatosafectante", "Cliente" as "Cliente", "Fechavenci" as "Fechavencimiento", "Fprecio" as "Precio", "Moneda" as "Moneda"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.SENIA 
								Where   SENIA.CODIGO != ''
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
	Tabla = 'SENIA'
	Filtro = " SENIA.CODIGO != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " SENIA.CODIGO != ''"
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
	<row entidad="SENIA                                   " atributo="FECHAIMPO                               " tabla="SENIA          " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SENIA                                   " atributo="FECHAMODIFICACIONFW                     " tabla="SENIA          " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SENIA                                   " atributo="FECHATRANSFERENCIA                      " tabla="SENIA          " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha transferencia                                                                                                                                             " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SENIA                                   " atributo="FECHAEXPO                               " tabla="SENIA          " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SENIA                                   " atributo="FECHAALTAFW                             " tabla="SENIA          " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SENIA                                   " atributo="TASAIMPUESTOINTERNO                     " tabla="SENIA          " campo="TASAIMPINT" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="7" decimales="4" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SENIA                                   " atributo="MONTOIMPUESTOINTERNO                    " tabla="SENIA          " campo="MTOIMPINT " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="4" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SENIA                                   " atributo="MONTOIVA                                " tabla="SENIA          " campo="MTOIVA    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="4" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SENIA                                   " atributo="PRECIOCONIMPUESTOSSINREDONDEAR          " tabla="SENIA          " campo="PRECIOCISR" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="6" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SENIA                                   " atributo="PORCENTAJEIVA                           " tabla="SENIA          " campo="PORCIVA   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="6" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SENIA                                   " atributo="CONDICIONIVA                            " tabla="SENIA          " campo="CONDIVA   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="ListaDePrecios.CondicionIva                                                                                                                                                                                                                                   " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SENIA                                   " atributo="PRECIOSINREDONDEAR                      " tabla="SENIA          " campo="PRECIOSR  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="6" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SENIA                                   " atributo="PRECIOSINIMPUESTOSSINREDONDEAR          " tabla="SENIA          " campo="PRECIOSISR" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="6" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SENIA                                   " atributo="PRECIOSINIMPUESTOS                      " tabla="SENIA          " campo="PRUNSINIMP" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="4" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SENIA                                   " atributo="PRECIOCONIMPUESTOS                      " tabla="SENIA          " campo="PRUNCONIMP" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="4" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SENIA                                   " atributo="ANULADO                                 " tabla="SENIA          " campo="ANULADO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Esta anulado                                                                                                                                                    " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SENIA                                   " atributo="VERSIONALTAFW                           " tabla="SENIA          " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SENIA                                   " atributo="ZADSFW                                  " tabla="SENIA          " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SENIA                                   " atributo="DESCRIPCIONFW                           " tabla="SENIA          " campo="DESCFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="200" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SENIA                                   " atributo="VERSIONMODIFICACIONFW                   " tabla="SENIA          " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SENIA                                   " atributo="SERIEMODIFICACIONFW                     " tabla="SENIA          " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SENIA                                   " atributo="USUARIOMODIFICACIONFW                   " tabla="SENIA          " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SENIA                                   " atributo="HORAMODIFICACIONFW                      " tabla="SENIA          " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SENIA                                   " atributo="HORAIMPO                                " tabla="SENIA          " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SENIA                                   " atributo="HORAALTAFW                              " tabla="SENIA          " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SENIA                                   " atributo="ESTADOTRANSFERENCIA                     " tabla="SENIA          " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado transferencia                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SENIA                                   " atributo="HORAEXPO                                " tabla="SENIA          " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SENIA                                   " atributo="SERIEALTAFW                             " tabla="SENIA          " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SENIA                                   " atributo="USUARIOALTAFW                           " tabla="SENIA          " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SENIA                                   " atributo="COMPROBANTEAFECTANTE                    " tabla="SENIA          " campo="COMPA     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Comprobante                                                                                                                                                     " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="3" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SENIA                                   " atributo="COMPROBANTEORIGEN                       " tabla="SENIA          " campo="COMP      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Comprobante                                                                                                                                                     " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SENIA                                   " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="SENIA          " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SENIA                                   " atributo="BASEDEDATOSALTAFW                       " tabla="SENIA          " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SENIA                                   " atributo="CODIGO                                  " tabla="SENIA          " campo="CODIGO    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="20" etiqueta="Código                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SENIA                                   " atributo="LETRAAFECTANTE                          " tabla="SENIA          " campo="FLETRAA   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="Comprobante                                                                                                                                                     " dominio="NUMEROCOMPROBANTE             " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="X 9999-99999999          " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SENIA                                   " atributo="LETRAORIGEN                             " tabla="SENIA          " campo="FLETRA    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="6" etiqueta="Comprobante                                                                                                                                                     " dominio="NUMEROCOMPROBANTE             " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="2" mascara="X 9999-99999999          " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SENIA                                   " atributo="ARTICULOSDETALLE                        " tabla="SENIADET       " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="402" etiqueta="Artículos señados                                                                                                                                               " dominio="DETALLEITEMSENIAS             " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="1" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SENIA                                   " atributo="OBSERVACION                             " tabla="SENIA          " campo="OBS       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="404" etiqueta="Observación                                                                                                                                                     " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SENIA                                   " atributo="PUNTODEVENTAAFECTANTE                   " tabla="SENIA          " campo="FPTOVENA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="4" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="406" etiqueta="Pto. Venta                                                                                                                                                      " dominio="NUMEROCOMPROBANTE             " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="X 9999-99999999          " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SENIA                                   " atributo="PUNTODEVENTAORIGEN                      " tabla="SENIA          " campo="FPTOVEN   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="4" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="8" etiqueta="Pto. Venta                                                                                                                                                      " dominio="NUMEROCOMPROBANTE             " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="3" mascara="X 9999-99999999          " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SENIA                                   " atributo="NUMEROAFECTANTE                         " tabla="SENIA          " campo="FNUMCOMPA " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="408" etiqueta="Comprobante                                                                                                                                                     " dominio="NUMEROCOMPROBANTE             " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="X 9999-99999999          " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SENIA                                   " atributo="NUMEROORIGEN                            " tabla="SENIA          " campo="FNUMCOMP  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="10" etiqueta="Comprobante                                                                                                                                                     " dominio="NUMEROCOMPROBANTE             " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="4" mascara="X 9999-99999999          " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SENIA                                   " atributo="TIPOCOMPROBANTEAFECTANTE                " tabla="SENIA          " campo="FACTTIPOA " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Tipo                                                                                                                                                            " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="3" orden="5" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SENIA                                   " atributo="TIPOCOMPROBANTEORIGEN                   " tabla="SENIA          " campo="FACTTIPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="18" etiqueta="Tipo                                                                                                                                                            " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="1" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="5" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SENIA                                   " atributo="TIPOCOMPROBANTEORIGENABREVIADO          " tabla="SENIA          " campo="CORIABREV " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="3" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="4" etiqueta="Tipo de comprobante                                                                                                                                             " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="5" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SENIA                                   " atributo="TIPOCOMPROBANTEAFECTANTEABREVIADO       " tabla="SENIA          " campo="CAFEABREV " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="3" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Tipo de comprobante                                                                                                                                             " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="5" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SENIA                                   " atributo="DESCRIPCIONTIPOCOMPROBANTEORIGEN        " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="80" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="410" etiqueta="Tipo de comprobante                                                                                                                                             " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SENIA                                   " atributo="DESCRIPCIONTIPOCOMPROBANTEAFECTANTE     " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="80" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="412" etiqueta="Tipo de comprobante                                                                                                                                             " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SENIA                                   " atributo="FECHAAFECTANTE                          " tabla="SENIA          " campo="FECHAA    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="414" etiqueta="Fecha                                                                                                                                                           " dominio="FECHACALENDARIO               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SENIA                                   " atributo="FECHAORIGEN                             " tabla="SENIA          " campo="FECHA     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="6" etiqueta="Fecha                                                                                                                                                           " dominio="FECHACALENDARIO               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SENIA                                   " atributo="CSERIEAFECTANTE                         " tabla="SENIA          " campo="CSERIEA   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="416" etiqueta="Serie                                                                                                                                                           " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SENIA                                   " atributo="CSERIEORIGEN                            " tabla="SENIA          " campo="CSERIE    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="418" etiqueta="Serie                                                                                                                                                           " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SENIA                                   " atributo="CVERSIONORIGEN                          " tabla="SENIA          " campo="CVERSION  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="420" etiqueta="Versión                                                                                                                                                         " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="8" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SENIA                                   " atributo="CVERSIONAFECTANTE                       " tabla="SENIA          " campo="CVERSIONA " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="422" etiqueta="Versión                                                                                                                                                         " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="8" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SENIA                                   " atributo="CBASEDEDATOSORIGEN                      " tabla="SENIA          " campo="CBASEDEDAT" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="424" etiqueta="Base de Datos                                                                                                                                                   " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="9" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SENIA                                   " atributo="CBASEDEDATOSAFECTANTE                   " tabla="SENIA          " campo="CBDEDATA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="426" etiqueta="Base de Datos                                                                                                                                                   " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="9" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SENIA                                   " atributo="CLIENTE                                 " tabla="SENIA          " campo="CLIENTE   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CLIENTE                                 " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="4" etiqueta="Cliente                                                                                                                                                         " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="12" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SENIA                                   " atributo="FECHAVENCIMIENTO                        " tabla="SENIA          " campo="FECHAVENCI" claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="6" etiqueta="Vencimiento                                                                                                                                                     " dominio="FECHACALENDARIO               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="14" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SENIA                                   " atributo="PRECIO                                  " tabla="SENIA          " campo="FPRECIO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="428" etiqueta="Importe                                                                                                                                                         " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="16" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SENIA                                   " atributo="MONEDA                                  " tabla="SENIA          " campo="MONEDA    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="MONEDA                                  " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="430" etiqueta="Moneda                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="17" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="NOMBRE                                  " tabla="CLI            " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="5" etiqueta="Detalle Cli.                                                                                                                                                    " dominio="TEXTOBUSQUEDA                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CLI On SENIA.CLIENTE = CLI.CLCOD And  CLI.CLCOD != ''                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MONEDA                                  " atributo="DESCRIPCION                             " tabla="MONEDA         " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="431" etiqueta="Detalle Mon.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join MONEDA On SENIA.MONEDA = MONEDA.Codigo And  MONEDA.CODIGO != ''                                                                                                                                                                                    " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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