
define class Din_EntidadPUNTOSDEVENTAAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_PUNTOSDEVENTA'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = [Comprobante + Letra + str( PuntoDeVenta, 4, 0) + str( BocaDeExpendio, 4, 0)]
	cExpresionCCPorCampos = [#tabla#.COMP + #tabla#.LETRA + str( #tabla#.PTO, 4, 0) + str( #tabla#.BOCAEXP, 4, 0)]
	cTagClaveCandidata = '_PVTCC'
	cTagClavePk = '_PVTPK'
	cTablaPrincipal = 'PTOVTA'
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
			local  lxPtovtaFecexpo, lxPtovtaFectrans, lxPtovtaFmodifw, lxPtovtaFaltafw, lxPtovtaFecimpo, lxPtovtaNum, lxPtovtaSaltafw, lxPtovtaHmodifw, lxPtovtaSmodifw, lxPtovtaHoraimpo, lxPtovtaUaltafw, lxPtovtaVmodifw, lxPtovtaZadsfw, lxPtovtaValtafw, lxPtovtaHoraexpo, lxPtovtaUmodifw, lxPtovtaBdmodifw, lxPtovtaHaltafw, lxPtovtaBdaltafw, lxPtovtaEsttrans, lxPtovtaComp, lxPtovtaDescri, lxPtovtaLetra, lxPtovtaCobs, lxPtovtaPto, lxPtovtaPvsug, lxPtovtaBocaexp
				lxPtovtaFecexpo =  .Fechaexpo			lxPtovtaFectrans =  .Fechatransferencia			lxPtovtaFmodifw =  .Fechamodificacionfw			lxPtovtaFaltafw =  .Fechaaltafw			lxPtovtaFecimpo =  .Fechaimpo			lxPtovtaNum =  .Numero			lxPtovtaSaltafw =  .Seriealtafw			lxPtovtaHmodifw =  .Horamodificacionfw			lxPtovtaSmodifw =  .Seriemodificacionfw			lxPtovtaHoraimpo =  .Horaimpo			lxPtovtaUaltafw =  .Usuarioaltafw			lxPtovtaVmodifw =  .Versionmodificacionfw			lxPtovtaZadsfw =  .Zadsfw			lxPtovtaValtafw =  .Versionaltafw			lxPtovtaHoraexpo =  .Horaexpo			lxPtovtaUmodifw =  .Usuariomodificacionfw			lxPtovtaBdmodifw =  .Basededatosmodificacionfw			lxPtovtaHaltafw =  .Horaaltafw			lxPtovtaBdaltafw =  .Basededatosaltafw			lxPtovtaEsttrans =  .Estadotransferencia			lxPtovtaComp =  .Comprobante			lxPtovtaDescri =  .Descripcion			lxPtovtaLetra =  .Letra			lxPtovtaCobs =  .Observacion			lxPtovtaPto =  .Puntodeventa			lxPtovtaPvsug =  .Puntodeventasugerido			lxPtovtaBocaexp =  .Bocadeexpendio
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxPtovtaNum = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.PTOVTA ( "Fecexpo","Fectrans","Fmodifw","Faltafw","Fecimpo","Num","Saltafw","Hmodifw","Smodifw","Horaimpo","Ualtafw","Vmodifw","Zadsfw","Valtafw","Horaexpo","Umodifw","Bdmodifw","Haltafw","Bdaltafw","Esttrans","Comp","Descri","Letra","Cobs","Pto","Pvsug","Bocaexp" ) values ( <<"'" + this.ConvertirDateSql( lxPtovtaFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxPtovtaFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxPtovtaFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxPtovtaFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxPtovtaFecimpo ) + "'" >>, <<lxPtovtaNum >>, <<"'" + this.FormatearTextoSql( lxPtovtaSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPtovtaHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPtovtaSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPtovtaHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPtovtaUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPtovtaVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPtovtaZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPtovtaValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPtovtaHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPtovtaUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPtovtaBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPtovtaHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPtovtaBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPtovtaEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPtovtaComp ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPtovtaDescri ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPtovtaLetra ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPtovtaCobs ) + "'" >>, <<lxPtovtaPto >>, <<iif( lxPtovtaPvsug, 1, 0 ) >>, <<lxPtovtaBocaexp >> )
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
		return this.oEntidad.NUMERO
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function Actualizar() as boolean
	local loError as Exception, loEx as Exception, lxValorClavePrimaria as variant, lnI as Integer, loSentenciasTriggers as zoocoleccion OF zoocoleccion.prg, lcSentencia as string

		with this.oEntidad
			local  lxPtovtaFecexpo, lxPtovtaFectrans, lxPtovtaFmodifw, lxPtovtaFaltafw, lxPtovtaFecimpo, lxPtovtaNum, lxPtovtaSaltafw, lxPtovtaHmodifw, lxPtovtaSmodifw, lxPtovtaHoraimpo, lxPtovtaUaltafw, lxPtovtaVmodifw, lxPtovtaZadsfw, lxPtovtaValtafw, lxPtovtaHoraexpo, lxPtovtaUmodifw, lxPtovtaBdmodifw, lxPtovtaHaltafw, lxPtovtaBdaltafw, lxPtovtaEsttrans, lxPtovtaComp, lxPtovtaDescri, lxPtovtaLetra, lxPtovtaCobs, lxPtovtaPto, lxPtovtaPvsug, lxPtovtaBocaexp
				lxPtovtaFecexpo =  .Fechaexpo			lxPtovtaFectrans =  .Fechatransferencia			lxPtovtaFmodifw =  .Fechamodificacionfw			lxPtovtaFaltafw =  .Fechaaltafw			lxPtovtaFecimpo =  .Fechaimpo			lxPtovtaNum =  .Numero			lxPtovtaSaltafw =  .Seriealtafw			lxPtovtaHmodifw =  .Horamodificacionfw			lxPtovtaSmodifw =  .Seriemodificacionfw			lxPtovtaHoraimpo =  .Horaimpo			lxPtovtaUaltafw =  .Usuarioaltafw			lxPtovtaVmodifw =  .Versionmodificacionfw			lxPtovtaZadsfw =  .Zadsfw			lxPtovtaValtafw =  .Versionaltafw			lxPtovtaHoraexpo =  .Horaexpo			lxPtovtaUmodifw =  .Usuariomodificacionfw			lxPtovtaBdmodifw =  .Basededatosmodificacionfw			lxPtovtaHaltafw =  .Horaaltafw			lxPtovtaBdaltafw =  .Basededatosaltafw			lxPtovtaEsttrans =  .Estadotransferencia			lxPtovtaComp =  .Comprobante			lxPtovtaDescri =  .Descripcion			lxPtovtaLetra =  .Letra			lxPtovtaCobs =  .Observacion			lxPtovtaPto =  .Puntodeventa			lxPtovtaPvsug =  .Puntodeventasugerido			lxPtovtaBocaexp =  .Bocadeexpendio
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()
			lxValorClavePrimaria = .oEntidad.NUMERO
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ZooLogic.PTOVTA set "Fecexpo" = <<"'" + this.ConvertirDateSql( lxPtovtaFecexpo ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxPtovtaFectrans ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxPtovtaFmodifw ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxPtovtaFaltafw ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxPtovtaFecimpo ) + "'">>,"Num" = <<lxPtovtaNum>>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxPtovtaSaltafw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxPtovtaHmodifw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxPtovtaSmodifw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxPtovtaHoraimpo ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxPtovtaUaltafw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxPtovtaVmodifw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxPtovtaZadsfw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxPtovtaValtafw ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxPtovtaHoraexpo ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxPtovtaUmodifw ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxPtovtaBdmodifw ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxPtovtaHaltafw ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxPtovtaBdaltafw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxPtovtaEsttrans ) + "'">>,"Comp" = <<"'" + this.FormatearTextoSql( lxPtovtaComp ) + "'">>,"Descri" = <<"'" + this.FormatearTextoSql( lxPtovtaDescri ) + "'">>,"Letra" = <<"'" + this.FormatearTextoSql( lxPtovtaLetra ) + "'">>,"Cobs" = <<"'" + this.FormatearTextoSql( lxPtovtaCobs ) + "'">>,"Pto" = <<lxPtovtaPto>>,"Pvsug" = <<iif( lxPtovtaPvsug, 1, 0 )>>,"Bocaexp" = <<lxPtovtaBocaexp>> where "Num" = <<lxPtovtaNum>> and  PTOVTA.NUM != 0 << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 NUM from ZooLogic.PTOVTA where " + this.ConvertirFuncionesSql( " PTOVTA.NUM != 0" ) )
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
			Local lxPtovtaNum
			lxPtovtaNum = .Numero

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Num" as "Numero", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Ualtafw" as "Usuarioaltafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Horaexpo" as "Horaexpo", "Umodifw" as "Usuariomodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Comp" as "Comprobante", "Descri" as "Descripcion", "Letra" as "Letra", "Cobs" as "Observacion", "Pto" as "Puntodeventa", "Pvsug" as "Puntodeventasugerido", "Bocaexp" as "Bocadeexpendio" from ZooLogic.PTOVTA where "Num" = <<lxPtovtaNum>> and  PTOVTA.NUM != 0
			endtext
			use in select('c_PUNTOSDEVENTA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_PUNTOSDEVENTA', set( 'Datasession' ) )

			if reccount( 'c_PUNTOSDEVENTA' ) = 0
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
			Local lxPTOVTACOMP As Variant, lxPTOVTALETRA As Variant, lxPTOVTAPTO As Variant, lxPTOVTABOCAEXP As Variant
			lxPTOVTACOMP = .Comprobante
			lxPTOVTALETRA = .Letra
			lxPTOVTAPTO = .PuntoDeVenta
			lxPTOVTABOCAEXP = .BocaDeExpendio
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Num" as "Numero", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Ualtafw" as "Usuarioaltafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Horaexpo" as "Horaexpo", "Umodifw" as "Usuariomodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Comp" as "Comprobante", "Descri" as "Descripcion", "Letra" as "Letra", "Cobs" as "Observacion", "Pto" as "Puntodeventa", "Pvsug" as "Puntodeventasugerido", "Bocaexp" as "Bocadeexpendio" from ZooLogic.PTOVTA where  PTOVTA.NUM != 0 And COMP = <<"'" + this.FormatearTextoSql( lxPTOVTACOMP ) + "'">> and LETRA = <<"'" + this.FormatearTextoSql( lxPTOVTALETRA ) + "'">> and PTO = <<lxPTOVTAPTO>> and BOCAEXP = <<lxPTOVTABOCAEXP>>
			endtext
			use in select('c_PUNTOSDEVENTA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_PUNTOSDEVENTA', set( 'Datasession' ) )
			if reccount( 'c_PUNTOSDEVENTA' ) = 0
				llRetorno = .f.
			else
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxPtovtaNum as Variant
		llRetorno = .t.
		lxPtovtaNum = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.PTOVTA where "Num" = <<lxPtovtaNum>> and  PTOVTA.NUM != 0
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
				lcOrden =  str( .Numero, 10, 0) + str( .BocaDeExpendio, 4, 0)
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Num" as "Numero", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Ualtafw" as "Usuarioaltafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Horaexpo" as "Horaexpo", "Umodifw" as "Usuariomodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Comp" as "Comprobante", "Descri" as "Descripcion", "Letra" as "Letra", "Cobs" as "Observacion", "Pto" as "Puntodeventa", "Pvsug" as "Puntodeventasugerido", "Bocaexp" as "Bocadeexpendio" from ZooLogic.PTOVTA where  PTOVTA.NUM != 0 order by NUM,BOCAEXP
			endtext
			use in select('c_PUNTOSDEVENTA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_PUNTOSDEVENTA', set( 'Datasession' ) )
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
				lcOrden =  str( .Numero, 10, 0) + str( .BocaDeExpendio, 4, 0)
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Num" as "Numero", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Ualtafw" as "Usuarioaltafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Horaexpo" as "Horaexpo", "Umodifw" as "Usuariomodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Comp" as "Comprobante", "Descri" as "Descripcion", "Letra" as "Letra", "Cobs" as "Observacion", "Pto" as "Puntodeventa", "Pvsug" as "Puntodeventasugerido", "Bocaexp" as "Bocadeexpendio" from ZooLogic.PTOVTA where  str( NUM, 10, 0) + str( BOCAEXP, 4, 0) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  PTOVTA.NUM != 0 order by NUM,BOCAEXP
			endtext
			use in select('c_PUNTOSDEVENTA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_PUNTOSDEVENTA', set( 'Datasession' ) )
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
				lcOrden =  str( .Numero, 10, 0) + str( .BocaDeExpendio, 4, 0)
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Num" as "Numero", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Ualtafw" as "Usuarioaltafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Horaexpo" as "Horaexpo", "Umodifw" as "Usuariomodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Comp" as "Comprobante", "Descri" as "Descripcion", "Letra" as "Letra", "Cobs" as "Observacion", "Pto" as "Puntodeventa", "Pvsug" as "Puntodeventasugerido", "Bocaexp" as "Bocadeexpendio" from ZooLogic.PTOVTA where  str( NUM, 10, 0) + str( BOCAEXP, 4, 0) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  PTOVTA.NUM != 0 order by NUM desc,BOCAEXP desc
			endtext
			use in select('c_PUNTOSDEVENTA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_PUNTOSDEVENTA', set( 'Datasession' ) )
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
				lcOrden =  str( .Numero, 10, 0) + str( .BocaDeExpendio, 4, 0)
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Num" as "Numero", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Ualtafw" as "Usuarioaltafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Horaexpo" as "Horaexpo", "Umodifw" as "Usuariomodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Comp" as "Comprobante", "Descri" as "Descripcion", "Letra" as "Letra", "Cobs" as "Observacion", "Pto" as "Puntodeventa", "Pvsug" as "Puntodeventasugerido", "Bocaexp" as "Bocadeexpendio" from ZooLogic.PTOVTA where  PTOVTA.NUM != 0 order by NUM desc,BOCAEXP desc
			endtext
			use in select('c_PUNTOSDEVENTA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_PUNTOSDEVENTA', set( 'Datasession' ) )
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
			lcXml = this.oConexion.EjecutarSql( "select Fecexpo,Fectrans,Fmodifw,Faltafw,Fecimpo,Num,Saltafw,Hmodifw,Smodifw,Horaimpo,Ualtafw,Vmodif" + ;
"w,Zadsfw,Valtafw,Horaexpo,Umodifw,Bdmodifw,Haltafw,Bdaltafw,Esttrans,Comp,Descri,Letra,Cobs,Pto,Pvsu" + ;
"g,Bocaexp" + ;
" from ZooLogic.PTOVTA where  PTOVTA.NUM != 0 and " + lcFiltro )
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
			local  lxPtovtaFecexpo, lxPtovtaFectrans, lxPtovtaFmodifw, lxPtovtaFaltafw, lxPtovtaFecimpo, lxPtovtaNum, lxPtovtaSaltafw, lxPtovtaHmodifw, lxPtovtaSmodifw, lxPtovtaHoraimpo, lxPtovtaUaltafw, lxPtovtaVmodifw, lxPtovtaZadsfw, lxPtovtaValtafw, lxPtovtaHoraexpo, lxPtovtaUmodifw, lxPtovtaBdmodifw, lxPtovtaHaltafw, lxPtovtaBdaltafw, lxPtovtaEsttrans, lxPtovtaComp, lxPtovtaDescri, lxPtovtaLetra, lxPtovtaCobs, lxPtovtaPto, lxPtovtaPvsug, lxPtovtaBocaexp
				lxPtovtaFecexpo = ctod( '  /  /    ' )			lxPtovtaFectrans = ctod( '  /  /    ' )			lxPtovtaFmodifw = ctod( '  /  /    ' )			lxPtovtaFaltafw = ctod( '  /  /    ' )			lxPtovtaFecimpo = ctod( '  /  /    ' )			lxPtovtaNum = 0			lxPtovtaSaltafw = []			lxPtovtaHmodifw = []			lxPtovtaSmodifw = []			lxPtovtaHoraimpo = []			lxPtovtaUaltafw = []			lxPtovtaVmodifw = []			lxPtovtaZadsfw = []			lxPtovtaValtafw = []			lxPtovtaHoraexpo = []			lxPtovtaUmodifw = []			lxPtovtaBdmodifw = []			lxPtovtaHaltafw = []			lxPtovtaBdaltafw = []			lxPtovtaEsttrans = []			lxPtovtaComp = []			lxPtovtaDescri = []			lxPtovtaLetra = []			lxPtovtaCobs = []			lxPtovtaPto = 0			lxPtovtaPvsug = .F.			lxPtovtaBocaexp = 0
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( [delete from ZooLogic.PTOVTA where "NUM" = ] + transform( .oEntidad.NUMERO )+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'PTOVTA' + '_' + tcCampo
			lcMemoAscii = ''

			lnIndice = alen(.aSqlMemos)
			lnIndice = iif(lnIndice = 1, 1, lnIndice + 1 )
			dimension .aSqlMemos(lnIndice)

			.aSqlMemos(lnIndice) = 'delete from ' + lcTabla + ' where NUM = ' + txValorClavePrimaria
			.GenerarSentenciasInsertTablaMemo( lcValor, lcTabla, txValorClavePrimaria )
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerSentenciaInsertMemo( tcTabla as String, txValorClavePrimaria as String, tcOrden as String, tcTexto as String ) as String
		return "Insert  into " + tcTabla + "(NUM, Orden, texto ) values ( " + txValorClavePrimaria + "," + tcOrden + ",'"+ tcTexto + "')"
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosEntidad( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  PTOVTA.NUM != 0"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Num" as "Numero", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Ualtafw" as "Usuarioaltafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Horaexpo" as "Horaexpo", "Umodifw" as "Usuariomodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Comp" as "Comprobante", "Descri" as "Descripcion", "Letra" as "Letra", "Cobs" as "Observacion", "Pto" as "Puntodeventa", "Pvsug" as "Puntodeventasugerido", "Bocaexp" as "Bocadeexpendio"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'PTOVTA', '', tnTope )
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
				Case lcAtributo == 'FECHATRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRANS AS FECHATRANSFERENCIA'
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'FECHAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECIMPO AS FECHAIMPO'
				Case lcAtributo == 'NUMERO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NUM AS NUMERO'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'COMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COMP AS COMPROBANTE'
				Case lcAtributo == 'DESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCRI AS DESCRIPCION'
				Case lcAtributo == 'LETRA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LETRA AS LETRA'
				Case lcAtributo == 'OBSERVACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COBS AS OBSERVACION'
				Case lcAtributo == 'PUNTODEVENTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PTO AS PUNTODEVENTA'
				Case lcAtributo == 'PUNTODEVENTASUGERIDO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PVSUG AS PUNTODEVENTASUGERIDO'
				Case lcAtributo == 'BOCADEEXPENDIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BOCAEXP AS BOCADEEXPENDIO'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAIMPO'
				lcCampo = 'FECIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'NUMERO'
				lcCampo = 'NUM'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'COMPROBANTE'
				lcCampo = 'COMP'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCION'
				lcCampo = 'DESCRI'
			Case upper( alltrim( tcAtributo ) ) == 'LETRA'
				lcCampo = 'LETRA'
			Case upper( alltrim( tcAtributo ) ) == 'OBSERVACION'
				lcCampo = 'COBS'
			Case upper( alltrim( tcAtributo ) ) == 'PUNTODEVENTA'
				lcCampo = 'PTO'
			Case upper( alltrim( tcAtributo ) ) == 'PUNTODEVENTASUGERIDO'
				lcCampo = 'PVSUG'
			Case upper( alltrim( tcAtributo ) ) == 'BOCADEEXPENDIO'
				lcCampo = 'BOCAEXP'
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
			local  lxPtovtaFecexpo, lxPtovtaFectrans, lxPtovtaFmodifw, lxPtovtaFaltafw, lxPtovtaFecimpo, lxPtovtaNum, lxPtovtaSaltafw, lxPtovtaHmodifw, lxPtovtaSmodifw, lxPtovtaHoraimpo, lxPtovtaUaltafw, lxPtovtaVmodifw, lxPtovtaZadsfw, lxPtovtaValtafw, lxPtovtaHoraexpo, lxPtovtaUmodifw, lxPtovtaBdmodifw, lxPtovtaHaltafw, lxPtovtaBdaltafw, lxPtovtaEsttrans, lxPtovtaComp, lxPtovtaDescri, lxPtovtaLetra, lxPtovtaCobs, lxPtovtaPto, lxPtovtaPvsug, lxPtovtaBocaexp
				lxPtovtaFecexpo =  .Fechaexpo			lxPtovtaFectrans =  .Fechatransferencia			lxPtovtaFmodifw =  .Fechamodificacionfw			lxPtovtaFaltafw =  .Fechaaltafw			lxPtovtaFecimpo =  .Fechaimpo			lxPtovtaNum =  .Numero			lxPtovtaSaltafw =  .Seriealtafw			lxPtovtaHmodifw =  .Horamodificacionfw			lxPtovtaSmodifw =  .Seriemodificacionfw			lxPtovtaHoraimpo =  .Horaimpo			lxPtovtaUaltafw =  .Usuarioaltafw			lxPtovtaVmodifw =  .Versionmodificacionfw			lxPtovtaZadsfw =  .Zadsfw			lxPtovtaValtafw =  .Versionaltafw			lxPtovtaHoraexpo =  .Horaexpo			lxPtovtaUmodifw =  .Usuariomodificacionfw			lxPtovtaBdmodifw =  .Basededatosmodificacionfw			lxPtovtaHaltafw =  .Horaaltafw			lxPtovtaBdaltafw =  .Basededatosaltafw			lxPtovtaEsttrans =  .Estadotransferencia			lxPtovtaComp =  .Comprobante			lxPtovtaDescri =  .Descripcion			lxPtovtaLetra =  .Letra			lxPtovtaCobs =  .Observacion			lxPtovtaPto =  .Puntodeventa			lxPtovtaPvsug =  .Puntodeventasugerido			lxPtovtaBocaexp =  .Bocadeexpendio
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.PTOVTA ( "Fecexpo","Fectrans","Fmodifw","Faltafw","Fecimpo","Num","Saltafw","Hmodifw","Smodifw","Horaimpo","Ualtafw","Vmodifw","Zadsfw","Valtafw","Horaexpo","Umodifw","Bdmodifw","Haltafw","Bdaltafw","Esttrans","Comp","Descri","Letra","Cobs","Pto","Pvsug","Bocaexp" ) values ( <<"'" + this.ConvertirDateSql( lxPtovtaFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxPtovtaFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxPtovtaFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxPtovtaFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxPtovtaFecimpo ) + "'" >>, <<lxPtovtaNum >>, <<"'" + this.FormatearTextoSql( lxPtovtaSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPtovtaHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPtovtaSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPtovtaHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPtovtaUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPtovtaVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPtovtaZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPtovtaValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPtovtaHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPtovtaUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPtovtaBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPtovtaHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPtovtaBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPtovtaEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPtovtaComp ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPtovtaDescri ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPtovtaLetra ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPtovtaCobs ) + "'" >>, <<lxPtovtaPto >>, <<iif( lxPtovtaPvsug, 1, 0 ) >>, <<lxPtovtaBocaexp >> )
		endtext
		loColeccion.cTabla = 'PTOVTA' 
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
			local  lxPtovtaFecexpo, lxPtovtaFectrans, lxPtovtaFmodifw, lxPtovtaFaltafw, lxPtovtaFecimpo, lxPtovtaNum, lxPtovtaSaltafw, lxPtovtaHmodifw, lxPtovtaSmodifw, lxPtovtaHoraimpo, lxPtovtaUaltafw, lxPtovtaVmodifw, lxPtovtaZadsfw, lxPtovtaValtafw, lxPtovtaHoraexpo, lxPtovtaUmodifw, lxPtovtaBdmodifw, lxPtovtaHaltafw, lxPtovtaBdaltafw, lxPtovtaEsttrans, lxPtovtaComp, lxPtovtaDescri, lxPtovtaLetra, lxPtovtaCobs, lxPtovtaPto, lxPtovtaPvsug, lxPtovtaBocaexp
				lxPtovtaFecexpo =  .Fechaexpo			lxPtovtaFectrans =  .Fechatransferencia			lxPtovtaFmodifw =  .Fechamodificacionfw			lxPtovtaFaltafw =  .Fechaaltafw			lxPtovtaFecimpo =  .Fechaimpo			lxPtovtaNum =  .Numero			lxPtovtaSaltafw =  .Seriealtafw			lxPtovtaHmodifw =  .Horamodificacionfw			lxPtovtaSmodifw =  .Seriemodificacionfw			lxPtovtaHoraimpo =  .Horaimpo			lxPtovtaUaltafw =  .Usuarioaltafw			lxPtovtaVmodifw =  .Versionmodificacionfw			lxPtovtaZadsfw =  .Zadsfw			lxPtovtaValtafw =  .Versionaltafw			lxPtovtaHoraexpo =  .Horaexpo			lxPtovtaUmodifw =  .Usuariomodificacionfw			lxPtovtaBdmodifw =  .Basededatosmodificacionfw			lxPtovtaHaltafw =  .Horaaltafw			lxPtovtaBdaltafw =  .Basededatosaltafw			lxPtovtaEsttrans =  .Estadotransferencia			lxPtovtaComp =  .Comprobante			lxPtovtaDescri =  .Descripcion			lxPtovtaLetra =  .Letra			lxPtovtaCobs =  .Observacion			lxPtovtaPto =  .Puntodeventa			lxPtovtaPvsug =  .Puntodeventasugerido			lxPtovtaBocaexp =  .Bocadeexpendio
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.NUMERO
			lcValorClavePrimariaString = transform( this.oEntidad.NUMERO )

			lcFiltro = ["Num" = ] + lcValorClavePrimariaString  + [ and  PTOVTA.NUM != 0]
			text to lcSentencia noshow textmerge
				update ZooLogic.PTOVTA set "Fecexpo" = <<"'" + this.ConvertirDateSql( lxPtovtaFecexpo ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxPtovtaFectrans ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxPtovtaFmodifw ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxPtovtaFaltafw ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxPtovtaFecimpo ) + "'">>, "Num" = <<lxPtovtaNum>>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxPtovtaSaltafw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxPtovtaHmodifw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxPtovtaSmodifw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxPtovtaHoraimpo ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxPtovtaUaltafw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxPtovtaVmodifw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxPtovtaZadsfw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxPtovtaValtafw ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxPtovtaHoraexpo ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxPtovtaUmodifw ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxPtovtaBdmodifw ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxPtovtaHaltafw ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxPtovtaBdaltafw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxPtovtaEsttrans ) + "'">>, "Comp" = <<"'" + this.FormatearTextoSql( lxPtovtaComp ) + "'">>, "Descri" = <<"'" + this.FormatearTextoSql( lxPtovtaDescri ) + "'">>, "Letra" = <<"'" + this.FormatearTextoSql( lxPtovtaLetra ) + "'">>, "Cobs" = <<"'" + this.FormatearTextoSql( lxPtovtaCobs ) + "'">>, "Pto" = <<lxPtovtaPto>>, "Pvsug" = <<iif( lxPtovtaPvsug, 1, 0 )>>, "Bocaexp" = <<lxPtovtaBocaexp>> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'PTOVTA' 
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

			lcFiltro = ["Num" = ] + lcValorClavePrimariaString  + [ and  PTOVTA.NUM != 0]
		loColeccion.Agregar( 'delete from ZooLogic.PTOVTA where ' + lcFiltro )
			loColeccion.cTabla = 'PTOVTA' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.PTOVTA where  PTOVTA.NUM != 0" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.PTOVTA where NUM = " + transform( this.oEntidad.NUMERO )+ " and  PTOVTA.NUM != 0" )
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
		local lcCursor as String, ldFecha as Date, lcHora as string, lcValorABuscar As String, lxValorClavePK As variant, lxValorClavePrimaria As variant, lcIdentificadorParaLoguear as string, lxPTOVTACOMP as variant, lxPTOVTALETRA as variant, lxPTOVTAPTO as variant, lxPTOVTABOCAEXP as variant, lcMensajeExtra as String
		lcValorABuscar = ''
		lxValorClavePK = ''
		lcMensajeExtra = ''
		lcCursor = This.oEntidad.cPrefijoRecibir + 'PUNTOSDEVENTA'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.PTOVTA Where  COMP = ] + "'" + this.FormatearTextoSql( &lcCursor..COMP       ) + "'" + [ and LETRA = ] + "'" + this.FormatearTextoSql( &lcCursor..LETRA      ) + "'" + [ and PTO = ] + transform( &lcCursor..PTO        ) + [ and BOCAEXP = ] + transform( &lcCursor..BOCAEXP    ), 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				lxValorClavePK = &lcCursor..NUM
				if lxValorClavePK == curSeek.NUM or this.oEntidad.lIgnorarClaveprimariaEnRecepcionBD 
					if lxValorClavePK != curSeek.NUM and this.oEntidad.lIgnorarClaveprimariaEnRecepcionBD 
						lcValorABuscar = curSeek.NUM
					else 
						lcValorABuscar = lxValorClavePK 
					endif 
					if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
						Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
						this.oConexion.EjecutarSql( [UPDATE ZooLogic.PTOVTA set  FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, NUM = ] + transform( &lcCursor..NUM )+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, COMP = ] + "'" + this.FormatearTextoSql( &lcCursor..COMP ) + "'"+ [, DESCRI = ] + "'" + this.FormatearTextoSql( &lcCursor..DESCRI ) + "'"+ [, LETRA = ] + "'" + this.FormatearTextoSql( &lcCursor..LETRA ) + "'"+ [, COBS = ] + "'" + this.FormatearTextoSql( &lcCursor..COBS ) + "'"+ [, PTO = ] + transform( &lcCursor..PTO )+ [, PVSUG = ] + Transform( iif( &lcCursor..PVSUG, 1, 0 ))+ [, BOCAEXP = ] + transform( &lcCursor..BOCAEXP ) + [ Where NUM = ] + transform( lcValorABuscar ) )
						this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
					else
						this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
					endIf
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir porque no coincide la clave principal.', tlLoguear )
				endIf
			else
				this.oConexion.EjecutarSql( [Select * From ZooLogic.PTOVTA Where NUM = ] + transform( &lcCursor..NUM ), 'curSeek', this.datasessionid )
				if reccount( 'curSeek' ) > 0
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir como alta porque la clave principal ya existe', tlLoguear )
				Else
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					Text to lcCampos noShow
						 FECEXPO, FECTRANS, FMODIFW, FALTAFW, FECIMPO, NUM, SALTAFW, HMODIFW, SMODIFW, HORAIMPO, UALTAFW, VMODIFW, ZADSFW, VALTAFW, HORAEXPO, UMODIFW, BDMODIFW, HALTAFW, BDALTAFW, ESTTRANS, COMP, DESCRI, LETRA, COBS, PTO, PVSUG, BOCAEXP
					EndText
					local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + transform( &lcCursor..NUM ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..COMP ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..DESCRI ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..LETRA ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..COBS ) + "'" + ',' + transform( &lcCursor..PTO ) + ',' + Transform( iif( &lcCursor..PVSUG, 1, 0 )) + ',' + transform( &lcCursor..BOCAEXP )
lcValoresCampos = substr(lcValoresCampos,2) 

					this.oConexion.EjecutarSql( [Insert into ZooLogic.PTOVTA ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
				EndIf
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'PUNTOSDEVENTA'
		if This.ActualizaEnRecepcion()
	endif
	Use in select( 'cExistentes' )
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearCursorMemo( tcCursorACrear as String, tcTablaConMemo as String ) as Void
		create cursor &tcCursorACrear ( NUM N (10) , Orden N(16), texto C(80))
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirComponentes() As Void
		
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function ObtenerIdentificadorParaLoguear( tcCursor as String ) As String
		local lcRetorno as String, lnCC as String , loCC as Object, lni as Integer, lcSecuencia as String
		lcRetorno = this.oEntidad.cDescripcion 
		lcRetorno = lcRetorno + ' - Comprobante: ' + transform( &tcCursor..COMP       )
		lcRetorno = lcRetorno + ' - Letra: ' + transform( &tcCursor..LETRA      )
		lcRetorno = lcRetorno + ' - Punto de venta: ' + transform( &tcCursor..PTO        )
		lcRetorno = lcRetorno + ' - Boca de expendio: ' + transform( &tcCursor..BOCAEXP    )
		Return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EsAliasDeProceso( tcAlias As String, tcPrefijo as string ) As Boolean
		local llRetorno as Boolean, lcAlias as String, lcPrefijo As String
		llRetorno = .F.
		lcAlias = upper( alltrim( tcAlias ) )
		lcPrefijo = upper( alltrim( tcPrefijo ) )
		Do Case
			Case  lcAlias == lcPrefijo + 'PUNTOSDEVENTA'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'PUNTOSDEVENTA_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'PUNTOSDEVENTA_COBS'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_PTOVTA')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'PUNTOSDEVENTA'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..NUM
		llCondicion = isnull( lxVar ) or isnull( &lcCursor..COMP ) or isnull( &lcCursor..LETRA ) or isnull( &lcCursor..PTO ) or isnull( &lcCursor..BOCAEXP )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad PUNTOSDEVENTA. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'PUNTOSDEVENTA'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		select recno() as _Rec, * from &lcCursor into cursor CurConRecno
		select max( _Rec ) as Maximo,NUM as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( NUM, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		select max( _Rec ) as Maximo,COMP + LETRA + str( PTO, 4, 0) + str( BOCAEXP, 4, 0) as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( COMP + LETRA + str( PTO, 4, 0) + str( BOCAEXP, 4, 0), 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		Use in select( 'CurConRecno' )
		Use in select( 'RepMax' )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDatosInvalidos( toConexion as Object ) as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'PUNTOSDEVENTA'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_PTOVTA') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_PTOVTA
Create Table ZooLogic.TablaTrabajo_PTOVTA ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fecexpo" datetime  null, 
"fectrans" datetime  null, 
"fmodifw" datetime  null, 
"faltafw" datetime  null, 
"fecimpo" datetime  null, 
"num" numeric( 10, 0 )  null, 
"saltafw" char( 7 )  null, 
"hmodifw" char( 8 )  null, 
"smodifw" char( 7 )  null, 
"horaimpo" char( 8 )  null, 
"ualtafw" char( 100 )  null, 
"vmodifw" char( 13 )  null, 
"zadsfw" varchar(max)  null, 
"valtafw" char( 13 )  null, 
"horaexpo" char( 8 )  null, 
"umodifw" char( 100 )  null, 
"bdmodifw" char( 8 )  null, 
"haltafw" char( 8 )  null, 
"bdaltafw" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"comp" char( 40 )  null, 
"descri" char( 50 )  null, 
"letra" char( 1 )  null, 
"cobs" varchar(max)  null, 
"pto" numeric( 4, 0 )  null, 
"pvsug" bit  null, 
"bocaexp" numeric( 4, 0 )  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_PTOVTA' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_PTOVTA' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'PUNTOSDEVENTA'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		with loManejador
			if this.oEntidad.VerificarContexto( 'CB' )
			else
				.AgregarMapeo('Nrolinea','Nrolinea')
			endif
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('num','num')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('comp','comp')
			.AgregarMapeo('descri','descri')
			.AgregarMapeo('letra','letra')
			.AgregarMapeo('cobs','cobs')
			.AgregarMapeo('pto','pto')
			.AgregarMapeo('pvsug','pvsug')
			.AgregarMapeo('bocaexp','bocaexp')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_PTOVTA'
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
				Update t Set t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.NUM = isnull( d.NUM, t.NUM ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.COMP = isnull( d.COMP, t.COMP ),t.DESCRI = isnull( d.DESCRI, t.DESCRI ),t.LETRA = isnull( d.LETRA, t.LETRA ),t.COBS = isnull( d.COBS, t.COBS ),t.PTO = isnull( d.PTO, t.PTO ),t.PVSUG = isnull( d.PVSUG, t.PVSUG ),t.BOCAEXP = isnull( d.BOCAEXP, t.BOCAEXP )
					from ZooLogic.PTOVTA t inner join deleted d 
							 on t.NUM = d.NUM
							 and  t.COMP = d.COMP
							 and  t.LETRA = d.LETRA
							 and  t.PTO = d.PTO
							 and  t.BOCAEXP = d.BOCAEXP
				-- Fin Updates
				insert into ZooLogic.PTOVTA(Fecexpo,Fectrans,Fmodifw,Faltafw,Fecimpo,Num,Saltafw,Hmodifw,Smodifw,Horaimpo,Ualtafw,Vmodifw,Zadsfw,Valtafw,Horaexpo,Umodifw,Bdmodifw,Haltafw,Bdaltafw,Esttrans,Comp,Descri,Letra,Cobs,Pto,Pvsug,Bocaexp)
					Select isnull( d.FECEXPO,''),isnull( d.FECTRANS,''),isnull( d.FMODIFW,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FECIMPO,''),isnull( d.NUM,0),isnull( d.SALTAFW,''),isnull( d.HMODIFW,''),isnull( d.SMODIFW,''),isnull( d.HORAIMPO,''),isnull( d.UALTAFW,''),isnull( d.VMODIFW,''),isnull( d.ZADSFW,''),isnull( d.VALTAFW,''),isnull( d.HORAEXPO,''),isnull( d.UMODIFW,''),isnull( d.BDMODIFW,''),convert( char(8), getdate(), 108 ),isnull( d.BDALTAFW,''),isnull( d.ESTTRANS,''),isnull( d.COMP,''),isnull( d.DESCRI,''),isnull( d.LETRA,''),isnull( d.COBS,''),isnull( d.PTO,0),isnull( d.PVSUG,0),isnull( d.BOCAEXP,0)
						From deleted d left join ZooLogic.PTOVTA pk 
							 on d.NUM = pk.NUM
						 left join ZooLogic.PTOVTA cc 
							 on  d.COMP = cc.COMP
							 and  d.LETRA = cc.LETRA
							 and  d.PTO = cc.PTO
							 and  d.BOCAEXP = cc.BOCAEXP
						Where pk.NUM Is Null 
							 and cc.COMP Is Null 
							 and cc.LETRA Is Null 
							 and cc.PTO Is Null 
							 and cc.BOCAEXP Is Null 
				-- Fin Inserts
				Insert into ZooLogic.Logueos ( Fecha, Nivel, Logger, Accion, BaseDeDatos, 
					EstadoDelSistema, Aplicacion, Version, 
					Serie, Usuario, NombrePc, 
					UsuarioPc, OrigenLogueo, Mensaje, Excepcion)
				select GetDate(), 'INFO', '', 'Importación <<lcEntidad>>','<<loLogueo.BaseDatos>>',
					<<loLogueo.EstadoSistema>>,'<<loLogueo.Aplicacion>>','<<loLogueo.Version>>',
					'<<loLogueo.Serie>>','<<loLogueo.Usuario>>','<<loLogueo.NombrePc>>',
					'<<loLogueo.UsuarioPc>>','<<loLogueo.OrigenLogueo>>','No se pudo importar la entidad <<lcEntidad>>: COMPROBANTE ' + cast( d.COMP as Varchar(40) ) + ', LETRA ' + cast( d.LETRA as Varchar(1) ) + ', PUNTO DE VENTA ' + cast( d.PTO as Varchar(4) ) + ', BOCA DE EXPENDIO ' + cast( d.BOCAEXP as Varchar(4) ) + '','La clave principal no es la esperada'
					from ZooLogic.PTOVTA t inner join deleted d 
							on   t.COMP = d.COMP
							 and  t.LETRA = d.LETRA
							 and  t.PTO = d.PTO
							 and  t.BOCAEXP = d.BOCAEXP
						left join deleted h 
							 on t.NUM = h.NUM
							 where h.NUM is null 
				Insert into ZooLogic.Logueos ( Fecha, Nivel, Logger, Accion, BaseDeDatos, 
					EstadoDelSistema, Aplicacion, Version, 
					Serie, Usuario, NombrePc, 
					UsuarioPc, OrigenLogueo, Mensaje, Excepcion)
				select GetDate(), 'INFO', '', 'Importación <<lcEntidad>>','<<loLogueo.BaseDatos>>',
					<<loLogueo.EstadoSistema>>,'<<loLogueo.Aplicacion>>','<<loLogueo.Version>>',
					'<<loLogueo.Serie>>','<<loLogueo.Usuario>>','<<loLogueo.NombrePc>>',
					'<<loLogueo.UsuarioPc>>','<<loLogueo.OrigenLogueo>>','No se pudo importar la entidad <<lcEntidad>>: COMPROBANTE ' + cast( d.COMP as Varchar(40) ) + ', LETRA ' + cast( d.LETRA as Varchar(1) ) + ', PUNTO DE VENTA ' + cast( d.PTO as Varchar(4) ) + ', BOCA DE EXPENDIO ' + cast( d.BOCAEXP as Varchar(4) ) + '','La clave principal a importar ya existe'
					from ZooLogic.PTOVTA t inner join deleted d 
							 on t.NUM = d.NUM
						left join deleted h 
							on   t.COMP = h.COMP
							 and   t.LETRA = h.LETRA
							 and   t.PTO = h.PTO
							 and   t.BOCAEXP = h.BOCAEXP
							where   h.COMP is null 
							 and   h.LETRA is null 
							 and   h.PTO is null 
							 and   h.BOCAEXP is null 
			End
		EndText
		Return lcCadena
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	protected Function EliminarTablasDeTrabajo( toConexion as Object ) as void
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_PTOVTA') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_PTOVTA
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_PUNTOSDEVENTA' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_PUNTOSDEVENTA.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_PUNTOSDEVENTA.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_PUNTOSDEVENTA.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_PUNTOSDEVENTA.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_PUNTOSDEVENTA.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Numero = nvl( c_PUNTOSDEVENTA.Numero, 0 )
					.Seriealtafw = nvl( c_PUNTOSDEVENTA.Seriealtafw, [] )
					.Horamodificacionfw = nvl( c_PUNTOSDEVENTA.Horamodificacionfw, [] )
					.Seriemodificacionfw = nvl( c_PUNTOSDEVENTA.Seriemodificacionfw, [] )
					.Horaimpo = nvl( c_PUNTOSDEVENTA.Horaimpo, [] )
					.Usuarioaltafw = nvl( c_PUNTOSDEVENTA.Usuarioaltafw, [] )
					.Versionmodificacionfw = nvl( c_PUNTOSDEVENTA.Versionmodificacionfw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Versionaltafw = nvl( c_PUNTOSDEVENTA.Versionaltafw, [] )
					.Horaexpo = nvl( c_PUNTOSDEVENTA.Horaexpo, [] )
					.Usuariomodificacionfw = nvl( c_PUNTOSDEVENTA.Usuariomodificacionfw, [] )
					.Basededatosmodificacionfw = nvl( c_PUNTOSDEVENTA.Basededatosmodificacionfw, [] )
					.Horaaltafw = nvl( c_PUNTOSDEVENTA.Horaaltafw, [] )
					.Basededatosaltafw = nvl( c_PUNTOSDEVENTA.Basededatosaltafw, [] )
					.Estadotransferencia = nvl( c_PUNTOSDEVENTA.Estadotransferencia, [] )
					.Comprobante = nvl( c_PUNTOSDEVENTA.Comprobante, [] )
					.Descripcion = nvl( c_PUNTOSDEVENTA.Descripcion, [] )
					.Letra = nvl( c_PUNTOSDEVENTA.Letra, [] )
					lcValor = This.ObtenerMemo( 'c_Observacion')
					.Observacion = lcValor 
					.Puntodeventa = nvl( c_PUNTOSDEVENTA.Puntodeventa, 0 )
					.Puntodeventasugerido = nvl( c_PUNTOSDEVENTA.Puntodeventasugerido, .F. )
					.Bocadeexpendio = nvl( c_PUNTOSDEVENTA.Bocadeexpendio, 0 )
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
			lxRetorno = c_PUNTOSDEVENTA.NUMERO
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
		return c_PUNTOSDEVENTA.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.PTOVTA' )
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
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "NUM"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
		text to lcSQL textmerge noshow
				SELECT nro,totalRegistros,NUM as Id
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    NUM from (
							select * 
								from ZooLogic.PTOVTA 
								Where   PTOVTA.NUM != 0
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "PTOVTA", "", lcCursor, set("Datasession") )
		lcXml = this.CursorAXml( lcCursor )
		
		use in select( lcCursor )
		
		Return lcXml 
		
	endfunc
	*-----------------------------------------------------------------------------------------
	function ObtenerDatosEntidadPaginado( tcOrderBy as String, tcFiltro as String, tnCantidad as Integer, tnPagina as Integer )  as String
		local lcOrderBy as String, lnCuantos as Integer, lnPagina as Integer, lnTope as Integer, lnDesde as Integer, lcSQL as String, lcCursor as String, lcXml as String
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "NUM"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
			text to lcAtributos textmerge noshow
			"Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Num" as "Numero", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Ualtafw" as "Usuarioaltafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Horaexpo" as "Horaexpo", "Umodifw" as "Usuariomodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Comp" as "Comprobante", "Descri" as "Descripcion", "Letra" as "Letra", "Cobs" as "Observacion", "Pto" as "Puntodeventa", "Pvsug" as "Puntodeventasugerido", "Bocaexp" as "Bocadeexpendio"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.PTOVTA 
								Where   PTOVTA.NUM != 0
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
	Tabla = 'PTOVTA'
	Filtro = " PTOVTA.NUM != 0"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " PTOVTA.NUM != 0"
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
	<row entidad="PUNTOSDEVENTA                           " atributo="FECHAEXPO                               " tabla="PTOVTA         " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PUNTOSDEVENTA                           " atributo="FECHATRANSFERENCIA                      " tabla="PTOVTA         " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha de novedad                                                                                                                                                " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PUNTOSDEVENTA                           " atributo="FECHAMODIFICACIONFW                     " tabla="PTOVTA         " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PUNTOSDEVENTA                           " atributo="FECHAALTAFW                             " tabla="PTOVTA         " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PUNTOSDEVENTA                           " atributo="FECHAIMPO                               " tabla="PTOVTA         " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PUNTOSDEVENTA                           " atributo="NUMERO                                  " tabla="PTOVTA         " campo="NUM       " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="1" etiqueta="Número                                                                                                                                                          " dominio="CODIGONUMERICO                " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PUNTOSDEVENTA                           " atributo="SERIEALTAFW                             " tabla="PTOVTA         " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PUNTOSDEVENTA                           " atributo="HORAMODIFICACIONFW                      " tabla="PTOVTA         " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PUNTOSDEVENTA                           " atributo="SERIEMODIFICACIONFW                     " tabla="PTOVTA         " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PUNTOSDEVENTA                           " atributo="HORAIMPO                                " tabla="PTOVTA         " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PUNTOSDEVENTA                           " atributo="USUARIOALTAFW                           " tabla="PTOVTA         " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PUNTOSDEVENTA                           " atributo="VERSIONMODIFICACIONFW                   " tabla="PTOVTA         " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PUNTOSDEVENTA                           " atributo="ZADSFW                                  " tabla="PTOVTA         " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PUNTOSDEVENTA                           " atributo="VERSIONALTAFW                           " tabla="PTOVTA         " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PUNTOSDEVENTA                           " atributo="HORAEXPO                                " tabla="PTOVTA         " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PUNTOSDEVENTA                           " atributo="USUARIOMODIFICACIONFW                   " tabla="PTOVTA         " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PUNTOSDEVENTA                           " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="PTOVTA         " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PUNTOSDEVENTA                           " atributo="HORAALTAFW                              " tabla="PTOVTA         " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PUNTOSDEVENTA                           " atributo="BASEDEDATOSALTAFW                       " tabla="PTOVTA         " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PUNTOSDEVENTA                           " atributo="ESTADOTRANSFERENCIA                     " tabla="PTOVTA         " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado de novedad                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PUNTOSDEVENTA                           " atributo="COMPROBANTE                             " tabla="PTOVTA         " campo="COMP      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="3" etiqueta="Comprobante                                                                                                                                                     " dominio="COMBOCOMPROBANTESDIFERPTOVEN  " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="1" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PUNTOSDEVENTA                           " atributo="DESCRIPCION                             " tabla="PTOVTA         " campo="DESCRI    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="2" etiqueta="Descripción                                                                                                                                                     " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PUNTOSDEVENTA                           " atributo="LETRA                                   " tabla="PTOVTA         " campo="LETRA     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="4" etiqueta="Letra                                                                                                                                                           " dominio="COMBOXML                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="2" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PUNTOSDEVENTA                           " atributo="OBSERVACION                             " tabla="PTOVTA         " campo="COBS      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="200" etiqueta="Observación                                                                                                                                                     " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PUNTOSDEVENTA                           " atributo="PUNTODEVENTA                            " tabla="PTOVTA         " campo="PTO       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="4" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="5" etiqueta="Punto de venta                                                                                                                                                  " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="3" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PUNTOSDEVENTA                           " atributo="PUNTODEVENTASUGERIDO                    " tabla="PTOVTA         " campo="PVSUG     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="= .T.                                                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="6" etiqueta="Punto de venta sugerido                                                                                                                                         " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PUNTOSDEVENTA                           " atributo="BOCADEEXPENDIO                          " tabla="PTOVTA         " campo="BOCAEXP   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="4" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="7" etiqueta="Boca de expendio                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="4" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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