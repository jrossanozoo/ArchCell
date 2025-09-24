
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
	cTagClavePk = '_CORPK'
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
			local  lxCorreFmodifw, lxCorreFectrans, lxCorreFecimpo, lxCorreFecexpo, lxCorreFaltafw, lxCorreHaltafw, lxCorreHmodifw, lxCorreValtafw, lxCorreZadsfw, lxCorreVmodifw, lxCorreUmodifw, lxCorreSmodifw, lxCorreUaltafw, lxCorreHoraimpo, lxCorreSaltafw, lxCorreEsttrans, lxCorreHoraexpo, lxCorreBdmodifw, lxCorreCltlf, lxCorreBdaltafw, lxCorreClpun1, lxCorreCimagen, lxCorreClcod, lxCorreClobs, lxCorreCltipodoc, lxCorreCldir, lxCorreCltlfm, lxCorreClpun2, lxCorreClnom, lxCorreClfecha, lxCorreClemail, lxCorreClnrodoc, lxCorreClnum, lxCorreCliva, lxCorreClcuit, lxCorreClfing, lxCorreClpiso, lxCorreClfax, lxCorreClfegr, lxCorreClloc, lxCorreClconta, lxCorreCldepto, lxCorreClcp, lxCorreClprv, lxCorrePpais
				lxCorreFmodifw =  .Fechamodificacionfw			lxCorreFectrans =  .Fechatransferencia			lxCorreFecimpo =  .Fechaimpo			lxCorreFecexpo =  .Fechaexpo			lxCorreFaltafw =  .Fechaaltafw			lxCorreHaltafw =  .Horaaltafw			lxCorreHmodifw =  .Horamodificacionfw			lxCorreValtafw =  .Versionaltafw			lxCorreZadsfw =  .Zadsfw			lxCorreVmodifw =  .Versionmodificacionfw			lxCorreUmodifw =  .Usuariomodificacionfw			lxCorreSmodifw =  .Seriemodificacionfw			lxCorreUaltafw =  .Usuarioaltafw			lxCorreHoraimpo =  .Horaimpo			lxCorreSaltafw =  .Seriealtafw			lxCorreEsttrans =  .Estadotransferencia			lxCorreHoraexpo =  .Horaexpo			lxCorreBdmodifw =  .Basededatosmodificacionfw			lxCorreCltlf =  .Telefono			lxCorreBdaltafw =  .Basededatosaltafw			lxCorreClpun1 =  .Comisionventas			lxCorreCimagen =  .Imagen			lxCorreClcod =  .Codigo			lxCorreClobs =  .Observacion			lxCorreCltipodoc =  .Tipodocumento			lxCorreCldir =  .Calle			lxCorreCltlfm =  .Movil			lxCorreClpun2 =  .Comisioncobranzas			lxCorreClnom =  .Nombre			lxCorreClfecha =  .Fechanacimiento			lxCorreClemail =  .Email			lxCorreClnrodoc =  .Nrodocumento			lxCorreClnum =  .Numero			lxCorreCliva =  .Situacionfiscal_PK 			lxCorreClcuit =  .Cuit			lxCorreClfing =  .Fechaingreso			lxCorreClpiso =  .Piso			lxCorreClfax =  .Fax			lxCorreClfegr =  .Fechaegreso			lxCorreClloc =  .Localidad			lxCorreClconta =  .Contacto			lxCorreCldepto =  .Departamento			lxCorreClcp =  .Codigopostal			lxCorreClprv =  upper( .Provincia_PK ) 			lxCorrePpais =  upper( .Pais_PK ) 
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxCorreClcod = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.CORRE ( "Fmodifw","Fectrans","Fecimpo","Fecexpo","Faltafw","Haltafw","Hmodifw","Valtafw","Zadsfw","Vmodifw","Umodifw","Smodifw","Ualtafw","Horaimpo","Saltafw","Esttrans","Horaexpo","Bdmodifw","Cltlf","Bdaltafw","Clpun1","Cimagen","Clcod","Clobs","Cltipodoc","Cldir","Cltlfm","Clpun2","Clnom","Clfecha","Clemail","Clnrodoc","Clnum","Cliva","Clcuit","Clfing","Clpiso","Clfax","Clfegr","Clloc","Clconta","Cldepto","Clcp","Clprv","Ppais" ) values ( <<"'" + this.ConvertirDateSql( lxCorreFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCorreFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCorreFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCorreFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCorreFaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCorreHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCorreHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCorreValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCorreZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCorreVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCorreUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCorreSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCorreUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCorreHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCorreSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCorreEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCorreHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCorreBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCorreCltlf ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCorreBdaltafw ) + "'" >>, <<lxCorreClpun1 >>, <<"'" + this.FormatearTextoSql( lxCorreCimagen ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCorreClcod ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCorreClobs ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCorreCltipodoc ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCorreCldir ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCorreCltlfm ) + "'" >>, <<lxCorreClpun2 >>, <<"'" + this.FormatearTextoSql( lxCorreClnom ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCorreClfecha ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCorreClemail ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCorreClnrodoc ) + "'" >>, <<lxCorreClnum >>, <<lxCorreCliva >>, <<"'" + this.FormatearTextoSql( lxCorreClcuit ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCorreClfing ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCorreClpiso ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCorreClfax ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCorreClfegr ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCorreClloc ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCorreClconta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCorreCldepto ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCorreClcp ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCorreClprv ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCorrePpais ) + "'" >> )
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
			local  lxCorreFmodifw, lxCorreFectrans, lxCorreFecimpo, lxCorreFecexpo, lxCorreFaltafw, lxCorreHaltafw, lxCorreHmodifw, lxCorreValtafw, lxCorreZadsfw, lxCorreVmodifw, lxCorreUmodifw, lxCorreSmodifw, lxCorreUaltafw, lxCorreHoraimpo, lxCorreSaltafw, lxCorreEsttrans, lxCorreHoraexpo, lxCorreBdmodifw, lxCorreCltlf, lxCorreBdaltafw, lxCorreClpun1, lxCorreCimagen, lxCorreClcod, lxCorreClobs, lxCorreCltipodoc, lxCorreCldir, lxCorreCltlfm, lxCorreClpun2, lxCorreClnom, lxCorreClfecha, lxCorreClemail, lxCorreClnrodoc, lxCorreClnum, lxCorreCliva, lxCorreClcuit, lxCorreClfing, lxCorreClpiso, lxCorreClfax, lxCorreClfegr, lxCorreClloc, lxCorreClconta, lxCorreCldepto, lxCorreClcp, lxCorreClprv, lxCorrePpais
				lxCorreFmodifw =  .Fechamodificacionfw			lxCorreFectrans =  .Fechatransferencia			lxCorreFecimpo =  .Fechaimpo			lxCorreFecexpo =  .Fechaexpo			lxCorreFaltafw =  .Fechaaltafw			lxCorreHaltafw =  .Horaaltafw			lxCorreHmodifw =  .Horamodificacionfw			lxCorreValtafw =  .Versionaltafw			lxCorreZadsfw =  .Zadsfw			lxCorreVmodifw =  .Versionmodificacionfw			lxCorreUmodifw =  .Usuariomodificacionfw			lxCorreSmodifw =  .Seriemodificacionfw			lxCorreUaltafw =  .Usuarioaltafw			lxCorreHoraimpo =  .Horaimpo			lxCorreSaltafw =  .Seriealtafw			lxCorreEsttrans =  .Estadotransferencia			lxCorreHoraexpo =  .Horaexpo			lxCorreBdmodifw =  .Basededatosmodificacionfw			lxCorreCltlf =  .Telefono			lxCorreBdaltafw =  .Basededatosaltafw			lxCorreClpun1 =  .Comisionventas			lxCorreCimagen =  .Imagen			lxCorreClcod =  .Codigo			lxCorreClobs =  .Observacion			lxCorreCltipodoc =  .Tipodocumento			lxCorreCldir =  .Calle			lxCorreCltlfm =  .Movil			lxCorreClpun2 =  .Comisioncobranzas			lxCorreClnom =  .Nombre			lxCorreClfecha =  .Fechanacimiento			lxCorreClemail =  .Email			lxCorreClnrodoc =  .Nrodocumento			lxCorreClnum =  .Numero			lxCorreCliva =  .Situacionfiscal_PK 			lxCorreClcuit =  .Cuit			lxCorreClfing =  .Fechaingreso			lxCorreClpiso =  .Piso			lxCorreClfax =  .Fax			lxCorreClfegr =  .Fechaegreso			lxCorreClloc =  .Localidad			lxCorreClconta =  .Contacto			lxCorreCldepto =  .Departamento			lxCorreClcp =  .Codigopostal			lxCorreClprv =  upper( .Provincia_PK ) 			lxCorrePpais =  upper( .Pais_PK ) 
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()
			lxValorClavePrimaria = .oEntidad.CODIGO
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ZooLogic.CORRE set "Fmodifw" = <<"'" + this.ConvertirDateSql( lxCorreFmodifw ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxCorreFectrans ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxCorreFecimpo ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxCorreFecexpo ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxCorreFaltafw ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxCorreHaltafw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxCorreHmodifw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxCorreValtafw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxCorreZadsfw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxCorreVmodifw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxCorreUmodifw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxCorreSmodifw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxCorreUaltafw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxCorreHoraimpo ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxCorreSaltafw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxCorreEsttrans ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxCorreHoraexpo ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxCorreBdmodifw ) + "'">>,"Cltlf" = <<"'" + this.FormatearTextoSql( lxCorreCltlf ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxCorreBdaltafw ) + "'">>,"Clpun1" = <<lxCorreClpun1>>,"Cimagen" = <<"'" + this.FormatearTextoSql( lxCorreCimagen ) + "'">>,"Clcod" = <<"'" + this.FormatearTextoSql( lxCorreClcod ) + "'">>,"Clobs" = <<"'" + this.FormatearTextoSql( lxCorreClobs ) + "'">>,"Cltipodoc" = <<"'" + this.FormatearTextoSql( lxCorreCltipodoc ) + "'">>,"Cldir" = <<"'" + this.FormatearTextoSql( lxCorreCldir ) + "'">>,"Cltlfm" = <<"'" + this.FormatearTextoSql( lxCorreCltlfm ) + "'">>,"Clpun2" = <<lxCorreClpun2>>,"Clnom" = <<"'" + this.FormatearTextoSql( lxCorreClnom ) + "'">>,"Clfecha" = <<"'" + this.ConvertirDateSql( lxCorreClfecha ) + "'">>,"Clemail" = <<"'" + this.FormatearTextoSql( lxCorreClemail ) + "'">>,"Clnrodoc" = <<"'" + this.FormatearTextoSql( lxCorreClnrodoc ) + "'">>,"Clnum" = <<lxCorreClnum>>,"Cliva" = <<lxCorreCliva>>,"Clcuit" = <<"'" + this.FormatearTextoSql( lxCorreClcuit ) + "'">>,"Clfing" = <<"'" + this.ConvertirDateSql( lxCorreClfing ) + "'">>,"Clpiso" = <<"'" + this.FormatearTextoSql( lxCorreClpiso ) + "'">>,"Clfax" = <<"'" + this.FormatearTextoSql( lxCorreClfax ) + "'">>,"Clfegr" = <<"'" + this.ConvertirDateSql( lxCorreClfegr ) + "'">>,"Clloc" = <<"'" + this.FormatearTextoSql( lxCorreClloc ) + "'">>,"Clconta" = <<"'" + this.FormatearTextoSql( lxCorreClconta ) + "'">>,"Cldepto" = <<"'" + this.FormatearTextoSql( lxCorreCldepto ) + "'">>,"Clcp" = <<"'" + this.FormatearTextoSql( lxCorreClcp ) + "'">>,"Clprv" = <<"'" + this.FormatearTextoSql( lxCorreClprv ) + "'">>,"Ppais" = <<"'" + this.FormatearTextoSql( lxCorrePpais ) + "'">> where "Clcod" = <<"'" + this.FormatearTextoSql( lxCorreClcod ) + "'">> and  CORRE.CLCOD != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 CLCOD from ZooLogic.CORRE where " + this.ConvertirFuncionesSql( " CORRE.CLCOD != ''" ) )
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
			Local lxCorreClcod
			lxCorreClcod = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Haltafw" as "Horaaltafw", "Hmodifw" as "Horamodificacionfw", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Cltlf" as "Telefono", "Bdaltafw" as "Basededatosaltafw", "Clpun1" as "Comisionventas", "Cimagen" as "Imagen", "Clcod" as "Codigo", "Clobs" as "Observacion", "Cltipodoc" as "Tipodocumento", "Cldir" as "Calle", "Cltlfm" as "Movil", "Clpun2" as "Comisioncobranzas", "Clnom" as "Nombre", "Clfecha" as "Fechanacimiento", "Clemail" as "Email", "Clnrodoc" as "Nrodocumento", "Clnum" as "Numero", "Cliva" as "Situacionfiscal", "Clcuit" as "Cuit", "Clfing" as "Fechaingreso", "Clpiso" as "Piso", "Clfax" as "Fax", "Clfegr" as "Fechaegreso", "Clloc" as "Localidad", "Clconta" as "Contacto", "Cldepto" as "Departamento", "Clcp" as "Codigopostal", "Clprv" as "Provincia", "Ppais" as "Pais" from ZooLogic.CORRE where "Clcod" = <<"'" + this.FormatearTextoSql( lxCorreClcod ) + "'">> and  CORRE.CLCOD != ''
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
		local llRetorno as boolean,lxCorreClcod as Variant
		llRetorno = .t.
		lxCorreClcod = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.CORRE where "Clcod" = <<"'" + this.FormatearTextoSql( lxCorreClcod ) + "'">> and  CORRE.CLCOD != ''
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
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Haltafw" as "Horaaltafw", "Hmodifw" as "Horamodificacionfw", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Cltlf" as "Telefono", "Bdaltafw" as "Basededatosaltafw", "Clpun1" as "Comisionventas", "Cimagen" as "Imagen", "Clcod" as "Codigo", "Clobs" as "Observacion", "Cltipodoc" as "Tipodocumento", "Cldir" as "Calle", "Cltlfm" as "Movil", "Clpun2" as "Comisioncobranzas", "Clnom" as "Nombre", "Clfecha" as "Fechanacimiento", "Clemail" as "Email", "Clnrodoc" as "Nrodocumento", "Clnum" as "Numero", "Cliva" as "Situacionfiscal", "Clcuit" as "Cuit", "Clfing" as "Fechaingreso", "Clpiso" as "Piso", "Clfax" as "Fax", "Clfegr" as "Fechaegreso", "Clloc" as "Localidad", "Clconta" as "Contacto", "Cldepto" as "Departamento", "Clcp" as "Codigopostal", "Clprv" as "Provincia", "Ppais" as "Pais" from ZooLogic.CORRE where  CORRE.CLCOD != '' order by CLCOD
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
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Haltafw" as "Horaaltafw", "Hmodifw" as "Horamodificacionfw", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Cltlf" as "Telefono", "Bdaltafw" as "Basededatosaltafw", "Clpun1" as "Comisionventas", "Cimagen" as "Imagen", "Clcod" as "Codigo", "Clobs" as "Observacion", "Cltipodoc" as "Tipodocumento", "Cldir" as "Calle", "Cltlfm" as "Movil", "Clpun2" as "Comisioncobranzas", "Clnom" as "Nombre", "Clfecha" as "Fechanacimiento", "Clemail" as "Email", "Clnrodoc" as "Nrodocumento", "Clnum" as "Numero", "Cliva" as "Situacionfiscal", "Clcuit" as "Cuit", "Clfing" as "Fechaingreso", "Clpiso" as "Piso", "Clfax" as "Fax", "Clfegr" as "Fechaegreso", "Clloc" as "Localidad", "Clconta" as "Contacto", "Cldepto" as "Departamento", "Clcp" as "Codigopostal", "Clprv" as "Provincia", "Ppais" as "Pais" from ZooLogic.CORRE where  funciones.padr( CLCOD, 10, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  CORRE.CLCOD != '' order by CLCOD
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
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Haltafw" as "Horaaltafw", "Hmodifw" as "Horamodificacionfw", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Cltlf" as "Telefono", "Bdaltafw" as "Basededatosaltafw", "Clpun1" as "Comisionventas", "Cimagen" as "Imagen", "Clcod" as "Codigo", "Clobs" as "Observacion", "Cltipodoc" as "Tipodocumento", "Cldir" as "Calle", "Cltlfm" as "Movil", "Clpun2" as "Comisioncobranzas", "Clnom" as "Nombre", "Clfecha" as "Fechanacimiento", "Clemail" as "Email", "Clnrodoc" as "Nrodocumento", "Clnum" as "Numero", "Cliva" as "Situacionfiscal", "Clcuit" as "Cuit", "Clfing" as "Fechaingreso", "Clpiso" as "Piso", "Clfax" as "Fax", "Clfegr" as "Fechaegreso", "Clloc" as "Localidad", "Clconta" as "Contacto", "Cldepto" as "Departamento", "Clcp" as "Codigopostal", "Clprv" as "Provincia", "Ppais" as "Pais" from ZooLogic.CORRE where  funciones.padr( CLCOD, 10, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  CORRE.CLCOD != '' order by CLCOD desc
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
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Haltafw" as "Horaaltafw", "Hmodifw" as "Horamodificacionfw", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Cltlf" as "Telefono", "Bdaltafw" as "Basededatosaltafw", "Clpun1" as "Comisionventas", "Cimagen" as "Imagen", "Clcod" as "Codigo", "Clobs" as "Observacion", "Cltipodoc" as "Tipodocumento", "Cldir" as "Calle", "Cltlfm" as "Movil", "Clpun2" as "Comisioncobranzas", "Clnom" as "Nombre", "Clfecha" as "Fechanacimiento", "Clemail" as "Email", "Clnrodoc" as "Nrodocumento", "Clnum" as "Numero", "Cliva" as "Situacionfiscal", "Clcuit" as "Cuit", "Clfing" as "Fechaingreso", "Clpiso" as "Piso", "Clfax" as "Fax", "Clfegr" as "Fechaegreso", "Clloc" as "Localidad", "Clconta" as "Contacto", "Cldepto" as "Departamento", "Clcp" as "Codigopostal", "Clprv" as "Provincia", "Ppais" as "Pais" from ZooLogic.CORRE where  CORRE.CLCOD != '' order by CLCOD desc
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
			lcXml = this.oConexion.EjecutarSql( "select Fmodifw,Fectrans,Fecimpo,Fecexpo,Faltafw,Haltafw,Hmodifw,Valtafw,Zadsfw,Vmodifw,Umodifw,Smod" + ;
"ifw,Ualtafw,Horaimpo,Saltafw,Esttrans,Horaexpo,Bdmodifw,Cltlf,Bdaltafw,Clpun1,Cimagen,Clcod,Clobs,Cl" + ;
"tipodoc,Cldir,Cltlfm,Clpun2,Clnom,Clfecha,Clemail,Clnrodoc,Clnum,Cliva,Clcuit,Clfing,Clpiso,Clfax,Cl" + ;
"fegr,Clloc,Clconta,Cldepto,Clcp,Clprv,Ppais" + ;
" from ZooLogic.CORRE where  CORRE.CLCOD != '' and " + lcFiltro )
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
			local  lxCorreFmodifw, lxCorreFectrans, lxCorreFecimpo, lxCorreFecexpo, lxCorreFaltafw, lxCorreHaltafw, lxCorreHmodifw, lxCorreValtafw, lxCorreZadsfw, lxCorreVmodifw, lxCorreUmodifw, lxCorreSmodifw, lxCorreUaltafw, lxCorreHoraimpo, lxCorreSaltafw, lxCorreEsttrans, lxCorreHoraexpo, lxCorreBdmodifw, lxCorreCltlf, lxCorreBdaltafw, lxCorreClpun1, lxCorreCimagen, lxCorreClcod, lxCorreClobs, lxCorreCltipodoc, lxCorreCldir, lxCorreCltlfm, lxCorreClpun2, lxCorreClnom, lxCorreClfecha, lxCorreClemail, lxCorreClnrodoc, lxCorreClnum, lxCorreCliva, lxCorreClcuit, lxCorreClfing, lxCorreClpiso, lxCorreClfax, lxCorreClfegr, lxCorreClloc, lxCorreClconta, lxCorreCldepto, lxCorreClcp, lxCorreClprv, lxCorrePpais
				lxCorreFmodifw = ctod( '  /  /    ' )			lxCorreFectrans = ctod( '  /  /    ' )			lxCorreFecimpo = ctod( '  /  /    ' )			lxCorreFecexpo = ctod( '  /  /    ' )			lxCorreFaltafw = ctod( '  /  /    ' )			lxCorreHaltafw = []			lxCorreHmodifw = []			lxCorreValtafw = []			lxCorreZadsfw = []			lxCorreVmodifw = []			lxCorreUmodifw = []			lxCorreSmodifw = []			lxCorreUaltafw = []			lxCorreHoraimpo = []			lxCorreSaltafw = []			lxCorreEsttrans = []			lxCorreHoraexpo = []			lxCorreBdmodifw = []			lxCorreCltlf = []			lxCorreBdaltafw = []			lxCorreClpun1 = 0			lxCorreCimagen = []			lxCorreClcod = []			lxCorreClobs = []			lxCorreCltipodoc = []			lxCorreCldir = []			lxCorreCltlfm = []			lxCorreClpun2 = 0			lxCorreClnom = []			lxCorreClfecha = ctod( '  /  /    ' )			lxCorreClemail = []			lxCorreClnrodoc = []			lxCorreClnum = 0			lxCorreCliva = 0			lxCorreClcuit = []			lxCorreClfing = ctod( '  /  /    ' )			lxCorreClpiso = []			lxCorreClfax = []			lxCorreClfegr = ctod( '  /  /    ' )			lxCorreClloc = []			lxCorreClconta = []			lxCorreCldepto = []			lxCorreClcp = []			lxCorreClprv = []			lxCorrePpais = []
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( [delete from ZooLogic.CORRE where "CLCOD" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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

			.aSqlMemos(lnIndice) = 'delete from ' + lcTabla + ' where CLCOD = ' + txValorClavePrimaria
			.GenerarSentenciasInsertTablaMemo( lcValor, lcTabla, txValorClavePrimaria )
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerSentenciaInsertMemo( tcTabla as String, txValorClavePrimaria as String, tcOrden as String, tcTexto as String ) as String
		return "Insert  into " + tcTabla + "(CLCOD, Orden, texto ) values ( " + txValorClavePrimaria + "," + tcOrden + ",'"+ tcTexto + "')"
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosEntidad( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  CORRE.CLCOD != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Haltafw" as "Horaaltafw", "Hmodifw" as "Horamodificacionfw", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Cltlf" as "Telefono", "Bdaltafw" as "Basededatosaltafw", "Clpun1" as "Comisionventas", "Cimagen" as "Imagen", "Clcod" as "Codigo", "Clobs" as "Observacion", "Cltipodoc" as "Tipodocumento", "Cldir" as "Calle", "Cltlfm" as "Movil", "Clpun2" as "Comisioncobranzas", "Clnom" as "Nombre", "Clfecha" as "Fechanacimiento", "Clemail" as "Email", "Clnrodoc" as "Nrodocumento", "Clnum" as "Numero", "Cliva" as "Situacionfiscal", "Clcuit" as "Cuit", "Clfing" as "Fechaingreso", "Clpiso" as "Piso", "Clfax" as "Fax", "Clfegr" as "Fechaegreso", "Clloc" as "Localidad", "Clconta" as "Contacto", "Cldepto" as "Departamento", "Clcp" as "Codigopostal", "Clprv" as "Provincia", "Ppais" as "Pais"
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
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'FECHATRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRANS AS FECHATRANSFERENCIA'
				Case lcAtributo == 'FECHAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECIMPO AS FECHAIMPO'
				Case lcAtributo == 'FECHAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECEXPO AS FECHAEXPO'
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'TELEFONO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLTLF AS TELEFONO'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'COMISIONVENTAS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLPUN1 AS COMISIONVENTAS'
				Case lcAtributo == 'IMAGEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CIMAGEN AS IMAGEN'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLCOD AS CODIGO'
				Case lcAtributo == 'OBSERVACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLOBS AS OBSERVACION'
				Case lcAtributo == 'TIPODOCUMENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLTIPODOC AS TIPODOCUMENTO'
				Case lcAtributo == 'CALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLDIR AS CALLE'
				Case lcAtributo == 'MOVIL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLTLFM AS MOVIL'
				Case lcAtributo == 'COMISIONCOBRANZAS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLPUN2 AS COMISIONCOBRANZAS'
				Case lcAtributo == 'NOMBRE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLNOM AS NOMBRE'
				Case lcAtributo == 'FECHANACIMIENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLFECHA AS FECHANACIMIENTO'
				Case lcAtributo == 'EMAIL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLEMAIL AS EMAIL'
				Case lcAtributo == 'NRODOCUMENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLNRODOC AS NRODOCUMENTO'
				Case lcAtributo == 'NUMERO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLNUM AS NUMERO'
				Case lcAtributo == 'SITUACIONFISCAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLIVA AS SITUACIONFISCAL'
				Case lcAtributo == 'CUIT'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLCUIT AS CUIT'
				Case lcAtributo == 'FECHAINGRESO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLFING AS FECHAINGRESO'
				Case lcAtributo == 'PISO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLPISO AS PISO'
				Case lcAtributo == 'FAX'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLFAX AS FAX'
				Case lcAtributo == 'FECHAEGRESO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLFEGR AS FECHAEGRESO'
				Case lcAtributo == 'LOCALIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLLOC AS LOCALIDAD'
				Case lcAtributo == 'CONTACTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLCONTA AS CONTACTO'
				Case lcAtributo == 'DEPARTAMENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLDEPTO AS DEPARTAMENTO'
				Case lcAtributo == 'CODIGOPOSTAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLCP AS CODIGOPOSTAL'
				Case lcAtributo == 'PROVINCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLPRV AS PROVINCIA'
				Case lcAtributo == 'PAIS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PPAIS AS PAIS'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoEntidad( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAIMPO'
				lcCampo = 'FECIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEXPO'
				lcCampo = 'FECEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'TELEFONO'
				lcCampo = 'CLTLF'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'COMISIONVENTAS'
				lcCampo = 'CLPUN1'
			Case upper( alltrim( tcAtributo ) ) == 'IMAGEN'
				lcCampo = 'CIMAGEN'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CLCOD'
			Case upper( alltrim( tcAtributo ) ) == 'OBSERVACION'
				lcCampo = 'CLOBS'
			Case upper( alltrim( tcAtributo ) ) == 'TIPODOCUMENTO'
				lcCampo = 'CLTIPODOC'
			Case upper( alltrim( tcAtributo ) ) == 'CALLE'
				lcCampo = 'CLDIR'
			Case upper( alltrim( tcAtributo ) ) == 'MOVIL'
				lcCampo = 'CLTLFM'
			Case upper( alltrim( tcAtributo ) ) == 'COMISIONCOBRANZAS'
				lcCampo = 'CLPUN2'
			Case upper( alltrim( tcAtributo ) ) == 'NOMBRE'
				lcCampo = 'CLNOM'
			Case upper( alltrim( tcAtributo ) ) == 'FECHANACIMIENTO'
				lcCampo = 'CLFECHA'
			Case upper( alltrim( tcAtributo ) ) == 'EMAIL'
				lcCampo = 'CLEMAIL'
			Case upper( alltrim( tcAtributo ) ) == 'NRODOCUMENTO'
				lcCampo = 'CLNRODOC'
			Case upper( alltrim( tcAtributo ) ) == 'NUMERO'
				lcCampo = 'CLNUM'
			Case upper( alltrim( tcAtributo ) ) == 'SITUACIONFISCAL'
				lcCampo = 'CLIVA'
			Case upper( alltrim( tcAtributo ) ) == 'CUIT'
				lcCampo = 'CLCUIT'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAINGRESO'
				lcCampo = 'CLFING'
			Case upper( alltrim( tcAtributo ) ) == 'PISO'
				lcCampo = 'CLPISO'
			Case upper( alltrim( tcAtributo ) ) == 'FAX'
				lcCampo = 'CLFAX'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEGRESO'
				lcCampo = 'CLFEGR'
			Case upper( alltrim( tcAtributo ) ) == 'LOCALIDAD'
				lcCampo = 'CLLOC'
			Case upper( alltrim( tcAtributo ) ) == 'CONTACTO'
				lcCampo = 'CLCONTA'
			Case upper( alltrim( tcAtributo ) ) == 'DEPARTAMENTO'
				lcCampo = 'CLDEPTO'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGOPOSTAL'
				lcCampo = 'CLCP'
			Case upper( alltrim( tcAtributo ) ) == 'PROVINCIA'
				lcCampo = 'CLPRV'
			Case upper( alltrim( tcAtributo ) ) == 'PAIS'
				lcCampo = 'PPAIS'
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
			local  lxCorreFmodifw, lxCorreFectrans, lxCorreFecimpo, lxCorreFecexpo, lxCorreFaltafw, lxCorreHaltafw, lxCorreHmodifw, lxCorreValtafw, lxCorreZadsfw, lxCorreVmodifw, lxCorreUmodifw, lxCorreSmodifw, lxCorreUaltafw, lxCorreHoraimpo, lxCorreSaltafw, lxCorreEsttrans, lxCorreHoraexpo, lxCorreBdmodifw, lxCorreCltlf, lxCorreBdaltafw, lxCorreClpun1, lxCorreCimagen, lxCorreClcod, lxCorreClobs, lxCorreCltipodoc, lxCorreCldir, lxCorreCltlfm, lxCorreClpun2, lxCorreClnom, lxCorreClfecha, lxCorreClemail, lxCorreClnrodoc, lxCorreClnum, lxCorreCliva, lxCorreClcuit, lxCorreClfing, lxCorreClpiso, lxCorreClfax, lxCorreClfegr, lxCorreClloc, lxCorreClconta, lxCorreCldepto, lxCorreClcp, lxCorreClprv, lxCorrePpais
				lxCorreFmodifw =  .Fechamodificacionfw			lxCorreFectrans =  .Fechatransferencia			lxCorreFecimpo =  .Fechaimpo			lxCorreFecexpo =  .Fechaexpo			lxCorreFaltafw =  .Fechaaltafw			lxCorreHaltafw =  .Horaaltafw			lxCorreHmodifw =  .Horamodificacionfw			lxCorreValtafw =  .Versionaltafw			lxCorreZadsfw =  .Zadsfw			lxCorreVmodifw =  .Versionmodificacionfw			lxCorreUmodifw =  .Usuariomodificacionfw			lxCorreSmodifw =  .Seriemodificacionfw			lxCorreUaltafw =  .Usuarioaltafw			lxCorreHoraimpo =  .Horaimpo			lxCorreSaltafw =  .Seriealtafw			lxCorreEsttrans =  .Estadotransferencia			lxCorreHoraexpo =  .Horaexpo			lxCorreBdmodifw =  .Basededatosmodificacionfw			lxCorreCltlf =  .Telefono			lxCorreBdaltafw =  .Basededatosaltafw			lxCorreClpun1 =  .Comisionventas			lxCorreCimagen =  .Imagen			lxCorreClcod =  .Codigo			lxCorreClobs =  .Observacion			lxCorreCltipodoc =  .Tipodocumento			lxCorreCldir =  .Calle			lxCorreCltlfm =  .Movil			lxCorreClpun2 =  .Comisioncobranzas			lxCorreClnom =  .Nombre			lxCorreClfecha =  .Fechanacimiento			lxCorreClemail =  .Email			lxCorreClnrodoc =  .Nrodocumento			lxCorreClnum =  .Numero			lxCorreCliva =  .Situacionfiscal_PK 			lxCorreClcuit =  .Cuit			lxCorreClfing =  .Fechaingreso			lxCorreClpiso =  .Piso			lxCorreClfax =  .Fax			lxCorreClfegr =  .Fechaegreso			lxCorreClloc =  .Localidad			lxCorreClconta =  .Contacto			lxCorreCldepto =  .Departamento			lxCorreClcp =  .Codigopostal			lxCorreClprv =  upper( .Provincia_PK ) 			lxCorrePpais =  upper( .Pais_PK ) 
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.CORRE ( "Fmodifw","Fectrans","Fecimpo","Fecexpo","Faltafw","Haltafw","Hmodifw","Valtafw","Zadsfw","Vmodifw","Umodifw","Smodifw","Ualtafw","Horaimpo","Saltafw","Esttrans","Horaexpo","Bdmodifw","Cltlf","Bdaltafw","Clpun1","Cimagen","Clcod","Clobs","Cltipodoc","Cldir","Cltlfm","Clpun2","Clnom","Clfecha","Clemail","Clnrodoc","Clnum","Cliva","Clcuit","Clfing","Clpiso","Clfax","Clfegr","Clloc","Clconta","Cldepto","Clcp","Clprv","Ppais" ) values ( <<"'" + this.ConvertirDateSql( lxCorreFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCorreFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCorreFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCorreFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCorreFaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCorreHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCorreHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCorreValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCorreZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCorreVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCorreUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCorreSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCorreUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCorreHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCorreSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCorreEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCorreHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCorreBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCorreCltlf ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCorreBdaltafw ) + "'" >>, <<lxCorreClpun1 >>, <<"'" + this.FormatearTextoSql( lxCorreCimagen ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCorreClcod ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCorreClobs ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCorreCltipodoc ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCorreCldir ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCorreCltlfm ) + "'" >>, <<lxCorreClpun2 >>, <<"'" + this.FormatearTextoSql( lxCorreClnom ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCorreClfecha ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCorreClemail ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCorreClnrodoc ) + "'" >>, <<lxCorreClnum >>, <<lxCorreCliva >>, <<"'" + this.FormatearTextoSql( lxCorreClcuit ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCorreClfing ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCorreClpiso ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCorreClfax ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCorreClfegr ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCorreClloc ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCorreClconta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCorreCldepto ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCorreClcp ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCorreClprv ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCorrePpais ) + "'" >> )
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
			local  lxCorreFmodifw, lxCorreFectrans, lxCorreFecimpo, lxCorreFecexpo, lxCorreFaltafw, lxCorreHaltafw, lxCorreHmodifw, lxCorreValtafw, lxCorreZadsfw, lxCorreVmodifw, lxCorreUmodifw, lxCorreSmodifw, lxCorreUaltafw, lxCorreHoraimpo, lxCorreSaltafw, lxCorreEsttrans, lxCorreHoraexpo, lxCorreBdmodifw, lxCorreCltlf, lxCorreBdaltafw, lxCorreClpun1, lxCorreCimagen, lxCorreClcod, lxCorreClobs, lxCorreCltipodoc, lxCorreCldir, lxCorreCltlfm, lxCorreClpun2, lxCorreClnom, lxCorreClfecha, lxCorreClemail, lxCorreClnrodoc, lxCorreClnum, lxCorreCliva, lxCorreClcuit, lxCorreClfing, lxCorreClpiso, lxCorreClfax, lxCorreClfegr, lxCorreClloc, lxCorreClconta, lxCorreCldepto, lxCorreClcp, lxCorreClprv, lxCorrePpais
				lxCorreFmodifw =  .Fechamodificacionfw			lxCorreFectrans =  .Fechatransferencia			lxCorreFecimpo =  .Fechaimpo			lxCorreFecexpo =  .Fechaexpo			lxCorreFaltafw =  .Fechaaltafw			lxCorreHaltafw =  .Horaaltafw			lxCorreHmodifw =  .Horamodificacionfw			lxCorreValtafw =  .Versionaltafw			lxCorreZadsfw =  .Zadsfw			lxCorreVmodifw =  .Versionmodificacionfw			lxCorreUmodifw =  .Usuariomodificacionfw			lxCorreSmodifw =  .Seriemodificacionfw			lxCorreUaltafw =  .Usuarioaltafw			lxCorreHoraimpo =  .Horaimpo			lxCorreSaltafw =  .Seriealtafw			lxCorreEsttrans =  .Estadotransferencia			lxCorreHoraexpo =  .Horaexpo			lxCorreBdmodifw =  .Basededatosmodificacionfw			lxCorreCltlf =  .Telefono			lxCorreBdaltafw =  .Basededatosaltafw			lxCorreClpun1 =  .Comisionventas			lxCorreCimagen =  .Imagen			lxCorreClcod =  .Codigo			lxCorreClobs =  .Observacion			lxCorreCltipodoc =  .Tipodocumento			lxCorreCldir =  .Calle			lxCorreCltlfm =  .Movil			lxCorreClpun2 =  .Comisioncobranzas			lxCorreClnom =  .Nombre			lxCorreClfecha =  .Fechanacimiento			lxCorreClemail =  .Email			lxCorreClnrodoc =  .Nrodocumento			lxCorreClnum =  .Numero			lxCorreCliva =  .Situacionfiscal_PK 			lxCorreClcuit =  .Cuit			lxCorreClfing =  .Fechaingreso			lxCorreClpiso =  .Piso			lxCorreClfax =  .Fax			lxCorreClfegr =  .Fechaegreso			lxCorreClloc =  .Localidad			lxCorreClconta =  .Contacto			lxCorreCldepto =  .Departamento			lxCorreClcp =  .Codigopostal			lxCorreClprv =  upper( .Provincia_PK ) 			lxCorrePpais =  upper( .Pais_PK ) 
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Clcod" = ] + lcValorClavePrimariaString  + [ and  CORRE.CLCOD != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.CORRE set "Fmodifw" = <<"'" + this.ConvertirDateSql( lxCorreFmodifw ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxCorreFectrans ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxCorreFecimpo ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxCorreFecexpo ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxCorreFaltafw ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxCorreHaltafw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxCorreHmodifw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxCorreValtafw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxCorreZadsfw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxCorreVmodifw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxCorreUmodifw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxCorreSmodifw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxCorreUaltafw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxCorreHoraimpo ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxCorreSaltafw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxCorreEsttrans ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxCorreHoraexpo ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxCorreBdmodifw ) + "'">>, "Cltlf" = <<"'" + this.FormatearTextoSql( lxCorreCltlf ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxCorreBdaltafw ) + "'">>, "Clpun1" = <<lxCorreClpun1>>, "Cimagen" = <<"'" + this.FormatearTextoSql( lxCorreCimagen ) + "'">>, "Clcod" = <<"'" + this.FormatearTextoSql( lxCorreClcod ) + "'">>, "Clobs" = <<"'" + this.FormatearTextoSql( lxCorreClobs ) + "'">>, "Cltipodoc" = <<"'" + this.FormatearTextoSql( lxCorreCltipodoc ) + "'">>, "Cldir" = <<"'" + this.FormatearTextoSql( lxCorreCldir ) + "'">>, "Cltlfm" = <<"'" + this.FormatearTextoSql( lxCorreCltlfm ) + "'">>, "Clpun2" = <<lxCorreClpun2>>, "Clnom" = <<"'" + this.FormatearTextoSql( lxCorreClnom ) + "'">>, "Clfecha" = <<"'" + this.ConvertirDateSql( lxCorreClfecha ) + "'">>, "Clemail" = <<"'" + this.FormatearTextoSql( lxCorreClemail ) + "'">>, "Clnrodoc" = <<"'" + this.FormatearTextoSql( lxCorreClnrodoc ) + "'">>, "Clnum" = <<lxCorreClnum>>, "Cliva" = <<lxCorreCliva>>, "Clcuit" = <<"'" + this.FormatearTextoSql( lxCorreClcuit ) + "'">>, "Clfing" = <<"'" + this.ConvertirDateSql( lxCorreClfing ) + "'">>, "Clpiso" = <<"'" + this.FormatearTextoSql( lxCorreClpiso ) + "'">>, "Clfax" = <<"'" + this.FormatearTextoSql( lxCorreClfax ) + "'">>, "Clfegr" = <<"'" + this.ConvertirDateSql( lxCorreClfegr ) + "'">>, "Clloc" = <<"'" + this.FormatearTextoSql( lxCorreClloc ) + "'">>, "Clconta" = <<"'" + this.FormatearTextoSql( lxCorreClconta ) + "'">>, "Cldepto" = <<"'" + this.FormatearTextoSql( lxCorreCldepto ) + "'">>, "Clcp" = <<"'" + this.FormatearTextoSql( lxCorreClcp ) + "'">>, "Clprv" = <<"'" + this.FormatearTextoSql( lxCorreClprv ) + "'">>, "Ppais" = <<"'" + this.FormatearTextoSql( lxCorrePpais ) + "'">> where << lcFiltro >>
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

			lcFiltro = ["Clcod" = ] + lcValorClavePrimariaString  + [ and  CORRE.CLCOD != '']
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.CORRE where  CORRE.CLCOD != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.CORRE where CLCOD = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  CORRE.CLCOD != ''" )
			this.xmlacursor( lcXml, lcCursor )
		if reccount( lcCursor ) > 0
			lnTimeStamp = &lcCursor..Timestamp
		endif
		use in select( lcCursor )

		return lnTimeStamp 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirCabecera( tlLoguear as Boolean ) As Void
		local lcCursor as String, ldFecha as Date, lcHora as string, lcValorABuscar As String, lxValorClavePK As variant, lxValorClavePrimaria As variant, lcIdentificadorParaLoguear as string, lxCORRECLIVA as variant, lxCORRECLCUIT as variant, lxCORRECLCONTA as variant, lcMensajeExtra as String
		lcValorABuscar = ''
		lxValorClavePK = ''
		lcMensajeExtra = ''
		lcCursor = This.oEntidad.cPrefijoRecibir + 'CORREDOR'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.CORRE Where CLCOD = ] + "'" + this.FormatearTextoSql( &lcCursor..CLCOD ) + "'", 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					this.oConexion.EjecutarSql( [UPDATE ZooLogic.CORRE set  FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, CLTLF = ] + "'" + this.FormatearTextoSql( &lcCursor..CLTLF ) + "'"+ [, CLPUN1 = ] + transform( &lcCursor..CLPUN1 )+ [, CIMAGEN = ] + "'" + this.FormatearTextoSql( &lcCursor..CIMAGEN ) + "'"+ [, CLCOD = ] + "'" + this.FormatearTextoSql( &lcCursor..CLCOD ) + "'"+ [, CLOBS = ] + "'" + this.FormatearTextoSql( &lcCursor..CLOBS ) + "'"+ [, CLTIPODOC = ] + "'" + this.FormatearTextoSql( &lcCursor..CLTIPODOC ) + "'"+ [, CLDIR = ] + "'" + this.FormatearTextoSql( &lcCursor..CLDIR ) + "'"+ [, CLTLFM = ] + "'" + this.FormatearTextoSql( &lcCursor..CLTLFM ) + "'"+ [, CLPUN2 = ] + transform( &lcCursor..CLPUN2 )+ [, CLNOM = ] + "'" + this.FormatearTextoSql( &lcCursor..CLNOM ) + "'"+ [, CLFECHA = ] + "'" + this.ConvertirDateSql( &lcCursor..CLFECHA ) + "'"+ [, CLEMAIL = ] + "'" + this.FormatearTextoSql( &lcCursor..CLEMAIL ) + "'"+ [, CLNRODOC = ] + "'" + this.FormatearTextoSql( &lcCursor..CLNRODOC ) + "'"+ [, CLNUM = ] + transform( &lcCursor..CLNUM )+ [, CLIVA = ] + transform( &lcCursor..CLIVA )+ [, CLCUIT = ] + "'" + this.FormatearTextoSql( &lcCursor..CLCUIT ) + "'"+ [, CLFING = ] + "'" + this.ConvertirDateSql( &lcCursor..CLFING ) + "'"+ [, CLPISO = ] + "'" + this.FormatearTextoSql( &lcCursor..CLPISO ) + "'"+ [, CLFAX = ] + "'" + this.FormatearTextoSql( &lcCursor..CLFAX ) + "'"+ [, CLFEGR = ] + "'" + this.ConvertirDateSql( &lcCursor..CLFEGR ) + "'"+ [, CLLOC = ] + "'" + this.FormatearTextoSql( &lcCursor..CLLOC ) + "'"+ [, CLCONTA = ] + "'" + this.FormatearTextoSql( &lcCursor..CLCONTA ) + "'"+ [, CLDEPTO = ] + "'" + this.FormatearTextoSql( &lcCursor..CLDEPTO ) + "'"+ [, CLCP = ] + "'" + this.FormatearTextoSql( &lcCursor..CLCP ) + "'"+ [, CLPRV = ] + "'" + this.FormatearTextoSql( &lcCursor..CLPRV ) + "'"+ [, PPAIS = ] + "'" + this.FormatearTextoSql( &lcCursor..PPAIS ) + "'" + [ Where CLCOD = ] + "'" + this.FormatearTextoSql( &lcCursor..CLCOD ) + "'" )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
				endIf
			else
				Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
				Text to lcCampos noShow
					 FMODIFW, FECTRANS, FECIMPO, FECEXPO, FALTAFW, HALTAFW, HMODIFW, VALTAFW, ZADSFW, VMODIFW, UMODIFW, SMODIFW, UALTAFW, HORAIMPO, SALTAFW, ESTTRANS, HORAEXPO, BDMODIFW, CLTLF, BDALTAFW, CLPUN1, CIMAGEN, CLCOD, CLOBS, CLTIPODOC, CLDIR, CLTLFM, CLPUN2, CLNOM, CLFECHA, CLEMAIL, CLNRODOC, CLNUM, CLIVA, CLCUIT, CLFING, CLPISO, CLFAX, CLFEGR, CLLOC, CLCONTA, CLDEPTO, CLCP, CLPRV, PPAIS
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLTLF ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + transform( &lcCursor..CLPUN1 )
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..CIMAGEN ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLCOD ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLOBS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLTIPODOC ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLDIR ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLTLFM ) + "'" + ',' + transform( &lcCursor..CLPUN2 )
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLNOM ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..CLFECHA ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLEMAIL ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLNRODOC ) + "'" + ',' + transform( &lcCursor..CLNUM ) + ',' + transform( &lcCursor..CLIVA ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLCUIT ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..CLFING ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLPISO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLFAX ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..CLFEGR ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLLOC ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLCONTA ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLDEPTO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLCP ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLPRV ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..PPAIS ) + "'"
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
		create cursor &tcCursorACrear ( CLCOD C (10) , Orden N(16), texto C(80))
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirComponentes() As Void
		
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function ObtenerIdentificadorParaLoguear( tcCursor as String ) As String
		local lcRetorno as String, lnCC as String , loCC as Object, lni as Integer, lcSecuencia as String
		lcRetorno = this.oEntidad.cDescripcion 
		lcRetorno = lcRetorno + ' - Código: ' + transform( &tcCursor..CLCOD      )
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
			Case  lcAlias == lcPrefijo + 'CORREDOR_CLOBS'
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
		lxVar = &lcCursor..CLCOD
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
		select max( _Rec ) as Maximo,CLCOD as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( CLCOD, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
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
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  CLFECHA   
		* Validar ANTERIORES A 1/1/1753  CLFING    
		* Validar ANTERIORES A 1/1/1753  CLFEGR    
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_CORRE') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_CORRE
Create Table ZooLogic.TablaTrabajo_CORRE ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fmodifw" datetime  null, 
"fectrans" datetime  null, 
"fecimpo" datetime  null, 
"fecexpo" datetime  null, 
"faltafw" datetime  null, 
"haltafw" char( 8 )  null, 
"hmodifw" char( 8 )  null, 
"valtafw" char( 13 )  null, 
"zadsfw" varchar(max)  null, 
"vmodifw" char( 13 )  null, 
"umodifw" char( 100 )  null, 
"smodifw" char( 7 )  null, 
"ualtafw" char( 100 )  null, 
"horaimpo" char( 8 )  null, 
"saltafw" char( 7 )  null, 
"esttrans" char( 20 )  null, 
"horaexpo" char( 8 )  null, 
"bdmodifw" char( 8 )  null, 
"cltlf" char( 30 )  null, 
"bdaltafw" char( 8 )  null, 
"clpun1" numeric( 15, 2 )  null, 
"cimagen" char( 180 )  null, 
"clcod" char( 10 )  null, 
"clobs" varchar(max)  null, 
"cltipodoc" char( 2 )  null, 
"cldir" char( 70 )  null, 
"cltlfm" char( 30 )  null, 
"clpun2" numeric( 15, 2 )  null, 
"clnom" char( 60 )  null, 
"clfecha" datetime  null, 
"clemail" char( 250 )  null, 
"clnrodoc" char( 10 )  null, 
"clnum" numeric( 5, 0 )  null, 
"cliva" numeric( 2, 0 )  null, 
"clcuit" char( 15 )  null, 
"clfing" datetime  null, 
"clpiso" char( 3 )  null, 
"clfax" char( 20 )  null, 
"clfegr" datetime  null, 
"clloc" char( 70 )  null, 
"clconta" char( 10 )  null, 
"cldepto" char( 3 )  null, 
"clcp" char( 8 )  null, 
"clprv" char( 2 )  null, 
"ppais" char( 3 )  null )
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
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('cltlf','cltlf')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('clpun1','clpun1')
			.AgregarMapeo('cimagen','cimagen')
			.AgregarMapeo('clcod','clcod')
			.AgregarMapeo('clobs','clobs')
			.AgregarMapeo('cltipodoc','cltipodoc')
			.AgregarMapeo('cldir','cldir')
			.AgregarMapeo('cltlfm','cltlfm')
			.AgregarMapeo('clpun2','clpun2')
			.AgregarMapeo('clnom','clnom')
			.AgregarMapeo('clfecha','clfecha')
			.AgregarMapeo('clemail','clemail')
			.AgregarMapeo('clnrodoc','clnrodoc')
			.AgregarMapeo('clnum','clnum')
			.AgregarMapeo('cliva','cliva')
			.AgregarMapeo('clcuit','clcuit')
			.AgregarMapeo('clfing','clfing')
			.AgregarMapeo('clpiso','clpiso')
			.AgregarMapeo('clfax','clfax')
			.AgregarMapeo('clfegr','clfegr')
			.AgregarMapeo('clloc','clloc')
			.AgregarMapeo('clconta','clconta')
			.AgregarMapeo('cldepto','cldepto')
			.AgregarMapeo('clcp','clcp')
			.AgregarMapeo('clprv','clprv')
			.AgregarMapeo('ppais','ppais')
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
				Update t Set t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.CLTLF = isnull( d.CLTLF, t.CLTLF ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.CLPUN1 = isnull( d.CLPUN1, t.CLPUN1 ),t.CIMAGEN = isnull( d.CIMAGEN, t.CIMAGEN ),t.CLCOD = isnull( d.CLCOD, t.CLCOD ),t.CLOBS = isnull( d.CLOBS, t.CLOBS ),t.CLTIPODOC = isnull( d.CLTIPODOC, t.CLTIPODOC ),t.CLDIR = isnull( d.CLDIR, t.CLDIR ),t.CLTLFM = isnull( d.CLTLFM, t.CLTLFM ),t.CLPUN2 = isnull( d.CLPUN2, t.CLPUN2 ),t.CLNOM = isnull( d.CLNOM, t.CLNOM ),t.CLFECHA = isnull( d.CLFECHA, t.CLFECHA ),t.CLEMAIL = isnull( d.CLEMAIL, t.CLEMAIL ),t.CLNRODOC = isnull( d.CLNRODOC, t.CLNRODOC ),t.CLNUM = isnull( d.CLNUM, t.CLNUM ),t.CLIVA = isnull( d.CLIVA, t.CLIVA ),t.CLCUIT = isnull( d.CLCUIT, t.CLCUIT ),t.CLFING = isnull( d.CLFING, t.CLFING ),t.CLPISO = isnull( d.CLPISO, t.CLPISO ),t.CLFAX = isnull( d.CLFAX, t.CLFAX ),t.CLFEGR = isnull( d.CLFEGR, t.CLFEGR ),t.CLLOC = isnull( d.CLLOC, t.CLLOC ),t.CLCONTA = isnull( d.CLCONTA, t.CLCONTA ),t.CLDEPTO = isnull( d.CLDEPTO, t.CLDEPTO ),t.CLCP = isnull( d.CLCP, t.CLCP ),t.CLPRV = isnull( d.CLPRV, t.CLPRV ),t.PPAIS = isnull( d.PPAIS, t.PPAIS )
					from ZooLogic.CORRE t inner join deleted d 
							 on t.CLCOD = d.CLCOD
				-- Fin Updates
				insert into ZooLogic.CORRE(Fmodifw,Fectrans,Fecimpo,Fecexpo,Faltafw,Haltafw,Hmodifw,Valtafw,Zadsfw,Vmodifw,Umodifw,Smodifw,Ualtafw,Horaimpo,Saltafw,Esttrans,Horaexpo,Bdmodifw,Cltlf,Bdaltafw,Clpun1,Cimagen,Clcod,Clobs,Cltipodoc,Cldir,Cltlfm,Clpun2,Clnom,Clfecha,Clemail,Clnrodoc,Clnum,Cliva,Clcuit,Clfing,Clpiso,Clfax,Clfegr,Clloc,Clconta,Cldepto,Clcp,Clprv,Ppais)
					Select isnull( d.FMODIFW,''),isnull( d.FECTRANS,''),isnull( d.FECIMPO,''),isnull( d.FECEXPO,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),convert( char(8), getdate(), 108 ),isnull( d.HMODIFW,''),isnull( d.VALTAFW,''),isnull( d.ZADSFW,''),isnull( d.VMODIFW,''),isnull( d.UMODIFW,''),isnull( d.SMODIFW,''),isnull( d.UALTAFW,''),isnull( d.HORAIMPO,''),isnull( d.SALTAFW,''),isnull( d.ESTTRANS,''),isnull( d.HORAEXPO,''),isnull( d.BDMODIFW,''),isnull( d.CLTLF,''),isnull( d.BDALTAFW,''),isnull( d.CLPUN1,0),isnull( d.CIMAGEN,''),isnull( d.CLCOD,''),isnull( d.CLOBS,''),isnull( d.CLTIPODOC,''),isnull( d.CLDIR,''),isnull( d.CLTLFM,''),isnull( d.CLPUN2,0),isnull( d.CLNOM,''),isnull( d.CLFECHA,''),isnull( d.CLEMAIL,''),isnull( d.CLNRODOC,''),isnull( d.CLNUM,0),isnull( d.CLIVA,0),isnull( d.CLCUIT,''),isnull( d.CLFING,''),isnull( d.CLPISO,''),isnull( d.CLFAX,''),isnull( d.CLFEGR,''),isnull( d.CLLOC,''),isnull( d.CLCONTA,''),isnull( d.CLDEPTO,''),isnull( d.CLCP,''),isnull( d.CLPRV,''),isnull( d.PPAIS,'')
						From deleted d left join ZooLogic.CORRE pk 
							 on d.CLCOD = pk.CLCOD
						Where pk.CLCOD Is Null 
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
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_CORREDOR.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_CORREDOR.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_CORREDOR.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_CORREDOR.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_CORREDOR.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Horaaltafw = nvl( c_CORREDOR.Horaaltafw, [] )
					.Horamodificacionfw = nvl( c_CORREDOR.Horamodificacionfw, [] )
					.Versionaltafw = nvl( c_CORREDOR.Versionaltafw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Versionmodificacionfw = nvl( c_CORREDOR.Versionmodificacionfw, [] )
					.Usuariomodificacionfw = nvl( c_CORREDOR.Usuariomodificacionfw, [] )
					.Seriemodificacionfw = nvl( c_CORREDOR.Seriemodificacionfw, [] )
					.Usuarioaltafw = nvl( c_CORREDOR.Usuarioaltafw, [] )
					.Horaimpo = nvl( c_CORREDOR.Horaimpo, [] )
					.Seriealtafw = nvl( c_CORREDOR.Seriealtafw, [] )
					.Estadotransferencia = nvl( c_CORREDOR.Estadotransferencia, [] )
					.Horaexpo = nvl( c_CORREDOR.Horaexpo, [] )
					.Basededatosmodificacionfw = nvl( c_CORREDOR.Basededatosmodificacionfw, [] )
					.Telefono = nvl( c_CORREDOR.Telefono, [] )
					.Basededatosaltafw = nvl( c_CORREDOR.Basededatosaltafw, [] )
					.Comisionventas = nvl( c_CORREDOR.Comisionventas, 0 )
					.Imagen = nvl( c_CORREDOR.Imagen, [] )
					.Codigo = nvl( c_CORREDOR.Codigo, [] )
					lcValor = This.ObtenerMemo( 'c_Observacion')
					.Observacion = lcValor 
					.Tipodocumento = nvl( c_CORREDOR.Tipodocumento, [] )
					.Calle = nvl( c_CORREDOR.Calle, [] )
					.Movil = nvl( c_CORREDOR.Movil, [] )
					.Comisioncobranzas = nvl( c_CORREDOR.Comisioncobranzas, 0 )
					.Nombre = nvl( c_CORREDOR.Nombre, [] )
					.Fechanacimiento = GoLibrerias.ObtenerFechaFormateada( nvl( c_CORREDOR.Fechanacimiento, ctod( '  /  /    ' ) ) )
					.Email = nvl( c_CORREDOR.Email, [] )
					.Nrodocumento = nvl( c_CORREDOR.Nrodocumento, [] )
					.Numero = nvl( c_CORREDOR.Numero, 0 )
					.Situacionfiscal_PK =  nvl( c_CORREDOR.Situacionfiscal, 0 )
					.Cuit = nvl( c_CORREDOR.Cuit, [] )
					.Fechaingreso = GoLibrerias.ObtenerFechaFormateada( nvl( c_CORREDOR.Fechaingreso, ctod( '  /  /    ' ) ) )
					.Piso = nvl( c_CORREDOR.Piso, [] )
					.Fax = nvl( c_CORREDOR.Fax, [] )
					.Fechaegreso = GoLibrerias.ObtenerFechaFormateada( nvl( c_CORREDOR.Fechaegreso, ctod( '  /  /    ' ) ) )
					.Localidad = nvl( c_CORREDOR.Localidad, [] )
					.Contacto = nvl( c_CORREDOR.Contacto, [] )
					.Departamento = nvl( c_CORREDOR.Departamento, [] )
					.Codigopostal = nvl( c_CORREDOR.Codigopostal, [] )
					.Provincia_PK =  nvl( c_CORREDOR.Provincia, [] )
					.Pais_PK =  nvl( c_CORREDOR.Pais, [] )
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
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "CLCOD"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
		text to lcSQL textmerge noshow
				SELECT nro,totalRegistros,CLCOD as Id
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    CLCOD from (
							select * 
								from ZooLogic.CORRE 
								Where   CORRE.CLCOD != ''
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
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "CLCOD"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
			text to lcAtributos textmerge noshow
			"Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Haltafw" as "Horaaltafw", "Hmodifw" as "Horamodificacionfw", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Cltlf" as "Telefono", "Bdaltafw" as "Basededatosaltafw", "Clpun1" as "Comisionventas", "Cimagen" as "Imagen", "Clcod" as "Codigo", "Clobs" as "Observacion", "Cltipodoc" as "Tipodocumento", "Cldir" as "Calle", "Cltlfm" as "Movil", "Clpun2" as "Comisioncobranzas", "Clnom" as "Nombre", "Clfecha" as "Fechanacimiento", "Clemail" as "Email", "Clnrodoc" as "Nrodocumento", "Clnum" as "Numero", "Cliva" as "Situacionfiscal", "Clcuit" as "Cuit", "Clfing" as "Fechaingreso", "Clpiso" as "Piso", "Clfax" as "Fax", "Clfegr" as "Fechaegreso", "Clloc" as "Localidad", "Clconta" as "Contacto", "Cldepto" as "Departamento", "Clcp" as "Codigopostal", "Clprv" as "Provincia", "Ppais" as "Pais"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.CORRE 
								Where   CORRE.CLCOD != ''
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
	Filtro = " CORRE.CLCOD != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " CORRE.CLCOD != ''"
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
	<row entidad="CORREDOR                                " atributo="FECHADEALTA                             " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CORREDOR                                " atributo="FECHAMODIFICACIONFW                     " tabla="CORRE          " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CORREDOR                                " atributo="FECHATRANSFERENCIA                      " tabla="CORRE          " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha de novedad                                                                                                                                                " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CORREDOR                                " atributo="FECHAULTIMAMODIFICACION                 " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CORREDOR                                " atributo="FECHAIMPO                               " tabla="CORRE          " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CORREDOR                                " atributo="FECHAEXPO                               " tabla="CORRE          " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CORREDOR                                " atributo="FECHAALTAFW                             " tabla="CORRE          " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CORREDOR                                " atributo="HORAALTAFW                              " tabla="CORRE          " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CORREDOR                                " atributo="HORAMODIFICACIONFW                      " tabla="CORRE          " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CORREDOR                                " atributo="VERSIONALTAFW                           " tabla="CORRE          " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CORREDOR                                " atributo="ZADSFW                                  " tabla="CORRE          " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CORREDOR                                " atributo="VERSIONMODIFICACIONFW                   " tabla="CORRE          " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CORREDOR                                " atributo="USUARIOMODIFICACIONFW                   " tabla="CORRE          " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CORREDOR                                " atributo="SERIEMODIFICACIONFW                     " tabla="CORRE          " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CORREDOR                                " atributo="USUARIOALTAFW                           " tabla="CORRE          " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CORREDOR                                " atributo="HORAIMPO                                " tabla="CORRE          " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CORREDOR                                " atributo="SERIEALTAFW                             " tabla="CORRE          " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CORREDOR                                " atributo="ESTADOTRANSFERENCIA                     " tabla="CORRE          " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado de novedad                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CORREDOR                                " atributo="HORAEXPO                                " tabla="CORRE          " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CORREDOR                                " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="CORRE          " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CORREDOR                                " atributo="TELEFONO                                " tabla="CORRE          " campo="CLTLF     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="20" etiqueta="Teléfono                                                                                                                                                        " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CORREDOR                                " atributo="BASEDEDATOSALTAFW                       " tabla="CORRE          " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CORREDOR                                " atributo="COMISIONVENTAS                          " tabla="CORRE          " campo="CLPUN1    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="% En detalle                                                                                                                                                    " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="4" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CORREDOR                                " atributo="IMAGEN                                  " tabla="CORRE          " campo="CIMAGEN   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="180" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="28" etiqueta="Archivo                                                                                                                                                         " dominio="IMAGENCONRUTADINAMICA         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CORREDOR                                " atributo="CODIGO                                  " tabla="CORRE          " campo="CLCOD     " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="2" etiqueta="Código                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CORREDOR                                " atributo="OBSERVACION                             " tabla="CORRE          " campo="CLOBS     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="Observaciones                                                                                                                                                   " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CORREDOR                                " atributo="TIPODOCUMENTO                           " tabla="CORRE          " campo="CLTIPODOC " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="402" etiqueta="Tipo documento                                                                                                                                                  " dominio="DOCUMENTO                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="3" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CORREDOR                                " atributo="CALLE                                   " tabla="CORRE          " campo="CLDIR     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="70" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="6" etiqueta="Calle                                                                                                                                                           " dominio="DIRECCION                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CORREDOR                                " atributo="MOVIL                                   " tabla="CORRE          " campo="CLTLFM    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="22" etiqueta="Teléfono móvil                                                                                                                                                  " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CORREDOR                                " atributo="COMISIONCOBRANZAS                       " tabla="CORRE          " campo="CLPUN2    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="% En totales                                                                                                                                                    " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="4" orden="1" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CORREDOR                                " atributo="NOMBRE                                  " tabla="CORRE          " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="4" etiqueta="Nombre                                                                                                                                                          " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CORREDOR                                " atributo="FECHANACIMIENTO                         " tabla="CORRE          " campo="CLFECHA   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="30" etiqueta="Fecha de nacimiento                                                                                                                                             " dominio="FECHALARGACALENDARIO          " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CORREDOR                                " atributo="EMAIL                                   " tabla="CORRE          " campo="CLEMAIL   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="250" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="24" etiqueta="Email                                                                                                                                                           " dominio="MAIL                          " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CORREDOR                                " atributo="NRODOCUMENTO                            " tabla="CORRE          " campo="CLNRODOC  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="32" etiqueta="Número documento                                                                                                                                                " dominio="DOCUMENTO                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="3" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CORREDOR                                " atributo="NUMERO                                  " tabla="CORRE          " campo="CLNUM     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="8" etiqueta="Número                                                                                                                                                          " dominio="DIRECCION                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="99999                    " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CORREDOR                                " atributo="SITUACIONFISCAL                         " tabla="CORRE          " campo="CLIVA     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="SITUACIONFISCAL                         " tipodato="N         " longitud="2" decimales="0" valorsugerido="3                                                                                                                                                                                                                                                             " obligatorio="false" admitebusqueda="404" etiqueta="Situación fiscal                                                                                                                                                " dominio="COMBOTABLA                    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="4" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CORREDOR                                " atributo="CUIT                                    " tabla="CORRE          " campo="CLCUIT    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="16" etiqueta="CUIT                                                                                                                                                            " dominio="CUIT                          " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="99-99999999-9            " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="4" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CORREDOR                                " atributo="FECHAINGRESO                            " tabla="CORRE          " campo="CLFING    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="34" etiqueta="Fecha de ingreso                                                                                                                                                " dominio="FECHACALENDARIO               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="3" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CORREDOR                                " atributo="PISO                                    " tabla="CORRE          " campo="CLPISO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="3" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="10" etiqueta="Piso                                                                                                                                                            " dominio="DIRECCION                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CORREDOR                                " atributo="FAX                                     " tabla="CORRE          " campo="CLFAX     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="26" etiqueta="Fax                                                                                                                                                             " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CORREDOR                                " atributo="FECHAEGRESO                             " tabla="CORRE          " campo="CLFEGR    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="36" etiqueta="Fecha de egreso                                                                                                                                                 " dominio="FECHACALENDARIO               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="3" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CORREDOR                                " atributo="LOCALIDAD                               " tabla="CORRE          " campo="CLLOC     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="70" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="406" etiqueta="Localidad                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CORREDOR                                " atributo="CONTACTO                                " tabla="CORRE          " campo="CLCONTA   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="26" etiqueta="Contacto                                                                                                                                                        " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CORREDOR                                " atributo="DEPARTAMENTO                            " tabla="CORRE          " campo="CLDEPTO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="3" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="12" etiqueta="Departamento                                                                                                                                                    " dominio="DIRECCION                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CORREDOR                                " atributo="CODIGOPOSTAL                            " tabla="CORRE          " campo="CLCP      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="14" etiqueta="Código postal                                                                                                                                                   " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CORREDOR                                " atributo="PROVINCIA                               " tabla="CORRE          " campo="CLPRV     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="PROVINCIA                               " tipodato="C         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="16" etiqueta="Provincia                                                                                                                                                       " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CORREDOR                                " atributo="PAIS                                    " tabla="CORRE          " campo="PPAIS     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="PAISES                                  " tipodato="C         " longitud="3" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="18" etiqueta="País                                                                                                                                                            " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="8" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SITUACIONFISCAL                         " atributo="DESCRIPCION                             " tabla="SITFISCAL      " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="405" etiqueta="Detalle Sit.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join SITFISCAL On CORRE.CLIVA = SITFISCAL.Codigo And  SITFISCAL.CODIGO != 0                                                                                                                                                                             " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVINCIA                               " atributo="DESCRIPCION                             " tabla="PROVINCI       " campo="PRV_DES   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="17" etiqueta="Detalle Pro.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join PROVINCI On CORRE.CLPRV = PROVINCI.PRV_COD And  PROVINCI.PRV_COD != ''                                                                                                                                                                             " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PAISES                                  " atributo="DESCRIPCION                             " tabla="PAISES         " campo="PDES      " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="19" etiqueta="Detalle Paí.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join PAISES On CORRE.PPAIS = PAISES.pcod And  PAISES.PCOD != ''                                                                                                                                                                                         " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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