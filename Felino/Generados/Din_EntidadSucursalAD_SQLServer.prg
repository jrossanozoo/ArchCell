
define class Din_EntidadSUCURSALAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_SUCURSAL'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = []
	cExpresionCCPorCampos = []
	cTagClaveCandidata = ''
	cTagClavePk = '_016PK'
	cTablaPrincipal = 'SUC'
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
			local  lxSucFaltafw, lxSucFectrans, lxSucFmodifw, lxSucFecimpo, lxSucFecexpo, lxSucCltpo, lxSucTimestamp, lxSucUmodifw, lxSucVmodifw, lxSucValtafw, lxSucZadsfw, lxSucHaltafw, lxSucUaltafw, lxSucSaltafw, lxSucHoraimpo, lxSucHmodifw, lxSucSmodifw, lxSucHoraexpo, lxSucCldir, lxSucEsttrans, lxSucBdaltafw, lxSucBdmodifw, lxSucClimpd, lxSucCltlf, lxSucCimagen, lxSucClnum, lxSucClfax, lxSucCodigo, lxSucClobs, lxSucClnom, lxSucClemail, lxSucClpiso, lxSucCldepto, lxSucClpageweb, lxSucClloc, lxSucClcontac, lxSucClcfi, lxSucClcp, lxSucClprv
				lxSucFaltafw =  .Fechaaltafw			lxSucFectrans =  .Fechatransferencia			lxSucFmodifw =  .Fechamodificacionfw			lxSucFecimpo =  .Fechaimpo			lxSucFecexpo =  .Fechaexpo			lxSucCltpo =  .Tipointerno			lxSucTimestamp = goLibrerias.ObtenerTimestamp()			lxSucUmodifw =  .Usuariomodificacionfw			lxSucVmodifw =  .Versionmodificacionfw			lxSucValtafw =  .Versionaltafw			lxSucZadsfw =  .Zadsfw			lxSucHaltafw =  .Horaaltafw			lxSucUaltafw =  .Usuarioaltafw			lxSucSaltafw =  .Seriealtafw			lxSucHoraimpo =  .Horaimpo			lxSucHmodifw =  .Horamodificacionfw			lxSucSmodifw =  .Seriemodificacionfw			lxSucHoraexpo =  .Horaexpo			lxSucCldir =  .Direccion			lxSucEsttrans =  .Estadotransferencia			lxSucBdaltafw =  .Basededatosaltafw			lxSucBdmodifw =  .Basededatosmodificacionfw			lxSucClimpd =  .Clasificacion			lxSucCltlf =  .Telefono			lxSucCimagen =  .Imagen			lxSucClnum =  .Numero			lxSucClfax =  .Fax			lxSucCodigo =  .Codigo			lxSucClobs =  .Observacion			lxSucClnom =  .Nombre			lxSucClemail =  .Email			lxSucClpiso =  .Piso			lxSucCldepto =  .Departamento			lxSucClpageweb =  .Paginaweb			lxSucClloc =  .Localidad			lxSucClcontac =  .Contacto			lxSucClcfi =  .Tipointerno2			lxSucClcp =  .Codigopostal			lxSucClprv =  upper( .Provincia_PK ) 
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxSucCodigo = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ORGANIZACION.SUC ( "Faltafw","Fectrans","Fmodifw","Fecimpo","Fecexpo","Cltpo","Timestamp","Umodifw","Vmodifw","Valtafw","Zadsfw","Haltafw","Ualtafw","Saltafw","Horaimpo","Hmodifw","Smodifw","Horaexpo","Cldir","Esttrans","Bdaltafw","Bdmodifw","Climpd","Cltlf","Cimagen","Clnum","Clfax","Codigo","Clobs","Clnom","Clemail","Clpiso","Cldepto","Clpageweb","Clloc","Clcontac","Clcfi","Clcp","Clprv" ) values ( <<"'" + this.ConvertirDateSql( lxSucFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxSucFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxSucFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxSucFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxSucFecexpo ) + "'" >>, <<lxSucCltpo >>, <<lxSucTimestamp >>, <<"'" + this.FormatearTextoSql( lxSucUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucCldir ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucClimpd ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucCltlf ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucCimagen ) + "'" >>, <<lxSucClnum >>, <<"'" + this.FormatearTextoSql( lxSucClfax ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucClobs ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucClnom ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucClemail ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucClpiso ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucCldepto ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucClpageweb ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucClloc ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucClcontac ) + "'" >>, <<lxSucClcfi >>, <<"'" + this.FormatearTextoSql( lxSucClcp ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucClprv ) + "'" >> )
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
		this.oEntidad.Timestamp = lxSucTimestamp
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
			local  lxSucFaltafw, lxSucFectrans, lxSucFmodifw, lxSucFecimpo, lxSucFecexpo, lxSucCltpo, lxSucTimestamp, lxSucUmodifw, lxSucVmodifw, lxSucValtafw, lxSucZadsfw, lxSucHaltafw, lxSucUaltafw, lxSucSaltafw, lxSucHoraimpo, lxSucHmodifw, lxSucSmodifw, lxSucHoraexpo, lxSucCldir, lxSucEsttrans, lxSucBdaltafw, lxSucBdmodifw, lxSucClimpd, lxSucCltlf, lxSucCimagen, lxSucClnum, lxSucClfax, lxSucCodigo, lxSucClobs, lxSucClnom, lxSucClemail, lxSucClpiso, lxSucCldepto, lxSucClpageweb, lxSucClloc, lxSucClcontac, lxSucClcfi, lxSucClcp, lxSucClprv
				lxSucFaltafw =  .Fechaaltafw			lxSucFectrans =  .Fechatransferencia			lxSucFmodifw =  .Fechamodificacionfw			lxSucFecimpo =  .Fechaimpo			lxSucFecexpo =  .Fechaexpo			lxSucCltpo =  .Tipointerno			lxSucTimestamp = goLibrerias.ObtenerTimestamp()			lxSucUmodifw =  .Usuariomodificacionfw			lxSucVmodifw =  .Versionmodificacionfw			lxSucValtafw =  .Versionaltafw			lxSucZadsfw =  .Zadsfw			lxSucHaltafw =  .Horaaltafw			lxSucUaltafw =  .Usuarioaltafw			lxSucSaltafw =  .Seriealtafw			lxSucHoraimpo =  .Horaimpo			lxSucHmodifw =  .Horamodificacionfw			lxSucSmodifw =  .Seriemodificacionfw			lxSucHoraexpo =  .Horaexpo			lxSucCldir =  .Direccion			lxSucEsttrans =  .Estadotransferencia			lxSucBdaltafw =  .Basededatosaltafw			lxSucBdmodifw =  .Basededatosmodificacionfw			lxSucClimpd =  .Clasificacion			lxSucCltlf =  .Telefono			lxSucCimagen =  .Imagen			lxSucClnum =  .Numero			lxSucClfax =  .Fax			lxSucCodigo =  .Codigo			lxSucClobs =  .Observacion			lxSucClnom =  .Nombre			lxSucClemail =  .Email			lxSucClpiso =  .Piso			lxSucCldepto =  .Departamento			lxSucClpageweb =  .Paginaweb			lxSucClloc =  .Localidad			lxSucClcontac =  .Contacto			lxSucClcfi =  .Tipointerno2			lxSucClcp =  .Codigopostal			lxSucClprv =  upper( .Provincia_PK ) 
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
				update ORGANIZACION.SUC set "Faltafw" = <<"'" + this.ConvertirDateSql( lxSucFaltafw ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxSucFectrans ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxSucFmodifw ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxSucFecimpo ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxSucFecexpo ) + "'">>,"Cltpo" = <<lxSucCltpo>>,"Timestamp" = <<lxSucTimestamp>>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxSucUmodifw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxSucVmodifw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxSucValtafw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxSucZadsfw ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxSucHaltafw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxSucUaltafw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxSucSaltafw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxSucHoraimpo ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxSucHmodifw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxSucSmodifw ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxSucHoraexpo ) + "'">>,"Cldir" = <<"'" + this.FormatearTextoSql( lxSucCldir ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxSucEsttrans ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxSucBdaltafw ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxSucBdmodifw ) + "'">>,"Climpd" = <<"'" + this.FormatearTextoSql( lxSucClimpd ) + "'">>,"Cltlf" = <<"'" + this.FormatearTextoSql( lxSucCltlf ) + "'">>,"Cimagen" = <<"'" + this.FormatearTextoSql( lxSucCimagen ) + "'">>,"Clnum" = <<lxSucClnum>>,"Clfax" = <<"'" + this.FormatearTextoSql( lxSucClfax ) + "'">>,"Codigo" = <<"'" + this.FormatearTextoSql( lxSucCodigo ) + "'">>,"Clobs" = <<"'" + this.FormatearTextoSql( lxSucClobs ) + "'">>,"Clnom" = <<"'" + this.FormatearTextoSql( lxSucClnom ) + "'">>,"Clemail" = <<"'" + this.FormatearTextoSql( lxSucClemail ) + "'">>,"Clpiso" = <<"'" + this.FormatearTextoSql( lxSucClpiso ) + "'">>,"Cldepto" = <<"'" + this.FormatearTextoSql( lxSucCldepto ) + "'">>,"Clpageweb" = <<"'" + this.FormatearTextoSql( lxSucClpageweb ) + "'">>,"Clloc" = <<"'" + this.FormatearTextoSql( lxSucClloc ) + "'">>,"Clcontac" = <<"'" + this.FormatearTextoSql( lxSucClcontac ) + "'">>,"Clcfi" = <<lxSucClcfi>>,"Clcp" = <<"'" + this.FormatearTextoSql( lxSucClcp ) + "'">>,"Clprv" = <<"'" + this.FormatearTextoSql( lxSucClprv ) + "'">> where "Codigo" = <<"'" + this.FormatearTextoSql( lxSucCodigo ) + "'">> and  SUC.CODIGO != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
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
		this.oEntidad.Timestamp = lxSucTimestamp
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 codigo from ORGANIZACION.SUC where " + this.ConvertirFuncionesSql( " SUC.CODIGO != ''" ) )
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
			Local lxSucCodigo
			lxSucCodigo = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Cltpo" as "Tipointerno", "Timestamp" as "Timestamp", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Haltafw" as "Horaaltafw", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Horaexpo" as "Horaexpo", "Cldir" as "Direccion", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Climpd" as "Clasificacion", "Cltlf" as "Telefono", "Cimagen" as "Imagen", "Clnum" as "Numero", "Clfax" as "Fax", "Codigo" as "Codigo", "Clobs" as "Observacion", "Clnom" as "Nombre", "Clemail" as "Email", "Clpiso" as "Piso", "Cldepto" as "Departamento", "Clpageweb" as "Paginaweb", "Clloc" as "Localidad", "Clcontac" as "Contacto", "Clcfi" as "Tipointerno2", "Clcp" as "Codigopostal", "Clprv" as "Provincia" from ORGANIZACION.SUC where "Codigo" = <<"'" + this.FormatearTextoSql( lxSucCodigo ) + "'">> and  SUC.CODIGO != ''
			endtext
			use in select('c_SUCURSAL')
			this.oConexion.EjecutarSql( lcSentencia, 'c_SUCURSAL', set( 'Datasession' ) )

			if reccount( 'c_SUCURSAL' ) = 0
				llRetorno = .f.
			else
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxSucCodigo as Variant
		llRetorno = .t.
		lxSucCodigo = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ORGANIZACION.SUC where "Codigo" = <<"'" + this.FormatearTextoSql( lxSucCodigo ) + "'">> and  SUC.CODIGO != ''
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
				select top 1 "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Cltpo" as "Tipointerno", "Timestamp" as "Timestamp", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Haltafw" as "Horaaltafw", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Horaexpo" as "Horaexpo", "Cldir" as "Direccion", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Climpd" as "Clasificacion", "Cltlf" as "Telefono", "Cimagen" as "Imagen", "Clnum" as "Numero", "Clfax" as "Fax", "Codigo" as "Codigo", "Clobs" as "Observacion", "Clnom" as "Nombre", "Clemail" as "Email", "Clpiso" as "Piso", "Cldepto" as "Departamento", "Clpageweb" as "Paginaweb", "Clloc" as "Localidad", "Clcontac" as "Contacto", "Clcfi" as "Tipointerno2", "Clcp" as "Codigopostal", "Clprv" as "Provincia" from ORGANIZACION.SUC where  SUC.CODIGO != '' order by codigo
			endtext
			use in select('c_SUCURSAL')
			this.oConexion.EjecutarSql( lcSentencia, 'c_SUCURSAL', set( 'Datasession' ) )
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
				select top 1 "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Cltpo" as "Tipointerno", "Timestamp" as "Timestamp", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Haltafw" as "Horaaltafw", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Horaexpo" as "Horaexpo", "Cldir" as "Direccion", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Climpd" as "Clasificacion", "Cltlf" as "Telefono", "Cimagen" as "Imagen", "Clnum" as "Numero", "Clfax" as "Fax", "Codigo" as "Codigo", "Clobs" as "Observacion", "Clnom" as "Nombre", "Clemail" as "Email", "Clpiso" as "Piso", "Cldepto" as "Departamento", "Clpageweb" as "Paginaweb", "Clloc" as "Localidad", "Clcontac" as "Contacto", "Clcfi" as "Tipointerno2", "Clcp" as "Codigopostal", "Clprv" as "Provincia" from ORGANIZACION.SUC where  funciones.padr( codigo, 5, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  SUC.CODIGO != '' order by codigo
			endtext
			use in select('c_SUCURSAL')
			this.oConexion.EjecutarSql( lcSentencia, 'c_SUCURSAL', set( 'Datasession' ) )
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
				select top 1 "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Cltpo" as "Tipointerno", "Timestamp" as "Timestamp", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Haltafw" as "Horaaltafw", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Horaexpo" as "Horaexpo", "Cldir" as "Direccion", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Climpd" as "Clasificacion", "Cltlf" as "Telefono", "Cimagen" as "Imagen", "Clnum" as "Numero", "Clfax" as "Fax", "Codigo" as "Codigo", "Clobs" as "Observacion", "Clnom" as "Nombre", "Clemail" as "Email", "Clpiso" as "Piso", "Cldepto" as "Departamento", "Clpageweb" as "Paginaweb", "Clloc" as "Localidad", "Clcontac" as "Contacto", "Clcfi" as "Tipointerno2", "Clcp" as "Codigopostal", "Clprv" as "Provincia" from ORGANIZACION.SUC where  funciones.padr( codigo, 5, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  SUC.CODIGO != '' order by codigo desc
			endtext
			use in select('c_SUCURSAL')
			this.oConexion.EjecutarSql( lcSentencia, 'c_SUCURSAL', set( 'Datasession' ) )
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
				select top 1 "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Cltpo" as "Tipointerno", "Timestamp" as "Timestamp", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Haltafw" as "Horaaltafw", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Horaexpo" as "Horaexpo", "Cldir" as "Direccion", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Climpd" as "Clasificacion", "Cltlf" as "Telefono", "Cimagen" as "Imagen", "Clnum" as "Numero", "Clfax" as "Fax", "Codigo" as "Codigo", "Clobs" as "Observacion", "Clnom" as "Nombre", "Clemail" as "Email", "Clpiso" as "Piso", "Cldepto" as "Departamento", "Clpageweb" as "Paginaweb", "Clloc" as "Localidad", "Clcontac" as "Contacto", "Clcfi" as "Tipointerno2", "Clcp" as "Codigopostal", "Clprv" as "Provincia" from ORGANIZACION.SUC where  SUC.CODIGO != '' order by codigo desc
			endtext
			use in select('c_SUCURSAL')
			this.oConexion.EjecutarSql( lcSentencia, 'c_SUCURSAL', set( 'Datasession' ) )
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
			lcXml = this.oConexion.EjecutarSql( "select Faltafw,Fectrans,Fmodifw,Fecimpo,Fecexpo,Cltpo,Timestamp,Umodifw,Vmodifw,Valtafw,Zadsfw,Halt" + ;
"afw,Ualtafw,Saltafw,Horaimpo,Hmodifw,Smodifw,Horaexpo,Cldir,Esttrans,Bdaltafw,Bdmodifw,Climpd,Cltlf," + ;
"Cimagen,Clnum,Clfax,Codigo,Clobs,Clnom,Clemail,Clpiso,Cldepto,Clpageweb,Clloc,Clcontac,Clcfi,Clcp,Cl" + ;
"prv" + ;
" from ORGANIZACION.SUC where  SUC.CODIGO != '' and " + lcFiltro )
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
			local  lxSucFaltafw, lxSucFectrans, lxSucFmodifw, lxSucFecimpo, lxSucFecexpo, lxSucCltpo, lxSucTimestamp, lxSucUmodifw, lxSucVmodifw, lxSucValtafw, lxSucZadsfw, lxSucHaltafw, lxSucUaltafw, lxSucSaltafw, lxSucHoraimpo, lxSucHmodifw, lxSucSmodifw, lxSucHoraexpo, lxSucCldir, lxSucEsttrans, lxSucBdaltafw, lxSucBdmodifw, lxSucClimpd, lxSucCltlf, lxSucCimagen, lxSucClnum, lxSucClfax, lxSucCodigo, lxSucClobs, lxSucClnom, lxSucClemail, lxSucClpiso, lxSucCldepto, lxSucClpageweb, lxSucClloc, lxSucClcontac, lxSucClcfi, lxSucClcp, lxSucClprv
				lxSucFaltafw = ctod( '  /  /    ' )			lxSucFectrans = ctod( '  /  /    ' )			lxSucFmodifw = ctod( '  /  /    ' )			lxSucFecimpo = ctod( '  /  /    ' )			lxSucFecexpo = ctod( '  /  /    ' )			lxSucCltpo = 0			lxSucTimestamp = goLibrerias.ObtenerTimestamp()			lxSucUmodifw = []			lxSucVmodifw = []			lxSucValtafw = []			lxSucZadsfw = []			lxSucHaltafw = []			lxSucUaltafw = []			lxSucSaltafw = []			lxSucHoraimpo = []			lxSucHmodifw = []			lxSucSmodifw = []			lxSucHoraexpo = []			lxSucCldir = []			lxSucEsttrans = []			lxSucBdaltafw = []			lxSucBdmodifw = []			lxSucClimpd = []			lxSucCltlf = []			lxSucCimagen = []			lxSucClnum = 0			lxSucClfax = []			lxSucCodigo = []			lxSucClobs = []			lxSucClnom = []			lxSucClemail = []			lxSucClpiso = []			lxSucCldepto = []			lxSucClpageweb = []			lxSucClloc = []			lxSucClcontac = []			lxSucClcfi = 0			lxSucClcp = []			lxSucClprv = []
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( [delete from ORGANIZACION.SUC where "codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'SUC' + '_' + tcCampo
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
		lcWhere = " Where  SUC.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Cltpo" as "Tipointerno", "Timestamp" as "Timestamp", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Haltafw" as "Horaaltafw", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Horaexpo" as "Horaexpo", "Cldir" as "Direccion", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Climpd" as "Clasificacion", "Cltlf" as "Telefono", "Cimagen" as "Imagen", "Clnum" as "Numero", "Clfax" as "Fax", "Codigo" as "Codigo", "Clobs" as "Observacion", "Clnom" as "Nombre", "Clemail" as "Email", "Clpiso" as "Piso", "Cldepto" as "Departamento", "Clpageweb" as "Paginaweb", "Clloc" as "Localidad", "Clcontac" as "Contacto", "Clcfi" as "Tipointerno2", "Clcp" as "Codigopostal", "Clprv" as "Provincia"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'SUC', '', tnTope )
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
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'FECHAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECIMPO AS FECHAIMPO'
				Case lcAtributo == 'FECHAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECEXPO AS FECHAEXPO'
				Case lcAtributo == 'TIPOINTERNO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLTPO AS TIPOINTERNO'
				Case lcAtributo == 'TIMESTAMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIMESTAMP AS TIMESTAMP'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'DIRECCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLDIR AS DIRECCION'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'CLASIFICACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLIMPD AS CLASIFICACION'
				Case lcAtributo == 'TELEFONO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLTLF AS TELEFONO'
				Case lcAtributo == 'IMAGEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CIMAGEN AS IMAGEN'
				Case lcAtributo == 'NUMERO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLNUM AS NUMERO'
				Case lcAtributo == 'FAX'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLFAX AS FAX'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'OBSERVACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLOBS AS OBSERVACION'
				Case lcAtributo == 'NOMBRE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLNOM AS NOMBRE'
				Case lcAtributo == 'EMAIL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLEMAIL AS EMAIL'
				Case lcAtributo == 'PISO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLPISO AS PISO'
				Case lcAtributo == 'DEPARTAMENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLDEPTO AS DEPARTAMENTO'
				Case lcAtributo == 'PAGINAWEB'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLPAGEWEB AS PAGINAWEB'
				Case lcAtributo == 'LOCALIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLLOC AS LOCALIDAD'
				Case lcAtributo == 'CONTACTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLCONTAC AS CONTACTO'
				Case lcAtributo == 'TIPOINTERNO2'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLCFI AS TIPOINTERNO2'
				Case lcAtributo == 'CODIGOPOSTAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLCP AS CODIGOPOSTAL'
				Case lcAtributo == 'PROVINCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLPRV AS PROVINCIA'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAIMPO'
				lcCampo = 'FECIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEXPO'
				lcCampo = 'FECEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOINTERNO'
				lcCampo = 'CLTPO'
			Case upper( alltrim( tcAtributo ) ) == 'TIMESTAMP'
				lcCampo = 'TIMESTAMP'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'DIRECCION'
				lcCampo = 'CLDIR'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'CLASIFICACION'
				lcCampo = 'CLIMPD'
			Case upper( alltrim( tcAtributo ) ) == 'TELEFONO'
				lcCampo = 'CLTLF'
			Case upper( alltrim( tcAtributo ) ) == 'IMAGEN'
				lcCampo = 'CIMAGEN'
			Case upper( alltrim( tcAtributo ) ) == 'NUMERO'
				lcCampo = 'CLNUM'
			Case upper( alltrim( tcAtributo ) ) == 'FAX'
				lcCampo = 'CLFAX'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'OBSERVACION'
				lcCampo = 'CLOBS'
			Case upper( alltrim( tcAtributo ) ) == 'NOMBRE'
				lcCampo = 'CLNOM'
			Case upper( alltrim( tcAtributo ) ) == 'EMAIL'
				lcCampo = 'CLEMAIL'
			Case upper( alltrim( tcAtributo ) ) == 'PISO'
				lcCampo = 'CLPISO'
			Case upper( alltrim( tcAtributo ) ) == 'DEPARTAMENTO'
				lcCampo = 'CLDEPTO'
			Case upper( alltrim( tcAtributo ) ) == 'PAGINAWEB'
				lcCampo = 'CLPAGEWEB'
			Case upper( alltrim( tcAtributo ) ) == 'LOCALIDAD'
				lcCampo = 'CLLOC'
			Case upper( alltrim( tcAtributo ) ) == 'CONTACTO'
				lcCampo = 'CLCONTAC'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOINTERNO2'
				lcCampo = 'CLCFI'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGOPOSTAL'
				lcCampo = 'CLCP'
			Case upper( alltrim( tcAtributo ) ) == 'PROVINCIA'
				lcCampo = 'CLPRV'
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
			local  lxSucFaltafw, lxSucFectrans, lxSucFmodifw, lxSucFecimpo, lxSucFecexpo, lxSucCltpo, lxSucTimestamp, lxSucUmodifw, lxSucVmodifw, lxSucValtafw, lxSucZadsfw, lxSucHaltafw, lxSucUaltafw, lxSucSaltafw, lxSucHoraimpo, lxSucHmodifw, lxSucSmodifw, lxSucHoraexpo, lxSucCldir, lxSucEsttrans, lxSucBdaltafw, lxSucBdmodifw, lxSucClimpd, lxSucCltlf, lxSucCimagen, lxSucClnum, lxSucClfax, lxSucCodigo, lxSucClobs, lxSucClnom, lxSucClemail, lxSucClpiso, lxSucCldepto, lxSucClpageweb, lxSucClloc, lxSucClcontac, lxSucClcfi, lxSucClcp, lxSucClprv
				lxSucFaltafw =  .Fechaaltafw			lxSucFectrans =  .Fechatransferencia			lxSucFmodifw =  .Fechamodificacionfw			lxSucFecimpo =  .Fechaimpo			lxSucFecexpo =  .Fechaexpo			lxSucCltpo =  .Tipointerno			lxSucTimestamp = goLibrerias.ObtenerTimestamp()			lxSucUmodifw =  .Usuariomodificacionfw			lxSucVmodifw =  .Versionmodificacionfw			lxSucValtafw =  .Versionaltafw			lxSucZadsfw =  .Zadsfw			lxSucHaltafw =  .Horaaltafw			lxSucUaltafw =  .Usuarioaltafw			lxSucSaltafw =  .Seriealtafw			lxSucHoraimpo =  .Horaimpo			lxSucHmodifw =  .Horamodificacionfw			lxSucSmodifw =  .Seriemodificacionfw			lxSucHoraexpo =  .Horaexpo			lxSucCldir =  .Direccion			lxSucEsttrans =  .Estadotransferencia			lxSucBdaltafw =  .Basededatosaltafw			lxSucBdmodifw =  .Basededatosmodificacionfw			lxSucClimpd =  .Clasificacion			lxSucCltlf =  .Telefono			lxSucCimagen =  .Imagen			lxSucClnum =  .Numero			lxSucClfax =  .Fax			lxSucCodigo =  .Codigo			lxSucClobs =  .Observacion			lxSucClnom =  .Nombre			lxSucClemail =  .Email			lxSucClpiso =  .Piso			lxSucCldepto =  .Departamento			lxSucClpageweb =  .Paginaweb			lxSucClloc =  .Localidad			lxSucClcontac =  .Contacto			lxSucClcfi =  .Tipointerno2			lxSucClcp =  .Codigopostal			lxSucClprv =  upper( .Provincia_PK ) 
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ORGANIZACION.SUC ( "Faltafw","Fectrans","Fmodifw","Fecimpo","Fecexpo","Cltpo","Timestamp","Umodifw","Vmodifw","Valtafw","Zadsfw","Haltafw","Ualtafw","Saltafw","Horaimpo","Hmodifw","Smodifw","Horaexpo","Cldir","Esttrans","Bdaltafw","Bdmodifw","Climpd","Cltlf","Cimagen","Clnum","Clfax","Codigo","Clobs","Clnom","Clemail","Clpiso","Cldepto","Clpageweb","Clloc","Clcontac","Clcfi","Clcp","Clprv" ) values ( <<"'" + this.ConvertirDateSql( lxSucFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxSucFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxSucFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxSucFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxSucFecexpo ) + "'" >>, <<lxSucCltpo >>, <<lxSucTimestamp >>, <<"'" + this.FormatearTextoSql( lxSucUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucCldir ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucClimpd ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucCltlf ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucCimagen ) + "'" >>, <<lxSucClnum >>, <<"'" + this.FormatearTextoSql( lxSucClfax ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucClobs ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucClnom ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucClemail ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucClpiso ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucCldepto ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucClpageweb ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucClloc ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucClcontac ) + "'" >>, <<lxSucClcfi >>, <<"'" + this.FormatearTextoSql( lxSucClcp ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucClprv ) + "'" >> )
		endtext
		loColeccion.cTabla = 'SUC' 
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
			local  lxSucFaltafw, lxSucFectrans, lxSucFmodifw, lxSucFecimpo, lxSucFecexpo, lxSucCltpo, lxSucTimestamp, lxSucUmodifw, lxSucVmodifw, lxSucValtafw, lxSucZadsfw, lxSucHaltafw, lxSucUaltafw, lxSucSaltafw, lxSucHoraimpo, lxSucHmodifw, lxSucSmodifw, lxSucHoraexpo, lxSucCldir, lxSucEsttrans, lxSucBdaltafw, lxSucBdmodifw, lxSucClimpd, lxSucCltlf, lxSucCimagen, lxSucClnum, lxSucClfax, lxSucCodigo, lxSucClobs, lxSucClnom, lxSucClemail, lxSucClpiso, lxSucCldepto, lxSucClpageweb, lxSucClloc, lxSucClcontac, lxSucClcfi, lxSucClcp, lxSucClprv
				lxSucFaltafw =  .Fechaaltafw			lxSucFectrans =  .Fechatransferencia			lxSucFmodifw =  .Fechamodificacionfw			lxSucFecimpo =  .Fechaimpo			lxSucFecexpo =  .Fechaexpo			lxSucCltpo =  .Tipointerno			lxSucTimestamp = goLibrerias.ObtenerTimestamp()			lxSucUmodifw =  .Usuariomodificacionfw			lxSucVmodifw =  .Versionmodificacionfw			lxSucValtafw =  .Versionaltafw			lxSucZadsfw =  .Zadsfw			lxSucHaltafw =  .Horaaltafw			lxSucUaltafw =  .Usuarioaltafw			lxSucSaltafw =  .Seriealtafw			lxSucHoraimpo =  .Horaimpo			lxSucHmodifw =  .Horamodificacionfw			lxSucSmodifw =  .Seriemodificacionfw			lxSucHoraexpo =  .Horaexpo			lxSucCldir =  .Direccion			lxSucEsttrans =  .Estadotransferencia			lxSucBdaltafw =  .Basededatosaltafw			lxSucBdmodifw =  .Basededatosmodificacionfw			lxSucClimpd =  .Clasificacion			lxSucCltlf =  .Telefono			lxSucCimagen =  .Imagen			lxSucClnum =  .Numero			lxSucClfax =  .Fax			lxSucCodigo =  .Codigo			lxSucClobs =  .Observacion			lxSucClnom =  .Nombre			lxSucClemail =  .Email			lxSucClpiso =  .Piso			lxSucCldepto =  .Departamento			lxSucClpageweb =  .Paginaweb			lxSucClloc =  .Localidad			lxSucClcontac =  .Contacto			lxSucClcfi =  .Tipointerno2			lxSucClcp =  .Codigopostal			lxSucClprv =  upper( .Provincia_PK ) 
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  SUC.CODIGO != '']
			text to lcSentencia noshow textmerge
				update ORGANIZACION.SUC set "Faltafw" = <<"'" + this.ConvertirDateSql( lxSucFaltafw ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxSucFectrans ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxSucFmodifw ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxSucFecimpo ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxSucFecexpo ) + "'">>, "Cltpo" = <<lxSucCltpo>>, "Timestamp" = <<lxSucTimestamp>>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxSucUmodifw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxSucVmodifw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxSucValtafw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxSucZadsfw ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxSucHaltafw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxSucUaltafw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxSucSaltafw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxSucHoraimpo ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxSucHmodifw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxSucSmodifw ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxSucHoraexpo ) + "'">>, "Cldir" = <<"'" + this.FormatearTextoSql( lxSucCldir ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxSucEsttrans ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxSucBdaltafw ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxSucBdmodifw ) + "'">>, "Climpd" = <<"'" + this.FormatearTextoSql( lxSucClimpd ) + "'">>, "Cltlf" = <<"'" + this.FormatearTextoSql( lxSucCltlf ) + "'">>, "Cimagen" = <<"'" + this.FormatearTextoSql( lxSucCimagen ) + "'">>, "Clnum" = <<lxSucClnum>>, "Clfax" = <<"'" + this.FormatearTextoSql( lxSucClfax ) + "'">>, "Codigo" = <<"'" + this.FormatearTextoSql( lxSucCodigo ) + "'">>, "Clobs" = <<"'" + this.FormatearTextoSql( lxSucClobs ) + "'">>, "Clnom" = <<"'" + this.FormatearTextoSql( lxSucClnom ) + "'">>, "Clemail" = <<"'" + this.FormatearTextoSql( lxSucClemail ) + "'">>, "Clpiso" = <<"'" + this.FormatearTextoSql( lxSucClpiso ) + "'">>, "Cldepto" = <<"'" + this.FormatearTextoSql( lxSucCldepto ) + "'">>, "Clpageweb" = <<"'" + this.FormatearTextoSql( lxSucClpageweb ) + "'">>, "Clloc" = <<"'" + this.FormatearTextoSql( lxSucClloc ) + "'">>, "Clcontac" = <<"'" + this.FormatearTextoSql( lxSucClcontac ) + "'">>, "Clcfi" = <<lxSucClcfi>>, "Clcp" = <<"'" + this.FormatearTextoSql( lxSucClcp ) + "'">>, "Clprv" = <<"'" + this.FormatearTextoSql( lxSucClprv ) + "'">> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'SUC' 
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

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  SUC.CODIGO != '']
		loColeccion.Agregar( 'delete from ORGANIZACION.SUC where ' + lcFiltro )
			loColeccion.cTabla = 'SUC' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ORGANIZACION.SUC where  SUC.CODIGO != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ORGANIZACION.SUC where codigo = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  SUC.CODIGO != ''" )
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
		lcCursor = This.oEntidad.cPrefijoRecibir + 'SUCURSAL'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ORGANIZACION.SUC Where codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..codigo ) + "'", 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					this.oConexion.EjecutarSql( [UPDATE ORGANIZACION.SUC set  FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, CLTPO = ] + transform( &lcCursor..CLTPO )+ [, TIMESTAMP = ] + transform( &lcCursor..TIMESTAMP )+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, CLDIR = ] + "'" + this.FormatearTextoSql( &lcCursor..CLDIR ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, CLIMPD = ] + "'" + this.FormatearTextoSql( &lcCursor..CLIMPD ) + "'"+ [, CLTLF = ] + "'" + this.FormatearTextoSql( &lcCursor..CLTLF ) + "'"+ [, CIMAGEN = ] + "'" + this.FormatearTextoSql( &lcCursor..CIMAGEN ) + "'"+ [, CLNUM = ] + transform( &lcCursor..CLNUM )+ [, CLFAX = ] + "'" + this.FormatearTextoSql( &lcCursor..CLFAX ) + "'"+ [, codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..codigo ) + "'"+ [, CLOBS = ] + "'" + this.FormatearTextoSql( &lcCursor..CLOBS ) + "'"+ [, CLNOM = ] + "'" + this.FormatearTextoSql( &lcCursor..CLNOM ) + "'"+ [, CLEMAIL = ] + "'" + this.FormatearTextoSql( &lcCursor..CLEMAIL ) + "'"+ [, CLPISO = ] + "'" + this.FormatearTextoSql( &lcCursor..CLPISO ) + "'"+ [, CLDEPTO = ] + "'" + this.FormatearTextoSql( &lcCursor..CLDEPTO ) + "'"+ [, CLPAGEWEB = ] + "'" + this.FormatearTextoSql( &lcCursor..CLPAGEWEB ) + "'"+ [, CLLOC = ] + "'" + this.FormatearTextoSql( &lcCursor..CLLOC ) + "'"+ [, CLCONTAC = ] + "'" + this.FormatearTextoSql( &lcCursor..CLCONTAC ) + "'"+ [, CLCFI = ] + transform( &lcCursor..CLCFI )+ [, CLCP = ] + "'" + this.FormatearTextoSql( &lcCursor..CLCP ) + "'"+ [, CLPRV = ] + "'" + this.FormatearTextoSql( &lcCursor..CLPRV ) + "'" + [ Where codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..codigo ) + "'" )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
				endIf
			else
				Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
				Text to lcCampos noShow
					 FALTAFW, FECTRANS, FMODIFW, FECIMPO, FECEXPO, CLTPO, TIMESTAMP, UMODIFW, VMODIFW, VALTAFW, ZADSFW, HALTAFW, UALTAFW, SALTAFW, HORAIMPO, HMODIFW, SMODIFW, HORAEXPO, CLDIR, ESTTRANS, BDALTAFW, BDMODIFW, CLIMPD, CLTLF, CIMAGEN, CLNUM, CLFAX, codigo, CLOBS, CLNOM, CLEMAIL, CLPISO, CLDEPTO, CLPAGEWEB, CLLOC, CLCONTAC, CLCFI, CLCP, CLPRV
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + transform( &lcCursor..CLTPO ) + ',' + transform( &lcCursor..TIMESTAMP )
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLDIR ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLIMPD ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLTLF ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CIMAGEN ) + "'" + ',' + transform( &lcCursor..CLNUM ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLFAX ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..codigo ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLOBS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLNOM ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLEMAIL ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLPISO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLDEPTO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLPAGEWEB ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLLOC ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLCONTAC ) + "'" + ',' + transform( &lcCursor..CLCFI ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLCP ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLPRV ) + "'"
lcValoresCampos = substr(lcValoresCampos,2) 

				this.oConexion.EjecutarSql( [Insert into ORGANIZACION.SUC ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
				this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'SUCURSAL'
		if This.ActualizaEnRecepcion()
	endif
	Use in select( 'cExistentes' )
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearCursorMemo( tcCursorACrear as String, tcTablaConMemo as String ) as Void
		create cursor &tcCursorACrear ( codigo C (5) , Orden N(16), texto C(80))
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
			Case  lcAlias == lcPrefijo + 'SUCURSAL'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'SUCURSAL_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'SUCURSAL_CLOBS'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ORGANIZACION.TablaTrabajo_Suc')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'SUCURSAL'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..codigo
		llCondicion = isnull( lxVar )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad SUCURSAL. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'SUCURSAL'
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
			lcCursor = This.oEntidad.cPrefijoRecibir + 'SUCURSAL'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ORGANIZACION.TablaTrabajo_Suc') AND type in ('U')) DROP TABLE ORGANIZACION.TablaTrabajo_Suc
Create Table ORGANIZACION.TablaTrabajo_Suc ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"faltafw" datetime  null, 
"fectrans" datetime  null, 
"fmodifw" datetime  null, 
"fecimpo" datetime  null, 
"fecexpo" datetime  null, 
"cltpo" numeric( 1, 0 )  null, 
"timestamp" numeric( 20, 0 )  null, 
"umodifw" char( 100 )  null, 
"vmodifw" char( 13 )  null, 
"valtafw" char( 13 )  null, 
"zadsfw" varchar(max)  null, 
"haltafw" char( 8 )  null, 
"ualtafw" char( 100 )  null, 
"saltafw" char( 7 )  null, 
"horaimpo" char( 8 )  null, 
"hmodifw" char( 8 )  null, 
"smodifw" char( 7 )  null, 
"horaexpo" char( 8 )  null, 
"cldir" char( 70 )  null, 
"esttrans" char( 20 )  null, 
"bdaltafw" char( 8 )  null, 
"bdmodifw" char( 8 )  null, 
"climpd" char( 8 )  null, 
"cltlf" char( 30 )  null, 
"cimagen" char( 180 )  null, 
"clnum" numeric( 5, 0 )  null, 
"clfax" char( 60 )  null, 
"codigo" char( 5 )  null, 
"clobs" varchar(max)  null, 
"clnom" char( 60 )  null, 
"clemail" char( 60 )  null, 
"clpiso" char( 3 )  null, 
"cldepto" char( 3 )  null, 
"clpageweb" char( 60 )  null, 
"clloc" char( 70 )  null, 
"clcontac" char( 60 )  null, 
"clcfi" numeric( 1, 0 )  null, 
"clcp" char( 8 )  null, 
"clprv" char( 2 )  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_Suc' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_Suc' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'SUCURSAL'
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
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('cltpo','cltpo')
			.AgregarMapeo('timestamp','timestamp')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('cldir','cldir')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('climpd','climpd')
			.AgregarMapeo('cltlf','cltlf')
			.AgregarMapeo('cimagen','cimagen')
			.AgregarMapeo('clnum','clnum')
			.AgregarMapeo('clfax','clfax')
			.AgregarMapeo('codigo','codigo')
			.AgregarMapeo('clobs','clobs')
			.AgregarMapeo('clnom','clnom')
			.AgregarMapeo('clemail','clemail')
			.AgregarMapeo('clpiso','clpiso')
			.AgregarMapeo('cldepto','cldepto')
			.AgregarMapeo('clpageweb','clpageweb')
			.AgregarMapeo('clloc','clloc')
			.AgregarMapeo('clcontac','clcontac')
			.AgregarMapeo('clcfi','clcfi')
			.AgregarMapeo('clcp','clcp')
			.AgregarMapeo('clprv','clprv')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ORGANIZACION.TablaTrabajo_Suc'
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
				Update t Set t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.CLTPO = isnull( d.CLTPO, t.CLTPO ),t.TIMESTAMP = isnull( d.TIMESTAMP, t.TIMESTAMP ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.CLDIR = isnull( d.CLDIR, t.CLDIR ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.CLIMPD = isnull( d.CLIMPD, t.CLIMPD ),t.CLTLF = isnull( d.CLTLF, t.CLTLF ),t.CIMAGEN = isnull( d.CIMAGEN, t.CIMAGEN ),t.CLNUM = isnull( d.CLNUM, t.CLNUM ),t.CLFAX = isnull( d.CLFAX, t.CLFAX ),t.CODIGO = isnull( d.CODIGO, t.CODIGO ),t.CLOBS = isnull( d.CLOBS, t.CLOBS ),t.CLNOM = isnull( d.CLNOM, t.CLNOM ),t.CLEMAIL = isnull( d.CLEMAIL, t.CLEMAIL ),t.CLPISO = isnull( d.CLPISO, t.CLPISO ),t.CLDEPTO = isnull( d.CLDEPTO, t.CLDEPTO ),t.CLPAGEWEB = isnull( d.CLPAGEWEB, t.CLPAGEWEB ),t.CLLOC = isnull( d.CLLOC, t.CLLOC ),t.CLCONTAC = isnull( d.CLCONTAC, t.CLCONTAC ),t.CLCFI = isnull( d.CLCFI, t.CLCFI ),t.CLCP = isnull( d.CLCP, t.CLCP ),t.CLPRV = isnull( d.CLPRV, t.CLPRV )
					from ORGANIZACION.SUC t inner join deleted d 
							 on t.codigo = d.codigo
				-- Fin Updates
				insert into ORGANIZACION.SUC(Faltafw,Fectrans,Fmodifw,Fecimpo,Fecexpo,Cltpo,Timestamp,Umodifw,Vmodifw,Valtafw,Zadsfw,Haltafw,Ualtafw,Saltafw,Horaimpo,Hmodifw,Smodifw,Horaexpo,Cldir,Esttrans,Bdaltafw,Bdmodifw,Climpd,Cltlf,Cimagen,Clnum,Clfax,Codigo,Clobs,Clnom,Clemail,Clpiso,Cldepto,Clpageweb,Clloc,Clcontac,Clcfi,Clcp,Clprv)
					Select CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FECTRANS,''),isnull( d.FMODIFW,''),isnull( d.FECIMPO,''),isnull( d.FECEXPO,''),isnull( d.CLTPO,0),isnull( d.TIMESTAMP,0),isnull( d.UMODIFW,''),isnull( d.VMODIFW,''),isnull( d.VALTAFW,''),isnull( d.ZADSFW,''),convert( char(8), getdate(), 108 ),isnull( d.UALTAFW,''),isnull( d.SALTAFW,''),isnull( d.HORAIMPO,''),isnull( d.HMODIFW,''),isnull( d.SMODIFW,''),isnull( d.HORAEXPO,''),isnull( d.CLDIR,''),isnull( d.ESTTRANS,''),isnull( d.BDALTAFW,''),isnull( d.BDMODIFW,''),isnull( d.CLIMPD,''),isnull( d.CLTLF,''),isnull( d.CIMAGEN,''),isnull( d.CLNUM,0),isnull( d.CLFAX,''),isnull( d.CODIGO,''),isnull( d.CLOBS,''),isnull( d.CLNOM,''),isnull( d.CLEMAIL,''),isnull( d.CLPISO,''),isnull( d.CLDEPTO,''),isnull( d.CLPAGEWEB,''),isnull( d.CLLOC,''),isnull( d.CLCONTAC,''),isnull( d.CLCFI,0),isnull( d.CLCP,''),isnull( d.CLPRV,'')
						From deleted d left join ORGANIZACION.SUC pk 
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ORGANIZACION.TablaTrabajo_Suc') AND type in ('U')) DROP TABLE ORGANIZACION.TablaTrabajo_Suc
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_SUCURSAL' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_SUCURSAL.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_SUCURSAL.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_SUCURSAL.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_SUCURSAL.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_SUCURSAL.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Tipointerno = nvl( c_SUCURSAL.Tipointerno, 0 )
					.Timestamp = nvl( c_SUCURSAL.Timestamp, 0 )
					.Usuariomodificacionfw = nvl( c_SUCURSAL.Usuariomodificacionfw, [] )
					.Versionmodificacionfw = nvl( c_SUCURSAL.Versionmodificacionfw, [] )
					.Versionaltafw = nvl( c_SUCURSAL.Versionaltafw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Horaaltafw = nvl( c_SUCURSAL.Horaaltafw, [] )
					.Usuarioaltafw = nvl( c_SUCURSAL.Usuarioaltafw, [] )
					.Seriealtafw = nvl( c_SUCURSAL.Seriealtafw, [] )
					.Horaimpo = nvl( c_SUCURSAL.Horaimpo, [] )
					.Horamodificacionfw = nvl( c_SUCURSAL.Horamodificacionfw, [] )
					.Seriemodificacionfw = nvl( c_SUCURSAL.Seriemodificacionfw, [] )
					.Horaexpo = nvl( c_SUCURSAL.Horaexpo, [] )
					.Direccion = nvl( c_SUCURSAL.Direccion, [] )
					.Estadotransferencia = nvl( c_SUCURSAL.Estadotransferencia, [] )
					.Basededatosaltafw = nvl( c_SUCURSAL.Basededatosaltafw, [] )
					.Basededatosmodificacionfw = nvl( c_SUCURSAL.Basededatosmodificacionfw, [] )
					.Clasificacion = nvl( c_SUCURSAL.Clasificacion, [] )
					.Telefono = nvl( c_SUCURSAL.Telefono, [] )
					.Imagen = nvl( c_SUCURSAL.Imagen, [] )
					.Numero = nvl( c_SUCURSAL.Numero, 0 )
					.Fax = nvl( c_SUCURSAL.Fax, [] )
					.Codigo = nvl( c_SUCURSAL.Codigo, [] )
					lcValor = This.ObtenerMemo( 'c_Observacion')
					.Observacion = lcValor 
					.Nombre = nvl( c_SUCURSAL.Nombre, [] )
					.Email = nvl( c_SUCURSAL.Email, [] )
					.Piso = nvl( c_SUCURSAL.Piso, [] )
					.Departamento = nvl( c_SUCURSAL.Departamento, [] )
					.Paginaweb = nvl( c_SUCURSAL.Paginaweb, [] )
					.Localidad = nvl( c_SUCURSAL.Localidad, [] )
					.Contacto = nvl( c_SUCURSAL.Contacto, [] )
					.Tipointerno2 = nvl( c_SUCURSAL.Tipointerno2, 0 )
					.Codigopostal = nvl( c_SUCURSAL.Codigopostal, [] )
					.Provincia_PK =  nvl( c_SUCURSAL.Provincia, [] )
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
		return c_SUCURSAL.&lcAtributo
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
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID('<<lcNombreBD>>') AND OBJECT_ID=OBJECT_ID( '<<lcNombreBD>>.ORGANIZACION.SUC' )
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
								from ORGANIZACION.SUC 
								Where   SUC.CODIGO != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "SUC", "", lcCursor, set("Datasession") )
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
			"Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Cltpo" as "Tipointerno", "Timestamp" as "Timestamp", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Haltafw" as "Horaaltafw", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Horaexpo" as "Horaexpo", "Cldir" as "Direccion", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Climpd" as "Clasificacion", "Cltlf" as "Telefono", "Cimagen" as "Imagen", "Clnum" as "Numero", "Clfax" as "Fax", "Codigo" as "Codigo", "Clobs" as "Observacion", "Clnom" as "Nombre", "Clemail" as "Email", "Clpiso" as "Piso", "Cldepto" as "Departamento", "Clpageweb" as "Paginaweb", "Clloc" as "Localidad", "Clcontac" as "Contacto", "Clcfi" as "Tipointerno2", "Clcp" as "Codigopostal", "Clprv" as "Provincia"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ORGANIZACION.SUC 
								Where   SUC.CODIGO != ''
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
	Tabla = 'SUC'
	Filtro = " SUC.CODIGO != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " SUC.CODIGO != ''"
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
	<row entidad="SUCURSAL                                " atributo="FECHAALTAFW                             " tabla="SUC            " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSAL                                " atributo="FECHATRANSFERENCIA                      " tabla="SUC            " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha transferencia                                                                                                                                             " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSAL                                " atributo="FECHAMODIFICACIONFW                     " tabla="SUC            " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSAL                                " atributo="FECHAIMPO                               " tabla="SUC            " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSAL                                " atributo="FECHAEXPO                               " tabla="SUC            " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSAL                                " atributo="TIPOINTERNO                             " tabla="SUC            " campo="CLTPO     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="3                                                                                                                                                                                                                                                             " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSAL                                " atributo="TIMESTAMP                               " tabla="SUC            " campo="TIMESTAMP " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSAL                                " atributo="USUARIOMODIFICACIONFW                   " tabla="SUC            " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSAL                                " atributo="VERSIONMODIFICACIONFW                   " tabla="SUC            " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSAL                                " atributo="VERSIONALTAFW                           " tabla="SUC            " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSAL                                " atributo="ZADSFW                                  " tabla="SUC            " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSAL                                " atributo="HORAALTAFW                              " tabla="SUC            " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSAL                                " atributo="USUARIOALTAFW                           " tabla="SUC            " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSAL                                " atributo="SERIEALTAFW                             " tabla="SUC            " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSAL                                " atributo="HORAIMPO                                " tabla="SUC            " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSAL                                " atributo="HORAMODIFICACIONFW                      " tabla="SUC            " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSAL                                " atributo="SERIEMODIFICACIONFW                     " tabla="SUC            " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSAL                                " atributo="HORAEXPO                                " tabla="SUC            " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSAL                                " atributo="DIRECCION                               " tabla="SUC            " campo="CLDIR     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="70" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="Direccion                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSAL                                " atributo="ESTADOTRANSFERENCIA                     " tabla="SUC            " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado transferencia                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSAL                                " atributo="BASEDEDATOSALTAFW                       " tabla="SUC            " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSAL                                " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="SUC            " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSAL                                " atributo="CLASIFICACION                           " tabla="SUC            " campo="CLIMPD    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="402" etiqueta="Clasificación                                                                                                                                                   " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="4" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSAL                                " atributo="TELEFONO                                " tabla="SUC            " campo="CLTLF     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="404" etiqueta="Telefono                                                                                                                                                        " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSAL                                " atributo="IMAGEN                                  " tabla="SUC            " campo="CIMAGEN   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="180" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="20" etiqueta="Imagen                                                                                                                                                          " dominio="IMAGENCONRUTADINAMICA         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="3" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSAL                                " atributo="NUMERO                                  " tabla="SUC            " campo="CLNUM     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="406" etiqueta="Número                                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="99999                    " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSAL                                " atributo="FAX                                     " tabla="SUC            " campo="CLFAX     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="408" etiqueta="Fax                                                                                                                                                             " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSAL                                " atributo="CODIGO                                  " tabla="SUC            " campo="CODIGO    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="2" etiqueta="Código                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSAL                                " atributo="OBSERVACION                             " tabla="SUC            " campo="CLOBS     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="410" etiqueta="Observaciones                                                                                                                                                   " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSAL                                " atributo="FECHADEALTA                             " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha Alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="0" orden="2" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSAL                                " atributo="NOMBRE                                  " tabla="SUC            " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="4" etiqueta="Nombre                                                                                                                                                          " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSAL                                " atributo="EMAIL                                   " tabla="SUC            " campo="CLEMAIL   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="412" etiqueta="E-Mail                                                                                                                                                          " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSAL                                " atributo="PISO                                    " tabla="SUC            " campo="CLPISO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="3" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="414" etiqueta="Piso                                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSAL                                " atributo="FECHAULTIMAMODIFICACION                 " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Ultima Modificacion                                                                                                                                             " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="0" orden="3" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSAL                                " atributo="DEPARTAMENTO                            " tabla="SUC            " campo="CLDEPTO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="3" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="416" etiqueta="Departamento                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSAL                                " atributo="PAGINAWEB                               " tabla="SUC            " campo="CLPAGEWEB " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="418" etiqueta="Página Web                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSAL                                " atributo="LOCALIDAD                               " tabla="SUC            " campo="CLLOC     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="70" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="420" etiqueta="Localidad                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSAL                                " atributo="CONTACTO                                " tabla="SUC            " campo="CLCONTAC  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="422" etiqueta="Contacto                                                                                                                                                        " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSAL                                " atributo="TIPOINTERNO2                            " tabla="SUC            " campo="CLCFI     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="3                                                                                                                                                                                                                                                             " obligatorio="false" admitebusqueda="0" etiqueta="CFI                                                                                                                                                             " dominio="SINOGENERICO                  " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="5" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSAL                                " atributo="CODIGOPOSTAL                            " tabla="SUC            " campo="CLCP      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="424" etiqueta="Código Postal                                                                                                                                                   " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSAL                                " atributo="PROVINCIA                               " tabla="SUC            " campo="CLPRV     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="PROVINCIA                               " tipodato="C         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="426" etiqueta="Provincia                                                                                                                                                       " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVINCIA                               " atributo="DESCRIPCION                             " tabla="PROVINCI       " campo="PRV_DES   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="427" etiqueta="Detalle Pro.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join PROVINCI On SUC.CLPRV = PROVINCI.PRV_COD And  PROVINCI.PRV_COD != ''                                                                                                                                                                               " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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