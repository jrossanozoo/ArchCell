
define class Din_EntidadPLANDECUENTASAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_PLANDECUENTAS'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = []
	cExpresionCCPorCampos = []
	cTagClaveCandidata = ''
	cTagClavePk = '_CTAPK'
	cTablaPrincipal = 'PLANCUENTA'
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
			local  lxPlancuentaFecimpo, lxPlancuentaFmodifw, lxPlancuentaFaltafw, lxPlancuentaFecexpo, lxPlancuentaFectrans, lxPlancuentaCtacodigo, lxPlancuentaHoraexpo, lxPlancuentaHaltafw, lxPlancuentaSaltafw, lxPlancuentaHoraimpo, lxPlancuentaVmodifw, lxPlancuentaZadsfw, lxPlancuentaValtafw, lxPlancuentaUmodifw, lxPlancuentaSmodifw, lxPlancuentaUaltafw, lxPlancuentaHmodifw, lxPlancuentaBdmodifw, lxPlancuentaBdaltafw, lxPlancuentaEsttrans, lxPlancuentaCtamayor, lxPlancuentaObs, lxPlancuentaCtanumero, lxPlancuentaDescrip, lxPlancuentaApodo, lxPlancuentaCtaimput, lxPlancuentaCtatipo, lxPlancuentaDerefund, lxPlancuentaReqccosto, lxPlancuentaCtarefund, lxPlancuentaAjustainf, lxPlancuentaCajuste, lxPlancuentaIndiceaju
				lxPlancuentaFecimpo =  .Fechaimpo			lxPlancuentaFmodifw =  .Fechamodificacionfw			lxPlancuentaFaltafw =  .Fechaaltafw			lxPlancuentaFecexpo =  .Fechaexpo			lxPlancuentaFectrans =  .Fechatransferencia			lxPlancuentaCtacodigo =  .Codigo			lxPlancuentaHoraexpo =  .Horaexpo			lxPlancuentaHaltafw =  .Horaaltafw			lxPlancuentaSaltafw =  .Seriealtafw			lxPlancuentaHoraimpo =  .Horaimpo			lxPlancuentaVmodifw =  .Versionmodificacionfw			lxPlancuentaZadsfw =  .Zadsfw			lxPlancuentaValtafw =  .Versionaltafw			lxPlancuentaUmodifw =  .Usuariomodificacionfw			lxPlancuentaSmodifw =  .Seriemodificacionfw			lxPlancuentaUaltafw =  .Usuarioaltafw			lxPlancuentaHmodifw =  .Horamodificacionfw			lxPlancuentaBdmodifw =  .Basededatosmodificacionfw			lxPlancuentaBdaltafw =  .Basededatosaltafw			lxPlancuentaEsttrans =  .Estadotransferencia			lxPlancuentaCtamayor =  upper( .Mayor_PK ) 			lxPlancuentaObs =  .Obs			lxPlancuentaCtanumero =  .Cuenta			lxPlancuentaDescrip =  .Descripcion			lxPlancuentaApodo =  .Apodo			lxPlancuentaCtaimput =  .Esimputable			lxPlancuentaCtatipo =  .Tipo			lxPlancuentaDerefund =  .Derefundicion			lxPlancuentaReqccosto =  .Requierecdc			lxPlancuentaCtarefund =  .Esderefundicion			lxPlancuentaAjustainf =  .Ajustaporinflacion			lxPlancuentaCajuste =  upper( .CuentaAjustePorInflacion_PK ) 			lxPlancuentaIndiceaju =  upper( .IndicesInflacion_PK ) 
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxPlancuentaCtacodigo = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.PLANCUENTA ( "Fecimpo","Fmodifw","Faltafw","Fecexpo","Fectrans","Ctacodigo","Horaexpo","Haltafw","Saltafw","Horaimpo","Vmodifw","Zadsfw","Valtafw","Umodifw","Smodifw","Ualtafw","Hmodifw","Bdmodifw","Bdaltafw","Esttrans","Ctamayor","Obs","Ctanumero","Descrip","Apodo","Ctaimput","Ctatipo","Derefund","Reqccosto","Ctarefund","Ajustainf","Cajuste","Indiceaju" ) values ( <<"'" + this.ConvertirDateSql( lxPlancuentaFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxPlancuentaFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxPlancuentaFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxPlancuentaFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxPlancuentaFectrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPlancuentaCtacodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPlancuentaHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPlancuentaHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPlancuentaSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPlancuentaHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPlancuentaVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPlancuentaZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPlancuentaValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPlancuentaUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPlancuentaSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPlancuentaUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPlancuentaHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPlancuentaBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPlancuentaBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPlancuentaEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPlancuentaCtamayor ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPlancuentaObs ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPlancuentaCtanumero ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPlancuentaDescrip ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPlancuentaApodo ) + "'" >>, <<iif( lxPlancuentaCtaimput, 1, 0 ) >>, <<lxPlancuentaCtatipo >>, <<lxPlancuentaDerefund >>, <<iif( lxPlancuentaReqccosto, 1, 0 ) >>, <<iif( lxPlancuentaCtarefund, 1, 0 ) >>, <<iif( lxPlancuentaAjustainf, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxPlancuentaCajuste ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPlancuentaIndiceaju ) + "'" >> )
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
			local  lxPlancuentaFecimpo, lxPlancuentaFmodifw, lxPlancuentaFaltafw, lxPlancuentaFecexpo, lxPlancuentaFectrans, lxPlancuentaCtacodigo, lxPlancuentaHoraexpo, lxPlancuentaHaltafw, lxPlancuentaSaltafw, lxPlancuentaHoraimpo, lxPlancuentaVmodifw, lxPlancuentaZadsfw, lxPlancuentaValtafw, lxPlancuentaUmodifw, lxPlancuentaSmodifw, lxPlancuentaUaltafw, lxPlancuentaHmodifw, lxPlancuentaBdmodifw, lxPlancuentaBdaltafw, lxPlancuentaEsttrans, lxPlancuentaCtamayor, lxPlancuentaObs, lxPlancuentaCtanumero, lxPlancuentaDescrip, lxPlancuentaApodo, lxPlancuentaCtaimput, lxPlancuentaCtatipo, lxPlancuentaDerefund, lxPlancuentaReqccosto, lxPlancuentaCtarefund, lxPlancuentaAjustainf, lxPlancuentaCajuste, lxPlancuentaIndiceaju
				lxPlancuentaFecimpo =  .Fechaimpo			lxPlancuentaFmodifw =  .Fechamodificacionfw			lxPlancuentaFaltafw =  .Fechaaltafw			lxPlancuentaFecexpo =  .Fechaexpo			lxPlancuentaFectrans =  .Fechatransferencia			lxPlancuentaCtacodigo =  .Codigo			lxPlancuentaHoraexpo =  .Horaexpo			lxPlancuentaHaltafw =  .Horaaltafw			lxPlancuentaSaltafw =  .Seriealtafw			lxPlancuentaHoraimpo =  .Horaimpo			lxPlancuentaVmodifw =  .Versionmodificacionfw			lxPlancuentaZadsfw =  .Zadsfw			lxPlancuentaValtafw =  .Versionaltafw			lxPlancuentaUmodifw =  .Usuariomodificacionfw			lxPlancuentaSmodifw =  .Seriemodificacionfw			lxPlancuentaUaltafw =  .Usuarioaltafw			lxPlancuentaHmodifw =  .Horamodificacionfw			lxPlancuentaBdmodifw =  .Basededatosmodificacionfw			lxPlancuentaBdaltafw =  .Basededatosaltafw			lxPlancuentaEsttrans =  .Estadotransferencia			lxPlancuentaCtamayor =  upper( .Mayor_PK ) 			lxPlancuentaObs =  .Obs			lxPlancuentaCtanumero =  .Cuenta			lxPlancuentaDescrip =  .Descripcion			lxPlancuentaApodo =  .Apodo			lxPlancuentaCtaimput =  .Esimputable			lxPlancuentaCtatipo =  .Tipo			lxPlancuentaDerefund =  .Derefundicion			lxPlancuentaReqccosto =  .Requierecdc			lxPlancuentaCtarefund =  .Esderefundicion			lxPlancuentaAjustainf =  .Ajustaporinflacion			lxPlancuentaCajuste =  upper( .CuentaAjustePorInflacion_PK ) 			lxPlancuentaIndiceaju =  upper( .IndicesInflacion_PK ) 
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()
			lxValorClavePrimaria = .oEntidad.CODIGO
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ZooLogic.PLANCUENTA set "Fecimpo" = <<"'" + this.ConvertirDateSql( lxPlancuentaFecimpo ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxPlancuentaFmodifw ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxPlancuentaFaltafw ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxPlancuentaFecexpo ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxPlancuentaFectrans ) + "'">>,"Ctacodigo" = <<"'" + this.FormatearTextoSql( lxPlancuentaCtacodigo ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxPlancuentaHoraexpo ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxPlancuentaHaltafw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxPlancuentaSaltafw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxPlancuentaHoraimpo ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxPlancuentaVmodifw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxPlancuentaZadsfw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxPlancuentaValtafw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxPlancuentaUmodifw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxPlancuentaSmodifw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxPlancuentaUaltafw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxPlancuentaHmodifw ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxPlancuentaBdmodifw ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxPlancuentaBdaltafw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxPlancuentaEsttrans ) + "'">>,"Ctamayor" = <<"'" + this.FormatearTextoSql( lxPlancuentaCtamayor ) + "'">>,"Obs" = <<"'" + this.FormatearTextoSql( lxPlancuentaObs ) + "'">>,"Ctanumero" = <<"'" + this.FormatearTextoSql( lxPlancuentaCtanumero ) + "'">>,"Descrip" = <<"'" + this.FormatearTextoSql( lxPlancuentaDescrip ) + "'">>,"Apodo" = <<"'" + this.FormatearTextoSql( lxPlancuentaApodo ) + "'">>,"Ctaimput" = <<iif( lxPlancuentaCtaimput, 1, 0 )>>,"Ctatipo" = <<lxPlancuentaCtatipo>>,"Derefund" = <<lxPlancuentaDerefund>>,"Reqccosto" = <<iif( lxPlancuentaReqccosto, 1, 0 )>>,"Ctarefund" = <<iif( lxPlancuentaCtarefund, 1, 0 )>>,"Ajustainf" = <<iif( lxPlancuentaAjustainf, 1, 0 )>>,"Cajuste" = <<"'" + this.FormatearTextoSql( lxPlancuentaCajuste ) + "'">>,"Indiceaju" = <<"'" + this.FormatearTextoSql( lxPlancuentaIndiceaju ) + "'">> where "Ctacodigo" = <<"'" + this.FormatearTextoSql( lxPlancuentaCtacodigo ) + "'">> and  PLANCUENTA.CTACODIGO != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 ctacodigo from ZooLogic.PLANCUENTA where " + this.ConvertirFuncionesSql( " PLANCUENTA.CTACODIGO != ''" ) )
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
			Local lxPlancuentaCtacodigo
			lxPlancuentaCtacodigo = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Ctacodigo" as "Codigo", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Ctamayor" as "Mayor", "Obs" as "Obs", "Ctanumero" as "Cuenta", "Descrip" as "Descripcion", "Apodo" as "Apodo", "Ctaimput" as "Esimputable", "Ctatipo" as "Tipo", "Derefund" as "Derefundicion", "Reqccosto" as "Requierecdc", "Ctarefund" as "Esderefundicion", "Ajustainf" as "Ajustaporinflacion", "Cajuste" as "Cuentaajusteporinflacion", "Indiceaju" as "Indicesinflacion" from ZooLogic.PLANCUENTA where "Ctacodigo" = <<"'" + this.FormatearTextoSql( lxPlancuentaCtacodigo ) + "'">> and  PLANCUENTA.CTACODIGO != ''
			endtext
			use in select('c_PLANDECUENTAS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_PLANDECUENTAS', set( 'Datasession' ) )

			if reccount( 'c_PLANDECUENTAS' ) = 0
				llRetorno = .f.
			else
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxPlancuentaCtacodigo as Variant
		llRetorno = .t.
		lxPlancuentaCtacodigo = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.PLANCUENTA where "Ctacodigo" = <<"'" + this.FormatearTextoSql( lxPlancuentaCtacodigo ) + "'">> and  PLANCUENTA.CTACODIGO != ''
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
				lcOrden =  .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Ctacodigo" as "Codigo", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Ctamayor" as "Mayor", "Obs" as "Obs", "Ctanumero" as "Cuenta", "Descrip" as "Descripcion", "Apodo" as "Apodo", "Ctaimput" as "Esimputable", "Ctatipo" as "Tipo", "Derefund" as "Derefundicion", "Reqccosto" as "Requierecdc", "Ctarefund" as "Esderefundicion", "Ajustainf" as "Ajustaporinflacion", "Cajuste" as "Cuentaajusteporinflacion", "Indiceaju" as "Indicesinflacion" from ZooLogic.PLANCUENTA where  PLANCUENTA.CTACODIGO != '' order by ctacodigo
			endtext
			use in select('c_PLANDECUENTAS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_PLANDECUENTAS', set( 'Datasession' ) )
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
				lcOrden =  .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Ctacodigo" as "Codigo", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Ctamayor" as "Mayor", "Obs" as "Obs", "Ctanumero" as "Cuenta", "Descrip" as "Descripcion", "Apodo" as "Apodo", "Ctaimput" as "Esimputable", "Ctatipo" as "Tipo", "Derefund" as "Derefundicion", "Reqccosto" as "Requierecdc", "Ctarefund" as "Esderefundicion", "Ajustainf" as "Ajustaporinflacion", "Cajuste" as "Cuentaajusteporinflacion", "Indiceaju" as "Indicesinflacion" from ZooLogic.PLANCUENTA where  funciones.padr( ctacodigo, 30, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  PLANCUENTA.CTACODIGO != '' order by ctacodigo
			endtext
			use in select('c_PLANDECUENTAS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_PLANDECUENTAS', set( 'Datasession' ) )
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
				lcOrden =  .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Ctacodigo" as "Codigo", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Ctamayor" as "Mayor", "Obs" as "Obs", "Ctanumero" as "Cuenta", "Descrip" as "Descripcion", "Apodo" as "Apodo", "Ctaimput" as "Esimputable", "Ctatipo" as "Tipo", "Derefund" as "Derefundicion", "Reqccosto" as "Requierecdc", "Ctarefund" as "Esderefundicion", "Ajustainf" as "Ajustaporinflacion", "Cajuste" as "Cuentaajusteporinflacion", "Indiceaju" as "Indicesinflacion" from ZooLogic.PLANCUENTA where  funciones.padr( ctacodigo, 30, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  PLANCUENTA.CTACODIGO != '' order by ctacodigo desc
			endtext
			use in select('c_PLANDECUENTAS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_PLANDECUENTAS', set( 'Datasession' ) )
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
				lcOrden =  .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Ctacodigo" as "Codigo", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Ctamayor" as "Mayor", "Obs" as "Obs", "Ctanumero" as "Cuenta", "Descrip" as "Descripcion", "Apodo" as "Apodo", "Ctaimput" as "Esimputable", "Ctatipo" as "Tipo", "Derefund" as "Derefundicion", "Reqccosto" as "Requierecdc", "Ctarefund" as "Esderefundicion", "Ajustainf" as "Ajustaporinflacion", "Cajuste" as "Cuentaajusteporinflacion", "Indiceaju" as "Indicesinflacion" from ZooLogic.PLANCUENTA where  PLANCUENTA.CTACODIGO != '' order by ctacodigo desc
			endtext
			use in select('c_PLANDECUENTAS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_PLANDECUENTAS', set( 'Datasession' ) )
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
			lcXml = this.oConexion.EjecutarSql( "select Fecimpo,Fmodifw,Faltafw,Fecexpo,Fectrans,Ctacodigo,Horaexpo,Haltafw,Saltafw,Horaimpo,Vmodifw" + ;
",Zadsfw,Valtafw,Umodifw,Smodifw,Ualtafw,Hmodifw,Bdmodifw,Bdaltafw,Esttrans,Ctamayor,Obs,Ctanumero,De" + ;
"scrip,Apodo,Ctaimput,Ctatipo,Derefund,Reqccosto,Ctarefund,Ajustainf,Cajuste,Indiceaju" + ;
" from ZooLogic.PLANCUENTA where  PLANCUENTA.CTACODIGO != '' and " + lcFiltro )
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
			local  lxPlancuentaFecimpo, lxPlancuentaFmodifw, lxPlancuentaFaltafw, lxPlancuentaFecexpo, lxPlancuentaFectrans, lxPlancuentaCtacodigo, lxPlancuentaHoraexpo, lxPlancuentaHaltafw, lxPlancuentaSaltafw, lxPlancuentaHoraimpo, lxPlancuentaVmodifw, lxPlancuentaZadsfw, lxPlancuentaValtafw, lxPlancuentaUmodifw, lxPlancuentaSmodifw, lxPlancuentaUaltafw, lxPlancuentaHmodifw, lxPlancuentaBdmodifw, lxPlancuentaBdaltafw, lxPlancuentaEsttrans, lxPlancuentaCtamayor, lxPlancuentaObs, lxPlancuentaCtanumero, lxPlancuentaDescrip, lxPlancuentaApodo, lxPlancuentaCtaimput, lxPlancuentaCtatipo, lxPlancuentaDerefund, lxPlancuentaReqccosto, lxPlancuentaCtarefund, lxPlancuentaAjustainf, lxPlancuentaCajuste, lxPlancuentaIndiceaju
				lxPlancuentaFecimpo = ctod( '  /  /    ' )			lxPlancuentaFmodifw = ctod( '  /  /    ' )			lxPlancuentaFaltafw = ctod( '  /  /    ' )			lxPlancuentaFecexpo = ctod( '  /  /    ' )			lxPlancuentaFectrans = ctod( '  /  /    ' )			lxPlancuentaCtacodigo = []			lxPlancuentaHoraexpo = []			lxPlancuentaHaltafw = []			lxPlancuentaSaltafw = []			lxPlancuentaHoraimpo = []			lxPlancuentaVmodifw = []			lxPlancuentaZadsfw = []			lxPlancuentaValtafw = []			lxPlancuentaUmodifw = []			lxPlancuentaSmodifw = []			lxPlancuentaUaltafw = []			lxPlancuentaHmodifw = []			lxPlancuentaBdmodifw = []			lxPlancuentaBdaltafw = []			lxPlancuentaEsttrans = []			lxPlancuentaCtamayor = []			lxPlancuentaObs = []			lxPlancuentaCtanumero = []			lxPlancuentaDescrip = []			lxPlancuentaApodo = []			lxPlancuentaCtaimput = .F.			lxPlancuentaCtatipo = 0			lxPlancuentaDerefund = 0			lxPlancuentaReqccosto = .F.			lxPlancuentaCtarefund = .F.			lxPlancuentaAjustainf = .F.			lxPlancuentaCajuste = []			lxPlancuentaIndiceaju = []
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( [delete from ZooLogic.PLANCUENTA where "ctacodigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'PLANCUENTA' + '_' + tcCampo
			lcMemoAscii = ''

			lnIndice = alen(.aSqlMemos)
			lnIndice = iif(lnIndice = 1, 1, lnIndice + 1 )
			dimension .aSqlMemos(lnIndice)

			.aSqlMemos(lnIndice) = 'delete from ' + lcTabla + ' where ctacodigo = ' + txValorClavePrimaria
			.GenerarSentenciasInsertTablaMemo( lcValor, lcTabla, txValorClavePrimaria )
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerSentenciaInsertMemo( tcTabla as String, txValorClavePrimaria as String, tcOrden as String, tcTexto as String ) as String
		return "Insert  into " + tcTabla + "(ctacodigo, Orden, texto ) values ( " + txValorClavePrimaria + "," + tcOrden + ",'"+ tcTexto + "')"
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosEntidad( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  PLANCUENTA.CTACODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Ctacodigo" as "Codigo", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Ctamayor" as "Mayor", "Obs" as "Obs", "Ctanumero" as "Cuenta", "Descrip" as "Descripcion", "Apodo" as "Apodo", "Ctaimput" as "Esimputable", "Ctatipo" as "Tipo", "Derefund" as "Derefundicion", "Reqccosto" as "Requierecdc", "Ctarefund" as "Esderefundicion", "Ajustainf" as "Ajustaporinflacion", "Cajuste" as "Cuentaajusteporinflacion", "Indiceaju" as "Indicesinflacion"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'PLANCUENTA', '', tnTope )
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
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'FECHAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECEXPO AS FECHAEXPO'
				Case lcAtributo == 'FECHATRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRANS AS FECHATRANSFERENCIA'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CTACODIGO AS CODIGO'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'MAYOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CTAMAYOR AS MAYOR'
				Case lcAtributo == 'OBS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'OBS AS OBS'
				Case lcAtributo == 'CUENTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CTANUMERO AS CUENTA'
				Case lcAtributo == 'DESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCRIP AS DESCRIPCION'
				Case lcAtributo == 'APODO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'APODO AS APODO'
				Case lcAtributo == 'ESIMPUTABLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CTAIMPUT AS ESIMPUTABLE'
				Case lcAtributo == 'TIPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CTATIPO AS TIPO'
				Case lcAtributo == 'DEREFUNDICION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DEREFUND AS DEREFUNDICION'
				Case lcAtributo == 'REQUIERECDC'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'REQCCOSTO AS REQUIERECDC'
				Case lcAtributo == 'ESDEREFUNDICION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CTAREFUND AS ESDEREFUNDICION'
				Case lcAtributo == 'AJUSTAPORINFLACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AJUSTAINF AS AJUSTAPORINFLACION'
				Case lcAtributo == 'CUENTAAJUSTEPORINFLACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CAJUSTE AS CUENTAAJUSTEPORINFLACION'
				Case lcAtributo == 'INDICESINFLACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'INDICEAJU AS INDICESINFLACION'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEXPO'
				lcCampo = 'FECEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CTACODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'MAYOR'
				lcCampo = 'CTAMAYOR'
			Case upper( alltrim( tcAtributo ) ) == 'OBS'
				lcCampo = 'OBS'
			Case upper( alltrim( tcAtributo ) ) == 'CUENTA'
				lcCampo = 'CTANUMERO'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCION'
				lcCampo = 'DESCRIP'
			Case upper( alltrim( tcAtributo ) ) == 'APODO'
				lcCampo = 'APODO'
			Case upper( alltrim( tcAtributo ) ) == 'ESIMPUTABLE'
				lcCampo = 'CTAIMPUT'
			Case upper( alltrim( tcAtributo ) ) == 'TIPO'
				lcCampo = 'CTATIPO'
			Case upper( alltrim( tcAtributo ) ) == 'DEREFUNDICION'
				lcCampo = 'DEREFUND'
			Case upper( alltrim( tcAtributo ) ) == 'REQUIERECDC'
				lcCampo = 'REQCCOSTO'
			Case upper( alltrim( tcAtributo ) ) == 'ESDEREFUNDICION'
				lcCampo = 'CTAREFUND'
			Case upper( alltrim( tcAtributo ) ) == 'AJUSTAPORINFLACION'
				lcCampo = 'AJUSTAINF'
			Case upper( alltrim( tcAtributo ) ) == 'CUENTAAJUSTEPORINFLACION'
				lcCampo = 'CAJUSTE'
			Case upper( alltrim( tcAtributo ) ) == 'INDICESINFLACION'
				lcCampo = 'INDICEAJU'
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
			local  lxPlancuentaFecimpo, lxPlancuentaFmodifw, lxPlancuentaFaltafw, lxPlancuentaFecexpo, lxPlancuentaFectrans, lxPlancuentaCtacodigo, lxPlancuentaHoraexpo, lxPlancuentaHaltafw, lxPlancuentaSaltafw, lxPlancuentaHoraimpo, lxPlancuentaVmodifw, lxPlancuentaZadsfw, lxPlancuentaValtafw, lxPlancuentaUmodifw, lxPlancuentaSmodifw, lxPlancuentaUaltafw, lxPlancuentaHmodifw, lxPlancuentaBdmodifw, lxPlancuentaBdaltafw, lxPlancuentaEsttrans, lxPlancuentaCtamayor, lxPlancuentaObs, lxPlancuentaCtanumero, lxPlancuentaDescrip, lxPlancuentaApodo, lxPlancuentaCtaimput, lxPlancuentaCtatipo, lxPlancuentaDerefund, lxPlancuentaReqccosto, lxPlancuentaCtarefund, lxPlancuentaAjustainf, lxPlancuentaCajuste, lxPlancuentaIndiceaju
				lxPlancuentaFecimpo =  .Fechaimpo			lxPlancuentaFmodifw =  .Fechamodificacionfw			lxPlancuentaFaltafw =  .Fechaaltafw			lxPlancuentaFecexpo =  .Fechaexpo			lxPlancuentaFectrans =  .Fechatransferencia			lxPlancuentaCtacodigo =  .Codigo			lxPlancuentaHoraexpo =  .Horaexpo			lxPlancuentaHaltafw =  .Horaaltafw			lxPlancuentaSaltafw =  .Seriealtafw			lxPlancuentaHoraimpo =  .Horaimpo			lxPlancuentaVmodifw =  .Versionmodificacionfw			lxPlancuentaZadsfw =  .Zadsfw			lxPlancuentaValtafw =  .Versionaltafw			lxPlancuentaUmodifw =  .Usuariomodificacionfw			lxPlancuentaSmodifw =  .Seriemodificacionfw			lxPlancuentaUaltafw =  .Usuarioaltafw			lxPlancuentaHmodifw =  .Horamodificacionfw			lxPlancuentaBdmodifw =  .Basededatosmodificacionfw			lxPlancuentaBdaltafw =  .Basededatosaltafw			lxPlancuentaEsttrans =  .Estadotransferencia			lxPlancuentaCtamayor =  upper( .Mayor_PK ) 			lxPlancuentaObs =  .Obs			lxPlancuentaCtanumero =  .Cuenta			lxPlancuentaDescrip =  .Descripcion			lxPlancuentaApodo =  .Apodo			lxPlancuentaCtaimput =  .Esimputable			lxPlancuentaCtatipo =  .Tipo			lxPlancuentaDerefund =  .Derefundicion			lxPlancuentaReqccosto =  .Requierecdc			lxPlancuentaCtarefund =  .Esderefundicion			lxPlancuentaAjustainf =  .Ajustaporinflacion			lxPlancuentaCajuste =  upper( .CuentaAjustePorInflacion_PK ) 			lxPlancuentaIndiceaju =  upper( .IndicesInflacion_PK ) 
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.PLANCUENTA ( "Fecimpo","Fmodifw","Faltafw","Fecexpo","Fectrans","Ctacodigo","Horaexpo","Haltafw","Saltafw","Horaimpo","Vmodifw","Zadsfw","Valtafw","Umodifw","Smodifw","Ualtafw","Hmodifw","Bdmodifw","Bdaltafw","Esttrans","Ctamayor","Obs","Ctanumero","Descrip","Apodo","Ctaimput","Ctatipo","Derefund","Reqccosto","Ctarefund","Ajustainf","Cajuste","Indiceaju" ) values ( <<"'" + this.ConvertirDateSql( lxPlancuentaFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxPlancuentaFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxPlancuentaFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxPlancuentaFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxPlancuentaFectrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPlancuentaCtacodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPlancuentaHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPlancuentaHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPlancuentaSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPlancuentaHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPlancuentaVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPlancuentaZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPlancuentaValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPlancuentaUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPlancuentaSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPlancuentaUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPlancuentaHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPlancuentaBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPlancuentaBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPlancuentaEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPlancuentaCtamayor ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPlancuentaObs ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPlancuentaCtanumero ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPlancuentaDescrip ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPlancuentaApodo ) + "'" >>, <<iif( lxPlancuentaCtaimput, 1, 0 ) >>, <<lxPlancuentaCtatipo >>, <<lxPlancuentaDerefund >>, <<iif( lxPlancuentaReqccosto, 1, 0 ) >>, <<iif( lxPlancuentaCtarefund, 1, 0 ) >>, <<iif( lxPlancuentaAjustainf, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxPlancuentaCajuste ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPlancuentaIndiceaju ) + "'" >> )
		endtext
		loColeccion.cTabla = 'PLANCUENTA' 
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
			local  lxPlancuentaFecimpo, lxPlancuentaFmodifw, lxPlancuentaFaltafw, lxPlancuentaFecexpo, lxPlancuentaFectrans, lxPlancuentaCtacodigo, lxPlancuentaHoraexpo, lxPlancuentaHaltafw, lxPlancuentaSaltafw, lxPlancuentaHoraimpo, lxPlancuentaVmodifw, lxPlancuentaZadsfw, lxPlancuentaValtafw, lxPlancuentaUmodifw, lxPlancuentaSmodifw, lxPlancuentaUaltafw, lxPlancuentaHmodifw, lxPlancuentaBdmodifw, lxPlancuentaBdaltafw, lxPlancuentaEsttrans, lxPlancuentaCtamayor, lxPlancuentaObs, lxPlancuentaCtanumero, lxPlancuentaDescrip, lxPlancuentaApodo, lxPlancuentaCtaimput, lxPlancuentaCtatipo, lxPlancuentaDerefund, lxPlancuentaReqccosto, lxPlancuentaCtarefund, lxPlancuentaAjustainf, lxPlancuentaCajuste, lxPlancuentaIndiceaju
				lxPlancuentaFecimpo =  .Fechaimpo			lxPlancuentaFmodifw =  .Fechamodificacionfw			lxPlancuentaFaltafw =  .Fechaaltafw			lxPlancuentaFecexpo =  .Fechaexpo			lxPlancuentaFectrans =  .Fechatransferencia			lxPlancuentaCtacodigo =  .Codigo			lxPlancuentaHoraexpo =  .Horaexpo			lxPlancuentaHaltafw =  .Horaaltafw			lxPlancuentaSaltafw =  .Seriealtafw			lxPlancuentaHoraimpo =  .Horaimpo			lxPlancuentaVmodifw =  .Versionmodificacionfw			lxPlancuentaZadsfw =  .Zadsfw			lxPlancuentaValtafw =  .Versionaltafw			lxPlancuentaUmodifw =  .Usuariomodificacionfw			lxPlancuentaSmodifw =  .Seriemodificacionfw			lxPlancuentaUaltafw =  .Usuarioaltafw			lxPlancuentaHmodifw =  .Horamodificacionfw			lxPlancuentaBdmodifw =  .Basededatosmodificacionfw			lxPlancuentaBdaltafw =  .Basededatosaltafw			lxPlancuentaEsttrans =  .Estadotransferencia			lxPlancuentaCtamayor =  upper( .Mayor_PK ) 			lxPlancuentaObs =  .Obs			lxPlancuentaCtanumero =  .Cuenta			lxPlancuentaDescrip =  .Descripcion			lxPlancuentaApodo =  .Apodo			lxPlancuentaCtaimput =  .Esimputable			lxPlancuentaCtatipo =  .Tipo			lxPlancuentaDerefund =  .Derefundicion			lxPlancuentaReqccosto =  .Requierecdc			lxPlancuentaCtarefund =  .Esderefundicion			lxPlancuentaAjustainf =  .Ajustaporinflacion			lxPlancuentaCajuste =  upper( .CuentaAjustePorInflacion_PK ) 			lxPlancuentaIndiceaju =  upper( .IndicesInflacion_PK ) 
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Ctacodigo" = ] + lcValorClavePrimariaString  + [ and  PLANCUENTA.CTACODIGO != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.PLANCUENTA set "Fecimpo" = <<"'" + this.ConvertirDateSql( lxPlancuentaFecimpo ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxPlancuentaFmodifw ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxPlancuentaFaltafw ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxPlancuentaFecexpo ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxPlancuentaFectrans ) + "'">>, "Ctacodigo" = <<"'" + this.FormatearTextoSql( lxPlancuentaCtacodigo ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxPlancuentaHoraexpo ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxPlancuentaHaltafw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxPlancuentaSaltafw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxPlancuentaHoraimpo ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxPlancuentaVmodifw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxPlancuentaZadsfw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxPlancuentaValtafw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxPlancuentaUmodifw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxPlancuentaSmodifw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxPlancuentaUaltafw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxPlancuentaHmodifw ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxPlancuentaBdmodifw ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxPlancuentaBdaltafw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxPlancuentaEsttrans ) + "'">>, "Ctamayor" = <<"'" + this.FormatearTextoSql( lxPlancuentaCtamayor ) + "'">>, "Obs" = <<"'" + this.FormatearTextoSql( lxPlancuentaObs ) + "'">>, "Ctanumero" = <<"'" + this.FormatearTextoSql( lxPlancuentaCtanumero ) + "'">>, "Descrip" = <<"'" + this.FormatearTextoSql( lxPlancuentaDescrip ) + "'">>, "Apodo" = <<"'" + this.FormatearTextoSql( lxPlancuentaApodo ) + "'">>, "Ctaimput" = <<iif( lxPlancuentaCtaimput, 1, 0 )>>, "Ctatipo" = <<lxPlancuentaCtatipo>>, "Derefund" = <<lxPlancuentaDerefund>>, "Reqccosto" = <<iif( lxPlancuentaReqccosto, 1, 0 )>>, "Ctarefund" = <<iif( lxPlancuentaCtarefund, 1, 0 )>>, "Ajustainf" = <<iif( lxPlancuentaAjustainf, 1, 0 )>>, "Cajuste" = <<"'" + this.FormatearTextoSql( lxPlancuentaCajuste ) + "'">>, "Indiceaju" = <<"'" + this.FormatearTextoSql( lxPlancuentaIndiceaju ) + "'">> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'PLANCUENTA' 
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

			lcFiltro = ["Ctacodigo" = ] + lcValorClavePrimariaString  + [ and  PLANCUENTA.CTACODIGO != '']
		loColeccion.Agregar( 'delete from ZooLogic.PLANCUENTA where ' + lcFiltro )
			loColeccion.cTabla = 'PLANCUENTA' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.PLANCUENTA where  PLANCUENTA.CTACODIGO != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.PLANCUENTA where ctacodigo = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  PLANCUENTA.CTACODIGO != ''" )
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
		lcCursor = This.oEntidad.cPrefijoRecibir + 'PLANDECUENTAS'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.PLANCUENTA Where ctacodigo = ] + "'" + this.FormatearTextoSql( &lcCursor..ctacodigo ) + "'", 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					this.oConexion.EjecutarSql( [UPDATE ZooLogic.PLANCUENTA set  FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, ctacodigo = ] + "'" + this.FormatearTextoSql( &lcCursor..ctacodigo ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, ctamayor = ] + "'" + this.FormatearTextoSql( &lcCursor..ctamayor ) + "'"+ [, Obs = ] + "'" + this.FormatearTextoSql( &lcCursor..Obs ) + "'"+ [, ctanumero = ] + "'" + this.FormatearTextoSql( &lcCursor..ctanumero ) + "'"+ [, descrip = ] + "'" + this.FormatearTextoSql( &lcCursor..descrip ) + "'"+ [, apodo = ] + "'" + this.FormatearTextoSql( &lcCursor..apodo ) + "'"+ [, ctaimput = ] + Transform( iif( &lcCursor..ctaimput, 1, 0 ))+ [, ctatipo = ] + transform( &lcCursor..ctatipo )+ [, Derefund = ] + transform( &lcCursor..Derefund )+ [, reqccosto = ] + Transform( iif( &lcCursor..reqccosto, 1, 0 ))+ [, ctarefund = ] + Transform( iif( &lcCursor..ctarefund, 1, 0 ))+ [, AjustaInf = ] + Transform( iif( &lcCursor..AjustaInf, 1, 0 ))+ [, CAjuste = ] + "'" + this.FormatearTextoSql( &lcCursor..CAjuste ) + "'"+ [, IndiceAju = ] + "'" + this.FormatearTextoSql( &lcCursor..IndiceAju ) + "'" + [ Where ctacodigo = ] + "'" + this.FormatearTextoSql( &lcCursor..ctacodigo ) + "'" )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versi�n m�s actual en la base de datos ).', tlLoguear )
				endIf
			else
				Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
				Text to lcCampos noShow
					 FECIMPO, FMODIFW, FALTAFW, FECEXPO, FECTRANS, ctacodigo, HORAEXPO, HALTAFW, SALTAFW, HORAIMPO, VMODIFW, ZADSFW, VALTAFW, UMODIFW, SMODIFW, UALTAFW, HMODIFW, BDMODIFW, BDALTAFW, ESTTRANS, ctamayor, Obs, ctanumero, descrip, apodo, ctaimput, ctatipo, Derefund, reqccosto, ctarefund, AjustaInf, CAjuste, IndiceAju
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ctacodigo ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ctamayor ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..Obs ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ctanumero ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..descrip ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..apodo ) + "'" + ',' + Transform( iif( &lcCursor..ctaimput, 1, 0 )) + ',' + transform( &lcCursor..ctatipo ) + ',' + transform( &lcCursor..Derefund ) + ',' + Transform( iif( &lcCursor..reqccosto, 1, 0 ))
lcValoresCampos = lcValoresCampos  + ',' + Transform( iif( &lcCursor..ctarefund, 1, 0 )) + ',' + Transform( iif( &lcCursor..AjustaInf, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..CAjuste ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..IndiceAju ) + "'"
lcValoresCampos = substr(lcValoresCampos,2) 

				this.oConexion.EjecutarSql( [Insert into ZooLogic.PLANCUENTA ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
				this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'PLANDECUENTAS'
		if This.ActualizaEnRecepcion()
	endif
	Use in select( 'cExistentes' )
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearCursorMemo( tcCursorACrear as String, tcTablaConMemo as String ) as Void
		create cursor &tcCursorACrear ( ctacodigo C (30) , Orden N(16), texto C(80))
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirComponentes() As Void
		
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function ObtenerIdentificadorParaLoguear( tcCursor as String ) As String
		local lcRetorno as String, lnCC as String , loCC as Object, lni as Integer, lcSecuencia as String
		lcRetorno = this.oEntidad.cDescripcion 
		lcRetorno = lcRetorno + ' - Cuenta: ' + transform( &tcCursor..ctacodigo  )
		Return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EsAliasDeProceso( tcAlias As String, tcPrefijo as string ) As Boolean
		local llRetorno as Boolean, lcAlias as String, lcPrefijo As String
		llRetorno = .F.
		lcAlias = upper( alltrim( tcAlias ) )
		lcPrefijo = upper( alltrim( tcPrefijo ) )
		Do Case
			Case  lcAlias == lcPrefijo + 'PLANDECUENTAS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'PLANDECUENTAS_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'PLANDECUENTAS_OBS'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_plancuenta')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'PLANDECUENTAS'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..ctacodigo
		llCondicion = isnull( lxVar )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad PLANDECUENTAS. Hay un error en el dise�o de importaci�n.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el dise�o.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'PLANDECUENTAS'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		select recno() as _Rec, * from &lcCursor into cursor CurConRecno
		select max( _Rec ) as Maximo,ctacodigo as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( ctacodigo, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		Use in select( 'CurConRecno' )
		Use in select( 'RepMax' )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDatosInvalidos( toConexion as Object ) as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'PLANDECUENTAS'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_plancuenta') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_plancuenta
Create Table ZooLogic.TablaTrabajo_plancuenta ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fecimpo" datetime  null, 
"fmodifw" datetime  null, 
"faltafw" datetime  null, 
"fecexpo" datetime  null, 
"fectrans" datetime  null, 
"ctacodigo" char( 30 )  null, 
"horaexpo" char( 8 )  null, 
"haltafw" char( 8 )  null, 
"saltafw" char( 7 )  null, 
"horaimpo" char( 8 )  null, 
"vmodifw" char( 13 )  null, 
"zadsfw" varchar(max)  null, 
"valtafw" char( 13 )  null, 
"umodifw" char( 100 )  null, 
"smodifw" char( 7 )  null, 
"ualtafw" char( 100 )  null, 
"hmodifw" char( 8 )  null, 
"bdmodifw" char( 8 )  null, 
"bdaltafw" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"ctamayor" char( 30 )  null, 
"obs" varchar(max)  null, 
"ctanumero" char( 30 )  null, 
"descrip" char( 100 )  null, 
"apodo" char( 50 )  null, 
"ctaimput" bit  null, 
"ctatipo" numeric( 1, 0 )  null, 
"derefund" numeric( 1, 0 )  null, 
"reqccosto" bit  null, 
"ctarefund" bit  null, 
"ajustainf" bit  null, 
"cajuste" char( 30 )  null, 
"indiceaju" char( 10 )  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_plancuenta' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_plancuenta' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'PLANDECUENTAS'
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
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('ctacodigo','ctacodigo')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('ctamayor','ctamayor')
			.AgregarMapeo('obs','obs')
			.AgregarMapeo('ctanumero','ctanumero')
			.AgregarMapeo('descrip','descrip')
			.AgregarMapeo('apodo','apodo')
			.AgregarMapeo('ctaimput','ctaimput')
			.AgregarMapeo('ctatipo','ctatipo')
			.AgregarMapeo('derefund','derefund')
			.AgregarMapeo('reqccosto','reqccosto')
			.AgregarMapeo('ctarefund','ctarefund')
			.AgregarMapeo('ajustainf','ajustainf')
			.AgregarMapeo('cajuste','cajuste')
			.AgregarMapeo('indiceaju','indiceaju')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_plancuenta'
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
				Update t Set t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.CTACODIGO = isnull( d.CTACODIGO, t.CTACODIGO ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.CTAMAYOR = isnull( d.CTAMAYOR, t.CTAMAYOR ),t.OBS = isnull( d.OBS, t.OBS ),t.CTANUMERO = isnull( d.CTANUMERO, t.CTANUMERO ),t.DESCRIP = isnull( d.DESCRIP, t.DESCRIP ),t.APODO = isnull( d.APODO, t.APODO ),t.CTAIMPUT = isnull( d.CTAIMPUT, t.CTAIMPUT ),t.CTATIPO = isnull( d.CTATIPO, t.CTATIPO ),t.DEREFUND = isnull( d.DEREFUND, t.DEREFUND ),t.REQCCOSTO = isnull( d.REQCCOSTO, t.REQCCOSTO ),t.CTAREFUND = isnull( d.CTAREFUND, t.CTAREFUND ),t.AJUSTAINF = isnull( d.AJUSTAINF, t.AJUSTAINF ),t.CAJUSTE = isnull( d.CAJUSTE, t.CAJUSTE ),t.INDICEAJU = isnull( d.INDICEAJU, t.INDICEAJU )
					from ZooLogic.PLANCUENTA t inner join deleted d 
							 on t.ctacodigo = d.ctacodigo
				-- Fin Updates
				insert into ZooLogic.PLANCUENTA(Fecimpo,Fmodifw,Faltafw,Fecexpo,Fectrans,Ctacodigo,Horaexpo,Haltafw,Saltafw,Horaimpo,Vmodifw,Zadsfw,Valtafw,Umodifw,Smodifw,Ualtafw,Hmodifw,Bdmodifw,Bdaltafw,Esttrans,Ctamayor,Obs,Ctanumero,Descrip,Apodo,Ctaimput,Ctatipo,Derefund,Reqccosto,Ctarefund,Ajustainf,Cajuste,Indiceaju)
					Select isnull( d.FECIMPO,''),isnull( d.FMODIFW,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FECEXPO,''),isnull( d.FECTRANS,''),isnull( d.CTACODIGO,''),isnull( d.HORAEXPO,''),convert( char(8), getdate(), 108 ),isnull( d.SALTAFW,''),isnull( d.HORAIMPO,''),isnull( d.VMODIFW,''),isnull( d.ZADSFW,''),isnull( d.VALTAFW,''),isnull( d.UMODIFW,''),isnull( d.SMODIFW,''),isnull( d.UALTAFW,''),isnull( d.HMODIFW,''),isnull( d.BDMODIFW,''),isnull( d.BDALTAFW,''),isnull( d.ESTTRANS,''),isnull( d.CTAMAYOR,''),isnull( d.OBS,''),isnull( d.CTANUMERO,''),isnull( d.DESCRIP,''),isnull( d.APODO,''),isnull( d.CTAIMPUT,0),isnull( d.CTATIPO,0),isnull( d.DEREFUND,0),isnull( d.REQCCOSTO,0),isnull( d.CTAREFUND,0),isnull( d.AJUSTAINF,0),isnull( d.CAJUSTE,''),isnull( d.INDICEAJU,'')
						From deleted d left join ZooLogic.PLANCUENTA pk 
							 on d.ctacodigo = pk.ctacodigo
						Where pk.ctacodigo Is Null 
				-- Fin Inserts
			End
		EndText
		Return lcCadena
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	protected Function EliminarTablasDeTrabajo( toConexion as Object ) as void
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_plancuenta') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_plancuenta
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_PLANDECUENTAS' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_PLANDECUENTAS.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_PLANDECUENTAS.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_PLANDECUENTAS.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_PLANDECUENTAS.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_PLANDECUENTAS.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Codigo = nvl( c_PLANDECUENTAS.Codigo, [] )
					.Horaexpo = nvl( c_PLANDECUENTAS.Horaexpo, [] )
					.Horaaltafw = nvl( c_PLANDECUENTAS.Horaaltafw, [] )
					.Seriealtafw = nvl( c_PLANDECUENTAS.Seriealtafw, [] )
					.Horaimpo = nvl( c_PLANDECUENTAS.Horaimpo, [] )
					.Versionmodificacionfw = nvl( c_PLANDECUENTAS.Versionmodificacionfw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Versionaltafw = nvl( c_PLANDECUENTAS.Versionaltafw, [] )
					.Usuariomodificacionfw = nvl( c_PLANDECUENTAS.Usuariomodificacionfw, [] )
					.Seriemodificacionfw = nvl( c_PLANDECUENTAS.Seriemodificacionfw, [] )
					.Usuarioaltafw = nvl( c_PLANDECUENTAS.Usuarioaltafw, [] )
					.Horamodificacionfw = nvl( c_PLANDECUENTAS.Horamodificacionfw, [] )
					.Basededatosmodificacionfw = nvl( c_PLANDECUENTAS.Basededatosmodificacionfw, [] )
					.Basededatosaltafw = nvl( c_PLANDECUENTAS.Basededatosaltafw, [] )
					.Estadotransferencia = nvl( c_PLANDECUENTAS.Estadotransferencia, [] )
					.Mayor_PK =  nvl( c_PLANDECUENTAS.Mayor, [] )
					lcValor = This.ObtenerMemo( 'c_Obs')
					.Obs = lcValor 
					.Cuenta = nvl( c_PLANDECUENTAS.Cuenta, [] )
					.Descripcion = nvl( c_PLANDECUENTAS.Descripcion, [] )
					.Apodo = nvl( c_PLANDECUENTAS.Apodo, [] )
					.Esimputable = nvl( c_PLANDECUENTAS.Esimputable, .F. )
					.Tipo = nvl( c_PLANDECUENTAS.Tipo, 0 )
					.Derefundicion = nvl( c_PLANDECUENTAS.Derefundicion, 0 )
					.Requierecdc = nvl( c_PLANDECUENTAS.Requierecdc, .F. )
					.Esderefundicion = nvl( c_PLANDECUENTAS.Esderefundicion, .F. )
					.Ajustaporinflacion = nvl( c_PLANDECUENTAS.Ajustaporinflacion, .F. )
					.Cuentaajusteporinflacion_PK =  nvl( c_PLANDECUENTAS.Cuentaajusteporinflacion, [] )
					.Indicesinflacion_PK =  nvl( c_PLANDECUENTAS.Indicesinflacion, [] )
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
		return c_PLANDECUENTAS.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.PLANCUENTA' )
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
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "ctacodigo"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
		text to lcSQL textmerge noshow
				SELECT nro,totalRegistros,ctacodigo as Id
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    ctacodigo from (
							select * 
								from ZooLogic.PLANCUENTA 
								Where   PLANCUENTA.CTACODIGO != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "PLANCUENTA", "", lcCursor, set("Datasession") )
		lcXml = this.CursorAXml( lcCursor )
		
		use in select( lcCursor )
		
		Return lcXml 
		
	endfunc
	*-----------------------------------------------------------------------------------------
	function ObtenerDatosEntidadPaginado( tcOrderBy as String, tcFiltro as String, tnCantidad as Integer, tnPagina as Integer )  as String
		local lcOrderBy as String, lnCuantos as Integer, lnPagina as Integer, lnTope as Integer, lnDesde as Integer, lcSQL as String, lcCursor as String, lcXml as String
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "ctacodigo"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
			text to lcAtributos textmerge noshow
			"Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Ctacodigo" as "Codigo", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Ctamayor" as "Mayor", "Obs" as "Obs", "Ctanumero" as "Cuenta", "Descrip" as "Descripcion", "Apodo" as "Apodo", "Ctaimput" as "Esimputable", "Ctatipo" as "Tipo", "Derefund" as "Derefundicion", "Reqccosto" as "Requierecdc", "Ctarefund" as "Esderefundicion", "Ajustainf" as "Ajustaporinflacion", "Cajuste" as "Cuentaajusteporinflacion", "Indiceaju" as "Indicesinflacion"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.PLANCUENTA 
								Where   PLANCUENTA.CTACODIGO != ''
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
	Tabla = 'PLANCUENTA'
	Filtro = " PLANCUENTA.CTACODIGO != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " PLANCUENTA.CTACODIGO != ''"
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
	<row entidad="PLANDECUENTAS                           " atributo="FECHAIMPO                               " tabla="PLANCUENTA     " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importaci�n                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PLANDECUENTAS                           " atributo="FECHAMODIFICACIONFW                     " tabla="PLANCUENTA     " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificaci�n                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PLANDECUENTAS                           " atributo="FECHAALTAFW                             " tabla="PLANCUENTA     " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PLANDECUENTAS                           " atributo="FECHAEXPO                               " tabla="PLANCUENTA     " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportaci�n                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PLANDECUENTAS                           " atributo="FECHATRANSFERENCIA                      " tabla="PLANCUENTA     " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha de novedad                                                                                                                                                " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PLANDECUENTAS                           " atributo="CODIGO                                  " tabla="PLANCUENTA     " campo="CTACODIGO " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="2" etiqueta="Cuenta                                                                                                                                                          " dominio="CODIGOSOLONUMEROS             " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PLANDECUENTAS                           " atributo="HORAEXPO                                " tabla="PLANCUENTA     " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportaci�n                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PLANDECUENTAS                           " atributo="HORAALTAFW                              " tabla="PLANCUENTA     " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PLANDECUENTAS                           " atributo="SERIEALTAFW                             " tabla="PLANCUENTA     " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PLANDECUENTAS                           " atributo="HORAIMPO                                " tabla="PLANCUENTA     " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importaci�n                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PLANDECUENTAS                           " atributo="VERSIONMODIFICACIONFW                   " tabla="PLANCUENTA     " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versi�n modificaci�n                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PLANDECUENTAS                           " atributo="ZADSFW                                  " tabla="PLANCUENTA     " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PLANDECUENTAS                           " atributo="VERSIONALTAFW                           " tabla="PLANCUENTA     " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versi�n alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PLANDECUENTAS                           " atributo="USUARIOMODIFICACIONFW                   " tabla="PLANCUENTA     " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificaci�n                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PLANDECUENTAS                           " atributo="SERIEMODIFICACIONFW                     " tabla="PLANCUENTA     " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificaci�n                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PLANDECUENTAS                           " atributo="USUARIOALTAFW                           " tabla="PLANCUENTA     " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PLANDECUENTAS                           " atributo="HORAMODIFICACIONFW                      " tabla="PLANCUENTA     " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificaci�n                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PLANDECUENTAS                           " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="PLANCUENTA     " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificaci�n                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PLANDECUENTAS                           " atributo="BASEDEDATOSALTAFW                       " tabla="PLANCUENTA     " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PLANDECUENTAS                           " atributo="ESTADOTRANSFERENCIA                     " tabla="PLANCUENTA     " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado de novedad                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PLANDECUENTAS                           " atributo="LISTADECUENTAS                          " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="Plan de cuentas                                                                                                                                                 " dominio="COMBO                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PLANDECUENTAS                           " atributo="MAYOR                                   " tabla="PLANCUENTA     " campo="CTAMAYOR  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="PLANDECUENTAS                           " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="6" etiqueta="Mayor                                                                                                                                                           " dominio="CODIGOSOLONUMEROS             " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="&quot; plancuenta.ctaimput = .f. &quot;                                                                                                                                                                           " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PLANDECUENTAS                           " atributo="OBS                                     " tabla="PLANCUENTA     " campo="OBS       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="402" etiqueta="Observaciones                                                                                                                                                   " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PLANDECUENTAS                           " atributo="CUENTA                                  " tabla="PLANCUENTA     " campo="CTANUMERO " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="404" etiqueta="C�digo                                                                                                                                                          " dominio="CARACTERSOLONUMEROS           " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PLANDECUENTAS                           " atributo="DESCRIPCION                             " tabla="PLANCUENTA     " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="4" etiqueta="Descripci�n                                                                                                                                                     " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PLANDECUENTAS                           " atributo="APODO                                   " tabla="PLANCUENTA     " campo="APODO     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="8" etiqueta="Alias                                                                                                                                                           " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PLANDECUENTAS                           " atributo="ESIMPUTABLE                             " tabla="PLANCUENTA     " campo="CTAIMPUT  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="406" etiqueta="Es imputable                                                                                                                                                    " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PLANDECUENTAS                           " atributo="TIPO                                    " tabla="PLANCUENTA     " campo="CTATIPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="408" etiqueta="Tipo de cuenta                                                                                                                                                  " dominio="COMBOXML                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PLANDECUENTAS                           " atributo="DEREFUNDICION                           " tabla="PLANCUENTA     " campo="DEREFUND  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="1                                                                                                                                                                                                                                                             " obligatorio="false" admitebusqueda="410" etiqueta="Tipo de refundici�n                                                                                                                                             " dominio="COMBOXML                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PLANDECUENTAS                           " atributo="REQUIERECDC                             " tabla="PLANCUENTA     " campo="REQCCOSTO " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="412" etiqueta="Permite centro de costos                                                                                                                                        " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="8" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PLANDECUENTAS                           " atributo="ESDEREFUNDICION                         " tabla="PLANCUENTA     " campo="CTAREFUND " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="9" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PLANDECUENTAS                           " atributo="AJUSTAPORINFLACION                      " tabla="PLANCUENTA     " campo="AJUSTAINF " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="414" etiqueta="Ajusta por inflaci�n                                                                                                                                            " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="9" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PLANDECUENTAS                           " atributo="CUENTAAJUSTEPORINFLACION                " tabla="PLANCUENTA     " campo="CAJUSTE   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="PLANDECUENTAS                           " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="416" etiqueta="Cuenta de ajuste                                                                                                                                                " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="10" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PLANDECUENTAS                           " atributo="INDICESINFLACION                        " tabla="PLANCUENTA     " campo="INDICEAJU " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="INDICESINFLACION                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="418" etiqueta="Indice                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="11" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INDICESINFLACION                        " atributo="DESCRIPCION                             " tabla="INDICES        " campo="DESCIP    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="419" etiqueta="Detalle Ind.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join INDICES On PLANCUENTA.INDICEAJU = INDICES.Codigo And  INDICES.CODIGO != ''                                                                                                                                                                         " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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