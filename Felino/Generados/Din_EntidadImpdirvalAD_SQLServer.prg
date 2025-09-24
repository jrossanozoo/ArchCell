
define class Din_EntidadIMPDIRVALAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_IMPDIRVAL'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = []
	cExpresionCCPorCampos = []
	cTagClaveCandidata = ''
	cTagClavePk = '_IDVPK'
	cTablaPrincipal = 'IMPDIRVAL'
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
			local  lxImpdirvalFectrans, lxImpdirvalFmodifw, lxImpdirvalFaltafw, lxImpdirvalFecexpo, lxImpdirvalFecimpo, lxImpdirvalTimestamp, lxImpdirvalHoraexpo, lxImpdirvalHoraimpo, lxImpdirvalHaltafw, lxImpdirvalUaltafw, lxImpdirvalVmodifw, lxImpdirvalZadsfw, lxImpdirvalValtafw, lxImpdirvalUmodifw, lxImpdirvalSaltafw, lxImpdirvalSmodifw, lxImpdirvalHmodifw, lxImpdirvalEsttrans, lxImpdirvalBdaltafw, lxImpdirvalBdmodifw, lxImpdirvalTipoval, lxImpdirvalNumero, lxImpdirvalDescripcio, lxImpdirvalValdesde, lxImpdirvalValhasta, lxImpdirvalMondesde, lxImpdirvalTipotarj, lxImpdirvalMonhasta, lxImpdirvalOpedesde, lxImpdirvalPcuenta, lxImpdirvalOpehasta, lxImpdirvalImportanci, lxImpdirvalTipoasi, lxImpdirvalObs
				lxImpdirvalFectrans =  .Fechatransferencia			lxImpdirvalFmodifw =  .Fechamodificacionfw			lxImpdirvalFaltafw =  .Fechaaltafw			lxImpdirvalFecexpo =  .Fechaexpo			lxImpdirvalFecimpo =  .Fechaimpo			lxImpdirvalTimestamp = goLibrerias.ObtenerTimestamp()			lxImpdirvalHoraexpo =  .Horaexpo			lxImpdirvalHoraimpo =  .Horaimpo			lxImpdirvalHaltafw =  .Horaaltafw			lxImpdirvalUaltafw =  .Usuarioaltafw			lxImpdirvalVmodifw =  .Versionmodificacionfw			lxImpdirvalZadsfw =  .Zadsfw			lxImpdirvalValtafw =  .Versionaltafw			lxImpdirvalUmodifw =  .Usuariomodificacionfw			lxImpdirvalSaltafw =  .Seriealtafw			lxImpdirvalSmodifw =  .Seriemodificacionfw			lxImpdirvalHmodifw =  .Horamodificacionfw			lxImpdirvalEsttrans =  .Estadotransferencia			lxImpdirvalBdaltafw =  .Basededatosaltafw			lxImpdirvalBdmodifw =  .Basededatosmodificacionfw			lxImpdirvalTipoval =  .Tipo			lxImpdirvalNumero =  .Numero			lxImpdirvalDescripcio =  .Descripcion			lxImpdirvalValdesde =  .F_valor_desde			lxImpdirvalValhasta =  .F_valor_hasta			lxImpdirvalMondesde =  .F_moneda_desde			lxImpdirvalTipotarj =  .Tipotarjeta			lxImpdirvalMonhasta =  .F_moneda_hasta			lxImpdirvalOpedesde =  .F_operadoradetarjeta_desde			lxImpdirvalPcuenta =  upper( .PlanDeCuentas_PK ) 			lxImpdirvalOpehasta =  .F_operadoradetarjeta_hasta			lxImpdirvalImportanci =  .Importancia			lxImpdirvalTipoasi =  .Tipodeasiento			lxImpdirvalObs =  .Observacion
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxImpdirvalNumero = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.IMPDIRVAL ( "Fectrans","Fmodifw","Faltafw","Fecexpo","Fecimpo","Timestamp","Horaexpo","Horaimpo","Haltafw","Ualtafw","Vmodifw","Zadsfw","Valtafw","Umodifw","Saltafw","Smodifw","Hmodifw","Esttrans","Bdaltafw","Bdmodifw","Tipoval","Numero","Descripcio","Valdesde","Valhasta","Mondesde","Tipotarj","Monhasta","Opedesde","Pcuenta","Opehasta","Importanci","Tipoasi","Obs" ) values ( <<"'" + this.ConvertirDateSql( lxImpdirvalFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxImpdirvalFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxImpdirvalFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxImpdirvalFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxImpdirvalFecimpo ) + "'" >>, <<lxImpdirvalTimestamp >>, <<"'" + this.FormatearTextoSql( lxImpdirvalHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirvalHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirvalHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirvalUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirvalVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirvalZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirvalValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirvalUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirvalSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirvalSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirvalHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirvalEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirvalBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirvalBdmodifw ) + "'" >>, <<lxImpdirvalTipoval >>, <<lxImpdirvalNumero >>, <<"'" + this.FormatearTextoSql( lxImpdirvalDescripcio ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirvalValdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirvalValhasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirvalMondesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirvalTipotarj ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirvalMonhasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirvalOpedesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirvalPcuenta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirvalOpehasta ) + "'" >>, <<lxImpdirvalImportanci >>, <<lxImpdirvalTipoasi >>, <<"'" + this.FormatearTextoSql( lxImpdirvalObs ) + "'" >> )
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
		this.ComprobarTransaccion()
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.NUMERO
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
		this.oEntidad.Timestamp = lxImpdirvalTimestamp
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
		return this.oEntidad.NUMERO
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function Actualizar() as boolean
	local loError as Exception, loEx as Exception, lxValorClavePrimaria as variant, lnI as Integer, loSentenciasTriggers as zoocoleccion OF zoocoleccion.prg, lcSentencia as string

		with this.oEntidad
			local  lxImpdirvalFectrans, lxImpdirvalFmodifw, lxImpdirvalFaltafw, lxImpdirvalFecexpo, lxImpdirvalFecimpo, lxImpdirvalTimestamp, lxImpdirvalHoraexpo, lxImpdirvalHoraimpo, lxImpdirvalHaltafw, lxImpdirvalUaltafw, lxImpdirvalVmodifw, lxImpdirvalZadsfw, lxImpdirvalValtafw, lxImpdirvalUmodifw, lxImpdirvalSaltafw, lxImpdirvalSmodifw, lxImpdirvalHmodifw, lxImpdirvalEsttrans, lxImpdirvalBdaltafw, lxImpdirvalBdmodifw, lxImpdirvalTipoval, lxImpdirvalNumero, lxImpdirvalDescripcio, lxImpdirvalValdesde, lxImpdirvalValhasta, lxImpdirvalMondesde, lxImpdirvalTipotarj, lxImpdirvalMonhasta, lxImpdirvalOpedesde, lxImpdirvalPcuenta, lxImpdirvalOpehasta, lxImpdirvalImportanci, lxImpdirvalTipoasi, lxImpdirvalObs
				lxImpdirvalFectrans =  .Fechatransferencia			lxImpdirvalFmodifw =  .Fechamodificacionfw			lxImpdirvalFaltafw =  .Fechaaltafw			lxImpdirvalFecexpo =  .Fechaexpo			lxImpdirvalFecimpo =  .Fechaimpo			lxImpdirvalTimestamp = goLibrerias.ObtenerTimestamp()			lxImpdirvalHoraexpo =  .Horaexpo			lxImpdirvalHoraimpo =  .Horaimpo			lxImpdirvalHaltafw =  .Horaaltafw			lxImpdirvalUaltafw =  .Usuarioaltafw			lxImpdirvalVmodifw =  .Versionmodificacionfw			lxImpdirvalZadsfw =  .Zadsfw			lxImpdirvalValtafw =  .Versionaltafw			lxImpdirvalUmodifw =  .Usuariomodificacionfw			lxImpdirvalSaltafw =  .Seriealtafw			lxImpdirvalSmodifw =  .Seriemodificacionfw			lxImpdirvalHmodifw =  .Horamodificacionfw			lxImpdirvalEsttrans =  .Estadotransferencia			lxImpdirvalBdaltafw =  .Basededatosaltafw			lxImpdirvalBdmodifw =  .Basededatosmodificacionfw			lxImpdirvalTipoval =  .Tipo			lxImpdirvalNumero =  .Numero			lxImpdirvalDescripcio =  .Descripcion			lxImpdirvalValdesde =  .F_valor_desde			lxImpdirvalValhasta =  .F_valor_hasta			lxImpdirvalMondesde =  .F_moneda_desde			lxImpdirvalTipotarj =  .Tipotarjeta			lxImpdirvalMonhasta =  .F_moneda_hasta			lxImpdirvalOpedesde =  .F_operadoradetarjeta_desde			lxImpdirvalPcuenta =  upper( .PlanDeCuentas_PK ) 			lxImpdirvalOpehasta =  .F_operadoradetarjeta_hasta			lxImpdirvalImportanci =  .Importancia			lxImpdirvalTipoasi =  .Tipodeasiento			lxImpdirvalObs =  .Observacion
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
			lxValorClavePrimaria = .oEntidad.NUMERO
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ZooLogic.IMPDIRVAL set "Fectrans" = <<"'" + this.ConvertirDateSql( lxImpdirvalFectrans ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxImpdirvalFmodifw ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxImpdirvalFaltafw ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxImpdirvalFecexpo ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxImpdirvalFecimpo ) + "'">>,"Timestamp" = <<lxImpdirvalTimestamp>>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxImpdirvalHoraexpo ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxImpdirvalHoraimpo ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxImpdirvalHaltafw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxImpdirvalUaltafw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxImpdirvalVmodifw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxImpdirvalZadsfw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxImpdirvalValtafw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxImpdirvalUmodifw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxImpdirvalSaltafw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxImpdirvalSmodifw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxImpdirvalHmodifw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxImpdirvalEsttrans ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxImpdirvalBdaltafw ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxImpdirvalBdmodifw ) + "'">>,"Tipoval" = <<lxImpdirvalTipoval>>,"Numero" = <<lxImpdirvalNumero>>,"Descripcio" = <<"'" + this.FormatearTextoSql( lxImpdirvalDescripcio ) + "'">>,"Valdesde" = <<"'" + this.FormatearTextoSql( lxImpdirvalValdesde ) + "'">>,"Valhasta" = <<"'" + this.FormatearTextoSql( lxImpdirvalValhasta ) + "'">>,"Mondesde" = <<"'" + this.FormatearTextoSql( lxImpdirvalMondesde ) + "'">>,"Tipotarj" = <<"'" + this.FormatearTextoSql( lxImpdirvalTipotarj ) + "'">>,"Monhasta" = <<"'" + this.FormatearTextoSql( lxImpdirvalMonhasta ) + "'">>,"Opedesde" = <<"'" + this.FormatearTextoSql( lxImpdirvalOpedesde ) + "'">>,"Pcuenta" = <<"'" + this.FormatearTextoSql( lxImpdirvalPcuenta ) + "'">>,"Opehasta" = <<"'" + this.FormatearTextoSql( lxImpdirvalOpehasta ) + "'">>,"Importanci" = <<lxImpdirvalImportanci>>,"Tipoasi" = <<lxImpdirvalTipoasi>>,"Obs" = <<"'" + this.FormatearTextoSql( lxImpdirvalObs ) + "'">> where "Numero" = <<lxImpdirvalNumero>> and  IMPDIRVAL.NUMERO != 0 << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
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
		this.oEntidad.Timestamp = lxImpdirvalTimestamp
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 NUMERO from ZooLogic.IMPDIRVAL where " + this.ConvertirFuncionesSql( " IMPDIRVAL.NUMERO != 0" ) )
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
			Local lxImpdirvalNumero
			lxImpdirvalNumero = .Numero

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Timestamp" as "Timestamp", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Ualtafw" as "Usuarioaltafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Tipoval" as "Tipo", "Numero" as "Numero", "Descripcio" as "Descripcion", "Valdesde" as "F_valor_desde", "Valhasta" as "F_valor_hasta", "Mondesde" as "F_moneda_desde", "Tipotarj" as "Tipotarjeta", "Monhasta" as "F_moneda_hasta", "Opedesde" as "F_operadoradetarjeta_desde", "Pcuenta" as "Plandecuentas", "Opehasta" as "F_operadoradetarjeta_hasta", "Importanci" as "Importancia", "Tipoasi" as "Tipodeasiento", "Obs" as "Observacion" from ZooLogic.IMPDIRVAL where "Numero" = <<lxImpdirvalNumero>> and  IMPDIRVAL.NUMERO != 0
			endtext
			use in select('c_IMPDIRVAL')
			this.oConexion.EjecutarSql( lcSentencia, 'c_IMPDIRVAL', set( 'Datasession' ) )

			if reccount( 'c_IMPDIRVAL' ) = 0
				llRetorno = .f.
			else
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxImpdirvalNumero as Variant
		llRetorno = .t.
		lxImpdirvalNumero = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.IMPDIRVAL where "Numero" = <<lxImpdirvalNumero>> and  IMPDIRVAL.NUMERO != 0
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
				select top 1 "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Timestamp" as "Timestamp", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Ualtafw" as "Usuarioaltafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Tipoval" as "Tipo", "Numero" as "Numero", "Descripcio" as "Descripcion", "Valdesde" as "F_valor_desde", "Valhasta" as "F_valor_hasta", "Mondesde" as "F_moneda_desde", "Tipotarj" as "Tipotarjeta", "Monhasta" as "F_moneda_hasta", "Opedesde" as "F_operadoradetarjeta_desde", "Pcuenta" as "Plandecuentas", "Opehasta" as "F_operadoradetarjeta_hasta", "Importanci" as "Importancia", "Tipoasi" as "Tipodeasiento", "Obs" as "Observacion" from ZooLogic.IMPDIRVAL where  IMPDIRVAL.NUMERO != 0 order by NUMERO
			endtext
			use in select('c_IMPDIRVAL')
			this.oConexion.EjecutarSql( lcSentencia, 'c_IMPDIRVAL', set( 'Datasession' ) )
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
				select top 1 "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Timestamp" as "Timestamp", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Ualtafw" as "Usuarioaltafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Tipoval" as "Tipo", "Numero" as "Numero", "Descripcio" as "Descripcion", "Valdesde" as "F_valor_desde", "Valhasta" as "F_valor_hasta", "Mondesde" as "F_moneda_desde", "Tipotarj" as "Tipotarjeta", "Monhasta" as "F_moneda_hasta", "Opedesde" as "F_operadoradetarjeta_desde", "Pcuenta" as "Plandecuentas", "Opehasta" as "F_operadoradetarjeta_hasta", "Importanci" as "Importancia", "Tipoasi" as "Tipodeasiento", "Obs" as "Observacion" from ZooLogic.IMPDIRVAL where  str( NUMERO, 8, 0) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  IMPDIRVAL.NUMERO != 0 order by NUMERO
			endtext
			use in select('c_IMPDIRVAL')
			this.oConexion.EjecutarSql( lcSentencia, 'c_IMPDIRVAL', set( 'Datasession' ) )
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
				select top 1 "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Timestamp" as "Timestamp", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Ualtafw" as "Usuarioaltafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Tipoval" as "Tipo", "Numero" as "Numero", "Descripcio" as "Descripcion", "Valdesde" as "F_valor_desde", "Valhasta" as "F_valor_hasta", "Mondesde" as "F_moneda_desde", "Tipotarj" as "Tipotarjeta", "Monhasta" as "F_moneda_hasta", "Opedesde" as "F_operadoradetarjeta_desde", "Pcuenta" as "Plandecuentas", "Opehasta" as "F_operadoradetarjeta_hasta", "Importanci" as "Importancia", "Tipoasi" as "Tipodeasiento", "Obs" as "Observacion" from ZooLogic.IMPDIRVAL where  str( NUMERO, 8, 0) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  IMPDIRVAL.NUMERO != 0 order by NUMERO desc
			endtext
			use in select('c_IMPDIRVAL')
			this.oConexion.EjecutarSql( lcSentencia, 'c_IMPDIRVAL', set( 'Datasession' ) )
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
				select top 1 "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Timestamp" as "Timestamp", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Ualtafw" as "Usuarioaltafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Tipoval" as "Tipo", "Numero" as "Numero", "Descripcio" as "Descripcion", "Valdesde" as "F_valor_desde", "Valhasta" as "F_valor_hasta", "Mondesde" as "F_moneda_desde", "Tipotarj" as "Tipotarjeta", "Monhasta" as "F_moneda_hasta", "Opedesde" as "F_operadoradetarjeta_desde", "Pcuenta" as "Plandecuentas", "Opehasta" as "F_operadoradetarjeta_hasta", "Importanci" as "Importancia", "Tipoasi" as "Tipodeasiento", "Obs" as "Observacion" from ZooLogic.IMPDIRVAL where  IMPDIRVAL.NUMERO != 0 order by NUMERO desc
			endtext
			use in select('c_IMPDIRVAL')
			this.oConexion.EjecutarSql( lcSentencia, 'c_IMPDIRVAL', set( 'Datasession' ) )
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
				lcFiltroCodigo = ' and ' + .cCampoClavePrimaria + ' <> ' + transform( .oEntidad.NUMERO )
			endif
			lcFiltro = lcCampo + ' = ' + goLibrerias.ValorAString(lxValor) + lcFiltroCodigo
			local lcXml as string
			lcXml = this.oConexion.EjecutarSql( "select Fectrans,Fmodifw,Faltafw,Fecexpo,Fecimpo,Timestamp,Horaexpo,Horaimpo,Haltafw,Ualtafw,Vmodifw" + ;
",Zadsfw,Valtafw,Umodifw,Saltafw,Smodifw,Hmodifw,Esttrans,Bdaltafw,Bdmodifw,Tipoval,Numero,Descripcio" + ;
",Valdesde,Valhasta,Mondesde,Tipotarj,Monhasta,Opedesde,Pcuenta,Opehasta,Importanci,Tipoasi,Obs" + ;
" from ZooLogic.IMPDIRVAL where  IMPDIRVAL.NUMERO != 0 and " + lcFiltro )
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
			local  lxImpdirvalFectrans, lxImpdirvalFmodifw, lxImpdirvalFaltafw, lxImpdirvalFecexpo, lxImpdirvalFecimpo, lxImpdirvalTimestamp, lxImpdirvalHoraexpo, lxImpdirvalHoraimpo, lxImpdirvalHaltafw, lxImpdirvalUaltafw, lxImpdirvalVmodifw, lxImpdirvalZadsfw, lxImpdirvalValtafw, lxImpdirvalUmodifw, lxImpdirvalSaltafw, lxImpdirvalSmodifw, lxImpdirvalHmodifw, lxImpdirvalEsttrans, lxImpdirvalBdaltafw, lxImpdirvalBdmodifw, lxImpdirvalTipoval, lxImpdirvalNumero, lxImpdirvalDescripcio, lxImpdirvalValdesde, lxImpdirvalValhasta, lxImpdirvalMondesde, lxImpdirvalTipotarj, lxImpdirvalMonhasta, lxImpdirvalOpedesde, lxImpdirvalPcuenta, lxImpdirvalOpehasta, lxImpdirvalImportanci, lxImpdirvalTipoasi, lxImpdirvalObs
				lxImpdirvalFectrans = ctod( '  /  /    ' )			lxImpdirvalFmodifw = ctod( '  /  /    ' )			lxImpdirvalFaltafw = ctod( '  /  /    ' )			lxImpdirvalFecexpo = ctod( '  /  /    ' )			lxImpdirvalFecimpo = ctod( '  /  /    ' )			lxImpdirvalTimestamp = goLibrerias.ObtenerTimestamp()			lxImpdirvalHoraexpo = []			lxImpdirvalHoraimpo = []			lxImpdirvalHaltafw = []			lxImpdirvalUaltafw = []			lxImpdirvalVmodifw = []			lxImpdirvalZadsfw = []			lxImpdirvalValtafw = []			lxImpdirvalUmodifw = []			lxImpdirvalSaltafw = []			lxImpdirvalSmodifw = []			lxImpdirvalHmodifw = []			lxImpdirvalEsttrans = []			lxImpdirvalBdaltafw = []			lxImpdirvalBdmodifw = []			lxImpdirvalTipoval = 0			lxImpdirvalNumero = 0			lxImpdirvalDescripcio = []			lxImpdirvalValdesde = []			lxImpdirvalValhasta = []			lxImpdirvalMondesde = []			lxImpdirvalTipotarj = []			lxImpdirvalMonhasta = []			lxImpdirvalOpedesde = []			lxImpdirvalPcuenta = []			lxImpdirvalOpehasta = []			lxImpdirvalImportanci = 0			lxImpdirvalTipoasi = 0			lxImpdirvalObs = []
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( [delete from ZooLogic.IMPDIRVAL where "NUMERO" = ] + transform( .oEntidad.NUMERO )+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'IMPDIRVAL' + '_' + tcCampo
			lcMemoAscii = ''

			lnIndice = alen(.aSqlMemos)
			lnIndice = iif(lnIndice = 1, 1, lnIndice + 1 )
			dimension .aSqlMemos(lnIndice)

			.aSqlMemos(lnIndice) = 'delete from ' + lcTabla + ' where NUMERO = ' + txValorClavePrimaria
			.GenerarSentenciasInsertTablaMemo( lcValor, lcTabla, txValorClavePrimaria )
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerSentenciaInsertMemo( tcTabla as String, txValorClavePrimaria as String, tcOrden as String, tcTexto as String ) as String
		return "Insert  into " + tcTabla + "(NUMERO, Orden, texto ) values ( " + txValorClavePrimaria + "," + tcOrden + ",'"+ tcTexto + "')"
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosEntidad( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  IMPDIRVAL.NUMERO != 0"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Timestamp" as "Timestamp", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Ualtafw" as "Usuarioaltafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Tipoval" as "Tipo", "Numero" as "Numero", "Descripcio" as "Descripcion", "Valdesde" as "F_valor_desde", "Valhasta" as "F_valor_hasta", "Mondesde" as "F_moneda_desde", "Tipotarj" as "Tipotarjeta", "Monhasta" as "F_moneda_hasta", "Opedesde" as "F_operadoradetarjeta_desde", "Pcuenta" as "Plandecuentas", "Opehasta" as "F_operadoradetarjeta_hasta", "Importanci" as "Importancia", "Tipoasi" as "Tipodeasiento", "Obs" as "Observacion"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'IMPDIRVAL', '', tnTope )
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
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'FECHAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECEXPO AS FECHAEXPO'
				Case lcAtributo == 'FECHAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECIMPO AS FECHAIMPO'
				Case lcAtributo == 'TIMESTAMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIMESTAMP AS TIMESTAMP'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
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
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'TIPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPOVAL AS TIPO'
				Case lcAtributo == 'NUMERO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NUMERO AS NUMERO'
				Case lcAtributo == 'DESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCRIPCIO AS DESCRIPCION'
				Case lcAtributo == 'F_VALOR_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALDESDE AS F_VALOR_DESDE'
				Case lcAtributo == 'F_VALOR_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALHASTA AS F_VALOR_HASTA'
				Case lcAtributo == 'F_MONEDA_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONDESDE AS F_MONEDA_DESDE'
				Case lcAtributo == 'TIPOTARJETA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPOTARJ AS TIPOTARJETA'
				Case lcAtributo == 'F_MONEDA_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONHASTA AS F_MONEDA_HASTA'
				Case lcAtributo == 'F_OPERADORADETARJETA_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'OPEDESDE AS F_OPERADORADETARJETA_DESDE'
				Case lcAtributo == 'PLANDECUENTAS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PCUENTA AS PLANDECUENTAS'
				Case lcAtributo == 'F_OPERADORADETARJETA_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'OPEHASTA AS F_OPERADORADETARJETA_HASTA'
				Case lcAtributo == 'IMPORTANCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IMPORTANCI AS IMPORTANCIA'
				Case lcAtributo == 'TIPODEASIENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPOASI AS TIPODEASIENTO'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEXPO'
				lcCampo = 'FECEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAIMPO'
				lcCampo = 'FECIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'TIMESTAMP'
				lcCampo = 'TIMESTAMP'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
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
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'TIPO'
				lcCampo = 'TIPOVAL'
			Case upper( alltrim( tcAtributo ) ) == 'NUMERO'
				lcCampo = 'NUMERO'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCION'
				lcCampo = 'DESCRIPCIO'
			Case upper( alltrim( tcAtributo ) ) == 'F_VALOR_DESDE'
				lcCampo = 'VALDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'F_VALOR_HASTA'
				lcCampo = 'VALHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'F_MONEDA_DESDE'
				lcCampo = 'MONDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOTARJETA'
				lcCampo = 'TIPOTARJ'
			Case upper( alltrim( tcAtributo ) ) == 'F_MONEDA_HASTA'
				lcCampo = 'MONHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'F_OPERADORADETARJETA_DESDE'
				lcCampo = 'OPEDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'PLANDECUENTAS'
				lcCampo = 'PCUENTA'
			Case upper( alltrim( tcAtributo ) ) == 'F_OPERADORADETARJETA_HASTA'
				lcCampo = 'OPEHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'IMPORTANCIA'
				lcCampo = 'IMPORTANCI'
			Case upper( alltrim( tcAtributo ) ) == 'TIPODEASIENTO'
				lcCampo = 'TIPOASI'
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
			local  lxImpdirvalFectrans, lxImpdirvalFmodifw, lxImpdirvalFaltafw, lxImpdirvalFecexpo, lxImpdirvalFecimpo, lxImpdirvalTimestamp, lxImpdirvalHoraexpo, lxImpdirvalHoraimpo, lxImpdirvalHaltafw, lxImpdirvalUaltafw, lxImpdirvalVmodifw, lxImpdirvalZadsfw, lxImpdirvalValtafw, lxImpdirvalUmodifw, lxImpdirvalSaltafw, lxImpdirvalSmodifw, lxImpdirvalHmodifw, lxImpdirvalEsttrans, lxImpdirvalBdaltafw, lxImpdirvalBdmodifw, lxImpdirvalTipoval, lxImpdirvalNumero, lxImpdirvalDescripcio, lxImpdirvalValdesde, lxImpdirvalValhasta, lxImpdirvalMondesde, lxImpdirvalTipotarj, lxImpdirvalMonhasta, lxImpdirvalOpedesde, lxImpdirvalPcuenta, lxImpdirvalOpehasta, lxImpdirvalImportanci, lxImpdirvalTipoasi, lxImpdirvalObs
				lxImpdirvalFectrans =  .Fechatransferencia			lxImpdirvalFmodifw =  .Fechamodificacionfw			lxImpdirvalFaltafw =  .Fechaaltafw			lxImpdirvalFecexpo =  .Fechaexpo			lxImpdirvalFecimpo =  .Fechaimpo			lxImpdirvalTimestamp = goLibrerias.ObtenerTimestamp()			lxImpdirvalHoraexpo =  .Horaexpo			lxImpdirvalHoraimpo =  .Horaimpo			lxImpdirvalHaltafw =  .Horaaltafw			lxImpdirvalUaltafw =  .Usuarioaltafw			lxImpdirvalVmodifw =  .Versionmodificacionfw			lxImpdirvalZadsfw =  .Zadsfw			lxImpdirvalValtafw =  .Versionaltafw			lxImpdirvalUmodifw =  .Usuariomodificacionfw			lxImpdirvalSaltafw =  .Seriealtafw			lxImpdirvalSmodifw =  .Seriemodificacionfw			lxImpdirvalHmodifw =  .Horamodificacionfw			lxImpdirvalEsttrans =  .Estadotransferencia			lxImpdirvalBdaltafw =  .Basededatosaltafw			lxImpdirvalBdmodifw =  .Basededatosmodificacionfw			lxImpdirvalTipoval =  .Tipo			lxImpdirvalNumero =  .Numero			lxImpdirvalDescripcio =  .Descripcion			lxImpdirvalValdesde =  .F_valor_desde			lxImpdirvalValhasta =  .F_valor_hasta			lxImpdirvalMondesde =  .F_moneda_desde			lxImpdirvalTipotarj =  .Tipotarjeta			lxImpdirvalMonhasta =  .F_moneda_hasta			lxImpdirvalOpedesde =  .F_operadoradetarjeta_desde			lxImpdirvalPcuenta =  upper( .PlanDeCuentas_PK ) 			lxImpdirvalOpehasta =  .F_operadoradetarjeta_hasta			lxImpdirvalImportanci =  .Importancia			lxImpdirvalTipoasi =  .Tipodeasiento			lxImpdirvalObs =  .Observacion
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.IMPDIRVAL ( "Fectrans","Fmodifw","Faltafw","Fecexpo","Fecimpo","Timestamp","Horaexpo","Horaimpo","Haltafw","Ualtafw","Vmodifw","Zadsfw","Valtafw","Umodifw","Saltafw","Smodifw","Hmodifw","Esttrans","Bdaltafw","Bdmodifw","Tipoval","Numero","Descripcio","Valdesde","Valhasta","Mondesde","Tipotarj","Monhasta","Opedesde","Pcuenta","Opehasta","Importanci","Tipoasi","Obs" ) values ( <<"'" + this.ConvertirDateSql( lxImpdirvalFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxImpdirvalFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxImpdirvalFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxImpdirvalFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxImpdirvalFecimpo ) + "'" >>, <<lxImpdirvalTimestamp >>, <<"'" + this.FormatearTextoSql( lxImpdirvalHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirvalHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirvalHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirvalUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirvalVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirvalZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirvalValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirvalUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirvalSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirvalSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirvalHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirvalEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirvalBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirvalBdmodifw ) + "'" >>, <<lxImpdirvalTipoval >>, <<lxImpdirvalNumero >>, <<"'" + this.FormatearTextoSql( lxImpdirvalDescripcio ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirvalValdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirvalValhasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirvalMondesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirvalTipotarj ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirvalMonhasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirvalOpedesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirvalPcuenta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirvalOpehasta ) + "'" >>, <<lxImpdirvalImportanci >>, <<lxImpdirvalTipoasi >>, <<"'" + this.FormatearTextoSql( lxImpdirvalObs ) + "'" >> )
		endtext
		loColeccion.cTabla = 'IMPDIRVAL' 
		loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		With this
			local lcValorClavePrimariaString as String
			lcValorClavePrimariaString = transform( this.oEntidad.NUMERO )
		EndWith
		return loColeccion
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasUpdate() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcFiltro as string, loItem as object, lcSentencia as string, lcSentencia as string
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxImpdirvalFectrans, lxImpdirvalFmodifw, lxImpdirvalFaltafw, lxImpdirvalFecexpo, lxImpdirvalFecimpo, lxImpdirvalTimestamp, lxImpdirvalHoraexpo, lxImpdirvalHoraimpo, lxImpdirvalHaltafw, lxImpdirvalUaltafw, lxImpdirvalVmodifw, lxImpdirvalZadsfw, lxImpdirvalValtafw, lxImpdirvalUmodifw, lxImpdirvalSaltafw, lxImpdirvalSmodifw, lxImpdirvalHmodifw, lxImpdirvalEsttrans, lxImpdirvalBdaltafw, lxImpdirvalBdmodifw, lxImpdirvalTipoval, lxImpdirvalNumero, lxImpdirvalDescripcio, lxImpdirvalValdesde, lxImpdirvalValhasta, lxImpdirvalMondesde, lxImpdirvalTipotarj, lxImpdirvalMonhasta, lxImpdirvalOpedesde, lxImpdirvalPcuenta, lxImpdirvalOpehasta, lxImpdirvalImportanci, lxImpdirvalTipoasi, lxImpdirvalObs
				lxImpdirvalFectrans =  .Fechatransferencia			lxImpdirvalFmodifw =  .Fechamodificacionfw			lxImpdirvalFaltafw =  .Fechaaltafw			lxImpdirvalFecexpo =  .Fechaexpo			lxImpdirvalFecimpo =  .Fechaimpo			lxImpdirvalTimestamp = goLibrerias.ObtenerTimestamp()			lxImpdirvalHoraexpo =  .Horaexpo			lxImpdirvalHoraimpo =  .Horaimpo			lxImpdirvalHaltafw =  .Horaaltafw			lxImpdirvalUaltafw =  .Usuarioaltafw			lxImpdirvalVmodifw =  .Versionmodificacionfw			lxImpdirvalZadsfw =  .Zadsfw			lxImpdirvalValtafw =  .Versionaltafw			lxImpdirvalUmodifw =  .Usuariomodificacionfw			lxImpdirvalSaltafw =  .Seriealtafw			lxImpdirvalSmodifw =  .Seriemodificacionfw			lxImpdirvalHmodifw =  .Horamodificacionfw			lxImpdirvalEsttrans =  .Estadotransferencia			lxImpdirvalBdaltafw =  .Basededatosaltafw			lxImpdirvalBdmodifw =  .Basededatosmodificacionfw			lxImpdirvalTipoval =  .Tipo			lxImpdirvalNumero =  .Numero			lxImpdirvalDescripcio =  .Descripcion			lxImpdirvalValdesde =  .F_valor_desde			lxImpdirvalValhasta =  .F_valor_hasta			lxImpdirvalMondesde =  .F_moneda_desde			lxImpdirvalTipotarj =  .Tipotarjeta			lxImpdirvalMonhasta =  .F_moneda_hasta			lxImpdirvalOpedesde =  .F_operadoradetarjeta_desde			lxImpdirvalPcuenta =  upper( .PlanDeCuentas_PK ) 			lxImpdirvalOpehasta =  .F_operadoradetarjeta_hasta			lxImpdirvalImportanci =  .Importancia			lxImpdirvalTipoasi =  .Tipodeasiento			lxImpdirvalObs =  .Observacion
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.NUMERO
			lcValorClavePrimariaString = transform( this.oEntidad.NUMERO )

			lcFiltro = ["Numero" = ] + lcValorClavePrimariaString  + [ and  IMPDIRVAL.NUMERO != 0]
			text to lcSentencia noshow textmerge
				update ZooLogic.IMPDIRVAL set "Fectrans" = <<"'" + this.ConvertirDateSql( lxImpdirvalFectrans ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxImpdirvalFmodifw ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxImpdirvalFaltafw ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxImpdirvalFecexpo ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxImpdirvalFecimpo ) + "'">>, "Timestamp" = <<lxImpdirvalTimestamp>>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxImpdirvalHoraexpo ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxImpdirvalHoraimpo ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxImpdirvalHaltafw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxImpdirvalUaltafw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxImpdirvalVmodifw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxImpdirvalZadsfw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxImpdirvalValtafw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxImpdirvalUmodifw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxImpdirvalSaltafw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxImpdirvalSmodifw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxImpdirvalHmodifw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxImpdirvalEsttrans ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxImpdirvalBdaltafw ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxImpdirvalBdmodifw ) + "'">>, "Tipoval" = <<lxImpdirvalTipoval>>, "Numero" = <<lxImpdirvalNumero>>, "Descripcio" = <<"'" + this.FormatearTextoSql( lxImpdirvalDescripcio ) + "'">>, "Valdesde" = <<"'" + this.FormatearTextoSql( lxImpdirvalValdesde ) + "'">>, "Valhasta" = <<"'" + this.FormatearTextoSql( lxImpdirvalValhasta ) + "'">>, "Mondesde" = <<"'" + this.FormatearTextoSql( lxImpdirvalMondesde ) + "'">>, "Tipotarj" = <<"'" + this.FormatearTextoSql( lxImpdirvalTipotarj ) + "'">>, "Monhasta" = <<"'" + this.FormatearTextoSql( lxImpdirvalMonhasta ) + "'">>, "Opedesde" = <<"'" + this.FormatearTextoSql( lxImpdirvalOpedesde ) + "'">>, "Pcuenta" = <<"'" + this.FormatearTextoSql( lxImpdirvalPcuenta ) + "'">>, "Opehasta" = <<"'" + this.FormatearTextoSql( lxImpdirvalOpehasta ) + "'">>, "Importanci" = <<lxImpdirvalImportanci>>, "Tipoasi" = <<lxImpdirvalTipoasi>>, "Obs" = <<"'" + this.FormatearTextoSql( lxImpdirvalObs ) + "'">> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'IMPDIRVAL' 
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
			lxValorClavePrimaria = this.oEntidad.NUMERO
			lcValorClavePrimariaString = transform( this.oEntidad.NUMERO )

			lcFiltro = ["Numero" = ] + lcValorClavePrimariaString  + [ and  IMPDIRVAL.NUMERO != 0]
		loColeccion.Agregar( 'delete from ZooLogic.IMPDIRVAL where ' + lcFiltro )
			loColeccion.cTabla = 'IMPDIRVAL' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.IMPDIRVAL where  IMPDIRVAL.NUMERO != 0" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.IMPDIRVAL where NUMERO = " + transform( this.oEntidad.NUMERO )+ " and  IMPDIRVAL.NUMERO != 0" )
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
		local lcCursor as String, ldFecha as Date, lcHora as string, lcValorABuscar As String, lxValorClavePK As variant, lxValorClavePrimaria As variant, lcIdentificadorParaLoguear as string, lcMensajeExtra as String
		lcValorABuscar = ''
		lxValorClavePK = ''
		lcMensajeExtra = ''
		lcCursor = This.oEntidad.cPrefijoRecibir + 'IMPDIRVAL'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.IMPDIRVAL Where NUMERO = ] + transform( &lcCursor..NUMERO ), 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					this.oConexion.EjecutarSql( [UPDATE ZooLogic.IMPDIRVAL set  FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, TIMESTAMP = ] + transform( &lcCursor..TIMESTAMP )+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, TipoVal = ] + transform( &lcCursor..TipoVal )+ [, NUMERO = ] + transform( &lcCursor..NUMERO )+ [, Descripcio = ] + "'" + this.FormatearTextoSql( &lcCursor..Descripcio ) + "'"+ [, ValDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..ValDesde ) + "'"+ [, ValHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..ValHasta ) + "'"+ [, MonDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..MonDesde ) + "'"+ [, tipotarj = ] + "'" + this.FormatearTextoSql( &lcCursor..tipotarj ) + "'"+ [, MonHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..MonHasta ) + "'"+ [, OpeDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..OpeDesde ) + "'"+ [, PCUENTA = ] + "'" + this.FormatearTextoSql( &lcCursor..PCUENTA ) + "'"+ [, OpeHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..OpeHasta ) + "'"+ [, Importanci = ] + transform( &lcCursor..Importanci )+ [, TipoAsi = ] + transform( &lcCursor..TipoAsi )+ [, OBS = ] + "'" + this.FormatearTextoSql( &lcCursor..OBS ) + "'" + [ Where NUMERO = ] + transform( &lcCursor..NUMERO ) )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
				endIf
			else
				Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
				Text to lcCampos noShow
					 FECTRANS, FMODIFW, FALTAFW, FECEXPO, FECIMPO, TIMESTAMP, HORAEXPO, HORAIMPO, HALTAFW, UALTAFW, VMODIFW, ZADSFW, VALTAFW, UMODIFW, SALTAFW, SMODIFW, HMODIFW, ESTTRANS, BDALTAFW, BDMODIFW, TipoVal, NUMERO, Descripcio, ValDesde, ValHasta, MonDesde, tipotarj, MonHasta, OpeDesde, PCUENTA, OpeHasta, Importanci, TipoAsi, OBS
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + transform( &lcCursor..TIMESTAMP ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + transform( &lcCursor..TipoVal )
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..NUMERO ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..Descripcio ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ValDesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ValHasta ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..MonDesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..tipotarj ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..MonHasta ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..OpeDesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..PCUENTA ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..OpeHasta ) + "'" + ',' + transform( &lcCursor..Importanci ) + ',' + transform( &lcCursor..TipoAsi ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..OBS ) + "'"
lcValoresCampos = substr(lcValoresCampos,2) 

				this.oConexion.EjecutarSql( [Insert into ZooLogic.IMPDIRVAL ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
				this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'IMPDIRVAL'
		if This.ActualizaEnRecepcion()
	endif
	Use in select( 'cExistentes' )
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearCursorMemo( tcCursorACrear as String, tcTablaConMemo as String ) as Void
		create cursor &tcCursorACrear ( NUMERO N (8) , Orden N(16), texto C(80))
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirComponentes() As Void
		
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
			Case  lcAlias == lcPrefijo + 'IMPDIRVAL'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'IMPDIRVAL_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'IMPDIRVAL_OBS'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_IMPDIRVAL')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'IMPDIRVAL'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..NUMERO
		llCondicion = isnull( lxVar )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad IMPDIRVAL. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'IMPDIRVAL'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		select recno() as _Rec, * from &lcCursor into cursor CurConRecno
		select max( _Rec ) as Maximo,NUMERO as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( NUMERO, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		Use in select( 'CurConRecno' )
		Use in select( 'RepMax' )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDatosInvalidos( toConexion as Object ) as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'IMPDIRVAL'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_IMPDIRVAL') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_IMPDIRVAL
Create Table ZooLogic.TablaTrabajo_IMPDIRVAL ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fectrans" datetime  null, 
"fmodifw" datetime  null, 
"faltafw" datetime  null, 
"fecexpo" datetime  null, 
"fecimpo" datetime  null, 
"timestamp" numeric( 20, 0 )  null, 
"horaexpo" char( 8 )  null, 
"horaimpo" char( 8 )  null, 
"haltafw" char( 8 )  null, 
"ualtafw" char( 100 )  null, 
"vmodifw" char( 13 )  null, 
"zadsfw" varchar(max)  null, 
"valtafw" char( 13 )  null, 
"umodifw" char( 100 )  null, 
"saltafw" char( 7 )  null, 
"smodifw" char( 7 )  null, 
"hmodifw" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"bdaltafw" char( 8 )  null, 
"bdmodifw" char( 8 )  null, 
"tipoval" numeric( 2, 0 )  null, 
"numero" numeric( 8, 0 )  null, 
"descripcio" char( 50 )  null, 
"valdesde" char( 5 )  null, 
"valhasta" char( 5 )  null, 
"mondesde" char( 10 )  null, 
"tipotarj" char( 1 )  null, 
"monhasta" char( 10 )  null, 
"opedesde" char( 15 )  null, 
"pcuenta" char( 30 )  null, 
"opehasta" char( 15 )  null, 
"importanci" numeric( 5, 0 )  null, 
"tipoasi" numeric( 1, 0 )  null, 
"obs" varchar(max)  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_IMPDIRVAL' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_IMPDIRVAL' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'IMPDIRVAL'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		with loManejador
			if this.oEntidad.VerificarContexto( 'CB' )
			else
				.AgregarMapeo('Nrolinea','Nrolinea')
			endif
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('timestamp','timestamp')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('tipoval','tipoval')
			.AgregarMapeo('numero','numero')
			.AgregarMapeo('descripcio','descripcio')
			.AgregarMapeo('valdesde','valdesde')
			.AgregarMapeo('valhasta','valhasta')
			.AgregarMapeo('mondesde','mondesde')
			.AgregarMapeo('tipotarj','tipotarj')
			.AgregarMapeo('monhasta','monhasta')
			.AgregarMapeo('opedesde','opedesde')
			.AgregarMapeo('pcuenta','pcuenta')
			.AgregarMapeo('opehasta','opehasta')
			.AgregarMapeo('importanci','importanci')
			.AgregarMapeo('tipoasi','tipoasi')
			.AgregarMapeo('obs','obs')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_IMPDIRVAL'
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
				Update t Set t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.TIMESTAMP = isnull( d.TIMESTAMP, t.TIMESTAMP ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.TIPOVAL = isnull( d.TIPOVAL, t.TIPOVAL ),t.NUMERO = isnull( d.NUMERO, t.NUMERO ),t.DESCRIPCIO = isnull( d.DESCRIPCIO, t.DESCRIPCIO ),t.VALDESDE = isnull( d.VALDESDE, t.VALDESDE ),t.VALHASTA = isnull( d.VALHASTA, t.VALHASTA ),t.MONDESDE = isnull( d.MONDESDE, t.MONDESDE ),t.TIPOTARJ = isnull( d.TIPOTARJ, t.TIPOTARJ ),t.MONHASTA = isnull( d.MONHASTA, t.MONHASTA ),t.OPEDESDE = isnull( d.OPEDESDE, t.OPEDESDE ),t.PCUENTA = isnull( d.PCUENTA, t.PCUENTA ),t.OPEHASTA = isnull( d.OPEHASTA, t.OPEHASTA ),t.IMPORTANCI = isnull( d.IMPORTANCI, t.IMPORTANCI ),t.TIPOASI = isnull( d.TIPOASI, t.TIPOASI ),t.OBS = isnull( d.OBS, t.OBS )
					from ZooLogic.IMPDIRVAL t inner join deleted d 
							 on t.NUMERO = d.NUMERO
				-- Fin Updates
				insert into ZooLogic.IMPDIRVAL(Fectrans,Fmodifw,Faltafw,Fecexpo,Fecimpo,Timestamp,Horaexpo,Horaimpo,Haltafw,Ualtafw,Vmodifw,Zadsfw,Valtafw,Umodifw,Saltafw,Smodifw,Hmodifw,Esttrans,Bdaltafw,Bdmodifw,Tipoval,Numero,Descripcio,Valdesde,Valhasta,Mondesde,Tipotarj,Monhasta,Opedesde,Pcuenta,Opehasta,Importanci,Tipoasi,Obs)
					Select isnull( d.FECTRANS,''),isnull( d.FMODIFW,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FECEXPO,''),isnull( d.FECIMPO,''),isnull( d.TIMESTAMP,0),isnull( d.HORAEXPO,''),isnull( d.HORAIMPO,''),convert( char(8), getdate(), 108 ),isnull( d.UALTAFW,''),isnull( d.VMODIFW,''),isnull( d.ZADSFW,''),isnull( d.VALTAFW,''),isnull( d.UMODIFW,''),isnull( d.SALTAFW,''),isnull( d.SMODIFW,''),isnull( d.HMODIFW,''),isnull( d.ESTTRANS,''),isnull( d.BDALTAFW,''),isnull( d.BDMODIFW,''),isnull( d.TIPOVAL,0),isnull( d.NUMERO,0),isnull( d.DESCRIPCIO,''),isnull( d.VALDESDE,''),isnull( d.VALHASTA,''),isnull( d.MONDESDE,''),isnull( d.TIPOTARJ,''),isnull( d.MONHASTA,''),isnull( d.OPEDESDE,''),isnull( d.PCUENTA,''),isnull( d.OPEHASTA,''),isnull( d.IMPORTANCI,0),isnull( d.TIPOASI,0),isnull( d.OBS,'')
						From deleted d left join ZooLogic.IMPDIRVAL pk 
							 on d.NUMERO = pk.NUMERO
						Where pk.NUMERO Is Null 
				-- Fin Inserts
			End
		EndText
		Return lcCadena
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	protected Function EliminarTablasDeTrabajo( toConexion as Object ) as void
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_IMPDIRVAL') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_IMPDIRVAL
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_IMPDIRVAL' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_IMPDIRVAL.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_IMPDIRVAL.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_IMPDIRVAL.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_IMPDIRVAL.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_IMPDIRVAL.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Timestamp = nvl( c_IMPDIRVAL.Timestamp, 0 )
					.Horaexpo = nvl( c_IMPDIRVAL.Horaexpo, [] )
					.Horaimpo = nvl( c_IMPDIRVAL.Horaimpo, [] )
					.Horaaltafw = nvl( c_IMPDIRVAL.Horaaltafw, [] )
					.Usuarioaltafw = nvl( c_IMPDIRVAL.Usuarioaltafw, [] )
					.Versionmodificacionfw = nvl( c_IMPDIRVAL.Versionmodificacionfw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Versionaltafw = nvl( c_IMPDIRVAL.Versionaltafw, [] )
					.Usuariomodificacionfw = nvl( c_IMPDIRVAL.Usuariomodificacionfw, [] )
					.Seriealtafw = nvl( c_IMPDIRVAL.Seriealtafw, [] )
					.Seriemodificacionfw = nvl( c_IMPDIRVAL.Seriemodificacionfw, [] )
					.Horamodificacionfw = nvl( c_IMPDIRVAL.Horamodificacionfw, [] )
					.Estadotransferencia = nvl( c_IMPDIRVAL.Estadotransferencia, [] )
					.Basededatosaltafw = nvl( c_IMPDIRVAL.Basededatosaltafw, [] )
					.Basededatosmodificacionfw = nvl( c_IMPDIRVAL.Basededatosmodificacionfw, [] )
					.Tipo = nvl( c_IMPDIRVAL.Tipo, 0 )
					.Numero = nvl( c_IMPDIRVAL.Numero, 0 )
					.Descripcion = nvl( c_IMPDIRVAL.Descripcion, [] )
					.F_valor_desde = nvl( c_IMPDIRVAL.F_valor_desde, [] )
					.F_valor_hasta = nvl( c_IMPDIRVAL.F_valor_hasta, [] )
					.F_moneda_desde = nvl( c_IMPDIRVAL.F_moneda_desde, [] )
					.Tipotarjeta = nvl( c_IMPDIRVAL.Tipotarjeta, [] )
					.F_moneda_hasta = nvl( c_IMPDIRVAL.F_moneda_hasta, [] )
					.F_operadoradetarjeta_desde = nvl( c_IMPDIRVAL.F_operadoradetarjeta_desde, [] )
					.Plandecuentas_PK =  nvl( c_IMPDIRVAL.Plandecuentas, [] )
					.F_operadoradetarjeta_hasta = nvl( c_IMPDIRVAL.F_operadoradetarjeta_hasta, [] )
					.Importancia = nvl( c_IMPDIRVAL.Importancia, 0 )
					.Tipodeasiento = nvl( c_IMPDIRVAL.Tipodeasiento, 0 )
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
		return c_IMPDIRVAL.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.IMPDIRVAL' )
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
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "NUMERO"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
		text to lcSQL textmerge noshow
				SELECT nro,totalRegistros,NUMERO as Id
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    NUMERO from (
							select * 
								from ZooLogic.IMPDIRVAL 
								Where   IMPDIRVAL.NUMERO != 0
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "IMPDIRVAL", "", lcCursor, set("Datasession") )
		lcXml = this.CursorAXml( lcCursor )
		
		use in select( lcCursor )
		
		Return lcXml 
		
	endfunc
	*-----------------------------------------------------------------------------------------
	function ObtenerDatosEntidadPaginado( tcOrderBy as String, tcFiltro as String, tnCantidad as Integer, tnPagina as Integer )  as String
		local lcOrderBy as String, lnCuantos as Integer, lnPagina as Integer, lnTope as Integer, lnDesde as Integer, lcSQL as String, lcCursor as String, lcXml as String
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "NUMERO"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
			text to lcAtributos textmerge noshow
			"Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Timestamp" as "Timestamp", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Ualtafw" as "Usuarioaltafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Tipoval" as "Tipo", "Numero" as "Numero", "Descripcio" as "Descripcion", "Valdesde" as "F_valor_desde", "Valhasta" as "F_valor_hasta", "Mondesde" as "F_moneda_desde", "Tipotarj" as "Tipotarjeta", "Monhasta" as "F_moneda_hasta", "Opedesde" as "F_operadoradetarjeta_desde", "Pcuenta" as "Plandecuentas", "Opehasta" as "F_operadoradetarjeta_hasta", "Importanci" as "Importancia", "Tipoasi" as "Tipodeasiento", "Obs" as "Observacion"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.IMPDIRVAL 
								Where   IMPDIRVAL.NUMERO != 0
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
	Tabla = 'IMPDIRVAL'
	Filtro = " IMPDIRVAL.NUMERO != 0"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " IMPDIRVAL.NUMERO != 0"
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
	<row entidad="IMPDIRVAL                               " atributo="FECHATRANSFERENCIA                      " tabla="IMPDIRVAL      " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha transferencia                                                                                                                                             " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRVAL                               " atributo="FECHAMODIFICACIONFW                     " tabla="IMPDIRVAL      " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRVAL                               " atributo="FECHAALTAFW                             " tabla="IMPDIRVAL      " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRVAL                               " atributo="FECHAEXPO                               " tabla="IMPDIRVAL      " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRVAL                               " atributo="FECHAIMPO                               " tabla="IMPDIRVAL      " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRVAL                               " atributo="TIMESTAMP                               " tabla="IMPDIRVAL      " campo="TIMESTAMP " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRVAL                               " atributo="HORAEXPO                                " tabla="IMPDIRVAL      " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRVAL                               " atributo="HORAIMPO                                " tabla="IMPDIRVAL      " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRVAL                               " atributo="HORAALTAFW                              " tabla="IMPDIRVAL      " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRVAL                               " atributo="USUARIOALTAFW                           " tabla="IMPDIRVAL      " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRVAL                               " atributo="VERSIONMODIFICACIONFW                   " tabla="IMPDIRVAL      " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRVAL                               " atributo="ZADSFW                                  " tabla="IMPDIRVAL      " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRVAL                               " atributo="VERSIONALTAFW                           " tabla="IMPDIRVAL      " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRVAL                               " atributo="USUARIOMODIFICACIONFW                   " tabla="IMPDIRVAL      " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRVAL                               " atributo="SERIEALTAFW                             " tabla="IMPDIRVAL      " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRVAL                               " atributo="SERIEMODIFICACIONFW                     " tabla="IMPDIRVAL      " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRVAL                               " atributo="HORAMODIFICACIONFW                      " tabla="IMPDIRVAL      " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRVAL                               " atributo="ESTADOTRANSFERENCIA                     " tabla="IMPDIRVAL      " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado transferencia                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRVAL                               " atributo="BASEDEDATOSALTAFW                       " tabla="IMPDIRVAL      " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRVAL                               " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="IMPDIRVAL      " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRVAL                               " atributo="TIPO                                    " tabla="IMPDIRVAL      " campo="TIPOVAL   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="10" etiqueta="Tipo                                                                                                                                                            " dominio="COMBOF_TIPODEVALORES          " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="12" orden="10" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRVAL                               " atributo="NUMERO                                  " tabla="IMPDIRVAL      " campo="NUMERO    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="8" etiqueta="Número                                                                                                                                                          " dominio="CODIGONUMERICO                " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="11" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRVAL                               " atributo="DESCRIPCION                             " tabla="IMPDIRVAL      " campo="DESCRIPCIO" claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="4" etiqueta="Descripción                                                                                                                                                     " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="12" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRVAL                               " atributo="F_VALOR_DESDE                           " tabla="IMPDIRVAL      " campo="VALDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="Valor                                                                                                                                                           " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="11" orden="13" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRVAL                               " atributo="F_VALOR_HASTA                           " tabla="IMPDIRVAL      " campo="VALHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="5" decimales="0" valorsugerido="ZZZZZ                                                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="402" etiqueta="Valor                                                                                                                                                           " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="11" orden="14" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRVAL                               " atributo="F_MONEDA_DESDE                          " tabla="IMPDIRVAL      " campo="MONDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="404" etiqueta="Moneda                                                                                                                                                          " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="13" orden="15" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRVAL                               " atributo="TIPOTARJETA                             " tabla="IMPDIRVAL      " campo="TIPOTARJ  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="406" etiqueta="Tipo tarjeta                                                                                                                                                    " dominio="COMBOXML                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="15" orden="16" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRVAL                               " atributo="F_MONEDA_HASTA                          " tabla="IMPDIRVAL      " campo="MONHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="ZZZZZZZZZZ                                                                                                                                                                                                                                                    " obligatorio="false" admitebusqueda="408" etiqueta="Moneda                                                                                                                                                          " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="13" orden="16" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRVAL                               " atributo="F_OPERADORADETARJETA_DESDE              " tabla="IMPDIRVAL      " campo="OPEDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="410" etiqueta="Operadora de la tarjeta                                                                                                                                         " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="14" orden="17" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRVAL                               " atributo="PLANDECUENTAS                           " tabla="IMPDIRVAL      " campo="PCUENTA   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="PLANDECUENTAS                           " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="412" etiqueta="Cuenta                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="&quot; plancuenta.CTAIMPUT = .t. &quot;                                                                                                                                                                           " grupo="0" subgrupo="1" orden="18" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRVAL                               " atributo="F_OPERADORADETARJETA_HASTA              " tabla="IMPDIRVAL      " campo="OPEHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="15" decimales="0" valorsugerido="ZZZZZZZZZZZZZZZ                                                                                                                                                                                                                                               " obligatorio="false" admitebusqueda="414" etiqueta="Operadora de la tarjeta                                                                                                                                         " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="14" orden="18" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRVAL                               " atributo="IMPORTANCIA                             " tabla="IMPDIRVAL      " campo="IMPORTANCI" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="4" etiqueta="Importancia                                                                                                                                                     " dominio="NUMERICONONEGATIVO            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="19" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRVAL                               " atributo="TIPODEASIENTO                           " tabla="IMPDIRVAL      " campo="TIPOASI   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="6" etiqueta="Imputación por tipo de asiento tipo                                                                                                                             " dominio="COMBOTIPODEASIENTO            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="16" orden="80" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRVAL                               " atributo="OBSERVACION                             " tabla="IMPDIRVAL      " campo="OBS       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="416" etiqueta="Observaciones                                                                                                                                                   " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="12" orden="99" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PLANDECUENTAS                           " atributo="DESCRIPCION                             " tabla="PLANCUENTA     " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="413" etiqueta="Detalle Cue.                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join PLANCUENTA On IMPDIRVAL.PCUENTA = PLANCUENTA.ctacodigo And  PLANCUENTA.CTACODIGO != ''                                                                                                                                                             " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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