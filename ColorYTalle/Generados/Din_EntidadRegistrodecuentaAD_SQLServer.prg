
define class Din_EntidadREGISTRODECUENTAAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_REGISTRODECUENTA'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = []
	cExpresionCCPorCampos = []
	cTagClaveCandidata = ''
	cTagClavePk = '_RCTPK'
	cTablaPrincipal = 'REGCTA'
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
			local  lxRegctaFectrans, lxRegctaFaltafw, lxRegctaFmodifw, lxRegctaFecimpo, lxRegctaFecexpo, lxRegctaFecha, lxRegctaHaltafw, lxRegctaHoraexpo, lxRegctaSaltafw, lxRegctaVmodifw, lxRegctaZadsfw, lxRegctaValtafw, lxRegctaUaltafw, lxRegctaUmodifw, lxRegctaHmodifw, lxRegctaSmodifw, lxRegctaHoraimpo, lxRegctaEsttrans, lxRegctaBdmodifw, lxRegctaEntidad, lxRegctaCodigo, lxRegctaFechacarga, lxRegctaCtabanc, lxRegctaHora, lxRegctaComp, lxRegctaTipoval, lxRegctaIdent, lxRegctaCodbco, lxRegctaPendiente, lxRegctaImporte, lxRegctaIdcomp, lxRegctaIdvalor, lxRegctaBdaltafw, lxRegctaObs
				lxRegctaFectrans =  .Fechatransferencia			lxRegctaFaltafw =  .Fechaaltafw			lxRegctaFmodifw =  .Fechamodificacionfw			lxRegctaFecimpo =  .Fechaimpo			lxRegctaFecexpo =  .Fechaexpo			lxRegctaFecha =  .Fecha			lxRegctaHaltafw =  .Horaaltafw			lxRegctaHoraexpo =  .Horaexpo			lxRegctaSaltafw =  .Seriealtafw			lxRegctaVmodifw =  .Versionmodificacionfw			lxRegctaZadsfw =  .Zadsfw			lxRegctaValtafw =  .Versionaltafw			lxRegctaUaltafw =  .Usuarioaltafw			lxRegctaUmodifw =  .Usuariomodificacionfw			lxRegctaHmodifw =  .Horamodificacionfw			lxRegctaSmodifw =  .Seriemodificacionfw			lxRegctaHoraimpo =  .Horaimpo			lxRegctaEsttrans =  .Estadotransferencia			lxRegctaBdmodifw =  .Basededatosmodificacionfw			lxRegctaEntidad =  .Entidadcomprobante			lxRegctaCodigo =  .Codigo			lxRegctaFechacarga =  .Fechacargaoperacion			lxRegctaCtabanc =  upper( .CuentaBancaria_PK ) 			lxRegctaHora =  .Hora			lxRegctaComp =  .Comprobante			lxRegctaTipoval =  .Tipovalor			lxRegctaIdent =  .Identificador			lxRegctaCodbco =  .Codigobanco			lxRegctaPendiente =  .Pendiente			lxRegctaImporte =  .Importe			lxRegctaIdcomp =  .Idcomprobante			lxRegctaIdvalor =  .Idvalor			lxRegctaBdaltafw =  .Basededatosaltafw			lxRegctaObs =  .Observacion
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxRegctaCodigo = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.REGCTA ( "Fectrans","Faltafw","Fmodifw","Fecimpo","Fecexpo","Fecha","Haltafw","Horaexpo","Saltafw","Vmodifw","Zadsfw","Valtafw","Ualtafw","Umodifw","Hmodifw","Smodifw","Horaimpo","Esttrans","Bdmodifw","Entidad","Codigo","Fechacarga","Ctabanc","Hora","Comp","Tipoval","Ident","Codbco","Pendiente","Importe","Idcomp","Idvalor","Bdaltafw","Obs" ) values ( <<"'" + this.ConvertirDateSql( lxRegctaFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxRegctaFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxRegctaFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxRegctaFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxRegctaFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxRegctaFecha ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegctaHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegctaHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegctaSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegctaVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegctaZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegctaValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegctaUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegctaUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegctaHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegctaSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegctaHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegctaEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegctaBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegctaEntidad ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegctaCodigo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxRegctaFechacarga ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegctaCtabanc ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegctaHora ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegctaComp ) + "'" >>, <<lxRegctaTipoval >>, <<"'" + this.FormatearTextoSql( lxRegctaIdent ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegctaCodbco ) + "'" >>, <<iif( lxRegctaPendiente, 1, 0 ) >>, <<lxRegctaImporte >>, <<"'" + this.FormatearTextoSql( lxRegctaIdcomp ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegctaIdvalor ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegctaBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegctaObs ) + "'" >> )
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
			local  lxRegctaFectrans, lxRegctaFaltafw, lxRegctaFmodifw, lxRegctaFecimpo, lxRegctaFecexpo, lxRegctaFecha, lxRegctaHaltafw, lxRegctaHoraexpo, lxRegctaSaltafw, lxRegctaVmodifw, lxRegctaZadsfw, lxRegctaValtafw, lxRegctaUaltafw, lxRegctaUmodifw, lxRegctaHmodifw, lxRegctaSmodifw, lxRegctaHoraimpo, lxRegctaEsttrans, lxRegctaBdmodifw, lxRegctaEntidad, lxRegctaCodigo, lxRegctaFechacarga, lxRegctaCtabanc, lxRegctaHora, lxRegctaComp, lxRegctaTipoval, lxRegctaIdent, lxRegctaCodbco, lxRegctaPendiente, lxRegctaImporte, lxRegctaIdcomp, lxRegctaIdvalor, lxRegctaBdaltafw, lxRegctaObs
				lxRegctaFectrans =  .Fechatransferencia			lxRegctaFaltafw =  .Fechaaltafw			lxRegctaFmodifw =  .Fechamodificacionfw			lxRegctaFecimpo =  .Fechaimpo			lxRegctaFecexpo =  .Fechaexpo			lxRegctaFecha =  .Fecha			lxRegctaHaltafw =  .Horaaltafw			lxRegctaHoraexpo =  .Horaexpo			lxRegctaSaltafw =  .Seriealtafw			lxRegctaVmodifw =  .Versionmodificacionfw			lxRegctaZadsfw =  .Zadsfw			lxRegctaValtafw =  .Versionaltafw			lxRegctaUaltafw =  .Usuarioaltafw			lxRegctaUmodifw =  .Usuariomodificacionfw			lxRegctaHmodifw =  .Horamodificacionfw			lxRegctaSmodifw =  .Seriemodificacionfw			lxRegctaHoraimpo =  .Horaimpo			lxRegctaEsttrans =  .Estadotransferencia			lxRegctaBdmodifw =  .Basededatosmodificacionfw			lxRegctaEntidad =  .Entidadcomprobante			lxRegctaCodigo =  .Codigo			lxRegctaFechacarga =  .Fechacargaoperacion			lxRegctaCtabanc =  upper( .CuentaBancaria_PK ) 			lxRegctaHora =  .Hora			lxRegctaComp =  .Comprobante			lxRegctaTipoval =  .Tipovalor			lxRegctaIdent =  .Identificador			lxRegctaCodbco =  .Codigobanco			lxRegctaPendiente =  .Pendiente			lxRegctaImporte =  .Importe			lxRegctaIdcomp =  .Idcomprobante			lxRegctaIdvalor =  .Idvalor			lxRegctaBdaltafw =  .Basededatosaltafw			lxRegctaObs =  .Observacion
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()
			lxValorClavePrimaria = .oEntidad.CODIGO
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ZooLogic.REGCTA set "Fectrans" = <<"'" + this.ConvertirDateSql( lxRegctaFectrans ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxRegctaFaltafw ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxRegctaFmodifw ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxRegctaFecimpo ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxRegctaFecexpo ) + "'">>,"Fecha" = <<"'" + this.ConvertirDateSql( lxRegctaFecha ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxRegctaHaltafw ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxRegctaHoraexpo ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxRegctaSaltafw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxRegctaVmodifw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxRegctaZadsfw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxRegctaValtafw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxRegctaUaltafw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxRegctaUmodifw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxRegctaHmodifw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxRegctaSmodifw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxRegctaHoraimpo ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxRegctaEsttrans ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxRegctaBdmodifw ) + "'">>,"Entidad" = <<"'" + this.FormatearTextoSql( lxRegctaEntidad ) + "'">>,"Codigo" = <<"'" + this.FormatearTextoSql( lxRegctaCodigo ) + "'">>,"Fechacarga" = <<"'" + this.ConvertirDateSql( lxRegctaFechacarga ) + "'">>,"Ctabanc" = <<"'" + this.FormatearTextoSql( lxRegctaCtabanc ) + "'">>,"Hora" = <<"'" + this.FormatearTextoSql( lxRegctaHora ) + "'">>,"Comp" = <<"'" + this.FormatearTextoSql( lxRegctaComp ) + "'">>,"Tipoval" = <<lxRegctaTipoval>>,"Ident" = <<"'" + this.FormatearTextoSql( lxRegctaIdent ) + "'">>,"Codbco" = <<"'" + this.FormatearTextoSql( lxRegctaCodbco ) + "'">>,"Pendiente" = <<iif( lxRegctaPendiente, 1, 0 )>>,"Importe" = <<lxRegctaImporte>>,"Idcomp" = <<"'" + this.FormatearTextoSql( lxRegctaIdcomp ) + "'">>,"Idvalor" = <<"'" + this.FormatearTextoSql( lxRegctaIdvalor ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxRegctaBdaltafw ) + "'">>,"Obs" = <<"'" + this.FormatearTextoSql( lxRegctaObs ) + "'">> where "Codigo" = <<"'" + this.FormatearTextoSql( lxRegctaCodigo ) + "'">> and  REGCTA.CODIGO != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 Codigo from ZooLogic.REGCTA where " + this.ConvertirFuncionesSql( " REGCTA.CODIGO != ''" ) )
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
			Local lxRegctaCodigo
			lxRegctaCodigo = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Fecha" as "Fecha", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Saltafw" as "Seriealtafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Entidad" as "Entidadcomprobante", "Codigo" as "Codigo", "Fechacarga" as "Fechacargaoperacion", "Ctabanc" as "Cuentabancaria", "Hora" as "Hora", "Comp" as "Comprobante", "Tipoval" as "Tipovalor", "Ident" as "Identificador", "Codbco" as "Codigobanco", "Pendiente" as "Pendiente", "Importe" as "Importe", "Idcomp" as "Idcomprobante", "Idvalor" as "Idvalor", "Bdaltafw" as "Basededatosaltafw", "Obs" as "Observacion" from ZooLogic.REGCTA where "Codigo" = <<"'" + this.FormatearTextoSql( lxRegctaCodigo ) + "'">> and  REGCTA.CODIGO != ''
			endtext
			use in select('c_REGISTRODECUENTA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_REGISTRODECUENTA', set( 'Datasession' ) )

			if reccount( 'c_REGISTRODECUENTA' ) = 0
				llRetorno = .f.
			else
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxRegctaCodigo as Variant
		llRetorno = .t.
		lxRegctaCodigo = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.REGCTA where "Codigo" = <<"'" + this.FormatearTextoSql( lxRegctaCodigo ) + "'">> and  REGCTA.CODIGO != ''
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
				lcOrden =   iif( empty( .Fecha ), dtos( evaluate( goRegistry.Nucleo.FechaEnBlancoParaSqlServer ) ), dtos( .Fecha ) ) +  iif( empty( .FechaCargaOperacion ), dtos( evaluate( goRegistry.Nucleo.FechaEnBlancoParaSqlServer ) ), dtos( .FechaCargaOperacion ) ) + .Hora + .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Fecha" as "Fecha", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Saltafw" as "Seriealtafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Entidad" as "Entidadcomprobante", "Codigo" as "Codigo", "Fechacarga" as "Fechacargaoperacion", "Ctabanc" as "Cuentabancaria", "Hora" as "Hora", "Comp" as "Comprobante", "Tipoval" as "Tipovalor", "Ident" as "Identificador", "Codbco" as "Codigobanco", "Pendiente" as "Pendiente", "Importe" as "Importe", "Idcomp" as "Idcomprobante", "Idvalor" as "Idvalor", "Bdaltafw" as "Basededatosaltafw", "Obs" as "Observacion" from ZooLogic.REGCTA where  REGCTA.CODIGO != '' order by Fecha,FechaCarga,Hora,Codigo
			endtext
			use in select('c_REGISTRODECUENTA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_REGISTRODECUENTA', set( 'Datasession' ) )
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
				lcOrden =   iif( empty( .Fecha ), dtos( evaluate( goRegistry.Nucleo.FechaEnBlancoParaSqlServer ) ), dtos( .Fecha ) ) +  iif( empty( .FechaCargaOperacion ), dtos( evaluate( goRegistry.Nucleo.FechaEnBlancoParaSqlServer ) ), dtos( .FechaCargaOperacion ) ) + .Hora + .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Fecha" as "Fecha", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Saltafw" as "Seriealtafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Entidad" as "Entidadcomprobante", "Codigo" as "Codigo", "Fechacarga" as "Fechacargaoperacion", "Ctabanc" as "Cuentabancaria", "Hora" as "Hora", "Comp" as "Comprobante", "Tipoval" as "Tipovalor", "Ident" as "Identificador", "Codbco" as "Codigobanco", "Pendiente" as "Pendiente", "Importe" as "Importe", "Idcomp" as "Idcomprobante", "Idvalor" as "Idvalor", "Bdaltafw" as "Basededatosaltafw", "Obs" as "Observacion" from ZooLogic.REGCTA where  funciones.dtos( Fecha ) + funciones.dtos( FechaCarga ) + funciones.padr( Hora, 5, ' ' ) + funciones.padr( Codigo, 20, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  REGCTA.CODIGO != '' order by Fecha,FechaCarga,Hora,Codigo
			endtext
			use in select('c_REGISTRODECUENTA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_REGISTRODECUENTA', set( 'Datasession' ) )
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
				lcOrden =   iif( empty( .Fecha ), dtos( evaluate( goRegistry.Nucleo.FechaEnBlancoParaSqlServer ) ), dtos( .Fecha ) ) +  iif( empty( .FechaCargaOperacion ), dtos( evaluate( goRegistry.Nucleo.FechaEnBlancoParaSqlServer ) ), dtos( .FechaCargaOperacion ) ) + .Hora + .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Fecha" as "Fecha", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Saltafw" as "Seriealtafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Entidad" as "Entidadcomprobante", "Codigo" as "Codigo", "Fechacarga" as "Fechacargaoperacion", "Ctabanc" as "Cuentabancaria", "Hora" as "Hora", "Comp" as "Comprobante", "Tipoval" as "Tipovalor", "Ident" as "Identificador", "Codbco" as "Codigobanco", "Pendiente" as "Pendiente", "Importe" as "Importe", "Idcomp" as "Idcomprobante", "Idvalor" as "Idvalor", "Bdaltafw" as "Basededatosaltafw", "Obs" as "Observacion" from ZooLogic.REGCTA where  funciones.dtos( Fecha ) + funciones.dtos( FechaCarga ) + funciones.padr( Hora, 5, ' ' ) + funciones.padr( Codigo, 20, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  REGCTA.CODIGO != '' order by Fecha desc,FechaCarga desc,Hora desc,Codigo desc
			endtext
			use in select('c_REGISTRODECUENTA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_REGISTRODECUENTA', set( 'Datasession' ) )
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
				lcOrden =   iif( empty( .Fecha ), dtos( evaluate( goRegistry.Nucleo.FechaEnBlancoParaSqlServer ) ), dtos( .Fecha ) ) +  iif( empty( .FechaCargaOperacion ), dtos( evaluate( goRegistry.Nucleo.FechaEnBlancoParaSqlServer ) ), dtos( .FechaCargaOperacion ) ) + .Hora + .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Fecha" as "Fecha", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Saltafw" as "Seriealtafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Entidad" as "Entidadcomprobante", "Codigo" as "Codigo", "Fechacarga" as "Fechacargaoperacion", "Ctabanc" as "Cuentabancaria", "Hora" as "Hora", "Comp" as "Comprobante", "Tipoval" as "Tipovalor", "Ident" as "Identificador", "Codbco" as "Codigobanco", "Pendiente" as "Pendiente", "Importe" as "Importe", "Idcomp" as "Idcomprobante", "Idvalor" as "Idvalor", "Bdaltafw" as "Basededatosaltafw", "Obs" as "Observacion" from ZooLogic.REGCTA where  REGCTA.CODIGO != '' order by Fecha desc,FechaCarga desc,Hora desc,Codigo desc
			endtext
			use in select('c_REGISTRODECUENTA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_REGISTRODECUENTA', set( 'Datasession' ) )
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
			lcXml = this.oConexion.EjecutarSql( "select Fectrans,Faltafw,Fmodifw,Fecimpo,Fecexpo,Fecha,Haltafw,Horaexpo,Saltafw,Vmodifw,Zadsfw,Valta" + ;
"fw,Ualtafw,Umodifw,Hmodifw,Smodifw,Horaimpo,Esttrans,Bdmodifw,Entidad,Codigo,Fechacarga,Ctabanc,Hora" + ;
",Comp,Tipoval,Ident,Codbco,Pendiente,Importe,Idcomp,Idvalor,Bdaltafw,Obs" + ;
" from ZooLogic.REGCTA where  REGCTA.CODIGO != '' and " + lcFiltro )
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
			local  lxRegctaFectrans, lxRegctaFaltafw, lxRegctaFmodifw, lxRegctaFecimpo, lxRegctaFecexpo, lxRegctaFecha, lxRegctaHaltafw, lxRegctaHoraexpo, lxRegctaSaltafw, lxRegctaVmodifw, lxRegctaZadsfw, lxRegctaValtafw, lxRegctaUaltafw, lxRegctaUmodifw, lxRegctaHmodifw, lxRegctaSmodifw, lxRegctaHoraimpo, lxRegctaEsttrans, lxRegctaBdmodifw, lxRegctaEntidad, lxRegctaCodigo, lxRegctaFechacarga, lxRegctaCtabanc, lxRegctaHora, lxRegctaComp, lxRegctaTipoval, lxRegctaIdent, lxRegctaCodbco, lxRegctaPendiente, lxRegctaImporte, lxRegctaIdcomp, lxRegctaIdvalor, lxRegctaBdaltafw, lxRegctaObs
				lxRegctaFectrans = ctod( '  /  /    ' )			lxRegctaFaltafw = ctod( '  /  /    ' )			lxRegctaFmodifw = ctod( '  /  /    ' )			lxRegctaFecimpo = ctod( '  /  /    ' )			lxRegctaFecexpo = ctod( '  /  /    ' )			lxRegctaFecha = ctod( '  /  /    ' )			lxRegctaHaltafw = []			lxRegctaHoraexpo = []			lxRegctaSaltafw = []			lxRegctaVmodifw = []			lxRegctaZadsfw = []			lxRegctaValtafw = []			lxRegctaUaltafw = []			lxRegctaUmodifw = []			lxRegctaHmodifw = []			lxRegctaSmodifw = []			lxRegctaHoraimpo = []			lxRegctaEsttrans = []			lxRegctaBdmodifw = []			lxRegctaEntidad = []			lxRegctaCodigo = []			lxRegctaFechacarga = ctod( '  /  /    ' )			lxRegctaCtabanc = []			lxRegctaHora = []			lxRegctaComp = []			lxRegctaTipoval = 0			lxRegctaIdent = []			lxRegctaCodbco = []			lxRegctaPendiente = .F.			lxRegctaImporte = 0			lxRegctaIdcomp = []			lxRegctaIdvalor = []			lxRegctaBdaltafw = []			lxRegctaObs = []
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( [delete from ZooLogic.REGCTA where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'REGCTA' + '_' + tcCampo
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
		lcWhere = " Where  REGCTA.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Fecha" as "Fecha", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Saltafw" as "Seriealtafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Entidad" as "Entidadcomprobante", "Codigo" as "Codigo", "Fechacarga" as "Fechacargaoperacion", "Ctabanc" as "Cuentabancaria", "Hora" as "Hora", "Comp" as "Comprobante", "Tipoval" as "Tipovalor", "Ident" as "Identificador", "Codbco" as "Codigobanco", "Pendiente" as "Pendiente", "Importe" as "Importe", "Idcomp" as "Idcomprobante", "Idvalor" as "Idvalor", "Bdaltafw" as "Basededatosaltafw", "Obs" as "Observacion"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'REGCTA', '', tnTope )
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
				Case lcAtributo == 'FECHATRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRANS AS FECHATRANSFERENCIA'
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'FECHAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECIMPO AS FECHAIMPO'
				Case lcAtributo == 'FECHAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECEXPO AS FECHAEXPO'
				Case lcAtributo == 'FECHA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHA AS FECHA'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'ENTIDADCOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ENTIDAD AS ENTIDADCOMPROBANTE'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'FECHACARGAOPERACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHACARGA AS FECHACARGAOPERACION'
				Case lcAtributo == 'CUENTABANCARIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CTABANC AS CUENTABANCARIA'
				Case lcAtributo == 'HORA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORA AS HORA'
				Case lcAtributo == 'COMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COMP AS COMPROBANTE'
				Case lcAtributo == 'TIPOVALOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPOVAL AS TIPOVALOR'
				Case lcAtributo == 'IDENTIFICADOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDENT AS IDENTIFICADOR'
				Case lcAtributo == 'CODIGOBANCO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODBCO AS CODIGOBANCO'
				Case lcAtributo == 'PENDIENTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PENDIENTE AS PENDIENTE'
				Case lcAtributo == 'IMPORTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IMPORTE AS IMPORTE'
				Case lcAtributo == 'IDCOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDCOMP AS IDCOMPROBANTE'
				Case lcAtributo == 'IDVALOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDVALOR AS IDVALOR'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAIMPO'
				lcCampo = 'FECIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEXPO'
				lcCampo = 'FECEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHA'
				lcCampo = 'FECHA'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ENTIDADCOMPROBANTE'
				lcCampo = 'ENTIDAD'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHACARGAOPERACION'
				lcCampo = 'FECHACARGA'
			Case upper( alltrim( tcAtributo ) ) == 'CUENTABANCARIA'
				lcCampo = 'CTABANC'
			Case upper( alltrim( tcAtributo ) ) == 'HORA'
				lcCampo = 'HORA'
			Case upper( alltrim( tcAtributo ) ) == 'COMPROBANTE'
				lcCampo = 'COMP'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOVALOR'
				lcCampo = 'TIPOVAL'
			Case upper( alltrim( tcAtributo ) ) == 'IDENTIFICADOR'
				lcCampo = 'IDENT'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGOBANCO'
				lcCampo = 'CODBCO'
			Case upper( alltrim( tcAtributo ) ) == 'PENDIENTE'
				lcCampo = 'PENDIENTE'
			Case upper( alltrim( tcAtributo ) ) == 'IMPORTE'
				lcCampo = 'IMPORTE'
			Case upper( alltrim( tcAtributo ) ) == 'IDCOMPROBANTE'
				lcCampo = 'IDCOMP'
			Case upper( alltrim( tcAtributo ) ) == 'IDVALOR'
				lcCampo = 'IDVALOR'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
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
			local  lxRegctaFectrans, lxRegctaFaltafw, lxRegctaFmodifw, lxRegctaFecimpo, lxRegctaFecexpo, lxRegctaFecha, lxRegctaHaltafw, lxRegctaHoraexpo, lxRegctaSaltafw, lxRegctaVmodifw, lxRegctaZadsfw, lxRegctaValtafw, lxRegctaUaltafw, lxRegctaUmodifw, lxRegctaHmodifw, lxRegctaSmodifw, lxRegctaHoraimpo, lxRegctaEsttrans, lxRegctaBdmodifw, lxRegctaEntidad, lxRegctaCodigo, lxRegctaFechacarga, lxRegctaCtabanc, lxRegctaHora, lxRegctaComp, lxRegctaTipoval, lxRegctaIdent, lxRegctaCodbco, lxRegctaPendiente, lxRegctaImporte, lxRegctaIdcomp, lxRegctaIdvalor, lxRegctaBdaltafw, lxRegctaObs
				lxRegctaFectrans =  .Fechatransferencia			lxRegctaFaltafw =  .Fechaaltafw			lxRegctaFmodifw =  .Fechamodificacionfw			lxRegctaFecimpo =  .Fechaimpo			lxRegctaFecexpo =  .Fechaexpo			lxRegctaFecha =  .Fecha			lxRegctaHaltafw =  .Horaaltafw			lxRegctaHoraexpo =  .Horaexpo			lxRegctaSaltafw =  .Seriealtafw			lxRegctaVmodifw =  .Versionmodificacionfw			lxRegctaZadsfw =  .Zadsfw			lxRegctaValtafw =  .Versionaltafw			lxRegctaUaltafw =  .Usuarioaltafw			lxRegctaUmodifw =  .Usuariomodificacionfw			lxRegctaHmodifw =  .Horamodificacionfw			lxRegctaSmodifw =  .Seriemodificacionfw			lxRegctaHoraimpo =  .Horaimpo			lxRegctaEsttrans =  .Estadotransferencia			lxRegctaBdmodifw =  .Basededatosmodificacionfw			lxRegctaEntidad =  .Entidadcomprobante			lxRegctaCodigo =  .Codigo			lxRegctaFechacarga =  .Fechacargaoperacion			lxRegctaCtabanc =  upper( .CuentaBancaria_PK ) 			lxRegctaHora =  .Hora			lxRegctaComp =  .Comprobante			lxRegctaTipoval =  .Tipovalor			lxRegctaIdent =  .Identificador			lxRegctaCodbco =  .Codigobanco			lxRegctaPendiente =  .Pendiente			lxRegctaImporte =  .Importe			lxRegctaIdcomp =  .Idcomprobante			lxRegctaIdvalor =  .Idvalor			lxRegctaBdaltafw =  .Basededatosaltafw			lxRegctaObs =  .Observacion
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.REGCTA ( "Fectrans","Faltafw","Fmodifw","Fecimpo","Fecexpo","Fecha","Haltafw","Horaexpo","Saltafw","Vmodifw","Zadsfw","Valtafw","Ualtafw","Umodifw","Hmodifw","Smodifw","Horaimpo","Esttrans","Bdmodifw","Entidad","Codigo","Fechacarga","Ctabanc","Hora","Comp","Tipoval","Ident","Codbco","Pendiente","Importe","Idcomp","Idvalor","Bdaltafw","Obs" ) values ( <<"'" + this.ConvertirDateSql( lxRegctaFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxRegctaFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxRegctaFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxRegctaFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxRegctaFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxRegctaFecha ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegctaHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegctaHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegctaSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegctaVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegctaZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegctaValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegctaUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegctaUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegctaHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegctaSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegctaHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegctaEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegctaBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegctaEntidad ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegctaCodigo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxRegctaFechacarga ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegctaCtabanc ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegctaHora ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegctaComp ) + "'" >>, <<lxRegctaTipoval >>, <<"'" + this.FormatearTextoSql( lxRegctaIdent ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegctaCodbco ) + "'" >>, <<iif( lxRegctaPendiente, 1, 0 ) >>, <<lxRegctaImporte >>, <<"'" + this.FormatearTextoSql( lxRegctaIdcomp ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegctaIdvalor ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegctaBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegctaObs ) + "'" >> )
		endtext
		loColeccion.cTabla = 'REGCTA' 
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
			local  lxRegctaFectrans, lxRegctaFaltafw, lxRegctaFmodifw, lxRegctaFecimpo, lxRegctaFecexpo, lxRegctaFecha, lxRegctaHaltafw, lxRegctaHoraexpo, lxRegctaSaltafw, lxRegctaVmodifw, lxRegctaZadsfw, lxRegctaValtafw, lxRegctaUaltafw, lxRegctaUmodifw, lxRegctaHmodifw, lxRegctaSmodifw, lxRegctaHoraimpo, lxRegctaEsttrans, lxRegctaBdmodifw, lxRegctaEntidad, lxRegctaCodigo, lxRegctaFechacarga, lxRegctaCtabanc, lxRegctaHora, lxRegctaComp, lxRegctaTipoval, lxRegctaIdent, lxRegctaCodbco, lxRegctaPendiente, lxRegctaImporte, lxRegctaIdcomp, lxRegctaIdvalor, lxRegctaBdaltafw, lxRegctaObs
				lxRegctaFectrans =  .Fechatransferencia			lxRegctaFaltafw =  .Fechaaltafw			lxRegctaFmodifw =  .Fechamodificacionfw			lxRegctaFecimpo =  .Fechaimpo			lxRegctaFecexpo =  .Fechaexpo			lxRegctaFecha =  .Fecha			lxRegctaHaltafw =  .Horaaltafw			lxRegctaHoraexpo =  .Horaexpo			lxRegctaSaltafw =  .Seriealtafw			lxRegctaVmodifw =  .Versionmodificacionfw			lxRegctaZadsfw =  .Zadsfw			lxRegctaValtafw =  .Versionaltafw			lxRegctaUaltafw =  .Usuarioaltafw			lxRegctaUmodifw =  .Usuariomodificacionfw			lxRegctaHmodifw =  .Horamodificacionfw			lxRegctaSmodifw =  .Seriemodificacionfw			lxRegctaHoraimpo =  .Horaimpo			lxRegctaEsttrans =  .Estadotransferencia			lxRegctaBdmodifw =  .Basededatosmodificacionfw			lxRegctaEntidad =  .Entidadcomprobante			lxRegctaCodigo =  .Codigo			lxRegctaFechacarga =  .Fechacargaoperacion			lxRegctaCtabanc =  upper( .CuentaBancaria_PK ) 			lxRegctaHora =  .Hora			lxRegctaComp =  .Comprobante			lxRegctaTipoval =  .Tipovalor			lxRegctaIdent =  .Identificador			lxRegctaCodbco =  .Codigobanco			lxRegctaPendiente =  .Pendiente			lxRegctaImporte =  .Importe			lxRegctaIdcomp =  .Idcomprobante			lxRegctaIdvalor =  .Idvalor			lxRegctaBdaltafw =  .Basededatosaltafw			lxRegctaObs =  .Observacion
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  REGCTA.CODIGO != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.REGCTA set "Fectrans" = <<"'" + this.ConvertirDateSql( lxRegctaFectrans ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxRegctaFaltafw ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxRegctaFmodifw ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxRegctaFecimpo ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxRegctaFecexpo ) + "'">>, "Fecha" = <<"'" + this.ConvertirDateSql( lxRegctaFecha ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxRegctaHaltafw ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxRegctaHoraexpo ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxRegctaSaltafw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxRegctaVmodifw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxRegctaZadsfw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxRegctaValtafw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxRegctaUaltafw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxRegctaUmodifw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxRegctaHmodifw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxRegctaSmodifw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxRegctaHoraimpo ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxRegctaEsttrans ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxRegctaBdmodifw ) + "'">>, "Entidad" = <<"'" + this.FormatearTextoSql( lxRegctaEntidad ) + "'">>, "Codigo" = <<"'" + this.FormatearTextoSql( lxRegctaCodigo ) + "'">>, "Fechacarga" = <<"'" + this.ConvertirDateSql( lxRegctaFechacarga ) + "'">>, "Ctabanc" = <<"'" + this.FormatearTextoSql( lxRegctaCtabanc ) + "'">>, "Hora" = <<"'" + this.FormatearTextoSql( lxRegctaHora ) + "'">>, "Comp" = <<"'" + this.FormatearTextoSql( lxRegctaComp ) + "'">>, "Tipoval" = <<lxRegctaTipoval>>, "Ident" = <<"'" + this.FormatearTextoSql( lxRegctaIdent ) + "'">>, "Codbco" = <<"'" + this.FormatearTextoSql( lxRegctaCodbco ) + "'">>, "Pendiente" = <<iif( lxRegctaPendiente, 1, 0 )>>, "Importe" = <<lxRegctaImporte>>, "Idcomp" = <<"'" + this.FormatearTextoSql( lxRegctaIdcomp ) + "'">>, "Idvalor" = <<"'" + this.FormatearTextoSql( lxRegctaIdvalor ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxRegctaBdaltafw ) + "'">>, "Obs" = <<"'" + this.FormatearTextoSql( lxRegctaObs ) + "'">> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'REGCTA' 
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

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  REGCTA.CODIGO != '']
		loColeccion.Agregar( 'delete from ZooLogic.REGCTA where ' + lcFiltro )
			loColeccion.cTabla = 'REGCTA' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.REGCTA where  REGCTA.CODIGO != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.REGCTA where Codigo = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  REGCTA.CODIGO != ''" )
			this.xmlacursor( lcXml, lcCursor )
		if reccount( lcCursor ) > 0
			lnTimeStamp = &lcCursor..Timestamp
		endif
		use in select( lcCursor )

		return lnTimeStamp 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirCabecera( tlLoguear as Boolean ) As Void
		local lcCursor as String, ldFecha as Date, lcHora as string, lcValorABuscar As String, lxValorClavePK As variant, lxValorClavePrimaria As variant, lcIdentificadorParaLoguear as string, lcMensajeExtra as String
		lcValorABuscar = ''
		lxValorClavePK = ''
		lcMensajeExtra = ''
		lcCursor = This.oEntidad.cPrefijoRecibir + 'REGISTRODECUENTA'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.REGCTA Where Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'", 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					this.oConexion.EjecutarSql( [UPDATE ZooLogic.REGCTA set  FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, Fecha = ] + "'" + this.ConvertirDateSql( &lcCursor..Fecha ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, Entidad = ] + "'" + this.FormatearTextoSql( &lcCursor..Entidad ) + "'"+ [, Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'"+ [, FechaCarga = ] + "'" + this.ConvertirDateSql( &lcCursor..FechaCarga ) + "'"+ [, CtaBanc = ] + "'" + this.FormatearTextoSql( &lcCursor..CtaBanc ) + "'"+ [, Hora = ] + "'" + this.FormatearTextoSql( &lcCursor..Hora ) + "'"+ [, Comp = ] + "'" + this.FormatearTextoSql( &lcCursor..Comp ) + "'"+ [, TipoVal = ] + transform( &lcCursor..TipoVal )+ [, Ident = ] + "'" + this.FormatearTextoSql( &lcCursor..Ident ) + "'"+ [, CodBco = ] + "'" + this.FormatearTextoSql( &lcCursor..CodBco ) + "'"+ [, Pendiente = ] + Transform( iif( &lcCursor..Pendiente, 1, 0 ))+ [, Importe = ] + transform( &lcCursor..Importe )+ [, IdComp = ] + "'" + this.FormatearTextoSql( &lcCursor..IdComp ) + "'"+ [, idValor = ] + "'" + this.FormatearTextoSql( &lcCursor..idValor ) + "'"+ [, Obs = ] + "'" + this.FormatearTextoSql( &lcCursor..Obs ) + "'" + [ Where Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'" )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
				endIf
			else
				Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
				Text to lcCampos noShow
					 FECTRANS, FALTAFW, FMODIFW, FECIMPO, FECEXPO, Fecha, HALTAFW, HORAEXPO, SALTAFW, VMODIFW, ZADSFW, VALTAFW, UALTAFW, UMODIFW, HMODIFW, SMODIFW, HORAIMPO, ESTTRANS, BDMODIFW, Entidad, Codigo, FechaCarga, CtaBanc, Hora, Comp, TipoVal, Ident, CodBco, Pendiente, Importe, IdComp, idValor, BDAltaFW, Obs
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..Fecha ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Entidad ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FechaCarga ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CtaBanc ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Hora ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Comp ) + "'" + ',' + transform( &lcCursor..TipoVal ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..Ident ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CodBco ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + Transform( iif( &lcCursor..Pendiente, 1, 0 )) + ',' + transform( &lcCursor..Importe ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..IdComp ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..idValor ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDAltaFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Obs ) + "'"
lcValoresCampos = substr(lcValoresCampos,2) 

				this.oConexion.EjecutarSql( [Insert into ZooLogic.REGCTA ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
				this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'REGISTRODECUENTA'
		if This.ActualizaEnRecepcion()
	endif
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
		lcRetorno = lcRetorno + ' - Código: ' + transform( &tcCursor..Codigo     )
		Return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EsAliasDeProceso( tcAlias As String, tcPrefijo as string ) As Boolean
		local llRetorno as Boolean, lcAlias as String, lcPrefijo As String
		llRetorno = .F.
		lcAlias = upper( alltrim( tcAlias ) )
		lcPrefijo = upper( alltrim( tcPrefijo ) )
		Do Case
			Case  lcAlias == lcPrefijo + 'REGISTRODECUENTA'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'REGISTRODECUENTA_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'REGISTRODECUENTA_OBS'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_RegCta')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'REGISTRODECUENTA'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..Codigo
		llCondicion = isnull( lxVar )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad REGISTRODECUENTA. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'REGISTRODECUENTA'
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
			lcCursor = This.oEntidad.cPrefijoRecibir + 'REGISTRODECUENTA'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  Fecha     
		* Validar ANTERIORES A 1/1/1753  FechaCarga
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_RegCta') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_RegCta
Create Table ZooLogic.TablaTrabajo_RegCta ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fectrans" datetime  null, 
"faltafw" datetime  null, 
"fmodifw" datetime  null, 
"fecimpo" datetime  null, 
"fecexpo" datetime  null, 
"fecha" datetime  null, 
"haltafw" char( 8 )  null, 
"horaexpo" char( 8 )  null, 
"saltafw" char( 7 )  null, 
"vmodifw" char( 13 )  null, 
"zadsfw" varchar(max)  null, 
"valtafw" char( 13 )  null, 
"ualtafw" char( 100 )  null, 
"umodifw" char( 100 )  null, 
"hmodifw" char( 8 )  null, 
"smodifw" char( 7 )  null, 
"horaimpo" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"bdmodifw" char( 8 )  null, 
"entidad" char( 40 )  null, 
"codigo" char( 20 )  null, 
"fechacarga" datetime  null, 
"ctabanc" char( 5 )  null, 
"hora" char( 5 )  null, 
"comp" char( 250 )  null, 
"tipoval" numeric( 2, 0 )  null, 
"ident" char( 30 )  null, 
"codbco" char( 30 )  null, 
"pendiente" bit  null, 
"importe" numeric( 15, 2 )  null, 
"idcomp" char( 38 )  null, 
"idvalor" char( 38 )  null, 
"bdaltafw" char( 8 )  null, 
"obs" varchar(max)  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_RegCta' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_RegCta' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'REGISTRODECUENTA'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		with loManejador
			if this.oEntidad.VerificarContexto( 'CB' )
			else
				.AgregarMapeo('Nrolinea','Nrolinea')
			endif
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('fecha','fecha')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('entidad','entidad')
			.AgregarMapeo('codigo','codigo')
			.AgregarMapeo('fechacarga','fechacarga')
			.AgregarMapeo('ctabanc','ctabanc')
			.AgregarMapeo('hora','hora')
			.AgregarMapeo('comp','comp')
			.AgregarMapeo('tipoval','tipoval')
			.AgregarMapeo('ident','ident')
			.AgregarMapeo('codbco','codbco')
			.AgregarMapeo('pendiente','pendiente')
			.AgregarMapeo('importe','importe')
			.AgregarMapeo('idcomp','idcomp')
			.AgregarMapeo('idvalor','idvalor')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('obs','obs')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_RegCta'
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
				Update t Set t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FECHA = isnull( d.FECHA, t.FECHA ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.ENTIDAD = isnull( d.ENTIDAD, t.ENTIDAD ),t.CODIGO = isnull( d.CODIGO, t.CODIGO ),t.FECHACARGA = isnull( d.FECHACARGA, t.FECHACARGA ),t.CTABANC = isnull( d.CTABANC, t.CTABANC ),t.HORA = isnull( d.HORA, t.HORA ),t.COMP = isnull( d.COMP, t.COMP ),t.TIPOVAL = isnull( d.TIPOVAL, t.TIPOVAL ),t.IDENT = isnull( d.IDENT, t.IDENT ),t.CODBCO = isnull( d.CODBCO, t.CODBCO ),t.PENDIENTE = isnull( d.PENDIENTE, t.PENDIENTE ),t.IMPORTE = isnull( d.IMPORTE, t.IMPORTE ),t.IDCOMP = isnull( d.IDCOMP, t.IDCOMP ),t.IDVALOR = isnull( d.IDVALOR, t.IDVALOR ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.OBS = isnull( d.OBS, t.OBS )
					from ZooLogic.REGCTA t inner join deleted d 
							 on t.Codigo = d.Codigo
				-- Fin Updates
				insert into ZooLogic.REGCTA(Fectrans,Faltafw,Fmodifw,Fecimpo,Fecexpo,Fecha,Haltafw,Horaexpo,Saltafw,Vmodifw,Zadsfw,Valtafw,Ualtafw,Umodifw,Hmodifw,Smodifw,Horaimpo,Esttrans,Bdmodifw,Entidad,Codigo,Fechacarga,Ctabanc,Hora,Comp,Tipoval,Ident,Codbco,Pendiente,Importe,Idcomp,Idvalor,Bdaltafw,Obs)
					Select isnull( d.FECTRANS,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FMODIFW,''),isnull( d.FECIMPO,''),isnull( d.FECEXPO,''),isnull( d.FECHA,''),convert( char(8), getdate(), 108 ),isnull( d.HORAEXPO,''),isnull( d.SALTAFW,''),isnull( d.VMODIFW,''),isnull( d.ZADSFW,''),isnull( d.VALTAFW,''),isnull( d.UALTAFW,''),isnull( d.UMODIFW,''),isnull( d.HMODIFW,''),isnull( d.SMODIFW,''),isnull( d.HORAIMPO,''),isnull( d.ESTTRANS,''),isnull( d.BDMODIFW,''),isnull( d.ENTIDAD,''),isnull( d.CODIGO,''),isnull( d.FECHACARGA,''),isnull( d.CTABANC,''),isnull( d.HORA,''),isnull( d.COMP,''),isnull( d.TIPOVAL,0),isnull( d.IDENT,''),isnull( d.CODBCO,''),isnull( d.PENDIENTE,0),isnull( d.IMPORTE,0),isnull( d.IDCOMP,''),isnull( d.IDVALOR,''),isnull( d.BDALTAFW,''),isnull( d.OBS,'')
						From deleted d left join ZooLogic.REGCTA pk 
							 on d.Codigo = pk.Codigo
						Where pk.Codigo Is Null 
				-- Fin Inserts
			End
		EndText
		Return lcCadena
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	protected Function EliminarTablasDeTrabajo( toConexion as Object ) as void
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_RegCta') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_RegCta
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_REGISTRODECUENTA' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_REGISTRODECUENTA.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_REGISTRODECUENTA.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_REGISTRODECUENTA.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_REGISTRODECUENTA.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_REGISTRODECUENTA.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fecha = GoLibrerias.ObtenerFechaFormateada( nvl( c_REGISTRODECUENTA.Fecha, ctod( '  /  /    ' ) ) )
					.Horaaltafw = nvl( c_REGISTRODECUENTA.Horaaltafw, [] )
					.Horaexpo = nvl( c_REGISTRODECUENTA.Horaexpo, [] )
					.Seriealtafw = nvl( c_REGISTRODECUENTA.Seriealtafw, [] )
					.Versionmodificacionfw = nvl( c_REGISTRODECUENTA.Versionmodificacionfw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Versionaltafw = nvl( c_REGISTRODECUENTA.Versionaltafw, [] )
					.Usuarioaltafw = nvl( c_REGISTRODECUENTA.Usuarioaltafw, [] )
					.Usuariomodificacionfw = nvl( c_REGISTRODECUENTA.Usuariomodificacionfw, [] )
					.Horamodificacionfw = nvl( c_REGISTRODECUENTA.Horamodificacionfw, [] )
					.Seriemodificacionfw = nvl( c_REGISTRODECUENTA.Seriemodificacionfw, [] )
					.Horaimpo = nvl( c_REGISTRODECUENTA.Horaimpo, [] )
					.Estadotransferencia = nvl( c_REGISTRODECUENTA.Estadotransferencia, [] )
					.Basededatosmodificacionfw = nvl( c_REGISTRODECUENTA.Basededatosmodificacionfw, [] )
					.Entidadcomprobante = nvl( c_REGISTRODECUENTA.Entidadcomprobante, [] )
					.Codigo = nvl( c_REGISTRODECUENTA.Codigo, [] )
					.Fechacargaoperacion = GoLibrerias.ObtenerFechaFormateada( nvl( c_REGISTRODECUENTA.Fechacargaoperacion, ctod( '  /  /    ' ) ) )
					.Cuentabancaria_PK =  nvl( c_REGISTRODECUENTA.Cuentabancaria, [] )
					.Hora = nvl( c_REGISTRODECUENTA.Hora, [] )
					.Comprobante = nvl( c_REGISTRODECUENTA.Comprobante, [] )
					.Tipovalor = nvl( c_REGISTRODECUENTA.Tipovalor, 0 )
					.Identificador = nvl( c_REGISTRODECUENTA.Identificador, [] )
					.Codigobanco = nvl( c_REGISTRODECUENTA.Codigobanco, [] )
					.Pendiente = nvl( c_REGISTRODECUENTA.Pendiente, .F. )
					.Importe = nvl( c_REGISTRODECUENTA.Importe, 0 )
					.Idcomprobante = nvl( c_REGISTRODECUENTA.Idcomprobante, [] )
					.Idvalor = nvl( c_REGISTRODECUENTA.Idvalor, [] )
					.Basededatosaltafw = nvl( c_REGISTRODECUENTA.Basededatosaltafw, [] )
					lcValor = This.ObtenerMemo( 'c_Observacion')
					.Observacion = lcValor 
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
	function ActualizarLosNROItemDeLosDetalles() as void
		local loDetalle as object, loItem as object, lnContadorNroItem as integer, lnIndex as integer
		
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function ObtenerMemo( tcTabla as String ) as string
		local lcAtributo as string
		lcAtributo = strtran( tcTabla, 'c_', '' )
		return c_REGISTRODECUENTA.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.REGCTA' )
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
								from ZooLogic.REGCTA 
								Where   REGCTA.CODIGO != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "REGCTA", "", lcCursor, set("Datasession") )
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
			"Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Fecha" as "Fecha", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Saltafw" as "Seriealtafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Entidad" as "Entidadcomprobante", "Codigo" as "Codigo", "Fechacarga" as "Fechacargaoperacion", "Ctabanc" as "Cuentabancaria", "Hora" as "Hora", "Comp" as "Comprobante", "Tipoval" as "Tipovalor", "Ident" as "Identificador", "Codbco" as "Codigobanco", "Pendiente" as "Pendiente", "Importe" as "Importe", "Idcomp" as "Idcomprobante", "Idvalor" as "Idvalor", "Bdaltafw" as "Basededatosaltafw", "Obs" as "Observacion"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.REGCTA 
								Where   REGCTA.CODIGO != ''
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
	Tabla = 'REGCTA'
	Filtro = " REGCTA.CODIGO != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " REGCTA.CODIGO != ''"
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
	<row entidad="REGISTRODECUENTA                        " atributo="FECHATRANSFERENCIA                      " tabla="REGCTA         " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha de novedad                                                                                                                                                " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODECUENTA                        " atributo="FECHAALTAFW                             " tabla="REGCTA         " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODECUENTA                        " atributo="FECHAMODIFICACIONFW                     " tabla="REGCTA         " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODECUENTA                        " atributo="FECHAIMPO                               " tabla="REGCTA         " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODECUENTA                        " atributo="FECHAEXPO                               " tabla="REGCTA         " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODECUENTA                        " atributo="FECHA                                   " tabla="REGCTA         " campo="FECHA     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="10" etiqueta="Fecha de conciliación                                                                                                                                           " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODECUENTA                        " atributo="HORAALTAFW                              " tabla="REGCTA         " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODECUENTA                        " atributo="HORAEXPO                                " tabla="REGCTA         " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODECUENTA                        " atributo="SERIEALTAFW                             " tabla="REGCTA         " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODECUENTA                        " atributo="VERSIONMODIFICACIONFW                   " tabla="REGCTA         " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODECUENTA                        " atributo="ZADSFW                                  " tabla="REGCTA         " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODECUENTA                        " atributo="VERSIONALTAFW                           " tabla="REGCTA         " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODECUENTA                        " atributo="USUARIOALTAFW                           " tabla="REGCTA         " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODECUENTA                        " atributo="USUARIOMODIFICACIONFW                   " tabla="REGCTA         " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODECUENTA                        " atributo="HORAMODIFICACIONFW                      " tabla="REGCTA         " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODECUENTA                        " atributo="SERIEMODIFICACIONFW                     " tabla="REGCTA         " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODECUENTA                        " atributo="HORAIMPO                                " tabla="REGCTA         " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODECUENTA                        " atributo="ESTADOTRANSFERENCIA                     " tabla="REGCTA         " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado de novedad                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODECUENTA                        " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="REGCTA         " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODECUENTA                        " atributo="ENTIDADCOMPROBANTE                      " tabla="REGCTA         " campo="ENTIDAD   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="2" etiqueta="Entidad de comprobante relacionado                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODECUENTA                        " atributo="CODIGO                                  " tabla="REGCTA         " campo="CODIGO    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="2" etiqueta="Código                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODECUENTA                        " atributo="FECHACARGAOPERACION                     " tabla="REGCTA         " campo="FECHACARGA" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goServicios.Librerias.ObtenerFecha()                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="12" etiqueta="Fecha de carga de operación                                                                                                                                     " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODECUENTA                        " atributo="CUENTABANCARIA                          " tabla="REGCTA         " campo="CTABANC   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CUENTABANCARIA                          " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="6" etiqueta="Cuenta bancaria                                                                                                                                                 " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODECUENTA                        " atributo="HORA                                    " tabla="REGCTA         " campo="HORA      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="5" decimales="0" valorsugerido="=left( goservicios.libreRIAS.obtenerhora() , 5)                                                                                                                                                                                                               " obligatorio="true" admitebusqueda="14" etiqueta="Hora                                                                                                                                                            " dominio="HORA                          " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODECUENTA                        " atributo="NUMEROCUENTA                            " tabla="CTABAN         " campo="CBNUM     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="18" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="8" etiqueta="Número de cuenta bancaria                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="CuentaBancaria.Numero                                                                                                                                                                                                                                         " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" left join CtaBan on REGCTA.CTABANC = CtaBan.CBCod                                                                                                                                                                                                            " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODECUENTA                        " atributo="COMPROBANTE                             " tabla="REGCTA         " campo="COMP      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="250" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="4" etiqueta="Comprobante relacionado                                                                                                                                         " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODECUENTA                        " atributo="MONEDA                                  " tabla="CTABAN         " campo="CBMONEDA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="MONEDA                                  " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="10" etiqueta="Moneda                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="CuentaBancaria.MonedaCuenta                                                                                                                                                                                                                                   " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" left join CtaBan on REGCTA.CTABANC = CtaBan.CBCod                                                                                                                                                                                                            " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODECUENTA                        " atributo="TIPOVALOR                               " tabla="REGCTA         " campo="TIPOVAL   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="16" etiqueta="Tipo de valor                                                                                                                                                   " dominio="COMBOTIPODEVALORES            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODECUENTA                        " atributo="IDENTIFICADOR                           " tabla="REGCTA         " campo="IDENT     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="18" etiqueta="Identificador para conciliar                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODECUENTA                        " atributo="CODIGOBANCO                             " tabla="REGCTA         " campo="CODBCO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="20" etiqueta="Código asignado por el banco                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODECUENTA                        " atributo="PENDIENTE                               " tabla="REGCTA         " campo="PENDIENTE " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="26" etiqueta="Pendiente de pago                                                                                                                                               " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODECUENTA                        " atributo="IMPORTE                                 " tabla="REGCTA         " campo="IMPORTE   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="22" etiqueta="Importe                                                                                                                                                         " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="8" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODECUENTA                        " atributo="IDCOMPROBANTE                           " tabla="REGCTA         " campo="IDCOMP    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Id comprobante relacionado                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="11" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODECUENTA                        " atributo="IDVALOR                                 " tabla="REGCTA         " campo="IDVALOR   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Id valor relacionado                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="12" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODECUENTA                        " atributo="BASEDEDATOSALTAFW                       " tabla="REGCTA         " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="24" etiqueta="Base de datos                                                                                                                                                   " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="13" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODECUENTA                        " atributo="OBSERVACION                             " tabla="REGCTA         " campo="OBS       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Observación                                                                                                                                                     " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="14" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUENTABANCARIA                          " atributo="DESCRIPCION                             " tabla="CTABAN         " campo="CBDES     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="7" etiqueta="Detalle Cue.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CTABAN On REGCTA.CTABANC = CTABAN.CBCod And  CTABAN.CBCOD != ''                                                                                                                                                                                    " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="10" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MONEDA                                  " atributo="DESCRIPCION                             " tabla="MONEDA         " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="11" etiqueta="Detalle Mon.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join MONEDA On CTABAN.CBMONEDA = MONEDA.Codigo And  MONEDA.CODIGO != ''                                                                                                                                                                                 " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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