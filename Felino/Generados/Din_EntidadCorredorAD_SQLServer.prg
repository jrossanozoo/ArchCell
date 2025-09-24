
define class Din_EntidadCORREDORAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_CORREDOR'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = []
	cExpresionCCPorCampos = []
	cTagClaveCandidata = ''
	cTagClavePk = '_014PK'
	cTablaPrincipal = 'CORRE'
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
			local  lxCorreFecexpo, lxCorreFecimpo, lxCorreFectrans, lxCorreFmodifw, lxCorreFaltafw, lxCorreCodir, lxCorreCoiva, lxCorreTimestamp, lxCorreCocomvta, lxCorreSaltafw, lxCorreHoraimpo, lxCorreHmodifw, lxCorreSmodifw, lxCorreUmodifw, lxCorreUaltafw, lxCorreZadsfw, lxCorreValtafw, lxCorreVmodifw, lxCorreHoraexpo, lxCorreHaltafw, lxCorreEsttrans, lxCorreBdaltafw, lxCorreBdmodifw, lxCorreCotlf, lxCorreCoimagen, lxCorreCocod, lxCorreCoobs, lxCorreCocuit, lxCorreColoc, lxCorreConom, lxCorreCocomcob, lxCorreCofax, lxCorreCoemail, lxCorreCotipodoc, lxCorreCocp, lxCorreCopageweb, lxCorreConrodoc, lxCorreCoprv, lxCorreCocontac
				lxCorreFecexpo =  .Fechaexpo			lxCorreFecimpo =  .Fechaimpo			lxCorreFectrans =  .Fechatransferencia			lxCorreFmodifw =  .Fechamodificacionfw			lxCorreFaltafw =  .Fechaaltafw			lxCorreCodir =  .Direccion			lxCorreCoiva =  .Situacionfiscal_PK 			lxCorreTimestamp = goLibrerias.ObtenerTimestamp()			lxCorreCocomvta =  .Comisionventas			lxCorreSaltafw =  .Seriealtafw			lxCorreHoraimpo =  .Horaimpo			lxCorreHmodifw =  .Horamodificacionfw			lxCorreSmodifw =  .Seriemodificacionfw			lxCorreUmodifw =  .Usuariomodificacionfw			lxCorreUaltafw =  .Usuarioaltafw			lxCorreZadsfw =  .Zadsfw			lxCorreValtafw =  .Versionaltafw			lxCorreVmodifw =  .Versionmodificacionfw			lxCorreHoraexpo =  .Horaexpo			lxCorreHaltafw =  .Horaaltafw			lxCorreEsttrans =  .Estadotransferencia			lxCorreBdaltafw =  .Basededatosaltafw			lxCorreBdmodifw =  .Basededatosmodificacionfw			lxCorreCotlf =  .Telefono			lxCorreCoimagen =  .Imagen			lxCorreCocod =  .Codigo			lxCorreCoobs =  .Observacion			lxCorreCocuit =  .Cuit			lxCorreColoc =  .Localidad			lxCorreConom =  .Nombre			lxCorreCocomcob =  .Comisioncobranzas			lxCorreCofax =  .Fax			lxCorreCoemail =  .Email			lxCorreCotipodoc =  .Tipodocumento			lxCorreCocp =  .Codigopostal			lxCorreCopageweb =  .Paginaweb			lxCorreConrodoc =  .Nrodocumento			lxCorreCoprv =  upper( .Provincia_PK ) 			lxCorreCocontac =  .Contacto
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxCorreCocod = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.CORRE ( "Fecexpo","Fecimpo","Fectrans","Fmodifw","Faltafw","Codir","Coiva","Timestamp","Cocomvta","Saltafw","Horaimpo","Hmodifw","Smodifw","Umodifw","Ualtafw","Zadsfw","Valtafw","Vmodifw","Horaexpo","Haltafw","Esttrans","Bdaltafw","Bdmodifw","Cotlf","Coimagen","Cocod","Coobs","Cocuit","Coloc","Conom","Cocomcob","Cofax","Coemail","Cotipodoc","Cocp","Copageweb","Conrodoc","Coprv","Cocontac" ) values ( <<"'" + this.ConvertirDateSql( lxCorreFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCorreFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCorreFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCorreFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCorreFaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCorreCodir ) + "'" >>, <<lxCorreCoiva >>, <<lxCorreTimestamp >>, <<lxCorreCocomvta >>, <<"'" + this.FormatearTextoSql( lxCorreSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCorreHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCorreHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCorreSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCorreUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCorreUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCorreZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCorreValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCorreVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCorreHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCorreHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCorreEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCorreBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCorreBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCorreCotlf ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCorreCoimagen ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCorreCocod ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCorreCoobs ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCorreCocuit ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCorreColoc ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCorreConom ) + "'" >>, <<lxCorreCocomcob >>, <<"'" + this.FormatearTextoSql( lxCorreCofax ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCorreCoemail ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCorreCotipodoc ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCorreCocp ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCorreCopageweb ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCorreConrodoc ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCorreCoprv ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCorreCocontac ) + "'" >> )
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
		this.oEntidad.Timestamp = lxCorreTimestamp
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
			local  lxCorreFecexpo, lxCorreFecimpo, lxCorreFectrans, lxCorreFmodifw, lxCorreFaltafw, lxCorreCodir, lxCorreCoiva, lxCorreTimestamp, lxCorreCocomvta, lxCorreSaltafw, lxCorreHoraimpo, lxCorreHmodifw, lxCorreSmodifw, lxCorreUmodifw, lxCorreUaltafw, lxCorreZadsfw, lxCorreValtafw, lxCorreVmodifw, lxCorreHoraexpo, lxCorreHaltafw, lxCorreEsttrans, lxCorreBdaltafw, lxCorreBdmodifw, lxCorreCotlf, lxCorreCoimagen, lxCorreCocod, lxCorreCoobs, lxCorreCocuit, lxCorreColoc, lxCorreConom, lxCorreCocomcob, lxCorreCofax, lxCorreCoemail, lxCorreCotipodoc, lxCorreCocp, lxCorreCopageweb, lxCorreConrodoc, lxCorreCoprv, lxCorreCocontac
				lxCorreFecexpo =  .Fechaexpo			lxCorreFecimpo =  .Fechaimpo			lxCorreFectrans =  .Fechatransferencia			lxCorreFmodifw =  .Fechamodificacionfw			lxCorreFaltafw =  .Fechaaltafw			lxCorreCodir =  .Direccion			lxCorreCoiva =  .Situacionfiscal_PK 			lxCorreTimestamp = goLibrerias.ObtenerTimestamp()			lxCorreCocomvta =  .Comisionventas			lxCorreSaltafw =  .Seriealtafw			lxCorreHoraimpo =  .Horaimpo			lxCorreHmodifw =  .Horamodificacionfw			lxCorreSmodifw =  .Seriemodificacionfw			lxCorreUmodifw =  .Usuariomodificacionfw			lxCorreUaltafw =  .Usuarioaltafw			lxCorreZadsfw =  .Zadsfw			lxCorreValtafw =  .Versionaltafw			lxCorreVmodifw =  .Versionmodificacionfw			lxCorreHoraexpo =  .Horaexpo			lxCorreHaltafw =  .Horaaltafw			lxCorreEsttrans =  .Estadotransferencia			lxCorreBdaltafw =  .Basededatosaltafw			lxCorreBdmodifw =  .Basededatosmodificacionfw			lxCorreCotlf =  .Telefono			lxCorreCoimagen =  .Imagen			lxCorreCocod =  .Codigo			lxCorreCoobs =  .Observacion			lxCorreCocuit =  .Cuit			lxCorreColoc =  .Localidad			lxCorreConom =  .Nombre			lxCorreCocomcob =  .Comisioncobranzas			lxCorreCofax =  .Fax			lxCorreCoemail =  .Email			lxCorreCotipodoc =  .Tipodocumento			lxCorreCocp =  .Codigopostal			lxCorreCopageweb =  .Paginaweb			lxCorreConrodoc =  .Nrodocumento			lxCorreCoprv =  upper( .Provincia_PK ) 			lxCorreCocontac =  .Contacto
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
				update ZooLogic.CORRE set "Fecexpo" = <<"'" + this.ConvertirDateSql( lxCorreFecexpo ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxCorreFecimpo ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxCorreFectrans ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxCorreFmodifw ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxCorreFaltafw ) + "'">>,"Codir" = <<"'" + this.FormatearTextoSql( lxCorreCodir ) + "'">>,"Coiva" = <<lxCorreCoiva>>,"Timestamp" = <<lxCorreTimestamp>>,"Cocomvta" = <<lxCorreCocomvta>>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxCorreSaltafw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxCorreHoraimpo ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxCorreHmodifw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxCorreSmodifw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxCorreUmodifw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxCorreUaltafw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxCorreZadsfw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxCorreValtafw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxCorreVmodifw ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxCorreHoraexpo ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxCorreHaltafw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxCorreEsttrans ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxCorreBdaltafw ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxCorreBdmodifw ) + "'">>,"Cotlf" = <<"'" + this.FormatearTextoSql( lxCorreCotlf ) + "'">>,"Coimagen" = <<"'" + this.FormatearTextoSql( lxCorreCoimagen ) + "'">>,"Cocod" = <<"'" + this.FormatearTextoSql( lxCorreCocod ) + "'">>,"Coobs" = <<"'" + this.FormatearTextoSql( lxCorreCoobs ) + "'">>,"Cocuit" = <<"'" + this.FormatearTextoSql( lxCorreCocuit ) + "'">>,"Coloc" = <<"'" + this.FormatearTextoSql( lxCorreColoc ) + "'">>,"Conom" = <<"'" + this.FormatearTextoSql( lxCorreConom ) + "'">>,"Cocomcob" = <<lxCorreCocomcob>>,"Cofax" = <<"'" + this.FormatearTextoSql( lxCorreCofax ) + "'">>,"Coemail" = <<"'" + this.FormatearTextoSql( lxCorreCoemail ) + "'">>,"Cotipodoc" = <<"'" + this.FormatearTextoSql( lxCorreCotipodoc ) + "'">>,"Cocp" = <<"'" + this.FormatearTextoSql( lxCorreCocp ) + "'">>,"Copageweb" = <<"'" + this.FormatearTextoSql( lxCorreCopageweb ) + "'">>,"Conrodoc" = <<"'" + this.FormatearTextoSql( lxCorreConrodoc ) + "'">>,"Coprv" = <<"'" + this.FormatearTextoSql( lxCorreCoprv ) + "'">>,"Cocontac" = <<"'" + this.FormatearTextoSql( lxCorreCocontac ) + "'">> where "Cocod" = <<"'" + this.FormatearTextoSql( lxCorreCocod ) + "'">> and  CORRE.COCOD != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
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
		this.oEntidad.Timestamp = lxCorreTimestamp
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 COCOD from ZooLogic.CORRE where " + this.ConvertirFuncionesSql( " CORRE.COCOD != ''" ) )
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
			Local lxCorreCocod
			lxCorreCocod = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Codir" as "Direccion", "Coiva" as "Situacionfiscal", "Timestamp" as "Timestamp", "Cocomvta" as "Comisionventas", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Cotlf" as "Telefono", "Coimagen" as "Imagen", "Cocod" as "Codigo", "Coobs" as "Observacion", "Cocuit" as "Cuit", "Coloc" as "Localidad", "Conom" as "Nombre", "Cocomcob" as "Comisioncobranzas", "Cofax" as "Fax", "Coemail" as "Email", "Cotipodoc" as "Tipodocumento", "Cocp" as "Codigopostal", "Copageweb" as "Paginaweb", "Conrodoc" as "Nrodocumento", "Coprv" as "Provincia", "Cocontac" as "Contacto" from ZooLogic.CORRE where "Cocod" = <<"'" + this.FormatearTextoSql( lxCorreCocod ) + "'">> and  CORRE.COCOD != ''
			endtext
			use in select('c_CORREDOR')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CORREDOR', set( 'Datasession' ) )

			if reccount( 'c_CORREDOR' ) = 0
				llRetorno = .f.
			else
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxCorreCocod as Variant
		llRetorno = .t.
		lxCorreCocod = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.CORRE where "Cocod" = <<"'" + this.FormatearTextoSql( lxCorreCocod ) + "'">> and  CORRE.COCOD != ''
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
				select top 1 "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Codir" as "Direccion", "Coiva" as "Situacionfiscal", "Timestamp" as "Timestamp", "Cocomvta" as "Comisionventas", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Cotlf" as "Telefono", "Coimagen" as "Imagen", "Cocod" as "Codigo", "Coobs" as "Observacion", "Cocuit" as "Cuit", "Coloc" as "Localidad", "Conom" as "Nombre", "Cocomcob" as "Comisioncobranzas", "Cofax" as "Fax", "Coemail" as "Email", "Cotipodoc" as "Tipodocumento", "Cocp" as "Codigopostal", "Copageweb" as "Paginaweb", "Conrodoc" as "Nrodocumento", "Coprv" as "Provincia", "Cocontac" as "Contacto" from ZooLogic.CORRE where  CORRE.COCOD != '' order by COCOD
			endtext
			use in select('c_CORREDOR')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CORREDOR', set( 'Datasession' ) )
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
				select top 1 "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Codir" as "Direccion", "Coiva" as "Situacionfiscal", "Timestamp" as "Timestamp", "Cocomvta" as "Comisionventas", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Cotlf" as "Telefono", "Coimagen" as "Imagen", "Cocod" as "Codigo", "Coobs" as "Observacion", "Cocuit" as "Cuit", "Coloc" as "Localidad", "Conom" as "Nombre", "Cocomcob" as "Comisioncobranzas", "Cofax" as "Fax", "Coemail" as "Email", "Cotipodoc" as "Tipodocumento", "Cocp" as "Codigopostal", "Copageweb" as "Paginaweb", "Conrodoc" as "Nrodocumento", "Coprv" as "Provincia", "Cocontac" as "Contacto" from ZooLogic.CORRE where  funciones.padr( COCOD, 5, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  CORRE.COCOD != '' order by COCOD
			endtext
			use in select('c_CORREDOR')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CORREDOR', set( 'Datasession' ) )
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
				select top 1 "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Codir" as "Direccion", "Coiva" as "Situacionfiscal", "Timestamp" as "Timestamp", "Cocomvta" as "Comisionventas", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Cotlf" as "Telefono", "Coimagen" as "Imagen", "Cocod" as "Codigo", "Coobs" as "Observacion", "Cocuit" as "Cuit", "Coloc" as "Localidad", "Conom" as "Nombre", "Cocomcob" as "Comisioncobranzas", "Cofax" as "Fax", "Coemail" as "Email", "Cotipodoc" as "Tipodocumento", "Cocp" as "Codigopostal", "Copageweb" as "Paginaweb", "Conrodoc" as "Nrodocumento", "Coprv" as "Provincia", "Cocontac" as "Contacto" from ZooLogic.CORRE where  funciones.padr( COCOD, 5, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  CORRE.COCOD != '' order by COCOD desc
			endtext
			use in select('c_CORREDOR')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CORREDOR', set( 'Datasession' ) )
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
				select top 1 "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Codir" as "Direccion", "Coiva" as "Situacionfiscal", "Timestamp" as "Timestamp", "Cocomvta" as "Comisionventas", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Cotlf" as "Telefono", "Coimagen" as "Imagen", "Cocod" as "Codigo", "Coobs" as "Observacion", "Cocuit" as "Cuit", "Coloc" as "Localidad", "Conom" as "Nombre", "Cocomcob" as "Comisioncobranzas", "Cofax" as "Fax", "Coemail" as "Email", "Cotipodoc" as "Tipodocumento", "Cocp" as "Codigopostal", "Copageweb" as "Paginaweb", "Conrodoc" as "Nrodocumento", "Coprv" as "Provincia", "Cocontac" as "Contacto" from ZooLogic.CORRE where  CORRE.COCOD != '' order by COCOD desc
			endtext
			use in select('c_CORREDOR')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CORREDOR', set( 'Datasession' ) )
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
			lcXml = this.oConexion.EjecutarSql( "select Fecexpo,Fecimpo,Fectrans,Fmodifw,Faltafw,Codir,Coiva,Timestamp,Cocomvta,Saltafw,Horaimpo,Hmo" + ;
"difw,Smodifw,Umodifw,Ualtafw,Zadsfw,Valtafw,Vmodifw,Horaexpo,Haltafw,Esttrans,Bdaltafw,Bdmodifw,Cotl" + ;
"f,Coimagen,Cocod,Coobs,Cocuit,Coloc,Conom,Cocomcob,Cofax,Coemail,Cotipodoc,Cocp,Copageweb,Conrodoc,C" + ;
"oprv,Cocontac" + ;
" from ZooLogic.CORRE where  CORRE.COCOD != '' and " + lcFiltro )
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
			local  lxCorreFecexpo, lxCorreFecimpo, lxCorreFectrans, lxCorreFmodifw, lxCorreFaltafw, lxCorreCodir, lxCorreCoiva, lxCorreTimestamp, lxCorreCocomvta, lxCorreSaltafw, lxCorreHoraimpo, lxCorreHmodifw, lxCorreSmodifw, lxCorreUmodifw, lxCorreUaltafw, lxCorreZadsfw, lxCorreValtafw, lxCorreVmodifw, lxCorreHoraexpo, lxCorreHaltafw, lxCorreEsttrans, lxCorreBdaltafw, lxCorreBdmodifw, lxCorreCotlf, lxCorreCoimagen, lxCorreCocod, lxCorreCoobs, lxCorreCocuit, lxCorreColoc, lxCorreConom, lxCorreCocomcob, lxCorreCofax, lxCorreCoemail, lxCorreCotipodoc, lxCorreCocp, lxCorreCopageweb, lxCorreConrodoc, lxCorreCoprv, lxCorreCocontac
				lxCorreFecexpo = ctod( '  /  /    ' )			lxCorreFecimpo = ctod( '  /  /    ' )			lxCorreFectrans = ctod( '  /  /    ' )			lxCorreFmodifw = ctod( '  /  /    ' )			lxCorreFaltafw = ctod( '  /  /    ' )			lxCorreCodir = []			lxCorreCoiva = 0			lxCorreTimestamp = goLibrerias.ObtenerTimestamp()			lxCorreCocomvta = 0			lxCorreSaltafw = []			lxCorreHoraimpo = []			lxCorreHmodifw = []			lxCorreSmodifw = []			lxCorreUmodifw = []			lxCorreUaltafw = []			lxCorreZadsfw = []			lxCorreValtafw = []			lxCorreVmodifw = []			lxCorreHoraexpo = []			lxCorreHaltafw = []			lxCorreEsttrans = []			lxCorreBdaltafw = []			lxCorreBdmodifw = []			lxCorreCotlf = []			lxCorreCoimagen = []			lxCorreCocod = []			lxCorreCoobs = []			lxCorreCocuit = []			lxCorreColoc = []			lxCorreConom = []			lxCorreCocomcob = 0			lxCorreCofax = []			lxCorreCoemail = []			lxCorreCotipodoc = []			lxCorreCocp = []			lxCorreCopageweb = []			lxCorreConrodoc = []			lxCorreCoprv = []			lxCorreCocontac = []
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( [delete from ZooLogic.CORRE where "COCOD" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'CORRE' + '_' + tcCampo
			lcMemoAscii = ''

			lnIndice = alen(.aSqlMemos)
			lnIndice = iif(lnIndice = 1, 1, lnIndice + 1 )
			dimension .aSqlMemos(lnIndice)

			.aSqlMemos(lnIndice) = 'delete from ' + lcTabla + ' where COCOD = ' + txValorClavePrimaria
			.GenerarSentenciasInsertTablaMemo( lcValor, lcTabla, txValorClavePrimaria )
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerSentenciaInsertMemo( tcTabla as String, txValorClavePrimaria as String, tcOrden as String, tcTexto as String ) as String
		return "Insert  into " + tcTabla + "(COCOD, Orden, texto ) values ( " + txValorClavePrimaria + "," + tcOrden + ",'"+ tcTexto + "')"
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosEntidad( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  CORRE.COCOD != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Codir" as "Direccion", "Coiva" as "Situacionfiscal", "Timestamp" as "Timestamp", "Cocomvta" as "Comisionventas", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Cotlf" as "Telefono", "Coimagen" as "Imagen", "Cocod" as "Codigo", "Coobs" as "Observacion", "Cocuit" as "Cuit", "Coloc" as "Localidad", "Conom" as "Nombre", "Cocomcob" as "Comisioncobranzas", "Cofax" as "Fax", "Coemail" as "Email", "Cotipodoc" as "Tipodocumento", "Cocp" as "Codigopostal", "Copageweb" as "Paginaweb", "Conrodoc" as "Nrodocumento", "Coprv" as "Provincia", "Cocontac" as "Contacto"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'CORRE', '', tnTope )
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
				Case lcAtributo == 'FECHAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECIMPO AS FECHAIMPO'
				Case lcAtributo == 'FECHATRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRANS AS FECHATRANSFERENCIA'
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'DIRECCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIR AS DIRECCION'
				Case lcAtributo == 'SITUACIONFISCAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COIVA AS SITUACIONFISCAL'
				Case lcAtributo == 'TIMESTAMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIMESTAMP AS TIMESTAMP'
				Case lcAtributo == 'COMISIONVENTAS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COCOMVTA AS COMISIONVENTAS'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'TELEFONO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COTLF AS TELEFONO'
				Case lcAtributo == 'IMAGEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COIMAGEN AS IMAGEN'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COCOD AS CODIGO'
				Case lcAtributo == 'OBSERVACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COOBS AS OBSERVACION'
				Case lcAtributo == 'CUIT'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COCUIT AS CUIT'
				Case lcAtributo == 'LOCALIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COLOC AS LOCALIDAD'
				Case lcAtributo == 'NOMBRE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CONOM AS NOMBRE'
				Case lcAtributo == 'COMISIONCOBRANZAS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COCOMCOB AS COMISIONCOBRANZAS'
				Case lcAtributo == 'FAX'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COFAX AS FAX'
				Case lcAtributo == 'EMAIL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COEMAIL AS EMAIL'
				Case lcAtributo == 'TIPODOCUMENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COTIPODOC AS TIPODOCUMENTO'
				Case lcAtributo == 'CODIGOPOSTAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COCP AS CODIGOPOSTAL'
				Case lcAtributo == 'PAGINAWEB'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COPAGEWEB AS PAGINAWEB'
				Case lcAtributo == 'NRODOCUMENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CONRODOC AS NRODOCUMENTO'
				Case lcAtributo == 'PROVINCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COPRV AS PROVINCIA'
				Case lcAtributo == 'CONTACTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COCONTAC AS CONTACTO'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHAIMPO'
				lcCampo = 'FECIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'DIRECCION'
				lcCampo = 'CODIR'
			Case upper( alltrim( tcAtributo ) ) == 'SITUACIONFISCAL'
				lcCampo = 'COIVA'
			Case upper( alltrim( tcAtributo ) ) == 'TIMESTAMP'
				lcCampo = 'TIMESTAMP'
			Case upper( alltrim( tcAtributo ) ) == 'COMISIONVENTAS'
				lcCampo = 'COCOMVTA'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'TELEFONO'
				lcCampo = 'COTLF'
			Case upper( alltrim( tcAtributo ) ) == 'IMAGEN'
				lcCampo = 'COIMAGEN'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'COCOD'
			Case upper( alltrim( tcAtributo ) ) == 'OBSERVACION'
				lcCampo = 'COOBS'
			Case upper( alltrim( tcAtributo ) ) == 'CUIT'
				lcCampo = 'COCUIT'
			Case upper( alltrim( tcAtributo ) ) == 'LOCALIDAD'
				lcCampo = 'COLOC'
			Case upper( alltrim( tcAtributo ) ) == 'NOMBRE'
				lcCampo = 'CONOM'
			Case upper( alltrim( tcAtributo ) ) == 'COMISIONCOBRANZAS'
				lcCampo = 'COCOMCOB'
			Case upper( alltrim( tcAtributo ) ) == 'FAX'
				lcCampo = 'COFAX'
			Case upper( alltrim( tcAtributo ) ) == 'EMAIL'
				lcCampo = 'COEMAIL'
			Case upper( alltrim( tcAtributo ) ) == 'TIPODOCUMENTO'
				lcCampo = 'COTIPODOC'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGOPOSTAL'
				lcCampo = 'COCP'
			Case upper( alltrim( tcAtributo ) ) == 'PAGINAWEB'
				lcCampo = 'COPAGEWEB'
			Case upper( alltrim( tcAtributo ) ) == 'NRODOCUMENTO'
				lcCampo = 'CONRODOC'
			Case upper( alltrim( tcAtributo ) ) == 'PROVINCIA'
				lcCampo = 'COPRV'
			Case upper( alltrim( tcAtributo ) ) == 'CONTACTO'
				lcCampo = 'COCONTAC'
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
			local  lxCorreFecexpo, lxCorreFecimpo, lxCorreFectrans, lxCorreFmodifw, lxCorreFaltafw, lxCorreCodir, lxCorreCoiva, lxCorreTimestamp, lxCorreCocomvta, lxCorreSaltafw, lxCorreHoraimpo, lxCorreHmodifw, lxCorreSmodifw, lxCorreUmodifw, lxCorreUaltafw, lxCorreZadsfw, lxCorreValtafw, lxCorreVmodifw, lxCorreHoraexpo, lxCorreHaltafw, lxCorreEsttrans, lxCorreBdaltafw, lxCorreBdmodifw, lxCorreCotlf, lxCorreCoimagen, lxCorreCocod, lxCorreCoobs, lxCorreCocuit, lxCorreColoc, lxCorreConom, lxCorreCocomcob, lxCorreCofax, lxCorreCoemail, lxCorreCotipodoc, lxCorreCocp, lxCorreCopageweb, lxCorreConrodoc, lxCorreCoprv, lxCorreCocontac
				lxCorreFecexpo =  .Fechaexpo			lxCorreFecimpo =  .Fechaimpo			lxCorreFectrans =  .Fechatransferencia			lxCorreFmodifw =  .Fechamodificacionfw			lxCorreFaltafw =  .Fechaaltafw			lxCorreCodir =  .Direccion			lxCorreCoiva =  .Situacionfiscal_PK 			lxCorreTimestamp = goLibrerias.ObtenerTimestamp()			lxCorreCocomvta =  .Comisionventas			lxCorreSaltafw =  .Seriealtafw			lxCorreHoraimpo =  .Horaimpo			lxCorreHmodifw =  .Horamodificacionfw			lxCorreSmodifw =  .Seriemodificacionfw			lxCorreUmodifw =  .Usuariomodificacionfw			lxCorreUaltafw =  .Usuarioaltafw			lxCorreZadsfw =  .Zadsfw			lxCorreValtafw =  .Versionaltafw			lxCorreVmodifw =  .Versionmodificacionfw			lxCorreHoraexpo =  .Horaexpo			lxCorreHaltafw =  .Horaaltafw			lxCorreEsttrans =  .Estadotransferencia			lxCorreBdaltafw =  .Basededatosaltafw			lxCorreBdmodifw =  .Basededatosmodificacionfw			lxCorreCotlf =  .Telefono			lxCorreCoimagen =  .Imagen			lxCorreCocod =  .Codigo			lxCorreCoobs =  .Observacion			lxCorreCocuit =  .Cuit			lxCorreColoc =  .Localidad			lxCorreConom =  .Nombre			lxCorreCocomcob =  .Comisioncobranzas			lxCorreCofax =  .Fax			lxCorreCoemail =  .Email			lxCorreCotipodoc =  .Tipodocumento			lxCorreCocp =  .Codigopostal			lxCorreCopageweb =  .Paginaweb			lxCorreConrodoc =  .Nrodocumento			lxCorreCoprv =  upper( .Provincia_PK ) 			lxCorreCocontac =  .Contacto
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.CORRE ( "Fecexpo","Fecimpo","Fectrans","Fmodifw","Faltafw","Codir","Coiva","Timestamp","Cocomvta","Saltafw","Horaimpo","Hmodifw","Smodifw","Umodifw","Ualtafw","Zadsfw","Valtafw","Vmodifw","Horaexpo","Haltafw","Esttrans","Bdaltafw","Bdmodifw","Cotlf","Coimagen","Cocod","Coobs","Cocuit","Coloc","Conom","Cocomcob","Cofax","Coemail","Cotipodoc","Cocp","Copageweb","Conrodoc","Coprv","Cocontac" ) values ( <<"'" + this.ConvertirDateSql( lxCorreFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCorreFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCorreFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCorreFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCorreFaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCorreCodir ) + "'" >>, <<lxCorreCoiva >>, <<lxCorreTimestamp >>, <<lxCorreCocomvta >>, <<"'" + this.FormatearTextoSql( lxCorreSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCorreHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCorreHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCorreSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCorreUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCorreUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCorreZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCorreValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCorreVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCorreHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCorreHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCorreEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCorreBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCorreBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCorreCotlf ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCorreCoimagen ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCorreCocod ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCorreCoobs ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCorreCocuit ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCorreColoc ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCorreConom ) + "'" >>, <<lxCorreCocomcob >>, <<"'" + this.FormatearTextoSql( lxCorreCofax ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCorreCoemail ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCorreCotipodoc ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCorreCocp ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCorreCopageweb ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCorreConrodoc ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCorreCoprv ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCorreCocontac ) + "'" >> )
		endtext
		loColeccion.cTabla = 'CORRE' 
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
			local  lxCorreFecexpo, lxCorreFecimpo, lxCorreFectrans, lxCorreFmodifw, lxCorreFaltafw, lxCorreCodir, lxCorreCoiva, lxCorreTimestamp, lxCorreCocomvta, lxCorreSaltafw, lxCorreHoraimpo, lxCorreHmodifw, lxCorreSmodifw, lxCorreUmodifw, lxCorreUaltafw, lxCorreZadsfw, lxCorreValtafw, lxCorreVmodifw, lxCorreHoraexpo, lxCorreHaltafw, lxCorreEsttrans, lxCorreBdaltafw, lxCorreBdmodifw, lxCorreCotlf, lxCorreCoimagen, lxCorreCocod, lxCorreCoobs, lxCorreCocuit, lxCorreColoc, lxCorreConom, lxCorreCocomcob, lxCorreCofax, lxCorreCoemail, lxCorreCotipodoc, lxCorreCocp, lxCorreCopageweb, lxCorreConrodoc, lxCorreCoprv, lxCorreCocontac
				lxCorreFecexpo =  .Fechaexpo			lxCorreFecimpo =  .Fechaimpo			lxCorreFectrans =  .Fechatransferencia			lxCorreFmodifw =  .Fechamodificacionfw			lxCorreFaltafw =  .Fechaaltafw			lxCorreCodir =  .Direccion			lxCorreCoiva =  .Situacionfiscal_PK 			lxCorreTimestamp = goLibrerias.ObtenerTimestamp()			lxCorreCocomvta =  .Comisionventas			lxCorreSaltafw =  .Seriealtafw			lxCorreHoraimpo =  .Horaimpo			lxCorreHmodifw =  .Horamodificacionfw			lxCorreSmodifw =  .Seriemodificacionfw			lxCorreUmodifw =  .Usuariomodificacionfw			lxCorreUaltafw =  .Usuarioaltafw			lxCorreZadsfw =  .Zadsfw			lxCorreValtafw =  .Versionaltafw			lxCorreVmodifw =  .Versionmodificacionfw			lxCorreHoraexpo =  .Horaexpo			lxCorreHaltafw =  .Horaaltafw			lxCorreEsttrans =  .Estadotransferencia			lxCorreBdaltafw =  .Basededatosaltafw			lxCorreBdmodifw =  .Basededatosmodificacionfw			lxCorreCotlf =  .Telefono			lxCorreCoimagen =  .Imagen			lxCorreCocod =  .Codigo			lxCorreCoobs =  .Observacion			lxCorreCocuit =  .Cuit			lxCorreColoc =  .Localidad			lxCorreConom =  .Nombre			lxCorreCocomcob =  .Comisioncobranzas			lxCorreCofax =  .Fax			lxCorreCoemail =  .Email			lxCorreCotipodoc =  .Tipodocumento			lxCorreCocp =  .Codigopostal			lxCorreCopageweb =  .Paginaweb			lxCorreConrodoc =  .Nrodocumento			lxCorreCoprv =  upper( .Provincia_PK ) 			lxCorreCocontac =  .Contacto
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Cocod" = ] + lcValorClavePrimariaString  + [ and  CORRE.COCOD != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.CORRE set "Fecexpo" = <<"'" + this.ConvertirDateSql( lxCorreFecexpo ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxCorreFecimpo ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxCorreFectrans ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxCorreFmodifw ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxCorreFaltafw ) + "'">>, "Codir" = <<"'" + this.FormatearTextoSql( lxCorreCodir ) + "'">>, "Coiva" = <<lxCorreCoiva>>, "Timestamp" = <<lxCorreTimestamp>>, "Cocomvta" = <<lxCorreCocomvta>>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxCorreSaltafw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxCorreHoraimpo ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxCorreHmodifw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxCorreSmodifw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxCorreUmodifw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxCorreUaltafw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxCorreZadsfw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxCorreValtafw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxCorreVmodifw ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxCorreHoraexpo ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxCorreHaltafw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxCorreEsttrans ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxCorreBdaltafw ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxCorreBdmodifw ) + "'">>, "Cotlf" = <<"'" + this.FormatearTextoSql( lxCorreCotlf ) + "'">>, "Coimagen" = <<"'" + this.FormatearTextoSql( lxCorreCoimagen ) + "'">>, "Cocod" = <<"'" + this.FormatearTextoSql( lxCorreCocod ) + "'">>, "Coobs" = <<"'" + this.FormatearTextoSql( lxCorreCoobs ) + "'">>, "Cocuit" = <<"'" + this.FormatearTextoSql( lxCorreCocuit ) + "'">>, "Coloc" = <<"'" + this.FormatearTextoSql( lxCorreColoc ) + "'">>, "Conom" = <<"'" + this.FormatearTextoSql( lxCorreConom ) + "'">>, "Cocomcob" = <<lxCorreCocomcob>>, "Cofax" = <<"'" + this.FormatearTextoSql( lxCorreCofax ) + "'">>, "Coemail" = <<"'" + this.FormatearTextoSql( lxCorreCoemail ) + "'">>, "Cotipodoc" = <<"'" + this.FormatearTextoSql( lxCorreCotipodoc ) + "'">>, "Cocp" = <<"'" + this.FormatearTextoSql( lxCorreCocp ) + "'">>, "Copageweb" = <<"'" + this.FormatearTextoSql( lxCorreCopageweb ) + "'">>, "Conrodoc" = <<"'" + this.FormatearTextoSql( lxCorreConrodoc ) + "'">>, "Coprv" = <<"'" + this.FormatearTextoSql( lxCorreCoprv ) + "'">>, "Cocontac" = <<"'" + this.FormatearTextoSql( lxCorreCocontac ) + "'">> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'CORRE' 
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

			lcFiltro = ["Cocod" = ] + lcValorClavePrimariaString  + [ and  CORRE.COCOD != '']
		loColeccion.Agregar( 'delete from ZooLogic.CORRE where ' + lcFiltro )
			loColeccion.cTabla = 'CORRE' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.CORRE where  CORRE.COCOD != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.CORRE where COCOD = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  CORRE.COCOD != ''" )
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
		lcCursor = This.oEntidad.cPrefijoRecibir + 'CORREDOR'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.CORRE Where COCOD = ] + "'" + this.FormatearTextoSql( &lcCursor..COCOD ) + "'", 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					this.oConexion.EjecutarSql( [UPDATE ZooLogic.CORRE set  FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, CODIR = ] + "'" + this.FormatearTextoSql( &lcCursor..CODIR ) + "'"+ [, COIVA = ] + transform( &lcCursor..COIVA )+ [, TIMESTAMP = ] + transform( &lcCursor..TIMESTAMP )+ [, COCOMVTA = ] + transform( &lcCursor..COCOMVTA )+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, COTLF = ] + "'" + this.FormatearTextoSql( &lcCursor..COTLF ) + "'"+ [, COIMAGEN = ] + "'" + this.FormatearTextoSql( &lcCursor..COIMAGEN ) + "'"+ [, COCOD = ] + "'" + this.FormatearTextoSql( &lcCursor..COCOD ) + "'"+ [, COOBS = ] + "'" + this.FormatearTextoSql( &lcCursor..COOBS ) + "'"+ [, COCUIT = ] + "'" + this.FormatearTextoSql( &lcCursor..COCUIT ) + "'"+ [, COLOC = ] + "'" + this.FormatearTextoSql( &lcCursor..COLOC ) + "'"+ [, CONOM = ] + "'" + this.FormatearTextoSql( &lcCursor..CONOM ) + "'"+ [, COCOMCOB = ] + transform( &lcCursor..COCOMCOB )+ [, COFAX = ] + "'" + this.FormatearTextoSql( &lcCursor..COFAX ) + "'"+ [, COEMAIL = ] + "'" + this.FormatearTextoSql( &lcCursor..COEMAIL ) + "'"+ [, COTIPODOC = ] + "'" + this.FormatearTextoSql( &lcCursor..COTIPODOC ) + "'"+ [, COCP = ] + "'" + this.FormatearTextoSql( &lcCursor..COCP ) + "'"+ [, COPAGEWEB = ] + "'" + this.FormatearTextoSql( &lcCursor..COPAGEWEB ) + "'"+ [, CONRODOC = ] + "'" + this.FormatearTextoSql( &lcCursor..CONRODOC ) + "'"+ [, COPRV = ] + "'" + this.FormatearTextoSql( &lcCursor..COPRV ) + "'"+ [, COCONTAC = ] + "'" + this.FormatearTextoSql( &lcCursor..COCONTAC ) + "'" + [ Where COCOD = ] + "'" + this.FormatearTextoSql( &lcCursor..COCOD ) + "'" )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
				endIf
			else
				Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
				Text to lcCampos noShow
					 FECEXPO, FECIMPO, FECTRANS, FMODIFW, FALTAFW, CODIR, COIVA, TIMESTAMP, COCOMVTA, SALTAFW, HORAIMPO, HMODIFW, SMODIFW, UMODIFW, UALTAFW, ZADSFW, VALTAFW, VMODIFW, HORAEXPO, HALTAFW, ESTTRANS, BDALTAFW, BDMODIFW, COTLF, COIMAGEN, COCOD, COOBS, COCUIT, COLOC, CONOM, COCOMCOB, COFAX, COEMAIL, COTIPODOC, COCP, COPAGEWEB, CONRODOC, COPRV, COCONTAC
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CODIR ) + "'" + ',' + transform( &lcCursor..COIVA )
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..TIMESTAMP ) + ',' + transform( &lcCursor..COCOMVTA ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..COTLF ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..COIMAGEN ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..COCOD ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..COOBS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..COCUIT ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..COLOC ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CONOM ) + "'" + ',' + transform( &lcCursor..COCOMCOB ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..COFAX ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..COEMAIL ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..COTIPODOC ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..COCP ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..COPAGEWEB ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CONRODOC ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..COPRV ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..COCONTAC ) + "'"
lcValoresCampos = substr(lcValoresCampos,2) 

				this.oConexion.EjecutarSql( [Insert into ZooLogic.CORRE ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
				this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'CORREDOR'
		if This.ActualizaEnRecepcion()
	endif
	Use in select( 'cExistentes' )
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearCursorMemo( tcCursorACrear as String, tcTablaConMemo as String ) as Void
		create cursor &tcCursorACrear ( COCOD C (5) , Orden N(16), texto C(80))
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirComponentes() As Void
		
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function ObtenerIdentificadorParaLoguear( tcCursor as String ) As String
		local lcRetorno as String, lnCC as String , loCC as Object, lni as Integer, lcSecuencia as String
		lcRetorno = this.oEntidad.cDescripcion 
		lcRetorno = lcRetorno + ' - Código: ' + transform( &tcCursor..COCOD      )
		Return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EsAliasDeProceso( tcAlias As String, tcPrefijo as string ) As Boolean
		local llRetorno as Boolean, lcAlias as String, lcPrefijo As String
		llRetorno = .F.
		lcAlias = upper( alltrim( tcAlias ) )
		lcPrefijo = upper( alltrim( tcPrefijo ) )
		Do Case
			Case  lcAlias == lcPrefijo + 'CORREDOR'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'CORREDOR_ZADSFW'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_CORRE')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'CORREDOR'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..COCOD
		llCondicion = isnull( lxVar )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad CORREDOR. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'CORREDOR'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		select recno() as _Rec, * from &lcCursor into cursor CurConRecno
		select max( _Rec ) as Maximo,COCOD as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( COCOD, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		Use in select( 'CurConRecno' )
		Use in select( 'RepMax' )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDatosInvalidos( toConexion as Object ) as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'CORREDOR'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_CORRE') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_CORRE
Create Table ZooLogic.TablaTrabajo_CORRE ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fecexpo" datetime  null, 
"fecimpo" datetime  null, 
"fectrans" datetime  null, 
"fmodifw" datetime  null, 
"faltafw" datetime  null, 
"codir" char( 70 )  null, 
"coiva" numeric( 2, 0 )  null, 
"timestamp" numeric( 20, 0 )  null, 
"cocomvta" numeric( 6, 2 )  null, 
"saltafw" char( 7 )  null, 
"horaimpo" char( 8 )  null, 
"hmodifw" char( 8 )  null, 
"smodifw" char( 7 )  null, 
"umodifw" char( 100 )  null, 
"ualtafw" char( 100 )  null, 
"zadsfw" varchar(max)  null, 
"valtafw" char( 13 )  null, 
"vmodifw" char( 13 )  null, 
"horaexpo" char( 8 )  null, 
"haltafw" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"bdaltafw" char( 8 )  null, 
"bdmodifw" char( 8 )  null, 
"cotlf" char( 30 )  null, 
"coimagen" char( 180 )  null, 
"cocod" char( 5 )  null, 
"coobs" char( 76 )  null, 
"cocuit" char( 15 )  null, 
"coloc" char( 70 )  null, 
"conom" char( 60 )  null, 
"cocomcob" numeric( 6, 2 )  null, 
"cofax" char( 60 )  null, 
"coemail" char( 60 )  null, 
"cotipodoc" char( 2 )  null, 
"cocp" char( 8 )  null, 
"copageweb" char( 60 )  null, 
"conrodoc" char( 10 )  null, 
"coprv" char( 2 )  null, 
"cocontac" char( 60 )  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_CORRE' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_CORRE' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'CORREDOR'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		with loManejador
			if this.oEntidad.VerificarContexto( 'CB' )
			else
				.AgregarMapeo('Nrolinea','Nrolinea')
			endif
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('codir','codir')
			.AgregarMapeo('coiva','coiva')
			.AgregarMapeo('timestamp','timestamp')
			.AgregarMapeo('cocomvta','cocomvta')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('cotlf','cotlf')
			.AgregarMapeo('coimagen','coimagen')
			.AgregarMapeo('cocod','cocod')
			.AgregarMapeo('coobs','coobs')
			.AgregarMapeo('cocuit','cocuit')
			.AgregarMapeo('coloc','coloc')
			.AgregarMapeo('conom','conom')
			.AgregarMapeo('cocomcob','cocomcob')
			.AgregarMapeo('cofax','cofax')
			.AgregarMapeo('coemail','coemail')
			.AgregarMapeo('cotipodoc','cotipodoc')
			.AgregarMapeo('cocp','cocp')
			.AgregarMapeo('copageweb','copageweb')
			.AgregarMapeo('conrodoc','conrodoc')
			.AgregarMapeo('coprv','coprv')
			.AgregarMapeo('cocontac','cocontac')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_CORRE'
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
				Update t Set t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.CODIR = isnull( d.CODIR, t.CODIR ),t.COIVA = isnull( d.COIVA, t.COIVA ),t.TIMESTAMP = isnull( d.TIMESTAMP, t.TIMESTAMP ),t.COCOMVTA = isnull( d.COCOMVTA, t.COCOMVTA ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.COTLF = isnull( d.COTLF, t.COTLF ),t.COIMAGEN = isnull( d.COIMAGEN, t.COIMAGEN ),t.COCOD = isnull( d.COCOD, t.COCOD ),t.COOBS = isnull( d.COOBS, t.COOBS ),t.COCUIT = isnull( d.COCUIT, t.COCUIT ),t.COLOC = isnull( d.COLOC, t.COLOC ),t.CONOM = isnull( d.CONOM, t.CONOM ),t.COCOMCOB = isnull( d.COCOMCOB, t.COCOMCOB ),t.COFAX = isnull( d.COFAX, t.COFAX ),t.COEMAIL = isnull( d.COEMAIL, t.COEMAIL ),t.COTIPODOC = isnull( d.COTIPODOC, t.COTIPODOC ),t.COCP = isnull( d.COCP, t.COCP ),t.COPAGEWEB = isnull( d.COPAGEWEB, t.COPAGEWEB ),t.CONRODOC = isnull( d.CONRODOC, t.CONRODOC ),t.COPRV = isnull( d.COPRV, t.COPRV ),t.COCONTAC = isnull( d.COCONTAC, t.COCONTAC )
					from ZooLogic.CORRE t inner join deleted d 
							 on t.COCOD = d.COCOD
				-- Fin Updates
				insert into ZooLogic.CORRE(Fecexpo,Fecimpo,Fectrans,Fmodifw,Faltafw,Codir,Coiva,Timestamp,Cocomvta,Saltafw,Horaimpo,Hmodifw,Smodifw,Umodifw,Ualtafw,Zadsfw,Valtafw,Vmodifw,Horaexpo,Haltafw,Esttrans,Bdaltafw,Bdmodifw,Cotlf,Coimagen,Cocod,Coobs,Cocuit,Coloc,Conom,Cocomcob,Cofax,Coemail,Cotipodoc,Cocp,Copageweb,Conrodoc,Coprv,Cocontac)
					Select isnull( d.FECEXPO,''),isnull( d.FECIMPO,''),isnull( d.FECTRANS,''),isnull( d.FMODIFW,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.CODIR,''),isnull( d.COIVA,0),isnull( d.TIMESTAMP,0),isnull( d.COCOMVTA,0),isnull( d.SALTAFW,''),isnull( d.HORAIMPO,''),isnull( d.HMODIFW,''),isnull( d.SMODIFW,''),isnull( d.UMODIFW,''),isnull( d.UALTAFW,''),isnull( d.ZADSFW,''),isnull( d.VALTAFW,''),isnull( d.VMODIFW,''),isnull( d.HORAEXPO,''),convert( char(8), getdate(), 108 ),isnull( d.ESTTRANS,''),isnull( d.BDALTAFW,''),isnull( d.BDMODIFW,''),isnull( d.COTLF,''),isnull( d.COIMAGEN,''),isnull( d.COCOD,''),isnull( d.COOBS,''),isnull( d.COCUIT,''),isnull( d.COLOC,''),isnull( d.CONOM,''),isnull( d.COCOMCOB,0),isnull( d.COFAX,''),isnull( d.COEMAIL,''),isnull( d.COTIPODOC,''),isnull( d.COCP,''),isnull( d.COPAGEWEB,''),isnull( d.CONRODOC,''),isnull( d.COPRV,''),isnull( d.COCONTAC,'')
						From deleted d left join ZooLogic.CORRE pk 
							 on d.COCOD = pk.COCOD
						Where pk.COCOD Is Null 
				-- Fin Inserts
			End
		EndText
		Return lcCadena
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	protected Function EliminarTablasDeTrabajo( toConexion as Object ) as void
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_CORRE') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_CORRE
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_CORREDOR' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_CORREDOR.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_CORREDOR.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_CORREDOR.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_CORREDOR.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_CORREDOR.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Direccion = nvl( c_CORREDOR.Direccion, [] )
					.Situacionfiscal_PK =  nvl( c_CORREDOR.Situacionfiscal, 0 )
					.Timestamp = nvl( c_CORREDOR.Timestamp, 0 )
					.Comisionventas = nvl( c_CORREDOR.Comisionventas, 0 )
					.Seriealtafw = nvl( c_CORREDOR.Seriealtafw, [] )
					.Horaimpo = nvl( c_CORREDOR.Horaimpo, [] )
					.Horamodificacionfw = nvl( c_CORREDOR.Horamodificacionfw, [] )
					.Seriemodificacionfw = nvl( c_CORREDOR.Seriemodificacionfw, [] )
					.Usuariomodificacionfw = nvl( c_CORREDOR.Usuariomodificacionfw, [] )
					.Usuarioaltafw = nvl( c_CORREDOR.Usuarioaltafw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Versionaltafw = nvl( c_CORREDOR.Versionaltafw, [] )
					.Versionmodificacionfw = nvl( c_CORREDOR.Versionmodificacionfw, [] )
					.Horaexpo = nvl( c_CORREDOR.Horaexpo, [] )
					.Horaaltafw = nvl( c_CORREDOR.Horaaltafw, [] )
					.Estadotransferencia = nvl( c_CORREDOR.Estadotransferencia, [] )
					.Basededatosaltafw = nvl( c_CORREDOR.Basededatosaltafw, [] )
					.Basededatosmodificacionfw = nvl( c_CORREDOR.Basededatosmodificacionfw, [] )
					.Telefono = nvl( c_CORREDOR.Telefono, [] )
					.Imagen = nvl( c_CORREDOR.Imagen, [] )
					.Codigo = nvl( c_CORREDOR.Codigo, [] )
					.Observacion = nvl( c_CORREDOR.Observacion, [] )
					.Cuit = nvl( c_CORREDOR.Cuit, [] )
					.Localidad = nvl( c_CORREDOR.Localidad, [] )
					.Nombre = nvl( c_CORREDOR.Nombre, [] )
					.Comisioncobranzas = nvl( c_CORREDOR.Comisioncobranzas, 0 )
					.Fax = nvl( c_CORREDOR.Fax, [] )
					.Email = nvl( c_CORREDOR.Email, [] )
					.Tipodocumento = nvl( c_CORREDOR.Tipodocumento, [] )
					.Codigopostal = nvl( c_CORREDOR.Codigopostal, [] )
					.Paginaweb = nvl( c_CORREDOR.Paginaweb, [] )
					.Nrodocumento = nvl( c_CORREDOR.Nrodocumento, [] )
					.Provincia_PK =  nvl( c_CORREDOR.Provincia, [] )
					.Contacto = nvl( c_CORREDOR.Contacto, [] )
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
		return c_CORREDOR.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.CORRE' )
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
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "COCOD"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
		text to lcSQL textmerge noshow
				SELECT nro,totalRegistros,COCOD as Id
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    COCOD from (
							select * 
								from ZooLogic.CORRE 
								Where   CORRE.COCOD != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "CORRE", "", lcCursor, set("Datasession") )
		lcXml = this.CursorAXml( lcCursor )
		
		use in select( lcCursor )
		
		Return lcXml 
		
	endfunc
	*-----------------------------------------------------------------------------------------
	function ObtenerDatosEntidadPaginado( tcOrderBy as String, tcFiltro as String, tnCantidad as Integer, tnPagina as Integer )  as String
		local lcOrderBy as String, lnCuantos as Integer, lnPagina as Integer, lnTope as Integer, lnDesde as Integer, lcSQL as String, lcCursor as String, lcXml as String
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "COCOD"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
			text to lcAtributos textmerge noshow
			"Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Codir" as "Direccion", "Coiva" as "Situacionfiscal", "Timestamp" as "Timestamp", "Cocomvta" as "Comisionventas", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Cotlf" as "Telefono", "Coimagen" as "Imagen", "Cocod" as "Codigo", "Coobs" as "Observacion", "Cocuit" as "Cuit", "Coloc" as "Localidad", "Conom" as "Nombre", "Cocomcob" as "Comisioncobranzas", "Cofax" as "Fax", "Coemail" as "Email", "Cotipodoc" as "Tipodocumento", "Cocp" as "Codigopostal", "Copageweb" as "Paginaweb", "Conrodoc" as "Nrodocumento", "Coprv" as "Provincia", "Cocontac" as "Contacto"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.CORRE 
								Where   CORRE.COCOD != ''
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
	Tabla = 'CORRE'
	Filtro = " CORRE.COCOD != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " CORRE.COCOD != ''"
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
	<row entidad="CORREDOR                                " atributo="FECHAEXPO                               " tabla="CORRE          " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CORREDOR                                " atributo="FECHAIMPO                               " tabla="CORRE          " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CORREDOR                                " atributo="FECHATRANSFERENCIA                      " tabla="CORRE          " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha transferencia                                                                                                                                             " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CORREDOR                                " atributo="FECHAMODIFICACIONFW                     " tabla="CORRE          " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CORREDOR                                " atributo="FECHAALTAFW                             " tabla="CORRE          " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CORREDOR                                " atributo="DIRECCION                               " tabla="CORRE          " campo="CODIR     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="70" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="6" etiqueta="Dirección                                                                                                                                                       " dominio="TEXTO                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CORREDOR                                " atributo="SITUACIONFISCAL                         " tabla="CORRE          " campo="COIVA     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="SITUACIONFISCAL                         " tipodato="N         " longitud="2" decimales="0" valorsugerido="1                                                                                                                                                                                                                                                             " obligatorio="false" admitebusqueda="400" etiqueta="Situación Fiscal                                                                                                                                                " dominio="COMBOTABLA                    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CORREDOR                                " atributo="TIMESTAMP                               " tabla="CORRE          " campo="TIMESTAMP " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CORREDOR                                " atributo="COMISIONVENTAS                          " tabla="CORRE          " campo="COCOMVTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="6" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="402" etiqueta="Comisión ventas %                                                                                                                                               " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="5" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CORREDOR                                " atributo="SERIEALTAFW                             " tabla="CORRE          " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CORREDOR                                " atributo="HORAIMPO                                " tabla="CORRE          " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CORREDOR                                " atributo="HORAMODIFICACIONFW                      " tabla="CORRE          " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CORREDOR                                " atributo="SERIEMODIFICACIONFW                     " tabla="CORRE          " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CORREDOR                                " atributo="USUARIOMODIFICACIONFW                   " tabla="CORRE          " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CORREDOR                                " atributo="USUARIOALTAFW                           " tabla="CORRE          " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CORREDOR                                " atributo="ZADSFW                                  " tabla="CORRE          " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CORREDOR                                " atributo="VERSIONALTAFW                           " tabla="CORRE          " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CORREDOR                                " atributo="VERSIONMODIFICACIONFW                   " tabla="CORRE          " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CORREDOR                                " atributo="HORAEXPO                                " tabla="CORRE          " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CORREDOR                                " atributo="HORAALTAFW                              " tabla="CORRE          " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CORREDOR                                " atributo="ESTADOTRANSFERENCIA                     " tabla="CORRE          " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado transferencia                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CORREDOR                                " atributo="BASEDEDATOSALTAFW                       " tabla="CORRE          " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CORREDOR                                " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="CORRE          " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CORREDOR                                " atributo="TELEFONO                                " tabla="CORRE          " campo="COTLF     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="14" etiqueta="Teléfonos                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CORREDOR                                " atributo="IMAGEN                                  " tabla="CORRE          " campo="COIMAGEN  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="180" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="20" etiqueta="Imagen                                                                                                                                                          " dominio="IMAGENCONRUTADINAMICA         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="3" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CORREDOR                                " atributo="CODIGO                                  " tabla="CORRE          " campo="COCOD     " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="2" etiqueta="Código                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CORREDOR                                " atributo="OBSERVACION                             " tabla="CORRE          " campo="COOBS     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="76" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="12" etiqueta="Observaciones                                                                                                                                                   " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CORREDOR                                " atributo="CUIT                                    " tabla="CORRE          " campo="COCUIT    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="404" etiqueta="CUIT                                                                                                                                                            " dominio="CUIT                          " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="99-99999999-9            " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CORREDOR                                " atributo="LOCALIDAD                               " tabla="CORRE          " campo="COLOC     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="70" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="8" etiqueta="Localidad                                                                                                                                                       " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CORREDOR                                " atributo="NOMBRE                                  " tabla="CORRE          " campo="CONOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="4" etiqueta="Nombre                                                                                                                                                          " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CORREDOR                                " atributo="COMISIONCOBRANZAS                       " tabla="CORRE          " campo="COCOMCOB  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="6" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="406" etiqueta="Comisión cobranzas %                                                                                                                                            " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="5" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CORREDOR                                " atributo="FAX                                     " tabla="CORRE          " campo="COFAX     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="408" etiqueta="Fax                                                                                                                                                             " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CORREDOR                                " atributo="FECHADEALTA                             " tabla="CORRE          " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha Alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="0" orden="2" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CORREDOR                                " atributo="EMAIL                                   " tabla="CORRE          " campo="COEMAIL   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="410" etiqueta="E-Mail                                                                                                                                                          " dominio="MAIL                          " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CORREDOR                                " atributo="TIPODOCUMENTO                           " tabla="CORRE          " campo="COTIPODOC " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="412" etiqueta="T./Nro.Doc                                                                                                                                                      " dominio="DOCUMENTO                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CORREDOR                                " atributo="CODIGOPOSTAL                            " tabla="CORRE          " campo="COCP      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="414" etiqueta="Código Postal                                                                                                                                                   " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CORREDOR                                " atributo="FECHAULTIMAMODIFICACION                 " tabla="CORRE          " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Ultima Modificación                                                                                                                                             " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="0" orden="3" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CORREDOR                                " atributo="PAGINAWEB                               " tabla="CORRE          " campo="COPAGEWEB " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="416" etiqueta="Pagina web                                                                                                                                                      " dominio="WEB                           " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CORREDOR                                " atributo="NRODOCUMENTO                            " tabla="CORRE          " campo="CONRODOC  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="418" etiqueta="T./Nro.Doc                                                                                                                                                      " dominio="DOCUMENTO                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CORREDOR                                " atributo="PROVINCIA                               " tabla="CORRE          " campo="COPRV     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="PROVINCIA                               " tipodato="C         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="420" etiqueta="Provincia                                                                                                                                                       " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CORREDOR                                " atributo="CONTACTO                                " tabla="CORRE          " campo="COCONTAC  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="10" etiqueta="Contacto                                                                                                                                                        " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SITUACIONFISCAL                         " atributo="DESCRIPCION                             " tabla="SITFISCAL      " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="401" etiqueta="Detalle Sit.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join SITFISCAL On CORRE.COIVA = SITFISCAL.Codigo And  SITFISCAL.CODIGO != 0                                                                                                                                                                             " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVINCIA                               " atributo="DESCRIPCION                             " tabla="PROVINCI       " campo="PRV_DES   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="421" etiqueta="Detalle Pro.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join PROVINCI On CORRE.COPRV = PROVINCI.PRV_COD And  PROVINCI.PRV_COD != ''                                                                                                                                                                             " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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