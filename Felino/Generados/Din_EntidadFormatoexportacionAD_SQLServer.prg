
define class Din_EntidadFORMATOEXPORTACIONAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_FORMATOEXPORTACION'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = []
	cExpresionCCPorCampos = []
	cTagClaveCandidata = ''
	cTagClavePk = '_FOEPK'
	cTablaPrincipal = 'FORMATOS'
	*--------------------------------------------------------------------------------------------------------
	function Inicializar() as boolean
		local loError as Exception, loEx as Exception

		dodefault()

		with this
			.cArchivoLogPrueba = SYS(0) + '_' + transform( date() ) + '_' + strtran( time(), ':', '.' ) + '_' + transform( golibrerias.obtenertimestamp() ) + '.txt' 
			.cArchivoLogPrueba = strtran( strtran( strtran( .cArchivoLogPrueba, '/', '-' ), ' ', '' ), '#', '' )
				.cUbicacionDB = 'ORGANIZACION'
				.cTipoDB = 'SQLSERVER'
				.cEsquema = 'ORGANIZACION'
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
			local  lxFormatosFecimpo, lxFormatosFectrans, lxFormatosFmodifw, lxFormatosFecexpo, lxFormatosFaltafw, lxFormatosBloqreg, lxFormatosSmodifw, lxFormatosUmodifw, lxFormatosUaltafw, lxFormatosSaltafw, lxFormatosVmodifw, lxFormatosValtafw, lxFormatosZadsfw, lxFormatosBdaltafw, lxFormatosEsttrans, lxFormatosBdmodifw, lxFormatosHaltafw, lxFormatosHmodifw, lxFormatosHoraimpo, lxFormatosHoraexpo, lxFormatosCobs, lxFormatosCodigo, lxFormatosDescrip, lxFormatosAlineacion, lxFormatosCapitaliz, lxFormatosCompizq, lxFormatosCompder, lxFormatosTruncar, lxFormatosCantdeci, lxFormatosSepdec, lxFormatosSecmiles, lxFormatosInicial, lxFormatosLltrim, lxFormatosLrtrim, lxFormatosComillas, lxFormatosComienza, lxFormatosFormfecha, lxFormatosOtroform
				lxFormatosFecimpo =  .Fechaimpo			lxFormatosFectrans =  .Fechatransferencia			lxFormatosFmodifw =  .Fechamodificacionfw			lxFormatosFecexpo =  .Fechaexpo			lxFormatosFaltafw =  .Fechaaltafw			lxFormatosBloqreg =  .Bloquearregistro			lxFormatosSmodifw =  .Seriemodificacionfw			lxFormatosUmodifw =  .Usuariomodificacionfw			lxFormatosUaltafw =  .Usuarioaltafw			lxFormatosSaltafw =  .Seriealtafw			lxFormatosVmodifw =  .Versionmodificacionfw			lxFormatosValtafw =  .Versionaltafw			lxFormatosZadsfw =  .Zadsfw			lxFormatosBdaltafw =  .Basededatosaltafw			lxFormatosEsttrans =  .Estadotransferencia			lxFormatosBdmodifw =  .Basededatosmodificacionfw			lxFormatosHaltafw =  .Horaaltafw			lxFormatosHmodifw =  .Horamodificacionfw			lxFormatosHoraimpo =  .Horaimpo			lxFormatosHoraexpo =  .Horaexpo			lxFormatosCobs =  .Obs			lxFormatosCodigo =  .Codigo			lxFormatosDescrip =  .Descripcion			lxFormatosAlineacion =  .Alineacion			lxFormatosCapitaliz =  .Capitalizacion			lxFormatosCompizq =  .Completarizq			lxFormatosCompder =  .Completarder			lxFormatosTruncar =  .Truncardecimales			lxFormatosCantdeci =  .Decimales			lxFormatosSepdec =  .Separadordecimal			lxFormatosSecmiles =  .Separadormiles			lxFormatosInicial =  .Simboloinicial			lxFormatosLltrim =  .Lltrim			lxFormatosLrtrim =  .Lrtrim			lxFormatosComillas =  .Agregarcomillas			lxFormatosComienza =  .Comienzacon			lxFormatosFormfecha =  .Formatofecha			lxFormatosOtroform =  .Otroformato
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxFormatosCodigo = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ORGANIZACION.FORMATOS ( "Fecimpo","Fectrans","Fmodifw","Fecexpo","Faltafw","Bloqreg","Smodifw","Umodifw","Ualtafw","Saltafw","Vmodifw","Valtafw","Zadsfw","Bdaltafw","Esttrans","Bdmodifw","Haltafw","Hmodifw","Horaimpo","Horaexpo","Cobs","Codigo","Descrip","Alineacion","Capitaliz","Compizq","Compder","Truncar","Cantdeci","Sepdec","Secmiles","Inicial","Lltrim","Lrtrim","Comillas","Comienza","Formfecha","Otroform" ) values ( <<"'" + this.ConvertirDateSql( lxFormatosFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxFormatosFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxFormatosFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxFormatosFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxFormatosFaltafw ) + "'" >>, <<iif( lxFormatosBloqreg, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxFormatosSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFormatosUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFormatosUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFormatosSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFormatosVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFormatosValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFormatosZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFormatosBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFormatosEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFormatosBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFormatosHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFormatosHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFormatosHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFormatosHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFormatosCobs ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFormatosCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFormatosDescrip ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFormatosAlineacion ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFormatosCapitaliz ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFormatosCompizq ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFormatosCompder ) + "'" >>, <<iif( lxFormatosTruncar, 1, 0 ) >>, <<lxFormatosCantdeci >>, <<"'" + this.FormatearTextoSql( lxFormatosSepdec ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFormatosSecmiles ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFormatosInicial ) + "'" >>, <<iif( lxFormatosLltrim, 1, 0 ) >>, <<iif( lxFormatosLrtrim, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxFormatosComillas ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFormatosComienza ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFormatosFormfecha ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFormatosOtroform ) + "'" >> )
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
			local  lxFormatosFecimpo, lxFormatosFectrans, lxFormatosFmodifw, lxFormatosFecexpo, lxFormatosFaltafw, lxFormatosBloqreg, lxFormatosSmodifw, lxFormatosUmodifw, lxFormatosUaltafw, lxFormatosSaltafw, lxFormatosVmodifw, lxFormatosValtafw, lxFormatosZadsfw, lxFormatosBdaltafw, lxFormatosEsttrans, lxFormatosBdmodifw, lxFormatosHaltafw, lxFormatosHmodifw, lxFormatosHoraimpo, lxFormatosHoraexpo, lxFormatosCobs, lxFormatosCodigo, lxFormatosDescrip, lxFormatosAlineacion, lxFormatosCapitaliz, lxFormatosCompizq, lxFormatosCompder, lxFormatosTruncar, lxFormatosCantdeci, lxFormatosSepdec, lxFormatosSecmiles, lxFormatosInicial, lxFormatosLltrim, lxFormatosLrtrim, lxFormatosComillas, lxFormatosComienza, lxFormatosFormfecha, lxFormatosOtroform
				lxFormatosFecimpo =  .Fechaimpo			lxFormatosFectrans =  .Fechatransferencia			lxFormatosFmodifw =  .Fechamodificacionfw			lxFormatosFecexpo =  .Fechaexpo			lxFormatosFaltafw =  .Fechaaltafw			lxFormatosBloqreg =  .Bloquearregistro			lxFormatosSmodifw =  .Seriemodificacionfw			lxFormatosUmodifw =  .Usuariomodificacionfw			lxFormatosUaltafw =  .Usuarioaltafw			lxFormatosSaltafw =  .Seriealtafw			lxFormatosVmodifw =  .Versionmodificacionfw			lxFormatosValtafw =  .Versionaltafw			lxFormatosZadsfw =  .Zadsfw			lxFormatosBdaltafw =  .Basededatosaltafw			lxFormatosEsttrans =  .Estadotransferencia			lxFormatosBdmodifw =  .Basededatosmodificacionfw			lxFormatosHaltafw =  .Horaaltafw			lxFormatosHmodifw =  .Horamodificacionfw			lxFormatosHoraimpo =  .Horaimpo			lxFormatosHoraexpo =  .Horaexpo			lxFormatosCobs =  .Obs			lxFormatosCodigo =  .Codigo			lxFormatosDescrip =  .Descripcion			lxFormatosAlineacion =  .Alineacion			lxFormatosCapitaliz =  .Capitalizacion			lxFormatosCompizq =  .Completarizq			lxFormatosCompder =  .Completarder			lxFormatosTruncar =  .Truncardecimales			lxFormatosCantdeci =  .Decimales			lxFormatosSepdec =  .Separadordecimal			lxFormatosSecmiles =  .Separadormiles			lxFormatosInicial =  .Simboloinicial			lxFormatosLltrim =  .Lltrim			lxFormatosLrtrim =  .Lrtrim			lxFormatosComillas =  .Agregarcomillas			lxFormatosComienza =  .Comienzacon			lxFormatosFormfecha =  .Formatofecha			lxFormatosOtroform =  .Otroformato
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()
			lxValorClavePrimaria = .oEntidad.CODIGO
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ORGANIZACION.FORMATOS set "Fecimpo" = <<"'" + this.ConvertirDateSql( lxFormatosFecimpo ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxFormatosFectrans ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxFormatosFmodifw ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxFormatosFecexpo ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxFormatosFaltafw ) + "'">>,"Bloqreg" = <<iif( lxFormatosBloqreg, 1, 0 )>>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxFormatosSmodifw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxFormatosUmodifw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxFormatosUaltafw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxFormatosSaltafw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxFormatosVmodifw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxFormatosValtafw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxFormatosZadsfw ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxFormatosBdaltafw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxFormatosEsttrans ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxFormatosBdmodifw ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxFormatosHaltafw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxFormatosHmodifw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxFormatosHoraimpo ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxFormatosHoraexpo ) + "'">>,"Cobs" = <<"'" + this.FormatearTextoSql( lxFormatosCobs ) + "'">>,"Codigo" = <<"'" + this.FormatearTextoSql( lxFormatosCodigo ) + "'">>,"Descrip" = <<"'" + this.FormatearTextoSql( lxFormatosDescrip ) + "'">>,"Alineacion" = <<"'" + this.FormatearTextoSql( lxFormatosAlineacion ) + "'">>,"Capitaliz" = <<"'" + this.FormatearTextoSql( lxFormatosCapitaliz ) + "'">>,"Compizq" = <<"'" + this.FormatearTextoSql( lxFormatosCompizq ) + "'">>,"Compder" = <<"'" + this.FormatearTextoSql( lxFormatosCompder ) + "'">>,"Truncar" = <<iif( lxFormatosTruncar, 1, 0 )>>,"Cantdeci" = <<lxFormatosCantdeci>>,"Sepdec" = <<"'" + this.FormatearTextoSql( lxFormatosSepdec ) + "'">>,"Secmiles" = <<"'" + this.FormatearTextoSql( lxFormatosSecmiles ) + "'">>,"Inicial" = <<"'" + this.FormatearTextoSql( lxFormatosInicial ) + "'">>,"Lltrim" = <<iif( lxFormatosLltrim, 1, 0 )>>,"Lrtrim" = <<iif( lxFormatosLrtrim, 1, 0 )>>,"Comillas" = <<"'" + this.FormatearTextoSql( lxFormatosComillas ) + "'">>,"Comienza" = <<"'" + this.FormatearTextoSql( lxFormatosComienza ) + "'">>,"Formfecha" = <<"'" + this.FormatearTextoSql( lxFormatosFormfecha ) + "'">>,"Otroform" = <<"'" + this.FormatearTextoSql( lxFormatosOtroform ) + "'">> where "Codigo" = <<"'" + this.FormatearTextoSql( lxFormatosCodigo ) + "'">> and  FORMATOS.CODIGO != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 codigo from ORGANIZACION.FORMATOS where " + this.ConvertirFuncionesSql( " FORMATOS.CODIGO != ''" ) )
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
			Local lxFormatosCodigo
			lxFormatosCodigo = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Bloqreg" as "Bloquearregistro", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Haltafw" as "Horaaltafw", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Cobs" as "Obs", "Codigo" as "Codigo", "Descrip" as "Descripcion", "Alineacion" as "Alineacion", "Capitaliz" as "Capitalizacion", "Compizq" as "Completarizq", "Compder" as "Completarder", "Truncar" as "Truncardecimales", "Cantdeci" as "Decimales", "Sepdec" as "Separadordecimal", "Secmiles" as "Separadormiles", "Inicial" as "Simboloinicial", "Lltrim" as "Lltrim", "Lrtrim" as "Lrtrim", "Comillas" as "Agregarcomillas", "Comienza" as "Comienzacon", "Formfecha" as "Formatofecha", "Otroform" as "Otroformato" from ORGANIZACION.FORMATOS where "Codigo" = <<"'" + this.FormatearTextoSql( lxFormatosCodigo ) + "'">> and  FORMATOS.CODIGO != ''
			endtext
			use in select('c_FORMATOEXPORTACION')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FORMATOEXPORTACION', set( 'Datasession' ) )

			if reccount( 'c_FORMATOEXPORTACION' ) = 0
				llRetorno = .f.
			else
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxFormatosCodigo as Variant
		llRetorno = .t.
		lxFormatosCodigo = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ORGANIZACION.FORMATOS where "Codigo" = <<"'" + this.FormatearTextoSql( lxFormatosCodigo ) + "'">> and  FORMATOS.CODIGO != ''
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
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Bloqreg" as "Bloquearregistro", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Haltafw" as "Horaaltafw", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Cobs" as "Obs", "Codigo" as "Codigo", "Descrip" as "Descripcion", "Alineacion" as "Alineacion", "Capitaliz" as "Capitalizacion", "Compizq" as "Completarizq", "Compder" as "Completarder", "Truncar" as "Truncardecimales", "Cantdeci" as "Decimales", "Sepdec" as "Separadordecimal", "Secmiles" as "Separadormiles", "Inicial" as "Simboloinicial", "Lltrim" as "Lltrim", "Lrtrim" as "Lrtrim", "Comillas" as "Agregarcomillas", "Comienza" as "Comienzacon", "Formfecha" as "Formatofecha", "Otroform" as "Otroformato" from ORGANIZACION.FORMATOS where  FORMATOS.CODIGO != '' order by codigo
			endtext
			use in select('c_FORMATOEXPORTACION')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FORMATOEXPORTACION', set( 'Datasession' ) )
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
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Bloqreg" as "Bloquearregistro", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Haltafw" as "Horaaltafw", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Cobs" as "Obs", "Codigo" as "Codigo", "Descrip" as "Descripcion", "Alineacion" as "Alineacion", "Capitaliz" as "Capitalizacion", "Compizq" as "Completarizq", "Compder" as "Completarder", "Truncar" as "Truncardecimales", "Cantdeci" as "Decimales", "Sepdec" as "Separadordecimal", "Secmiles" as "Separadormiles", "Inicial" as "Simboloinicial", "Lltrim" as "Lltrim", "Lrtrim" as "Lrtrim", "Comillas" as "Agregarcomillas", "Comienza" as "Comienzacon", "Formfecha" as "Formatofecha", "Otroform" as "Otroformato" from ORGANIZACION.FORMATOS where  funciones.padr( codigo, 40, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  FORMATOS.CODIGO != '' order by codigo
			endtext
			use in select('c_FORMATOEXPORTACION')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FORMATOEXPORTACION', set( 'Datasession' ) )
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
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Bloqreg" as "Bloquearregistro", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Haltafw" as "Horaaltafw", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Cobs" as "Obs", "Codigo" as "Codigo", "Descrip" as "Descripcion", "Alineacion" as "Alineacion", "Capitaliz" as "Capitalizacion", "Compizq" as "Completarizq", "Compder" as "Completarder", "Truncar" as "Truncardecimales", "Cantdeci" as "Decimales", "Sepdec" as "Separadordecimal", "Secmiles" as "Separadormiles", "Inicial" as "Simboloinicial", "Lltrim" as "Lltrim", "Lrtrim" as "Lrtrim", "Comillas" as "Agregarcomillas", "Comienza" as "Comienzacon", "Formfecha" as "Formatofecha", "Otroform" as "Otroformato" from ORGANIZACION.FORMATOS where  funciones.padr( codigo, 40, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  FORMATOS.CODIGO != '' order by codigo desc
			endtext
			use in select('c_FORMATOEXPORTACION')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FORMATOEXPORTACION', set( 'Datasession' ) )
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
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Bloqreg" as "Bloquearregistro", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Haltafw" as "Horaaltafw", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Cobs" as "Obs", "Codigo" as "Codigo", "Descrip" as "Descripcion", "Alineacion" as "Alineacion", "Capitaliz" as "Capitalizacion", "Compizq" as "Completarizq", "Compder" as "Completarder", "Truncar" as "Truncardecimales", "Cantdeci" as "Decimales", "Sepdec" as "Separadordecimal", "Secmiles" as "Separadormiles", "Inicial" as "Simboloinicial", "Lltrim" as "Lltrim", "Lrtrim" as "Lrtrim", "Comillas" as "Agregarcomillas", "Comienza" as "Comienzacon", "Formfecha" as "Formatofecha", "Otroform" as "Otroformato" from ORGANIZACION.FORMATOS where  FORMATOS.CODIGO != '' order by codigo desc
			endtext
			use in select('c_FORMATOEXPORTACION')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FORMATOEXPORTACION', set( 'Datasession' ) )
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
			lcXml = this.oConexion.EjecutarSql( "select Fecimpo,Fectrans,Fmodifw,Fecexpo,Faltafw,Bloqreg,Smodifw,Umodifw,Ualtafw,Saltafw,Vmodifw,Val" + ;
"tafw,Zadsfw,Bdaltafw,Esttrans,Bdmodifw,Haltafw,Hmodifw,Horaimpo,Horaexpo,Cobs,Codigo,Descrip,Alineac" + ;
"ion,Capitaliz,Compizq,Compder,Truncar,Cantdeci,Sepdec,Secmiles,Inicial,Lltrim,Lrtrim,Comillas,Comien" + ;
"za,Formfecha,Otroform" + ;
" from ORGANIZACION.FORMATOS where  FORMATOS.CODIGO != '' and " + lcFiltro )
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
			local  lxFormatosFecimpo, lxFormatosFectrans, lxFormatosFmodifw, lxFormatosFecexpo, lxFormatosFaltafw, lxFormatosBloqreg, lxFormatosSmodifw, lxFormatosUmodifw, lxFormatosUaltafw, lxFormatosSaltafw, lxFormatosVmodifw, lxFormatosValtafw, lxFormatosZadsfw, lxFormatosBdaltafw, lxFormatosEsttrans, lxFormatosBdmodifw, lxFormatosHaltafw, lxFormatosHmodifw, lxFormatosHoraimpo, lxFormatosHoraexpo, lxFormatosCobs, lxFormatosCodigo, lxFormatosDescrip, lxFormatosAlineacion, lxFormatosCapitaliz, lxFormatosCompizq, lxFormatosCompder, lxFormatosTruncar, lxFormatosCantdeci, lxFormatosSepdec, lxFormatosSecmiles, lxFormatosInicial, lxFormatosLltrim, lxFormatosLrtrim, lxFormatosComillas, lxFormatosComienza, lxFormatosFormfecha, lxFormatosOtroform
				lxFormatosFecimpo = ctod( '  /  /    ' )			lxFormatosFectrans = ctod( '  /  /    ' )			lxFormatosFmodifw = ctod( '  /  /    ' )			lxFormatosFecexpo = ctod( '  /  /    ' )			lxFormatosFaltafw = ctod( '  /  /    ' )			lxFormatosBloqreg = .F.			lxFormatosSmodifw = []			lxFormatosUmodifw = []			lxFormatosUaltafw = []			lxFormatosSaltafw = []			lxFormatosVmodifw = []			lxFormatosValtafw = []			lxFormatosZadsfw = []			lxFormatosBdaltafw = []			lxFormatosEsttrans = []			lxFormatosBdmodifw = []			lxFormatosHaltafw = []			lxFormatosHmodifw = []			lxFormatosHoraimpo = []			lxFormatosHoraexpo = []			lxFormatosCobs = []			lxFormatosCodigo = []			lxFormatosDescrip = []			lxFormatosAlineacion = []			lxFormatosCapitaliz = []			lxFormatosCompizq = []			lxFormatosCompder = []			lxFormatosTruncar = .F.			lxFormatosCantdeci = 0			lxFormatosSepdec = []			lxFormatosSecmiles = []			lxFormatosInicial = []			lxFormatosLltrim = .F.			lxFormatosLrtrim = .F.			lxFormatosComillas = []			lxFormatosComienza = []			lxFormatosFormfecha = []			lxFormatosOtroform = []
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( [delete from ORGANIZACION.FORMATOS where "codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'FORMATOS' + '_' + tcCampo
			lcMemoAscii = ''

			lnIndice = alen(.aSqlMemos)
			lnIndice = iif(lnIndice = 1, 1, lnIndice + 1 )
			dimension .aSqlMemos(lnIndice)

			.aSqlMemos(lnIndice) = 'delete from ' + lcTabla + ' where codigo = ' + txValorClavePrimaria
			.GenerarSentenciasInsertTablaMemo( lcValor, lcTabla, txValorClavePrimaria )
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerSentenciaInsertMemo( tcTabla as String, txValorClavePrimaria as String, tcOrden as String, tcTexto as String ) as String
		return "Insert  into " + tcTabla + "(codigo, Orden, texto ) values ( " + txValorClavePrimaria + "," + tcOrden + ",'"+ tcTexto + "')"
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosEntidad( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  FORMATOS.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Bloqreg" as "Bloquearregistro", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Haltafw" as "Horaaltafw", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Cobs" as "Obs", "Codigo" as "Codigo", "Descrip" as "Descripcion", "Alineacion" as "Alineacion", "Capitaliz" as "Capitalizacion", "Compizq" as "Completarizq", "Compder" as "Completarder", "Truncar" as "Truncardecimales", "Cantdeci" as "Decimales", "Sepdec" as "Separadordecimal", "Secmiles" as "Separadormiles", "Inicial" as "Simboloinicial", "Lltrim" as "Lltrim", "Lrtrim" as "Lrtrim", "Comillas" as "Agregarcomillas", "Comienza" as "Comienzacon", "Formfecha" as "Formatofecha", "Otroform" as "Otroformato"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'FORMATOS', '', tnTope )
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
				Case lcAtributo == 'BLOQUEARREGISTRO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BLOQREG AS BLOQUEARREGISTRO'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'OBS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COBS AS OBS'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'DESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCRIP AS DESCRIPCION'
				Case lcAtributo == 'ALINEACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ALINEACION AS ALINEACION'
				Case lcAtributo == 'CAPITALIZACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CAPITALIZ AS CAPITALIZACION'
				Case lcAtributo == 'COMPLETARIZQ'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COMPIZQ AS COMPLETARIZQ'
				Case lcAtributo == 'COMPLETARDER'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COMPDER AS COMPLETARDER'
				Case lcAtributo == 'TRUNCARDECIMALES'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TRUNCAR AS TRUNCARDECIMALES'
				Case lcAtributo == 'DECIMALES'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CANTDECI AS DECIMALES'
				Case lcAtributo == 'SEPARADORDECIMAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SEPDEC AS SEPARADORDECIMAL'
				Case lcAtributo == 'SEPARADORMILES'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SECMILES AS SEPARADORMILES'
				Case lcAtributo == 'SIMBOLOINICIAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'INICIAL AS SIMBOLOINICIAL'
				Case lcAtributo == 'LLTRIM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LLTRIM AS LLTRIM'
				Case lcAtributo == 'LRTRIM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LRTRIM AS LRTRIM'
				Case lcAtributo == 'AGREGARCOMILLAS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COMILLAS AS AGREGARCOMILLAS'
				Case lcAtributo == 'COMIENZACON'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COMIENZA AS COMIENZACON'
				Case lcAtributo == 'FORMATOFECHA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FORMFECHA AS FORMATOFECHA'
				Case lcAtributo == 'OTROFORMATO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'OTROFORM AS OTROFORMATO'
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
			Case upper( alltrim( tcAtributo ) ) == 'BLOQUEARREGISTRO'
				lcCampo = 'BLOQREG'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'OBS'
				lcCampo = 'COBS'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCION'
				lcCampo = 'DESCRIP'
			Case upper( alltrim( tcAtributo ) ) == 'ALINEACION'
				lcCampo = 'ALINEACION'
			Case upper( alltrim( tcAtributo ) ) == 'CAPITALIZACION'
				lcCampo = 'CAPITALIZ'
			Case upper( alltrim( tcAtributo ) ) == 'COMPLETARIZQ'
				lcCampo = 'COMPIZQ'
			Case upper( alltrim( tcAtributo ) ) == 'COMPLETARDER'
				lcCampo = 'COMPDER'
			Case upper( alltrim( tcAtributo ) ) == 'TRUNCARDECIMALES'
				lcCampo = 'TRUNCAR'
			Case upper( alltrim( tcAtributo ) ) == 'DECIMALES'
				lcCampo = 'CANTDECI'
			Case upper( alltrim( tcAtributo ) ) == 'SEPARADORDECIMAL'
				lcCampo = 'SEPDEC'
			Case upper( alltrim( tcAtributo ) ) == 'SEPARADORMILES'
				lcCampo = 'SECMILES'
			Case upper( alltrim( tcAtributo ) ) == 'SIMBOLOINICIAL'
				lcCampo = 'INICIAL'
			Case upper( alltrim( tcAtributo ) ) == 'LLTRIM'
				lcCampo = 'LLTRIM'
			Case upper( alltrim( tcAtributo ) ) == 'LRTRIM'
				lcCampo = 'LRTRIM'
			Case upper( alltrim( tcAtributo ) ) == 'AGREGARCOMILLAS'
				lcCampo = 'COMILLAS'
			Case upper( alltrim( tcAtributo ) ) == 'COMIENZACON'
				lcCampo = 'COMIENZA'
			Case upper( alltrim( tcAtributo ) ) == 'FORMATOFECHA'
				lcCampo = 'FORMFECHA'
			Case upper( alltrim( tcAtributo ) ) == 'OTROFORMATO'
				lcCampo = 'OTROFORM'
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
			local  lxFormatosFecimpo, lxFormatosFectrans, lxFormatosFmodifw, lxFormatosFecexpo, lxFormatosFaltafw, lxFormatosBloqreg, lxFormatosSmodifw, lxFormatosUmodifw, lxFormatosUaltafw, lxFormatosSaltafw, lxFormatosVmodifw, lxFormatosValtafw, lxFormatosZadsfw, lxFormatosBdaltafw, lxFormatosEsttrans, lxFormatosBdmodifw, lxFormatosHaltafw, lxFormatosHmodifw, lxFormatosHoraimpo, lxFormatosHoraexpo, lxFormatosCobs, lxFormatosCodigo, lxFormatosDescrip, lxFormatosAlineacion, lxFormatosCapitaliz, lxFormatosCompizq, lxFormatosCompder, lxFormatosTruncar, lxFormatosCantdeci, lxFormatosSepdec, lxFormatosSecmiles, lxFormatosInicial, lxFormatosLltrim, lxFormatosLrtrim, lxFormatosComillas, lxFormatosComienza, lxFormatosFormfecha, lxFormatosOtroform
				lxFormatosFecimpo =  .Fechaimpo			lxFormatosFectrans =  .Fechatransferencia			lxFormatosFmodifw =  .Fechamodificacionfw			lxFormatosFecexpo =  .Fechaexpo			lxFormatosFaltafw =  .Fechaaltafw			lxFormatosBloqreg =  .Bloquearregistro			lxFormatosSmodifw =  .Seriemodificacionfw			lxFormatosUmodifw =  .Usuariomodificacionfw			lxFormatosUaltafw =  .Usuarioaltafw			lxFormatosSaltafw =  .Seriealtafw			lxFormatosVmodifw =  .Versionmodificacionfw			lxFormatosValtafw =  .Versionaltafw			lxFormatosZadsfw =  .Zadsfw			lxFormatosBdaltafw =  .Basededatosaltafw			lxFormatosEsttrans =  .Estadotransferencia			lxFormatosBdmodifw =  .Basededatosmodificacionfw			lxFormatosHaltafw =  .Horaaltafw			lxFormatosHmodifw =  .Horamodificacionfw			lxFormatosHoraimpo =  .Horaimpo			lxFormatosHoraexpo =  .Horaexpo			lxFormatosCobs =  .Obs			lxFormatosCodigo =  .Codigo			lxFormatosDescrip =  .Descripcion			lxFormatosAlineacion =  .Alineacion			lxFormatosCapitaliz =  .Capitalizacion			lxFormatosCompizq =  .Completarizq			lxFormatosCompder =  .Completarder			lxFormatosTruncar =  .Truncardecimales			lxFormatosCantdeci =  .Decimales			lxFormatosSepdec =  .Separadordecimal			lxFormatosSecmiles =  .Separadormiles			lxFormatosInicial =  .Simboloinicial			lxFormatosLltrim =  .Lltrim			lxFormatosLrtrim =  .Lrtrim			lxFormatosComillas =  .Agregarcomillas			lxFormatosComienza =  .Comienzacon			lxFormatosFormfecha =  .Formatofecha			lxFormatosOtroform =  .Otroformato
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ORGANIZACION.FORMATOS ( "Fecimpo","Fectrans","Fmodifw","Fecexpo","Faltafw","Bloqreg","Smodifw","Umodifw","Ualtafw","Saltafw","Vmodifw","Valtafw","Zadsfw","Bdaltafw","Esttrans","Bdmodifw","Haltafw","Hmodifw","Horaimpo","Horaexpo","Cobs","Codigo","Descrip","Alineacion","Capitaliz","Compizq","Compder","Truncar","Cantdeci","Sepdec","Secmiles","Inicial","Lltrim","Lrtrim","Comillas","Comienza","Formfecha","Otroform" ) values ( <<"'" + this.ConvertirDateSql( lxFormatosFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxFormatosFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxFormatosFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxFormatosFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxFormatosFaltafw ) + "'" >>, <<iif( lxFormatosBloqreg, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxFormatosSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFormatosUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFormatosUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFormatosSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFormatosVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFormatosValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFormatosZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFormatosBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFormatosEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFormatosBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFormatosHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFormatosHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFormatosHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFormatosHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFormatosCobs ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFormatosCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFormatosDescrip ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFormatosAlineacion ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFormatosCapitaliz ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFormatosCompizq ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFormatosCompder ) + "'" >>, <<iif( lxFormatosTruncar, 1, 0 ) >>, <<lxFormatosCantdeci >>, <<"'" + this.FormatearTextoSql( lxFormatosSepdec ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFormatosSecmiles ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFormatosInicial ) + "'" >>, <<iif( lxFormatosLltrim, 1, 0 ) >>, <<iif( lxFormatosLrtrim, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxFormatosComillas ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFormatosComienza ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFormatosFormfecha ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFormatosOtroform ) + "'" >> )
		endtext
		loColeccion.cTabla = 'FORMATOS' 
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
			local  lxFormatosFecimpo, lxFormatosFectrans, lxFormatosFmodifw, lxFormatosFecexpo, lxFormatosFaltafw, lxFormatosBloqreg, lxFormatosSmodifw, lxFormatosUmodifw, lxFormatosUaltafw, lxFormatosSaltafw, lxFormatosVmodifw, lxFormatosValtafw, lxFormatosZadsfw, lxFormatosBdaltafw, lxFormatosEsttrans, lxFormatosBdmodifw, lxFormatosHaltafw, lxFormatosHmodifw, lxFormatosHoraimpo, lxFormatosHoraexpo, lxFormatosCobs, lxFormatosCodigo, lxFormatosDescrip, lxFormatosAlineacion, lxFormatosCapitaliz, lxFormatosCompizq, lxFormatosCompder, lxFormatosTruncar, lxFormatosCantdeci, lxFormatosSepdec, lxFormatosSecmiles, lxFormatosInicial, lxFormatosLltrim, lxFormatosLrtrim, lxFormatosComillas, lxFormatosComienza, lxFormatosFormfecha, lxFormatosOtroform
				lxFormatosFecimpo =  .Fechaimpo			lxFormatosFectrans =  .Fechatransferencia			lxFormatosFmodifw =  .Fechamodificacionfw			lxFormatosFecexpo =  .Fechaexpo			lxFormatosFaltafw =  .Fechaaltafw			lxFormatosBloqreg =  .Bloquearregistro			lxFormatosSmodifw =  .Seriemodificacionfw			lxFormatosUmodifw =  .Usuariomodificacionfw			lxFormatosUaltafw =  .Usuarioaltafw			lxFormatosSaltafw =  .Seriealtafw			lxFormatosVmodifw =  .Versionmodificacionfw			lxFormatosValtafw =  .Versionaltafw			lxFormatosZadsfw =  .Zadsfw			lxFormatosBdaltafw =  .Basededatosaltafw			lxFormatosEsttrans =  .Estadotransferencia			lxFormatosBdmodifw =  .Basededatosmodificacionfw			lxFormatosHaltafw =  .Horaaltafw			lxFormatosHmodifw =  .Horamodificacionfw			lxFormatosHoraimpo =  .Horaimpo			lxFormatosHoraexpo =  .Horaexpo			lxFormatosCobs =  .Obs			lxFormatosCodigo =  .Codigo			lxFormatosDescrip =  .Descripcion			lxFormatosAlineacion =  .Alineacion			lxFormatosCapitaliz =  .Capitalizacion			lxFormatosCompizq =  .Completarizq			lxFormatosCompder =  .Completarder			lxFormatosTruncar =  .Truncardecimales			lxFormatosCantdeci =  .Decimales			lxFormatosSepdec =  .Separadordecimal			lxFormatosSecmiles =  .Separadormiles			lxFormatosInicial =  .Simboloinicial			lxFormatosLltrim =  .Lltrim			lxFormatosLrtrim =  .Lrtrim			lxFormatosComillas =  .Agregarcomillas			lxFormatosComienza =  .Comienzacon			lxFormatosFormfecha =  .Formatofecha			lxFormatosOtroform =  .Otroformato
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  FORMATOS.CODIGO != '']
			text to lcSentencia noshow textmerge
				update ORGANIZACION.FORMATOS set "Fecimpo" = <<"'" + this.ConvertirDateSql( lxFormatosFecimpo ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxFormatosFectrans ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxFormatosFmodifw ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxFormatosFecexpo ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxFormatosFaltafw ) + "'">>, "Bloqreg" = <<iif( lxFormatosBloqreg, 1, 0 )>>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxFormatosSmodifw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxFormatosUmodifw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxFormatosUaltafw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxFormatosSaltafw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxFormatosVmodifw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxFormatosValtafw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxFormatosZadsfw ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxFormatosBdaltafw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxFormatosEsttrans ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxFormatosBdmodifw ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxFormatosHaltafw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxFormatosHmodifw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxFormatosHoraimpo ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxFormatosHoraexpo ) + "'">>, "Cobs" = <<"'" + this.FormatearTextoSql( lxFormatosCobs ) + "'">>, "Codigo" = <<"'" + this.FormatearTextoSql( lxFormatosCodigo ) + "'">>, "Descrip" = <<"'" + this.FormatearTextoSql( lxFormatosDescrip ) + "'">>, "Alineacion" = <<"'" + this.FormatearTextoSql( lxFormatosAlineacion ) + "'">>, "Capitaliz" = <<"'" + this.FormatearTextoSql( lxFormatosCapitaliz ) + "'">>, "Compizq" = <<"'" + this.FormatearTextoSql( lxFormatosCompizq ) + "'">>, "Compder" = <<"'" + this.FormatearTextoSql( lxFormatosCompder ) + "'">>, "Truncar" = <<iif( lxFormatosTruncar, 1, 0 )>>, "Cantdeci" = <<lxFormatosCantdeci>>, "Sepdec" = <<"'" + this.FormatearTextoSql( lxFormatosSepdec ) + "'">>, "Secmiles" = <<"'" + this.FormatearTextoSql( lxFormatosSecmiles ) + "'">>, "Inicial" = <<"'" + this.FormatearTextoSql( lxFormatosInicial ) + "'">>, "Lltrim" = <<iif( lxFormatosLltrim, 1, 0 )>>, "Lrtrim" = <<iif( lxFormatosLrtrim, 1, 0 )>>, "Comillas" = <<"'" + this.FormatearTextoSql( lxFormatosComillas ) + "'">>, "Comienza" = <<"'" + this.FormatearTextoSql( lxFormatosComienza ) + "'">>, "Formfecha" = <<"'" + this.FormatearTextoSql( lxFormatosFormfecha ) + "'">>, "Otroform" = <<"'" + this.FormatearTextoSql( lxFormatosOtroform ) + "'">> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'FORMATOS' 
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

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  FORMATOS.CODIGO != '']
		loColeccion.Agregar( 'delete from ORGANIZACION.FORMATOS where ' + lcFiltro )
			loColeccion.cTabla = 'FORMATOS' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ORGANIZACION.FORMATOS where  FORMATOS.CODIGO != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ORGANIZACION.FORMATOS where codigo = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  FORMATOS.CODIGO != ''" )
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
		lcCursor = This.oEntidad.cPrefijoRecibir + 'FORMATOEXPORTACION'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ORGANIZACION.FORMATOS Where codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..codigo ) + "'", 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					this.oConexion.EjecutarSql( [UPDATE ORGANIZACION.FORMATOS set  FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, BLOQREG = ] + Transform( iif( &lcCursor..BLOQREG, 1, 0 ))+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, cObs = ] + "'" + this.FormatearTextoSql( &lcCursor..cObs ) + "'"+ [, codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..codigo ) + "'"+ [, descrip = ] + "'" + this.FormatearTextoSql( &lcCursor..descrip ) + "'"+ [, alineacion = ] + "'" + this.FormatearTextoSql( &lcCursor..alineacion ) + "'"+ [, capitaliz = ] + "'" + this.FormatearTextoSql( &lcCursor..capitaliz ) + "'"+ [, compizq = ] + "'" + this.FormatearTextoSql( &lcCursor..compizq ) + "'"+ [, compder = ] + "'" + this.FormatearTextoSql( &lcCursor..compder ) + "'"+ [, Truncar = ] + Transform( iif( &lcCursor..Truncar, 1, 0 ))+ [, CantDeci = ] + transform( &lcCursor..CantDeci )+ [, sepdec = ] + "'" + this.FormatearTextoSql( &lcCursor..sepdec ) + "'"+ [, secmiles = ] + "'" + this.FormatearTextoSql( &lcCursor..secmiles ) + "'"+ [, inicial = ] + "'" + this.FormatearTextoSql( &lcCursor..inicial ) + "'"+ [, lltrim = ] + Transform( iif( &lcCursor..lltrim, 1, 0 ))+ [, lrtrim = ] + Transform( iif( &lcCursor..lrtrim, 1, 0 ))+ [, comillas = ] + "'" + this.FormatearTextoSql( &lcCursor..comillas ) + "'"+ [, comienza = ] + "'" + this.FormatearTextoSql( &lcCursor..comienza ) + "'"+ [, formfecha = ] + "'" + this.FormatearTextoSql( &lcCursor..formfecha ) + "'"+ [, otroform = ] + "'" + this.FormatearTextoSql( &lcCursor..otroform ) + "'" + [ Where codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..codigo ) + "'" )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
				endIf
			else
				Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
				Text to lcCampos noShow
					 FECIMPO, FECTRANS, FMODIFW, FECEXPO, FALTAFW, BLOQREG, SMODIFW, UMODIFW, UALTAFW, SALTAFW, VMODIFW, VALTAFW, ZADSFW, BDALTAFW, ESTTRANS, BDMODIFW, HALTAFW, HMODIFW, HORAIMPO, HORAEXPO, cObs, codigo, descrip, alineacion, capitaliz, compizq, compder, Truncar, CantDeci, sepdec, secmiles, inicial, lltrim, lrtrim, comillas, comienza, formfecha, otroform
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + Transform( iif( &lcCursor..BLOQREG, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..cObs ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..codigo ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..descrip ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..alineacion ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..capitaliz ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..compizq ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..compder ) + "'" + ',' + Transform( iif( &lcCursor..Truncar, 1, 0 ))
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..CantDeci ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..sepdec ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..secmiles ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..inicial ) + "'" + ',' + Transform( iif( &lcCursor..lltrim, 1, 0 )) + ',' + Transform( iif( &lcCursor..lrtrim, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..comillas ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..comienza ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..formfecha ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..otroform ) + "'"
lcValoresCampos = substr(lcValoresCampos,2) 

				this.oConexion.EjecutarSql( [Insert into ORGANIZACION.FORMATOS ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
				this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'FORMATOEXPORTACION'
		if This.ActualizaEnRecepcion()
	endif
	Use in select( 'cExistentes' )
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearCursorMemo( tcCursorACrear as String, tcTablaConMemo as String ) as Void
		create cursor &tcCursorACrear ( codigo C (40) , Orden N(16), texto C(80))
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirComponentes() As Void
		
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function ObtenerIdentificadorParaLoguear( tcCursor as String ) As String
		local lcRetorno as String, lnCC as String , loCC as Object, lni as Integer, lcSecuencia as String
		lcRetorno = this.oEntidad.cDescripcion 
		lcRetorno = lcRetorno + ' - Código: ' + transform( &tcCursor..codigo     )
		Return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EsAliasDeProceso( tcAlias As String, tcPrefijo as string ) As Boolean
		local llRetorno as Boolean, lcAlias as String, lcPrefijo As String
		llRetorno = .F.
		lcAlias = upper( alltrim( tcAlias ) )
		lcPrefijo = upper( alltrim( tcPrefijo ) )
		Do Case
			Case  lcAlias == lcPrefijo + 'FORMATOEXPORTACION'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'FORMATOEXPORTACION_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'FORMATOEXPORTACION_COBS'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ORGANIZACION.TablaTrabajo_formatos')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'FORMATOEXPORTACION'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..codigo
		llCondicion = isnull( lxVar )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad FORMATOEXPORTACION. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'FORMATOEXPORTACION'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		select recno() as _Rec, * from &lcCursor into cursor CurConRecno
		select max( _Rec ) as Maximo,codigo as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( codigo, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		Use in select( 'CurConRecno' )
		Use in select( 'RepMax' )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDatosInvalidos( toConexion as Object ) as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'FORMATOEXPORTACION'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ORGANIZACION.TablaTrabajo_formatos') AND type in ('U')) DROP TABLE ORGANIZACION.TablaTrabajo_formatos
Create Table ORGANIZACION.TablaTrabajo_formatos ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fecimpo" datetime  null, 
"fectrans" datetime  null, 
"fmodifw" datetime  null, 
"fecexpo" datetime  null, 
"faltafw" datetime  null, 
"bloqreg" bit  null, 
"smodifw" char( 7 )  null, 
"umodifw" char( 100 )  null, 
"ualtafw" char( 100 )  null, 
"saltafw" char( 7 )  null, 
"vmodifw" char( 13 )  null, 
"valtafw" char( 13 )  null, 
"zadsfw" varchar(max)  null, 
"bdaltafw" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"bdmodifw" char( 8 )  null, 
"haltafw" char( 8 )  null, 
"hmodifw" char( 8 )  null, 
"horaimpo" char( 8 )  null, 
"horaexpo" char( 8 )  null, 
"cobs" varchar(max)  null, 
"codigo" char( 40 )  null, 
"descrip" char( 100 )  null, 
"alineacion" char( 40 )  null, 
"capitaliz" char( 40 )  null, 
"compizq" char( 40 )  null, 
"compder" char( 40 )  null, 
"truncar" bit  null, 
"cantdeci" numeric( 2, 0 )  null, 
"sepdec" char( 1 )  null, 
"secmiles" char( 1 )  null, 
"inicial" char( 40 )  null, 
"lltrim" bit  null, 
"lrtrim" bit  null, 
"comillas" char( 10 )  null, 
"comienza" char( 50 )  null, 
"formfecha" char( 20 )  null, 
"otroform" char( 100 )  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_formatos' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_formatos' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'FORMATOEXPORTACION'
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
			.AgregarMapeo('bloqreg','bloqreg')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('cobs','cobs')
			.AgregarMapeo('codigo','codigo')
			.AgregarMapeo('descrip','descrip')
			.AgregarMapeo('alineacion','alineacion')
			.AgregarMapeo('capitaliz','capitaliz')
			.AgregarMapeo('compizq','compizq')
			.AgregarMapeo('compder','compder')
			.AgregarMapeo('truncar','truncar')
			.AgregarMapeo('cantdeci','cantdeci')
			.AgregarMapeo('sepdec','sepdec')
			.AgregarMapeo('secmiles','secmiles')
			.AgregarMapeo('inicial','inicial')
			.AgregarMapeo('lltrim','lltrim')
			.AgregarMapeo('lrtrim','lrtrim')
			.AgregarMapeo('comillas','comillas')
			.AgregarMapeo('comienza','comienza')
			.AgregarMapeo('formfecha','formfecha')
			.AgregarMapeo('otroform','otroform')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ORGANIZACION.TablaTrabajo_formatos'
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
			CREATE TRIGGER ORGANIZACION.DELETE_<<lcTabla>>
				ON ORGANIZACION.<<lcTabla>>
				AFTER DELETE
			As
			Begin
				Update t Set t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.BLOQREG = isnull( d.BLOQREG, t.BLOQREG ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.COBS = isnull( d.COBS, t.COBS ),t.CODIGO = isnull( d.CODIGO, t.CODIGO ),t.DESCRIP = isnull( d.DESCRIP, t.DESCRIP ),t.ALINEACION = isnull( d.ALINEACION, t.ALINEACION ),t.CAPITALIZ = isnull( d.CAPITALIZ, t.CAPITALIZ ),t.COMPIZQ = isnull( d.COMPIZQ, t.COMPIZQ ),t.COMPDER = isnull( d.COMPDER, t.COMPDER ),t.TRUNCAR = isnull( d.TRUNCAR, t.TRUNCAR ),t.CANTDECI = isnull( d.CANTDECI, t.CANTDECI ),t.SEPDEC = isnull( d.SEPDEC, t.SEPDEC ),t.SECMILES = isnull( d.SECMILES, t.SECMILES ),t.INICIAL = isnull( d.INICIAL, t.INICIAL ),t.LLTRIM = isnull( d.LLTRIM, t.LLTRIM ),t.LRTRIM = isnull( d.LRTRIM, t.LRTRIM ),t.COMILLAS = isnull( d.COMILLAS, t.COMILLAS ),t.COMIENZA = isnull( d.COMIENZA, t.COMIENZA ),t.FORMFECHA = isnull( d.FORMFECHA, t.FORMFECHA ),t.OTROFORM = isnull( d.OTROFORM, t.OTROFORM )
					from ORGANIZACION.FORMATOS t inner join deleted d 
							 on t.codigo = d.codigo
				-- Fin Updates
				insert into ORGANIZACION.FORMATOS(Fecimpo,Fectrans,Fmodifw,Fecexpo,Faltafw,Bloqreg,Smodifw,Umodifw,Ualtafw,Saltafw,Vmodifw,Valtafw,Zadsfw,Bdaltafw,Esttrans,Bdmodifw,Haltafw,Hmodifw,Horaimpo,Horaexpo,Cobs,Codigo,Descrip,Alineacion,Capitaliz,Compizq,Compder,Truncar,Cantdeci,Sepdec,Secmiles,Inicial,Lltrim,Lrtrim,Comillas,Comienza,Formfecha,Otroform)
					Select isnull( d.FECIMPO,''),isnull( d.FECTRANS,''),isnull( d.FMODIFW,''),isnull( d.FECEXPO,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.BLOQREG,0),isnull( d.SMODIFW,''),isnull( d.UMODIFW,''),isnull( d.UALTAFW,''),isnull( d.SALTAFW,''),isnull( d.VMODIFW,''),isnull( d.VALTAFW,''),isnull( d.ZADSFW,''),isnull( d.BDALTAFW,''),isnull( d.ESTTRANS,''),isnull( d.BDMODIFW,''),convert( char(8), getdate(), 108 ),isnull( d.HMODIFW,''),isnull( d.HORAIMPO,''),isnull( d.HORAEXPO,''),isnull( d.COBS,''),isnull( d.CODIGO,''),isnull( d.DESCRIP,''),isnull( d.ALINEACION,''),isnull( d.CAPITALIZ,''),isnull( d.COMPIZQ,''),isnull( d.COMPDER,''),isnull( d.TRUNCAR,0),isnull( d.CANTDECI,0),isnull( d.SEPDEC,''),isnull( d.SECMILES,''),isnull( d.INICIAL,''),isnull( d.LLTRIM,0),isnull( d.LRTRIM,0),isnull( d.COMILLAS,''),isnull( d.COMIENZA,''),isnull( d.FORMFECHA,''),isnull( d.OTROFORM,'')
						From deleted d left join ORGANIZACION.FORMATOS pk 
							 on d.codigo = pk.codigo
						Where pk.codigo Is Null 
				-- Fin Inserts
			End
		EndText
		Return lcCadena
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	protected Function EliminarTablasDeTrabajo( toConexion as Object ) as void
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ORGANIZACION.TablaTrabajo_formatos') AND type in ('U')) DROP TABLE ORGANIZACION.TablaTrabajo_formatos
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_FORMATOEXPORTACION' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_FORMATOEXPORTACION.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_FORMATOEXPORTACION.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_FORMATOEXPORTACION.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_FORMATOEXPORTACION.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_FORMATOEXPORTACION.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Bloquearregistro = nvl( c_FORMATOEXPORTACION.Bloquearregistro, .F. )
					.Seriemodificacionfw = nvl( c_FORMATOEXPORTACION.Seriemodificacionfw, [] )
					.Usuariomodificacionfw = nvl( c_FORMATOEXPORTACION.Usuariomodificacionfw, [] )
					.Usuarioaltafw = nvl( c_FORMATOEXPORTACION.Usuarioaltafw, [] )
					.Seriealtafw = nvl( c_FORMATOEXPORTACION.Seriealtafw, [] )
					.Versionmodificacionfw = nvl( c_FORMATOEXPORTACION.Versionmodificacionfw, [] )
					.Versionaltafw = nvl( c_FORMATOEXPORTACION.Versionaltafw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Basededatosaltafw = nvl( c_FORMATOEXPORTACION.Basededatosaltafw, [] )
					.Estadotransferencia = nvl( c_FORMATOEXPORTACION.Estadotransferencia, [] )
					.Basededatosmodificacionfw = nvl( c_FORMATOEXPORTACION.Basededatosmodificacionfw, [] )
					.Horaaltafw = nvl( c_FORMATOEXPORTACION.Horaaltafw, [] )
					.Horamodificacionfw = nvl( c_FORMATOEXPORTACION.Horamodificacionfw, [] )
					.Horaimpo = nvl( c_FORMATOEXPORTACION.Horaimpo, [] )
					.Horaexpo = nvl( c_FORMATOEXPORTACION.Horaexpo, [] )
					lcValor = This.ObtenerMemo( 'c_Obs')
					.Obs = lcValor 
					.Codigo = nvl( c_FORMATOEXPORTACION.Codigo, [] )
					.Descripcion = nvl( c_FORMATOEXPORTACION.Descripcion, [] )
					.Alineacion = nvl( c_FORMATOEXPORTACION.Alineacion, [] )
					.Capitalizacion = nvl( c_FORMATOEXPORTACION.Capitalizacion, [] )
					.Completarizq = nvl( c_FORMATOEXPORTACION.Completarizq, [] )
					.Completarder = nvl( c_FORMATOEXPORTACION.Completarder, [] )
					.Truncardecimales = nvl( c_FORMATOEXPORTACION.Truncardecimales, .F. )
					.Decimales = nvl( c_FORMATOEXPORTACION.Decimales, 0 )
					.Separadordecimal = nvl( c_FORMATOEXPORTACION.Separadordecimal, [] )
					.Separadormiles = nvl( c_FORMATOEXPORTACION.Separadormiles, [] )
					.Simboloinicial = nvl( c_FORMATOEXPORTACION.Simboloinicial, [] )
					.Lltrim = nvl( c_FORMATOEXPORTACION.Lltrim, .F. )
					.Lrtrim = nvl( c_FORMATOEXPORTACION.Lrtrim, .F. )
					.Agregarcomillas = nvl( c_FORMATOEXPORTACION.Agregarcomillas, [] )
					.Comienzacon = nvl( c_FORMATOEXPORTACION.Comienzacon, [] )
					.Formatofecha = nvl( c_FORMATOEXPORTACION.Formatofecha, [] )
					.Otroformato = nvl( c_FORMATOEXPORTACION.Otroformato, [] )
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
		return c_FORMATOEXPORTACION.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		local lcNombreBD as String 
		lcNombreBD = ''
		lcNombreBD = this.oConexion.ObtenerNombreBD( 'ZOOLOGICMASTER' )
		lcNombreBD = goLibrerias.EscapeCaracteresSqlServer( lcNombreBD )

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID('<<lcNombreBD>>') AND OBJECT_ID=OBJECT_ID( '<<lcNombreBD>>.ORGANIZACION.FORMATOS' )
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
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "codigo"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
		text to lcSQL textmerge noshow
				SELECT nro,totalRegistros,codigo as Id
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    codigo from (
							select * 
								from ORGANIZACION.FORMATOS 
								Where   FORMATOS.CODIGO != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "FORMATOS", "", lcCursor, set("Datasession") )
		lcXml = this.CursorAXml( lcCursor )
		
		use in select( lcCursor )
		
		Return lcXml 
		
	endfunc
	*-----------------------------------------------------------------------------------------
	function ObtenerDatosEntidadPaginado( tcOrderBy as String, tcFiltro as String, tnCantidad as Integer, tnPagina as Integer )  as String
		local lcOrderBy as String, lnCuantos as Integer, lnPagina as Integer, lnTope as Integer, lnDesde as Integer, lcSQL as String, lcCursor as String, lcXml as String
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "codigo"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
			text to lcAtributos textmerge noshow
			"Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Bloqreg" as "Bloquearregistro", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Haltafw" as "Horaaltafw", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Cobs" as "Obs", "Codigo" as "Codigo", "Descrip" as "Descripcion", "Alineacion" as "Alineacion", "Capitaliz" as "Capitalizacion", "Compizq" as "Completarizq", "Compder" as "Completarder", "Truncar" as "Truncardecimales", "Cantdeci" as "Decimales", "Sepdec" as "Separadordecimal", "Secmiles" as "Separadormiles", "Inicial" as "Simboloinicial", "Lltrim" as "Lltrim", "Lrtrim" as "Lrtrim", "Comillas" as "Agregarcomillas", "Comienza" as "Comienzacon", "Formfecha" as "Formatofecha", "Otroform" as "Otroformato"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ORGANIZACION.FORMATOS 
								Where   FORMATOS.CODIGO != ''
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
	Tabla = 'FORMATOS'
	Filtro = " FORMATOS.CODIGO != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " FORMATOS.CODIGO != ''"
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
	<row entidad="FORMATOEXPORTACION                      " atributo="FECHAIMPO                               " tabla="FORMATOS       " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FORMATOEXPORTACION                      " atributo="FECHATRANSFERENCIA                      " tabla="FORMATOS       " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha transferencia                                                                                                                                             " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FORMATOEXPORTACION                      " atributo="FECHAMODIFICACIONFW                     " tabla="FORMATOS       " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FORMATOEXPORTACION                      " atributo="FECHAEXPO                               " tabla="FORMATOS       " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FORMATOEXPORTACION                      " atributo="FECHAALTAFW                             " tabla="FORMATOS       " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FORMATOEXPORTACION                      " atributo="BLOQUEARREGISTRO                        " tabla="FORMATOS       " campo="BLOQREG   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FORMATOEXPORTACION                      " atributo="SERIEMODIFICACIONFW                     " tabla="FORMATOS       " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FORMATOEXPORTACION                      " atributo="USUARIOMODIFICACIONFW                   " tabla="FORMATOS       " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FORMATOEXPORTACION                      " atributo="USUARIOALTAFW                           " tabla="FORMATOS       " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FORMATOEXPORTACION                      " atributo="SERIEALTAFW                             " tabla="FORMATOS       " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FORMATOEXPORTACION                      " atributo="VERSIONMODIFICACIONFW                   " tabla="FORMATOS       " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FORMATOEXPORTACION                      " atributo="VERSIONALTAFW                           " tabla="FORMATOS       " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FORMATOEXPORTACION                      " atributo="ZADSFW                                  " tabla="FORMATOS       " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FORMATOEXPORTACION                      " atributo="BASEDEDATOSALTAFW                       " tabla="FORMATOS       " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FORMATOEXPORTACION                      " atributo="ESTADOTRANSFERENCIA                     " tabla="FORMATOS       " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado transferencia                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FORMATOEXPORTACION                      " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="FORMATOS       " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FORMATOEXPORTACION                      " atributo="HORAALTAFW                              " tabla="FORMATOS       " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FORMATOEXPORTACION                      " atributo="HORAMODIFICACIONFW                      " tabla="FORMATOS       " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FORMATOEXPORTACION                      " atributo="HORAIMPO                                " tabla="FORMATOS       " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FORMATOEXPORTACION                      " atributo="HORAEXPO                                " tabla="FORMATOS       " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FORMATOEXPORTACION                      " atributo="OBS                                     " tabla="FORMATOS       " campo="COBS      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="200" etiqueta="Observación                                                                                                                                                     " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="5" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FORMATOEXPORTACION                      " atributo="CODIGO                                  " tabla="FORMATOS       " campo="CODIGO    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="1" etiqueta="Código                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FORMATOEXPORTACION                      " atributo="DESCRIPCION                             " tabla="FORMATOS       " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="2" etiqueta="Descripción                                                                                                                                                     " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FORMATOEXPORTACION                      " atributo="ALINEACION                              " tabla="FORMATOS       " campo="ALINEACION" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="= &quot;DEF&quot;                                                                                                                                                                                                                                                       " obligatorio="true" admitebusqueda="201" etiqueta="Alineación                                                                                                                                                      " dominio="COMBOALINEACION               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="10" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FORMATOEXPORTACION                      " atributo="CAPITALIZACION                          " tabla="FORMATOS       " campo="CAPITALIZ " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="= &quot;DEF&quot;                                                                                                                                                                                                                                                       " obligatorio="true" admitebusqueda="202" etiqueta="Capitalización                                                                                                                                                  " dominio="COMBOCAPITALIZACION           " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="20" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FORMATOEXPORTACION                      " atributo="COMPLETARIZQ                            " tabla="FORMATOS       " campo="COMPIZQ   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="203" etiqueta="Completar izquierda                                                                                                                                             " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="30" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FORMATOEXPORTACION                      " atributo="COMPLETARDER                            " tabla="FORMATOS       " campo="COMPDER   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="204" etiqueta="Completar derecha                                                                                                                                               " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="40" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FORMATOEXPORTACION                      " atributo="TRUNCARDECIMALES                        " tabla="FORMATOS       " campo="TRUNCAR   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="= .T.                                                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="205" etiqueta="Redondear                                                                                                                                                       " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="42" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FORMATOEXPORTACION                      " atributo="DECIMALES                               " tabla="FORMATOS       " campo="CANTDECI  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="206" etiqueta="Cantidad de decimales                                                                                                                                           " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="43" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FORMATOEXPORTACION                      " atributo="SEPARADORDECIMAL                        " tabla="FORMATOS       " campo="SEPDEC    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="207" etiqueta="Separador decimal                                                                                                                                               " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="50" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FORMATOEXPORTACION                      " atributo="SEPARADORMILES                          " tabla="FORMATOS       " campo="SECMILES  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="208" etiqueta="Separador de miles                                                                                                                                              " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="60" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FORMATOEXPORTACION                      " atributo="SIMBOLOINICIAL                          " tabla="FORMATOS       " campo="INICIAL   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="209" etiqueta="Simbolo inicial                                                                                                                                                 " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="70" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FORMATOEXPORTACION                      " atributo="LLTRIM                                  " tabla="FORMATOS       " campo="LLTRIM    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="210" etiqueta="Sacar espacios izquierda                                                                                                                                        " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="80" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FORMATOEXPORTACION                      " atributo="LRTRIM                                  " tabla="FORMATOS       " campo="LRTRIM    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="211" etiqueta="Sacar espacios derecha                                                                                                                                          " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="90" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FORMATOEXPORTACION                      " atributo="AGREGARCOMILLAS                         " tabla="FORMATOS       " campo="COMILLAS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Agregar comillas                                                                                                                                                " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="100" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FORMATOEXPORTACION                      " atributo="COMIENZACON                             " tabla="FORMATOS       " campo="COMIENZA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="212" etiqueta="Comienza con                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="105" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FORMATOEXPORTACION                      " atributo="FORMATOFECHA                            " tabla="FORMATOS       " campo="FORMFECHA " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="213" etiqueta="Formato de fecha                                                                                                                                                " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="4" orden="110" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FORMATOEXPORTACION                      " atributo="OTROFORMATO                             " tabla="FORMATOS       " campo="OTROFORM  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="214" etiqueta="Otro formato                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="4" orden="120" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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