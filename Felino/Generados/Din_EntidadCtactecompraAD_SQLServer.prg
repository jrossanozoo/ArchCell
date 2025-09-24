
define class Din_EntidadCTACTECOMPRAAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_CTACTECOMPRA'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = [dtos( FechaVencimiento ) + str( TipoDeComprobante, 2, 0) + Letra + str( PuntoDeVenta, 4, 0) + str( Numero, 8, 0) + Valor + Proveedor]
	cExpresionCCPorCampos = [dtos( #tabla#.fechaven ) + str( #tabla#.TipoComp, 2, 0) + #tabla#.letra + str( #tabla#.ptovta, 4, 0) + str( #tabla#.numero, 8, 0) + #tabla#.Valor + #tabla#.Cliente]
	cTagClaveCandidata = '_130CC'
	cTagClavePk = '_130PK'
	cTablaPrincipal = 'CCCOMPRA'
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
			local  lxCccompraFaltafw, lxCccompraFecexpo, lxCccompraFmodifw, lxCccompraFecimpo, lxCccompraFectrans, lxCccompraMontosin, lxCccompraMontogra, lxCccompraMontocon, lxCccompraCompcc, lxCccompraMontoiva, lxCccompraHaltafw, lxCccompraValtafw, lxCccompraHoraexpo, lxCccompraVmodifw, lxCccompraHoraimpo, lxCccompraSaltafw, lxCccompraSmodifw, lxCccompraHmodifw, lxCccompraUaltafw, lxCccompraEsttrans, lxCccompraCodcomp, lxCccompraUmodifw, lxCccompraZadsfw, lxCccompraBdaltafw, lxCccompraBdmodifw, lxCccompraMoneda, lxCccompraCodigo, lxCccompraCliente, lxCccompraLetra, lxCccompraPtovta, lxCccompraNumero, lxCccompraTotalcc, lxCccompraFechaven, lxCccompraFechaemi, lxCccompraTipocomp, lxCccompraSaldocc, lxCccompraFecha, lxCccompraComprob, lxCccompraAnotacion, lxCccompraPtovtaext, lxCccompraValor, lxCccompraSigno
				lxCccompraFaltafw =  .Fechaaltafw			lxCccompraFecexpo =  .Fechaexpo			lxCccompraFmodifw =  .Fechamodificacionfw			lxCccompraFecimpo =  .Fechaimpo			lxCccompraFectrans =  .Fechatransferencia			lxCccompraMontosin =  .Montocomprobantesinimpuesto			lxCccompraMontogra =  .Montocomprobantegravado			lxCccompraMontocon =  .Montocomprobanteconimpuesto			lxCccompraCompcc =  .Comprometidocc			lxCccompraMontoiva =  .Montocomprobanteiva			lxCccompraHaltafw =  .Horaaltafw			lxCccompraValtafw =  .Versionaltafw			lxCccompraHoraexpo =  .Horaexpo			lxCccompraVmodifw =  .Versionmodificacionfw			lxCccompraHoraimpo =  .Horaimpo			lxCccompraSaltafw =  .Seriealtafw			lxCccompraSmodifw =  .Seriemodificacionfw			lxCccompraHmodifw =  .Horamodificacionfw			lxCccompraUaltafw =  .Usuarioaltafw			lxCccompraEsttrans =  .Estadotransferencia			lxCccompraCodcomp =  .Codigocomprobante			lxCccompraUmodifw =  .Usuariomodificacionfw			lxCccompraZadsfw =  .Zadsfw			lxCccompraBdaltafw =  .Basededatosaltafw			lxCccompraBdmodifw =  .Basededatosmodificacionfw			lxCccompraMoneda =  upper( .Moneda_PK ) 			lxCccompraCodigo =  .Codigo			lxCccompraCliente =  upper( .Proveedor_PK ) 			lxCccompraLetra =  .Letra			lxCccompraPtovta =  .Puntodeventa			lxCccompraNumero =  .Numero			lxCccompraTotalcc =  .Totalcc			lxCccompraFechaven =  .Fechavencimiento			lxCccompraFechaemi =  .Fechaemision			lxCccompraTipocomp =  .Tipodecomprobante			lxCccompraSaldocc =  .Saldocc			lxCccompraFecha =  .Fecha			lxCccompraComprob =  .Comprobante			lxCccompraAnotacion =  .Anotacion			lxCccompraPtovtaext =  .Puntodeventaextendido			lxCccompraValor =  upper( .Valor_PK ) 			lxCccompraSigno =  .Signodemovimiento
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxCccompraCodigo = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.CCCOMPRA ( "Faltafw","Fecexpo","Fmodifw","Fecimpo","Fectrans","Montosin","Montogra","Montocon","Compcc","Montoiva","Haltafw","Valtafw","Horaexpo","Vmodifw","Horaimpo","Saltafw","Smodifw","Hmodifw","Ualtafw","Esttrans","Codcomp","Umodifw","Zadsfw","Bdaltafw","Bdmodifw","Moneda","Codigo","Cliente","Letra","Ptovta","Numero","Totalcc","Fechaven","Fechaemi","Tipocomp","Saldocc","Fecha","Comprob","Anotacion","Ptovtaext","Valor","Signo" ) values ( <<"'" + this.ConvertirDateSql( lxCccompraFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCccompraFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCccompraFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCccompraFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCccompraFectrans ) + "'" >>, <<lxCccompraMontosin >>, <<lxCccompraMontogra >>, <<lxCccompraMontocon >>, <<lxCccompraCompcc >>, <<lxCccompraMontoiva >>, <<"'" + this.FormatearTextoSql( lxCccompraHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCccompraValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCccompraHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCccompraVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCccompraHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCccompraSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCccompraSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCccompraHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCccompraUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCccompraEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCccompraCodcomp ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCccompraUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCccompraZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCccompraBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCccompraBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCccompraMoneda ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCccompraCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCccompraCliente ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCccompraLetra ) + "'" >>, <<lxCccompraPtovta >>, <<lxCccompraNumero >>, <<lxCccompraTotalcc >>, <<"'" + this.ConvertirDateSql( lxCccompraFechaven ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCccompraFechaemi ) + "'" >>, <<lxCccompraTipocomp >>, <<lxCccompraSaldocc >>, <<"'" + this.ConvertirDateSql( lxCccompraFecha ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCccompraComprob ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCccompraAnotacion ) + "'" >>, <<lxCccompraPtovtaext >>, <<"'" + this.FormatearTextoSql( lxCccompraValor ) + "'" >>, <<lxCccompraSigno >> )
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
		this.ComprobarTransaccion()
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = lxValorClavePrimaria

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
			local  lxCccompraFaltafw, lxCccompraFecexpo, lxCccompraFmodifw, lxCccompraFecimpo, lxCccompraFectrans, lxCccompraMontosin, lxCccompraMontogra, lxCccompraMontocon, lxCccompraCompcc, lxCccompraMontoiva, lxCccompraHaltafw, lxCccompraValtafw, lxCccompraHoraexpo, lxCccompraVmodifw, lxCccompraHoraimpo, lxCccompraSaltafw, lxCccompraSmodifw, lxCccompraHmodifw, lxCccompraUaltafw, lxCccompraEsttrans, lxCccompraCodcomp, lxCccompraUmodifw, lxCccompraZadsfw, lxCccompraBdaltafw, lxCccompraBdmodifw, lxCccompraMoneda, lxCccompraCodigo, lxCccompraCliente, lxCccompraLetra, lxCccompraPtovta, lxCccompraNumero, lxCccompraTotalcc, lxCccompraFechaven, lxCccompraFechaemi, lxCccompraTipocomp, lxCccompraSaldocc, lxCccompraFecha, lxCccompraComprob, lxCccompraAnotacion, lxCccompraPtovtaext, lxCccompraValor, lxCccompraSigno
				lxCccompraFaltafw =  .Fechaaltafw			lxCccompraFecexpo =  .Fechaexpo			lxCccompraFmodifw =  .Fechamodificacionfw			lxCccompraFecimpo =  .Fechaimpo			lxCccompraFectrans =  .Fechatransferencia			lxCccompraMontosin =  .Montocomprobantesinimpuesto			lxCccompraMontogra =  .Montocomprobantegravado			lxCccompraMontocon =  .Montocomprobanteconimpuesto			lxCccompraCompcc =  .Comprometidocc			lxCccompraMontoiva =  .Montocomprobanteiva			lxCccompraHaltafw =  .Horaaltafw			lxCccompraValtafw =  .Versionaltafw			lxCccompraHoraexpo =  .Horaexpo			lxCccompraVmodifw =  .Versionmodificacionfw			lxCccompraHoraimpo =  .Horaimpo			lxCccompraSaltafw =  .Seriealtafw			lxCccompraSmodifw =  .Seriemodificacionfw			lxCccompraHmodifw =  .Horamodificacionfw			lxCccompraUaltafw =  .Usuarioaltafw			lxCccompraEsttrans =  .Estadotransferencia			lxCccompraCodcomp =  .Codigocomprobante			lxCccompraUmodifw =  .Usuariomodificacionfw			lxCccompraZadsfw =  .Zadsfw			lxCccompraBdaltafw =  .Basededatosaltafw			lxCccompraBdmodifw =  .Basededatosmodificacionfw			lxCccompraMoneda =  upper( .Moneda_PK ) 			lxCccompraCodigo =  .Codigo			lxCccompraCliente =  upper( .Proveedor_PK ) 			lxCccompraLetra =  .Letra			lxCccompraPtovta =  .Puntodeventa			lxCccompraNumero =  .Numero			lxCccompraTotalcc =  .Totalcc			lxCccompraFechaven =  .Fechavencimiento			lxCccompraFechaemi =  .Fechaemision			lxCccompraTipocomp =  .Tipodecomprobante			lxCccompraSaldocc =  .Saldocc			lxCccompraFecha =  .Fecha			lxCccompraComprob =  .Comprobante			lxCccompraAnotacion =  .Anotacion			lxCccompraPtovtaext =  .Puntodeventaextendido			lxCccompraValor =  upper( .Valor_PK ) 			lxCccompraSigno =  .Signodemovimiento
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()
			lxValorClavePrimaria = .oEntidad.CODIGO
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ZooLogic.CCCOMPRA set "Faltafw" = <<"'" + this.ConvertirDateSql( lxCccompraFaltafw ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxCccompraFecexpo ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxCccompraFmodifw ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxCccompraFecimpo ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxCccompraFectrans ) + "'">>,"Montosin" = <<lxCccompraMontosin>>,"Montogra" = <<lxCccompraMontogra>>,"Montocon" = <<lxCccompraMontocon>>,"Compcc" = "Compcc" + <<lxCccompraCompcc>>,"Montoiva" = <<lxCccompraMontoiva>>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxCccompraHaltafw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxCccompraValtafw ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxCccompraHoraexpo ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxCccompraVmodifw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxCccompraHoraimpo ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxCccompraSaltafw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxCccompraSmodifw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxCccompraHmodifw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxCccompraUaltafw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxCccompraEsttrans ) + "'">>,"Codcomp" = <<"'" + this.FormatearTextoSql( lxCccompraCodcomp ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxCccompraUmodifw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxCccompraZadsfw ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxCccompraBdaltafw ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxCccompraBdmodifw ) + "'">>,"Moneda" = <<"'" + this.FormatearTextoSql( lxCccompraMoneda ) + "'">>,"Codigo" = <<"'" + this.FormatearTextoSql( lxCccompraCodigo ) + "'">>,"Cliente" = <<"'" + this.FormatearTextoSql( lxCccompraCliente ) + "'">>,"Letra" = <<"'" + this.FormatearTextoSql( lxCccompraLetra ) + "'">>,"Ptovta" = <<lxCccompraPtovta>>,"Numero" = <<lxCccompraNumero>>,"Totalcc" = <<lxCccompraTotalcc>>,"Fechaven" = <<"'" + this.ConvertirDateSql( lxCccompraFechaven ) + "'">>,"Fechaemi" = <<"'" + this.ConvertirDateSql( lxCccompraFechaemi ) + "'">>,"Tipocomp" = <<lxCccompraTipocomp>>,"Saldocc" = "Saldocc" + <<lxCccompraSaldocc>>,"Fecha" = <<"'" + this.ConvertirDateSql( lxCccompraFecha ) + "'">>,"Comprob" = <<"'" + this.FormatearTextoSql( lxCccompraComprob ) + "'">>,"Anotacion" = <<"'" + this.FormatearTextoSql( lxCccompraAnotacion ) + "'">>,"Ptovtaext" = <<lxCccompraPtovtaext>>,"Valor" = <<"'" + this.FormatearTextoSql( lxCccompraValor ) + "'">>,"Signo" = <<lxCccompraSigno>> where "Codigo" = <<"'" + this.FormatearTextoSql( lxCccompraCodigo ) + "'">> and  CCCOMPRA.CODIGO != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			this.ComprobarResultadoDeEjecucionDelUpdate()
		this.ComprobarTransaccion()
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 Codigo from ZooLogic.CCCOMPRA where " + this.ConvertirFuncionesSql( " CCCOMPRA.CODIGO != ''" ) )
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
			Local lxCccompraCodigo
			lxCccompraCodigo = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Montosin" as "Montocomprobantesinimpuesto", "Montogra" as "Montocomprobantegravado", "Montocon" as "Montocomprobanteconimpuesto", "Compcc" as "Comprometidocc", "Montoiva" as "Montocomprobanteiva", "Haltafw" as "Horaaltafw", "Valtafw" as "Versionaltafw", "Horaexpo" as "Horaexpo", "Vmodifw" as "Versionmodificacionfw", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Ualtafw" as "Usuarioaltafw", "Esttrans" as "Estadotransferencia", "Codcomp" as "Codigocomprobante", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Moneda" as "Moneda", "Codigo" as "Codigo", "Cliente" as "Proveedor", "Letra" as "Letra", "Ptovta" as "Puntodeventa", "Numero" as "Numero", "Totalcc" as "Totalcc", "Fechaven" as "Fechavencimiento", "Fechaemi" as "Fechaemision", "Tipocomp" as "Tipodecomprobante", "Saldocc" as "Saldocc", "Fecha" as "Fecha", "Comprob" as "Comprobante", "Anotacion" as "Anotacion", "Ptovtaext" as "Puntodeventaextendido", "Valor" as "Valor", "Signo" as "Signodemovimiento" from ZooLogic.CCCOMPRA where "Codigo" = <<"'" + this.FormatearTextoSql( lxCccompraCodigo ) + "'">> and  CCCOMPRA.CODIGO != ''
			endtext
			use in select('c_CTACTECOMPRA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CTACTECOMPRA', set( 'Datasession' ) )

			if reccount( 'c_CTACTECOMPRA' ) = 0
				llRetorno = .f.
			else
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ConsultarPorClaveCandidata() as Boolean
		local llRetorno as Boolean
		llRetorno = .t.
		with this.oEntidad
			Local lxccComprafechaven As Variant, lxccCompraTipoComp As Variant, lxccCompraletra As Variant, lxccCompraptovta As Variant, lxccCompranumero As Variant, lxccCompraValor As Variant, lxccCompraCliente As Variant
			lxccComprafechaven = .FechaVencimiento
			lxccCompraTipoComp = .TipoDeComprobante
			lxccCompraletra = .Letra
			lxccCompraptovta = .PuntoDeVenta
			lxccCompranumero = .Numero
			lxccCompraValor = .Valor_Pk
			lxccCompraCliente = .Proveedor_Pk
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Montosin" as "Montocomprobantesinimpuesto", "Montogra" as "Montocomprobantegravado", "Montocon" as "Montocomprobanteconimpuesto", "Compcc" as "Comprometidocc", "Montoiva" as "Montocomprobanteiva", "Haltafw" as "Horaaltafw", "Valtafw" as "Versionaltafw", "Horaexpo" as "Horaexpo", "Vmodifw" as "Versionmodificacionfw", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Ualtafw" as "Usuarioaltafw", "Esttrans" as "Estadotransferencia", "Codcomp" as "Codigocomprobante", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Moneda" as "Moneda", "Codigo" as "Codigo", "Cliente" as "Proveedor", "Letra" as "Letra", "Ptovta" as "Puntodeventa", "Numero" as "Numero", "Totalcc" as "Totalcc", "Fechaven" as "Fechavencimiento", "Fechaemi" as "Fechaemision", "Tipocomp" as "Tipodecomprobante", "Saldocc" as "Saldocc", "Fecha" as "Fecha", "Comprob" as "Comprobante", "Anotacion" as "Anotacion", "Ptovtaext" as "Puntodeventaextendido", "Valor" as "Valor", "Signo" as "Signodemovimiento" from ZooLogic.CCCOMPRA where  CCCOMPRA.CODIGO != '' And fechaven = <<"'" + this.ConvertirDateSql( lxccComprafechaven ) + "'">> and TipoComp = <<lxccCompraTipoComp>> and letra = <<"'" + this.FormatearTextoSql( lxccCompraletra ) + "'">> and ptovta = <<lxccCompraptovta>> and numero = <<lxccCompranumero>> and Valor = <<"'" + this.FormatearTextoSql( lxccCompraValor ) + "'">> and Cliente = <<"'" + this.FormatearTextoSql( lxccCompraCliente ) + "'">>
			endtext
			use in select('c_CTACTECOMPRA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CTACTECOMPRA', set( 'Datasession' ) )
			if reccount( 'c_CTACTECOMPRA' ) = 0
				llRetorno = .f.
			else
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxCccompraCodigo as Variant
		llRetorno = .t.
		lxCccompraCodigo = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.CCCOMPRA where "Codigo" = <<"'" + this.FormatearTextoSql( lxCccompraCodigo ) + "'">> and  CCCOMPRA.CODIGO != ''
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
				lcOrden =   iif( empty( .FechaVencimiento ), dtos( evaluate( goRegistry.Nucleo.FechaEnBlancoParaSqlServer ) ), dtos( .FechaVencimiento ) ) + str( .TipoDeComprobante, 2, 0) + .Letra + str( .PuntoDeVenta, 4, 0) + str( .Numero, 8, 0) + .Valor_PK + .Proveedor_PK
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Montosin" as "Montocomprobantesinimpuesto", "Montogra" as "Montocomprobantegravado", "Montocon" as "Montocomprobanteconimpuesto", "Compcc" as "Comprometidocc", "Montoiva" as "Montocomprobanteiva", "Haltafw" as "Horaaltafw", "Valtafw" as "Versionaltafw", "Horaexpo" as "Horaexpo", "Vmodifw" as "Versionmodificacionfw", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Ualtafw" as "Usuarioaltafw", "Esttrans" as "Estadotransferencia", "Codcomp" as "Codigocomprobante", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Moneda" as "Moneda", "Codigo" as "Codigo", "Cliente" as "Proveedor", "Letra" as "Letra", "Ptovta" as "Puntodeventa", "Numero" as "Numero", "Totalcc" as "Totalcc", "Fechaven" as "Fechavencimiento", "Fechaemi" as "Fechaemision", "Tipocomp" as "Tipodecomprobante", "Saldocc" as "Saldocc", "Fecha" as "Fecha", "Comprob" as "Comprobante", "Anotacion" as "Anotacion", "Ptovtaext" as "Puntodeventaextendido", "Valor" as "Valor", "Signo" as "Signodemovimiento" from ZooLogic.CCCOMPRA where  CCCOMPRA.CODIGO != '' order by fechaven,TipoComp,letra,ptovta,numero,Valor,Cliente
			endtext
			use in select('c_CTACTECOMPRA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CTACTECOMPRA', set( 'Datasession' ) )
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
				lcOrden =   iif( empty( .FechaVencimiento ), dtos( evaluate( goRegistry.Nucleo.FechaEnBlancoParaSqlServer ) ), dtos( .FechaVencimiento ) ) + str( .TipoDeComprobante, 2, 0) + .Letra + str( .PuntoDeVenta, 4, 0) + str( .Numero, 8, 0) + .Valor_PK + .Proveedor_PK
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Montosin" as "Montocomprobantesinimpuesto", "Montogra" as "Montocomprobantegravado", "Montocon" as "Montocomprobanteconimpuesto", "Compcc" as "Comprometidocc", "Montoiva" as "Montocomprobanteiva", "Haltafw" as "Horaaltafw", "Valtafw" as "Versionaltafw", "Horaexpo" as "Horaexpo", "Vmodifw" as "Versionmodificacionfw", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Ualtafw" as "Usuarioaltafw", "Esttrans" as "Estadotransferencia", "Codcomp" as "Codigocomprobante", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Moneda" as "Moneda", "Codigo" as "Codigo", "Cliente" as "Proveedor", "Letra" as "Letra", "Ptovta" as "Puntodeventa", "Numero" as "Numero", "Totalcc" as "Totalcc", "Fechaven" as "Fechavencimiento", "Fechaemi" as "Fechaemision", "Tipocomp" as "Tipodecomprobante", "Saldocc" as "Saldocc", "Fecha" as "Fecha", "Comprob" as "Comprobante", "Anotacion" as "Anotacion", "Ptovtaext" as "Puntodeventaextendido", "Valor" as "Valor", "Signo" as "Signodemovimiento" from ZooLogic.CCCOMPRA where  funciones.dtos( fechaven ) + str( TipoComp, 2, 0) + funciones.padr( letra, 1, ' ' ) + str( ptovta, 4, 0) + str( numero, 8, 0) + funciones.padr( Valor, 5, ' ' ) + funciones.padr( Cliente, 5, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  CCCOMPRA.CODIGO != '' order by fechaven,TipoComp,letra,ptovta,numero,Valor,Cliente
			endtext
			use in select('c_CTACTECOMPRA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CTACTECOMPRA', set( 'Datasession' ) )
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
				lcOrden =   iif( empty( .FechaVencimiento ), dtos( evaluate( goRegistry.Nucleo.FechaEnBlancoParaSqlServer ) ), dtos( .FechaVencimiento ) ) + str( .TipoDeComprobante, 2, 0) + .Letra + str( .PuntoDeVenta, 4, 0) + str( .Numero, 8, 0) + .Valor_PK + .Proveedor_PK
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Montosin" as "Montocomprobantesinimpuesto", "Montogra" as "Montocomprobantegravado", "Montocon" as "Montocomprobanteconimpuesto", "Compcc" as "Comprometidocc", "Montoiva" as "Montocomprobanteiva", "Haltafw" as "Horaaltafw", "Valtafw" as "Versionaltafw", "Horaexpo" as "Horaexpo", "Vmodifw" as "Versionmodificacionfw", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Ualtafw" as "Usuarioaltafw", "Esttrans" as "Estadotransferencia", "Codcomp" as "Codigocomprobante", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Moneda" as "Moneda", "Codigo" as "Codigo", "Cliente" as "Proveedor", "Letra" as "Letra", "Ptovta" as "Puntodeventa", "Numero" as "Numero", "Totalcc" as "Totalcc", "Fechaven" as "Fechavencimiento", "Fechaemi" as "Fechaemision", "Tipocomp" as "Tipodecomprobante", "Saldocc" as "Saldocc", "Fecha" as "Fecha", "Comprob" as "Comprobante", "Anotacion" as "Anotacion", "Ptovtaext" as "Puntodeventaextendido", "Valor" as "Valor", "Signo" as "Signodemovimiento" from ZooLogic.CCCOMPRA where  funciones.dtos( fechaven ) + str( TipoComp, 2, 0) + funciones.padr( letra, 1, ' ' ) + str( ptovta, 4, 0) + str( numero, 8, 0) + funciones.padr( Valor, 5, ' ' ) + funciones.padr( Cliente, 5, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  CCCOMPRA.CODIGO != '' order by fechaven desc,TipoComp desc,letra desc,ptovta desc,numero desc,Valor desc,Cliente desc
			endtext
			use in select('c_CTACTECOMPRA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CTACTECOMPRA', set( 'Datasession' ) )
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
				lcOrden =   iif( empty( .FechaVencimiento ), dtos( evaluate( goRegistry.Nucleo.FechaEnBlancoParaSqlServer ) ), dtos( .FechaVencimiento ) ) + str( .TipoDeComprobante, 2, 0) + .Letra + str( .PuntoDeVenta, 4, 0) + str( .Numero, 8, 0) + .Valor_PK + .Proveedor_PK
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Montosin" as "Montocomprobantesinimpuesto", "Montogra" as "Montocomprobantegravado", "Montocon" as "Montocomprobanteconimpuesto", "Compcc" as "Comprometidocc", "Montoiva" as "Montocomprobanteiva", "Haltafw" as "Horaaltafw", "Valtafw" as "Versionaltafw", "Horaexpo" as "Horaexpo", "Vmodifw" as "Versionmodificacionfw", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Ualtafw" as "Usuarioaltafw", "Esttrans" as "Estadotransferencia", "Codcomp" as "Codigocomprobante", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Moneda" as "Moneda", "Codigo" as "Codigo", "Cliente" as "Proveedor", "Letra" as "Letra", "Ptovta" as "Puntodeventa", "Numero" as "Numero", "Totalcc" as "Totalcc", "Fechaven" as "Fechavencimiento", "Fechaemi" as "Fechaemision", "Tipocomp" as "Tipodecomprobante", "Saldocc" as "Saldocc", "Fecha" as "Fecha", "Comprob" as "Comprobante", "Anotacion" as "Anotacion", "Ptovtaext" as "Puntodeventaextendido", "Valor" as "Valor", "Signo" as "Signodemovimiento" from ZooLogic.CCCOMPRA where  CCCOMPRA.CODIGO != '' order by fechaven desc,TipoComp desc,letra desc,ptovta desc,numero desc,Valor desc,Cliente desc
			endtext
			use in select('c_CTACTECOMPRA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CTACTECOMPRA', set( 'Datasession' ) )
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
			lcXml = this.oConexion.EjecutarSql( "select Faltafw,Fecexpo,Fmodifw,Fecimpo,Fectrans,Montosin,Montogra,Montocon,Compcc,Montoiva,Haltafw," + ;
"Valtafw,Horaexpo,Vmodifw,Horaimpo,Saltafw,Smodifw,Hmodifw,Ualtafw,Esttrans,Codcomp,Umodifw,Zadsfw,Bd" + ;
"altafw,Bdmodifw,Moneda,Codigo,Cliente,Letra,Ptovta,Numero,Totalcc,Fechaven,Fechaemi,Tipocomp,Saldocc" + ;
",Fecha,Comprob,Anotacion,Ptovtaext,Valor,Signo" + ;
" from ZooLogic.CCCOMPRA where  CCCOMPRA.CODIGO != '' and " + lcFiltro )
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
			local  lxCccompraFaltafw, lxCccompraFecexpo, lxCccompraFmodifw, lxCccompraFecimpo, lxCccompraFectrans, lxCccompraMontosin, lxCccompraMontogra, lxCccompraMontocon, lxCccompraCompcc, lxCccompraMontoiva, lxCccompraHaltafw, lxCccompraValtafw, lxCccompraHoraexpo, lxCccompraVmodifw, lxCccompraHoraimpo, lxCccompraSaltafw, lxCccompraSmodifw, lxCccompraHmodifw, lxCccompraUaltafw, lxCccompraEsttrans, lxCccompraCodcomp, lxCccompraUmodifw, lxCccompraZadsfw, lxCccompraBdaltafw, lxCccompraBdmodifw, lxCccompraMoneda, lxCccompraCodigo, lxCccompraCliente, lxCccompraLetra, lxCccompraPtovta, lxCccompraNumero, lxCccompraTotalcc, lxCccompraFechaven, lxCccompraFechaemi, lxCccompraTipocomp, lxCccompraSaldocc, lxCccompraFecha, lxCccompraComprob, lxCccompraAnotacion, lxCccompraPtovtaext, lxCccompraValor, lxCccompraSigno
				lxCccompraFaltafw = ctod( '  /  /    ' )			lxCccompraFecexpo = ctod( '  /  /    ' )			lxCccompraFmodifw = ctod( '  /  /    ' )			lxCccompraFecimpo = ctod( '  /  /    ' )			lxCccompraFectrans = ctod( '  /  /    ' )			lxCccompraMontosin = 0			lxCccompraMontogra = 0			lxCccompraMontocon = 0			lxCccompraCompcc = 0			lxCccompraMontoiva = 0			lxCccompraHaltafw = []			lxCccompraValtafw = []			lxCccompraHoraexpo = []			lxCccompraVmodifw = []			lxCccompraHoraimpo = []			lxCccompraSaltafw = []			lxCccompraSmodifw = []			lxCccompraHmodifw = []			lxCccompraUaltafw = []			lxCccompraEsttrans = []			lxCccompraCodcomp = []			lxCccompraUmodifw = []			lxCccompraZadsfw = []			lxCccompraBdaltafw = []			lxCccompraBdmodifw = []			lxCccompraMoneda = []			lxCccompraCodigo = []			lxCccompraCliente = []			lxCccompraLetra = []			lxCccompraPtovta = 0			lxCccompraNumero = 0			lxCccompraTotalcc = 0			lxCccompraFechaven = ctod( '  /  /    ' )			lxCccompraFechaemi = ctod( '  /  /    ' )			lxCccompraTipocomp = 0			lxCccompraSaldocc = 0			lxCccompraFecha = ctod( '  /  /    ' )			lxCccompraComprob = []			lxCccompraAnotacion = []			lxCccompraPtovtaext = 0			lxCccompraValor = []			lxCccompraSigno = 0
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( [delete from ZooLogic.CCCOMPRA where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'CCCOMPRA' + '_' + tcCampo
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
		lcWhere = " Where  CCCOMPRA.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Montosin" as "Montocomprobantesinimpuesto", "Montogra" as "Montocomprobantegravado", "Montocon" as "Montocomprobanteconimpuesto", "Compcc" as "Comprometidocc", "Montoiva" as "Montocomprobanteiva", "Haltafw" as "Horaaltafw", "Valtafw" as "Versionaltafw", "Horaexpo" as "Horaexpo", "Vmodifw" as "Versionmodificacionfw", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Ualtafw" as "Usuarioaltafw", "Esttrans" as "Estadotransferencia", "Codcomp" as "Codigocomprobante", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Moneda" as "Moneda", "Codigo" as "Codigo", "Cliente" as "Proveedor", "Letra" as "Letra", "Ptovta" as "Puntodeventa", "Numero" as "Numero", "Totalcc" as "Totalcc", "Fechaven" as "Fechavencimiento", "Fechaemi" as "Fechaemision", "Tipocomp" as "Tipodecomprobante", "Saldocc" as "Saldocc", "Fecha" as "Fecha", "Comprob" as "Comprobante", "Anotacion" as "Anotacion", "Ptovtaext" as "Puntodeventaextendido", "Valor" as "Valor", "Signo" as "Signodemovimiento"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'CCCOMPRA', '', tnTope )
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
	Function ObtenerCamposSelectEntidad( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'FECHAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECEXPO AS FECHAEXPO'
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'FECHAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECIMPO AS FECHAIMPO'
				Case lcAtributo == 'FECHATRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRANS AS FECHATRANSFERENCIA'
				Case lcAtributo == 'MONTOCOMPROBANTESINIMPUESTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONTOSIN AS MONTOCOMPROBANTESINIMPUESTO'
				Case lcAtributo == 'MONTOCOMPROBANTEGRAVADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONTOGRA AS MONTOCOMPROBANTEGRAVADO'
				Case lcAtributo == 'MONTOCOMPROBANTECONIMPUESTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONTOCON AS MONTOCOMPROBANTECONIMPUESTO'
				Case lcAtributo == 'COMPROMETIDOCC'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COMPCC AS COMPROMETIDOCC'
				Case lcAtributo == 'MONTOCOMPROBANTEIVA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONTOIVA AS MONTOCOMPROBANTEIVA'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'CODIGOCOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODCOMP AS CODIGOCOMPROBANTE'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'MONEDA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONEDA AS MONEDA'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'PROVEEDOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLIENTE AS PROVEEDOR'
				Case lcAtributo == 'LETRA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LETRA AS LETRA'
				Case lcAtributo == 'PUNTODEVENTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PTOVTA AS PUNTODEVENTA'
				Case lcAtributo == 'NUMERO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NUMERO AS NUMERO'
				Case lcAtributo == 'TOTALCC'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TOTALCC AS TOTALCC'
				Case lcAtributo == 'FECHAVENCIMIENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHAVEN AS FECHAVENCIMIENTO'
				Case lcAtributo == 'FECHAEMISION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHAEMI AS FECHAEMISION'
				Case lcAtributo == 'TIPODECOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPOCOMP AS TIPODECOMPROBANTE'
				Case lcAtributo == 'SALDOCC'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALDOCC AS SALDOCC'
				Case lcAtributo == 'FECHA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHA AS FECHA'
				Case lcAtributo == 'COMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COMPROB AS COMPROBANTE'
				Case lcAtributo == 'ANOTACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ANOTACION AS ANOTACION'
				Case lcAtributo == 'PUNTODEVENTAEXTENDIDO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PTOVTAEXT AS PUNTODEVENTAEXTENDIDO'
				Case lcAtributo == 'VALOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALOR AS VALOR'
				Case lcAtributo == 'SIGNODEMOVIMIENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SIGNO AS SIGNODEMOVIMIENTO'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEXPO'
				lcCampo = 'FECEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAIMPO'
				lcCampo = 'FECIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOCOMPROBANTESINIMPUESTO'
				lcCampo = 'MONTOSIN'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOCOMPROBANTEGRAVADO'
				lcCampo = 'MONTOGRA'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOCOMPROBANTECONIMPUESTO'
				lcCampo = 'MONTOCON'
			Case upper( alltrim( tcAtributo ) ) == 'COMPROMETIDOCC'
				lcCampo = 'COMPCC'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOCOMPROBANTEIVA'
				lcCampo = 'MONTOIVA'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGOCOMPROBANTE'
				lcCampo = 'CODCOMP'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'MONEDA'
				lcCampo = 'MONEDA'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'PROVEEDOR'
				lcCampo = 'CLIENTE'
			Case upper( alltrim( tcAtributo ) ) == 'LETRA'
				lcCampo = 'LETRA'
			Case upper( alltrim( tcAtributo ) ) == 'PUNTODEVENTA'
				lcCampo = 'PTOVTA'
			Case upper( alltrim( tcAtributo ) ) == 'NUMERO'
				lcCampo = 'NUMERO'
			Case upper( alltrim( tcAtributo ) ) == 'TOTALCC'
				lcCampo = 'TOTALCC'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAVENCIMIENTO'
				lcCampo = 'FECHAVEN'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEMISION'
				lcCampo = 'FECHAEMI'
			Case upper( alltrim( tcAtributo ) ) == 'TIPODECOMPROBANTE'
				lcCampo = 'TIPOCOMP'
			Case upper( alltrim( tcAtributo ) ) == 'SALDOCC'
				lcCampo = 'SALDOCC'
			Case upper( alltrim( tcAtributo ) ) == 'FECHA'
				lcCampo = 'FECHA'
			Case upper( alltrim( tcAtributo ) ) == 'COMPROBANTE'
				lcCampo = 'COMPROB'
			Case upper( alltrim( tcAtributo ) ) == 'ANOTACION'
				lcCampo = 'ANOTACION'
			Case upper( alltrim( tcAtributo ) ) == 'PUNTODEVENTAEXTENDIDO'
				lcCampo = 'PTOVTAEXT'
			Case upper( alltrim( tcAtributo ) ) == 'VALOR'
				lcCampo = 'VALOR'
			Case upper( alltrim( tcAtributo ) ) == 'SIGNODEMOVIMIENTO'
				lcCampo = 'SIGNO'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerTablaDetalle( tcDetalle as string ) as String
		local lcRetorno as string
		lcRetorno = ''
		return lcRetorno
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasInsert() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcSentencia as string, loItem as object
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxCccompraFaltafw, lxCccompraFecexpo, lxCccompraFmodifw, lxCccompraFecimpo, lxCccompraFectrans, lxCccompraMontosin, lxCccompraMontogra, lxCccompraMontocon, lxCccompraCompcc, lxCccompraMontoiva, lxCccompraHaltafw, lxCccompraValtafw, lxCccompraHoraexpo, lxCccompraVmodifw, lxCccompraHoraimpo, lxCccompraSaltafw, lxCccompraSmodifw, lxCccompraHmodifw, lxCccompraUaltafw, lxCccompraEsttrans, lxCccompraCodcomp, lxCccompraUmodifw, lxCccompraZadsfw, lxCccompraBdaltafw, lxCccompraBdmodifw, lxCccompraMoneda, lxCccompraCodigo, lxCccompraCliente, lxCccompraLetra, lxCccompraPtovta, lxCccompraNumero, lxCccompraTotalcc, lxCccompraFechaven, lxCccompraFechaemi, lxCccompraTipocomp, lxCccompraSaldocc, lxCccompraFecha, lxCccompraComprob, lxCccompraAnotacion, lxCccompraPtovtaext, lxCccompraValor, lxCccompraSigno
				lxCccompraFaltafw =  .Fechaaltafw			lxCccompraFecexpo =  .Fechaexpo			lxCccompraFmodifw =  .Fechamodificacionfw			lxCccompraFecimpo =  .Fechaimpo			lxCccompraFectrans =  .Fechatransferencia			lxCccompraMontosin =  .Montocomprobantesinimpuesto			lxCccompraMontogra =  .Montocomprobantegravado			lxCccompraMontocon =  .Montocomprobanteconimpuesto			lxCccompraCompcc =  .Comprometidocc			lxCccompraMontoiva =  .Montocomprobanteiva			lxCccompraHaltafw =  .Horaaltafw			lxCccompraValtafw =  .Versionaltafw			lxCccompraHoraexpo =  .Horaexpo			lxCccompraVmodifw =  .Versionmodificacionfw			lxCccompraHoraimpo =  .Horaimpo			lxCccompraSaltafw =  .Seriealtafw			lxCccompraSmodifw =  .Seriemodificacionfw			lxCccompraHmodifw =  .Horamodificacionfw			lxCccompraUaltafw =  .Usuarioaltafw			lxCccompraEsttrans =  .Estadotransferencia			lxCccompraCodcomp =  .Codigocomprobante			lxCccompraUmodifw =  .Usuariomodificacionfw			lxCccompraZadsfw =  .Zadsfw			lxCccompraBdaltafw =  .Basededatosaltafw			lxCccompraBdmodifw =  .Basededatosmodificacionfw			lxCccompraMoneda =  upper( .Moneda_PK ) 			lxCccompraCodigo =  .Codigo			lxCccompraCliente =  upper( .Proveedor_PK ) 			lxCccompraLetra =  .Letra			lxCccompraPtovta =  .Puntodeventa			lxCccompraNumero =  .Numero			lxCccompraTotalcc =  .Totalcc			lxCccompraFechaven =  .Fechavencimiento			lxCccompraFechaemi =  .Fechaemision			lxCccompraTipocomp =  .Tipodecomprobante			lxCccompraSaldocc =  .Saldocc			lxCccompraFecha =  .Fecha			lxCccompraComprob =  .Comprobante			lxCccompraAnotacion =  .Anotacion			lxCccompraPtovtaext =  .Puntodeventaextendido			lxCccompraValor =  upper( .Valor_PK ) 			lxCccompraSigno =  .Signodemovimiento
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.CCCOMPRA ( "Faltafw","Fecexpo","Fmodifw","Fecimpo","Fectrans","Montosin","Montogra","Montocon","Compcc","Montoiva","Haltafw","Valtafw","Horaexpo","Vmodifw","Horaimpo","Saltafw","Smodifw","Hmodifw","Ualtafw","Esttrans","Codcomp","Umodifw","Zadsfw","Bdaltafw","Bdmodifw","Moneda","Codigo","Cliente","Letra","Ptovta","Numero","Totalcc","Fechaven","Fechaemi","Tipocomp","Saldocc","Fecha","Comprob","Anotacion","Ptovtaext","Valor","Signo" ) values ( <<"'" + this.ConvertirDateSql( lxCccompraFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCccompraFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCccompraFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCccompraFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCccompraFectrans ) + "'" >>, <<lxCccompraMontosin >>, <<lxCccompraMontogra >>, <<lxCccompraMontocon >>, <<lxCccompraCompcc >>, <<lxCccompraMontoiva >>, <<"'" + this.FormatearTextoSql( lxCccompraHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCccompraValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCccompraHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCccompraVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCccompraHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCccompraSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCccompraSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCccompraHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCccompraUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCccompraEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCccompraCodcomp ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCccompraUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCccompraZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCccompraBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCccompraBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCccompraMoneda ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCccompraCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCccompraCliente ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCccompraLetra ) + "'" >>, <<lxCccompraPtovta >>, <<lxCccompraNumero >>, <<lxCccompraTotalcc >>, <<"'" + this.ConvertirDateSql( lxCccompraFechaven ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCccompraFechaemi ) + "'" >>, <<lxCccompraTipocomp >>, <<lxCccompraSaldocc >>, <<"'" + this.ConvertirDateSql( lxCccompraFecha ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCccompraComprob ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCccompraAnotacion ) + "'" >>, <<lxCccompraPtovtaext >>, <<"'" + this.FormatearTextoSql( lxCccompraValor ) + "'" >>, <<lxCccompraSigno >> )
		endtext
		loColeccion.cTabla = 'CCCOMPRA' 
		loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		With this
			local lcValorClavePrimariaString as String
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"
		EndWith
		return loColeccion
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasUpdate() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcFiltro as string, loItem as object, lcSentencia as string, lcSentencia as string
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxCccompraFaltafw, lxCccompraFecexpo, lxCccompraFmodifw, lxCccompraFecimpo, lxCccompraFectrans, lxCccompraMontosin, lxCccompraMontogra, lxCccompraMontocon, lxCccompraCompcc, lxCccompraMontoiva, lxCccompraHaltafw, lxCccompraValtafw, lxCccompraHoraexpo, lxCccompraVmodifw, lxCccompraHoraimpo, lxCccompraSaltafw, lxCccompraSmodifw, lxCccompraHmodifw, lxCccompraUaltafw, lxCccompraEsttrans, lxCccompraCodcomp, lxCccompraUmodifw, lxCccompraZadsfw, lxCccompraBdaltafw, lxCccompraBdmodifw, lxCccompraMoneda, lxCccompraCodigo, lxCccompraCliente, lxCccompraLetra, lxCccompraPtovta, lxCccompraNumero, lxCccompraTotalcc, lxCccompraFechaven, lxCccompraFechaemi, lxCccompraTipocomp, lxCccompraSaldocc, lxCccompraFecha, lxCccompraComprob, lxCccompraAnotacion, lxCccompraPtovtaext, lxCccompraValor, lxCccompraSigno
				lxCccompraFaltafw =  .Fechaaltafw			lxCccompraFecexpo =  .Fechaexpo			lxCccompraFmodifw =  .Fechamodificacionfw			lxCccompraFecimpo =  .Fechaimpo			lxCccompraFectrans =  .Fechatransferencia			lxCccompraMontosin =  .Montocomprobantesinimpuesto			lxCccompraMontogra =  .Montocomprobantegravado			lxCccompraMontocon =  .Montocomprobanteconimpuesto			lxCccompraCompcc =  .Comprometidocc			lxCccompraMontoiva =  .Montocomprobanteiva			lxCccompraHaltafw =  .Horaaltafw			lxCccompraValtafw =  .Versionaltafw			lxCccompraHoraexpo =  .Horaexpo			lxCccompraVmodifw =  .Versionmodificacionfw			lxCccompraHoraimpo =  .Horaimpo			lxCccompraSaltafw =  .Seriealtafw			lxCccompraSmodifw =  .Seriemodificacionfw			lxCccompraHmodifw =  .Horamodificacionfw			lxCccompraUaltafw =  .Usuarioaltafw			lxCccompraEsttrans =  .Estadotransferencia			lxCccompraCodcomp =  .Codigocomprobante			lxCccompraUmodifw =  .Usuariomodificacionfw			lxCccompraZadsfw =  .Zadsfw			lxCccompraBdaltafw =  .Basededatosaltafw			lxCccompraBdmodifw =  .Basededatosmodificacionfw			lxCccompraMoneda =  upper( .Moneda_PK ) 			lxCccompraCodigo =  .Codigo			lxCccompraCliente =  upper( .Proveedor_PK ) 			lxCccompraLetra =  .Letra			lxCccompraPtovta =  .Puntodeventa			lxCccompraNumero =  .Numero			lxCccompraTotalcc =  .Totalcc			lxCccompraFechaven =  .Fechavencimiento			lxCccompraFechaemi =  .Fechaemision			lxCccompraTipocomp =  .Tipodecomprobante			lxCccompraSaldocc =  .Saldocc			lxCccompraFecha =  .Fecha			lxCccompraComprob =  .Comprobante			lxCccompraAnotacion =  .Anotacion			lxCccompraPtovtaext =  .Puntodeventaextendido			lxCccompraValor =  upper( .Valor_PK ) 			lxCccompraSigno =  .Signodemovimiento
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  CCCOMPRA.CODIGO != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.CCCOMPRA set "Faltafw" = <<"'" + this.ConvertirDateSql( lxCccompraFaltafw ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxCccompraFecexpo ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxCccompraFmodifw ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxCccompraFecimpo ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxCccompraFectrans ) + "'">>, "Montosin" = <<lxCccompraMontosin>>, "Montogra" = <<lxCccompraMontogra>>, "Montocon" = <<lxCccompraMontocon>>, "Compcc" = Compcc + ( <<lxCccompraCompcc>> ), "Montoiva" = <<lxCccompraMontoiva>>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxCccompraHaltafw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxCccompraValtafw ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxCccompraHoraexpo ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxCccompraVmodifw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxCccompraHoraimpo ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxCccompraSaltafw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxCccompraSmodifw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxCccompraHmodifw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxCccompraUaltafw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxCccompraEsttrans ) + "'">>, "Codcomp" = <<"'" + this.FormatearTextoSql( lxCccompraCodcomp ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxCccompraUmodifw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxCccompraZadsfw ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxCccompraBdaltafw ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxCccompraBdmodifw ) + "'">>, "Moneda" = <<"'" + this.FormatearTextoSql( lxCccompraMoneda ) + "'">>, "Codigo" = <<"'" + this.FormatearTextoSql( lxCccompraCodigo ) + "'">>, "Cliente" = <<"'" + this.FormatearTextoSql( lxCccompraCliente ) + "'">>, "Letra" = <<"'" + this.FormatearTextoSql( lxCccompraLetra ) + "'">>, "Ptovta" = <<lxCccompraPtovta>>, "Numero" = <<lxCccompraNumero>>, "Totalcc" = <<lxCccompraTotalcc>>, "Fechaven" = <<"'" + this.ConvertirDateSql( lxCccompraFechaven ) + "'">>, "Fechaemi" = <<"'" + this.ConvertirDateSql( lxCccompraFechaemi ) + "'">>, "Tipocomp" = <<lxCccompraTipocomp>>, "Saldocc" = Saldocc + ( <<lxCccompraSaldocc>> ), "Fecha" = <<"'" + this.ConvertirDateSql( lxCccompraFecha ) + "'">>, "Comprob" = <<"'" + this.FormatearTextoSql( lxCccompraComprob ) + "'">>, "Anotacion" = <<"'" + this.FormatearTextoSql( lxCccompraAnotacion ) + "'">>, "Ptovtaext" = <<lxCccompraPtovtaext>>, "Valor" = <<"'" + this.FormatearTextoSql( lxCccompraValor ) + "'">>, "Signo" = <<lxCccompraSigno>> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'CCCOMPRA' 
		loColeccion.agregar( strtran(  lcSentencia, chr( 9 ), '' ) )
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

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  CCCOMPRA.CODIGO != '']
		loColeccion.Agregar( 'delete from ZooLogic.CCCOMPRA where ' + lcFiltro )
			loColeccion.cTabla = 'CCCOMPRA' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.CCCOMPRA where  CCCOMPRA.CODIGO != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.CCCOMPRA where Codigo = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  CCCOMPRA.CODIGO != ''" )
			this.xmlacursor( lcXml, lcCursor )
		if reccount( lcCursor ) > 0
			lnTimeStamp = &lcCursor..Timestamp
		endif
		use in select( lcCursor )

		return lnTimeStamp 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirCabecera( tlLoguear as Boolean ) As Void
		local lcCursor as String, ldFecha as Date, lcHora as string, lcValorABuscar As String, lxValorClavePK As variant, lxValorClavePrimaria As variant, lcIdentificadorParaLoguear as string, lxccCompraCliente as variant, lxccCompraletra as variant, lxccCompraptovta as variant, lxccCompranumero as variant, lxccComprafechaven as variant, lxccCompraTipoComp as variant, lxccCompraValor as variant, lcMensajeExtra as String
		lcValorABuscar = ''
		lxValorClavePK = ''
		lcMensajeExtra = ''
		lcCursor = This.oEntidad.cPrefijoRecibir + 'CTACTECOMPRA'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.CCCOMPRA Where  fechaven = ] + "'" + this.ConvertirDateSql( &lcCursor..fechaven   ) + "'" + [ and TipoComp = ] + transform( &lcCursor..TipoComp   ) + [ and letra = ] + "'" + this.FormatearTextoSql( &lcCursor..letra      ) + "'" + [ and ptovta = ] + transform( &lcCursor..ptovta     ) + [ and numero = ] + transform( &lcCursor..numero     ) + [ and Valor = ] + "'" + this.FormatearTextoSql( &lcCursor..Valor      ) + "'" + [ and Cliente = ] + "'" + this.FormatearTextoSql( &lcCursor..Cliente    ) + "'", 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				lxValorClavePK = &lcCursor..Codigo
				if lxValorClavePK == curSeek.Codigo or this.oEntidad.lIgnorarClaveprimariaEnRecepcionBD 
					if lxValorClavePK != curSeek.Codigo and this.oEntidad.lIgnorarClaveprimariaEnRecepcionBD 
						lcValorABuscar = curSeek.Codigo
					else 
						lcValorABuscar = lxValorClavePK 
					endif 
					if This.ActualizaEnRecepcion() 
						Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
						this.oConexion.EjecutarSql( [UPDATE ZooLogic.CCCOMPRA set  FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, MontoSin = ] + transform( &lcCursor..MontoSin )+ [, MontoGra = ] + transform( &lcCursor..MontoGra )+ [, MontoCon = ] + transform( &lcCursor..MontoCon )+ [, ComPCC = ZooLogic.CCCOMPRA.ComPCC + ] + transform( &lcCursor..ComPCC )+ [, MontoIVA = ] + transform( &lcCursor..MontoIVA )+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, CodComp = ] + "'" + this.FormatearTextoSql( &lcCursor..CodComp ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, Moneda = ] + "'" + this.FormatearTextoSql( &lcCursor..Moneda ) + "'"+ [, Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'"+ [, Cliente = ] + "'" + this.FormatearTextoSql( &lcCursor..Cliente ) + "'"+ [, letra = ] + "'" + this.FormatearTextoSql( &lcCursor..letra ) + "'"+ [, ptovta = ] + transform( &lcCursor..ptovta )+ [, numero = ] + transform( &lcCursor..numero )+ [, TotalCC = ] + transform( &lcCursor..TotalCC )+ [, fechaven = ] + "'" + this.ConvertirDateSql( &lcCursor..fechaven ) + "'"+ [, fechaemi = ] + "'" + this.ConvertirDateSql( &lcCursor..fechaemi ) + "'"+ [, TipoComp = ] + transform( &lcCursor..TipoComp )+ [, SaldoCC = ZooLogic.CCCOMPRA.SaldoCC + ] + transform( &lcCursor..SaldoCC )+ [, Fecha = ] + "'" + this.ConvertirDateSql( &lcCursor..Fecha ) + "'"+ [, Comprob = ] + "'" + this.FormatearTextoSql( &lcCursor..Comprob ) + "'"+ [, anotacion = ] + "'" + this.FormatearTextoSql( &lcCursor..anotacion ) + "'"+ [, ptovtaext = ] + transform( &lcCursor..ptovtaext )+ [, Valor = ] + "'" + this.FormatearTextoSql( &lcCursor..Valor ) + "'"+ [, Signo = ] + transform( &lcCursor..Signo ) + [ Where Codigo = ] + "'" + this.FormatearTextoSql( lcValorABuscar ) + "'" )
						this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
					else
						this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
					endIf
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir porque no coincide la clave principal.', tlLoguear )
				endIf
			else
				this.oConexion.EjecutarSql( [Select * From ZooLogic.CCCOMPRA Where Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'", 'curSeek', this.datasessionid )
				if reccount( 'curSeek' ) > 0
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir como alta porque la clave principal ya existe', tlLoguear )
				Else
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					Text to lcCampos noShow
						 FALTAFW, FECEXPO, FMODIFW, FECIMPO, FECTRANS, MontoSin, MontoGra, MontoCon, ComPCC, MontoIVA, HALTAFW, VALTAFW, HORAEXPO, VMODIFW, HORAIMPO, SALTAFW, SMODIFW, HMODIFW, UALTAFW, ESTTRANS, CodComp, UMODIFW, ZADSFW, BDALTAFW, BDMODIFW, Moneda, Codigo, Cliente, letra, ptovta, numero, TotalCC, fechaven, fechaemi, TipoComp, SaldoCC, Fecha, Comprob, anotacion, ptovtaext, Valor, Signo
					EndText
					local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + transform( &lcCursor..MontoSin ) + ',' + transform( &lcCursor..MontoGra )
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..MontoCon ) + ',' + transform( &lcCursor..ComPCC ) + ',' + transform( &lcCursor..MontoIVA ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CodComp ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Moneda ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Cliente ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..letra ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..ptovta ) + ',' + transform( &lcCursor..numero ) + ',' + transform( &lcCursor..TotalCC ) + ',' + "'" + this.ConvertirDateSql( &lcCursor..fechaven ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..fechaemi ) + "'" + ',' + transform( &lcCursor..TipoComp ) + ',' + transform( &lcCursor..SaldoCC ) + ',' + "'" + this.ConvertirDateSql( &lcCursor..Fecha ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Comprob ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..anotacion ) + "'" + ',' + transform( &lcCursor..ptovtaext ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..Valor ) + "'" + ',' + transform( &lcCursor..Signo )
lcValoresCampos = substr(lcValoresCampos,2) 

					this.oConexion.EjecutarSql( [Insert into ZooLogic.CCCOMPRA ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
				EndIf
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'CTACTECOMPRA'
		if This.ActualizaEnRecepcion()
	endif
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
		lcRetorno = lcRetorno + ' - Fecha Vencimiento: ' + transform( &tcCursor..fechaven   )
		lcRetorno = lcRetorno + ' - Tipo Comprobante: ' + transform( &tcCursor..TipoComp   )
		lcRetorno = lcRetorno + ' - Letra: ' + transform( &tcCursor..letra      )
		lcRetorno = lcRetorno + ' - Punto de venta: ' + transform( &tcCursor..ptovta     )
		lcRetorno = lcRetorno + ' - Número: ' + transform( &tcCursor..numero     )
		lcRetorno = lcRetorno + ' - Valor: ' + transform( &tcCursor..Valor      )
		lcRetorno = lcRetorno + ' - Proveedor: ' + transform( &tcCursor..Cliente    )
		Return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EsAliasDeProceso( tcAlias As String, tcPrefijo as string ) As Boolean
		local llRetorno as Boolean, lcAlias as String, lcPrefijo As String
		llRetorno = .F.
		lcAlias = upper( alltrim( tcAlias ) )
		lcPrefijo = upper( alltrim( tcPrefijo ) )
		Do Case
			Case  lcAlias == lcPrefijo + 'CTACTECOMPRA'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'CTACTECOMPRA_ZADSFW'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_ccCompra')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'CTACTECOMPRA'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..Codigo
		llCondicion = isnull( lxVar ) or isnull( &lcCursor..fechaven ) or isnull( &lcCursor..TipoComp ) or isnull( &lcCursor..letra ) or isnull( &lcCursor..ptovta ) or isnull( &lcCursor..numero ) or isnull( &lcCursor..Valor ) or isnull( &lcCursor..Cliente )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad CTACTECOMPRA. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'CTACTECOMPRA'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		select recno() as _Rec, * from &lcCursor into cursor CurConRecno
		select max( _Rec ) as Maximo,Codigo as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( Codigo, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		select max( _Rec ) as Maximo,dtos( fechaven ) + str( TipoComp, 2, 0) + letra + str( ptovta, 4, 0) + str( numero, 8, 0) + Valor + Cliente as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( dtos( fechaven ) + str( TipoComp, 2, 0) + letra + str( ptovta, 4, 0) + str( numero, 8, 0) + Valor + Cliente, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		Use in select( 'CurConRecno' )
		Use in select( 'RepMax' )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDatosInvalidos( toConexion as Object ) as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'CTACTECOMPRA'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  fechaven  
		* Validar ANTERIORES A 1/1/1753  fechaemi  
		* Validar ANTERIORES A 1/1/1753  Fecha     
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_ccCompra') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_ccCompra
Create Table ZooLogic.TablaTrabajo_ccCompra ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"faltafw" datetime  null, 
"fecexpo" datetime  null, 
"fmodifw" datetime  null, 
"fecimpo" datetime  null, 
"fectrans" datetime  null, 
"montosin" numeric( 15, 2 )  null, 
"montogra" numeric( 15, 2 )  null, 
"montocon" numeric( 15, 2 )  null, 
"compcc" numeric( 15, 2 )  null, 
"montoiva" numeric( 15, 2 )  null, 
"haltafw" char( 8 )  null, 
"valtafw" char( 13 )  null, 
"horaexpo" char( 8 )  null, 
"vmodifw" char( 13 )  null, 
"horaimpo" char( 8 )  null, 
"saltafw" char( 7 )  null, 
"smodifw" char( 7 )  null, 
"hmodifw" char( 8 )  null, 
"ualtafw" char( 100 )  null, 
"esttrans" char( 20 )  null, 
"codcomp" char( 38 )  null, 
"umodifw" char( 100 )  null, 
"zadsfw" varchar(max)  null, 
"bdaltafw" char( 8 )  null, 
"bdmodifw" char( 8 )  null, 
"moneda" char( 10 )  null, 
"codigo" char( 38 )  null, 
"cliente" char( 5 )  null, 
"letra" char( 1 )  null, 
"ptovta" numeric( 4, 0 )  null, 
"numero" numeric( 8, 0 )  null, 
"totalcc" numeric( 16, 2 )  null, 
"fechaven" datetime  null, 
"fechaemi" datetime  null, 
"tipocomp" numeric( 2, 0 )  null, 
"saldocc" numeric( 16, 2 )  null, 
"fecha" datetime  null, 
"comprob" char( 100 )  null, 
"anotacion" char( 100 )  null, 
"ptovtaext" numeric( 5, 0 )  null, 
"valor" char( 5 )  null, 
"signo" numeric( 2, 0 )  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_ccCompra' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_ccCompra' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'CTACTECOMPRA'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		with loManejador
			if this.oEntidad.VerificarContexto( 'CB' )
			else
				.AgregarMapeo('Nrolinea','Nrolinea')
			endif
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('montosin','montosin')
			.AgregarMapeo('montogra','montogra')
			.AgregarMapeo('montocon','montocon')
			.AgregarMapeo('compcc','compcc')
			.AgregarMapeo('montoiva','montoiva')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('codcomp','codcomp')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('moneda','moneda')
			.AgregarMapeo('codigo','codigo')
			.AgregarMapeo('cliente','cliente')
			.AgregarMapeo('letra','letra')
			.AgregarMapeo('ptovta','ptovta')
			.AgregarMapeo('numero','numero')
			.AgregarMapeo('totalcc','totalcc')
			.AgregarMapeo('fechaven','fechaven')
			.AgregarMapeo('fechaemi','fechaemi')
			.AgregarMapeo('tipocomp','tipocomp')
			.AgregarMapeo('saldocc','saldocc')
			.AgregarMapeo('fecha','fecha')
			.AgregarMapeo('comprob','comprob')
			.AgregarMapeo('anotacion','anotacion')
			.AgregarMapeo('ptovtaext','ptovtaext')
			.AgregarMapeo('valor','valor')
			.AgregarMapeo('signo','signo')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_ccCompra'
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
				Update t Set t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.MONTOSIN = isnull( d.MONTOSIN, t.MONTOSIN ),t.MONTOGRA = isnull( d.MONTOGRA, t.MONTOGRA ),t.MONTOCON = isnull( d.MONTOCON, t.MONTOCON ),t.COMPCC = isnull( d.COMPCC, t.COMPCC ),t.MONTOIVA = isnull( d.MONTOIVA, t.MONTOIVA ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.CODCOMP = isnull( d.CODCOMP, t.CODCOMP ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.MONEDA = isnull( d.MONEDA, t.MONEDA ),t.CODIGO = isnull( d.CODIGO, t.CODIGO ),t.CLIENTE = isnull( d.CLIENTE, t.CLIENTE ),t.LETRA = isnull( d.LETRA, t.LETRA ),t.PTOVTA = isnull( d.PTOVTA, t.PTOVTA ),t.NUMERO = isnull( d.NUMERO, t.NUMERO ),t.TOTALCC = isnull( d.TOTALCC, t.TOTALCC ),t.FECHAVEN = isnull( d.FECHAVEN, t.FECHAVEN ),t.FECHAEMI = isnull( d.FECHAEMI, t.FECHAEMI ),t.TIPOCOMP = isnull( d.TIPOCOMP, t.TIPOCOMP ),t.SALDOCC = isnull( d.SALDOCC, t.SALDOCC ),t.FECHA = isnull( d.FECHA, t.FECHA ),t.COMPROB = isnull( d.COMPROB, t.COMPROB ),t.ANOTACION = isnull( d.ANOTACION, t.ANOTACION ),t.PTOVTAEXT = isnull( d.PTOVTAEXT, t.PTOVTAEXT ),t.VALOR = isnull( d.VALOR, t.VALOR ),t.SIGNO = isnull( d.SIGNO, t.SIGNO )
					from ZooLogic.CCCOMPRA t inner join deleted d 
							 on t.Codigo = d.Codigo
							 and  t.fechaven = d.fechaven
							 and  t.TipoComp = d.TipoComp
							 and  t.letra = d.letra
							 and  t.ptovta = d.ptovta
							 and  t.numero = d.numero
							 and  t.Valor = d.Valor
							 and  t.Cliente = d.Cliente
				-- Fin Updates
				insert into ZooLogic.CCCOMPRA(Faltafw,Fecexpo,Fmodifw,Fecimpo,Fectrans,Montosin,Montogra,Montocon,Compcc,Montoiva,Haltafw,Valtafw,Horaexpo,Vmodifw,Horaimpo,Saltafw,Smodifw,Hmodifw,Ualtafw,Esttrans,Codcomp,Umodifw,Zadsfw,Bdaltafw,Bdmodifw,Moneda,Codigo,Cliente,Letra,Ptovta,Numero,Totalcc,Fechaven,Fechaemi,Tipocomp,Saldocc,Fecha,Comprob,Anotacion,Ptovtaext,Valor,Signo)
					Select CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FECEXPO,''),isnull( d.FMODIFW,''),isnull( d.FECIMPO,''),isnull( d.FECTRANS,''),isnull( d.MONTOSIN,0),isnull( d.MONTOGRA,0),isnull( d.MONTOCON,0),isnull( d.COMPCC,0),isnull( d.MONTOIVA,0),convert( char(8), getdate(), 108 ),isnull( d.VALTAFW,''),isnull( d.HORAEXPO,''),isnull( d.VMODIFW,''),isnull( d.HORAIMPO,''),isnull( d.SALTAFW,''),isnull( d.SMODIFW,''),isnull( d.HMODIFW,''),isnull( d.UALTAFW,''),isnull( d.ESTTRANS,''),isnull( d.CODCOMP,''),isnull( d.UMODIFW,''),isnull( d.ZADSFW,''),isnull( d.BDALTAFW,''),isnull( d.BDMODIFW,''),isnull( d.MONEDA,''),isnull( d.CODIGO,''),isnull( d.CLIENTE,''),isnull( d.LETRA,''),isnull( d.PTOVTA,0),isnull( d.NUMERO,0),isnull( d.TOTALCC,0),isnull( d.FECHAVEN,''),isnull( d.FECHAEMI,''),isnull( d.TIPOCOMP,0),isnull( d.SALDOCC,0),isnull( d.FECHA,''),isnull( d.COMPROB,''),isnull( d.ANOTACION,''),isnull( d.PTOVTAEXT,0),isnull( d.VALOR,''),isnull( d.SIGNO,0)
						From deleted d left join ZooLogic.CCCOMPRA pk 
							 on d.Codigo = pk.Codigo
						 left join ZooLogic.CCCOMPRA cc 
							 on  d.fechaven = cc.fechaven
							 and  d.TipoComp = cc.TipoComp
							 and  d.letra = cc.letra
							 and  d.ptovta = cc.ptovta
							 and  d.numero = cc.numero
							 and  d.Valor = cc.Valor
							 and  d.Cliente = cc.Cliente
						Where pk.Codigo Is Null 
							 and cc.fechaven Is Null 
							 and cc.TipoComp Is Null 
							 and cc.letra Is Null 
							 and cc.ptovta Is Null 
							 and cc.numero Is Null 
							 and cc.Valor Is Null 
							 and cc.Cliente Is Null 
				-- Fin Inserts
				Insert into ZooLogic.Logueos ( Fecha, Nivel, Logger, Accion, BaseDeDatos, 
					EstadoDelSistema, Aplicacion, Version, 
					Serie, Usuario, NombrePc, 
					UsuarioPc, OrigenLogueo, Mensaje, Excepcion)
				select GetDate(), 'INFO', '', 'Importación <<lcEntidad>>','<<loLogueo.BaseDatos>>',
					<<loLogueo.EstadoSistema>>,'<<loLogueo.Aplicacion>>','<<loLogueo.Version>>',
					'<<loLogueo.Serie>>','<<loLogueo.Usuario>>','<<loLogueo.NombrePc>>',
					'<<loLogueo.UsuarioPc>>','<<loLogueo.OrigenLogueo>>','No se pudo importar la entidad <<lcEntidad>>: FECHA VENCIMIENTO ' + cast( d.fechaven as Varchar(8) ) + ', TIPO COMPROBANTE ' + cast( d.TipoComp as Varchar(2) ) + ', LETRA ' + cast( d.letra as Varchar(1) ) + ', PUNTO DE VENTA ' + cast( d.ptovta as Varchar(4) ) + ', NÚMERO ' + cast( d.numero as Varchar(8) ) + ', VALOR ' + cast( d.Valor as Varchar(5) ) + ', PROVEEDOR ' + cast( d.Cliente as Varchar(5) ) + '','La clave principal no es la esperada'
					from ZooLogic.CCCOMPRA t inner join deleted d 
							on   t.fechaven = d.fechaven
							 and  t.TipoComp = d.TipoComp
							 and  t.letra = d.letra
							 and  t.ptovta = d.ptovta
							 and  t.numero = d.numero
							 and  t.Valor = d.Valor
							 and  t.Cliente = d.Cliente
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
					'<<loLogueo.UsuarioPc>>','<<loLogueo.OrigenLogueo>>','No se pudo importar la entidad <<lcEntidad>>: FECHA VENCIMIENTO ' + cast( d.fechaven as Varchar(8) ) + ', TIPO COMPROBANTE ' + cast( d.TipoComp as Varchar(2) ) + ', LETRA ' + cast( d.letra as Varchar(1) ) + ', PUNTO DE VENTA ' + cast( d.ptovta as Varchar(4) ) + ', NÚMERO ' + cast( d.numero as Varchar(8) ) + ', VALOR ' + cast( d.Valor as Varchar(5) ) + ', PROVEEDOR ' + cast( d.Cliente as Varchar(5) ) + '','La clave principal a importar ya existe'
					from ZooLogic.CCCOMPRA t inner join deleted d 
							 on t.Codigo = d.Codigo
						left join deleted h 
							on   t.fechaven = h.fechaven
							 and   t.TipoComp = h.TipoComp
							 and   t.letra = h.letra
							 and   t.ptovta = h.ptovta
							 and   t.numero = h.numero
							 and   t.Valor = h.Valor
							 and   t.Cliente = h.Cliente
							where   h.fechaven is null 
							 and   h.TipoComp is null 
							 and   h.letra is null 
							 and   h.ptovta is null 
							 and   h.numero is null 
							 and   h.Valor is null 
							 and   h.Cliente is null 
			End
		EndText
		Return lcCadena
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	protected Function EliminarTablasDeTrabajo( toConexion as Object ) as void
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_ccCompra') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_ccCompra
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_CTACTECOMPRA' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_CTACTECOMPRA.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_CTACTECOMPRA.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_CTACTECOMPRA.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_CTACTECOMPRA.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_CTACTECOMPRA.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Montocomprobantesinimpuesto = nvl( c_CTACTECOMPRA.Montocomprobantesinimpuesto, 0 )
					.Montocomprobantegravado = nvl( c_CTACTECOMPRA.Montocomprobantegravado, 0 )
					.Montocomprobanteconimpuesto = nvl( c_CTACTECOMPRA.Montocomprobanteconimpuesto, 0 )
					.Comprometidocc = nvl( c_CTACTECOMPRA.Comprometidocc, 0 )
					.Montocomprobanteiva = nvl( c_CTACTECOMPRA.Montocomprobanteiva, 0 )
					.Horaaltafw = nvl( c_CTACTECOMPRA.Horaaltafw, [] )
					.Versionaltafw = nvl( c_CTACTECOMPRA.Versionaltafw, [] )
					.Horaexpo = nvl( c_CTACTECOMPRA.Horaexpo, [] )
					.Versionmodificacionfw = nvl( c_CTACTECOMPRA.Versionmodificacionfw, [] )
					.Horaimpo = nvl( c_CTACTECOMPRA.Horaimpo, [] )
					.Seriealtafw = nvl( c_CTACTECOMPRA.Seriealtafw, [] )
					.Seriemodificacionfw = nvl( c_CTACTECOMPRA.Seriemodificacionfw, [] )
					.Horamodificacionfw = nvl( c_CTACTECOMPRA.Horamodificacionfw, [] )
					.Usuarioaltafw = nvl( c_CTACTECOMPRA.Usuarioaltafw, [] )
					.Estadotransferencia = nvl( c_CTACTECOMPRA.Estadotransferencia, [] )
					.Codigocomprobante = nvl( c_CTACTECOMPRA.Codigocomprobante, [] )
					.Usuariomodificacionfw = nvl( c_CTACTECOMPRA.Usuariomodificacionfw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Basededatosaltafw = nvl( c_CTACTECOMPRA.Basededatosaltafw, [] )
					.Basededatosmodificacionfw = nvl( c_CTACTECOMPRA.Basededatosmodificacionfw, [] )
					.Moneda_PK =  nvl( c_CTACTECOMPRA.Moneda, [] )
					.Codigo = nvl( c_CTACTECOMPRA.Codigo, [] )
					.Proveedor_PK =  nvl( c_CTACTECOMPRA.Proveedor, [] )
					.Letra = nvl( c_CTACTECOMPRA.Letra, [] )
					.Puntodeventa = nvl( c_CTACTECOMPRA.Puntodeventa, 0 )
					.Numero = nvl( c_CTACTECOMPRA.Numero, 0 )
					.Totalcc = nvl( c_CTACTECOMPRA.Totalcc, 0 )
					.Fechavencimiento = GoLibrerias.ObtenerFechaFormateada( nvl( c_CTACTECOMPRA.Fechavencimiento, ctod( '  /  /    ' ) ) )
					.Fechaemision = GoLibrerias.ObtenerFechaFormateada( nvl( c_CTACTECOMPRA.Fechaemision, ctod( '  /  /    ' ) ) )
					.Tipodecomprobante = nvl( c_CTACTECOMPRA.Tipodecomprobante, 0 )
					.Saldocc = nvl( c_CTACTECOMPRA.Saldocc, 0 )
					.Fecha = GoLibrerias.ObtenerFechaFormateada( nvl( c_CTACTECOMPRA.Fecha, ctod( '  /  /    ' ) ) )
					.Comprobante = nvl( c_CTACTECOMPRA.Comprobante, [] )
					.Anotacion = nvl( c_CTACTECOMPRA.Anotacion, [] )
					.Puntodeventaextendido = nvl( c_CTACTECOMPRA.Puntodeventaextendido, 0 )
					.Valor_PK =  nvl( c_CTACTECOMPRA.Valor, [] )
					.Signodemovimiento = nvl( c_CTACTECOMPRA.Signodemovimiento, 0 )
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
			lxRetorno = c_CTACTECOMPRA.CODIGO
		endif
		return lxRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function ActualizarLosNROItemDeLosDetalles() as void
		local loDetalle as object, loItem as object, lnContadorNroItem as integer, lnIndex as integer
		
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function ObtenerMemo( tcTabla as String ) as string
		local lcAtributo as string
		lcAtributo = strtran( tcTabla, 'c_', '' )
		return c_CTACTECOMPRA.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.CCCOMPRA' )
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
								from ZooLogic.CCCOMPRA 
								Where   CCCOMPRA.CODIGO != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "CCCOMPRA", "", lcCursor, set("Datasession") )
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
			"Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Montosin" as "Montocomprobantesinimpuesto", "Montogra" as "Montocomprobantegravado", "Montocon" as "Montocomprobanteconimpuesto", "Compcc" as "Comprometidocc", "Montoiva" as "Montocomprobanteiva", "Haltafw" as "Horaaltafw", "Valtafw" as "Versionaltafw", "Horaexpo" as "Horaexpo", "Vmodifw" as "Versionmodificacionfw", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Ualtafw" as "Usuarioaltafw", "Esttrans" as "Estadotransferencia", "Codcomp" as "Codigocomprobante", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Moneda" as "Moneda", "Codigo" as "Codigo", "Cliente" as "Proveedor", "Letra" as "Letra", "Ptovta" as "Puntodeventa", "Numero" as "Numero", "Totalcc" as "Totalcc", "Fechaven" as "Fechavencimiento", "Fechaemi" as "Fechaemision", "Tipocomp" as "Tipodecomprobante", "Saldocc" as "Saldocc", "Fecha" as "Fecha", "Comprob" as "Comprobante", "Anotacion" as "Anotacion", "Ptovtaext" as "Puntodeventaextendido", "Valor" as "Valor", "Signo" as "Signodemovimiento"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.CCCOMPRA 
								Where   CCCOMPRA.CODIGO != ''
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
	Tabla = 'CCCOMPRA'
	Filtro = " CCCOMPRA.CODIGO != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " CCCOMPRA.CODIGO != ''"
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
	<row entidad="CTACTECOMPRA                            " atributo="FECHAALTAFW                             " tabla="CCCOMPRA       " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CTACTECOMPRA                            " atributo="FECHAEXPO                               " tabla="CCCOMPRA       " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CTACTECOMPRA                            " atributo="FECHAMODIFICACIONFW                     " tabla="CCCOMPRA       " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CTACTECOMPRA                            " atributo="FECHAIMPO                               " tabla="CCCOMPRA       " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CTACTECOMPRA                            " atributo="FECHATRANSFERENCIA                      " tabla="CCCOMPRA       " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha transferencia                                                                                                                                             " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CTACTECOMPRA                            " atributo="MONTOCOMPROBANTESINIMPUESTO             " tabla="CCCOMPRA       " campo="MONTOSIN  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Monto comprobante sin impuesto                                                                                                                                  " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CTACTECOMPRA                            " atributo="MONTOCOMPROBANTEGRAVADO                 " tabla="CCCOMPRA       " campo="MONTOGRA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Monto comprobante gravado                                                                                                                                       " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CTACTECOMPRA                            " atributo="MONTOCOMPROBANTECONIMPUESTO             " tabla="CCCOMPRA       " campo="MONTOCON  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Monto comprobante con impuesto                                                                                                                                  " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CTACTECOMPRA                            " atributo="COMPROMETIDOCC                          " tabla="CCCOMPRA       " campo="COMPCC    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Comprometido                                                                                                                                                    " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CTACTECOMPRA                            " atributo="MONTOCOMPROBANTEIVA                     " tabla="CCCOMPRA       " campo="MONTOIVA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Monto IVA                                                                                                                                                       " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CTACTECOMPRA                            " atributo="HORAALTAFW                              " tabla="CCCOMPRA       " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CTACTECOMPRA                            " atributo="VERSIONALTAFW                           " tabla="CCCOMPRA       " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CTACTECOMPRA                            " atributo="HORAEXPO                                " tabla="CCCOMPRA       " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CTACTECOMPRA                            " atributo="VERSIONMODIFICACIONFW                   " tabla="CCCOMPRA       " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CTACTECOMPRA                            " atributo="HORAIMPO                                " tabla="CCCOMPRA       " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CTACTECOMPRA                            " atributo="SERIEALTAFW                             " tabla="CCCOMPRA       " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CTACTECOMPRA                            " atributo="SERIEMODIFICACIONFW                     " tabla="CCCOMPRA       " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CTACTECOMPRA                            " atributo="HORAMODIFICACIONFW                      " tabla="CCCOMPRA       " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CTACTECOMPRA                            " atributo="USUARIOALTAFW                           " tabla="CCCOMPRA       " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CTACTECOMPRA                            " atributo="ESTADOTRANSFERENCIA                     " tabla="CCCOMPRA       " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado transferencia                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CTACTECOMPRA                            " atributo="CODIGOCOMPROBANTE                       " tabla="CCCOMPRA       " campo="CODCOMP   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CTACTECOMPRA                            " atributo="USUARIOMODIFICACIONFW                   " tabla="CCCOMPRA       " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CTACTECOMPRA                            " atributo="ZADSFW                                  " tabla="CCCOMPRA       " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CTACTECOMPRA                            " atributo="BASEDEDATOSALTAFW                       " tabla="CCCOMPRA       " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CTACTECOMPRA                            " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="CCCOMPRA       " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CTACTECOMPRA                            " atributo="MONEDA                                  " tabla="CCCOMPRA       " campo="MONEDA    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="MONEDA                                  " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Moneda                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="Valor.SimboloMonetario                                                                                                                                                                                                                                        " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CTACTECOMPRA                            " atributo="CODIGO                                  " tabla="CCCOMPRA       " campo="CODIGO    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="2" etiqueta="Nro Interno                                                                                                                                                     " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CTACTECOMPRA                            " atributo="PROVEEDOR                               " tabla="CCCOMPRA       " campo="CLIENTE   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="PROVEEDOR                               " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="400" etiqueta="Proveedor                                                                                                                                                       " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="7" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CTACTECOMPRA                            " atributo="LETRA                                   " tabla="CCCOMPRA       " campo="LETRA     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="4" etiqueta="Letra                                                                                                                                                           " dominio="NROCOMPROBANTECOMPRASEDITABLE " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="3" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CTACTECOMPRA                            " atributo="PUNTODEVENTA                            " tabla="CCCOMPRA       " campo="PTOVTA    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="4" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="6" etiqueta="Punto de venta                                                                                                                                                  " dominio="NROCOMPROBANTECOMPRASEDITABLE " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="4" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CTACTECOMPRA                            " atributo="NUMERO                                  " tabla="CCCOMPRA       " campo="NUMERO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="8" etiqueta="Número                                                                                                                                                          " dominio="NROCOMPROBANTECOMPRASEDITABLE " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="5" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CTACTECOMPRA                            " atributo="TOTALCC                                 " tabla="CCCOMPRA       " campo="TOTALCC   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="16" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="402" etiqueta="Total                                                                                                                                                           " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CTACTECOMPRA                            " atributo="FECHAVENCIMIENTO                        " tabla="CCCOMPRA       " campo="FECHAVEN  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="404" etiqueta="Fecha Vencimiento                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="1" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CTACTECOMPRA                            " atributo="FECHAEMISION                            " tabla="CCCOMPRA       " campo="FECHAEMI  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="406" etiqueta="Fecha de emisión                                                                                                                                                " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="8" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CTACTECOMPRA                            " atributo="TIPODECOMPROBANTE                       " tabla="CCCOMPRA       " campo="TIPOCOMP  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="10" etiqueta="Tipo Comprobante                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="2" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="9" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CTACTECOMPRA                            " atributo="SALDOCC                                 " tabla="CCCOMPRA       " campo="SALDOCC   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="16" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="408" etiqueta="Saldo                                                                                                                                                           " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="10" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CTACTECOMPRA                            " atributo="FECHA                                   " tabla="CCCOMPRA       " campo="FECHA     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha                                                                                                                                                           " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="11" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CTACTECOMPRA                            " atributo="COMPROBANTE                             " tabla="CCCOMPRA       " campo="COMPROB   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Comprobante                                                                                                                                                     " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="12" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CTACTECOMPRA                            " atributo="ANOTACION                               " tabla="CCCOMPRA       " campo="ANOTACION " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Anotación                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="13" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CTACTECOMPRA                            " atributo="PUNTODEVENTAEXTENDIDO                   " tabla="CCCOMPRA       " campo="PTOVTAEXT " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="6" etiqueta="Punto de venta                                                                                                                                                  " dominio="NROCOMPROBANTECOMPRASEDITABLE " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="99999                    " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="14" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CTACTECOMPRA                            " atributo="VALOR                                   " tabla="CCCOMPRA       " campo="VALOR     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="VALOR                                   " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="14" etiqueta="Valor                                                                                                                                                           " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="6" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="18" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CTACTECOMPRA                            " atributo="SIGNODEMOVIMIENTO                       " tabla="CCCOMPRA       " campo="SIGNO     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="0" etiqueta="Signo de Movimiento                                                                                                                                             " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="20" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="NOMBRE                                  " tabla="PROVEED        " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="401" etiqueta="Detalle Pro.                                                                                                                                                    " dominio="TEXTOBUSQUEDA                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join PROVEED On CCCOMPRA.CLIENTE = PROVEED.CLCOD And  PROVEED.CLCOD != ''                                                                                                                                                                               " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="DESCRIPCION                             " tabla="XVALORES       " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="15" etiqueta="Detalle Val.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join XVALORES On CCCOMPRA.VALOR = XVALORES.CLCOD And  XVALORES.CLCOD != '' AND XVALORES.CLCOD != ''                                                                                                                                                     " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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