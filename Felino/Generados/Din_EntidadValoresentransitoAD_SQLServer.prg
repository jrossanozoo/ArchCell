
define class Din_EntidadVALORESENTRANSITOAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_VALORESENTRANSITO'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = [str( Numero, 8, 0)]
	cExpresionCCPorCampos = [str( #tabla#.Numero, 8, 0)]
	cTagClaveCandidata = '_VTRCC'
	cTagClavePk = '_VTRPK'
	cTablaPrincipal = 'VTRANS'
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
		this.GrabarNumeraciones()

		with this.oEntidad
			local  lxVtransFaltafw, lxVtransFectrans, lxVtransFecexpo, lxVtransFecimpo, lxVtransFmodifw, lxVtransCotiz, lxVtransTimestamp, lxVtransHoraexpo, lxVtransHaltafw, lxVtransUaltafw, lxVtransHoraimpo, lxVtransVmodifw, lxVtransDescfw, lxVtransValtafw, lxVtransUmodifw, lxVtransSaltafw, lxVtransSmodifw, lxVtransHmodifw, lxVtransEsttrans, lxVtransEstadoacc, lxVtransBdmodifw, lxVtransVendedor, lxVtransBdaltafw, lxVtransMoneda, lxVtransCodigo, lxVtransMobs, lxVtransCajaorig, lxVtransZadsfw, lxVtransNumero, lxVtransOrigdest, lxVtransFecha, lxVtransConcepto, lxVtransTipo, lxVtransDescvend
				lxVtransFaltafw =  .Fechaaltafw			lxVtransFectrans =  .Fechatransferencia			lxVtransFecexpo =  .Fechaexpo			lxVtransFecimpo =  .Fechaimpo			lxVtransFmodifw =  .Fechamodificacionfw			lxVtransCotiz =  .Cotizacion			lxVtransTimestamp = goLibrerias.ObtenerTimestamp()			lxVtransHoraexpo =  .Horaexpo			lxVtransHaltafw =  .Horaaltafw			lxVtransUaltafw =  .Usuarioaltafw			lxVtransHoraimpo =  .Horaimpo			lxVtransVmodifw =  .Versionmodificacionfw			lxVtransDescfw =  .Descripcionfw			lxVtransValtafw =  .Versionaltafw			lxVtransUmodifw =  .Usuariomodificacionfw			lxVtransSaltafw =  .Seriealtafw			lxVtransSmodifw =  .Seriemodificacionfw			lxVtransHmodifw =  .Horamodificacionfw			lxVtransEsttrans =  .Estadotransferencia			lxVtransEstadoacc =  .Estadosegunaccion			lxVtransBdmodifw =  .Basededatosmodificacionfw			lxVtransVendedor =  .Codigovendedororigen			lxVtransBdaltafw =  .Basededatosaltafw			lxVtransMoneda =  upper( .MonedaComprobante_PK ) 			lxVtransCodigo =  .Codigo			lxVtransMobs =  .Observacion			lxVtransCajaorig =  .Cajaorigen_PK 			lxVtransZadsfw =  .Zadsfw			lxVtransNumero =  .Numero			lxVtransOrigdest =  upper( .OrigenDestino_PK ) 			lxVtransFecha =  .Fecha			lxVtransConcepto =  upper( .Concepto_PK ) 			lxVtransTipo =  .Tipo			lxVtransDescvend =  .Nombrevendedororigen
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxVtransCodigo = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.VTRANS ( "Faltafw","Fectrans","Fecexpo","Fecimpo","Fmodifw","Cotiz","Timestamp","Horaexpo","Haltafw","Ualtafw","Horaimpo","Vmodifw","Descfw","Valtafw","Umodifw","Saltafw","Smodifw","Hmodifw","Esttrans","Estadoacc","Bdmodifw","Vendedor","Bdaltafw","Moneda","Codigo","Mobs","Cajaorig","Zadsfw","Numero","Origdest","Fecha","Concepto","Tipo","Descvend" ) values ( <<"'" + this.ConvertirDateSql( lxVtransFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxVtransFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxVtransFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxVtransFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxVtransFmodifw ) + "'" >>, <<lxVtransCotiz >>, <<lxVtransTimestamp >>, <<"'" + this.FormatearTextoSql( lxVtransHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVtransHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVtransUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVtransHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVtransVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVtransDescfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVtransValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVtransUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVtransSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVtransSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVtransHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVtransEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVtransEstadoacc ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVtransBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVtransVendedor ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVtransBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVtransMoneda ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVtransCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVtransMobs ) + "'" >>, <<lxVtransCajaorig >>, <<"'" + this.FormatearTextoSql( lxVtransZadsfw ) + "'" >>, <<lxVtransNumero >>, <<"'" + this.FormatearTextoSql( lxVtransOrigdest ) + "'" >>, <<"'" + this.ConvertirDateSql( lxVtransFecha ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVtransConcepto ) + "'" >>, <<lxVtransTipo >>, <<"'" + this.FormatearTextoSql( lxVtransDescvend ) + "'" >> )
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
		this.ComprobarTransaccion()
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = lxValorClavePrimaria


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

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.Valores
				if this.oEntidad.Valores.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxTipo = loItem.Tipo
					lxCotiza = loItem.Cotiza
					lxNroitem = lnContadorNroItem
					lxCodigochequepropio_PK = loItem.Codigochequepropio_PK
					lxCodigocheque_PK = loItem.Codigocheque_PK
					lxValor_PK = loItem.Valor_PK
					lxValordetalle = loItem.Valordetalle
					lxNumerointerno = loItem.Numerointerno
					lxFechaemision = loItem.Fechaemision
					lxFechapago = loItem.Fechapago
					lxEstadoenorigen = loItem.Estadoenorigen
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.VTRANSDET("CodDetVal","Tipo","Cotiza","NROITEM","NroChProp","NroCheque","CodVal","Descrip","NroInterno","FechaEmi","FechaPago","Estado","monto" ) values ( <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<lxTipo>>, <<lxCotiza>>, <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxCodigochequepropio_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigocheque_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerointerno ) + "'">>, <<"'" + this.ConvertirDateSql( lxFechaemision ) + "'">>, <<"'" + this.ConvertirDateSql( lxFechapago ) + "'">>, <<"'" + this.FormatearTextoSql( lxEstadoenorigen ) + "'">>, <<lxMonto>> ) 
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
		this.oEntidad.Timestamp = lxVtransTimestamp
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
			local  lxVtransFaltafw, lxVtransFectrans, lxVtransFecexpo, lxVtransFecimpo, lxVtransFmodifw, lxVtransCotiz, lxVtransTimestamp, lxVtransHoraexpo, lxVtransHaltafw, lxVtransUaltafw, lxVtransHoraimpo, lxVtransVmodifw, lxVtransDescfw, lxVtransValtafw, lxVtransUmodifw, lxVtransSaltafw, lxVtransSmodifw, lxVtransHmodifw, lxVtransEsttrans, lxVtransEstadoacc, lxVtransBdmodifw, lxVtransVendedor, lxVtransBdaltafw, lxVtransMoneda, lxVtransCodigo, lxVtransMobs, lxVtransCajaorig, lxVtransZadsfw, lxVtransNumero, lxVtransOrigdest, lxVtransFecha, lxVtransConcepto, lxVtransTipo, lxVtransDescvend
				lxVtransFaltafw =  .Fechaaltafw			lxVtransFectrans =  .Fechatransferencia			lxVtransFecexpo =  .Fechaexpo			lxVtransFecimpo =  .Fechaimpo			lxVtransFmodifw =  .Fechamodificacionfw			lxVtransCotiz =  .Cotizacion			lxVtransTimestamp = goLibrerias.ObtenerTimestamp()			lxVtransHoraexpo =  .Horaexpo			lxVtransHaltafw =  .Horaaltafw			lxVtransUaltafw =  .Usuarioaltafw			lxVtransHoraimpo =  .Horaimpo			lxVtransVmodifw =  .Versionmodificacionfw			lxVtransDescfw =  .Descripcionfw			lxVtransValtafw =  .Versionaltafw			lxVtransUmodifw =  .Usuariomodificacionfw			lxVtransSaltafw =  .Seriealtafw			lxVtransSmodifw =  .Seriemodificacionfw			lxVtransHmodifw =  .Horamodificacionfw			lxVtransEsttrans =  .Estadotransferencia			lxVtransEstadoacc =  .Estadosegunaccion			lxVtransBdmodifw =  .Basededatosmodificacionfw			lxVtransVendedor =  .Codigovendedororigen			lxVtransBdaltafw =  .Basededatosaltafw			lxVtransMoneda =  upper( .MonedaComprobante_PK ) 			lxVtransCodigo =  .Codigo			lxVtransMobs =  .Observacion			lxVtransCajaorig =  .Cajaorigen_PK 			lxVtransZadsfw =  .Zadsfw			lxVtransNumero =  .Numero			lxVtransOrigdest =  upper( .OrigenDestino_PK ) 			lxVtransFecha =  .Fecha			lxVtransConcepto =  upper( .Concepto_PK ) 			lxVtransTipo =  .Tipo			lxVtransDescvend =  .Nombrevendedororigen
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
				update ZooLogic.VTRANS set "Faltafw" = <<"'" + this.ConvertirDateSql( lxVtransFaltafw ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxVtransFectrans ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxVtransFecexpo ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxVtransFecimpo ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxVtransFmodifw ) + "'">>,"Cotiz" = <<lxVtransCotiz>>,"Timestamp" = <<lxVtransTimestamp>>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxVtransHoraexpo ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxVtransHaltafw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxVtransUaltafw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxVtransHoraimpo ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxVtransVmodifw ) + "'">>,"Descfw" = <<"'" + this.FormatearTextoSql( lxVtransDescfw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxVtransValtafw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxVtransUmodifw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxVtransSaltafw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxVtransSmodifw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxVtransHmodifw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxVtransEsttrans ) + "'">>,"Estadoacc" = <<"'" + this.FormatearTextoSql( lxVtransEstadoacc ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxVtransBdmodifw ) + "'">>,"Vendedor" = <<"'" + this.FormatearTextoSql( lxVtransVendedor ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxVtransBdaltafw ) + "'">>,"Moneda" = <<"'" + this.FormatearTextoSql( lxVtransMoneda ) + "'">>,"Codigo" = <<"'" + this.FormatearTextoSql( lxVtransCodigo ) + "'">>,"Mobs" = <<"'" + this.FormatearTextoSql( lxVtransMobs ) + "'">>,"Cajaorig" = <<lxVtransCajaorig>>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxVtransZadsfw ) + "'">>,"Numero" = <<lxVtransNumero>>,"Origdest" = <<"'" + this.FormatearTextoSql( lxVtransOrigdest ) + "'">>,"Fecha" = <<"'" + this.ConvertirDateSql( lxVtransFecha ) + "'">>,"Concepto" = <<"'" + this.FormatearTextoSql( lxVtransConcepto ) + "'">>,"Tipo" = <<lxVtransTipo>>,"Descvend" = <<"'" + this.FormatearTextoSql( lxVtransDescvend ) + "'">> where "Codigo" = <<"'" + this.FormatearTextoSql( lxVtransCodigo ) + "'">> and  VTRANS.CODIGO != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			this.ComprobarResultadoDeEjecucionDelUpdate()
		this.ComprobarTransaccion()
			this.oConexion.EjecutarSql( 'delete from ZooLogic.CompAfe where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.VTRANSDET where "CodDetVal" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )

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

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.Valores
				if this.oEntidad.Valores.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxTipo = loItem.Tipo
					lxCotiza = loItem.Cotiza
					lxNroitem = lnContadorNroItem
					lxCodigochequepropio_PK = loItem.Codigochequepropio_PK
					lxCodigocheque_PK = loItem.Codigocheque_PK
					lxValor_PK = loItem.Valor_PK
					lxValordetalle = loItem.Valordetalle
					lxNumerointerno = loItem.Numerointerno
					lxFechaemision = loItem.Fechaemision
					lxFechapago = loItem.Fechapago
					lxEstadoenorigen = loItem.Estadoenorigen
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.VTRANSDET("CodDetVal","Tipo","Cotiza","NROITEM","NroChProp","NroCheque","CodVal","Descrip","NroInterno","FechaEmi","FechaPago","Estado","monto" ) values ( <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<lxTipo>>, <<lxCotiza>>, <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxCodigochequepropio_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigocheque_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerointerno ) + "'">>, <<"'" + this.ConvertirDateSql( lxFechaemision ) + "'">>, <<"'" + this.ConvertirDateSql( lxFechapago ) + "'">>, <<"'" + this.FormatearTextoSql( lxEstadoenorigen ) + "'">>, <<lxMonto>> ) 
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
		this.oEntidad.Timestamp = lxVtransTimestamp
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 Codigo from ZooLogic.VTRANS where " + this.ConvertirFuncionesSql( " VTRANS.CODIGO != ''" ) )
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
			Local lxVtransCodigo
			lxVtransCodigo = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Cotiz" as "Cotizacion", "Timestamp" as "Timestamp", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Ualtafw" as "Usuarioaltafw", "Horaimpo" as "Horaimpo", "Vmodifw" as "Versionmodificacionfw", "Descfw" as "Descripcionfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Esttrans" as "Estadotransferencia", "Estadoacc" as "Estadosegunaccion", "Bdmodifw" as "Basededatosmodificacionfw", "Vendedor" as "Codigovendedororigen", "Bdaltafw" as "Basededatosaltafw", "Moneda" as "Monedacomprobante", "Codigo" as "Codigo", "Mobs" as "Observacion", "Cajaorig" as "Cajaorigen", "Zadsfw" as "Zadsfw", "Numero" as "Numero", "Origdest" as "Origendestino", "Fecha" as "Fecha", "Concepto" as "Concepto", "Tipo" as "Tipo", "Descvend" as "Nombrevendedororigen" from ZooLogic.VTRANS where "Codigo" = <<"'" + this.FormatearTextoSql( lxVtransCodigo ) + "'">> and  VTRANS.CODIGO != ''
			endtext
			use in select('c_VALORESENTRANSITO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_VALORESENTRANSITO', set( 'Datasession' ) )

			if reccount( 'c_VALORESENTRANSITO' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afetipocom" as "Tipocomprobante", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen" from ZooLogic.CompAfe where Codigo = <<"'" + this.FormatearTextoSql( c_VALORESENTRANSITO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_COMPAFEC')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMPAFEC', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_COMPAFEC
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Coddetval" as "Codigo", "Tipo" as "Tipo", "Cotiza" as "Cotiza", "Nroitem" as "Nroitem", "Nrochprop" as "Codigochequepropio", "Nrocheque" as "Codigocheque", "Codval" as "Valor", "Descrip" as "Valordetalle", "Nrointerno" as "Numerointerno", "Fechaemi" as "Fechaemision", "Fechapago" as "Fechapago", "Estado" as "Estadoenorigen", "Monto" as "Monto" from ZooLogic.VTRANSDET where CodDetVal = <<"'" + this.FormatearTextoSql( c_VALORESENTRANSITO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_Valores')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Valores', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Valores
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ConsultarPorClaveCandidata() as Boolean
		local llRetorno as Boolean
		llRetorno = .t.
		with this.oEntidad
			Local lxVTRANSNumero As Variant
			lxVTRANSNumero = .Numero
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Cotiz" as "Cotizacion", "Timestamp" as "Timestamp", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Ualtafw" as "Usuarioaltafw", "Horaimpo" as "Horaimpo", "Vmodifw" as "Versionmodificacionfw", "Descfw" as "Descripcionfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Esttrans" as "Estadotransferencia", "Estadoacc" as "Estadosegunaccion", "Bdmodifw" as "Basededatosmodificacionfw", "Vendedor" as "Codigovendedororigen", "Bdaltafw" as "Basededatosaltafw", "Moneda" as "Monedacomprobante", "Codigo" as "Codigo", "Mobs" as "Observacion", "Cajaorig" as "Cajaorigen", "Zadsfw" as "Zadsfw", "Numero" as "Numero", "Origdest" as "Origendestino", "Fecha" as "Fecha", "Concepto" as "Concepto", "Tipo" as "Tipo", "Descvend" as "Nombrevendedororigen" from ZooLogic.VTRANS where  VTRANS.CODIGO != '' And Numero = <<lxVTRANSNumero>>
			endtext
			use in select('c_VALORESENTRANSITO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_VALORESENTRANSITO', set( 'Datasession' ) )
			if reccount( 'c_VALORESENTRANSITO' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afetipocom" as "Tipocomprobante", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen" from ZooLogic.CompAfe where Codigo = <<"'" + this.FormatearTextoSql( c_VALORESENTRANSITO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_COMPAFEC')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMPAFEC', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_COMPAFEC
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Coddetval" as "Codigo", "Tipo" as "Tipo", "Cotiza" as "Cotiza", "Nroitem" as "Nroitem", "Nrochprop" as "Codigochequepropio", "Nrocheque" as "Codigocheque", "Codval" as "Valor", "Descrip" as "Valordetalle", "Nrointerno" as "Numerointerno", "Fechaemi" as "Fechaemision", "Fechapago" as "Fechapago", "Estado" as "Estadoenorigen", "Monto" as "Monto" from ZooLogic.VTRANSDET where CodDetVal = <<"'" + this.FormatearTextoSql( c_VALORESENTRANSITO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_Valores')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Valores', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Valores
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxVtransCodigo as Variant
		llRetorno = .t.
		lxVtransCodigo = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.VTRANS where "Codigo" = <<"'" + this.FormatearTextoSql( lxVtransCodigo ) + "'">> and  VTRANS.CODIGO != ''
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
				lcOrden =  str( .Numero, 8, 0)
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Cotiz" as "Cotizacion", "Timestamp" as "Timestamp", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Ualtafw" as "Usuarioaltafw", "Horaimpo" as "Horaimpo", "Vmodifw" as "Versionmodificacionfw", "Descfw" as "Descripcionfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Esttrans" as "Estadotransferencia", "Estadoacc" as "Estadosegunaccion", "Bdmodifw" as "Basededatosmodificacionfw", "Vendedor" as "Codigovendedororigen", "Bdaltafw" as "Basededatosaltafw", "Moneda" as "Monedacomprobante", "Codigo" as "Codigo", "Mobs" as "Observacion", "Cajaorig" as "Cajaorigen", "Zadsfw" as "Zadsfw", "Numero" as "Numero", "Origdest" as "Origendestino", "Fecha" as "Fecha", "Concepto" as "Concepto", "Tipo" as "Tipo", "Descvend" as "Nombrevendedororigen" from ZooLogic.VTRANS where  VTRANS.CODIGO != '' order by Numero
			endtext
			use in select('c_VALORESENTRANSITO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_VALORESENTRANSITO', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afetipocom" as "Tipocomprobante", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen" from ZooLogic.CompAfe where Codigo = <<"'" + this.FormatearTextoSql( c_VALORESENTRANSITO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_COMPAFEC')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMPAFEC', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_COMPAFEC
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Coddetval" as "Codigo", "Tipo" as "Tipo", "Cotiza" as "Cotiza", "Nroitem" as "Nroitem", "Nrochprop" as "Codigochequepropio", "Nrocheque" as "Codigocheque", "Codval" as "Valor", "Descrip" as "Valordetalle", "Nrointerno" as "Numerointerno", "Fechaemi" as "Fechaemision", "Fechapago" as "Fechapago", "Estado" as "Estadoenorigen", "Monto" as "Monto" from ZooLogic.VTRANSDET where CodDetVal = <<"'" + this.FormatearTextoSql( c_VALORESENTRANSITO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_Valores')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Valores', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Valores
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
				lcOrden =  str( .Numero, 8, 0)
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Cotiz" as "Cotizacion", "Timestamp" as "Timestamp", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Ualtafw" as "Usuarioaltafw", "Horaimpo" as "Horaimpo", "Vmodifw" as "Versionmodificacionfw", "Descfw" as "Descripcionfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Esttrans" as "Estadotransferencia", "Estadoacc" as "Estadosegunaccion", "Bdmodifw" as "Basededatosmodificacionfw", "Vendedor" as "Codigovendedororigen", "Bdaltafw" as "Basededatosaltafw", "Moneda" as "Monedacomprobante", "Codigo" as "Codigo", "Mobs" as "Observacion", "Cajaorig" as "Cajaorigen", "Zadsfw" as "Zadsfw", "Numero" as "Numero", "Origdest" as "Origendestino", "Fecha" as "Fecha", "Concepto" as "Concepto", "Tipo" as "Tipo", "Descvend" as "Nombrevendedororigen" from ZooLogic.VTRANS where  str( Numero, 8, 0) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  VTRANS.CODIGO != '' order by Numero
			endtext
			use in select('c_VALORESENTRANSITO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_VALORESENTRANSITO', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afetipocom" as "Tipocomprobante", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen" from ZooLogic.CompAfe where Codigo = <<"'" + this.FormatearTextoSql( c_VALORESENTRANSITO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_COMPAFEC')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMPAFEC', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_COMPAFEC
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Coddetval" as "Codigo", "Tipo" as "Tipo", "Cotiza" as "Cotiza", "Nroitem" as "Nroitem", "Nrochprop" as "Codigochequepropio", "Nrocheque" as "Codigocheque", "Codval" as "Valor", "Descrip" as "Valordetalle", "Nrointerno" as "Numerointerno", "Fechaemi" as "Fechaemision", "Fechapago" as "Fechapago", "Estado" as "Estadoenorigen", "Monto" as "Monto" from ZooLogic.VTRANSDET where CodDetVal = <<"'" + this.FormatearTextoSql( c_VALORESENTRANSITO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_Valores')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Valores', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Valores
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
				lcOrden =  str( .Numero, 8, 0)
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Cotiz" as "Cotizacion", "Timestamp" as "Timestamp", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Ualtafw" as "Usuarioaltafw", "Horaimpo" as "Horaimpo", "Vmodifw" as "Versionmodificacionfw", "Descfw" as "Descripcionfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Esttrans" as "Estadotransferencia", "Estadoacc" as "Estadosegunaccion", "Bdmodifw" as "Basededatosmodificacionfw", "Vendedor" as "Codigovendedororigen", "Bdaltafw" as "Basededatosaltafw", "Moneda" as "Monedacomprobante", "Codigo" as "Codigo", "Mobs" as "Observacion", "Cajaorig" as "Cajaorigen", "Zadsfw" as "Zadsfw", "Numero" as "Numero", "Origdest" as "Origendestino", "Fecha" as "Fecha", "Concepto" as "Concepto", "Tipo" as "Tipo", "Descvend" as "Nombrevendedororigen" from ZooLogic.VTRANS where  str( Numero, 8, 0) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  VTRANS.CODIGO != '' order by Numero desc
			endtext
			use in select('c_VALORESENTRANSITO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_VALORESENTRANSITO', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afetipocom" as "Tipocomprobante", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen" from ZooLogic.CompAfe where Codigo = <<"'" + this.FormatearTextoSql( c_VALORESENTRANSITO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_COMPAFEC')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMPAFEC', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_COMPAFEC
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Coddetval" as "Codigo", "Tipo" as "Tipo", "Cotiza" as "Cotiza", "Nroitem" as "Nroitem", "Nrochprop" as "Codigochequepropio", "Nrocheque" as "Codigocheque", "Codval" as "Valor", "Descrip" as "Valordetalle", "Nrointerno" as "Numerointerno", "Fechaemi" as "Fechaemision", "Fechapago" as "Fechapago", "Estado" as "Estadoenorigen", "Monto" as "Monto" from ZooLogic.VTRANSDET where CodDetVal = <<"'" + this.FormatearTextoSql( c_VALORESENTRANSITO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_Valores')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Valores', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Valores
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
				lcOrden =  str( .Numero, 8, 0)
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Cotiz" as "Cotizacion", "Timestamp" as "Timestamp", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Ualtafw" as "Usuarioaltafw", "Horaimpo" as "Horaimpo", "Vmodifw" as "Versionmodificacionfw", "Descfw" as "Descripcionfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Esttrans" as "Estadotransferencia", "Estadoacc" as "Estadosegunaccion", "Bdmodifw" as "Basededatosmodificacionfw", "Vendedor" as "Codigovendedororigen", "Bdaltafw" as "Basededatosaltafw", "Moneda" as "Monedacomprobante", "Codigo" as "Codigo", "Mobs" as "Observacion", "Cajaorig" as "Cajaorigen", "Zadsfw" as "Zadsfw", "Numero" as "Numero", "Origdest" as "Origendestino", "Fecha" as "Fecha", "Concepto" as "Concepto", "Tipo" as "Tipo", "Descvend" as "Nombrevendedororigen" from ZooLogic.VTRANS where  VTRANS.CODIGO != '' order by Numero desc
			endtext
			use in select('c_VALORESENTRANSITO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_VALORESENTRANSITO', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afetipocom" as "Tipocomprobante", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen" from ZooLogic.CompAfe where Codigo = <<"'" + this.FormatearTextoSql( c_VALORESENTRANSITO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_COMPAFEC')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMPAFEC', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_COMPAFEC
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Coddetval" as "Codigo", "Tipo" as "Tipo", "Cotiza" as "Cotiza", "Nroitem" as "Nroitem", "Nrochprop" as "Codigochequepropio", "Nrocheque" as "Codigocheque", "Codval" as "Valor", "Descrip" as "Valordetalle", "Nrointerno" as "Numerointerno", "Fechaemi" as "Fechaemision", "Fechapago" as "Fechapago", "Estado" as "Estadoenorigen", "Monto" as "Monto" from ZooLogic.VTRANSDET where CodDetVal = <<"'" + this.FormatearTextoSql( c_VALORESENTRANSITO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_Valores')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Valores', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Valores
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
			lcXml = this.oConexion.EjecutarSql( "select Faltafw,Fectrans,Fecexpo,Fecimpo,Fmodifw,Cotiz,Timestamp,Horaexpo,Haltafw,Ualtafw,Horaimpo,V" + ;
"modifw,Descfw,Valtafw,Umodifw,Saltafw,Smodifw,Hmodifw,Esttrans,Estadoacc,Bdmodifw,Vendedor,Bdaltafw," + ;
"Moneda,Codigo,Mobs,Cajaorig,Zadsfw,Numero,Origdest,Fecha,Concepto,Tipo,Descvend" + ;
" from ZooLogic.VTRANS where  VTRANS.CODIGO != '' and " + lcFiltro )
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
			local  lxVtransFaltafw, lxVtransFectrans, lxVtransFecexpo, lxVtransFecimpo, lxVtransFmodifw, lxVtransCotiz, lxVtransTimestamp, lxVtransHoraexpo, lxVtransHaltafw, lxVtransUaltafw, lxVtransHoraimpo, lxVtransVmodifw, lxVtransDescfw, lxVtransValtafw, lxVtransUmodifw, lxVtransSaltafw, lxVtransSmodifw, lxVtransHmodifw, lxVtransEsttrans, lxVtransEstadoacc, lxVtransBdmodifw, lxVtransVendedor, lxVtransBdaltafw, lxVtransMoneda, lxVtransCodigo, lxVtransMobs, lxVtransCajaorig, lxVtransZadsfw, lxVtransNumero, lxVtransOrigdest, lxVtransFecha, lxVtransConcepto, lxVtransTipo, lxVtransDescvend
				lxVtransFaltafw = ctod( '  /  /    ' )			lxVtransFectrans = ctod( '  /  /    ' )			lxVtransFecexpo = ctod( '  /  /    ' )			lxVtransFecimpo = ctod( '  /  /    ' )			lxVtransFmodifw = ctod( '  /  /    ' )			lxVtransCotiz = 0			lxVtransTimestamp = goLibrerias.ObtenerTimestamp()			lxVtransHoraexpo = []			lxVtransHaltafw = []			lxVtransUaltafw = []			lxVtransHoraimpo = []			lxVtransVmodifw = []			lxVtransDescfw = []			lxVtransValtafw = []			lxVtransUmodifw = []			lxVtransSaltafw = []			lxVtransSmodifw = []			lxVtransHmodifw = []			lxVtransEsttrans = []			lxVtransEstadoacc = []			lxVtransBdmodifw = []			lxVtransVendedor = []			lxVtransBdaltafw = []			lxVtransMoneda = []			lxVtransCodigo = []			lxVtransMobs = []			lxVtransCajaorig = 0			lxVtransZadsfw = []			lxVtransNumero = 0			lxVtransOrigdest = []			lxVtransFecha = ctod( '  /  /    ' )			lxVtransConcepto = []			lxVtransTipo = 0			lxVtransDescvend = []
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.CompAfe where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.VTRANSDET where "CodDetVal" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( [delete from ZooLogic.VTRANS where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'VTRANS' + '_' + tcCampo
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
		lcWhere = " Where  VTRANS.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Cotiz" as "Cotizacion", "Timestamp" as "Timestamp", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Ualtafw" as "Usuarioaltafw", "Horaimpo" as "Horaimpo", "Vmodifw" as "Versionmodificacionfw", "Descfw" as "Descripcionfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Esttrans" as "Estadotransferencia", "Estadoacc" as "Estadosegunaccion", "Bdmodifw" as "Basededatosmodificacionfw", "Vendedor" as "Codigovendedororigen", "Bdaltafw" as "Basededatosaltafw", "Moneda" as "Monedacomprobante", "Codigo" as "Codigo", "Mobs" as "Observacion", "Cajaorig" as "Cajaorigen", "Zadsfw" as "Zadsfw", "Numero" as "Numero", "Origdest" as "Origendestino", "Fecha" as "Fecha", "Concepto" as "Concepto", "Tipo" as "Tipo", "Descvend" as "Nombrevendedororigen"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'VTRANS', '', tnTope )
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
	Function ObtenerDatosDetalleValores( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  VTRANSDET.CODDETVAL != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Coddetval" as "Codigo", "Tipo" as "Tipo", "Cotiza" as "Cotiza", "Nroitem" as "Nroitem", "Nrochprop" as "Codigochequepropio", "Nrocheque" as "Codigocheque", "Codval" as "Valor", "Descrip" as "Valordetalle", "Nrointerno" as "Numerointerno", "Fechaemi" as "Fechaemision", "Fechapago" as "Fechapago", "Estado" as "Estadoenorigen", "Monto" as "Monto"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleValores( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'VTRANSDET', 'Valores', tnTope )
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
				Case lcAtributo == 'COTIZACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COTIZ AS COTIZACION'
				Case lcAtributo == 'TIMESTAMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIMESTAMP AS TIMESTAMP'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'DESCRIPCIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCFW AS DESCRIPCIONFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'ESTADOSEGUNACCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTADOACC AS ESTADOSEGUNACCION'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'CODIGOVENDEDORORIGEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VENDEDOR AS CODIGOVENDEDORORIGEN'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'MONEDACOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONEDA AS MONEDACOMPROBANTE'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'OBSERVACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MOBS AS OBSERVACION'
				Case lcAtributo == 'CAJAORIGEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CAJAORIG AS CAJAORIGEN'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'NUMERO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NUMERO AS NUMERO'
				Case lcAtributo == 'ORIGENDESTINO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ORIGDEST AS ORIGENDESTINO'
				Case lcAtributo == 'FECHA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHA AS FECHA'
				Case lcAtributo == 'CONCEPTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CONCEPTO AS CONCEPTO'
				Case lcAtributo == 'TIPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPO AS TIPO'
				Case lcAtributo == 'NOMBREVENDEDORORIGEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCVEND AS NOMBREVENDEDORORIGEN'
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
	Function ObtenerCamposSelectDetalleValores( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODDETVAL AS CODIGO'
				Case lcAtributo == 'TIPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPO AS TIPO'
				Case lcAtributo == 'COTIZA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COTIZA AS COTIZA'
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'CODIGOCHEQUEPROPIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROCHPROP AS CODIGOCHEQUEPROPIO'
				Case lcAtributo == 'CODIGOCHEQUE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROCHEQUE AS CODIGOCHEQUE'
				Case lcAtributo == 'VALOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODVAL AS VALOR'
				Case lcAtributo == 'VALORDETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCRIP AS VALORDETALLE'
				Case lcAtributo == 'NUMEROINTERNO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROINTERNO AS NUMEROINTERNO'
				Case lcAtributo == 'FECHAEMISION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHAEMI AS FECHAEMISION'
				Case lcAtributo == 'FECHAPAGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHAPAGO AS FECHAPAGO'
				Case lcAtributo == 'ESTADOENORIGEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTADO AS ESTADOENORIGEN'
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
			Case upper( alltrim( tcAtributo ) ) == 'COTIZACION'
				lcCampo = 'COTIZ'
			Case upper( alltrim( tcAtributo ) ) == 'TIMESTAMP'
				lcCampo = 'TIMESTAMP'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCIONFW'
				lcCampo = 'DESCFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOSEGUNACCION'
				lcCampo = 'ESTADOACC'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGOVENDEDORORIGEN'
				lcCampo = 'VENDEDOR'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'MONEDACOMPROBANTE'
				lcCampo = 'MONEDA'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'OBSERVACION'
				lcCampo = 'MOBS'
			Case upper( alltrim( tcAtributo ) ) == 'CAJAORIGEN'
				lcCampo = 'CAJAORIG'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'NUMERO'
				lcCampo = 'NUMERO'
			Case upper( alltrim( tcAtributo ) ) == 'ORIGENDESTINO'
				lcCampo = 'ORIGDEST'
			Case upper( alltrim( tcAtributo ) ) == 'FECHA'
				lcCampo = 'FECHA'
			Case upper( alltrim( tcAtributo ) ) == 'CONCEPTO'
				lcCampo = 'CONCEPTO'
			Case upper( alltrim( tcAtributo ) ) == 'TIPO'
				lcCampo = 'TIPO'
			Case upper( alltrim( tcAtributo ) ) == 'NOMBREVENDEDORORIGEN'
				lcCampo = 'DESCVEND'
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
	Function ObtenerCampoDetalleValores( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODDETVAL'
			Case upper( alltrim( tcAtributo ) ) == 'TIPO'
				lcCampo = 'TIPO'
			Case upper( alltrim( tcAtributo ) ) == 'COTIZA'
				lcCampo = 'COTIZA'
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGOCHEQUEPROPIO'
				lcCampo = 'NROCHPROP'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGOCHEQUE'
				lcCampo = 'NROCHEQUE'
			Case upper( alltrim( tcAtributo ) ) == 'VALOR'
				lcCampo = 'CODVAL'
			Case upper( alltrim( tcAtributo ) ) == 'VALORDETALLE'
				lcCampo = 'DESCRIP'
			Case upper( alltrim( tcAtributo ) ) == 'NUMEROINTERNO'
				lcCampo = 'NROINTERNO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEMISION'
				lcCampo = 'FECHAEMI'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAPAGO'
				lcCampo = 'FECHAPAGO'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOENORIGEN'
				lcCampo = 'ESTADO'
			Case upper( alltrim( tcAtributo ) ) == 'MONTO'
				lcCampo = 'MONTO'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerTablaDetalle( tcDetalle as string ) as String
		local lcRetorno as string
		lcRetorno = ''
		if upper( alltrim( tcDetalle ) ) == 'COMPAFEC'
			lcRetorno = 'COMPAFE'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'VALORES'
			lcRetorno = 'VTRANSDET'
		EndIf
		return lcRetorno
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasInsert() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcSentencia as string, loItem as object
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxVtransFaltafw, lxVtransFectrans, lxVtransFecexpo, lxVtransFecimpo, lxVtransFmodifw, lxVtransCotiz, lxVtransTimestamp, lxVtransHoraexpo, lxVtransHaltafw, lxVtransUaltafw, lxVtransHoraimpo, lxVtransVmodifw, lxVtransDescfw, lxVtransValtafw, lxVtransUmodifw, lxVtransSaltafw, lxVtransSmodifw, lxVtransHmodifw, lxVtransEsttrans, lxVtransEstadoacc, lxVtransBdmodifw, lxVtransVendedor, lxVtransBdaltafw, lxVtransMoneda, lxVtransCodigo, lxVtransMobs, lxVtransCajaorig, lxVtransZadsfw, lxVtransNumero, lxVtransOrigdest, lxVtransFecha, lxVtransConcepto, lxVtransTipo, lxVtransDescvend
				lxVtransFaltafw =  .Fechaaltafw			lxVtransFectrans =  .Fechatransferencia			lxVtransFecexpo =  .Fechaexpo			lxVtransFecimpo =  .Fechaimpo			lxVtransFmodifw =  .Fechamodificacionfw			lxVtransCotiz =  .Cotizacion			lxVtransTimestamp = goLibrerias.ObtenerTimestamp()			lxVtransHoraexpo =  .Horaexpo			lxVtransHaltafw =  .Horaaltafw			lxVtransUaltafw =  .Usuarioaltafw			lxVtransHoraimpo =  .Horaimpo			lxVtransVmodifw =  .Versionmodificacionfw			lxVtransDescfw =  .Descripcionfw			lxVtransValtafw =  .Versionaltafw			lxVtransUmodifw =  .Usuariomodificacionfw			lxVtransSaltafw =  .Seriealtafw			lxVtransSmodifw =  .Seriemodificacionfw			lxVtransHmodifw =  .Horamodificacionfw			lxVtransEsttrans =  .Estadotransferencia			lxVtransEstadoacc =  .Estadosegunaccion			lxVtransBdmodifw =  .Basededatosmodificacionfw			lxVtransVendedor =  .Codigovendedororigen			lxVtransBdaltafw =  .Basededatosaltafw			lxVtransMoneda =  upper( .MonedaComprobante_PK ) 			lxVtransCodigo =  .Codigo			lxVtransMobs =  .Observacion			lxVtransCajaorig =  .Cajaorigen_PK 			lxVtransZadsfw =  .Zadsfw			lxVtransNumero =  .Numero			lxVtransOrigdest =  upper( .OrigenDestino_PK ) 			lxVtransFecha =  .Fecha			lxVtransConcepto =  upper( .Concepto_PK ) 			lxVtransTipo =  .Tipo			lxVtransDescvend =  .Nombrevendedororigen
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.VTRANS ( "Faltafw","Fectrans","Fecexpo","Fecimpo","Fmodifw","Cotiz","Timestamp","Horaexpo","Haltafw","Ualtafw","Horaimpo","Vmodifw","Descfw","Valtafw","Umodifw","Saltafw","Smodifw","Hmodifw","Esttrans","Estadoacc","Bdmodifw","Vendedor","Bdaltafw","Moneda","Codigo","Mobs","Cajaorig","Zadsfw","Numero","Origdest","Fecha","Concepto","Tipo","Descvend" ) values ( <<"'" + this.ConvertirDateSql( lxVtransFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxVtransFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxVtransFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxVtransFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxVtransFmodifw ) + "'" >>, <<lxVtransCotiz >>, <<lxVtransTimestamp >>, <<"'" + this.FormatearTextoSql( lxVtransHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVtransHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVtransUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVtransHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVtransVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVtransDescfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVtransValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVtransUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVtransSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVtransSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVtransHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVtransEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVtransEstadoacc ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVtransBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVtransVendedor ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVtransBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVtransMoneda ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVtransCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVtransMobs ) + "'" >>, <<lxVtransCajaorig >>, <<"'" + this.FormatearTextoSql( lxVtransZadsfw ) + "'" >>, <<lxVtransNumero >>, <<"'" + this.FormatearTextoSql( lxVtransOrigdest ) + "'" >>, <<"'" + this.ConvertirDateSql( lxVtransFecha ) + "'" >>, <<"'" + this.FormatearTextoSql( lxVtransConcepto ) + "'" >>, <<lxVtransTipo >>, <<"'" + this.FormatearTextoSql( lxVtransDescvend ) + "'" >> )
		endtext
		loColeccion.cTabla = 'VTRANS' 
		loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		With this
			local lcValorClavePrimariaString as String
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

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

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.Valores
				if this.oEntidad.Valores.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxTipo = loItem.Tipo
					lxCotiza = loItem.Cotiza
					lxNroitem = lnContadorNroItem
					lxCodigochequepropio_PK = loItem.Codigochequepropio_PK
					lxCodigocheque_PK = loItem.Codigocheque_PK
					lxValor_PK = loItem.Valor_PK
					lxValordetalle = loItem.Valordetalle
					lxNumerointerno = loItem.Numerointerno
					lxFechaemision = loItem.Fechaemision
					lxFechapago = loItem.Fechapago
					lxEstadoenorigen = loItem.Estadoenorigen
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.VTRANSDET("CodDetVal","Tipo","Cotiza","NROITEM","NroChProp","NroCheque","CodVal","Descrip","NroInterno","FechaEmi","FechaPago","Estado","monto" ) values ( << lcValorClavePrimariaString >>, <<lxTipo>>, <<lxCotiza>>, <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxCodigochequepropio_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigocheque_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerointerno ) + "'">>, <<"'" + this.ConvertirDateSql( lxFechaemision ) + "'">>, <<"'" + this.ConvertirDateSql( lxFechapago ) + "'">>, <<"'" + this.FormatearTextoSql( lxEstadoenorigen ) + "'">>, <<lxMonto>> ) 
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
			local  lxVtransFaltafw, lxVtransFectrans, lxVtransFecexpo, lxVtransFecimpo, lxVtransFmodifw, lxVtransCotiz, lxVtransTimestamp, lxVtransHoraexpo, lxVtransHaltafw, lxVtransUaltafw, lxVtransHoraimpo, lxVtransVmodifw, lxVtransDescfw, lxVtransValtafw, lxVtransUmodifw, lxVtransSaltafw, lxVtransSmodifw, lxVtransHmodifw, lxVtransEsttrans, lxVtransEstadoacc, lxVtransBdmodifw, lxVtransVendedor, lxVtransBdaltafw, lxVtransMoneda, lxVtransCodigo, lxVtransMobs, lxVtransCajaorig, lxVtransZadsfw, lxVtransNumero, lxVtransOrigdest, lxVtransFecha, lxVtransConcepto, lxVtransTipo, lxVtransDescvend
				lxVtransFaltafw =  .Fechaaltafw			lxVtransFectrans =  .Fechatransferencia			lxVtransFecexpo =  .Fechaexpo			lxVtransFecimpo =  .Fechaimpo			lxVtransFmodifw =  .Fechamodificacionfw			lxVtransCotiz =  .Cotizacion			lxVtransTimestamp = goLibrerias.ObtenerTimestamp()			lxVtransHoraexpo =  .Horaexpo			lxVtransHaltafw =  .Horaaltafw			lxVtransUaltafw =  .Usuarioaltafw			lxVtransHoraimpo =  .Horaimpo			lxVtransVmodifw =  .Versionmodificacionfw			lxVtransDescfw =  .Descripcionfw			lxVtransValtafw =  .Versionaltafw			lxVtransUmodifw =  .Usuariomodificacionfw			lxVtransSaltafw =  .Seriealtafw			lxVtransSmodifw =  .Seriemodificacionfw			lxVtransHmodifw =  .Horamodificacionfw			lxVtransEsttrans =  .Estadotransferencia			lxVtransEstadoacc =  .Estadosegunaccion			lxVtransBdmodifw =  .Basededatosmodificacionfw			lxVtransVendedor =  .Codigovendedororigen			lxVtransBdaltafw =  .Basededatosaltafw			lxVtransMoneda =  upper( .MonedaComprobante_PK ) 			lxVtransCodigo =  .Codigo			lxVtransMobs =  .Observacion			lxVtransCajaorig =  .Cajaorigen_PK 			lxVtransZadsfw =  .Zadsfw			lxVtransNumero =  .Numero			lxVtransOrigdest =  upper( .OrigenDestino_PK ) 			lxVtransFecha =  .Fecha			lxVtransConcepto =  upper( .Concepto_PK ) 			lxVtransTipo =  .Tipo			lxVtransDescvend =  .Nombrevendedororigen
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  VTRANS.CODIGO != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.VTRANS set "Faltafw" = <<"'" + this.ConvertirDateSql( lxVtransFaltafw ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxVtransFectrans ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxVtransFecexpo ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxVtransFecimpo ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxVtransFmodifw ) + "'">>, "Cotiz" = <<lxVtransCotiz>>, "Timestamp" = <<lxVtransTimestamp>>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxVtransHoraexpo ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxVtransHaltafw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxVtransUaltafw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxVtransHoraimpo ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxVtransVmodifw ) + "'">>, "Descfw" = <<"'" + this.FormatearTextoSql( lxVtransDescfw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxVtransValtafw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxVtransUmodifw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxVtransSaltafw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxVtransSmodifw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxVtransHmodifw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxVtransEsttrans ) + "'">>, "Estadoacc" = <<"'" + this.FormatearTextoSql( lxVtransEstadoacc ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxVtransBdmodifw ) + "'">>, "Vendedor" = <<"'" + this.FormatearTextoSql( lxVtransVendedor ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxVtransBdaltafw ) + "'">>, "Moneda" = <<"'" + this.FormatearTextoSql( lxVtransMoneda ) + "'">>, "Codigo" = <<"'" + this.FormatearTextoSql( lxVtransCodigo ) + "'">>, "Mobs" = <<"'" + this.FormatearTextoSql( lxVtransMobs ) + "'">>, "Cajaorig" = <<lxVtransCajaorig>>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxVtransZadsfw ) + "'">>, "Numero" = <<lxVtransNumero>>, "Origdest" = <<"'" + this.FormatearTextoSql( lxVtransOrigdest ) + "'">>, "Fecha" = <<"'" + this.ConvertirDateSql( lxVtransFecha ) + "'">>, "Concepto" = <<"'" + this.FormatearTextoSql( lxVtransConcepto ) + "'">>, "Tipo" = <<lxVtransTipo>>, "Descvend" = <<"'" + this.FormatearTextoSql( lxVtransDescvend ) + "'">> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'VTRANS' 
		loColeccion.agregar( strtran(  lcSentencia, chr( 9 ), '' ) )
			loColeccion.Agregar([delete from ZooLogic.CompAfe where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.VTRANSDET where "CodDetVal" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")

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

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.Valores
				if this.oEntidad.Valores.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxTipo = loItem.Tipo
					lxCotiza = loItem.Cotiza
					lxNroitem = lnContadorNroItem
					lxCodigochequepropio_PK = loItem.Codigochequepropio_PK
					lxCodigocheque_PK = loItem.Codigocheque_PK
					lxValor_PK = loItem.Valor_PK
					lxValordetalle = loItem.Valordetalle
					lxNumerointerno = loItem.Numerointerno
					lxFechaemision = loItem.Fechaemision
					lxFechapago = loItem.Fechapago
					lxEstadoenorigen = loItem.Estadoenorigen
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.VTRANSDET("CodDetVal","Tipo","Cotiza","NROITEM","NroChProp","NroCheque","CodVal","Descrip","NroInterno","FechaEmi","FechaPago","Estado","monto" ) values ( << lcValorClavePrimariaString >>, <<lxTipo>>, <<lxCotiza>>, <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxCodigochequepropio_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigocheque_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerointerno ) + "'">>, <<"'" + this.ConvertirDateSql( lxFechaemision ) + "'">>, <<"'" + this.ConvertirDateSql( lxFechapago ) + "'">>, <<"'" + this.FormatearTextoSql( lxEstadoenorigen ) + "'">>, <<lxMonto>> ) 
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

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  VTRANS.CODIGO != '']
		loColeccion.Agregar( 'delete from ZooLogic.VTRANS where ' + lcFiltro )
			loColeccion.Agregar([delete from ZooLogic.CompAfe where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.VTRANSDET where "CodDetVal" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.cTabla = 'VTRANS' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.VTRANS where  VTRANS.CODIGO != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.VTRANS where Codigo = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  VTRANS.CODIGO != ''" )
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
		local lcCursor as String, ldFecha as Date, lcHora as string, lcValorABuscar As String, lxValorClavePK As variant, lxValorClavePrimaria As variant, lcIdentificadorParaLoguear as string, lxVTRANSNumero as variant, lcMensajeExtra as String
		lcValorABuscar = ''
		lxValorClavePK = ''
		lcMensajeExtra = ''
		lcCursor = This.oEntidad.cPrefijoRecibir + 'VALORESENTRANSITO'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.VTRANS Where  Numero = ] + transform( &lcCursor..Numero     ), 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				lxValorClavePK = &lcCursor..Codigo
				if lxValorClavePK == curSeek.Codigo or this.oEntidad.lIgnorarClaveprimariaEnRecepcionBD 
					if lxValorClavePK != curSeek.Codigo and this.oEntidad.lIgnorarClaveprimariaEnRecepcionBD 
						lcValorABuscar = curSeek.Codigo
					else 
						lcValorABuscar = lxValorClavePK 
					endif 
					if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
						Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
						this.oConexion.EjecutarSql( [UPDATE ZooLogic.VTRANS set  FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, Cotiz = ] + transform( &lcCursor..Cotiz )+ [, TIMESTAMP = ] + transform( &lcCursor..TIMESTAMP )+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, DescFW = ] + "'" + this.FormatearTextoSql( &lcCursor..DescFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, EstadoAcc = ] + "'" + this.FormatearTextoSql( &lcCursor..EstadoAcc ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, Vendedor = ] + "'" + this.FormatearTextoSql( &lcCursor..Vendedor ) + "'"+ [, Moneda = ] + "'" + this.FormatearTextoSql( &lcCursor..Moneda ) + "'"+ [, Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'"+ [, MObs = ] + "'" + this.FormatearTextoSql( &lcCursor..MObs ) + "'"+ [, CajaOrig = ] + transform( &lcCursor..CajaOrig )+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, Numero = ] + transform( &lcCursor..Numero )+ [, OrigDest = ] + "'" + this.FormatearTextoSql( &lcCursor..OrigDest ) + "'"+ [, Fecha = ] + "'" + this.ConvertirDateSql( &lcCursor..Fecha ) + "'"+ [, Concepto = ] + "'" + this.FormatearTextoSql( &lcCursor..Concepto ) + "'"+ [, Tipo = ] + transform( &lcCursor..Tipo )+ [, DescVend = ] + "'" + this.FormatearTextoSql( &lcCursor..DescVend ) + "'" + [ Where Codigo = ] + "'" + this.FormatearTextoSql( lcValorABuscar ) + "'" )
						this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
					else
						this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
					endIf
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir porque no coincide la clave principal.', tlLoguear )
				endIf
			else
				this.oConexion.EjecutarSql( [Select * From ZooLogic.VTRANS Where Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'", 'curSeek', this.datasessionid )
				if reccount( 'curSeek' ) > 0
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir como alta porque la clave principal ya existe', tlLoguear )
				Else
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					Text to lcCampos noShow
						 FALTAFW, FECTRANS, FECEXPO, FECIMPO, FMODIFW, Cotiz, TIMESTAMP, HORAEXPO, HALTAFW, UALTAFW, HORAIMPO, VMODIFW, DescFW, VALTAFW, UMODIFW, SALTAFW, SMODIFW, HMODIFW, ESTTRANS, EstadoAcc, BDMODIFW, Vendedor, BDALTAFW, Moneda, Codigo, MObs, CajaOrig, ZADSFW, Numero, OrigDest, Fecha, Concepto, Tipo, DescVend
					EndText
					local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + transform( &lcCursor..Cotiz ) + ',' + transform( &lcCursor..TIMESTAMP )
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..DescFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..EstadoAcc ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..Vendedor ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Moneda ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..MObs ) + "'" + ',' + transform( &lcCursor..CajaOrig ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..Numero ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..OrigDest ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..Fecha ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Concepto ) + "'" + ',' + transform( &lcCursor..Tipo ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..DescVend ) + "'"
lcValoresCampos = substr(lcValoresCampos,2) 

					this.oConexion.EjecutarSql( [Insert into ZooLogic.VTRANS ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
				EndIf
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'VALORESENTRANSITO'
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
			this.oConexion.EjecutarSql( [Delete From ZooLogic.CompAfe Where Codigo] + lcIn  )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.VTRANSDET Where CodDetVal] + lcIn  )
			endfor
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'COMMIT TRANSACTION' )
			endif
		EndIf
	endif
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
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMVALORESENTRANSITO'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where CodDetVal in ( select Codigo from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"CodDetVal","Tipo","Cotiza","NROITEM","NroChProp","NroCheque","CodVal","Descrip","NroInterno","FechaEmi","FechaPago","Estado","monto"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.VTRANSDET ( ] + lcCamposInsert + [ ) values ( ] +  "'" + this.FormatearTextoSql( cDetallesExistentes.CodDetVal  ) + "'" + ',' + transform( cDetallesExistentes.Tipo       ) + ',' + transform( cDetallesExistentes.Cotiza     ) + ',' + transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.NroChProp  ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.NroCheque  ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CodVal     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Descrip    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.NroInterno ) + "'" + ',' + "'" + this.ConvertirDateSql( cDetallesExistentes.FechaEmi   ) + "'" + ',' + "'" + this.ConvertirDateSql( cDetallesExistentes.FechaPago  ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Estado     ) + "'" + ',' + transform( cDetallesExistentes.monto      ) + ' )'  )
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
		
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function ObtenerIdentificadorParaLoguear( tcCursor as String ) As String
		local lcRetorno as String, lnCC as String , loCC as Object, lni as Integer, lcSecuencia as String
		lcRetorno = this.oEntidad.cDescripcion 
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
			Case  lcAlias == lcPrefijo + 'VALORESENTRANSITO'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'VALORESENTRANSITO_MOBS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'VALORESENTRANSITO_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMCOMPROBANTE'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMVALORESENTRANSITO'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_VTRANS')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'VALORESENTRANSITO'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..Codigo
		llCondicion = isnull( lxVar ) or isnull( &lcCursor..Numero )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad VALORESENTRANSITO. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'VALORESENTRANSITO'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		select recno() as _Rec, * from &lcCursor into cursor CurConRecno
		select max( _Rec ) as Maximo,Codigo as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( Codigo, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		select max( _Rec ) as Maximo,str( Numero, 8, 0) as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( str( Numero, 8, 0), 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		Use in select( 'CurConRecno' )
		Use in select( 'RepMax' )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDatosInvalidos( toConexion as Object ) as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'VALORESENTRANSITO'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  Fecha     
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_VTRANS') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_VTRANS
Create Table ZooLogic.TablaTrabajo_VTRANS ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"faltafw" datetime  null, 
"fectrans" datetime  null, 
"fecexpo" datetime  null, 
"fecimpo" datetime  null, 
"fmodifw" datetime  null, 
"cotiz" numeric( 15, 5 )  null, 
"timestamp" numeric( 20, 0 )  null, 
"horaexpo" char( 8 )  null, 
"haltafw" char( 8 )  null, 
"ualtafw" char( 100 )  null, 
"horaimpo" char( 8 )  null, 
"vmodifw" char( 13 )  null, 
"descfw" char( 200 )  null, 
"valtafw" char( 13 )  null, 
"umodifw" char( 100 )  null, 
"saltafw" char( 7 )  null, 
"smodifw" char( 7 )  null, 
"hmodifw" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"estadoacc" char( 1 )  null, 
"bdmodifw" char( 8 )  null, 
"vendedor" char( 10 )  null, 
"bdaltafw" char( 8 )  null, 
"moneda" char( 10 )  null, 
"codigo" char( 20 )  null, 
"mobs" varchar(max)  null, 
"cajaorig" numeric( 2, 0 )  null, 
"zadsfw" varchar(max)  null, 
"numero" numeric( 8, 0 )  null, 
"origdest" char( 8 )  null, 
"fecha" datetime  null, 
"concepto" char( 10 )  null, 
"tipo" numeric( 1, 0 )  null, 
"descvend" char( 80 )  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_VTRANS' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_VTRANS' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'VALORESENTRANSITO'
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
			.AgregarMapeo('cotiz','cotiz')
			.AgregarMapeo('timestamp','timestamp')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('descfw','descfw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('estadoacc','estadoacc')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('vendedor','vendedor')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('moneda','moneda')
			.AgregarMapeo('codigo','codigo')
			.AgregarMapeo('mobs','mobs')
			.AgregarMapeo('cajaorig','cajaorig')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('numero','numero')
			.AgregarMapeo('origdest','origdest')
			.AgregarMapeo('fecha','fecha')
			.AgregarMapeo('concepto','concepto')
			.AgregarMapeo('tipo','tipo')
			.AgregarMapeo('descvend','descvend')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_VTRANS'
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
				Update t Set t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.COTIZ = isnull( d.COTIZ, t.COTIZ ),t.TIMESTAMP = isnull( d.TIMESTAMP, t.TIMESTAMP ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.DESCFW = isnull( d.DESCFW, t.DESCFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.ESTADOACC = isnull( d.ESTADOACC, t.ESTADOACC ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.VENDEDOR = isnull( d.VENDEDOR, t.VENDEDOR ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.MONEDA = isnull( d.MONEDA, t.MONEDA ),t.CODIGO = isnull( d.CODIGO, t.CODIGO ),t.MOBS = isnull( d.MOBS, t.MOBS ),t.CAJAORIG = isnull( d.CAJAORIG, t.CAJAORIG ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.NUMERO = isnull( d.NUMERO, t.NUMERO ),t.ORIGDEST = isnull( d.ORIGDEST, t.ORIGDEST ),t.FECHA = isnull( d.FECHA, t.FECHA ),t.CONCEPTO = isnull( d.CONCEPTO, t.CONCEPTO ),t.TIPO = isnull( d.TIPO, t.TIPO ),t.DESCVEND = isnull( d.DESCVEND, t.DESCVEND )
					from ZooLogic.VTRANS t inner join deleted d 
							 on t.Codigo = d.Codigo
							 and  t.Numero = d.Numero
				-- Fin Updates
				insert into ZooLogic.VTRANS(Faltafw,Fectrans,Fecexpo,Fecimpo,Fmodifw,Cotiz,Timestamp,Horaexpo,Haltafw,Ualtafw,Horaimpo,Vmodifw,Descfw,Valtafw,Umodifw,Saltafw,Smodifw,Hmodifw,Esttrans,Estadoacc,Bdmodifw,Vendedor,Bdaltafw,Moneda,Codigo,Mobs,Cajaorig,Zadsfw,Numero,Origdest,Fecha,Concepto,Tipo,Descvend)
					Select CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FECTRANS,''),isnull( d.FECEXPO,''),isnull( d.FECIMPO,''),isnull( d.FMODIFW,''),isnull( d.COTIZ,0),isnull( d.TIMESTAMP,0),isnull( d.HORAEXPO,''),convert( char(8), getdate(), 108 ),isnull( d.UALTAFW,''),isnull( d.HORAIMPO,''),isnull( d.VMODIFW,''),isnull( d.DESCFW,''),isnull( d.VALTAFW,''),isnull( d.UMODIFW,''),isnull( d.SALTAFW,''),isnull( d.SMODIFW,''),isnull( d.HMODIFW,''),isnull( d.ESTTRANS,''),isnull( d.ESTADOACC,''),isnull( d.BDMODIFW,''),isnull( d.VENDEDOR,''),isnull( d.BDALTAFW,''),isnull( d.MONEDA,''),isnull( d.CODIGO,''),isnull( d.MOBS,''),isnull( d.CAJAORIG,0),isnull( d.ZADSFW,''),isnull( d.NUMERO,0),isnull( d.ORIGDEST,''),isnull( d.FECHA,''),isnull( d.CONCEPTO,''),isnull( d.TIPO,0),isnull( d.DESCVEND,'')
						From deleted d left join ZooLogic.VTRANS pk 
							 on d.Codigo = pk.Codigo
						 left join ZooLogic.VTRANS cc 
							 on  d.Numero = cc.Numero
						Where pk.Codigo Is Null 
							 and cc.Numero Is Null 
				-- Fin Inserts
				Insert into ZooLogic.Logueos ( Fecha, Nivel, Logger, Accion, BaseDeDatos, 
					EstadoDelSistema, Aplicacion, Version, 
					Serie, Usuario, NombrePc, 
					UsuarioPc, OrigenLogueo, Mensaje, Excepcion)
				select GetDate(), 'INFO', '', 'Importación <<lcEntidad>>','<<loLogueo.BaseDatos>>',
					<<loLogueo.EstadoSistema>>,'<<loLogueo.Aplicacion>>','<<loLogueo.Version>>',
					'<<loLogueo.Serie>>','<<loLogueo.Usuario>>','<<loLogueo.NombrePc>>',
					'<<loLogueo.UsuarioPc>>','<<loLogueo.OrigenLogueo>>','No se pudo importar la entidad <<lcEntidad>>: NÚMERO ' + cast( d.Numero as Varchar(8) ) + '','La clave principal no es la esperada'
					from ZooLogic.VTRANS t inner join deleted d 
							on   t.Numero = d.Numero
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
					'<<loLogueo.UsuarioPc>>','<<loLogueo.OrigenLogueo>>','No se pudo importar la entidad <<lcEntidad>>: NÚMERO ' + cast( d.Numero as Varchar(8) ) + '','La clave principal a importar ya existe'
					from ZooLogic.VTRANS t inner join deleted d 
							 on t.Codigo = d.Codigo
						left join deleted h 
							on   t.Numero = h.Numero
							where   h.Numero is null 
			End
		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_CompAfe( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_VTRANS_CompAfe
ON ZooLogic.TablaTrabajo_VTRANS_CompAfe
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
	function ObtenerTriggerDeleteImportacion_VTRANSDET( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_VTRANS_VTRANSDET
ON ZooLogic.TablaTrabajo_VTRANS_VTRANSDET
AFTER DELETE
As
Begin
Update t Set 
t.CODDETVAL = isnull( d.CODDETVAL, t.CODDETVAL ),
t.TIPO = isnull( d.TIPO, t.TIPO ),
t.COTIZA = isnull( d.COTIZA, t.COTIZA ),
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.NROCHPROP = isnull( d.NROCHPROP, t.NROCHPROP ),
t.NROCHEQUE = isnull( d.NROCHEQUE, t.NROCHEQUE ),
t.CODVAL = isnull( d.CODVAL, t.CODVAL ),
t.DESCRIP = isnull( d.DESCRIP, t.DESCRIP ),
t.NROINTERNO = isnull( d.NROINTERNO, t.NROINTERNO ),
t.FECHAEMI = isnull( d.FECHAEMI, t.FECHAEMI ),
t.FECHAPAGO = isnull( d.FECHAPAGO, t.FECHAPAGO ),
t.ESTADO = isnull( d.ESTADO, t.ESTADO ),
t.MONTO = isnull( d.MONTO, t.MONTO )
from ZooLogic.VTRANSDET t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.VTRANSDET
( 
"CODDETVAL",
"TIPO",
"COTIZA",
"NROITEM",
"NROCHPROP",
"NROCHEQUE",
"CODVAL",
"DESCRIP",
"NROINTERNO",
"FECHAEMI",
"FECHAPAGO",
"ESTADO",
"MONTO"
 )
Select 
d.CODDETVAL,
d.TIPO,
d.COTIZA,
d.NROITEM,
d.NROCHPROP,
d.NROCHEQUE,
d.CODVAL,
d.DESCRIP,
d.NROINTERNO,
d.FECHAEMI,
d.FECHAPAGO,
d.ESTADO,
d.MONTO
From deleted d left join ZooLogic.VTRANSDET pk 
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_VTRANS') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_VTRANS
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_VALORESENTRANSITO' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_VALORESENTRANSITO.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_VALORESENTRANSITO.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_VALORESENTRANSITO.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_VALORESENTRANSITO.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_VALORESENTRANSITO.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Cotizacion = nvl( c_VALORESENTRANSITO.Cotizacion, 0 )
					.Compafec.Limpiar()
					.Compafec.SetearEsNavegacion( .lProcesando )
					.Compafec.Cargar()
					.Timestamp = nvl( c_VALORESENTRANSITO.Timestamp, 0 )
					.Horaexpo = nvl( c_VALORESENTRANSITO.Horaexpo, [] )
					.Horaaltafw = nvl( c_VALORESENTRANSITO.Horaaltafw, [] )
					.Usuarioaltafw = nvl( c_VALORESENTRANSITO.Usuarioaltafw, [] )
					.Horaimpo = nvl( c_VALORESENTRANSITO.Horaimpo, [] )
					.Versionmodificacionfw = nvl( c_VALORESENTRANSITO.Versionmodificacionfw, [] )
					.Descripcionfw = nvl( c_VALORESENTRANSITO.Descripcionfw, [] )
					.Versionaltafw = nvl( c_VALORESENTRANSITO.Versionaltafw, [] )
					.Usuariomodificacionfw = nvl( c_VALORESENTRANSITO.Usuariomodificacionfw, [] )
					.Seriealtafw = nvl( c_VALORESENTRANSITO.Seriealtafw, [] )
					.Seriemodificacionfw = nvl( c_VALORESENTRANSITO.Seriemodificacionfw, [] )
					.Horamodificacionfw = nvl( c_VALORESENTRANSITO.Horamodificacionfw, [] )
					.Estadotransferencia = nvl( c_VALORESENTRANSITO.Estadotransferencia, [] )
					.Estadosegunaccion = nvl( c_VALORESENTRANSITO.Estadosegunaccion, [] )
					.Basededatosmodificacionfw = nvl( c_VALORESENTRANSITO.Basededatosmodificacionfw, [] )
					.Codigovendedororigen = nvl( c_VALORESENTRANSITO.Codigovendedororigen, [] )
					.Basededatosaltafw = nvl( c_VALORESENTRANSITO.Basededatosaltafw, [] )
					.Monedacomprobante_PK =  nvl( c_VALORESENTRANSITO.Monedacomprobante, [] )
					.Codigo = nvl( c_VALORESENTRANSITO.Codigo, [] )
					lcValor = This.ObtenerMemo( 'c_Observacion')
					.Observacion = lcValor 
					.Valores.Limpiar()
					.Valores.SetearEsNavegacion( .lProcesando )
					.Valores.Cargar()
					.Cajaorigen_PK =  nvl( c_VALORESENTRANSITO.Cajaorigen, 0 )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Numero = nvl( c_VALORESENTRANSITO.Numero, 0 )
					.Origendestino_PK =  nvl( c_VALORESENTRANSITO.Origendestino, [] )
					.Fecha = GoLibrerias.ObtenerFechaFormateada( nvl( c_VALORESENTRANSITO.Fecha, ctod( '  /  /    ' ) ) )
					.Concepto_PK =  nvl( c_VALORESENTRANSITO.Concepto, [] )
					.Tipo = nvl( c_VALORESENTRANSITO.Tipo, 0 )
					.Nombrevendedororigen = nvl( c_VALORESENTRANSITO.Nombrevendedororigen, [] )
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
			lxRetorno = c_VALORESENTRANSITO.CODIGO
		endif
		return lxRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function ActualizarLosNROItemDeLosDetalles() as void
		local loDetalle as object, loItem as object, lnContadorNroItem as integer, lnIndex as integer
		
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

	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function ObtenerMemo( tcTabla as String ) as string
		local lcAtributo as string
		lcAtributo = strtran( tcTabla, 'c_', '' )
		return c_VALORESENTRANSITO.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.VTRANS' )
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
								from ZooLogic.VTRANS 
								Where   VTRANS.CODIGO != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "VTRANS", "", lcCursor, set("Datasession") )
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
			"Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Cotiz" as "Cotizacion", "Timestamp" as "Timestamp", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Ualtafw" as "Usuarioaltafw", "Horaimpo" as "Horaimpo", "Vmodifw" as "Versionmodificacionfw", "Descfw" as "Descripcionfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Esttrans" as "Estadotransferencia", "Estadoacc" as "Estadosegunaccion", "Bdmodifw" as "Basededatosmodificacionfw", "Vendedor" as "Codigovendedororigen", "Bdaltafw" as "Basededatosaltafw", "Moneda" as "Monedacomprobante", "Codigo" as "Codigo", "Mobs" as "Observacion", "Cajaorig" as "Cajaorigen", "Zadsfw" as "Zadsfw", "Numero" as "Numero", "Origdest" as "Origendestino", "Fecha" as "Fecha", "Concepto" as "Concepto", "Tipo" as "Tipo", "Descvend" as "Nombrevendedororigen"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.VTRANS 
								Where   VTRANS.CODIGO != ''
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
	Tabla = 'VTRANS'
	Filtro = " VTRANS.CODIGO != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " VTRANS.CODIGO != ''"
	AnchoCampo = 13
	Caracteres = 13
	nrodecolumnas = 0
	signopregunta = .T.
	signopregunta2 = .t.
	TablaAuxiliar = .f.
	cOrden = "VTRANS.Numero"
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
	<row entidad="VALORESENTRANSITO                       " atributo="FECHAALTAFW                             " tabla="VTRANS         " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALORESENTRANSITO                       " atributo="FECHATRANSFERENCIA                      " tabla="VTRANS         " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha transferencia                                                                                                                                             " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALORESENTRANSITO                       " atributo="FECHAEXPO                               " tabla="VTRANS         " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALORESENTRANSITO                       " atributo="FECHAIMPO                               " tabla="VTRANS         " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALORESENTRANSITO                       " atributo="FECHAMODIFICACIONFW                     " tabla="VTRANS         " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALORESENTRANSITO                       " atributo="COTIZACION                              " tabla="VTRANS         " campo="COTIZ     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="5" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICONONEGATIVO            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALORESENTRANSITO                       " atributo="COMPAFEC                                " tabla="COMPAFE        " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="DETALLEITEMCOMPROBANTE        " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALORESENTRANSITO                       " atributo="TIMESTAMP                               " tabla="VTRANS         " campo="TIMESTAMP " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALORESENTRANSITO                       " atributo="HORAEXPO                                " tabla="VTRANS         " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALORESENTRANSITO                       " atributo="HORAALTAFW                              " tabla="VTRANS         " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALORESENTRANSITO                       " atributo="USUARIOALTAFW                           " tabla="VTRANS         " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALORESENTRANSITO                       " atributo="HORAIMPO                                " tabla="VTRANS         " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALORESENTRANSITO                       " atributo="VERSIONMODIFICACIONFW                   " tabla="VTRANS         " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALORESENTRANSITO                       " atributo="DESCRIPCIONFW                           " tabla="VTRANS         " campo="DESCFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="200" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALORESENTRANSITO                       " atributo="VERSIONALTAFW                           " tabla="VTRANS         " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALORESENTRANSITO                       " atributo="USUARIOMODIFICACIONFW                   " tabla="VTRANS         " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALORESENTRANSITO                       " atributo="SERIEALTAFW                             " tabla="VTRANS         " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALORESENTRANSITO                       " atributo="SERIEMODIFICACIONFW                     " tabla="VTRANS         " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALORESENTRANSITO                       " atributo="HORAMODIFICACIONFW                      " tabla="VTRANS         " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALORESENTRANSITO                       " atributo="ESTADOTRANSFERENCIA                     " tabla="VTRANS         " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado transferencia                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALORESENTRANSITO                       " atributo="ESTADOSEGUNACCION                       " tabla="VTRANS         " campo="ESTADOACC " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado                                                                                                                                                          " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALORESENTRANSITO                       " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="VTRANS         " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALORESENTRANSITO                       " atributo="CODIGOVENDEDORORIGEN                    " tabla="VTRANS         " campo="VENDEDOR  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Vendedor origen                                                                                                                                                 " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALORESENTRANSITO                       " atributo="BASEDEDATOSALTAFW                       " tabla="VTRANS         " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALORESENTRANSITO                       " atributo="MONEDACOMPROBANTE                       " tabla="VTRANS         " campo="MONEDA    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="MONEDA                                  " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Moneda Comprobante                                                                                                                                              " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALORESENTRANSITO                       " atributo="CODIGO                                  " tabla="VTRANS         " campo="CODIGO    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="14" etiqueta="Número interno                                                                                                                                                  " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALORESENTRANSITO                       " atributo="OBSERVACION                             " tabla="VTRANS         " campo="MOBS      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="Observaciones                                                                                                                                                   " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALORESENTRANSITO                       " atributo="VALORES                                 " tabla="VTRANSDET      " campo="CODDETVAL " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="402" etiqueta="Detalle de valores                                                                                                                                              " dominio="DETALLEITEMVALORESENTRANSITO  " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALORESENTRANSITO                       " atributo="CAJAORIGEN                              " tabla="VTRANS         " campo="CAJAORIG  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CAJAESTADO                              " tipodato="N         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Caja origen                                                                                                                                                     " dominio="CODIGONUMERICO                " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALORESENTRANSITO                       " atributo="ZADSFW                                  " tabla="VTRANS         " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="404" etiqueta="Acciones del sistema                                                                                                                                            " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="4" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALORESENTRANSITO                       " atributo="NUMERO                                  " tabla="VTRANS         " campo="NUMERO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="4" etiqueta="Número                                                                                                                                                          " dominio="CLAVECANDIDATA                " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="1" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALORESENTRANSITO                       " atributo="ORIGENDESTINO                           " tabla="VTRANS         " campo="ORIGDEST  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="ORIGENDEDATOS                           " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="6" etiqueta="Origen/destino                                                                                                                                                  " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALORESENTRANSITO                       " atributo="FECHA                                   " tabla="VTRANS         " campo="FECHA     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goServicios.librerias.ObtenerFecha()                                                                                                                                                                                                                         " obligatorio="true" admitebusqueda="2" etiqueta="Fecha                                                                                                                                                           " dominio="FECHACOMPROBANTE              " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALORESENTRANSITO                       " atributo="CONCEPTO                                " tabla="VTRANS         " campo="CONCEPTO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CONCEPTOCAJA                            " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="8" etiqueta="Concepto                                                                                                                                                        " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALORESENTRANSITO                       " atributo="TIPO                                    " tabla="VTRANS         " campo="TIPO      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="10" etiqueta="Tipo                                                                                                                                                            " dominio="COMBOXML                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALORESENTRANSITO                       " atributo="NOMBREVENDEDORORIGEN                    " tabla="VTRANS         " campo="DESCVEND  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="80" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="12" etiqueta="Vendedor                                                                                                                                                        " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORIGENDEDATOS                           " atributo="DESCRIPCION                             " tabla="ORDAT          " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="7" etiqueta="Detalle Ori.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join ORDAT On VTRANS.ORIGDEST = ORDAT.codigo And  ORDAT.CODIGO != ''                                                                                                                                                                                    " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONCEPTOCAJA                            " atributo="DESCRIPCION                             " tabla="CONCECAJA      " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="9" etiqueta="Detalle Con.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CONCECAJA On VTRANS.CONCEPTO = CONCECAJA.Codigo And  CONCECAJA.CODIGO != ''                                                                                                                                                                        " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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