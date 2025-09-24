
define class Din_EntidadMERCADERIAENTRANSITOAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_MERCADERIAENTRANSITO'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = [str( Numero, 8, 0)]
	cExpresionCCPorCampos = [str( #tabla#.NUMERO, 8, 0)]
	cTagClaveCandidata = '_MTRCC'
	cTagClavePk = '_MTRPK'
	cTablaPrincipal = 'MTRANS'
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
			local  lxMtransFecimpo, lxMtransFechaori, lxMtransFecexpo, lxMtransFmodifw, lxMtransFaltafw, lxMtransFectrans, lxMtransHoraexpo, lxMtransBdaltafw, lxMtransHoraimpo, lxMtransBdmodifw, lxMtransEsttrans, lxMtransUmodifw, lxMtransHmodifw, lxMtransDescfw, lxMtransZadsfw, lxMtransVmodifw, lxMtransValtafw, lxMtransSaltafw, lxMtransSmodifw, lxMtransHaltafw, lxMtransUaltafw, lxMtransTimestamp, lxMtransClase, lxMtransAnulado, lxMtransCodigo, lxMtransMobs, lxMtransOrigdest, lxMtransNumero, lxMtransNumeroori, lxMtransFecha, lxMtransDirmov, lxMtransDatori, lxMtransMotivo, lxMtransVendedor, lxMtransOrigtipo, lxMtransRemito, lxMtransOrigletra, lxMtransMotremorg, lxMtransMovgen, lxMtransOrigpvta, lxMtransCompgen, lxMtransOrignro, lxMtransFpodes, lxMtransMd3, lxMtransRecpor, lxMtransMr2
				lxMtransFecimpo =  .Fechaimpo			lxMtransFechaori =  .Fechaoriginal			lxMtransFecexpo =  .Fechaexpo			lxMtransFmodifw =  .Fechamodificacionfw			lxMtransFaltafw =  .Fechaaltafw			lxMtransFectrans =  .Fechatransferencia			lxMtransHoraexpo =  .Horaexpo			lxMtransBdaltafw =  .Basededatosaltafw			lxMtransHoraimpo =  .Horaimpo			lxMtransBdmodifw =  .Basededatosmodificacionfw			lxMtransEsttrans =  .Estadotransferencia			lxMtransUmodifw =  .Usuariomodificacionfw			lxMtransHmodifw =  .Horamodificacionfw			lxMtransDescfw =  .Descripcionfw			lxMtransZadsfw =  .Zadsfw			lxMtransVmodifw =  .Versionmodificacionfw			lxMtransValtafw =  .Versionaltafw			lxMtransSaltafw =  .Seriealtafw			lxMtransSmodifw =  .Seriemodificacionfw			lxMtransHaltafw =  .Horaaltafw			lxMtransUaltafw =  .Usuarioaltafw			lxMtransTimestamp = goLibrerias.ObtenerTimestamp()			lxMtransClase =  .Clase			lxMtransAnulado =  .Anulado			lxMtransCodigo =  .Codigo			lxMtransMobs =  .Observacion			lxMtransOrigdest =  upper( .OrigenDestino_PK ) 			lxMtransNumero =  .Numero			lxMtransNumeroori =  .Numerooriginal			lxMtransFecha =  .Fecha			lxMtransDirmov =  .Tipo			lxMtransDatori =  .Datosadicionales			lxMtransMotivo =  upper( .Motivo_PK ) 			lxMtransVendedor =  upper( .vendedor_PK ) 			lxMtransOrigtipo =  .Origtipo			lxMtransRemito =  .Remito			lxMtransOrigletra =  .Origletra			lxMtransMotremorg =  .Motivoremitoorigen			lxMtransMovgen =  .Movimientogenerado			lxMtransOrigpvta =  .Origptovta			lxMtransCompgen =  .Comprobantegenerado			lxMtransOrignro =  .Orignumero			lxMtransFpodes =  .Porcentajedescuento			lxMtransMd3 =  .Montodescuento3			lxMtransRecpor =  .Recargoporcentaje			lxMtransMr2 =  .Recargomonto2
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxMtransCodigo = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.MTRANS ( "Fecimpo","Fechaori","Fecexpo","Fmodifw","Faltafw","Fectrans","Horaexpo","Bdaltafw","Horaimpo","Bdmodifw","Esttrans","Umodifw","Hmodifw","Descfw","Zadsfw","Vmodifw","Valtafw","Saltafw","Smodifw","Haltafw","Ualtafw","Timestamp","Clase","Anulado","Codigo","Mobs","Origdest","Numero","Numeroori","Fecha","Dirmov","Datori","Motivo","Vendedor","Origtipo","Remito","Origletra","Motremorg","Movgen","Origpvta","Compgen","Orignro","Fpodes","Md3","Recpor","Mr2" ) values ( <<"'" + this.ConvertirDateSql( lxMtransFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxMtransFechaori ) + "'" >>, <<"'" + this.ConvertirDateSql( lxMtransFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxMtransFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxMtransFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxMtransFectrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMtransHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMtransBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMtransHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMtransBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMtransEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMtransUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMtransHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMtransDescfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMtransZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMtransVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMtransValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMtransSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMtransSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMtransHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMtransUaltafw ) + "'" >>, <<lxMtransTimestamp >>, <<lxMtransClase >>, <<iif( lxMtransAnulado, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxMtransCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMtransMobs ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMtransOrigdest ) + "'" >>, <<lxMtransNumero >>, <<lxMtransNumeroori >>, <<"'" + this.ConvertirDateSql( lxMtransFecha ) + "'" >>, <<lxMtransDirmov >>, <<"'" + this.FormatearTextoSql( lxMtransDatori ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMtransMotivo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMtransVendedor ) + "'" >>, <<lxMtransOrigtipo >>, <<"'" + this.FormatearTextoSql( lxMtransRemito ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMtransOrigletra ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMtransMotremorg ) + "'" >>, <<lxMtransMovgen >>, <<lxMtransOrigpvta >>, <<"'" + this.FormatearTextoSql( lxMtransCompgen ) + "'" >>, <<lxMtransOrignro >>, <<lxMtransFpodes >>, <<lxMtransMd3 >>, <<lxMtransRecpor >>, <<lxMtransMr2 >> )
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
			for each loItem in this.oEntidad.COMPAFEC
				if this.oEntidad.COMPAFEC.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxTipocomprobante = loItem.Tipocomprobante
					lxNroitem = lnContadorNroItem
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
						Insert into ZooLogic.CompAfe("AfeTipoCom","NROITEM","Codigo","AfeComprob","AfeLETRA","AfePTOVEN","AfeNUMCOM","afefecha","afetotal","afevend","afetipo","Afecta","DescInter","NomInter","CodInter","Origen" ) values ( <<lxTipocomprobante>>, <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipocompcaracter ) + "'">>, <<"'" + this.FormatearTextoSql( lxLetra ) + "'">>, <<lxPuntodeventa>>, <<lxNumero>>, <<"'" + this.ConvertirDateSql( lxFecha ) + "'">>, <<lxTotal>>, <<"'" + this.FormatearTextoSql( lxVendedor ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipo ) + "'">>, <<"'" + this.FormatearTextoSql( lxAfecta ) + "'">>, <<"'" + this.FormatearTextoSql( lxInterviniente ) + "'">>, <<"'" + this.FormatearTextoSql( lxNombreentidad ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigoentidad ) + "'">>, <<"'" + this.FormatearTextoSql( lxOrigen ) + "'">> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.MovimientoDetalle
				if this.oEntidad.MovimientoDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxIditemarticulos = loItem.Iditemarticulos
					lxPorcentajeiva = loItem.Porcentajeiva
					lxComportamiento = loItem.Comportamiento
					lxNroitem = lnContadorNroItem
					lxNoprocesarstock = loItem.Noprocesarstock
					lxEquivalencia_PK = loItem.Equivalencia_PK
					lxArticulo_PK = loItem.Articulo_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxTalledetalle = loItem.Talledetalle
					lxTalle_PK = loItem.Talle_PK
					lxCantidad = loItem.Cantidad
					lxPrecioconimpuestos = loItem.Precioconimpuestos
					lxPreciosinimpuestos = loItem.Preciosinimpuestos
					lxDescuento = loItem.Descuento
					lxMontodescuento = loItem.Montodescuento
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.DETMTRANS("IdItem","fporIva","COMP","NROITEM","ProcStock","Equiv","NUMR","MART","DESCRIP","cColor","COLTXT","TALLTXT","Talle","CANTI","prunconimp","prunSInimp","FCFI","MNTDES" ) values ( <<"'" + this.FormatearTextoSql( lxIditemarticulos ) + "'">>, <<lxPorcentajeiva>>, <<lxComportamiento>>, <<lxNroitem>>, <<iif( lxNoprocesarstock, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxEquivalencia_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalledetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<lxCantidad>>, <<lxPrecioconimpuestos>>, <<lxPreciosinimpuestos>>, <<lxDescuento>>, <<lxMontodescuento>> ) 
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
		this.oEntidad.Timestamp = lxMtransTimestamp
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
			local  lxMtransFecimpo, lxMtransFechaori, lxMtransFecexpo, lxMtransFmodifw, lxMtransFaltafw, lxMtransFectrans, lxMtransHoraexpo, lxMtransBdaltafw, lxMtransHoraimpo, lxMtransBdmodifw, lxMtransEsttrans, lxMtransUmodifw, lxMtransHmodifw, lxMtransDescfw, lxMtransZadsfw, lxMtransVmodifw, lxMtransValtafw, lxMtransSaltafw, lxMtransSmodifw, lxMtransHaltafw, lxMtransUaltafw, lxMtransTimestamp, lxMtransClase, lxMtransAnulado, lxMtransCodigo, lxMtransMobs, lxMtransOrigdest, lxMtransNumero, lxMtransNumeroori, lxMtransFecha, lxMtransDirmov, lxMtransDatori, lxMtransMotivo, lxMtransVendedor, lxMtransOrigtipo, lxMtransRemito, lxMtransOrigletra, lxMtransMotremorg, lxMtransMovgen, lxMtransOrigpvta, lxMtransCompgen, lxMtransOrignro, lxMtransFpodes, lxMtransMd3, lxMtransRecpor, lxMtransMr2
				lxMtransFecimpo =  .Fechaimpo			lxMtransFechaori =  .Fechaoriginal			lxMtransFecexpo =  .Fechaexpo			lxMtransFmodifw =  .Fechamodificacionfw			lxMtransFaltafw =  .Fechaaltafw			lxMtransFectrans =  .Fechatransferencia			lxMtransHoraexpo =  .Horaexpo			lxMtransBdaltafw =  .Basededatosaltafw			lxMtransHoraimpo =  .Horaimpo			lxMtransBdmodifw =  .Basededatosmodificacionfw			lxMtransEsttrans =  .Estadotransferencia			lxMtransUmodifw =  .Usuariomodificacionfw			lxMtransHmodifw =  .Horamodificacionfw			lxMtransDescfw =  .Descripcionfw			lxMtransZadsfw =  .Zadsfw			lxMtransVmodifw =  .Versionmodificacionfw			lxMtransValtafw =  .Versionaltafw			lxMtransSaltafw =  .Seriealtafw			lxMtransSmodifw =  .Seriemodificacionfw			lxMtransHaltafw =  .Horaaltafw			lxMtransUaltafw =  .Usuarioaltafw			lxMtransTimestamp = goLibrerias.ObtenerTimestamp()			lxMtransClase =  .Clase			lxMtransAnulado =  .Anulado			lxMtransCodigo =  .Codigo			lxMtransMobs =  .Observacion			lxMtransOrigdest =  upper( .OrigenDestino_PK ) 			lxMtransNumero =  .Numero			lxMtransNumeroori =  .Numerooriginal			lxMtransFecha =  .Fecha			lxMtransDirmov =  .Tipo			lxMtransDatori =  .Datosadicionales			lxMtransMotivo =  upper( .Motivo_PK ) 			lxMtransVendedor =  upper( .vendedor_PK ) 			lxMtransOrigtipo =  .Origtipo			lxMtransRemito =  .Remito			lxMtransOrigletra =  .Origletra			lxMtransMotremorg =  .Motivoremitoorigen			lxMtransMovgen =  .Movimientogenerado			lxMtransOrigpvta =  .Origptovta			lxMtransCompgen =  .Comprobantegenerado			lxMtransOrignro =  .Orignumero			lxMtransFpodes =  .Porcentajedescuento			lxMtransMd3 =  .Montodescuento3			lxMtransRecpor =  .Recargoporcentaje			lxMtransMr2 =  .Recargomonto2
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
				update ZooLogic.MTRANS set "Fecimpo" = <<"'" + this.ConvertirDateSql( lxMtransFecimpo ) + "'">>,"Fechaori" = <<"'" + this.ConvertirDateSql( lxMtransFechaori ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxMtransFecexpo ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxMtransFmodifw ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxMtransFaltafw ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxMtransFectrans ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxMtransHoraexpo ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxMtransBdaltafw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxMtransHoraimpo ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxMtransBdmodifw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxMtransEsttrans ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxMtransUmodifw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxMtransHmodifw ) + "'">>,"Descfw" = <<"'" + this.FormatearTextoSql( lxMtransDescfw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxMtransZadsfw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxMtransVmodifw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxMtransValtafw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxMtransSaltafw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxMtransSmodifw ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxMtransHaltafw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxMtransUaltafw ) + "'">>,"Timestamp" = <<lxMtransTimestamp>>,"Clase" = <<lxMtransClase>>,"Anulado" = <<iif( lxMtransAnulado, 1, 0 )>>,"Codigo" = <<"'" + this.FormatearTextoSql( lxMtransCodigo ) + "'">>,"Mobs" = <<"'" + this.FormatearTextoSql( lxMtransMobs ) + "'">>,"Origdest" = <<"'" + this.FormatearTextoSql( lxMtransOrigdest ) + "'">>,"Numero" = <<lxMtransNumero>>,"Numeroori" = <<lxMtransNumeroori>>,"Fecha" = <<"'" + this.ConvertirDateSql( lxMtransFecha ) + "'">>,"Dirmov" = <<lxMtransDirmov>>,"Datori" = <<"'" + this.FormatearTextoSql( lxMtransDatori ) + "'">>,"Motivo" = <<"'" + this.FormatearTextoSql( lxMtransMotivo ) + "'">>,"Vendedor" = <<"'" + this.FormatearTextoSql( lxMtransVendedor ) + "'">>,"Origtipo" = <<lxMtransOrigtipo>>,"Remito" = <<"'" + this.FormatearTextoSql( lxMtransRemito ) + "'">>,"Origletra" = <<"'" + this.FormatearTextoSql( lxMtransOrigletra ) + "'">>,"Motremorg" = <<"'" + this.FormatearTextoSql( lxMtransMotremorg ) + "'">>,"Movgen" = <<lxMtransMovgen>>,"Origpvta" = <<lxMtransOrigpvta>>,"Compgen" = <<"'" + this.FormatearTextoSql( lxMtransCompgen ) + "'">>,"Orignro" = <<lxMtransOrignro>>,"Fpodes" = <<lxMtransFpodes>>,"Md3" = <<lxMtransMd3>>,"Recpor" = <<lxMtransRecpor>>,"Mr2" = <<lxMtransMr2>> where "Codigo" = <<"'" + this.FormatearTextoSql( lxMtransCodigo ) + "'">> and  MTRANS.CODIGO != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			this.ComprobarResultadoDeEjecucionDelUpdate()
		this.ComprobarTransaccion()
			.EjecutarSentencias( This.ColSentencias )
		this.ComprobarTransaccion()
			this.oConexion.EjecutarSql( 'delete from ZooLogic.CompAfe where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.DETMTRANS where "NUMR" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.COMPAFEC
				if this.oEntidad.COMPAFEC.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxTipocomprobante = loItem.Tipocomprobante
					lxNroitem = lnContadorNroItem
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
						Insert into ZooLogic.CompAfe("AfeTipoCom","NROITEM","Codigo","AfeComprob","AfeLETRA","AfePTOVEN","AfeNUMCOM","afefecha","afetotal","afevend","afetipo","Afecta","DescInter","NomInter","CodInter","Origen" ) values ( <<lxTipocomprobante>>, <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipocompcaracter ) + "'">>, <<"'" + this.FormatearTextoSql( lxLetra ) + "'">>, <<lxPuntodeventa>>, <<lxNumero>>, <<"'" + this.ConvertirDateSql( lxFecha ) + "'">>, <<lxTotal>>, <<"'" + this.FormatearTextoSql( lxVendedor ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipo ) + "'">>, <<"'" + this.FormatearTextoSql( lxAfecta ) + "'">>, <<"'" + this.FormatearTextoSql( lxInterviniente ) + "'">>, <<"'" + this.FormatearTextoSql( lxNombreentidad ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigoentidad ) + "'">>, <<"'" + this.FormatearTextoSql( lxOrigen ) + "'">> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.MovimientoDetalle
				if this.oEntidad.MovimientoDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxIditemarticulos = loItem.Iditemarticulos
					lxPorcentajeiva = loItem.Porcentajeiva
					lxComportamiento = loItem.Comportamiento
					lxNroitem = lnContadorNroItem
					lxNoprocesarstock = loItem.Noprocesarstock
					lxEquivalencia_PK = loItem.Equivalencia_PK
					lxArticulo_PK = loItem.Articulo_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxTalledetalle = loItem.Talledetalle
					lxTalle_PK = loItem.Talle_PK
					lxCantidad = loItem.Cantidad
					lxPrecioconimpuestos = loItem.Precioconimpuestos
					lxPreciosinimpuestos = loItem.Preciosinimpuestos
					lxDescuento = loItem.Descuento
					lxMontodescuento = loItem.Montodescuento
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.DETMTRANS("IdItem","fporIva","COMP","NROITEM","ProcStock","Equiv","NUMR","MART","DESCRIP","cColor","COLTXT","TALLTXT","Talle","CANTI","prunconimp","prunSInimp","FCFI","MNTDES" ) values ( <<"'" + this.FormatearTextoSql( lxIditemarticulos ) + "'">>, <<lxPorcentajeiva>>, <<lxComportamiento>>, <<lxNroitem>>, <<iif( lxNoprocesarstock, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxEquivalencia_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalledetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<lxCantidad>>, <<lxPrecioconimpuestos>>, <<lxPreciosinimpuestos>>, <<lxDescuento>>, <<lxMontodescuento>> ) 
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
		this.oEntidad.Timestamp = lxMtransTimestamp
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 CODIGO from ZooLogic.MTRANS where " + this.ConvertirFuncionesSql( " MTRANS.CODIGO != ''" ) )
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
			Local lxMtransCodigo
			lxMtransCodigo = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecimpo" as "Fechaimpo", "Fechaori" as "Fechaoriginal", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Horaexpo" as "Horaexpo", "Bdaltafw" as "Basededatosaltafw", "Horaimpo" as "Horaimpo", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Umodifw" as "Usuariomodificacionfw", "Hmodifw" as "Horamodificacionfw", "Descfw" as "Descripcionfw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Haltafw" as "Horaaltafw", "Ualtafw" as "Usuarioaltafw", "Timestamp" as "Timestamp", "Clase" as "Clase", "Anulado" as "Anulado", "Codigo" as "Codigo", "Mobs" as "Observacion", "Origdest" as "Origendestino", "Numero" as "Numero", "Numeroori" as "Numerooriginal", "Fecha" as "Fecha", "Dirmov" as "Tipo", "Datori" as "Datosadicionales", "Motivo" as "Motivo", "Vendedor" as "Vendedor", "Origtipo" as "Origtipo", "Remito" as "Remito", "Origletra" as "Origletra", "Motremorg" as "Motivoremitoorigen", "Movgen" as "Movimientogenerado", "Origpvta" as "Origptovta", "Compgen" as "Comprobantegenerado", "Orignro" as "Orignumero", "Fpodes" as "Porcentajedescuento", "Md3" as "Montodescuento3", "Recpor" as "Recargoporcentaje", "Mr2" as "Recargomonto2" from ZooLogic.MTRANS where "Codigo" = <<"'" + this.FormatearTextoSql( lxMtransCodigo ) + "'">> and  MTRANS.CODIGO != ''
			endtext
			use in select('c_MERCADERIAENTRANSITO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_MERCADERIAENTRANSITO', set( 'Datasession' ) )

			if reccount( 'c_MERCADERIAENTRANSITO' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afetipocom" as "Tipocomprobante", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen" from ZooLogic.CompAfe where Codigo = <<"'" + this.FormatearTextoSql( c_MERCADERIAENTRANSITO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_COMPAFEC')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMPAFEC', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_COMPAFEC
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Iditem" as "Iditemarticulos", "Fporiva" as "Porcentajeiva", "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Procstock" as "Noprocesarstock", "Equiv" as "Equivalencia", "Numr" as "Codigo", "Mart" as "Articulo", "Descrip" as "Articulodetalle", "Ccolor" as "Color", "Coltxt" as "Colordetalle", "Talltxt" as "Talledetalle", "Talle" as "Talle", "Canti" as "Cantidad", "Prunconimp" as "Precioconimpuestos", "Prunsinimp" as "Preciosinimpuestos", "Fcfi" as "Descuento", "Mntdes" as "Montodescuento" from ZooLogic.DETMTRANS where NUMR = <<"'" + this.FormatearTextoSql( c_MERCADERIAENTRANSITO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_MovimientoDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_MovimientoDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_MovimientoDetalle
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ConsultarPorClaveCandidata() as Boolean
		local llRetorno as Boolean
		llRetorno = .t.
		with this.oEntidad
			Local lxMTRANSNUMERO As Variant
			lxMTRANSNUMERO = .Numero
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecimpo" as "Fechaimpo", "Fechaori" as "Fechaoriginal", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Horaexpo" as "Horaexpo", "Bdaltafw" as "Basededatosaltafw", "Horaimpo" as "Horaimpo", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Umodifw" as "Usuariomodificacionfw", "Hmodifw" as "Horamodificacionfw", "Descfw" as "Descripcionfw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Haltafw" as "Horaaltafw", "Ualtafw" as "Usuarioaltafw", "Timestamp" as "Timestamp", "Clase" as "Clase", "Anulado" as "Anulado", "Codigo" as "Codigo", "Mobs" as "Observacion", "Origdest" as "Origendestino", "Numero" as "Numero", "Numeroori" as "Numerooriginal", "Fecha" as "Fecha", "Dirmov" as "Tipo", "Datori" as "Datosadicionales", "Motivo" as "Motivo", "Vendedor" as "Vendedor", "Origtipo" as "Origtipo", "Remito" as "Remito", "Origletra" as "Origletra", "Motremorg" as "Motivoremitoorigen", "Movgen" as "Movimientogenerado", "Origpvta" as "Origptovta", "Compgen" as "Comprobantegenerado", "Orignro" as "Orignumero", "Fpodes" as "Porcentajedescuento", "Md3" as "Montodescuento3", "Recpor" as "Recargoporcentaje", "Mr2" as "Recargomonto2" from ZooLogic.MTRANS where  MTRANS.CODIGO != '' And NUMERO = <<lxMTRANSNUMERO>>
			endtext
			use in select('c_MERCADERIAENTRANSITO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_MERCADERIAENTRANSITO', set( 'Datasession' ) )
			if reccount( 'c_MERCADERIAENTRANSITO' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afetipocom" as "Tipocomprobante", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen" from ZooLogic.CompAfe where Codigo = <<"'" + this.FormatearTextoSql( c_MERCADERIAENTRANSITO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_COMPAFEC')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMPAFEC', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_COMPAFEC
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Iditem" as "Iditemarticulos", "Fporiva" as "Porcentajeiva", "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Procstock" as "Noprocesarstock", "Equiv" as "Equivalencia", "Numr" as "Codigo", "Mart" as "Articulo", "Descrip" as "Articulodetalle", "Ccolor" as "Color", "Coltxt" as "Colordetalle", "Talltxt" as "Talledetalle", "Talle" as "Talle", "Canti" as "Cantidad", "Prunconimp" as "Precioconimpuestos", "Prunsinimp" as "Preciosinimpuestos", "Fcfi" as "Descuento", "Mntdes" as "Montodescuento" from ZooLogic.DETMTRANS where NUMR = <<"'" + this.FormatearTextoSql( c_MERCADERIAENTRANSITO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_MovimientoDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_MovimientoDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_MovimientoDetalle
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxMtransCodigo as Variant
		llRetorno = .t.
		lxMtransCodigo = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.MTRANS where "Codigo" = <<"'" + this.FormatearTextoSql( lxMtransCodigo ) + "'">> and  MTRANS.CODIGO != ''
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
				select top 1 "Fecimpo" as "Fechaimpo", "Fechaori" as "Fechaoriginal", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Horaexpo" as "Horaexpo", "Bdaltafw" as "Basededatosaltafw", "Horaimpo" as "Horaimpo", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Umodifw" as "Usuariomodificacionfw", "Hmodifw" as "Horamodificacionfw", "Descfw" as "Descripcionfw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Haltafw" as "Horaaltafw", "Ualtafw" as "Usuarioaltafw", "Timestamp" as "Timestamp", "Clase" as "Clase", "Anulado" as "Anulado", "Codigo" as "Codigo", "Mobs" as "Observacion", "Origdest" as "Origendestino", "Numero" as "Numero", "Numeroori" as "Numerooriginal", "Fecha" as "Fecha", "Dirmov" as "Tipo", "Datori" as "Datosadicionales", "Motivo" as "Motivo", "Vendedor" as "Vendedor", "Origtipo" as "Origtipo", "Remito" as "Remito", "Origletra" as "Origletra", "Motremorg" as "Motivoremitoorigen", "Movgen" as "Movimientogenerado", "Origpvta" as "Origptovta", "Compgen" as "Comprobantegenerado", "Orignro" as "Orignumero", "Fpodes" as "Porcentajedescuento", "Md3" as "Montodescuento3", "Recpor" as "Recargoporcentaje", "Mr2" as "Recargomonto2" from ZooLogic.MTRANS where  MTRANS.CODIGO != '' order by NUMERO
			endtext
			use in select('c_MERCADERIAENTRANSITO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_MERCADERIAENTRANSITO', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afetipocom" as "Tipocomprobante", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen" from ZooLogic.CompAfe where Codigo = <<"'" + this.FormatearTextoSql( c_MERCADERIAENTRANSITO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_COMPAFEC')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMPAFEC', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_COMPAFEC
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Iditem" as "Iditemarticulos", "Fporiva" as "Porcentajeiva", "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Procstock" as "Noprocesarstock", "Equiv" as "Equivalencia", "Numr" as "Codigo", "Mart" as "Articulo", "Descrip" as "Articulodetalle", "Ccolor" as "Color", "Coltxt" as "Colordetalle", "Talltxt" as "Talledetalle", "Talle" as "Talle", "Canti" as "Cantidad", "Prunconimp" as "Precioconimpuestos", "Prunsinimp" as "Preciosinimpuestos", "Fcfi" as "Descuento", "Mntdes" as "Montodescuento" from ZooLogic.DETMTRANS where NUMR = <<"'" + this.FormatearTextoSql( c_MERCADERIAENTRANSITO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_MovimientoDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_MovimientoDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_MovimientoDetalle
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
				select top 1 "Fecimpo" as "Fechaimpo", "Fechaori" as "Fechaoriginal", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Horaexpo" as "Horaexpo", "Bdaltafw" as "Basededatosaltafw", "Horaimpo" as "Horaimpo", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Umodifw" as "Usuariomodificacionfw", "Hmodifw" as "Horamodificacionfw", "Descfw" as "Descripcionfw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Haltafw" as "Horaaltafw", "Ualtafw" as "Usuarioaltafw", "Timestamp" as "Timestamp", "Clase" as "Clase", "Anulado" as "Anulado", "Codigo" as "Codigo", "Mobs" as "Observacion", "Origdest" as "Origendestino", "Numero" as "Numero", "Numeroori" as "Numerooriginal", "Fecha" as "Fecha", "Dirmov" as "Tipo", "Datori" as "Datosadicionales", "Motivo" as "Motivo", "Vendedor" as "Vendedor", "Origtipo" as "Origtipo", "Remito" as "Remito", "Origletra" as "Origletra", "Motremorg" as "Motivoremitoorigen", "Movgen" as "Movimientogenerado", "Origpvta" as "Origptovta", "Compgen" as "Comprobantegenerado", "Orignro" as "Orignumero", "Fpodes" as "Porcentajedescuento", "Md3" as "Montodescuento3", "Recpor" as "Recargoporcentaje", "Mr2" as "Recargomonto2" from ZooLogic.MTRANS where  str( NUMERO, 8, 0) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  MTRANS.CODIGO != '' order by NUMERO
			endtext
			use in select('c_MERCADERIAENTRANSITO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_MERCADERIAENTRANSITO', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afetipocom" as "Tipocomprobante", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen" from ZooLogic.CompAfe where Codigo = <<"'" + this.FormatearTextoSql( c_MERCADERIAENTRANSITO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_COMPAFEC')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMPAFEC', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_COMPAFEC
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Iditem" as "Iditemarticulos", "Fporiva" as "Porcentajeiva", "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Procstock" as "Noprocesarstock", "Equiv" as "Equivalencia", "Numr" as "Codigo", "Mart" as "Articulo", "Descrip" as "Articulodetalle", "Ccolor" as "Color", "Coltxt" as "Colordetalle", "Talltxt" as "Talledetalle", "Talle" as "Talle", "Canti" as "Cantidad", "Prunconimp" as "Precioconimpuestos", "Prunsinimp" as "Preciosinimpuestos", "Fcfi" as "Descuento", "Mntdes" as "Montodescuento" from ZooLogic.DETMTRANS where NUMR = <<"'" + this.FormatearTextoSql( c_MERCADERIAENTRANSITO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_MovimientoDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_MovimientoDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_MovimientoDetalle
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
				select top 1 "Fecimpo" as "Fechaimpo", "Fechaori" as "Fechaoriginal", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Horaexpo" as "Horaexpo", "Bdaltafw" as "Basededatosaltafw", "Horaimpo" as "Horaimpo", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Umodifw" as "Usuariomodificacionfw", "Hmodifw" as "Horamodificacionfw", "Descfw" as "Descripcionfw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Haltafw" as "Horaaltafw", "Ualtafw" as "Usuarioaltafw", "Timestamp" as "Timestamp", "Clase" as "Clase", "Anulado" as "Anulado", "Codigo" as "Codigo", "Mobs" as "Observacion", "Origdest" as "Origendestino", "Numero" as "Numero", "Numeroori" as "Numerooriginal", "Fecha" as "Fecha", "Dirmov" as "Tipo", "Datori" as "Datosadicionales", "Motivo" as "Motivo", "Vendedor" as "Vendedor", "Origtipo" as "Origtipo", "Remito" as "Remito", "Origletra" as "Origletra", "Motremorg" as "Motivoremitoorigen", "Movgen" as "Movimientogenerado", "Origpvta" as "Origptovta", "Compgen" as "Comprobantegenerado", "Orignro" as "Orignumero", "Fpodes" as "Porcentajedescuento", "Md3" as "Montodescuento3", "Recpor" as "Recargoporcentaje", "Mr2" as "Recargomonto2" from ZooLogic.MTRANS where  str( NUMERO, 8, 0) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  MTRANS.CODIGO != '' order by NUMERO desc
			endtext
			use in select('c_MERCADERIAENTRANSITO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_MERCADERIAENTRANSITO', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afetipocom" as "Tipocomprobante", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen" from ZooLogic.CompAfe where Codigo = <<"'" + this.FormatearTextoSql( c_MERCADERIAENTRANSITO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_COMPAFEC')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMPAFEC', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_COMPAFEC
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Iditem" as "Iditemarticulos", "Fporiva" as "Porcentajeiva", "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Procstock" as "Noprocesarstock", "Equiv" as "Equivalencia", "Numr" as "Codigo", "Mart" as "Articulo", "Descrip" as "Articulodetalle", "Ccolor" as "Color", "Coltxt" as "Colordetalle", "Talltxt" as "Talledetalle", "Talle" as "Talle", "Canti" as "Cantidad", "Prunconimp" as "Precioconimpuestos", "Prunsinimp" as "Preciosinimpuestos", "Fcfi" as "Descuento", "Mntdes" as "Montodescuento" from ZooLogic.DETMTRANS where NUMR = <<"'" + this.FormatearTextoSql( c_MERCADERIAENTRANSITO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_MovimientoDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_MovimientoDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_MovimientoDetalle
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
				select top 1 "Fecimpo" as "Fechaimpo", "Fechaori" as "Fechaoriginal", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Horaexpo" as "Horaexpo", "Bdaltafw" as "Basededatosaltafw", "Horaimpo" as "Horaimpo", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Umodifw" as "Usuariomodificacionfw", "Hmodifw" as "Horamodificacionfw", "Descfw" as "Descripcionfw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Haltafw" as "Horaaltafw", "Ualtafw" as "Usuarioaltafw", "Timestamp" as "Timestamp", "Clase" as "Clase", "Anulado" as "Anulado", "Codigo" as "Codigo", "Mobs" as "Observacion", "Origdest" as "Origendestino", "Numero" as "Numero", "Numeroori" as "Numerooriginal", "Fecha" as "Fecha", "Dirmov" as "Tipo", "Datori" as "Datosadicionales", "Motivo" as "Motivo", "Vendedor" as "Vendedor", "Origtipo" as "Origtipo", "Remito" as "Remito", "Origletra" as "Origletra", "Motremorg" as "Motivoremitoorigen", "Movgen" as "Movimientogenerado", "Origpvta" as "Origptovta", "Compgen" as "Comprobantegenerado", "Orignro" as "Orignumero", "Fpodes" as "Porcentajedescuento", "Md3" as "Montodescuento3", "Recpor" as "Recargoporcentaje", "Mr2" as "Recargomonto2" from ZooLogic.MTRANS where  MTRANS.CODIGO != '' order by NUMERO desc
			endtext
			use in select('c_MERCADERIAENTRANSITO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_MERCADERIAENTRANSITO', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afetipocom" as "Tipocomprobante", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen" from ZooLogic.CompAfe where Codigo = <<"'" + this.FormatearTextoSql( c_MERCADERIAENTRANSITO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_COMPAFEC')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMPAFEC', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_COMPAFEC
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Iditem" as "Iditemarticulos", "Fporiva" as "Porcentajeiva", "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Procstock" as "Noprocesarstock", "Equiv" as "Equivalencia", "Numr" as "Codigo", "Mart" as "Articulo", "Descrip" as "Articulodetalle", "Ccolor" as "Color", "Coltxt" as "Colordetalle", "Talltxt" as "Talledetalle", "Talle" as "Talle", "Canti" as "Cantidad", "Prunconimp" as "Precioconimpuestos", "Prunsinimp" as "Preciosinimpuestos", "Fcfi" as "Descuento", "Mntdes" as "Montodescuento" from ZooLogic.DETMTRANS where NUMR = <<"'" + this.FormatearTextoSql( c_MERCADERIAENTRANSITO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_MovimientoDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_MovimientoDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_MovimientoDetalle
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
			lcXml = this.oConexion.EjecutarSql( "select Fecimpo,Fechaori,Fecexpo,Fmodifw,Faltafw,Fectrans,Horaexpo,Bdaltafw,Horaimpo,Bdmodifw,Esttra" + ;
"ns,Umodifw,Hmodifw,Descfw,Zadsfw,Vmodifw,Valtafw,Saltafw,Smodifw,Haltafw,Ualtafw,Timestamp,Clase,Anu" + ;
"lado,Codigo,Mobs,Origdest,Numero,Numeroori,Fecha,Dirmov,Datori,Motivo,Vendedor,Origtipo,Remito,Origl" + ;
"etra,Motremorg,Movgen,Origpvta,Compgen,Orignro,Fpodes,Md3,Recpor,Mr2" + ;
" from ZooLogic.MTRANS where  MTRANS.CODIGO != '' and " + lcFiltro )
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
			local  lxMtransFecimpo, lxMtransFechaori, lxMtransFecexpo, lxMtransFmodifw, lxMtransFaltafw, lxMtransFectrans, lxMtransHoraexpo, lxMtransBdaltafw, lxMtransHoraimpo, lxMtransBdmodifw, lxMtransEsttrans, lxMtransUmodifw, lxMtransHmodifw, lxMtransDescfw, lxMtransZadsfw, lxMtransVmodifw, lxMtransValtafw, lxMtransSaltafw, lxMtransSmodifw, lxMtransHaltafw, lxMtransUaltafw, lxMtransTimestamp, lxMtransClase, lxMtransAnulado, lxMtransCodigo, lxMtransMobs, lxMtransOrigdest, lxMtransNumero, lxMtransNumeroori, lxMtransFecha, lxMtransDirmov, lxMtransDatori, lxMtransMotivo, lxMtransVendedor, lxMtransOrigtipo, lxMtransRemito, lxMtransOrigletra, lxMtransMotremorg, lxMtransMovgen, lxMtransOrigpvta, lxMtransCompgen, lxMtransOrignro, lxMtransFpodes, lxMtransMd3, lxMtransRecpor, lxMtransMr2
				lxMtransFecimpo = ctod( '  /  /    ' )			lxMtransFechaori = ctod( '  /  /    ' )			lxMtransFecexpo = ctod( '  /  /    ' )			lxMtransFmodifw = ctod( '  /  /    ' )			lxMtransFaltafw = ctod( '  /  /    ' )			lxMtransFectrans = ctod( '  /  /    ' )			lxMtransHoraexpo = []			lxMtransBdaltafw = []			lxMtransHoraimpo = []			lxMtransBdmodifw = []			lxMtransEsttrans = []			lxMtransUmodifw = []			lxMtransHmodifw = []			lxMtransDescfw = []			lxMtransZadsfw = []			lxMtransVmodifw = []			lxMtransValtafw = []			lxMtransSaltafw = []			lxMtransSmodifw = []			lxMtransHaltafw = []			lxMtransUaltafw = []			lxMtransTimestamp = goLibrerias.ObtenerTimestamp()			lxMtransClase = 0			lxMtransAnulado = .F.			lxMtransCodigo = []			lxMtransMobs = []			lxMtransOrigdest = []			lxMtransNumero = 0			lxMtransNumeroori = 0			lxMtransFecha = ctod( '  /  /    ' )			lxMtransDirmov = 0			lxMtransDatori = []			lxMtransMotivo = []			lxMtransVendedor = []			lxMtransOrigtipo = 0			lxMtransRemito = []			lxMtransOrigletra = []			lxMtransMotremorg = []			lxMtransMovgen = 0			lxMtransOrigpvta = 0			lxMtransCompgen = []			lxMtransOrignro = 0			lxMtransFpodes = 0			lxMtransMd3 = 0			lxMtransRecpor = 0			lxMtransMr2 = 0
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.CompAfe where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.DETMTRANS where "NUMR" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( [delete from ZooLogic.MTRANS where "CODIGO" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'MTRANS' + '_' + tcCampo
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
		lcWhere = " Where  MTRANS.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fecimpo" as "Fechaimpo", "Fechaori" as "Fechaoriginal", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Horaexpo" as "Horaexpo", "Bdaltafw" as "Basededatosaltafw", "Horaimpo" as "Horaimpo", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Umodifw" as "Usuariomodificacionfw", "Hmodifw" as "Horamodificacionfw", "Descfw" as "Descripcionfw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Haltafw" as "Horaaltafw", "Ualtafw" as "Usuarioaltafw", "Timestamp" as "Timestamp", "Clase" as "Clase", "Anulado" as "Anulado", "Codigo" as "Codigo", "Mobs" as "Observacion", "Origdest" as "Origendestino", "Numero" as "Numero", "Numeroori" as "Numerooriginal", "Fecha" as "Fecha", "Dirmov" as "Tipo", "Datori" as "Datosadicionales", "Motivo" as "Motivo", "Vendedor" as "Vendedor", "Origtipo" as "Origtipo", "Remito" as "Remito", "Origletra" as "Origletra", "Motremorg" as "Motivoremitoorigen", "Movgen" as "Movimientogenerado", "Origpvta" as "Origptovta", "Compgen" as "Comprobantegenerado", "Orignro" as "Orignumero", "Fpodes" as "Porcentajedescuento", "Md3" as "Montodescuento3", "Recpor" as "Recargoporcentaje", "Mr2" as "Recargomonto2"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'MTRANS', '', tnTope )
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
					"Afetipocom" as "Tipocomprobante", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen"
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
	Function ObtenerDatosDetalleMovimientoDetalle( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  DETMTRANS.NUMR != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Iditem" as "Iditemarticulos", "Fporiva" as "Porcentajeiva", "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Procstock" as "Noprocesarstock", "Equiv" as "Equivalencia", "Numr" as "Codigo", "Mart" as "Articulo", "Descrip" as "Articulodetalle", "Ccolor" as "Color", "Coltxt" as "Colordetalle", "Talltxt" as "Talledetalle", "Talle" as "Talle", "Canti" as "Cantidad", "Prunconimp" as "Precioconimpuestos", "Prunsinimp" as "Preciosinimpuestos", "Fcfi" as "Descuento", "Mntdes" as "Montodescuento"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleMovimientoDetalle( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'DETMTRANS', 'MovimientoDetalle', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleMovimientoDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleMovimientoDetalle( lcAtributo )
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
				Case lcAtributo == 'FECHAORIGINAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHAORI AS FECHAORIGINAL'
				Case lcAtributo == 'FECHAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECEXPO AS FECHAEXPO'
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'FECHATRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRANS AS FECHATRANSFERENCIA'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'DESCRIPCIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCFW AS DESCRIPCIONFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'TIMESTAMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIMESTAMP AS TIMESTAMP'
				Case lcAtributo == 'CLASE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLASE AS CLASE'
				Case lcAtributo == 'ANULADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ANULADO AS ANULADO'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'OBSERVACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MOBS AS OBSERVACION'
				Case lcAtributo == 'ORIGENDESTINO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ORIGDEST AS ORIGENDESTINO'
				Case lcAtributo == 'NUMERO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NUMERO AS NUMERO'
				Case lcAtributo == 'NUMEROORIGINAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NUMEROORI AS NUMEROORIGINAL'
				Case lcAtributo == 'FECHA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHA AS FECHA'
				Case lcAtributo == 'TIPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DIRMOV AS TIPO'
				Case lcAtributo == 'DATOSADICIONALES'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DATORI AS DATOSADICIONALES'
				Case lcAtributo == 'MOTIVO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MOTIVO AS MOTIVO'
				Case lcAtributo == 'VENDEDOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VENDEDOR AS VENDEDOR'
				Case lcAtributo == 'ORIGTIPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ORIGTIPO AS ORIGTIPO'
				Case lcAtributo == 'REMITO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'REMITO AS REMITO'
				Case lcAtributo == 'ORIGLETRA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ORIGLETRA AS ORIGLETRA'
				Case lcAtributo == 'MOTIVOREMITOORIGEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MOTREMORG AS MOTIVOREMITOORIGEN'
				Case lcAtributo == 'MOVIMIENTOGENERADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MOVGEN AS MOVIMIENTOGENERADO'
				Case lcAtributo == 'ORIGPTOVTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ORIGPVTA AS ORIGPTOVTA'
				Case lcAtributo == 'COMPROBANTEGENERADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COMPGEN AS COMPROBANTEGENERADO'
				Case lcAtributo == 'ORIGNUMERO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ORIGNRO AS ORIGNUMERO'
				Case lcAtributo == 'PORCENTAJEDESCUENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPODES AS PORCENTAJEDESCUENTO'
				Case lcAtributo == 'MONTODESCUENTO3'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MD3 AS MONTODESCUENTO3'
				Case lcAtributo == 'RECARGOPORCENTAJE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RECPOR AS RECARGOPORCENTAJE'
				Case lcAtributo == 'RECARGOMONTO2'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MR2 AS RECARGOMONTO2'
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
				Case lcAtributo == 'TIPOCOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFETIPOCOM AS TIPOCOMPROBANTE'
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
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
	Function ObtenerCamposSelectDetalleMovimientoDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'IDITEMARTICULOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDITEM AS IDITEMARTICULOS'
				Case lcAtributo == 'PORCENTAJEIVA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPORIVA AS PORCENTAJEIVA'
				Case lcAtributo == 'COMPORTAMIENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COMP AS COMPORTAMIENTO'
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'NOPROCESARSTOCK'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PROCSTOCK AS NOPROCESARSTOCK'
				Case lcAtributo == 'EQUIVALENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'EQUIV AS EQUIVALENCIA'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NUMR AS CODIGO'
				Case lcAtributo == 'ARTICULO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MART AS ARTICULO'
				Case lcAtributo == 'ARTICULODETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCRIP AS ARTICULODETALLE'
				Case lcAtributo == 'COLOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CCOLOR AS COLOR'
				Case lcAtributo == 'COLORDETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COLTXT AS COLORDETALLE'
				Case lcAtributo == 'TALLEDETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TALLTXT AS TALLEDETALLE'
				Case lcAtributo == 'TALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TALLE AS TALLE'
				Case lcAtributo == 'CANTIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CANTI AS CANTIDAD'
				Case lcAtributo == 'PRECIOCONIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PRUNCONIMP AS PRECIOCONIMPUESTOS'
				Case lcAtributo == 'PRECIOSINIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PRUNSINIMP AS PRECIOSINIMPUESTOS'
				Case lcAtributo == 'DESCUENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FCFI AS DESCUENTO'
				Case lcAtributo == 'MONTODESCUENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MNTDES AS MONTODESCUENTO'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHAORIGINAL'
				lcCampo = 'FECHAORI'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEXPO'
				lcCampo = 'FECEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCIONFW'
				lcCampo = 'DESCFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'TIMESTAMP'
				lcCampo = 'TIMESTAMP'
			Case upper( alltrim( tcAtributo ) ) == 'CLASE'
				lcCampo = 'CLASE'
			Case upper( alltrim( tcAtributo ) ) == 'ANULADO'
				lcCampo = 'ANULADO'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'OBSERVACION'
				lcCampo = 'MOBS'
			Case upper( alltrim( tcAtributo ) ) == 'ORIGENDESTINO'
				lcCampo = 'ORIGDEST'
			Case upper( alltrim( tcAtributo ) ) == 'NUMERO'
				lcCampo = 'NUMERO'
			Case upper( alltrim( tcAtributo ) ) == 'NUMEROORIGINAL'
				lcCampo = 'NUMEROORI'
			Case upper( alltrim( tcAtributo ) ) == 'FECHA'
				lcCampo = 'FECHA'
			Case upper( alltrim( tcAtributo ) ) == 'TIPO'
				lcCampo = 'DIRMOV'
			Case upper( alltrim( tcAtributo ) ) == 'DATOSADICIONALES'
				lcCampo = 'DATORI'
			Case upper( alltrim( tcAtributo ) ) == 'MOTIVO'
				lcCampo = 'MOTIVO'
			Case upper( alltrim( tcAtributo ) ) == 'VENDEDOR'
				lcCampo = 'VENDEDOR'
			Case upper( alltrim( tcAtributo ) ) == 'ORIGTIPO'
				lcCampo = 'ORIGTIPO'
			Case upper( alltrim( tcAtributo ) ) == 'REMITO'
				lcCampo = 'REMITO'
			Case upper( alltrim( tcAtributo ) ) == 'ORIGLETRA'
				lcCampo = 'ORIGLETRA'
			Case upper( alltrim( tcAtributo ) ) == 'MOTIVOREMITOORIGEN'
				lcCampo = 'MOTREMORG'
			Case upper( alltrim( tcAtributo ) ) == 'MOVIMIENTOGENERADO'
				lcCampo = 'MOVGEN'
			Case upper( alltrim( tcAtributo ) ) == 'ORIGPTOVTA'
				lcCampo = 'ORIGPVTA'
			Case upper( alltrim( tcAtributo ) ) == 'COMPROBANTEGENERADO'
				lcCampo = 'COMPGEN'
			Case upper( alltrim( tcAtributo ) ) == 'ORIGNUMERO'
				lcCampo = 'ORIGNRO'
			Case upper( alltrim( tcAtributo ) ) == 'PORCENTAJEDESCUENTO'
				lcCampo = 'FPODES'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTO3'
				lcCampo = 'MD3'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOPORCENTAJE'
				lcCampo = 'RECPOR'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOMONTO2'
				lcCampo = 'MR2'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleCOMPAFEC( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'TIPOCOMPROBANTE'
				lcCampo = 'AFETIPOCOM'
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
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
	Function ObtenerCampoDetalleMovimientoDetalle( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'IDITEMARTICULOS'
				lcCampo = 'IDITEM'
			Case upper( alltrim( tcAtributo ) ) == 'PORCENTAJEIVA'
				lcCampo = 'FPORIVA'
			Case upper( alltrim( tcAtributo ) ) == 'COMPORTAMIENTO'
				lcCampo = 'COMP'
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'NOPROCESARSTOCK'
				lcCampo = 'PROCSTOCK'
			Case upper( alltrim( tcAtributo ) ) == 'EQUIVALENCIA'
				lcCampo = 'EQUIV'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'NUMR'
			Case upper( alltrim( tcAtributo ) ) == 'ARTICULO'
				lcCampo = 'MART'
			Case upper( alltrim( tcAtributo ) ) == 'ARTICULODETALLE'
				lcCampo = 'DESCRIP'
			Case upper( alltrim( tcAtributo ) ) == 'COLOR'
				lcCampo = 'CCOLOR'
			Case upper( alltrim( tcAtributo ) ) == 'COLORDETALLE'
				lcCampo = 'COLTXT'
			Case upper( alltrim( tcAtributo ) ) == 'TALLEDETALLE'
				lcCampo = 'TALLTXT'
			Case upper( alltrim( tcAtributo ) ) == 'TALLE'
				lcCampo = 'TALLE'
			Case upper( alltrim( tcAtributo ) ) == 'CANTIDAD'
				lcCampo = 'CANTI'
			Case upper( alltrim( tcAtributo ) ) == 'PRECIOCONIMPUESTOS'
				lcCampo = 'PRUNCONIMP'
			Case upper( alltrim( tcAtributo ) ) == 'PRECIOSINIMPUESTOS'
				lcCampo = 'PRUNSINIMP'
			Case upper( alltrim( tcAtributo ) ) == 'DESCUENTO'
				lcCampo = 'FCFI'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTO'
				lcCampo = 'MNTDES'
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
		if upper( alltrim( tcDetalle ) ) == 'MOVIMIENTODETALLE'
			lcRetorno = 'DETMTRANS'
		EndIf
		return lcRetorno
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasInsert() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcSentencia as string, loItem as object
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxMtransFecimpo, lxMtransFechaori, lxMtransFecexpo, lxMtransFmodifw, lxMtransFaltafw, lxMtransFectrans, lxMtransHoraexpo, lxMtransBdaltafw, lxMtransHoraimpo, lxMtransBdmodifw, lxMtransEsttrans, lxMtransUmodifw, lxMtransHmodifw, lxMtransDescfw, lxMtransZadsfw, lxMtransVmodifw, lxMtransValtafw, lxMtransSaltafw, lxMtransSmodifw, lxMtransHaltafw, lxMtransUaltafw, lxMtransTimestamp, lxMtransClase, lxMtransAnulado, lxMtransCodigo, lxMtransMobs, lxMtransOrigdest, lxMtransNumero, lxMtransNumeroori, lxMtransFecha, lxMtransDirmov, lxMtransDatori, lxMtransMotivo, lxMtransVendedor, lxMtransOrigtipo, lxMtransRemito, lxMtransOrigletra, lxMtransMotremorg, lxMtransMovgen, lxMtransOrigpvta, lxMtransCompgen, lxMtransOrignro, lxMtransFpodes, lxMtransMd3, lxMtransRecpor, lxMtransMr2
				lxMtransFecimpo =  .Fechaimpo			lxMtransFechaori =  .Fechaoriginal			lxMtransFecexpo =  .Fechaexpo			lxMtransFmodifw =  .Fechamodificacionfw			lxMtransFaltafw =  .Fechaaltafw			lxMtransFectrans =  .Fechatransferencia			lxMtransHoraexpo =  .Horaexpo			lxMtransBdaltafw =  .Basededatosaltafw			lxMtransHoraimpo =  .Horaimpo			lxMtransBdmodifw =  .Basededatosmodificacionfw			lxMtransEsttrans =  .Estadotransferencia			lxMtransUmodifw =  .Usuariomodificacionfw			lxMtransHmodifw =  .Horamodificacionfw			lxMtransDescfw =  .Descripcionfw			lxMtransZadsfw =  .Zadsfw			lxMtransVmodifw =  .Versionmodificacionfw			lxMtransValtafw =  .Versionaltafw			lxMtransSaltafw =  .Seriealtafw			lxMtransSmodifw =  .Seriemodificacionfw			lxMtransHaltafw =  .Horaaltafw			lxMtransUaltafw =  .Usuarioaltafw			lxMtransTimestamp = goLibrerias.ObtenerTimestamp()			lxMtransClase =  .Clase			lxMtransAnulado =  .Anulado			lxMtransCodigo =  .Codigo			lxMtransMobs =  .Observacion			lxMtransOrigdest =  upper( .OrigenDestino_PK ) 			lxMtransNumero =  .Numero			lxMtransNumeroori =  .Numerooriginal			lxMtransFecha =  .Fecha			lxMtransDirmov =  .Tipo			lxMtransDatori =  .Datosadicionales			lxMtransMotivo =  upper( .Motivo_PK ) 			lxMtransVendedor =  upper( .vendedor_PK ) 			lxMtransOrigtipo =  .Origtipo			lxMtransRemito =  .Remito			lxMtransOrigletra =  .Origletra			lxMtransMotremorg =  .Motivoremitoorigen			lxMtransMovgen =  .Movimientogenerado			lxMtransOrigpvta =  .Origptovta			lxMtransCompgen =  .Comprobantegenerado			lxMtransOrignro =  .Orignumero			lxMtransFpodes =  .Porcentajedescuento			lxMtransMd3 =  .Montodescuento3			lxMtransRecpor =  .Recargoporcentaje			lxMtransMr2 =  .Recargomonto2
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.MTRANS ( "Fecimpo","Fechaori","Fecexpo","Fmodifw","Faltafw","Fectrans","Horaexpo","Bdaltafw","Horaimpo","Bdmodifw","Esttrans","Umodifw","Hmodifw","Descfw","Zadsfw","Vmodifw","Valtafw","Saltafw","Smodifw","Haltafw","Ualtafw","Timestamp","Clase","Anulado","Codigo","Mobs","Origdest","Numero","Numeroori","Fecha","Dirmov","Datori","Motivo","Vendedor","Origtipo","Remito","Origletra","Motremorg","Movgen","Origpvta","Compgen","Orignro","Fpodes","Md3","Recpor","Mr2" ) values ( <<"'" + this.ConvertirDateSql( lxMtransFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxMtransFechaori ) + "'" >>, <<"'" + this.ConvertirDateSql( lxMtransFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxMtransFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxMtransFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxMtransFectrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMtransHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMtransBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMtransHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMtransBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMtransEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMtransUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMtransHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMtransDescfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMtransZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMtransVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMtransValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMtransSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMtransSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMtransHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMtransUaltafw ) + "'" >>, <<lxMtransTimestamp >>, <<lxMtransClase >>, <<iif( lxMtransAnulado, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxMtransCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMtransMobs ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMtransOrigdest ) + "'" >>, <<lxMtransNumero >>, <<lxMtransNumeroori >>, <<"'" + this.ConvertirDateSql( lxMtransFecha ) + "'" >>, <<lxMtransDirmov >>, <<"'" + this.FormatearTextoSql( lxMtransDatori ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMtransMotivo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMtransVendedor ) + "'" >>, <<lxMtransOrigtipo >>, <<"'" + this.FormatearTextoSql( lxMtransRemito ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMtransOrigletra ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMtransMotremorg ) + "'" >>, <<lxMtransMovgen >>, <<lxMtransOrigpvta >>, <<"'" + this.FormatearTextoSql( lxMtransCompgen ) + "'" >>, <<lxMtransOrignro >>, <<lxMtransFpodes >>, <<lxMtransMd3 >>, <<lxMtransRecpor >>, <<lxMtransMr2 >> )
		endtext
		loColeccion.cTabla = 'MTRANS' 
		loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		With this
			local lcValorClavePrimariaString as String
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.COMPAFEC
				if this.oEntidad.COMPAFEC.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxTipocomprobante = loItem.Tipocomprobante
					lxNroitem = lnContadorNroItem
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
						Insert into ZooLogic.CompAfe("AfeTipoCom","NROITEM","Codigo","AfeComprob","AfeLETRA","AfePTOVEN","AfeNUMCOM","afefecha","afetotal","afevend","afetipo","Afecta","DescInter","NomInter","CodInter","Origen" ) values ( <<lxTipocomprobante>>, <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxTipocompcaracter ) + "'">>, <<"'" + this.FormatearTextoSql( lxLetra ) + "'">>, <<lxPuntodeventa>>, <<lxNumero>>, <<"'" + this.ConvertirDateSql( lxFecha ) + "'">>, <<lxTotal>>, <<"'" + this.FormatearTextoSql( lxVendedor ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipo ) + "'">>, <<"'" + this.FormatearTextoSql( lxAfecta ) + "'">>, <<"'" + this.FormatearTextoSql( lxInterviniente ) + "'">>, <<"'" + this.FormatearTextoSql( lxNombreentidad ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigoentidad ) + "'">>, <<"'" + this.FormatearTextoSql( lxOrigen ) + "'">> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.MovimientoDetalle
				if this.oEntidad.MovimientoDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxIditemarticulos = loItem.Iditemarticulos
					lxPorcentajeiva = loItem.Porcentajeiva
					lxComportamiento = loItem.Comportamiento
					lxNroitem = lnContadorNroItem
					lxNoprocesarstock = loItem.Noprocesarstock
					lxEquivalencia_PK = loItem.Equivalencia_PK
					lxArticulo_PK = loItem.Articulo_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxTalledetalle = loItem.Talledetalle
					lxTalle_PK = loItem.Talle_PK
					lxCantidad = loItem.Cantidad
					lxPrecioconimpuestos = loItem.Precioconimpuestos
					lxPreciosinimpuestos = loItem.Preciosinimpuestos
					lxDescuento = loItem.Descuento
					lxMontodescuento = loItem.Montodescuento
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.DETMTRANS("IdItem","fporIva","COMP","NROITEM","ProcStock","Equiv","NUMR","MART","DESCRIP","cColor","COLTXT","TALLTXT","Talle","CANTI","prunconimp","prunSInimp","FCFI","MNTDES" ) values ( <<"'" + this.FormatearTextoSql( lxIditemarticulos ) + "'">>, <<lxPorcentajeiva>>, <<lxComportamiento>>, <<lxNroitem>>, <<iif( lxNoprocesarstock, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxEquivalencia_PK ) + "'">>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalledetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<lxCantidad>>, <<lxPrecioconimpuestos>>, <<lxPreciosinimpuestos>>, <<lxDescuento>>, <<lxMontodescuento>> ) 
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
			local  lxMtransFecimpo, lxMtransFechaori, lxMtransFecexpo, lxMtransFmodifw, lxMtransFaltafw, lxMtransFectrans, lxMtransHoraexpo, lxMtransBdaltafw, lxMtransHoraimpo, lxMtransBdmodifw, lxMtransEsttrans, lxMtransUmodifw, lxMtransHmodifw, lxMtransDescfw, lxMtransZadsfw, lxMtransVmodifw, lxMtransValtafw, lxMtransSaltafw, lxMtransSmodifw, lxMtransHaltafw, lxMtransUaltafw, lxMtransTimestamp, lxMtransClase, lxMtransAnulado, lxMtransCodigo, lxMtransMobs, lxMtransOrigdest, lxMtransNumero, lxMtransNumeroori, lxMtransFecha, lxMtransDirmov, lxMtransDatori, lxMtransMotivo, lxMtransVendedor, lxMtransOrigtipo, lxMtransRemito, lxMtransOrigletra, lxMtransMotremorg, lxMtransMovgen, lxMtransOrigpvta, lxMtransCompgen, lxMtransOrignro, lxMtransFpodes, lxMtransMd3, lxMtransRecpor, lxMtransMr2
				lxMtransFecimpo =  .Fechaimpo			lxMtransFechaori =  .Fechaoriginal			lxMtransFecexpo =  .Fechaexpo			lxMtransFmodifw =  .Fechamodificacionfw			lxMtransFaltafw =  .Fechaaltafw			lxMtransFectrans =  .Fechatransferencia			lxMtransHoraexpo =  .Horaexpo			lxMtransBdaltafw =  .Basededatosaltafw			lxMtransHoraimpo =  .Horaimpo			lxMtransBdmodifw =  .Basededatosmodificacionfw			lxMtransEsttrans =  .Estadotransferencia			lxMtransUmodifw =  .Usuariomodificacionfw			lxMtransHmodifw =  .Horamodificacionfw			lxMtransDescfw =  .Descripcionfw			lxMtransZadsfw =  .Zadsfw			lxMtransVmodifw =  .Versionmodificacionfw			lxMtransValtafw =  .Versionaltafw			lxMtransSaltafw =  .Seriealtafw			lxMtransSmodifw =  .Seriemodificacionfw			lxMtransHaltafw =  .Horaaltafw			lxMtransUaltafw =  .Usuarioaltafw			lxMtransTimestamp = goLibrerias.ObtenerTimestamp()			lxMtransClase =  .Clase			lxMtransAnulado =  .Anulado			lxMtransCodigo =  .Codigo			lxMtransMobs =  .Observacion			lxMtransOrigdest =  upper( .OrigenDestino_PK ) 			lxMtransNumero =  .Numero			lxMtransNumeroori =  .Numerooriginal			lxMtransFecha =  .Fecha			lxMtransDirmov =  .Tipo			lxMtransDatori =  .Datosadicionales			lxMtransMotivo =  upper( .Motivo_PK ) 			lxMtransVendedor =  upper( .vendedor_PK ) 			lxMtransOrigtipo =  .Origtipo			lxMtransRemito =  .Remito			lxMtransOrigletra =  .Origletra			lxMtransMotremorg =  .Motivoremitoorigen			lxMtransMovgen =  .Movimientogenerado			lxMtransOrigpvta =  .Origptovta			lxMtransCompgen =  .Comprobantegenerado			lxMtransOrignro =  .Orignumero			lxMtransFpodes =  .Porcentajedescuento			lxMtransMd3 =  .Montodescuento3			lxMtransRecpor =  .Recargoporcentaje			lxMtransMr2 =  .Recargomonto2
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  MTRANS.CODIGO != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.MTRANS set "Fecimpo" = <<"'" + this.ConvertirDateSql( lxMtransFecimpo ) + "'">>, "Fechaori" = <<"'" + this.ConvertirDateSql( lxMtransFechaori ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxMtransFecexpo ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxMtransFmodifw ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxMtransFaltafw ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxMtransFectrans ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxMtransHoraexpo ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxMtransBdaltafw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxMtransHoraimpo ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxMtransBdmodifw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxMtransEsttrans ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxMtransUmodifw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxMtransHmodifw ) + "'">>, "Descfw" = <<"'" + this.FormatearTextoSql( lxMtransDescfw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxMtransZadsfw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxMtransVmodifw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxMtransValtafw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxMtransSaltafw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxMtransSmodifw ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxMtransHaltafw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxMtransUaltafw ) + "'">>, "Timestamp" = <<lxMtransTimestamp>>, "Clase" = <<lxMtransClase>>, "Anulado" = <<iif( lxMtransAnulado, 1, 0 )>>, "Codigo" = <<"'" + this.FormatearTextoSql( lxMtransCodigo ) + "'">>, "Mobs" = <<"'" + this.FormatearTextoSql( lxMtransMobs ) + "'">>, "Origdest" = <<"'" + this.FormatearTextoSql( lxMtransOrigdest ) + "'">>, "Numero" = <<lxMtransNumero>>, "Numeroori" = <<lxMtransNumeroori>>, "Fecha" = <<"'" + this.ConvertirDateSql( lxMtransFecha ) + "'">>, "Dirmov" = <<lxMtransDirmov>>, "Datori" = <<"'" + this.FormatearTextoSql( lxMtransDatori ) + "'">>, "Motivo" = <<"'" + this.FormatearTextoSql( lxMtransMotivo ) + "'">>, "Vendedor" = <<"'" + this.FormatearTextoSql( lxMtransVendedor ) + "'">>, "Origtipo" = <<lxMtransOrigtipo>>, "Remito" = <<"'" + this.FormatearTextoSql( lxMtransRemito ) + "'">>, "Origletra" = <<"'" + this.FormatearTextoSql( lxMtransOrigletra ) + "'">>, "Motremorg" = <<"'" + this.FormatearTextoSql( lxMtransMotremorg ) + "'">>, "Movgen" = <<lxMtransMovgen>>, "Origpvta" = <<lxMtransOrigpvta>>, "Compgen" = <<"'" + this.FormatearTextoSql( lxMtransCompgen ) + "'">>, "Orignro" = <<lxMtransOrignro>>, "Fpodes" = <<lxMtransFpodes>>, "Md3" = <<lxMtransMd3>>, "Recpor" = <<lxMtransRecpor>>, "Mr2" = <<lxMtransMr2>> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'MTRANS' 
		loColeccion.agregar( strtran(  lcSentencia, chr( 9 ), '' ) )
			loColeccion.Agregar([delete from ZooLogic.CompAfe where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.DETMTRANS where "NUMR" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.COMPAFEC
				if this.oEntidad.COMPAFEC.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxTipocomprobante = loItem.Tipocomprobante
					lxNroitem = lnContadorNroItem
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
						Insert into ZooLogic.CompAfe("AfeTipoCom","NROITEM","Codigo","AfeComprob","AfeLETRA","AfePTOVEN","AfeNUMCOM","afefecha","afetotal","afevend","afetipo","Afecta","DescInter","NomInter","CodInter","Origen" ) values ( <<lxTipocomprobante>>, <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxTipocompcaracter ) + "'">>, <<"'" + this.FormatearTextoSql( lxLetra ) + "'">>, <<lxPuntodeventa>>, <<lxNumero>>, <<"'" + this.ConvertirDateSql( lxFecha ) + "'">>, <<lxTotal>>, <<"'" + this.FormatearTextoSql( lxVendedor ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipo ) + "'">>, <<"'" + this.FormatearTextoSql( lxAfecta ) + "'">>, <<"'" + this.FormatearTextoSql( lxInterviniente ) + "'">>, <<"'" + this.FormatearTextoSql( lxNombreentidad ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigoentidad ) + "'">>, <<"'" + this.FormatearTextoSql( lxOrigen ) + "'">> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.MovimientoDetalle
				if this.oEntidad.MovimientoDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxIditemarticulos = loItem.Iditemarticulos
					lxPorcentajeiva = loItem.Porcentajeiva
					lxComportamiento = loItem.Comportamiento
					lxNroitem = lnContadorNroItem
					lxNoprocesarstock = loItem.Noprocesarstock
					lxEquivalencia_PK = loItem.Equivalencia_PK
					lxArticulo_PK = loItem.Articulo_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxTalledetalle = loItem.Talledetalle
					lxTalle_PK = loItem.Talle_PK
					lxCantidad = loItem.Cantidad
					lxPrecioconimpuestos = loItem.Precioconimpuestos
					lxPreciosinimpuestos = loItem.Preciosinimpuestos
					lxDescuento = loItem.Descuento
					lxMontodescuento = loItem.Montodescuento
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.DETMTRANS("IdItem","fporIva","COMP","NROITEM","ProcStock","Equiv","NUMR","MART","DESCRIP","cColor","COLTXT","TALLTXT","Talle","CANTI","prunconimp","prunSInimp","FCFI","MNTDES" ) values ( <<"'" + this.FormatearTextoSql( lxIditemarticulos ) + "'">>, <<lxPorcentajeiva>>, <<lxComportamiento>>, <<lxNroitem>>, <<iif( lxNoprocesarstock, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxEquivalencia_PK ) + "'">>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalledetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<lxCantidad>>, <<lxPrecioconimpuestos>>, <<lxPreciosinimpuestos>>, <<lxDescuento>>, <<lxMontodescuento>> ) 
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

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  MTRANS.CODIGO != '']
		loColeccion.Agregar( 'delete from ZooLogic.MTRANS where ' + lcFiltro )
			loColeccion.Agregar([delete from ZooLogic.CompAfe where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.DETMTRANS where "NUMR" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.cTabla = 'MTRANS' 
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
			.MovimientoDetalle.oItem.oCompStock.lNuevo = .EsNuevo()
			.MovimientoDetalle.oItem.oCompStock.lEdicion = .EsEdicion()
			.MovimientoDetalle.oItem.oCompStock.lEliminar = .lEliminar
			.MovimientoDetalle.oItem.oCompStock.lAnular = .lAnular
			loColSentencias = .MovimientoDetalle.oItem.oCompStock.grabar()
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
			lcRetorno = [update ZooLogic.MTRANS set TimeStamp = ] + transform( lnTimeStamp ) + lcUpdateRealTime + [ where CODIGO = ] + "'" + this.FormatearTextoSql( .Codigo ) + "'" + [ and  MTRANS.CODIGO != ''] + goServicios.RealTime.ObtenerTagEstimulo( .cNombre )
		
		endwith
		return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function ObtenerCantidadRegistros() as integer
		local lnCantReg as integer
			local lcXml as string
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.MTRANS where  MTRANS.CODIGO != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.MTRANS where CODIGO = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  MTRANS.CODIGO != ''" )
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
		local lcCursor as String, ldFecha as Date, lcHora as string, lcValorABuscar As String, lxValorClavePK As variant, lxValorClavePrimaria As variant, lcIdentificadorParaLoguear as string, lxMTRANSNUMERO as variant, lcMensajeExtra as String
		lcValorABuscar = ''
		lxValorClavePK = ''
		lcMensajeExtra = ''
		lcCursor = This.oEntidad.cPrefijoRecibir + 'MERCADERIAENTRANSITO'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.MTRANS Where  NUMERO = ] + transform( &lcCursor..NUMERO     ), 'curSeek', this.datasessionid )
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
								this.oConexion.EjecutarSql( [UPDATE ZooLogic.MTRANS set  FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FECHAORI = ] + "'" + this.ConvertirDateSql( &lcCursor..FECHAORI ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, DescFW = ] + "'" + this.FormatearTextoSql( &lcCursor..DescFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, TIMESTAMP = ] + transform( &lcCursor..TIMESTAMP )+ [, CLASE = ] + transform( &lcCursor..CLASE )+ [, Anulado = ] + Transform( iif( &lcCursor..Anulado, 1, 0 ))+ [, CODIGO = ] + "'" + this.FormatearTextoSql( &lcCursor..CODIGO ) + "'"+ [, MObs = ] + "'" + this.FormatearTextoSql( &lcCursor..MObs ) + "'"+ [, ORIGDEST = ] + "'" + this.FormatearTextoSql( &lcCursor..ORIGDEST ) + "'"+ [, NUMERO = ] + transform( &lcCursor..NUMERO )+ [, NUMEROORI = ] + transform( &lcCursor..NUMEROORI )+ [, FECHA = ] + "'" + this.ConvertirDateSql( &lcCursor..FECHA ) + "'"+ [, DIRMOV = ] + transform( &lcCursor..DIRMOV )+ [, DatOri = ] + "'" + this.FormatearTextoSql( &lcCursor..DatOri ) + "'"+ [, MOTIVO = ] + "'" + this.FormatearTextoSql( &lcCursor..MOTIVO ) + "'"+ [, VENDEDOR = ] + "'" + this.FormatearTextoSql( &lcCursor..VENDEDOR ) + "'"+ [, ORIGTIPO = ] + transform( &lcCursor..ORIGTIPO )+ [, REMITO = ] + "'" + this.FormatearTextoSql( &lcCursor..REMITO ) + "'"+ [, ORIGLETRA = ] + "'" + this.FormatearTextoSql( &lcCursor..ORIGLETRA ) + "'"+ [, MOTREMORG = ] + "'" + this.FormatearTextoSql( &lcCursor..MOTREMORG ) + "'"+ [, MovGen = ] + transform( &lcCursor..MovGen )+ [, ORIGPVTA = ] + transform( &lcCursor..ORIGPVTA )+ [, CompGen = ] + "'" + this.FormatearTextoSql( &lcCursor..CompGen ) + "'"+ [, ORIGNRO = ] + transform( &lcCursor..ORIGNRO )+ [, FPODES = ] + transform( &lcCursor..FPODES )+ [, MD3 = ] + transform( &lcCursor..MD3 )+ [, RecPor = ] + transform( &lcCursor..RecPor )+ [, MR2 = ] + transform( &lcCursor..MR2 ) + [ Where CODIGO = ] + "'" + this.FormatearTextoSql( lcValorABuscar ) + "'" )
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
				this.oConexion.EjecutarSql( [Select * From ZooLogic.MTRANS Where CODIGO = ] + "'" + this.FormatearTextoSql( &lcCursor..CODIGO ) + "'", 'curSeek', this.datasessionid )
				if reccount( 'curSeek' ) > 0
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir como alta porque la clave principal ya existe', tlLoguear )
				Else
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					Text to lcCampos noShow
						 FECIMPO, FECHAORI, FECEXPO, FMODIFW, FALTAFW, FECTRANS, HORAEXPO, BDALTAFW, HORAIMPO, BDMODIFW, ESTTRANS, UMODIFW, HMODIFW, DescFW, ZADSFW, VMODIFW, VALTAFW, SALTAFW, SMODIFW, HALTAFW, UALTAFW, TIMESTAMP, CLASE, Anulado, CODIGO, MObs, ORIGDEST, NUMERO, NUMEROORI, FECHA, DIRMOV, DatOri, MOTIVO, VENDEDOR, ORIGTIPO, REMITO, ORIGLETRA, MOTREMORG, MovGen, ORIGPVTA, CompGen, ORIGNRO, FPODES, MD3, RecPor, MR2
					EndText
					local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECHAORI ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..DescFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..TIMESTAMP ) + ',' + transform( &lcCursor..CLASE ) + ',' + Transform( iif( &lcCursor..Anulado, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..CODIGO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..MObs ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ORIGDEST ) + "'" + ',' + transform( &lcCursor..NUMERO ) + ',' + transform( &lcCursor..NUMEROORI )
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECHA ) + "'" + ',' + transform( &lcCursor..DIRMOV ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..DatOri ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..MOTIVO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VENDEDOR ) + "'" + ',' + transform( &lcCursor..ORIGTIPO ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..REMITO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ORIGLETRA ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..MOTREMORG ) + "'" + ',' + transform( &lcCursor..MovGen ) + ',' + transform( &lcCursor..ORIGPVTA ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..CompGen ) + "'" + ',' + transform( &lcCursor..ORIGNRO ) + ',' + transform( &lcCursor..FPODES ) + ',' + transform( &lcCursor..MD3 ) + ',' + transform( &lcCursor..RecPor ) + ',' + transform( &lcCursor..MR2 )
lcValoresCampos = substr(lcValoresCampos,2) 

					this.oConexion.EjecutarSql( [Insert into ZooLogic.MTRANS ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
				EndIf
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'MERCADERIAENTRANSITO'
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
			this.oConexion.EjecutarSql( [Delete From ZooLogic.CompAfe Where Codigo] + lcIn  )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.DETMTRANS Where NUMR] + lcIn  )
			endfor
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'COMMIT TRANSACTION' )
			endif
		EndIf
	endif
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMCOMPROBANTE'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where Codigo in ( select CODIGO from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"AfeTipoCom","NROITEM","Codigo","AfeComprob","AfeLETRA","AfePTOVEN","AfeNUMCOM","afefecha","afetotal","afevend","afetipo","Afecta","DescInter","NomInter","CodInter","Origen"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.CompAfe ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.AfeTipoCom ) + ',' + transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Codigo     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.AfeComprob ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.AfeLETRA   ) + "'" + ',' + transform( cDetallesExistentes.AfePTOVEN  ) + ',' + transform( cDetallesExistentes.AfeNUMCOM  ) + ',' + "'" + this.ConvertirDateSql( cDetallesExistentes.afefecha   ) + "'" + ',' + transform( cDetallesExistentes.afetotal   ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.afevend    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.afetipo    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Afecta     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.DescInter  ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.NomInter   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CodInter   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Origen     ) + "'" + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMMERCENTRANSITO'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where NUMR in ( select CODIGO from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"IdItem","fporIva","COMP","NROITEM","ProcStock","Equiv","NUMR","MART","DESCRIP","cColor","COLTXT","TALLTXT","Talle","CANTI","prunconimp","prunSInimp","FCFI","MNTDES"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.DETMTRANS ( ] + lcCamposInsert + [ ) values ( ] +  "'" + this.FormatearTextoSql( cDetallesExistentes.IdItem     ) + "'" + ',' + transform( cDetallesExistentes.fporIva    ) + ',' + transform( cDetallesExistentes.COMP       ) + ',' + transform( cDetallesExistentes.NROITEM    ) + ',' + Transform( iif( cDetallesExistentes.ProcStock , 1, 0 )) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Equiv      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.NUMR       ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.MART       ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.DESCRIP    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.cColor     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.COLTXT     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.TALLTXT    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Talle      ) + "'" + ',' + transform( cDetallesExistentes.CANTI      ) + ',' + transform( cDetallesExistentes.prunconimp ) + ',' + transform( cDetallesExistentes.prunSInimp ) + ',' + transform( cDetallesExistentes.FCFI       ) + ',' + transform( cDetallesExistentes.MNTDES     ) + ' )'  )
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
		this.oEntidad.MovimientoDetalle.oItem.oCompStock.Recibir( this.oEntidad, 'MovimientoDetalle',this.oEntidad.cPrefijoRecibir + 'ITEMMERCENTRANSITO',this.oEntidad.cPrefijoRecibir + 'MERCADERIAENTRANSITO')
		
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function ObtenerIdentificadorParaLoguear( tcCursor as String ) As String
		local lcRetorno as String, lnCC as String , loCC as Object, lni as Integer, lcSecuencia as String
		lcRetorno = this.oEntidad.cDescripcion 
		lcRetorno = lcRetorno + ' - Número: ' + transform( &tcCursor..NUMERO     )
		Return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EsAliasDeProceso( tcAlias As String, tcPrefijo as string ) As Boolean
		local llRetorno as Boolean, lcAlias as String, lcPrefijo As String
		llRetorno = .F.
		lcAlias = upper( alltrim( tcAlias ) )
		lcPrefijo = upper( alltrim( tcPrefijo ) )
		Do Case
			Case  lcAlias == lcPrefijo + 'MERCADERIAENTRANSITO'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'MERCADERIAENTRANSITO_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'MERCADERIAENTRANSITO_MOBS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMCOMPROBANTE'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMMERCENTRANSITO'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_MTRANS')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'MERCADERIAENTRANSITO'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..CODIGO
		llCondicion = isnull( lxVar ) or isnull( &lcCursor..NUMERO )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad MERCADERIAENTRANSITO. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'MERCADERIAENTRANSITO'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		select recno() as _Rec, * from &lcCursor into cursor CurConRecno
		select max( _Rec ) as Maximo,CODIGO as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( CODIGO, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		select max( _Rec ) as Maximo,str( NUMERO, 8, 0) as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( str( NUMERO, 8, 0), 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		Use in select( 'CurConRecno' )
		Use in select( 'RepMax' )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDatosInvalidos( toConexion as Object ) as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'MERCADERIAENTRANSITO'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FECHAORI  
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FECHA     
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_MTRANS') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_MTRANS
Create Table ZooLogic.TablaTrabajo_MTRANS ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fecimpo" datetime  null, 
"fechaori" datetime  null, 
"fecexpo" datetime  null, 
"fmodifw" datetime  null, 
"faltafw" datetime  null, 
"fectrans" datetime  null, 
"horaexpo" char( 8 )  null, 
"bdaltafw" char( 8 )  null, 
"horaimpo" char( 8 )  null, 
"bdmodifw" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"umodifw" char( 100 )  null, 
"hmodifw" char( 8 )  null, 
"descfw" char( 200 )  null, 
"zadsfw" varchar(max)  null, 
"vmodifw" char( 13 )  null, 
"valtafw" char( 13 )  null, 
"saltafw" char( 7 )  null, 
"smodifw" char( 7 )  null, 
"haltafw" char( 8 )  null, 
"ualtafw" char( 100 )  null, 
"timestamp" numeric( 20, 0 )  null, 
"clase" numeric( 1, 0 )  null, 
"anulado" bit  null, 
"codigo" char( 38 )  null, 
"mobs" varchar(max)  null, 
"origdest" char( 8 )  null, 
"numero" numeric( 8, 0 )  null, 
"numeroori" numeric( 8, 0 )  null, 
"fecha" datetime  null, 
"dirmov" numeric( 1, 0 )  null, 
"datori" char( 120 )  null, 
"motivo" char( 3 )  null, 
"vendedor" char( 10 )  null, 
"origtipo" numeric( 2, 0 )  null, 
"remito" char( 15 )  null, 
"origletra" char( 1 )  null, 
"motremorg" char( 100 )  null, 
"movgen" numeric( 8, 0 )  null, 
"origpvta" numeric( 4, 0 )  null, 
"compgen" char( 250 )  null, 
"orignro" numeric( 8, 0 )  null, 
"fpodes" numeric( 6, 2 )  null, 
"md3" numeric( 15, 2 )  null, 
"recpor" numeric( 6, 2 )  null, 
"mr2" numeric( 15, 2 )  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_MTRANS' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_MTRANS' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'MERCADERIAENTRANSITO'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		with loManejador
			if this.oEntidad.VerificarContexto( 'CB' )
			else
				.AgregarMapeo('Nrolinea','Nrolinea')
			endif
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('fechaori','fechaori')
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('descfw','descfw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('timestamp','timestamp')
			.AgregarMapeo('clase','clase')
			.AgregarMapeo('anulado','anulado')
			.AgregarMapeo('codigo','codigo')
			.AgregarMapeo('mobs','mobs')
			.AgregarMapeo('origdest','origdest')
			.AgregarMapeo('numero','numero')
			.AgregarMapeo('numeroori','numeroori')
			.AgregarMapeo('fecha','fecha')
			.AgregarMapeo('dirmov','dirmov')
			.AgregarMapeo('datori','datori')
			.AgregarMapeo('motivo','motivo')
			.AgregarMapeo('vendedor','vendedor')
			.AgregarMapeo('origtipo','origtipo')
			.AgregarMapeo('remito','remito')
			.AgregarMapeo('origletra','origletra')
			.AgregarMapeo('motremorg','motremorg')
			.AgregarMapeo('movgen','movgen')
			.AgregarMapeo('origpvta','origpvta')
			.AgregarMapeo('compgen','compgen')
			.AgregarMapeo('orignro','orignro')
			.AgregarMapeo('fpodes','fpodes')
			.AgregarMapeo('md3','md3')
			.AgregarMapeo('recpor','recpor')
			.AgregarMapeo('mr2','mr2')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_MTRANS'
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
				Update t Set t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FECHAORI = isnull( d.FECHAORI, t.FECHAORI ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.DESCFW = isnull( d.DESCFW, t.DESCFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.TIMESTAMP = isnull( d.TIMESTAMP, t.TIMESTAMP ),t.CLASE = isnull( d.CLASE, t.CLASE ),t.ANULADO = isnull( d.ANULADO, t.ANULADO ),t.CODIGO = isnull( d.CODIGO, t.CODIGO ),t.MOBS = isnull( d.MOBS, t.MOBS ),t.ORIGDEST = isnull( d.ORIGDEST, t.ORIGDEST ),t.NUMERO = isnull( d.NUMERO, t.NUMERO ),t.NUMEROORI = isnull( d.NUMEROORI, t.NUMEROORI ),t.FECHA = isnull( d.FECHA, t.FECHA ),t.DIRMOV = isnull( d.DIRMOV, t.DIRMOV ),t.DATORI = isnull( d.DATORI, t.DATORI ),t.MOTIVO = isnull( d.MOTIVO, t.MOTIVO ),t.VENDEDOR = isnull( d.VENDEDOR, t.VENDEDOR ),t.ORIGTIPO = isnull( d.ORIGTIPO, t.ORIGTIPO ),t.REMITO = isnull( d.REMITO, t.REMITO ),t.ORIGLETRA = isnull( d.ORIGLETRA, t.ORIGLETRA ),t.MOTREMORG = isnull( d.MOTREMORG, t.MOTREMORG ),t.MOVGEN = isnull( d.MOVGEN, t.MOVGEN ),t.ORIGPVTA = isnull( d.ORIGPVTA, t.ORIGPVTA ),t.COMPGEN = isnull( d.COMPGEN, t.COMPGEN ),t.ORIGNRO = isnull( d.ORIGNRO, t.ORIGNRO ),t.FPODES = isnull( d.FPODES, t.FPODES ),t.MD3 = isnull( d.MD3, t.MD3 ),t.RECPOR = isnull( d.RECPOR, t.RECPOR ),t.MR2 = isnull( d.MR2, t.MR2 )
					from ZooLogic.MTRANS t inner join deleted d 
							 on t.CODIGO = d.CODIGO
							 and  t.NUMERO = d.NUMERO
				-- Fin Updates
				insert into ZooLogic.MTRANS(Fecimpo,Fechaori,Fecexpo,Fmodifw,Faltafw,Fectrans,Horaexpo,Bdaltafw,Horaimpo,Bdmodifw,Esttrans,Umodifw,Hmodifw,Descfw,Zadsfw,Vmodifw,Valtafw,Saltafw,Smodifw,Haltafw,Ualtafw,Timestamp,Clase,Anulado,Codigo,Mobs,Origdest,Numero,Numeroori,Fecha,Dirmov,Datori,Motivo,Vendedor,Origtipo,Remito,Origletra,Motremorg,Movgen,Origpvta,Compgen,Orignro,Fpodes,Md3,Recpor,Mr2)
					Select isnull( d.FECIMPO,''),isnull( d.FECHAORI,''),isnull( d.FECEXPO,''),isnull( d.FMODIFW,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FECTRANS,''),isnull( d.HORAEXPO,''),isnull( d.BDALTAFW,''),isnull( d.HORAIMPO,''),isnull( d.BDMODIFW,''),isnull( d.ESTTRANS,''),isnull( d.UMODIFW,''),isnull( d.HMODIFW,''),isnull( d.DESCFW,''),isnull( d.ZADSFW,''),isnull( d.VMODIFW,''),isnull( d.VALTAFW,''),isnull( d.SALTAFW,''),isnull( d.SMODIFW,''),convert( char(8), getdate(), 108 ),isnull( d.UALTAFW,''),isnull( d.TIMESTAMP,0),isnull( d.CLASE,0),isnull( d.ANULADO,0),isnull( d.CODIGO,''),isnull( d.MOBS,''),isnull( d.ORIGDEST,''),isnull( d.NUMERO,0),isnull( d.NUMEROORI,0),isnull( d.FECHA,''),isnull( d.DIRMOV,0),isnull( d.DATORI,''),isnull( d.MOTIVO,''),isnull( d.VENDEDOR,''),isnull( d.ORIGTIPO,0),isnull( d.REMITO,''),isnull( d.ORIGLETRA,''),isnull( d.MOTREMORG,''),isnull( d.MOVGEN,0),isnull( d.ORIGPVTA,0),isnull( d.COMPGEN,''),isnull( d.ORIGNRO,0),isnull( d.FPODES,0),isnull( d.MD3,0),isnull( d.RECPOR,0),isnull( d.MR2,0)
						From deleted d left join ZooLogic.MTRANS pk 
							 on d.CODIGO = pk.CODIGO
						 left join ZooLogic.MTRANS cc 
							 on  d.NUMERO = cc.NUMERO
						Where pk.CODIGO Is Null 
							 and cc.NUMERO Is Null 
				-- Fin Inserts
				Insert into ZooLogic.Logueos ( Fecha, Nivel, Logger, Accion, BaseDeDatos, 
					EstadoDelSistema, Aplicacion, Version, 
					Serie, Usuario, NombrePc, 
					UsuarioPc, OrigenLogueo, Mensaje, Excepcion)
				select GetDate(), 'INFO', '', 'Importación <<lcEntidad>>','<<loLogueo.BaseDatos>>',
					<<loLogueo.EstadoSistema>>,'<<loLogueo.Aplicacion>>','<<loLogueo.Version>>',
					'<<loLogueo.Serie>>','<<loLogueo.Usuario>>','<<loLogueo.NombrePc>>',
					'<<loLogueo.UsuarioPc>>','<<loLogueo.OrigenLogueo>>','No se pudo importar la entidad <<lcEntidad>>: NÚMERO ' + cast( d.NUMERO as Varchar(8) ) + '','La clave principal no es la esperada'
					from ZooLogic.MTRANS t inner join deleted d 
							on   t.NUMERO = d.NUMERO
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
					'<<loLogueo.UsuarioPc>>','<<loLogueo.OrigenLogueo>>','No se pudo importar la entidad <<lcEntidad>>: NÚMERO ' + cast( d.NUMERO as Varchar(8) ) + '','La clave principal a importar ya existe'
					from ZooLogic.MTRANS t inner join deleted d 
							 on t.CODIGO = d.CODIGO
						left join deleted h 
							on   t.NUMERO = h.NUMERO
							where   h.NUMERO is null 
			End
		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_CompAfe( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_MTRANS_CompAfe
ON ZooLogic.TablaTrabajo_MTRANS_CompAfe
AFTER DELETE
As
Begin
Update t Set 
t.AFETIPOCOM = isnull( d.AFETIPOCOM, t.AFETIPOCOM ),
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.CODIGO = isnull( d.CODIGO, t.CODIGO ),
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
"AFETIPOCOM",
"NROITEM",
"CODIGO",
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
d.AFETIPOCOM,
d.NROITEM,
d.CODIGO,
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
	function ObtenerTriggerDeleteImportacion_DETMTRANS( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_MTRANS_DETMTRANS
ON ZooLogic.TablaTrabajo_MTRANS_DETMTRANS
AFTER DELETE
As
Begin
Update t Set 
t.IDITEM = isnull( d.IDITEM, t.IDITEM ),
t.FPORIVA = isnull( d.FPORIVA, t.FPORIVA ),
t.COMP = isnull( d.COMP, t.COMP ),
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.PROCSTOCK = isnull( d.PROCSTOCK, t.PROCSTOCK ),
t.EQUIV = isnull( d.EQUIV, t.EQUIV ),
t.NUMR = isnull( d.NUMR, t.NUMR ),
t.MART = isnull( d.MART, t.MART ),
t.DESCRIP = isnull( d.DESCRIP, t.DESCRIP ),
t.CCOLOR = isnull( d.CCOLOR, t.CCOLOR ),
t.COLTXT = isnull( d.COLTXT, t.COLTXT ),
t.TALLTXT = isnull( d.TALLTXT, t.TALLTXT ),
t.TALLE = isnull( d.TALLE, t.TALLE ),
t.CANTI = isnull( d.CANTI, t.CANTI ),
t.PRUNCONIMP = isnull( d.PRUNCONIMP, t.PRUNCONIMP ),
t.PRUNSINIMP = isnull( d.PRUNSINIMP, t.PRUNSINIMP ),
t.FCFI = isnull( d.FCFI, t.FCFI ),
t.MNTDES = isnull( d.MNTDES, t.MNTDES )
from ZooLogic.DETMTRANS t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.DETMTRANS
( 
"IDITEM",
"FPORIVA",
"COMP",
"NROITEM",
"PROCSTOCK",
"EQUIV",
"NUMR",
"MART",
"DESCRIP",
"CCOLOR",
"COLTXT",
"TALLTXT",
"TALLE",
"CANTI",
"PRUNCONIMP",
"PRUNSINIMP",
"FCFI",
"MNTDES"
 )
Select 
d.IDITEM,
d.FPORIVA,
d.COMP,
d.NROITEM,
d.PROCSTOCK,
d.EQUIV,
d.NUMR,
d.MART,
d.DESCRIP,
d.CCOLOR,
d.COLTXT,
d.TALLTXT,
d.TALLE,
d.CANTI,
d.PRUNCONIMP,
d.PRUNSINIMP,
d.FCFI,
d.MNTDES
From deleted d left join ZooLogic.DETMTRANS pk 
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_MTRANS') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_MTRANS
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_MERCADERIAENTRANSITO' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_MERCADERIAENTRANSITO.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechaoriginal = GoLibrerias.ObtenerFechaFormateada( nvl( c_MERCADERIAENTRANSITO.Fechaoriginal, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_MERCADERIAENTRANSITO.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_MERCADERIAENTRANSITO.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_MERCADERIAENTRANSITO.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_MERCADERIAENTRANSITO.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Compafec.Limpiar()
					.Compafec.SetearEsNavegacion( .lProcesando )
					.Compafec.Cargar()
					.Horaexpo = nvl( c_MERCADERIAENTRANSITO.Horaexpo, [] )
					.Basededatosaltafw = nvl( c_MERCADERIAENTRANSITO.Basededatosaltafw, [] )
					.Horaimpo = nvl( c_MERCADERIAENTRANSITO.Horaimpo, [] )
					.Basededatosmodificacionfw = nvl( c_MERCADERIAENTRANSITO.Basededatosmodificacionfw, [] )
					.Estadotransferencia = nvl( c_MERCADERIAENTRANSITO.Estadotransferencia, [] )
					.Usuariomodificacionfw = nvl( c_MERCADERIAENTRANSITO.Usuariomodificacionfw, [] )
					.Horamodificacionfw = nvl( c_MERCADERIAENTRANSITO.Horamodificacionfw, [] )
					.Descripcionfw = nvl( c_MERCADERIAENTRANSITO.Descripcionfw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Versionmodificacionfw = nvl( c_MERCADERIAENTRANSITO.Versionmodificacionfw, [] )
					.Versionaltafw = nvl( c_MERCADERIAENTRANSITO.Versionaltafw, [] )
					.Seriealtafw = nvl( c_MERCADERIAENTRANSITO.Seriealtafw, [] )
					.Seriemodificacionfw = nvl( c_MERCADERIAENTRANSITO.Seriemodificacionfw, [] )
					.Horaaltafw = nvl( c_MERCADERIAENTRANSITO.Horaaltafw, [] )
					.Usuarioaltafw = nvl( c_MERCADERIAENTRANSITO.Usuarioaltafw, [] )
					.Timestamp = nvl( c_MERCADERIAENTRANSITO.Timestamp, 0 )
					.Clase = nvl( c_MERCADERIAENTRANSITO.Clase, 0 )
					.Anulado = nvl( c_MERCADERIAENTRANSITO.Anulado, .F. )
					.Movimientodetalle.Limpiar()
					.Movimientodetalle.SetearEsNavegacion( .lProcesando )
					.Movimientodetalle.Cargar()
					.Codigo = nvl( c_MERCADERIAENTRANSITO.Codigo, [] )
					lcValor = This.ObtenerMemo( 'c_Observacion')
					.Observacion = lcValor 
					.Origendestino_PK =  nvl( c_MERCADERIAENTRANSITO.Origendestino, [] )
					.Numero = nvl( c_MERCADERIAENTRANSITO.Numero, 0 )
					.Numerooriginal = nvl( c_MERCADERIAENTRANSITO.Numerooriginal, 0 )
					.Fecha = GoLibrerias.ObtenerFechaFormateada( nvl( c_MERCADERIAENTRANSITO.Fecha, ctod( '  /  /    ' ) ) )
					.Tipo = nvl( c_MERCADERIAENTRANSITO.Tipo, 0 )
					.Datosadicionales = nvl( c_MERCADERIAENTRANSITO.Datosadicionales, [] )
					.Motivo_PK =  nvl( c_MERCADERIAENTRANSITO.Motivo, [] )
					.Vendedor_PK =  nvl( c_MERCADERIAENTRANSITO.Vendedor, [] )
					.Origtipo = nvl( c_MERCADERIAENTRANSITO.Origtipo, 0 )
					.Remito = nvl( c_MERCADERIAENTRANSITO.Remito, [] )
					.Origletra = nvl( c_MERCADERIAENTRANSITO.Origletra, [] )
					.Motivoremitoorigen = nvl( c_MERCADERIAENTRANSITO.Motivoremitoorigen, [] )
					.Movimientogenerado = nvl( c_MERCADERIAENTRANSITO.Movimientogenerado, 0 )
					.Origptovta = nvl( c_MERCADERIAENTRANSITO.Origptovta, 0 )
					.Comprobantegenerado = nvl( c_MERCADERIAENTRANSITO.Comprobantegenerado, [] )
					.Orignumero = nvl( c_MERCADERIAENTRANSITO.Orignumero, 0 )
					.Porcentajedescuento = nvl( c_MERCADERIAENTRANSITO.Porcentajedescuento, 0 )
					.Montodescuento3 = nvl( c_MERCADERIAENTRANSITO.Montodescuento3, 0 )
					.Recargoporcentaje = nvl( c_MERCADERIAENTRANSITO.Recargoporcentaje, 0 )
					.Recargomonto2 = nvl( c_MERCADERIAENTRANSITO.Recargomonto2, 0 )
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
			lxRetorno = c_MERCADERIAENTRANSITO.CODIGO
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

		loDetalle = this.oEntidad.MovimientoDetalle
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
		return c_MERCADERIAENTRANSITO.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.MTRANS' )
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
								from ZooLogic.MTRANS 
								Where   MTRANS.CODIGO != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "MTRANS", "", lcCursor, set("Datasession") )
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
			"Fecimpo" as "Fechaimpo", "Fechaori" as "Fechaoriginal", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Horaexpo" as "Horaexpo", "Bdaltafw" as "Basededatosaltafw", "Horaimpo" as "Horaimpo", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Umodifw" as "Usuariomodificacionfw", "Hmodifw" as "Horamodificacionfw", "Descfw" as "Descripcionfw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Haltafw" as "Horaaltafw", "Ualtafw" as "Usuarioaltafw", "Timestamp" as "Timestamp", "Clase" as "Clase", "Anulado" as "Anulado", "Codigo" as "Codigo", "Mobs" as "Observacion", "Origdest" as "Origendestino", "Numero" as "Numero", "Numeroori" as "Numerooriginal", "Fecha" as "Fecha", "Dirmov" as "Tipo", "Datori" as "Datosadicionales", "Motivo" as "Motivo", "Vendedor" as "Vendedor", "Origtipo" as "Origtipo", "Remito" as "Remito", "Origletra" as "Origletra", "Motremorg" as "Motivoremitoorigen", "Movgen" as "Movimientogenerado", "Origpvta" as "Origptovta", "Compgen" as "Comprobantegenerado", "Orignro" as "Orignumero", "Fpodes" as "Porcentajedescuento", "Md3" as "Montodescuento3", "Recpor" as "Recargoporcentaje", "Mr2" as "Recargomonto2"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.MTRANS 
								Where   MTRANS.CODIGO != ''
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
	Tabla = 'MTRANS'
	Filtro = " MTRANS.CODIGO != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " MTRANS.CODIGO != ''"
	AnchoCampo = 13
	Caracteres = 13
	nrodecolumnas = 0
	signopregunta = .T.
	signopregunta2 = .t.
	TablaAuxiliar = .f.
	cOrden = "MTRANS.NUMERO"
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
	<row entidad="MERCADERIAENTRANSITO                    " atributo="FECHAIMPO                               " tabla="MTRANS         " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MERCADERIAENTRANSITO                    " atributo="FECHAORIGINAL                           " tabla="MTRANS         " campo="FECHAORI  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha original                                                                                                                                                  " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MERCADERIAENTRANSITO                    " atributo="FECHAEXPO                               " tabla="MTRANS         " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MERCADERIAENTRANSITO                    " atributo="FECHAMODIFICACIONFW                     " tabla="MTRANS         " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MERCADERIAENTRANSITO                    " atributo="FECHAALTAFW                             " tabla="MTRANS         " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MERCADERIAENTRANSITO                    " atributo="FECHATRANSFERENCIA                      " tabla="MTRANS         " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha de novedad                                                                                                                                                " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MERCADERIAENTRANSITO                    " atributo="COMPAFEC                                " tabla="COMPAFE        " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="DETALLEITEMCOMPROBANTE        " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MERCADERIAENTRANSITO                    " atributo="HORAEXPO                                " tabla="MTRANS         " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MERCADERIAENTRANSITO                    " atributo="BASEDEDATOSALTAFW                       " tabla="MTRANS         " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MERCADERIAENTRANSITO                    " atributo="HORAIMPO                                " tabla="MTRANS         " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MERCADERIAENTRANSITO                    " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="MTRANS         " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MERCADERIAENTRANSITO                    " atributo="ESTADOTRANSFERENCIA                     " tabla="MTRANS         " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado de novedad                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MERCADERIAENTRANSITO                    " atributo="USUARIOMODIFICACIONFW                   " tabla="MTRANS         " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MERCADERIAENTRANSITO                    " atributo="HORAMODIFICACIONFW                      " tabla="MTRANS         " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MERCADERIAENTRANSITO                    " atributo="DESCRIPCIONFW                           " tabla="MTRANS         " campo="DESCFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="200" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MERCADERIAENTRANSITO                    " atributo="ZADSFW                                  " tabla="MTRANS         " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MERCADERIAENTRANSITO                    " atributo="VERSIONMODIFICACIONFW                   " tabla="MTRANS         " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MERCADERIAENTRANSITO                    " atributo="VERSIONALTAFW                           " tabla="MTRANS         " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MERCADERIAENTRANSITO                    " atributo="SERIEALTAFW                             " tabla="MTRANS         " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MERCADERIAENTRANSITO                    " atributo="SERIEMODIFICACIONFW                     " tabla="MTRANS         " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MERCADERIAENTRANSITO                    " atributo="HORAALTAFW                              " tabla="MTRANS         " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MERCADERIAENTRANSITO                    " atributo="USUARIOALTAFW                           " tabla="MTRANS         " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MERCADERIAENTRANSITO                    " atributo="TIMESTAMP                               " tabla="MTRANS         " campo="TIMESTAMP " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MERCADERIAENTRANSITO                    " atributo="CLASE                                   " tabla="MTRANS         " campo="CLASE     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="1                                                                                                                                                                                                                                                             " obligatorio="true" admitebusqueda="0" etiqueta="Clase                                                                                                                                                           " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MERCADERIAENTRANSITO                    " atributo="ANULADO                                 " tabla="MTRANS         " campo="ANULADO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Esta anulado                                                                                                                                                    " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MERCADERIAENTRANSITO                    " atributo="MOVIMIENTODETALLE                       " tabla="DETMTRANS      " campo="NUMR      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="Artículos                                                                                                                                                       " dominio="DETALLEITEMMERCENTRANSITO     " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MERCADERIAENTRANSITO                    " atributo="CODIGO                                  " tabla="MTRANS         " campo="CODIGO    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="10" etiqueta="Número interno                                                                                                                                                  " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MERCADERIAENTRANSITO                    " atributo="OBSERVACION                             " tabla="MTRANS         " campo="MOBS      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="402" etiqueta="Observaciones                                                                                                                                                   " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MERCADERIAENTRANSITO                    " atributo="ORIGENDESTINO                           " tabla="MTRANS         " campo="ORIGDEST  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="ORIGENDEDATOS                           " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="404" etiqueta="Origen/Destino                                                                                                                                                  " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MERCADERIAENTRANSITO                    " atributo="NUMERO                                  " tabla="MTRANS         " campo="NUMERO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="8" etiqueta="Número                                                                                                                                                          " dominio="CLAVECANDIDATA                " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="1" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MERCADERIAENTRANSITO                    " atributo="NUMEROORIGINAL                          " tabla="MTRANS         " campo="NUMEROORI " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Número original                                                                                                                                                 " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MERCADERIAENTRANSITO                    " atributo="FECHA                                   " tabla="MTRANS         " campo="FECHA     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goServicios.librerias.ObtenerFecha()                                                                                                                                                                                                                         " obligatorio="true" admitebusqueda="6" etiqueta="Fecha                                                                                                                                                           " dominio="FECHACOMPROBANTE              " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MERCADERIAENTRANSITO                    " atributo="TIPO                                    " tabla="MTRANS         " campo="DIRMOV    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="1                                                                                                                                                                                                                                                             " obligatorio="true" admitebusqueda="406" etiqueta="Tipo                                                                                                                                                            " dominio="COMBOMOVMER                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MERCADERIAENTRANSITO                    " atributo="DATOSADICIONALES                        " tabla="MTRANS         " campo="DATORI    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="120" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="408" etiqueta="Datos adicionales                                                                                                                                               " dominio="OBSERVACION4R                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MERCADERIAENTRANSITO                    " atributo="MOTIVO                                  " tabla="MTRANS         " campo="MOTIVO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="MOTIVO                                  " tipodato="C         " longitud="3" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Motivo                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="5" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MERCADERIAENTRANSITO                    " atributo="VENDEDOR                                " tabla="MTRANS         " campo="VENDEDOR  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="VENDEDOR                                " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Vendedor                                                                                                                                                        " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="6" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MERCADERIAENTRANSITO                    " atributo="ORIGTIPO                                " tabla="MTRANS         " campo="ORIGTIPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Tipo comprobante                                                                                                                                                " dominio="COMPROBANTEEDICION            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="7" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MERCADERIAENTRANSITO                    " atributo="REMITO                                  " tabla="MTRANS         " campo="REMITO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="4" etiqueta="Remito                                                                                                                                                          " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="A 9999-99999999          " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MERCADERIAENTRANSITO                    " atributo="ORIGLETRA                               " tabla="MTRANS         " campo="ORIGLETRA " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Letra comprobante                                                                                                                                               " dominio="COMPROBANTEEDICION            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="8" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MERCADERIAENTRANSITO                    " atributo="MOTIVOREMITOORIGEN                      " tabla="MTRANS         " campo="MOTREMORG " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="410" etiqueta="Motivo de remito origen                                                                                                                                         " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="8" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MERCADERIAENTRANSITO                    " atributo="MOVIMIENTOGENERADO                      " tabla="MTRANS         " campo="MOVGEN    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Movimiento generado                                                                                                                                             " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="8" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MERCADERIAENTRANSITO                    " atributo="ORIGPTOVTA                              " tabla="MTRANS         " campo="ORIGPVTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="4" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Punto venta comprobante                                                                                                                                         " dominio="COMPROBANTEEDICION            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="9" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MERCADERIAENTRANSITO                    " atributo="COMPROBANTEGENERADO                     " tabla="MTRANS         " campo="COMPGEN   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="250" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="412" etiqueta="Comprobante generado                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="9" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MERCADERIAENTRANSITO                    " atributo="ORIGNUMERO                              " tabla="MTRANS         " campo="ORIGNRO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Número comprobante                                                                                                                                              " dominio="COMPROBANTEEDICION            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="10" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MERCADERIAENTRANSITO                    " atributo="PORCENTAJEDESCUENTO                     " tabla="MTRANS         " campo="FPODES    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="6" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="% Descuento                                                                                                                                                     " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="10" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MERCADERIAENTRANSITO                    " atributo="MONTODESCUENTO3                         " tabla="MTRANS         " campo="MD3       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Monto de descuento                                                                                                                                              " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="20" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MERCADERIAENTRANSITO                    " atributo="RECARGOPORCENTAJE                       " tabla="MTRANS         " campo="RECPOR    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="6" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="% Recargo                                                                                                                                                       " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="30" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MERCADERIAENTRANSITO                    " atributo="RECARGOMONTO2                           " tabla="MTRANS         " campo="MR2       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Monto recargo                                                                                                                                                   " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="40" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORIGENDEDATOS                           " atributo="DESCRIPCION                             " tabla="ORDAT          " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="405" etiqueta="Detalle Ori.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join ORDAT On MTRANS.ORIGDEST = ORDAT.CODIGO And  ORDAT.CODIGO != ''                                                                                                                                                                                    " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
</VFPData>

			Endtext

			text to .cEstructuraDetalle noshow 
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
	<row entidad="ITEMMERCENTRANSITO                      " atributo="ARTICULO                                " tabla="DETMTRANS      " campo="MART      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="ARTICULO                                " tipodato="C         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="201" etiqueta="DetalleArtículos, Artículo                                                                                                                                      " dominio="CONSOPORTEPREPANTALLA         " detalle="false" tipo="I" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join DETMTRANS On MTRANS.CODIGO = DETMTRANS.NUMR And  MTRANS.CODIGO != ''                                                                                                                                                                               " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ITEMMERCENTRANSITO                      " atributo="ARTICULODETALLE                         " tabla="DETMTRANS      " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="202" etiqueta="DetalleArtículos, Artículo descripción                                                                                                                          " dominio="DESCRIPCION                   " detalle="false" tipo="I" atributoforaneo="Articulo.Descripcion                                                                                                                                                                                                                                          " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join DETMTRANS On MTRANS.CODIGO = DETMTRANS.NUMR And  MTRANS.CODIGO != ''                                                                                                                                                                               " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ITEMMERCENTRANSITO                      " atributo="COLOR                                   " tabla="DETMTRANS      " campo="CCOLOR    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="COLOR                                   " tipodato="C         " longitud="6" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="203" etiqueta="DetalleArtículos, Color                                                                                                                                         " dominio="CODIGO                        " detalle="false" tipo="I" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join DETMTRANS On MTRANS.CODIGO = DETMTRANS.NUMR And  MTRANS.CODIGO != ''                                                                                                                                                                               " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ITEMMERCENTRANSITO                      " atributo="COLORDETALLE                            " tabla="DETMTRANS      " campo="COLTXT    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="204" etiqueta="DetalleArtículos, Color descripción                                                                                                                             " dominio="DESCRIPCION                   " detalle="false" tipo="I" atributoforaneo="Color.Descripcion                                                                                                                                                                                                                                             " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join DETMTRANS On MTRANS.CODIGO = DETMTRANS.NUMR And  MTRANS.CODIGO != ''                                                                                                                                                                               " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ITEMMERCENTRANSITO                      " atributo="TALLE                                   " tabla="DETMTRANS      " campo="TALLE     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="TALLE                                   " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="205" etiqueta="DetalleArtículos, Talle                                                                                                                                         " dominio="CODIGO                        " detalle="false" tipo="I" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join DETMTRANS On MTRANS.CODIGO = DETMTRANS.NUMR And  MTRANS.CODIGO != ''                                                                                                                                                                               " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ITEMMERCENTRANSITO                      " atributo="CANTIDAD                                " tabla="DETMTRANS      " campo="CANTI     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="206" etiqueta="DetalleArtículos, Cantidad                                                                                                                                      " dominio="NUMERICODECIMALPARAMETRIZADO  " detalle="false" tipo="I" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join DETMTRANS On MTRANS.CODIGO = DETMTRANS.NUMR And  MTRANS.CODIGO != ''                                                                                                                                                                               " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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