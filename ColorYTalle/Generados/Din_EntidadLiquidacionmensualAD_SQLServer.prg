
define class Din_EntidadLIQUIDACIONMENSUALAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_LIQUIDACIONMENSUAL'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = [str( NumInt, 8, 0)]
	cExpresionCCPorCampos = [str( #tabla#.numint, 8, 0)]
	cTagClaveCandidata = '_LIQCC'
	cTagClavePk = '_LIQPK'
	cTablaPrincipal = 'LIQMENSUAL'
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
			local  lxLiqmensualFectrans, lxLiqmensualFecexpo, lxLiqmensualFecimpo, lxLiqmensualFmodifw, lxLiqmensualFaltafw, lxLiqmensualVmodifw, lxLiqmensualBdaltafw, lxLiqmensualEsttrans, lxLiqmensualBdmodifw, lxLiqmensualHmodifw, lxLiqmensualUmodifw, lxLiqmensualValtafw, lxLiqmensualZadsfw, lxLiqmensualUaltafw, lxLiqmensualSmodifw, lxLiqmensualHoraexpo, lxLiqmensualSaltafw, lxLiqmensualHoraimpo, lxLiqmensualHaltafw, lxLiqmensualFechaliq, lxLiqmensualTotalliq, lxLiqmensualOperadora, lxLiqmensualCodigo, lxLiqmensualFechadesde, lxLiqmensualNumint, lxLiqmensualTotalgrav, lxLiqmensualPtoventa, lxLiqmensualFechahasta, lxLiqmensualTotalnogra, lxLiqmensualObs, lxLiqmensualNroliq, lxLiqmensualSubtotal, lxLiqmensualIdregcta, lxLiqmensualOtrosimp, lxLiqmensualTotiva, lxLiqmensualOtroiva
				lxLiqmensualFectrans =  .Fechatransferencia			lxLiqmensualFecexpo =  .Fechaexpo			lxLiqmensualFecimpo =  .Fechaimpo			lxLiqmensualFmodifw =  .Fechamodificacionfw			lxLiqmensualFaltafw =  .Fechaaltafw			lxLiqmensualVmodifw =  .Versionmodificacionfw			lxLiqmensualBdaltafw =  .Basededatosaltafw			lxLiqmensualEsttrans =  .Estadotransferencia			lxLiqmensualBdmodifw =  .Basededatosmodificacionfw			lxLiqmensualHmodifw =  .Horamodificacionfw			lxLiqmensualUmodifw =  .Usuariomodificacionfw			lxLiqmensualValtafw =  .Versionaltafw			lxLiqmensualZadsfw =  .Zadsfw			lxLiqmensualUaltafw =  .Usuarioaltafw			lxLiqmensualSmodifw =  .Seriemodificacionfw			lxLiqmensualHoraexpo =  .Horaexpo			lxLiqmensualSaltafw =  .Seriealtafw			lxLiqmensualHoraimpo =  .Horaimpo			lxLiqmensualHaltafw =  .Horaaltafw			lxLiqmensualFechaliq =  .Fechaliq			lxLiqmensualTotalliq =  .Totalliquidacion			lxLiqmensualOperadora =  upper( .Operadora_PK ) 			lxLiqmensualCodigo =  .Codigo			lxLiqmensualFechadesde =  .Fechadesde			lxLiqmensualNumint =  .Numint			lxLiqmensualTotalgrav =  .Totalgravado			lxLiqmensualPtoventa =  .Puntodeventaliquidacion			lxLiqmensualFechahasta =  .Fechahasta			lxLiqmensualTotalnogra =  .Totalnogravado			lxLiqmensualObs =  .Obs			lxLiqmensualNroliq =  .Numeroliquidacion			lxLiqmensualSubtotal =  .Subtotal			lxLiqmensualIdregcta =  .Idregistrodecuenta			lxLiqmensualOtrosimp =  .Otrosimpuestos			lxLiqmensualTotiva =  .Totaliva			lxLiqmensualOtroiva =  .Totalotroiva
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxLiqmensualCodigo = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.LIQMENSUAL ( "Fectrans","Fecexpo","Fecimpo","Fmodifw","Faltafw","Vmodifw","Bdaltafw","Esttrans","Bdmodifw","Hmodifw","Umodifw","Valtafw","Zadsfw","Ualtafw","Smodifw","Horaexpo","Saltafw","Horaimpo","Haltafw","Fechaliq","Totalliq","Operadora","Codigo","Fechadesde","Numint","Totalgrav","Ptoventa","Fechahasta","Totalnogra","Obs","Nroliq","Subtotal","Idregcta","Otrosimp","Totiva","Otroiva" ) values ( <<"'" + this.ConvertirDateSql( lxLiqmensualFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxLiqmensualFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxLiqmensualFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxLiqmensualFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxLiqmensualFaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLiqmensualVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLiqmensualBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLiqmensualEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLiqmensualBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLiqmensualHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLiqmensualUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLiqmensualValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLiqmensualZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLiqmensualUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLiqmensualSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLiqmensualHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLiqmensualSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLiqmensualHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLiqmensualHaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxLiqmensualFechaliq ) + "'" >>, <<lxLiqmensualTotalliq >>, <<"'" + this.FormatearTextoSql( lxLiqmensualOperadora ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLiqmensualCodigo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxLiqmensualFechadesde ) + "'" >>, <<lxLiqmensualNumint >>, <<lxLiqmensualTotalgrav >>, <<lxLiqmensualPtoventa >>, <<"'" + this.ConvertirDateSql( lxLiqmensualFechahasta ) + "'" >>, <<lxLiqmensualTotalnogra >>, <<"'" + this.FormatearTextoSql( lxLiqmensualObs ) + "'" >>, <<lxLiqmensualNroliq >>, <<lxLiqmensualSubtotal >>, <<"'" + this.FormatearTextoSql( lxLiqmensualIdregcta ) + "'" >>, <<lxLiqmensualOtrosimp >>, <<lxLiqmensualTotiva >>, <<lxLiqmensualOtroiva >> )
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
			for each loItem in this.oEntidad.ImpuestosDetalle
				if this.oEntidad.ImpuestosDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxMontonogravadosindescuento = loItem.Montonogravadosindescuento
					lxNroitem = lnContadorNroItem
					lxMontonogravado = loItem.Montonogravado
					lxMontodeivasindescuento = loItem.Montodeivasindescuento
					lxPorcentajedeiva = loItem.Porcentajedeiva
					lxMontodeiva = loItem.Montodeiva
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ImpLiqMen("IVAMNGSD","NROITEM","IVAMonNG","IVAMonSD","IVAPorcent","IVAMonto","Codigo" ) values ( <<lxMontonogravadosindescuento>>, <<lxNroitem>>, <<lxMontonogravado>>, <<lxMontodeivasindescuento>>, <<lxPorcentajedeiva>>, <<lxMontodeiva>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.Conceptosgenerales
				if this.oEntidad.Conceptosgenerales.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxConcepto_PK = loItem.Concepto_PK
					lxConceptodetalle = loItem.Conceptodetalle
					lxMonto = loItem.Monto
					lxSubdiarioiva = loItem.Subdiarioiva
					lxIditemcomponente = loItem.Iditemcomponente
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.liqConMenlDet("NROITEM","codigo","Concepto","Descrip","monto","subiva","guidComp" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxConcepto_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxConceptodetalle ) + "'">>, <<lxMonto>>, <<lxSubdiarioiva>>, <<"'" + this.FormatearTextoSql( lxIditemcomponente ) + "'">> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.Conceptosdiarios
				if this.oEntidad.Conceptosdiarios.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxLiquidacion_PK = loItem.Liquidacion_PK
					lxMonto = loItem.Monto
					lxDescuento = loItem.Descuento
					lxNeto = loItem.Neto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.liqConDiaDet("NROITEM","codigo","LiqDiaria","monto","descuento","neto" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxLiquidacion_PK ) + "'">>, <<lxMonto>>, <<lxDescuento>>, <<lxNeto>> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ImpuestosComprobante
				if this.oEntidad.ImpuestosComprobante.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxCodigointerno = loItem.Codigointerno
					lxTipoimpuesto = loItem.Tipoimpuesto
					lxPorcentaje = loItem.Porcentaje
					lxMinimonoimponible = loItem.Minimonoimponible
					lxNroitem = lnContadorNroItem
					lxCodimp_PK = loItem.Codimp_PK
					lxCodimpdetalle = loItem.Codimpdetalle
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ImpLiqMenCom("codint","TipoI","porcen","minoimp","NroItem","cCod","CodImp","Descri","Monto" ) values ( <<"'" + this.FormatearTextoSql( lxCodigointerno ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipoimpuesto ) + "'">>, <<lxPorcentaje>>, <<lxMinimonoimponible>>, <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodimp_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodimpdetalle ) + "'">>, <<lxMonto>> ) 
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
			local  lxLiqmensualFectrans, lxLiqmensualFecexpo, lxLiqmensualFecimpo, lxLiqmensualFmodifw, lxLiqmensualFaltafw, lxLiqmensualVmodifw, lxLiqmensualBdaltafw, lxLiqmensualEsttrans, lxLiqmensualBdmodifw, lxLiqmensualHmodifw, lxLiqmensualUmodifw, lxLiqmensualValtafw, lxLiqmensualZadsfw, lxLiqmensualUaltafw, lxLiqmensualSmodifw, lxLiqmensualHoraexpo, lxLiqmensualSaltafw, lxLiqmensualHoraimpo, lxLiqmensualHaltafw, lxLiqmensualFechaliq, lxLiqmensualTotalliq, lxLiqmensualOperadora, lxLiqmensualCodigo, lxLiqmensualFechadesde, lxLiqmensualNumint, lxLiqmensualTotalgrav, lxLiqmensualPtoventa, lxLiqmensualFechahasta, lxLiqmensualTotalnogra, lxLiqmensualObs, lxLiqmensualNroliq, lxLiqmensualSubtotal, lxLiqmensualIdregcta, lxLiqmensualOtrosimp, lxLiqmensualTotiva, lxLiqmensualOtroiva
				lxLiqmensualFectrans =  .Fechatransferencia			lxLiqmensualFecexpo =  .Fechaexpo			lxLiqmensualFecimpo =  .Fechaimpo			lxLiqmensualFmodifw =  .Fechamodificacionfw			lxLiqmensualFaltafw =  .Fechaaltafw			lxLiqmensualVmodifw =  .Versionmodificacionfw			lxLiqmensualBdaltafw =  .Basededatosaltafw			lxLiqmensualEsttrans =  .Estadotransferencia			lxLiqmensualBdmodifw =  .Basededatosmodificacionfw			lxLiqmensualHmodifw =  .Horamodificacionfw			lxLiqmensualUmodifw =  .Usuariomodificacionfw			lxLiqmensualValtafw =  .Versionaltafw			lxLiqmensualZadsfw =  .Zadsfw			lxLiqmensualUaltafw =  .Usuarioaltafw			lxLiqmensualSmodifw =  .Seriemodificacionfw			lxLiqmensualHoraexpo =  .Horaexpo			lxLiqmensualSaltafw =  .Seriealtafw			lxLiqmensualHoraimpo =  .Horaimpo			lxLiqmensualHaltafw =  .Horaaltafw			lxLiqmensualFechaliq =  .Fechaliq			lxLiqmensualTotalliq =  .Totalliquidacion			lxLiqmensualOperadora =  upper( .Operadora_PK ) 			lxLiqmensualCodigo =  .Codigo			lxLiqmensualFechadesde =  .Fechadesde			lxLiqmensualNumint =  .Numint			lxLiqmensualTotalgrav =  .Totalgravado			lxLiqmensualPtoventa =  .Puntodeventaliquidacion			lxLiqmensualFechahasta =  .Fechahasta			lxLiqmensualTotalnogra =  .Totalnogravado			lxLiqmensualObs =  .Obs			lxLiqmensualNroliq =  .Numeroliquidacion			lxLiqmensualSubtotal =  .Subtotal			lxLiqmensualIdregcta =  .Idregistrodecuenta			lxLiqmensualOtrosimp =  .Otrosimpuestos			lxLiqmensualTotiva =  .Totaliva			lxLiqmensualOtroiva =  .Totalotroiva
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()
			lxValorClavePrimaria = .oEntidad.CODIGO
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ZooLogic.LIQMENSUAL set "Fectrans" = <<"'" + this.ConvertirDateSql( lxLiqmensualFectrans ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxLiqmensualFecexpo ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxLiqmensualFecimpo ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxLiqmensualFmodifw ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxLiqmensualFaltafw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxLiqmensualVmodifw ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxLiqmensualBdaltafw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxLiqmensualEsttrans ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxLiqmensualBdmodifw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxLiqmensualHmodifw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxLiqmensualUmodifw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxLiqmensualValtafw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxLiqmensualZadsfw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxLiqmensualUaltafw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxLiqmensualSmodifw ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxLiqmensualHoraexpo ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxLiqmensualSaltafw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxLiqmensualHoraimpo ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxLiqmensualHaltafw ) + "'">>,"Fechaliq" = <<"'" + this.ConvertirDateSql( lxLiqmensualFechaliq ) + "'">>,"Totalliq" = <<lxLiqmensualTotalliq>>,"Operadora" = <<"'" + this.FormatearTextoSql( lxLiqmensualOperadora ) + "'">>,"Codigo" = <<"'" + this.FormatearTextoSql( lxLiqmensualCodigo ) + "'">>,"Fechadesde" = <<"'" + this.ConvertirDateSql( lxLiqmensualFechadesde ) + "'">>,"Numint" = <<lxLiqmensualNumint>>,"Totalgrav" = <<lxLiqmensualTotalgrav>>,"Ptoventa" = <<lxLiqmensualPtoventa>>,"Fechahasta" = <<"'" + this.ConvertirDateSql( lxLiqmensualFechahasta ) + "'">>,"Totalnogra" = <<lxLiqmensualTotalnogra>>,"Obs" = <<"'" + this.FormatearTextoSql( lxLiqmensualObs ) + "'">>,"Nroliq" = <<lxLiqmensualNroliq>>,"Subtotal" = <<lxLiqmensualSubtotal>>,"Idregcta" = <<"'" + this.FormatearTextoSql( lxLiqmensualIdregcta ) + "'">>,"Otrosimp" = <<lxLiqmensualOtrosimp>>,"Totiva" = <<lxLiqmensualTotiva>>,"Otroiva" = <<lxLiqmensualOtroiva>> where "Codigo" = <<"'" + this.FormatearTextoSql( lxLiqmensualCodigo ) + "'">> and  LIQMENSUAL.CODIGO != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			this.ComprobarResultadoDeEjecucionDelUpdate()
		this.ComprobarTransaccion()
			.EjecutarSentencias( This.ColSentencias )
		this.ComprobarTransaccion()
			this.oConexion.EjecutarSql( 'delete from ZooLogic.ImpLiqMen where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.liqConMenlDet where "codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.liqConDiaDet where "codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.ImpLiqMenCom where "cCod" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ImpuestosDetalle
				if this.oEntidad.ImpuestosDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxMontonogravadosindescuento = loItem.Montonogravadosindescuento
					lxNroitem = lnContadorNroItem
					lxMontonogravado = loItem.Montonogravado
					lxMontodeivasindescuento = loItem.Montodeivasindescuento
					lxPorcentajedeiva = loItem.Porcentajedeiva
					lxMontodeiva = loItem.Montodeiva
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ImpLiqMen("IVAMNGSD","NROITEM","IVAMonNG","IVAMonSD","IVAPorcent","IVAMonto","Codigo" ) values ( <<lxMontonogravadosindescuento>>, <<lxNroitem>>, <<lxMontonogravado>>, <<lxMontodeivasindescuento>>, <<lxPorcentajedeiva>>, <<lxMontodeiva>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.Conceptosgenerales
				if this.oEntidad.Conceptosgenerales.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxConcepto_PK = loItem.Concepto_PK
					lxConceptodetalle = loItem.Conceptodetalle
					lxMonto = loItem.Monto
					lxSubdiarioiva = loItem.Subdiarioiva
					lxIditemcomponente = loItem.Iditemcomponente
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.liqConMenlDet("NROITEM","codigo","Concepto","Descrip","monto","subiva","guidComp" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxConcepto_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxConceptodetalle ) + "'">>, <<lxMonto>>, <<lxSubdiarioiva>>, <<"'" + this.FormatearTextoSql( lxIditemcomponente ) + "'">> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.Conceptosdiarios
				if this.oEntidad.Conceptosdiarios.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxLiquidacion_PK = loItem.Liquidacion_PK
					lxMonto = loItem.Monto
					lxDescuento = loItem.Descuento
					lxNeto = loItem.Neto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.liqConDiaDet("NROITEM","codigo","LiqDiaria","monto","descuento","neto" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxLiquidacion_PK ) + "'">>, <<lxMonto>>, <<lxDescuento>>, <<lxNeto>> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ImpuestosComprobante
				if this.oEntidad.ImpuestosComprobante.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxCodigointerno = loItem.Codigointerno
					lxTipoimpuesto = loItem.Tipoimpuesto
					lxPorcentaje = loItem.Porcentaje
					lxMinimonoimponible = loItem.Minimonoimponible
					lxNroitem = lnContadorNroItem
					lxCodimp_PK = loItem.Codimp_PK
					lxCodimpdetalle = loItem.Codimpdetalle
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ImpLiqMenCom("codint","TipoI","porcen","minoimp","NroItem","cCod","CodImp","Descri","Monto" ) values ( <<"'" + this.FormatearTextoSql( lxCodigointerno ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipoimpuesto ) + "'">>, <<lxPorcentaje>>, <<lxMinimonoimponible>>, <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodimp_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodimpdetalle ) + "'">>, <<lxMonto>> ) 
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 codigo from ZooLogic.LIQMENSUAL where " + this.ConvertirFuncionesSql( " LIQMENSUAL.CODIGO != ''" ) )
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
			Local lxLiqmensualCodigo
			lxLiqmensualCodigo = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Vmodifw" as "Versionmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Hmodifw" as "Horamodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Horaexpo" as "Horaexpo", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Fechaliq" as "Fechaliq", "Totalliq" as "Totalliquidacion", "Operadora" as "Operadora", "Codigo" as "Codigo", "Fechadesde" as "Fechadesde", "Numint" as "Numint", "Totalgrav" as "Totalgravado", "Ptoventa" as "Puntodeventaliquidacion", "Fechahasta" as "Fechahasta", "Totalnogra" as "Totalnogravado", "Obs" as "Obs", "Nroliq" as "Numeroliquidacion", "Subtotal" as "Subtotal", "Idregcta" as "Idregistrodecuenta", "Otrosimp" as "Otrosimpuestos", "Totiva" as "Totaliva", "Otroiva" as "Totalotroiva" from ZooLogic.LIQMENSUAL where "Codigo" = <<"'" + this.FormatearTextoSql( lxLiqmensualCodigo ) + "'">> and  LIQMENSUAL.CODIGO != ''
			endtext
			use in select('c_LIQUIDACIONMENSUAL')
			this.oConexion.EjecutarSql( lcSentencia, 'c_LIQUIDACIONMENSUAL', set( 'Datasession' ) )

			if reccount( 'c_LIQUIDACIONMENSUAL' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Ivamngsd" as "Montonogravadosindescuento", "Nroitem" as "Nroitem", "Ivamonng" as "Montonogravado", "Ivamonsd" as "Montodeivasindescuento", "Ivaporcent" as "Porcentajedeiva", "Ivamonto" as "Montodeiva", "Codigo" as "Codigo" from ZooLogic.ImpLiqMen where Codigo = <<"'" + this.FormatearTextoSql( c_LIQUIDACIONMENSUAL.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ImpuestosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ImpuestosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ImpuestosDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Concepto" as "Concepto", "Descrip" as "Conceptodetalle", "Monto" as "Monto", "Subiva" as "Subdiarioiva", "Guidcomp" as "Iditemcomponente" from ZooLogic.liqConMenlDet where codigo = <<"'" + this.FormatearTextoSql( c_LIQUIDACIONMENSUAL.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_Conceptosgenerales')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Conceptosgenerales', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Conceptosgenerales
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Liqdiaria" as "Liquidacion", "Monto" as "Monto", "Descuento" as "Descuento", "Neto" as "Neto" from ZooLogic.liqConDiaDet where codigo = <<"'" + this.FormatearTextoSql( c_LIQUIDACIONMENSUAL.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_Conceptosdiarios')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Conceptosdiarios', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Conceptosdiarios
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Codint" as "Codigointerno", "Tipoi" as "Tipoimpuesto", "Porcen" as "Porcentaje", "Minoimp" as "Minimonoimponible", "Nroitem" as "Nroitem", "Ccod" as "Codigo", "Codimp" as "Codimp", "Descri" as "Codimpdetalle", "Monto" as "Monto" from ZooLogic.ImpLiqMenCom where cCod = <<"'" + this.FormatearTextoSql( c_LIQUIDACIONMENSUAL.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ImpuestosComprobante')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ImpuestosComprobante', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ImpuestosComprobante
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ConsultarPorClaveCandidata() as Boolean
		local llRetorno as Boolean
		llRetorno = .t.
		with this.oEntidad
			Local lxliqMensualnumint As Variant
			lxliqMensualnumint = .NumInt
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Vmodifw" as "Versionmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Hmodifw" as "Horamodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Horaexpo" as "Horaexpo", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Fechaliq" as "Fechaliq", "Totalliq" as "Totalliquidacion", "Operadora" as "Operadora", "Codigo" as "Codigo", "Fechadesde" as "Fechadesde", "Numint" as "Numint", "Totalgrav" as "Totalgravado", "Ptoventa" as "Puntodeventaliquidacion", "Fechahasta" as "Fechahasta", "Totalnogra" as "Totalnogravado", "Obs" as "Obs", "Nroliq" as "Numeroliquidacion", "Subtotal" as "Subtotal", "Idregcta" as "Idregistrodecuenta", "Otrosimp" as "Otrosimpuestos", "Totiva" as "Totaliva", "Otroiva" as "Totalotroiva" from ZooLogic.LIQMENSUAL where  LIQMENSUAL.CODIGO != '' And numint = <<lxliqMensualnumint>>
			endtext
			use in select('c_LIQUIDACIONMENSUAL')
			this.oConexion.EjecutarSql( lcSentencia, 'c_LIQUIDACIONMENSUAL', set( 'Datasession' ) )
			if reccount( 'c_LIQUIDACIONMENSUAL' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Ivamngsd" as "Montonogravadosindescuento", "Nroitem" as "Nroitem", "Ivamonng" as "Montonogravado", "Ivamonsd" as "Montodeivasindescuento", "Ivaporcent" as "Porcentajedeiva", "Ivamonto" as "Montodeiva", "Codigo" as "Codigo" from ZooLogic.ImpLiqMen where Codigo = <<"'" + this.FormatearTextoSql( c_LIQUIDACIONMENSUAL.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ImpuestosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ImpuestosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ImpuestosDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Concepto" as "Concepto", "Descrip" as "Conceptodetalle", "Monto" as "Monto", "Subiva" as "Subdiarioiva", "Guidcomp" as "Iditemcomponente" from ZooLogic.liqConMenlDet where codigo = <<"'" + this.FormatearTextoSql( c_LIQUIDACIONMENSUAL.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_Conceptosgenerales')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Conceptosgenerales', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Conceptosgenerales
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Liqdiaria" as "Liquidacion", "Monto" as "Monto", "Descuento" as "Descuento", "Neto" as "Neto" from ZooLogic.liqConDiaDet where codigo = <<"'" + this.FormatearTextoSql( c_LIQUIDACIONMENSUAL.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_Conceptosdiarios')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Conceptosdiarios', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Conceptosdiarios
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Codint" as "Codigointerno", "Tipoi" as "Tipoimpuesto", "Porcen" as "Porcentaje", "Minoimp" as "Minimonoimponible", "Nroitem" as "Nroitem", "Ccod" as "Codigo", "Codimp" as "Codimp", "Descri" as "Codimpdetalle", "Monto" as "Monto" from ZooLogic.ImpLiqMenCom where cCod = <<"'" + this.FormatearTextoSql( c_LIQUIDACIONMENSUAL.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ImpuestosComprobante')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ImpuestosComprobante', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ImpuestosComprobante
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxLiqmensualCodigo as Variant
		llRetorno = .t.
		lxLiqmensualCodigo = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.LIQMENSUAL where "Codigo" = <<"'" + this.FormatearTextoSql( lxLiqmensualCodigo ) + "'">> and  LIQMENSUAL.CODIGO != ''
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
				lcOrden =  str( .NumInt, 8, 0)
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Vmodifw" as "Versionmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Hmodifw" as "Horamodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Horaexpo" as "Horaexpo", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Fechaliq" as "Fechaliq", "Totalliq" as "Totalliquidacion", "Operadora" as "Operadora", "Codigo" as "Codigo", "Fechadesde" as "Fechadesde", "Numint" as "Numint", "Totalgrav" as "Totalgravado", "Ptoventa" as "Puntodeventaliquidacion", "Fechahasta" as "Fechahasta", "Totalnogra" as "Totalnogravado", "Obs" as "Obs", "Nroliq" as "Numeroliquidacion", "Subtotal" as "Subtotal", "Idregcta" as "Idregistrodecuenta", "Otrosimp" as "Otrosimpuestos", "Totiva" as "Totaliva", "Otroiva" as "Totalotroiva" from ZooLogic.LIQMENSUAL where  LIQMENSUAL.CODIGO != '' order by numint
			endtext
			use in select('c_LIQUIDACIONMENSUAL')
			this.oConexion.EjecutarSql( lcSentencia, 'c_LIQUIDACIONMENSUAL', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Ivamngsd" as "Montonogravadosindescuento", "Nroitem" as "Nroitem", "Ivamonng" as "Montonogravado", "Ivamonsd" as "Montodeivasindescuento", "Ivaporcent" as "Porcentajedeiva", "Ivamonto" as "Montodeiva", "Codigo" as "Codigo" from ZooLogic.ImpLiqMen where Codigo = <<"'" + this.FormatearTextoSql( c_LIQUIDACIONMENSUAL.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ImpuestosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ImpuestosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ImpuestosDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Concepto" as "Concepto", "Descrip" as "Conceptodetalle", "Monto" as "Monto", "Subiva" as "Subdiarioiva", "Guidcomp" as "Iditemcomponente" from ZooLogic.liqConMenlDet where codigo = <<"'" + this.FormatearTextoSql( c_LIQUIDACIONMENSUAL.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_Conceptosgenerales')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Conceptosgenerales', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Conceptosgenerales
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Liqdiaria" as "Liquidacion", "Monto" as "Monto", "Descuento" as "Descuento", "Neto" as "Neto" from ZooLogic.liqConDiaDet where codigo = <<"'" + this.FormatearTextoSql( c_LIQUIDACIONMENSUAL.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_Conceptosdiarios')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Conceptosdiarios', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Conceptosdiarios
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Codint" as "Codigointerno", "Tipoi" as "Tipoimpuesto", "Porcen" as "Porcentaje", "Minoimp" as "Minimonoimponible", "Nroitem" as "Nroitem", "Ccod" as "Codigo", "Codimp" as "Codimp", "Descri" as "Codimpdetalle", "Monto" as "Monto" from ZooLogic.ImpLiqMenCom where cCod = <<"'" + this.FormatearTextoSql( c_LIQUIDACIONMENSUAL.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ImpuestosComprobante')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ImpuestosComprobante', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ImpuestosComprobante
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
				lcOrden =  str( .NumInt, 8, 0)
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Vmodifw" as "Versionmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Hmodifw" as "Horamodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Horaexpo" as "Horaexpo", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Fechaliq" as "Fechaliq", "Totalliq" as "Totalliquidacion", "Operadora" as "Operadora", "Codigo" as "Codigo", "Fechadesde" as "Fechadesde", "Numint" as "Numint", "Totalgrav" as "Totalgravado", "Ptoventa" as "Puntodeventaliquidacion", "Fechahasta" as "Fechahasta", "Totalnogra" as "Totalnogravado", "Obs" as "Obs", "Nroliq" as "Numeroliquidacion", "Subtotal" as "Subtotal", "Idregcta" as "Idregistrodecuenta", "Otrosimp" as "Otrosimpuestos", "Totiva" as "Totaliva", "Otroiva" as "Totalotroiva" from ZooLogic.LIQMENSUAL where  str( numint, 8, 0) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  LIQMENSUAL.CODIGO != '' order by numint
			endtext
			use in select('c_LIQUIDACIONMENSUAL')
			this.oConexion.EjecutarSql( lcSentencia, 'c_LIQUIDACIONMENSUAL', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Ivamngsd" as "Montonogravadosindescuento", "Nroitem" as "Nroitem", "Ivamonng" as "Montonogravado", "Ivamonsd" as "Montodeivasindescuento", "Ivaporcent" as "Porcentajedeiva", "Ivamonto" as "Montodeiva", "Codigo" as "Codigo" from ZooLogic.ImpLiqMen where Codigo = <<"'" + this.FormatearTextoSql( c_LIQUIDACIONMENSUAL.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ImpuestosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ImpuestosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ImpuestosDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Concepto" as "Concepto", "Descrip" as "Conceptodetalle", "Monto" as "Monto", "Subiva" as "Subdiarioiva", "Guidcomp" as "Iditemcomponente" from ZooLogic.liqConMenlDet where codigo = <<"'" + this.FormatearTextoSql( c_LIQUIDACIONMENSUAL.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_Conceptosgenerales')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Conceptosgenerales', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Conceptosgenerales
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Liqdiaria" as "Liquidacion", "Monto" as "Monto", "Descuento" as "Descuento", "Neto" as "Neto" from ZooLogic.liqConDiaDet where codigo = <<"'" + this.FormatearTextoSql( c_LIQUIDACIONMENSUAL.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_Conceptosdiarios')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Conceptosdiarios', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Conceptosdiarios
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Codint" as "Codigointerno", "Tipoi" as "Tipoimpuesto", "Porcen" as "Porcentaje", "Minoimp" as "Minimonoimponible", "Nroitem" as "Nroitem", "Ccod" as "Codigo", "Codimp" as "Codimp", "Descri" as "Codimpdetalle", "Monto" as "Monto" from ZooLogic.ImpLiqMenCom where cCod = <<"'" + this.FormatearTextoSql( c_LIQUIDACIONMENSUAL.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ImpuestosComprobante')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ImpuestosComprobante', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ImpuestosComprobante
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
				lcOrden =  str( .NumInt, 8, 0)
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Vmodifw" as "Versionmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Hmodifw" as "Horamodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Horaexpo" as "Horaexpo", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Fechaliq" as "Fechaliq", "Totalliq" as "Totalliquidacion", "Operadora" as "Operadora", "Codigo" as "Codigo", "Fechadesde" as "Fechadesde", "Numint" as "Numint", "Totalgrav" as "Totalgravado", "Ptoventa" as "Puntodeventaliquidacion", "Fechahasta" as "Fechahasta", "Totalnogra" as "Totalnogravado", "Obs" as "Obs", "Nroliq" as "Numeroliquidacion", "Subtotal" as "Subtotal", "Idregcta" as "Idregistrodecuenta", "Otrosimp" as "Otrosimpuestos", "Totiva" as "Totaliva", "Otroiva" as "Totalotroiva" from ZooLogic.LIQMENSUAL where  str( numint, 8, 0) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  LIQMENSUAL.CODIGO != '' order by numint desc
			endtext
			use in select('c_LIQUIDACIONMENSUAL')
			this.oConexion.EjecutarSql( lcSentencia, 'c_LIQUIDACIONMENSUAL', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Ivamngsd" as "Montonogravadosindescuento", "Nroitem" as "Nroitem", "Ivamonng" as "Montonogravado", "Ivamonsd" as "Montodeivasindescuento", "Ivaporcent" as "Porcentajedeiva", "Ivamonto" as "Montodeiva", "Codigo" as "Codigo" from ZooLogic.ImpLiqMen where Codigo = <<"'" + this.FormatearTextoSql( c_LIQUIDACIONMENSUAL.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ImpuestosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ImpuestosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ImpuestosDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Concepto" as "Concepto", "Descrip" as "Conceptodetalle", "Monto" as "Monto", "Subiva" as "Subdiarioiva", "Guidcomp" as "Iditemcomponente" from ZooLogic.liqConMenlDet where codigo = <<"'" + this.FormatearTextoSql( c_LIQUIDACIONMENSUAL.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_Conceptosgenerales')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Conceptosgenerales', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Conceptosgenerales
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Liqdiaria" as "Liquidacion", "Monto" as "Monto", "Descuento" as "Descuento", "Neto" as "Neto" from ZooLogic.liqConDiaDet where codigo = <<"'" + this.FormatearTextoSql( c_LIQUIDACIONMENSUAL.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_Conceptosdiarios')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Conceptosdiarios', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Conceptosdiarios
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Codint" as "Codigointerno", "Tipoi" as "Tipoimpuesto", "Porcen" as "Porcentaje", "Minoimp" as "Minimonoimponible", "Nroitem" as "Nroitem", "Ccod" as "Codigo", "Codimp" as "Codimp", "Descri" as "Codimpdetalle", "Monto" as "Monto" from ZooLogic.ImpLiqMenCom where cCod = <<"'" + this.FormatearTextoSql( c_LIQUIDACIONMENSUAL.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ImpuestosComprobante')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ImpuestosComprobante', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ImpuestosComprobante
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
				lcOrden =  str( .NumInt, 8, 0)
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Vmodifw" as "Versionmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Hmodifw" as "Horamodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Horaexpo" as "Horaexpo", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Fechaliq" as "Fechaliq", "Totalliq" as "Totalliquidacion", "Operadora" as "Operadora", "Codigo" as "Codigo", "Fechadesde" as "Fechadesde", "Numint" as "Numint", "Totalgrav" as "Totalgravado", "Ptoventa" as "Puntodeventaliquidacion", "Fechahasta" as "Fechahasta", "Totalnogra" as "Totalnogravado", "Obs" as "Obs", "Nroliq" as "Numeroliquidacion", "Subtotal" as "Subtotal", "Idregcta" as "Idregistrodecuenta", "Otrosimp" as "Otrosimpuestos", "Totiva" as "Totaliva", "Otroiva" as "Totalotroiva" from ZooLogic.LIQMENSUAL where  LIQMENSUAL.CODIGO != '' order by numint desc
			endtext
			use in select('c_LIQUIDACIONMENSUAL')
			this.oConexion.EjecutarSql( lcSentencia, 'c_LIQUIDACIONMENSUAL', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Ivamngsd" as "Montonogravadosindescuento", "Nroitem" as "Nroitem", "Ivamonng" as "Montonogravado", "Ivamonsd" as "Montodeivasindescuento", "Ivaporcent" as "Porcentajedeiva", "Ivamonto" as "Montodeiva", "Codigo" as "Codigo" from ZooLogic.ImpLiqMen where Codigo = <<"'" + this.FormatearTextoSql( c_LIQUIDACIONMENSUAL.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ImpuestosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ImpuestosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ImpuestosDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Concepto" as "Concepto", "Descrip" as "Conceptodetalle", "Monto" as "Monto", "Subiva" as "Subdiarioiva", "Guidcomp" as "Iditemcomponente" from ZooLogic.liqConMenlDet where codigo = <<"'" + this.FormatearTextoSql( c_LIQUIDACIONMENSUAL.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_Conceptosgenerales')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Conceptosgenerales', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Conceptosgenerales
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Liqdiaria" as "Liquidacion", "Monto" as "Monto", "Descuento" as "Descuento", "Neto" as "Neto" from ZooLogic.liqConDiaDet where codigo = <<"'" + this.FormatearTextoSql( c_LIQUIDACIONMENSUAL.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_Conceptosdiarios')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Conceptosdiarios', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Conceptosdiarios
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Codint" as "Codigointerno", "Tipoi" as "Tipoimpuesto", "Porcen" as "Porcentaje", "Minoimp" as "Minimonoimponible", "Nroitem" as "Nroitem", "Ccod" as "Codigo", "Codimp" as "Codimp", "Descri" as "Codimpdetalle", "Monto" as "Monto" from ZooLogic.ImpLiqMenCom where cCod = <<"'" + this.FormatearTextoSql( c_LIQUIDACIONMENSUAL.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ImpuestosComprobante')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ImpuestosComprobante', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ImpuestosComprobante
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
			lcXml = this.oConexion.EjecutarSql( "select Fectrans,Fecexpo,Fecimpo,Fmodifw,Faltafw,Vmodifw,Bdaltafw,Esttrans,Bdmodifw,Hmodifw,Umodifw," + ;
"Valtafw,Zadsfw,Ualtafw,Smodifw,Horaexpo,Saltafw,Horaimpo,Haltafw,Fechaliq,Totalliq,Operadora,Codigo," + ;
"Fechadesde,Numint,Totalgrav,Ptoventa,Fechahasta,Totalnogra,Obs,Nroliq,Subtotal,Idregcta,Otrosimp,Tot" + ;
"iva,Otroiva" + ;
" from ZooLogic.LIQMENSUAL where  LIQMENSUAL.CODIGO != '' and " + lcFiltro )
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
			local  lxLiqmensualFectrans, lxLiqmensualFecexpo, lxLiqmensualFecimpo, lxLiqmensualFmodifw, lxLiqmensualFaltafw, lxLiqmensualVmodifw, lxLiqmensualBdaltafw, lxLiqmensualEsttrans, lxLiqmensualBdmodifw, lxLiqmensualHmodifw, lxLiqmensualUmodifw, lxLiqmensualValtafw, lxLiqmensualZadsfw, lxLiqmensualUaltafw, lxLiqmensualSmodifw, lxLiqmensualHoraexpo, lxLiqmensualSaltafw, lxLiqmensualHoraimpo, lxLiqmensualHaltafw, lxLiqmensualFechaliq, lxLiqmensualTotalliq, lxLiqmensualOperadora, lxLiqmensualCodigo, lxLiqmensualFechadesde, lxLiqmensualNumint, lxLiqmensualTotalgrav, lxLiqmensualPtoventa, lxLiqmensualFechahasta, lxLiqmensualTotalnogra, lxLiqmensualObs, lxLiqmensualNroliq, lxLiqmensualSubtotal, lxLiqmensualIdregcta, lxLiqmensualOtrosimp, lxLiqmensualTotiva, lxLiqmensualOtroiva
				lxLiqmensualFectrans = ctod( '  /  /    ' )			lxLiqmensualFecexpo = ctod( '  /  /    ' )			lxLiqmensualFecimpo = ctod( '  /  /    ' )			lxLiqmensualFmodifw = ctod( '  /  /    ' )			lxLiqmensualFaltafw = ctod( '  /  /    ' )			lxLiqmensualVmodifw = []			lxLiqmensualBdaltafw = []			lxLiqmensualEsttrans = []			lxLiqmensualBdmodifw = []			lxLiqmensualHmodifw = []			lxLiqmensualUmodifw = []			lxLiqmensualValtafw = []			lxLiqmensualZadsfw = []			lxLiqmensualUaltafw = []			lxLiqmensualSmodifw = []			lxLiqmensualHoraexpo = []			lxLiqmensualSaltafw = []			lxLiqmensualHoraimpo = []			lxLiqmensualHaltafw = []			lxLiqmensualFechaliq = ctod( '  /  /    ' )			lxLiqmensualTotalliq = 0			lxLiqmensualOperadora = []			lxLiqmensualCodigo = []			lxLiqmensualFechadesde = ctod( '  /  /    ' )			lxLiqmensualNumint = 0			lxLiqmensualTotalgrav = 0			lxLiqmensualPtoventa = 0			lxLiqmensualFechahasta = ctod( '  /  /    ' )			lxLiqmensualTotalnogra = 0			lxLiqmensualObs = []			lxLiqmensualNroliq = 0			lxLiqmensualSubtotal = 0			lxLiqmensualIdregcta = []			lxLiqmensualOtrosimp = 0			lxLiqmensualTotiva = 0			lxLiqmensualOtroiva = 0
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.ImpLiqMen where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.liqConMenlDet where "codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.liqConDiaDet where "codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.ImpLiqMenCom where "cCod" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( [delete from ZooLogic.LIQMENSUAL where "codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'LIQMENSUAL' + '_' + tcCampo
			lcMemoAscii = ''

			lnIndice = alen(.aSqlMemos)
			lnIndice = iif(lnIndice = 1, 1, lnIndice + 1 )
			dimension .aSqlMemos(lnIndice)

			.aSqlMemos(lnIndice) = 'delete from ' + lcTabla + ' where codigo = ' + txValorClavePrimaria
			.GenerarSentenciasInsertTablaMemo( lcValor, lcTabla, txValorClavePrimaria )
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerSentenciaInsertMemo( tcTabla as String, txValorClavePrimaria as String, tcOrden as String, tcTexto as String ) as String
		return "Insert  into " + tcTabla + "(codigo, Orden, texto ) values ( " + txValorClavePrimaria + "," + tcOrden + ",'"+ tcTexto + "')"
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosEntidad( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  LIQMENSUAL.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Vmodifw" as "Versionmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Hmodifw" as "Horamodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Horaexpo" as "Horaexpo", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Fechaliq" as "Fechaliq", "Totalliq" as "Totalliquidacion", "Operadora" as "Operadora", "Codigo" as "Codigo", "Fechadesde" as "Fechadesde", "Numint" as "Numint", "Totalgrav" as "Totalgravado", "Ptoventa" as "Puntodeventaliquidacion", "Fechahasta" as "Fechahasta", "Totalnogra" as "Totalnogravado", "Obs" as "Obs", "Nroliq" as "Numeroliquidacion", "Subtotal" as "Subtotal", "Idregcta" as "Idregistrodecuenta", "Otrosimp" as "Otrosimpuestos", "Totiva" as "Totaliva", "Otroiva" as "Totalotroiva"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'LIQMENSUAL', '', tnTope )
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
	Function ObtenerDatosDetalleImpuestosDetalle( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  IMPLIQMEN.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Ivamngsd" as "Montonogravadosindescuento", "Nroitem" as "Nroitem", "Ivamonng" as "Montonogravado", "Ivamonsd" as "Montodeivasindescuento", "Ivaporcent" as "Porcentajedeiva", "Ivamonto" as "Montodeiva", "Codigo" as "Codigo"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleImpuestosDetalle( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'ImpLiqMen', 'ImpuestosDetalle', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleImpuestosDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleImpuestosDetalle( lcAtributo )
		endfor
		lcSelect = substr( lcSelect, 2 )
		return lcSelect
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosDetalleConceptosgenerales( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  LIQCONMENLDET.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Nroitem" as "Nroitem", "Codigo" as "Codigo", "Concepto" as "Concepto", "Descrip" as "Conceptodetalle", "Monto" as "Monto", "Subiva" as "Subdiarioiva", "Guidcomp" as "Iditemcomponente"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleConceptosgenerales( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'liqConMenlDet', 'Conceptosgenerales', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleConceptosgenerales( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleConceptosgenerales( lcAtributo )
		endfor
		lcSelect = substr( lcSelect, 2 )
		return lcSelect
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosDetalleConceptosdiarios( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  LIQCONDIADET.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Nroitem" as "Nroitem", "Codigo" as "Codigo", "Liqdiaria" as "Liquidacion", "Monto" as "Monto", "Descuento" as "Descuento", "Neto" as "Neto"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleConceptosdiarios( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'liqConDiaDet', 'Conceptosdiarios', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleConceptosdiarios( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleConceptosdiarios( lcAtributo )
		endfor
		lcSelect = substr( lcSelect, 2 )
		return lcSelect
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosDetalleImpuestosComprobante( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  IMPLIQMENCOM.CCOD != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Codint" as "Codigointerno", "Tipoi" as "Tipoimpuesto", "Porcen" as "Porcentaje", "Minoimp" as "Minimonoimponible", "Nroitem" as "Nroitem", "Ccod" as "Codigo", "Codimp" as "Codimp", "Descri" as "Codimpdetalle", "Monto" as "Monto"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleImpuestosComprobante( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'ImpLiqMenCom', 'ImpuestosComprobante', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleImpuestosComprobante( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleImpuestosComprobante( lcAtributo )
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
				Case lcAtributo == 'FECHAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECIMPO AS FECHAIMPO'
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'FECHALIQ'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHALIQ AS FECHALIQ'
				Case lcAtributo == 'TOTALLIQUIDACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TOTALLIQ AS TOTALLIQUIDACION'
				Case lcAtributo == 'OPERADORA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'OPERADORA AS OPERADORA'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'FECHADESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHADESDE AS FECHADESDE'
				Case lcAtributo == 'NUMINT'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NUMINT AS NUMINT'
				Case lcAtributo == 'TOTALGRAVADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TOTALGRAV AS TOTALGRAVADO'
				Case lcAtributo == 'PUNTODEVENTALIQUIDACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PTOVENTA AS PUNTODEVENTALIQUIDACION'
				Case lcAtributo == 'FECHAHASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHAHASTA AS FECHAHASTA'
				Case lcAtributo == 'TOTALNOGRAVADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TOTALNOGRA AS TOTALNOGRAVADO'
				Case lcAtributo == 'OBS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'OBS AS OBS'
				Case lcAtributo == 'NUMEROLIQUIDACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROLIQ AS NUMEROLIQUIDACION'
				Case lcAtributo == 'SUBTOTAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SUBTOTAL AS SUBTOTAL'
				Case lcAtributo == 'IDREGISTRODECUENTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDREGCTA AS IDREGISTRODECUENTA'
				Case lcAtributo == 'OTROSIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'OTROSIMP AS OTROSIMPUESTOS'
				Case lcAtributo == 'TOTALIVA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TOTIVA AS TOTALIVA'
				Case lcAtributo == 'TOTALOTROIVA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'OTROIVA AS TOTALOTROIVA'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleImpuestosDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'MONTONOGRAVADOSINDESCUENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IVAMNGSD AS MONTONOGRAVADOSINDESCUENTO'
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'MONTONOGRAVADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IVAMONNG AS MONTONOGRAVADO'
				Case lcAtributo == 'MONTODEIVASINDESCUENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IVAMONSD AS MONTODEIVASINDESCUENTO'
				Case lcAtributo == 'PORCENTAJEDEIVA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IVAPORCENT AS PORCENTAJEDEIVA'
				Case lcAtributo == 'MONTODEIVA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IVAMONTO AS MONTODEIVA'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleConceptosgenerales( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'CONCEPTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CONCEPTO AS CONCEPTO'
				Case lcAtributo == 'CONCEPTODETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCRIP AS CONCEPTODETALLE'
				Case lcAtributo == 'MONTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONTO AS MONTO'
				Case lcAtributo == 'SUBDIARIOIVA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SUBIVA AS SUBDIARIOIVA'
				Case lcAtributo == 'IDITEMCOMPONENTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'GUIDCOMP AS IDITEMCOMPONENTE'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleConceptosdiarios( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'LIQUIDACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LIQDIARIA AS LIQUIDACION'
				Case lcAtributo == 'MONTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONTO AS MONTO'
				Case lcAtributo == 'DESCUENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCUENTO AS DESCUENTO'
				Case lcAtributo == 'NETO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NETO AS NETO'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleImpuestosComprobante( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'CODIGOINTERNO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODINT AS CODIGOINTERNO'
				Case lcAtributo == 'TIPOIMPUESTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPOI AS TIPOIMPUESTO'
				Case lcAtributo == 'PORCENTAJE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PORCEN AS PORCENTAJE'
				Case lcAtributo == 'MINIMONOIMPONIBLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MINOIMP AS MINIMONOIMPONIBLE'
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CCOD AS CODIGO'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEXPO'
				lcCampo = 'FECEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAIMPO'
				lcCampo = 'FECIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHALIQ'
				lcCampo = 'FECHALIQ'
			Case upper( alltrim( tcAtributo ) ) == 'TOTALLIQUIDACION'
				lcCampo = 'TOTALLIQ'
			Case upper( alltrim( tcAtributo ) ) == 'OPERADORA'
				lcCampo = 'OPERADORA'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHADESDE'
				lcCampo = 'FECHADESDE'
			Case upper( alltrim( tcAtributo ) ) == 'NUMINT'
				lcCampo = 'NUMINT'
			Case upper( alltrim( tcAtributo ) ) == 'TOTALGRAVADO'
				lcCampo = 'TOTALGRAV'
			Case upper( alltrim( tcAtributo ) ) == 'PUNTODEVENTALIQUIDACION'
				lcCampo = 'PTOVENTA'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAHASTA'
				lcCampo = 'FECHAHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'TOTALNOGRAVADO'
				lcCampo = 'TOTALNOGRA'
			Case upper( alltrim( tcAtributo ) ) == 'OBS'
				lcCampo = 'OBS'
			Case upper( alltrim( tcAtributo ) ) == 'NUMEROLIQUIDACION'
				lcCampo = 'NROLIQ'
			Case upper( alltrim( tcAtributo ) ) == 'SUBTOTAL'
				lcCampo = 'SUBTOTAL'
			Case upper( alltrim( tcAtributo ) ) == 'IDREGISTRODECUENTA'
				lcCampo = 'IDREGCTA'
			Case upper( alltrim( tcAtributo ) ) == 'OTROSIMPUESTOS'
				lcCampo = 'OTROSIMP'
			Case upper( alltrim( tcAtributo ) ) == 'TOTALIVA'
				lcCampo = 'TOTIVA'
			Case upper( alltrim( tcAtributo ) ) == 'TOTALOTROIVA'
				lcCampo = 'OTROIVA'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleImpuestosDetalle( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'MONTONOGRAVADOSINDESCUENTO'
				lcCampo = 'IVAMNGSD'
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'MONTONOGRAVADO'
				lcCampo = 'IVAMONNG'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODEIVASINDESCUENTO'
				lcCampo = 'IVAMONSD'
			Case upper( alltrim( tcAtributo ) ) == 'PORCENTAJEDEIVA'
				lcCampo = 'IVAPORCENT'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODEIVA'
				lcCampo = 'IVAMONTO'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleConceptosgenerales( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'CONCEPTO'
				lcCampo = 'CONCEPTO'
			Case upper( alltrim( tcAtributo ) ) == 'CONCEPTODETALLE'
				lcCampo = 'DESCRIP'
			Case upper( alltrim( tcAtributo ) ) == 'MONTO'
				lcCampo = 'MONTO'
			Case upper( alltrim( tcAtributo ) ) == 'SUBDIARIOIVA'
				lcCampo = 'SUBIVA'
			Case upper( alltrim( tcAtributo ) ) == 'IDITEMCOMPONENTE'
				lcCampo = 'GUIDCOMP'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleConceptosdiarios( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'LIQUIDACION'
				lcCampo = 'LIQDIARIA'
			Case upper( alltrim( tcAtributo ) ) == 'MONTO'
				lcCampo = 'MONTO'
			Case upper( alltrim( tcAtributo ) ) == 'DESCUENTO'
				lcCampo = 'DESCUENTO'
			Case upper( alltrim( tcAtributo ) ) == 'NETO'
				lcCampo = 'NETO'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleImpuestosComprobante( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'CODIGOINTERNO'
				lcCampo = 'CODINT'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOIMPUESTO'
				lcCampo = 'TIPOI'
			Case upper( alltrim( tcAtributo ) ) == 'PORCENTAJE'
				lcCampo = 'PORCEN'
			Case upper( alltrim( tcAtributo ) ) == 'MINIMONOIMPONIBLE'
				lcCampo = 'MINOIMP'
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CCOD'
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
		if upper( alltrim( tcDetalle ) ) == 'IMPUESTOSDETALLE'
			lcRetorno = 'IMPLIQMEN'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'CONCEPTOSGENERALES'
			lcRetorno = 'LIQCONMENLDET'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'CONCEPTOSDIARIOS'
			lcRetorno = 'LIQCONDIADET'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'IMPUESTOSCOMPROBANTE'
			lcRetorno = 'IMPLIQMENCOM'
		EndIf
		return lcRetorno
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasInsert() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcSentencia as string, loItem as object
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxLiqmensualFectrans, lxLiqmensualFecexpo, lxLiqmensualFecimpo, lxLiqmensualFmodifw, lxLiqmensualFaltafw, lxLiqmensualVmodifw, lxLiqmensualBdaltafw, lxLiqmensualEsttrans, lxLiqmensualBdmodifw, lxLiqmensualHmodifw, lxLiqmensualUmodifw, lxLiqmensualValtafw, lxLiqmensualZadsfw, lxLiqmensualUaltafw, lxLiqmensualSmodifw, lxLiqmensualHoraexpo, lxLiqmensualSaltafw, lxLiqmensualHoraimpo, lxLiqmensualHaltafw, lxLiqmensualFechaliq, lxLiqmensualTotalliq, lxLiqmensualOperadora, lxLiqmensualCodigo, lxLiqmensualFechadesde, lxLiqmensualNumint, lxLiqmensualTotalgrav, lxLiqmensualPtoventa, lxLiqmensualFechahasta, lxLiqmensualTotalnogra, lxLiqmensualObs, lxLiqmensualNroliq, lxLiqmensualSubtotal, lxLiqmensualIdregcta, lxLiqmensualOtrosimp, lxLiqmensualTotiva, lxLiqmensualOtroiva
				lxLiqmensualFectrans =  .Fechatransferencia			lxLiqmensualFecexpo =  .Fechaexpo			lxLiqmensualFecimpo =  .Fechaimpo			lxLiqmensualFmodifw =  .Fechamodificacionfw			lxLiqmensualFaltafw =  .Fechaaltafw			lxLiqmensualVmodifw =  .Versionmodificacionfw			lxLiqmensualBdaltafw =  .Basededatosaltafw			lxLiqmensualEsttrans =  .Estadotransferencia			lxLiqmensualBdmodifw =  .Basededatosmodificacionfw			lxLiqmensualHmodifw =  .Horamodificacionfw			lxLiqmensualUmodifw =  .Usuariomodificacionfw			lxLiqmensualValtafw =  .Versionaltafw			lxLiqmensualZadsfw =  .Zadsfw			lxLiqmensualUaltafw =  .Usuarioaltafw			lxLiqmensualSmodifw =  .Seriemodificacionfw			lxLiqmensualHoraexpo =  .Horaexpo			lxLiqmensualSaltafw =  .Seriealtafw			lxLiqmensualHoraimpo =  .Horaimpo			lxLiqmensualHaltafw =  .Horaaltafw			lxLiqmensualFechaliq =  .Fechaliq			lxLiqmensualTotalliq =  .Totalliquidacion			lxLiqmensualOperadora =  upper( .Operadora_PK ) 			lxLiqmensualCodigo =  .Codigo			lxLiqmensualFechadesde =  .Fechadesde			lxLiqmensualNumint =  .Numint			lxLiqmensualTotalgrav =  .Totalgravado			lxLiqmensualPtoventa =  .Puntodeventaliquidacion			lxLiqmensualFechahasta =  .Fechahasta			lxLiqmensualTotalnogra =  .Totalnogravado			lxLiqmensualObs =  .Obs			lxLiqmensualNroliq =  .Numeroliquidacion			lxLiqmensualSubtotal =  .Subtotal			lxLiqmensualIdregcta =  .Idregistrodecuenta			lxLiqmensualOtrosimp =  .Otrosimpuestos			lxLiqmensualTotiva =  .Totaliva			lxLiqmensualOtroiva =  .Totalotroiva
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.LIQMENSUAL ( "Fectrans","Fecexpo","Fecimpo","Fmodifw","Faltafw","Vmodifw","Bdaltafw","Esttrans","Bdmodifw","Hmodifw","Umodifw","Valtafw","Zadsfw","Ualtafw","Smodifw","Horaexpo","Saltafw","Horaimpo","Haltafw","Fechaliq","Totalliq","Operadora","Codigo","Fechadesde","Numint","Totalgrav","Ptoventa","Fechahasta","Totalnogra","Obs","Nroliq","Subtotal","Idregcta","Otrosimp","Totiva","Otroiva" ) values ( <<"'" + this.ConvertirDateSql( lxLiqmensualFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxLiqmensualFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxLiqmensualFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxLiqmensualFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxLiqmensualFaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLiqmensualVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLiqmensualBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLiqmensualEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLiqmensualBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLiqmensualHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLiqmensualUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLiqmensualValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLiqmensualZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLiqmensualUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLiqmensualSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLiqmensualHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLiqmensualSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLiqmensualHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLiqmensualHaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxLiqmensualFechaliq ) + "'" >>, <<lxLiqmensualTotalliq >>, <<"'" + this.FormatearTextoSql( lxLiqmensualOperadora ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLiqmensualCodigo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxLiqmensualFechadesde ) + "'" >>, <<lxLiqmensualNumint >>, <<lxLiqmensualTotalgrav >>, <<lxLiqmensualPtoventa >>, <<"'" + this.ConvertirDateSql( lxLiqmensualFechahasta ) + "'" >>, <<lxLiqmensualTotalnogra >>, <<"'" + this.FormatearTextoSql( lxLiqmensualObs ) + "'" >>, <<lxLiqmensualNroliq >>, <<lxLiqmensualSubtotal >>, <<"'" + this.FormatearTextoSql( lxLiqmensualIdregcta ) + "'" >>, <<lxLiqmensualOtrosimp >>, <<lxLiqmensualTotiva >>, <<lxLiqmensualOtroiva >> )
		endtext
		loColeccion.cTabla = 'LIQMENSUAL' 
		loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		With this
			local lcValorClavePrimariaString as String
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ImpuestosDetalle
				if this.oEntidad.ImpuestosDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxMontonogravadosindescuento = loItem.Montonogravadosindescuento
					lxNroitem = lnContadorNroItem
					lxMontonogravado = loItem.Montonogravado
					lxMontodeivasindescuento = loItem.Montodeivasindescuento
					lxPorcentajedeiva = loItem.Porcentajedeiva
					lxMontodeiva = loItem.Montodeiva
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ImpLiqMen("IVAMNGSD","NROITEM","IVAMonNG","IVAMonSD","IVAPorcent","IVAMonto","Codigo" ) values ( <<lxMontonogravadosindescuento>>, <<lxNroitem>>, <<lxMontonogravado>>, <<lxMontodeivasindescuento>>, <<lxPorcentajedeiva>>, <<lxMontodeiva>>, << lcValorClavePrimariaString >> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.Conceptosgenerales
				if this.oEntidad.Conceptosgenerales.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxConcepto_PK = loItem.Concepto_PK
					lxConceptodetalle = loItem.Conceptodetalle
					lxMonto = loItem.Monto
					lxSubdiarioiva = loItem.Subdiarioiva
					lxIditemcomponente = loItem.Iditemcomponente
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.liqConMenlDet("NROITEM","codigo","Concepto","Descrip","monto","subiva","guidComp" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxConcepto_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxConceptodetalle ) + "'">>, <<lxMonto>>, <<lxSubdiarioiva>>, <<"'" + this.FormatearTextoSql( lxIditemcomponente ) + "'">> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.Conceptosdiarios
				if this.oEntidad.Conceptosdiarios.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxLiquidacion_PK = loItem.Liquidacion_PK
					lxMonto = loItem.Monto
					lxDescuento = loItem.Descuento
					lxNeto = loItem.Neto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.liqConDiaDet("NROITEM","codigo","LiqDiaria","monto","descuento","neto" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxLiquidacion_PK ) + "'">>, <<lxMonto>>, <<lxDescuento>>, <<lxNeto>> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ImpuestosComprobante
				if this.oEntidad.ImpuestosComprobante.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxCodigointerno = loItem.Codigointerno
					lxTipoimpuesto = loItem.Tipoimpuesto
					lxPorcentaje = loItem.Porcentaje
					lxMinimonoimponible = loItem.Minimonoimponible
					lxNroitem = lnContadorNroItem
					lxCodimp_PK = loItem.Codimp_PK
					lxCodimpdetalle = loItem.Codimpdetalle
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ImpLiqMenCom("codint","TipoI","porcen","minoimp","NroItem","cCod","CodImp","Descri","Monto" ) values ( <<"'" + this.FormatearTextoSql( lxCodigointerno ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipoimpuesto ) + "'">>, <<lxPorcentaje>>, <<lxMinimonoimponible>>, <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxCodimp_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodimpdetalle ) + "'">>, <<lxMonto>> ) 
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
			local  lxLiqmensualFectrans, lxLiqmensualFecexpo, lxLiqmensualFecimpo, lxLiqmensualFmodifw, lxLiqmensualFaltafw, lxLiqmensualVmodifw, lxLiqmensualBdaltafw, lxLiqmensualEsttrans, lxLiqmensualBdmodifw, lxLiqmensualHmodifw, lxLiqmensualUmodifw, lxLiqmensualValtafw, lxLiqmensualZadsfw, lxLiqmensualUaltafw, lxLiqmensualSmodifw, lxLiqmensualHoraexpo, lxLiqmensualSaltafw, lxLiqmensualHoraimpo, lxLiqmensualHaltafw, lxLiqmensualFechaliq, lxLiqmensualTotalliq, lxLiqmensualOperadora, lxLiqmensualCodigo, lxLiqmensualFechadesde, lxLiqmensualNumint, lxLiqmensualTotalgrav, lxLiqmensualPtoventa, lxLiqmensualFechahasta, lxLiqmensualTotalnogra, lxLiqmensualObs, lxLiqmensualNroliq, lxLiqmensualSubtotal, lxLiqmensualIdregcta, lxLiqmensualOtrosimp, lxLiqmensualTotiva, lxLiqmensualOtroiva
				lxLiqmensualFectrans =  .Fechatransferencia			lxLiqmensualFecexpo =  .Fechaexpo			lxLiqmensualFecimpo =  .Fechaimpo			lxLiqmensualFmodifw =  .Fechamodificacionfw			lxLiqmensualFaltafw =  .Fechaaltafw			lxLiqmensualVmodifw =  .Versionmodificacionfw			lxLiqmensualBdaltafw =  .Basededatosaltafw			lxLiqmensualEsttrans =  .Estadotransferencia			lxLiqmensualBdmodifw =  .Basededatosmodificacionfw			lxLiqmensualHmodifw =  .Horamodificacionfw			lxLiqmensualUmodifw =  .Usuariomodificacionfw			lxLiqmensualValtafw =  .Versionaltafw			lxLiqmensualZadsfw =  .Zadsfw			lxLiqmensualUaltafw =  .Usuarioaltafw			lxLiqmensualSmodifw =  .Seriemodificacionfw			lxLiqmensualHoraexpo =  .Horaexpo			lxLiqmensualSaltafw =  .Seriealtafw			lxLiqmensualHoraimpo =  .Horaimpo			lxLiqmensualHaltafw =  .Horaaltafw			lxLiqmensualFechaliq =  .Fechaliq			lxLiqmensualTotalliq =  .Totalliquidacion			lxLiqmensualOperadora =  upper( .Operadora_PK ) 			lxLiqmensualCodigo =  .Codigo			lxLiqmensualFechadesde =  .Fechadesde			lxLiqmensualNumint =  .Numint			lxLiqmensualTotalgrav =  .Totalgravado			lxLiqmensualPtoventa =  .Puntodeventaliquidacion			lxLiqmensualFechahasta =  .Fechahasta			lxLiqmensualTotalnogra =  .Totalnogravado			lxLiqmensualObs =  .Obs			lxLiqmensualNroliq =  .Numeroliquidacion			lxLiqmensualSubtotal =  .Subtotal			lxLiqmensualIdregcta =  .Idregistrodecuenta			lxLiqmensualOtrosimp =  .Otrosimpuestos			lxLiqmensualTotiva =  .Totaliva			lxLiqmensualOtroiva =  .Totalotroiva
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  LIQMENSUAL.CODIGO != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.LIQMENSUAL set "Fectrans" = <<"'" + this.ConvertirDateSql( lxLiqmensualFectrans ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxLiqmensualFecexpo ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxLiqmensualFecimpo ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxLiqmensualFmodifw ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxLiqmensualFaltafw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxLiqmensualVmodifw ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxLiqmensualBdaltafw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxLiqmensualEsttrans ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxLiqmensualBdmodifw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxLiqmensualHmodifw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxLiqmensualUmodifw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxLiqmensualValtafw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxLiqmensualZadsfw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxLiqmensualUaltafw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxLiqmensualSmodifw ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxLiqmensualHoraexpo ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxLiqmensualSaltafw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxLiqmensualHoraimpo ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxLiqmensualHaltafw ) + "'">>, "Fechaliq" = <<"'" + this.ConvertirDateSql( lxLiqmensualFechaliq ) + "'">>, "Totalliq" = <<lxLiqmensualTotalliq>>, "Operadora" = <<"'" + this.FormatearTextoSql( lxLiqmensualOperadora ) + "'">>, "Codigo" = <<"'" + this.FormatearTextoSql( lxLiqmensualCodigo ) + "'">>, "Fechadesde" = <<"'" + this.ConvertirDateSql( lxLiqmensualFechadesde ) + "'">>, "Numint" = <<lxLiqmensualNumint>>, "Totalgrav" = <<lxLiqmensualTotalgrav>>, "Ptoventa" = <<lxLiqmensualPtoventa>>, "Fechahasta" = <<"'" + this.ConvertirDateSql( lxLiqmensualFechahasta ) + "'">>, "Totalnogra" = <<lxLiqmensualTotalnogra>>, "Obs" = <<"'" + this.FormatearTextoSql( lxLiqmensualObs ) + "'">>, "Nroliq" = <<lxLiqmensualNroliq>>, "Subtotal" = <<lxLiqmensualSubtotal>>, "Idregcta" = <<"'" + this.FormatearTextoSql( lxLiqmensualIdregcta ) + "'">>, "Otrosimp" = <<lxLiqmensualOtrosimp>>, "Totiva" = <<lxLiqmensualTotiva>>, "Otroiva" = <<lxLiqmensualOtroiva>> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'LIQMENSUAL' 
		loColeccion.agregar( strtran(  lcSentencia, chr( 9 ), '' ) )
			loColeccion.Agregar([delete from ZooLogic.ImpLiqMen where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.liqConMenlDet where "codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.liqConDiaDet where "codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.ImpLiqMenCom where "cCod" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ImpuestosDetalle
				if this.oEntidad.ImpuestosDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxMontonogravadosindescuento = loItem.Montonogravadosindescuento
					lxNroitem = lnContadorNroItem
					lxMontonogravado = loItem.Montonogravado
					lxMontodeivasindescuento = loItem.Montodeivasindescuento
					lxPorcentajedeiva = loItem.Porcentajedeiva
					lxMontodeiva = loItem.Montodeiva
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ImpLiqMen("IVAMNGSD","NROITEM","IVAMonNG","IVAMonSD","IVAPorcent","IVAMonto","Codigo" ) values ( <<lxMontonogravadosindescuento>>, <<lxNroitem>>, <<lxMontonogravado>>, <<lxMontodeivasindescuento>>, <<lxPorcentajedeiva>>, <<lxMontodeiva>>, << lcValorClavePrimariaString >> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.Conceptosgenerales
				if this.oEntidad.Conceptosgenerales.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxConcepto_PK = loItem.Concepto_PK
					lxConceptodetalle = loItem.Conceptodetalle
					lxMonto = loItem.Monto
					lxSubdiarioiva = loItem.Subdiarioiva
					lxIditemcomponente = loItem.Iditemcomponente
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.liqConMenlDet("NROITEM","codigo","Concepto","Descrip","monto","subiva","guidComp" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxConcepto_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxConceptodetalle ) + "'">>, <<lxMonto>>, <<lxSubdiarioiva>>, <<"'" + this.FormatearTextoSql( lxIditemcomponente ) + "'">> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.Conceptosdiarios
				if this.oEntidad.Conceptosdiarios.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxLiquidacion_PK = loItem.Liquidacion_PK
					lxMonto = loItem.Monto
					lxDescuento = loItem.Descuento
					lxNeto = loItem.Neto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.liqConDiaDet("NROITEM","codigo","LiqDiaria","monto","descuento","neto" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxLiquidacion_PK ) + "'">>, <<lxMonto>>, <<lxDescuento>>, <<lxNeto>> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ImpuestosComprobante
				if this.oEntidad.ImpuestosComprobante.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxCodigointerno = loItem.Codigointerno
					lxTipoimpuesto = loItem.Tipoimpuesto
					lxPorcentaje = loItem.Porcentaje
					lxMinimonoimponible = loItem.Minimonoimponible
					lxNroitem = lnContadorNroItem
					lxCodimp_PK = loItem.Codimp_PK
					lxCodimpdetalle = loItem.Codimpdetalle
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ImpLiqMenCom("codint","TipoI","porcen","minoimp","NroItem","cCod","CodImp","Descri","Monto" ) values ( <<"'" + this.FormatearTextoSql( lxCodigointerno ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipoimpuesto ) + "'">>, <<lxPorcentaje>>, <<lxMinimonoimponible>>, <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxCodimp_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodimpdetalle ) + "'">>, <<lxMonto>> ) 
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

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  LIQMENSUAL.CODIGO != '']
		loColeccion.Agregar( 'delete from ZooLogic.LIQMENSUAL where ' + lcFiltro )
			loColeccion.Agregar([delete from ZooLogic.ImpLiqMen where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.liqConMenlDet where "codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.liqConDiaDet where "codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.ImpLiqMenCom where "cCod" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.cTabla = 'LIQMENSUAL' 
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
		
			.oCompCuentabancarialiquidacionmensual.lNuevo = .EsNuevo()
			.oCompCuentabancarialiquidacionmensual.lEdicion = .EsEdicion()
			.oCompCuentabancarialiquidacionmensual.lEliminar = .lEliminar
			.oCompCuentabancarialiquidacionmensual.lAnular = .lAnular
			loColSentencias = .oCompCuentabancarialiquidacionmensual.grabar()
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
			lcRetorno = [update ZooLogic.LIQMENSUAL set TimeStamp = ] + transform( lnTimeStamp ) + lcUpdateRealTime + [ where codigo = ] + "'" + this.FormatearTextoSql( .Codigo ) + "'" + [ and  LIQMENSUAL.CODIGO != ''] + goServicios.RealTime.ObtenerTagEstimulo( .cNombre )
		
		endwith
		return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function ObtenerCantidadRegistros() as integer
		local lnCantReg as integer
			local lcXml as string
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.LIQMENSUAL where  LIQMENSUAL.CODIGO != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.LIQMENSUAL where codigo = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  LIQMENSUAL.CODIGO != ''" )
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
					if empty( .oNumeraciones.ObtenerServicio('NUMINT') ) and iif( type( '.NUMINT' ) = 'C', int( val( .NUMINT ) ),.NUMINT ) = .oNumeraciones.UltimoNumero( 'NUMINT' )
						.oNumeraciones.Actualizar( 'NUMINT' )
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
					.NUMINT = .oNumeraciones.grabar( 'NUMINT' )
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
		local lcCursor as String, ldFecha as Date, lcHora as string, lcValorABuscar As String, lxValorClavePK As variant, lxValorClavePrimaria As variant, lcIdentificadorParaLoguear as string, lxliqMensualnumint as variant, lcMensajeExtra as String
		lcValorABuscar = ''
		lxValorClavePK = ''
		lcMensajeExtra = ''
		lcCursor = This.oEntidad.cPrefijoRecibir + 'LIQUIDACIONMENSUAL'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.LIQMENSUAL Where  numint = ] + transform( &lcCursor..numint     ), 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				lxValorClavePK = &lcCursor..codigo
				if lxValorClavePK == curSeek.codigo or this.oEntidad.lIgnorarClaveprimariaEnRecepcionBD 
					if lxValorClavePK != curSeek.codigo and this.oEntidad.lIgnorarClaveprimariaEnRecepcionBD 
						lcValorABuscar = curSeek.codigo
					else 
						lcValorABuscar = lxValorClavePK 
					endif 
					if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
						Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
						this.oConexion.EjecutarSql( [UPDATE ZooLogic.LIQMENSUAL set  FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, fechaliq = ] + "'" + this.ConvertirDateSql( &lcCursor..fechaliq ) + "'"+ [, TotalLiq = ] + transform( &lcCursor..TotalLiq )+ [, operadora = ] + "'" + this.FormatearTextoSql( &lcCursor..operadora ) + "'"+ [, codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..codigo ) + "'"+ [, fechadesde = ] + "'" + this.ConvertirDateSql( &lcCursor..fechadesde ) + "'"+ [, numint = ] + transform( &lcCursor..numint )+ [, TotalGrav = ] + transform( &lcCursor..TotalGrav )+ [, ptoventa = ] + transform( &lcCursor..ptoventa )+ [, fechahasta = ] + "'" + this.ConvertirDateSql( &lcCursor..fechahasta ) + "'"+ [, TotalNoGra = ] + transform( &lcCursor..TotalNoGra )+ [, Obs = ] + "'" + this.FormatearTextoSql( &lcCursor..Obs ) + "'"+ [, nroliq = ] + transform( &lcCursor..nroliq )+ [, SubTotal = ] + transform( &lcCursor..SubTotal )+ [, IdRegCta = ] + "'" + this.FormatearTextoSql( &lcCursor..IdRegCta ) + "'"+ [, OtrosImp = ] + transform( &lcCursor..OtrosImp )+ [, totiva = ] + transform( &lcCursor..totiva )+ [, OtroIva = ] + transform( &lcCursor..OtroIva ) + [ Where codigo = ] + "'" + this.FormatearTextoSql( lcValorABuscar ) + "'" )
						this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
					else
						this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
					endIf
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir porque no coincide la clave principal.', tlLoguear )
				endIf
			else
				this.oConexion.EjecutarSql( [Select * From ZooLogic.LIQMENSUAL Where codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..codigo ) + "'", 'curSeek', this.datasessionid )
				if reccount( 'curSeek' ) > 0
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir como alta porque la clave principal ya existe', tlLoguear )
				Else
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					Text to lcCampos noShow
						 FECTRANS, FECEXPO, FECIMPO, FMODIFW, FALTAFW, VMODIFW, BDALTAFW, ESTTRANS, BDMODIFW, HMODIFW, UMODIFW, VALTAFW, ZADSFW, UALTAFW, SMODIFW, HORAEXPO, SALTAFW, HORAIMPO, HALTAFW, fechaliq, TotalLiq, operadora, codigo, fechadesde, numint, TotalGrav, ptoventa, fechahasta, TotalNoGra, Obs, nroliq, SubTotal, IdRegCta, OtrosImp, totiva, OtroIva
					EndText
					local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..fechaliq ) + "'" + ',' + transform( &lcCursor..TotalLiq )
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..operadora ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..codigo ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..fechadesde ) + "'" + ',' + transform( &lcCursor..numint ) + ',' + transform( &lcCursor..TotalGrav ) + ',' + transform( &lcCursor..ptoventa ) + ',' + "'" + this.ConvertirDateSql( &lcCursor..fechahasta ) + "'" + ',' + transform( &lcCursor..TotalNoGra )
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..Obs ) + "'" + ',' + transform( &lcCursor..nroliq ) + ',' + transform( &lcCursor..SubTotal ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..IdRegCta ) + "'" + ',' + transform( &lcCursor..OtrosImp ) + ',' + transform( &lcCursor..totiva ) + ',' + transform( &lcCursor..OtroIva )
lcValoresCampos = substr(lcValoresCampos,2) 

					this.oConexion.EjecutarSql( [Insert into ZooLogic.LIQMENSUAL ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
				EndIf
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'LIQUIDACIONMENSUAL'
		if This.ActualizaEnRecepcion()
		Local lcIn as String, lcCantRegistros as Integer
		Select( lcCursor )
		Count to lcCantRegistros
		If lcCantRegistros > 0
			lcIn = This.ObtenerInSqlServer( lcCursor, 'codigo','C')
			lnFragmento = goRegistry.nucleo.cantidadDeElementosEnSentenciaInSQL
			loIn = this.ObtenerColeccionInSqlServer( lcCursor,'','codigo')
			llEjecutaEnTransaccion = loIn.count > 0
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'BEGIN TRANSACTION' )
			endif
			for i = 1 to loIn.count step lnFragmento
				lcIn = this.ObtenerFragmentoColeccionInSqlServer( loIn, i, lnFragmento )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.ImpLiqMen Where Codigo] + lcIn  )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.liqConMenlDet Where codigo] + lcIn  )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.liqConDiaDet Where codigo] + lcIn  )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.ImpLiqMenCom Where cCod] + lcIn  )
			endfor
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'COMMIT TRANSACTION' )
			endif
		EndIf
	endif
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMIMPUESTOSLIQ'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where Codigo in ( select codigo from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"IVAMNGSD","NROITEM","IVAMonNG","IVAMonSD","IVAPorcent","IVAMonto","Codigo"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.ImpLiqMen ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.IVAMNGSD   ) + ',' + transform( cDetallesExistentes.NROITEM    ) + ',' + transform( cDetallesExistentes.IVAMonNG   ) + ',' + transform( cDetallesExistentes.IVAMonSD   ) + ',' + transform( cDetallesExistentes.IVAPorcent ) + ',' + transform( cDetallesExistentes.IVAMonto   ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Codigo     ) + "'" + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMLIQGENERAL'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where codigo in ( select codigo from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"NROITEM","codigo","Concepto","Descrip","monto","subiva","guidComp"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.liqConMenlDet ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.codigo     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Concepto   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Descrip    ) + "'" + ',' + transform( cDetallesExistentes.monto      ) + ',' + transform( cDetallesExistentes.subiva     ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.guidComp   ) + "'" + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMLIQDIARIA'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where codigo in ( select codigo from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"NROITEM","codigo","LiqDiaria","monto","descuento","neto"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.liqConDiaDet ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.codigo     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.LiqDiaria  ) + "'" + ',' + transform( cDetallesExistentes.monto      ) + ',' + transform( cDetallesExistentes.descuento  ) + ',' + transform( cDetallesExistentes.neto       ) + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMIMPUESTOSLIQCOM'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where cCod in ( select codigo from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"codint","TipoI","porcen","minoimp","NroItem","cCod","CodImp","Descri","Monto"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.ImpLiqMenCom ( ] + lcCamposInsert + [ ) values ( ] +  "'" + this.FormatearTextoSql( cDetallesExistentes.codint     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.TipoI      ) + "'" + ',' + transform( cDetallesExistentes.porcen     ) + ',' + transform( cDetallesExistentes.minoimp    ) + ',' + transform( cDetallesExistentes.NroItem    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.cCod       ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CodImp     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Descri     ) + "'" + ',' + transform( cDetallesExistentes.Monto      ) + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	Use in select( 'cExistentes' )
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearCursorMemo( tcCursorACrear as String, tcTablaConMemo as String ) as Void
		create cursor &tcCursorACrear ( codigo C (38) , Orden N(16), texto C(80))
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirComponentes() As Void
		
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function ObtenerIdentificadorParaLoguear( tcCursor as String ) As String
		local lcRetorno as String, lnCC as String , loCC as Object, lni as Integer, lcSecuencia as String
		lcRetorno = this.oEntidad.cDescripcion 
		lcRetorno = lcRetorno + ' - Número interno: ' + transform( &tcCursor..numint     )
		Return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EsAliasDeProceso( tcAlias As String, tcPrefijo as string ) As Boolean
		local llRetorno as Boolean, lcAlias as String, lcPrefijo As String
		llRetorno = .F.
		lcAlias = upper( alltrim( tcAlias ) )
		lcPrefijo = upper( alltrim( tcPrefijo ) )
		Do Case
			Case  lcAlias == lcPrefijo + 'LIQUIDACIONMENSUAL'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'LIQUIDACIONMENSUAL_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'LIQUIDACIONMENSUAL_OBS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMIMPUESTOSLIQ'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMLIQGENERAL'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMLIQDIARIA'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMIMPUESTOSLIQCOM'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_liqMensual')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'LIQUIDACIONMENSUAL'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..codigo
		llCondicion = isnull( lxVar ) or isnull( &lcCursor..numint )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad LIQUIDACIONMENSUAL. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'LIQUIDACIONMENSUAL'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		select recno() as _Rec, * from &lcCursor into cursor CurConRecno
		select max( _Rec ) as Maximo,codigo as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( codigo, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		select max( _Rec ) as Maximo,str( numint, 8, 0) as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( str( numint, 8, 0), 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		Use in select( 'CurConRecno' )
		Use in select( 'RepMax' )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDatosInvalidos( toConexion as Object ) as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'LIQUIDACIONMENSUAL'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  fechaliq  
		* Validar ANTERIORES A 1/1/1753  fechadesde
		* Validar ANTERIORES A 1/1/1753  fechahasta
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_liqMensual') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_liqMensual
Create Table ZooLogic.TablaTrabajo_liqMensual ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fectrans" datetime  null, 
"fecexpo" datetime  null, 
"fecimpo" datetime  null, 
"fmodifw" datetime  null, 
"faltafw" datetime  null, 
"vmodifw" char( 13 )  null, 
"bdaltafw" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"bdmodifw" char( 8 )  null, 
"hmodifw" char( 8 )  null, 
"umodifw" char( 100 )  null, 
"valtafw" char( 13 )  null, 
"zadsfw" varchar(max)  null, 
"ualtafw" char( 100 )  null, 
"smodifw" char( 7 )  null, 
"horaexpo" char( 8 )  null, 
"saltafw" char( 7 )  null, 
"horaimpo" char( 8 )  null, 
"haltafw" char( 8 )  null, 
"fechaliq" datetime  null, 
"totalliq" numeric( 15, 2 )  null, 
"operadora" char( 15 )  null, 
"codigo" char( 38 )  null, 
"fechadesde" datetime  null, 
"numint" numeric( 8, 0 )  null, 
"totalgrav" numeric( 15, 2 )  null, 
"ptoventa" numeric( 4, 0 )  null, 
"fechahasta" datetime  null, 
"totalnogra" numeric( 15, 2 )  null, 
"obs" varchar(max)  null, 
"nroliq" numeric( 15, 0 )  null, 
"subtotal" numeric( 15, 2 )  null, 
"idregcta" char( 20 )  null, 
"otrosimp" numeric( 15, 2 )  null, 
"totiva" numeric( 15, 2 )  null, 
"otroiva" numeric( 15, 2 )  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_liqMensual' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_liqMensual' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'LIQUIDACIONMENSUAL'
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
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('fechaliq','fechaliq')
			.AgregarMapeo('totalliq','totalliq')
			.AgregarMapeo('operadora','operadora')
			.AgregarMapeo('codigo','codigo')
			.AgregarMapeo('fechadesde','fechadesde')
			.AgregarMapeo('numint','numint')
			.AgregarMapeo('totalgrav','totalgrav')
			.AgregarMapeo('ptoventa','ptoventa')
			.AgregarMapeo('fechahasta','fechahasta')
			.AgregarMapeo('totalnogra','totalnogra')
			.AgregarMapeo('obs','obs')
			.AgregarMapeo('nroliq','nroliq')
			.AgregarMapeo('subtotal','subtotal')
			.AgregarMapeo('idregcta','idregcta')
			.AgregarMapeo('otrosimp','otrosimp')
			.AgregarMapeo('totiva','totiva')
			.AgregarMapeo('otroiva','otroiva')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_liqMensual'
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
				Update t Set t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.FECHALIQ = isnull( d.FECHALIQ, t.FECHALIQ ),t.TOTALLIQ = isnull( d.TOTALLIQ, t.TOTALLIQ ),t.OPERADORA = isnull( d.OPERADORA, t.OPERADORA ),t.CODIGO = isnull( d.CODIGO, t.CODIGO ),t.FECHADESDE = isnull( d.FECHADESDE, t.FECHADESDE ),t.NUMINT = isnull( d.NUMINT, t.NUMINT ),t.TOTALGRAV = isnull( d.TOTALGRAV, t.TOTALGRAV ),t.PTOVENTA = isnull( d.PTOVENTA, t.PTOVENTA ),t.FECHAHASTA = isnull( d.FECHAHASTA, t.FECHAHASTA ),t.TOTALNOGRA = isnull( d.TOTALNOGRA, t.TOTALNOGRA ),t.OBS = isnull( d.OBS, t.OBS ),t.NROLIQ = isnull( d.NROLIQ, t.NROLIQ ),t.SUBTOTAL = isnull( d.SUBTOTAL, t.SUBTOTAL ),t.IDREGCTA = isnull( d.IDREGCTA, t.IDREGCTA ),t.OTROSIMP = isnull( d.OTROSIMP, t.OTROSIMP ),t.TOTIVA = isnull( d.TOTIVA, t.TOTIVA ),t.OTROIVA = isnull( d.OTROIVA, t.OTROIVA )
					from ZooLogic.LIQMENSUAL t inner join deleted d 
							 on t.codigo = d.codigo
							 and  t.numint = d.numint
				-- Fin Updates
				insert into ZooLogic.LIQMENSUAL(Fectrans,Fecexpo,Fecimpo,Fmodifw,Faltafw,Vmodifw,Bdaltafw,Esttrans,Bdmodifw,Hmodifw,Umodifw,Valtafw,Zadsfw,Ualtafw,Smodifw,Horaexpo,Saltafw,Horaimpo,Haltafw,Fechaliq,Totalliq,Operadora,Codigo,Fechadesde,Numint,Totalgrav,Ptoventa,Fechahasta,Totalnogra,Obs,Nroliq,Subtotal,Idregcta,Otrosimp,Totiva,Otroiva)
					Select isnull( d.FECTRANS,''),isnull( d.FECEXPO,''),isnull( d.FECIMPO,''),isnull( d.FMODIFW,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.VMODIFW,''),isnull( d.BDALTAFW,''),isnull( d.ESTTRANS,''),isnull( d.BDMODIFW,''),isnull( d.HMODIFW,''),isnull( d.UMODIFW,''),isnull( d.VALTAFW,''),isnull( d.ZADSFW,''),isnull( d.UALTAFW,''),isnull( d.SMODIFW,''),isnull( d.HORAEXPO,''),isnull( d.SALTAFW,''),isnull( d.HORAIMPO,''),convert( char(8), getdate(), 108 ),isnull( d.FECHALIQ,''),isnull( d.TOTALLIQ,0),isnull( d.OPERADORA,''),isnull( d.CODIGO,''),isnull( d.FECHADESDE,''),isnull( d.NUMINT,0),isnull( d.TOTALGRAV,0),isnull( d.PTOVENTA,0),isnull( d.FECHAHASTA,''),isnull( d.TOTALNOGRA,0),isnull( d.OBS,''),isnull( d.NROLIQ,0),isnull( d.SUBTOTAL,0),isnull( d.IDREGCTA,''),isnull( d.OTROSIMP,0),isnull( d.TOTIVA,0),isnull( d.OTROIVA,0)
						From deleted d left join ZooLogic.LIQMENSUAL pk 
							 on d.codigo = pk.codigo
						 left join ZooLogic.LIQMENSUAL cc 
							 on  d.numint = cc.numint
						Where pk.codigo Is Null 
							 and cc.numint Is Null 
				-- Fin Inserts
				Insert into ZooLogic.Logueos ( Fecha, Nivel, Logger, Accion, BaseDeDatos, 
					EstadoDelSistema, Aplicacion, Version, 
					Serie, Usuario, NombrePc, 
					UsuarioPc, OrigenLogueo, Mensaje, Excepcion)
				select GetDate(), 'INFO', '', 'Importación <<lcEntidad>>','<<loLogueo.BaseDatos>>',
					<<loLogueo.EstadoSistema>>,'<<loLogueo.Aplicacion>>','<<loLogueo.Version>>',
					'<<loLogueo.Serie>>','<<loLogueo.Usuario>>','<<loLogueo.NombrePc>>',
					'<<loLogueo.UsuarioPc>>','<<loLogueo.OrigenLogueo>>','No se pudo importar la entidad <<lcEntidad>>: NÚMERO INTERNO ' + cast( d.numint as Varchar(8) ) + '','La clave principal no es la esperada'
					from ZooLogic.LIQMENSUAL t inner join deleted d 
							on   t.numint = d.numint
						left join deleted h 
							 on t.codigo = h.codigo
							 where h.codigo is null 
				Insert into ZooLogic.Logueos ( Fecha, Nivel, Logger, Accion, BaseDeDatos, 
					EstadoDelSistema, Aplicacion, Version, 
					Serie, Usuario, NombrePc, 
					UsuarioPc, OrigenLogueo, Mensaje, Excepcion)
				select GetDate(), 'INFO', '', 'Importación <<lcEntidad>>','<<loLogueo.BaseDatos>>',
					<<loLogueo.EstadoSistema>>,'<<loLogueo.Aplicacion>>','<<loLogueo.Version>>',
					'<<loLogueo.Serie>>','<<loLogueo.Usuario>>','<<loLogueo.NombrePc>>',
					'<<loLogueo.UsuarioPc>>','<<loLogueo.OrigenLogueo>>','No se pudo importar la entidad <<lcEntidad>>: NÚMERO INTERNO ' + cast( d.numint as Varchar(8) ) + '','La clave principal a importar ya existe'
					from ZooLogic.LIQMENSUAL t inner join deleted d 
							 on t.codigo = d.codigo
						left join deleted h 
							on   t.numint = h.numint
							where   h.numint is null 
			End
		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_ImpLiqMen( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_LIQMENSUAL_ImpLiqMen
ON ZooLogic.TablaTrabajo_LIQMENSUAL_ImpLiqMen
AFTER DELETE
As
Begin
Update t Set 
t.IVAMNGSD = isnull( d.IVAMNGSD, t.IVAMNGSD ),
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.IVAMONNG = isnull( d.IVAMONNG, t.IVAMONNG ),
t.IVAMONSD = isnull( d.IVAMONSD, t.IVAMONSD ),
t.IVAPORCENT = isnull( d.IVAPORCENT, t.IVAPORCENT ),
t.IVAMONTO = isnull( d.IVAMONTO, t.IVAMONTO ),
t.CODIGO = isnull( d.CODIGO, t.CODIGO )
from ZooLogic.ImpLiqMen t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.ImpLiqMen
( 
"IVAMNGSD",
"NROITEM",
"IVAMONNG",
"IVAMONSD",
"IVAPORCENT",
"IVAMONTO",
"CODIGO"
 )
Select 
d.IVAMNGSD,
d.NROITEM,
d.IVAMONNG,
d.IVAMONSD,
d.IVAPORCENT,
d.IVAMONTO,
d.CODIGO
From deleted d left join ZooLogic.ImpLiqMen pk 
 on d.CODIGO = pk.CODIGO
Where pk.CODIGO Is Null 
-- Fin Inserts
End

		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_liqConMenlDet( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_LIQMENSUAL_liqConMenlDet
ON ZooLogic.TablaTrabajo_LIQMENSUAL_liqConMenlDet
AFTER DELETE
As
Begin
Update t Set 
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.CODIGO = isnull( d.CODIGO, t.CODIGO ),
t.CONCEPTO = isnull( d.CONCEPTO, t.CONCEPTO ),
t.DESCRIP = isnull( d.DESCRIP, t.DESCRIP ),
t.MONTO = isnull( d.MONTO, t.MONTO ),
t.SUBIVA = isnull( d.SUBIVA, t.SUBIVA ),
t.GUIDCOMP = isnull( d.GUIDCOMP, t.GUIDCOMP )
from ZooLogic.liqConMenlDet t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.liqConMenlDet
( 
"NROITEM",
"CODIGO",
"CONCEPTO",
"DESCRIP",
"MONTO",
"SUBIVA",
"GUIDCOMP"
 )
Select 
d.NROITEM,
d.CODIGO,
d.CONCEPTO,
d.DESCRIP,
d.MONTO,
d.SUBIVA,
d.GUIDCOMP
From deleted d left join ZooLogic.liqConMenlDet pk 
 on d.CODIGO = pk.CODIGO
Where pk.CODIGO Is Null 
-- Fin Inserts
End

		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_liqConDiaDet( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_LIQMENSUAL_liqConDiaDet
ON ZooLogic.TablaTrabajo_LIQMENSUAL_liqConDiaDet
AFTER DELETE
As
Begin
Update t Set 
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.CODIGO = isnull( d.CODIGO, t.CODIGO ),
t.LIQDIARIA = isnull( d.LIQDIARIA, t.LIQDIARIA ),
t.MONTO = isnull( d.MONTO, t.MONTO ),
t.DESCUENTO = isnull( d.DESCUENTO, t.DESCUENTO ),
t.NETO = isnull( d.NETO, t.NETO )
from ZooLogic.liqConDiaDet t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.liqConDiaDet
( 
"NROITEM",
"CODIGO",
"LIQDIARIA",
"MONTO",
"DESCUENTO",
"NETO"
 )
Select 
d.NROITEM,
d.CODIGO,
d.LIQDIARIA,
d.MONTO,
d.DESCUENTO,
d.NETO
From deleted d left join ZooLogic.liqConDiaDet pk 
 on d.CODIGO = pk.CODIGO
Where pk.CODIGO Is Null 
-- Fin Inserts
End

		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_ImpLiqMenCom( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_LIQMENSUAL_ImpLiqMenCom
ON ZooLogic.TablaTrabajo_LIQMENSUAL_ImpLiqMenCom
AFTER DELETE
As
Begin
Update t Set 
t.CODINT = isnull( d.CODINT, t.CODINT ),
t.TIPOI = isnull( d.TIPOI, t.TIPOI ),
t.PORCEN = isnull( d.PORCEN, t.PORCEN ),
t.MINOIMP = isnull( d.MINOIMP, t.MINOIMP ),
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.CCOD = isnull( d.CCOD, t.CCOD ),
t.CODIMP = isnull( d.CODIMP, t.CODIMP ),
t.DESCRI = isnull( d.DESCRI, t.DESCRI ),
t.MONTO = isnull( d.MONTO, t.MONTO )
from ZooLogic.ImpLiqMenCom t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.ImpLiqMenCom
( 
"CODINT",
"TIPOI",
"PORCEN",
"MINOIMP",
"NROITEM",
"CCOD",
"CODIMP",
"DESCRI",
"MONTO"
 )
Select 
d.CODINT,
d.TIPOI,
d.PORCEN,
d.MINOIMP,
d.NROITEM,
d.CCOD,
d.CODIMP,
d.DESCRI,
d.MONTO
From deleted d left join ZooLogic.ImpLiqMenCom pk 
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_liqMensual') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_liqMensual
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_LIQUIDACIONMENSUAL' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_LIQUIDACIONMENSUAL.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_LIQUIDACIONMENSUAL.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_LIQUIDACIONMENSUAL.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_LIQUIDACIONMENSUAL.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_LIQUIDACIONMENSUAL.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Versionmodificacionfw = nvl( c_LIQUIDACIONMENSUAL.Versionmodificacionfw, [] )
					.Basededatosaltafw = nvl( c_LIQUIDACIONMENSUAL.Basededatosaltafw, [] )
					.Estadotransferencia = nvl( c_LIQUIDACIONMENSUAL.Estadotransferencia, [] )
					.Basededatosmodificacionfw = nvl( c_LIQUIDACIONMENSUAL.Basededatosmodificacionfw, [] )
					.Horamodificacionfw = nvl( c_LIQUIDACIONMENSUAL.Horamodificacionfw, [] )
					.Usuariomodificacionfw = nvl( c_LIQUIDACIONMENSUAL.Usuariomodificacionfw, [] )
					.Versionaltafw = nvl( c_LIQUIDACIONMENSUAL.Versionaltafw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Usuarioaltafw = nvl( c_LIQUIDACIONMENSUAL.Usuarioaltafw, [] )
					.Seriemodificacionfw = nvl( c_LIQUIDACIONMENSUAL.Seriemodificacionfw, [] )
					.Horaexpo = nvl( c_LIQUIDACIONMENSUAL.Horaexpo, [] )
					.Seriealtafw = nvl( c_LIQUIDACIONMENSUAL.Seriealtafw, [] )
					.Horaimpo = nvl( c_LIQUIDACIONMENSUAL.Horaimpo, [] )
					.Horaaltafw = nvl( c_LIQUIDACIONMENSUAL.Horaaltafw, [] )
					.Impuestosdetalle.Limpiar()
					.Impuestosdetalle.SetearEsNavegacion( .lProcesando )
					.Impuestosdetalle.Cargar()
					.Fechaliq = GoLibrerias.ObtenerFechaFormateada( nvl( c_LIQUIDACIONMENSUAL.Fechaliq, ctod( '  /  /    ' ) ) )
					.Totalliquidacion = nvl( c_LIQUIDACIONMENSUAL.Totalliquidacion, 0 )
					.Operadora_PK =  nvl( c_LIQUIDACIONMENSUAL.Operadora, [] )
					.Codigo = nvl( c_LIQUIDACIONMENSUAL.Codigo, [] )
					.Conceptosgenerales.Limpiar()
					.Conceptosgenerales.SetearEsNavegacion( .lProcesando )
					.Conceptosgenerales.Cargar()
					.Conceptosdiarios.Limpiar()
					.Conceptosdiarios.SetearEsNavegacion( .lProcesando )
					.Conceptosdiarios.Cargar()
					.Impuestoscomprobante.Limpiar()
					.Impuestoscomprobante.SetearEsNavegacion( .lProcesando )
					.Impuestoscomprobante.Cargar()
					.Fechadesde = GoLibrerias.ObtenerFechaFormateada( nvl( c_LIQUIDACIONMENSUAL.Fechadesde, ctod( '  /  /    ' ) ) )
					.Numint = nvl( c_LIQUIDACIONMENSUAL.Numint, 0 )
					.Totalgravado = nvl( c_LIQUIDACIONMENSUAL.Totalgravado, 0 )
					.Puntodeventaliquidacion = nvl( c_LIQUIDACIONMENSUAL.Puntodeventaliquidacion, 0 )
					.Fechahasta = GoLibrerias.ObtenerFechaFormateada( nvl( c_LIQUIDACIONMENSUAL.Fechahasta, ctod( '  /  /    ' ) ) )
					.Totalnogravado = nvl( c_LIQUIDACIONMENSUAL.Totalnogravado, 0 )
					lcValor = This.ObtenerMemo( 'c_Obs')
					.Obs = lcValor 
					.Numeroliquidacion = nvl( c_LIQUIDACIONMENSUAL.Numeroliquidacion, 0 )
					.Subtotal = nvl( c_LIQUIDACIONMENSUAL.Subtotal, 0 )
					.Idregistrodecuenta = nvl( c_LIQUIDACIONMENSUAL.Idregistrodecuenta, [] )
					.Otrosimpuestos = nvl( c_LIQUIDACIONMENSUAL.Otrosimpuestos, 0 )
					.Totaliva = nvl( c_LIQUIDACIONMENSUAL.Totaliva, 0 )
					.Totalotroiva = nvl( c_LIQUIDACIONMENSUAL.Totalotroiva, 0 )
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
			lxRetorno = c_LIQUIDACIONMENSUAL.CODIGO
		endif
		return lxRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function ActualizarLosNROItemDeLosDetalles() as void
		local loDetalle as object, loItem as object, lnContadorNroItem as integer, lnIndex as integer
		
		loDetalle = this.oEntidad.ImpuestosDetalle
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

		loDetalle = this.oEntidad.Conceptosgenerales
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

		loDetalle = this.oEntidad.Conceptosdiarios
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

		loDetalle = this.oEntidad.ImpuestosComprobante
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
		return c_LIQUIDACIONMENSUAL.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.LIQMENSUAL' )
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
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "codigo"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
		text to lcSQL textmerge noshow
				SELECT nro,totalRegistros,codigo as Id
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    codigo from (
							select * 
								from ZooLogic.LIQMENSUAL 
								Where   LIQMENSUAL.CODIGO != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "LIQMENSUAL", "", lcCursor, set("Datasession") )
		lcXml = this.CursorAXml( lcCursor )
		
		use in select( lcCursor )
		
		Return lcXml 
		
	endfunc
	*-----------------------------------------------------------------------------------------
	function ObtenerDatosEntidadPaginado( tcOrderBy as String, tcFiltro as String, tnCantidad as Integer, tnPagina as Integer )  as String
		local lcOrderBy as String, lnCuantos as Integer, lnPagina as Integer, lnTope as Integer, lnDesde as Integer, lcSQL as String, lcCursor as String, lcXml as String
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "codigo"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
			text to lcAtributos textmerge noshow
			"Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Vmodifw" as "Versionmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Hmodifw" as "Horamodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Horaexpo" as "Horaexpo", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Fechaliq" as "Fechaliq", "Totalliq" as "Totalliquidacion", "Operadora" as "Operadora", "Codigo" as "Codigo", "Fechadesde" as "Fechadesde", "Numint" as "Numint", "Totalgrav" as "Totalgravado", "Ptoventa" as "Puntodeventaliquidacion", "Fechahasta" as "Fechahasta", "Totalnogra" as "Totalnogravado", "Obs" as "Obs", "Nroliq" as "Numeroliquidacion", "Subtotal" as "Subtotal", "Idregcta" as "Idregistrodecuenta", "Otrosimp" as "Otrosimpuestos", "Totiva" as "Totaliva", "Otroiva" as "Totalotroiva"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.LIQMENSUAL 
								Where   LIQMENSUAL.CODIGO != ''
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
	Tabla = 'LIQMENSUAL'
	Filtro = " LIQMENSUAL.CODIGO != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " LIQMENSUAL.CODIGO != ''"
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
	<row entidad="LIQUIDACIONMENSUAL                      " atributo="FECHATRANSFERENCIA                      " tabla="LIQMENSUAL     " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha de novedad                                                                                                                                                " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIQUIDACIONMENSUAL                      " atributo="FECHAEXPO                               " tabla="LIQMENSUAL     " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIQUIDACIONMENSUAL                      " atributo="FECHAIMPO                               " tabla="LIQMENSUAL     " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIQUIDACIONMENSUAL                      " atributo="FECHAMODIFICACIONFW                     " tabla="LIQMENSUAL     " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIQUIDACIONMENSUAL                      " atributo="FECHAALTAFW                             " tabla="LIQMENSUAL     " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIQUIDACIONMENSUAL                      " atributo="VERSIONMODIFICACIONFW                   " tabla="LIQMENSUAL     " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIQUIDACIONMENSUAL                      " atributo="BASEDEDATOSALTAFW                       " tabla="LIQMENSUAL     " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIQUIDACIONMENSUAL                      " atributo="ESTADOTRANSFERENCIA                     " tabla="LIQMENSUAL     " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado de novedad                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIQUIDACIONMENSUAL                      " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="LIQMENSUAL     " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIQUIDACIONMENSUAL                      " atributo="HORAMODIFICACIONFW                      " tabla="LIQMENSUAL     " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIQUIDACIONMENSUAL                      " atributo="USUARIOMODIFICACIONFW                   " tabla="LIQMENSUAL     " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIQUIDACIONMENSUAL                      " atributo="VERSIONALTAFW                           " tabla="LIQMENSUAL     " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIQUIDACIONMENSUAL                      " atributo="ZADSFW                                  " tabla="LIQMENSUAL     " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIQUIDACIONMENSUAL                      " atributo="USUARIOALTAFW                           " tabla="LIQMENSUAL     " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIQUIDACIONMENSUAL                      " atributo="SERIEMODIFICACIONFW                     " tabla="LIQMENSUAL     " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIQUIDACIONMENSUAL                      " atributo="HORAEXPO                                " tabla="LIQMENSUAL     " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIQUIDACIONMENSUAL                      " atributo="SERIEALTAFW                             " tabla="LIQMENSUAL     " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIQUIDACIONMENSUAL                      " atributo="HORAIMPO                                " tabla="LIQMENSUAL     " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIQUIDACIONMENSUAL                      " atributo="HORAALTAFW                              " tabla="LIQMENSUAL     " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIQUIDACIONMENSUAL                      " atributo="IMPUESTOSDETALLE                        " tabla="IMPLIQMEN      " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Impuesto Detalle                                                                                                                                                " dominio="DETALLEITEMIMPUESTOSLIQ       " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="10" orden="0" alta="false" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIQUIDACIONMENSUAL                      " atributo="FECHALIQ                                " tabla="LIQMENSUAL     " campo="FECHALIQ  " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goServicios.Librerias.ObtenerFecha()                                                                                                                                                                                                                         " obligatorio="true" admitebusqueda="400" etiqueta="Fecha liquidación                                                                                                                                               " dominio="FECHACALENDARIO               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="3" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIQUIDACIONMENSUAL                      " atributo="TOTALLIQUIDACION                        " tabla="LIQMENSUAL     " campo="TOTALLIQ  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="402" etiqueta="Total                                                                                                                                                           " dominio="TOTALMULTIMONEDA              " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="6" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIQUIDACIONMENSUAL                      " atributo="OPERADORA                               " tabla="LIQMENSUAL     " campo="OPERADORA " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="OPERADORADETARJETA                      " tipodato="C         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="404" etiqueta="Operadora                                                                                                                                                       " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIQUIDACIONMENSUAL                      " atributo="CODIGO                                  " tabla="LIQMENSUAL     " campo="CODIGO    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="0" etiqueta="Código                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIQUIDACIONMENSUAL                      " atributo="CONCEPTOSGENERALES                      " tabla="LIQCONMENLDET  " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="406" etiqueta="Conceptos generales                                                                                                                                             " dominio="DETALLEITEMLIQGENERAL         " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="5" orden="1" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIQUIDACIONMENSUAL                      " atributo="CONCEPTOSDIARIOS                        " tabla="LIQCONDIADET   " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="408" etiqueta="Conceptos diarios                                                                                                                                               " dominio="DETALLEITEMLIQDIARIA          " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="4" orden="1" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIQUIDACIONMENSUAL                      " atributo="IMPUESTOSCOMPROBANTE                    " tabla="IMPLIQMENCOM   " campo="CCOD      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Impuesto comprobante                                                                                                                                            " dominio="DETALLEITEMIMPUESTOSLIQCOM    " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="12" orden="1" alta="false" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIQUIDACIONMENSUAL                      " atributo="FECHADESDE                              " tabla="LIQMENSUAL     " campo="FECHADESDE" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goServicios.Librerias.ObtenerFecha() -(day(goServicios.Librerias.ObtenerFecha())-1)                                                                                                                                                                          " obligatorio="true" admitebusqueda="410" etiqueta="Fecha desde                                                                                                                                                     " dominio="FECHACALENDARIO               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIQUIDACIONMENSUAL                      " atributo="NUMINT                                  " tabla="LIQMENSUAL     " campo="NUMINT    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="2" etiqueta="Número interno                                                                                                                                                  " dominio="CLAVECANDIDATA                " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="1" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIQUIDACIONMENSUAL                      " atributo="TOTALGRAVADO                            " tabla="LIQMENSUAL     " campo="TOTALGRAV " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Total gravado                                                                                                                                                   " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="6" orden="2" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIQUIDACIONMENSUAL                      " atributo="PUNTODEVENTALIQUIDACION                 " tabla="LIQMENSUAL     " campo="PTOVENTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="4" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="412" etiqueta="Punto de venta liquidación                                                                                                                                      " dominio="NUMEROCOMPROBANTEEDITSINLETRA " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="9999                     " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="3" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIQUIDACIONMENSUAL                      " atributo="FECHAHASTA                              " tabla="LIQMENSUAL     " campo="FECHAHASTA" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goServicios.Librerias.ObtenerUltimoDiaDelMes(goServicios.Librerias.ObtenerFecha())                                                                                                                                                                           " obligatorio="true" admitebusqueda="414" etiqueta="Fecha hasta                                                                                                                                                     " dominio="FECHACALENDARIO               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIQUIDACIONMENSUAL                      " atributo="TOTALNOGRAVADO                          " tabla="LIQMENSUAL     " campo="TOTALNOGRA" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Total no gravado                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="6" orden="3" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIQUIDACIONMENSUAL                      " atributo="OBS                                     " tabla="LIQMENSUAL     " campo="OBS       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="416" etiqueta="Observación                                                                                                                                                     " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="7" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIQUIDACIONMENSUAL                      " atributo="NUMEROLIQUIDACION                       " tabla="LIQMENSUAL     " campo="NROLIQ    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="418" etiqueta="Nro. liquidación                                                                                                                                                " dominio="NUMEROCOMPROBANTEEDITSINLETRA " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="999999999999999          " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="3" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIQUIDACIONMENSUAL                      " atributo="SUBTOTAL                                " tabla="LIQMENSUAL     " campo="SUBTOTAL  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Sub total                                                                                                                                                       " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="6" orden="4" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIQUIDACIONMENSUAL                      " atributo="IDREGISTRODECUENTA                      " tabla="LIQMENSUAL     " campo="IDREGCTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="5" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIQUIDACIONMENSUAL                      " atributo="OTROSIMPUESTOS                          " tabla="LIQMENSUAL     " campo="OTROSIMP  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Otros                                                                                                                                                           " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="6" orden="5" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIQUIDACIONMENSUAL                      " atributo="TOTALIVA                                " tabla="LIQMENSUAL     " campo="TOTIVA    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="IVA                                                                                                                                                             " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="6" orden="6" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIQUIDACIONMENSUAL                      " atributo="TOTALOTROIVA                            " tabla="LIQMENSUAL     " campo="OTROIVA   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Otro IVA                                                                                                                                                        " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="6" orden="7" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="OPERADORADETARJETA                      " atributo="DESCRIPCION                             " tabla="OPETAR         " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="405" etiqueta="Detalle Ope.                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join OPETAR On LIQMENSUAL.OPERADORA = OPETAR.Codigo And  OPETAR.CODIGO != ''                                                                                                                                                                            " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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