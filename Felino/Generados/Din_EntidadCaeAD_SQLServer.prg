
define class Din_EntidadCAEAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_CAE'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = []
	cExpresionCCPorCampos = []
	cTagClaveCandidata = ''
	cTagClavePk = '_FAEPK'
	cTablaPrincipal = 'CAE'
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
			local  lxCaeFecimpo, lxCaeFectrans, lxCaeFmodifw, lxCaeFecexpo, lxCaeFaltafw, lxCaeFechavto, lxCaeCodigocaea, lxCaeDginumero, lxCaeTimestamp, lxCaeCaeainf, lxCaeSaltafw, lxCaeSmodifw, lxCaeHmodifw, lxCaeHoraimpo, lxCaeVmodifw, lxCaeUaltafw, lxCaeZadsfw, lxCaeValtafw, lxCaeHoraexpo, lxCaeUmodifw, lxCaeCodbarra, lxCaeEsttrans, lxCaeBdaltafw, lxCaeBdmodifw, lxCaeHaltafw, lxCaeResultado, lxCaeInco, lxCaeDgiserie, lxCaeNumero, lxCaeMone, lxCaeCodigo, lxCaeObs
				lxCaeFecimpo =  .Fechaimpo			lxCaeFectrans =  .Fechatransferencia			lxCaeFmodifw =  .Fechamodificacionfw			lxCaeFecexpo =  .Fechaexpo			lxCaeFaltafw =  .Fechaaltafw			lxCaeFechavto =  .Fechavencimiento			lxCaeCodigocaea =  .Codigocaea			lxCaeDginumero =  .Dginumero			lxCaeTimestamp = goLibrerias.ObtenerTimestamp()			lxCaeCaeainf =  .Caeainformado			lxCaeSaltafw =  .Seriealtafw			lxCaeSmodifw =  .Seriemodificacionfw			lxCaeHmodifw =  .Horamodificacionfw			lxCaeHoraimpo =  .Horaimpo			lxCaeVmodifw =  .Versionmodificacionfw			lxCaeUaltafw =  .Usuarioaltafw			lxCaeZadsfw =  .Zadsfw			lxCaeValtafw =  .Versionaltafw			lxCaeHoraexpo =  .Horaexpo			lxCaeUmodifw =  .Usuariomodificacionfw			lxCaeCodbarra =  .Codigobarracae			lxCaeEsttrans =  .Estadotransferencia			lxCaeBdaltafw =  .Basededatosaltafw			lxCaeBdmodifw =  .Basededatosmodificacionfw			lxCaeHaltafw =  .Horaaltafw			lxCaeResultado =  .Resultado			lxCaeInco =  upper( .Incoterms_PK ) 			lxCaeDgiserie =  .Dgiserie			lxCaeNumero =  .Numero			lxCaeMone =  upper( .Moneda_PK ) 			lxCaeCodigo =  .Codigo			lxCaeObs =  .Observaciones
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxCaeCodigo = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.CAE ( "Fecimpo","Fectrans","Fmodifw","Fecexpo","Faltafw","Fechavto","Codigocaea","Dginumero","Timestamp","Caeainf","Saltafw","Smodifw","Hmodifw","Horaimpo","Vmodifw","Ualtafw","Zadsfw","Valtafw","Horaexpo","Umodifw","Codbarra","Esttrans","Bdaltafw","Bdmodifw","Haltafw","Resultado","Inco","Dgiserie","Numero","Mone","Codigo","Obs" ) values ( <<"'" + this.ConvertirDateSql( lxCaeFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCaeFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCaeFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCaeFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCaeFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCaeFechavto ) + "'" >>, <<lxCaeCodigocaea >>, <<lxCaeDginumero >>, <<lxCaeTimestamp >>, <<iif( lxCaeCaeainf, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxCaeSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCaeSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCaeHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCaeHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCaeVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCaeUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCaeZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCaeValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCaeHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCaeUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCaeCodbarra ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCaeEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCaeBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCaeBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCaeHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCaeResultado ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCaeInco ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCaeDgiserie ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCaeNumero ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCaeMone ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCaeCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCaeObs ) + "'" >> )
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
		this.oEntidad.Timestamp = lxCaeTimestamp
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
			local  lxCaeFecimpo, lxCaeFectrans, lxCaeFmodifw, lxCaeFecexpo, lxCaeFaltafw, lxCaeFechavto, lxCaeCodigocaea, lxCaeDginumero, lxCaeTimestamp, lxCaeCaeainf, lxCaeSaltafw, lxCaeSmodifw, lxCaeHmodifw, lxCaeHoraimpo, lxCaeVmodifw, lxCaeUaltafw, lxCaeZadsfw, lxCaeValtafw, lxCaeHoraexpo, lxCaeUmodifw, lxCaeCodbarra, lxCaeEsttrans, lxCaeBdaltafw, lxCaeBdmodifw, lxCaeHaltafw, lxCaeResultado, lxCaeInco, lxCaeDgiserie, lxCaeNumero, lxCaeMone, lxCaeCodigo, lxCaeObs
				lxCaeFecimpo =  .Fechaimpo			lxCaeFectrans =  .Fechatransferencia			lxCaeFmodifw =  .Fechamodificacionfw			lxCaeFecexpo =  .Fechaexpo			lxCaeFaltafw =  .Fechaaltafw			lxCaeFechavto =  .Fechavencimiento			lxCaeCodigocaea =  .Codigocaea			lxCaeDginumero =  .Dginumero			lxCaeTimestamp = goLibrerias.ObtenerTimestamp()			lxCaeCaeainf =  .Caeainformado			lxCaeSaltafw =  .Seriealtafw			lxCaeSmodifw =  .Seriemodificacionfw			lxCaeHmodifw =  .Horamodificacionfw			lxCaeHoraimpo =  .Horaimpo			lxCaeVmodifw =  .Versionmodificacionfw			lxCaeUaltafw =  .Usuarioaltafw			lxCaeZadsfw =  .Zadsfw			lxCaeValtafw =  .Versionaltafw			lxCaeHoraexpo =  .Horaexpo			lxCaeUmodifw =  .Usuariomodificacionfw			lxCaeCodbarra =  .Codigobarracae			lxCaeEsttrans =  .Estadotransferencia			lxCaeBdaltafw =  .Basededatosaltafw			lxCaeBdmodifw =  .Basededatosmodificacionfw			lxCaeHaltafw =  .Horaaltafw			lxCaeResultado =  .Resultado			lxCaeInco =  upper( .Incoterms_PK ) 			lxCaeDgiserie =  .Dgiserie			lxCaeNumero =  .Numero			lxCaeMone =  upper( .Moneda_PK ) 			lxCaeCodigo =  .Codigo			lxCaeObs =  .Observaciones
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
			lxValorClavePrimaria = .oEntidad.CODIGO
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ZooLogic.CAE set "Fecimpo" = <<"'" + this.ConvertirDateSql( lxCaeFecimpo ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxCaeFectrans ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxCaeFmodifw ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxCaeFecexpo ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxCaeFaltafw ) + "'">>,"Fechavto" = <<"'" + this.ConvertirDateSql( lxCaeFechavto ) + "'">>,"Codigocaea" = <<lxCaeCodigocaea>>,"Dginumero" = <<lxCaeDginumero>>,"Timestamp" = <<lxCaeTimestamp>>,"Caeainf" = <<iif( lxCaeCaeainf, 1, 0 )>>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxCaeSaltafw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxCaeSmodifw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxCaeHmodifw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxCaeHoraimpo ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxCaeVmodifw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxCaeUaltafw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxCaeZadsfw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxCaeValtafw ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxCaeHoraexpo ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxCaeUmodifw ) + "'">>,"Codbarra" = <<"'" + this.FormatearTextoSql( lxCaeCodbarra ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxCaeEsttrans ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxCaeBdaltafw ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxCaeBdmodifw ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxCaeHaltafw ) + "'">>,"Resultado" = <<"'" + this.FormatearTextoSql( lxCaeResultado ) + "'">>,"Inco" = <<"'" + this.FormatearTextoSql( lxCaeInco ) + "'">>,"Dgiserie" = <<"'" + this.FormatearTextoSql( lxCaeDgiserie ) + "'">>,"Numero" = <<"'" + this.FormatearTextoSql( lxCaeNumero ) + "'">>,"Mone" = <<"'" + this.FormatearTextoSql( lxCaeMone ) + "'">>,"Codigo" = <<"'" + this.FormatearTextoSql( lxCaeCodigo ) + "'">>,"Obs" = <<"'" + this.FormatearTextoSql( lxCaeObs ) + "'">> where "Codigo" = <<"'" + this.FormatearTextoSql( lxCaeCodigo ) + "'">> and  CAE.CODIGO != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
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
		this.oEntidad.Timestamp = lxCaeTimestamp
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 CODIGO from ZooLogic.CAE where " + this.ConvertirFuncionesSql( " CAE.CODIGO != ''" ) )
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
			Local lxCaeCodigo
			lxCaeCodigo = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fechavto" as "Fechavencimiento", "Codigocaea" as "Codigocaea", "Dginumero" as "Dginumero", "Timestamp" as "Timestamp", "Caeainf" as "Caeainformado", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Vmodifw" as "Versionmodificacionfw", "Ualtafw" as "Usuarioaltafw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Horaexpo" as "Horaexpo", "Umodifw" as "Usuariomodificacionfw", "Codbarra" as "Codigobarracae", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Haltafw" as "Horaaltafw", "Resultado" as "Resultado", "Inco" as "Incoterms", "Dgiserie" as "Dgiserie", "Numero" as "Numero", "Mone" as "Moneda", "Codigo" as "Codigo", "Obs" as "Observaciones" from ZooLogic.CAE where "Codigo" = <<"'" + this.FormatearTextoSql( lxCaeCodigo ) + "'">> and  CAE.CODIGO != ''
			endtext
			use in select('c_CAE')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CAE', set( 'Datasession' ) )

			if reccount( 'c_CAE' ) = 0
				llRetorno = .f.
			else
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxCaeCodigo as Variant
		llRetorno = .t.
		lxCaeCodigo = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.CAE where "Codigo" = <<"'" + this.FormatearTextoSql( lxCaeCodigo ) + "'">> and  CAE.CODIGO != ''
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
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fechavto" as "Fechavencimiento", "Codigocaea" as "Codigocaea", "Dginumero" as "Dginumero", "Timestamp" as "Timestamp", "Caeainf" as "Caeainformado", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Vmodifw" as "Versionmodificacionfw", "Ualtafw" as "Usuarioaltafw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Horaexpo" as "Horaexpo", "Umodifw" as "Usuariomodificacionfw", "Codbarra" as "Codigobarracae", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Haltafw" as "Horaaltafw", "Resultado" as "Resultado", "Inco" as "Incoterms", "Dgiserie" as "Dgiserie", "Numero" as "Numero", "Mone" as "Moneda", "Codigo" as "Codigo", "Obs" as "Observaciones" from ZooLogic.CAE where  CAE.CODIGO != '' order by CODIGO
			endtext
			use in select('c_CAE')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CAE', set( 'Datasession' ) )
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
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fechavto" as "Fechavencimiento", "Codigocaea" as "Codigocaea", "Dginumero" as "Dginumero", "Timestamp" as "Timestamp", "Caeainf" as "Caeainformado", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Vmodifw" as "Versionmodificacionfw", "Ualtafw" as "Usuarioaltafw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Horaexpo" as "Horaexpo", "Umodifw" as "Usuariomodificacionfw", "Codbarra" as "Codigobarracae", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Haltafw" as "Horaaltafw", "Resultado" as "Resultado", "Inco" as "Incoterms", "Dgiserie" as "Dgiserie", "Numero" as "Numero", "Mone" as "Moneda", "Codigo" as "Codigo", "Obs" as "Observaciones" from ZooLogic.CAE where  funciones.padr( CODIGO, 38, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  CAE.CODIGO != '' order by CODIGO
			endtext
			use in select('c_CAE')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CAE', set( 'Datasession' ) )
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
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fechavto" as "Fechavencimiento", "Codigocaea" as "Codigocaea", "Dginumero" as "Dginumero", "Timestamp" as "Timestamp", "Caeainf" as "Caeainformado", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Vmodifw" as "Versionmodificacionfw", "Ualtafw" as "Usuarioaltafw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Horaexpo" as "Horaexpo", "Umodifw" as "Usuariomodificacionfw", "Codbarra" as "Codigobarracae", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Haltafw" as "Horaaltafw", "Resultado" as "Resultado", "Inco" as "Incoterms", "Dgiserie" as "Dgiserie", "Numero" as "Numero", "Mone" as "Moneda", "Codigo" as "Codigo", "Obs" as "Observaciones" from ZooLogic.CAE where  funciones.padr( CODIGO, 38, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  CAE.CODIGO != '' order by CODIGO desc
			endtext
			use in select('c_CAE')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CAE', set( 'Datasession' ) )
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
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fechavto" as "Fechavencimiento", "Codigocaea" as "Codigocaea", "Dginumero" as "Dginumero", "Timestamp" as "Timestamp", "Caeainf" as "Caeainformado", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Vmodifw" as "Versionmodificacionfw", "Ualtafw" as "Usuarioaltafw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Horaexpo" as "Horaexpo", "Umodifw" as "Usuariomodificacionfw", "Codbarra" as "Codigobarracae", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Haltafw" as "Horaaltafw", "Resultado" as "Resultado", "Inco" as "Incoterms", "Dgiserie" as "Dgiserie", "Numero" as "Numero", "Mone" as "Moneda", "Codigo" as "Codigo", "Obs" as "Observaciones" from ZooLogic.CAE where  CAE.CODIGO != '' order by CODIGO desc
			endtext
			use in select('c_CAE')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CAE', set( 'Datasession' ) )
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
			lcXml = this.oConexion.EjecutarSql( "select Fecimpo,Fectrans,Fmodifw,Fecexpo,Faltafw,Fechavto,Codigocaea,Dginumero,Timestamp,Caeainf,Sal" + ;
"tafw,Smodifw,Hmodifw,Horaimpo,Vmodifw,Ualtafw,Zadsfw,Valtafw,Horaexpo,Umodifw,Codbarra,Esttrans,Bdal" + ;
"tafw,Bdmodifw,Haltafw,Resultado,Inco,Dgiserie,Numero,Mone,Codigo,Obs" + ;
" from ZooLogic.CAE where  CAE.CODIGO != '' and " + lcFiltro )
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
			local  lxCaeFecimpo, lxCaeFectrans, lxCaeFmodifw, lxCaeFecexpo, lxCaeFaltafw, lxCaeFechavto, lxCaeCodigocaea, lxCaeDginumero, lxCaeTimestamp, lxCaeCaeainf, lxCaeSaltafw, lxCaeSmodifw, lxCaeHmodifw, lxCaeHoraimpo, lxCaeVmodifw, lxCaeUaltafw, lxCaeZadsfw, lxCaeValtafw, lxCaeHoraexpo, lxCaeUmodifw, lxCaeCodbarra, lxCaeEsttrans, lxCaeBdaltafw, lxCaeBdmodifw, lxCaeHaltafw, lxCaeResultado, lxCaeInco, lxCaeDgiserie, lxCaeNumero, lxCaeMone, lxCaeCodigo, lxCaeObs
				lxCaeFecimpo = ctod( '  /  /    ' )			lxCaeFectrans = ctod( '  /  /    ' )			lxCaeFmodifw = ctod( '  /  /    ' )			lxCaeFecexpo = ctod( '  /  /    ' )			lxCaeFaltafw = ctod( '  /  /    ' )			lxCaeFechavto = ctod( '  /  /    ' )			lxCaeCodigocaea = 0			lxCaeDginumero = 0			lxCaeTimestamp = goLibrerias.ObtenerTimestamp()			lxCaeCaeainf = .F.			lxCaeSaltafw = []			lxCaeSmodifw = []			lxCaeHmodifw = []			lxCaeHoraimpo = []			lxCaeVmodifw = []			lxCaeUaltafw = []			lxCaeZadsfw = []			lxCaeValtafw = []			lxCaeHoraexpo = []			lxCaeUmodifw = []			lxCaeCodbarra = []			lxCaeEsttrans = []			lxCaeBdaltafw = []			lxCaeBdmodifw = []			lxCaeHaltafw = []			lxCaeResultado = []			lxCaeInco = []			lxCaeDgiserie = []			lxCaeNumero = []			lxCaeMone = []			lxCaeCodigo = []			lxCaeObs = []
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( [delete from ZooLogic.CAE where "CODIGO" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'CAE' + '_' + tcCampo
			lcMemoAscii = ''

			lnIndice = alen(.aSqlMemos)
			lnIndice = iif(lnIndice = 1, 1, lnIndice + 1 )
			dimension .aSqlMemos(lnIndice)

			.aSqlMemos(lnIndice) = 'delete from ' + lcTabla + ' where CODIGO = ' + txValorClavePrimaria
			.GenerarSentenciasInsertTablaMemo( lcValor, lcTabla, txValorClavePrimaria )
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerSentenciaInsertMemo( tcTabla as String, txValorClavePrimaria as String, tcOrden as String, tcTexto as String ) as String
		return "Insert  into " + tcTabla + "(CODIGO, Orden, texto ) values ( " + txValorClavePrimaria + "," + tcOrden + ",'"+ tcTexto + "')"
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosEntidad( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  CAE.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fechavto" as "Fechavencimiento", "Codigocaea" as "Codigocaea", "Dginumero" as "Dginumero", "Timestamp" as "Timestamp", "Caeainf" as "Caeainformado", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Vmodifw" as "Versionmodificacionfw", "Ualtafw" as "Usuarioaltafw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Horaexpo" as "Horaexpo", "Umodifw" as "Usuariomodificacionfw", "Codbarra" as "Codigobarracae", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Haltafw" as "Horaaltafw", "Resultado" as "Resultado", "Inco" as "Incoterms", "Dgiserie" as "Dgiserie", "Numero" as "Numero", "Mone" as "Moneda", "Codigo" as "Codigo", "Obs" as "Observaciones"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'CAE', '', tnTope )
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
				Case lcAtributo == 'FECHAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECEXPO AS FECHAEXPO'
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'FECHAVENCIMIENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHAVTO AS FECHAVENCIMIENTO'
				Case lcAtributo == 'CODIGOCAEA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGOCAEA AS CODIGOCAEA'
				Case lcAtributo == 'DGINUMERO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DGINUMERO AS DGINUMERO'
				Case lcAtributo == 'TIMESTAMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIMESTAMP AS TIMESTAMP'
				Case lcAtributo == 'CAEAINFORMADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CAEAINF AS CAEAINFORMADO'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'CODIGOBARRACAE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODBARRA AS CODIGOBARRACAE'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'RESULTADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RESULTADO AS RESULTADO'
				Case lcAtributo == 'INCOTERMS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'INCO AS INCOTERMS'
				Case lcAtributo == 'DGISERIE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DGISERIE AS DGISERIE'
				Case lcAtributo == 'NUMERO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NUMERO AS NUMERO'
				Case lcAtributo == 'MONEDA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONE AS MONEDA'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'OBSERVACIONES'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'OBS AS OBSERVACIONES'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEXPO'
				lcCampo = 'FECEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAVENCIMIENTO'
				lcCampo = 'FECHAVTO'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGOCAEA'
				lcCampo = 'CODIGOCAEA'
			Case upper( alltrim( tcAtributo ) ) == 'DGINUMERO'
				lcCampo = 'DGINUMERO'
			Case upper( alltrim( tcAtributo ) ) == 'TIMESTAMP'
				lcCampo = 'TIMESTAMP'
			Case upper( alltrim( tcAtributo ) ) == 'CAEAINFORMADO'
				lcCampo = 'CAEAINF'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGOBARRACAE'
				lcCampo = 'CODBARRA'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'RESULTADO'
				lcCampo = 'RESULTADO'
			Case upper( alltrim( tcAtributo ) ) == 'INCOTERMS'
				lcCampo = 'INCO'
			Case upper( alltrim( tcAtributo ) ) == 'DGISERIE'
				lcCampo = 'DGISERIE'
			Case upper( alltrim( tcAtributo ) ) == 'NUMERO'
				lcCampo = 'NUMERO'
			Case upper( alltrim( tcAtributo ) ) == 'MONEDA'
				lcCampo = 'MONE'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'OBSERVACIONES'
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
			local  lxCaeFecimpo, lxCaeFectrans, lxCaeFmodifw, lxCaeFecexpo, lxCaeFaltafw, lxCaeFechavto, lxCaeCodigocaea, lxCaeDginumero, lxCaeTimestamp, lxCaeCaeainf, lxCaeSaltafw, lxCaeSmodifw, lxCaeHmodifw, lxCaeHoraimpo, lxCaeVmodifw, lxCaeUaltafw, lxCaeZadsfw, lxCaeValtafw, lxCaeHoraexpo, lxCaeUmodifw, lxCaeCodbarra, lxCaeEsttrans, lxCaeBdaltafw, lxCaeBdmodifw, lxCaeHaltafw, lxCaeResultado, lxCaeInco, lxCaeDgiserie, lxCaeNumero, lxCaeMone, lxCaeCodigo, lxCaeObs
				lxCaeFecimpo =  .Fechaimpo			lxCaeFectrans =  .Fechatransferencia			lxCaeFmodifw =  .Fechamodificacionfw			lxCaeFecexpo =  .Fechaexpo			lxCaeFaltafw =  .Fechaaltafw			lxCaeFechavto =  .Fechavencimiento			lxCaeCodigocaea =  .Codigocaea			lxCaeDginumero =  .Dginumero			lxCaeTimestamp = goLibrerias.ObtenerTimestamp()			lxCaeCaeainf =  .Caeainformado			lxCaeSaltafw =  .Seriealtafw			lxCaeSmodifw =  .Seriemodificacionfw			lxCaeHmodifw =  .Horamodificacionfw			lxCaeHoraimpo =  .Horaimpo			lxCaeVmodifw =  .Versionmodificacionfw			lxCaeUaltafw =  .Usuarioaltafw			lxCaeZadsfw =  .Zadsfw			lxCaeValtafw =  .Versionaltafw			lxCaeHoraexpo =  .Horaexpo			lxCaeUmodifw =  .Usuariomodificacionfw			lxCaeCodbarra =  .Codigobarracae			lxCaeEsttrans =  .Estadotransferencia			lxCaeBdaltafw =  .Basededatosaltafw			lxCaeBdmodifw =  .Basededatosmodificacionfw			lxCaeHaltafw =  .Horaaltafw			lxCaeResultado =  .Resultado			lxCaeInco =  upper( .Incoterms_PK ) 			lxCaeDgiserie =  .Dgiserie			lxCaeNumero =  .Numero			lxCaeMone =  upper( .Moneda_PK ) 			lxCaeCodigo =  .Codigo			lxCaeObs =  .Observaciones
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.CAE ( "Fecimpo","Fectrans","Fmodifw","Fecexpo","Faltafw","Fechavto","Codigocaea","Dginumero","Timestamp","Caeainf","Saltafw","Smodifw","Hmodifw","Horaimpo","Vmodifw","Ualtafw","Zadsfw","Valtafw","Horaexpo","Umodifw","Codbarra","Esttrans","Bdaltafw","Bdmodifw","Haltafw","Resultado","Inco","Dgiserie","Numero","Mone","Codigo","Obs" ) values ( <<"'" + this.ConvertirDateSql( lxCaeFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCaeFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCaeFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCaeFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCaeFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCaeFechavto ) + "'" >>, <<lxCaeCodigocaea >>, <<lxCaeDginumero >>, <<lxCaeTimestamp >>, <<iif( lxCaeCaeainf, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxCaeSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCaeSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCaeHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCaeHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCaeVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCaeUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCaeZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCaeValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCaeHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCaeUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCaeCodbarra ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCaeEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCaeBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCaeBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCaeHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCaeResultado ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCaeInco ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCaeDgiserie ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCaeNumero ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCaeMone ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCaeCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCaeObs ) + "'" >> )
		endtext
		loColeccion.cTabla = 'CAE' 
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
			local  lxCaeFecimpo, lxCaeFectrans, lxCaeFmodifw, lxCaeFecexpo, lxCaeFaltafw, lxCaeFechavto, lxCaeCodigocaea, lxCaeDginumero, lxCaeTimestamp, lxCaeCaeainf, lxCaeSaltafw, lxCaeSmodifw, lxCaeHmodifw, lxCaeHoraimpo, lxCaeVmodifw, lxCaeUaltafw, lxCaeZadsfw, lxCaeValtafw, lxCaeHoraexpo, lxCaeUmodifw, lxCaeCodbarra, lxCaeEsttrans, lxCaeBdaltafw, lxCaeBdmodifw, lxCaeHaltafw, lxCaeResultado, lxCaeInco, lxCaeDgiserie, lxCaeNumero, lxCaeMone, lxCaeCodigo, lxCaeObs
				lxCaeFecimpo =  .Fechaimpo			lxCaeFectrans =  .Fechatransferencia			lxCaeFmodifw =  .Fechamodificacionfw			lxCaeFecexpo =  .Fechaexpo			lxCaeFaltafw =  .Fechaaltafw			lxCaeFechavto =  .Fechavencimiento			lxCaeCodigocaea =  .Codigocaea			lxCaeDginumero =  .Dginumero			lxCaeTimestamp = goLibrerias.ObtenerTimestamp()			lxCaeCaeainf =  .Caeainformado			lxCaeSaltafw =  .Seriealtafw			lxCaeSmodifw =  .Seriemodificacionfw			lxCaeHmodifw =  .Horamodificacionfw			lxCaeHoraimpo =  .Horaimpo			lxCaeVmodifw =  .Versionmodificacionfw			lxCaeUaltafw =  .Usuarioaltafw			lxCaeZadsfw =  .Zadsfw			lxCaeValtafw =  .Versionaltafw			lxCaeHoraexpo =  .Horaexpo			lxCaeUmodifw =  .Usuariomodificacionfw			lxCaeCodbarra =  .Codigobarracae			lxCaeEsttrans =  .Estadotransferencia			lxCaeBdaltafw =  .Basededatosaltafw			lxCaeBdmodifw =  .Basededatosmodificacionfw			lxCaeHaltafw =  .Horaaltafw			lxCaeResultado =  .Resultado			lxCaeInco =  upper( .Incoterms_PK ) 			lxCaeDgiserie =  .Dgiserie			lxCaeNumero =  .Numero			lxCaeMone =  upper( .Moneda_PK ) 			lxCaeCodigo =  .Codigo			lxCaeObs =  .Observaciones
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  CAE.CODIGO != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.CAE set "Fecimpo" = <<"'" + this.ConvertirDateSql( lxCaeFecimpo ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxCaeFectrans ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxCaeFmodifw ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxCaeFecexpo ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxCaeFaltafw ) + "'">>, "Fechavto" = <<"'" + this.ConvertirDateSql( lxCaeFechavto ) + "'">>, "Codigocaea" = <<lxCaeCodigocaea>>, "Dginumero" = <<lxCaeDginumero>>, "Timestamp" = <<lxCaeTimestamp>>, "Caeainf" = <<iif( lxCaeCaeainf, 1, 0 )>>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxCaeSaltafw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxCaeSmodifw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxCaeHmodifw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxCaeHoraimpo ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxCaeVmodifw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxCaeUaltafw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxCaeZadsfw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxCaeValtafw ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxCaeHoraexpo ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxCaeUmodifw ) + "'">>, "Codbarra" = <<"'" + this.FormatearTextoSql( lxCaeCodbarra ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxCaeEsttrans ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxCaeBdaltafw ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxCaeBdmodifw ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxCaeHaltafw ) + "'">>, "Resultado" = <<"'" + this.FormatearTextoSql( lxCaeResultado ) + "'">>, "Inco" = <<"'" + this.FormatearTextoSql( lxCaeInco ) + "'">>, "Dgiserie" = <<"'" + this.FormatearTextoSql( lxCaeDgiserie ) + "'">>, "Numero" = <<"'" + this.FormatearTextoSql( lxCaeNumero ) + "'">>, "Mone" = <<"'" + this.FormatearTextoSql( lxCaeMone ) + "'">>, "Codigo" = <<"'" + this.FormatearTextoSql( lxCaeCodigo ) + "'">>, "Obs" = <<"'" + this.FormatearTextoSql( lxCaeObs ) + "'">> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'CAE' 
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

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  CAE.CODIGO != '']
		loColeccion.Agregar( 'delete from ZooLogic.CAE where ' + lcFiltro )
			loColeccion.cTabla = 'CAE' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.CAE where  CAE.CODIGO != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.CAE where CODIGO = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  CAE.CODIGO != ''" )
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
		lcCursor = This.oEntidad.cPrefijoRecibir + 'CAE'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.CAE Where CODIGO = ] + "'" + this.FormatearTextoSql( &lcCursor..CODIGO ) + "'", 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				if This.ActualizaEnRecepcion() 
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					this.oConexion.EjecutarSql( [UPDATE ZooLogic.CAE set  FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FechaVTO = ] + "'" + this.ConvertirDateSql( &lcCursor..FechaVTO ) + "'"+ [, CodigoCAEA = ] + transform( &lcCursor..CodigoCAEA )+ [, DGINumero = ] + transform( &lcCursor..DGINumero )+ [, TIMESTAMP = ] + transform( &lcCursor..TIMESTAMP )+ [, CAEAInf = ] + Transform( iif( &lcCursor..CAEAInf, 1, 0 ))+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, CodBarra = ] + "'" + this.FormatearTextoSql( &lcCursor..CodBarra ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, Resultado = ] + "'" + this.FormatearTextoSql( &lcCursor..Resultado ) + "'"+ [, Inco = ] + "'" + this.FormatearTextoSql( &lcCursor..Inco ) + "'"+ [, DGISerie = ] + "'" + this.FormatearTextoSql( &lcCursor..DGISerie ) + "'"+ [, Numero = ] + "'" + this.FormatearTextoSql( &lcCursor..Numero ) + "'"+ [, Mone = ] + "'" + this.FormatearTextoSql( &lcCursor..Mone ) + "'"+ [, CODIGO = ] + "'" + this.FormatearTextoSql( &lcCursor..CODIGO ) + "'"+ [, Obs = ] + "'" + this.FormatearTextoSql( &lcCursor..Obs ) + "'" + [ Where CODIGO = ] + "'" + this.FormatearTextoSql( &lcCursor..CODIGO ) + "'" )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
				endIf
			else
				Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
				Text to lcCampos noShow
					 FECIMPO, FECTRANS, FMODIFW, FECEXPO, FALTAFW, FechaVTO, CodigoCAEA, DGINumero, TIMESTAMP, CAEAInf, SALTAFW, SMODIFW, HMODIFW, HORAIMPO, VMODIFW, UALTAFW, ZADSFW, VALTAFW, HORAEXPO, UMODIFW, CodBarra, ESTTRANS, BDALTAFW, BDMODIFW, HALTAFW, Resultado, Inco, DGISerie, Numero, Mone, CODIGO, Obs
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FechaVTO ) + "'" + ',' + transform( &lcCursor..CodigoCAEA )
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..DGINumero ) + ',' + transform( &lcCursor..TIMESTAMP ) + ',' + Transform( iif( &lcCursor..CAEAInf, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CodBarra ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Resultado ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Inco ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..DGISerie ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Numero ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..Mone ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CODIGO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Obs ) + "'"
lcValoresCampos = substr(lcValoresCampos,2) 

				this.oConexion.EjecutarSql( [Insert into ZooLogic.CAE ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
				this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'CAE'
		if This.ActualizaEnRecepcion()
	endif
	Use in select( 'cExistentes' )
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearCursorMemo( tcCursorACrear as String, tcTablaConMemo as String ) as Void
		create cursor &tcCursorACrear ( CODIGO C (38) , Orden N(16), texto C(80))
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirComponentes() As Void
		
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function ObtenerIdentificadorParaLoguear( tcCursor as String ) As String
		local lcRetorno as String, lnCC as String , loCC as Object, lni as Integer, lcSecuencia as String
		lcRetorno = this.oEntidad.cDescripcion 
		lcRetorno = lcRetorno + ' - Codigo: ' + transform( &tcCursor..CODIGO     )
		Return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EsAliasDeProceso( tcAlias As String, tcPrefijo as string ) As Boolean
		local llRetorno as Boolean, lcAlias as String, lcPrefijo As String
		llRetorno = .F.
		lcAlias = upper( alltrim( tcAlias ) )
		lcPrefijo = upper( alltrim( tcPrefijo ) )
		Do Case
			Case  lcAlias == lcPrefijo + 'CAE'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'CAE_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'CAE_OBS'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_CAE')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'CAE'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..CODIGO
		llCondicion = isnull( lxVar )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad CAE. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'CAE'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		select recno() as _Rec, * from &lcCursor into cursor CurConRecno
		select max( _Rec ) as Maximo,CODIGO as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( CODIGO, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		Use in select( 'CurConRecno' )
		Use in select( 'RepMax' )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDatosInvalidos( toConexion as Object ) as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'CAE'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FechaVTO  
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_CAE') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_CAE
Create Table ZooLogic.TablaTrabajo_CAE ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fecimpo" datetime  null, 
"fectrans" datetime  null, 
"fmodifw" datetime  null, 
"fecexpo" datetime  null, 
"faltafw" datetime  null, 
"fechavto" datetime  null, 
"codigocaea" numeric( 15, 0 )  null, 
"dginumero" numeric( 7, 0 )  null, 
"timestamp" numeric( 20, 0 )  null, 
"caeainf" bit  null, 
"saltafw" char( 7 )  null, 
"smodifw" char( 7 )  null, 
"hmodifw" char( 8 )  null, 
"horaimpo" char( 8 )  null, 
"vmodifw" char( 13 )  null, 
"ualtafw" char( 100 )  null, 
"zadsfw" varchar(max)  null, 
"valtafw" char( 13 )  null, 
"horaexpo" char( 8 )  null, 
"umodifw" char( 100 )  null, 
"codbarra" char( 40 )  null, 
"esttrans" char( 20 )  null, 
"bdaltafw" char( 8 )  null, 
"bdmodifw" char( 8 )  null, 
"haltafw" char( 8 )  null, 
"resultado" char( 1 )  null, 
"inco" char( 3 )  null, 
"dgiserie" char( 2 )  null, 
"numero" char( 20 )  null, 
"mone" char( 10 )  null, 
"codigo" char( 38 )  null, 
"obs" varchar(max)  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_CAE' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_CAE' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'CAE'
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
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('fechavto','fechavto')
			.AgregarMapeo('codigocaea','codigocaea')
			.AgregarMapeo('dginumero','dginumero')
			.AgregarMapeo('timestamp','timestamp')
			.AgregarMapeo('caeainf','caeainf')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('codbarra','codbarra')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('resultado','resultado')
			.AgregarMapeo('inco','inco')
			.AgregarMapeo('dgiserie','dgiserie')
			.AgregarMapeo('numero','numero')
			.AgregarMapeo('mone','mone')
			.AgregarMapeo('codigo','codigo')
			.AgregarMapeo('obs','obs')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_CAE'
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
				Update t Set t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FECHAVTO = isnull( d.FECHAVTO, t.FECHAVTO ),t.CODIGOCAEA = isnull( d.CODIGOCAEA, t.CODIGOCAEA ),t.DGINUMERO = isnull( d.DGINUMERO, t.DGINUMERO ),t.TIMESTAMP = isnull( d.TIMESTAMP, t.TIMESTAMP ),t.CAEAINF = isnull( d.CAEAINF, t.CAEAINF ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.CODBARRA = isnull( d.CODBARRA, t.CODBARRA ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.RESULTADO = isnull( d.RESULTADO, t.RESULTADO ),t.INCO = isnull( d.INCO, t.INCO ),t.DGISERIE = isnull( d.DGISERIE, t.DGISERIE ),t.NUMERO = isnull( d.NUMERO, t.NUMERO ),t.MONE = isnull( d.MONE, t.MONE ),t.CODIGO = isnull( d.CODIGO, t.CODIGO ),t.OBS = isnull( d.OBS, t.OBS )
					from ZooLogic.CAE t inner join deleted d 
							 on t.CODIGO = d.CODIGO
				-- Fin Updates
				insert into ZooLogic.CAE(Fecimpo,Fectrans,Fmodifw,Fecexpo,Faltafw,Fechavto,Codigocaea,Dginumero,Timestamp,Caeainf,Saltafw,Smodifw,Hmodifw,Horaimpo,Vmodifw,Ualtafw,Zadsfw,Valtafw,Horaexpo,Umodifw,Codbarra,Esttrans,Bdaltafw,Bdmodifw,Haltafw,Resultado,Inco,Dgiserie,Numero,Mone,Codigo,Obs)
					Select isnull( d.FECIMPO,''),isnull( d.FECTRANS,''),isnull( d.FMODIFW,''),isnull( d.FECEXPO,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FECHAVTO,''),isnull( d.CODIGOCAEA,0),isnull( d.DGINUMERO,0),isnull( d.TIMESTAMP,0),isnull( d.CAEAINF,0),isnull( d.SALTAFW,''),isnull( d.SMODIFW,''),isnull( d.HMODIFW,''),isnull( d.HORAIMPO,''),isnull( d.VMODIFW,''),isnull( d.UALTAFW,''),isnull( d.ZADSFW,''),isnull( d.VALTAFW,''),isnull( d.HORAEXPO,''),isnull( d.UMODIFW,''),isnull( d.CODBARRA,''),isnull( d.ESTTRANS,''),isnull( d.BDALTAFW,''),isnull( d.BDMODIFW,''),convert( char(8), getdate(), 108 ),isnull( d.RESULTADO,''),isnull( d.INCO,''),isnull( d.DGISERIE,''),isnull( d.NUMERO,''),isnull( d.MONE,''),isnull( d.CODIGO,''),isnull( d.OBS,'')
						From deleted d left join ZooLogic.CAE pk 
							 on d.CODIGO = pk.CODIGO
						Where pk.CODIGO Is Null 
				-- Fin Inserts
			End
		EndText
		Return lcCadena
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	protected Function EliminarTablasDeTrabajo( toConexion as Object ) as void
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_CAE') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_CAE
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_CAE' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_CAE.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_CAE.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_CAE.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_CAE.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_CAE.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechavencimiento = GoLibrerias.ObtenerFechaFormateada( nvl( c_CAE.Fechavencimiento, ctod( '  /  /    ' ) ) )
					.Codigocaea = nvl( c_CAE.Codigocaea, 0 )
					.Dginumero = nvl( c_CAE.Dginumero, 0 )
					.Timestamp = nvl( c_CAE.Timestamp, 0 )
					.Caeainformado = nvl( c_CAE.Caeainformado, .F. )
					.Seriealtafw = nvl( c_CAE.Seriealtafw, [] )
					.Seriemodificacionfw = nvl( c_CAE.Seriemodificacionfw, [] )
					.Horamodificacionfw = nvl( c_CAE.Horamodificacionfw, [] )
					.Horaimpo = nvl( c_CAE.Horaimpo, [] )
					.Versionmodificacionfw = nvl( c_CAE.Versionmodificacionfw, [] )
					.Usuarioaltafw = nvl( c_CAE.Usuarioaltafw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Versionaltafw = nvl( c_CAE.Versionaltafw, [] )
					.Horaexpo = nvl( c_CAE.Horaexpo, [] )
					.Usuariomodificacionfw = nvl( c_CAE.Usuariomodificacionfw, [] )
					.Codigobarracae = nvl( c_CAE.Codigobarracae, [] )
					.Estadotransferencia = nvl( c_CAE.Estadotransferencia, [] )
					.Basededatosaltafw = nvl( c_CAE.Basededatosaltafw, [] )
					.Basededatosmodificacionfw = nvl( c_CAE.Basededatosmodificacionfw, [] )
					.Horaaltafw = nvl( c_CAE.Horaaltafw, [] )
					.Resultado = nvl( c_CAE.Resultado, [] )
					.Incoterms_PK =  nvl( c_CAE.Incoterms, [] )
					.Dgiserie = nvl( c_CAE.Dgiserie, [] )
					.Numero = nvl( c_CAE.Numero, [] )
					.Moneda_PK =  nvl( c_CAE.Moneda, [] )
					.Codigo = nvl( c_CAE.Codigo, [] )
					lcValor = This.ObtenerMemo( 'c_Observaciones')
					.Observaciones = lcValor 
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
		return c_CAE.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.CAE' )
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
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "CODIGO"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
		text to lcSQL textmerge noshow
				SELECT nro,totalRegistros,CODIGO as Id
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    CODIGO from (
							select * 
								from ZooLogic.CAE 
								Where   CAE.CODIGO != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "CAE", "", lcCursor, set("Datasession") )
		lcXml = this.CursorAXml( lcCursor )
		
		use in select( lcCursor )
		
		Return lcXml 
		
	endfunc
	*-----------------------------------------------------------------------------------------
	function ObtenerDatosEntidadPaginado( tcOrderBy as String, tcFiltro as String, tnCantidad as Integer, tnPagina as Integer )  as String
		local lcOrderBy as String, lnCuantos as Integer, lnPagina as Integer, lnTope as Integer, lnDesde as Integer, lcSQL as String, lcCursor as String, lcXml as String
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "CODIGO"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
			text to lcAtributos textmerge noshow
			"Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fechavto" as "Fechavencimiento", "Codigocaea" as "Codigocaea", "Dginumero" as "Dginumero", "Timestamp" as "Timestamp", "Caeainf" as "Caeainformado", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Vmodifw" as "Versionmodificacionfw", "Ualtafw" as "Usuarioaltafw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Horaexpo" as "Horaexpo", "Umodifw" as "Usuariomodificacionfw", "Codbarra" as "Codigobarracae", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Haltafw" as "Horaaltafw", "Resultado" as "Resultado", "Inco" as "Incoterms", "Dgiserie" as "Dgiserie", "Numero" as "Numero", "Mone" as "Moneda", "Codigo" as "Codigo", "Obs" as "Observaciones"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.CAE 
								Where   CAE.CODIGO != ''
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
	Tabla = 'CAE'
	Filtro = " CAE.CODIGO != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " CAE.CODIGO != ''"
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
	<row entidad="CAE                                     " atributo="FECHAIMPO                               " tabla="CAE            " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAE                                     " atributo="FECHATRANSFERENCIA                      " tabla="CAE            " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha transferencia                                                                                                                                             " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAE                                     " atributo="FECHAMODIFICACIONFW                     " tabla="CAE            " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAE                                     " atributo="FECHAEXPO                               " tabla="CAE            " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAE                                     " atributo="FECHAALTAFW                             " tabla="CAE            " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAE                                     " atributo="FECHAVENCIMIENTO                        " tabla="CAE            " campo="FECHAVTO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="6" etiqueta="Fecha                                                                                                                                                           " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAE                                     " atributo="CODIGOCAEA                              " tabla="CAE            " campo="CODIGOCAEA" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="Número CAEA                                                                                                                                                     " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAE                                     " atributo="DGINUMERO                               " tabla="CAE            " campo="DGINUMERO " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Número DGI                                                                                                                                                      " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAE                                     " atributo="TIMESTAMP                               " tabla="CAE            " campo="TIMESTAMP " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAE                                     " atributo="CAEAINFORMADO                           " tabla="CAE            " campo="CAEAINF   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="402" etiqueta="CAEA infomado                                                                                                                                                   " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAE                                     " atributo="SERIEALTAFW                             " tabla="CAE            " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAE                                     " atributo="SERIEMODIFICACIONFW                     " tabla="CAE            " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAE                                     " atributo="HORAMODIFICACIONFW                      " tabla="CAE            " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAE                                     " atributo="HORAIMPO                                " tabla="CAE            " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAE                                     " atributo="VERSIONMODIFICACIONFW                   " tabla="CAE            " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAE                                     " atributo="USUARIOALTAFW                           " tabla="CAE            " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAE                                     " atributo="ZADSFW                                  " tabla="CAE            " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAE                                     " atributo="VERSIONALTAFW                           " tabla="CAE            " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAE                                     " atributo="HORAEXPO                                " tabla="CAE            " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAE                                     " atributo="USUARIOMODIFICACIONFW                   " tabla="CAE            " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAE                                     " atributo="CODIGOBARRACAE                          " tabla="CAE            " campo="CODBARRA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Código de barra                                                                                                                                                 " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAE                                     " atributo="ESTADOTRANSFERENCIA                     " tabla="CAE            " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado transferencia                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAE                                     " atributo="BASEDEDATOSALTAFW                       " tabla="CAE            " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAE                                     " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="CAE            " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAE                                     " atributo="HORAALTAFW                              " tabla="CAE            " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAE                                     " atributo="RESULTADO                               " tabla="CAE            " campo="RESULTADO " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="404" etiqueta="Resultado                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAE                                     " atributo="INCOTERMS                               " tabla="CAE            " campo="INCO      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="INCOTERMS                               " tipodato="C         " longitud="3" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="406" etiqueta="Incoterms                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAE                                     " atributo="DGISERIE                                " tabla="CAE            " campo="DGISERIE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie DGI                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAE                                     " atributo="NUMERO                                  " tabla="CAE            " campo="NUMERO    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="4" etiqueta="Numero                                                                                                                                                          " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAE                                     " atributo="MONEDA                                  " tabla="CAE            " campo="MONE      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="MONEDA                                  " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="408" etiqueta="Moneda                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAE                                     " atributo="CODIGO                                  " tabla="CAE            " campo="CODIGO    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="2" etiqueta="Codigo                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAE                                     " atributo="OBSERVACIONES                           " tabla="CAE            " campo="OBS       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="410" etiqueta="Observaciones                                                                                                                                                   " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INCOTERMS                               " atributo="DESCRIPCION                             " tabla="INCOT          " campo="DESCRI    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="407" etiqueta="Detalle Inc.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join INCOT On CAE.INCO = INCOT.cod And  INCOT.COD != ''                                                                                                                                                                                                 " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="20" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MONEDA                                  " atributo="DESCRIPCION                             " tabla="MONEDA         " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="409" etiqueta="Detalle Mon.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join MONEDA On CAE.MONE = MONEDA.Codigo And  MONEDA.CODIGO != ''                                                                                                                                                                                        " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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