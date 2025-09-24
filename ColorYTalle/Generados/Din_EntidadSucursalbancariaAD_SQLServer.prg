
define class Din_EntidadSUCURSALBANCARIAAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_SUCURSALBANCARIA'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = []
	cExpresionCCPorCampos = []
	cTagClaveCandidata = ''
	cTagClavePk = '_131PK'
	cTablaPrincipal = 'SUCBAN'
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
			local  lxSucbanFmodifw, lxSucbanFecexpo, lxSucbanFectrans, lxSucbanFaltafw, lxSucbanFecimpo, lxSucbanSbcalle, lxSucbanHaltafw, lxSucbanHoraimpo, lxSucbanValtafw, lxSucbanZadsfw, lxSucbanVmodifw, lxSucbanUmodifw, lxSucbanUaltafw, lxSucbanHmodifw, lxSucbanSmodifw, lxSucbanSaltafw, lxSucbanHoraexpo, lxSucbanEsttrans, lxSucbanBdaltafw, lxSucbanBdmodifw, lxSucbanTipagrupub, lxSucbanTimestamp, lxSucbanSbcod, lxSucbanSbnro, lxSucbanSbdes, lxSucbanSbpiso, lxSucbanSbentfin, lxSucbanSbdepto, lxSucbanSbnum, lxSucbanSbloc, lxSucbanSbcp, lxSucbanSbprv, lxSucbanSbtlf, lxSucbanSbpais, lxSucbanSbemail, lxSucbanSbcontac, lxSucbanSbobs
				lxSucbanFmodifw =  .Fechamodificacionfw			lxSucbanFecexpo =  .Fechaexpo			lxSucbanFectrans =  .Fechatransferencia			lxSucbanFaltafw =  .Fechaaltafw			lxSucbanFecimpo =  .Fechaimpo			lxSucbanSbcalle =  .Calle			lxSucbanHaltafw =  .Horaaltafw			lxSucbanHoraimpo =  .Horaimpo			lxSucbanValtafw =  .Versionaltafw			lxSucbanZadsfw =  .Zadsfw			lxSucbanVmodifw =  .Versionmodificacionfw			lxSucbanUmodifw =  .Usuariomodificacionfw			lxSucbanUaltafw =  .Usuarioaltafw			lxSucbanHmodifw =  .Horamodificacionfw			lxSucbanSmodifw =  .Seriemodificacionfw			lxSucbanSaltafw =  .Seriealtafw			lxSucbanHoraexpo =  .Horaexpo			lxSucbanEsttrans =  .Estadotransferencia			lxSucbanBdaltafw =  .Basededatosaltafw			lxSucbanBdmodifw =  .Basededatosmodificacionfw			lxSucbanTipagrupub =  .Tipoagrupamientopublicaciones			lxSucbanTimestamp = goLibrerias.ObtenerTimestamp()			lxSucbanSbcod =  .Codigo			lxSucbanSbnro =  .Numero			lxSucbanSbdes =  .Descripcion			lxSucbanSbpiso =  .Piso			lxSucbanSbentfin =  upper( .EntidadFinanciera_PK ) 			lxSucbanSbdepto =  .Departamento			lxSucbanSbnum =  .Numerosuc			lxSucbanSbloc =  .Localidad			lxSucbanSbcp =  .Codigopostal			lxSucbanSbprv =  upper( .Provincia_PK ) 			lxSucbanSbtlf =  .Telefono			lxSucbanSbpais =  upper( .Pais_PK ) 			lxSucbanSbemail =  .Email			lxSucbanSbcontac =  .Contacto			lxSucbanSbobs =  .Observacion
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxSucbanSbcod = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.SUCBAN ( "Fmodifw","Fecexpo","Fectrans","Faltafw","Fecimpo","Sbcalle","Haltafw","Horaimpo","Valtafw","Zadsfw","Vmodifw","Umodifw","Ualtafw","Hmodifw","Smodifw","Saltafw","Horaexpo","Esttrans","Bdaltafw","Bdmodifw","Tipagrupub","Timestamp","Sbcod","Sbnro","Sbdes","Sbpiso","Sbentfin","Sbdepto","Sbnum","Sbloc","Sbcp","Sbprv","Sbtlf","Sbpais","Sbemail","Sbcontac","Sbobs" ) values ( <<"'" + this.ConvertirDateSql( lxSucbanFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxSucbanFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxSucbanFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxSucbanFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxSucbanFecimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucbanSbcalle ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucbanHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucbanHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucbanValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucbanZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucbanVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucbanUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucbanUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucbanHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucbanSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucbanSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucbanHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucbanEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucbanBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucbanBdmodifw ) + "'" >>, <<lxSucbanTipagrupub >>, <<lxSucbanTimestamp >>, <<"'" + this.FormatearTextoSql( lxSucbanSbcod ) + "'" >>, <<lxSucbanSbnro >>, <<"'" + this.FormatearTextoSql( lxSucbanSbdes ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucbanSbpiso ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucbanSbentfin ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucbanSbdepto ) + "'" >>, <<lxSucbanSbnum >>, <<"'" + this.FormatearTextoSql( lxSucbanSbloc ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucbanSbcp ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucbanSbprv ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucbanSbtlf ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucbanSbpais ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucbanSbemail ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucbanSbcontac ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucbanSbobs ) + "'" >> )
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
						Insert into ZooLogic.AgruPub131("NROITEM","Codigo","Agrup","AgrupDes" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxAgrupamiento_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxAgrupamientodetalle ) + "'">> ) 
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
		this.oEntidad.Timestamp = lxSucbanTimestamp
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
			local  lxSucbanFmodifw, lxSucbanFecexpo, lxSucbanFectrans, lxSucbanFaltafw, lxSucbanFecimpo, lxSucbanSbcalle, lxSucbanHaltafw, lxSucbanHoraimpo, lxSucbanValtafw, lxSucbanZadsfw, lxSucbanVmodifw, lxSucbanUmodifw, lxSucbanUaltafw, lxSucbanHmodifw, lxSucbanSmodifw, lxSucbanSaltafw, lxSucbanHoraexpo, lxSucbanEsttrans, lxSucbanBdaltafw, lxSucbanBdmodifw, lxSucbanTipagrupub, lxSucbanTimestamp, lxSucbanSbcod, lxSucbanSbnro, lxSucbanSbdes, lxSucbanSbpiso, lxSucbanSbentfin, lxSucbanSbdepto, lxSucbanSbnum, lxSucbanSbloc, lxSucbanSbcp, lxSucbanSbprv, lxSucbanSbtlf, lxSucbanSbpais, lxSucbanSbemail, lxSucbanSbcontac, lxSucbanSbobs
				lxSucbanFmodifw =  .Fechamodificacionfw			lxSucbanFecexpo =  .Fechaexpo			lxSucbanFectrans =  .Fechatransferencia			lxSucbanFaltafw =  .Fechaaltafw			lxSucbanFecimpo =  .Fechaimpo			lxSucbanSbcalle =  .Calle			lxSucbanHaltafw =  .Horaaltafw			lxSucbanHoraimpo =  .Horaimpo			lxSucbanValtafw =  .Versionaltafw			lxSucbanZadsfw =  .Zadsfw			lxSucbanVmodifw =  .Versionmodificacionfw			lxSucbanUmodifw =  .Usuariomodificacionfw			lxSucbanUaltafw =  .Usuarioaltafw			lxSucbanHmodifw =  .Horamodificacionfw			lxSucbanSmodifw =  .Seriemodificacionfw			lxSucbanSaltafw =  .Seriealtafw			lxSucbanHoraexpo =  .Horaexpo			lxSucbanEsttrans =  .Estadotransferencia			lxSucbanBdaltafw =  .Basededatosaltafw			lxSucbanBdmodifw =  .Basededatosmodificacionfw			lxSucbanTipagrupub =  .Tipoagrupamientopublicaciones			lxSucbanTimestamp = goLibrerias.ObtenerTimestamp()			lxSucbanSbcod =  .Codigo			lxSucbanSbnro =  .Numero			lxSucbanSbdes =  .Descripcion			lxSucbanSbpiso =  .Piso			lxSucbanSbentfin =  upper( .EntidadFinanciera_PK ) 			lxSucbanSbdepto =  .Departamento			lxSucbanSbnum =  .Numerosuc			lxSucbanSbloc =  .Localidad			lxSucbanSbcp =  .Codigopostal			lxSucbanSbprv =  upper( .Provincia_PK ) 			lxSucbanSbtlf =  .Telefono			lxSucbanSbpais =  upper( .Pais_PK ) 			lxSucbanSbemail =  .Email			lxSucbanSbcontac =  .Contacto			lxSucbanSbobs =  .Observacion
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
				update ZooLogic.SUCBAN set "Fmodifw" = <<"'" + this.ConvertirDateSql( lxSucbanFmodifw ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxSucbanFecexpo ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxSucbanFectrans ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxSucbanFaltafw ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxSucbanFecimpo ) + "'">>,"Sbcalle" = <<"'" + this.FormatearTextoSql( lxSucbanSbcalle ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxSucbanHaltafw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxSucbanHoraimpo ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxSucbanValtafw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxSucbanZadsfw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxSucbanVmodifw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxSucbanUmodifw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxSucbanUaltafw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxSucbanHmodifw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxSucbanSmodifw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxSucbanSaltafw ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxSucbanHoraexpo ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxSucbanEsttrans ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxSucbanBdaltafw ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxSucbanBdmodifw ) + "'">>,"Tipagrupub" = <<lxSucbanTipagrupub>>,"Timestamp" = <<lxSucbanTimestamp>>,"Sbcod" = <<"'" + this.FormatearTextoSql( lxSucbanSbcod ) + "'">>,"Sbnro" = <<lxSucbanSbnro>>,"Sbdes" = <<"'" + this.FormatearTextoSql( lxSucbanSbdes ) + "'">>,"Sbpiso" = <<"'" + this.FormatearTextoSql( lxSucbanSbpiso ) + "'">>,"Sbentfin" = <<"'" + this.FormatearTextoSql( lxSucbanSbentfin ) + "'">>,"Sbdepto" = <<"'" + this.FormatearTextoSql( lxSucbanSbdepto ) + "'">>,"Sbnum" = <<lxSucbanSbnum>>,"Sbloc" = <<"'" + this.FormatearTextoSql( lxSucbanSbloc ) + "'">>,"Sbcp" = <<"'" + this.FormatearTextoSql( lxSucbanSbcp ) + "'">>,"Sbprv" = <<"'" + this.FormatearTextoSql( lxSucbanSbprv ) + "'">>,"Sbtlf" = <<"'" + this.FormatearTextoSql( lxSucbanSbtlf ) + "'">>,"Sbpais" = <<"'" + this.FormatearTextoSql( lxSucbanSbpais ) + "'">>,"Sbemail" = <<"'" + this.FormatearTextoSql( lxSucbanSbemail ) + "'">>,"Sbcontac" = <<"'" + this.FormatearTextoSql( lxSucbanSbcontac ) + "'">>,"Sbobs" = <<"'" + this.FormatearTextoSql( lxSucbanSbobs ) + "'">> where "Sbcod" = <<"'" + this.FormatearTextoSql( lxSucbanSbcod ) + "'">> and  SUCBAN.SBCOD != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			this.ComprobarResultadoDeEjecucionDelUpdate()
		this.ComprobarTransaccion()
			this.oConexion.EjecutarSql( 'delete from ZooLogic.AgruPub131 where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.AgruPubliDetalle
				if this.oEntidad.AgruPubliDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxAgrupamiento_PK = loItem.Agrupamiento_PK
					lxAgrupamientodetalle = loItem.Agrupamientodetalle
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.AgruPub131("NROITEM","Codigo","Agrup","AgrupDes" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxAgrupamiento_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxAgrupamientodetalle ) + "'">> ) 
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
		this.oEntidad.Timestamp = lxSucbanTimestamp
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 SbCod from ZooLogic.SUCBAN where " + this.ConvertirFuncionesSql( " SUCBAN.SBCOD != ''" ) )
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
			Local lxSucbanSbcod
			lxSucbanSbcod = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Sbcalle" as "Calle", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Horaexpo" as "Horaexpo", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Tipagrupub" as "Tipoagrupamientopublicaciones", "Timestamp" as "Timestamp", "Sbcod" as "Codigo", "Sbnro" as "Numero", "Sbdes" as "Descripcion", "Sbpiso" as "Piso", "Sbentfin" as "Entidadfinanciera", "Sbdepto" as "Departamento", "Sbnum" as "Numerosuc", "Sbloc" as "Localidad", "Sbcp" as "Codigopostal", "Sbprv" as "Provincia", "Sbtlf" as "Telefono", "Sbpais" as "Pais", "Sbemail" as "Email", "Sbcontac" as "Contacto", "Sbobs" as "Observacion" from ZooLogic.SUCBAN where "Sbcod" = <<"'" + this.FormatearTextoSql( lxSucbanSbcod ) + "'">> and  SUCBAN.SBCOD != ''
			endtext
			use in select('c_SUCURSALBANCARIA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_SUCURSALBANCARIA', set( 'Datasession' ) )

			if reccount( 'c_SUCURSALBANCARIA' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Agrup" as "Agrupamiento", "Agrupdes" as "Agrupamientodetalle" from ZooLogic.AgruPub131 where Codigo = <<"'" + this.FormatearTextoSql( c_SUCURSALBANCARIA.CODIGO ) + "'">> Order by NroItem
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
		local llRetorno as boolean,lxSucbanSbcod as Variant
		llRetorno = .t.
		lxSucbanSbcod = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.SUCBAN where "Sbcod" = <<"'" + this.FormatearTextoSql( lxSucbanSbcod ) + "'">> and  SUCBAN.SBCOD != ''
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
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Sbcalle" as "Calle", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Horaexpo" as "Horaexpo", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Tipagrupub" as "Tipoagrupamientopublicaciones", "Timestamp" as "Timestamp", "Sbcod" as "Codigo", "Sbnro" as "Numero", "Sbdes" as "Descripcion", "Sbpiso" as "Piso", "Sbentfin" as "Entidadfinanciera", "Sbdepto" as "Departamento", "Sbnum" as "Numerosuc", "Sbloc" as "Localidad", "Sbcp" as "Codigopostal", "Sbprv" as "Provincia", "Sbtlf" as "Telefono", "Sbpais" as "Pais", "Sbemail" as "Email", "Sbcontac" as "Contacto", "Sbobs" as "Observacion" from ZooLogic.SUCBAN where  SUCBAN.SBCOD != '' order by SbCod
			endtext
			use in select('c_SUCURSALBANCARIA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_SUCURSALBANCARIA', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Agrup" as "Agrupamiento", "Agrupdes" as "Agrupamientodetalle" from ZooLogic.AgruPub131 where Codigo = <<"'" + this.FormatearTextoSql( c_SUCURSALBANCARIA.CODIGO ) + "'">> Order by NroItem
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
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Sbcalle" as "Calle", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Horaexpo" as "Horaexpo", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Tipagrupub" as "Tipoagrupamientopublicaciones", "Timestamp" as "Timestamp", "Sbcod" as "Codigo", "Sbnro" as "Numero", "Sbdes" as "Descripcion", "Sbpiso" as "Piso", "Sbentfin" as "Entidadfinanciera", "Sbdepto" as "Departamento", "Sbnum" as "Numerosuc", "Sbloc" as "Localidad", "Sbcp" as "Codigopostal", "Sbprv" as "Provincia", "Sbtlf" as "Telefono", "Sbpais" as "Pais", "Sbemail" as "Email", "Sbcontac" as "Contacto", "Sbobs" as "Observacion" from ZooLogic.SUCBAN where  funciones.padr( SbCod, 5, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  SUCBAN.SBCOD != '' order by SbCod
			endtext
			use in select('c_SUCURSALBANCARIA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_SUCURSALBANCARIA', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Agrup" as "Agrupamiento", "Agrupdes" as "Agrupamientodetalle" from ZooLogic.AgruPub131 where Codigo = <<"'" + this.FormatearTextoSql( c_SUCURSALBANCARIA.CODIGO ) + "'">> Order by NroItem
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
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Sbcalle" as "Calle", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Horaexpo" as "Horaexpo", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Tipagrupub" as "Tipoagrupamientopublicaciones", "Timestamp" as "Timestamp", "Sbcod" as "Codigo", "Sbnro" as "Numero", "Sbdes" as "Descripcion", "Sbpiso" as "Piso", "Sbentfin" as "Entidadfinanciera", "Sbdepto" as "Departamento", "Sbnum" as "Numerosuc", "Sbloc" as "Localidad", "Sbcp" as "Codigopostal", "Sbprv" as "Provincia", "Sbtlf" as "Telefono", "Sbpais" as "Pais", "Sbemail" as "Email", "Sbcontac" as "Contacto", "Sbobs" as "Observacion" from ZooLogic.SUCBAN where  funciones.padr( SbCod, 5, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  SUCBAN.SBCOD != '' order by SbCod desc
			endtext
			use in select('c_SUCURSALBANCARIA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_SUCURSALBANCARIA', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Agrup" as "Agrupamiento", "Agrupdes" as "Agrupamientodetalle" from ZooLogic.AgruPub131 where Codigo = <<"'" + this.FormatearTextoSql( c_SUCURSALBANCARIA.CODIGO ) + "'">> Order by NroItem
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
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Sbcalle" as "Calle", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Horaexpo" as "Horaexpo", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Tipagrupub" as "Tipoagrupamientopublicaciones", "Timestamp" as "Timestamp", "Sbcod" as "Codigo", "Sbnro" as "Numero", "Sbdes" as "Descripcion", "Sbpiso" as "Piso", "Sbentfin" as "Entidadfinanciera", "Sbdepto" as "Departamento", "Sbnum" as "Numerosuc", "Sbloc" as "Localidad", "Sbcp" as "Codigopostal", "Sbprv" as "Provincia", "Sbtlf" as "Telefono", "Sbpais" as "Pais", "Sbemail" as "Email", "Sbcontac" as "Contacto", "Sbobs" as "Observacion" from ZooLogic.SUCBAN where  SUCBAN.SBCOD != '' order by SbCod desc
			endtext
			use in select('c_SUCURSALBANCARIA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_SUCURSALBANCARIA', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Agrup" as "Agrupamiento", "Agrupdes" as "Agrupamientodetalle" from ZooLogic.AgruPub131 where Codigo = <<"'" + this.FormatearTextoSql( c_SUCURSALBANCARIA.CODIGO ) + "'">> Order by NroItem
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
			lcXml = this.oConexion.EjecutarSql( "select Fmodifw,Fecexpo,Fectrans,Faltafw,Fecimpo,Sbcalle,Haltafw,Horaimpo,Valtafw,Zadsfw,Vmodifw,Umo" + ;
"difw,Ualtafw,Hmodifw,Smodifw,Saltafw,Horaexpo,Esttrans,Bdaltafw,Bdmodifw,Tipagrupub,Timestamp,Sbcod," + ;
"Sbnro,Sbdes,Sbpiso,Sbentfin,Sbdepto,Sbnum,Sbloc,Sbcp,Sbprv,Sbtlf,Sbpais,Sbemail,Sbcontac,Sbobs" + ;
" from ZooLogic.SUCBAN where  SUCBAN.SBCOD != '' and " + lcFiltro )
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
			local  lxSucbanFmodifw, lxSucbanFecexpo, lxSucbanFectrans, lxSucbanFaltafw, lxSucbanFecimpo, lxSucbanSbcalle, lxSucbanHaltafw, lxSucbanHoraimpo, lxSucbanValtafw, lxSucbanZadsfw, lxSucbanVmodifw, lxSucbanUmodifw, lxSucbanUaltafw, lxSucbanHmodifw, lxSucbanSmodifw, lxSucbanSaltafw, lxSucbanHoraexpo, lxSucbanEsttrans, lxSucbanBdaltafw, lxSucbanBdmodifw, lxSucbanTipagrupub, lxSucbanTimestamp, lxSucbanSbcod, lxSucbanSbnro, lxSucbanSbdes, lxSucbanSbpiso, lxSucbanSbentfin, lxSucbanSbdepto, lxSucbanSbnum, lxSucbanSbloc, lxSucbanSbcp, lxSucbanSbprv, lxSucbanSbtlf, lxSucbanSbpais, lxSucbanSbemail, lxSucbanSbcontac, lxSucbanSbobs
				lxSucbanFmodifw = ctod( '  /  /    ' )			lxSucbanFecexpo = ctod( '  /  /    ' )			lxSucbanFectrans = ctod( '  /  /    ' )			lxSucbanFaltafw = ctod( '  /  /    ' )			lxSucbanFecimpo = ctod( '  /  /    ' )			lxSucbanSbcalle = []			lxSucbanHaltafw = []			lxSucbanHoraimpo = []			lxSucbanValtafw = []			lxSucbanZadsfw = []			lxSucbanVmodifw = []			lxSucbanUmodifw = []			lxSucbanUaltafw = []			lxSucbanHmodifw = []			lxSucbanSmodifw = []			lxSucbanSaltafw = []			lxSucbanHoraexpo = []			lxSucbanEsttrans = []			lxSucbanBdaltafw = []			lxSucbanBdmodifw = []			lxSucbanTipagrupub = 0			lxSucbanTimestamp = goLibrerias.ObtenerTimestamp()			lxSucbanSbcod = []			lxSucbanSbnro = 0			lxSucbanSbdes = []			lxSucbanSbpiso = []			lxSucbanSbentfin = []			lxSucbanSbdepto = []			lxSucbanSbnum = 0			lxSucbanSbloc = []			lxSucbanSbcp = []			lxSucbanSbprv = []			lxSucbanSbtlf = []			lxSucbanSbpais = []			lxSucbanSbemail = []			lxSucbanSbcontac = []			lxSucbanSbobs = []
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.AgruPub131 where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( [delete from ZooLogic.SUCBAN where "SbCod" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'SUCBAN' + '_' + tcCampo
			lcMemoAscii = ''

			lnIndice = alen(.aSqlMemos)
			lnIndice = iif(lnIndice = 1, 1, lnIndice + 1 )
			dimension .aSqlMemos(lnIndice)

			.aSqlMemos(lnIndice) = 'delete from ' + lcTabla + ' where SbCod = ' + txValorClavePrimaria
			.GenerarSentenciasInsertTablaMemo( lcValor, lcTabla, txValorClavePrimaria )
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerSentenciaInsertMemo( tcTabla as String, txValorClavePrimaria as String, tcOrden as String, tcTexto as String ) as String
		return "Insert  into " + tcTabla + "(SbCod, Orden, texto ) values ( " + txValorClavePrimaria + "," + tcOrden + ",'"+ tcTexto + "')"
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosEntidad( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  SUCBAN.SBCOD != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Sbcalle" as "Calle", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Horaexpo" as "Horaexpo", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Tipagrupub" as "Tipoagrupamientopublicaciones", "Timestamp" as "Timestamp", "Sbcod" as "Codigo", "Sbnro" as "Numero", "Sbdes" as "Descripcion", "Sbpiso" as "Piso", "Sbentfin" as "Entidadfinanciera", "Sbdepto" as "Departamento", "Sbnum" as "Numerosuc", "Sbloc" as "Localidad", "Sbcp" as "Codigopostal", "Sbprv" as "Provincia", "Sbtlf" as "Telefono", "Sbpais" as "Pais", "Sbemail" as "Email", "Sbcontac" as "Contacto", "Sbobs" as "Observacion"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'SUCBAN', '', tnTope )
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
		lcWhere = " Where  AGRUPUB131.CODIGO != ''"
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
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'AgruPub131', 'AgruPubliDetalle', tnTope )
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
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'FECHAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECEXPO AS FECHAEXPO'
				Case lcAtributo == 'FECHATRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRANS AS FECHATRANSFERENCIA'
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'FECHAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECIMPO AS FECHAIMPO'
				Case lcAtributo == 'CALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SBCALLE AS CALLE'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'TIPOAGRUPAMIENTOPUBLICACIONES'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPAGRUPUB AS TIPOAGRUPAMIENTOPUBLICACIONES'
				Case lcAtributo == 'TIMESTAMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIMESTAMP AS TIMESTAMP'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SBCOD AS CODIGO'
				Case lcAtributo == 'NUMERO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SBNRO AS NUMERO'
				Case lcAtributo == 'DESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SBDES AS DESCRIPCION'
				Case lcAtributo == 'PISO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SBPISO AS PISO'
				Case lcAtributo == 'ENTIDADFINANCIERA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SBENTFIN AS ENTIDADFINANCIERA'
				Case lcAtributo == 'DEPARTAMENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SBDEPTO AS DEPARTAMENTO'
				Case lcAtributo == 'NUMEROSUC'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SBNUM AS NUMEROSUC'
				Case lcAtributo == 'LOCALIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SBLOC AS LOCALIDAD'
				Case lcAtributo == 'CODIGOPOSTAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SBCP AS CODIGOPOSTAL'
				Case lcAtributo == 'PROVINCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SBPRV AS PROVINCIA'
				Case lcAtributo == 'TELEFONO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SBTLF AS TELEFONO'
				Case lcAtributo == 'PAIS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SBPAIS AS PAIS'
				Case lcAtributo == 'EMAIL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SBEMAIL AS EMAIL'
				Case lcAtributo == 'CONTACTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SBCONTAC AS CONTACTO'
				Case lcAtributo == 'OBSERVACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SBOBS AS OBSERVACION'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEXPO'
				lcCampo = 'FECEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAIMPO'
				lcCampo = 'FECIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'CALLE'
				lcCampo = 'SBCALLE'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOAGRUPAMIENTOPUBLICACIONES'
				lcCampo = 'TIPAGRUPUB'
			Case upper( alltrim( tcAtributo ) ) == 'TIMESTAMP'
				lcCampo = 'TIMESTAMP'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'SBCOD'
			Case upper( alltrim( tcAtributo ) ) == 'NUMERO'
				lcCampo = 'SBNRO'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCION'
				lcCampo = 'SBDES'
			Case upper( alltrim( tcAtributo ) ) == 'PISO'
				lcCampo = 'SBPISO'
			Case upper( alltrim( tcAtributo ) ) == 'ENTIDADFINANCIERA'
				lcCampo = 'SBENTFIN'
			Case upper( alltrim( tcAtributo ) ) == 'DEPARTAMENTO'
				lcCampo = 'SBDEPTO'
			Case upper( alltrim( tcAtributo ) ) == 'NUMEROSUC'
				lcCampo = 'SBNUM'
			Case upper( alltrim( tcAtributo ) ) == 'LOCALIDAD'
				lcCampo = 'SBLOC'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGOPOSTAL'
				lcCampo = 'SBCP'
			Case upper( alltrim( tcAtributo ) ) == 'PROVINCIA'
				lcCampo = 'SBPRV'
			Case upper( alltrim( tcAtributo ) ) == 'TELEFONO'
				lcCampo = 'SBTLF'
			Case upper( alltrim( tcAtributo ) ) == 'PAIS'
				lcCampo = 'SBPAIS'
			Case upper( alltrim( tcAtributo ) ) == 'EMAIL'
				lcCampo = 'SBEMAIL'
			Case upper( alltrim( tcAtributo ) ) == 'CONTACTO'
				lcCampo = 'SBCONTAC'
			Case upper( alltrim( tcAtributo ) ) == 'OBSERVACION'
				lcCampo = 'SBOBS'
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
			lcRetorno = 'AGRUPUB131'
		EndIf
		return lcRetorno
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasInsert() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcSentencia as string, loItem as object
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxSucbanFmodifw, lxSucbanFecexpo, lxSucbanFectrans, lxSucbanFaltafw, lxSucbanFecimpo, lxSucbanSbcalle, lxSucbanHaltafw, lxSucbanHoraimpo, lxSucbanValtafw, lxSucbanZadsfw, lxSucbanVmodifw, lxSucbanUmodifw, lxSucbanUaltafw, lxSucbanHmodifw, lxSucbanSmodifw, lxSucbanSaltafw, lxSucbanHoraexpo, lxSucbanEsttrans, lxSucbanBdaltafw, lxSucbanBdmodifw, lxSucbanTipagrupub, lxSucbanTimestamp, lxSucbanSbcod, lxSucbanSbnro, lxSucbanSbdes, lxSucbanSbpiso, lxSucbanSbentfin, lxSucbanSbdepto, lxSucbanSbnum, lxSucbanSbloc, lxSucbanSbcp, lxSucbanSbprv, lxSucbanSbtlf, lxSucbanSbpais, lxSucbanSbemail, lxSucbanSbcontac, lxSucbanSbobs
				lxSucbanFmodifw =  .Fechamodificacionfw			lxSucbanFecexpo =  .Fechaexpo			lxSucbanFectrans =  .Fechatransferencia			lxSucbanFaltafw =  .Fechaaltafw			lxSucbanFecimpo =  .Fechaimpo			lxSucbanSbcalle =  .Calle			lxSucbanHaltafw =  .Horaaltafw			lxSucbanHoraimpo =  .Horaimpo			lxSucbanValtafw =  .Versionaltafw			lxSucbanZadsfw =  .Zadsfw			lxSucbanVmodifw =  .Versionmodificacionfw			lxSucbanUmodifw =  .Usuariomodificacionfw			lxSucbanUaltafw =  .Usuarioaltafw			lxSucbanHmodifw =  .Horamodificacionfw			lxSucbanSmodifw =  .Seriemodificacionfw			lxSucbanSaltafw =  .Seriealtafw			lxSucbanHoraexpo =  .Horaexpo			lxSucbanEsttrans =  .Estadotransferencia			lxSucbanBdaltafw =  .Basededatosaltafw			lxSucbanBdmodifw =  .Basededatosmodificacionfw			lxSucbanTipagrupub =  .Tipoagrupamientopublicaciones			lxSucbanTimestamp = goLibrerias.ObtenerTimestamp()			lxSucbanSbcod =  .Codigo			lxSucbanSbnro =  .Numero			lxSucbanSbdes =  .Descripcion			lxSucbanSbpiso =  .Piso			lxSucbanSbentfin =  upper( .EntidadFinanciera_PK ) 			lxSucbanSbdepto =  .Departamento			lxSucbanSbnum =  .Numerosuc			lxSucbanSbloc =  .Localidad			lxSucbanSbcp =  .Codigopostal			lxSucbanSbprv =  upper( .Provincia_PK ) 			lxSucbanSbtlf =  .Telefono			lxSucbanSbpais =  upper( .Pais_PK ) 			lxSucbanSbemail =  .Email			lxSucbanSbcontac =  .Contacto			lxSucbanSbobs =  .Observacion
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.SUCBAN ( "Fmodifw","Fecexpo","Fectrans","Faltafw","Fecimpo","Sbcalle","Haltafw","Horaimpo","Valtafw","Zadsfw","Vmodifw","Umodifw","Ualtafw","Hmodifw","Smodifw","Saltafw","Horaexpo","Esttrans","Bdaltafw","Bdmodifw","Tipagrupub","Timestamp","Sbcod","Sbnro","Sbdes","Sbpiso","Sbentfin","Sbdepto","Sbnum","Sbloc","Sbcp","Sbprv","Sbtlf","Sbpais","Sbemail","Sbcontac","Sbobs" ) values ( <<"'" + this.ConvertirDateSql( lxSucbanFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxSucbanFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxSucbanFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxSucbanFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxSucbanFecimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucbanSbcalle ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucbanHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucbanHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucbanValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucbanZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucbanVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucbanUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucbanUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucbanHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucbanSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucbanSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucbanHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucbanEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucbanBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucbanBdmodifw ) + "'" >>, <<lxSucbanTipagrupub >>, <<lxSucbanTimestamp >>, <<"'" + this.FormatearTextoSql( lxSucbanSbcod ) + "'" >>, <<lxSucbanSbnro >>, <<"'" + this.FormatearTextoSql( lxSucbanSbdes ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucbanSbpiso ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucbanSbentfin ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucbanSbdepto ) + "'" >>, <<lxSucbanSbnum >>, <<"'" + this.FormatearTextoSql( lxSucbanSbloc ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucbanSbcp ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucbanSbprv ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucbanSbtlf ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucbanSbpais ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucbanSbemail ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucbanSbcontac ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucbanSbobs ) + "'" >> )
		endtext
		loColeccion.cTabla = 'SUCBAN' 
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
						Insert into ZooLogic.AgruPub131("NROITEM","Codigo","Agrup","AgrupDes" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxAgrupamiento_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxAgrupamientodetalle ) + "'">> ) 
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
			local  lxSucbanFmodifw, lxSucbanFecexpo, lxSucbanFectrans, lxSucbanFaltafw, lxSucbanFecimpo, lxSucbanSbcalle, lxSucbanHaltafw, lxSucbanHoraimpo, lxSucbanValtafw, lxSucbanZadsfw, lxSucbanVmodifw, lxSucbanUmodifw, lxSucbanUaltafw, lxSucbanHmodifw, lxSucbanSmodifw, lxSucbanSaltafw, lxSucbanHoraexpo, lxSucbanEsttrans, lxSucbanBdaltafw, lxSucbanBdmodifw, lxSucbanTipagrupub, lxSucbanTimestamp, lxSucbanSbcod, lxSucbanSbnro, lxSucbanSbdes, lxSucbanSbpiso, lxSucbanSbentfin, lxSucbanSbdepto, lxSucbanSbnum, lxSucbanSbloc, lxSucbanSbcp, lxSucbanSbprv, lxSucbanSbtlf, lxSucbanSbpais, lxSucbanSbemail, lxSucbanSbcontac, lxSucbanSbobs
				lxSucbanFmodifw =  .Fechamodificacionfw			lxSucbanFecexpo =  .Fechaexpo			lxSucbanFectrans =  .Fechatransferencia			lxSucbanFaltafw =  .Fechaaltafw			lxSucbanFecimpo =  .Fechaimpo			lxSucbanSbcalle =  .Calle			lxSucbanHaltafw =  .Horaaltafw			lxSucbanHoraimpo =  .Horaimpo			lxSucbanValtafw =  .Versionaltafw			lxSucbanZadsfw =  .Zadsfw			lxSucbanVmodifw =  .Versionmodificacionfw			lxSucbanUmodifw =  .Usuariomodificacionfw			lxSucbanUaltafw =  .Usuarioaltafw			lxSucbanHmodifw =  .Horamodificacionfw			lxSucbanSmodifw =  .Seriemodificacionfw			lxSucbanSaltafw =  .Seriealtafw			lxSucbanHoraexpo =  .Horaexpo			lxSucbanEsttrans =  .Estadotransferencia			lxSucbanBdaltafw =  .Basededatosaltafw			lxSucbanBdmodifw =  .Basededatosmodificacionfw			lxSucbanTipagrupub =  .Tipoagrupamientopublicaciones			lxSucbanTimestamp = goLibrerias.ObtenerTimestamp()			lxSucbanSbcod =  .Codigo			lxSucbanSbnro =  .Numero			lxSucbanSbdes =  .Descripcion			lxSucbanSbpiso =  .Piso			lxSucbanSbentfin =  upper( .EntidadFinanciera_PK ) 			lxSucbanSbdepto =  .Departamento			lxSucbanSbnum =  .Numerosuc			lxSucbanSbloc =  .Localidad			lxSucbanSbcp =  .Codigopostal			lxSucbanSbprv =  upper( .Provincia_PK ) 			lxSucbanSbtlf =  .Telefono			lxSucbanSbpais =  upper( .Pais_PK ) 			lxSucbanSbemail =  .Email			lxSucbanSbcontac =  .Contacto			lxSucbanSbobs =  .Observacion
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Sbcod" = ] + lcValorClavePrimariaString  + [ and  SUCBAN.SBCOD != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.SUCBAN set "Fmodifw" = <<"'" + this.ConvertirDateSql( lxSucbanFmodifw ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxSucbanFecexpo ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxSucbanFectrans ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxSucbanFaltafw ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxSucbanFecimpo ) + "'">>, "Sbcalle" = <<"'" + this.FormatearTextoSql( lxSucbanSbcalle ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxSucbanHaltafw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxSucbanHoraimpo ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxSucbanValtafw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxSucbanZadsfw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxSucbanVmodifw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxSucbanUmodifw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxSucbanUaltafw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxSucbanHmodifw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxSucbanSmodifw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxSucbanSaltafw ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxSucbanHoraexpo ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxSucbanEsttrans ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxSucbanBdaltafw ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxSucbanBdmodifw ) + "'">>, "Tipagrupub" = <<lxSucbanTipagrupub>>, "Timestamp" = <<lxSucbanTimestamp>>, "Sbcod" = <<"'" + this.FormatearTextoSql( lxSucbanSbcod ) + "'">>, "Sbnro" = <<lxSucbanSbnro>>, "Sbdes" = <<"'" + this.FormatearTextoSql( lxSucbanSbdes ) + "'">>, "Sbpiso" = <<"'" + this.FormatearTextoSql( lxSucbanSbpiso ) + "'">>, "Sbentfin" = <<"'" + this.FormatearTextoSql( lxSucbanSbentfin ) + "'">>, "Sbdepto" = <<"'" + this.FormatearTextoSql( lxSucbanSbdepto ) + "'">>, "Sbnum" = <<lxSucbanSbnum>>, "Sbloc" = <<"'" + this.FormatearTextoSql( lxSucbanSbloc ) + "'">>, "Sbcp" = <<"'" + this.FormatearTextoSql( lxSucbanSbcp ) + "'">>, "Sbprv" = <<"'" + this.FormatearTextoSql( lxSucbanSbprv ) + "'">>, "Sbtlf" = <<"'" + this.FormatearTextoSql( lxSucbanSbtlf ) + "'">>, "Sbpais" = <<"'" + this.FormatearTextoSql( lxSucbanSbpais ) + "'">>, "Sbemail" = <<"'" + this.FormatearTextoSql( lxSucbanSbemail ) + "'">>, "Sbcontac" = <<"'" + this.FormatearTextoSql( lxSucbanSbcontac ) + "'">>, "Sbobs" = <<"'" + this.FormatearTextoSql( lxSucbanSbobs ) + "'">> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'SUCBAN' 
		loColeccion.agregar( strtran(  lcSentencia, chr( 9 ), '' ) )
			loColeccion.Agregar([delete from ZooLogic.AgruPub131 where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.AgruPubliDetalle
				if this.oEntidad.AgruPubliDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxAgrupamiento_PK = loItem.Agrupamiento_PK
					lxAgrupamientodetalle = loItem.Agrupamientodetalle
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.AgruPub131("NROITEM","Codigo","Agrup","AgrupDes" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxAgrupamiento_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxAgrupamientodetalle ) + "'">> ) 
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

			lcFiltro = ["Sbcod" = ] + lcValorClavePrimariaString  + [ and  SUCBAN.SBCOD != '']
		loColeccion.Agregar( 'delete from ZooLogic.SUCBAN where ' + lcFiltro )
			loColeccion.Agregar([delete from ZooLogic.AgruPub131 where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.cTabla = 'SUCBAN' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.SUCBAN where  SUCBAN.SBCOD != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.SUCBAN where SbCod = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  SUCBAN.SBCOD != ''" )
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
		lcCursor = This.oEntidad.cPrefijoRecibir + 'SUCURSALBANCARIA'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.SUCBAN Where SbCod = ] + "'" + this.FormatearTextoSql( &lcCursor..SbCod ) + "'", 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					this.oConexion.EjecutarSql( [UPDATE ZooLogic.SUCBAN set  FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, SbCalle = ] + "'" + this.FormatearTextoSql( &lcCursor..SbCalle ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, tipagrupub = ] + transform( &lcCursor..tipagrupub )+ [, TIMESTAMP = ] + transform( &lcCursor..TIMESTAMP )+ [, SbCod = ] + "'" + this.FormatearTextoSql( &lcCursor..SbCod ) + "'"+ [, SbNro = ] + transform( &lcCursor..SbNro )+ [, SbDes = ] + "'" + this.FormatearTextoSql( &lcCursor..SbDes ) + "'"+ [, SbPiso = ] + "'" + this.FormatearTextoSql( &lcCursor..SbPiso ) + "'"+ [, SbEntFin = ] + "'" + this.FormatearTextoSql( &lcCursor..SbEntFin ) + "'"+ [, SbDepto = ] + "'" + this.FormatearTextoSql( &lcCursor..SbDepto ) + "'"+ [, SbNum = ] + transform( &lcCursor..SbNum )+ [, SbLoc = ] + "'" + this.FormatearTextoSql( &lcCursor..SbLoc ) + "'"+ [, SbCP = ] + "'" + this.FormatearTextoSql( &lcCursor..SbCP ) + "'"+ [, SbPrv = ] + "'" + this.FormatearTextoSql( &lcCursor..SbPrv ) + "'"+ [, SbTlf = ] + "'" + this.FormatearTextoSql( &lcCursor..SbTlf ) + "'"+ [, SbPais = ] + "'" + this.FormatearTextoSql( &lcCursor..SbPais ) + "'"+ [, SbEmail = ] + "'" + this.FormatearTextoSql( &lcCursor..SbEmail ) + "'"+ [, SbContac = ] + "'" + this.FormatearTextoSql( &lcCursor..SbContac ) + "'"+ [, SbObs = ] + "'" + this.FormatearTextoSql( &lcCursor..SbObs ) + "'" + [ Where SbCod = ] + "'" + this.FormatearTextoSql( &lcCursor..SbCod ) + "'" )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
				endIf
			else
				Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
				Text to lcCampos noShow
					 FMODIFW, FECEXPO, FECTRANS, FALTAFW, FECIMPO, SbCalle, HALTAFW, HORAIMPO, VALTAFW, ZADSFW, VMODIFW, UMODIFW, UALTAFW, HMODIFW, SMODIFW, SALTAFW, HORAEXPO, ESTTRANS, BDALTAFW, BDMODIFW, tipagrupub, TIMESTAMP, SbCod, SbNro, SbDes, SbPiso, SbEntFin, SbDepto, SbNum, SbLoc, SbCP, SbPrv, SbTlf, SbPais, SbEmail, SbContac, SbObs
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SbCalle ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + transform( &lcCursor..tipagrupub )
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..TIMESTAMP ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..SbCod ) + "'" + ',' + transform( &lcCursor..SbNro ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..SbDes ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SbPiso ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SbEntFin ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SbDepto ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..SbNum ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..SbLoc ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SbCP ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SbPrv ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SbTlf ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SbPais ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SbEmail ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..SbContac ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SbObs ) + "'"
lcValoresCampos = substr(lcValoresCampos,2) 

				this.oConexion.EjecutarSql( [Insert into ZooLogic.SUCBAN ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
				this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'SUCURSALBANCARIA'
		if This.ActualizaEnRecepcion()
		Local lcIn as String, lcCantRegistros as Integer
		Select( lcCursor )
		Count to lcCantRegistros
		If lcCantRegistros > 0
			lcIn = This.ObtenerInSqlServer( lcCursor, 'SbCod','C')
			lnFragmento = goRegistry.nucleo.cantidadDeElementosEnSentenciaInSQL
			loIn = this.ObtenerColeccionInSqlServer( lcCursor,'','SbCod')
			llEjecutaEnTransaccion = loIn.count > 0
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'BEGIN TRANSACTION' )
			endif
			for i = 1 to loIn.count step lnFragmento
				lcIn = this.ObtenerFragmentoColeccionInSqlServer( loIn, i, lnFragmento )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.AgruPub131 Where Codigo] + lcIn  )
			endfor
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'COMMIT TRANSACTION' )
			endif
		EndIf
	endif
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMAGRUPAPUBLIC131'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where Codigo in ( select SbCod from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"NROITEM","Codigo","Agrup","AgrupDes"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.AgruPub131 ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Codigo     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Agrup      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.AgrupDes   ) + "'" + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	Use in select( 'cExistentes' )
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearCursorMemo( tcCursorACrear as String, tcTablaConMemo as String ) as Void
		create cursor &tcCursorACrear ( SbCod C (5) , Orden N(16), texto C(80))
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirComponentes() As Void
		
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function ObtenerIdentificadorParaLoguear( tcCursor as String ) As String
		local lcRetorno as String, lnCC as String , loCC as Object, lni as Integer, lcSecuencia as String
		lcRetorno = this.oEntidad.cDescripcion 
		lcRetorno = lcRetorno + ' - Código: ' + transform( &tcCursor..SbCod      )
		Return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EsAliasDeProceso( tcAlias As String, tcPrefijo as string ) As Boolean
		local llRetorno as Boolean, lcAlias as String, lcPrefijo As String
		llRetorno = .F.
		lcAlias = upper( alltrim( tcAlias ) )
		lcPrefijo = upper( alltrim( tcPrefijo ) )
		Do Case
			Case  lcAlias == lcPrefijo + 'SUCURSALBANCARIA'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'SUCURSALBANCARIA_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'SUCURSALBANCARIA_SBOBS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMAGRUPAPUBLIC131'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_SucBan')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'SUCURSALBANCARIA'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..SbCod
		llCondicion = isnull( lxVar )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad SUCURSALBANCARIA. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'SUCURSALBANCARIA'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		select recno() as _Rec, * from &lcCursor into cursor CurConRecno
		select max( _Rec ) as Maximo,SbCod as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( SbCod, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		Use in select( 'CurConRecno' )
		Use in select( 'RepMax' )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDatosInvalidos( toConexion as Object ) as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'SUCURSALBANCARIA'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_SucBan') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_SucBan
Create Table ZooLogic.TablaTrabajo_SucBan ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fmodifw" datetime  null, 
"fecexpo" datetime  null, 
"fectrans" datetime  null, 
"faltafw" datetime  null, 
"fecimpo" datetime  null, 
"sbcalle" char( 70 )  null, 
"haltafw" char( 8 )  null, 
"horaimpo" char( 8 )  null, 
"valtafw" char( 13 )  null, 
"zadsfw" varchar(max)  null, 
"vmodifw" char( 13 )  null, 
"umodifw" char( 100 )  null, 
"ualtafw" char( 100 )  null, 
"hmodifw" char( 8 )  null, 
"smodifw" char( 7 )  null, 
"saltafw" char( 7 )  null, 
"horaexpo" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"bdaltafw" char( 8 )  null, 
"bdmodifw" char( 8 )  null, 
"tipagrupub" numeric( 1, 0 )  null, 
"timestamp" numeric( 20, 0 )  null, 
"sbcod" char( 5 )  null, 
"sbnro" numeric( 5, 0 )  null, 
"sbdes" char( 40 )  null, 
"sbpiso" char( 3 )  null, 
"sbentfin" char( 5 )  null, 
"sbdepto" char( 3 )  null, 
"sbnum" numeric( 10, 0 )  null, 
"sbloc" char( 70 )  null, 
"sbcp" char( 8 )  null, 
"sbprv" char( 2 )  null, 
"sbtlf" char( 30 )  null, 
"sbpais" char( 3 )  null, 
"sbemail" char( 60 )  null, 
"sbcontac" char( 60 )  null, 
"sbobs" varchar(max)  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_SucBan' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_SucBan' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'SUCURSALBANCARIA'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		with loManejador
			if this.oEntidad.VerificarContexto( 'CB' )
			else
				.AgregarMapeo('Nrolinea','Nrolinea')
			endif
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('sbcalle','sbcalle')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('tipagrupub','tipagrupub')
			.AgregarMapeo('timestamp','timestamp')
			.AgregarMapeo('sbcod','sbcod')
			.AgregarMapeo('sbnro','sbnro')
			.AgregarMapeo('sbdes','sbdes')
			.AgregarMapeo('sbpiso','sbpiso')
			.AgregarMapeo('sbentfin','sbentfin')
			.AgregarMapeo('sbdepto','sbdepto')
			.AgregarMapeo('sbnum','sbnum')
			.AgregarMapeo('sbloc','sbloc')
			.AgregarMapeo('sbcp','sbcp')
			.AgregarMapeo('sbprv','sbprv')
			.AgregarMapeo('sbtlf','sbtlf')
			.AgregarMapeo('sbpais','sbpais')
			.AgregarMapeo('sbemail','sbemail')
			.AgregarMapeo('sbcontac','sbcontac')
			.AgregarMapeo('sbobs','sbobs')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_SucBan'
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
				Update t Set t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.SBCALLE = isnull( d.SBCALLE, t.SBCALLE ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.TIPAGRUPUB = isnull( d.TIPAGRUPUB, t.TIPAGRUPUB ),t.TIMESTAMP = isnull( d.TIMESTAMP, t.TIMESTAMP ),t.SBCOD = isnull( d.SBCOD, t.SBCOD ),t.SBNRO = isnull( d.SBNRO, t.SBNRO ),t.SBDES = isnull( d.SBDES, t.SBDES ),t.SBPISO = isnull( d.SBPISO, t.SBPISO ),t.SBENTFIN = isnull( d.SBENTFIN, t.SBENTFIN ),t.SBDEPTO = isnull( d.SBDEPTO, t.SBDEPTO ),t.SBNUM = isnull( d.SBNUM, t.SBNUM ),t.SBLOC = isnull( d.SBLOC, t.SBLOC ),t.SBCP = isnull( d.SBCP, t.SBCP ),t.SBPRV = isnull( d.SBPRV, t.SBPRV ),t.SBTLF = isnull( d.SBTLF, t.SBTLF ),t.SBPAIS = isnull( d.SBPAIS, t.SBPAIS ),t.SBEMAIL = isnull( d.SBEMAIL, t.SBEMAIL ),t.SBCONTAC = isnull( d.SBCONTAC, t.SBCONTAC ),t.SBOBS = isnull( d.SBOBS, t.SBOBS )
					from ZooLogic.SUCBAN t inner join deleted d 
							 on t.SbCod = d.SbCod
				-- Fin Updates
				insert into ZooLogic.SUCBAN(Fmodifw,Fecexpo,Fectrans,Faltafw,Fecimpo,Sbcalle,Haltafw,Horaimpo,Valtafw,Zadsfw,Vmodifw,Umodifw,Ualtafw,Hmodifw,Smodifw,Saltafw,Horaexpo,Esttrans,Bdaltafw,Bdmodifw,Tipagrupub,Timestamp,Sbcod,Sbnro,Sbdes,Sbpiso,Sbentfin,Sbdepto,Sbnum,Sbloc,Sbcp,Sbprv,Sbtlf,Sbpais,Sbemail,Sbcontac,Sbobs)
					Select isnull( d.FMODIFW,''),isnull( d.FECEXPO,''),isnull( d.FECTRANS,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FECIMPO,''),isnull( d.SBCALLE,''),convert( char(8), getdate(), 108 ),isnull( d.HORAIMPO,''),isnull( d.VALTAFW,''),isnull( d.ZADSFW,''),isnull( d.VMODIFW,''),isnull( d.UMODIFW,''),isnull( d.UALTAFW,''),isnull( d.HMODIFW,''),isnull( d.SMODIFW,''),isnull( d.SALTAFW,''),isnull( d.HORAEXPO,''),isnull( d.ESTTRANS,''),isnull( d.BDALTAFW,''),isnull( d.BDMODIFW,''),isnull( d.TIPAGRUPUB,0),isnull( d.TIMESTAMP,0),isnull( d.SBCOD,''),isnull( d.SBNRO,0),isnull( d.SBDES,''),isnull( d.SBPISO,''),isnull( d.SBENTFIN,''),isnull( d.SBDEPTO,''),isnull( d.SBNUM,0),isnull( d.SBLOC,''),isnull( d.SBCP,''),isnull( d.SBPRV,''),isnull( d.SBTLF,''),isnull( d.SBPAIS,''),isnull( d.SBEMAIL,''),isnull( d.SBCONTAC,''),isnull( d.SBOBS,'')
						From deleted d left join ZooLogic.SUCBAN pk 
							 on d.SbCod = pk.SbCod
						Where pk.SbCod Is Null 
				-- Fin Inserts
			End
		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_AgruPub131( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_SUCBAN_AgruPub131
ON ZooLogic.TablaTrabajo_SUCBAN_AgruPub131
AFTER DELETE
As
Begin
Update t Set 
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.CODIGO = isnull( d.CODIGO, t.CODIGO ),
t.AGRUP = isnull( d.AGRUP, t.AGRUP ),
t.AGRUPDES = isnull( d.AGRUPDES, t.AGRUPDES )
from ZooLogic.AgruPub131 t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.AgruPub131
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
From deleted d left join ZooLogic.AgruPub131 pk 
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_SucBan') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_SucBan
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_SUCURSALBANCARIA' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_SUCURSALBANCARIA.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_SUCURSALBANCARIA.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_SUCURSALBANCARIA.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_SUCURSALBANCARIA.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_SUCURSALBANCARIA.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Calle = nvl( c_SUCURSALBANCARIA.Calle, [] )
					.Horaaltafw = nvl( c_SUCURSALBANCARIA.Horaaltafw, [] )
					.Horaimpo = nvl( c_SUCURSALBANCARIA.Horaimpo, [] )
					.Versionaltafw = nvl( c_SUCURSALBANCARIA.Versionaltafw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Versionmodificacionfw = nvl( c_SUCURSALBANCARIA.Versionmodificacionfw, [] )
					.Usuariomodificacionfw = nvl( c_SUCURSALBANCARIA.Usuariomodificacionfw, [] )
					.Usuarioaltafw = nvl( c_SUCURSALBANCARIA.Usuarioaltafw, [] )
					.Horamodificacionfw = nvl( c_SUCURSALBANCARIA.Horamodificacionfw, [] )
					.Seriemodificacionfw = nvl( c_SUCURSALBANCARIA.Seriemodificacionfw, [] )
					.Seriealtafw = nvl( c_SUCURSALBANCARIA.Seriealtafw, [] )
					.Horaexpo = nvl( c_SUCURSALBANCARIA.Horaexpo, [] )
					.Estadotransferencia = nvl( c_SUCURSALBANCARIA.Estadotransferencia, [] )
					.Basededatosaltafw = nvl( c_SUCURSALBANCARIA.Basededatosaltafw, [] )
					.Basededatosmodificacionfw = nvl( c_SUCURSALBANCARIA.Basededatosmodificacionfw, [] )
					.Tipoagrupamientopublicaciones = nvl( c_SUCURSALBANCARIA.Tipoagrupamientopublicaciones, 0 )
					.Timestamp = nvl( c_SUCURSALBANCARIA.Timestamp, 0 )
					.Codigo = nvl( c_SUCURSALBANCARIA.Codigo, [] )
					.Numero = nvl( c_SUCURSALBANCARIA.Numero, 0 )
					.Descripcion = nvl( c_SUCURSALBANCARIA.Descripcion, [] )
					if !.lEsSubEntidad
					.Agrupublidetalle.Limpiar()
					.Agrupublidetalle.SetearEsNavegacion( .lProcesando )
					.Agrupublidetalle.Cargar()
					endif
					.Piso = nvl( c_SUCURSALBANCARIA.Piso, [] )
					.Entidadfinanciera_PK =  nvl( c_SUCURSALBANCARIA.Entidadfinanciera, [] )
					.Departamento = nvl( c_SUCURSALBANCARIA.Departamento, [] )
					.Numerosuc = nvl( c_SUCURSALBANCARIA.Numerosuc, 0 )
					.Localidad = nvl( c_SUCURSALBANCARIA.Localidad, [] )
					.Codigopostal = nvl( c_SUCURSALBANCARIA.Codigopostal, [] )
					.Provincia_PK =  nvl( c_SUCURSALBANCARIA.Provincia, [] )
					.Telefono = nvl( c_SUCURSALBANCARIA.Telefono, [] )
					.Pais_PK =  nvl( c_SUCURSALBANCARIA.Pais, [] )
					.Email = nvl( c_SUCURSALBANCARIA.Email, [] )
					.Contacto = nvl( c_SUCURSALBANCARIA.Contacto, [] )
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
		return c_SUCURSALBANCARIA.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.SUCBAN' )
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
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "SbCod"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
		text to lcSQL textmerge noshow
				SELECT nro,totalRegistros,SbCod as Id
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    SbCod from (
							select * 
								from ZooLogic.SUCBAN 
								Where   SUCBAN.SBCOD != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "SUCBAN", "", lcCursor, set("Datasession") )
		lcXml = this.CursorAXml( lcCursor )
		
		use in select( lcCursor )
		
		Return lcXml 
		
	endfunc
	*-----------------------------------------------------------------------------------------
	function ObtenerDatosEntidadPaginado( tcOrderBy as String, tcFiltro as String, tnCantidad as Integer, tnPagina as Integer )  as String
		local lcOrderBy as String, lnCuantos as Integer, lnPagina as Integer, lnTope as Integer, lnDesde as Integer, lcSQL as String, lcCursor as String, lcXml as String
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "SbCod"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
			text to lcAtributos textmerge noshow
			"Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Sbcalle" as "Calle", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Horaexpo" as "Horaexpo", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Tipagrupub" as "Tipoagrupamientopublicaciones", "Timestamp" as "Timestamp", "Sbcod" as "Codigo", "Sbnro" as "Numero", "Sbdes" as "Descripcion", "Sbpiso" as "Piso", "Sbentfin" as "Entidadfinanciera", "Sbdepto" as "Departamento", "Sbnum" as "Numerosuc", "Sbloc" as "Localidad", "Sbcp" as "Codigopostal", "Sbprv" as "Provincia", "Sbtlf" as "Telefono", "Sbpais" as "Pais", "Sbemail" as "Email", "Sbcontac" as "Contacto", "Sbobs" as "Observacion"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.SUCBAN 
								Where   SUCBAN.SBCOD != ''
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
	Tabla = 'SUCBAN'
	Filtro = " SUCBAN.SBCOD != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " SUCBAN.SBCOD != ''"
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
	<row entidad="SUCURSALBANCARIA                        " atributo="FECHAMODIFICACIONFW                     " tabla="SUCBAN         " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSALBANCARIA                        " atributo="FECHAEXPO                               " tabla="SUCBAN         " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSALBANCARIA                        " atributo="FECHATRANSFERENCIA                      " tabla="SUCBAN         " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha de novedad                                                                                                                                                " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSALBANCARIA                        " atributo="FECHAALTAFW                             " tabla="SUCBAN         " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSALBANCARIA                        " atributo="FECHAIMPO                               " tabla="SUCBAN         " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSALBANCARIA                        " atributo="CALLE                                   " tabla="SUCBAN         " campo="SBCALLE   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="70" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="10" etiqueta="Calle                                                                                                                                                           " dominio="DIRECCION                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSALBANCARIA                        " atributo="HORAALTAFW                              " tabla="SUCBAN         " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSALBANCARIA                        " atributo="HORAIMPO                                " tabla="SUCBAN         " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSALBANCARIA                        " atributo="VERSIONALTAFW                           " tabla="SUCBAN         " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSALBANCARIA                        " atributo="ZADSFW                                  " tabla="SUCBAN         " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSALBANCARIA                        " atributo="VERSIONMODIFICACIONFW                   " tabla="SUCBAN         " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSALBANCARIA                        " atributo="USUARIOMODIFICACIONFW                   " tabla="SUCBAN         " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSALBANCARIA                        " atributo="USUARIOALTAFW                           " tabla="SUCBAN         " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSALBANCARIA                        " atributo="HORAMODIFICACIONFW                      " tabla="SUCBAN         " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSALBANCARIA                        " atributo="SERIEMODIFICACIONFW                     " tabla="SUCBAN         " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSALBANCARIA                        " atributo="SERIEALTAFW                             " tabla="SUCBAN         " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSALBANCARIA                        " atributo="HORAEXPO                                " tabla="SUCBAN         " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSALBANCARIA                        " atributo="ESTADOTRANSFERENCIA                     " tabla="SUCBAN         " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado de novedad                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSALBANCARIA                        " atributo="BASEDEDATOSALTAFW                       " tabla="SUCBAN         " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSALBANCARIA                        " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="SUCBAN         " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSALBANCARIA                        " atributo="TIPOAGRUPAMIENTOPUBLICACIONES           " tabla="SUCBAN         " campo="TIPAGRUPUB" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSALBANCARIA                        " atributo="TIMESTAMP                               " tabla="SUCBAN         " campo="TIMESTAMP " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSALBANCARIA                        " atributo="CODIGO                                  " tabla="SUCBAN         " campo="SBCOD     " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="2" etiqueta="Código                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSALBANCARIA                        " atributo="NUMERO                                  " tabla="SUCBAN         " campo="SBNRO     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="12" etiqueta="Número                                                                                                                                                          " dominio="DIRECCION                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSALBANCARIA                        " atributo="DESCRIPCION                             " tabla="SUCBAN         " campo="SBDES     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="4" etiqueta="Descripción                                                                                                                                                     " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSALBANCARIA                        " atributo="AGRUPUBLIDETALLE                        " tabla="AGRUPUB131     " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Agrupamientos                                                                                                                                                   " dominio="DETALLEITEMAGRUPAPUBLIC131    " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="1" alta="false" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSALBANCARIA                        " atributo="PISO                                    " tabla="SUCBAN         " campo="SBPISO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="3" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="Piso                                                                                                                                                            " dominio="DIRECCION                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSALBANCARIA                        " atributo="ENTIDADFINANCIERA                       " tabla="SUCBAN         " campo="SBENTFIN  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="ENTIDADFINANCIERA                       " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="6" etiqueta="Entidad financiera                                                                                                                                              " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSALBANCARIA                        " atributo="DEPARTAMENTO                            " tabla="SUCBAN         " campo="SBDEPTO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="3" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="402" etiqueta="Departamento                                                                                                                                                    " dominio="DIRECCION                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSALBANCARIA                        " atributo="NUMEROSUC                               " tabla="SUCBAN         " campo="SBNUM     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="8" etiqueta="Número de sucursal                                                                                                                                              " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSALBANCARIA                        " atributo="LOCALIDAD                               " tabla="SUCBAN         " campo="SBLOC     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="70" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="14" etiqueta="Localidad                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSALBANCARIA                        " atributo="CODIGOPOSTAL                            " tabla="SUCBAN         " campo="SBCP      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="404" etiqueta="Código postal                                                                                                                                                   " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSALBANCARIA                        " atributo="PROVINCIA                               " tabla="SUCBAN         " campo="SBPRV     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="PROVINCIA                               " tipodato="C         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="406" etiqueta="Provincia                                                                                                                                                       " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSALBANCARIA                        " atributo="TELEFONO                                " tabla="SUCBAN         " campo="SBTLF     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="16" etiqueta="Teléfono                                                                                                                                                        " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="8" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSALBANCARIA                        " atributo="PAIS                                    " tabla="SUCBAN         " campo="SBPAIS    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="PAISES                                  " tipodato="C         " longitud="3" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="408" etiqueta="País                                                                                                                                                            " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="8" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSALBANCARIA                        " atributo="EMAIL                                   " tabla="SUCBAN         " campo="SBEMAIL   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="410" etiqueta="Email                                                                                                                                                           " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="9" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSALBANCARIA                        " atributo="CONTACTO                                " tabla="SUCBAN         " campo="SBCONTAC  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="18" etiqueta="Contacto                                                                                                                                                        " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="10" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSALBANCARIA                        " atributo="OBSERVACION                             " tabla="SUCBAN         " campo="SBOBS     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="412" etiqueta="Observaciones                                                                                                                                                   " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="11" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ENTIDADFINANCIERA                       " atributo="DESCRIPCION                             " tabla="ENTFIN         " campo="EFDES     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="7" etiqueta="Detalle Ent.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join ENTFIN On SUCBAN.SBENTFIN = ENTFIN.EfCod And  ENTFIN.EFCOD != ''                                                                                                                                                                                   " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVINCIA                               " atributo="DESCRIPCION                             " tabla="PROVINCI       " campo="PRV_DES   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="407" etiqueta="Detalle Pro.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join PROVINCI On SUCBAN.SBPRV = PROVINCI.PRV_COD And  PROVINCI.PRV_COD != ''                                                                                                                                                                            " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PAISES                                  " atributo="DESCRIPCION                             " tabla="PAISES         " campo="PDES      " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="409" etiqueta="Detalle Paí.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join PAISES On SUCBAN.SBPAIS = PAISES.pcod And  PAISES.PCOD != ''                                                                                                                                                                                       " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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