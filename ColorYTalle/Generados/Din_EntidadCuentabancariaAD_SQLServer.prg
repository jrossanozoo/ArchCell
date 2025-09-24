
define class Din_EntidadCUENTABANCARIAAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_CUENTABANCARIA'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = []
	cExpresionCCPorCampos = []
	cTagClaveCandidata = ''
	cTagClavePk = '_132PK'
	cTablaPrincipal = 'CTABAN'
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
			local  lxCtabanFecimpo, lxCtabanFectrans, lxCtabanFmodifw, lxCtabanFaltafw, lxCtabanFecexpo, lxCtabanZadsfw, lxCtabanHoraexpo, lxCtabanHaltafw, lxCtabanSaltafw, lxCtabanHoraimpo, lxCtabanHmodifw, lxCtabanVmodifw, lxCtabanEsttrans, lxCtabanUmodifw, lxCtabanValtafw, lxCtabanUaltafw, lxCtabanSmodifw, lxCtabanBdaltafw, lxCtabanBdmodifw, lxCtabanTimestamp, lxCtabanTipagrupub, lxCtabanCbcod, lxCtabanCbdes, lxCtabanCbsucban, lxCtabanCbnum, lxCtabanCbcbu, lxCtabanCbmoneda, lxCtabanCbacuerdo, lxCtabanCbcuit, lxCtabanCbrazsoc, lxCtabanCbdir, lxCtabanCbfirma, lxCtabanCbobs
				lxCtabanFecimpo =  .Fechaimpo			lxCtabanFectrans =  .Fechatransferencia			lxCtabanFmodifw =  .Fechamodificacionfw			lxCtabanFaltafw =  .Fechaaltafw			lxCtabanFecexpo =  .Fechaexpo			lxCtabanZadsfw =  .Zadsfw			lxCtabanHoraexpo =  .Horaexpo			lxCtabanHaltafw =  .Horaaltafw			lxCtabanSaltafw =  .Seriealtafw			lxCtabanHoraimpo =  .Horaimpo			lxCtabanHmodifw =  .Horamodificacionfw			lxCtabanVmodifw =  .Versionmodificacionfw			lxCtabanEsttrans =  .Estadotransferencia			lxCtabanUmodifw =  .Usuariomodificacionfw			lxCtabanValtafw =  .Versionaltafw			lxCtabanUaltafw =  .Usuarioaltafw			lxCtabanSmodifw =  .Seriemodificacionfw			lxCtabanBdaltafw =  .Basededatosaltafw			lxCtabanBdmodifw =  .Basededatosmodificacionfw			lxCtabanTimestamp = goLibrerias.ObtenerTimestamp()			lxCtabanTipagrupub =  .Tipoagrupamientopublicaciones			lxCtabanCbcod =  .Codigo			lxCtabanCbdes =  .Descripcion			lxCtabanCbsucban =  upper( .SucursalBancaria_PK ) 			lxCtabanCbnum =  .Numero			lxCtabanCbcbu =  .Cbu			lxCtabanCbmoneda =  upper( .MonedaCuenta_PK ) 			lxCtabanCbacuerdo =  .Acuerdo			lxCtabanCbcuit =  .Codigotributariolibrador			lxCtabanCbrazsoc =  .Razonsociallibrador			lxCtabanCbdir =  .Direccion			lxCtabanCbfirma =  .Firmantes			lxCtabanCbobs =  .Observacion
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxCtabanCbcod = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.CTABAN ( "Fecimpo","Fectrans","Fmodifw","Faltafw","Fecexpo","Zadsfw","Horaexpo","Haltafw","Saltafw","Horaimpo","Hmodifw","Vmodifw","Esttrans","Umodifw","Valtafw","Ualtafw","Smodifw","Bdaltafw","Bdmodifw","Timestamp","Tipagrupub","Cbcod","Cbdes","Cbsucban","Cbnum","Cbcbu","Cbmoneda","Cbacuerdo","Cbcuit","Cbrazsoc","Cbdir","Cbfirma","Cbobs" ) values ( <<"'" + this.ConvertirDateSql( lxCtabanFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCtabanFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCtabanFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCtabanFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCtabanFecexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCtabanZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCtabanHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCtabanHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCtabanSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCtabanHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCtabanHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCtabanVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCtabanEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCtabanUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCtabanValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCtabanUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCtabanSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCtabanBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCtabanBdmodifw ) + "'" >>, <<lxCtabanTimestamp >>, <<lxCtabanTipagrupub >>, <<"'" + this.FormatearTextoSql( lxCtabanCbcod ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCtabanCbdes ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCtabanCbsucban ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCtabanCbnum ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCtabanCbcbu ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCtabanCbmoneda ) + "'" >>, <<lxCtabanCbacuerdo >>, <<"'" + this.FormatearTextoSql( lxCtabanCbcuit ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCtabanCbrazsoc ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCtabanCbdir ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCtabanCbfirma ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCtabanCbobs ) + "'" >> )
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
		this.ComprobarTransaccion()
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = lxValorClavePrimaria


			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.AgruPubliDetalle
				if this.oEntidad.AgruPubliDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxAgrupamiento_PK = loItem.Agrupamiento_PK
					lxAgrupamientodetalle = loItem.Agrupamientodetalle
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.AgruPub132("NROITEM","Codigo","Agrup","AgrupDes" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxAgrupamiento_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxAgrupamientodetalle ) + "'">> ) 
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
		this.oEntidad.Timestamp = lxCtabanTimestamp
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
			local  lxCtabanFecimpo, lxCtabanFectrans, lxCtabanFmodifw, lxCtabanFaltafw, lxCtabanFecexpo, lxCtabanZadsfw, lxCtabanHoraexpo, lxCtabanHaltafw, lxCtabanSaltafw, lxCtabanHoraimpo, lxCtabanHmodifw, lxCtabanVmodifw, lxCtabanEsttrans, lxCtabanUmodifw, lxCtabanValtafw, lxCtabanUaltafw, lxCtabanSmodifw, lxCtabanBdaltafw, lxCtabanBdmodifw, lxCtabanTimestamp, lxCtabanTipagrupub, lxCtabanCbcod, lxCtabanCbdes, lxCtabanCbsucban, lxCtabanCbnum, lxCtabanCbcbu, lxCtabanCbmoneda, lxCtabanCbacuerdo, lxCtabanCbcuit, lxCtabanCbrazsoc, lxCtabanCbdir, lxCtabanCbfirma, lxCtabanCbobs
				lxCtabanFecimpo =  .Fechaimpo			lxCtabanFectrans =  .Fechatransferencia			lxCtabanFmodifw =  .Fechamodificacionfw			lxCtabanFaltafw =  .Fechaaltafw			lxCtabanFecexpo =  .Fechaexpo			lxCtabanZadsfw =  .Zadsfw			lxCtabanHoraexpo =  .Horaexpo			lxCtabanHaltafw =  .Horaaltafw			lxCtabanSaltafw =  .Seriealtafw			lxCtabanHoraimpo =  .Horaimpo			lxCtabanHmodifw =  .Horamodificacionfw			lxCtabanVmodifw =  .Versionmodificacionfw			lxCtabanEsttrans =  .Estadotransferencia			lxCtabanUmodifw =  .Usuariomodificacionfw			lxCtabanValtafw =  .Versionaltafw			lxCtabanUaltafw =  .Usuarioaltafw			lxCtabanSmodifw =  .Seriemodificacionfw			lxCtabanBdaltafw =  .Basededatosaltafw			lxCtabanBdmodifw =  .Basededatosmodificacionfw			lxCtabanTimestamp = goLibrerias.ObtenerTimestamp()			lxCtabanTipagrupub =  .Tipoagrupamientopublicaciones			lxCtabanCbcod =  .Codigo			lxCtabanCbdes =  .Descripcion			lxCtabanCbsucban =  upper( .SucursalBancaria_PK ) 			lxCtabanCbnum =  .Numero			lxCtabanCbcbu =  .Cbu			lxCtabanCbmoneda =  upper( .MonedaCuenta_PK ) 			lxCtabanCbacuerdo =  .Acuerdo			lxCtabanCbcuit =  .Codigotributariolibrador			lxCtabanCbrazsoc =  .Razonsociallibrador			lxCtabanCbdir =  .Direccion			lxCtabanCbfirma =  .Firmantes			lxCtabanCbobs =  .Observacion
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
				update ZooLogic.CTABAN set "Fecimpo" = <<"'" + this.ConvertirDateSql( lxCtabanFecimpo ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxCtabanFectrans ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxCtabanFmodifw ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxCtabanFaltafw ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxCtabanFecexpo ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxCtabanZadsfw ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxCtabanHoraexpo ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxCtabanHaltafw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxCtabanSaltafw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxCtabanHoraimpo ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxCtabanHmodifw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxCtabanVmodifw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxCtabanEsttrans ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxCtabanUmodifw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxCtabanValtafw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxCtabanUaltafw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxCtabanSmodifw ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxCtabanBdaltafw ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxCtabanBdmodifw ) + "'">>,"Timestamp" = <<lxCtabanTimestamp>>,"Tipagrupub" = <<lxCtabanTipagrupub>>,"Cbcod" = <<"'" + this.FormatearTextoSql( lxCtabanCbcod ) + "'">>,"Cbdes" = <<"'" + this.FormatearTextoSql( lxCtabanCbdes ) + "'">>,"Cbsucban" = <<"'" + this.FormatearTextoSql( lxCtabanCbsucban ) + "'">>,"Cbnum" = <<"'" + this.FormatearTextoSql( lxCtabanCbnum ) + "'">>,"Cbcbu" = <<"'" + this.FormatearTextoSql( lxCtabanCbcbu ) + "'">>,"Cbmoneda" = <<"'" + this.FormatearTextoSql( lxCtabanCbmoneda ) + "'">>,"Cbacuerdo" = <<lxCtabanCbacuerdo>>,"Cbcuit" = <<"'" + this.FormatearTextoSql( lxCtabanCbcuit ) + "'">>,"Cbrazsoc" = <<"'" + this.FormatearTextoSql( lxCtabanCbrazsoc ) + "'">>,"Cbdir" = <<"'" + this.FormatearTextoSql( lxCtabanCbdir ) + "'">>,"Cbfirma" = <<"'" + this.FormatearTextoSql( lxCtabanCbfirma ) + "'">>,"Cbobs" = <<"'" + this.FormatearTextoSql( lxCtabanCbobs ) + "'">> where "Cbcod" = <<"'" + this.FormatearTextoSql( lxCtabanCbcod ) + "'">> and  CTABAN.CBCOD != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			this.ComprobarResultadoDeEjecucionDelUpdate()
		this.ComprobarTransaccion()
			this.oConexion.EjecutarSql( 'delete from ZooLogic.AgruPub132 where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.AgruPubliDetalle
				if this.oEntidad.AgruPubliDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxAgrupamiento_PK = loItem.Agrupamiento_PK
					lxAgrupamientodetalle = loItem.Agrupamientodetalle
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.AgruPub132("NROITEM","Codigo","Agrup","AgrupDes" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxAgrupamiento_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxAgrupamientodetalle ) + "'">> ) 
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
		this.oEntidad.Timestamp = lxCtabanTimestamp
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 CBCod from ZooLogic.CTABAN where " + this.ConvertirFuncionesSql( " CTABAN.CBCOD != ''" ) )
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
			Local lxCtabanCbcod
			lxCtabanCbcod = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Zadsfw" as "Zadsfw", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Esttrans" as "Estadotransferencia", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Timestamp" as "Timestamp", "Tipagrupub" as "Tipoagrupamientopublicaciones", "Cbcod" as "Codigo", "Cbdes" as "Descripcion", "Cbsucban" as "Sucursalbancaria", "Cbnum" as "Numero", "Cbcbu" as "Cbu", "Cbmoneda" as "Monedacuenta", "Cbacuerdo" as "Acuerdo", "Cbcuit" as "Codigotributariolibrador", "Cbrazsoc" as "Razonsociallibrador", "Cbdir" as "Direccion", "Cbfirma" as "Firmantes", "Cbobs" as "Observacion" from ZooLogic.CTABAN where "Cbcod" = <<"'" + this.FormatearTextoSql( lxCtabanCbcod ) + "'">> and  CTABAN.CBCOD != ''
			endtext
			use in select('c_CUENTABANCARIA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CUENTABANCARIA', set( 'Datasession' ) )

			if reccount( 'c_CUENTABANCARIA' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Agrup" as "Agrupamiento", "Agrupdes" as "Agrupamientodetalle" from ZooLogic.AgruPub132 where Codigo = <<"'" + this.FormatearTextoSql( c_CUENTABANCARIA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_AgruPubliDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_AgruPubliDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_AgruPubliDetalle
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxCtabanCbcod as Variant
		llRetorno = .t.
		lxCtabanCbcod = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.CTABAN where "Cbcod" = <<"'" + this.FormatearTextoSql( lxCtabanCbcod ) + "'">> and  CTABAN.CBCOD != ''
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
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Zadsfw" as "Zadsfw", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Esttrans" as "Estadotransferencia", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Timestamp" as "Timestamp", "Tipagrupub" as "Tipoagrupamientopublicaciones", "Cbcod" as "Codigo", "Cbdes" as "Descripcion", "Cbsucban" as "Sucursalbancaria", "Cbnum" as "Numero", "Cbcbu" as "Cbu", "Cbmoneda" as "Monedacuenta", "Cbacuerdo" as "Acuerdo", "Cbcuit" as "Codigotributariolibrador", "Cbrazsoc" as "Razonsociallibrador", "Cbdir" as "Direccion", "Cbfirma" as "Firmantes", "Cbobs" as "Observacion" from ZooLogic.CTABAN where  CTABAN.CBCOD != '' order by CBCod
			endtext
			use in select('c_CUENTABANCARIA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CUENTABANCARIA', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Agrup" as "Agrupamiento", "Agrupdes" as "Agrupamientodetalle" from ZooLogic.AgruPub132 where Codigo = <<"'" + this.FormatearTextoSql( c_CUENTABANCARIA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_AgruPubliDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_AgruPubliDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_AgruPubliDetalle
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
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Zadsfw" as "Zadsfw", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Esttrans" as "Estadotransferencia", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Timestamp" as "Timestamp", "Tipagrupub" as "Tipoagrupamientopublicaciones", "Cbcod" as "Codigo", "Cbdes" as "Descripcion", "Cbsucban" as "Sucursalbancaria", "Cbnum" as "Numero", "Cbcbu" as "Cbu", "Cbmoneda" as "Monedacuenta", "Cbacuerdo" as "Acuerdo", "Cbcuit" as "Codigotributariolibrador", "Cbrazsoc" as "Razonsociallibrador", "Cbdir" as "Direccion", "Cbfirma" as "Firmantes", "Cbobs" as "Observacion" from ZooLogic.CTABAN where  funciones.padr( CBCod, 5, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  CTABAN.CBCOD != '' order by CBCod
			endtext
			use in select('c_CUENTABANCARIA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CUENTABANCARIA', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Agrup" as "Agrupamiento", "Agrupdes" as "Agrupamientodetalle" from ZooLogic.AgruPub132 where Codigo = <<"'" + this.FormatearTextoSql( c_CUENTABANCARIA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_AgruPubliDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_AgruPubliDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_AgruPubliDetalle
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
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Zadsfw" as "Zadsfw", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Esttrans" as "Estadotransferencia", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Timestamp" as "Timestamp", "Tipagrupub" as "Tipoagrupamientopublicaciones", "Cbcod" as "Codigo", "Cbdes" as "Descripcion", "Cbsucban" as "Sucursalbancaria", "Cbnum" as "Numero", "Cbcbu" as "Cbu", "Cbmoneda" as "Monedacuenta", "Cbacuerdo" as "Acuerdo", "Cbcuit" as "Codigotributariolibrador", "Cbrazsoc" as "Razonsociallibrador", "Cbdir" as "Direccion", "Cbfirma" as "Firmantes", "Cbobs" as "Observacion" from ZooLogic.CTABAN where  funciones.padr( CBCod, 5, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  CTABAN.CBCOD != '' order by CBCod desc
			endtext
			use in select('c_CUENTABANCARIA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CUENTABANCARIA', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Agrup" as "Agrupamiento", "Agrupdes" as "Agrupamientodetalle" from ZooLogic.AgruPub132 where Codigo = <<"'" + this.FormatearTextoSql( c_CUENTABANCARIA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_AgruPubliDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_AgruPubliDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_AgruPubliDetalle
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
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Zadsfw" as "Zadsfw", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Esttrans" as "Estadotransferencia", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Timestamp" as "Timestamp", "Tipagrupub" as "Tipoagrupamientopublicaciones", "Cbcod" as "Codigo", "Cbdes" as "Descripcion", "Cbsucban" as "Sucursalbancaria", "Cbnum" as "Numero", "Cbcbu" as "Cbu", "Cbmoneda" as "Monedacuenta", "Cbacuerdo" as "Acuerdo", "Cbcuit" as "Codigotributariolibrador", "Cbrazsoc" as "Razonsociallibrador", "Cbdir" as "Direccion", "Cbfirma" as "Firmantes", "Cbobs" as "Observacion" from ZooLogic.CTABAN where  CTABAN.CBCOD != '' order by CBCod desc
			endtext
			use in select('c_CUENTABANCARIA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CUENTABANCARIA', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Agrup" as "Agrupamiento", "Agrupdes" as "Agrupamientodetalle" from ZooLogic.AgruPub132 where Codigo = <<"'" + this.FormatearTextoSql( c_CUENTABANCARIA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_AgruPubliDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_AgruPubliDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_AgruPubliDetalle
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
			lcXml = this.oConexion.EjecutarSql( "select Fecimpo,Fectrans,Fmodifw,Faltafw,Fecexpo,Zadsfw,Horaexpo,Haltafw,Saltafw,Horaimpo,Hmodifw,Vm" + ;
"odifw,Esttrans,Umodifw,Valtafw,Ualtafw,Smodifw,Bdaltafw,Bdmodifw,Timestamp,Tipagrupub,Cbcod,Cbdes,Cb" + ;
"sucban,Cbnum,Cbcbu,Cbmoneda,Cbacuerdo,Cbcuit,Cbrazsoc,Cbdir,Cbfirma,Cbobs" + ;
" from ZooLogic.CTABAN where  CTABAN.CBCOD != '' and " + lcFiltro )
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
			local  lxCtabanFecimpo, lxCtabanFectrans, lxCtabanFmodifw, lxCtabanFaltafw, lxCtabanFecexpo, lxCtabanZadsfw, lxCtabanHoraexpo, lxCtabanHaltafw, lxCtabanSaltafw, lxCtabanHoraimpo, lxCtabanHmodifw, lxCtabanVmodifw, lxCtabanEsttrans, lxCtabanUmodifw, lxCtabanValtafw, lxCtabanUaltafw, lxCtabanSmodifw, lxCtabanBdaltafw, lxCtabanBdmodifw, lxCtabanTimestamp, lxCtabanTipagrupub, lxCtabanCbcod, lxCtabanCbdes, lxCtabanCbsucban, lxCtabanCbnum, lxCtabanCbcbu, lxCtabanCbmoneda, lxCtabanCbacuerdo, lxCtabanCbcuit, lxCtabanCbrazsoc, lxCtabanCbdir, lxCtabanCbfirma, lxCtabanCbobs
				lxCtabanFecimpo = ctod( '  /  /    ' )			lxCtabanFectrans = ctod( '  /  /    ' )			lxCtabanFmodifw = ctod( '  /  /    ' )			lxCtabanFaltafw = ctod( '  /  /    ' )			lxCtabanFecexpo = ctod( '  /  /    ' )			lxCtabanZadsfw = []			lxCtabanHoraexpo = []			lxCtabanHaltafw = []			lxCtabanSaltafw = []			lxCtabanHoraimpo = []			lxCtabanHmodifw = []			lxCtabanVmodifw = []			lxCtabanEsttrans = []			lxCtabanUmodifw = []			lxCtabanValtafw = []			lxCtabanUaltafw = []			lxCtabanSmodifw = []			lxCtabanBdaltafw = []			lxCtabanBdmodifw = []			lxCtabanTimestamp = goLibrerias.ObtenerTimestamp()			lxCtabanTipagrupub = 0			lxCtabanCbcod = []			lxCtabanCbdes = []			lxCtabanCbsucban = []			lxCtabanCbnum = []			lxCtabanCbcbu = []			lxCtabanCbmoneda = []			lxCtabanCbacuerdo = 0			lxCtabanCbcuit = []			lxCtabanCbrazsoc = []			lxCtabanCbdir = []			lxCtabanCbfirma = []			lxCtabanCbobs = []
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.AgruPub132 where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( [delete from ZooLogic.CTABAN where "CBCod" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'CTABAN' + '_' + tcCampo
			lcMemoAscii = ''

			lnIndice = alen(.aSqlMemos)
			lnIndice = iif(lnIndice = 1, 1, lnIndice + 1 )
			dimension .aSqlMemos(lnIndice)

			.aSqlMemos(lnIndice) = 'delete from ' + lcTabla + ' where CBCod = ' + txValorClavePrimaria
			.GenerarSentenciasInsertTablaMemo( lcValor, lcTabla, txValorClavePrimaria )
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerSentenciaInsertMemo( tcTabla as String, txValorClavePrimaria as String, tcOrden as String, tcTexto as String ) as String
		return "Insert  into " + tcTabla + "(CBCod, Orden, texto ) values ( " + txValorClavePrimaria + "," + tcOrden + ",'"+ tcTexto + "')"
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosEntidad( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  CTABAN.CBCOD != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Zadsfw" as "Zadsfw", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Esttrans" as "Estadotransferencia", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Timestamp" as "Timestamp", "Tipagrupub" as "Tipoagrupamientopublicaciones", "Cbcod" as "Codigo", "Cbdes" as "Descripcion", "Cbsucban" as "Sucursalbancaria", "Cbnum" as "Numero", "Cbcbu" as "Cbu", "Cbmoneda" as "Monedacuenta", "Cbacuerdo" as "Acuerdo", "Cbcuit" as "Codigotributariolibrador", "Cbrazsoc" as "Razonsociallibrador", "Cbdir" as "Direccion", "Cbfirma" as "Firmantes", "Cbobs" as "Observacion"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'CTABAN', '', tnTope )
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
	Function ObtenerDatosDetalleAgruPubliDetalle( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  AGRUPUB132.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Nroitem" as "Nroitem", "Codigo" as "Codigo", "Agrup" as "Agrupamiento", "Agrupdes" as "Agrupamientodetalle"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleAgruPubliDetalle( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'AgruPub132', 'AgruPubliDetalle', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleAgruPubliDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleAgruPubliDetalle( lcAtributo )
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
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'TIMESTAMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIMESTAMP AS TIMESTAMP'
				Case lcAtributo == 'TIPOAGRUPAMIENTOPUBLICACIONES'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPAGRUPUB AS TIPOAGRUPAMIENTOPUBLICACIONES'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CBCOD AS CODIGO'
				Case lcAtributo == 'DESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CBDES AS DESCRIPCION'
				Case lcAtributo == 'SUCURSALBANCARIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CBSUCBAN AS SUCURSALBANCARIA'
				Case lcAtributo == 'NUMERO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CBNUM AS NUMERO'
				Case lcAtributo == 'CBU'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CBCBU AS CBU'
				Case lcAtributo == 'MONEDACUENTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CBMONEDA AS MONEDACUENTA'
				Case lcAtributo == 'ACUERDO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CBACUERDO AS ACUERDO'
				Case lcAtributo == 'CODIGOTRIBUTARIOLIBRADOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CBCUIT AS CODIGOTRIBUTARIOLIBRADOR'
				Case lcAtributo == 'RAZONSOCIALLIBRADOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CBRAZSOC AS RAZONSOCIALLIBRADOR'
				Case lcAtributo == 'DIRECCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CBDIR AS DIRECCION'
				Case lcAtributo == 'FIRMANTES'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CBFIRMA AS FIRMANTES'
				Case lcAtributo == 'OBSERVACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CBOBS AS OBSERVACION'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleAgruPubliDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'AGRUPAMIENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AGRUP AS AGRUPAMIENTO'
				Case lcAtributo == 'AGRUPAMIENTODETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AGRUPDES AS AGRUPAMIENTODETALLE'
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
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'TIMESTAMP'
				lcCampo = 'TIMESTAMP'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOAGRUPAMIENTOPUBLICACIONES'
				lcCampo = 'TIPAGRUPUB'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CBCOD'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCION'
				lcCampo = 'CBDES'
			Case upper( alltrim( tcAtributo ) ) == 'SUCURSALBANCARIA'
				lcCampo = 'CBSUCBAN'
			Case upper( alltrim( tcAtributo ) ) == 'NUMERO'
				lcCampo = 'CBNUM'
			Case upper( alltrim( tcAtributo ) ) == 'CBU'
				lcCampo = 'CBCBU'
			Case upper( alltrim( tcAtributo ) ) == 'MONEDACUENTA'
				lcCampo = 'CBMONEDA'
			Case upper( alltrim( tcAtributo ) ) == 'ACUERDO'
				lcCampo = 'CBACUERDO'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGOTRIBUTARIOLIBRADOR'
				lcCampo = 'CBCUIT'
			Case upper( alltrim( tcAtributo ) ) == 'RAZONSOCIALLIBRADOR'
				lcCampo = 'CBRAZSOC'
			Case upper( alltrim( tcAtributo ) ) == 'DIRECCION'
				lcCampo = 'CBDIR'
			Case upper( alltrim( tcAtributo ) ) == 'FIRMANTES'
				lcCampo = 'CBFIRMA'
			Case upper( alltrim( tcAtributo ) ) == 'OBSERVACION'
				lcCampo = 'CBOBS'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleAgruPubliDetalle( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'AGRUPAMIENTO'
				lcCampo = 'AGRUP'
			Case upper( alltrim( tcAtributo ) ) == 'AGRUPAMIENTODETALLE'
				lcCampo = 'AGRUPDES'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerTablaDetalle( tcDetalle as string ) as String
		local lcRetorno as string
		lcRetorno = ''
		if upper( alltrim( tcDetalle ) ) == 'AGRUPUBLIDETALLE'
			lcRetorno = 'AGRUPUB132'
		EndIf
		return lcRetorno
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasInsert() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcSentencia as string, loItem as object
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxCtabanFecimpo, lxCtabanFectrans, lxCtabanFmodifw, lxCtabanFaltafw, lxCtabanFecexpo, lxCtabanZadsfw, lxCtabanHoraexpo, lxCtabanHaltafw, lxCtabanSaltafw, lxCtabanHoraimpo, lxCtabanHmodifw, lxCtabanVmodifw, lxCtabanEsttrans, lxCtabanUmodifw, lxCtabanValtafw, lxCtabanUaltafw, lxCtabanSmodifw, lxCtabanBdaltafw, lxCtabanBdmodifw, lxCtabanTimestamp, lxCtabanTipagrupub, lxCtabanCbcod, lxCtabanCbdes, lxCtabanCbsucban, lxCtabanCbnum, lxCtabanCbcbu, lxCtabanCbmoneda, lxCtabanCbacuerdo, lxCtabanCbcuit, lxCtabanCbrazsoc, lxCtabanCbdir, lxCtabanCbfirma, lxCtabanCbobs
				lxCtabanFecimpo =  .Fechaimpo			lxCtabanFectrans =  .Fechatransferencia			lxCtabanFmodifw =  .Fechamodificacionfw			lxCtabanFaltafw =  .Fechaaltafw			lxCtabanFecexpo =  .Fechaexpo			lxCtabanZadsfw =  .Zadsfw			lxCtabanHoraexpo =  .Horaexpo			lxCtabanHaltafw =  .Horaaltafw			lxCtabanSaltafw =  .Seriealtafw			lxCtabanHoraimpo =  .Horaimpo			lxCtabanHmodifw =  .Horamodificacionfw			lxCtabanVmodifw =  .Versionmodificacionfw			lxCtabanEsttrans =  .Estadotransferencia			lxCtabanUmodifw =  .Usuariomodificacionfw			lxCtabanValtafw =  .Versionaltafw			lxCtabanUaltafw =  .Usuarioaltafw			lxCtabanSmodifw =  .Seriemodificacionfw			lxCtabanBdaltafw =  .Basededatosaltafw			lxCtabanBdmodifw =  .Basededatosmodificacionfw			lxCtabanTimestamp = goLibrerias.ObtenerTimestamp()			lxCtabanTipagrupub =  .Tipoagrupamientopublicaciones			lxCtabanCbcod =  .Codigo			lxCtabanCbdes =  .Descripcion			lxCtabanCbsucban =  upper( .SucursalBancaria_PK ) 			lxCtabanCbnum =  .Numero			lxCtabanCbcbu =  .Cbu			lxCtabanCbmoneda =  upper( .MonedaCuenta_PK ) 			lxCtabanCbacuerdo =  .Acuerdo			lxCtabanCbcuit =  .Codigotributariolibrador			lxCtabanCbrazsoc =  .Razonsociallibrador			lxCtabanCbdir =  .Direccion			lxCtabanCbfirma =  .Firmantes			lxCtabanCbobs =  .Observacion
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.CTABAN ( "Fecimpo","Fectrans","Fmodifw","Faltafw","Fecexpo","Zadsfw","Horaexpo","Haltafw","Saltafw","Horaimpo","Hmodifw","Vmodifw","Esttrans","Umodifw","Valtafw","Ualtafw","Smodifw","Bdaltafw","Bdmodifw","Timestamp","Tipagrupub","Cbcod","Cbdes","Cbsucban","Cbnum","Cbcbu","Cbmoneda","Cbacuerdo","Cbcuit","Cbrazsoc","Cbdir","Cbfirma","Cbobs" ) values ( <<"'" + this.ConvertirDateSql( lxCtabanFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCtabanFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCtabanFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCtabanFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCtabanFecexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCtabanZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCtabanHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCtabanHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCtabanSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCtabanHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCtabanHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCtabanVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCtabanEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCtabanUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCtabanValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCtabanUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCtabanSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCtabanBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCtabanBdmodifw ) + "'" >>, <<lxCtabanTimestamp >>, <<lxCtabanTipagrupub >>, <<"'" + this.FormatearTextoSql( lxCtabanCbcod ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCtabanCbdes ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCtabanCbsucban ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCtabanCbnum ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCtabanCbcbu ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCtabanCbmoneda ) + "'" >>, <<lxCtabanCbacuerdo >>, <<"'" + this.FormatearTextoSql( lxCtabanCbcuit ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCtabanCbrazsoc ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCtabanCbdir ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCtabanCbfirma ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCtabanCbobs ) + "'" >> )
		endtext
		loColeccion.cTabla = 'CTABAN' 
		loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		With this
			local lcValorClavePrimariaString as String
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.AgruPubliDetalle
				if this.oEntidad.AgruPubliDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxAgrupamiento_PK = loItem.Agrupamiento_PK
					lxAgrupamientodetalle = loItem.Agrupamientodetalle
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.AgruPub132("NROITEM","Codigo","Agrup","AgrupDes" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxAgrupamiento_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxAgrupamientodetalle ) + "'">> ) 
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
			local  lxCtabanFecimpo, lxCtabanFectrans, lxCtabanFmodifw, lxCtabanFaltafw, lxCtabanFecexpo, lxCtabanZadsfw, lxCtabanHoraexpo, lxCtabanHaltafw, lxCtabanSaltafw, lxCtabanHoraimpo, lxCtabanHmodifw, lxCtabanVmodifw, lxCtabanEsttrans, lxCtabanUmodifw, lxCtabanValtafw, lxCtabanUaltafw, lxCtabanSmodifw, lxCtabanBdaltafw, lxCtabanBdmodifw, lxCtabanTimestamp, lxCtabanTipagrupub, lxCtabanCbcod, lxCtabanCbdes, lxCtabanCbsucban, lxCtabanCbnum, lxCtabanCbcbu, lxCtabanCbmoneda, lxCtabanCbacuerdo, lxCtabanCbcuit, lxCtabanCbrazsoc, lxCtabanCbdir, lxCtabanCbfirma, lxCtabanCbobs
				lxCtabanFecimpo =  .Fechaimpo			lxCtabanFectrans =  .Fechatransferencia			lxCtabanFmodifw =  .Fechamodificacionfw			lxCtabanFaltafw =  .Fechaaltafw			lxCtabanFecexpo =  .Fechaexpo			lxCtabanZadsfw =  .Zadsfw			lxCtabanHoraexpo =  .Horaexpo			lxCtabanHaltafw =  .Horaaltafw			lxCtabanSaltafw =  .Seriealtafw			lxCtabanHoraimpo =  .Horaimpo			lxCtabanHmodifw =  .Horamodificacionfw			lxCtabanVmodifw =  .Versionmodificacionfw			lxCtabanEsttrans =  .Estadotransferencia			lxCtabanUmodifw =  .Usuariomodificacionfw			lxCtabanValtafw =  .Versionaltafw			lxCtabanUaltafw =  .Usuarioaltafw			lxCtabanSmodifw =  .Seriemodificacionfw			lxCtabanBdaltafw =  .Basededatosaltafw			lxCtabanBdmodifw =  .Basededatosmodificacionfw			lxCtabanTimestamp = goLibrerias.ObtenerTimestamp()			lxCtabanTipagrupub =  .Tipoagrupamientopublicaciones			lxCtabanCbcod =  .Codigo			lxCtabanCbdes =  .Descripcion			lxCtabanCbsucban =  upper( .SucursalBancaria_PK ) 			lxCtabanCbnum =  .Numero			lxCtabanCbcbu =  .Cbu			lxCtabanCbmoneda =  upper( .MonedaCuenta_PK ) 			lxCtabanCbacuerdo =  .Acuerdo			lxCtabanCbcuit =  .Codigotributariolibrador			lxCtabanCbrazsoc =  .Razonsociallibrador			lxCtabanCbdir =  .Direccion			lxCtabanCbfirma =  .Firmantes			lxCtabanCbobs =  .Observacion
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Cbcod" = ] + lcValorClavePrimariaString  + [ and  CTABAN.CBCOD != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.CTABAN set "Fecimpo" = <<"'" + this.ConvertirDateSql( lxCtabanFecimpo ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxCtabanFectrans ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxCtabanFmodifw ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxCtabanFaltafw ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxCtabanFecexpo ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxCtabanZadsfw ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxCtabanHoraexpo ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxCtabanHaltafw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxCtabanSaltafw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxCtabanHoraimpo ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxCtabanHmodifw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxCtabanVmodifw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxCtabanEsttrans ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxCtabanUmodifw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxCtabanValtafw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxCtabanUaltafw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxCtabanSmodifw ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxCtabanBdaltafw ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxCtabanBdmodifw ) + "'">>, "Timestamp" = <<lxCtabanTimestamp>>, "Tipagrupub" = <<lxCtabanTipagrupub>>, "Cbcod" = <<"'" + this.FormatearTextoSql( lxCtabanCbcod ) + "'">>, "Cbdes" = <<"'" + this.FormatearTextoSql( lxCtabanCbdes ) + "'">>, "Cbsucban" = <<"'" + this.FormatearTextoSql( lxCtabanCbsucban ) + "'">>, "Cbnum" = <<"'" + this.FormatearTextoSql( lxCtabanCbnum ) + "'">>, "Cbcbu" = <<"'" + this.FormatearTextoSql( lxCtabanCbcbu ) + "'">>, "Cbmoneda" = <<"'" + this.FormatearTextoSql( lxCtabanCbmoneda ) + "'">>, "Cbacuerdo" = <<lxCtabanCbacuerdo>>, "Cbcuit" = <<"'" + this.FormatearTextoSql( lxCtabanCbcuit ) + "'">>, "Cbrazsoc" = <<"'" + this.FormatearTextoSql( lxCtabanCbrazsoc ) + "'">>, "Cbdir" = <<"'" + this.FormatearTextoSql( lxCtabanCbdir ) + "'">>, "Cbfirma" = <<"'" + this.FormatearTextoSql( lxCtabanCbfirma ) + "'">>, "Cbobs" = <<"'" + this.FormatearTextoSql( lxCtabanCbobs ) + "'">> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'CTABAN' 
		loColeccion.agregar( strtran(  lcSentencia, chr( 9 ), '' ) )
			loColeccion.Agregar([delete from ZooLogic.AgruPub132 where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.AgruPubliDetalle
				if this.oEntidad.AgruPubliDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxAgrupamiento_PK = loItem.Agrupamiento_PK
					lxAgrupamientodetalle = loItem.Agrupamientodetalle
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.AgruPub132("NROITEM","Codigo","Agrup","AgrupDes" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxAgrupamiento_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxAgrupamientodetalle ) + "'">> ) 
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

			lcFiltro = ["Cbcod" = ] + lcValorClavePrimariaString  + [ and  CTABAN.CBCOD != '']
		loColeccion.Agregar( 'delete from ZooLogic.CTABAN where ' + lcFiltro )
			loColeccion.Agregar([delete from ZooLogic.AgruPub132 where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.cTabla = 'CTABAN' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.CTABAN where  CTABAN.CBCOD != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.CTABAN where CBCod = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  CTABAN.CBCOD != ''" )
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
		lcCursor = This.oEntidad.cPrefijoRecibir + 'CUENTABANCARIA'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.CTABAN Where CBCod = ] + "'" + this.FormatearTextoSql( &lcCursor..CBCod ) + "'", 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					this.oConexion.EjecutarSql( [UPDATE ZooLogic.CTABAN set  FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, TIMESTAMP = ] + transform( &lcCursor..TIMESTAMP )+ [, tipagrupub = ] + transform( &lcCursor..tipagrupub )+ [, CBCod = ] + "'" + this.FormatearTextoSql( &lcCursor..CBCod ) + "'"+ [, CBDes = ] + "'" + this.FormatearTextoSql( &lcCursor..CBDes ) + "'"+ [, CBSucBan = ] + "'" + this.FormatearTextoSql( &lcCursor..CBSucBan ) + "'"+ [, CBNum = ] + "'" + this.FormatearTextoSql( &lcCursor..CBNum ) + "'"+ [, CBCBU = ] + "'" + this.FormatearTextoSql( &lcCursor..CBCBU ) + "'"+ [, CBMoneda = ] + "'" + this.FormatearTextoSql( &lcCursor..CBMoneda ) + "'"+ [, CBAcuerdo = ] + transform( &lcCursor..CBAcuerdo )+ [, CBCuit = ] + "'" + this.FormatearTextoSql( &lcCursor..CBCuit ) + "'"+ [, CBRazSoc = ] + "'" + this.FormatearTextoSql( &lcCursor..CBRazSoc ) + "'"+ [, CBDir = ] + "'" + this.FormatearTextoSql( &lcCursor..CBDir ) + "'"+ [, CBFirma = ] + "'" + this.FormatearTextoSql( &lcCursor..CBFirma ) + "'"+ [, CBObs = ] + "'" + this.FormatearTextoSql( &lcCursor..CBObs ) + "'" + [ Where CBCod = ] + "'" + this.FormatearTextoSql( &lcCursor..CBCod ) + "'" )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
				endIf
			else
				Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
				Text to lcCampos noShow
					 FECIMPO, FECTRANS, FMODIFW, FALTAFW, FECEXPO, ZADSFW, HORAEXPO, HALTAFW, SALTAFW, HORAIMPO, HMODIFW, VMODIFW, ESTTRANS, UMODIFW, VALTAFW, UALTAFW, SMODIFW, BDALTAFW, BDMODIFW, TIMESTAMP, tipagrupub, CBCod, CBDes, CBSucBan, CBNum, CBCBU, CBMoneda, CBAcuerdo, CBCuit, CBRazSoc, CBDir, CBFirma, CBObs
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + transform( &lcCursor..TIMESTAMP ) + ',' + transform( &lcCursor..tipagrupub )
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..CBCod ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CBDes ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CBSucBan ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CBNum ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CBCBU ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CBMoneda ) + "'" + ',' + transform( &lcCursor..CBAcuerdo )
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..CBCuit ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CBRazSoc ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CBDir ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CBFirma ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CBObs ) + "'"
lcValoresCampos = substr(lcValoresCampos,2) 

				this.oConexion.EjecutarSql( [Insert into ZooLogic.CTABAN ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
				this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'CUENTABANCARIA'
		if This.ActualizaEnRecepcion()
		Local lcIn as String, lcCantRegistros as Integer
		Select( lcCursor )
		Count to lcCantRegistros
		If lcCantRegistros > 0
			lcIn = This.ObtenerInSqlServer( lcCursor, 'CBCod','C')
			lnFragmento = goRegistry.nucleo.cantidadDeElementosEnSentenciaInSQL
			loIn = this.ObtenerColeccionInSqlServer( lcCursor,'','CBCod')
			llEjecutaEnTransaccion = loIn.count > 0
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'BEGIN TRANSACTION' )
			endif
			for i = 1 to loIn.count step lnFragmento
				lcIn = this.ObtenerFragmentoColeccionInSqlServer( loIn, i, lnFragmento )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.AgruPub132 Where Codigo] + lcIn  )
			endfor
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'COMMIT TRANSACTION' )
			endif
		EndIf
	endif
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMAGRUPAPUBLIC132'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where Codigo in ( select CBCod from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"NROITEM","Codigo","Agrup","AgrupDes"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.AgruPub132 ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Codigo     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Agrup      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.AgrupDes   ) + "'" + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	Use in select( 'cExistentes' )
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearCursorMemo( tcCursorACrear as String, tcTablaConMemo as String ) as Void
		create cursor &tcCursorACrear ( CBCod C (5) , Orden N(16), texto C(80))
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirComponentes() As Void
		
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function ObtenerIdentificadorParaLoguear( tcCursor as String ) As String
		local lcRetorno as String, lnCC as String , loCC as Object, lni as Integer, lcSecuencia as String
		lcRetorno = this.oEntidad.cDescripcion 
		lcRetorno = lcRetorno + ' - Código: ' + transform( &tcCursor..CBCod      )
		Return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EsAliasDeProceso( tcAlias As String, tcPrefijo as string ) As Boolean
		local llRetorno as Boolean, lcAlias as String, lcPrefijo As String
		llRetorno = .F.
		lcAlias = upper( alltrim( tcAlias ) )
		lcPrefijo = upper( alltrim( tcPrefijo ) )
		Do Case
			Case  lcAlias == lcPrefijo + 'CUENTABANCARIA'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'CUENTABANCARIA_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'CUENTABANCARIA_CBOBS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMAGRUPAPUBLIC132'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_CtaBan')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'CUENTABANCARIA'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..CBCod
		llCondicion = isnull( lxVar )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad CUENTABANCARIA. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'CUENTABANCARIA'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		select recno() as _Rec, * from &lcCursor into cursor CurConRecno
		select max( _Rec ) as Maximo,CBCod as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( CBCod, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		Use in select( 'CurConRecno' )
		Use in select( 'RepMax' )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDatosInvalidos( toConexion as Object ) as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'CUENTABANCARIA'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_CtaBan') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_CtaBan
Create Table ZooLogic.TablaTrabajo_CtaBan ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fecimpo" datetime  null, 
"fectrans" datetime  null, 
"fmodifw" datetime  null, 
"faltafw" datetime  null, 
"fecexpo" datetime  null, 
"zadsfw" varchar(max)  null, 
"horaexpo" char( 8 )  null, 
"haltafw" char( 8 )  null, 
"saltafw" char( 7 )  null, 
"horaimpo" char( 8 )  null, 
"hmodifw" char( 8 )  null, 
"vmodifw" char( 13 )  null, 
"esttrans" char( 20 )  null, 
"umodifw" char( 100 )  null, 
"valtafw" char( 13 )  null, 
"ualtafw" char( 100 )  null, 
"smodifw" char( 7 )  null, 
"bdaltafw" char( 8 )  null, 
"bdmodifw" char( 8 )  null, 
"timestamp" numeric( 20, 0 )  null, 
"tipagrupub" numeric( 1, 0 )  null, 
"cbcod" char( 5 )  null, 
"cbdes" char( 40 )  null, 
"cbsucban" char( 5 )  null, 
"cbnum" char( 18 )  null, 
"cbcbu" char( 25 )  null, 
"cbmoneda" char( 10 )  null, 
"cbacuerdo" numeric( 15, 2 )  null, 
"cbcuit" char( 15 )  null, 
"cbrazsoc" char( 30 )  null, 
"cbdir" char( 70 )  null, 
"cbfirma" char( 70 )  null, 
"cbobs" varchar(max)  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_CtaBan' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_CtaBan' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'CUENTABANCARIA'
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
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('timestamp','timestamp')
			.AgregarMapeo('tipagrupub','tipagrupub')
			.AgregarMapeo('cbcod','cbcod')
			.AgregarMapeo('cbdes','cbdes')
			.AgregarMapeo('cbsucban','cbsucban')
			.AgregarMapeo('cbnum','cbnum')
			.AgregarMapeo('cbcbu','cbcbu')
			.AgregarMapeo('cbmoneda','cbmoneda')
			.AgregarMapeo('cbacuerdo','cbacuerdo')
			.AgregarMapeo('cbcuit','cbcuit')
			.AgregarMapeo('cbrazsoc','cbrazsoc')
			.AgregarMapeo('cbdir','cbdir')
			.AgregarMapeo('cbfirma','cbfirma')
			.AgregarMapeo('cbobs','cbobs')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_CtaBan'
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
				Update t Set t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.TIMESTAMP = isnull( d.TIMESTAMP, t.TIMESTAMP ),t.TIPAGRUPUB = isnull( d.TIPAGRUPUB, t.TIPAGRUPUB ),t.CBCOD = isnull( d.CBCOD, t.CBCOD ),t.CBDES = isnull( d.CBDES, t.CBDES ),t.CBSUCBAN = isnull( d.CBSUCBAN, t.CBSUCBAN ),t.CBNUM = isnull( d.CBNUM, t.CBNUM ),t.CBCBU = isnull( d.CBCBU, t.CBCBU ),t.CBMONEDA = isnull( d.CBMONEDA, t.CBMONEDA ),t.CBACUERDO = isnull( d.CBACUERDO, t.CBACUERDO ),t.CBCUIT = isnull( d.CBCUIT, t.CBCUIT ),t.CBRAZSOC = isnull( d.CBRAZSOC, t.CBRAZSOC ),t.CBDIR = isnull( d.CBDIR, t.CBDIR ),t.CBFIRMA = isnull( d.CBFIRMA, t.CBFIRMA ),t.CBOBS = isnull( d.CBOBS, t.CBOBS )
					from ZooLogic.CTABAN t inner join deleted d 
							 on t.CBCod = d.CBCod
				-- Fin Updates
				insert into ZooLogic.CTABAN(Fecimpo,Fectrans,Fmodifw,Faltafw,Fecexpo,Zadsfw,Horaexpo,Haltafw,Saltafw,Horaimpo,Hmodifw,Vmodifw,Esttrans,Umodifw,Valtafw,Ualtafw,Smodifw,Bdaltafw,Bdmodifw,Timestamp,Tipagrupub,Cbcod,Cbdes,Cbsucban,Cbnum,Cbcbu,Cbmoneda,Cbacuerdo,Cbcuit,Cbrazsoc,Cbdir,Cbfirma,Cbobs)
					Select isnull( d.FECIMPO,''),isnull( d.FECTRANS,''),isnull( d.FMODIFW,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FECEXPO,''),isnull( d.ZADSFW,''),isnull( d.HORAEXPO,''),convert( char(8), getdate(), 108 ),isnull( d.SALTAFW,''),isnull( d.HORAIMPO,''),isnull( d.HMODIFW,''),isnull( d.VMODIFW,''),isnull( d.ESTTRANS,''),isnull( d.UMODIFW,''),isnull( d.VALTAFW,''),isnull( d.UALTAFW,''),isnull( d.SMODIFW,''),isnull( d.BDALTAFW,''),isnull( d.BDMODIFW,''),isnull( d.TIMESTAMP,0),isnull( d.TIPAGRUPUB,0),isnull( d.CBCOD,''),isnull( d.CBDES,''),isnull( d.CBSUCBAN,''),isnull( d.CBNUM,''),isnull( d.CBCBU,''),isnull( d.CBMONEDA,''),isnull( d.CBACUERDO,0),isnull( d.CBCUIT,''),isnull( d.CBRAZSOC,''),isnull( d.CBDIR,''),isnull( d.CBFIRMA,''),isnull( d.CBOBS,'')
						From deleted d left join ZooLogic.CTABAN pk 
							 on d.CBCod = pk.CBCod
						Where pk.CBCod Is Null 
				-- Fin Inserts
			End
		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_AgruPub132( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_CTABAN_AgruPub132
ON ZooLogic.TablaTrabajo_CTABAN_AgruPub132
AFTER DELETE
As
Begin
Update t Set 
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.CODIGO = isnull( d.CODIGO, t.CODIGO ),
t.AGRUP = isnull( d.AGRUP, t.AGRUP ),
t.AGRUPDES = isnull( d.AGRUPDES, t.AGRUPDES )
from ZooLogic.AgruPub132 t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.AgruPub132
( 
"NROITEM",
"CODIGO",
"AGRUP",
"AGRUPDES"
 )
Select 
d.NROITEM,
d.CODIGO,
d.AGRUP,
d.AGRUPDES
From deleted d left join ZooLogic.AgruPub132 pk 
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_CtaBan') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_CtaBan
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_CUENTABANCARIA' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_CUENTABANCARIA.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_CUENTABANCARIA.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_CUENTABANCARIA.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_CUENTABANCARIA.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_CUENTABANCARIA.Fechaexpo, ctod( '  /  /    ' ) ) )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Horaexpo = nvl( c_CUENTABANCARIA.Horaexpo, [] )
					.Horaaltafw = nvl( c_CUENTABANCARIA.Horaaltafw, [] )
					.Seriealtafw = nvl( c_CUENTABANCARIA.Seriealtafw, [] )
					.Horaimpo = nvl( c_CUENTABANCARIA.Horaimpo, [] )
					.Horamodificacionfw = nvl( c_CUENTABANCARIA.Horamodificacionfw, [] )
					.Versionmodificacionfw = nvl( c_CUENTABANCARIA.Versionmodificacionfw, [] )
					.Estadotransferencia = nvl( c_CUENTABANCARIA.Estadotransferencia, [] )
					.Usuariomodificacionfw = nvl( c_CUENTABANCARIA.Usuariomodificacionfw, [] )
					.Versionaltafw = nvl( c_CUENTABANCARIA.Versionaltafw, [] )
					.Usuarioaltafw = nvl( c_CUENTABANCARIA.Usuarioaltafw, [] )
					.Seriemodificacionfw = nvl( c_CUENTABANCARIA.Seriemodificacionfw, [] )
					.Basededatosaltafw = nvl( c_CUENTABANCARIA.Basededatosaltafw, [] )
					.Basededatosmodificacionfw = nvl( c_CUENTABANCARIA.Basededatosmodificacionfw, [] )
					.Timestamp = nvl( c_CUENTABANCARIA.Timestamp, 0 )
					.Tipoagrupamientopublicaciones = nvl( c_CUENTABANCARIA.Tipoagrupamientopublicaciones, 0 )
					.Codigo = nvl( c_CUENTABANCARIA.Codigo, [] )
					if !.lEsSubEntidad
					.Agrupublidetalle.Limpiar()
					.Agrupublidetalle.SetearEsNavegacion( .lProcesando )
					.Agrupublidetalle.Cargar()
					endif
					.Descripcion = nvl( c_CUENTABANCARIA.Descripcion, [] )
					.Sucursalbancaria_PK =  nvl( c_CUENTABANCARIA.Sucursalbancaria, [] )
					.Numero = nvl( c_CUENTABANCARIA.Numero, [] )
					.Cbu = nvl( c_CUENTABANCARIA.Cbu, [] )
					.Monedacuenta_PK =  nvl( c_CUENTABANCARIA.Monedacuenta, [] )
					.Acuerdo = nvl( c_CUENTABANCARIA.Acuerdo, 0 )
					.Codigotributariolibrador = nvl( c_CUENTABANCARIA.Codigotributariolibrador, [] )
					.Razonsociallibrador = nvl( c_CUENTABANCARIA.Razonsociallibrador, [] )
					.Direccion = nvl( c_CUENTABANCARIA.Direccion, [] )
					.Firmantes = nvl( c_CUENTABANCARIA.Firmantes, [] )
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
	function ActualizarLosNROItemDeLosDetalles() as void
		local loDetalle as object, loItem as object, lnContadorNroItem as integer, lnIndex as integer
		
		loDetalle = this.oEntidad.AgruPubliDetalle
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
		return c_CUENTABANCARIA.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.CTABAN' )
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
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "CBCod"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
		text to lcSQL textmerge noshow
				SELECT nro,totalRegistros,CBCod as Id
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    CBCod from (
							select * 
								from ZooLogic.CTABAN 
								Where   CTABAN.CBCOD != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "CTABAN", "", lcCursor, set("Datasession") )
		lcXml = this.CursorAXml( lcCursor )
		
		use in select( lcCursor )
		
		Return lcXml 
		
	endfunc
	*-----------------------------------------------------------------------------------------
	function ObtenerDatosEntidadPaginado( tcOrderBy as String, tcFiltro as String, tnCantidad as Integer, tnPagina as Integer )  as String
		local lcOrderBy as String, lnCuantos as Integer, lnPagina as Integer, lnTope as Integer, lnDesde as Integer, lcSQL as String, lcCursor as String, lcXml as String
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "CBCod"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
			text to lcAtributos textmerge noshow
			"Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Zadsfw" as "Zadsfw", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Esttrans" as "Estadotransferencia", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Timestamp" as "Timestamp", "Tipagrupub" as "Tipoagrupamientopublicaciones", "Cbcod" as "Codigo", "Cbdes" as "Descripcion", "Cbsucban" as "Sucursalbancaria", "Cbnum" as "Numero", "Cbcbu" as "Cbu", "Cbmoneda" as "Monedacuenta", "Cbacuerdo" as "Acuerdo", "Cbcuit" as "Codigotributariolibrador", "Cbrazsoc" as "Razonsociallibrador", "Cbdir" as "Direccion", "Cbfirma" as "Firmantes", "Cbobs" as "Observacion"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.CTABAN 
								Where   CTABAN.CBCOD != ''
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
	Tabla = 'CTABAN'
	Filtro = " CTABAN.CBCOD != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " CTABAN.CBCOD != ''"
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
	<row entidad="CUENTABANCARIA                          " atributo="FECHAIMPO                               " tabla="CTABAN         " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUENTABANCARIA                          " atributo="FECHATRANSFERENCIA                      " tabla="CTABAN         " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha de novedad                                                                                                                                                " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUENTABANCARIA                          " atributo="FECHAMODIFICACIONFW                     " tabla="CTABAN         " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUENTABANCARIA                          " atributo="FECHAALTAFW                             " tabla="CTABAN         " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUENTABANCARIA                          " atributo="FECHAEXPO                               " tabla="CTABAN         " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUENTABANCARIA                          " atributo="ZADSFW                                  " tabla="CTABAN         " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUENTABANCARIA                          " atributo="HORAEXPO                                " tabla="CTABAN         " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUENTABANCARIA                          " atributo="HORAALTAFW                              " tabla="CTABAN         " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUENTABANCARIA                          " atributo="SERIEALTAFW                             " tabla="CTABAN         " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUENTABANCARIA                          " atributo="HORAIMPO                                " tabla="CTABAN         " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUENTABANCARIA                          " atributo="HORAMODIFICACIONFW                      " tabla="CTABAN         " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUENTABANCARIA                          " atributo="VERSIONMODIFICACIONFW                   " tabla="CTABAN         " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUENTABANCARIA                          " atributo="ESTADOTRANSFERENCIA                     " tabla="CTABAN         " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado de novedad                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUENTABANCARIA                          " atributo="USUARIOMODIFICACIONFW                   " tabla="CTABAN         " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUENTABANCARIA                          " atributo="VERSIONALTAFW                           " tabla="CTABAN         " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUENTABANCARIA                          " atributo="USUARIOALTAFW                           " tabla="CTABAN         " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUENTABANCARIA                          " atributo="SERIEMODIFICACIONFW                     " tabla="CTABAN         " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUENTABANCARIA                          " atributo="BASEDEDATOSALTAFW                       " tabla="CTABAN         " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUENTABANCARIA                          " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="CTABAN         " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUENTABANCARIA                          " atributo="TIMESTAMP                               " tabla="CTABAN         " campo="TIMESTAMP " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUENTABANCARIA                          " atributo="TIPOAGRUPAMIENTOPUBLICACIONES           " tabla="CTABAN         " campo="TIPAGRUPUB" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUENTABANCARIA                          " atributo="CODIGO                                  " tabla="CTABAN         " campo="CBCOD     " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="2" etiqueta="Código                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUENTABANCARIA                          " atributo="AGRUPUBLIDETALLE                        " tabla="AGRUPUB132     " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Agrupamientos                                                                                                                                                   " dominio="DETALLEITEMAGRUPAPUBLIC132    " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="1" alta="false" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUENTABANCARIA                          " atributo="DESCRIPCION                             " tabla="CTABAN         " campo="CBDES     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="4" etiqueta="Descripción                                                                                                                                                     " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="10" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUENTABANCARIA                          " atributo="SUCURSALBANCARIA                        " tabla="CTABAN         " campo="CBSUCBAN  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="SUCURSALBANCARIA                        " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="6" etiqueta="Sucursal bancaria                                                                                                                                               " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="20" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUENTABANCARIA                          " atributo="NUMERO                                  " tabla="CTABAN         " campo="CBNUM     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="18" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="8" etiqueta="Número de cuenta bancaria                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="30" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUENTABANCARIA                          " atributo="CBU                                     " tabla="CTABAN         " campo="CBCBU     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="25" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="10" etiqueta="CBU                                                                                                                                                             " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="9999999-9 9999999999999-9" ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="50" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUENTABANCARIA                          " atributo="MONEDACUENTA                            " tabla="CTABAN         " campo="CBMONEDA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="MONEDA                                  " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="400" etiqueta="Moneda                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="51" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUENTABANCARIA                          " atributo="ACUERDO                                 " tabla="CTABAN         " campo="CBACUERDO " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="402" etiqueta="Acuerdo                                                                                                                                                         " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="60" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUENTABANCARIA                          " atributo="CODIGOTRIBUTARIOLIBRADOR                " tabla="CTABAN         " campo="CBCUIT    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="12" etiqueta="C.U.I.T.                                                                                                                                                        " dominio="CUIT                          " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="99-99999999-9            " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="6" orden="70" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUENTABANCARIA                          " atributo="RAZONSOCIALLIBRADOR                     " tabla="CTABAN         " campo="CBRAZSOC  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="14" etiqueta="Razón social                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="6" orden="80" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUENTABANCARIA                          " atributo="DIRECCION                               " tabla="CTABAN         " campo="CBDIR     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="70" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="16" etiqueta="Dirección                                                                                                                                                       " dominio="TEXTO                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="6" orden="90" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUENTABANCARIA                          " atributo="FIRMANTES                               " tabla="CTABAN         " campo="CBFIRMA   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="70" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="404" etiqueta="Firmantes                                                                                                                                                       " dominio="TEXTO                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="6" orden="91" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUENTABANCARIA                          " atributo="OBSERVACION                             " tabla="CTABAN         " campo="CBOBS     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="406" etiqueta="Observaciones                                                                                                                                                   " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="92" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSALBANCARIA                        " atributo="DESCRIPCION                             " tabla="SUCBAN         " campo="SBDES     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="7" etiqueta="Detalle Suc.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join SUCBAN On CTABAN.CBSUCBAN = SUCBAN.SbCod And  SUCBAN.SBCOD != ''                                                                                                                                                                                   " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MONEDA                                  " atributo="DESCRIPCION                             " tabla="MONEDA         " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="401" etiqueta="Detalle Mon.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join MONEDA On CTABAN.CBMONEDA = MONEDA.Codigo And  MONEDA.CODIGO != ''                                                                                                                                                                                 " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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