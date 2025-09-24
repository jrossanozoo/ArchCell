
define class Din_EntidadIMPDIRCLIAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_IMPDIRCLI'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = []
	cExpresionCCPorCampos = []
	cTagClaveCandidata = ''
	cTagClavePk = '_IDCPK'
	cTablaPrincipal = 'IMPDIRCLI'
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
			local  lxImpdircliFecimpo, lxImpdircliFecexpo, lxImpdircliFmodifw, lxImpdircliFaltafw, lxImpdircliFectrans, lxImpdircliTimestamp, lxImpdircliHoraexpo, lxImpdircliHaltafw, lxImpdircliHoraimpo, lxImpdircliEsttrans, lxImpdircliBdaltafw, lxImpdircliUaltafw, lxImpdircliVmodifw, lxImpdircliZadsfw, lxImpdircliValtafw, lxImpdircliUmodifw, lxImpdircliHmodifw, lxImpdircliBdmodifw, lxImpdircliSaltafw, lxImpdircliSmodifw, lxImpdircliNumero, lxImpdircliGlodesde, lxImpdircliSitfis, lxImpdircliDescripcio, lxImpdircliGlohasta, lxImpdircliPcuenta, lxImpdircliImportanci, lxImpdircliClidesde, lxImpdircliClihasta, lxImpdircliVendesde, lxImpdircliVenhasta, lxImpdircliLishasta, lxImpdircliLisdesde, lxImpdircliCladesde, lxImpdircliClahasta, lxImpdircliTipdesde, lxImpdircliTiphasta, lxImpdircliCatdesde, lxImpdircliCathasta, lxImpdircliProdesde, lxImpdircliProhasta, lxImpdircliPaidesde, lxImpdircliPaihasta, lxImpdircliImpval, lxImpdircliObs
				lxImpdircliFecimpo =  .Fechaimpo			lxImpdircliFecexpo =  .Fechaexpo			lxImpdircliFmodifw =  .Fechamodificacionfw			lxImpdircliFaltafw =  .Fechaaltafw			lxImpdircliFectrans =  .Fechatransferencia			lxImpdircliTimestamp = goLibrerias.ObtenerTimestamp()			lxImpdircliHoraexpo =  .Horaexpo			lxImpdircliHaltafw =  .Horaaltafw			lxImpdircliHoraimpo =  .Horaimpo			lxImpdircliEsttrans =  .Estadotransferencia			lxImpdircliBdaltafw =  .Basededatosaltafw			lxImpdircliUaltafw =  .Usuarioaltafw			lxImpdircliVmodifw =  .Versionmodificacionfw			lxImpdircliZadsfw =  .Zadsfw			lxImpdircliValtafw =  .Versionaltafw			lxImpdircliUmodifw =  .Usuariomodificacionfw			lxImpdircliHmodifw =  .Horamodificacionfw			lxImpdircliBdmodifw =  .Basededatosmodificacionfw			lxImpdircliSaltafw =  .Seriealtafw			lxImpdircliSmodifw =  .Seriemodificacionfw			lxImpdircliNumero =  .Numero			lxImpdircliGlodesde =  .F_idglobal_desde			lxImpdircliSitfis =  .Situacionfiscal			lxImpdircliDescripcio =  .Descripcion			lxImpdircliGlohasta =  .F_idglobal_hasta			lxImpdircliPcuenta =  upper( .PlanDeCuentas_PK ) 			lxImpdircliImportanci =  .Importancia			lxImpdircliClidesde =  .F_cliente_desde			lxImpdircliClihasta =  .F_cliente_hasta			lxImpdircliVendesde =  .F_vendedor_desde			lxImpdircliVenhasta =  .F_vendedor_hasta			lxImpdircliLishasta =  .F_lista_hasta			lxImpdircliLisdesde =  .F_lista_desde			lxImpdircliCladesde =  .F_clasificacion_desde			lxImpdircliClahasta =  .F_clasificacion_hasta			lxImpdircliTipdesde =  .F_tipo_desde			lxImpdircliTiphasta =  .F_tipo_hasta			lxImpdircliCatdesde =  .F_categoria_desde			lxImpdircliCathasta =  .F_categoria_hasta			lxImpdircliProdesde =  .F_provincia_desde			lxImpdircliProhasta =  .F_provincia_hasta			lxImpdircliPaidesde =  .F_pais_desde			lxImpdircliPaihasta =  .F_pais_hasta			lxImpdircliImpval =  .Imputacion_PK 			lxImpdircliObs =  .Observacion
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxImpdircliNumero = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.IMPDIRCLI ( "Fecimpo","Fecexpo","Fmodifw","Faltafw","Fectrans","Timestamp","Horaexpo","Haltafw","Horaimpo","Esttrans","Bdaltafw","Ualtafw","Vmodifw","Zadsfw","Valtafw","Umodifw","Hmodifw","Bdmodifw","Saltafw","Smodifw","Numero","Glodesde","Sitfis","Descripcio","Glohasta","Pcuenta","Importanci","Clidesde","Clihasta","Vendesde","Venhasta","Lishasta","Lisdesde","Cladesde","Clahasta","Tipdesde","Tiphasta","Catdesde","Cathasta","Prodesde","Prohasta","Paidesde","Paihasta","Impval","Obs" ) values ( <<"'" + this.ConvertirDateSql( lxImpdircliFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxImpdircliFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxImpdircliFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxImpdircliFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxImpdircliFectrans ) + "'" >>, <<lxImpdircliTimestamp >>, <<"'" + this.FormatearTextoSql( lxImpdircliHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircliHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircliHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircliEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircliBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircliUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircliVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircliZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircliValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircliUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircliHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircliBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircliSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircliSmodifw ) + "'" >>, <<lxImpdircliNumero >>, <<"'" + this.FormatearTextoSql( lxImpdircliGlodesde ) + "'" >>, <<lxImpdircliSitfis >>, <<"'" + this.FormatearTextoSql( lxImpdircliDescripcio ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircliGlohasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircliPcuenta ) + "'" >>, <<lxImpdircliImportanci >>, <<"'" + this.FormatearTextoSql( lxImpdircliClidesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircliClihasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircliVendesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircliVenhasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircliLishasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircliLisdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircliCladesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircliClahasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircliTipdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircliTiphasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircliCatdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircliCathasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircliProdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircliProhasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircliPaidesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircliPaihasta ) + "'" >>, <<lxImpdircliImpval >>, <<"'" + this.FormatearTextoSql( lxImpdircliObs ) + "'" >> )
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
		this.oEntidad.Timestamp = lxImpdircliTimestamp
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
			local  lxImpdircliFecimpo, lxImpdircliFecexpo, lxImpdircliFmodifw, lxImpdircliFaltafw, lxImpdircliFectrans, lxImpdircliTimestamp, lxImpdircliHoraexpo, lxImpdircliHaltafw, lxImpdircliHoraimpo, lxImpdircliEsttrans, lxImpdircliBdaltafw, lxImpdircliUaltafw, lxImpdircliVmodifw, lxImpdircliZadsfw, lxImpdircliValtafw, lxImpdircliUmodifw, lxImpdircliHmodifw, lxImpdircliBdmodifw, lxImpdircliSaltafw, lxImpdircliSmodifw, lxImpdircliNumero, lxImpdircliGlodesde, lxImpdircliSitfis, lxImpdircliDescripcio, lxImpdircliGlohasta, lxImpdircliPcuenta, lxImpdircliImportanci, lxImpdircliClidesde, lxImpdircliClihasta, lxImpdircliVendesde, lxImpdircliVenhasta, lxImpdircliLishasta, lxImpdircliLisdesde, lxImpdircliCladesde, lxImpdircliClahasta, lxImpdircliTipdesde, lxImpdircliTiphasta, lxImpdircliCatdesde, lxImpdircliCathasta, lxImpdircliProdesde, lxImpdircliProhasta, lxImpdircliPaidesde, lxImpdircliPaihasta, lxImpdircliImpval, lxImpdircliObs
				lxImpdircliFecimpo =  .Fechaimpo			lxImpdircliFecexpo =  .Fechaexpo			lxImpdircliFmodifw =  .Fechamodificacionfw			lxImpdircliFaltafw =  .Fechaaltafw			lxImpdircliFectrans =  .Fechatransferencia			lxImpdircliTimestamp = goLibrerias.ObtenerTimestamp()			lxImpdircliHoraexpo =  .Horaexpo			lxImpdircliHaltafw =  .Horaaltafw			lxImpdircliHoraimpo =  .Horaimpo			lxImpdircliEsttrans =  .Estadotransferencia			lxImpdircliBdaltafw =  .Basededatosaltafw			lxImpdircliUaltafw =  .Usuarioaltafw			lxImpdircliVmodifw =  .Versionmodificacionfw			lxImpdircliZadsfw =  .Zadsfw			lxImpdircliValtafw =  .Versionaltafw			lxImpdircliUmodifw =  .Usuariomodificacionfw			lxImpdircliHmodifw =  .Horamodificacionfw			lxImpdircliBdmodifw =  .Basededatosmodificacionfw			lxImpdircliSaltafw =  .Seriealtafw			lxImpdircliSmodifw =  .Seriemodificacionfw			lxImpdircliNumero =  .Numero			lxImpdircliGlodesde =  .F_idglobal_desde			lxImpdircliSitfis =  .Situacionfiscal			lxImpdircliDescripcio =  .Descripcion			lxImpdircliGlohasta =  .F_idglobal_hasta			lxImpdircliPcuenta =  upper( .PlanDeCuentas_PK ) 			lxImpdircliImportanci =  .Importancia			lxImpdircliClidesde =  .F_cliente_desde			lxImpdircliClihasta =  .F_cliente_hasta			lxImpdircliVendesde =  .F_vendedor_desde			lxImpdircliVenhasta =  .F_vendedor_hasta			lxImpdircliLishasta =  .F_lista_hasta			lxImpdircliLisdesde =  .F_lista_desde			lxImpdircliCladesde =  .F_clasificacion_desde			lxImpdircliClahasta =  .F_clasificacion_hasta			lxImpdircliTipdesde =  .F_tipo_desde			lxImpdircliTiphasta =  .F_tipo_hasta			lxImpdircliCatdesde =  .F_categoria_desde			lxImpdircliCathasta =  .F_categoria_hasta			lxImpdircliProdesde =  .F_provincia_desde			lxImpdircliProhasta =  .F_provincia_hasta			lxImpdircliPaidesde =  .F_pais_desde			lxImpdircliPaihasta =  .F_pais_hasta			lxImpdircliImpval =  .Imputacion_PK 			lxImpdircliObs =  .Observacion
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
				update ZooLogic.IMPDIRCLI set "Fecimpo" = <<"'" + this.ConvertirDateSql( lxImpdircliFecimpo ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxImpdircliFecexpo ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxImpdircliFmodifw ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxImpdircliFaltafw ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxImpdircliFectrans ) + "'">>,"Timestamp" = <<lxImpdircliTimestamp>>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxImpdircliHoraexpo ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxImpdircliHaltafw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxImpdircliHoraimpo ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxImpdircliEsttrans ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxImpdircliBdaltafw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxImpdircliUaltafw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxImpdircliVmodifw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxImpdircliZadsfw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxImpdircliValtafw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxImpdircliUmodifw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxImpdircliHmodifw ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxImpdircliBdmodifw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxImpdircliSaltafw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxImpdircliSmodifw ) + "'">>,"Numero" = <<lxImpdircliNumero>>,"Glodesde" = <<"'" + this.FormatearTextoSql( lxImpdircliGlodesde ) + "'">>,"Sitfis" = <<lxImpdircliSitfis>>,"Descripcio" = <<"'" + this.FormatearTextoSql( lxImpdircliDescripcio ) + "'">>,"Glohasta" = <<"'" + this.FormatearTextoSql( lxImpdircliGlohasta ) + "'">>,"Pcuenta" = <<"'" + this.FormatearTextoSql( lxImpdircliPcuenta ) + "'">>,"Importanci" = <<lxImpdircliImportanci>>,"Clidesde" = <<"'" + this.FormatearTextoSql( lxImpdircliClidesde ) + "'">>,"Clihasta" = <<"'" + this.FormatearTextoSql( lxImpdircliClihasta ) + "'">>,"Vendesde" = <<"'" + this.FormatearTextoSql( lxImpdircliVendesde ) + "'">>,"Venhasta" = <<"'" + this.FormatearTextoSql( lxImpdircliVenhasta ) + "'">>,"Lishasta" = <<"'" + this.FormatearTextoSql( lxImpdircliLishasta ) + "'">>,"Lisdesde" = <<"'" + this.FormatearTextoSql( lxImpdircliLisdesde ) + "'">>,"Cladesde" = <<"'" + this.FormatearTextoSql( lxImpdircliCladesde ) + "'">>,"Clahasta" = <<"'" + this.FormatearTextoSql( lxImpdircliClahasta ) + "'">>,"Tipdesde" = <<"'" + this.FormatearTextoSql( lxImpdircliTipdesde ) + "'">>,"Tiphasta" = <<"'" + this.FormatearTextoSql( lxImpdircliTiphasta ) + "'">>,"Catdesde" = <<"'" + this.FormatearTextoSql( lxImpdircliCatdesde ) + "'">>,"Cathasta" = <<"'" + this.FormatearTextoSql( lxImpdircliCathasta ) + "'">>,"Prodesde" = <<"'" + this.FormatearTextoSql( lxImpdircliProdesde ) + "'">>,"Prohasta" = <<"'" + this.FormatearTextoSql( lxImpdircliProhasta ) + "'">>,"Paidesde" = <<"'" + this.FormatearTextoSql( lxImpdircliPaidesde ) + "'">>,"Paihasta" = <<"'" + this.FormatearTextoSql( lxImpdircliPaihasta ) + "'">>,"Impval" = <<lxImpdircliImpval>>,"Obs" = <<"'" + this.FormatearTextoSql( lxImpdircliObs ) + "'">> where "Numero" = <<lxImpdircliNumero>> and  IMPDIRCLI.NUMERO != 0 << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
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
		this.oEntidad.Timestamp = lxImpdircliTimestamp
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 NUMERO from ZooLogic.IMPDIRCLI where " + this.ConvertirFuncionesSql( " IMPDIRCLI.NUMERO != 0" ) )
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
			Local lxImpdircliNumero
			lxImpdircliNumero = .Numero

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Timestamp" as "Timestamp", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Ualtafw" as "Usuarioaltafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Hmodifw" as "Horamodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Numero" as "Numero", "Glodesde" as "F_idglobal_desde", "Sitfis" as "Situacionfiscal", "Descripcio" as "Descripcion", "Glohasta" as "F_idglobal_hasta", "Pcuenta" as "Plandecuentas", "Importanci" as "Importancia", "Clidesde" as "F_cliente_desde", "Clihasta" as "F_cliente_hasta", "Vendesde" as "F_vendedor_desde", "Venhasta" as "F_vendedor_hasta", "Lishasta" as "F_lista_hasta", "Lisdesde" as "F_lista_desde", "Cladesde" as "F_clasificacion_desde", "Clahasta" as "F_clasificacion_hasta", "Tipdesde" as "F_tipo_desde", "Tiphasta" as "F_tipo_hasta", "Catdesde" as "F_categoria_desde", "Cathasta" as "F_categoria_hasta", "Prodesde" as "F_provincia_desde", "Prohasta" as "F_provincia_hasta", "Paidesde" as "F_pais_desde", "Paihasta" as "F_pais_hasta", "Impval" as "Imputacion", "Obs" as "Observacion" from ZooLogic.IMPDIRCLI where "Numero" = <<lxImpdircliNumero>> and  IMPDIRCLI.NUMERO != 0
			endtext
			use in select('c_IMPDIRCLI')
			this.oConexion.EjecutarSql( lcSentencia, 'c_IMPDIRCLI', set( 'Datasession' ) )

			if reccount( 'c_IMPDIRCLI' ) = 0
				llRetorno = .f.
			else
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxImpdircliNumero as Variant
		llRetorno = .t.
		lxImpdircliNumero = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.IMPDIRCLI where "Numero" = <<lxImpdircliNumero>> and  IMPDIRCLI.NUMERO != 0
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
				select top 1 "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Timestamp" as "Timestamp", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Ualtafw" as "Usuarioaltafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Hmodifw" as "Horamodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Numero" as "Numero", "Glodesde" as "F_idglobal_desde", "Sitfis" as "Situacionfiscal", "Descripcio" as "Descripcion", "Glohasta" as "F_idglobal_hasta", "Pcuenta" as "Plandecuentas", "Importanci" as "Importancia", "Clidesde" as "F_cliente_desde", "Clihasta" as "F_cliente_hasta", "Vendesde" as "F_vendedor_desde", "Venhasta" as "F_vendedor_hasta", "Lishasta" as "F_lista_hasta", "Lisdesde" as "F_lista_desde", "Cladesde" as "F_clasificacion_desde", "Clahasta" as "F_clasificacion_hasta", "Tipdesde" as "F_tipo_desde", "Tiphasta" as "F_tipo_hasta", "Catdesde" as "F_categoria_desde", "Cathasta" as "F_categoria_hasta", "Prodesde" as "F_provincia_desde", "Prohasta" as "F_provincia_hasta", "Paidesde" as "F_pais_desde", "Paihasta" as "F_pais_hasta", "Impval" as "Imputacion", "Obs" as "Observacion" from ZooLogic.IMPDIRCLI where  IMPDIRCLI.NUMERO != 0 order by NUMERO
			endtext
			use in select('c_IMPDIRCLI')
			this.oConexion.EjecutarSql( lcSentencia, 'c_IMPDIRCLI', set( 'Datasession' ) )
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
				select top 1 "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Timestamp" as "Timestamp", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Ualtafw" as "Usuarioaltafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Hmodifw" as "Horamodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Numero" as "Numero", "Glodesde" as "F_idglobal_desde", "Sitfis" as "Situacionfiscal", "Descripcio" as "Descripcion", "Glohasta" as "F_idglobal_hasta", "Pcuenta" as "Plandecuentas", "Importanci" as "Importancia", "Clidesde" as "F_cliente_desde", "Clihasta" as "F_cliente_hasta", "Vendesde" as "F_vendedor_desde", "Venhasta" as "F_vendedor_hasta", "Lishasta" as "F_lista_hasta", "Lisdesde" as "F_lista_desde", "Cladesde" as "F_clasificacion_desde", "Clahasta" as "F_clasificacion_hasta", "Tipdesde" as "F_tipo_desde", "Tiphasta" as "F_tipo_hasta", "Catdesde" as "F_categoria_desde", "Cathasta" as "F_categoria_hasta", "Prodesde" as "F_provincia_desde", "Prohasta" as "F_provincia_hasta", "Paidesde" as "F_pais_desde", "Paihasta" as "F_pais_hasta", "Impval" as "Imputacion", "Obs" as "Observacion" from ZooLogic.IMPDIRCLI where  str( NUMERO, 8, 0) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  IMPDIRCLI.NUMERO != 0 order by NUMERO
			endtext
			use in select('c_IMPDIRCLI')
			this.oConexion.EjecutarSql( lcSentencia, 'c_IMPDIRCLI', set( 'Datasession' ) )
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
				select top 1 "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Timestamp" as "Timestamp", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Ualtafw" as "Usuarioaltafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Hmodifw" as "Horamodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Numero" as "Numero", "Glodesde" as "F_idglobal_desde", "Sitfis" as "Situacionfiscal", "Descripcio" as "Descripcion", "Glohasta" as "F_idglobal_hasta", "Pcuenta" as "Plandecuentas", "Importanci" as "Importancia", "Clidesde" as "F_cliente_desde", "Clihasta" as "F_cliente_hasta", "Vendesde" as "F_vendedor_desde", "Venhasta" as "F_vendedor_hasta", "Lishasta" as "F_lista_hasta", "Lisdesde" as "F_lista_desde", "Cladesde" as "F_clasificacion_desde", "Clahasta" as "F_clasificacion_hasta", "Tipdesde" as "F_tipo_desde", "Tiphasta" as "F_tipo_hasta", "Catdesde" as "F_categoria_desde", "Cathasta" as "F_categoria_hasta", "Prodesde" as "F_provincia_desde", "Prohasta" as "F_provincia_hasta", "Paidesde" as "F_pais_desde", "Paihasta" as "F_pais_hasta", "Impval" as "Imputacion", "Obs" as "Observacion" from ZooLogic.IMPDIRCLI where  str( NUMERO, 8, 0) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  IMPDIRCLI.NUMERO != 0 order by NUMERO desc
			endtext
			use in select('c_IMPDIRCLI')
			this.oConexion.EjecutarSql( lcSentencia, 'c_IMPDIRCLI', set( 'Datasession' ) )
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
				select top 1 "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Timestamp" as "Timestamp", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Ualtafw" as "Usuarioaltafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Hmodifw" as "Horamodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Numero" as "Numero", "Glodesde" as "F_idglobal_desde", "Sitfis" as "Situacionfiscal", "Descripcio" as "Descripcion", "Glohasta" as "F_idglobal_hasta", "Pcuenta" as "Plandecuentas", "Importanci" as "Importancia", "Clidesde" as "F_cliente_desde", "Clihasta" as "F_cliente_hasta", "Vendesde" as "F_vendedor_desde", "Venhasta" as "F_vendedor_hasta", "Lishasta" as "F_lista_hasta", "Lisdesde" as "F_lista_desde", "Cladesde" as "F_clasificacion_desde", "Clahasta" as "F_clasificacion_hasta", "Tipdesde" as "F_tipo_desde", "Tiphasta" as "F_tipo_hasta", "Catdesde" as "F_categoria_desde", "Cathasta" as "F_categoria_hasta", "Prodesde" as "F_provincia_desde", "Prohasta" as "F_provincia_hasta", "Paidesde" as "F_pais_desde", "Paihasta" as "F_pais_hasta", "Impval" as "Imputacion", "Obs" as "Observacion" from ZooLogic.IMPDIRCLI where  IMPDIRCLI.NUMERO != 0 order by NUMERO desc
			endtext
			use in select('c_IMPDIRCLI')
			this.oConexion.EjecutarSql( lcSentencia, 'c_IMPDIRCLI', set( 'Datasession' ) )
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
			lcXml = this.oConexion.EjecutarSql( "select Fecimpo,Fecexpo,Fmodifw,Faltafw,Fectrans,Timestamp,Horaexpo,Haltafw,Horaimpo,Esttrans,Bdalta" + ;
"fw,Ualtafw,Vmodifw,Zadsfw,Valtafw,Umodifw,Hmodifw,Bdmodifw,Saltafw,Smodifw,Numero,Glodesde,Sitfis,De" + ;
"scripcio,Glohasta,Pcuenta,Importanci,Clidesde,Clihasta,Vendesde,Venhasta,Lishasta,Lisdesde,Cladesde," + ;
"Clahasta,Tipdesde,Tiphasta,Catdesde,Cathasta,Prodesde,Prohasta,Paidesde,Paihasta,Impval,Obs" + ;
" from ZooLogic.IMPDIRCLI where  IMPDIRCLI.NUMERO != 0 and " + lcFiltro )
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
			local  lxImpdircliFecimpo, lxImpdircliFecexpo, lxImpdircliFmodifw, lxImpdircliFaltafw, lxImpdircliFectrans, lxImpdircliTimestamp, lxImpdircliHoraexpo, lxImpdircliHaltafw, lxImpdircliHoraimpo, lxImpdircliEsttrans, lxImpdircliBdaltafw, lxImpdircliUaltafw, lxImpdircliVmodifw, lxImpdircliZadsfw, lxImpdircliValtafw, lxImpdircliUmodifw, lxImpdircliHmodifw, lxImpdircliBdmodifw, lxImpdircliSaltafw, lxImpdircliSmodifw, lxImpdircliNumero, lxImpdircliGlodesde, lxImpdircliSitfis, lxImpdircliDescripcio, lxImpdircliGlohasta, lxImpdircliPcuenta, lxImpdircliImportanci, lxImpdircliClidesde, lxImpdircliClihasta, lxImpdircliVendesde, lxImpdircliVenhasta, lxImpdircliLishasta, lxImpdircliLisdesde, lxImpdircliCladesde, lxImpdircliClahasta, lxImpdircliTipdesde, lxImpdircliTiphasta, lxImpdircliCatdesde, lxImpdircliCathasta, lxImpdircliProdesde, lxImpdircliProhasta, lxImpdircliPaidesde, lxImpdircliPaihasta, lxImpdircliImpval, lxImpdircliObs
				lxImpdircliFecimpo = ctod( '  /  /    ' )			lxImpdircliFecexpo = ctod( '  /  /    ' )			lxImpdircliFmodifw = ctod( '  /  /    ' )			lxImpdircliFaltafw = ctod( '  /  /    ' )			lxImpdircliFectrans = ctod( '  /  /    ' )			lxImpdircliTimestamp = goLibrerias.ObtenerTimestamp()			lxImpdircliHoraexpo = []			lxImpdircliHaltafw = []			lxImpdircliHoraimpo = []			lxImpdircliEsttrans = []			lxImpdircliBdaltafw = []			lxImpdircliUaltafw = []			lxImpdircliVmodifw = []			lxImpdircliZadsfw = []			lxImpdircliValtafw = []			lxImpdircliUmodifw = []			lxImpdircliHmodifw = []			lxImpdircliBdmodifw = []			lxImpdircliSaltafw = []			lxImpdircliSmodifw = []			lxImpdircliNumero = 0			lxImpdircliGlodesde = []			lxImpdircliSitfis = 0			lxImpdircliDescripcio = []			lxImpdircliGlohasta = []			lxImpdircliPcuenta = []			lxImpdircliImportanci = 0			lxImpdircliClidesde = []			lxImpdircliClihasta = []			lxImpdircliVendesde = []			lxImpdircliVenhasta = []			lxImpdircliLishasta = []			lxImpdircliLisdesde = []			lxImpdircliCladesde = []			lxImpdircliClahasta = []			lxImpdircliTipdesde = []			lxImpdircliTiphasta = []			lxImpdircliCatdesde = []			lxImpdircliCathasta = []			lxImpdircliProdesde = []			lxImpdircliProhasta = []			lxImpdircliPaidesde = []			lxImpdircliPaihasta = []			lxImpdircliImpval = 0			lxImpdircliObs = []
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( [delete from ZooLogic.IMPDIRCLI where "NUMERO" = ] + transform( .oEntidad.NUMERO )+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'IMPDIRCLI' + '_' + tcCampo
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
		lcWhere = " Where  IMPDIRCLI.NUMERO != 0"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Timestamp" as "Timestamp", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Ualtafw" as "Usuarioaltafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Hmodifw" as "Horamodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Numero" as "Numero", "Glodesde" as "F_idglobal_desde", "Sitfis" as "Situacionfiscal", "Descripcio" as "Descripcion", "Glohasta" as "F_idglobal_hasta", "Pcuenta" as "Plandecuentas", "Importanci" as "Importancia", "Clidesde" as "F_cliente_desde", "Clihasta" as "F_cliente_hasta", "Vendesde" as "F_vendedor_desde", "Venhasta" as "F_vendedor_hasta", "Lishasta" as "F_lista_hasta", "Lisdesde" as "F_lista_desde", "Cladesde" as "F_clasificacion_desde", "Clahasta" as "F_clasificacion_hasta", "Tipdesde" as "F_tipo_desde", "Tiphasta" as "F_tipo_hasta", "Catdesde" as "F_categoria_desde", "Cathasta" as "F_categoria_hasta", "Prodesde" as "F_provincia_desde", "Prohasta" as "F_provincia_hasta", "Paidesde" as "F_pais_desde", "Paihasta" as "F_pais_hasta", "Impval" as "Imputacion", "Obs" as "Observacion"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'IMPDIRCLI', '', tnTope )
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
				Case lcAtributo == 'FECHAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECEXPO AS FECHAEXPO'
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'FECHATRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRANS AS FECHATRANSFERENCIA'
				Case lcAtributo == 'TIMESTAMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIMESTAMP AS TIMESTAMP'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
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
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'NUMERO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NUMERO AS NUMERO'
				Case lcAtributo == 'F_IDGLOBAL_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'GLODESDE AS F_IDGLOBAL_DESDE'
				Case lcAtributo == 'SITUACIONFISCAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SITFIS AS SITUACIONFISCAL'
				Case lcAtributo == 'DESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCRIPCIO AS DESCRIPCION'
				Case lcAtributo == 'F_IDGLOBAL_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'GLOHASTA AS F_IDGLOBAL_HASTA'
				Case lcAtributo == 'PLANDECUENTAS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PCUENTA AS PLANDECUENTAS'
				Case lcAtributo == 'IMPORTANCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IMPORTANCI AS IMPORTANCIA'
				Case lcAtributo == 'F_CLIENTE_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLIDESDE AS F_CLIENTE_DESDE'
				Case lcAtributo == 'F_CLIENTE_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLIHASTA AS F_CLIENTE_HASTA'
				Case lcAtributo == 'F_VENDEDOR_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VENDESDE AS F_VENDEDOR_DESDE'
				Case lcAtributo == 'F_VENDEDOR_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VENHASTA AS F_VENDEDOR_HASTA'
				Case lcAtributo == 'F_LISTA_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LISHASTA AS F_LISTA_HASTA'
				Case lcAtributo == 'F_LISTA_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LISDESDE AS F_LISTA_DESDE'
				Case lcAtributo == 'F_CLASIFICACION_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLADESDE AS F_CLASIFICACION_DESDE'
				Case lcAtributo == 'F_CLASIFICACION_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLAHASTA AS F_CLASIFICACION_HASTA'
				Case lcAtributo == 'F_TIPO_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPDESDE AS F_TIPO_DESDE'
				Case lcAtributo == 'F_TIPO_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPHASTA AS F_TIPO_HASTA'
				Case lcAtributo == 'F_CATEGORIA_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CATDESDE AS F_CATEGORIA_DESDE'
				Case lcAtributo == 'F_CATEGORIA_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CATHASTA AS F_CATEGORIA_HASTA'
				Case lcAtributo == 'F_PROVINCIA_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PRODESDE AS F_PROVINCIA_DESDE'
				Case lcAtributo == 'F_PROVINCIA_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PROHASTA AS F_PROVINCIA_HASTA'
				Case lcAtributo == 'F_PAIS_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PAIDESDE AS F_PAIS_DESDE'
				Case lcAtributo == 'F_PAIS_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PAIHASTA AS F_PAIS_HASTA'
				Case lcAtributo == 'IMPUTACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IMPVAL AS IMPUTACION'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHAIMPO'
				lcCampo = 'FECIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEXPO'
				lcCampo = 'FECEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'TIMESTAMP'
				lcCampo = 'TIMESTAMP'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
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
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'NUMERO'
				lcCampo = 'NUMERO'
			Case upper( alltrim( tcAtributo ) ) == 'F_IDGLOBAL_DESDE'
				lcCampo = 'GLODESDE'
			Case upper( alltrim( tcAtributo ) ) == 'SITUACIONFISCAL'
				lcCampo = 'SITFIS'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCION'
				lcCampo = 'DESCRIPCIO'
			Case upper( alltrim( tcAtributo ) ) == 'F_IDGLOBAL_HASTA'
				lcCampo = 'GLOHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'PLANDECUENTAS'
				lcCampo = 'PCUENTA'
			Case upper( alltrim( tcAtributo ) ) == 'IMPORTANCIA'
				lcCampo = 'IMPORTANCI'
			Case upper( alltrim( tcAtributo ) ) == 'F_CLIENTE_DESDE'
				lcCampo = 'CLIDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'F_CLIENTE_HASTA'
				lcCampo = 'CLIHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'F_VENDEDOR_DESDE'
				lcCampo = 'VENDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'F_VENDEDOR_HASTA'
				lcCampo = 'VENHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'F_LISTA_HASTA'
				lcCampo = 'LISHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'F_LISTA_DESDE'
				lcCampo = 'LISDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'F_CLASIFICACION_DESDE'
				lcCampo = 'CLADESDE'
			Case upper( alltrim( tcAtributo ) ) == 'F_CLASIFICACION_HASTA'
				lcCampo = 'CLAHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'F_TIPO_DESDE'
				lcCampo = 'TIPDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'F_TIPO_HASTA'
				lcCampo = 'TIPHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'F_CATEGORIA_DESDE'
				lcCampo = 'CATDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'F_CATEGORIA_HASTA'
				lcCampo = 'CATHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'F_PROVINCIA_DESDE'
				lcCampo = 'PRODESDE'
			Case upper( alltrim( tcAtributo ) ) == 'F_PROVINCIA_HASTA'
				lcCampo = 'PROHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'F_PAIS_DESDE'
				lcCampo = 'PAIDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'F_PAIS_HASTA'
				lcCampo = 'PAIHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'IMPUTACION'
				lcCampo = 'IMPVAL'
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
			local  lxImpdircliFecimpo, lxImpdircliFecexpo, lxImpdircliFmodifw, lxImpdircliFaltafw, lxImpdircliFectrans, lxImpdircliTimestamp, lxImpdircliHoraexpo, lxImpdircliHaltafw, lxImpdircliHoraimpo, lxImpdircliEsttrans, lxImpdircliBdaltafw, lxImpdircliUaltafw, lxImpdircliVmodifw, lxImpdircliZadsfw, lxImpdircliValtafw, lxImpdircliUmodifw, lxImpdircliHmodifw, lxImpdircliBdmodifw, lxImpdircliSaltafw, lxImpdircliSmodifw, lxImpdircliNumero, lxImpdircliGlodesde, lxImpdircliSitfis, lxImpdircliDescripcio, lxImpdircliGlohasta, lxImpdircliPcuenta, lxImpdircliImportanci, lxImpdircliClidesde, lxImpdircliClihasta, lxImpdircliVendesde, lxImpdircliVenhasta, lxImpdircliLishasta, lxImpdircliLisdesde, lxImpdircliCladesde, lxImpdircliClahasta, lxImpdircliTipdesde, lxImpdircliTiphasta, lxImpdircliCatdesde, lxImpdircliCathasta, lxImpdircliProdesde, lxImpdircliProhasta, lxImpdircliPaidesde, lxImpdircliPaihasta, lxImpdircliImpval, lxImpdircliObs
				lxImpdircliFecimpo =  .Fechaimpo			lxImpdircliFecexpo =  .Fechaexpo			lxImpdircliFmodifw =  .Fechamodificacionfw			lxImpdircliFaltafw =  .Fechaaltafw			lxImpdircliFectrans =  .Fechatransferencia			lxImpdircliTimestamp = goLibrerias.ObtenerTimestamp()			lxImpdircliHoraexpo =  .Horaexpo			lxImpdircliHaltafw =  .Horaaltafw			lxImpdircliHoraimpo =  .Horaimpo			lxImpdircliEsttrans =  .Estadotransferencia			lxImpdircliBdaltafw =  .Basededatosaltafw			lxImpdircliUaltafw =  .Usuarioaltafw			lxImpdircliVmodifw =  .Versionmodificacionfw			lxImpdircliZadsfw =  .Zadsfw			lxImpdircliValtafw =  .Versionaltafw			lxImpdircliUmodifw =  .Usuariomodificacionfw			lxImpdircliHmodifw =  .Horamodificacionfw			lxImpdircliBdmodifw =  .Basededatosmodificacionfw			lxImpdircliSaltafw =  .Seriealtafw			lxImpdircliSmodifw =  .Seriemodificacionfw			lxImpdircliNumero =  .Numero			lxImpdircliGlodesde =  .F_idglobal_desde			lxImpdircliSitfis =  .Situacionfiscal			lxImpdircliDescripcio =  .Descripcion			lxImpdircliGlohasta =  .F_idglobal_hasta			lxImpdircliPcuenta =  upper( .PlanDeCuentas_PK ) 			lxImpdircliImportanci =  .Importancia			lxImpdircliClidesde =  .F_cliente_desde			lxImpdircliClihasta =  .F_cliente_hasta			lxImpdircliVendesde =  .F_vendedor_desde			lxImpdircliVenhasta =  .F_vendedor_hasta			lxImpdircliLishasta =  .F_lista_hasta			lxImpdircliLisdesde =  .F_lista_desde			lxImpdircliCladesde =  .F_clasificacion_desde			lxImpdircliClahasta =  .F_clasificacion_hasta			lxImpdircliTipdesde =  .F_tipo_desde			lxImpdircliTiphasta =  .F_tipo_hasta			lxImpdircliCatdesde =  .F_categoria_desde			lxImpdircliCathasta =  .F_categoria_hasta			lxImpdircliProdesde =  .F_provincia_desde			lxImpdircliProhasta =  .F_provincia_hasta			lxImpdircliPaidesde =  .F_pais_desde			lxImpdircliPaihasta =  .F_pais_hasta			lxImpdircliImpval =  .Imputacion_PK 			lxImpdircliObs =  .Observacion
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.IMPDIRCLI ( "Fecimpo","Fecexpo","Fmodifw","Faltafw","Fectrans","Timestamp","Horaexpo","Haltafw","Horaimpo","Esttrans","Bdaltafw","Ualtafw","Vmodifw","Zadsfw","Valtafw","Umodifw","Hmodifw","Bdmodifw","Saltafw","Smodifw","Numero","Glodesde","Sitfis","Descripcio","Glohasta","Pcuenta","Importanci","Clidesde","Clihasta","Vendesde","Venhasta","Lishasta","Lisdesde","Cladesde","Clahasta","Tipdesde","Tiphasta","Catdesde","Cathasta","Prodesde","Prohasta","Paidesde","Paihasta","Impval","Obs" ) values ( <<"'" + this.ConvertirDateSql( lxImpdircliFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxImpdircliFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxImpdircliFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxImpdircliFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxImpdircliFectrans ) + "'" >>, <<lxImpdircliTimestamp >>, <<"'" + this.FormatearTextoSql( lxImpdircliHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircliHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircliHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircliEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircliBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircliUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircliVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircliZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircliValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircliUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircliHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircliBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircliSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircliSmodifw ) + "'" >>, <<lxImpdircliNumero >>, <<"'" + this.FormatearTextoSql( lxImpdircliGlodesde ) + "'" >>, <<lxImpdircliSitfis >>, <<"'" + this.FormatearTextoSql( lxImpdircliDescripcio ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircliGlohasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircliPcuenta ) + "'" >>, <<lxImpdircliImportanci >>, <<"'" + this.FormatearTextoSql( lxImpdircliClidesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircliClihasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircliVendesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircliVenhasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircliLishasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircliLisdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircliCladesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircliClahasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircliTipdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircliTiphasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircliCatdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircliCathasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircliProdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircliProhasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircliPaidesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdircliPaihasta ) + "'" >>, <<lxImpdircliImpval >>, <<"'" + this.FormatearTextoSql( lxImpdircliObs ) + "'" >> )
		endtext
		loColeccion.cTabla = 'IMPDIRCLI' 
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
			local  lxImpdircliFecimpo, lxImpdircliFecexpo, lxImpdircliFmodifw, lxImpdircliFaltafw, lxImpdircliFectrans, lxImpdircliTimestamp, lxImpdircliHoraexpo, lxImpdircliHaltafw, lxImpdircliHoraimpo, lxImpdircliEsttrans, lxImpdircliBdaltafw, lxImpdircliUaltafw, lxImpdircliVmodifw, lxImpdircliZadsfw, lxImpdircliValtafw, lxImpdircliUmodifw, lxImpdircliHmodifw, lxImpdircliBdmodifw, lxImpdircliSaltafw, lxImpdircliSmodifw, lxImpdircliNumero, lxImpdircliGlodesde, lxImpdircliSitfis, lxImpdircliDescripcio, lxImpdircliGlohasta, lxImpdircliPcuenta, lxImpdircliImportanci, lxImpdircliClidesde, lxImpdircliClihasta, lxImpdircliVendesde, lxImpdircliVenhasta, lxImpdircliLishasta, lxImpdircliLisdesde, lxImpdircliCladesde, lxImpdircliClahasta, lxImpdircliTipdesde, lxImpdircliTiphasta, lxImpdircliCatdesde, lxImpdircliCathasta, lxImpdircliProdesde, lxImpdircliProhasta, lxImpdircliPaidesde, lxImpdircliPaihasta, lxImpdircliImpval, lxImpdircliObs
				lxImpdircliFecimpo =  .Fechaimpo			lxImpdircliFecexpo =  .Fechaexpo			lxImpdircliFmodifw =  .Fechamodificacionfw			lxImpdircliFaltafw =  .Fechaaltafw			lxImpdircliFectrans =  .Fechatransferencia			lxImpdircliTimestamp = goLibrerias.ObtenerTimestamp()			lxImpdircliHoraexpo =  .Horaexpo			lxImpdircliHaltafw =  .Horaaltafw			lxImpdircliHoraimpo =  .Horaimpo			lxImpdircliEsttrans =  .Estadotransferencia			lxImpdircliBdaltafw =  .Basededatosaltafw			lxImpdircliUaltafw =  .Usuarioaltafw			lxImpdircliVmodifw =  .Versionmodificacionfw			lxImpdircliZadsfw =  .Zadsfw			lxImpdircliValtafw =  .Versionaltafw			lxImpdircliUmodifw =  .Usuariomodificacionfw			lxImpdircliHmodifw =  .Horamodificacionfw			lxImpdircliBdmodifw =  .Basededatosmodificacionfw			lxImpdircliSaltafw =  .Seriealtafw			lxImpdircliSmodifw =  .Seriemodificacionfw			lxImpdircliNumero =  .Numero			lxImpdircliGlodesde =  .F_idglobal_desde			lxImpdircliSitfis =  .Situacionfiscal			lxImpdircliDescripcio =  .Descripcion			lxImpdircliGlohasta =  .F_idglobal_hasta			lxImpdircliPcuenta =  upper( .PlanDeCuentas_PK ) 			lxImpdircliImportanci =  .Importancia			lxImpdircliClidesde =  .F_cliente_desde			lxImpdircliClihasta =  .F_cliente_hasta			lxImpdircliVendesde =  .F_vendedor_desde			lxImpdircliVenhasta =  .F_vendedor_hasta			lxImpdircliLishasta =  .F_lista_hasta			lxImpdircliLisdesde =  .F_lista_desde			lxImpdircliCladesde =  .F_clasificacion_desde			lxImpdircliClahasta =  .F_clasificacion_hasta			lxImpdircliTipdesde =  .F_tipo_desde			lxImpdircliTiphasta =  .F_tipo_hasta			lxImpdircliCatdesde =  .F_categoria_desde			lxImpdircliCathasta =  .F_categoria_hasta			lxImpdircliProdesde =  .F_provincia_desde			lxImpdircliProhasta =  .F_provincia_hasta			lxImpdircliPaidesde =  .F_pais_desde			lxImpdircliPaihasta =  .F_pais_hasta			lxImpdircliImpval =  .Imputacion_PK 			lxImpdircliObs =  .Observacion
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.NUMERO
			lcValorClavePrimariaString = transform( this.oEntidad.NUMERO )

			lcFiltro = ["Numero" = ] + lcValorClavePrimariaString  + [ and  IMPDIRCLI.NUMERO != 0]
			text to lcSentencia noshow textmerge
				update ZooLogic.IMPDIRCLI set "Fecimpo" = <<"'" + this.ConvertirDateSql( lxImpdircliFecimpo ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxImpdircliFecexpo ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxImpdircliFmodifw ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxImpdircliFaltafw ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxImpdircliFectrans ) + "'">>, "Timestamp" = <<lxImpdircliTimestamp>>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxImpdircliHoraexpo ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxImpdircliHaltafw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxImpdircliHoraimpo ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxImpdircliEsttrans ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxImpdircliBdaltafw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxImpdircliUaltafw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxImpdircliVmodifw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxImpdircliZadsfw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxImpdircliValtafw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxImpdircliUmodifw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxImpdircliHmodifw ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxImpdircliBdmodifw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxImpdircliSaltafw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxImpdircliSmodifw ) + "'">>, "Numero" = <<lxImpdircliNumero>>, "Glodesde" = <<"'" + this.FormatearTextoSql( lxImpdircliGlodesde ) + "'">>, "Sitfis" = <<lxImpdircliSitfis>>, "Descripcio" = <<"'" + this.FormatearTextoSql( lxImpdircliDescripcio ) + "'">>, "Glohasta" = <<"'" + this.FormatearTextoSql( lxImpdircliGlohasta ) + "'">>, "Pcuenta" = <<"'" + this.FormatearTextoSql( lxImpdircliPcuenta ) + "'">>, "Importanci" = <<lxImpdircliImportanci>>, "Clidesde" = <<"'" + this.FormatearTextoSql( lxImpdircliClidesde ) + "'">>, "Clihasta" = <<"'" + this.FormatearTextoSql( lxImpdircliClihasta ) + "'">>, "Vendesde" = <<"'" + this.FormatearTextoSql( lxImpdircliVendesde ) + "'">>, "Venhasta" = <<"'" + this.FormatearTextoSql( lxImpdircliVenhasta ) + "'">>, "Lishasta" = <<"'" + this.FormatearTextoSql( lxImpdircliLishasta ) + "'">>, "Lisdesde" = <<"'" + this.FormatearTextoSql( lxImpdircliLisdesde ) + "'">>, "Cladesde" = <<"'" + this.FormatearTextoSql( lxImpdircliCladesde ) + "'">>, "Clahasta" = <<"'" + this.FormatearTextoSql( lxImpdircliClahasta ) + "'">>, "Tipdesde" = <<"'" + this.FormatearTextoSql( lxImpdircliTipdesde ) + "'">>, "Tiphasta" = <<"'" + this.FormatearTextoSql( lxImpdircliTiphasta ) + "'">>, "Catdesde" = <<"'" + this.FormatearTextoSql( lxImpdircliCatdesde ) + "'">>, "Cathasta" = <<"'" + this.FormatearTextoSql( lxImpdircliCathasta ) + "'">>, "Prodesde" = <<"'" + this.FormatearTextoSql( lxImpdircliProdesde ) + "'">>, "Prohasta" = <<"'" + this.FormatearTextoSql( lxImpdircliProhasta ) + "'">>, "Paidesde" = <<"'" + this.FormatearTextoSql( lxImpdircliPaidesde ) + "'">>, "Paihasta" = <<"'" + this.FormatearTextoSql( lxImpdircliPaihasta ) + "'">>, "Impval" = <<lxImpdircliImpval>>, "Obs" = <<"'" + this.FormatearTextoSql( lxImpdircliObs ) + "'">> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'IMPDIRCLI' 
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

			lcFiltro = ["Numero" = ] + lcValorClavePrimariaString  + [ and  IMPDIRCLI.NUMERO != 0]
		loColeccion.Agregar( 'delete from ZooLogic.IMPDIRCLI where ' + lcFiltro )
			loColeccion.cTabla = 'IMPDIRCLI' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.IMPDIRCLI where  IMPDIRCLI.NUMERO != 0" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.IMPDIRCLI where NUMERO = " + transform( this.oEntidad.NUMERO )+ " and  IMPDIRCLI.NUMERO != 0" )
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
		local lcCursor as String, ldFecha as Date, lcHora as string, lcValorABuscar As String, lxValorClavePK As variant, lxValorClavePrimaria As variant, lcIdentificadorParaLoguear as string, lxIMPDIRCLISitFis as variant, lcMensajeExtra as String
		lcValorABuscar = ''
		lxValorClavePK = ''
		lcMensajeExtra = ''
		lcCursor = This.oEntidad.cPrefijoRecibir + 'IMPDIRCLI'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.IMPDIRCLI Where NUMERO = ] + transform( &lcCursor..NUMERO ), 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					this.oConexion.EjecutarSql( [UPDATE ZooLogic.IMPDIRCLI set  FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, TIMESTAMP = ] + transform( &lcCursor..TIMESTAMP )+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, NUMERO = ] + transform( &lcCursor..NUMERO )+ [, GloDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..GloDesde ) + "'"+ [, SitFis = ] + transform( &lcCursor..SitFis )+ [, Descripcio = ] + "'" + this.FormatearTextoSql( &lcCursor..Descripcio ) + "'"+ [, GloHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..GloHasta ) + "'"+ [, PCUENTA = ] + "'" + this.FormatearTextoSql( &lcCursor..PCUENTA ) + "'"+ [, Importanci = ] + transform( &lcCursor..Importanci )+ [, CliDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..CliDesde ) + "'"+ [, CliHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..CliHasta ) + "'"+ [, VenDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..VenDesde ) + "'"+ [, VenHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..VenHasta ) + "'"+ [, LisHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..LisHasta ) + "'"+ [, LisDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..LisDesde ) + "'"+ [, ClaDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..ClaDesde ) + "'"+ [, ClaHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..ClaHasta ) + "'"+ [, TipDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..TipDesde ) + "'"+ [, TipHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..TipHasta ) + "'"+ [, CatDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..CatDesde ) + "'"+ [, CatHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..CatHasta ) + "'"+ [, ProDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..ProDesde ) + "'"+ [, ProHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..ProHasta ) + "'"+ [, PaiDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..PaiDesde ) + "'"+ [, PaiHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..PaiHasta ) + "'"+ [, ImpVal = ] + transform( &lcCursor..ImpVal )+ [, OBS = ] + "'" + this.FormatearTextoSql( &lcCursor..OBS ) + "'" + [ Where NUMERO = ] + transform( &lcCursor..NUMERO ) )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
				endIf
			else
				Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
				Text to lcCampos noShow
					 FECIMPO, FECEXPO, FMODIFW, FALTAFW, FECTRANS, TIMESTAMP, HORAEXPO, HALTAFW, HORAIMPO, ESTTRANS, BDALTAFW, UALTAFW, VMODIFW, ZADSFW, VALTAFW, UMODIFW, HMODIFW, BDMODIFW, SALTAFW, SMODIFW, NUMERO, GloDesde, SitFis, Descripcio, GloHasta, PCUENTA, Importanci, CliDesde, CliHasta, VenDesde, VenHasta, LisHasta, LisDesde, ClaDesde, ClaHasta, TipDesde, TipHasta, CatDesde, CatHasta, ProDesde, ProHasta, PaiDesde, PaiHasta, ImpVal, OBS
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + transform( &lcCursor..TIMESTAMP ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + transform( &lcCursor..NUMERO )
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..GloDesde ) + "'" + ',' + transform( &lcCursor..SitFis ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..Descripcio ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..GloHasta ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..PCUENTA ) + "'" + ',' + transform( &lcCursor..Importanci ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..CliDesde ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..CliHasta ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VenDesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VenHasta ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..LisHasta ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..LisDesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ClaDesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ClaHasta ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..TipDesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..TipHasta ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CatDesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CatHasta ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ProDesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ProHasta ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..PaiDesde ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..PaiHasta ) + "'" + ',' + transform( &lcCursor..ImpVal ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..OBS ) + "'"
lcValoresCampos = substr(lcValoresCampos,2) 

				this.oConexion.EjecutarSql( [Insert into ZooLogic.IMPDIRCLI ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
				this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'IMPDIRCLI'
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
			Case  lcAlias == lcPrefijo + 'IMPDIRCLI'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'IMPDIRCLI_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'IMPDIRCLI_OBS'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_IMPDIRCLI')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'IMPDIRCLI'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..NUMERO
		llCondicion = isnull( lxVar )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad IMPDIRCLI. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'IMPDIRCLI'
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
			lcCursor = This.oEntidad.cPrefijoRecibir + 'IMPDIRCLI'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_IMPDIRCLI') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_IMPDIRCLI
Create Table ZooLogic.TablaTrabajo_IMPDIRCLI ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fecimpo" datetime  null, 
"fecexpo" datetime  null, 
"fmodifw" datetime  null, 
"faltafw" datetime  null, 
"fectrans" datetime  null, 
"timestamp" numeric( 20, 0 )  null, 
"horaexpo" char( 8 )  null, 
"haltafw" char( 8 )  null, 
"horaimpo" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"bdaltafw" char( 8 )  null, 
"ualtafw" char( 100 )  null, 
"vmodifw" char( 13 )  null, 
"zadsfw" varchar(max)  null, 
"valtafw" char( 13 )  null, 
"umodifw" char( 100 )  null, 
"hmodifw" char( 8 )  null, 
"bdmodifw" char( 8 )  null, 
"saltafw" char( 7 )  null, 
"smodifw" char( 7 )  null, 
"numero" numeric( 8, 0 )  null, 
"glodesde" char( 38 )  null, 
"sitfis" numeric( 2, 0 )  null, 
"descripcio" char( 50 )  null, 
"glohasta" char( 38 )  null, 
"pcuenta" char( 30 )  null, 
"importanci" numeric( 5, 0 )  null, 
"clidesde" char( 10 )  null, 
"clihasta" char( 10 )  null, 
"vendesde" char( 10 )  null, 
"venhasta" char( 10 )  null, 
"lishasta" char( 5 )  null, 
"lisdesde" char( 5 )  null, 
"cladesde" char( 6 )  null, 
"clahasta" char( 6 )  null, 
"tipdesde" char( 10 )  null, 
"tiphasta" char( 10 )  null, 
"catdesde" char( 10 )  null, 
"cathasta" char( 10 )  null, 
"prodesde" char( 2 )  null, 
"prohasta" char( 2 )  null, 
"paidesde" char( 3 )  null, 
"paihasta" char( 3 )  null, 
"impval" numeric( 8, 0 )  null, 
"obs" varchar(max)  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_IMPDIRCLI' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_IMPDIRCLI' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'IMPDIRCLI'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		with loManejador
			if this.oEntidad.VerificarContexto( 'CB' )
			else
				.AgregarMapeo('Nrolinea','Nrolinea')
			endif
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('timestamp','timestamp')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('numero','numero')
			.AgregarMapeo('glodesde','glodesde')
			.AgregarMapeo('sitfis','sitfis')
			.AgregarMapeo('descripcio','descripcio')
			.AgregarMapeo('glohasta','glohasta')
			.AgregarMapeo('pcuenta','pcuenta')
			.AgregarMapeo('importanci','importanci')
			.AgregarMapeo('clidesde','clidesde')
			.AgregarMapeo('clihasta','clihasta')
			.AgregarMapeo('vendesde','vendesde')
			.AgregarMapeo('venhasta','venhasta')
			.AgregarMapeo('lishasta','lishasta')
			.AgregarMapeo('lisdesde','lisdesde')
			.AgregarMapeo('cladesde','cladesde')
			.AgregarMapeo('clahasta','clahasta')
			.AgregarMapeo('tipdesde','tipdesde')
			.AgregarMapeo('tiphasta','tiphasta')
			.AgregarMapeo('catdesde','catdesde')
			.AgregarMapeo('cathasta','cathasta')
			.AgregarMapeo('prodesde','prodesde')
			.AgregarMapeo('prohasta','prohasta')
			.AgregarMapeo('paidesde','paidesde')
			.AgregarMapeo('paihasta','paihasta')
			.AgregarMapeo('impval','impval')
			.AgregarMapeo('obs','obs')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_IMPDIRCLI'
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
				Update t Set t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.TIMESTAMP = isnull( d.TIMESTAMP, t.TIMESTAMP ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.NUMERO = isnull( d.NUMERO, t.NUMERO ),t.GLODESDE = isnull( d.GLODESDE, t.GLODESDE ),t.SITFIS = isnull( d.SITFIS, t.SITFIS ),t.DESCRIPCIO = isnull( d.DESCRIPCIO, t.DESCRIPCIO ),t.GLOHASTA = isnull( d.GLOHASTA, t.GLOHASTA ),t.PCUENTA = isnull( d.PCUENTA, t.PCUENTA ),t.IMPORTANCI = isnull( d.IMPORTANCI, t.IMPORTANCI ),t.CLIDESDE = isnull( d.CLIDESDE, t.CLIDESDE ),t.CLIHASTA = isnull( d.CLIHASTA, t.CLIHASTA ),t.VENDESDE = isnull( d.VENDESDE, t.VENDESDE ),t.VENHASTA = isnull( d.VENHASTA, t.VENHASTA ),t.LISHASTA = isnull( d.LISHASTA, t.LISHASTA ),t.LISDESDE = isnull( d.LISDESDE, t.LISDESDE ),t.CLADESDE = isnull( d.CLADESDE, t.CLADESDE ),t.CLAHASTA = isnull( d.CLAHASTA, t.CLAHASTA ),t.TIPDESDE = isnull( d.TIPDESDE, t.TIPDESDE ),t.TIPHASTA = isnull( d.TIPHASTA, t.TIPHASTA ),t.CATDESDE = isnull( d.CATDESDE, t.CATDESDE ),t.CATHASTA = isnull( d.CATHASTA, t.CATHASTA ),t.PRODESDE = isnull( d.PRODESDE, t.PRODESDE ),t.PROHASTA = isnull( d.PROHASTA, t.PROHASTA ),t.PAIDESDE = isnull( d.PAIDESDE, t.PAIDESDE ),t.PAIHASTA = isnull( d.PAIHASTA, t.PAIHASTA ),t.IMPVAL = isnull( d.IMPVAL, t.IMPVAL ),t.OBS = isnull( d.OBS, t.OBS )
					from ZooLogic.IMPDIRCLI t inner join deleted d 
							 on t.NUMERO = d.NUMERO
				-- Fin Updates
				insert into ZooLogic.IMPDIRCLI(Fecimpo,Fecexpo,Fmodifw,Faltafw,Fectrans,Timestamp,Horaexpo,Haltafw,Horaimpo,Esttrans,Bdaltafw,Ualtafw,Vmodifw,Zadsfw,Valtafw,Umodifw,Hmodifw,Bdmodifw,Saltafw,Smodifw,Numero,Glodesde,Sitfis,Descripcio,Glohasta,Pcuenta,Importanci,Clidesde,Clihasta,Vendesde,Venhasta,Lishasta,Lisdesde,Cladesde,Clahasta,Tipdesde,Tiphasta,Catdesde,Cathasta,Prodesde,Prohasta,Paidesde,Paihasta,Impval,Obs)
					Select isnull( d.FECIMPO,''),isnull( d.FECEXPO,''),isnull( d.FMODIFW,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FECTRANS,''),isnull( d.TIMESTAMP,0),isnull( d.HORAEXPO,''),convert( char(8), getdate(), 108 ),isnull( d.HORAIMPO,''),isnull( d.ESTTRANS,''),isnull( d.BDALTAFW,''),isnull( d.UALTAFW,''),isnull( d.VMODIFW,''),isnull( d.ZADSFW,''),isnull( d.VALTAFW,''),isnull( d.UMODIFW,''),isnull( d.HMODIFW,''),isnull( d.BDMODIFW,''),isnull( d.SALTAFW,''),isnull( d.SMODIFW,''),isnull( d.NUMERO,0),isnull( d.GLODESDE,''),isnull( d.SITFIS,0),isnull( d.DESCRIPCIO,''),isnull( d.GLOHASTA,''),isnull( d.PCUENTA,''),isnull( d.IMPORTANCI,0),isnull( d.CLIDESDE,''),isnull( d.CLIHASTA,''),isnull( d.VENDESDE,''),isnull( d.VENHASTA,''),isnull( d.LISHASTA,''),isnull( d.LISDESDE,''),isnull( d.CLADESDE,''),isnull( d.CLAHASTA,''),isnull( d.TIPDESDE,''),isnull( d.TIPHASTA,''),isnull( d.CATDESDE,''),isnull( d.CATHASTA,''),isnull( d.PRODESDE,''),isnull( d.PROHASTA,''),isnull( d.PAIDESDE,''),isnull( d.PAIHASTA,''),isnull( d.IMPVAL,0),isnull( d.OBS,'')
						From deleted d left join ZooLogic.IMPDIRCLI pk 
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_IMPDIRCLI') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_IMPDIRCLI
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_IMPDIRCLI' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_IMPDIRCLI.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_IMPDIRCLI.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_IMPDIRCLI.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_IMPDIRCLI.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_IMPDIRCLI.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Timestamp = nvl( c_IMPDIRCLI.Timestamp, 0 )
					.Horaexpo = nvl( c_IMPDIRCLI.Horaexpo, [] )
					.Horaaltafw = nvl( c_IMPDIRCLI.Horaaltafw, [] )
					.Horaimpo = nvl( c_IMPDIRCLI.Horaimpo, [] )
					.Estadotransferencia = nvl( c_IMPDIRCLI.Estadotransferencia, [] )
					.Basededatosaltafw = nvl( c_IMPDIRCLI.Basededatosaltafw, [] )
					.Usuarioaltafw = nvl( c_IMPDIRCLI.Usuarioaltafw, [] )
					.Versionmodificacionfw = nvl( c_IMPDIRCLI.Versionmodificacionfw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Versionaltafw = nvl( c_IMPDIRCLI.Versionaltafw, [] )
					.Usuariomodificacionfw = nvl( c_IMPDIRCLI.Usuariomodificacionfw, [] )
					.Horamodificacionfw = nvl( c_IMPDIRCLI.Horamodificacionfw, [] )
					.Basededatosmodificacionfw = nvl( c_IMPDIRCLI.Basededatosmodificacionfw, [] )
					.Seriealtafw = nvl( c_IMPDIRCLI.Seriealtafw, [] )
					.Seriemodificacionfw = nvl( c_IMPDIRCLI.Seriemodificacionfw, [] )
					.Numero = nvl( c_IMPDIRCLI.Numero, 0 )
					.F_idglobal_desde = nvl( c_IMPDIRCLI.F_idglobal_desde, [] )
					.Situacionfiscal = nvl( c_IMPDIRCLI.Situacionfiscal, 0 )
					.Descripcion = nvl( c_IMPDIRCLI.Descripcion, [] )
					.F_idglobal_hasta = nvl( c_IMPDIRCLI.F_idglobal_hasta, [] )
					.Plandecuentas_PK =  nvl( c_IMPDIRCLI.Plandecuentas, [] )
					.Importancia = nvl( c_IMPDIRCLI.Importancia, 0 )
					.F_cliente_desde = nvl( c_IMPDIRCLI.F_cliente_desde, [] )
					.F_cliente_hasta = nvl( c_IMPDIRCLI.F_cliente_hasta, [] )
					.F_vendedor_desde = nvl( c_IMPDIRCLI.F_vendedor_desde, [] )
					.F_vendedor_hasta = nvl( c_IMPDIRCLI.F_vendedor_hasta, [] )
					.F_lista_hasta = nvl( c_IMPDIRCLI.F_lista_hasta, [] )
					.F_lista_desde = nvl( c_IMPDIRCLI.F_lista_desde, [] )
					.F_clasificacion_desde = nvl( c_IMPDIRCLI.F_clasificacion_desde, [] )
					.F_clasificacion_hasta = nvl( c_IMPDIRCLI.F_clasificacion_hasta, [] )
					.F_tipo_desde = nvl( c_IMPDIRCLI.F_tipo_desde, [] )
					.F_tipo_hasta = nvl( c_IMPDIRCLI.F_tipo_hasta, [] )
					.F_categoria_desde = nvl( c_IMPDIRCLI.F_categoria_desde, [] )
					.F_categoria_hasta = nvl( c_IMPDIRCLI.F_categoria_hasta, [] )
					.F_provincia_desde = nvl( c_IMPDIRCLI.F_provincia_desde, [] )
					.F_provincia_hasta = nvl( c_IMPDIRCLI.F_provincia_hasta, [] )
					.F_pais_desde = nvl( c_IMPDIRCLI.F_pais_desde, [] )
					.F_pais_hasta = nvl( c_IMPDIRCLI.F_pais_hasta, [] )
					.Imputacion_PK =  nvl( c_IMPDIRCLI.Imputacion, 0 )
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
		return c_IMPDIRCLI.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.IMPDIRCLI' )
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
								from ZooLogic.IMPDIRCLI 
								Where   IMPDIRCLI.NUMERO != 0
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "IMPDIRCLI", "", lcCursor, set("Datasession") )
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
			"Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Timestamp" as "Timestamp", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Ualtafw" as "Usuarioaltafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Hmodifw" as "Horamodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Numero" as "Numero", "Glodesde" as "F_idglobal_desde", "Sitfis" as "Situacionfiscal", "Descripcio" as "Descripcion", "Glohasta" as "F_idglobal_hasta", "Pcuenta" as "Plandecuentas", "Importanci" as "Importancia", "Clidesde" as "F_cliente_desde", "Clihasta" as "F_cliente_hasta", "Vendesde" as "F_vendedor_desde", "Venhasta" as "F_vendedor_hasta", "Lishasta" as "F_lista_hasta", "Lisdesde" as "F_lista_desde", "Cladesde" as "F_clasificacion_desde", "Clahasta" as "F_clasificacion_hasta", "Tipdesde" as "F_tipo_desde", "Tiphasta" as "F_tipo_hasta", "Catdesde" as "F_categoria_desde", "Cathasta" as "F_categoria_hasta", "Prodesde" as "F_provincia_desde", "Prohasta" as "F_provincia_hasta", "Paidesde" as "F_pais_desde", "Paihasta" as "F_pais_hasta", "Impval" as "Imputacion", "Obs" as "Observacion"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.IMPDIRCLI 
								Where   IMPDIRCLI.NUMERO != 0
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
	Tabla = 'IMPDIRCLI'
	Filtro = " IMPDIRCLI.NUMERO != 0"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " IMPDIRCLI.NUMERO != 0"
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
	<row entidad="IMPDIRCLI                               " atributo="FECHAIMPO                               " tabla="IMPDIRCLI      " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCLI                               " atributo="FECHAEXPO                               " tabla="IMPDIRCLI      " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCLI                               " atributo="FECHAMODIFICACIONFW                     " tabla="IMPDIRCLI      " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCLI                               " atributo="FECHAALTAFW                             " tabla="IMPDIRCLI      " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCLI                               " atributo="FECHATRANSFERENCIA                      " tabla="IMPDIRCLI      " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha transferencia                                                                                                                                             " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCLI                               " atributo="TIMESTAMP                               " tabla="IMPDIRCLI      " campo="TIMESTAMP " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCLI                               " atributo="HORAEXPO                                " tabla="IMPDIRCLI      " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCLI                               " atributo="HORAALTAFW                              " tabla="IMPDIRCLI      " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCLI                               " atributo="HORAIMPO                                " tabla="IMPDIRCLI      " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCLI                               " atributo="ESTADOTRANSFERENCIA                     " tabla="IMPDIRCLI      " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado transferencia                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCLI                               " atributo="BASEDEDATOSALTAFW                       " tabla="IMPDIRCLI      " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCLI                               " atributo="USUARIOALTAFW                           " tabla="IMPDIRCLI      " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCLI                               " atributo="VERSIONMODIFICACIONFW                   " tabla="IMPDIRCLI      " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCLI                               " atributo="ZADSFW                                  " tabla="IMPDIRCLI      " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCLI                               " atributo="VERSIONALTAFW                           " tabla="IMPDIRCLI      " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCLI                               " atributo="USUARIOMODIFICACIONFW                   " tabla="IMPDIRCLI      " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCLI                               " atributo="HORAMODIFICACIONFW                      " tabla="IMPDIRCLI      " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCLI                               " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="IMPDIRCLI      " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCLI                               " atributo="SERIEALTAFW                             " tabla="IMPDIRCLI      " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCLI                               " atributo="SERIEMODIFICACIONFW                     " tabla="IMPDIRCLI      " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCLI                               " atributo="NUMERO                                  " tabla="IMPDIRCLI      " campo="NUMERO    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="8" etiqueta="Número                                                                                                                                                          " dominio="CODIGONUMERICO                " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCLI                               " atributo="F_IDGLOBAL_DESDE                        " tabla="IMPDIRCLI      " campo="GLODESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="Id centralización desde                                                                                                                                         " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="11" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCLI                               " atributo="SITUACIONFISCAL                         " tabla="IMPDIRCLI      " campo="SITFIS    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="402" etiqueta="Situación fiscal                                                                                                                                                " dominio="COMBOSITUACIONFISCALCONVACIO  " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="12" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCLI                               " atributo="DESCRIPCION                             " tabla="IMPDIRCLI      " campo="DESCRIPCIO" claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="4" etiqueta="Descripción                                                                                                                                                     " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCLI                               " atributo="F_IDGLOBAL_HASTA                        " tabla="IMPDIRCLI      " campo="GLOHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ                                                                                                                                                                                                                        " obligatorio="false" admitebusqueda="404" etiqueta="Id centralización hasta                                                                                                                                         " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="11" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCLI                               " atributo="PLANDECUENTAS                           " tabla="IMPDIRCLI      " campo="PCUENTA   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="PLANDECUENTAS                           " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="406" etiqueta="Cuenta                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="&quot; plancuenta.CTAIMPUT = .t. &quot;                                                                                                                                                                           " grupo="0" subgrupo="1" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCLI                               " atributo="IMPORTANCIA                             " tabla="IMPDIRCLI      " campo="IMPORTANCI" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="4" etiqueta="Importancia                                                                                                                                                     " dominio="NUMERICONONEGATIVO            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCLI                               " atributo="F_CLIENTE_DESDE                         " tabla="IMPDIRCLI      " campo="CLIDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="408" etiqueta="Cliente                                                                                                                                                         " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="10" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCLI                               " atributo="F_CLIENTE_HASTA                         " tabla="IMPDIRCLI      " campo="CLIHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="ZZZZZZZZZZ                                                                                                                                                                                                                                                    " obligatorio="false" admitebusqueda="410" etiqueta="Cliente                                                                                                                                                         " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="10" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCLI                               " atributo="F_VENDEDOR_DESDE                        " tabla="IMPDIRCLI      " campo="VENDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="412" etiqueta="Vendedor                                                                                                                                                        " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="13" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCLI                               " atributo="F_VENDEDOR_HASTA                        " tabla="IMPDIRCLI      " campo="VENHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="ZZZZZZZZZZ                                                                                                                                                                                                                                                    " obligatorio="false" admitebusqueda="414" etiqueta="Vendedor                                                                                                                                                        " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="13" orden="8" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCLI                               " atributo="F_LISTA_HASTA                           " tabla="IMPDIRCLI      " campo="LISHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="5" decimales="0" valorsugerido="ZZZZZ                                                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="416" etiqueta="Lista de precio                                                                                                                                                 " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="14" orden="9" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCLI                               " atributo="F_LISTA_DESDE                           " tabla="IMPDIRCLI      " campo="LISDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="418" etiqueta="Lista de precio                                                                                                                                                 " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="14" orden="10" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCLI                               " atributo="F_CLASIFICACION_DESDE                   " tabla="IMPDIRCLI      " campo="CLADESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="6" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="420" etiqueta="Clasificación                                                                                                                                                   " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="15" orden="15" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCLI                               " atributo="F_CLASIFICACION_HASTA                   " tabla="IMPDIRCLI      " campo="CLAHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="6" decimales="0" valorsugerido="ZZZZZZ                                                                                                                                                                                                                                                        " obligatorio="false" admitebusqueda="422" etiqueta="Clasificación                                                                                                                                                   " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="15" orden="16" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCLI                               " atributo="F_TIPO_DESDE                            " tabla="IMPDIRCLI      " campo="TIPDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="424" etiqueta="Tipo                                                                                                                                                            " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="16" orden="17" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCLI                               " atributo="F_TIPO_HASTA                            " tabla="IMPDIRCLI      " campo="TIPHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="ZZZZZZZZZZ                                                                                                                                                                                                                                                    " obligatorio="false" admitebusqueda="426" etiqueta="Tipo                                                                                                                                                            " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="16" orden="18" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCLI                               " atributo="F_CATEGORIA_DESDE                       " tabla="IMPDIRCLI      " campo="CATDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="428" etiqueta="Categoría                                                                                                                                                       " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="17" orden="19" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCLI                               " atributo="F_CATEGORIA_HASTA                       " tabla="IMPDIRCLI      " campo="CATHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="ZZZZZZZZZZ                                                                                                                                                                                                                                                    " obligatorio="false" admitebusqueda="430" etiqueta="Categoría                                                                                                                                                       " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="17" orden="20" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCLI                               " atributo="F_PROVINCIA_DESDE                       " tabla="IMPDIRCLI      " campo="PRODESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="432" etiqueta="Provincia                                                                                                                                                       " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="18" orden="21" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCLI                               " atributo="F_PROVINCIA_HASTA                       " tabla="IMPDIRCLI      " campo="PROHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="2" decimales="0" valorsugerido="ZZ                                                                                                                                                                                                                                                            " obligatorio="false" admitebusqueda="434" etiqueta="Provincia                                                                                                                                                       " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="18" orden="22" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCLI                               " atributo="F_PAIS_DESDE                            " tabla="IMPDIRCLI      " campo="PAIDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="3" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="436" etiqueta="País                                                                                                                                                            " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="19" orden="23" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCLI                               " atributo="F_PAIS_HASTA                            " tabla="IMPDIRCLI      " campo="PAIHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="3" decimales="0" valorsugerido="ZZZ                                                                                                                                                                                                                                                           " obligatorio="false" admitebusqueda="438" etiqueta="País                                                                                                                                                            " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="19" orden="24" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCLI                               " atributo="IMPUTACION                              " tabla="IMPDIRCLI      " campo="IMPVAL    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="IMPDIRVAL                               " tipodato="N         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="6" etiqueta="Imputación                                                                                                                                                      " dominio="CODIGONUMERICO                " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="35" orden="80" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCLI                               " atributo="OBSERVACION                             " tabla="IMPDIRCLI      " campo="OBS       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="440" etiqueta="Observaciones                                                                                                                                                   " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="50" orden="90" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PLANDECUENTAS                           " atributo="DESCRIPCION                             " tabla="PLANCUENTA     " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="407" etiqueta="Detalle Cue.                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join PLANCUENTA On IMPDIRCLI.PCUENTA = PLANCUENTA.ctacodigo And  PLANCUENTA.CTACODIGO != ''                                                                                                                                                             " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRVAL                               " atributo="DESCRIPCION                             " tabla="IMPDIRVAL      " campo="DESCRIPCIO" claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="7" etiqueta="Detalle Imp.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join IMPDIRVAL On IMPDIRCLI.IMPVAL = IMPDIRVAL.NUMERO And  IMPDIRVAL.NUMERO != 0                                                                                                                                                                        " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="12" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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