
define class Din_EntidadREPORTEAUDITORIACIERREZAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_REPORTEAUDITORIACIERREZ'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = [str( Numero, 8, 0)]
	cExpresionCCPorCampos = [str( #tabla#.Numero, 8, 0)]
	cTagClaveCandidata = '_ACZCC'
	cTagClavePk = '_ACZPK'
	cTablaPrincipal = 'REPAUDIZ'
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
			local  lxRepaudizFecimpo, lxRepaudizFectrans, lxRepaudizFmodifw, lxRepaudizFaltafw, lxRepaudizFecexpo, lxRepaudizNumero, lxRepaudizSaltafw, lxRepaudizHmodifw, lxRepaudizUaltafw, lxRepaudizSmodifw, lxRepaudizHoraimpo, lxRepaudizUmodifw, lxRepaudizHaltafw, lxRepaudizHoraexpo, lxRepaudizBdaltafw, lxRepaudizBdmodifw, lxRepaudizVmodifw, lxRepaudizValtafw, lxRepaudizEsttrans, lxRepaudizZadsfw, lxRepaudizCodint, lxRepaudizTipoaudi, lxRepaudizFecdesde, lxRepaudizFechasta, lxRepaudizNrodesde, lxRepaudizNrohasta, lxRepaudizResumida, lxRepaudizObs
				lxRepaudizFecimpo =  .Fechaimpo			lxRepaudizFectrans =  .Fechatransferencia			lxRepaudizFmodifw =  .Fechamodificacionfw			lxRepaudizFaltafw =  .Fechaaltafw			lxRepaudizFecexpo =  .Fechaexpo			lxRepaudizNumero =  .Numero			lxRepaudizSaltafw =  .Seriealtafw			lxRepaudizHmodifw =  .Horamodificacionfw			lxRepaudizUaltafw =  .Usuarioaltafw			lxRepaudizSmodifw =  .Seriemodificacionfw			lxRepaudizHoraimpo =  .Horaimpo			lxRepaudizUmodifw =  .Usuariomodificacionfw			lxRepaudizHaltafw =  .Horaaltafw			lxRepaudizHoraexpo =  .Horaexpo			lxRepaudizBdaltafw =  .Basededatosaltafw			lxRepaudizBdmodifw =  .Basededatosmodificacionfw			lxRepaudizVmodifw =  .Versionmodificacionfw			lxRepaudizValtafw =  .Versionaltafw			lxRepaudizEsttrans =  .Estadotransferencia			lxRepaudizZadsfw =  .Zadsfw			lxRepaudizCodint =  .Codint			lxRepaudizTipoaudi =  .Tipoauditoria			lxRepaudizFecdesde =  .Fechadesde			lxRepaudizFechasta =  .Fechahasta			lxRepaudizNrodesde =  .Numerodesde			lxRepaudizNrohasta =  .Numerohasta			lxRepaudizResumida =  .Resumida			lxRepaudizObs =  .Observacion
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxRepaudizCodint = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.REPAUDIZ ( "Fecimpo","Fectrans","Fmodifw","Faltafw","Fecexpo","Numero","Saltafw","Hmodifw","Ualtafw","Smodifw","Horaimpo","Umodifw","Haltafw","Horaexpo","Bdaltafw","Bdmodifw","Vmodifw","Valtafw","Esttrans","Zadsfw","Codint","Tipoaudi","Fecdesde","Fechasta","Nrodesde","Nrohasta","Resumida","Obs" ) values ( <<"'" + this.ConvertirDateSql( lxRepaudizFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxRepaudizFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxRepaudizFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxRepaudizFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxRepaudizFecexpo ) + "'" >>, <<lxRepaudizNumero >>, <<"'" + this.FormatearTextoSql( lxRepaudizSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRepaudizHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRepaudizUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRepaudizSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRepaudizHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRepaudizUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRepaudizHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRepaudizHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRepaudizBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRepaudizBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRepaudizVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRepaudizValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRepaudizEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRepaudizZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRepaudizCodint ) + "'" >>, <<lxRepaudizTipoaudi >>, <<"'" + this.ConvertirDateSql( lxRepaudizFecdesde ) + "'" >>, <<"'" + this.ConvertirDateSql( lxRepaudizFechasta ) + "'" >>, <<lxRepaudizNrodesde >>, <<lxRepaudizNrohasta >>, <<iif( lxRepaudizResumida, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxRepaudizObs ) + "'" >> )
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
		this.ComprobarTransaccion()
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODINT
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
				lcError  = 'El número a grabar ya existe. Cambie el último número del talonario correspondiente'
			endif
		endif
		if !empty( lcError )
			goServicios.Errores.LevantarExcepcionTexto( lcError )
		endif
		return this.oEntidad.CODINT
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function Actualizar() as boolean
	local loError as Exception, loEx as Exception, lxValorClavePrimaria as variant, lnI as Integer, loSentenciasTriggers as zoocoleccion OF zoocoleccion.prg, lcSentencia as string

		with this.oEntidad
			local  lxRepaudizFecimpo, lxRepaudizFectrans, lxRepaudizFmodifw, lxRepaudizFaltafw, lxRepaudizFecexpo, lxRepaudizNumero, lxRepaudizSaltafw, lxRepaudizHmodifw, lxRepaudizUaltafw, lxRepaudizSmodifw, lxRepaudizHoraimpo, lxRepaudizUmodifw, lxRepaudizHaltafw, lxRepaudizHoraexpo, lxRepaudizBdaltafw, lxRepaudizBdmodifw, lxRepaudizVmodifw, lxRepaudizValtafw, lxRepaudizEsttrans, lxRepaudizZadsfw, lxRepaudizCodint, lxRepaudizTipoaudi, lxRepaudizFecdesde, lxRepaudizFechasta, lxRepaudizNrodesde, lxRepaudizNrohasta, lxRepaudizResumida, lxRepaudizObs
				lxRepaudizFecimpo =  .Fechaimpo			lxRepaudizFectrans =  .Fechatransferencia			lxRepaudizFmodifw =  .Fechamodificacionfw			lxRepaudizFaltafw =  .Fechaaltafw			lxRepaudizFecexpo =  .Fechaexpo			lxRepaudizNumero =  .Numero			lxRepaudizSaltafw =  .Seriealtafw			lxRepaudizHmodifw =  .Horamodificacionfw			lxRepaudizUaltafw =  .Usuarioaltafw			lxRepaudizSmodifw =  .Seriemodificacionfw			lxRepaudizHoraimpo =  .Horaimpo			lxRepaudizUmodifw =  .Usuariomodificacionfw			lxRepaudizHaltafw =  .Horaaltafw			lxRepaudizHoraexpo =  .Horaexpo			lxRepaudizBdaltafw =  .Basededatosaltafw			lxRepaudizBdmodifw =  .Basededatosmodificacionfw			lxRepaudizVmodifw =  .Versionmodificacionfw			lxRepaudizValtafw =  .Versionaltafw			lxRepaudizEsttrans =  .Estadotransferencia			lxRepaudizZadsfw =  .Zadsfw			lxRepaudizCodint =  .Codint			lxRepaudizTipoaudi =  .Tipoauditoria			lxRepaudizFecdesde =  .Fechadesde			lxRepaudizFechasta =  .Fechahasta			lxRepaudizNrodesde =  .Numerodesde			lxRepaudizNrohasta =  .Numerohasta			lxRepaudizResumida =  .Resumida			lxRepaudizObs =  .Observacion
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()
			lxValorClavePrimaria = .oEntidad.CODINT
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ZooLogic.REPAUDIZ set "Fecimpo" = <<"'" + this.ConvertirDateSql( lxRepaudizFecimpo ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxRepaudizFectrans ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxRepaudizFmodifw ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxRepaudizFaltafw ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxRepaudizFecexpo ) + "'">>,"Numero" = <<lxRepaudizNumero>>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxRepaudizSaltafw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxRepaudizHmodifw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxRepaudizUaltafw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxRepaudizSmodifw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxRepaudizHoraimpo ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxRepaudizUmodifw ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxRepaudizHaltafw ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxRepaudizHoraexpo ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxRepaudizBdaltafw ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxRepaudizBdmodifw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxRepaudizVmodifw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxRepaudizValtafw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxRepaudizEsttrans ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxRepaudizZadsfw ) + "'">>,"Codint" = <<"'" + this.FormatearTextoSql( lxRepaudizCodint ) + "'">>,"Tipoaudi" = <<lxRepaudizTipoaudi>>,"Fecdesde" = <<"'" + this.ConvertirDateSql( lxRepaudizFecdesde ) + "'">>,"Fechasta" = <<"'" + this.ConvertirDateSql( lxRepaudizFechasta ) + "'">>,"Nrodesde" = <<lxRepaudizNrodesde>>,"Nrohasta" = <<lxRepaudizNrohasta>>,"Resumida" = <<iif( lxRepaudizResumida, 1, 0 )>>,"Obs" = <<"'" + this.FormatearTextoSql( lxRepaudizObs ) + "'">> where "Codint" = <<"'" + this.FormatearTextoSql( lxRepaudizCodint ) + "'">> and  REPAUDIZ.CODINT != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 CodInt from ZooLogic.REPAUDIZ where " + this.ConvertirFuncionesSql( " REPAUDIZ.CODINT != ''" ) )
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
			Local lxRepaudizCodint
			lxRepaudizCodint = .Codint

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Numero" as "Numero", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Umodifw" as "Usuariomodificacionfw", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Esttrans" as "Estadotransferencia", "Zadsfw" as "Zadsfw", "Codint" as "Codint", "Tipoaudi" as "Tipoauditoria", "Fecdesde" as "Fechadesde", "Fechasta" as "Fechahasta", "Nrodesde" as "Numerodesde", "Nrohasta" as "Numerohasta", "Resumida" as "Resumida", "Obs" as "Observacion" from ZooLogic.REPAUDIZ where "Codint" = <<"'" + this.FormatearTextoSql( lxRepaudizCodint ) + "'">> and  REPAUDIZ.CODINT != ''
			endtext
			use in select('c_REPORTEAUDITORIACIERREZ')
			this.oConexion.EjecutarSql( lcSentencia, 'c_REPORTEAUDITORIACIERREZ', set( 'Datasession' ) )

			if reccount( 'c_REPORTEAUDITORIACIERREZ' ) = 0
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
			Local lxREPAUDIZNumero As Variant
			lxREPAUDIZNumero = .Numero
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Numero" as "Numero", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Umodifw" as "Usuariomodificacionfw", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Esttrans" as "Estadotransferencia", "Zadsfw" as "Zadsfw", "Codint" as "Codint", "Tipoaudi" as "Tipoauditoria", "Fecdesde" as "Fechadesde", "Fechasta" as "Fechahasta", "Nrodesde" as "Numerodesde", "Nrohasta" as "Numerohasta", "Resumida" as "Resumida", "Obs" as "Observacion" from ZooLogic.REPAUDIZ where  REPAUDIZ.CODINT != '' And Numero = <<lxREPAUDIZNumero>>
			endtext
			use in select('c_REPORTEAUDITORIACIERREZ')
			this.oConexion.EjecutarSql( lcSentencia, 'c_REPORTEAUDITORIACIERREZ', set( 'Datasession' ) )
			if reccount( 'c_REPORTEAUDITORIACIERREZ' ) = 0
				llRetorno = .f.
			else
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxRepaudizCodint as Variant
		llRetorno = .t.
		lxRepaudizCodint = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.REPAUDIZ where "Codint" = <<"'" + this.FormatearTextoSql( lxRepaudizCodint ) + "'">> and  REPAUDIZ.CODINT != ''
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
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Numero" as "Numero", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Umodifw" as "Usuariomodificacionfw", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Esttrans" as "Estadotransferencia", "Zadsfw" as "Zadsfw", "Codint" as "Codint", "Tipoaudi" as "Tipoauditoria", "Fecdesde" as "Fechadesde", "Fechasta" as "Fechahasta", "Nrodesde" as "Numerodesde", "Nrohasta" as "Numerohasta", "Resumida" as "Resumida", "Obs" as "Observacion" from ZooLogic.REPAUDIZ where  REPAUDIZ.CODINT != '' order by Numero
			endtext
			use in select('c_REPORTEAUDITORIACIERREZ')
			this.oConexion.EjecutarSql( lcSentencia, 'c_REPORTEAUDITORIACIERREZ', set( 'Datasession' ) )
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
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Numero" as "Numero", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Umodifw" as "Usuariomodificacionfw", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Esttrans" as "Estadotransferencia", "Zadsfw" as "Zadsfw", "Codint" as "Codint", "Tipoaudi" as "Tipoauditoria", "Fecdesde" as "Fechadesde", "Fechasta" as "Fechahasta", "Nrodesde" as "Numerodesde", "Nrohasta" as "Numerohasta", "Resumida" as "Resumida", "Obs" as "Observacion" from ZooLogic.REPAUDIZ where  str( Numero, 8, 0) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  REPAUDIZ.CODINT != '' order by Numero
			endtext
			use in select('c_REPORTEAUDITORIACIERREZ')
			this.oConexion.EjecutarSql( lcSentencia, 'c_REPORTEAUDITORIACIERREZ', set( 'Datasession' ) )
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
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Numero" as "Numero", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Umodifw" as "Usuariomodificacionfw", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Esttrans" as "Estadotransferencia", "Zadsfw" as "Zadsfw", "Codint" as "Codint", "Tipoaudi" as "Tipoauditoria", "Fecdesde" as "Fechadesde", "Fechasta" as "Fechahasta", "Nrodesde" as "Numerodesde", "Nrohasta" as "Numerohasta", "Resumida" as "Resumida", "Obs" as "Observacion" from ZooLogic.REPAUDIZ where  str( Numero, 8, 0) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  REPAUDIZ.CODINT != '' order by Numero desc
			endtext
			use in select('c_REPORTEAUDITORIACIERREZ')
			this.oConexion.EjecutarSql( lcSentencia, 'c_REPORTEAUDITORIACIERREZ', set( 'Datasession' ) )
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
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Numero" as "Numero", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Umodifw" as "Usuariomodificacionfw", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Esttrans" as "Estadotransferencia", "Zadsfw" as "Zadsfw", "Codint" as "Codint", "Tipoaudi" as "Tipoauditoria", "Fecdesde" as "Fechadesde", "Fechasta" as "Fechahasta", "Nrodesde" as "Numerodesde", "Nrohasta" as "Numerohasta", "Resumida" as "Resumida", "Obs" as "Observacion" from ZooLogic.REPAUDIZ where  REPAUDIZ.CODINT != '' order by Numero desc
			endtext
			use in select('c_REPORTEAUDITORIACIERREZ')
			this.oConexion.EjecutarSql( lcSentencia, 'c_REPORTEAUDITORIACIERREZ', set( 'Datasession' ) )
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
				lcFiltroCodigo = ' and ' + .cCampoClavePrimaria + ' <> ' + "'" + this.FormatearTextoSql( .oEntidad.CODINT ) + "'"
			endif
			lcFiltro = lcCampo + ' = ' + goLibrerias.ValorAString(lxValor) + lcFiltroCodigo
			local lcXml as string
			lcXml = this.oConexion.EjecutarSql( "select Fecimpo,Fectrans,Fmodifw,Faltafw,Fecexpo,Numero,Saltafw,Hmodifw,Ualtafw,Smodifw,Horaimpo,Umo" + ;
"difw,Haltafw,Horaexpo,Bdaltafw,Bdmodifw,Vmodifw,Valtafw,Esttrans,Zadsfw,Codint,Tipoaudi,Fecdesde,Fec" + ;
"hasta,Nrodesde,Nrohasta,Resumida,Obs" + ;
" from ZooLogic.REPAUDIZ where  REPAUDIZ.CODINT != '' and " + lcFiltro )
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
			local  lxRepaudizFecimpo, lxRepaudizFectrans, lxRepaudizFmodifw, lxRepaudizFaltafw, lxRepaudizFecexpo, lxRepaudizNumero, lxRepaudizSaltafw, lxRepaudizHmodifw, lxRepaudizUaltafw, lxRepaudizSmodifw, lxRepaudizHoraimpo, lxRepaudizUmodifw, lxRepaudizHaltafw, lxRepaudizHoraexpo, lxRepaudizBdaltafw, lxRepaudizBdmodifw, lxRepaudizVmodifw, lxRepaudizValtafw, lxRepaudizEsttrans, lxRepaudizZadsfw, lxRepaudizCodint, lxRepaudizTipoaudi, lxRepaudizFecdesde, lxRepaudizFechasta, lxRepaudizNrodesde, lxRepaudizNrohasta, lxRepaudizResumida, lxRepaudizObs
				lxRepaudizFecimpo = ctod( '  /  /    ' )			lxRepaudizFectrans = ctod( '  /  /    ' )			lxRepaudizFmodifw = ctod( '  /  /    ' )			lxRepaudizFaltafw = ctod( '  /  /    ' )			lxRepaudizFecexpo = ctod( '  /  /    ' )			lxRepaudizNumero = 0			lxRepaudizSaltafw = []			lxRepaudizHmodifw = []			lxRepaudizUaltafw = []			lxRepaudizSmodifw = []			lxRepaudizHoraimpo = []			lxRepaudizUmodifw = []			lxRepaudizHaltafw = []			lxRepaudizHoraexpo = []			lxRepaudizBdaltafw = []			lxRepaudizBdmodifw = []			lxRepaudizVmodifw = []			lxRepaudizValtafw = []			lxRepaudizEsttrans = []			lxRepaudizZadsfw = []			lxRepaudizCodint = []			lxRepaudizTipoaudi = 0			lxRepaudizFecdesde = ctod( '  /  /    ' )			lxRepaudizFechasta = ctod( '  /  /    ' )			lxRepaudizNrodesde = 0			lxRepaudizNrohasta = 0			lxRepaudizResumida = .F.			lxRepaudizObs = []
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( [delete from ZooLogic.REPAUDIZ where "CodInt" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODINT ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'REPAUDIZ' + '_' + tcCampo
			lcMemoAscii = ''

			lnIndice = alen(.aSqlMemos)
			lnIndice = iif(lnIndice = 1, 1, lnIndice + 1 )
			dimension .aSqlMemos(lnIndice)

			.aSqlMemos(lnIndice) = 'delete from ' + lcTabla + ' where CodInt = ' + txValorClavePrimaria
			.GenerarSentenciasInsertTablaMemo( lcValor, lcTabla, txValorClavePrimaria )
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerSentenciaInsertMemo( tcTabla as String, txValorClavePrimaria as String, tcOrden as String, tcTexto as String ) as String
		return "Insert  into " + tcTabla + "(CodInt, Orden, texto ) values ( " + txValorClavePrimaria + "," + tcOrden + ",'"+ tcTexto + "')"
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosEntidad( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  REPAUDIZ.CODINT != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Numero" as "Numero", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Umodifw" as "Usuariomodificacionfw", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Esttrans" as "Estadotransferencia", "Zadsfw" as "Zadsfw", "Codint" as "Codint", "Tipoaudi" as "Tipoauditoria", "Fecdesde" as "Fechadesde", "Fechasta" as "Fechahasta", "Nrodesde" as "Numerodesde", "Nrohasta" as "Numerohasta", "Resumida" as "Resumida", "Obs" as "Observacion"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'REPAUDIZ', '', tnTope )
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
				Case lcAtributo == 'FECHATRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRANS AS FECHATRANSFERENCIA'
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'FECHAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECEXPO AS FECHAEXPO'
				Case lcAtributo == 'NUMERO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NUMERO AS NUMERO'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'CODINT'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODINT AS CODINT'
				Case lcAtributo == 'TIPOAUDITORIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPOAUDI AS TIPOAUDITORIA'
				Case lcAtributo == 'FECHADESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECDESDE AS FECHADESDE'
				Case lcAtributo == 'FECHAHASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHASTA AS FECHAHASTA'
				Case lcAtributo == 'NUMERODESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NRODESDE AS NUMERODESDE'
				Case lcAtributo == 'NUMEROHASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROHASTA AS NUMEROHASTA'
				Case lcAtributo == 'RESUMIDA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RESUMIDA AS RESUMIDA'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEXPO'
				lcCampo = 'FECEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'NUMERO'
				lcCampo = 'NUMERO'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'CODINT'
				lcCampo = 'CODINT'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOAUDITORIA'
				lcCampo = 'TIPOAUDI'
			Case upper( alltrim( tcAtributo ) ) == 'FECHADESDE'
				lcCampo = 'FECDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAHASTA'
				lcCampo = 'FECHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'NUMERODESDE'
				lcCampo = 'NRODESDE'
			Case upper( alltrim( tcAtributo ) ) == 'NUMEROHASTA'
				lcCampo = 'NROHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'RESUMIDA'
				lcCampo = 'RESUMIDA'
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
			local  lxRepaudizFecimpo, lxRepaudizFectrans, lxRepaudizFmodifw, lxRepaudizFaltafw, lxRepaudizFecexpo, lxRepaudizNumero, lxRepaudizSaltafw, lxRepaudizHmodifw, lxRepaudizUaltafw, lxRepaudizSmodifw, lxRepaudizHoraimpo, lxRepaudizUmodifw, lxRepaudizHaltafw, lxRepaudizHoraexpo, lxRepaudizBdaltafw, lxRepaudizBdmodifw, lxRepaudizVmodifw, lxRepaudizValtafw, lxRepaudizEsttrans, lxRepaudizZadsfw, lxRepaudizCodint, lxRepaudizTipoaudi, lxRepaudizFecdesde, lxRepaudizFechasta, lxRepaudizNrodesde, lxRepaudizNrohasta, lxRepaudizResumida, lxRepaudizObs
				lxRepaudizFecimpo =  .Fechaimpo			lxRepaudizFectrans =  .Fechatransferencia			lxRepaudizFmodifw =  .Fechamodificacionfw			lxRepaudizFaltafw =  .Fechaaltafw			lxRepaudizFecexpo =  .Fechaexpo			lxRepaudizNumero =  .Numero			lxRepaudizSaltafw =  .Seriealtafw			lxRepaudizHmodifw =  .Horamodificacionfw			lxRepaudizUaltafw =  .Usuarioaltafw			lxRepaudizSmodifw =  .Seriemodificacionfw			lxRepaudizHoraimpo =  .Horaimpo			lxRepaudizUmodifw =  .Usuariomodificacionfw			lxRepaudizHaltafw =  .Horaaltafw			lxRepaudizHoraexpo =  .Horaexpo			lxRepaudizBdaltafw =  .Basededatosaltafw			lxRepaudizBdmodifw =  .Basededatosmodificacionfw			lxRepaudizVmodifw =  .Versionmodificacionfw			lxRepaudizValtafw =  .Versionaltafw			lxRepaudizEsttrans =  .Estadotransferencia			lxRepaudizZadsfw =  .Zadsfw			lxRepaudizCodint =  .Codint			lxRepaudizTipoaudi =  .Tipoauditoria			lxRepaudizFecdesde =  .Fechadesde			lxRepaudizFechasta =  .Fechahasta			lxRepaudizNrodesde =  .Numerodesde			lxRepaudizNrohasta =  .Numerohasta			lxRepaudizResumida =  .Resumida			lxRepaudizObs =  .Observacion
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.REPAUDIZ ( "Fecimpo","Fectrans","Fmodifw","Faltafw","Fecexpo","Numero","Saltafw","Hmodifw","Ualtafw","Smodifw","Horaimpo","Umodifw","Haltafw","Horaexpo","Bdaltafw","Bdmodifw","Vmodifw","Valtafw","Esttrans","Zadsfw","Codint","Tipoaudi","Fecdesde","Fechasta","Nrodesde","Nrohasta","Resumida","Obs" ) values ( <<"'" + this.ConvertirDateSql( lxRepaudizFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxRepaudizFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxRepaudizFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxRepaudizFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxRepaudizFecexpo ) + "'" >>, <<lxRepaudizNumero >>, <<"'" + this.FormatearTextoSql( lxRepaudizSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRepaudizHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRepaudizUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRepaudizSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRepaudizHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRepaudizUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRepaudizHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRepaudizHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRepaudizBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRepaudizBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRepaudizVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRepaudizValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRepaudizEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRepaudizZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRepaudizCodint ) + "'" >>, <<lxRepaudizTipoaudi >>, <<"'" + this.ConvertirDateSql( lxRepaudizFecdesde ) + "'" >>, <<"'" + this.ConvertirDateSql( lxRepaudizFechasta ) + "'" >>, <<lxRepaudizNrodesde >>, <<lxRepaudizNrohasta >>, <<iif( lxRepaudizResumida, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxRepaudizObs ) + "'" >> )
		endtext
		loColeccion.cTabla = 'REPAUDIZ' 
		loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		With this
			local lcValorClavePrimariaString as String
			lcValorClavePrimariaString = "'" + this.oEntidad.CODINT + "'"
		EndWith
		return loColeccion
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasUpdate() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcFiltro as string, loItem as object, lcSentencia as string, lcSentencia as string
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxRepaudizFecimpo, lxRepaudizFectrans, lxRepaudizFmodifw, lxRepaudizFaltafw, lxRepaudizFecexpo, lxRepaudizNumero, lxRepaudizSaltafw, lxRepaudizHmodifw, lxRepaudizUaltafw, lxRepaudizSmodifw, lxRepaudizHoraimpo, lxRepaudizUmodifw, lxRepaudizHaltafw, lxRepaudizHoraexpo, lxRepaudizBdaltafw, lxRepaudizBdmodifw, lxRepaudizVmodifw, lxRepaudizValtafw, lxRepaudizEsttrans, lxRepaudizZadsfw, lxRepaudizCodint, lxRepaudizTipoaudi, lxRepaudizFecdesde, lxRepaudizFechasta, lxRepaudizNrodesde, lxRepaudizNrohasta, lxRepaudizResumida, lxRepaudizObs
				lxRepaudizFecimpo =  .Fechaimpo			lxRepaudizFectrans =  .Fechatransferencia			lxRepaudizFmodifw =  .Fechamodificacionfw			lxRepaudizFaltafw =  .Fechaaltafw			lxRepaudizFecexpo =  .Fechaexpo			lxRepaudizNumero =  .Numero			lxRepaudizSaltafw =  .Seriealtafw			lxRepaudizHmodifw =  .Horamodificacionfw			lxRepaudizUaltafw =  .Usuarioaltafw			lxRepaudizSmodifw =  .Seriemodificacionfw			lxRepaudizHoraimpo =  .Horaimpo			lxRepaudizUmodifw =  .Usuariomodificacionfw			lxRepaudizHaltafw =  .Horaaltafw			lxRepaudizHoraexpo =  .Horaexpo			lxRepaudizBdaltafw =  .Basededatosaltafw			lxRepaudizBdmodifw =  .Basededatosmodificacionfw			lxRepaudizVmodifw =  .Versionmodificacionfw			lxRepaudizValtafw =  .Versionaltafw			lxRepaudizEsttrans =  .Estadotransferencia			lxRepaudizZadsfw =  .Zadsfw			lxRepaudizCodint =  .Codint			lxRepaudizTipoaudi =  .Tipoauditoria			lxRepaudizFecdesde =  .Fechadesde			lxRepaudizFechasta =  .Fechahasta			lxRepaudizNrodesde =  .Numerodesde			lxRepaudizNrohasta =  .Numerohasta			lxRepaudizResumida =  .Resumida			lxRepaudizObs =  .Observacion
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODINT
			lcValorClavePrimariaString = "'" + this.oEntidad.CODINT + "'"

			lcFiltro = ["Codint" = ] + lcValorClavePrimariaString  + [ and  REPAUDIZ.CODINT != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.REPAUDIZ set "Fecimpo" = <<"'" + this.ConvertirDateSql( lxRepaudizFecimpo ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxRepaudizFectrans ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxRepaudizFmodifw ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxRepaudizFaltafw ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxRepaudizFecexpo ) + "'">>, "Numero" = <<lxRepaudizNumero>>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxRepaudizSaltafw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxRepaudizHmodifw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxRepaudizUaltafw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxRepaudizSmodifw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxRepaudizHoraimpo ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxRepaudizUmodifw ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxRepaudizHaltafw ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxRepaudizHoraexpo ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxRepaudizBdaltafw ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxRepaudizBdmodifw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxRepaudizVmodifw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxRepaudizValtafw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxRepaudizEsttrans ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxRepaudizZadsfw ) + "'">>, "Codint" = <<"'" + this.FormatearTextoSql( lxRepaudizCodint ) + "'">>, "Tipoaudi" = <<lxRepaudizTipoaudi>>, "Fecdesde" = <<"'" + this.ConvertirDateSql( lxRepaudizFecdesde ) + "'">>, "Fechasta" = <<"'" + this.ConvertirDateSql( lxRepaudizFechasta ) + "'">>, "Nrodesde" = <<lxRepaudizNrodesde>>, "Nrohasta" = <<lxRepaudizNrohasta>>, "Resumida" = <<iif( lxRepaudizResumida, 1, 0 )>>, "Obs" = <<"'" + this.FormatearTextoSql( lxRepaudizObs ) + "'">> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'REPAUDIZ' 
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
			lxValorClavePrimaria = this.oEntidad.CODINT
			lcValorClavePrimariaString = "'" + this.oEntidad.CODINT + "'"

			lcFiltro = ["Codint" = ] + lcValorClavePrimariaString  + [ and  REPAUDIZ.CODINT != '']
		loColeccion.Agregar( 'delete from ZooLogic.REPAUDIZ where ' + lcFiltro )
			loColeccion.cTabla = 'REPAUDIZ' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.REPAUDIZ where  REPAUDIZ.CODINT != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.REPAUDIZ where CodInt = " + "'" + this.FormatearTextoSql( this.oEntidad.CODINT ) + "'"+ " and  REPAUDIZ.CODINT != ''" )
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
		local lcCursor as String, ldFecha as Date, lcHora as string, lcValorABuscar As String, lxValorClavePK As variant, lxValorClavePrimaria As variant, lcIdentificadorParaLoguear as string, lxREPAUDIZNumero as variant, lcMensajeExtra as String
		lcValorABuscar = ''
		lxValorClavePK = ''
		lcMensajeExtra = ''
		lcCursor = This.oEntidad.cPrefijoRecibir + 'REPORTEAUDITORIACIERREZ'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.REPAUDIZ Where  Numero = ] + transform( &lcCursor..Numero     ), 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				lxValorClavePK = &lcCursor..CodInt
				if lxValorClavePK == curSeek.CodInt or this.oEntidad.lIgnorarClaveprimariaEnRecepcionBD 
					if lxValorClavePK != curSeek.CodInt and this.oEntidad.lIgnorarClaveprimariaEnRecepcionBD 
						lcValorABuscar = curSeek.CodInt
					else 
						lcValorABuscar = lxValorClavePK 
					endif 
					if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
						Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
						this.oConexion.EjecutarSql( [UPDATE ZooLogic.REPAUDIZ set  FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, Numero = ] + transform( &lcCursor..Numero )+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, CodInt = ] + "'" + this.FormatearTextoSql( &lcCursor..CodInt ) + "'"+ [, TipoAudi = ] + transform( &lcCursor..TipoAudi )+ [, FecDesde = ] + "'" + this.ConvertirDateSql( &lcCursor..FecDesde ) + "'"+ [, FecHasta = ] + "'" + this.ConvertirDateSql( &lcCursor..FecHasta ) + "'"+ [, NroDesde = ] + transform( &lcCursor..NroDesde )+ [, NroHasta = ] + transform( &lcCursor..NroHasta )+ [, Resumida = ] + Transform( iif( &lcCursor..Resumida, 1, 0 ))+ [, Obs = ] + "'" + this.FormatearTextoSql( &lcCursor..Obs ) + "'" + [ Where CodInt = ] + "'" + this.FormatearTextoSql( lcValorABuscar ) + "'" )
						this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
					else
						this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
					endIf
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir porque no coincide la clave principal.', tlLoguear )
				endIf
			else
				this.oConexion.EjecutarSql( [Select * From ZooLogic.REPAUDIZ Where CodInt = ] + "'" + this.FormatearTextoSql( &lcCursor..CodInt ) + "'", 'curSeek', this.datasessionid )
				if reccount( 'curSeek' ) > 0
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir como alta porque la clave principal ya existe', tlLoguear )
				Else
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					Text to lcCampos noShow
						 FECIMPO, FECTRANS, FMODIFW, FALTAFW, FECEXPO, Numero, SALTAFW, HMODIFW, UALTAFW, SMODIFW, HORAIMPO, UMODIFW, HALTAFW, HORAEXPO, BDALTAFW, BDMODIFW, VMODIFW, VALTAFW, ESTTRANS, ZADSFW, CodInt, TipoAudi, FecDesde, FecHasta, NroDesde, NroHasta, Resumida, Obs
					EndText
					local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + transform( &lcCursor..Numero ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CodInt ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..TipoAudi ) + ',' + "'" + this.ConvertirDateSql( &lcCursor..FecDesde ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FecHasta ) + "'" + ',' + transform( &lcCursor..NroDesde ) + ',' + transform( &lcCursor..NroHasta ) + ',' + Transform( iif( &lcCursor..Resumida, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..Obs ) + "'"
lcValoresCampos = substr(lcValoresCampos,2) 

					this.oConexion.EjecutarSql( [Insert into ZooLogic.REPAUDIZ ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
				EndIf
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'REPORTEAUDITORIACIERREZ'
		if This.ActualizaEnRecepcion()
	endif
	Use in select( 'cExistentes' )
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearCursorMemo( tcCursorACrear as String, tcTablaConMemo as String ) as Void
		create cursor &tcCursorACrear ( CodInt C (38) , Orden N(16), texto C(80))
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
			Case  lcAlias == lcPrefijo + 'REPORTEAUDITORIACIERREZ'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'REPORTEAUDITORIACIERREZ_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'REPORTEAUDITORIACIERREZ_OBS'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_REPAUDIZ')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'REPORTEAUDITORIACIERREZ'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..CodInt
		llCondicion = isnull( lxVar ) or isnull( &lcCursor..Numero )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad REPORTEAUDITORIACIERREZ. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'REPORTEAUDITORIACIERREZ'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		select recno() as _Rec, * from &lcCursor into cursor CurConRecno
		select max( _Rec ) as Maximo,CodInt as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( CodInt, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
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
			lcCursor = This.oEntidad.cPrefijoRecibir + 'REPORTEAUDITORIACIERREZ'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FecDesde  
		* Validar ANTERIORES A 1/1/1753  FecHasta  
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_REPAUDIZ') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_REPAUDIZ
Create Table ZooLogic.TablaTrabajo_REPAUDIZ ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fecimpo" datetime  null, 
"fectrans" datetime  null, 
"fmodifw" datetime  null, 
"faltafw" datetime  null, 
"fecexpo" datetime  null, 
"numero" numeric( 8, 0 )  null, 
"saltafw" char( 7 )  null, 
"hmodifw" char( 8 )  null, 
"ualtafw" char( 100 )  null, 
"smodifw" char( 7 )  null, 
"horaimpo" char( 8 )  null, 
"umodifw" char( 100 )  null, 
"haltafw" char( 8 )  null, 
"horaexpo" char( 8 )  null, 
"bdaltafw" char( 8 )  null, 
"bdmodifw" char( 8 )  null, 
"vmodifw" char( 13 )  null, 
"valtafw" char( 13 )  null, 
"esttrans" char( 20 )  null, 
"zadsfw" varchar(max)  null, 
"codint" char( 38 )  null, 
"tipoaudi" numeric( 1, 0 )  null, 
"fecdesde" datetime  null, 
"fechasta" datetime  null, 
"nrodesde" numeric( 5, 0 )  null, 
"nrohasta" numeric( 5, 0 )  null, 
"resumida" bit  null, 
"obs" varchar(max)  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_REPAUDIZ' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_REPAUDIZ' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'REPORTEAUDITORIACIERREZ'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		with loManejador
			if this.oEntidad.VerificarContexto( 'CB' )
			else
				.AgregarMapeo('Nrolinea','Nrolinea')
			endif
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('numero','numero')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('codint','codint')
			.AgregarMapeo('tipoaudi','tipoaudi')
			.AgregarMapeo('fecdesde','fecdesde')
			.AgregarMapeo('fechasta','fechasta')
			.AgregarMapeo('nrodesde','nrodesde')
			.AgregarMapeo('nrohasta','nrohasta')
			.AgregarMapeo('resumida','resumida')
			.AgregarMapeo('obs','obs')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_REPAUDIZ'
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
				Update t Set t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.NUMERO = isnull( d.NUMERO, t.NUMERO ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.CODINT = isnull( d.CODINT, t.CODINT ),t.TIPOAUDI = isnull( d.TIPOAUDI, t.TIPOAUDI ),t.FECDESDE = isnull( d.FECDESDE, t.FECDESDE ),t.FECHASTA = isnull( d.FECHASTA, t.FECHASTA ),t.NRODESDE = isnull( d.NRODESDE, t.NRODESDE ),t.NROHASTA = isnull( d.NROHASTA, t.NROHASTA ),t.RESUMIDA = isnull( d.RESUMIDA, t.RESUMIDA ),t.OBS = isnull( d.OBS, t.OBS )
					from ZooLogic.REPAUDIZ t inner join deleted d 
							 on t.CodInt = d.CodInt
							 and  t.Numero = d.Numero
				-- Fin Updates
				insert into ZooLogic.REPAUDIZ(Fecimpo,Fectrans,Fmodifw,Faltafw,Fecexpo,Numero,Saltafw,Hmodifw,Ualtafw,Smodifw,Horaimpo,Umodifw,Haltafw,Horaexpo,Bdaltafw,Bdmodifw,Vmodifw,Valtafw,Esttrans,Zadsfw,Codint,Tipoaudi,Fecdesde,Fechasta,Nrodesde,Nrohasta,Resumida,Obs)
					Select isnull( d.FECIMPO,''),isnull( d.FECTRANS,''),isnull( d.FMODIFW,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FECEXPO,''),isnull( d.NUMERO,0),isnull( d.SALTAFW,''),isnull( d.HMODIFW,''),isnull( d.UALTAFW,''),isnull( d.SMODIFW,''),isnull( d.HORAIMPO,''),isnull( d.UMODIFW,''),convert( char(8), getdate(), 108 ),isnull( d.HORAEXPO,''),isnull( d.BDALTAFW,''),isnull( d.BDMODIFW,''),isnull( d.VMODIFW,''),isnull( d.VALTAFW,''),isnull( d.ESTTRANS,''),isnull( d.ZADSFW,''),isnull( d.CODINT,''),isnull( d.TIPOAUDI,0),isnull( d.FECDESDE,''),isnull( d.FECHASTA,''),isnull( d.NRODESDE,0),isnull( d.NROHASTA,0),isnull( d.RESUMIDA,0),isnull( d.OBS,'')
						From deleted d left join ZooLogic.REPAUDIZ pk 
							 on d.CodInt = pk.CodInt
						 left join ZooLogic.REPAUDIZ cc 
							 on  d.Numero = cc.Numero
						Where pk.CodInt Is Null 
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
					from ZooLogic.REPAUDIZ t inner join deleted d 
							on   t.Numero = d.Numero
						left join deleted h 
							 on t.CodInt = h.CodInt
							 where h.CodInt is null 
				Insert into ZooLogic.Logueos ( Fecha, Nivel, Logger, Accion, BaseDeDatos, 
					EstadoDelSistema, Aplicacion, Version, 
					Serie, Usuario, NombrePc, 
					UsuarioPc, OrigenLogueo, Mensaje, Excepcion)
				select GetDate(), 'INFO', '', 'Importación <<lcEntidad>>','<<loLogueo.BaseDatos>>',
					<<loLogueo.EstadoSistema>>,'<<loLogueo.Aplicacion>>','<<loLogueo.Version>>',
					'<<loLogueo.Serie>>','<<loLogueo.Usuario>>','<<loLogueo.NombrePc>>',
					'<<loLogueo.UsuarioPc>>','<<loLogueo.OrigenLogueo>>','No se pudo importar la entidad <<lcEntidad>>: NÚMERO ' + cast( d.Numero as Varchar(8) ) + '','La clave principal a importar ya existe'
					from ZooLogic.REPAUDIZ t inner join deleted d 
							 on t.CodInt = d.CodInt
						left join deleted h 
							on   t.Numero = h.Numero
							where   h.Numero is null 
			End
		EndText
		Return lcCadena
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	protected Function EliminarTablasDeTrabajo( toConexion as Object ) as void
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_REPAUDIZ') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_REPAUDIZ
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_REPORTEAUDITORIACIERREZ' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_REPORTEAUDITORIACIERREZ.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_REPORTEAUDITORIACIERREZ.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_REPORTEAUDITORIACIERREZ.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_REPORTEAUDITORIACIERREZ.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_REPORTEAUDITORIACIERREZ.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Numero = nvl( c_REPORTEAUDITORIACIERREZ.Numero, 0 )
					.Seriealtafw = nvl( c_REPORTEAUDITORIACIERREZ.Seriealtafw, [] )
					.Horamodificacionfw = nvl( c_REPORTEAUDITORIACIERREZ.Horamodificacionfw, [] )
					.Usuarioaltafw = nvl( c_REPORTEAUDITORIACIERREZ.Usuarioaltafw, [] )
					.Seriemodificacionfw = nvl( c_REPORTEAUDITORIACIERREZ.Seriemodificacionfw, [] )
					.Horaimpo = nvl( c_REPORTEAUDITORIACIERREZ.Horaimpo, [] )
					.Usuariomodificacionfw = nvl( c_REPORTEAUDITORIACIERREZ.Usuariomodificacionfw, [] )
					.Horaaltafw = nvl( c_REPORTEAUDITORIACIERREZ.Horaaltafw, [] )
					.Horaexpo = nvl( c_REPORTEAUDITORIACIERREZ.Horaexpo, [] )
					.Basededatosaltafw = nvl( c_REPORTEAUDITORIACIERREZ.Basededatosaltafw, [] )
					.Basededatosmodificacionfw = nvl( c_REPORTEAUDITORIACIERREZ.Basededatosmodificacionfw, [] )
					.Versionmodificacionfw = nvl( c_REPORTEAUDITORIACIERREZ.Versionmodificacionfw, [] )
					.Versionaltafw = nvl( c_REPORTEAUDITORIACIERREZ.Versionaltafw, [] )
					.Estadotransferencia = nvl( c_REPORTEAUDITORIACIERREZ.Estadotransferencia, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Codint = nvl( c_REPORTEAUDITORIACIERREZ.Codint, [] )
					.Tipoauditoria = nvl( c_REPORTEAUDITORIACIERREZ.Tipoauditoria, 0 )
					.Fechadesde = GoLibrerias.ObtenerFechaFormateada( nvl( c_REPORTEAUDITORIACIERREZ.Fechadesde, ctod( '  /  /    ' ) ) )
					.Fechahasta = GoLibrerias.ObtenerFechaFormateada( nvl( c_REPORTEAUDITORIACIERREZ.Fechahasta, ctod( '  /  /    ' ) ) )
					.Numerodesde = nvl( c_REPORTEAUDITORIACIERREZ.Numerodesde, 0 )
					.Numerohasta = nvl( c_REPORTEAUDITORIACIERREZ.Numerohasta, 0 )
					.Resumida = nvl( c_REPORTEAUDITORIACIERREZ.Resumida, .F. )
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
	function ObtenerIdPorClaveCandidata() as variant
		local lxRetorno as Variant
		lxRetorno = ''
		if this.ConsultarPorClaveCandidata()
			lxRetorno = c_REPORTEAUDITORIACIERREZ.CODINT
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
		return c_REPORTEAUDITORIACIERREZ.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.REPAUDIZ' )
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
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "CodInt"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
		text to lcSQL textmerge noshow
				SELECT nro,totalRegistros,CodInt as Id
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    CodInt from (
							select * 
								from ZooLogic.REPAUDIZ 
								Where   REPAUDIZ.CODINT != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "REPAUDIZ", "", lcCursor, set("Datasession") )
		lcXml = this.CursorAXml( lcCursor )
		
		use in select( lcCursor )
		
		Return lcXml 
		
	endfunc
	*-----------------------------------------------------------------------------------------
	function ObtenerDatosEntidadPaginado( tcOrderBy as String, tcFiltro as String, tnCantidad as Integer, tnPagina as Integer )  as String
		local lcOrderBy as String, lnCuantos as Integer, lnPagina as Integer, lnTope as Integer, lnDesde as Integer, lcSQL as String, lcCursor as String, lcXml as String
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "CodInt"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
			text to lcAtributos textmerge noshow
			"Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Numero" as "Numero", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Umodifw" as "Usuariomodificacionfw", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Esttrans" as "Estadotransferencia", "Zadsfw" as "Zadsfw", "Codint" as "Codint", "Tipoaudi" as "Tipoauditoria", "Fecdesde" as "Fechadesde", "Fechasta" as "Fechahasta", "Nrodesde" as "Numerodesde", "Nrohasta" as "Numerohasta", "Resumida" as "Resumida", "Obs" as "Observacion"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.REPAUDIZ 
								Where   REPAUDIZ.CODINT != ''
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
	Tabla = 'REPAUDIZ'
	Filtro = " REPAUDIZ.CODINT != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " REPAUDIZ.CODINT != ''"
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
	<row entidad="REPORTEAUDITORIACIERREZ                 " atributo="FECHAIMPO                               " tabla="REPAUDIZ       " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REPORTEAUDITORIACIERREZ                 " atributo="FECHATRANSFERENCIA                      " tabla="REPAUDIZ       " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha transferencia                                                                                                                                             " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REPORTEAUDITORIACIERREZ                 " atributo="FECHAMODIFICACIONFW                     " tabla="REPAUDIZ       " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REPORTEAUDITORIACIERREZ                 " atributo="FECHAALTAFW                             " tabla="REPAUDIZ       " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REPORTEAUDITORIACIERREZ                 " atributo="FECHAEXPO                               " tabla="REPAUDIZ       " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REPORTEAUDITORIACIERREZ                 " atributo="NUMERO                                  " tabla="REPAUDIZ       " campo="NUMERO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="1" etiqueta="Número                                                                                                                                                          " dominio="CLAVECANDIDATA                " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="1" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REPORTEAUDITORIACIERREZ                 " atributo="SERIEALTAFW                             " tabla="REPAUDIZ       " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REPORTEAUDITORIACIERREZ                 " atributo="HORAMODIFICACIONFW                      " tabla="REPAUDIZ       " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REPORTEAUDITORIACIERREZ                 " atributo="USUARIOALTAFW                           " tabla="REPAUDIZ       " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REPORTEAUDITORIACIERREZ                 " atributo="SERIEMODIFICACIONFW                     " tabla="REPAUDIZ       " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REPORTEAUDITORIACIERREZ                 " atributo="HORAIMPO                                " tabla="REPAUDIZ       " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REPORTEAUDITORIACIERREZ                 " atributo="USUARIOMODIFICACIONFW                   " tabla="REPAUDIZ       " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REPORTEAUDITORIACIERREZ                 " atributo="HORAALTAFW                              " tabla="REPAUDIZ       " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REPORTEAUDITORIACIERREZ                 " atributo="HORAEXPO                                " tabla="REPAUDIZ       " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REPORTEAUDITORIACIERREZ                 " atributo="BASEDEDATOSALTAFW                       " tabla="REPAUDIZ       " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REPORTEAUDITORIACIERREZ                 " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="REPAUDIZ       " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REPORTEAUDITORIACIERREZ                 " atributo="VERSIONMODIFICACIONFW                   " tabla="REPAUDIZ       " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REPORTEAUDITORIACIERREZ                 " atributo="VERSIONALTAFW                           " tabla="REPAUDIZ       " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REPORTEAUDITORIACIERREZ                 " atributo="ESTADOTRANSFERENCIA                     " tabla="REPAUDIZ       " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado transferencia                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REPORTEAUDITORIACIERREZ                 " atributo="ZADSFW                                  " tabla="REPAUDIZ       " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REPORTEAUDITORIACIERREZ                 " atributo="CODINT                                  " tabla="REPAUDIZ       " campo="CODINT    " claveprimaria="true" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Código                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REPORTEAUDITORIACIERREZ                 " atributo="TIPOAUDITORIA                           " tabla="REPAUDIZ       " campo="TIPOAUDI  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="200" etiqueta="Tipo de auditoría                                                                                                                                               " dominio="COMBOXML                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REPORTEAUDITORIACIERREZ                 " atributo="FECHADESDE                              " tabla="REPAUDIZ       " campo="FECDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goServicios.librerias.obtenerFecha() - 15                                                                                                                                                                                                                    " obligatorio="false" admitebusqueda="201" etiqueta="Fecha desde                                                                                                                                                     " dominio="FECHACALENDARIO               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="10" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REPORTEAUDITORIACIERREZ                 " atributo="FECHAHASTA                              " tabla="REPAUDIZ       " campo="FECHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goServicios.librerias.obtenerFecha()                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="202" etiqueta="Fecha hasta                                                                                                                                                     " dominio="FECHACALENDARIO               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="15" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REPORTEAUDITORIACIERREZ                 " atributo="NUMERODESDE                             " tabla="REPAUDIZ       " campo="NRODESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="203" etiqueta="Número de cierre Z desde                                                                                                                                        " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="25" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REPORTEAUDITORIACIERREZ                 " atributo="NUMEROHASTA                             " tabla="REPAUDIZ       " campo="NROHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="204" etiqueta="Número de cierre Z hasta                                                                                                                                        " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="30" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REPORTEAUDITORIACIERREZ                 " atributo="RESUMIDA                                " tabla="REPAUDIZ       " campo="RESUMIDA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="=.F.                                                                                                                                                                                                                                                          " obligatorio="false" admitebusqueda="205" etiqueta="Resumida                                                                                                                                                        " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="40" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REPORTEAUDITORIACIERREZ                 " atributo="OBSERVACION                             " tabla="REPAUDIZ       " campo="OBS       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="206" etiqueta="Obs.                                                                                                                                                            " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="5" orden="50" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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