
define class Din_EntidadREGISTRODEMANTENIMIENTOAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_REGISTRODEMANTENIMIENTO'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = [str( PuntoDeVenta, 4, 0) + str( Numero, 8, 0) + BaseDeDatosAltaFW]
	cExpresionCCPorCampos = [str( #tabla#.cPtoventa, 4, 0) + str( #tabla#.cNumero, 8, 0) + #tabla#.BDAltaFW]
	cTagClaveCandidata = '_RAMCC'
	cTagClavePk = '_RAMPK'
	cTablaPrincipal = 'REGACTISYS'
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
			local  lxRegactisysFectrans, lxRegactisysFaltafw, lxRegactisysFecexpo, lxRegactisysFmodifw, lxRegactisysFecimpo, lxRegactisysCestado, lxRegactisysHoraimpo, lxRegactisysHoraexpo, lxRegactisysUaltafw, lxRegactisysHmodifw, lxRegactisysVmodifw, lxRegactisysZadsfw, lxRegactisysUmodifw, lxRegactisysValtafw, lxRegactisysSaltafw, lxRegactisysSmodifw, lxRegactisysEsttrans, lxRegactisysHaltafw, lxRegactisysCsitio, lxRegactisysBdmodifw, lxRegactisysCfechafin, lxRegactisysCfechaini, lxRegactisysCtipo, lxRegactisysCcodigo, lxRegactisysChoraini, lxRegactisysChorafin, lxRegactisysCptoventa, lxRegactisysDet, lxRegactisysCnumero, lxRegactisysCresultado, lxRegactisysBdaltafw, lxRegactisysCdescrip
				lxRegactisysFectrans =  .Fechatransferencia			lxRegactisysFaltafw =  .Fechaaltafw			lxRegactisysFecexpo =  .Fechaexpo			lxRegactisysFmodifw =  .Fechamodificacionfw			lxRegactisysFecimpo =  .Fechaimpo			lxRegactisysCestado =  .Estado			lxRegactisysHoraimpo =  .Horaimpo			lxRegactisysHoraexpo =  .Horaexpo			lxRegactisysUaltafw =  .Usuarioaltafw			lxRegactisysHmodifw =  .Horamodificacionfw			lxRegactisysVmodifw =  .Versionmodificacionfw			lxRegactisysZadsfw =  .Zadsfw			lxRegactisysUmodifw =  .Usuariomodificacionfw			lxRegactisysValtafw =  .Versionaltafw			lxRegactisysSaltafw =  .Seriealtafw			lxRegactisysSmodifw =  .Seriemodificacionfw			lxRegactisysEsttrans =  .Estadotransferencia			lxRegactisysHaltafw =  .Horaaltafw			lxRegactisysCsitio =  .Sitio			lxRegactisysBdmodifw =  .Basededatosmodificacionfw			lxRegactisysCfechafin =  .Fechafin			lxRegactisysCfechaini =  .Fechainicio			lxRegactisysCtipo =  .Tipo			lxRegactisysCcodigo =  .Codigo			lxRegactisysChoraini =  .Horainicio			lxRegactisysChorafin =  .Horafin			lxRegactisysCptoventa =  .Puntodeventa			lxRegactisysDet =  .Registro			lxRegactisysCnumero =  .Numero			lxRegactisysCresultado =  .Resultadodelatarea			lxRegactisysBdaltafw =  .Basededatosaltafw			lxRegactisysCdescrip =  .Descripcion
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxRegactisysCcodigo = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ORGANIZACION.REGACTISYS ( "Fectrans","Faltafw","Fecexpo","Fmodifw","Fecimpo","Cestado","Horaimpo","Horaexpo","Ualtafw","Hmodifw","Vmodifw","Zadsfw","Umodifw","Valtafw","Saltafw","Smodifw","Esttrans","Haltafw","Csitio","Bdmodifw","Cfechafin","Cfechaini","Ctipo","Ccodigo","Choraini","Chorafin","Cptoventa","Det","Cnumero","Cresultado","Bdaltafw","Cdescrip" ) values ( <<"'" + this.ConvertirDateSql( lxRegactisysFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxRegactisysFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxRegactisysFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxRegactisysFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxRegactisysFecimpo ) + "'" >>, <<lxRegactisysCestado >>, <<"'" + this.FormatearTextoSql( lxRegactisysHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegactisysHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegactisysUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegactisysHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegactisysVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegactisysZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegactisysUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegactisysValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegactisysSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegactisysSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegactisysEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegactisysHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegactisysCsitio ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegactisysBdmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxRegactisysCfechafin ) + "'" >>, <<"'" + this.ConvertirDateSql( lxRegactisysCfechaini ) + "'" >>, <<lxRegactisysCtipo >>, <<"'" + this.FormatearTextoSql( lxRegactisysCcodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegactisysChoraini ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegactisysChorafin ) + "'" >>, <<lxRegactisysCptoventa >>, <<"'" + this.FormatearTextoSql( lxRegactisysDet ) + "'" >>, <<lxRegactisysCnumero >>, <<"'" + this.FormatearTextoSql( lxRegactisysCresultado ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegactisysBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegactisysCdescrip ) + "'" >> )
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
			If this.ConsultarPorClaveCandidata()
				lcError  = this.oEntidad.ObtenerMensajeClaveCandidataExistente()
			endif
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
			local  lxRegactisysFectrans, lxRegactisysFaltafw, lxRegactisysFecexpo, lxRegactisysFmodifw, lxRegactisysFecimpo, lxRegactisysCestado, lxRegactisysHoraimpo, lxRegactisysHoraexpo, lxRegactisysUaltafw, lxRegactisysHmodifw, lxRegactisysVmodifw, lxRegactisysZadsfw, lxRegactisysUmodifw, lxRegactisysValtafw, lxRegactisysSaltafw, lxRegactisysSmodifw, lxRegactisysEsttrans, lxRegactisysHaltafw, lxRegactisysCsitio, lxRegactisysBdmodifw, lxRegactisysCfechafin, lxRegactisysCfechaini, lxRegactisysCtipo, lxRegactisysCcodigo, lxRegactisysChoraini, lxRegactisysChorafin, lxRegactisysCptoventa, lxRegactisysDet, lxRegactisysCnumero, lxRegactisysCresultado, lxRegactisysBdaltafw, lxRegactisysCdescrip
				lxRegactisysFectrans =  .Fechatransferencia			lxRegactisysFaltafw =  .Fechaaltafw			lxRegactisysFecexpo =  .Fechaexpo			lxRegactisysFmodifw =  .Fechamodificacionfw			lxRegactisysFecimpo =  .Fechaimpo			lxRegactisysCestado =  .Estado			lxRegactisysHoraimpo =  .Horaimpo			lxRegactisysHoraexpo =  .Horaexpo			lxRegactisysUaltafw =  .Usuarioaltafw			lxRegactisysHmodifw =  .Horamodificacionfw			lxRegactisysVmodifw =  .Versionmodificacionfw			lxRegactisysZadsfw =  .Zadsfw			lxRegactisysUmodifw =  .Usuariomodificacionfw			lxRegactisysValtafw =  .Versionaltafw			lxRegactisysSaltafw =  .Seriealtafw			lxRegactisysSmodifw =  .Seriemodificacionfw			lxRegactisysEsttrans =  .Estadotransferencia			lxRegactisysHaltafw =  .Horaaltafw			lxRegactisysCsitio =  .Sitio			lxRegactisysBdmodifw =  .Basededatosmodificacionfw			lxRegactisysCfechafin =  .Fechafin			lxRegactisysCfechaini =  .Fechainicio			lxRegactisysCtipo =  .Tipo			lxRegactisysCcodigo =  .Codigo			lxRegactisysChoraini =  .Horainicio			lxRegactisysChorafin =  .Horafin			lxRegactisysCptoventa =  .Puntodeventa			lxRegactisysDet =  .Registro			lxRegactisysCnumero =  .Numero			lxRegactisysCresultado =  .Resultadodelatarea			lxRegactisysBdaltafw =  .Basededatosaltafw			lxRegactisysCdescrip =  .Descripcion
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()
			lxValorClavePrimaria = .oEntidad.CODIGO
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ORGANIZACION.REGACTISYS set "Fectrans" = <<"'" + this.ConvertirDateSql( lxRegactisysFectrans ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxRegactisysFaltafw ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxRegactisysFecexpo ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxRegactisysFmodifw ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxRegactisysFecimpo ) + "'">>,"Cestado" = <<lxRegactisysCestado>>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxRegactisysHoraimpo ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxRegactisysHoraexpo ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxRegactisysUaltafw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxRegactisysHmodifw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxRegactisysVmodifw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxRegactisysZadsfw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxRegactisysUmodifw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxRegactisysValtafw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxRegactisysSaltafw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxRegactisysSmodifw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxRegactisysEsttrans ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxRegactisysHaltafw ) + "'">>,"Csitio" = <<"'" + this.FormatearTextoSql( lxRegactisysCsitio ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxRegactisysBdmodifw ) + "'">>,"Cfechafin" = <<"'" + this.ConvertirDateSql( lxRegactisysCfechafin ) + "'">>,"Cfechaini" = <<"'" + this.ConvertirDateSql( lxRegactisysCfechaini ) + "'">>,"Ctipo" = <<lxRegactisysCtipo>>,"Ccodigo" = <<"'" + this.FormatearTextoSql( lxRegactisysCcodigo ) + "'">>,"Choraini" = <<"'" + this.FormatearTextoSql( lxRegactisysChoraini ) + "'">>,"Chorafin" = <<"'" + this.FormatearTextoSql( lxRegactisysChorafin ) + "'">>,"Cptoventa" = <<lxRegactisysCptoventa>>,"Det" = <<"'" + this.FormatearTextoSql( lxRegactisysDet ) + "'">>,"Cnumero" = <<lxRegactisysCnumero>>,"Cresultado" = <<"'" + this.FormatearTextoSql( lxRegactisysCresultado ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxRegactisysBdaltafw ) + "'">>,"Cdescrip" = <<"'" + this.FormatearTextoSql( lxRegactisysCdescrip ) + "'">> where "Ccodigo" = <<"'" + this.FormatearTextoSql( lxRegactisysCcodigo ) + "'">> and  REGACTISYS.CCODIGO != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 cCodigo from ORGANIZACION.REGACTISYS where " + this.ConvertirFuncionesSql( " REGACTISYS.CCODIGO != ''" ) )
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
			Local lxRegactisysCcodigo
			lxRegactisysCcodigo = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Cestado" as "Estado", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Csitio" as "Sitio", "Bdmodifw" as "Basededatosmodificacionfw", "Cfechafin" as "Fechafin", "Cfechaini" as "Fechainicio", "Ctipo" as "Tipo", "Ccodigo" as "Codigo", "Choraini" as "Horainicio", "Chorafin" as "Horafin", "Cptoventa" as "Puntodeventa", "Det" as "Registro", "Cnumero" as "Numero", "Cresultado" as "Resultadodelatarea", "Bdaltafw" as "Basededatosaltafw", "Cdescrip" as "Descripcion" from ORGANIZACION.REGACTISYS where "Ccodigo" = <<"'" + this.FormatearTextoSql( lxRegactisysCcodigo ) + "'">> and  REGACTISYS.CCODIGO != ''
			endtext
			use in select('c_REGISTRODEMANTENIMIENTO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_REGISTRODEMANTENIMIENTO', set( 'Datasession' ) )

			if reccount( 'c_REGISTRODEMANTENIMIENTO' ) = 0
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
			Local lxRegActiSyscPtoventa As Variant, lxRegActiSyscNumero As Variant, lxRegActiSysBDAltaFW As Variant
			lxRegActiSyscPtoventa = .PuntoDeVenta
			lxRegActiSyscNumero = .Numero
			lxRegActiSysBDAltaFW = .BaseDeDatosAltaFW
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Cestado" as "Estado", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Csitio" as "Sitio", "Bdmodifw" as "Basededatosmodificacionfw", "Cfechafin" as "Fechafin", "Cfechaini" as "Fechainicio", "Ctipo" as "Tipo", "Ccodigo" as "Codigo", "Choraini" as "Horainicio", "Chorafin" as "Horafin", "Cptoventa" as "Puntodeventa", "Det" as "Registro", "Cnumero" as "Numero", "Cresultado" as "Resultadodelatarea", "Bdaltafw" as "Basededatosaltafw", "Cdescrip" as "Descripcion" from ORGANIZACION.REGACTISYS where  REGACTISYS.CCODIGO != '' And cPtoventa = <<lxRegActiSyscPtoventa>> and cNumero = <<lxRegActiSyscNumero>> and BDAltaFW = <<"'" + this.FormatearTextoSql( lxRegActiSysBDAltaFW ) + "'">>
			endtext
			use in select('c_REGISTRODEMANTENIMIENTO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_REGISTRODEMANTENIMIENTO', set( 'Datasession' ) )
			if reccount( 'c_REGISTRODEMANTENIMIENTO' ) = 0
				llRetorno = .f.
			else
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxRegactisysCcodigo as Variant
		llRetorno = .t.
		lxRegactisysCcodigo = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ORGANIZACION.REGACTISYS where "Ccodigo" = <<"'" + this.FormatearTextoSql( lxRegactisysCcodigo ) + "'">> and  REGACTISYS.CCODIGO != ''
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
				lcOrden =  str( .PuntoDeVenta, 4, 0) + str( .Numero, 8, 0) + .BaseDeDatosAltaFW
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Cestado" as "Estado", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Csitio" as "Sitio", "Bdmodifw" as "Basededatosmodificacionfw", "Cfechafin" as "Fechafin", "Cfechaini" as "Fechainicio", "Ctipo" as "Tipo", "Ccodigo" as "Codigo", "Choraini" as "Horainicio", "Chorafin" as "Horafin", "Cptoventa" as "Puntodeventa", "Det" as "Registro", "Cnumero" as "Numero", "Cresultado" as "Resultadodelatarea", "Bdaltafw" as "Basededatosaltafw", "Cdescrip" as "Descripcion" from ORGANIZACION.REGACTISYS where  REGACTISYS.CCODIGO != '' order by cPtoventa,cNumero,BDAltaFW
			endtext
			use in select('c_REGISTRODEMANTENIMIENTO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_REGISTRODEMANTENIMIENTO', set( 'Datasession' ) )
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
				lcOrden =  str( .PuntoDeVenta, 4, 0) + str( .Numero, 8, 0) + .BaseDeDatosAltaFW
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Cestado" as "Estado", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Csitio" as "Sitio", "Bdmodifw" as "Basededatosmodificacionfw", "Cfechafin" as "Fechafin", "Cfechaini" as "Fechainicio", "Ctipo" as "Tipo", "Ccodigo" as "Codigo", "Choraini" as "Horainicio", "Chorafin" as "Horafin", "Cptoventa" as "Puntodeventa", "Det" as "Registro", "Cnumero" as "Numero", "Cresultado" as "Resultadodelatarea", "Bdaltafw" as "Basededatosaltafw", "Cdescrip" as "Descripcion" from ORGANIZACION.REGACTISYS where  str( cPtoventa, 4, 0) + str( cNumero, 8, 0) + funciones.padr( BDAltaFW, 8, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  REGACTISYS.CCODIGO != '' order by cPtoventa,cNumero,BDAltaFW
			endtext
			use in select('c_REGISTRODEMANTENIMIENTO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_REGISTRODEMANTENIMIENTO', set( 'Datasession' ) )
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
				lcOrden =  str( .PuntoDeVenta, 4, 0) + str( .Numero, 8, 0) + .BaseDeDatosAltaFW
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Cestado" as "Estado", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Csitio" as "Sitio", "Bdmodifw" as "Basededatosmodificacionfw", "Cfechafin" as "Fechafin", "Cfechaini" as "Fechainicio", "Ctipo" as "Tipo", "Ccodigo" as "Codigo", "Choraini" as "Horainicio", "Chorafin" as "Horafin", "Cptoventa" as "Puntodeventa", "Det" as "Registro", "Cnumero" as "Numero", "Cresultado" as "Resultadodelatarea", "Bdaltafw" as "Basededatosaltafw", "Cdescrip" as "Descripcion" from ORGANIZACION.REGACTISYS where  str( cPtoventa, 4, 0) + str( cNumero, 8, 0) + funciones.padr( BDAltaFW, 8, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  REGACTISYS.CCODIGO != '' order by cPtoventa desc,cNumero desc,BDAltaFW desc
			endtext
			use in select('c_REGISTRODEMANTENIMIENTO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_REGISTRODEMANTENIMIENTO', set( 'Datasession' ) )
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
				lcOrden =  str( .PuntoDeVenta, 4, 0) + str( .Numero, 8, 0) + .BaseDeDatosAltaFW
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Cestado" as "Estado", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Csitio" as "Sitio", "Bdmodifw" as "Basededatosmodificacionfw", "Cfechafin" as "Fechafin", "Cfechaini" as "Fechainicio", "Ctipo" as "Tipo", "Ccodigo" as "Codigo", "Choraini" as "Horainicio", "Chorafin" as "Horafin", "Cptoventa" as "Puntodeventa", "Det" as "Registro", "Cnumero" as "Numero", "Cresultado" as "Resultadodelatarea", "Bdaltafw" as "Basededatosaltafw", "Cdescrip" as "Descripcion" from ORGANIZACION.REGACTISYS where  REGACTISYS.CCODIGO != '' order by cPtoventa desc,cNumero desc,BDAltaFW desc
			endtext
			use in select('c_REGISTRODEMANTENIMIENTO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_REGISTRODEMANTENIMIENTO', set( 'Datasession' ) )
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
			lcXml = this.oConexion.EjecutarSql( "select Fectrans,Faltafw,Fecexpo,Fmodifw,Fecimpo,Cestado,Horaimpo,Horaexpo,Ualtafw,Hmodifw,Vmodifw,Z" + ;
"adsfw,Umodifw,Valtafw,Saltafw,Smodifw,Esttrans,Haltafw,Csitio,Bdmodifw,Cfechafin,Cfechaini,Ctipo,Cco" + ;
"digo,Choraini,Chorafin,Cptoventa,Det,Cnumero,Cresultado,Bdaltafw,Cdescrip" + ;
" from ORGANIZACION.REGACTISYS where  REGACTISYS.CCODIGO != '' and " + lcFiltro )
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
			local  lxRegactisysFectrans, lxRegactisysFaltafw, lxRegactisysFecexpo, lxRegactisysFmodifw, lxRegactisysFecimpo, lxRegactisysCestado, lxRegactisysHoraimpo, lxRegactisysHoraexpo, lxRegactisysUaltafw, lxRegactisysHmodifw, lxRegactisysVmodifw, lxRegactisysZadsfw, lxRegactisysUmodifw, lxRegactisysValtafw, lxRegactisysSaltafw, lxRegactisysSmodifw, lxRegactisysEsttrans, lxRegactisysHaltafw, lxRegactisysCsitio, lxRegactisysBdmodifw, lxRegactisysCfechafin, lxRegactisysCfechaini, lxRegactisysCtipo, lxRegactisysCcodigo, lxRegactisysChoraini, lxRegactisysChorafin, lxRegactisysCptoventa, lxRegactisysDet, lxRegactisysCnumero, lxRegactisysCresultado, lxRegactisysBdaltafw, lxRegactisysCdescrip
				lxRegactisysFectrans = ctod( '  /  /    ' )			lxRegactisysFaltafw = ctod( '  /  /    ' )			lxRegactisysFecexpo = ctod( '  /  /    ' )			lxRegactisysFmodifw = ctod( '  /  /    ' )			lxRegactisysFecimpo = ctod( '  /  /    ' )			lxRegactisysCestado = 0			lxRegactisysHoraimpo = []			lxRegactisysHoraexpo = []			lxRegactisysUaltafw = []			lxRegactisysHmodifw = []			lxRegactisysVmodifw = []			lxRegactisysZadsfw = []			lxRegactisysUmodifw = []			lxRegactisysValtafw = []			lxRegactisysSaltafw = []			lxRegactisysSmodifw = []			lxRegactisysEsttrans = []			lxRegactisysHaltafw = []			lxRegactisysCsitio = []			lxRegactisysBdmodifw = []			lxRegactisysCfechafin = ctod( '  /  /    ' )			lxRegactisysCfechaini = ctod( '  /  /    ' )			lxRegactisysCtipo = 0			lxRegactisysCcodigo = []			lxRegactisysChoraini = []			lxRegactisysChorafin = []			lxRegactisysCptoventa = 0			lxRegactisysDet = []			lxRegactisysCnumero = 0			lxRegactisysCresultado = []			lxRegactisysBdaltafw = []			lxRegactisysCdescrip = []
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( [delete from ORGANIZACION.REGACTISYS where "cCodigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'REGACTISYS' + '_' + tcCampo
			lcMemoAscii = ''

			lnIndice = alen(.aSqlMemos)
			lnIndice = iif(lnIndice = 1, 1, lnIndice + 1 )
			dimension .aSqlMemos(lnIndice)

			.aSqlMemos(lnIndice) = 'delete from ' + lcTabla + ' where cCodigo = ' + txValorClavePrimaria
			.GenerarSentenciasInsertTablaMemo( lcValor, lcTabla, txValorClavePrimaria )
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerSentenciaInsertMemo( tcTabla as String, txValorClavePrimaria as String, tcOrden as String, tcTexto as String ) as String
		return "Insert  into " + tcTabla + "(cCodigo, Orden, texto ) values ( " + txValorClavePrimaria + "," + tcOrden + ",'"+ tcTexto + "')"
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosEntidad( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  REGACTISYS.CCODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Cestado" as "Estado", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Csitio" as "Sitio", "Bdmodifw" as "Basededatosmodificacionfw", "Cfechafin" as "Fechafin", "Cfechaini" as "Fechainicio", "Ctipo" as "Tipo", "Ccodigo" as "Codigo", "Choraini" as "Horainicio", "Chorafin" as "Horafin", "Cptoventa" as "Puntodeventa", "Det" as "Registro", "Cnumero" as "Numero", "Cresultado" as "Resultadodelatarea", "Bdaltafw" as "Basededatosaltafw", "Cdescrip" as "Descripcion"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'REGACTISYS', '', tnTope )
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
				Case lcAtributo == 'FECHAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECEXPO AS FECHAEXPO'
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'FECHAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECIMPO AS FECHAIMPO'
				Case lcAtributo == 'ESTADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CESTADO AS ESTADO'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'SITIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CSITIO AS SITIO'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'FECHAFIN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CFECHAFIN AS FECHAFIN'
				Case lcAtributo == 'FECHAINICIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CFECHAINI AS FECHAINICIO'
				Case lcAtributo == 'TIPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CTIPO AS TIPO'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CCODIGO AS CODIGO'
				Case lcAtributo == 'HORAINICIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CHORAINI AS HORAINICIO'
				Case lcAtributo == 'HORAFIN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CHORAFIN AS HORAFIN'
				Case lcAtributo == 'PUNTODEVENTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CPTOVENTA AS PUNTODEVENTA'
				Case lcAtributo == 'REGISTRO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DET AS REGISTRO'
				Case lcAtributo == 'NUMERO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CNUMERO AS NUMERO'
				Case lcAtributo == 'RESULTADODELATAREA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CRESULTADO AS RESULTADODELATAREA'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'DESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CDESCRIP AS DESCRIPCION'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEXPO'
				lcCampo = 'FECEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAIMPO'
				lcCampo = 'FECIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADO'
				lcCampo = 'CESTADO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SITIO'
				lcCampo = 'CSITIO'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAFIN'
				lcCampo = 'CFECHAFIN'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAINICIO'
				lcCampo = 'CFECHAINI'
			Case upper( alltrim( tcAtributo ) ) == 'TIPO'
				lcCampo = 'CTIPO'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CCODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAINICIO'
				lcCampo = 'CHORAINI'
			Case upper( alltrim( tcAtributo ) ) == 'HORAFIN'
				lcCampo = 'CHORAFIN'
			Case upper( alltrim( tcAtributo ) ) == 'PUNTODEVENTA'
				lcCampo = 'CPTOVENTA'
			Case upper( alltrim( tcAtributo ) ) == 'REGISTRO'
				lcCampo = 'DET'
			Case upper( alltrim( tcAtributo ) ) == 'NUMERO'
				lcCampo = 'CNUMERO'
			Case upper( alltrim( tcAtributo ) ) == 'RESULTADODELATAREA'
				lcCampo = 'CRESULTADO'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCION'
				lcCampo = 'CDESCRIP'
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
			local  lxRegactisysFectrans, lxRegactisysFaltafw, lxRegactisysFecexpo, lxRegactisysFmodifw, lxRegactisysFecimpo, lxRegactisysCestado, lxRegactisysHoraimpo, lxRegactisysHoraexpo, lxRegactisysUaltafw, lxRegactisysHmodifw, lxRegactisysVmodifw, lxRegactisysZadsfw, lxRegactisysUmodifw, lxRegactisysValtafw, lxRegactisysSaltafw, lxRegactisysSmodifw, lxRegactisysEsttrans, lxRegactisysHaltafw, lxRegactisysCsitio, lxRegactisysBdmodifw, lxRegactisysCfechafin, lxRegactisysCfechaini, lxRegactisysCtipo, lxRegactisysCcodigo, lxRegactisysChoraini, lxRegactisysChorafin, lxRegactisysCptoventa, lxRegactisysDet, lxRegactisysCnumero, lxRegactisysCresultado, lxRegactisysBdaltafw, lxRegactisysCdescrip
				lxRegactisysFectrans =  .Fechatransferencia			lxRegactisysFaltafw =  .Fechaaltafw			lxRegactisysFecexpo =  .Fechaexpo			lxRegactisysFmodifw =  .Fechamodificacionfw			lxRegactisysFecimpo =  .Fechaimpo			lxRegactisysCestado =  .Estado			lxRegactisysHoraimpo =  .Horaimpo			lxRegactisysHoraexpo =  .Horaexpo			lxRegactisysUaltafw =  .Usuarioaltafw			lxRegactisysHmodifw =  .Horamodificacionfw			lxRegactisysVmodifw =  .Versionmodificacionfw			lxRegactisysZadsfw =  .Zadsfw			lxRegactisysUmodifw =  .Usuariomodificacionfw			lxRegactisysValtafw =  .Versionaltafw			lxRegactisysSaltafw =  .Seriealtafw			lxRegactisysSmodifw =  .Seriemodificacionfw			lxRegactisysEsttrans =  .Estadotransferencia			lxRegactisysHaltafw =  .Horaaltafw			lxRegactisysCsitio =  .Sitio			lxRegactisysBdmodifw =  .Basededatosmodificacionfw			lxRegactisysCfechafin =  .Fechafin			lxRegactisysCfechaini =  .Fechainicio			lxRegactisysCtipo =  .Tipo			lxRegactisysCcodigo =  .Codigo			lxRegactisysChoraini =  .Horainicio			lxRegactisysChorafin =  .Horafin			lxRegactisysCptoventa =  .Puntodeventa			lxRegactisysDet =  .Registro			lxRegactisysCnumero =  .Numero			lxRegactisysCresultado =  .Resultadodelatarea			lxRegactisysBdaltafw =  .Basededatosaltafw			lxRegactisysCdescrip =  .Descripcion
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ORGANIZACION.REGACTISYS ( "Fectrans","Faltafw","Fecexpo","Fmodifw","Fecimpo","Cestado","Horaimpo","Horaexpo","Ualtafw","Hmodifw","Vmodifw","Zadsfw","Umodifw","Valtafw","Saltafw","Smodifw","Esttrans","Haltafw","Csitio","Bdmodifw","Cfechafin","Cfechaini","Ctipo","Ccodigo","Choraini","Chorafin","Cptoventa","Det","Cnumero","Cresultado","Bdaltafw","Cdescrip" ) values ( <<"'" + this.ConvertirDateSql( lxRegactisysFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxRegactisysFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxRegactisysFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxRegactisysFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxRegactisysFecimpo ) + "'" >>, <<lxRegactisysCestado >>, <<"'" + this.FormatearTextoSql( lxRegactisysHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegactisysHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegactisysUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegactisysHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegactisysVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegactisysZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegactisysUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegactisysValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegactisysSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegactisysSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegactisysEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegactisysHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegactisysCsitio ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegactisysBdmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxRegactisysCfechafin ) + "'" >>, <<"'" + this.ConvertirDateSql( lxRegactisysCfechaini ) + "'" >>, <<lxRegactisysCtipo >>, <<"'" + this.FormatearTextoSql( lxRegactisysCcodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegactisysChoraini ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegactisysChorafin ) + "'" >>, <<lxRegactisysCptoventa >>, <<"'" + this.FormatearTextoSql( lxRegactisysDet ) + "'" >>, <<lxRegactisysCnumero >>, <<"'" + this.FormatearTextoSql( lxRegactisysCresultado ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegactisysBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegactisysCdescrip ) + "'" >> )
		endtext
		loColeccion.cTabla = 'REGACTISYS' 
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
			local  lxRegactisysFectrans, lxRegactisysFaltafw, lxRegactisysFecexpo, lxRegactisysFmodifw, lxRegactisysFecimpo, lxRegactisysCestado, lxRegactisysHoraimpo, lxRegactisysHoraexpo, lxRegactisysUaltafw, lxRegactisysHmodifw, lxRegactisysVmodifw, lxRegactisysZadsfw, lxRegactisysUmodifw, lxRegactisysValtafw, lxRegactisysSaltafw, lxRegactisysSmodifw, lxRegactisysEsttrans, lxRegactisysHaltafw, lxRegactisysCsitio, lxRegactisysBdmodifw, lxRegactisysCfechafin, lxRegactisysCfechaini, lxRegactisysCtipo, lxRegactisysCcodigo, lxRegactisysChoraini, lxRegactisysChorafin, lxRegactisysCptoventa, lxRegactisysDet, lxRegactisysCnumero, lxRegactisysCresultado, lxRegactisysBdaltafw, lxRegactisysCdescrip
				lxRegactisysFectrans =  .Fechatransferencia			lxRegactisysFaltafw =  .Fechaaltafw			lxRegactisysFecexpo =  .Fechaexpo			lxRegactisysFmodifw =  .Fechamodificacionfw			lxRegactisysFecimpo =  .Fechaimpo			lxRegactisysCestado =  .Estado			lxRegactisysHoraimpo =  .Horaimpo			lxRegactisysHoraexpo =  .Horaexpo			lxRegactisysUaltafw =  .Usuarioaltafw			lxRegactisysHmodifw =  .Horamodificacionfw			lxRegactisysVmodifw =  .Versionmodificacionfw			lxRegactisysZadsfw =  .Zadsfw			lxRegactisysUmodifw =  .Usuariomodificacionfw			lxRegactisysValtafw =  .Versionaltafw			lxRegactisysSaltafw =  .Seriealtafw			lxRegactisysSmodifw =  .Seriemodificacionfw			lxRegactisysEsttrans =  .Estadotransferencia			lxRegactisysHaltafw =  .Horaaltafw			lxRegactisysCsitio =  .Sitio			lxRegactisysBdmodifw =  .Basededatosmodificacionfw			lxRegactisysCfechafin =  .Fechafin			lxRegactisysCfechaini =  .Fechainicio			lxRegactisysCtipo =  .Tipo			lxRegactisysCcodigo =  .Codigo			lxRegactisysChoraini =  .Horainicio			lxRegactisysChorafin =  .Horafin			lxRegactisysCptoventa =  .Puntodeventa			lxRegactisysDet =  .Registro			lxRegactisysCnumero =  .Numero			lxRegactisysCresultado =  .Resultadodelatarea			lxRegactisysBdaltafw =  .Basededatosaltafw			lxRegactisysCdescrip =  .Descripcion
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Ccodigo" = ] + lcValorClavePrimariaString  + [ and  REGACTISYS.CCODIGO != '']
			text to lcSentencia noshow textmerge
				update ORGANIZACION.REGACTISYS set "Fectrans" = <<"'" + this.ConvertirDateSql( lxRegactisysFectrans ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxRegactisysFaltafw ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxRegactisysFecexpo ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxRegactisysFmodifw ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxRegactisysFecimpo ) + "'">>, "Cestado" = <<lxRegactisysCestado>>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxRegactisysHoraimpo ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxRegactisysHoraexpo ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxRegactisysUaltafw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxRegactisysHmodifw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxRegactisysVmodifw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxRegactisysZadsfw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxRegactisysUmodifw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxRegactisysValtafw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxRegactisysSaltafw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxRegactisysSmodifw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxRegactisysEsttrans ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxRegactisysHaltafw ) + "'">>, "Csitio" = <<"'" + this.FormatearTextoSql( lxRegactisysCsitio ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxRegactisysBdmodifw ) + "'">>, "Cfechafin" = <<"'" + this.ConvertirDateSql( lxRegactisysCfechafin ) + "'">>, "Cfechaini" = <<"'" + this.ConvertirDateSql( lxRegactisysCfechaini ) + "'">>, "Ctipo" = <<lxRegactisysCtipo>>, "Ccodigo" = <<"'" + this.FormatearTextoSql( lxRegactisysCcodigo ) + "'">>, "Choraini" = <<"'" + this.FormatearTextoSql( lxRegactisysChoraini ) + "'">>, "Chorafin" = <<"'" + this.FormatearTextoSql( lxRegactisysChorafin ) + "'">>, "Cptoventa" = <<lxRegactisysCptoventa>>, "Det" = <<"'" + this.FormatearTextoSql( lxRegactisysDet ) + "'">>, "Cnumero" = <<lxRegactisysCnumero>>, "Cresultado" = <<"'" + this.FormatearTextoSql( lxRegactisysCresultado ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxRegactisysBdaltafw ) + "'">>, "Cdescrip" = <<"'" + this.FormatearTextoSql( lxRegactisysCdescrip ) + "'">> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'REGACTISYS' 
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

			lcFiltro = ["Ccodigo" = ] + lcValorClavePrimariaString  + [ and  REGACTISYS.CCODIGO != '']
		loColeccion.Agregar( 'delete from ORGANIZACION.REGACTISYS where ' + lcFiltro )
			loColeccion.cTabla = 'REGACTISYS' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ORGANIZACION.REGACTISYS where  REGACTISYS.CCODIGO != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ORGANIZACION.REGACTISYS where cCodigo = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  REGACTISYS.CCODIGO != ''" )
			this.xmlacursor( lcXml, lcCursor )
		if reccount( lcCursor ) > 0
			lnTimeStamp = &lcCursor..Timestamp
		endif
		use in select( lcCursor )

		return lnTimeStamp 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirCabecera( tlLoguear as Boolean ) As Void
		local lcCursor as String, ldFecha as Date, lcHora as string, lcValorABuscar As String, lxValorClavePK As variant, lxValorClavePrimaria As variant, lcIdentificadorParaLoguear as string, lxRegActiSyscPtoventa as variant, lxRegActiSyscNumero as variant, lxRegActiSysBDAltaFW as variant, lcMensajeExtra as String
		lcValorABuscar = ''
		lxValorClavePK = ''
		lcMensajeExtra = ''
		lcCursor = This.oEntidad.cPrefijoRecibir + 'REGISTRODEMANTENIMIENTO'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ORGANIZACION.REGACTISYS Where  cPtoventa = ] + transform( &lcCursor..cPtoventa  ) + [ and cNumero = ] + transform( &lcCursor..cNumero    ) + [ and BDAltaFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDAltaFW   ) + "'", 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				lxValorClavePK = &lcCursor..cCodigo
				if lxValorClavePK == curSeek.cCodigo or this.oEntidad.lIgnorarClaveprimariaEnRecepcionBD 
					if lxValorClavePK != curSeek.cCodigo and this.oEntidad.lIgnorarClaveprimariaEnRecepcionBD 
						lcValorABuscar = curSeek.cCodigo
					else 
						lcValorABuscar = lxValorClavePK 
					endif 
					if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
						Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
						this.oConexion.EjecutarSql( [UPDATE ORGANIZACION.REGACTISYS set  FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, cEstado = ] + transform( &lcCursor..cEstado )+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, cSitio = ] + "'" + this.FormatearTextoSql( &lcCursor..cSitio ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, cFechaFin = ] + "'" + this.ConvertirDateSql( &lcCursor..cFechaFin ) + "'"+ [, cFechaIni = ] + "'" + this.ConvertirDateSql( &lcCursor..cFechaIni ) + "'"+ [, cTipo = ] + transform( &lcCursor..cTipo )+ [, cCodigo = ] + "'" + this.FormatearTextoSql( &lcCursor..cCodigo ) + "'"+ [, cHoraIni = ] + "'" + this.FormatearTextoSql( &lcCursor..cHoraIni ) + "'"+ [, cHoraFin = ] + "'" + this.FormatearTextoSql( &lcCursor..cHoraFin ) + "'"+ [, cPtoventa = ] + transform( &lcCursor..cPtoventa )+ [, det = ] + "'" + this.FormatearTextoSql( &lcCursor..det ) + "'"+ [, cNumero = ] + transform( &lcCursor..cNumero )+ [, cResultado = ] + "'" + this.FormatearTextoSql( &lcCursor..cResultado ) + "'"+ [, cDescrip = ] + "'" + this.FormatearTextoSql( &lcCursor..cDescrip ) + "'" + [ Where cCodigo = ] + "'" + this.FormatearTextoSql( lcValorABuscar ) + "'" )
						this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
					else
						this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
					endIf
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir porque no coincide la clave principal.', tlLoguear )
				endIf
			else
				this.oConexion.EjecutarSql( [Select * From ORGANIZACION.REGACTISYS Where cCodigo = ] + "'" + this.FormatearTextoSql( &lcCursor..cCodigo ) + "'", 'curSeek', this.datasessionid )
				if reccount( 'curSeek' ) > 0
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir como alta porque la clave principal ya existe', tlLoguear )
				Else
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					Text to lcCampos noShow
						 FECTRANS, FALTAFW, FECEXPO, FMODIFW, FECIMPO, cEstado, HORAIMPO, HORAEXPO, UALTAFW, HMODIFW, VMODIFW, ZADSFW, UMODIFW, VALTAFW, SALTAFW, SMODIFW, ESTTRANS, HALTAFW, cSitio, BDMODIFW, cFechaFin, cFechaIni, cTipo, cCodigo, cHoraIni, cHoraFin, cPtoventa, det, cNumero, cResultado, BDAltaFW, cDescrip
					EndText
					local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + transform( &lcCursor..cEstado ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..cSitio ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..cFechaFin ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..cFechaIni ) + "'" + ',' + transform( &lcCursor..cTipo ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..cCodigo ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..cHoraIni ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..cHoraFin ) + "'" + ',' + transform( &lcCursor..cPtoventa ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..det ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..cNumero ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..cResultado ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDAltaFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..cDescrip ) + "'"
lcValoresCampos = substr(lcValoresCampos,2) 

					this.oConexion.EjecutarSql( [Insert into ORGANIZACION.REGACTISYS ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
				EndIf
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'REGISTRODEMANTENIMIENTO'
		if This.ActualizaEnRecepcion()
	endif
	Use in select( 'cExistentes' )
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearCursorMemo( tcCursorACrear as String, tcTablaConMemo as String ) as Void
		create cursor &tcCursorACrear ( cCodigo C (38) , Orden N(16), texto C(80))
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirComponentes() As Void
		
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function ObtenerIdentificadorParaLoguear( tcCursor as String ) As String
		local lcRetorno as String, lnCC as String , loCC as Object, lni as Integer, lcSecuencia as String
		lcRetorno = this.oEntidad.cDescripcion 
		lcRetorno = lcRetorno + ' - Punto de venta: ' + transform( &tcCursor..cPtoventa  )
		lcRetorno = lcRetorno + ' - Número: ' + transform( &tcCursor..cNumero    )
		lcRetorno = lcRetorno + ' - Base de datos: ' + transform( &tcCursor..BDAltaFW   )
		Return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EsAliasDeProceso( tcAlias As String, tcPrefijo as string ) As Boolean
		local llRetorno as Boolean, lcAlias as String, lcPrefijo As String
		llRetorno = .F.
		lcAlias = upper( alltrim( tcAlias ) )
		lcPrefijo = upper( alltrim( tcPrefijo ) )
		Do Case
			Case  lcAlias == lcPrefijo + 'REGISTRODEMANTENIMIENTO'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'REGISTRODEMANTENIMIENTO_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'REGISTRODEMANTENIMIENTO_DET'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ORGANIZACION.TablaTrabajo_RegActiSys')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'REGISTRODEMANTENIMIENTO'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..cCodigo
		llCondicion = isnull( lxVar ) or isnull( &lcCursor..cPtoventa ) or isnull( &lcCursor..cNumero ) or isnull( &lcCursor..BDAltaFW )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad REGISTRODEMANTENIMIENTO. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'REGISTRODEMANTENIMIENTO'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		select recno() as _Rec, * from &lcCursor into cursor CurConRecno
		select max( _Rec ) as Maximo,cCodigo as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( cCodigo, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		select max( _Rec ) as Maximo,str( cPtoventa, 4, 0) + str( cNumero, 8, 0) + BDAltaFW as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( str( cPtoventa, 4, 0) + str( cNumero, 8, 0) + BDAltaFW, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		Use in select( 'CurConRecno' )
		Use in select( 'RepMax' )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDatosInvalidos( toConexion as Object ) as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'REGISTRODEMANTENIMIENTO'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  cFechaFin 
		* Validar ANTERIORES A 1/1/1753  cFechaIni 
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ORGANIZACION.TablaTrabajo_RegActiSys') AND type in ('U')) DROP TABLE ORGANIZACION.TablaTrabajo_RegActiSys
Create Table ORGANIZACION.TablaTrabajo_RegActiSys ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fectrans" datetime  null, 
"faltafw" datetime  null, 
"fecexpo" datetime  null, 
"fmodifw" datetime  null, 
"fecimpo" datetime  null, 
"cestado" numeric( 2, 0 )  null, 
"horaimpo" char( 8 )  null, 
"horaexpo" char( 8 )  null, 
"ualtafw" char( 100 )  null, 
"hmodifw" char( 8 )  null, 
"vmodifw" char( 13 )  null, 
"zadsfw" varchar(max)  null, 
"umodifw" char( 100 )  null, 
"valtafw" char( 13 )  null, 
"saltafw" char( 7 )  null, 
"smodifw" char( 7 )  null, 
"esttrans" char( 20 )  null, 
"haltafw" char( 8 )  null, 
"csitio" char( 38 )  null, 
"bdmodifw" char( 8 )  null, 
"cfechafin" datetime  null, 
"cfechaini" datetime  null, 
"ctipo" numeric( 2, 0 )  null, 
"ccodigo" char( 38 )  null, 
"choraini" char( 5 )  null, 
"chorafin" char( 5 )  null, 
"cptoventa" numeric( 4, 0 )  null, 
"det" varchar(max)  null, 
"cnumero" numeric( 8, 0 )  null, 
"cresultado" char( 254 )  null, 
"bdaltafw" char( 8 )  null, 
"cdescrip" char( 254 )  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_RegActiSys' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_RegActiSys' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'REGISTRODEMANTENIMIENTO'
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
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('cestado','cestado')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('csitio','csitio')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('cfechafin','cfechafin')
			.AgregarMapeo('cfechaini','cfechaini')
			.AgregarMapeo('ctipo','ctipo')
			.AgregarMapeo('ccodigo','ccodigo')
			.AgregarMapeo('choraini','choraini')
			.AgregarMapeo('chorafin','chorafin')
			.AgregarMapeo('cptoventa','cptoventa')
			.AgregarMapeo('det','det')
			.AgregarMapeo('cnumero','cnumero')
			.AgregarMapeo('cresultado','cresultado')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('cdescrip','cdescrip')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ORGANIZACION.TablaTrabajo_RegActiSys'
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
				Update t Set t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.CESTADO = isnull( d.CESTADO, t.CESTADO ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.CSITIO = isnull( d.CSITIO, t.CSITIO ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.CFECHAFIN = isnull( d.CFECHAFIN, t.CFECHAFIN ),t.CFECHAINI = isnull( d.CFECHAINI, t.CFECHAINI ),t.CTIPO = isnull( d.CTIPO, t.CTIPO ),t.CCODIGO = isnull( d.CCODIGO, t.CCODIGO ),t.CHORAINI = isnull( d.CHORAINI, t.CHORAINI ),t.CHORAFIN = isnull( d.CHORAFIN, t.CHORAFIN ),t.CPTOVENTA = isnull( d.CPTOVENTA, t.CPTOVENTA ),t.DET = isnull( d.DET, t.DET ),t.CNUMERO = isnull( d.CNUMERO, t.CNUMERO ),t.CRESULTADO = isnull( d.CRESULTADO, t.CRESULTADO ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.CDESCRIP = isnull( d.CDESCRIP, t.CDESCRIP )
					from ORGANIZACION.REGACTISYS t inner join deleted d 
							 on t.cCodigo = d.cCodigo
							 and  t.cPtoventa = d.cPtoventa
							 and  t.cNumero = d.cNumero
							 and  t.BDAltaFW = d.BDAltaFW
				-- Fin Updates
				insert into ORGANIZACION.REGACTISYS(Fectrans,Faltafw,Fecexpo,Fmodifw,Fecimpo,Cestado,Horaimpo,Horaexpo,Ualtafw,Hmodifw,Vmodifw,Zadsfw,Umodifw,Valtafw,Saltafw,Smodifw,Esttrans,Haltafw,Csitio,Bdmodifw,Cfechafin,Cfechaini,Ctipo,Ccodigo,Choraini,Chorafin,Cptoventa,Det,Cnumero,Cresultado,Bdaltafw,Cdescrip)
					Select isnull( d.FECTRANS,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FECEXPO,''),isnull( d.FMODIFW,''),isnull( d.FECIMPO,''),isnull( d.CESTADO,0),isnull( d.HORAIMPO,''),isnull( d.HORAEXPO,''),isnull( d.UALTAFW,''),isnull( d.HMODIFW,''),isnull( d.VMODIFW,''),isnull( d.ZADSFW,''),isnull( d.UMODIFW,''),isnull( d.VALTAFW,''),isnull( d.SALTAFW,''),isnull( d.SMODIFW,''),isnull( d.ESTTRANS,''),convert( char(8), getdate(), 108 ),isnull( d.CSITIO,''),isnull( d.BDMODIFW,''),isnull( d.CFECHAFIN,''),isnull( d.CFECHAINI,''),isnull( d.CTIPO,0),isnull( d.CCODIGO,''),isnull( d.CHORAINI,''),isnull( d.CHORAFIN,''),isnull( d.CPTOVENTA,0),isnull( d.DET,''),isnull( d.CNUMERO,0),isnull( d.CRESULTADO,''),isnull( d.BDALTAFW,''),isnull( d.CDESCRIP,'')
						From deleted d left join ORGANIZACION.REGACTISYS pk 
							 on d.cCodigo = pk.cCodigo
						 left join ORGANIZACION.REGACTISYS cc 
							 on  d.cPtoventa = cc.cPtoventa
							 and  d.cNumero = cc.cNumero
							 and  d.BDAltaFW = cc.BDAltaFW
						Where pk.cCodigo Is Null 
							 and cc.cPtoventa Is Null 
							 and cc.cNumero Is Null 
							 and cc.BDAltaFW Is Null 
				-- Fin Inserts
				Insert into ZooLogic.Logueos ( Fecha, Nivel, Logger, Accion, BaseDeDatos, 
					EstadoDelSistema, Aplicacion, Version, 
					Serie, Usuario, NombrePc, 
					UsuarioPc, OrigenLogueo, Mensaje, Excepcion)
				select GetDate(), 'INFO', '', 'Importación <<lcEntidad>>','<<loLogueo.BaseDatos>>',
					<<loLogueo.EstadoSistema>>,'<<loLogueo.Aplicacion>>','<<loLogueo.Version>>',
					'<<loLogueo.Serie>>','<<loLogueo.Usuario>>','<<loLogueo.NombrePc>>',
					'<<loLogueo.UsuarioPc>>','<<loLogueo.OrigenLogueo>>','No se pudo importar la entidad <<lcEntidad>>: PUNTO DE VENTA ' + cast( d.cPtoventa as Varchar(4) ) + ', NÚMERO ' + cast( d.cNumero as Varchar(8) ) + ', BASE DE DATOS ' + cast( d.BDAltaFW as Varchar(8) ) + '','La clave principal no es la esperada'
					from ORGANIZACION.REGACTISYS t inner join deleted d 
							on   t.cPtoventa = d.cPtoventa
							 and  t.cNumero = d.cNumero
							 and  t.BDAltaFW = d.BDAltaFW
						left join deleted h 
							 on t.cCodigo = h.cCodigo
							 where h.cCodigo is null 
				Insert into ZooLogic.Logueos ( Fecha, Nivel, Logger, Accion, BaseDeDatos, 
					EstadoDelSistema, Aplicacion, Version, 
					Serie, Usuario, NombrePc, 
					UsuarioPc, OrigenLogueo, Mensaje, Excepcion)
				select GetDate(), 'INFO', '', 'Importación <<lcEntidad>>','<<loLogueo.BaseDatos>>',
					<<loLogueo.EstadoSistema>>,'<<loLogueo.Aplicacion>>','<<loLogueo.Version>>',
					'<<loLogueo.Serie>>','<<loLogueo.Usuario>>','<<loLogueo.NombrePc>>',
					'<<loLogueo.UsuarioPc>>','<<loLogueo.OrigenLogueo>>','No se pudo importar la entidad <<lcEntidad>>: PUNTO DE VENTA ' + cast( d.cPtoventa as Varchar(4) ) + ', NÚMERO ' + cast( d.cNumero as Varchar(8) ) + ', BASE DE DATOS ' + cast( d.BDAltaFW as Varchar(8) ) + '','La clave principal a importar ya existe'
					from ORGANIZACION.REGACTISYS t inner join deleted d 
							 on t.cCodigo = d.cCodigo
						left join deleted h 
							on   t.cPtoventa = h.cPtoventa
							 and   t.cNumero = h.cNumero
							 and   t.BDAltaFW = h.BDAltaFW
							where   h.cPtoventa is null 
							 and   h.cNumero is null 
							 and   h.BDAltaFW is null 
			End
		EndText
		Return lcCadena
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	protected Function EliminarTablasDeTrabajo( toConexion as Object ) as void
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ORGANIZACION.TablaTrabajo_RegActiSys') AND type in ('U')) DROP TABLE ORGANIZACION.TablaTrabajo_RegActiSys
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_REGISTRODEMANTENIMIENTO' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_REGISTRODEMANTENIMIENTO.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_REGISTRODEMANTENIMIENTO.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_REGISTRODEMANTENIMIENTO.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_REGISTRODEMANTENIMIENTO.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_REGISTRODEMANTENIMIENTO.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Estado = nvl( c_REGISTRODEMANTENIMIENTO.Estado, 0 )
					.Horaimpo = nvl( c_REGISTRODEMANTENIMIENTO.Horaimpo, [] )
					.Horaexpo = nvl( c_REGISTRODEMANTENIMIENTO.Horaexpo, [] )
					.Usuarioaltafw = nvl( c_REGISTRODEMANTENIMIENTO.Usuarioaltafw, [] )
					.Horamodificacionfw = nvl( c_REGISTRODEMANTENIMIENTO.Horamodificacionfw, [] )
					.Versionmodificacionfw = nvl( c_REGISTRODEMANTENIMIENTO.Versionmodificacionfw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Usuariomodificacionfw = nvl( c_REGISTRODEMANTENIMIENTO.Usuariomodificacionfw, [] )
					.Versionaltafw = nvl( c_REGISTRODEMANTENIMIENTO.Versionaltafw, [] )
					.Seriealtafw = nvl( c_REGISTRODEMANTENIMIENTO.Seriealtafw, [] )
					.Seriemodificacionfw = nvl( c_REGISTRODEMANTENIMIENTO.Seriemodificacionfw, [] )
					.Estadotransferencia = nvl( c_REGISTRODEMANTENIMIENTO.Estadotransferencia, [] )
					.Horaaltafw = nvl( c_REGISTRODEMANTENIMIENTO.Horaaltafw, [] )
					.Sitio = nvl( c_REGISTRODEMANTENIMIENTO.Sitio, [] )
					.Basededatosmodificacionfw = nvl( c_REGISTRODEMANTENIMIENTO.Basededatosmodificacionfw, [] )
					.Fechafin = GoLibrerias.ObtenerFechaFormateada( nvl( c_REGISTRODEMANTENIMIENTO.Fechafin, ctod( '  /  /    ' ) ) )
					.Fechainicio = GoLibrerias.ObtenerFechaFormateada( nvl( c_REGISTRODEMANTENIMIENTO.Fechainicio, ctod( '  /  /    ' ) ) )
					.Tipo = nvl( c_REGISTRODEMANTENIMIENTO.Tipo, 0 )
					.Codigo = nvl( c_REGISTRODEMANTENIMIENTO.Codigo, [] )
					.Horainicio = nvl( c_REGISTRODEMANTENIMIENTO.Horainicio, [] )
					.Horafin = nvl( c_REGISTRODEMANTENIMIENTO.Horafin, [] )
					.Puntodeventa = nvl( c_REGISTRODEMANTENIMIENTO.Puntodeventa, 0 )
					lcValor = This.ObtenerMemo( 'c_Registro')
					.Registro = lcValor 
					.Numero = nvl( c_REGISTRODEMANTENIMIENTO.Numero, 0 )
					.Resultadodelatarea = nvl( c_REGISTRODEMANTENIMIENTO.Resultadodelatarea, [] )
					.Basededatosaltafw = nvl( c_REGISTRODEMANTENIMIENTO.Basededatosaltafw, [] )
					.Descripcion = nvl( c_REGISTRODEMANTENIMIENTO.Descripcion, [] )
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
			lxRetorno = c_REGISTRODEMANTENIMIENTO.CODIGO
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
		return c_REGISTRODEMANTENIMIENTO.&lcAtributo
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
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID('<<lcNombreBD>>') AND OBJECT_ID=OBJECT_ID( '<<lcNombreBD>>.ORGANIZACION.REGACTISYS' )
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
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "cCodigo"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
		text to lcSQL textmerge noshow
				SELECT nro,totalRegistros,cCodigo as Id
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    cCodigo from (
							select * 
								from ORGANIZACION.REGACTISYS 
								Where   REGACTISYS.CCODIGO != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "REGACTISYS", "", lcCursor, set("Datasession") )
		lcXml = this.CursorAXml( lcCursor )
		
		use in select( lcCursor )
		
		Return lcXml 
		
	endfunc
	*-----------------------------------------------------------------------------------------
	function ObtenerDatosEntidadPaginado( tcOrderBy as String, tcFiltro as String, tnCantidad as Integer, tnPagina as Integer )  as String
		local lcOrderBy as String, lnCuantos as Integer, lnPagina as Integer, lnTope as Integer, lnDesde as Integer, lcSQL as String, lcCursor as String, lcXml as String
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "cCodigo"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
			text to lcAtributos textmerge noshow
			"Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Cestado" as "Estado", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Csitio" as "Sitio", "Bdmodifw" as "Basededatosmodificacionfw", "Cfechafin" as "Fechafin", "Cfechaini" as "Fechainicio", "Ctipo" as "Tipo", "Ccodigo" as "Codigo", "Choraini" as "Horainicio", "Chorafin" as "Horafin", "Cptoventa" as "Puntodeventa", "Det" as "Registro", "Cnumero" as "Numero", "Cresultado" as "Resultadodelatarea", "Bdaltafw" as "Basededatosaltafw", "Cdescrip" as "Descripcion"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ORGANIZACION.REGACTISYS 
								Where   REGACTISYS.CCODIGO != ''
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
	Tabla = 'REGACTISYS'
	Filtro = " REGACTISYS.CCODIGO != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " REGACTISYS.CCODIGO != ''"
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
	<row entidad="REGISTRODEMANTENIMIENTO                 " atributo="FECHATRANSFERENCIA                      " tabla="REGACTISYS     " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha transferencia                                                                                                                                             " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODEMANTENIMIENTO                 " atributo="FECHAALTAFW                             " tabla="REGACTISYS     " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODEMANTENIMIENTO                 " atributo="FECHAEXPO                               " tabla="REGACTISYS     " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODEMANTENIMIENTO                 " atributo="FECHAMODIFICACIONFW                     " tabla="REGACTISYS     " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODEMANTENIMIENTO                 " atributo="FECHAIMPO                               " tabla="REGACTISYS     " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODEMANTENIMIENTO                 " atributo="ESTADO                                  " tabla="REGACTISYS     " campo="CESTADO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Resultado                                                                                                                                                       " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODEMANTENIMIENTO                 " atributo="HORAIMPO                                " tabla="REGACTISYS     " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODEMANTENIMIENTO                 " atributo="HORAEXPO                                " tabla="REGACTISYS     " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODEMANTENIMIENTO                 " atributo="USUARIOALTAFW                           " tabla="REGACTISYS     " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODEMANTENIMIENTO                 " atributo="HORAMODIFICACIONFW                      " tabla="REGACTISYS     " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODEMANTENIMIENTO                 " atributo="VERSIONMODIFICACIONFW                   " tabla="REGACTISYS     " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODEMANTENIMIENTO                 " atributo="ZADSFW                                  " tabla="REGACTISYS     " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODEMANTENIMIENTO                 " atributo="USUARIOMODIFICACIONFW                   " tabla="REGACTISYS     " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODEMANTENIMIENTO                 " atributo="VERSIONALTAFW                           " tabla="REGACTISYS     " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODEMANTENIMIENTO                 " atributo="SERIEALTAFW                             " tabla="REGACTISYS     " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODEMANTENIMIENTO                 " atributo="SERIEMODIFICACIONFW                     " tabla="REGACTISYS     " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODEMANTENIMIENTO                 " atributo="ESTADOTRANSFERENCIA                     " tabla="REGACTISYS     " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado transferencia                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODEMANTENIMIENTO                 " atributo="HORAALTAFW                              " tabla="REGACTISYS     " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODEMANTENIMIENTO                 " atributo="SITIO                                   " tabla="REGACTISYS     " campo="CSITIO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Sitio                                                                                                                                                           " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODEMANTENIMIENTO                 " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="REGACTISYS     " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODEMANTENIMIENTO                 " atributo="FECHAFIN                                " tabla="REGACTISYS     " campo="CFECHAFIN " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="7" etiqueta="Fecha fin                                                                                                                                                       " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODEMANTENIMIENTO                 " atributo="FECHAINICIO                             " tabla="REGACTISYS     " campo="CFECHAINI " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="5" etiqueta="Fecha inicio                                                                                                                                                    " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODEMANTENIMIENTO                 " atributo="TIPO                                    " tabla="REGACTISYS     " campo="CTIPO     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="10" etiqueta="Tipo de mantenimiento                                                                                                                                           " dominio="COMBOXML                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODEMANTENIMIENTO                 " atributo="CODIGO                                  " tabla="REGACTISYS     " campo="CCODIGO   " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="99" etiqueta="Código                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODEMANTENIMIENTO                 " atributo="HORAINICIO                              " tabla="REGACTISYS     " campo="CHORAINI  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="6" etiqueta="Hora inicio                                                                                                                                                     " dominio="HORA                          " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODEMANTENIMIENTO                 " atributo="HORAFIN                                 " tabla="REGACTISYS     " campo="CHORAFIN  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="8" etiqueta="Hora fin                                                                                                                                                        " dominio="HORA                          " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODEMANTENIMIENTO                 " atributo="PUNTODEVENTA                            " tabla="REGACTISYS     " campo="CPTOVENTA " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="4" decimales="0" valorsugerido="=goParametros.felino.Numeraciones.BocaDeExpendio                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="1" etiqueta="Punto de venta                                                                                                                                                  " dominio="NUMEROINTERNO                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="1" mascara="X999-99999999            " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODEMANTENIMIENTO                 " atributo="REGISTRO                                " tabla="REGACTISYS     " campo="DET       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="200" etiqueta="Detalle de la tarea                                                                                                                                             " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="98" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODEMANTENIMIENTO                 " atributo="NUMERO                                  " tabla="REGACTISYS     " campo="CNUMERO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="2" etiqueta="Número                                                                                                                                                          " dominio="NUMEROINTERNO                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="2" mascara="X999-99999999            " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODEMANTENIMIENTO                 " atributo="RESULTADODELATAREA                      " tabla="REGACTISYS     " campo="CRESULTADO" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="254" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="4" etiqueta="Resultado de la tarea                                                                                                                                           " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="99" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODEMANTENIMIENTO                 " atributo="BASEDEDATOSALTAFW                       " tabla="REGACTISYS     " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="12" etiqueta="Base de datos                                                                                                                                                   " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="3" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTRODEMANTENIMIENTO                 " atributo="DESCRIPCION                             " tabla="REGACTISYS     " campo="CDESCRIP  " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="254" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="3" etiqueta="Descripción de la tarea                                                                                                                                         " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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