
define class Din_EntidadCTACTEAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_CTACTE'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = [dtos( FechaVencimiento ) + str( TipoDeComprobante, 2, 0) + Letra + str( PuntoDeVenta, 4, 0) + str( Numero, 8, 0) + Valor + Cliente + Secuencia + BaseDeDatosAltaFW]
	cExpresionCCPorCampos = [dtos( #tabla#.fechaven ) + str( #tabla#.TipoComp, 2, 0) + #tabla#.letra + str( #tabla#.ptovta, 4, 0) + str( #tabla#.numero, 8, 0) + #tabla#.Valor + #tabla#.Cliente + #tabla#.factsec + #tabla#.BDAltaFW]
	cTagClaveCandidata = '_053CC'
	cTagClavePk = '_053PK'
	cTablaPrincipal = 'CTACTE'
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
			local  lxCtacteFecimpo, lxCtacteFmodifw, lxCtacteFecexpo, lxCtacteFectrans, lxCtacteFaltafw, lxCtacteValtafw, lxCtacteUmodifw, lxCtacteVmodifw, lxCtacteUaltafw, lxCtacteZadsfw, lxCtacteHoraexpo, lxCtacteHaltafw, lxCtacteEsttrans, lxCtacteSaltafw, lxCtacteHmodifw, lxCtacteSmodifw, lxCtacteHoraimpo, lxCtacteBdmodifw, lxCtacteCodcomp, lxCtacteClglobalid, lxCtacteMoneda, lxCtacteCodigo, lxCtacteCliente, lxCtacteLetra, lxCtactePtovta, lxCtacteNumero, lxCtacteFactsec, lxCtacteTotalcc, lxCtacteFechaven, lxCtacteTipocomp, lxCtacteSaldocc, lxCtacteFecha, lxCtacteComprob, lxCtacteAnotacion, lxCtacteValor, lxCtacteSigno, lxCtacteBdaltafw
				lxCtacteFecimpo =  .Fechaimpo			lxCtacteFmodifw =  .Fechamodificacionfw			lxCtacteFecexpo =  .Fechaexpo			lxCtacteFectrans =  .Fechatransferencia			lxCtacteFaltafw =  .Fechaaltafw			lxCtacteValtafw =  .Versionaltafw			lxCtacteUmodifw =  .Usuariomodificacionfw			lxCtacteVmodifw =  .Versionmodificacionfw			lxCtacteUaltafw =  .Usuarioaltafw			lxCtacteZadsfw =  .Zadsfw			lxCtacteHoraexpo =  .Horaexpo			lxCtacteHaltafw =  .Horaaltafw			lxCtacteEsttrans =  .Estadotransferencia			lxCtacteSaltafw =  .Seriealtafw			lxCtacteHmodifw =  .Horamodificacionfw			lxCtacteSmodifw =  .Seriemodificacionfw			lxCtacteHoraimpo =  .Horaimpo			lxCtacteBdmodifw =  .Basededatosmodificacionfw			lxCtacteCodcomp =  .Codigocomprobante			lxCtacteClglobalid =  .Idglobalcliente			lxCtacteMoneda =  upper( .Moneda_PK ) 			lxCtacteCodigo =  .Codigo			lxCtacteCliente =  upper( .Cliente_PK ) 			lxCtacteLetra =  .Letra			lxCtactePtovta =  .Puntodeventa			lxCtacteNumero =  .Numero			lxCtacteFactsec =  .Secuencia			lxCtacteTotalcc =  .Totalcc			lxCtacteFechaven =  .Fechavencimiento			lxCtacteTipocomp =  .Tipodecomprobante			lxCtacteSaldocc =  .Saldocc			lxCtacteFecha =  .Fecha			lxCtacteComprob =  .Comprobante			lxCtacteAnotacion =  .Anotacion			lxCtacteValor =  upper( .Valor_PK ) 			lxCtacteSigno =  .Signodemovimiento			lxCtacteBdaltafw =  .Basededatosaltafw
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxCtacteCodigo = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.CTACTE ( "Fecimpo","Fmodifw","Fecexpo","Fectrans","Faltafw","Valtafw","Umodifw","Vmodifw","Ualtafw","Zadsfw","Horaexpo","Haltafw","Esttrans","Saltafw","Hmodifw","Smodifw","Horaimpo","Bdmodifw","Codcomp","Clglobalid","Moneda","Codigo","Cliente","Letra","Ptovta","Numero","Factsec","Totalcc","Fechaven","Tipocomp","Saldocc","Fecha","Comprob","Anotacion","Valor","Signo","Bdaltafw" ) values ( <<"'" + this.ConvertirDateSql( lxCtacteFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCtacteFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCtacteFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCtacteFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCtacteFaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCtacteValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCtacteUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCtacteVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCtacteUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCtacteZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCtacteHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCtacteHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCtacteEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCtacteSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCtacteHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCtacteSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCtacteHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCtacteBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCtacteCodcomp ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCtacteClglobalid ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCtacteMoneda ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCtacteCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCtacteCliente ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCtacteLetra ) + "'" >>, <<lxCtactePtovta >>, <<lxCtacteNumero >>, <<"'" + this.FormatearTextoSql( lxCtacteFactsec ) + "'" >>, <<lxCtacteTotalcc >>, <<"'" + this.ConvertirDateSql( lxCtacteFechaven ) + "'" >>, <<lxCtacteTipocomp >>, <<lxCtacteSaldocc >>, <<"'" + this.ConvertirDateSql( lxCtacteFecha ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCtacteComprob ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCtacteAnotacion ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCtacteValor ) + "'" >>, <<lxCtacteSigno >>, <<"'" + this.FormatearTextoSql( lxCtacteBdaltafw ) + "'" >> )
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
			local  lxCtacteFecimpo, lxCtacteFmodifw, lxCtacteFecexpo, lxCtacteFectrans, lxCtacteFaltafw, lxCtacteValtafw, lxCtacteUmodifw, lxCtacteVmodifw, lxCtacteUaltafw, lxCtacteZadsfw, lxCtacteHoraexpo, lxCtacteHaltafw, lxCtacteEsttrans, lxCtacteSaltafw, lxCtacteHmodifw, lxCtacteSmodifw, lxCtacteHoraimpo, lxCtacteBdmodifw, lxCtacteCodcomp, lxCtacteClglobalid, lxCtacteMoneda, lxCtacteCodigo, lxCtacteCliente, lxCtacteLetra, lxCtactePtovta, lxCtacteNumero, lxCtacteFactsec, lxCtacteTotalcc, lxCtacteFechaven, lxCtacteTipocomp, lxCtacteSaldocc, lxCtacteFecha, lxCtacteComprob, lxCtacteAnotacion, lxCtacteValor, lxCtacteSigno, lxCtacteBdaltafw
				lxCtacteFecimpo =  .Fechaimpo			lxCtacteFmodifw =  .Fechamodificacionfw			lxCtacteFecexpo =  .Fechaexpo			lxCtacteFectrans =  .Fechatransferencia			lxCtacteFaltafw =  .Fechaaltafw			lxCtacteValtafw =  .Versionaltafw			lxCtacteUmodifw =  .Usuariomodificacionfw			lxCtacteVmodifw =  .Versionmodificacionfw			lxCtacteUaltafw =  .Usuarioaltafw			lxCtacteZadsfw =  .Zadsfw			lxCtacteHoraexpo =  .Horaexpo			lxCtacteHaltafw =  .Horaaltafw			lxCtacteEsttrans =  .Estadotransferencia			lxCtacteSaltafw =  .Seriealtafw			lxCtacteHmodifw =  .Horamodificacionfw			lxCtacteSmodifw =  .Seriemodificacionfw			lxCtacteHoraimpo =  .Horaimpo			lxCtacteBdmodifw =  .Basededatosmodificacionfw			lxCtacteCodcomp =  .Codigocomprobante			lxCtacteClglobalid =  .Idglobalcliente			lxCtacteMoneda =  upper( .Moneda_PK ) 			lxCtacteCodigo =  .Codigo			lxCtacteCliente =  upper( .Cliente_PK ) 			lxCtacteLetra =  .Letra			lxCtactePtovta =  .Puntodeventa			lxCtacteNumero =  .Numero			lxCtacteFactsec =  .Secuencia			lxCtacteTotalcc =  .Totalcc			lxCtacteFechaven =  .Fechavencimiento			lxCtacteTipocomp =  .Tipodecomprobante			lxCtacteSaldocc =  .Saldocc			lxCtacteFecha =  .Fecha			lxCtacteComprob =  .Comprobante			lxCtacteAnotacion =  .Anotacion			lxCtacteValor =  upper( .Valor_PK ) 			lxCtacteSigno =  .Signodemovimiento			lxCtacteBdaltafw =  .Basededatosaltafw
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()
			lxValorClavePrimaria = .oEntidad.CODIGO
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ZooLogic.CTACTE set "Fecimpo" = <<"'" + this.ConvertirDateSql( lxCtacteFecimpo ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxCtacteFmodifw ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxCtacteFecexpo ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxCtacteFectrans ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxCtacteFaltafw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxCtacteValtafw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxCtacteUmodifw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxCtacteVmodifw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxCtacteUaltafw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxCtacteZadsfw ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxCtacteHoraexpo ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxCtacteHaltafw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxCtacteEsttrans ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxCtacteSaltafw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxCtacteHmodifw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxCtacteSmodifw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxCtacteHoraimpo ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxCtacteBdmodifw ) + "'">>,"Codcomp" = <<"'" + this.FormatearTextoSql( lxCtacteCodcomp ) + "'">>,"Clglobalid" = <<"'" + this.FormatearTextoSql( lxCtacteClglobalid ) + "'">>,"Moneda" = <<"'" + this.FormatearTextoSql( lxCtacteMoneda ) + "'">>,"Codigo" = <<"'" + this.FormatearTextoSql( lxCtacteCodigo ) + "'">>,"Cliente" = <<"'" + this.FormatearTextoSql( lxCtacteCliente ) + "'">>,"Letra" = <<"'" + this.FormatearTextoSql( lxCtacteLetra ) + "'">>,"Ptovta" = <<lxCtactePtovta>>,"Numero" = <<lxCtacteNumero>>,"Factsec" = <<"'" + this.FormatearTextoSql( lxCtacteFactsec ) + "'">>,"Totalcc" = <<lxCtacteTotalcc>>,"Fechaven" = <<"'" + this.ConvertirDateSql( lxCtacteFechaven ) + "'">>,"Tipocomp" = <<lxCtacteTipocomp>>,"Saldocc" = "Saldocc" + <<lxCtacteSaldocc>>,"Fecha" = <<"'" + this.ConvertirDateSql( lxCtacteFecha ) + "'">>,"Comprob" = <<"'" + this.FormatearTextoSql( lxCtacteComprob ) + "'">>,"Anotacion" = <<"'" + this.FormatearTextoSql( lxCtacteAnotacion ) + "'">>,"Valor" = <<"'" + this.FormatearTextoSql( lxCtacteValor ) + "'">>,"Signo" = <<lxCtacteSigno>>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxCtacteBdaltafw ) + "'">> where "Codigo" = <<"'" + this.FormatearTextoSql( lxCtacteCodigo ) + "'">> and  CTACTE.CODIGO != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 Codigo from ZooLogic.CTACTE where " + this.ConvertirFuncionesSql( " CTACTE.CODIGO != ''" ) )
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
			Local lxCtacteCodigo
			lxCtacteCodigo = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Ualtafw" as "Usuarioaltafw", "Zadsfw" as "Zadsfw", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Esttrans" as "Estadotransferencia", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Bdmodifw" as "Basededatosmodificacionfw", "Codcomp" as "Codigocomprobante", "Clglobalid" as "Idglobalcliente", "Moneda" as "Moneda", "Codigo" as "Codigo", "Cliente" as "Cliente", "Letra" as "Letra", "Ptovta" as "Puntodeventa", "Numero" as "Numero", "Factsec" as "Secuencia", "Totalcc" as "Totalcc", "Fechaven" as "Fechavencimiento", "Tipocomp" as "Tipodecomprobante", "Saldocc" as "Saldocc", "Fecha" as "Fecha", "Comprob" as "Comprobante", "Anotacion" as "Anotacion", "Valor" as "Valor", "Signo" as "Signodemovimiento", "Bdaltafw" as "Basededatosaltafw" from ZooLogic.CTACTE where "Codigo" = <<"'" + this.FormatearTextoSql( lxCtacteCodigo ) + "'">> and  CTACTE.CODIGO != ''
			endtext
			use in select('c_CTACTE')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CTACTE', set( 'Datasession' ) )

			if reccount( 'c_CTACTE' ) = 0
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
			Local lxCtaCtefechaven As Variant, lxCtaCteTipoComp As Variant, lxCtaCteletra As Variant, lxCtaCteptovta As Variant, lxCtaCtenumero As Variant, lxCtaCteValor As Variant, lxCtaCteCliente As Variant, lxctactefactsec As Variant, lxCtaCteBDAltaFW As Variant
			lxCtaCtefechaven = .FechaVencimiento
			lxCtaCteTipoComp = .TipoDeComprobante
			lxCtaCteletra = .Letra
			lxCtaCteptovta = .PuntoDeVenta
			lxCtaCtenumero = .Numero
			lxCtaCteValor = .Valor_Pk
			lxCtaCteCliente = .Cliente_Pk
			lxctactefactsec = .Secuencia
			lxCtaCteBDAltaFW = .BaseDeDatosAltaFW
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Ualtafw" as "Usuarioaltafw", "Zadsfw" as "Zadsfw", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Esttrans" as "Estadotransferencia", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Bdmodifw" as "Basededatosmodificacionfw", "Codcomp" as "Codigocomprobante", "Clglobalid" as "Idglobalcliente", "Moneda" as "Moneda", "Codigo" as "Codigo", "Cliente" as "Cliente", "Letra" as "Letra", "Ptovta" as "Puntodeventa", "Numero" as "Numero", "Factsec" as "Secuencia", "Totalcc" as "Totalcc", "Fechaven" as "Fechavencimiento", "Tipocomp" as "Tipodecomprobante", "Saldocc" as "Saldocc", "Fecha" as "Fecha", "Comprob" as "Comprobante", "Anotacion" as "Anotacion", "Valor" as "Valor", "Signo" as "Signodemovimiento", "Bdaltafw" as "Basededatosaltafw" from ZooLogic.CTACTE where  CTACTE.CODIGO != '' And fechaven = <<"'" + this.ConvertirDateSql( lxCtaCtefechaven ) + "'">> and TipoComp = <<lxCtaCteTipoComp>> and letra = <<"'" + this.FormatearTextoSql( lxCtaCteletra ) + "'">> and ptovta = <<lxCtaCteptovta>> and numero = <<lxCtaCtenumero>> and Valor = <<"'" + this.FormatearTextoSql( lxCtaCteValor ) + "'">> and Cliente = <<"'" + this.FormatearTextoSql( lxCtaCteCliente ) + "'">> and factsec = <<"'" + this.FormatearTextoSql( lxctactefactsec ) + "'">> and BDAltaFW = <<"'" + this.FormatearTextoSql( lxCtaCteBDAltaFW ) + "'">>
			endtext
			use in select('c_CTACTE')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CTACTE', set( 'Datasession' ) )
			if reccount( 'c_CTACTE' ) = 0
				llRetorno = .f.
			else
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxCtacteCodigo as Variant
		llRetorno = .t.
		lxCtacteCodigo = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.CTACTE where "Codigo" = <<"'" + this.FormatearTextoSql( lxCtacteCodigo ) + "'">> and  CTACTE.CODIGO != ''
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
				lcOrden =   iif( empty( .FechaVencimiento ), dtos( evaluate( goRegistry.Nucleo.FechaEnBlancoParaSqlServer ) ), dtos( .FechaVencimiento ) ) + str( .TipoDeComprobante, 2, 0) + .Letra + str( .PuntoDeVenta, 4, 0) + str( .Numero, 8, 0) + .Valor_PK + .Cliente_PK + .Secuencia + .BaseDeDatosAltaFW
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Ualtafw" as "Usuarioaltafw", "Zadsfw" as "Zadsfw", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Esttrans" as "Estadotransferencia", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Bdmodifw" as "Basededatosmodificacionfw", "Codcomp" as "Codigocomprobante", "Clglobalid" as "Idglobalcliente", "Moneda" as "Moneda", "Codigo" as "Codigo", "Cliente" as "Cliente", "Letra" as "Letra", "Ptovta" as "Puntodeventa", "Numero" as "Numero", "Factsec" as "Secuencia", "Totalcc" as "Totalcc", "Fechaven" as "Fechavencimiento", "Tipocomp" as "Tipodecomprobante", "Saldocc" as "Saldocc", "Fecha" as "Fecha", "Comprob" as "Comprobante", "Anotacion" as "Anotacion", "Valor" as "Valor", "Signo" as "Signodemovimiento", "Bdaltafw" as "Basededatosaltafw" from ZooLogic.CTACTE where  CTACTE.CODIGO != '' order by fechaven,TipoComp,letra,ptovta,numero,Valor,Cliente,factsec,BDAltaFW
			endtext
			use in select('c_CTACTE')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CTACTE', set( 'Datasession' ) )
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
				lcOrden =   iif( empty( .FechaVencimiento ), dtos( evaluate( goRegistry.Nucleo.FechaEnBlancoParaSqlServer ) ), dtos( .FechaVencimiento ) ) + str( .TipoDeComprobante, 2, 0) + .Letra + str( .PuntoDeVenta, 4, 0) + str( .Numero, 8, 0) + .Valor_PK + .Cliente_PK + .Secuencia + .BaseDeDatosAltaFW
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Ualtafw" as "Usuarioaltafw", "Zadsfw" as "Zadsfw", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Esttrans" as "Estadotransferencia", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Bdmodifw" as "Basededatosmodificacionfw", "Codcomp" as "Codigocomprobante", "Clglobalid" as "Idglobalcliente", "Moneda" as "Moneda", "Codigo" as "Codigo", "Cliente" as "Cliente", "Letra" as "Letra", "Ptovta" as "Puntodeventa", "Numero" as "Numero", "Factsec" as "Secuencia", "Totalcc" as "Totalcc", "Fechaven" as "Fechavencimiento", "Tipocomp" as "Tipodecomprobante", "Saldocc" as "Saldocc", "Fecha" as "Fecha", "Comprob" as "Comprobante", "Anotacion" as "Anotacion", "Valor" as "Valor", "Signo" as "Signodemovimiento", "Bdaltafw" as "Basededatosaltafw" from ZooLogic.CTACTE where  funciones.dtos( fechaven ) + str( TipoComp, 2, 0) + funciones.padr( letra, 1, ' ' ) + str( ptovta, 4, 0) + str( numero, 8, 0) + funciones.padr( Valor, 5, ' ' ) + funciones.padr( Cliente, 10, ' ' ) + funciones.padr( factsec, 2, ' ' ) + funciones.padr( BDAltaFW, 8, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  CTACTE.CODIGO != '' order by fechaven,TipoComp,letra,ptovta,numero,Valor,Cliente,factsec,BDAltaFW
			endtext
			use in select('c_CTACTE')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CTACTE', set( 'Datasession' ) )
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
				lcOrden =   iif( empty( .FechaVencimiento ), dtos( evaluate( goRegistry.Nucleo.FechaEnBlancoParaSqlServer ) ), dtos( .FechaVencimiento ) ) + str( .TipoDeComprobante, 2, 0) + .Letra + str( .PuntoDeVenta, 4, 0) + str( .Numero, 8, 0) + .Valor_PK + .Cliente_PK + .Secuencia + .BaseDeDatosAltaFW
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Ualtafw" as "Usuarioaltafw", "Zadsfw" as "Zadsfw", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Esttrans" as "Estadotransferencia", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Bdmodifw" as "Basededatosmodificacionfw", "Codcomp" as "Codigocomprobante", "Clglobalid" as "Idglobalcliente", "Moneda" as "Moneda", "Codigo" as "Codigo", "Cliente" as "Cliente", "Letra" as "Letra", "Ptovta" as "Puntodeventa", "Numero" as "Numero", "Factsec" as "Secuencia", "Totalcc" as "Totalcc", "Fechaven" as "Fechavencimiento", "Tipocomp" as "Tipodecomprobante", "Saldocc" as "Saldocc", "Fecha" as "Fecha", "Comprob" as "Comprobante", "Anotacion" as "Anotacion", "Valor" as "Valor", "Signo" as "Signodemovimiento", "Bdaltafw" as "Basededatosaltafw" from ZooLogic.CTACTE where  funciones.dtos( fechaven ) + str( TipoComp, 2, 0) + funciones.padr( letra, 1, ' ' ) + str( ptovta, 4, 0) + str( numero, 8, 0) + funciones.padr( Valor, 5, ' ' ) + funciones.padr( Cliente, 10, ' ' ) + funciones.padr( factsec, 2, ' ' ) + funciones.padr( BDAltaFW, 8, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  CTACTE.CODIGO != '' order by fechaven desc,TipoComp desc,letra desc,ptovta desc,numero desc,Valor desc,Cliente desc,factsec desc,BDAltaFW desc
			endtext
			use in select('c_CTACTE')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CTACTE', set( 'Datasession' ) )
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
				lcOrden =   iif( empty( .FechaVencimiento ), dtos( evaluate( goRegistry.Nucleo.FechaEnBlancoParaSqlServer ) ), dtos( .FechaVencimiento ) ) + str( .TipoDeComprobante, 2, 0) + .Letra + str( .PuntoDeVenta, 4, 0) + str( .Numero, 8, 0) + .Valor_PK + .Cliente_PK + .Secuencia + .BaseDeDatosAltaFW
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Ualtafw" as "Usuarioaltafw", "Zadsfw" as "Zadsfw", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Esttrans" as "Estadotransferencia", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Bdmodifw" as "Basededatosmodificacionfw", "Codcomp" as "Codigocomprobante", "Clglobalid" as "Idglobalcliente", "Moneda" as "Moneda", "Codigo" as "Codigo", "Cliente" as "Cliente", "Letra" as "Letra", "Ptovta" as "Puntodeventa", "Numero" as "Numero", "Factsec" as "Secuencia", "Totalcc" as "Totalcc", "Fechaven" as "Fechavencimiento", "Tipocomp" as "Tipodecomprobante", "Saldocc" as "Saldocc", "Fecha" as "Fecha", "Comprob" as "Comprobante", "Anotacion" as "Anotacion", "Valor" as "Valor", "Signo" as "Signodemovimiento", "Bdaltafw" as "Basededatosaltafw" from ZooLogic.CTACTE where  CTACTE.CODIGO != '' order by fechaven desc,TipoComp desc,letra desc,ptovta desc,numero desc,Valor desc,Cliente desc,factsec desc,BDAltaFW desc
			endtext
			use in select('c_CTACTE')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CTACTE', set( 'Datasession' ) )
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
			lcXml = this.oConexion.EjecutarSql( "select Fecimpo,Fmodifw,Fecexpo,Fectrans,Faltafw,Valtafw,Umodifw,Vmodifw,Ualtafw,Zadsfw,Horaexpo,Hal" + ;
"tafw,Esttrans,Saltafw,Hmodifw,Smodifw,Horaimpo,Bdmodifw,Codcomp,Clglobalid,Moneda,Codigo,Cliente,Let" + ;
"ra,Ptovta,Numero,Factsec,Totalcc,Fechaven,Tipocomp,Saldocc,Fecha,Comprob,Anotacion,Valor,Signo,Bdalt" + ;
"afw" + ;
" from ZooLogic.CTACTE where  CTACTE.CODIGO != '' and " + lcFiltro )
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
			local  lxCtacteFecimpo, lxCtacteFmodifw, lxCtacteFecexpo, lxCtacteFectrans, lxCtacteFaltafw, lxCtacteValtafw, lxCtacteUmodifw, lxCtacteVmodifw, lxCtacteUaltafw, lxCtacteZadsfw, lxCtacteHoraexpo, lxCtacteHaltafw, lxCtacteEsttrans, lxCtacteSaltafw, lxCtacteHmodifw, lxCtacteSmodifw, lxCtacteHoraimpo, lxCtacteBdmodifw, lxCtacteCodcomp, lxCtacteClglobalid, lxCtacteMoneda, lxCtacteCodigo, lxCtacteCliente, lxCtacteLetra, lxCtactePtovta, lxCtacteNumero, lxCtacteFactsec, lxCtacteTotalcc, lxCtacteFechaven, lxCtacteTipocomp, lxCtacteSaldocc, lxCtacteFecha, lxCtacteComprob, lxCtacteAnotacion, lxCtacteValor, lxCtacteSigno, lxCtacteBdaltafw
				lxCtacteFecimpo = ctod( '  /  /    ' )			lxCtacteFmodifw = ctod( '  /  /    ' )			lxCtacteFecexpo = ctod( '  /  /    ' )			lxCtacteFectrans = ctod( '  /  /    ' )			lxCtacteFaltafw = ctod( '  /  /    ' )			lxCtacteValtafw = []			lxCtacteUmodifw = []			lxCtacteVmodifw = []			lxCtacteUaltafw = []			lxCtacteZadsfw = []			lxCtacteHoraexpo = []			lxCtacteHaltafw = []			lxCtacteEsttrans = []			lxCtacteSaltafw = []			lxCtacteHmodifw = []			lxCtacteSmodifw = []			lxCtacteHoraimpo = []			lxCtacteBdmodifw = []			lxCtacteCodcomp = []			lxCtacteClglobalid = []			lxCtacteMoneda = []			lxCtacteCodigo = []			lxCtacteCliente = []			lxCtacteLetra = []			lxCtactePtovta = 0			lxCtacteNumero = 0			lxCtacteFactsec = []			lxCtacteTotalcc = 0			lxCtacteFechaven = ctod( '  /  /    ' )			lxCtacteTipocomp = 0			lxCtacteSaldocc = 0			lxCtacteFecha = ctod( '  /  /    ' )			lxCtacteComprob = []			lxCtacteAnotacion = []			lxCtacteValor = []			lxCtacteSigno = 0			lxCtacteBdaltafw = []
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( [delete from ZooLogic.CTACTE where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'CTACTE' + '_' + tcCampo
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
		lcWhere = " Where  CTACTE.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Ualtafw" as "Usuarioaltafw", "Zadsfw" as "Zadsfw", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Esttrans" as "Estadotransferencia", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Bdmodifw" as "Basededatosmodificacionfw", "Codcomp" as "Codigocomprobante", "Clglobalid" as "Idglobalcliente", "Moneda" as "Moneda", "Codigo" as "Codigo", "Cliente" as "Cliente", "Letra" as "Letra", "Ptovta" as "Puntodeventa", "Numero" as "Numero", "Factsec" as "Secuencia", "Totalcc" as "Totalcc", "Fechaven" as "Fechavencimiento", "Tipocomp" as "Tipodecomprobante", "Saldocc" as "Saldocc", "Fecha" as "Fecha", "Comprob" as "Comprobante", "Anotacion" as "Anotacion", "Valor" as "Valor", "Signo" as "Signodemovimiento", "Bdaltafw" as "Basededatosaltafw"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'CTACTE', '', tnTope )
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
				Case lcAtributo == 'FECHAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECIMPO AS FECHAIMPO'
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'FECHAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECEXPO AS FECHAEXPO'
				Case lcAtributo == 'FECHATRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRANS AS FECHATRANSFERENCIA'
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'CODIGOCOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODCOMP AS CODIGOCOMPROBANTE'
				Case lcAtributo == 'IDGLOBALCLIENTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLGLOBALID AS IDGLOBALCLIENTE'
				Case lcAtributo == 'MONEDA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONEDA AS MONEDA'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'CLIENTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLIENTE AS CLIENTE'
				Case lcAtributo == 'LETRA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LETRA AS LETRA'
				Case lcAtributo == 'PUNTODEVENTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PTOVTA AS PUNTODEVENTA'
				Case lcAtributo == 'NUMERO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NUMERO AS NUMERO'
				Case lcAtributo == 'SECUENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FACTSEC AS SECUENCIA'
				Case lcAtributo == 'TOTALCC'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TOTALCC AS TOTALCC'
				Case lcAtributo == 'FECHAVENCIMIENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHAVEN AS FECHAVENCIMIENTO'
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
				Case lcAtributo == 'VALOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALOR AS VALOR'
				Case lcAtributo == 'SIGNODEMOVIMIENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SIGNO AS SIGNODEMOVIMIENTO'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEXPO'
				lcCampo = 'FECEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGOCOMPROBANTE'
				lcCampo = 'CODCOMP'
			Case upper( alltrim( tcAtributo ) ) == 'IDGLOBALCLIENTE'
				lcCampo = 'CLGLOBALID'
			Case upper( alltrim( tcAtributo ) ) == 'MONEDA'
				lcCampo = 'MONEDA'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'CLIENTE'
				lcCampo = 'CLIENTE'
			Case upper( alltrim( tcAtributo ) ) == 'LETRA'
				lcCampo = 'LETRA'
			Case upper( alltrim( tcAtributo ) ) == 'PUNTODEVENTA'
				lcCampo = 'PTOVTA'
			Case upper( alltrim( tcAtributo ) ) == 'NUMERO'
				lcCampo = 'NUMERO'
			Case upper( alltrim( tcAtributo ) ) == 'SECUENCIA'
				lcCampo = 'FACTSEC'
			Case upper( alltrim( tcAtributo ) ) == 'TOTALCC'
				lcCampo = 'TOTALCC'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAVENCIMIENTO'
				lcCampo = 'FECHAVEN'
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
			Case upper( alltrim( tcAtributo ) ) == 'VALOR'
				lcCampo = 'VALOR'
			Case upper( alltrim( tcAtributo ) ) == 'SIGNODEMOVIMIENTO'
				lcCampo = 'SIGNO'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
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
			local  lxCtacteFecimpo, lxCtacteFmodifw, lxCtacteFecexpo, lxCtacteFectrans, lxCtacteFaltafw, lxCtacteValtafw, lxCtacteUmodifw, lxCtacteVmodifw, lxCtacteUaltafw, lxCtacteZadsfw, lxCtacteHoraexpo, lxCtacteHaltafw, lxCtacteEsttrans, lxCtacteSaltafw, lxCtacteHmodifw, lxCtacteSmodifw, lxCtacteHoraimpo, lxCtacteBdmodifw, lxCtacteCodcomp, lxCtacteClglobalid, lxCtacteMoneda, lxCtacteCodigo, lxCtacteCliente, lxCtacteLetra, lxCtactePtovta, lxCtacteNumero, lxCtacteFactsec, lxCtacteTotalcc, lxCtacteFechaven, lxCtacteTipocomp, lxCtacteSaldocc, lxCtacteFecha, lxCtacteComprob, lxCtacteAnotacion, lxCtacteValor, lxCtacteSigno, lxCtacteBdaltafw
				lxCtacteFecimpo =  .Fechaimpo			lxCtacteFmodifw =  .Fechamodificacionfw			lxCtacteFecexpo =  .Fechaexpo			lxCtacteFectrans =  .Fechatransferencia			lxCtacteFaltafw =  .Fechaaltafw			lxCtacteValtafw =  .Versionaltafw			lxCtacteUmodifw =  .Usuariomodificacionfw			lxCtacteVmodifw =  .Versionmodificacionfw			lxCtacteUaltafw =  .Usuarioaltafw			lxCtacteZadsfw =  .Zadsfw			lxCtacteHoraexpo =  .Horaexpo			lxCtacteHaltafw =  .Horaaltafw			lxCtacteEsttrans =  .Estadotransferencia			lxCtacteSaltafw =  .Seriealtafw			lxCtacteHmodifw =  .Horamodificacionfw			lxCtacteSmodifw =  .Seriemodificacionfw			lxCtacteHoraimpo =  .Horaimpo			lxCtacteBdmodifw =  .Basededatosmodificacionfw			lxCtacteCodcomp =  .Codigocomprobante			lxCtacteClglobalid =  .Idglobalcliente			lxCtacteMoneda =  upper( .Moneda_PK ) 			lxCtacteCodigo =  .Codigo			lxCtacteCliente =  upper( .Cliente_PK ) 			lxCtacteLetra =  .Letra			lxCtactePtovta =  .Puntodeventa			lxCtacteNumero =  .Numero			lxCtacteFactsec =  .Secuencia			lxCtacteTotalcc =  .Totalcc			lxCtacteFechaven =  .Fechavencimiento			lxCtacteTipocomp =  .Tipodecomprobante			lxCtacteSaldocc =  .Saldocc			lxCtacteFecha =  .Fecha			lxCtacteComprob =  .Comprobante			lxCtacteAnotacion =  .Anotacion			lxCtacteValor =  upper( .Valor_PK ) 			lxCtacteSigno =  .Signodemovimiento			lxCtacteBdaltafw =  .Basededatosaltafw
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.CTACTE ( "Fecimpo","Fmodifw","Fecexpo","Fectrans","Faltafw","Valtafw","Umodifw","Vmodifw","Ualtafw","Zadsfw","Horaexpo","Haltafw","Esttrans","Saltafw","Hmodifw","Smodifw","Horaimpo","Bdmodifw","Codcomp","Clglobalid","Moneda","Codigo","Cliente","Letra","Ptovta","Numero","Factsec","Totalcc","Fechaven","Tipocomp","Saldocc","Fecha","Comprob","Anotacion","Valor","Signo","Bdaltafw" ) values ( <<"'" + this.ConvertirDateSql( lxCtacteFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCtacteFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCtacteFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCtacteFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCtacteFaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCtacteValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCtacteUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCtacteVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCtacteUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCtacteZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCtacteHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCtacteHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCtacteEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCtacteSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCtacteHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCtacteSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCtacteHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCtacteBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCtacteCodcomp ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCtacteClglobalid ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCtacteMoneda ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCtacteCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCtacteCliente ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCtacteLetra ) + "'" >>, <<lxCtactePtovta >>, <<lxCtacteNumero >>, <<"'" + this.FormatearTextoSql( lxCtacteFactsec ) + "'" >>, <<lxCtacteTotalcc >>, <<"'" + this.ConvertirDateSql( lxCtacteFechaven ) + "'" >>, <<lxCtacteTipocomp >>, <<lxCtacteSaldocc >>, <<"'" + this.ConvertirDateSql( lxCtacteFecha ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCtacteComprob ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCtacteAnotacion ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCtacteValor ) + "'" >>, <<lxCtacteSigno >>, <<"'" + this.FormatearTextoSql( lxCtacteBdaltafw ) + "'" >> )
		endtext
		loColeccion.cTabla = 'CTACTE' 
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
			local  lxCtacteFecimpo, lxCtacteFmodifw, lxCtacteFecexpo, lxCtacteFectrans, lxCtacteFaltafw, lxCtacteValtafw, lxCtacteUmodifw, lxCtacteVmodifw, lxCtacteUaltafw, lxCtacteZadsfw, lxCtacteHoraexpo, lxCtacteHaltafw, lxCtacteEsttrans, lxCtacteSaltafw, lxCtacteHmodifw, lxCtacteSmodifw, lxCtacteHoraimpo, lxCtacteBdmodifw, lxCtacteCodcomp, lxCtacteClglobalid, lxCtacteMoneda, lxCtacteCodigo, lxCtacteCliente, lxCtacteLetra, lxCtactePtovta, lxCtacteNumero, lxCtacteFactsec, lxCtacteTotalcc, lxCtacteFechaven, lxCtacteTipocomp, lxCtacteSaldocc, lxCtacteFecha, lxCtacteComprob, lxCtacteAnotacion, lxCtacteValor, lxCtacteSigno, lxCtacteBdaltafw
				lxCtacteFecimpo =  .Fechaimpo			lxCtacteFmodifw =  .Fechamodificacionfw			lxCtacteFecexpo =  .Fechaexpo			lxCtacteFectrans =  .Fechatransferencia			lxCtacteFaltafw =  .Fechaaltafw			lxCtacteValtafw =  .Versionaltafw			lxCtacteUmodifw =  .Usuariomodificacionfw			lxCtacteVmodifw =  .Versionmodificacionfw			lxCtacteUaltafw =  .Usuarioaltafw			lxCtacteZadsfw =  .Zadsfw			lxCtacteHoraexpo =  .Horaexpo			lxCtacteHaltafw =  .Horaaltafw			lxCtacteEsttrans =  .Estadotransferencia			lxCtacteSaltafw =  .Seriealtafw			lxCtacteHmodifw =  .Horamodificacionfw			lxCtacteSmodifw =  .Seriemodificacionfw			lxCtacteHoraimpo =  .Horaimpo			lxCtacteBdmodifw =  .Basededatosmodificacionfw			lxCtacteCodcomp =  .Codigocomprobante			lxCtacteClglobalid =  .Idglobalcliente			lxCtacteMoneda =  upper( .Moneda_PK ) 			lxCtacteCodigo =  .Codigo			lxCtacteCliente =  upper( .Cliente_PK ) 			lxCtacteLetra =  .Letra			lxCtactePtovta =  .Puntodeventa			lxCtacteNumero =  .Numero			lxCtacteFactsec =  .Secuencia			lxCtacteTotalcc =  .Totalcc			lxCtacteFechaven =  .Fechavencimiento			lxCtacteTipocomp =  .Tipodecomprobante			lxCtacteSaldocc =  .Saldocc			lxCtacteFecha =  .Fecha			lxCtacteComprob =  .Comprobante			lxCtacteAnotacion =  .Anotacion			lxCtacteValor =  upper( .Valor_PK ) 			lxCtacteSigno =  .Signodemovimiento			lxCtacteBdaltafw =  .Basededatosaltafw
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  CTACTE.CODIGO != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.CTACTE set "Fecimpo" = <<"'" + this.ConvertirDateSql( lxCtacteFecimpo ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxCtacteFmodifw ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxCtacteFecexpo ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxCtacteFectrans ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxCtacteFaltafw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxCtacteValtafw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxCtacteUmodifw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxCtacteVmodifw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxCtacteUaltafw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxCtacteZadsfw ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxCtacteHoraexpo ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxCtacteHaltafw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxCtacteEsttrans ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxCtacteSaltafw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxCtacteHmodifw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxCtacteSmodifw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxCtacteHoraimpo ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxCtacteBdmodifw ) + "'">>, "Codcomp" = <<"'" + this.FormatearTextoSql( lxCtacteCodcomp ) + "'">>, "Clglobalid" = <<"'" + this.FormatearTextoSql( lxCtacteClglobalid ) + "'">>, "Moneda" = <<"'" + this.FormatearTextoSql( lxCtacteMoneda ) + "'">>, "Codigo" = <<"'" + this.FormatearTextoSql( lxCtacteCodigo ) + "'">>, "Cliente" = <<"'" + this.FormatearTextoSql( lxCtacteCliente ) + "'">>, "Letra" = <<"'" + this.FormatearTextoSql( lxCtacteLetra ) + "'">>, "Ptovta" = <<lxCtactePtovta>>, "Numero" = <<lxCtacteNumero>>, "Factsec" = <<"'" + this.FormatearTextoSql( lxCtacteFactsec ) + "'">>, "Totalcc" = <<lxCtacteTotalcc>>, "Fechaven" = <<"'" + this.ConvertirDateSql( lxCtacteFechaven ) + "'">>, "Tipocomp" = <<lxCtacteTipocomp>>, "Saldocc" = Saldocc + ( <<lxCtacteSaldocc>> ), "Fecha" = <<"'" + this.ConvertirDateSql( lxCtacteFecha ) + "'">>, "Comprob" = <<"'" + this.FormatearTextoSql( lxCtacteComprob ) + "'">>, "Anotacion" = <<"'" + this.FormatearTextoSql( lxCtacteAnotacion ) + "'">>, "Valor" = <<"'" + this.FormatearTextoSql( lxCtacteValor ) + "'">>, "Signo" = <<lxCtacteSigno>>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxCtacteBdaltafw ) + "'">> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'CTACTE' 
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

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  CTACTE.CODIGO != '']
		loColeccion.Agregar( 'delete from ZooLogic.CTACTE where ' + lcFiltro )
			loColeccion.cTabla = 'CTACTE' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.CTACTE where  CTACTE.CODIGO != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.CTACTE where Codigo = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  CTACTE.CODIGO != ''" )
			this.xmlacursor( lcXml, lcCursor )
		if reccount( lcCursor ) > 0
			lnTimeStamp = &lcCursor..Timestamp
		endif
		use in select( lcCursor )

		return lnTimeStamp 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirCabecera( tlLoguear as Boolean ) As Void
		local lcCursor as String, ldFecha as Date, lcHora as string, lcValorABuscar As String, lxValorClavePK As variant, lxValorClavePrimaria As variant, lcIdentificadorParaLoguear as string, lxCtaCteCliente as variant, lxCtaCteletra as variant, lxCtaCteptovta as variant, lxCtaCtenumero as variant, lxctactefactsec as variant, lxCtaCtefechaven as variant, lxCtaCteTipoComp as variant, lxCtaCteValor as variant, lxCtaCteBDAltaFW as variant, lcMensajeExtra as String
		lcValorABuscar = ''
		lxValorClavePK = ''
		lcMensajeExtra = ''
		lcCursor = This.oEntidad.cPrefijoRecibir + 'CTACTE'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.CTACTE Where  fechaven = ] + "'" + this.ConvertirDateSql( &lcCursor..fechaven   ) + "'" + [ and TipoComp = ] + transform( &lcCursor..TipoComp   ) + [ and letra = ] + "'" + this.FormatearTextoSql( &lcCursor..letra      ) + "'" + [ and ptovta = ] + transform( &lcCursor..ptovta     ) + [ and numero = ] + transform( &lcCursor..numero     ) + [ and Valor = ] + "'" + this.FormatearTextoSql( &lcCursor..Valor      ) + "'" + [ and Cliente = ] + "'" + this.FormatearTextoSql( &lcCursor..Cliente    ) + "'" + [ and factsec = ] + "'" + this.FormatearTextoSql( &lcCursor..factsec    ) + "'" + [ and BDAltaFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDAltaFW   ) + "'", 'curSeek', this.datasessionid )
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
						this.oConexion.EjecutarSql( [UPDATE ZooLogic.CTACTE set  FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, CodComp = ] + "'" + this.FormatearTextoSql( &lcCursor..CodComp ) + "'"+ [, clGlobalID = ] + "'" + this.FormatearTextoSql( &lcCursor..clGlobalID ) + "'"+ [, Moneda = ] + "'" + this.FormatearTextoSql( &lcCursor..Moneda ) + "'"+ [, Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'"+ [, Cliente = ] + "'" + this.FormatearTextoSql( &lcCursor..Cliente ) + "'"+ [, letra = ] + "'" + this.FormatearTextoSql( &lcCursor..letra ) + "'"+ [, ptovta = ] + transform( &lcCursor..ptovta )+ [, numero = ] + transform( &lcCursor..numero )+ [, factsec = ] + "'" + this.FormatearTextoSql( &lcCursor..factsec ) + "'"+ [, TotalCC = ] + transform( &lcCursor..TotalCC )+ [, fechaven = ] + "'" + this.ConvertirDateSql( &lcCursor..fechaven ) + "'"+ [, TipoComp = ] + transform( &lcCursor..TipoComp )+ [, SaldoCC = ZooLogic.CTACTE.SaldoCC + ] + transform( &lcCursor..SaldoCC )+ [, Fecha = ] + "'" + this.ConvertirDateSql( &lcCursor..Fecha ) + "'"+ [, Comprob = ] + "'" + this.FormatearTextoSql( &lcCursor..Comprob ) + "'"+ [, anotacion = ] + "'" + this.FormatearTextoSql( &lcCursor..anotacion ) + "'"+ [, Valor = ] + "'" + this.FormatearTextoSql( &lcCursor..Valor ) + "'"+ [, Signo = ] + transform( &lcCursor..Signo ) + [ Where Codigo = ] + "'" + this.FormatearTextoSql( lcValorABuscar ) + "'" )
						this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
					else
						this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
					endIf
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir porque no coincide la clave principal.', tlLoguear )
				endIf
			else
				this.oConexion.EjecutarSql( [Select * From ZooLogic.CTACTE Where Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'", 'curSeek', this.datasessionid )
				if reccount( 'curSeek' ) > 0
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir como alta porque la clave principal ya existe', tlLoguear )
				Else
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					Text to lcCampos noShow
						 FECIMPO, FMODIFW, FECEXPO, FECTRANS, FALTAFW, VALTAFW, UMODIFW, VMODIFW, UALTAFW, ZADSFW, HORAEXPO, HALTAFW, ESTTRANS, SALTAFW, HMODIFW, SMODIFW, HORAIMPO, BDMODIFW, CodComp, clGlobalID, Moneda, Codigo, Cliente, letra, ptovta, numero, factsec, TotalCC, fechaven, TipoComp, SaldoCC, Fecha, Comprob, anotacion, Valor, Signo, BDAltaFW
					EndText
					local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CodComp ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..clGlobalID ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Moneda ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Cliente ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..letra ) + "'" + ',' + transform( &lcCursor..ptovta ) + ',' + transform( &lcCursor..numero ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..factsec ) + "'" + ',' + transform( &lcCursor..TotalCC ) + ',' + "'" + this.ConvertirDateSql( &lcCursor..fechaven ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..TipoComp ) + ',' + transform( &lcCursor..SaldoCC ) + ',' + "'" + this.ConvertirDateSql( &lcCursor..Fecha ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Comprob ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..anotacion ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Valor ) + "'" + ',' + transform( &lcCursor..Signo ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDAltaFW ) + "'"
lcValoresCampos = substr(lcValoresCampos,2) 

					this.oConexion.EjecutarSql( [Insert into ZooLogic.CTACTE ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
				EndIf
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'CTACTE'
		if This.ActualizaEnRecepcion()
	endif
	Use in select( 'cExistentes' )
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearCursorMemo( tcCursorACrear as String, tcTablaConMemo as String ) as Void
		create cursor &tcCursorACrear ( Codigo C (48) , Orden N(16), texto C(80))
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirComponentes() As Void
		
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function ObtenerIdentificadorParaLoguear( tcCursor as String ) As String
		local lcRetorno as String, lnCC as String , loCC as Object, lni as Integer, lcSecuencia as String
		lcRetorno = this.oEntidad.cDescripcion 
		lcRetorno = lcRetorno + ' - Fecha de vencimiento: ' + transform( &tcCursor..fechaven   )
		lcRetorno = lcRetorno + ' - Tipo de comprobante: ' + transform( &tcCursor..TipoComp   )
		lcRetorno = lcRetorno + ' - Letra: ' + transform( &tcCursor..letra      )
		lcRetorno = lcRetorno + ' - Punto de venta: ' + transform( &tcCursor..ptovta     )
		lcRetorno = lcRetorno + ' - Número: ' + transform( &tcCursor..numero     )
		lcRetorno = lcRetorno + ' - Valor: ' + transform( &tcCursor..Valor      )
		lcRetorno = lcRetorno + ' - Cliente: ' + transform( &tcCursor..Cliente    )
		lcRetorno = lcRetorno + ' - Secuencia: ' + transform( &tcCursor..factsec    )
		Return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EsAliasDeProceso( tcAlias As String, tcPrefijo as string ) As Boolean
		local llRetorno as Boolean, lcAlias as String, lcPrefijo As String
		llRetorno = .F.
		lcAlias = upper( alltrim( tcAlias ) )
		lcPrefijo = upper( alltrim( tcPrefijo ) )
		Do Case
			Case  lcAlias == lcPrefijo + 'CTACTE'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'CTACTE_ZADSFW'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_CtaCte')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'CTACTE'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..Codigo
		llCondicion = isnull( lxVar ) or isnull( &lcCursor..fechaven ) or isnull( &lcCursor..TipoComp ) or isnull( &lcCursor..letra ) or isnull( &lcCursor..ptovta ) or isnull( &lcCursor..numero ) or isnull( &lcCursor..Valor ) or isnull( &lcCursor..Cliente ) or isnull( &lcCursor..factsec ) or isnull( &lcCursor..BDAltaFW )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad CTACTE. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'CTACTE'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		select recno() as _Rec, * from &lcCursor into cursor CurConRecno
		select max( _Rec ) as Maximo,Codigo as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( Codigo, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		select max( _Rec ) as Maximo,dtos( fechaven ) + str( TipoComp, 2, 0) + letra + str( ptovta, 4, 0) + str( numero, 8, 0) + Valor + Cliente + factsec + BDAltaFW as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( dtos( fechaven ) + str( TipoComp, 2, 0) + letra + str( ptovta, 4, 0) + str( numero, 8, 0) + Valor + Cliente + factsec + BDAltaFW, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		Use in select( 'CurConRecno' )
		Use in select( 'RepMax' )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDatosInvalidos( toConexion as Object ) as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'CTACTE'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  fechaven  
		* Validar ANTERIORES A 1/1/1753  Fecha     
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_CtaCte') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_CtaCte
Create Table ZooLogic.TablaTrabajo_CtaCte ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fecimpo" datetime  null, 
"fmodifw" datetime  null, 
"fecexpo" datetime  null, 
"fectrans" datetime  null, 
"faltafw" datetime  null, 
"valtafw" char( 13 )  null, 
"umodifw" char( 100 )  null, 
"vmodifw" char( 13 )  null, 
"ualtafw" char( 100 )  null, 
"zadsfw" varchar(max)  null, 
"horaexpo" char( 8 )  null, 
"haltafw" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"saltafw" char( 7 )  null, 
"hmodifw" char( 8 )  null, 
"smodifw" char( 7 )  null, 
"horaimpo" char( 8 )  null, 
"bdmodifw" char( 8 )  null, 
"codcomp" char( 38 )  null, 
"clglobalid" char( 38 )  null, 
"moneda" char( 10 )  null, 
"codigo" char( 48 )  null, 
"cliente" char( 10 )  null, 
"letra" char( 1 )  null, 
"ptovta" numeric( 4, 0 )  null, 
"numero" numeric( 8, 0 )  null, 
"factsec" char( 2 )  null, 
"totalcc" numeric( 15, 2 )  null, 
"fechaven" datetime  null, 
"tipocomp" numeric( 2, 0 )  null, 
"saldocc" numeric( 15, 2 )  null, 
"fecha" datetime  null, 
"comprob" char( 100 )  null, 
"anotacion" char( 100 )  null, 
"valor" char( 5 )  null, 
"signo" numeric( 2, 0 )  null, 
"bdaltafw" char( 8 )  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_CtaCte' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_CtaCte' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'CTACTE'
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
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('codcomp','codcomp')
			.AgregarMapeo('clglobalid','clglobalid')
			.AgregarMapeo('moneda','moneda')
			.AgregarMapeo('codigo','codigo')
			.AgregarMapeo('cliente','cliente')
			.AgregarMapeo('letra','letra')
			.AgregarMapeo('ptovta','ptovta')
			.AgregarMapeo('numero','numero')
			.AgregarMapeo('factsec','factsec')
			.AgregarMapeo('totalcc','totalcc')
			.AgregarMapeo('fechaven','fechaven')
			.AgregarMapeo('tipocomp','tipocomp')
			.AgregarMapeo('saldocc','saldocc')
			.AgregarMapeo('fecha','fecha')
			.AgregarMapeo('comprob','comprob')
			.AgregarMapeo('anotacion','anotacion')
			.AgregarMapeo('valor','valor')
			.AgregarMapeo('signo','signo')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_CtaCte'
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
				Update t Set t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.CODCOMP = isnull( d.CODCOMP, t.CODCOMP ),t.CLGLOBALID = isnull( d.CLGLOBALID, t.CLGLOBALID ),t.MONEDA = isnull( d.MONEDA, t.MONEDA ),t.CODIGO = isnull( d.CODIGO, t.CODIGO ),t.CLIENTE = isnull( d.CLIENTE, t.CLIENTE ),t.LETRA = isnull( d.LETRA, t.LETRA ),t.PTOVTA = isnull( d.PTOVTA, t.PTOVTA ),t.NUMERO = isnull( d.NUMERO, t.NUMERO ),t.FACTSEC = isnull( d.FACTSEC, t.FACTSEC ),t.TOTALCC = isnull( d.TOTALCC, t.TOTALCC ),t.FECHAVEN = isnull( d.FECHAVEN, t.FECHAVEN ),t.TIPOCOMP = isnull( d.TIPOCOMP, t.TIPOCOMP ),t.SALDOCC = isnull( d.SALDOCC, t.SALDOCC ),t.FECHA = isnull( d.FECHA, t.FECHA ),t.COMPROB = isnull( d.COMPROB, t.COMPROB ),t.ANOTACION = isnull( d.ANOTACION, t.ANOTACION ),t.VALOR = isnull( d.VALOR, t.VALOR ),t.SIGNO = isnull( d.SIGNO, t.SIGNO ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW )
					from ZooLogic.CTACTE t inner join deleted d 
							 on t.Codigo = d.Codigo
							 and  t.fechaven = d.fechaven
							 and  t.TipoComp = d.TipoComp
							 and  t.letra = d.letra
							 and  t.ptovta = d.ptovta
							 and  t.numero = d.numero
							 and  t.Valor = d.Valor
							 and  t.Cliente = d.Cliente
							 and  t.factsec = d.factsec
							 and  t.BDAltaFW = d.BDAltaFW
				-- Fin Updates
				insert into ZooLogic.CTACTE(Fecimpo,Fmodifw,Fecexpo,Fectrans,Faltafw,Valtafw,Umodifw,Vmodifw,Ualtafw,Zadsfw,Horaexpo,Haltafw,Esttrans,Saltafw,Hmodifw,Smodifw,Horaimpo,Bdmodifw,Codcomp,Clglobalid,Moneda,Codigo,Cliente,Letra,Ptovta,Numero,Factsec,Totalcc,Fechaven,Tipocomp,Saldocc,Fecha,Comprob,Anotacion,Valor,Signo,Bdaltafw)
					Select isnull( d.FECIMPO,''),isnull( d.FMODIFW,''),isnull( d.FECEXPO,''),isnull( d.FECTRANS,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.VALTAFW,''),isnull( d.UMODIFW,''),isnull( d.VMODIFW,''),isnull( d.UALTAFW,''),isnull( d.ZADSFW,''),isnull( d.HORAEXPO,''),convert( char(8), getdate(), 108 ),isnull( d.ESTTRANS,''),isnull( d.SALTAFW,''),isnull( d.HMODIFW,''),isnull( d.SMODIFW,''),isnull( d.HORAIMPO,''),isnull( d.BDMODIFW,''),isnull( d.CODCOMP,''),isnull( d.CLGLOBALID,''),isnull( d.MONEDA,''),isnull( d.CODIGO,''),isnull( d.CLIENTE,''),isnull( d.LETRA,''),isnull( d.PTOVTA,0),isnull( d.NUMERO,0),isnull( d.FACTSEC,''),isnull( d.TOTALCC,0),isnull( d.FECHAVEN,''),isnull( d.TIPOCOMP,0),isnull( d.SALDOCC,0),isnull( d.FECHA,''),isnull( d.COMPROB,''),isnull( d.ANOTACION,''),isnull( d.VALOR,''),isnull( d.SIGNO,0),isnull( d.BDALTAFW,'')
						From deleted d left join ZooLogic.CTACTE pk 
							 on d.Codigo = pk.Codigo
						 left join ZooLogic.CTACTE cc 
							 on  d.fechaven = cc.fechaven
							 and  d.TipoComp = cc.TipoComp
							 and  d.letra = cc.letra
							 and  d.ptovta = cc.ptovta
							 and  d.numero = cc.numero
							 and  d.Valor = cc.Valor
							 and  d.Cliente = cc.Cliente
							 and  d.factsec = cc.factsec
							 and  d.BDAltaFW = cc.BDAltaFW
						Where pk.Codigo Is Null 
							 and cc.fechaven Is Null 
							 and cc.TipoComp Is Null 
							 and cc.letra Is Null 
							 and cc.ptovta Is Null 
							 and cc.numero Is Null 
							 and cc.Valor Is Null 
							 and cc.Cliente Is Null 
							 and cc.factsec Is Null 
							 and cc.BDAltaFW Is Null 
				-- Fin Inserts
				Insert into ZooLogic.Logueos ( Fecha, Nivel, Logger, Accion, BaseDeDatos, 
					EstadoDelSistema, Aplicacion, Version, 
					Serie, Usuario, NombrePc, 
					UsuarioPc, OrigenLogueo, Mensaje, Excepcion)
				select GetDate(), 'INFO', '', 'Importación <<lcEntidad>>','<<loLogueo.BaseDatos>>',
					<<loLogueo.EstadoSistema>>,'<<loLogueo.Aplicacion>>','<<loLogueo.Version>>',
					'<<loLogueo.Serie>>','<<loLogueo.Usuario>>','<<loLogueo.NombrePc>>',
					'<<loLogueo.UsuarioPc>>','<<loLogueo.OrigenLogueo>>','No se pudo importar la entidad <<lcEntidad>>: FECHA DE VENCIMIENTO ' + cast( d.fechaven as Varchar(8) ) + ', TIPO DE COMPROBANTE ' + cast( d.TipoComp as Varchar(2) ) + ', LETRA ' + cast( d.letra as Varchar(1) ) + ', PUNTO DE VENTA ' + cast( d.ptovta as Varchar(4) ) + ', NÚMERO ' + cast( d.numero as Varchar(8) ) + ', VALOR ' + cast( d.Valor as Varchar(5) ) + ', CLIENTE ' + cast( d.Cliente as Varchar(10) ) + ', SECUENCIA ' + cast( d.factsec as Varchar(2) ) + ', BASE DE DATOS ' + cast( d.BDAltaFW as Varchar(8) ) + '','La clave principal no es la esperada'
					from ZooLogic.CTACTE t inner join deleted d 
							on   t.fechaven = d.fechaven
							 and  t.TipoComp = d.TipoComp
							 and  t.letra = d.letra
							 and  t.ptovta = d.ptovta
							 and  t.numero = d.numero
							 and  t.Valor = d.Valor
							 and  t.Cliente = d.Cliente
							 and  t.factsec = d.factsec
							 and  t.BDAltaFW = d.BDAltaFW
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
					'<<loLogueo.UsuarioPc>>','<<loLogueo.OrigenLogueo>>','No se pudo importar la entidad <<lcEntidad>>: FECHA DE VENCIMIENTO ' + cast( d.fechaven as Varchar(8) ) + ', TIPO DE COMPROBANTE ' + cast( d.TipoComp as Varchar(2) ) + ', LETRA ' + cast( d.letra as Varchar(1) ) + ', PUNTO DE VENTA ' + cast( d.ptovta as Varchar(4) ) + ', NÚMERO ' + cast( d.numero as Varchar(8) ) + ', VALOR ' + cast( d.Valor as Varchar(5) ) + ', CLIENTE ' + cast( d.Cliente as Varchar(10) ) + ', SECUENCIA ' + cast( d.factsec as Varchar(2) ) + ', BASE DE DATOS ' + cast( d.BDAltaFW as Varchar(8) ) + '','La clave principal a importar ya existe'
					from ZooLogic.CTACTE t inner join deleted d 
							 on t.Codigo = d.Codigo
						left join deleted h 
							on   t.fechaven = h.fechaven
							 and   t.TipoComp = h.TipoComp
							 and   t.letra = h.letra
							 and   t.ptovta = h.ptovta
							 and   t.numero = h.numero
							 and   t.Valor = h.Valor
							 and   t.Cliente = h.Cliente
							 and   t.factsec = h.factsec
							 and   t.BDAltaFW = h.BDAltaFW
							where   h.fechaven is null 
							 and   h.TipoComp is null 
							 and   h.letra is null 
							 and   h.ptovta is null 
							 and   h.numero is null 
							 and   h.Valor is null 
							 and   h.Cliente is null 
							 and   h.factsec is null 
							 and   h.BDAltaFW is null 
			End
		EndText
		Return lcCadena
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	protected Function EliminarTablasDeTrabajo( toConexion as Object ) as void
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_CtaCte') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_CtaCte
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_CTACTE' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_CTACTE.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_CTACTE.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_CTACTE.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_CTACTE.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_CTACTE.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Versionaltafw = nvl( c_CTACTE.Versionaltafw, [] )
					.Usuariomodificacionfw = nvl( c_CTACTE.Usuariomodificacionfw, [] )
					.Versionmodificacionfw = nvl( c_CTACTE.Versionmodificacionfw, [] )
					.Usuarioaltafw = nvl( c_CTACTE.Usuarioaltafw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Horaexpo = nvl( c_CTACTE.Horaexpo, [] )
					.Horaaltafw = nvl( c_CTACTE.Horaaltafw, [] )
					.Estadotransferencia = nvl( c_CTACTE.Estadotransferencia, [] )
					.Seriealtafw = nvl( c_CTACTE.Seriealtafw, [] )
					.Horamodificacionfw = nvl( c_CTACTE.Horamodificacionfw, [] )
					.Seriemodificacionfw = nvl( c_CTACTE.Seriemodificacionfw, [] )
					.Horaimpo = nvl( c_CTACTE.Horaimpo, [] )
					.Basededatosmodificacionfw = nvl( c_CTACTE.Basededatosmodificacionfw, [] )
					.Codigocomprobante = nvl( c_CTACTE.Codigocomprobante, [] )
					.Idglobalcliente = nvl( c_CTACTE.Idglobalcliente, [] )
					.Moneda_PK =  nvl( c_CTACTE.Moneda, [] )
					.Codigo = nvl( c_CTACTE.Codigo, [] )
					.Cliente_PK =  nvl( c_CTACTE.Cliente, [] )
					.Letra = nvl( c_CTACTE.Letra, [] )
					.Puntodeventa = nvl( c_CTACTE.Puntodeventa, 0 )
					.Numero = nvl( c_CTACTE.Numero, 0 )
					.Secuencia = nvl( c_CTACTE.Secuencia, [] )
					.Totalcc = nvl( c_CTACTE.Totalcc, 0 )
					.Fechavencimiento = GoLibrerias.ObtenerFechaFormateada( nvl( c_CTACTE.Fechavencimiento, ctod( '  /  /    ' ) ) )
					.Tipodecomprobante = nvl( c_CTACTE.Tipodecomprobante, 0 )
					.Saldocc = nvl( c_CTACTE.Saldocc, 0 )
					.Fecha = GoLibrerias.ObtenerFechaFormateada( nvl( c_CTACTE.Fecha, ctod( '  /  /    ' ) ) )
					.Comprobante = nvl( c_CTACTE.Comprobante, [] )
					.Anotacion = nvl( c_CTACTE.Anotacion, [] )
					.Valor_PK =  nvl( c_CTACTE.Valor, [] )
					.Signodemovimiento = nvl( c_CTACTE.Signodemovimiento, 0 )
					.Basededatosaltafw = nvl( c_CTACTE.Basededatosaltafw, [] )
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
			lxRetorno = c_CTACTE.CODIGO
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
		return c_CTACTE.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.CTACTE' )
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
								from ZooLogic.CTACTE 
								Where   CTACTE.CODIGO != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "CTACTE", "", lcCursor, set("Datasession") )
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
			"Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Ualtafw" as "Usuarioaltafw", "Zadsfw" as "Zadsfw", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Esttrans" as "Estadotransferencia", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Bdmodifw" as "Basededatosmodificacionfw", "Codcomp" as "Codigocomprobante", "Clglobalid" as "Idglobalcliente", "Moneda" as "Moneda", "Codigo" as "Codigo", "Cliente" as "Cliente", "Letra" as "Letra", "Ptovta" as "Puntodeventa", "Numero" as "Numero", "Factsec" as "Secuencia", "Totalcc" as "Totalcc", "Fechaven" as "Fechavencimiento", "Tipocomp" as "Tipodecomprobante", "Saldocc" as "Saldocc", "Fecha" as "Fecha", "Comprob" as "Comprobante", "Anotacion" as "Anotacion", "Valor" as "Valor", "Signo" as "Signodemovimiento", "Bdaltafw" as "Basededatosaltafw"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.CTACTE 
								Where   CTACTE.CODIGO != ''
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
	Tabla = 'CTACTE'
	Filtro = " CTACTE.CODIGO != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " CTACTE.CODIGO != ''"
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
	<row entidad="CTACTE                                  " atributo="FECHAIMPO                               " tabla="CTACTE         " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CTACTE                                  " atributo="FECHAMODIFICACIONFW                     " tabla="CTACTE         " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CTACTE                                  " atributo="FECHAEXPO                               " tabla="CTACTE         " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CTACTE                                  " atributo="FECHATRANSFERENCIA                      " tabla="CTACTE         " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha de novedad                                                                                                                                                " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CTACTE                                  " atributo="FECHAALTAFW                             " tabla="CTACTE         " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CTACTE                                  " atributo="VERSIONALTAFW                           " tabla="CTACTE         " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CTACTE                                  " atributo="USUARIOMODIFICACIONFW                   " tabla="CTACTE         " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CTACTE                                  " atributo="VERSIONMODIFICACIONFW                   " tabla="CTACTE         " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CTACTE                                  " atributo="USUARIOALTAFW                           " tabla="CTACTE         " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CTACTE                                  " atributo="ZADSFW                                  " tabla="CTACTE         " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CTACTE                                  " atributo="HORAEXPO                                " tabla="CTACTE         " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CTACTE                                  " atributo="HORAALTAFW                              " tabla="CTACTE         " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CTACTE                                  " atributo="ESTADOTRANSFERENCIA                     " tabla="CTACTE         " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado de novedad                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CTACTE                                  " atributo="SERIEALTAFW                             " tabla="CTACTE         " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CTACTE                                  " atributo="HORAMODIFICACIONFW                      " tabla="CTACTE         " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CTACTE                                  " atributo="SERIEMODIFICACIONFW                     " tabla="CTACTE         " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CTACTE                                  " atributo="HORAIMPO                                " tabla="CTACTE         " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CTACTE                                  " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="CTACTE         " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CTACTE                                  " atributo="CODIGOCOMPROBANTE                       " tabla="CTACTE         " campo="CODCOMP   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CTACTE                                  " atributo="IDGLOBALCLIENTE                         " tabla="CTACTE         " campo="CLGLOBALID" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Identificador global                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CTACTE                                  " atributo="MONEDA                                  " tabla="CTACTE         " campo="MONEDA    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="MONEDA                                  " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Moneda                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="Valor.SimboloMonetario                                                                                                                                                                                                                                        " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CTACTE                                  " atributo="CODIGO                                  " tabla="CTACTE         " campo="CODIGO    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="48" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="16" etiqueta="Número interno                                                                                                                                                  " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CTACTE                                  " atributo="CLIENTE                                 " tabla="CTACTE         " campo="CLIENTE   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CLIENTE                                 " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="400" etiqueta="Cliente                                                                                                                                                         " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="7" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CTACTE                                  " atributo="LETRA                                   " tabla="CTACTE         " campo="LETRA     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="4" etiqueta="Letra                                                                                                                                                           " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="3" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CTACTE                                  " atributo="PUNTODEVENTA                            " tabla="CTACTE         " campo="PTOVTA    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="4" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="6" etiqueta="Punto de venta                                                                                                                                                  " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="4" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CTACTE                                  " atributo="NUMERO                                  " tabla="CTACTE         " campo="NUMERO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="8" etiqueta="Número                                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="5" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CTACTE                                  " atributo="SECUENCIA                               " tabla="CTACTE         " campo="FACTSEC   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="402" etiqueta="Secuencia                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="8" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CTACTE                                  " atributo="TOTALCC                                 " tabla="CTACTE         " campo="TOTALCC   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="404" etiqueta="Total                                                                                                                                                           " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CTACTE                                  " atributo="FECHAVENCIMIENTO                        " tabla="CTACTE         " campo="FECHAVEN  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="406" etiqueta="Fecha de vencimiento                                                                                                                                            " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="1" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="8" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CTACTE                                  " atributo="TIPODECOMPROBANTE                       " tabla="CTACTE         " campo="TIPOCOMP  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="10" etiqueta="Tipo de comprobante                                                                                                                                             " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="2" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="9" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CTACTE                                  " atributo="SALDOCC                                 " tabla="CTACTE         " campo="SALDOCC   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="408" etiqueta="Saldo                                                                                                                                                           " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="10" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CTACTE                                  " atributo="FECHA                                   " tabla="CTACTE         " campo="FECHA     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha                                                                                                                                                           " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="11" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CTACTE                                  " atributo="COMPROBANTE                             " tabla="CTACTE         " campo="COMPROB   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Comprobante                                                                                                                                                     " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="12" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CTACTE                                  " atributo="ANOTACION                               " tabla="CTACTE         " campo="ANOTACION " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Anotación                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="13" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CTACTE                                  " atributo="VALOR                                   " tabla="CTACTE         " campo="VALOR     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="VALOR                                   " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="14" etiqueta="Valor                                                                                                                                                           " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="6" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="18" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CTACTE                                  " atributo="SIGNODEMOVIMIENTO                       " tabla="CTACTE         " campo="SIGNO     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="0" etiqueta="Signo de Movimiento                                                                                                                                             " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="20" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CTACTE                                  " atributo="BASEDEDATOSALTAFW                       " tabla="CTACTE         " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos CC                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="9" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="21" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="NOMBRE                                  " tabla="CLI            " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="185" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="401" etiqueta="Detalle Cli.                                                                                                                                                    " dominio="TEXTOBUSQUEDA                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CLI On CTACTE.CLIENTE = CLI.CLCOD And  CLI.CLCOD != ''                                                                                                                                                                                             " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="5" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="DESCRIPCION                             " tabla="XVAL           " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="15" etiqueta="Detalle Val.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join XVAL On CTACTE.VALOR = XVAL.CLCOD And  XVAL.CLCOD != ''                                                                                                                                                                                            " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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