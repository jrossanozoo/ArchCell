
define class Din_EntidadCAEAINFORMAAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_CAEAINFORMA'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = []
	cExpresionCCPorCampos = []
	cTagClaveCandidata = ''
	cTagClavePk = '_IMCPK'
	cTablaPrincipal = 'CAEAINF'
	*--------------------------------------------------------------------------------------------------------
	function Inicializar() as boolean
		local loError as Exception, loEx as Exception

		dodefault()

		with this
			.cArchivoLogPrueba = SYS(0) + '_' + transform( date() ) + '_' + strtran( time(), ':', '.' ) + '_' + transform( golibrerias.obtenertimestamp() ) + '.txt' 
			.cArchivoLogPrueba = strtran( strtran( strtran( .cArchivoLogPrueba, '/', '-' ), ' ', '' ), '#', '' )
			.ColSentencias = _screen.zoo.crearobjeto('zooColeccion')
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
			local  lxCaeainfFecexpo, lxCaeainfFaltafw, lxCaeainfFecimpo, lxCaeainfFectrans, lxCaeainfFmodifw, lxCaeainfTimestamp, lxCaeainfHmodifw, lxCaeainfUaltafw, lxCaeainfSaltafw, lxCaeainfVmodifw, lxCaeainfZadsfw, lxCaeainfUmodifw, lxCaeainfValtafw, lxCaeainfSmodifw, lxCaeainfHoraimpo, lxCaeainfEsttrans, lxCaeainfHoraexpo, lxCaeainfHaltafw, lxCaeainfBdaltafw, lxCaeainfBdmodifw, lxCaeainfCaea, lxCaeainfResultado2, lxCaeainfObsafip, lxCaeainfFechaproc2, lxCaeainfNumint, lxCaeainfVigenciad, lxCaeainfFecha, lxCaeainfVigenciah, lxCaeainfFechatope, lxCaeainfPtovta, lxCaeainfPeriodo, lxCaeainfQuincena, lxCaeainfCodigo
				lxCaeainfFecexpo =  .Fechaexpo			lxCaeainfFaltafw =  .Fechaaltafw			lxCaeainfFecimpo =  .Fechaimpo			lxCaeainfFectrans =  .Fechatransferencia			lxCaeainfFmodifw =  .Fechamodificacionfw			lxCaeainfTimestamp = goLibrerias.ObtenerTimestamp()			lxCaeainfHmodifw =  .Horamodificacionfw			lxCaeainfUaltafw =  .Usuarioaltafw			lxCaeainfSaltafw =  .Seriealtafw			lxCaeainfVmodifw =  .Versionmodificacionfw			lxCaeainfZadsfw =  .Zadsfw			lxCaeainfUmodifw =  .Usuariomodificacionfw			lxCaeainfValtafw =  .Versionaltafw			lxCaeainfSmodifw =  .Seriemodificacionfw			lxCaeainfHoraimpo =  .Horaimpo			lxCaeainfEsttrans =  .Estadotransferencia			lxCaeainfHoraexpo =  .Horaexpo			lxCaeainfHaltafw =  .Horaaltafw			lxCaeainfBdaltafw =  .Basededatosaltafw			lxCaeainfBdmodifw =  .Basededatosmodificacionfw			lxCaeainfCaea =  .Codcaea_PK 			lxCaeainfResultado2 =  .Resultado2			lxCaeainfObsafip =  .Observacion			lxCaeainfFechaproc2 =  .Fechaproceso2			lxCaeainfNumint =  .Numerointerno			lxCaeainfVigenciad =  .Fechavigenciadesde			lxCaeainfFecha =  .Fecha			lxCaeainfVigenciah =  .Fechavigenciahasta			lxCaeainfFechatope =  .Fechatope			lxCaeainfPtovta =  .Ptoventa			lxCaeainfPeriodo =  .Periodocaea			lxCaeainfQuincena =  .Quincena			lxCaeainfCodigo =  .Codigo
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxCaeainfCodigo = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.CAEAINF ( "Fecexpo","Faltafw","Fecimpo","Fectrans","Fmodifw","Timestamp","Hmodifw","Ualtafw","Saltafw","Vmodifw","Zadsfw","Umodifw","Valtafw","Smodifw","Horaimpo","Esttrans","Horaexpo","Haltafw","Bdaltafw","Bdmodifw","Caea","Resultado2","Obsafip","Fechaproc2","Numint","Vigenciad","Fecha","Vigenciah","Fechatope","Ptovta","Periodo","Quincena","Codigo" ) values ( <<"'" + this.ConvertirDateSql( lxCaeainfFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCaeainfFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCaeainfFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCaeainfFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCaeainfFmodifw ) + "'" >>, <<lxCaeainfTimestamp >>, <<"'" + this.FormatearTextoSql( lxCaeainfHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCaeainfUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCaeainfSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCaeainfVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCaeainfZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCaeainfUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCaeainfValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCaeainfSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCaeainfHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCaeainfEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCaeainfHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCaeainfHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCaeainfBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCaeainfBdmodifw ) + "'" >>, <<lxCaeainfCaea >>, <<"'" + this.FormatearTextoSql( lxCaeainfResultado2 ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCaeainfObsafip ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCaeainfFechaproc2 ) + "'" >>, <<lxCaeainfNumint >>, <<"'" + this.ConvertirDateSql( lxCaeainfVigenciad ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCaeainfFecha ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCaeainfVigenciah ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCaeainfFechatope ) + "'" >>, <<lxCaeainfPtovta >>, <<"'" + this.FormatearTextoSql( lxCaeainfPeriodo ) + "'" >>, <<lxCaeainfQuincena >>, <<"'" + this.FormatearTextoSql( lxCaeainfCodigo ) + "'" >> )
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
		this.ComprobarTransaccion()
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = lxValorClavePrimaria

			.GenerarSentenciasComponentes()
			.EjecutarSentencias( This.ColSentencias )
		this.ComprobarTransaccion()

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.CaeInformaDetalle
				if this.oEntidad.CaeInformaDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxFecha = loItem.Fecha
					lxTipocomp = loItem.Tipocomp
					lxCodigocomp = loItem.Codigocomp
					lxTotalcomp = loItem.Totalcomp
					lxResultado = loItem.Resultado
					lxFechaproceso = loItem.Fechaproceso
					lxComentariosafip = loItem.Comentariosafip
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.CAEAINFDET("NROITEM","Codigo","FechaComp","TipoComp","CodComp","TotalComp","Resultado","FechaProc","ObsAfip" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.ConvertirDateSql( lxFecha ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipocomp ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigocomp ) + "'">>, <<lxTotalcomp>>, <<"'" + this.FormatearTextoSql( lxResultado ) + "'">>, <<"'" + this.ConvertirDateSql( lxFechaproceso ) + "'">>, <<"'" + this.FormatearTextoSql( lxComentariosafip ) + "'">> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor
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
		this.oEntidad.Timestamp = lxCaeainfTimestamp
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
			this.GenerarSentenciasComponentes()
			local  lxCaeainfFecexpo, lxCaeainfFaltafw, lxCaeainfFecimpo, lxCaeainfFectrans, lxCaeainfFmodifw, lxCaeainfTimestamp, lxCaeainfHmodifw, lxCaeainfUaltafw, lxCaeainfSaltafw, lxCaeainfVmodifw, lxCaeainfZadsfw, lxCaeainfUmodifw, lxCaeainfValtafw, lxCaeainfSmodifw, lxCaeainfHoraimpo, lxCaeainfEsttrans, lxCaeainfHoraexpo, lxCaeainfHaltafw, lxCaeainfBdaltafw, lxCaeainfBdmodifw, lxCaeainfCaea, lxCaeainfResultado2, lxCaeainfObsafip, lxCaeainfFechaproc2, lxCaeainfNumint, lxCaeainfVigenciad, lxCaeainfFecha, lxCaeainfVigenciah, lxCaeainfFechatope, lxCaeainfPtovta, lxCaeainfPeriodo, lxCaeainfQuincena, lxCaeainfCodigo
				lxCaeainfFecexpo =  .Fechaexpo			lxCaeainfFaltafw =  .Fechaaltafw			lxCaeainfFecimpo =  .Fechaimpo			lxCaeainfFectrans =  .Fechatransferencia			lxCaeainfFmodifw =  .Fechamodificacionfw			lxCaeainfTimestamp = goLibrerias.ObtenerTimestamp()			lxCaeainfHmodifw =  .Horamodificacionfw			lxCaeainfUaltafw =  .Usuarioaltafw			lxCaeainfSaltafw =  .Seriealtafw			lxCaeainfVmodifw =  .Versionmodificacionfw			lxCaeainfZadsfw =  .Zadsfw			lxCaeainfUmodifw =  .Usuariomodificacionfw			lxCaeainfValtafw =  .Versionaltafw			lxCaeainfSmodifw =  .Seriemodificacionfw			lxCaeainfHoraimpo =  .Horaimpo			lxCaeainfEsttrans =  .Estadotransferencia			lxCaeainfHoraexpo =  .Horaexpo			lxCaeainfHaltafw =  .Horaaltafw			lxCaeainfBdaltafw =  .Basededatosaltafw			lxCaeainfBdmodifw =  .Basededatosmodificacionfw			lxCaeainfCaea =  .Codcaea_PK 			lxCaeainfResultado2 =  .Resultado2			lxCaeainfObsafip =  .Observacion			lxCaeainfFechaproc2 =  .Fechaproceso2			lxCaeainfNumint =  .Numerointerno			lxCaeainfVigenciad =  .Fechavigenciadesde			lxCaeainfFecha =  .Fecha			lxCaeainfVigenciah =  .Fechavigenciahasta			lxCaeainfFechatope =  .Fechatope			lxCaeainfPtovta =  .Ptoventa			lxCaeainfPeriodo =  .Periodocaea			lxCaeainfQuincena =  .Quincena			lxCaeainfCodigo =  .Codigo
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
				update ZooLogic.CAEAINF set "Fecexpo" = <<"'" + this.ConvertirDateSql( lxCaeainfFecexpo ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxCaeainfFaltafw ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxCaeainfFecimpo ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxCaeainfFectrans ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxCaeainfFmodifw ) + "'">>,"Timestamp" = <<lxCaeainfTimestamp>>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxCaeainfHmodifw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxCaeainfUaltafw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxCaeainfSaltafw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxCaeainfVmodifw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxCaeainfZadsfw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxCaeainfUmodifw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxCaeainfValtafw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxCaeainfSmodifw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxCaeainfHoraimpo ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxCaeainfEsttrans ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxCaeainfHoraexpo ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxCaeainfHaltafw ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxCaeainfBdaltafw ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxCaeainfBdmodifw ) + "'">>,"Caea" = <<lxCaeainfCaea>>,"Resultado2" = <<"'" + this.FormatearTextoSql( lxCaeainfResultado2 ) + "'">>,"Obsafip" = <<"'" + this.FormatearTextoSql( lxCaeainfObsafip ) + "'">>,"Fechaproc2" = <<"'" + this.ConvertirDateSql( lxCaeainfFechaproc2 ) + "'">>,"Numint" = <<lxCaeainfNumint>>,"Vigenciad" = <<"'" + this.ConvertirDateSql( lxCaeainfVigenciad ) + "'">>,"Fecha" = <<"'" + this.ConvertirDateSql( lxCaeainfFecha ) + "'">>,"Vigenciah" = <<"'" + this.ConvertirDateSql( lxCaeainfVigenciah ) + "'">>,"Fechatope" = <<"'" + this.ConvertirDateSql( lxCaeainfFechatope ) + "'">>,"Ptovta" = <<lxCaeainfPtovta>>,"Periodo" = <<"'" + this.FormatearTextoSql( lxCaeainfPeriodo ) + "'">>,"Quincena" = <<lxCaeainfQuincena>>,"Codigo" = <<"'" + this.FormatearTextoSql( lxCaeainfCodigo ) + "'">> where "Codigo" = <<"'" + this.FormatearTextoSql( lxCaeainfCodigo ) + "'">> and  CAEAINF.CODIGO != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			this.ComprobarResultadoDeEjecucionDelUpdate()
		this.ComprobarTransaccion()
			.EjecutarSentencias( This.ColSentencias )
		this.ComprobarTransaccion()
			this.oConexion.EjecutarSql( 'delete from ZooLogic.CAEAINFDET where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.CaeInformaDetalle
				if this.oEntidad.CaeInformaDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxFecha = loItem.Fecha
					lxTipocomp = loItem.Tipocomp
					lxCodigocomp = loItem.Codigocomp
					lxTotalcomp = loItem.Totalcomp
					lxResultado = loItem.Resultado
					lxFechaproceso = loItem.Fechaproceso
					lxComentariosafip = loItem.Comentariosafip
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.CAEAINFDET("NROITEM","Codigo","FechaComp","TipoComp","CodComp","TotalComp","Resultado","FechaProc","ObsAfip" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.ConvertirDateSql( lxFecha ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipocomp ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigocomp ) + "'">>, <<lxTotalcomp>>, <<"'" + this.FormatearTextoSql( lxResultado ) + "'">>, <<"'" + this.ConvertirDateSql( lxFechaproceso ) + "'">>, <<"'" + this.FormatearTextoSql( lxComentariosafip ) + "'">> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor
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
		this.oEntidad.Timestamp = lxCaeainfTimestamp
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 Codigo from ZooLogic.CAEAINF where " + this.ConvertirFuncionesSql( " CAEAINF.CODIGO != ''" ) )
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
			Local lxCaeainfCodigo
			lxCaeainfCodigo = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Timestamp" as "Timestamp", "Hmodifw" as "Horamodificacionfw", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Caea" as "Codcaea", "Resultado2" as "Resultado2", "Obsafip" as "Observacion", "Fechaproc2" as "Fechaproceso2", "Numint" as "Numerointerno", "Vigenciad" as "Fechavigenciadesde", "Fecha" as "Fecha", "Vigenciah" as "Fechavigenciahasta", "Fechatope" as "Fechatope", "Ptovta" as "Ptoventa", "Periodo" as "Periodocaea", "Quincena" as "Quincena", "Codigo" as "Codigo" from ZooLogic.CAEAINF where "Codigo" = <<"'" + this.FormatearTextoSql( lxCaeainfCodigo ) + "'">> and  CAEAINF.CODIGO != ''
			endtext
			use in select('c_CAEAINFORMA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CAEAINFORMA', set( 'Datasession' ) )

			if reccount( 'c_CAEAINFORMA' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Fechacomp" as "Fecha", "Tipocomp" as "Tipocomp", "Codcomp" as "Codigocomp", "Totalcomp" as "Totalcomp", "Resultado" as "Resultado", "Fechaproc" as "Fechaproceso", "Obsafip" as "Comentariosafip" from ZooLogic.CAEAINFDET where Codigo = <<"'" + this.FormatearTextoSql( c_CAEAINFORMA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_CaeInformaDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CaeInformaDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_CaeInformaDetalle
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxCaeainfCodigo as Variant
		llRetorno = .t.
		lxCaeainfCodigo = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.CAEAINF where "Codigo" = <<"'" + this.FormatearTextoSql( lxCaeainfCodigo ) + "'">> and  CAEAINF.CODIGO != ''
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
				lcOrden =  str( .NumeroInterno, 15, 0) + .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Timestamp" as "Timestamp", "Hmodifw" as "Horamodificacionfw", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Caea" as "Codcaea", "Resultado2" as "Resultado2", "Obsafip" as "Observacion", "Fechaproc2" as "Fechaproceso2", "Numint" as "Numerointerno", "Vigenciad" as "Fechavigenciadesde", "Fecha" as "Fecha", "Vigenciah" as "Fechavigenciahasta", "Fechatope" as "Fechatope", "Ptovta" as "Ptoventa", "Periodo" as "Periodocaea", "Quincena" as "Quincena", "Codigo" as "Codigo" from ZooLogic.CAEAINF where  CAEAINF.CODIGO != '' order by NumInt,Codigo
			endtext
			use in select('c_CAEAINFORMA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CAEAINFORMA', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Fechacomp" as "Fecha", "Tipocomp" as "Tipocomp", "Codcomp" as "Codigocomp", "Totalcomp" as "Totalcomp", "Resultado" as "Resultado", "Fechaproc" as "Fechaproceso", "Obsafip" as "Comentariosafip" from ZooLogic.CAEAINFDET where Codigo = <<"'" + this.FormatearTextoSql( c_CAEAINFORMA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_CaeInformaDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CaeInformaDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_CaeInformaDetalle
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
				lcOrden =  str( .NumeroInterno, 15, 0) + .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Timestamp" as "Timestamp", "Hmodifw" as "Horamodificacionfw", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Caea" as "Codcaea", "Resultado2" as "Resultado2", "Obsafip" as "Observacion", "Fechaproc2" as "Fechaproceso2", "Numint" as "Numerointerno", "Vigenciad" as "Fechavigenciadesde", "Fecha" as "Fecha", "Vigenciah" as "Fechavigenciahasta", "Fechatope" as "Fechatope", "Ptovta" as "Ptoventa", "Periodo" as "Periodocaea", "Quincena" as "Quincena", "Codigo" as "Codigo" from ZooLogic.CAEAINF where  str( NumInt, 15, 0) + funciones.padr( Codigo, 38, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  CAEAINF.CODIGO != '' order by NumInt,Codigo
			endtext
			use in select('c_CAEAINFORMA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CAEAINFORMA', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Fechacomp" as "Fecha", "Tipocomp" as "Tipocomp", "Codcomp" as "Codigocomp", "Totalcomp" as "Totalcomp", "Resultado" as "Resultado", "Fechaproc" as "Fechaproceso", "Obsafip" as "Comentariosafip" from ZooLogic.CAEAINFDET where Codigo = <<"'" + this.FormatearTextoSql( c_CAEAINFORMA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_CaeInformaDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CaeInformaDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_CaeInformaDetalle
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
				lcOrden =  str( .NumeroInterno, 15, 0) + .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Timestamp" as "Timestamp", "Hmodifw" as "Horamodificacionfw", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Caea" as "Codcaea", "Resultado2" as "Resultado2", "Obsafip" as "Observacion", "Fechaproc2" as "Fechaproceso2", "Numint" as "Numerointerno", "Vigenciad" as "Fechavigenciadesde", "Fecha" as "Fecha", "Vigenciah" as "Fechavigenciahasta", "Fechatope" as "Fechatope", "Ptovta" as "Ptoventa", "Periodo" as "Periodocaea", "Quincena" as "Quincena", "Codigo" as "Codigo" from ZooLogic.CAEAINF where  str( NumInt, 15, 0) + funciones.padr( Codigo, 38, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  CAEAINF.CODIGO != '' order by NumInt desc,Codigo desc
			endtext
			use in select('c_CAEAINFORMA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CAEAINFORMA', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Fechacomp" as "Fecha", "Tipocomp" as "Tipocomp", "Codcomp" as "Codigocomp", "Totalcomp" as "Totalcomp", "Resultado" as "Resultado", "Fechaproc" as "Fechaproceso", "Obsafip" as "Comentariosafip" from ZooLogic.CAEAINFDET where Codigo = <<"'" + this.FormatearTextoSql( c_CAEAINFORMA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_CaeInformaDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CaeInformaDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_CaeInformaDetalle
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
				lcOrden =  str( .NumeroInterno, 15, 0) + .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Timestamp" as "Timestamp", "Hmodifw" as "Horamodificacionfw", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Caea" as "Codcaea", "Resultado2" as "Resultado2", "Obsafip" as "Observacion", "Fechaproc2" as "Fechaproceso2", "Numint" as "Numerointerno", "Vigenciad" as "Fechavigenciadesde", "Fecha" as "Fecha", "Vigenciah" as "Fechavigenciahasta", "Fechatope" as "Fechatope", "Ptovta" as "Ptoventa", "Periodo" as "Periodocaea", "Quincena" as "Quincena", "Codigo" as "Codigo" from ZooLogic.CAEAINF where  CAEAINF.CODIGO != '' order by NumInt desc,Codigo desc
			endtext
			use in select('c_CAEAINFORMA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CAEAINFORMA', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Fechacomp" as "Fecha", "Tipocomp" as "Tipocomp", "Codcomp" as "Codigocomp", "Totalcomp" as "Totalcomp", "Resultado" as "Resultado", "Fechaproc" as "Fechaproceso", "Obsafip" as "Comentariosafip" from ZooLogic.CAEAINFDET where Codigo = <<"'" + this.FormatearTextoSql( c_CAEAINFORMA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_CaeInformaDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CaeInformaDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_CaeInformaDetalle
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
			lcXml = this.oConexion.EjecutarSql( "select Fecexpo,Faltafw,Fecimpo,Fectrans,Fmodifw,Timestamp,Hmodifw,Ualtafw,Saltafw,Vmodifw,Zadsfw,Um" + ;
"odifw,Valtafw,Smodifw,Horaimpo,Esttrans,Horaexpo,Haltafw,Bdaltafw,Bdmodifw,Caea,Resultado2,Obsafip,F" + ;
"echaproc2,Numint,Vigenciad,Fecha,Vigenciah,Fechatope,Ptovta,Periodo,Quincena,Codigo" + ;
" from ZooLogic.CAEAINF where  CAEAINF.CODIGO != '' and " + lcFiltro )
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
			local  lxCaeainfFecexpo, lxCaeainfFaltafw, lxCaeainfFecimpo, lxCaeainfFectrans, lxCaeainfFmodifw, lxCaeainfTimestamp, lxCaeainfHmodifw, lxCaeainfUaltafw, lxCaeainfSaltafw, lxCaeainfVmodifw, lxCaeainfZadsfw, lxCaeainfUmodifw, lxCaeainfValtafw, lxCaeainfSmodifw, lxCaeainfHoraimpo, lxCaeainfEsttrans, lxCaeainfHoraexpo, lxCaeainfHaltafw, lxCaeainfBdaltafw, lxCaeainfBdmodifw, lxCaeainfCaea, lxCaeainfResultado2, lxCaeainfObsafip, lxCaeainfFechaproc2, lxCaeainfNumint, lxCaeainfVigenciad, lxCaeainfFecha, lxCaeainfVigenciah, lxCaeainfFechatope, lxCaeainfPtovta, lxCaeainfPeriodo, lxCaeainfQuincena, lxCaeainfCodigo
				lxCaeainfFecexpo = ctod( '  /  /    ' )			lxCaeainfFaltafw = ctod( '  /  /    ' )			lxCaeainfFecimpo = ctod( '  /  /    ' )			lxCaeainfFectrans = ctod( '  /  /    ' )			lxCaeainfFmodifw = ctod( '  /  /    ' )			lxCaeainfTimestamp = goLibrerias.ObtenerTimestamp()			lxCaeainfHmodifw = []			lxCaeainfUaltafw = []			lxCaeainfSaltafw = []			lxCaeainfVmodifw = []			lxCaeainfZadsfw = []			lxCaeainfUmodifw = []			lxCaeainfValtafw = []			lxCaeainfSmodifw = []			lxCaeainfHoraimpo = []			lxCaeainfEsttrans = []			lxCaeainfHoraexpo = []			lxCaeainfHaltafw = []			lxCaeainfBdaltafw = []			lxCaeainfBdmodifw = []			lxCaeainfCaea = 0			lxCaeainfResultado2 = []			lxCaeainfObsafip = []			lxCaeainfFechaproc2 = ctod( '  /  /    ' )			lxCaeainfNumint = 0			lxCaeainfVigenciad = ctod( '  /  /    ' )			lxCaeainfFecha = ctod( '  /  /    ' )			lxCaeainfVigenciah = ctod( '  /  /    ' )			lxCaeainfFechatope = ctod( '  /  /    ' )			lxCaeainfPtovta = 0			lxCaeainfPeriodo = []			lxCaeainfQuincena = 0			lxCaeainfCodigo = []
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.CAEAINFDET where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( [delete from ZooLogic.CAEAINF where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			.GenerarSentenciasComponentes()
			.EjecutarSentencias( This.ColSentencias )
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
			lcTabla = 'CAEAINF' + '_' + tcCampo
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
		lcWhere = " Where  CAEAINF.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Timestamp" as "Timestamp", "Hmodifw" as "Horamodificacionfw", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Caea" as "Codcaea", "Resultado2" as "Resultado2", "Obsafip" as "Observacion", "Fechaproc2" as "Fechaproceso2", "Numint" as "Numerointerno", "Vigenciad" as "Fechavigenciadesde", "Fecha" as "Fecha", "Vigenciah" as "Fechavigenciahasta", "Fechatope" as "Fechatope", "Ptovta" as "Ptoventa", "Periodo" as "Periodocaea", "Quincena" as "Quincena", "Codigo" as "Codigo"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'CAEAINF', '', tnTope )
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
	Function ObtenerDatosDetalleCaeInformaDetalle( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  CAEAINFDET.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Nroitem" as "Nroitem", "Codigo" as "Codigo", "Fechacomp" as "Fecha", "Tipocomp" as "Tipocomp", "Codcomp" as "Codigocomp", "Totalcomp" as "Totalcomp", "Resultado" as "Resultado", "Fechaproc" as "Fechaproceso", "Obsafip" as "Comentariosafip"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleCaeInformaDetalle( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'CAEAINFDET', 'CaeInformaDetalle', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleCaeInformaDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleCaeInformaDetalle( lcAtributo )
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
				Case lcAtributo == 'FECHATRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRANS AS FECHATRANSFERENCIA'
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'TIMESTAMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIMESTAMP AS TIMESTAMP'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'CODCAEA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CAEA AS CODCAEA'
				Case lcAtributo == 'RESULTADO2'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RESULTADO2 AS RESULTADO2'
				Case lcAtributo == 'OBSERVACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'OBSAFIP AS OBSERVACION'
				Case lcAtributo == 'FECHAPROCESO2'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHAPROC2 AS FECHAPROCESO2'
				Case lcAtributo == 'NUMEROINTERNO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NUMINT AS NUMEROINTERNO'
				Case lcAtributo == 'FECHAVIGENCIADESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VIGENCIAD AS FECHAVIGENCIADESDE'
				Case lcAtributo == 'FECHA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHA AS FECHA'
				Case lcAtributo == 'FECHAVIGENCIAHASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VIGENCIAH AS FECHAVIGENCIAHASTA'
				Case lcAtributo == 'FECHATOPE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHATOPE AS FECHATOPE'
				Case lcAtributo == 'PTOVENTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PTOVTA AS PTOVENTA'
				Case lcAtributo == 'PERIODOCAEA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PERIODO AS PERIODOCAEA'
				Case lcAtributo == 'QUINCENA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'QUINCENA AS QUINCENA'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleCaeInformaDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'FECHA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHACOMP AS FECHA'
				Case lcAtributo == 'TIPOCOMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPOCOMP AS TIPOCOMP'
				Case lcAtributo == 'CODIGOCOMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODCOMP AS CODIGOCOMP'
				Case lcAtributo == 'TOTALCOMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TOTALCOMP AS TOTALCOMP'
				Case lcAtributo == 'RESULTADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RESULTADO AS RESULTADO'
				Case lcAtributo == 'FECHAPROCESO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHAPROC AS FECHAPROCESO'
				Case lcAtributo == 'COMENTARIOSAFIP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'OBSAFIP AS COMENTARIOSAFIP'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'TIMESTAMP'
				lcCampo = 'TIMESTAMP'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'CODCAEA'
				lcCampo = 'CAEA'
			Case upper( alltrim( tcAtributo ) ) == 'RESULTADO2'
				lcCampo = 'RESULTADO2'
			Case upper( alltrim( tcAtributo ) ) == 'OBSERVACION'
				lcCampo = 'OBSAFIP'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAPROCESO2'
				lcCampo = 'FECHAPROC2'
			Case upper( alltrim( tcAtributo ) ) == 'NUMEROINTERNO'
				lcCampo = 'NUMINT'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAVIGENCIADESDE'
				lcCampo = 'VIGENCIAD'
			Case upper( alltrim( tcAtributo ) ) == 'FECHA'
				lcCampo = 'FECHA'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAVIGENCIAHASTA'
				lcCampo = 'VIGENCIAH'
			Case upper( alltrim( tcAtributo ) ) == 'FECHATOPE'
				lcCampo = 'FECHATOPE'
			Case upper( alltrim( tcAtributo ) ) == 'PTOVENTA'
				lcCampo = 'PTOVTA'
			Case upper( alltrim( tcAtributo ) ) == 'PERIODOCAEA'
				lcCampo = 'PERIODO'
			Case upper( alltrim( tcAtributo ) ) == 'QUINCENA'
				lcCampo = 'QUINCENA'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleCaeInformaDetalle( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHA'
				lcCampo = 'FECHACOMP'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOCOMP'
				lcCampo = 'TIPOCOMP'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGOCOMP'
				lcCampo = 'CODCOMP'
			Case upper( alltrim( tcAtributo ) ) == 'TOTALCOMP'
				lcCampo = 'TOTALCOMP'
			Case upper( alltrim( tcAtributo ) ) == 'RESULTADO'
				lcCampo = 'RESULTADO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAPROCESO'
				lcCampo = 'FECHAPROC'
			Case upper( alltrim( tcAtributo ) ) == 'COMENTARIOSAFIP'
				lcCampo = 'OBSAFIP'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerTablaDetalle( tcDetalle as string ) as String
		local lcRetorno as string
		lcRetorno = ''
		if upper( alltrim( tcDetalle ) ) == 'CAEINFORMADETALLE'
			lcRetorno = 'CAEAINFDET'
		EndIf
		return lcRetorno
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasInsert() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcSentencia as string, loItem as object
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxCaeainfFecexpo, lxCaeainfFaltafw, lxCaeainfFecimpo, lxCaeainfFectrans, lxCaeainfFmodifw, lxCaeainfTimestamp, lxCaeainfHmodifw, lxCaeainfUaltafw, lxCaeainfSaltafw, lxCaeainfVmodifw, lxCaeainfZadsfw, lxCaeainfUmodifw, lxCaeainfValtafw, lxCaeainfSmodifw, lxCaeainfHoraimpo, lxCaeainfEsttrans, lxCaeainfHoraexpo, lxCaeainfHaltafw, lxCaeainfBdaltafw, lxCaeainfBdmodifw, lxCaeainfCaea, lxCaeainfResultado2, lxCaeainfObsafip, lxCaeainfFechaproc2, lxCaeainfNumint, lxCaeainfVigenciad, lxCaeainfFecha, lxCaeainfVigenciah, lxCaeainfFechatope, lxCaeainfPtovta, lxCaeainfPeriodo, lxCaeainfQuincena, lxCaeainfCodigo
				lxCaeainfFecexpo =  .Fechaexpo			lxCaeainfFaltafw =  .Fechaaltafw			lxCaeainfFecimpo =  .Fechaimpo			lxCaeainfFectrans =  .Fechatransferencia			lxCaeainfFmodifw =  .Fechamodificacionfw			lxCaeainfTimestamp = goLibrerias.ObtenerTimestamp()			lxCaeainfHmodifw =  .Horamodificacionfw			lxCaeainfUaltafw =  .Usuarioaltafw			lxCaeainfSaltafw =  .Seriealtafw			lxCaeainfVmodifw =  .Versionmodificacionfw			lxCaeainfZadsfw =  .Zadsfw			lxCaeainfUmodifw =  .Usuariomodificacionfw			lxCaeainfValtafw =  .Versionaltafw			lxCaeainfSmodifw =  .Seriemodificacionfw			lxCaeainfHoraimpo =  .Horaimpo			lxCaeainfEsttrans =  .Estadotransferencia			lxCaeainfHoraexpo =  .Horaexpo			lxCaeainfHaltafw =  .Horaaltafw			lxCaeainfBdaltafw =  .Basededatosaltafw			lxCaeainfBdmodifw =  .Basededatosmodificacionfw			lxCaeainfCaea =  .Codcaea_PK 			lxCaeainfResultado2 =  .Resultado2			lxCaeainfObsafip =  .Observacion			lxCaeainfFechaproc2 =  .Fechaproceso2			lxCaeainfNumint =  .Numerointerno			lxCaeainfVigenciad =  .Fechavigenciadesde			lxCaeainfFecha =  .Fecha			lxCaeainfVigenciah =  .Fechavigenciahasta			lxCaeainfFechatope =  .Fechatope			lxCaeainfPtovta =  .Ptoventa			lxCaeainfPeriodo =  .Periodocaea			lxCaeainfQuincena =  .Quincena			lxCaeainfCodigo =  .Codigo
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.CAEAINF ( "Fecexpo","Faltafw","Fecimpo","Fectrans","Fmodifw","Timestamp","Hmodifw","Ualtafw","Saltafw","Vmodifw","Zadsfw","Umodifw","Valtafw","Smodifw","Horaimpo","Esttrans","Horaexpo","Haltafw","Bdaltafw","Bdmodifw","Caea","Resultado2","Obsafip","Fechaproc2","Numint","Vigenciad","Fecha","Vigenciah","Fechatope","Ptovta","Periodo","Quincena","Codigo" ) values ( <<"'" + this.ConvertirDateSql( lxCaeainfFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCaeainfFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCaeainfFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCaeainfFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCaeainfFmodifw ) + "'" >>, <<lxCaeainfTimestamp >>, <<"'" + this.FormatearTextoSql( lxCaeainfHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCaeainfUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCaeainfSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCaeainfVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCaeainfZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCaeainfUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCaeainfValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCaeainfSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCaeainfHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCaeainfEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCaeainfHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCaeainfHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCaeainfBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCaeainfBdmodifw ) + "'" >>, <<lxCaeainfCaea >>, <<"'" + this.FormatearTextoSql( lxCaeainfResultado2 ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCaeainfObsafip ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCaeainfFechaproc2 ) + "'" >>, <<lxCaeainfNumint >>, <<"'" + this.ConvertirDateSql( lxCaeainfVigenciad ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCaeainfFecha ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCaeainfVigenciah ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCaeainfFechatope ) + "'" >>, <<lxCaeainfPtovta >>, <<"'" + this.FormatearTextoSql( lxCaeainfPeriodo ) + "'" >>, <<lxCaeainfQuincena >>, <<"'" + this.FormatearTextoSql( lxCaeainfCodigo ) + "'" >> )
		endtext
		loColeccion.cTabla = 'CAEAINF' 
		loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		With this
			local lcValorClavePrimariaString as String
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.CaeInformaDetalle
				if this.oEntidad.CaeInformaDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxFecha = loItem.Fecha
					lxTipocomp = loItem.Tipocomp
					lxCodigocomp = loItem.Codigocomp
					lxTotalcomp = loItem.Totalcomp
					lxResultado = loItem.Resultado
					lxFechaproceso = loItem.Fechaproceso
					lxComentariosafip = loItem.Comentariosafip
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.CAEAINFDET("NROITEM","Codigo","FechaComp","TipoComp","CodComp","TotalComp","Resultado","FechaProc","ObsAfip" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.ConvertirDateSql( lxFecha ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipocomp ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigocomp ) + "'">>, <<lxTotalcomp>>, <<"'" + this.FormatearTextoSql( lxResultado ) + "'">>, <<"'" + this.ConvertirDateSql( lxFechaproceso ) + "'">>, <<"'" + this.FormatearTextoSql( lxComentariosafip ) + "'">> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor
		EndWith
		return loColeccion
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasUpdate() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcFiltro as string, loItem as object, lcSentencia as string, lcSentencia as string
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxCaeainfFecexpo, lxCaeainfFaltafw, lxCaeainfFecimpo, lxCaeainfFectrans, lxCaeainfFmodifw, lxCaeainfTimestamp, lxCaeainfHmodifw, lxCaeainfUaltafw, lxCaeainfSaltafw, lxCaeainfVmodifw, lxCaeainfZadsfw, lxCaeainfUmodifw, lxCaeainfValtafw, lxCaeainfSmodifw, lxCaeainfHoraimpo, lxCaeainfEsttrans, lxCaeainfHoraexpo, lxCaeainfHaltafw, lxCaeainfBdaltafw, lxCaeainfBdmodifw, lxCaeainfCaea, lxCaeainfResultado2, lxCaeainfObsafip, lxCaeainfFechaproc2, lxCaeainfNumint, lxCaeainfVigenciad, lxCaeainfFecha, lxCaeainfVigenciah, lxCaeainfFechatope, lxCaeainfPtovta, lxCaeainfPeriodo, lxCaeainfQuincena, lxCaeainfCodigo
				lxCaeainfFecexpo =  .Fechaexpo			lxCaeainfFaltafw =  .Fechaaltafw			lxCaeainfFecimpo =  .Fechaimpo			lxCaeainfFectrans =  .Fechatransferencia			lxCaeainfFmodifw =  .Fechamodificacionfw			lxCaeainfTimestamp = goLibrerias.ObtenerTimestamp()			lxCaeainfHmodifw =  .Horamodificacionfw			lxCaeainfUaltafw =  .Usuarioaltafw			lxCaeainfSaltafw =  .Seriealtafw			lxCaeainfVmodifw =  .Versionmodificacionfw			lxCaeainfZadsfw =  .Zadsfw			lxCaeainfUmodifw =  .Usuariomodificacionfw			lxCaeainfValtafw =  .Versionaltafw			lxCaeainfSmodifw =  .Seriemodificacionfw			lxCaeainfHoraimpo =  .Horaimpo			lxCaeainfEsttrans =  .Estadotransferencia			lxCaeainfHoraexpo =  .Horaexpo			lxCaeainfHaltafw =  .Horaaltafw			lxCaeainfBdaltafw =  .Basededatosaltafw			lxCaeainfBdmodifw =  .Basededatosmodificacionfw			lxCaeainfCaea =  .Codcaea_PK 			lxCaeainfResultado2 =  .Resultado2			lxCaeainfObsafip =  .Observacion			lxCaeainfFechaproc2 =  .Fechaproceso2			lxCaeainfNumint =  .Numerointerno			lxCaeainfVigenciad =  .Fechavigenciadesde			lxCaeainfFecha =  .Fecha			lxCaeainfVigenciah =  .Fechavigenciahasta			lxCaeainfFechatope =  .Fechatope			lxCaeainfPtovta =  .Ptoventa			lxCaeainfPeriodo =  .Periodocaea			lxCaeainfQuincena =  .Quincena			lxCaeainfCodigo =  .Codigo
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  CAEAINF.CODIGO != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.CAEAINF set "Fecexpo" = <<"'" + this.ConvertirDateSql( lxCaeainfFecexpo ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxCaeainfFaltafw ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxCaeainfFecimpo ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxCaeainfFectrans ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxCaeainfFmodifw ) + "'">>, "Timestamp" = <<lxCaeainfTimestamp>>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxCaeainfHmodifw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxCaeainfUaltafw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxCaeainfSaltafw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxCaeainfVmodifw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxCaeainfZadsfw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxCaeainfUmodifw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxCaeainfValtafw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxCaeainfSmodifw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxCaeainfHoraimpo ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxCaeainfEsttrans ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxCaeainfHoraexpo ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxCaeainfHaltafw ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxCaeainfBdaltafw ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxCaeainfBdmodifw ) + "'">>, "Caea" = <<lxCaeainfCaea>>, "Resultado2" = <<"'" + this.FormatearTextoSql( lxCaeainfResultado2 ) + "'">>, "Obsafip" = <<"'" + this.FormatearTextoSql( lxCaeainfObsafip ) + "'">>, "Fechaproc2" = <<"'" + this.ConvertirDateSql( lxCaeainfFechaproc2 ) + "'">>, "Numint" = <<lxCaeainfNumint>>, "Vigenciad" = <<"'" + this.ConvertirDateSql( lxCaeainfVigenciad ) + "'">>, "Fecha" = <<"'" + this.ConvertirDateSql( lxCaeainfFecha ) + "'">>, "Vigenciah" = <<"'" + this.ConvertirDateSql( lxCaeainfVigenciah ) + "'">>, "Fechatope" = <<"'" + this.ConvertirDateSql( lxCaeainfFechatope ) + "'">>, "Ptovta" = <<lxCaeainfPtovta>>, "Periodo" = <<"'" + this.FormatearTextoSql( lxCaeainfPeriodo ) + "'">>, "Quincena" = <<lxCaeainfQuincena>>, "Codigo" = <<"'" + this.FormatearTextoSql( lxCaeainfCodigo ) + "'">> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'CAEAINF' 
		loColeccion.agregar( strtran(  lcSentencia, chr( 9 ), '' ) )
			loColeccion.Agregar([delete from ZooLogic.CAEAINFDET where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.CaeInformaDetalle
				if this.oEntidad.CaeInformaDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxFecha = loItem.Fecha
					lxTipocomp = loItem.Tipocomp
					lxCodigocomp = loItem.Codigocomp
					lxTotalcomp = loItem.Totalcomp
					lxResultado = loItem.Resultado
					lxFechaproceso = loItem.Fechaproceso
					lxComentariosafip = loItem.Comentariosafip
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.CAEAINFDET("NROITEM","Codigo","FechaComp","TipoComp","CodComp","TotalComp","Resultado","FechaProc","ObsAfip" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.ConvertirDateSql( lxFecha ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipocomp ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigocomp ) + "'">>, <<lxTotalcomp>>, <<"'" + this.FormatearTextoSql( lxResultado ) + "'">>, <<"'" + this.ConvertirDateSql( lxFechaproceso ) + "'">>, <<"'" + this.FormatearTextoSql( lxComentariosafip ) + "'">> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor
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

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  CAEAINF.CODIGO != '']
		loColeccion.Agregar( 'delete from ZooLogic.CAEAINF where ' + lcFiltro )
			loColeccion.Agregar([delete from ZooLogic.CAEAINFDET where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.cTabla = 'CAEAINF' 
		EndWith
		return loColeccion
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerObjetoBusqueda() as Void
		return newobject( 'ObjetoBusqueda', '', '', this.oEntidad )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function GenerarSentenciasComponentes() as void
		local loColSentencias as ZooColeccion of zooColeccion.prg, lcItem as String
		dodefault()
		this.colSentencias.Remove( -1 )

	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ObtenerSentenciaActualizacionTimeStamp() As String
		local lnTimeStamp as integer, lcRetorno as string, lcUpdateRealTime as string
		with this.oEntidad
		
			lnTimeStamp = goLibrerias.ObtenerTimestamp()
			lcUpdateRealTime = ", "+this.obtenercampoentidad("fechamodificacionfw")+" = "+goServicios.Datos.ObtenerFechaFormateada(goServicios.Librerias.ObtenerFecha());
			+ ", "+this.obtenercampoentidad("horamodificacionfw")+" = '"+goServicios.Librerias.ObtenerHora()+"'"
			lcRetorno = [update ZooLogic.CAEAINF set TimeStamp = ] + transform( lnTimeStamp ) + lcUpdateRealTime + [ where Codigo = ] + "'" + this.FormatearTextoSql( .Codigo ) + "'" + [ and  CAEAINF.CODIGO != ''] + goServicios.RealTime.ObtenerTagEstimulo( .cNombre )
		
		endwith
		return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function ObtenerCantidadRegistros() as integer
		local lnCantReg as integer
			local lcXml as string
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.CAEAINF where  CAEAINF.CODIGO != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.CAEAINF where Codigo = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  CAEAINF.CODIGO != ''" )
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
					if empty( .oNumeraciones.ObtenerServicio('NUMEROINTERNO') ) and iif( type( '.NUMEROINTERNO' ) = 'C', int( val( .NUMEROINTERNO ) ),.NUMEROINTERNO ) = .oNumeraciones.UltimoNumero( 'NUMEROINTERNO' )
						.oNumeraciones.Actualizar( 'NUMEROINTERNO' )
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
					.NUMEROINTERNO = .oNumeraciones.grabar( 'NUMEROINTERNO' )
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
		lcCursor = This.oEntidad.cPrefijoRecibir + 'CAEAINFORMA'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.CAEAINF Where Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'", 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					this.oConexion.EjecutarSql( [UPDATE ZooLogic.CAEAINF set  FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, TIMESTAMP = ] + transform( &lcCursor..TIMESTAMP )+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, CAEA = ] + transform( &lcCursor..CAEA )+ [, Resultado2 = ] + "'" + this.FormatearTextoSql( &lcCursor..Resultado2 ) + "'"+ [, ObsAfip = ] + "'" + this.FormatearTextoSql( &lcCursor..ObsAfip ) + "'"+ [, FechaProc2 = ] + "'" + this.ConvertirDateSql( &lcCursor..FechaProc2 ) + "'"+ [, NumInt = ] + transform( &lcCursor..NumInt )+ [, VigenciaD = ] + "'" + this.ConvertirDateSql( &lcCursor..VigenciaD ) + "'"+ [, FECHA = ] + "'" + this.ConvertirDateSql( &lcCursor..FECHA ) + "'"+ [, VigenciaH = ] + "'" + this.ConvertirDateSql( &lcCursor..VigenciaH ) + "'"+ [, FechaTope = ] + "'" + this.ConvertirDateSql( &lcCursor..FechaTope ) + "'"+ [, PtoVta = ] + transform( &lcCursor..PtoVta )+ [, Periodo = ] + "'" + this.FormatearTextoSql( &lcCursor..Periodo ) + "'"+ [, Quincena = ] + transform( &lcCursor..Quincena )+ [, Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'" + [ Where Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'" )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
				endIf
			else
				Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
				Text to lcCampos noShow
					 FECEXPO, FALTAFW, FECIMPO, FECTRANS, FMODIFW, TIMESTAMP, HMODIFW, UALTAFW, SALTAFW, VMODIFW, ZADSFW, UMODIFW, VALTAFW, SMODIFW, HORAIMPO, ESTTRANS, HORAEXPO, HALTAFW, BDALTAFW, BDMODIFW, CAEA, Resultado2, ObsAfip, FechaProc2, NumInt, VigenciaD, FECHA, VigenciaH, FechaTope, PtoVta, Periodo, Quincena, Codigo
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + transform( &lcCursor..TIMESTAMP ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + transform( &lcCursor..CAEA )
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..Resultado2 ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ObsAfip ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FechaProc2 ) + "'" + ',' + transform( &lcCursor..NumInt ) + ',' + "'" + this.ConvertirDateSql( &lcCursor..VigenciaD ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECHA ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..VigenciaH ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FechaTope ) + "'" + ',' + transform( &lcCursor..PtoVta ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..Periodo ) + "'" + ',' + transform( &lcCursor..Quincena ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'"
lcValoresCampos = substr(lcValoresCampos,2) 

				this.oConexion.EjecutarSql( [Insert into ZooLogic.CAEAINF ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
				this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'CAEAINFORMA'
		if This.ActualizaEnRecepcion()
		Local lcIn as String, lcCantRegistros as Integer
		Select( lcCursor )
		Count to lcCantRegistros
		If lcCantRegistros > 0
			lcIn = This.ObtenerInSqlServer( lcCursor, 'Codigo','C')
			lnFragmento = goRegistry.nucleo.cantidadDeElementosEnSentenciaInSQL
			loIn = this.ObtenerColeccionInSqlServer( lcCursor,'','Codigo')
			llEjecutaEnTransaccion = loIn.count > 0
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'BEGIN TRANSACTION' )
			endif
			for i = 1 to loIn.count step lnFragmento
				lcIn = this.ObtenerFragmentoColeccionInSqlServer( loIn, i, lnFragmento )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.CAEAINFDET Where Codigo] + lcIn  )
			endfor
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'COMMIT TRANSACTION' )
			endif
		EndIf
	endif
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMCAEAINFORMA'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where Codigo in ( select Codigo from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"NROITEM","Codigo","FechaComp","TipoComp","CodComp","TotalComp","Resultado","FechaProc","ObsAfip"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.CAEAINFDET ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Codigo     ) + "'" + ',' + "'" + this.ConvertirDateSql( cDetallesExistentes.FechaComp  ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.TipoComp   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CodComp    ) + "'" + ',' + transform( cDetallesExistentes.TotalComp  ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Resultado  ) + "'" + ',' + "'" + this.ConvertirDateSql( cDetallesExistentes.FechaProc  ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ObsAfip    ) + "'" + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
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
			Case  lcAlias == lcPrefijo + 'CAEAINFORMA'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'CAEAINFORMA_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'CAEAINFORMA_OBSAFIP'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMCAEAINFORMA'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_CAEAINF')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'CAEAINFORMA'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..Codigo
		llCondicion = isnull( lxVar )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad CAEAINFORMA. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'CAEAINFORMA'
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
			lcCursor = This.oEntidad.cPrefijoRecibir + 'CAEAINFORMA'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FechaProc2
		* Validar ANTERIORES A 1/1/1753  VigenciaD 
		* Validar ANTERIORES A 1/1/1753  FECHA     
		* Validar ANTERIORES A 1/1/1753  VigenciaH 
		* Validar ANTERIORES A 1/1/1753  FechaTope 
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_CAEAINF') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_CAEAINF
Create Table ZooLogic.TablaTrabajo_CAEAINF ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fecexpo" datetime  null, 
"faltafw" datetime  null, 
"fecimpo" datetime  null, 
"fectrans" datetime  null, 
"fmodifw" datetime  null, 
"timestamp" numeric( 20, 0 )  null, 
"hmodifw" char( 8 )  null, 
"ualtafw" char( 100 )  null, 
"saltafw" char( 7 )  null, 
"vmodifw" char( 13 )  null, 
"zadsfw" varchar(max)  null, 
"umodifw" char( 100 )  null, 
"valtafw" char( 13 )  null, 
"smodifw" char( 7 )  null, 
"horaimpo" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"horaexpo" char( 8 )  null, 
"haltafw" char( 8 )  null, 
"bdaltafw" char( 8 )  null, 
"bdmodifw" char( 8 )  null, 
"caea" numeric( 15, 0 )  null, 
"resultado2" char( 10 )  null, 
"obsafip" varchar(max)  null, 
"fechaproc2" datetime  null, 
"numint" numeric( 15, 0 )  null, 
"vigenciad" datetime  null, 
"fecha" datetime  null, 
"vigenciah" datetime  null, 
"fechatope" datetime  null, 
"ptovta" numeric( 5, 0 )  null, 
"periodo" char( 7 )  null, 
"quincena" numeric( 1, 0 )  null, 
"codigo" char( 38 )  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_CAEAINF' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_CAEAINF' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'CAEAINFORMA'
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
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('timestamp','timestamp')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('caea','caea')
			.AgregarMapeo('resultado2','resultado2')
			.AgregarMapeo('obsafip','obsafip')
			.AgregarMapeo('fechaproc2','fechaproc2')
			.AgregarMapeo('numint','numint')
			.AgregarMapeo('vigenciad','vigenciad')
			.AgregarMapeo('fecha','fecha')
			.AgregarMapeo('vigenciah','vigenciah')
			.AgregarMapeo('fechatope','fechatope')
			.AgregarMapeo('ptovta','ptovta')
			.AgregarMapeo('periodo','periodo')
			.AgregarMapeo('quincena','quincena')
			.AgregarMapeo('codigo','codigo')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_CAEAINF'
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
				Update t Set t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.TIMESTAMP = isnull( d.TIMESTAMP, t.TIMESTAMP ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.CAEA = isnull( d.CAEA, t.CAEA ),t.RESULTADO2 = isnull( d.RESULTADO2, t.RESULTADO2 ),t.OBSAFIP = isnull( d.OBSAFIP, t.OBSAFIP ),t.FECHAPROC2 = isnull( d.FECHAPROC2, t.FECHAPROC2 ),t.NUMINT = isnull( d.NUMINT, t.NUMINT ),t.VIGENCIAD = isnull( d.VIGENCIAD, t.VIGENCIAD ),t.FECHA = isnull( d.FECHA, t.FECHA ),t.VIGENCIAH = isnull( d.VIGENCIAH, t.VIGENCIAH ),t.FECHATOPE = isnull( d.FECHATOPE, t.FECHATOPE ),t.PTOVTA = isnull( d.PTOVTA, t.PTOVTA ),t.PERIODO = isnull( d.PERIODO, t.PERIODO ),t.QUINCENA = isnull( d.QUINCENA, t.QUINCENA ),t.CODIGO = isnull( d.CODIGO, t.CODIGO )
					from ZooLogic.CAEAINF t inner join deleted d 
							 on t.Codigo = d.Codigo
				-- Fin Updates
				insert into ZooLogic.CAEAINF(Fecexpo,Faltafw,Fecimpo,Fectrans,Fmodifw,Timestamp,Hmodifw,Ualtafw,Saltafw,Vmodifw,Zadsfw,Umodifw,Valtafw,Smodifw,Horaimpo,Esttrans,Horaexpo,Haltafw,Bdaltafw,Bdmodifw,Caea,Resultado2,Obsafip,Fechaproc2,Numint,Vigenciad,Fecha,Vigenciah,Fechatope,Ptovta,Periodo,Quincena,Codigo)
					Select isnull( d.FECEXPO,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FECIMPO,''),isnull( d.FECTRANS,''),isnull( d.FMODIFW,''),isnull( d.TIMESTAMP,0),isnull( d.HMODIFW,''),isnull( d.UALTAFW,''),isnull( d.SALTAFW,''),isnull( d.VMODIFW,''),isnull( d.ZADSFW,''),isnull( d.UMODIFW,''),isnull( d.VALTAFW,''),isnull( d.SMODIFW,''),isnull( d.HORAIMPO,''),isnull( d.ESTTRANS,''),isnull( d.HORAEXPO,''),convert( char(8), getdate(), 108 ),isnull( d.BDALTAFW,''),isnull( d.BDMODIFW,''),isnull( d.CAEA,0),isnull( d.RESULTADO2,''),isnull( d.OBSAFIP,''),isnull( d.FECHAPROC2,''),isnull( d.NUMINT,0),isnull( d.VIGENCIAD,''),isnull( d.FECHA,''),isnull( d.VIGENCIAH,''),isnull( d.FECHATOPE,''),isnull( d.PTOVTA,0),isnull( d.PERIODO,''),isnull( d.QUINCENA,0),isnull( d.CODIGO,'')
						From deleted d left join ZooLogic.CAEAINF pk 
							 on d.Codigo = pk.Codigo
						Where pk.Codigo Is Null 
				-- Fin Inserts
			End
		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_CAEAINFDET( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_CAEAINF_CAEAINFDET
ON ZooLogic.TablaTrabajo_CAEAINF_CAEAINFDET
AFTER DELETE
As
Begin
Update t Set 
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.CODIGO = isnull( d.CODIGO, t.CODIGO ),
t.FECHACOMP = isnull( d.FECHACOMP, t.FECHACOMP ),
t.TIPOCOMP = isnull( d.TIPOCOMP, t.TIPOCOMP ),
t.CODCOMP = isnull( d.CODCOMP, t.CODCOMP ),
t.TOTALCOMP = isnull( d.TOTALCOMP, t.TOTALCOMP ),
t.RESULTADO = isnull( d.RESULTADO, t.RESULTADO ),
t.FECHAPROC = isnull( d.FECHAPROC, t.FECHAPROC ),
t.OBSAFIP = isnull( d.OBSAFIP, t.OBSAFIP )
from ZooLogic.CAEAINFDET t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.CAEAINFDET
( 
"NROITEM",
"CODIGO",
"FECHACOMP",
"TIPOCOMP",
"CODCOMP",
"TOTALCOMP",
"RESULTADO",
"FECHAPROC",
"OBSAFIP"
 )
Select 
d.NROITEM,
d.CODIGO,
d.FECHACOMP,
d.TIPOCOMP,
d.CODCOMP,
d.TOTALCOMP,
d.RESULTADO,
d.FECHAPROC,
d.OBSAFIP
From deleted d left join ZooLogic.CAEAINFDET pk 
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_CAEAINF') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_CAEAINF
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_CAEAINFORMA' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_CAEAINFORMA.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_CAEAINFORMA.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_CAEAINFORMA.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_CAEAINFORMA.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_CAEAINFORMA.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Timestamp = nvl( c_CAEAINFORMA.Timestamp, 0 )
					.Horamodificacionfw = nvl( c_CAEAINFORMA.Horamodificacionfw, [] )
					.Usuarioaltafw = nvl( c_CAEAINFORMA.Usuarioaltafw, [] )
					.Seriealtafw = nvl( c_CAEAINFORMA.Seriealtafw, [] )
					.Versionmodificacionfw = nvl( c_CAEAINFORMA.Versionmodificacionfw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Usuariomodificacionfw = nvl( c_CAEAINFORMA.Usuariomodificacionfw, [] )
					.Versionaltafw = nvl( c_CAEAINFORMA.Versionaltafw, [] )
					.Seriemodificacionfw = nvl( c_CAEAINFORMA.Seriemodificacionfw, [] )
					.Horaimpo = nvl( c_CAEAINFORMA.Horaimpo, [] )
					.Estadotransferencia = nvl( c_CAEAINFORMA.Estadotransferencia, [] )
					.Horaexpo = nvl( c_CAEAINFORMA.Horaexpo, [] )
					.Horaaltafw = nvl( c_CAEAINFORMA.Horaaltafw, [] )
					.Basededatosaltafw = nvl( c_CAEAINFORMA.Basededatosaltafw, [] )
					.Basededatosmodificacionfw = nvl( c_CAEAINFORMA.Basededatosmodificacionfw, [] )
					.Codcaea_PK =  nvl( c_CAEAINFORMA.Codcaea, 0 )
					.Resultado2 = nvl( c_CAEAINFORMA.Resultado2, [] )
					lcValor = This.ObtenerMemo( 'c_Observacion')
					.Observacion = lcValor 
					.Fechaproceso2 = GoLibrerias.ObtenerFechaFormateada( nvl( c_CAEAINFORMA.Fechaproceso2, ctod( '  /  /    ' ) ) )
					.Numerointerno = nvl( c_CAEAINFORMA.Numerointerno, 0 )
					.Fechavigenciadesde = GoLibrerias.ObtenerFechaFormateada( nvl( c_CAEAINFORMA.Fechavigenciadesde, ctod( '  /  /    ' ) ) )
					.Fecha = GoLibrerias.ObtenerFechaFormateada( nvl( c_CAEAINFORMA.Fecha, ctod( '  /  /    ' ) ) )
					.Fechavigenciahasta = GoLibrerias.ObtenerFechaFormateada( nvl( c_CAEAINFORMA.Fechavigenciahasta, ctod( '  /  /    ' ) ) )
					.Fechatope = GoLibrerias.ObtenerFechaFormateada( nvl( c_CAEAINFORMA.Fechatope, ctod( '  /  /    ' ) ) )
					.Ptoventa = nvl( c_CAEAINFORMA.Ptoventa, 0 )
					.Periodocaea = nvl( c_CAEAINFORMA.Periodocaea, [] )
					.Quincena = nvl( c_CAEAINFORMA.Quincena, 0 )
					.Caeinformadetalle.Limpiar()
					.Caeinformadetalle.SetearEsNavegacion( .lProcesando )
					.Caeinformadetalle.Cargar()
					.Codigo = nvl( c_CAEAINFORMA.Codigo, [] )
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
		
		loDetalle = this.oEntidad.CaeInformaDetalle
		for lnIndex = loDetalle.count to 1 step -1
			if !loDetalle.ValidarExistenciaCamposFijosItemPlano( loDetalle.Item[lnIndex].NroItem )
				loDetalle.Remove( lnIndex )
			endif
		endfor
		
		lnContadorNroItem = 1
		for each loItem in loDetalle foxObject
			loItem.NroItem = lnContadorNroItem
			lnContadorNroItem = lnContadorNroItem + 1
		endfor

	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function ObtenerMemo( tcTabla as String ) as string
		local lcAtributo as string
		lcAtributo = strtran( tcTabla, 'c_', '' )
		return c_CAEAINFORMA.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.CAEAINF' )
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
								from ZooLogic.CAEAINF 
								Where   CAEAINF.CODIGO != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "CAEAINF", "", lcCursor, set("Datasession") )
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
			"Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Timestamp" as "Timestamp", "Hmodifw" as "Horamodificacionfw", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Caea" as "Codcaea", "Resultado2" as "Resultado2", "Obsafip" as "Observacion", "Fechaproc2" as "Fechaproceso2", "Numint" as "Numerointerno", "Vigenciad" as "Fechavigenciadesde", "Fecha" as "Fecha", "Vigenciah" as "Fechavigenciahasta", "Fechatope" as "Fechatope", "Ptovta" as "Ptoventa", "Periodo" as "Periodocaea", "Quincena" as "Quincena", "Codigo" as "Codigo"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.CAEAINF 
								Where   CAEAINF.CODIGO != ''
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
	Tabla = 'CAEAINF'
	Filtro = " CAEAINF.CODIGO != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " CAEAINF.CODIGO != ''"
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
	<row entidad="CAEAINFORMA                             " atributo="FECHAEXPO                               " tabla="CAEAINF        " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAEAINFORMA                             " atributo="FECHAALTAFW                             " tabla="CAEAINF        " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAEAINFORMA                             " atributo="FECHAIMPO                               " tabla="CAEAINF        " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAEAINFORMA                             " atributo="FECHATRANSFERENCIA                      " tabla="CAEAINF        " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha transferencia                                                                                                                                             " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAEAINFORMA                             " atributo="FECHAMODIFICACIONFW                     " tabla="CAEAINF        " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAEAINFORMA                             " atributo="TIMESTAMP                               " tabla="CAEAINF        " campo="TIMESTAMP " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAEAINFORMA                             " atributo="HORAMODIFICACIONFW                      " tabla="CAEAINF        " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAEAINFORMA                             " atributo="USUARIOALTAFW                           " tabla="CAEAINF        " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAEAINFORMA                             " atributo="SERIEALTAFW                             " tabla="CAEAINF        " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAEAINFORMA                             " atributo="VERSIONMODIFICACIONFW                   " tabla="CAEAINF        " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAEAINFORMA                             " atributo="ZADSFW                                  " tabla="CAEAINF        " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAEAINFORMA                             " atributo="USUARIOMODIFICACIONFW                   " tabla="CAEAINF        " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAEAINFORMA                             " atributo="VERSIONALTAFW                           " tabla="CAEAINF        " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAEAINFORMA                             " atributo="SERIEMODIFICACIONFW                     " tabla="CAEAINF        " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAEAINFORMA                             " atributo="HORAIMPO                                " tabla="CAEAINF        " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAEAINFORMA                             " atributo="ESTADOTRANSFERENCIA                     " tabla="CAEAINF        " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado transferencia                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAEAINFORMA                             " atributo="HORAEXPO                                " tabla="CAEAINF        " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAEAINFORMA                             " atributo="HORAALTAFW                              " tabla="CAEAINF        " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAEAINFORMA                             " atributo="BASEDEDATOSALTAFW                       " tabla="CAEAINF        " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAEAINFORMA                             " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="CAEAINF        " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAEAINFORMA                             " atributo="CODCAEA                                 " tabla="CAEAINF        " campo="CAEA      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CAEA                                    " tipodato="N         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="2" etiqueta="CAEA                                                                                                                                                            " dominio="CODIGONUMERICO                " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAEAINFORMA                             " atributo="RESULTADO2                              " tabla="CAEAINF        " campo="RESULTADO2" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="Resultado                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAEAINFORMA                             " atributo="OBSERVACION                             " tabla="CAEAINF        " campo="OBSAFIP   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="402" etiqueta="Observaciones                                                                                                                                                   " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="4" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAEAINFORMA                             " atributo="FECHAPROCESO2                           " tabla="CAEAINF        " campo="FECHAPROC2" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="404" etiqueta="Fecha de proceso                                                                                                                                                " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAEAINFORMA                             " atributo="NUMEROINTERNO                           " tabla="CAEAINF        " campo="NUMINT    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="2" etiqueta="Número interno                                                                                                                                                  " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAEAINFORMA                             " atributo="FECHAVIGENCIADESDE                      " tabla="CAEAINF        " campo="VIGENCIAD " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="406" etiqueta="Fecha de vigencia                                                                                                                                               " dominio="EtiquetaFechaDesHasIZ         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAEAINFORMA                             " atributo="FECHA                                   " tabla="CAEAINF        " campo="FECHA     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goServicios.librerias.ObtenerFecha()                                                                                                                                                                                                                         " obligatorio="true" admitebusqueda="10" etiqueta="Fecha                                                                                                                                                           " dominio="FECHACOMPROBANTE              " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAEAINFORMA                             " atributo="FECHAVIGENCIAHASTA                      " tabla="CAEAINF        " campo="VIGENCIAH " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="408" etiqueta="Fecha de vigencia hasta                                                                                                                                         " dominio="EtiquetaFechaDesHasIZ         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAEAINFORMA                             " atributo="FECHATOPE                               " tabla="CAEAINF        " campo="FECHATOPE " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="410" etiqueta="Fecha tope para informar comprobantes                                                                                                                           " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAEAINFORMA                             " atributo="PTOVENTA                                " tabla="CAEAINF        " campo="PTOVTA    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="412" etiqueta="Punto de venta                                                                                                                                                  " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAEAINFORMA                             " atributo="PERIODOCAEA                             " tabla="CAEAINF        " campo="PERIODO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="414" etiqueta="Período de CAEA (YYYY/MM)                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="9999/99                  " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAEAINFORMA                             " atributo="QUINCENA                                " tabla="CAEAINF        " campo="QUINCENA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="416" etiqueta="Quincena                                                                                                                                                        " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAEAINFORMA                             " atributo="CAEINFORMADETALLE                       " tabla="CAEAINFDET     " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="418" etiqueta="Información CAEA                                                                                                                                                " dominio="DETALLEITEMCAEAINFORMA        " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="10" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAEAINFORMA                             " atributo="CODIGO                                  " tabla="CAEAINF        " campo="CODIGO    " claveprimaria="true" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="420" etiqueta="Código                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="20" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAEA                                    " atributo="NUMEROCAEA                              " tabla="CAEA           " campo="NCAEA     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="3" etiqueta="Detalle CAE.                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CAEA On CAEAINF.CAEA = CAEA.NInterno And  CAEA.NINTERNO != 0                                                                                                                                                                                       " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="10" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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