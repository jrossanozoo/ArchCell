
define class Din_EntidadTRATAMIENTOCOMPROBANTESAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_TRATAMIENTOCOMPROBANTES'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = [str( Numero, 8, 0)]
	cExpresionCCPorCampos = [str( #tabla#.Numero, 8, 0)]
	cTagClaveCandidata = '_TCOCC'
	cTagClavePk = '_TCOPK'
	cTablaPrincipal = 'TRATCOMP'
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
			local  lxTratcompFaltafw, lxTratcompFectrans, lxTratcompFecexpo, lxTratcompFecimpo, lxTratcompFmodifw, lxTratcompNumero, lxTratcompHoraexpo, lxTratcompHoraimpo, lxTratcompUmodifw, lxTratcompHmodifw, lxTratcompVmodifw, lxTratcompZadsfw, lxTratcompUaltafw, lxTratcompValtafw, lxTratcompSaltafw, lxTratcompSmodifw, lxTratcompBdmodifw, lxTratcompHaltafw, lxTratcompEsttrans, lxTratcompBdaltafw, lxTratcompCodint, lxTratcompTipocomp, lxTratcompAccion, lxTratcompFecha, lxTratcompHora, lxTratcompUsuario, lxTratcompSerie, lxTratcompLetdesde, lxTratcompPtodesde, lxTratcompNumdesde, lxTratcompNumhasta, lxTratcompFactsec, lxTratcompFfch, lxTratcompObs
				lxTratcompFaltafw =  .Fechaaltafw			lxTratcompFectrans =  .Fechatransferencia			lxTratcompFecexpo =  .Fechaexpo			lxTratcompFecimpo =  .Fechaimpo			lxTratcompFmodifw =  .Fechamodificacionfw			lxTratcompNumero =  .Numero			lxTratcompHoraexpo =  .Horaexpo			lxTratcompHoraimpo =  .Horaimpo			lxTratcompUmodifw =  .Usuariomodificacionfw			lxTratcompHmodifw =  .Horamodificacionfw			lxTratcompVmodifw =  .Versionmodificacionfw			lxTratcompZadsfw =  .Zadsfw			lxTratcompUaltafw =  .Usuarioaltafw			lxTratcompValtafw =  .Versionaltafw			lxTratcompSaltafw =  .Seriealtafw			lxTratcompSmodifw =  .Seriemodificacionfw			lxTratcompBdmodifw =  .Basededatosmodificacionfw			lxTratcompHaltafw =  .Horaaltafw			lxTratcompEsttrans =  .Estadotransferencia			lxTratcompBdaltafw =  .Basededatosaltafw			lxTratcompCodint =  .Codint			lxTratcompTipocomp =  .Tipocomprobante			lxTratcompAccion =  .Accion			lxTratcompFecha =  .Fecha			lxTratcompHora =  .Hora			lxTratcompUsuario =  .Usuario			lxTratcompSerie =  .Serie			lxTratcompLetdesde =  .Letra			lxTratcompPtodesde =  .Puntodeventa			lxTratcompNumdesde =  .Numerodesde			lxTratcompNumhasta =  .Numerohasta			lxTratcompFactsec =  .Secuencia			lxTratcompFfch =  .Fechacomprobante			lxTratcompObs =  .Observacion
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxTratcompCodint = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.TRATCOMP ( "Faltafw","Fectrans","Fecexpo","Fecimpo","Fmodifw","Numero","Horaexpo","Horaimpo","Umodifw","Hmodifw","Vmodifw","Zadsfw","Ualtafw","Valtafw","Saltafw","Smodifw","Bdmodifw","Haltafw","Esttrans","Bdaltafw","Codint","Tipocomp","Accion","Fecha","Hora","Usuario","Serie","Letdesde","Ptodesde","Numdesde","Numhasta","Factsec","Ffch","Obs" ) values ( <<"'" + this.ConvertirDateSql( lxTratcompFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxTratcompFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxTratcompFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxTratcompFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxTratcompFmodifw ) + "'" >>, <<lxTratcompNumero >>, <<"'" + this.FormatearTextoSql( lxTratcompHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTratcompHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTratcompUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTratcompHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTratcompVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTratcompZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTratcompUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTratcompValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTratcompSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTratcompSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTratcompBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTratcompHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTratcompEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTratcompBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTratcompCodint ) + "'" >>, <<lxTratcompTipocomp >>, <<lxTratcompAccion >>, <<"'" + this.ConvertirDateSql( lxTratcompFecha ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTratcompHora ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTratcompUsuario ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTratcompSerie ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTratcompLetdesde ) + "'" >>, <<lxTratcompPtodesde >>, <<lxTratcompNumdesde >>, <<lxTratcompNumhasta >>, <<"'" + this.FormatearTextoSql( lxTratcompFactsec ) + "'" >>, <<"'" + this.ConvertirDateSql( lxTratcompFfch ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTratcompObs ) + "'" >> )
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
			local  lxTratcompFaltafw, lxTratcompFectrans, lxTratcompFecexpo, lxTratcompFecimpo, lxTratcompFmodifw, lxTratcompNumero, lxTratcompHoraexpo, lxTratcompHoraimpo, lxTratcompUmodifw, lxTratcompHmodifw, lxTratcompVmodifw, lxTratcompZadsfw, lxTratcompUaltafw, lxTratcompValtafw, lxTratcompSaltafw, lxTratcompSmodifw, lxTratcompBdmodifw, lxTratcompHaltafw, lxTratcompEsttrans, lxTratcompBdaltafw, lxTratcompCodint, lxTratcompTipocomp, lxTratcompAccion, lxTratcompFecha, lxTratcompHora, lxTratcompUsuario, lxTratcompSerie, lxTratcompLetdesde, lxTratcompPtodesde, lxTratcompNumdesde, lxTratcompNumhasta, lxTratcompFactsec, lxTratcompFfch, lxTratcompObs
				lxTratcompFaltafw =  .Fechaaltafw			lxTratcompFectrans =  .Fechatransferencia			lxTratcompFecexpo =  .Fechaexpo			lxTratcompFecimpo =  .Fechaimpo			lxTratcompFmodifw =  .Fechamodificacionfw			lxTratcompNumero =  .Numero			lxTratcompHoraexpo =  .Horaexpo			lxTratcompHoraimpo =  .Horaimpo			lxTratcompUmodifw =  .Usuariomodificacionfw			lxTratcompHmodifw =  .Horamodificacionfw			lxTratcompVmodifw =  .Versionmodificacionfw			lxTratcompZadsfw =  .Zadsfw			lxTratcompUaltafw =  .Usuarioaltafw			lxTratcompValtafw =  .Versionaltafw			lxTratcompSaltafw =  .Seriealtafw			lxTratcompSmodifw =  .Seriemodificacionfw			lxTratcompBdmodifw =  .Basededatosmodificacionfw			lxTratcompHaltafw =  .Horaaltafw			lxTratcompEsttrans =  .Estadotransferencia			lxTratcompBdaltafw =  .Basededatosaltafw			lxTratcompCodint =  .Codint			lxTratcompTipocomp =  .Tipocomprobante			lxTratcompAccion =  .Accion			lxTratcompFecha =  .Fecha			lxTratcompHora =  .Hora			lxTratcompUsuario =  .Usuario			lxTratcompSerie =  .Serie			lxTratcompLetdesde =  .Letra			lxTratcompPtodesde =  .Puntodeventa			lxTratcompNumdesde =  .Numerodesde			lxTratcompNumhasta =  .Numerohasta			lxTratcompFactsec =  .Secuencia			lxTratcompFfch =  .Fechacomprobante			lxTratcompObs =  .Observacion
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()
			lxValorClavePrimaria = .oEntidad.CODINT
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ZooLogic.TRATCOMP set "Faltafw" = <<"'" + this.ConvertirDateSql( lxTratcompFaltafw ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxTratcompFectrans ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxTratcompFecexpo ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxTratcompFecimpo ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxTratcompFmodifw ) + "'">>,"Numero" = <<lxTratcompNumero>>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxTratcompHoraexpo ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxTratcompHoraimpo ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxTratcompUmodifw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxTratcompHmodifw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxTratcompVmodifw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxTratcompZadsfw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxTratcompUaltafw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxTratcompValtafw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxTratcompSaltafw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxTratcompSmodifw ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxTratcompBdmodifw ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxTratcompHaltafw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxTratcompEsttrans ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxTratcompBdaltafw ) + "'">>,"Codint" = <<"'" + this.FormatearTextoSql( lxTratcompCodint ) + "'">>,"Tipocomp" = <<lxTratcompTipocomp>>,"Accion" = <<lxTratcompAccion>>,"Fecha" = <<"'" + this.ConvertirDateSql( lxTratcompFecha ) + "'">>,"Hora" = <<"'" + this.FormatearTextoSql( lxTratcompHora ) + "'">>,"Usuario" = <<"'" + this.FormatearTextoSql( lxTratcompUsuario ) + "'">>,"Serie" = <<"'" + this.FormatearTextoSql( lxTratcompSerie ) + "'">>,"Letdesde" = <<"'" + this.FormatearTextoSql( lxTratcompLetdesde ) + "'">>,"Ptodesde" = <<lxTratcompPtodesde>>,"Numdesde" = <<lxTratcompNumdesde>>,"Numhasta" = <<lxTratcompNumhasta>>,"Factsec" = <<"'" + this.FormatearTextoSql( lxTratcompFactsec ) + "'">>,"Ffch" = <<"'" + this.ConvertirDateSql( lxTratcompFfch ) + "'">>,"Obs" = <<"'" + this.FormatearTextoSql( lxTratcompObs ) + "'">> where "Codint" = <<"'" + this.FormatearTextoSql( lxTratcompCodint ) + "'">> and  TRATCOMP.CODINT != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 CodInt from ZooLogic.TRATCOMP where " + this.ConvertirFuncionesSql( " TRATCOMP.CODINT != ''" ) )
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
			Local lxTratcompCodint
			lxTratcompCodint = .Codint

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Numero" as "Numero", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Umodifw" as "Usuariomodificacionfw", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Ualtafw" as "Usuarioaltafw", "Valtafw" as "Versionaltafw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Haltafw" as "Horaaltafw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Codint" as "Codint", "Tipocomp" as "Tipocomprobante", "Accion" as "Accion", "Fecha" as "Fecha", "Hora" as "Hora", "Usuario" as "Usuario", "Serie" as "Serie", "Letdesde" as "Letra", "Ptodesde" as "Puntodeventa", "Numdesde" as "Numerodesde", "Numhasta" as "Numerohasta", "Factsec" as "Secuencia", "Ffch" as "Fechacomprobante", "Obs" as "Observacion" from ZooLogic.TRATCOMP where "Codint" = <<"'" + this.FormatearTextoSql( lxTratcompCodint ) + "'">> and  TRATCOMP.CODINT != ''
			endtext
			use in select('c_TRATAMIENTOCOMPROBANTES')
			this.oConexion.EjecutarSql( lcSentencia, 'c_TRATAMIENTOCOMPROBANTES', set( 'Datasession' ) )

			if reccount( 'c_TRATAMIENTOCOMPROBANTES' ) = 0
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
			Local lxTRATCOMPNumero As Variant
			lxTRATCOMPNumero = .Numero
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Numero" as "Numero", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Umodifw" as "Usuariomodificacionfw", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Ualtafw" as "Usuarioaltafw", "Valtafw" as "Versionaltafw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Haltafw" as "Horaaltafw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Codint" as "Codint", "Tipocomp" as "Tipocomprobante", "Accion" as "Accion", "Fecha" as "Fecha", "Hora" as "Hora", "Usuario" as "Usuario", "Serie" as "Serie", "Letdesde" as "Letra", "Ptodesde" as "Puntodeventa", "Numdesde" as "Numerodesde", "Numhasta" as "Numerohasta", "Factsec" as "Secuencia", "Ffch" as "Fechacomprobante", "Obs" as "Observacion" from ZooLogic.TRATCOMP where  TRATCOMP.CODINT != '' And Numero = <<lxTRATCOMPNumero>>
			endtext
			use in select('c_TRATAMIENTOCOMPROBANTES')
			this.oConexion.EjecutarSql( lcSentencia, 'c_TRATAMIENTOCOMPROBANTES', set( 'Datasession' ) )
			if reccount( 'c_TRATAMIENTOCOMPROBANTES' ) = 0
				llRetorno = .f.
			else
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxTratcompCodint as Variant
		llRetorno = .t.
		lxTratcompCodint = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.TRATCOMP where "Codint" = <<"'" + this.FormatearTextoSql( lxTratcompCodint ) + "'">> and  TRATCOMP.CODINT != ''
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
				select top 1 "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Numero" as "Numero", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Umodifw" as "Usuariomodificacionfw", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Ualtafw" as "Usuarioaltafw", "Valtafw" as "Versionaltafw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Haltafw" as "Horaaltafw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Codint" as "Codint", "Tipocomp" as "Tipocomprobante", "Accion" as "Accion", "Fecha" as "Fecha", "Hora" as "Hora", "Usuario" as "Usuario", "Serie" as "Serie", "Letdesde" as "Letra", "Ptodesde" as "Puntodeventa", "Numdesde" as "Numerodesde", "Numhasta" as "Numerohasta", "Factsec" as "Secuencia", "Ffch" as "Fechacomprobante", "Obs" as "Observacion" from ZooLogic.TRATCOMP where  TRATCOMP.CODINT != '' order by Numero
			endtext
			use in select('c_TRATAMIENTOCOMPROBANTES')
			this.oConexion.EjecutarSql( lcSentencia, 'c_TRATAMIENTOCOMPROBANTES', set( 'Datasession' ) )
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
				select top 1 "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Numero" as "Numero", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Umodifw" as "Usuariomodificacionfw", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Ualtafw" as "Usuarioaltafw", "Valtafw" as "Versionaltafw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Haltafw" as "Horaaltafw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Codint" as "Codint", "Tipocomp" as "Tipocomprobante", "Accion" as "Accion", "Fecha" as "Fecha", "Hora" as "Hora", "Usuario" as "Usuario", "Serie" as "Serie", "Letdesde" as "Letra", "Ptodesde" as "Puntodeventa", "Numdesde" as "Numerodesde", "Numhasta" as "Numerohasta", "Factsec" as "Secuencia", "Ffch" as "Fechacomprobante", "Obs" as "Observacion" from ZooLogic.TRATCOMP where  str( Numero, 8, 0) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  TRATCOMP.CODINT != '' order by Numero
			endtext
			use in select('c_TRATAMIENTOCOMPROBANTES')
			this.oConexion.EjecutarSql( lcSentencia, 'c_TRATAMIENTOCOMPROBANTES', set( 'Datasession' ) )
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
				select top 1 "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Numero" as "Numero", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Umodifw" as "Usuariomodificacionfw", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Ualtafw" as "Usuarioaltafw", "Valtafw" as "Versionaltafw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Haltafw" as "Horaaltafw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Codint" as "Codint", "Tipocomp" as "Tipocomprobante", "Accion" as "Accion", "Fecha" as "Fecha", "Hora" as "Hora", "Usuario" as "Usuario", "Serie" as "Serie", "Letdesde" as "Letra", "Ptodesde" as "Puntodeventa", "Numdesde" as "Numerodesde", "Numhasta" as "Numerohasta", "Factsec" as "Secuencia", "Ffch" as "Fechacomprobante", "Obs" as "Observacion" from ZooLogic.TRATCOMP where  str( Numero, 8, 0) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  TRATCOMP.CODINT != '' order by Numero desc
			endtext
			use in select('c_TRATAMIENTOCOMPROBANTES')
			this.oConexion.EjecutarSql( lcSentencia, 'c_TRATAMIENTOCOMPROBANTES', set( 'Datasession' ) )
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
				select top 1 "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Numero" as "Numero", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Umodifw" as "Usuariomodificacionfw", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Ualtafw" as "Usuarioaltafw", "Valtafw" as "Versionaltafw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Haltafw" as "Horaaltafw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Codint" as "Codint", "Tipocomp" as "Tipocomprobante", "Accion" as "Accion", "Fecha" as "Fecha", "Hora" as "Hora", "Usuario" as "Usuario", "Serie" as "Serie", "Letdesde" as "Letra", "Ptodesde" as "Puntodeventa", "Numdesde" as "Numerodesde", "Numhasta" as "Numerohasta", "Factsec" as "Secuencia", "Ffch" as "Fechacomprobante", "Obs" as "Observacion" from ZooLogic.TRATCOMP where  TRATCOMP.CODINT != '' order by Numero desc
			endtext
			use in select('c_TRATAMIENTOCOMPROBANTES')
			this.oConexion.EjecutarSql( lcSentencia, 'c_TRATAMIENTOCOMPROBANTES', set( 'Datasession' ) )
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
			lcXml = this.oConexion.EjecutarSql( "select Faltafw,Fectrans,Fecexpo,Fecimpo,Fmodifw,Numero,Horaexpo,Horaimpo,Umodifw,Hmodifw,Vmodifw,Za" + ;
"dsfw,Ualtafw,Valtafw,Saltafw,Smodifw,Bdmodifw,Haltafw,Esttrans,Bdaltafw,Codint,Tipocomp,Accion,Fecha" + ;
",Hora,Usuario,Serie,Letdesde,Ptodesde,Numdesde,Numhasta,Factsec,Ffch,Obs" + ;
" from ZooLogic.TRATCOMP where  TRATCOMP.CODINT != '' and " + lcFiltro )
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
			local  lxTratcompFaltafw, lxTratcompFectrans, lxTratcompFecexpo, lxTratcompFecimpo, lxTratcompFmodifw, lxTratcompNumero, lxTratcompHoraexpo, lxTratcompHoraimpo, lxTratcompUmodifw, lxTratcompHmodifw, lxTratcompVmodifw, lxTratcompZadsfw, lxTratcompUaltafw, lxTratcompValtafw, lxTratcompSaltafw, lxTratcompSmodifw, lxTratcompBdmodifw, lxTratcompHaltafw, lxTratcompEsttrans, lxTratcompBdaltafw, lxTratcompCodint, lxTratcompTipocomp, lxTratcompAccion, lxTratcompFecha, lxTratcompHora, lxTratcompUsuario, lxTratcompSerie, lxTratcompLetdesde, lxTratcompPtodesde, lxTratcompNumdesde, lxTratcompNumhasta, lxTratcompFactsec, lxTratcompFfch, lxTratcompObs
				lxTratcompFaltafw = ctod( '  /  /    ' )			lxTratcompFectrans = ctod( '  /  /    ' )			lxTratcompFecexpo = ctod( '  /  /    ' )			lxTratcompFecimpo = ctod( '  /  /    ' )			lxTratcompFmodifw = ctod( '  /  /    ' )			lxTratcompNumero = 0			lxTratcompHoraexpo = []			lxTratcompHoraimpo = []			lxTratcompUmodifw = []			lxTratcompHmodifw = []			lxTratcompVmodifw = []			lxTratcompZadsfw = []			lxTratcompUaltafw = []			lxTratcompValtafw = []			lxTratcompSaltafw = []			lxTratcompSmodifw = []			lxTratcompBdmodifw = []			lxTratcompHaltafw = []			lxTratcompEsttrans = []			lxTratcompBdaltafw = []			lxTratcompCodint = []			lxTratcompTipocomp = 0			lxTratcompAccion = 0			lxTratcompFecha = ctod( '  /  /    ' )			lxTratcompHora = []			lxTratcompUsuario = []			lxTratcompSerie = []			lxTratcompLetdesde = []			lxTratcompPtodesde = 0			lxTratcompNumdesde = 0			lxTratcompNumhasta = 0			lxTratcompFactsec = []			lxTratcompFfch = ctod( '  /  /    ' )			lxTratcompObs = []
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( [delete from ZooLogic.TRATCOMP where "CodInt" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODINT ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'TRATCOMP' + '_' + tcCampo
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
		lcWhere = " Where  TRATCOMP.CODINT != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Numero" as "Numero", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Umodifw" as "Usuariomodificacionfw", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Ualtafw" as "Usuarioaltafw", "Valtafw" as "Versionaltafw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Haltafw" as "Horaaltafw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Codint" as "Codint", "Tipocomp" as "Tipocomprobante", "Accion" as "Accion", "Fecha" as "Fecha", "Hora" as "Hora", "Usuario" as "Usuario", "Serie" as "Serie", "Letdesde" as "Letra", "Ptodesde" as "Puntodeventa", "Numdesde" as "Numerodesde", "Numhasta" as "Numerohasta", "Factsec" as "Secuencia", "Ffch" as "Fechacomprobante", "Obs" as "Observacion"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'TRATCOMP', '', tnTope )
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
				Case lcAtributo == 'FECHATRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRANS AS FECHATRANSFERENCIA'
				Case lcAtributo == 'FECHAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECEXPO AS FECHAEXPO'
				Case lcAtributo == 'FECHAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECIMPO AS FECHAIMPO'
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'NUMERO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NUMERO AS NUMERO'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'CODINT'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODINT AS CODINT'
				Case lcAtributo == 'TIPOCOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPOCOMP AS TIPOCOMPROBANTE'
				Case lcAtributo == 'ACCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ACCION AS ACCION'
				Case lcAtributo == 'FECHA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHA AS FECHA'
				Case lcAtributo == 'HORA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORA AS HORA'
				Case lcAtributo == 'USUARIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'USUARIO AS USUARIO'
				Case lcAtributo == 'SERIE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SERIE AS SERIE'
				Case lcAtributo == 'LETRA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LETDESDE AS LETRA'
				Case lcAtributo == 'PUNTODEVENTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PTODESDE AS PUNTODEVENTA'
				Case lcAtributo == 'NUMERODESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NUMDESDE AS NUMERODESDE'
				Case lcAtributo == 'NUMEROHASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NUMHASTA AS NUMEROHASTA'
				Case lcAtributo == 'SECUENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FACTSEC AS SECUENCIA'
				Case lcAtributo == 'FECHACOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FFCH AS FECHACOMPROBANTE'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEXPO'
				lcCampo = 'FECEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAIMPO'
				lcCampo = 'FECIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'NUMERO'
				lcCampo = 'NUMERO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'CODINT'
				lcCampo = 'CODINT'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOCOMPROBANTE'
				lcCampo = 'TIPOCOMP'
			Case upper( alltrim( tcAtributo ) ) == 'ACCION'
				lcCampo = 'ACCION'
			Case upper( alltrim( tcAtributo ) ) == 'FECHA'
				lcCampo = 'FECHA'
			Case upper( alltrim( tcAtributo ) ) == 'HORA'
				lcCampo = 'HORA'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIO'
				lcCampo = 'USUARIO'
			Case upper( alltrim( tcAtributo ) ) == 'SERIE'
				lcCampo = 'SERIE'
			Case upper( alltrim( tcAtributo ) ) == 'LETRA'
				lcCampo = 'LETDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'PUNTODEVENTA'
				lcCampo = 'PTODESDE'
			Case upper( alltrim( tcAtributo ) ) == 'NUMERODESDE'
				lcCampo = 'NUMDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'NUMEROHASTA'
				lcCampo = 'NUMHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'SECUENCIA'
				lcCampo = 'FACTSEC'
			Case upper( alltrim( tcAtributo ) ) == 'FECHACOMPROBANTE'
				lcCampo = 'FFCH'
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
			local  lxTratcompFaltafw, lxTratcompFectrans, lxTratcompFecexpo, lxTratcompFecimpo, lxTratcompFmodifw, lxTratcompNumero, lxTratcompHoraexpo, lxTratcompHoraimpo, lxTratcompUmodifw, lxTratcompHmodifw, lxTratcompVmodifw, lxTratcompZadsfw, lxTratcompUaltafw, lxTratcompValtafw, lxTratcompSaltafw, lxTratcompSmodifw, lxTratcompBdmodifw, lxTratcompHaltafw, lxTratcompEsttrans, lxTratcompBdaltafw, lxTratcompCodint, lxTratcompTipocomp, lxTratcompAccion, lxTratcompFecha, lxTratcompHora, lxTratcompUsuario, lxTratcompSerie, lxTratcompLetdesde, lxTratcompPtodesde, lxTratcompNumdesde, lxTratcompNumhasta, lxTratcompFactsec, lxTratcompFfch, lxTratcompObs
				lxTratcompFaltafw =  .Fechaaltafw			lxTratcompFectrans =  .Fechatransferencia			lxTratcompFecexpo =  .Fechaexpo			lxTratcompFecimpo =  .Fechaimpo			lxTratcompFmodifw =  .Fechamodificacionfw			lxTratcompNumero =  .Numero			lxTratcompHoraexpo =  .Horaexpo			lxTratcompHoraimpo =  .Horaimpo			lxTratcompUmodifw =  .Usuariomodificacionfw			lxTratcompHmodifw =  .Horamodificacionfw			lxTratcompVmodifw =  .Versionmodificacionfw			lxTratcompZadsfw =  .Zadsfw			lxTratcompUaltafw =  .Usuarioaltafw			lxTratcompValtafw =  .Versionaltafw			lxTratcompSaltafw =  .Seriealtafw			lxTratcompSmodifw =  .Seriemodificacionfw			lxTratcompBdmodifw =  .Basededatosmodificacionfw			lxTratcompHaltafw =  .Horaaltafw			lxTratcompEsttrans =  .Estadotransferencia			lxTratcompBdaltafw =  .Basededatosaltafw			lxTratcompCodint =  .Codint			lxTratcompTipocomp =  .Tipocomprobante			lxTratcompAccion =  .Accion			lxTratcompFecha =  .Fecha			lxTratcompHora =  .Hora			lxTratcompUsuario =  .Usuario			lxTratcompSerie =  .Serie			lxTratcompLetdesde =  .Letra			lxTratcompPtodesde =  .Puntodeventa			lxTratcompNumdesde =  .Numerodesde			lxTratcompNumhasta =  .Numerohasta			lxTratcompFactsec =  .Secuencia			lxTratcompFfch =  .Fechacomprobante			lxTratcompObs =  .Observacion
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.TRATCOMP ( "Faltafw","Fectrans","Fecexpo","Fecimpo","Fmodifw","Numero","Horaexpo","Horaimpo","Umodifw","Hmodifw","Vmodifw","Zadsfw","Ualtafw","Valtafw","Saltafw","Smodifw","Bdmodifw","Haltafw","Esttrans","Bdaltafw","Codint","Tipocomp","Accion","Fecha","Hora","Usuario","Serie","Letdesde","Ptodesde","Numdesde","Numhasta","Factsec","Ffch","Obs" ) values ( <<"'" + this.ConvertirDateSql( lxTratcompFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxTratcompFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxTratcompFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxTratcompFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxTratcompFmodifw ) + "'" >>, <<lxTratcompNumero >>, <<"'" + this.FormatearTextoSql( lxTratcompHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTratcompHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTratcompUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTratcompHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTratcompVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTratcompZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTratcompUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTratcompValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTratcompSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTratcompSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTratcompBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTratcompHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTratcompEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTratcompBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTratcompCodint ) + "'" >>, <<lxTratcompTipocomp >>, <<lxTratcompAccion >>, <<"'" + this.ConvertirDateSql( lxTratcompFecha ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTratcompHora ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTratcompUsuario ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTratcompSerie ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTratcompLetdesde ) + "'" >>, <<lxTratcompPtodesde >>, <<lxTratcompNumdesde >>, <<lxTratcompNumhasta >>, <<"'" + this.FormatearTextoSql( lxTratcompFactsec ) + "'" >>, <<"'" + this.ConvertirDateSql( lxTratcompFfch ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTratcompObs ) + "'" >> )
		endtext
		loColeccion.cTabla = 'TRATCOMP' 
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
			local  lxTratcompFaltafw, lxTratcompFectrans, lxTratcompFecexpo, lxTratcompFecimpo, lxTratcompFmodifw, lxTratcompNumero, lxTratcompHoraexpo, lxTratcompHoraimpo, lxTratcompUmodifw, lxTratcompHmodifw, lxTratcompVmodifw, lxTratcompZadsfw, lxTratcompUaltafw, lxTratcompValtafw, lxTratcompSaltafw, lxTratcompSmodifw, lxTratcompBdmodifw, lxTratcompHaltafw, lxTratcompEsttrans, lxTratcompBdaltafw, lxTratcompCodint, lxTratcompTipocomp, lxTratcompAccion, lxTratcompFecha, lxTratcompHora, lxTratcompUsuario, lxTratcompSerie, lxTratcompLetdesde, lxTratcompPtodesde, lxTratcompNumdesde, lxTratcompNumhasta, lxTratcompFactsec, lxTratcompFfch, lxTratcompObs
				lxTratcompFaltafw =  .Fechaaltafw			lxTratcompFectrans =  .Fechatransferencia			lxTratcompFecexpo =  .Fechaexpo			lxTratcompFecimpo =  .Fechaimpo			lxTratcompFmodifw =  .Fechamodificacionfw			lxTratcompNumero =  .Numero			lxTratcompHoraexpo =  .Horaexpo			lxTratcompHoraimpo =  .Horaimpo			lxTratcompUmodifw =  .Usuariomodificacionfw			lxTratcompHmodifw =  .Horamodificacionfw			lxTratcompVmodifw =  .Versionmodificacionfw			lxTratcompZadsfw =  .Zadsfw			lxTratcompUaltafw =  .Usuarioaltafw			lxTratcompValtafw =  .Versionaltafw			lxTratcompSaltafw =  .Seriealtafw			lxTratcompSmodifw =  .Seriemodificacionfw			lxTratcompBdmodifw =  .Basededatosmodificacionfw			lxTratcompHaltafw =  .Horaaltafw			lxTratcompEsttrans =  .Estadotransferencia			lxTratcompBdaltafw =  .Basededatosaltafw			lxTratcompCodint =  .Codint			lxTratcompTipocomp =  .Tipocomprobante			lxTratcompAccion =  .Accion			lxTratcompFecha =  .Fecha			lxTratcompHora =  .Hora			lxTratcompUsuario =  .Usuario			lxTratcompSerie =  .Serie			lxTratcompLetdesde =  .Letra			lxTratcompPtodesde =  .Puntodeventa			lxTratcompNumdesde =  .Numerodesde			lxTratcompNumhasta =  .Numerohasta			lxTratcompFactsec =  .Secuencia			lxTratcompFfch =  .Fechacomprobante			lxTratcompObs =  .Observacion
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODINT
			lcValorClavePrimariaString = "'" + this.oEntidad.CODINT + "'"

			lcFiltro = ["Codint" = ] + lcValorClavePrimariaString  + [ and  TRATCOMP.CODINT != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.TRATCOMP set "Faltafw" = <<"'" + this.ConvertirDateSql( lxTratcompFaltafw ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxTratcompFectrans ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxTratcompFecexpo ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxTratcompFecimpo ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxTratcompFmodifw ) + "'">>, "Numero" = <<lxTratcompNumero>>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxTratcompHoraexpo ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxTratcompHoraimpo ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxTratcompUmodifw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxTratcompHmodifw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxTratcompVmodifw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxTratcompZadsfw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxTratcompUaltafw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxTratcompValtafw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxTratcompSaltafw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxTratcompSmodifw ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxTratcompBdmodifw ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxTratcompHaltafw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxTratcompEsttrans ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxTratcompBdaltafw ) + "'">>, "Codint" = <<"'" + this.FormatearTextoSql( lxTratcompCodint ) + "'">>, "Tipocomp" = <<lxTratcompTipocomp>>, "Accion" = <<lxTratcompAccion>>, "Fecha" = <<"'" + this.ConvertirDateSql( lxTratcompFecha ) + "'">>, "Hora" = <<"'" + this.FormatearTextoSql( lxTratcompHora ) + "'">>, "Usuario" = <<"'" + this.FormatearTextoSql( lxTratcompUsuario ) + "'">>, "Serie" = <<"'" + this.FormatearTextoSql( lxTratcompSerie ) + "'">>, "Letdesde" = <<"'" + this.FormatearTextoSql( lxTratcompLetdesde ) + "'">>, "Ptodesde" = <<lxTratcompPtodesde>>, "Numdesde" = <<lxTratcompNumdesde>>, "Numhasta" = <<lxTratcompNumhasta>>, "Factsec" = <<"'" + this.FormatearTextoSql( lxTratcompFactsec ) + "'">>, "Ffch" = <<"'" + this.ConvertirDateSql( lxTratcompFfch ) + "'">>, "Obs" = <<"'" + this.FormatearTextoSql( lxTratcompObs ) + "'">> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'TRATCOMP' 
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

			lcFiltro = ["Codint" = ] + lcValorClavePrimariaString  + [ and  TRATCOMP.CODINT != '']
		loColeccion.Agregar( 'delete from ZooLogic.TRATCOMP where ' + lcFiltro )
			loColeccion.cTabla = 'TRATCOMP' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.TRATCOMP where  TRATCOMP.CODINT != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.TRATCOMP where CodInt = " + "'" + this.FormatearTextoSql( this.oEntidad.CODINT ) + "'"+ " and  TRATCOMP.CODINT != ''" )
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
		local lcCursor as String, ldFecha as Date, lcHora as string, lcValorABuscar As String, lxValorClavePK As variant, lxValorClavePrimaria As variant, lcIdentificadorParaLoguear as string, lxTRATCOMPNumero as variant, lcMensajeExtra as String
		lcValorABuscar = ''
		lxValorClavePK = ''
		lcMensajeExtra = ''
		lcCursor = This.oEntidad.cPrefijoRecibir + 'TRATAMIENTOCOMPROBANTES'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.TRATCOMP Where  Numero = ] + transform( &lcCursor..Numero     ), 'curSeek', this.datasessionid )
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
						this.oConexion.EjecutarSql( [UPDATE ZooLogic.TRATCOMP set  FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, Numero = ] + transform( &lcCursor..Numero )+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, CodInt = ] + "'" + this.FormatearTextoSql( &lcCursor..CodInt ) + "'"+ [, TipoComp = ] + transform( &lcCursor..TipoComp )+ [, Accion = ] + transform( &lcCursor..Accion )+ [, fecha = ] + "'" + this.ConvertirDateSql( &lcCursor..fecha ) + "'"+ [, hora = ] + "'" + this.FormatearTextoSql( &lcCursor..hora ) + "'"+ [, Usuario = ] + "'" + this.FormatearTextoSql( &lcCursor..Usuario ) + "'"+ [, serie = ] + "'" + this.FormatearTextoSql( &lcCursor..serie ) + "'"+ [, LetDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..LetDesde ) + "'"+ [, PtoDesde = ] + transform( &lcCursor..PtoDesde )+ [, NumDesde = ] + transform( &lcCursor..NumDesde )+ [, NumHasta = ] + transform( &lcCursor..NumHasta )+ [, factsec = ] + "'" + this.FormatearTextoSql( &lcCursor..factsec ) + "'"+ [, ffch = ] + "'" + this.ConvertirDateSql( &lcCursor..ffch ) + "'"+ [, Obs = ] + "'" + this.FormatearTextoSql( &lcCursor..Obs ) + "'" + [ Where CodInt = ] + "'" + this.FormatearTextoSql( lcValorABuscar ) + "'" )
						this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
					else
						this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
					endIf
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir porque no coincide la clave principal.', tlLoguear )
				endIf
			else
				this.oConexion.EjecutarSql( [Select * From ZooLogic.TRATCOMP Where CodInt = ] + "'" + this.FormatearTextoSql( &lcCursor..CodInt ) + "'", 'curSeek', this.datasessionid )
				if reccount( 'curSeek' ) > 0
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir como alta porque la clave principal ya existe', tlLoguear )
				Else
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					Text to lcCampos noShow
						 FALTAFW, FECTRANS, FECEXPO, FECIMPO, FMODIFW, Numero, HORAEXPO, HORAIMPO, UMODIFW, HMODIFW, VMODIFW, ZADSFW, UALTAFW, VALTAFW, SALTAFW, SMODIFW, BDMODIFW, HALTAFW, ESTTRANS, BDALTAFW, CodInt, TipoComp, Accion, fecha, hora, Usuario, serie, LetDesde, PtoDesde, NumDesde, NumHasta, factsec, ffch, Obs
					EndText
					local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + transform( &lcCursor..Numero ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CodInt ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..TipoComp ) + ',' + transform( &lcCursor..Accion ) + ',' + "'" + this.ConvertirDateSql( &lcCursor..fecha ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..hora ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Usuario ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..serie ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..LetDesde ) + "'" + ',' + transform( &lcCursor..PtoDesde )
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..NumDesde ) + ',' + transform( &lcCursor..NumHasta ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..factsec ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..ffch ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Obs ) + "'"
lcValoresCampos = substr(lcValoresCampos,2) 

					this.oConexion.EjecutarSql( [Insert into ZooLogic.TRATCOMP ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
				EndIf
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'TRATAMIENTOCOMPROBANTES'
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
			Case  lcAlias == lcPrefijo + 'TRATAMIENTOCOMPROBANTES'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'TRATAMIENTOCOMPROBANTES_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'TRATAMIENTOCOMPROBANTES_OBS'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_TRATCOMP')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'TRATAMIENTOCOMPROBANTES'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..CodInt
		llCondicion = isnull( lxVar ) or isnull( &lcCursor..Numero )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad TRATAMIENTOCOMPROBANTES. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'TRATAMIENTOCOMPROBANTES'
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
			lcCursor = This.oEntidad.cPrefijoRecibir + 'TRATAMIENTOCOMPROBANTES'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  fecha     
		* Validar ANTERIORES A 1/1/1753  ffch      
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_TRATCOMP') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_TRATCOMP
Create Table ZooLogic.TablaTrabajo_TRATCOMP ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"faltafw" datetime  null, 
"fectrans" datetime  null, 
"fecexpo" datetime  null, 
"fecimpo" datetime  null, 
"fmodifw" datetime  null, 
"numero" numeric( 8, 0 )  null, 
"horaexpo" char( 8 )  null, 
"horaimpo" char( 8 )  null, 
"umodifw" char( 100 )  null, 
"hmodifw" char( 8 )  null, 
"vmodifw" char( 13 )  null, 
"zadsfw" varchar(max)  null, 
"ualtafw" char( 100 )  null, 
"valtafw" char( 13 )  null, 
"saltafw" char( 7 )  null, 
"smodifw" char( 7 )  null, 
"bdmodifw" char( 8 )  null, 
"haltafw" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"bdaltafw" char( 8 )  null, 
"codint" char( 38 )  null, 
"tipocomp" numeric( 2, 0 )  null, 
"accion" numeric( 2, 0 )  null, 
"fecha" datetime  null, 
"hora" char( 8 )  null, 
"usuario" char( 100 )  null, 
"serie" char( 7 )  null, 
"letdesde" char( 1 )  null, 
"ptodesde" numeric( 4, 0 )  null, 
"numdesde" numeric( 8, 0 )  null, 
"numhasta" numeric( 8, 0 )  null, 
"factsec" char( 2 )  null, 
"ffch" datetime  null, 
"obs" varchar(max)  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_TRATCOMP' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_TRATCOMP' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'TRATAMIENTOCOMPROBANTES'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		with loManejador
			if this.oEntidad.VerificarContexto( 'CB' )
			else
				.AgregarMapeo('Nrolinea','Nrolinea')
			endif
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('numero','numero')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('codint','codint')
			.AgregarMapeo('tipocomp','tipocomp')
			.AgregarMapeo('accion','accion')
			.AgregarMapeo('fecha','fecha')
			.AgregarMapeo('hora','hora')
			.AgregarMapeo('usuario','usuario')
			.AgregarMapeo('serie','serie')
			.AgregarMapeo('letdesde','letdesde')
			.AgregarMapeo('ptodesde','ptodesde')
			.AgregarMapeo('numdesde','numdesde')
			.AgregarMapeo('numhasta','numhasta')
			.AgregarMapeo('factsec','factsec')
			.AgregarMapeo('ffch','ffch')
			.AgregarMapeo('obs','obs')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_TRATCOMP'
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
				Update t Set t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.NUMERO = isnull( d.NUMERO, t.NUMERO ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.CODINT = isnull( d.CODINT, t.CODINT ),t.TIPOCOMP = isnull( d.TIPOCOMP, t.TIPOCOMP ),t.ACCION = isnull( d.ACCION, t.ACCION ),t.FECHA = isnull( d.FECHA, t.FECHA ),t.HORA = isnull( d.HORA, t.HORA ),t.USUARIO = isnull( d.USUARIO, t.USUARIO ),t.SERIE = isnull( d.SERIE, t.SERIE ),t.LETDESDE = isnull( d.LETDESDE, t.LETDESDE ),t.PTODESDE = isnull( d.PTODESDE, t.PTODESDE ),t.NUMDESDE = isnull( d.NUMDESDE, t.NUMDESDE ),t.NUMHASTA = isnull( d.NUMHASTA, t.NUMHASTA ),t.FACTSEC = isnull( d.FACTSEC, t.FACTSEC ),t.FFCH = isnull( d.FFCH, t.FFCH ),t.OBS = isnull( d.OBS, t.OBS )
					from ZooLogic.TRATCOMP t inner join deleted d 
							 on t.CodInt = d.CodInt
							 and  t.Numero = d.Numero
				-- Fin Updates
				insert into ZooLogic.TRATCOMP(Faltafw,Fectrans,Fecexpo,Fecimpo,Fmodifw,Numero,Horaexpo,Horaimpo,Umodifw,Hmodifw,Vmodifw,Zadsfw,Ualtafw,Valtafw,Saltafw,Smodifw,Bdmodifw,Haltafw,Esttrans,Bdaltafw,Codint,Tipocomp,Accion,Fecha,Hora,Usuario,Serie,Letdesde,Ptodesde,Numdesde,Numhasta,Factsec,Ffch,Obs)
					Select CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FECTRANS,''),isnull( d.FECEXPO,''),isnull( d.FECIMPO,''),isnull( d.FMODIFW,''),isnull( d.NUMERO,0),isnull( d.HORAEXPO,''),isnull( d.HORAIMPO,''),isnull( d.UMODIFW,''),isnull( d.HMODIFW,''),isnull( d.VMODIFW,''),isnull( d.ZADSFW,''),isnull( d.UALTAFW,''),isnull( d.VALTAFW,''),isnull( d.SALTAFW,''),isnull( d.SMODIFW,''),isnull( d.BDMODIFW,''),convert( char(8), getdate(), 108 ),isnull( d.ESTTRANS,''),isnull( d.BDALTAFW,''),isnull( d.CODINT,''),isnull( d.TIPOCOMP,0),isnull( d.ACCION,0),isnull( d.FECHA,''),isnull( d.HORA,''),isnull( d.USUARIO,''),isnull( d.SERIE,''),isnull( d.LETDESDE,''),isnull( d.PTODESDE,0),isnull( d.NUMDESDE,0),isnull( d.NUMHASTA,0),isnull( d.FACTSEC,''),isnull( d.FFCH,''),isnull( d.OBS,'')
						From deleted d left join ZooLogic.TRATCOMP pk 
							 on d.CodInt = pk.CodInt
						 left join ZooLogic.TRATCOMP cc 
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
					from ZooLogic.TRATCOMP t inner join deleted d 
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
					from ZooLogic.TRATCOMP t inner join deleted d 
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_TRATCOMP') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_TRATCOMP
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_TRATAMIENTOCOMPROBANTES' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_TRATAMIENTOCOMPROBANTES.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_TRATAMIENTOCOMPROBANTES.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_TRATAMIENTOCOMPROBANTES.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_TRATAMIENTOCOMPROBANTES.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_TRATAMIENTOCOMPROBANTES.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Numero = nvl( c_TRATAMIENTOCOMPROBANTES.Numero, 0 )
					.Horaexpo = nvl( c_TRATAMIENTOCOMPROBANTES.Horaexpo, [] )
					.Horaimpo = nvl( c_TRATAMIENTOCOMPROBANTES.Horaimpo, [] )
					.Usuariomodificacionfw = nvl( c_TRATAMIENTOCOMPROBANTES.Usuariomodificacionfw, [] )
					.Horamodificacionfw = nvl( c_TRATAMIENTOCOMPROBANTES.Horamodificacionfw, [] )
					.Versionmodificacionfw = nvl( c_TRATAMIENTOCOMPROBANTES.Versionmodificacionfw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Usuarioaltafw = nvl( c_TRATAMIENTOCOMPROBANTES.Usuarioaltafw, [] )
					.Versionaltafw = nvl( c_TRATAMIENTOCOMPROBANTES.Versionaltafw, [] )
					.Seriealtafw = nvl( c_TRATAMIENTOCOMPROBANTES.Seriealtafw, [] )
					.Seriemodificacionfw = nvl( c_TRATAMIENTOCOMPROBANTES.Seriemodificacionfw, [] )
					.Basededatosmodificacionfw = nvl( c_TRATAMIENTOCOMPROBANTES.Basededatosmodificacionfw, [] )
					.Horaaltafw = nvl( c_TRATAMIENTOCOMPROBANTES.Horaaltafw, [] )
					.Estadotransferencia = nvl( c_TRATAMIENTOCOMPROBANTES.Estadotransferencia, [] )
					.Basededatosaltafw = nvl( c_TRATAMIENTOCOMPROBANTES.Basededatosaltafw, [] )
					.Codint = nvl( c_TRATAMIENTOCOMPROBANTES.Codint, [] )
					.Tipocomprobante = nvl( c_TRATAMIENTOCOMPROBANTES.Tipocomprobante, 0 )
					.Accion = nvl( c_TRATAMIENTOCOMPROBANTES.Accion, 0 )
					.Fecha = GoLibrerias.ObtenerFechaFormateada( nvl( c_TRATAMIENTOCOMPROBANTES.Fecha, ctod( '  /  /    ' ) ) )
					.Hora = nvl( c_TRATAMIENTOCOMPROBANTES.Hora, [] )
					.Usuario = nvl( c_TRATAMIENTOCOMPROBANTES.Usuario, [] )
					.Serie = nvl( c_TRATAMIENTOCOMPROBANTES.Serie, [] )
					.Letra = nvl( c_TRATAMIENTOCOMPROBANTES.Letra, [] )
					.Puntodeventa = nvl( c_TRATAMIENTOCOMPROBANTES.Puntodeventa, 0 )
					.Numerodesde = nvl( c_TRATAMIENTOCOMPROBANTES.Numerodesde, 0 )
					.Numerohasta = nvl( c_TRATAMIENTOCOMPROBANTES.Numerohasta, 0 )
					.Secuencia = nvl( c_TRATAMIENTOCOMPROBANTES.Secuencia, [] )
					.Fechacomprobante = GoLibrerias.ObtenerFechaFormateada( nvl( c_TRATAMIENTOCOMPROBANTES.Fechacomprobante, ctod( '  /  /    ' ) ) )
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
			lxRetorno = c_TRATAMIENTOCOMPROBANTES.CODINT
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
		return c_TRATAMIENTOCOMPROBANTES.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.TRATCOMP' )
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
								from ZooLogic.TRATCOMP 
								Where   TRATCOMP.CODINT != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "TRATCOMP", "", lcCursor, set("Datasession") )
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
			"Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Numero" as "Numero", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Umodifw" as "Usuariomodificacionfw", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Ualtafw" as "Usuarioaltafw", "Valtafw" as "Versionaltafw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Haltafw" as "Horaaltafw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Codint" as "Codint", "Tipocomp" as "Tipocomprobante", "Accion" as "Accion", "Fecha" as "Fecha", "Hora" as "Hora", "Usuario" as "Usuario", "Serie" as "Serie", "Letdesde" as "Letra", "Ptodesde" as "Puntodeventa", "Numdesde" as "Numerodesde", "Numhasta" as "Numerohasta", "Factsec" as "Secuencia", "Ffch" as "Fechacomprobante", "Obs" as "Observacion"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.TRATCOMP 
								Where   TRATCOMP.CODINT != ''
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
	Tabla = 'TRATCOMP'
	Filtro = " TRATCOMP.CODINT != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " TRATCOMP.CODINT != ''"
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
	<row entidad="TRATAMIENTOCOMPROBANTES                 " atributo="FECHAALTAFW                             " tabla="TRATCOMP       " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRATAMIENTOCOMPROBANTES                 " atributo="FECHATRANSFERENCIA                      " tabla="TRATCOMP       " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha transferencia                                                                                                                                             " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRATAMIENTOCOMPROBANTES                 " atributo="FECHAEXPO                               " tabla="TRATCOMP       " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRATAMIENTOCOMPROBANTES                 " atributo="FECHAIMPO                               " tabla="TRATCOMP       " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRATAMIENTOCOMPROBANTES                 " atributo="FECHAMODIFICACIONFW                     " tabla="TRATCOMP       " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRATAMIENTOCOMPROBANTES                 " atributo="NUMERO                                  " tabla="TRATCOMP       " campo="NUMERO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="1" etiqueta="Número                                                                                                                                                          " dominio="CLAVECANDIDATA                " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="1" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRATAMIENTOCOMPROBANTES                 " atributo="HORAEXPO                                " tabla="TRATCOMP       " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRATAMIENTOCOMPROBANTES                 " atributo="HORAIMPO                                " tabla="TRATCOMP       " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRATAMIENTOCOMPROBANTES                 " atributo="USUARIOMODIFICACIONFW                   " tabla="TRATCOMP       " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRATAMIENTOCOMPROBANTES                 " atributo="HORAMODIFICACIONFW                      " tabla="TRATCOMP       " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRATAMIENTOCOMPROBANTES                 " atributo="VERSIONMODIFICACIONFW                   " tabla="TRATCOMP       " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRATAMIENTOCOMPROBANTES                 " atributo="ZADSFW                                  " tabla="TRATCOMP       " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRATAMIENTOCOMPROBANTES                 " atributo="USUARIOALTAFW                           " tabla="TRATCOMP       " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRATAMIENTOCOMPROBANTES                 " atributo="VERSIONALTAFW                           " tabla="TRATCOMP       " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRATAMIENTOCOMPROBANTES                 " atributo="SERIEALTAFW                             " tabla="TRATCOMP       " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRATAMIENTOCOMPROBANTES                 " atributo="SERIEMODIFICACIONFW                     " tabla="TRATCOMP       " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRATAMIENTOCOMPROBANTES                 " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="TRATCOMP       " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRATAMIENTOCOMPROBANTES                 " atributo="HORAALTAFW                              " tabla="TRATCOMP       " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRATAMIENTOCOMPROBANTES                 " atributo="ESTADOTRANSFERENCIA                     " tabla="TRATCOMP       " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado transferencia                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRATAMIENTOCOMPROBANTES                 " atributo="BASEDEDATOSALTAFW                       " tabla="TRATCOMP       " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRATAMIENTOCOMPROBANTES                 " atributo="CODINT                                  " tabla="TRATCOMP       " campo="CODINT    " claveprimaria="true" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Código                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRATAMIENTOCOMPROBANTES                 " atributo="TIPOCOMPROBANTE                         " tabla="TRATCOMP       " campo="TIPOCOMP  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="2" etiqueta="Tipo de comprobante                                                                                                                                             " dominio="TIPOCOMPROBANTEVENTASFISCAL   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRATAMIENTOCOMPROBANTES                 " atributo="ACCION                                  " tabla="TRATCOMP       " campo="ACCION    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="1                                                                                                                                                                                                                                                             " obligatorio="true" admitebusqueda="3" etiqueta="Acción                                                                                                                                                          " dominio="COMBOXML                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRATAMIENTOCOMPROBANTES                 " atributo="FECHA                                   " tabla="TRATCOMP       " campo="FECHA     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goServicios.Librerias.ObtenerFecha()                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="200" etiqueta="Fecha                                                                                                                                                           " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="4" orden="11" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRATAMIENTOCOMPROBANTES                 " atributo="HORA                                    " tabla="TRATCOMP       " campo="HORA      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="=goServicios.Librerias.ObtenerHora()                                                                                                                                                                                                                          " obligatorio="false" admitebusqueda="201" etiqueta="Hora                                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="4" orden="12" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRATAMIENTOCOMPROBANTES                 " atributo="USUARIO                                 " tabla="TRATCOMP       " campo="USUARIO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="=goServicios.Seguridad.cUsuarioLogueado                                                                                                                                                                                                                       " obligatorio="false" admitebusqueda="202" etiqueta="Usuario                                                                                                                                                         " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="4" orden="15" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRATAMIENTOCOMPROBANTES                 " atributo="SERIE                                   " tabla="TRATCOMP       " campo="SERIE     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="=_Screen.Zoo.App.cSerie                                                                                                                                                                                                                                       " obligatorio="false" admitebusqueda="203" etiqueta="Serie                                                                                                                                                           " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="4" orden="17" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRATAMIENTOCOMPROBANTES                 " atributo="LETRA                                   " tabla="TRATCOMP       " campo="LETDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="204" etiqueta="Letra                                                                                                                                                           " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="20" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRATAMIENTOCOMPROBANTES                 " atributo="PUNTODEVENTA                            " tabla="TRATCOMP       " campo="PTODESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="4" decimales="0" valorsugerido="=goParametros.Felino.ControladoresFiscales.PuntoDeVenta                                                                                                                                                                                                       " obligatorio="true" admitebusqueda="205" etiqueta="Punto de venta                                                                                                                                                  " dominio="NUMERICONONEGATIVO            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="21" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRATAMIENTOCOMPROBANTES                 " atributo="NUMERODESDE                             " tabla="TRATCOMP       " campo="NUMDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="206" etiqueta="Numero desde                                                                                                                                                    " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="22" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRATAMIENTOCOMPROBANTES                 " atributo="NUMEROHASTA                             " tabla="TRATCOMP       " campo="NUMHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="207" etiqueta="Numero hasta                                                                                                                                                    " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="23" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRATAMIENTOCOMPROBANTES                 " atributo="SECUENCIA                               " tabla="TRATCOMP       " campo="FACTSEC   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Secuencia                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="24" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRATAMIENTOCOMPROBANTES                 " atributo="FECHACOMPROBANTE                        " tabla="TRATCOMP       " campo="FFCH      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="208" etiqueta="Fecha                                                                                                                                                           " dominio="FECHACALENDARIO               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="25" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRATAMIENTOCOMPROBANTES                 " atributo="OBSERVACION                             " tabla="TRATCOMP       " campo="OBS       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="209" etiqueta="Observacion                                                                                                                                                     " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="5" orden="50" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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