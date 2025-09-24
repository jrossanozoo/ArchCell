
define class Din_EntidadCONSUMOCLIENTEAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_CONSUMOCLIENTE'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = [str( tipoComprobante, 2, 0) + Letra + str( PuntoDeVenta, 4, 0) + str( Numero, 8, 0) + CodigoComprobante]
	cExpresionCCPorCampos = [str( #tabla#.TipComp, 2, 0) + #tabla#.Letra + str( #tabla#.ptoVta, 4, 0) + str( #tabla#.num, 8, 0) + #tabla#.codcomp]
	cTagClaveCandidata = '_CCLCC'
	cTagClavePk = '_CCLPK'
	cTablaPrincipal = 'CONCLI'
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
			local  lxConcliFecexpo, lxConcliFaltafw, lxConcliFecimpo, lxConcliFmodifw, lxConcliFectrans, lxConcliSigno, lxConcliAnul, lxConcliHmodifw, lxConcliSaltafw, lxConcliUmodifw, lxConcliZadsfw, lxConcliDescfw, lxConcliVmodifw, lxConcliValtafw, lxConcliUaltafw, lxConcliHoraimpo, lxConcliSmodifw, lxConcliEsttrans, lxConcliHoraexpo, lxConcliDb, lxConcliCodcomp, lxConcliHaltafw, lxConcliBdaltafw, lxConcliBdmodifw, lxConcliCodigo, lxConcliLimconsumo, lxConcliCliente, lxConcliTipcomp, lxConcliLetra, lxConcliPtovta, lxConcliNum, lxConcliFeccomp, lxConcliMonto, lxConcliObs
				lxConcliFecexpo =  .Fechaexpo			lxConcliFaltafw =  .Fechaaltafw			lxConcliFecimpo =  .Fechaimpo			lxConcliFmodifw =  .Fechamodificacionfw			lxConcliFectrans =  .Fechatransferencia			lxConcliSigno =  .Signo			lxConcliAnul =  .Anulado			lxConcliHmodifw =  .Horamodificacionfw			lxConcliSaltafw =  .Seriealtafw			lxConcliUmodifw =  .Usuariomodificacionfw			lxConcliZadsfw =  .Zadsfw			lxConcliDescfw =  .Descripcionfw			lxConcliVmodifw =  .Versionmodificacionfw			lxConcliValtafw =  .Versionaltafw			lxConcliUaltafw =  .Usuarioaltafw			lxConcliHoraimpo =  .Horaimpo			lxConcliSmodifw =  .Seriemodificacionfw			lxConcliEsttrans =  .Estadotransferencia			lxConcliHoraexpo =  .Horaexpo			lxConcliDb =  .Basededatos			lxConcliCodcomp =  .Codigocomprobante			lxConcliHaltafw =  .Horaaltafw			lxConcliBdaltafw =  .Basededatosaltafw			lxConcliBdmodifw =  .Basededatosmodificacionfw			lxConcliCodigo =  .Codigo			lxConcliLimconsumo =  upper( .LimiteConsumo_PK ) 			lxConcliCliente =  .Cliente			lxConcliTipcomp =  .Tipocomprobante			lxConcliLetra =  .Letra			lxConcliPtovta =  .Puntodeventa			lxConcliNum =  .Numero			lxConcliFeccomp =  .Fechacomp			lxConcliMonto =  .Monto			lxConcliObs =  .Observacion
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxConcliCodigo = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.CONCLI ( "Fecexpo","Faltafw","Fecimpo","Fmodifw","Fectrans","Signo","Anul","Hmodifw","Saltafw","Umodifw","Zadsfw","Descfw","Vmodifw","Valtafw","Ualtafw","Horaimpo","Smodifw","Esttrans","Horaexpo","Db","Codcomp","Haltafw","Bdaltafw","Bdmodifw","Codigo","Limconsumo","Cliente","Tipcomp","Letra","Ptovta","Num","Feccomp","Monto","Obs" ) values ( <<"'" + this.ConvertirDateSql( lxConcliFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxConcliFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxConcliFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxConcliFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxConcliFectrans ) + "'" >>, <<lxConcliSigno >>, <<iif( lxConcliAnul, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxConcliHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxConcliSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxConcliUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxConcliZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxConcliDescfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxConcliVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxConcliValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxConcliUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxConcliHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxConcliSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxConcliEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxConcliHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxConcliDb ) + "'" >>, <<"'" + this.FormatearTextoSql( lxConcliCodcomp ) + "'" >>, <<"'" + this.FormatearTextoSql( lxConcliHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxConcliBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxConcliBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxConcliCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxConcliLimconsumo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxConcliCliente ) + "'" >>, <<lxConcliTipcomp >>, <<"'" + this.FormatearTextoSql( lxConcliLetra ) + "'" >>, <<lxConcliPtovta >>, <<lxConcliNum >>, <<"'" + this.ConvertirDateSql( lxConcliFeccomp ) + "'" >>, <<lxConcliMonto >>, <<"'" + this.FormatearTextoSql( lxConcliObs ) + "'" >> )
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
		this.ComprobarTransaccion()
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = lxValorClavePrimaria

			lcSentencia = this.ObtenerSentenciasInsertAuditoria()
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
		this.ComprobarTransaccion()
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
			local  lxConcliFecexpo, lxConcliFaltafw, lxConcliFecimpo, lxConcliFmodifw, lxConcliFectrans, lxConcliSigno, lxConcliAnul, lxConcliHmodifw, lxConcliSaltafw, lxConcliUmodifw, lxConcliZadsfw, lxConcliDescfw, lxConcliVmodifw, lxConcliValtafw, lxConcliUaltafw, lxConcliHoraimpo, lxConcliSmodifw, lxConcliEsttrans, lxConcliHoraexpo, lxConcliDb, lxConcliCodcomp, lxConcliHaltafw, lxConcliBdaltafw, lxConcliBdmodifw, lxConcliCodigo, lxConcliLimconsumo, lxConcliCliente, lxConcliTipcomp, lxConcliLetra, lxConcliPtovta, lxConcliNum, lxConcliFeccomp, lxConcliMonto, lxConcliObs
				lxConcliFecexpo =  .Fechaexpo			lxConcliFaltafw =  .Fechaaltafw			lxConcliFecimpo =  .Fechaimpo			lxConcliFmodifw =  .Fechamodificacionfw			lxConcliFectrans =  .Fechatransferencia			lxConcliSigno =  .Signo			lxConcliAnul =  .Anulado			lxConcliHmodifw =  .Horamodificacionfw			lxConcliSaltafw =  .Seriealtafw			lxConcliUmodifw =  .Usuariomodificacionfw			lxConcliZadsfw =  .Zadsfw			lxConcliDescfw =  .Descripcionfw			lxConcliVmodifw =  .Versionmodificacionfw			lxConcliValtafw =  .Versionaltafw			lxConcliUaltafw =  .Usuarioaltafw			lxConcliHoraimpo =  .Horaimpo			lxConcliSmodifw =  .Seriemodificacionfw			lxConcliEsttrans =  .Estadotransferencia			lxConcliHoraexpo =  .Horaexpo			lxConcliDb =  .Basededatos			lxConcliCodcomp =  .Codigocomprobante			lxConcliHaltafw =  .Horaaltafw			lxConcliBdaltafw =  .Basededatosaltafw			lxConcliBdmodifw =  .Basededatosmodificacionfw			lxConcliCodigo =  .Codigo			lxConcliLimconsumo =  upper( .LimiteConsumo_PK ) 			lxConcliCliente =  .Cliente			lxConcliTipcomp =  .Tipocomprobante			lxConcliLetra =  .Letra			lxConcliPtovta =  .Puntodeventa			lxConcliNum =  .Numero			lxConcliFeccomp =  .Fechacomp			lxConcliMonto =  .Monto			lxConcliObs =  .Observacion
		endwith
		
		with this
		Try
			local llInsertarAuditoria as Boolean
			llInsertarAuditoria = (  .oEntidad.oAtributosAuditoria.BaseDeDatos != .oEntidad.BaseDeDatos or  .oEntidad.oAtributosAuditoria.LimiteConsumo != .oEntidad.LimiteConsumo_Pk or  .oEntidad.oAtributosAuditoria.Cliente != .oEntidad.Cliente or  this.ConvertirDateSql( .oEntidad.oAtributosAuditoria.FechaComp) != this.ConvertirDateSql( .oEntidad.FechaComp) or  .oEntidad.oAtributosAuditoria.monto != .oEntidad.monto )
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()
			lxValorClavePrimaria = .oEntidad.CODIGO
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ZooLogic.CONCLI set "Fecexpo" = <<"'" + this.ConvertirDateSql( lxConcliFecexpo ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxConcliFaltafw ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxConcliFecimpo ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxConcliFmodifw ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxConcliFectrans ) + "'">>,"Signo" = <<lxConcliSigno>>,"Anul" = <<iif( lxConcliAnul, 1, 0 )>>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxConcliHmodifw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxConcliSaltafw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxConcliUmodifw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxConcliZadsfw ) + "'">>,"Descfw" = <<"'" + this.FormatearTextoSql( lxConcliDescfw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxConcliVmodifw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxConcliValtafw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxConcliUaltafw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxConcliHoraimpo ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxConcliSmodifw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxConcliEsttrans ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxConcliHoraexpo ) + "'">>,"Db" = <<"'" + this.FormatearTextoSql( lxConcliDb ) + "'">>,"Codcomp" = <<"'" + this.FormatearTextoSql( lxConcliCodcomp ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxConcliHaltafw ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxConcliBdaltafw ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxConcliBdmodifw ) + "'">>,"Codigo" = <<"'" + this.FormatearTextoSql( lxConcliCodigo ) + "'">>,"Limconsumo" = <<"'" + this.FormatearTextoSql( lxConcliLimconsumo ) + "'">>,"Cliente" = <<"'" + this.FormatearTextoSql( lxConcliCliente ) + "'">>,"Tipcomp" = <<lxConcliTipcomp>>,"Letra" = <<"'" + this.FormatearTextoSql( lxConcliLetra ) + "'">>,"Ptovta" = <<lxConcliPtovta>>,"Num" = <<lxConcliNum>>,"Feccomp" = <<"'" + this.ConvertirDateSql( lxConcliFeccomp ) + "'">>,"Monto" = <<lxConcliMonto>>,"Obs" = <<"'" + this.FormatearTextoSql( lxConcliObs ) + "'">> where "Codigo" = <<"'" + this.FormatearTextoSql( lxConcliCodigo ) + "'">> and  CONCLI.CODIGO != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			this.ComprobarResultadoDeEjecucionDelUpdate()
		this.ComprobarTransaccion()
			If llInsertarAuditoria
				lcSentencia = this.ObtenerSentenciasInsertAuditoria()
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			EndIf
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 Codigo from ZooLogic.CONCLI where " + this.ConvertirFuncionesSql( " CONCLI.CODIGO != ''" ) )
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
			Local lxConcliCodigo
			lxConcliCodigo = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Signo" as "Signo", "Anul" as "Anulado", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Descfw" as "Descripcionfw", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Horaimpo" as "Horaimpo", "Smodifw" as "Seriemodificacionfw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Db" as "Basededatos", "Codcomp" as "Codigocomprobante", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Codigo" as "Codigo", "Limconsumo" as "Limiteconsumo", "Cliente" as "Cliente", "Tipcomp" as "Tipocomprobante", "Letra" as "Letra", "Ptovta" as "Puntodeventa", "Num" as "Numero", "Feccomp" as "Fechacomp", "Monto" as "Monto", "Obs" as "Observacion" from ZooLogic.CONCLI where "Codigo" = <<"'" + this.FormatearTextoSql( lxConcliCodigo ) + "'">> and  CONCLI.CODIGO != ''
			endtext
			use in select('c_CONSUMOCLIENTE')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CONSUMOCLIENTE', set( 'Datasession' ) )

			if reccount( 'c_CONSUMOCLIENTE' ) = 0
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
			Local lxCONCLITipComp As Variant, lxCONCLILetra As Variant, lxCONCLIptoVta As Variant, lxCONCLInum As Variant, lxCONCLIcodcomp As Variant
			lxCONCLITipComp = .tipoComprobante
			lxCONCLILetra = .Letra
			lxCONCLIptoVta = .PuntoDeVenta
			lxCONCLInum = .Numero
			lxCONCLIcodcomp = .CodigoComprobante
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Signo" as "Signo", "Anul" as "Anulado", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Descfw" as "Descripcionfw", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Horaimpo" as "Horaimpo", "Smodifw" as "Seriemodificacionfw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Db" as "Basededatos", "Codcomp" as "Codigocomprobante", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Codigo" as "Codigo", "Limconsumo" as "Limiteconsumo", "Cliente" as "Cliente", "Tipcomp" as "Tipocomprobante", "Letra" as "Letra", "Ptovta" as "Puntodeventa", "Num" as "Numero", "Feccomp" as "Fechacomp", "Monto" as "Monto", "Obs" as "Observacion" from ZooLogic.CONCLI where  CONCLI.CODIGO != '' And TipComp = <<lxCONCLITipComp>> and Letra = <<"'" + this.FormatearTextoSql( lxCONCLILetra ) + "'">> and ptoVta = <<lxCONCLIptoVta>> and num = <<lxCONCLInum>> and codcomp = <<"'" + this.FormatearTextoSql( lxCONCLIcodcomp ) + "'">>
			endtext
			use in select('c_CONSUMOCLIENTE')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CONSUMOCLIENTE', set( 'Datasession' ) )
			if reccount( 'c_CONSUMOCLIENTE' ) = 0
				llRetorno = .f.
			else
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxConcliCodigo as Variant
		llRetorno = .t.
		lxConcliCodigo = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.CONCLI where "Codigo" = <<"'" + this.FormatearTextoSql( lxConcliCodigo ) + "'">> and  CONCLI.CODIGO != ''
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
				lcOrden =  str( .tipoComprobante, 2, 0) + .Letra + str( .PuntoDeVenta, 4, 0) + str( .Numero, 8, 0) + .CodigoComprobante
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Signo" as "Signo", "Anul" as "Anulado", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Descfw" as "Descripcionfw", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Horaimpo" as "Horaimpo", "Smodifw" as "Seriemodificacionfw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Db" as "Basededatos", "Codcomp" as "Codigocomprobante", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Codigo" as "Codigo", "Limconsumo" as "Limiteconsumo", "Cliente" as "Cliente", "Tipcomp" as "Tipocomprobante", "Letra" as "Letra", "Ptovta" as "Puntodeventa", "Num" as "Numero", "Feccomp" as "Fechacomp", "Monto" as "Monto", "Obs" as "Observacion" from ZooLogic.CONCLI where  CONCLI.CODIGO != '' order by TipComp,Letra,ptoVta,num,codcomp
			endtext
			use in select('c_CONSUMOCLIENTE')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CONSUMOCLIENTE', set( 'Datasession' ) )
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
				lcOrden =  str( .tipoComprobante, 2, 0) + .Letra + str( .PuntoDeVenta, 4, 0) + str( .Numero, 8, 0) + .CodigoComprobante
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Signo" as "Signo", "Anul" as "Anulado", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Descfw" as "Descripcionfw", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Horaimpo" as "Horaimpo", "Smodifw" as "Seriemodificacionfw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Db" as "Basededatos", "Codcomp" as "Codigocomprobante", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Codigo" as "Codigo", "Limconsumo" as "Limiteconsumo", "Cliente" as "Cliente", "Tipcomp" as "Tipocomprobante", "Letra" as "Letra", "Ptovta" as "Puntodeventa", "Num" as "Numero", "Feccomp" as "Fechacomp", "Monto" as "Monto", "Obs" as "Observacion" from ZooLogic.CONCLI where  str( TipComp, 2, 0) + funciones.padr( Letra, 1, ' ' ) + str( ptoVta, 4, 0) + str( num, 8, 0) + funciones.padr( codcomp, 38, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  CONCLI.CODIGO != '' order by TipComp,Letra,ptoVta,num,codcomp
			endtext
			use in select('c_CONSUMOCLIENTE')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CONSUMOCLIENTE', set( 'Datasession' ) )
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
				lcOrden =  str( .tipoComprobante, 2, 0) + .Letra + str( .PuntoDeVenta, 4, 0) + str( .Numero, 8, 0) + .CodigoComprobante
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Signo" as "Signo", "Anul" as "Anulado", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Descfw" as "Descripcionfw", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Horaimpo" as "Horaimpo", "Smodifw" as "Seriemodificacionfw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Db" as "Basededatos", "Codcomp" as "Codigocomprobante", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Codigo" as "Codigo", "Limconsumo" as "Limiteconsumo", "Cliente" as "Cliente", "Tipcomp" as "Tipocomprobante", "Letra" as "Letra", "Ptovta" as "Puntodeventa", "Num" as "Numero", "Feccomp" as "Fechacomp", "Monto" as "Monto", "Obs" as "Observacion" from ZooLogic.CONCLI where  str( TipComp, 2, 0) + funciones.padr( Letra, 1, ' ' ) + str( ptoVta, 4, 0) + str( num, 8, 0) + funciones.padr( codcomp, 38, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  CONCLI.CODIGO != '' order by TipComp desc,Letra desc,ptoVta desc,num desc,codcomp desc
			endtext
			use in select('c_CONSUMOCLIENTE')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CONSUMOCLIENTE', set( 'Datasession' ) )
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
				lcOrden =  str( .tipoComprobante, 2, 0) + .Letra + str( .PuntoDeVenta, 4, 0) + str( .Numero, 8, 0) + .CodigoComprobante
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Signo" as "Signo", "Anul" as "Anulado", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Descfw" as "Descripcionfw", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Horaimpo" as "Horaimpo", "Smodifw" as "Seriemodificacionfw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Db" as "Basededatos", "Codcomp" as "Codigocomprobante", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Codigo" as "Codigo", "Limconsumo" as "Limiteconsumo", "Cliente" as "Cliente", "Tipcomp" as "Tipocomprobante", "Letra" as "Letra", "Ptovta" as "Puntodeventa", "Num" as "Numero", "Feccomp" as "Fechacomp", "Monto" as "Monto", "Obs" as "Observacion" from ZooLogic.CONCLI where  CONCLI.CODIGO != '' order by TipComp desc,Letra desc,ptoVta desc,num desc,codcomp desc
			endtext
			use in select('c_CONSUMOCLIENTE')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CONSUMOCLIENTE', set( 'Datasession' ) )
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
			lcXml = this.oConexion.EjecutarSql( "select Fecexpo,Faltafw,Fecimpo,Fmodifw,Fectrans,Signo,Anul,Hmodifw,Saltafw,Umodifw,Zadsfw,Descfw,Vm" + ;
"odifw,Valtafw,Ualtafw,Horaimpo,Smodifw,Esttrans,Horaexpo,Db,Codcomp,Haltafw,Bdaltafw,Bdmodifw,Codigo" + ;
",Limconsumo,Cliente,Tipcomp,Letra,Ptovta,Num,Feccomp,Monto,Obs" + ;
" from ZooLogic.CONCLI where  CONCLI.CODIGO != '' and " + lcFiltro )
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
			local  lxConcliFecexpo, lxConcliFaltafw, lxConcliFecimpo, lxConcliFmodifw, lxConcliFectrans, lxConcliSigno, lxConcliAnul, lxConcliHmodifw, lxConcliSaltafw, lxConcliUmodifw, lxConcliZadsfw, lxConcliDescfw, lxConcliVmodifw, lxConcliValtafw, lxConcliUaltafw, lxConcliHoraimpo, lxConcliSmodifw, lxConcliEsttrans, lxConcliHoraexpo, lxConcliDb, lxConcliCodcomp, lxConcliHaltafw, lxConcliBdaltafw, lxConcliBdmodifw, lxConcliCodigo, lxConcliLimconsumo, lxConcliCliente, lxConcliTipcomp, lxConcliLetra, lxConcliPtovta, lxConcliNum, lxConcliFeccomp, lxConcliMonto, lxConcliObs
				lxConcliFecexpo = ctod( '  /  /    ' )			lxConcliFaltafw = ctod( '  /  /    ' )			lxConcliFecimpo = ctod( '  /  /    ' )			lxConcliFmodifw = ctod( '  /  /    ' )			lxConcliFectrans = ctod( '  /  /    ' )			lxConcliSigno = 0			lxConcliAnul = .F.			lxConcliHmodifw = []			lxConcliSaltafw = []			lxConcliUmodifw = []			lxConcliZadsfw = []			lxConcliDescfw = []			lxConcliVmodifw = []			lxConcliValtafw = []			lxConcliUaltafw = []			lxConcliHoraimpo = []			lxConcliSmodifw = []			lxConcliEsttrans = []			lxConcliHoraexpo = []			lxConcliDb = []			lxConcliCodcomp = []			lxConcliHaltafw = []			lxConcliBdaltafw = []			lxConcliBdmodifw = []			lxConcliCodigo = []			lxConcliLimconsumo = []			lxConcliCliente = []			lxConcliTipcomp = 0			lxConcliLetra = []			lxConcliPtovta = 0			lxConcliNum = 0			lxConcliFeccomp = ctod( '  /  /    ' )			lxConcliMonto = 0			lxConcliObs = []
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( [delete from ZooLogic.CONCLI where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'CONCLI' + '_' + tcCampo
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
		lcWhere = " Where  CONCLI.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Signo" as "Signo", "Anul" as "Anulado", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Descfw" as "Descripcionfw", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Horaimpo" as "Horaimpo", "Smodifw" as "Seriemodificacionfw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Db" as "Basededatos", "Codcomp" as "Codigocomprobante", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Codigo" as "Codigo", "Limconsumo" as "Limiteconsumo", "Cliente" as "Cliente", "Tipcomp" as "Tipocomprobante", "Letra" as "Letra", "Ptovta" as "Puntodeventa", "Num" as "Numero", "Feccomp" as "Fechacomp", "Monto" as "Monto", "Obs" as "Observacion"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'CONCLI', '', tnTope )
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
				Case lcAtributo == 'FECHAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECEXPO AS FECHAEXPO'
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'FECHAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECIMPO AS FECHAIMPO'
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'FECHATRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRANS AS FECHATRANSFERENCIA'
				Case lcAtributo == 'SIGNO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SIGNO AS SIGNO'
				Case lcAtributo == 'ANULADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ANUL AS ANULADO'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
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
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'BASEDEDATOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DB AS BASEDEDATOS'
				Case lcAtributo == 'CODIGOCOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODCOMP AS CODIGOCOMPROBANTE'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'LIMITECONSUMO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LIMCONSUMO AS LIMITECONSUMO'
				Case lcAtributo == 'CLIENTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLIENTE AS CLIENTE'
				Case lcAtributo == 'TIPOCOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPCOMP AS TIPOCOMPROBANTE'
				Case lcAtributo == 'LETRA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LETRA AS LETRA'
				Case lcAtributo == 'PUNTODEVENTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PTOVTA AS PUNTODEVENTA'
				Case lcAtributo == 'NUMERO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NUM AS NUMERO'
				Case lcAtributo == 'FECHACOMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECCOMP AS FECHACOMP'
				Case lcAtributo == 'MONTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONTO AS MONTO'
				Case lcAtributo == 'OBSERVACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'OBS AS OBSERVACION'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoEntidad( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEXPO'
				lcCampo = 'FECEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAIMPO'
				lcCampo = 'FECIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'SIGNO'
				lcCampo = 'SIGNO'
			Case upper( alltrim( tcAtributo ) ) == 'ANULADO'
				lcCampo = 'ANUL'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
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
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOS'
				lcCampo = 'DB'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGOCOMPROBANTE'
				lcCampo = 'CODCOMP'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'LIMITECONSUMO'
				lcCampo = 'LIMCONSUMO'
			Case upper( alltrim( tcAtributo ) ) == 'CLIENTE'
				lcCampo = 'CLIENTE'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOCOMPROBANTE'
				lcCampo = 'TIPCOMP'
			Case upper( alltrim( tcAtributo ) ) == 'LETRA'
				lcCampo = 'LETRA'
			Case upper( alltrim( tcAtributo ) ) == 'PUNTODEVENTA'
				lcCampo = 'PTOVTA'
			Case upper( alltrim( tcAtributo ) ) == 'NUMERO'
				lcCampo = 'NUM'
			Case upper( alltrim( tcAtributo ) ) == 'FECHACOMP'
				lcCampo = 'FECCOMP'
			Case upper( alltrim( tcAtributo ) ) == 'MONTO'
				lcCampo = 'MONTO'
			Case upper( alltrim( tcAtributo ) ) == 'OBSERVACION'
				lcCampo = 'OBS'
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
			local  lxConcliFecexpo, lxConcliFaltafw, lxConcliFecimpo, lxConcliFmodifw, lxConcliFectrans, lxConcliSigno, lxConcliAnul, lxConcliHmodifw, lxConcliSaltafw, lxConcliUmodifw, lxConcliZadsfw, lxConcliDescfw, lxConcliVmodifw, lxConcliValtafw, lxConcliUaltafw, lxConcliHoraimpo, lxConcliSmodifw, lxConcliEsttrans, lxConcliHoraexpo, lxConcliDb, lxConcliCodcomp, lxConcliHaltafw, lxConcliBdaltafw, lxConcliBdmodifw, lxConcliCodigo, lxConcliLimconsumo, lxConcliCliente, lxConcliTipcomp, lxConcliLetra, lxConcliPtovta, lxConcliNum, lxConcliFeccomp, lxConcliMonto, lxConcliObs
				lxConcliFecexpo =  .Fechaexpo			lxConcliFaltafw =  .Fechaaltafw			lxConcliFecimpo =  .Fechaimpo			lxConcliFmodifw =  .Fechamodificacionfw			lxConcliFectrans =  .Fechatransferencia			lxConcliSigno =  .Signo			lxConcliAnul =  .Anulado			lxConcliHmodifw =  .Horamodificacionfw			lxConcliSaltafw =  .Seriealtafw			lxConcliUmodifw =  .Usuariomodificacionfw			lxConcliZadsfw =  .Zadsfw			lxConcliDescfw =  .Descripcionfw			lxConcliVmodifw =  .Versionmodificacionfw			lxConcliValtafw =  .Versionaltafw			lxConcliUaltafw =  .Usuarioaltafw			lxConcliHoraimpo =  .Horaimpo			lxConcliSmodifw =  .Seriemodificacionfw			lxConcliEsttrans =  .Estadotransferencia			lxConcliHoraexpo =  .Horaexpo			lxConcliDb =  .Basededatos			lxConcliCodcomp =  .Codigocomprobante			lxConcliHaltafw =  .Horaaltafw			lxConcliBdaltafw =  .Basededatosaltafw			lxConcliBdmodifw =  .Basededatosmodificacionfw			lxConcliCodigo =  .Codigo			lxConcliLimconsumo =  upper( .LimiteConsumo_PK ) 			lxConcliCliente =  .Cliente			lxConcliTipcomp =  .Tipocomprobante			lxConcliLetra =  .Letra			lxConcliPtovta =  .Puntodeventa			lxConcliNum =  .Numero			lxConcliFeccomp =  .Fechacomp			lxConcliMonto =  .Monto			lxConcliObs =  .Observacion
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.CONCLI ( "Fecexpo","Faltafw","Fecimpo","Fmodifw","Fectrans","Signo","Anul","Hmodifw","Saltafw","Umodifw","Zadsfw","Descfw","Vmodifw","Valtafw","Ualtafw","Horaimpo","Smodifw","Esttrans","Horaexpo","Db","Codcomp","Haltafw","Bdaltafw","Bdmodifw","Codigo","Limconsumo","Cliente","Tipcomp","Letra","Ptovta","Num","Feccomp","Monto","Obs" ) values ( <<"'" + this.ConvertirDateSql( lxConcliFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxConcliFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxConcliFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxConcliFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxConcliFectrans ) + "'" >>, <<lxConcliSigno >>, <<iif( lxConcliAnul, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxConcliHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxConcliSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxConcliUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxConcliZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxConcliDescfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxConcliVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxConcliValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxConcliUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxConcliHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxConcliSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxConcliEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxConcliHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxConcliDb ) + "'" >>, <<"'" + this.FormatearTextoSql( lxConcliCodcomp ) + "'" >>, <<"'" + this.FormatearTextoSql( lxConcliHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxConcliBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxConcliBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxConcliCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxConcliLimconsumo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxConcliCliente ) + "'" >>, <<lxConcliTipcomp >>, <<"'" + this.FormatearTextoSql( lxConcliLetra ) + "'" >>, <<lxConcliPtovta >>, <<lxConcliNum >>, <<"'" + this.ConvertirDateSql( lxConcliFeccomp ) + "'" >>, <<lxConcliMonto >>, <<"'" + this.FormatearTextoSql( lxConcliObs ) + "'" >> )
		endtext
		loColeccion.cTabla = 'CONCLI' 
		loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		With this
			local lcValorClavePrimariaString as String
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcSentencia = this.ObtenerSentenciasInsertAuditoria()
			loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		EndWith
		return loColeccion
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasUpdate() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcFiltro as string, loItem as object, lcSentencia as string, lcSentencia as string
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxConcliFecexpo, lxConcliFaltafw, lxConcliFecimpo, lxConcliFmodifw, lxConcliFectrans, lxConcliSigno, lxConcliAnul, lxConcliHmodifw, lxConcliSaltafw, lxConcliUmodifw, lxConcliZadsfw, lxConcliDescfw, lxConcliVmodifw, lxConcliValtafw, lxConcliUaltafw, lxConcliHoraimpo, lxConcliSmodifw, lxConcliEsttrans, lxConcliHoraexpo, lxConcliDb, lxConcliCodcomp, lxConcliHaltafw, lxConcliBdaltafw, lxConcliBdmodifw, lxConcliCodigo, lxConcliLimconsumo, lxConcliCliente, lxConcliTipcomp, lxConcliLetra, lxConcliPtovta, lxConcliNum, lxConcliFeccomp, lxConcliMonto, lxConcliObs
				lxConcliFecexpo =  .Fechaexpo			lxConcliFaltafw =  .Fechaaltafw			lxConcliFecimpo =  .Fechaimpo			lxConcliFmodifw =  .Fechamodificacionfw			lxConcliFectrans =  .Fechatransferencia			lxConcliSigno =  .Signo			lxConcliAnul =  .Anulado			lxConcliHmodifw =  .Horamodificacionfw			lxConcliSaltafw =  .Seriealtafw			lxConcliUmodifw =  .Usuariomodificacionfw			lxConcliZadsfw =  .Zadsfw			lxConcliDescfw =  .Descripcionfw			lxConcliVmodifw =  .Versionmodificacionfw			lxConcliValtafw =  .Versionaltafw			lxConcliUaltafw =  .Usuarioaltafw			lxConcliHoraimpo =  .Horaimpo			lxConcliSmodifw =  .Seriemodificacionfw			lxConcliEsttrans =  .Estadotransferencia			lxConcliHoraexpo =  .Horaexpo			lxConcliDb =  .Basededatos			lxConcliCodcomp =  .Codigocomprobante			lxConcliHaltafw =  .Horaaltafw			lxConcliBdaltafw =  .Basededatosaltafw			lxConcliBdmodifw =  .Basededatosmodificacionfw			lxConcliCodigo =  .Codigo			lxConcliLimconsumo =  upper( .LimiteConsumo_PK ) 			lxConcliCliente =  .Cliente			lxConcliTipcomp =  .Tipocomprobante			lxConcliLetra =  .Letra			lxConcliPtovta =  .Puntodeventa			lxConcliNum =  .Numero			lxConcliFeccomp =  .Fechacomp			lxConcliMonto =  .Monto			lxConcliObs =  .Observacion
		endwith
		With this
			local llInsertarAuditoria as Boolean
			llInsertarAuditoria = (  .oEntidad.oAtributosAuditoria.BaseDeDatos != .oEntidad.BaseDeDatos or  .oEntidad.oAtributosAuditoria.LimiteConsumo != .oEntidad.LimiteConsumo_Pk or  .oEntidad.oAtributosAuditoria.Cliente != .oEntidad.Cliente or  this.ConvertirDateSql( .oEntidad.oAtributosAuditoria.FechaComp) != this.ConvertirDateSql( .oEntidad.FechaComp) or  .oEntidad.oAtributosAuditoria.monto != .oEntidad.monto )
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  CONCLI.CODIGO != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.CONCLI set "Fecexpo" = <<"'" + this.ConvertirDateSql( lxConcliFecexpo ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxConcliFaltafw ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxConcliFecimpo ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxConcliFmodifw ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxConcliFectrans ) + "'">>, "Signo" = <<lxConcliSigno>>, "Anul" = <<iif( lxConcliAnul, 1, 0 )>>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxConcliHmodifw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxConcliSaltafw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxConcliUmodifw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxConcliZadsfw ) + "'">>, "Descfw" = <<"'" + this.FormatearTextoSql( lxConcliDescfw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxConcliVmodifw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxConcliValtafw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxConcliUaltafw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxConcliHoraimpo ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxConcliSmodifw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxConcliEsttrans ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxConcliHoraexpo ) + "'">>, "Db" = <<"'" + this.FormatearTextoSql( lxConcliDb ) + "'">>, "Codcomp" = <<"'" + this.FormatearTextoSql( lxConcliCodcomp ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxConcliHaltafw ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxConcliBdaltafw ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxConcliBdmodifw ) + "'">>, "Codigo" = <<"'" + this.FormatearTextoSql( lxConcliCodigo ) + "'">>, "Limconsumo" = <<"'" + this.FormatearTextoSql( lxConcliLimconsumo ) + "'">>, "Cliente" = <<"'" + this.FormatearTextoSql( lxConcliCliente ) + "'">>, "Tipcomp" = <<lxConcliTipcomp>>, "Letra" = <<"'" + this.FormatearTextoSql( lxConcliLetra ) + "'">>, "Ptovta" = <<lxConcliPtovta>>, "Num" = <<lxConcliNum>>, "Feccomp" = <<"'" + this.ConvertirDateSql( lxConcliFeccomp ) + "'">>, "Monto" = <<lxConcliMonto>>, "Obs" = <<"'" + this.FormatearTextoSql( lxConcliObs ) + "'">> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'CONCLI' 
		loColeccion.agregar( strtran(  lcSentencia, chr( 9 ), '' ) )
		If llInsertarAuditoria
			lcSentencia = this.ObtenerSentenciasInsertAuditoria()
			loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		EndIf
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

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  CONCLI.CODIGO != '']
		loColeccion.Agregar( 'delete from ZooLogic.CONCLI where ' + lcFiltro )
			loColeccion.cTabla = 'CONCLI' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.CONCLI where  CONCLI.CODIGO != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.CONCLI where Codigo = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  CONCLI.CODIGO != ''" )
			this.xmlacursor( lcXml, lcCursor )
		if reccount( lcCursor ) > 0
			lnTimeStamp = &lcCursor..Timestamp
		endif
		use in select( lcCursor )

		return lnTimeStamp 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirCabecera( tlLoguear as Boolean ) As Void
		local lcCursor as String, ldFecha as Date, lcHora as string, lcValorABuscar As String, lxValorClavePK As variant, lxValorClavePrimaria As variant, lcIdentificadorParaLoguear as string, lxCONCLIdb as variant, lxCONCLIcodcomp as variant, lxCONCLIlimConsumo as variant, lxCONCLIcliente as variant, lxCONCLITipComp as variant, lxCONCLILetra as variant, lxCONCLIptoVta as variant, lxCONCLInum as variant, lxCONCLIFecComp as variant, lxCONCLImonto as variant, lcMensajeExtra as String
		lcValorABuscar = ''
		lxValorClavePK = ''
		lcMensajeExtra = ''
		lcCursor = This.oEntidad.cPrefijoRecibir + 'CONSUMOCLIENTE'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.CONCLI Where  TipComp = ] + transform( &lcCursor..TipComp    ) + [ and Letra = ] + "'" + this.FormatearTextoSql( &lcCursor..Letra      ) + "'" + [ and ptoVta = ] + transform( &lcCursor..ptoVta     ) + [ and num = ] + transform( &lcCursor..num        ) + [ and codcomp = ] + "'" + this.FormatearTextoSql( &lcCursor..codcomp    ) + "'", 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				lxValorClavePK = &lcCursor..Codigo
				if lxValorClavePK == curSeek.Codigo or this.oEntidad.lIgnorarClaveprimariaEnRecepcionBD 
					if lxValorClavePK != curSeek.Codigo and this.oEntidad.lIgnorarClaveprimariaEnRecepcionBD 
						lcValorABuscar = curSeek.Codigo
					else 
						lcValorABuscar = lxValorClavePK 
					endif 
					if This.ActualizaEnRecepcion() 
						local llInsertarAuditoria as boolean
						llInsertarAuditoria = (  iif( isnull( curSeek.db != &lcCursor..db ), .F., curSeek.db != &lcCursor..db ) or  iif( isnull( curSeek.limConsumo != &lcCursor..limConsumo ), .F., curSeek.limConsumo != &lcCursor..limConsumo ) or  iif( isnull( curSeek.cliente != &lcCursor..cliente ), .F., curSeek.cliente != &lcCursor..cliente ) or  iif( isnull( ( curSeek.FecComp != &lcCursor..FecComp ) and ( !empty( goServicios.Librerias.ObtenerFechaFormateada( curSeek.FecComp ) ) or !empty( goServicios.Librerias.ObtenerFechaFormateada( &lcCursor..FecComp ) ) ) ), .F., ( curSeek.FecComp != &lcCursor..FecComp ) and ( !empty( goServicios.Librerias.ObtenerFechaFormateada( curSeek.FecComp ) ) or !empty( goServicios.Librerias.ObtenerFechaFormateada( &lcCursor..FecComp ) ) ) ) or  iif( isnull( curSeek.monto != &lcCursor..monto ), .F., curSeek.monto != &lcCursor..monto ) )
						Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
						this.oConexion.EjecutarSql( [UPDATE ZooLogic.CONCLI set  FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, signo = ] + transform( &lcCursor..signo )+ [, anul = ] + Transform( iif( &lcCursor..anul, 1, 0 ))+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, DescFW = ] + "'" + this.FormatearTextoSql( &lcCursor..DescFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, db = ] + "'" + this.FormatearTextoSql( &lcCursor..db ) + "'"+ [, codcomp = ] + "'" + this.FormatearTextoSql( &lcCursor..codcomp ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'"+ [, limConsumo = ] + "'" + this.FormatearTextoSql( &lcCursor..limConsumo ) + "'"+ [, cliente = ] + "'" + this.FormatearTextoSql( &lcCursor..cliente ) + "'"+ [, TipComp = ] + transform( &lcCursor..TipComp )+ [, Letra = ] + "'" + this.FormatearTextoSql( &lcCursor..Letra ) + "'"+ [, ptoVta = ] + transform( &lcCursor..ptoVta )+ [, num = ] + transform( &lcCursor..num )+ [, FecComp = ] + "'" + this.ConvertirDateSql( &lcCursor..FecComp ) + "'"+ [, monto = ] + transform( &lcCursor..monto )+ [, obs = ] + "'" + this.FormatearTextoSql( &lcCursor..obs ) + "'" + [ Where Codigo = ] + "'" + this.FormatearTextoSql( lcValorABuscar ) + "'" )
						this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
						if llInsertarAuditoria
							lcSentencia = this.ObtenerSentenciasInsertAuditoria( lcCursor )
							this.oConexion.EjecutarSql( lcSentencia )
						EndIf
					else
						this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
					endIf
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir porque no coincide la clave principal.', tlLoguear )
				endIf
			else
				this.oConexion.EjecutarSql( [Select * From ZooLogic.CONCLI Where Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'", 'curSeek', this.datasessionid )
				if reccount( 'curSeek' ) > 0
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir como alta porque la clave principal ya existe', tlLoguear )
				Else
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					Text to lcCampos noShow
						 FECEXPO, FALTAFW, FECIMPO, FMODIFW, FECTRANS, signo, anul, HMODIFW, SALTAFW, UMODIFW, ZADSFW, DescFW, VMODIFW, VALTAFW, UALTAFW, HORAIMPO, SMODIFW, ESTTRANS, HORAEXPO, db, codcomp, HALTAFW, BDALTAFW, BDMODIFW, Codigo, limConsumo, cliente, TipComp, Letra, ptoVta, num, FecComp, monto, obs
					EndText
					local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + transform( &lcCursor..signo ) + ',' + Transform( iif( &lcCursor..anul, 1, 0 ))
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..DescFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..db ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..codcomp ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..limConsumo ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..cliente ) + "'" + ',' + transform( &lcCursor..TipComp )
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..Letra ) + "'" + ',' + transform( &lcCursor..ptoVta ) + ',' + transform( &lcCursor..num ) + ',' + "'" + this.ConvertirDateSql( &lcCursor..FecComp ) + "'" + ',' + transform( &lcCursor..monto ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..obs ) + "'"
lcValoresCampos = substr(lcValoresCampos,2) 

					this.oConexion.EjecutarSql( [Insert into ZooLogic.CONCLI ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
					lcSentencia = this.ObtenerSentenciasInsertAuditoria( lcCursor )
					this.oConexion.EjecutarSql( lcSentencia )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
				EndIf
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'CONSUMOCLIENTE'
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
		lcRetorno = lcRetorno + ' - Tipo comprobante: ' + transform( &tcCursor..TipComp    )
		lcRetorno = lcRetorno + ' - Letra: ' + transform( &tcCursor..Letra      )
		lcRetorno = lcRetorno + ' - Punto de Venta: ' + transform( &tcCursor..ptoVta     )
		lcRetorno = lcRetorno + ' - Número: ' + transform( &tcCursor..num        )
		Return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EsAliasDeProceso( tcAlias As String, tcPrefijo as string ) As Boolean
		local llRetorno as Boolean, lcAlias as String, lcPrefijo As String
		llRetorno = .F.
		lcAlias = upper( alltrim( tcAlias ) )
		lcPrefijo = upper( alltrim( tcPrefijo ) )
		Do Case
			Case  lcAlias == lcPrefijo + 'CONSUMOCLIENTE'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'CONSUMOCLIENTE_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'CONSUMOCLIENTE_OBS'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_CONCLI')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'CONSUMOCLIENTE'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..Codigo
		llCondicion = isnull( lxVar ) or isnull( &lcCursor..TipComp ) or isnull( &lcCursor..Letra ) or isnull( &lcCursor..ptoVta ) or isnull( &lcCursor..num ) or isnull( &lcCursor..codcomp )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad CONSUMOCLIENTE. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'CONSUMOCLIENTE'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		select recno() as _Rec, * from &lcCursor into cursor CurConRecno
		select max( _Rec ) as Maximo,Codigo as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( Codigo, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		select max( _Rec ) as Maximo,str( TipComp, 2, 0) + Letra + str( ptoVta, 4, 0) + str( num, 8, 0) + codcomp as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( str( TipComp, 2, 0) + Letra + str( ptoVta, 4, 0) + str( num, 8, 0) + codcomp, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		Use in select( 'CurConRecno' )
		Use in select( 'RepMax' )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDatosInvalidos( toConexion as Object ) as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'CONSUMOCLIENTE'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FecComp   
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_CONCLI') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_CONCLI
Create Table ZooLogic.TablaTrabajo_CONCLI ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fecexpo" datetime  null, 
"faltafw" datetime  null, 
"fecimpo" datetime  null, 
"fmodifw" datetime  null, 
"fectrans" datetime  null, 
"signo" numeric( 2, 0 )  null, 
"anul" bit  null, 
"hmodifw" char( 8 )  null, 
"saltafw" char( 7 )  null, 
"umodifw" char( 100 )  null, 
"zadsfw" varchar(max)  null, 
"descfw" char( 200 )  null, 
"vmodifw" char( 13 )  null, 
"valtafw" char( 13 )  null, 
"ualtafw" char( 100 )  null, 
"horaimpo" char( 8 )  null, 
"smodifw" char( 7 )  null, 
"esttrans" char( 20 )  null, 
"horaexpo" char( 8 )  null, 
"db" char( 8 )  null, 
"codcomp" char( 38 )  null, 
"haltafw" char( 8 )  null, 
"bdaltafw" char( 8 )  null, 
"bdmodifw" char( 8 )  null, 
"codigo" char( 38 )  null, 
"limconsumo" char( 38 )  null, 
"cliente" char( 5 )  null, 
"tipcomp" numeric( 2, 0 )  null, 
"letra" char( 1 )  null, 
"ptovta" numeric( 4, 0 )  null, 
"num" numeric( 8, 0 )  null, 
"feccomp" datetime  null, 
"monto" numeric( 16, 2 )  null, 
"obs" varchar(max)  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_CONCLI' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_CONCLI' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'CONSUMOCLIENTE'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		with loManejador
			if this.oEntidad.VerificarContexto( 'CB' )
			else
				.AgregarMapeo('Nrolinea','Nrolinea')
			endif
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('signo','signo')
			.AgregarMapeo('anul','anul')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('descfw','descfw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('db','db')
			.AgregarMapeo('codcomp','codcomp')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('codigo','codigo')
			.AgregarMapeo('limconsumo','limconsumo')
			.AgregarMapeo('cliente','cliente')
			.AgregarMapeo('tipcomp','tipcomp')
			.AgregarMapeo('letra','letra')
			.AgregarMapeo('ptovta','ptovta')
			.AgregarMapeo('num','num')
			.AgregarMapeo('feccomp','feccomp')
			.AgregarMapeo('monto','monto')
			.AgregarMapeo('obs','obs')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_CONCLI'
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
		Local lcCabecera1 as string, lcCabecera2 as string, lcCabecera3 as string, lcCabecera4 as string, lcCabecera5 as string, lcCabecera6 as string, lcCabecera7 as string, lcCabecera8 as string, lcCabecera9 as string
		lcCabecera1 = "replace( newId(),'-','1' )"
		lcCabecera2 = "'" + this.ConvertirDateSql( golibrerias.obtenerfechaformateada( golibrerias.obtenerfecha() ) ) + "'"
		lcCabecera3 = "'" + this.FormatearTextoSql( golibrerias.obtenerhora() ) + "'"
		lcCabecera4 = "'" + this.FormatearTextoSql( alltrim( _screen.zoo.app.cSerie ) ) + "'"
		lcCabecera5 = "'" + this.FormatearTextoSql( goServicios.Seguridad.cUsuarioLogueado ) + "'"
		lcCabecera6 = "'" + this.FormatearTextoSql( this.oEntidad.ObtenerNombre() ) + "'"
		lcCabecera7 = "'" + this.FormatearTextoSql( alltrim('1.00') ) + "'"
		lcCabecera8 = "'" + this.FormatearTextoSql( _Screen.zoo.app.obtenerversion() ) + "'"
		lcCabecera9 = iif( .F., 1, 0 )
		
		Text to lcCadena noshow textmerge
			CREATE TRIGGER ZooLogic.DELETE_<<lcTabla>>
				ON ZooLogic.<<lcTabla>>
				AFTER DELETE
			As
			Begin
				insert into ZooLogic.ADT_CONCLI ( "ADT_Cod","ADT_Fecha","ADT_Hora","ADT_Serie","ADT_Usr","ADT_Ent","ADT_Comp","ADT_ADN","ADT_Vers","ADT_Ext","codcomp","Codigo","TipComp","Letra","ptoVta","num","Db","Limconsumo","Cliente","Feccomp","Monto" ) 
					Select <<lcCabecera1>>, <<lcCabecera2>>, <<lcCabecera3>>, <<lcCabecera4>>, <<lcCabecera5>>, <<lcCabecera6>>, case when funciones.empty( d.DescFw ) = 1 then 'IMPORTACION' else d.descFw end, <<lcCabecera7>>, <<lcCabecera8>>, <<lcCabecera9>>, d.Codcomp,d.Codigo,d.Tipcomp,d.Letra,d.Ptovta,d.Num,Isnull( d.Db,t.Db),Isnull( d.Limconsumo,t.Limconsumo),Isnull( d.Cliente,t.Cliente),Isnull( d.Feccomp,t.Feccomp),Isnull( d.Monto,t.Monto)
						from ZooLogic.CONCLI t inner join deleted d 
							 on t.Codigo = d.Codigo
							 and  t.TipComp = d.TipComp
							 and  t.Letra = d.Letra
							 and  t.ptoVta = d.ptoVta
							 and  t.num = d.num
							 and  t.codcomp = d.codcomp
					where ( d.db is not null and d.db <> t.db ) or ( d.limConsumo is not null and d.limConsumo <> t.limConsumo ) or ( d.cliente is not null and d.cliente <> t.cliente ) or ( d.FecComp is not null and d.FecComp <> t.FecComp ) or ( d.monto is not null and d.monto <> t.monto )
				Update t Set t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.SIGNO = isnull( d.SIGNO, t.SIGNO ),t.ANUL = isnull( d.ANUL, t.ANUL ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.DESCFW = isnull( d.DESCFW, t.DESCFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.DB = isnull( d.DB, t.DB ),t.CODCOMP = isnull( d.CODCOMP, t.CODCOMP ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.CODIGO = isnull( d.CODIGO, t.CODIGO ),t.LIMCONSUMO = isnull( d.LIMCONSUMO, t.LIMCONSUMO ),t.CLIENTE = isnull( d.CLIENTE, t.CLIENTE ),t.TIPCOMP = isnull( d.TIPCOMP, t.TIPCOMP ),t.LETRA = isnull( d.LETRA, t.LETRA ),t.PTOVTA = isnull( d.PTOVTA, t.PTOVTA ),t.NUM = isnull( d.NUM, t.NUM ),t.FECCOMP = isnull( d.FECCOMP, t.FECCOMP ),t.MONTO = isnull( d.MONTO, t.MONTO ),t.OBS = isnull( d.OBS, t.OBS )
					from ZooLogic.CONCLI t inner join deleted d 
							 on t.Codigo = d.Codigo
							 and  t.TipComp = d.TipComp
							 and  t.Letra = d.Letra
							 and  t.ptoVta = d.ptoVta
							 and  t.num = d.num
							 and  t.codcomp = d.codcomp
				-- Fin Updates
				insert into ZooLogic.ADT_CONCLI ( "ADT_Cod","ADT_Fecha","ADT_Hora","ADT_Serie","ADT_Usr","ADT_Ent","ADT_Comp","ADT_ADN","ADT_Vers","ADT_Ext","codcomp","Codigo","TipComp","Letra","ptoVta","num","Db","Limconsumo","Cliente","Feccomp","Monto" ) 
					Select <<lcCabecera1>>, <<lcCabecera2>>, <<lcCabecera3>>, <<lcCabecera4>>, <<lcCabecera5>>, <<lcCabecera6>>, case when funciones.empty( d.DescFw ) = 1 then 'IMPORTACION' else d.descFw end, <<lcCabecera7>>, <<lcCabecera8>>, <<lcCabecera9>>, d.Codcomp,d.Codigo,d.Tipcomp,d.Letra,d.Ptovta,d.Num,isnull( d.DB,''),isnull( d.LIMCONSUMO,''),isnull( d.CLIENTE,''),isnull( d.FECCOMP,''),isnull( d.MONTO,0)
						From deleted d left join ZooLogic.CONCLI pk 
							 on d.Codigo = pk.Codigo
						 left join ZooLogic.CONCLI cc 
							 on  d.TipComp = cc.TipComp
							 and  d.Letra = cc.Letra
							 and  d.ptoVta = cc.ptoVta
							 and  d.num = cc.num
							 and  d.codcomp = cc.codcomp
						Where pk.Codigo Is Null 
							 and cc.TipComp Is Null 
							 and cc.Letra Is Null 
							 and cc.ptoVta Is Null 
							 and cc.num Is Null 
							 and cc.codcomp Is Null 
				insert into ZooLogic.CONCLI(Fecexpo,Faltafw,Fecimpo,Fmodifw,Fectrans,Signo,Anul,Hmodifw,Saltafw,Umodifw,Zadsfw,Descfw,Vmodifw,Valtafw,Ualtafw,Horaimpo,Smodifw,Esttrans,Horaexpo,Db,Codcomp,Haltafw,Bdaltafw,Bdmodifw,Codigo,Limconsumo,Cliente,Tipcomp,Letra,Ptovta,Num,Feccomp,Monto,Obs)
					Select isnull( d.FECEXPO,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FECIMPO,''),isnull( d.FMODIFW,''),isnull( d.FECTRANS,''),isnull( d.SIGNO,0),isnull( d.ANUL,0),isnull( d.HMODIFW,''),isnull( d.SALTAFW,''),isnull( d.UMODIFW,''),isnull( d.ZADSFW,''),isnull( d.DESCFW,''),isnull( d.VMODIFW,''),isnull( d.VALTAFW,''),isnull( d.UALTAFW,''),isnull( d.HORAIMPO,''),isnull( d.SMODIFW,''),isnull( d.ESTTRANS,''),isnull( d.HORAEXPO,''),isnull( d.DB,''),isnull( d.CODCOMP,''),convert( char(8), getdate(), 108 ),isnull( d.BDALTAFW,''),isnull( d.BDMODIFW,''),isnull( d.CODIGO,''),isnull( d.LIMCONSUMO,''),isnull( d.CLIENTE,''),isnull( d.TIPCOMP,0),isnull( d.LETRA,''),isnull( d.PTOVTA,0),isnull( d.NUM,0),isnull( d.FECCOMP,''),isnull( d.MONTO,0),isnull( d.OBS,'')
						From deleted d left join ZooLogic.CONCLI pk 
							 on d.Codigo = pk.Codigo
						 left join ZooLogic.CONCLI cc 
							 on  d.TipComp = cc.TipComp
							 and  d.Letra = cc.Letra
							 and  d.ptoVta = cc.ptoVta
							 and  d.num = cc.num
							 and  d.codcomp = cc.codcomp
						Where pk.Codigo Is Null 
							 and cc.TipComp Is Null 
							 and cc.Letra Is Null 
							 and cc.ptoVta Is Null 
							 and cc.num Is Null 
							 and cc.codcomp Is Null 
				-- Fin Inserts
				Insert into ZooLogic.Logueos ( Fecha, Nivel, Logger, Accion, BaseDeDatos, 
					EstadoDelSistema, Aplicacion, Version, 
					Serie, Usuario, NombrePc, 
					UsuarioPc, OrigenLogueo, Mensaje, Excepcion)
				select GetDate(), 'INFO', '', 'Importación <<lcEntidad>>','<<loLogueo.BaseDatos>>',
					<<loLogueo.EstadoSistema>>,'<<loLogueo.Aplicacion>>','<<loLogueo.Version>>',
					'<<loLogueo.Serie>>','<<loLogueo.Usuario>>','<<loLogueo.NombrePc>>',
					'<<loLogueo.UsuarioPc>>','<<loLogueo.OrigenLogueo>>','No se pudo importar la entidad <<lcEntidad>>: TIPO COMPROBANTE ' + cast( d.TipComp as Varchar(2) ) + ', LETRA ' + cast( d.Letra as Varchar(1) ) + ', PUNTO DE VENTA ' + cast( d.ptoVta as Varchar(4) ) + ', NÚMERO ' + cast( d.num as Varchar(8) ) + ', CODIGO COMPROBANTE ' + cast( d.codcomp as Varchar(38) ) + '','La clave principal no es la esperada'
					from ZooLogic.CONCLI t inner join deleted d 
							on   t.TipComp = d.TipComp
							 and  t.Letra = d.Letra
							 and  t.ptoVta = d.ptoVta
							 and  t.num = d.num
							 and  t.codcomp = d.codcomp
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
					'<<loLogueo.UsuarioPc>>','<<loLogueo.OrigenLogueo>>','No se pudo importar la entidad <<lcEntidad>>: TIPO COMPROBANTE ' + cast( d.TipComp as Varchar(2) ) + ', LETRA ' + cast( d.Letra as Varchar(1) ) + ', PUNTO DE VENTA ' + cast( d.ptoVta as Varchar(4) ) + ', NÚMERO ' + cast( d.num as Varchar(8) ) + ', CODIGO COMPROBANTE ' + cast( d.codcomp as Varchar(38) ) + '','La clave principal a importar ya existe'
					from ZooLogic.CONCLI t inner join deleted d 
							 on t.Codigo = d.Codigo
						left join deleted h 
							on   t.TipComp = h.TipComp
							 and   t.Letra = h.Letra
							 and   t.ptoVta = h.ptoVta
							 and   t.num = h.num
							 and   t.codcomp = h.codcomp
							where   h.TipComp is null 
							 and   h.Letra is null 
							 and   h.ptoVta is null 
							 and   h.num is null 
							 and   h.codcomp is null 
			End
		EndText
		Return lcCadena
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	protected Function EliminarTablasDeTrabajo( toConexion as Object ) as void
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_CONCLI') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_CONCLI
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_CONSUMOCLIENTE' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_CONSUMOCLIENTE.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_CONSUMOCLIENTE.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_CONSUMOCLIENTE.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_CONSUMOCLIENTE.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_CONSUMOCLIENTE.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Signo = nvl( c_CONSUMOCLIENTE.Signo, 0 )
					.Anulado = nvl( c_CONSUMOCLIENTE.Anulado, .F. )
					.Horamodificacionfw = nvl( c_CONSUMOCLIENTE.Horamodificacionfw, [] )
					.Seriealtafw = nvl( c_CONSUMOCLIENTE.Seriealtafw, [] )
					.Usuariomodificacionfw = nvl( c_CONSUMOCLIENTE.Usuariomodificacionfw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Descripcionfw = nvl( c_CONSUMOCLIENTE.Descripcionfw, [] )
					.Versionmodificacionfw = nvl( c_CONSUMOCLIENTE.Versionmodificacionfw, [] )
					.Versionaltafw = nvl( c_CONSUMOCLIENTE.Versionaltafw, [] )
					.Usuarioaltafw = nvl( c_CONSUMOCLIENTE.Usuarioaltafw, [] )
					.Horaimpo = nvl( c_CONSUMOCLIENTE.Horaimpo, [] )
					.Seriemodificacionfw = nvl( c_CONSUMOCLIENTE.Seriemodificacionfw, [] )
					.Estadotransferencia = nvl( c_CONSUMOCLIENTE.Estadotransferencia, [] )
					.Horaexpo = nvl( c_CONSUMOCLIENTE.Horaexpo, [] )
					.Basededatos = nvl( c_CONSUMOCLIENTE.Basededatos, [] )
					.Codigocomprobante = nvl( c_CONSUMOCLIENTE.Codigocomprobante, [] )
					.Horaaltafw = nvl( c_CONSUMOCLIENTE.Horaaltafw, [] )
					.Basededatosaltafw = nvl( c_CONSUMOCLIENTE.Basededatosaltafw, [] )
					.Basededatosmodificacionfw = nvl( c_CONSUMOCLIENTE.Basededatosmodificacionfw, [] )
					.Codigo = nvl( c_CONSUMOCLIENTE.Codigo, [] )
					.Limiteconsumo_PK =  nvl( c_CONSUMOCLIENTE.Limiteconsumo, [] )
					.Cliente = nvl( c_CONSUMOCLIENTE.Cliente, [] )
					.Tipocomprobante = nvl( c_CONSUMOCLIENTE.Tipocomprobante, 0 )
					.Letra = nvl( c_CONSUMOCLIENTE.Letra, [] )
					.Puntodeventa = nvl( c_CONSUMOCLIENTE.Puntodeventa, 0 )
					.Numero = nvl( c_CONSUMOCLIENTE.Numero, 0 )
					.Fechacomp = GoLibrerias.ObtenerFechaFormateada( nvl( c_CONSUMOCLIENTE.Fechacomp, ctod( '  /  /    ' ) ) )
					.Monto = nvl( c_CONSUMOCLIENTE.Monto, 0 )
					lcValor = This.ObtenerMemo( 'c_Observacion')
					.Observacion = lcValor 
					Select c_CONSUMOCLIENTE
					scatter name This.oEntidad.oAtributosAuditoria
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
	*-----------------------------------------------------------------------------------------
	function ObtenerSentenciasInsertAuditoria( tcCursor as string ) as String
		if empty( tcCursor )
			local lcDescripcionFW as string
			lcDescripcionFW = this.oEntidad.DescripcionFW
		else
			local lcDescripcionFW as string
			lcDescripcionFW = &tcCursor..DescFW
		endif
		Local lcCabecera1 as string, lcCabecera2 as string, lcCabecera3 as string, lcCabecera4 as string, lcCabecera5 as string, lcCabecera6 as string, lcCabecera7 as string, lcCabecera8 as string, lcCabecera9 as string;
		, lcCabecera10 as string
		lcCabecera1 = "'" + this.FormatearTextoSql( goLibrerias.ObtenerGuidPk() ) + "'"
		lcCabecera2 = "'" + this.ConvertirDateSql( golibrerias.obtenerfechaformateada( golibrerias.obtenerfecha() ) ) + "'"
		lcCabecera3 = "'" + this.FormatearTextoSql( golibrerias.obtenerhora() ) + "'"
		lcCabecera4 = "'" + this.FormatearTextoSql( alltrim( _screen.zoo.app.cSerie ) ) + "'"
		lcCabecera5 = "'" + this.FormatearTextoSql( goServicios.Seguridad.cUsuarioLogueado ) + "'"
		lcCabecera6 = "'" + this.FormatearTextoSql( this.oEntidad.ObtenerNombre() ) + "'"
		lcCabecera7 = "'" + this.FormatearTextoSql( lcDescripcionFW ) + "'"
		lcCabecera8 = "'" + this.FormatearTextoSql( alltrim('1.00') ) + "'"
		lcCabecera9 = "'" + this.FormatearTextoSql( _Screen.zoo.app.obtenerversion() ) + "'"
		lcCabecera10 = iif( .F., 1, 0 )
		
		local lxValorClavePrimaria as variant
		if empty( tcCursor )
			lxValorClavePrimaria = this.oEntidad.CODIGO
			Local lcEntidad1 as string, lcEntidad2 as string, lcEntidad3 as string, lcEntidad4 as string, lcEntidad5 as string, lcEntidad6 as string, lcEntidad7 as string, lcEntidad8 as string, lcEntidad9 as string, lcEntidad10 as string;
			, lcEntidad11 as string
			lcEntidad1 = "'" + this.FormatearTextoSql( this.oEntidad.Codigocomprobante ) + "'"
			lcEntidad2 = "'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'"
			lcEntidad3 = transform( this.oEntidad.Tipocomprobante )
			lcEntidad4 = "'" + this.FormatearTextoSql( this.oEntidad.Letra ) + "'"
			lcEntidad5 = transform( this.oEntidad.Puntodeventa )
			lcEntidad6 = transform( this.oEntidad.Numero )
			lcEntidad7 = "'" + this.FormatearTextoSql( this.oEntidad.Basededatos ) + "'"
			lcEntidad8 = "'" + this.FormatearTextoSql( this.oEntidad.Limiteconsumo_pk ) + "'"
			lcEntidad9 = "'" + this.FormatearTextoSql( this.oEntidad.Cliente ) + "'"
			lcEntidad10 = "'" + this.ConvertirDateSql( this.oEntidad.Fechacomp ) + "'"
			lcEntidad11 = transform( this.oEntidad.Monto )
			
		else
			lxValorClavePrimaria = &tcCursor..Codigo
			Local lcEntidad1 as string, lcEntidad2 as string, lcEntidad3 as string, lcEntidad4 as string, lcEntidad5 as string, lcEntidad6 as string, lcEntidad7 as string, lcEntidad8 as string, lcEntidad9 as string, lcEntidad10 as string;
			, lcEntidad11 as string
			lcEntidad1 = "'" + this.FormatearTextoSql( &tcCursor..Codcomp ) + "'"
			lcEntidad2 = "'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'"
			lcEntidad3 = transform( &tcCursor..Tipcomp )
			lcEntidad4 = "'" + this.FormatearTextoSql( &tcCursor..Letra ) + "'"
			lcEntidad5 = transform( &tcCursor..Ptovta )
			lcEntidad6 = transform( &tcCursor..Num )
			lcEntidad7 = "'" + this.FormatearTextoSql( &tcCursor..Db ) + "'"
			lcEntidad8 = "'" + this.FormatearTextoSql( &tcCursor..Limconsumo ) + "'"
			lcEntidad9 = "'" + this.FormatearTextoSql( &tcCursor..Cliente ) + "'"
			lcEntidad10 = "'" + this.ConvertirDateSql( &tcCursor..Feccomp ) + "'"
			lcEntidad11 = transform( &tcCursor..Monto )
			
		endif
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.ADT_CONCLI ( "ADT_Cod","ADT_Fecha","ADT_Hora","ADT_Serie","ADT_Usr","ADT_Ent","ADT_Comp","ADT_ADN","ADT_Vers","ADT_Ext","codcomp","Codigo","TipComp","Letra","ptoVta","num","Db","Limconsumo","Cliente","Feccomp","Monto" ) values ( <<lcCabecera1>>, <<lcCabecera2>>, <<lcCabecera3>>, <<lcCabecera4>>, <<lcCabecera5>>, <<lcCabecera6>>, <<lcCabecera7>>, <<lcCabecera8>>, <<lcCabecera9>>, <<lcCabecera10>>, <<lcEntidad1>>, <<lcEntidad2>>, <<lcEntidad3>>, <<lcEntidad4>>, <<lcEntidad5>>, <<lcEntidad6>>, <<lcEntidad7>>, <<lcEntidad8>>, <<lcEntidad9>>, <<lcEntidad10>>, <<lcEntidad11>> ) 
			endtext
		return lcSentencia
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function ObtenerIdPorClaveCandidata() as variant
		local lxRetorno as Variant
		lxRetorno = ''
		if this.ConsultarPorClaveCandidata()
			lxRetorno = c_CONSUMOCLIENTE.CODIGO
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
		return c_CONSUMOCLIENTE.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.CONCLI' )
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
								from ZooLogic.CONCLI 
								Where   CONCLI.CODIGO != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "CONCLI", "", lcCursor, set("Datasession") )
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
			"Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Signo" as "Signo", "Anul" as "Anulado", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Descfw" as "Descripcionfw", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Horaimpo" as "Horaimpo", "Smodifw" as "Seriemodificacionfw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Db" as "Basededatos", "Codcomp" as "Codigocomprobante", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Codigo" as "Codigo", "Limconsumo" as "Limiteconsumo", "Cliente" as "Cliente", "Tipcomp" as "Tipocomprobante", "Letra" as "Letra", "Ptovta" as "Puntodeventa", "Num" as "Numero", "Feccomp" as "Fechacomp", "Monto" as "Monto", "Obs" as "Observacion"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.CONCLI 
								Where   CONCLI.CODIGO != ''
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
	Tabla = 'CONCLI'
	Filtro = " CONCLI.CODIGO != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " CONCLI.CODIGO != ''"
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
	<row entidad="CONSUMOCLIENTE                          " atributo="FECHAEXPO                               " tabla="CONCLI         " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONSUMOCLIENTE                          " atributo="FECHAALTAFW                             " tabla="CONCLI         " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONSUMOCLIENTE                          " atributo="FECHAIMPO                               " tabla="CONCLI         " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONSUMOCLIENTE                          " atributo="FECHAMODIFICACIONFW                     " tabla="CONCLI         " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONSUMOCLIENTE                          " atributo="FECHATRANSFERENCIA                      " tabla="CONCLI         " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha transferencia                                                                                                                                             " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONSUMOCLIENTE                          " atributo="SIGNO                                   " tabla="CONCLI         " campo="SIGNO     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Signo comprobante                                                                                                                                               " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONSUMOCLIENTE                          " atributo="ANULADO                                 " tabla="CONCLI         " campo="ANUL      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Anulado                                                                                                                                                         " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONSUMOCLIENTE                          " atributo="HORAMODIFICACIONFW                      " tabla="CONCLI         " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONSUMOCLIENTE                          " atributo="SERIEALTAFW                             " tabla="CONCLI         " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONSUMOCLIENTE                          " atributo="USUARIOMODIFICACIONFW                   " tabla="CONCLI         " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONSUMOCLIENTE                          " atributo="ZADSFW                                  " tabla="CONCLI         " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONSUMOCLIENTE                          " atributo="DESCRIPCIONFW                           " tabla="CONCLI         " campo="DESCFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="200" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONSUMOCLIENTE                          " atributo="VERSIONMODIFICACIONFW                   " tabla="CONCLI         " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONSUMOCLIENTE                          " atributo="VERSIONALTAFW                           " tabla="CONCLI         " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONSUMOCLIENTE                          " atributo="USUARIOALTAFW                           " tabla="CONCLI         " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONSUMOCLIENTE                          " atributo="HORAIMPO                                " tabla="CONCLI         " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONSUMOCLIENTE                          " atributo="SERIEMODIFICACIONFW                     " tabla="CONCLI         " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONSUMOCLIENTE                          " atributo="ESTADOTRANSFERENCIA                     " tabla="CONCLI         " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado transferencia                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONSUMOCLIENTE                          " atributo="HORAEXPO                                " tabla="CONCLI         " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONSUMOCLIENTE                          " atributo="BASEDEDATOS                             " tabla="CONCLI         " campo="DB        " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos                                                                                                                                                   " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONSUMOCLIENTE                          " atributo="CODIGOCOMPROBANTE                       " tabla="CONCLI         " campo="CODCOMP   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Codigo comprobante                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="5" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONSUMOCLIENTE                          " atributo="HORAALTAFW                              " tabla="CONCLI         " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONSUMOCLIENTE                          " atributo="BASEDEDATOSALTAFW                       " tabla="CONCLI         " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONSUMOCLIENTE                          " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="CONCLI         " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONSUMOCLIENTE                          " atributo="CODIGO                                  " tabla="CONCLI         " campo="CODIGO    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="16" etiqueta="Código                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONSUMOCLIENTE                          " atributo="LIMITECONSUMO                           " tabla="CONCLI         " campo="LIMCONSUMO" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="LIMITECONSUMO                           " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Limite Consumo                                                                                                                                                  " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONSUMOCLIENTE                          " atributo="CLIENTE                                 " tabla="CONCLI         " campo="CLIENTE   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="2" etiqueta="Cliente                                                                                                                                                         " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONSUMOCLIENTE                          " atributo="TIPOCOMPROBANTE                         " tabla="CONCLI         " campo="TIPCOMP   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="4" etiqueta="Tipo comprobante                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="1" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONSUMOCLIENTE                          " atributo="LETRA                                   " tabla="CONCLI         " campo="LETRA     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="6" etiqueta="Letra                                                                                                                                                           " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="2" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="10" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONSUMOCLIENTE                          " atributo="PUNTODEVENTA                            " tabla="CONCLI         " campo="PTOVTA    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="4" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="8" etiqueta="Punto de Venta                                                                                                                                                  " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="3" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="15" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONSUMOCLIENTE                          " atributo="NUMERO                                  " tabla="CONCLI         " campo="NUM       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="10" etiqueta="Número                                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="4" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="20" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONSUMOCLIENTE                          " atributo="FECHACOMP                               " tabla="CONCLI         " campo="FECCOMP   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="Fecha comprobante                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="25" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONSUMOCLIENTE                          " atributo="MONTO                                   " tabla="CONCLI         " campo="MONTO     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="16" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="12" etiqueta="Total                                                                                                                                                           " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="30" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONSUMOCLIENTE                          " atributo="OBSERVACION                             " tabla="CONCLI         " campo="OBS       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="402" etiqueta="Observaciones                                                                                                                                                   " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="40" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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