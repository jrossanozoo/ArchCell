
define class Din_EntidadTRANSPORTISTAAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_TRANSPORTISTA'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = []
	cExpresionCCPorCampos = []
	cTagClaveCandidata = ''
	cTagClavePk = '_TRAPK'
	cTablaPrincipal = 'TRA'
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
			local  lxTraCd1, lxTraFaltafw, lxTraFecexpo, lxTraFecimpo, lxTraFmodifw, lxTraFectrans, lxTraTrcalle, lxTraUmodifw, lxTraHaltafw, lxTraHoraimpo, lxTraSaltafw, lxTraSmodifw, lxTraHmodifw, lxTraHoraexpo, lxTraBdaltafw, lxTraEsttrans, lxTraVmodifw, lxTraZadsfw, lxTraValtafw, lxTraTrtlf, lxTraBdmodifw, lxTraUaltafw, lxTraTriva, lxTraTimestamp, lxTraTimagen, lxTraTrcod, lxTraTrobs, lxTraTrcuit, lxTraTrnro, lxTraTrmovil, lxTraTrnom, lxTraTrtipodoc, lxTraTrpiso, lxTraTrfax, lxTraTremail, lxTraTrnrodoc, lxTraTrdepto, lxTraTrpageweb, lxTraTrloc, lxTraTrmsn, lxTraTrcp, lxTraTrprv, lxTraTrpais
				lxTraCd1 =  .Fechaultimamodificacion			lxTraFaltafw =  .Fechaaltafw			lxTraFecexpo =  .Fechaexpo			lxTraFecimpo =  .Fechaimpo			lxTraFmodifw =  .Fechamodificacionfw			lxTraFectrans =  .Fechatransferencia			lxTraTrcalle =  .Calle			lxTraUmodifw =  .Usuariomodificacionfw			lxTraHaltafw =  .Horaaltafw			lxTraHoraimpo =  .Horaimpo			lxTraSaltafw =  .Seriealtafw			lxTraSmodifw =  .Seriemodificacionfw			lxTraHmodifw =  .Horamodificacionfw			lxTraHoraexpo =  .Horaexpo			lxTraBdaltafw =  .Basededatosaltafw			lxTraEsttrans =  .Estadotransferencia			lxTraVmodifw =  .Versionmodificacionfw			lxTraZadsfw =  .Zadsfw			lxTraValtafw =  .Versionaltafw			lxTraTrtlf =  .Telefono			lxTraBdmodifw =  .Basededatosmodificacionfw			lxTraUaltafw =  .Usuarioaltafw			lxTraTriva =  .Situacionfiscal_PK 			lxTraTimestamp = goLibrerias.ObtenerTimestamp()			lxTraTimagen =  .Imagen			lxTraTrcod =  .Codigo			lxTraTrobs =  .Observacion			lxTraTrcuit =  .Cuit			lxTraTrnro =  .Numero			lxTraTrmovil =  .Movil			lxTraTrnom =  .Nombre			lxTraTrtipodoc =  .Tipodocumento			lxTraTrpiso =  .Piso			lxTraTrfax =  .Fax			lxTraTremail =  .Email			lxTraTrnrodoc =  .Nrodocumento			lxTraTrdepto =  .Departamento			lxTraTrpageweb =  .Paginaweb			lxTraTrloc =  .Localidad			lxTraTrmsn =  .Messenger			lxTraTrcp =  .Codigopostal			lxTraTrprv =  upper( .Provincia_PK ) 			lxTraTrpais =  upper( .Pais_PK ) 
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxTraTrcod = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.TRA ( "Cd1","Faltafw","Fecexpo","Fecimpo","Fmodifw","Fectrans","Trcalle","Umodifw","Haltafw","Horaimpo","Saltafw","Smodifw","Hmodifw","Horaexpo","Bdaltafw","Esttrans","Vmodifw","Zadsfw","Valtafw","Trtlf","Bdmodifw","Ualtafw","Triva","Timestamp","Timagen","Trcod","Trobs","Trcuit","Trnro","Trmovil","Trnom","Trtipodoc","Trpiso","Trfax","Tremail","Trnrodoc","Trdepto","Trpageweb","Trloc","Trmsn","Trcp","Trprv","Trpais" ) values ( <<"'" + this.ConvertirDateSql( lxTraCd1 ) + "'" >>, <<"'" + this.ConvertirDateSql( lxTraFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxTraFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxTraFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxTraFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxTraFectrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTraTrcalle ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTraUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTraHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTraHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTraSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTraSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTraHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTraHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTraBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTraEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTraVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTraZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTraValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTraTrtlf ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTraBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTraUaltafw ) + "'" >>, <<lxTraTriva >>, <<lxTraTimestamp >>, <<"'" + this.FormatearTextoSql( lxTraTimagen ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTraTrcod ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTraTrobs ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTraTrcuit ) + "'" >>, <<lxTraTrnro >>, <<"'" + this.FormatearTextoSql( lxTraTrmovil ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTraTrnom ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTraTrtipodoc ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTraTrpiso ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTraTrfax ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTraTremail ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTraTrnrodoc ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTraTrdepto ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTraTrpageweb ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTraTrloc ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTraTrmsn ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTraTrcp ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTraTrprv ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTraTrpais ) + "'" >> )
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
		this.ComprobarTransaccion()
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = lxValorClavePrimaria


			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.VehiculoDetalle
				if this.oEntidad.VehiculoDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxDominio = loItem.Dominio
					lxTipovehiculo = loItem.Tipovehiculo
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.VehiculoDet("NROITEM","Codigo","Dominio","TipoVehi" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxDominio ) + "'">>, <<lxTipovehiculo>> ) 
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
		this.oEntidad.Timestamp = lxTraTimestamp
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
			local  lxTraCd1, lxTraFaltafw, lxTraFecexpo, lxTraFecimpo, lxTraFmodifw, lxTraFectrans, lxTraTrcalle, lxTraUmodifw, lxTraHaltafw, lxTraHoraimpo, lxTraSaltafw, lxTraSmodifw, lxTraHmodifw, lxTraHoraexpo, lxTraBdaltafw, lxTraEsttrans, lxTraVmodifw, lxTraZadsfw, lxTraValtafw, lxTraTrtlf, lxTraBdmodifw, lxTraUaltafw, lxTraTriva, lxTraTimestamp, lxTraTimagen, lxTraTrcod, lxTraTrobs, lxTraTrcuit, lxTraTrnro, lxTraTrmovil, lxTraTrnom, lxTraTrtipodoc, lxTraTrpiso, lxTraTrfax, lxTraTremail, lxTraTrnrodoc, lxTraTrdepto, lxTraTrpageweb, lxTraTrloc, lxTraTrmsn, lxTraTrcp, lxTraTrprv, lxTraTrpais
				lxTraCd1 =  .Fechaultimamodificacion			lxTraFaltafw =  .Fechaaltafw			lxTraFecexpo =  .Fechaexpo			lxTraFecimpo =  .Fechaimpo			lxTraFmodifw =  .Fechamodificacionfw			lxTraFectrans =  .Fechatransferencia			lxTraTrcalle =  .Calle			lxTraUmodifw =  .Usuariomodificacionfw			lxTraHaltafw =  .Horaaltafw			lxTraHoraimpo =  .Horaimpo			lxTraSaltafw =  .Seriealtafw			lxTraSmodifw =  .Seriemodificacionfw			lxTraHmodifw =  .Horamodificacionfw			lxTraHoraexpo =  .Horaexpo			lxTraBdaltafw =  .Basededatosaltafw			lxTraEsttrans =  .Estadotransferencia			lxTraVmodifw =  .Versionmodificacionfw			lxTraZadsfw =  .Zadsfw			lxTraValtafw =  .Versionaltafw			lxTraTrtlf =  .Telefono			lxTraBdmodifw =  .Basededatosmodificacionfw			lxTraUaltafw =  .Usuarioaltafw			lxTraTriva =  .Situacionfiscal_PK 			lxTraTimestamp = goLibrerias.ObtenerTimestamp()			lxTraTimagen =  .Imagen			lxTraTrcod =  .Codigo			lxTraTrobs =  .Observacion			lxTraTrcuit =  .Cuit			lxTraTrnro =  .Numero			lxTraTrmovil =  .Movil			lxTraTrnom =  .Nombre			lxTraTrtipodoc =  .Tipodocumento			lxTraTrpiso =  .Piso			lxTraTrfax =  .Fax			lxTraTremail =  .Email			lxTraTrnrodoc =  .Nrodocumento			lxTraTrdepto =  .Departamento			lxTraTrpageweb =  .Paginaweb			lxTraTrloc =  .Localidad			lxTraTrmsn =  .Messenger			lxTraTrcp =  .Codigopostal			lxTraTrprv =  upper( .Provincia_PK ) 			lxTraTrpais =  upper( .Pais_PK ) 
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
				update ZooLogic.TRA set "Cd1" = <<"'" + this.ConvertirDateSql( lxTraCd1 ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxTraFaltafw ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxTraFecexpo ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxTraFecimpo ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxTraFmodifw ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxTraFectrans ) + "'">>,"Trcalle" = <<"'" + this.FormatearTextoSql( lxTraTrcalle ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxTraUmodifw ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxTraHaltafw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxTraHoraimpo ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxTraSaltafw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxTraSmodifw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxTraHmodifw ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxTraHoraexpo ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxTraBdaltafw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxTraEsttrans ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxTraVmodifw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxTraZadsfw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxTraValtafw ) + "'">>,"Trtlf" = <<"'" + this.FormatearTextoSql( lxTraTrtlf ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxTraBdmodifw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxTraUaltafw ) + "'">>,"Triva" = <<lxTraTriva>>,"Timestamp" = <<lxTraTimestamp>>,"Timagen" = <<"'" + this.FormatearTextoSql( lxTraTimagen ) + "'">>,"Trcod" = <<"'" + this.FormatearTextoSql( lxTraTrcod ) + "'">>,"Trobs" = <<"'" + this.FormatearTextoSql( lxTraTrobs ) + "'">>,"Trcuit" = <<"'" + this.FormatearTextoSql( lxTraTrcuit ) + "'">>,"Trnro" = <<lxTraTrnro>>,"Trmovil" = <<"'" + this.FormatearTextoSql( lxTraTrmovil ) + "'">>,"Trnom" = <<"'" + this.FormatearTextoSql( lxTraTrnom ) + "'">>,"Trtipodoc" = <<"'" + this.FormatearTextoSql( lxTraTrtipodoc ) + "'">>,"Trpiso" = <<"'" + this.FormatearTextoSql( lxTraTrpiso ) + "'">>,"Trfax" = <<"'" + this.FormatearTextoSql( lxTraTrfax ) + "'">>,"Tremail" = <<"'" + this.FormatearTextoSql( lxTraTremail ) + "'">>,"Trnrodoc" = <<"'" + this.FormatearTextoSql( lxTraTrnrodoc ) + "'">>,"Trdepto" = <<"'" + this.FormatearTextoSql( lxTraTrdepto ) + "'">>,"Trpageweb" = <<"'" + this.FormatearTextoSql( lxTraTrpageweb ) + "'">>,"Trloc" = <<"'" + this.FormatearTextoSql( lxTraTrloc ) + "'">>,"Trmsn" = <<"'" + this.FormatearTextoSql( lxTraTrmsn ) + "'">>,"Trcp" = <<"'" + this.FormatearTextoSql( lxTraTrcp ) + "'">>,"Trprv" = <<"'" + this.FormatearTextoSql( lxTraTrprv ) + "'">>,"Trpais" = <<"'" + this.FormatearTextoSql( lxTraTrpais ) + "'">> where "Trcod" = <<"'" + this.FormatearTextoSql( lxTraTrcod ) + "'">> and  TRA.TRCOD != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			this.ComprobarResultadoDeEjecucionDelUpdate()
		this.ComprobarTransaccion()
			this.oConexion.EjecutarSql( 'delete from ZooLogic.VehiculoDet where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.VehiculoDetalle
				if this.oEntidad.VehiculoDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxDominio = loItem.Dominio
					lxTipovehiculo = loItem.Tipovehiculo
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.VehiculoDet("NROITEM","Codigo","Dominio","TipoVehi" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxDominio ) + "'">>, <<lxTipovehiculo>> ) 
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
		this.oEntidad.Timestamp = lxTraTimestamp
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 TRCOD from ZooLogic.TRA where " + this.ConvertirFuncionesSql( " TRA.TRCOD != ''" ) )
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
			Local lxTraTrcod
			lxTraTrcod = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Cd1" as "Fechaultimamodificacion", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Trcalle" as "Calle", "Umodifw" as "Usuariomodificacionfw", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Horaexpo" as "Horaexpo", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Trtlf" as "Telefono", "Bdmodifw" as "Basededatosmodificacionfw", "Ualtafw" as "Usuarioaltafw", "Triva" as "Situacionfiscal", "Timestamp" as "Timestamp", "Timagen" as "Imagen", "Trcod" as "Codigo", "Trobs" as "Observacion", "Trcuit" as "Cuit", "Trnro" as "Numero", "Trmovil" as "Movil", "Trnom" as "Nombre", "Trtipodoc" as "Tipodocumento", "Trpiso" as "Piso", "Trfax" as "Fax", "Tremail" as "Email", "Trnrodoc" as "Nrodocumento", "Trdepto" as "Departamento", "Trpageweb" as "Paginaweb", "Trloc" as "Localidad", "Trmsn" as "Messenger", "Trcp" as "Codigopostal", "Trprv" as "Provincia", "Trpais" as "Pais" from ZooLogic.TRA where "Trcod" = <<"'" + this.FormatearTextoSql( lxTraTrcod ) + "'">> and  TRA.TRCOD != ''
			endtext
			use in select('c_TRANSPORTISTA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_TRANSPORTISTA', set( 'Datasession' ) )

			if reccount( 'c_TRANSPORTISTA' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Dominio" as "Dominio", "Tipovehi" as "Tipovehiculo" from ZooLogic.VehiculoDet where Codigo = <<"'" + this.FormatearTextoSql( c_TRANSPORTISTA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_VehiculoDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_VehiculoDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_VehiculoDetalle
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxTraTrcod as Variant
		llRetorno = .t.
		lxTraTrcod = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.TRA where "Trcod" = <<"'" + this.FormatearTextoSql( lxTraTrcod ) + "'">> and  TRA.TRCOD != ''
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
				select top 1 "Cd1" as "Fechaultimamodificacion", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Trcalle" as "Calle", "Umodifw" as "Usuariomodificacionfw", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Horaexpo" as "Horaexpo", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Trtlf" as "Telefono", "Bdmodifw" as "Basededatosmodificacionfw", "Ualtafw" as "Usuarioaltafw", "Triva" as "Situacionfiscal", "Timestamp" as "Timestamp", "Timagen" as "Imagen", "Trcod" as "Codigo", "Trobs" as "Observacion", "Trcuit" as "Cuit", "Trnro" as "Numero", "Trmovil" as "Movil", "Trnom" as "Nombre", "Trtipodoc" as "Tipodocumento", "Trpiso" as "Piso", "Trfax" as "Fax", "Tremail" as "Email", "Trnrodoc" as "Nrodocumento", "Trdepto" as "Departamento", "Trpageweb" as "Paginaweb", "Trloc" as "Localidad", "Trmsn" as "Messenger", "Trcp" as "Codigopostal", "Trprv" as "Provincia", "Trpais" as "Pais" from ZooLogic.TRA where  TRA.TRCOD != '' order by TRCOD
			endtext
			use in select('c_TRANSPORTISTA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_TRANSPORTISTA', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Dominio" as "Dominio", "Tipovehi" as "Tipovehiculo" from ZooLogic.VehiculoDet where Codigo = <<"'" + this.FormatearTextoSql( c_TRANSPORTISTA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_VehiculoDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_VehiculoDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_VehiculoDetalle
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
				select top 1 "Cd1" as "Fechaultimamodificacion", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Trcalle" as "Calle", "Umodifw" as "Usuariomodificacionfw", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Horaexpo" as "Horaexpo", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Trtlf" as "Telefono", "Bdmodifw" as "Basededatosmodificacionfw", "Ualtafw" as "Usuarioaltafw", "Triva" as "Situacionfiscal", "Timestamp" as "Timestamp", "Timagen" as "Imagen", "Trcod" as "Codigo", "Trobs" as "Observacion", "Trcuit" as "Cuit", "Trnro" as "Numero", "Trmovil" as "Movil", "Trnom" as "Nombre", "Trtipodoc" as "Tipodocumento", "Trpiso" as "Piso", "Trfax" as "Fax", "Tremail" as "Email", "Trnrodoc" as "Nrodocumento", "Trdepto" as "Departamento", "Trpageweb" as "Paginaweb", "Trloc" as "Localidad", "Trmsn" as "Messenger", "Trcp" as "Codigopostal", "Trprv" as "Provincia", "Trpais" as "Pais" from ZooLogic.TRA where  funciones.padr( TRCOD, 15, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  TRA.TRCOD != '' order by TRCOD
			endtext
			use in select('c_TRANSPORTISTA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_TRANSPORTISTA', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Dominio" as "Dominio", "Tipovehi" as "Tipovehiculo" from ZooLogic.VehiculoDet where Codigo = <<"'" + this.FormatearTextoSql( c_TRANSPORTISTA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_VehiculoDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_VehiculoDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_VehiculoDetalle
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
				select top 1 "Cd1" as "Fechaultimamodificacion", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Trcalle" as "Calle", "Umodifw" as "Usuariomodificacionfw", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Horaexpo" as "Horaexpo", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Trtlf" as "Telefono", "Bdmodifw" as "Basededatosmodificacionfw", "Ualtafw" as "Usuarioaltafw", "Triva" as "Situacionfiscal", "Timestamp" as "Timestamp", "Timagen" as "Imagen", "Trcod" as "Codigo", "Trobs" as "Observacion", "Trcuit" as "Cuit", "Trnro" as "Numero", "Trmovil" as "Movil", "Trnom" as "Nombre", "Trtipodoc" as "Tipodocumento", "Trpiso" as "Piso", "Trfax" as "Fax", "Tremail" as "Email", "Trnrodoc" as "Nrodocumento", "Trdepto" as "Departamento", "Trpageweb" as "Paginaweb", "Trloc" as "Localidad", "Trmsn" as "Messenger", "Trcp" as "Codigopostal", "Trprv" as "Provincia", "Trpais" as "Pais" from ZooLogic.TRA where  funciones.padr( TRCOD, 15, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  TRA.TRCOD != '' order by TRCOD desc
			endtext
			use in select('c_TRANSPORTISTA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_TRANSPORTISTA', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Dominio" as "Dominio", "Tipovehi" as "Tipovehiculo" from ZooLogic.VehiculoDet where Codigo = <<"'" + this.FormatearTextoSql( c_TRANSPORTISTA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_VehiculoDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_VehiculoDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_VehiculoDetalle
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
				select top 1 "Cd1" as "Fechaultimamodificacion", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Trcalle" as "Calle", "Umodifw" as "Usuariomodificacionfw", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Horaexpo" as "Horaexpo", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Trtlf" as "Telefono", "Bdmodifw" as "Basededatosmodificacionfw", "Ualtafw" as "Usuarioaltafw", "Triva" as "Situacionfiscal", "Timestamp" as "Timestamp", "Timagen" as "Imagen", "Trcod" as "Codigo", "Trobs" as "Observacion", "Trcuit" as "Cuit", "Trnro" as "Numero", "Trmovil" as "Movil", "Trnom" as "Nombre", "Trtipodoc" as "Tipodocumento", "Trpiso" as "Piso", "Trfax" as "Fax", "Tremail" as "Email", "Trnrodoc" as "Nrodocumento", "Trdepto" as "Departamento", "Trpageweb" as "Paginaweb", "Trloc" as "Localidad", "Trmsn" as "Messenger", "Trcp" as "Codigopostal", "Trprv" as "Provincia", "Trpais" as "Pais" from ZooLogic.TRA where  TRA.TRCOD != '' order by TRCOD desc
			endtext
			use in select('c_TRANSPORTISTA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_TRANSPORTISTA', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Dominio" as "Dominio", "Tipovehi" as "Tipovehiculo" from ZooLogic.VehiculoDet where Codigo = <<"'" + this.FormatearTextoSql( c_TRANSPORTISTA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_VehiculoDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_VehiculoDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_VehiculoDetalle
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
			lcXml = this.oConexion.EjecutarSql( "select Cd1,Faltafw,Fecexpo,Fecimpo,Fmodifw,Fectrans,Trcalle,Umodifw,Haltafw,Horaimpo,Saltafw,Smodif" + ;
"w,Hmodifw,Horaexpo,Bdaltafw,Esttrans,Vmodifw,Zadsfw,Valtafw,Trtlf,Bdmodifw,Ualtafw,Triva,Timestamp,T" + ;
"imagen,Trcod,Trobs,Trcuit,Trnro,Trmovil,Trnom,Trtipodoc,Trpiso,Trfax,Tremail,Trnrodoc,Trdepto,Trpage" + ;
"web,Trloc,Trmsn,Trcp,Trprv,Trpais" + ;
" from ZooLogic.TRA where  TRA.TRCOD != '' and " + lcFiltro )
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
			local  lxTraCd1, lxTraFaltafw, lxTraFecexpo, lxTraFecimpo, lxTraFmodifw, lxTraFectrans, lxTraTrcalle, lxTraUmodifw, lxTraHaltafw, lxTraHoraimpo, lxTraSaltafw, lxTraSmodifw, lxTraHmodifw, lxTraHoraexpo, lxTraBdaltafw, lxTraEsttrans, lxTraVmodifw, lxTraZadsfw, lxTraValtafw, lxTraTrtlf, lxTraBdmodifw, lxTraUaltafw, lxTraTriva, lxTraTimestamp, lxTraTimagen, lxTraTrcod, lxTraTrobs, lxTraTrcuit, lxTraTrnro, lxTraTrmovil, lxTraTrnom, lxTraTrtipodoc, lxTraTrpiso, lxTraTrfax, lxTraTremail, lxTraTrnrodoc, lxTraTrdepto, lxTraTrpageweb, lxTraTrloc, lxTraTrmsn, lxTraTrcp, lxTraTrprv, lxTraTrpais
				lxTraCd1 = ctod( '  /  /    ' )			lxTraFaltafw = ctod( '  /  /    ' )			lxTraFecexpo = ctod( '  /  /    ' )			lxTraFecimpo = ctod( '  /  /    ' )			lxTraFmodifw = ctod( '  /  /    ' )			lxTraFectrans = ctod( '  /  /    ' )			lxTraTrcalle = []			lxTraUmodifw = []			lxTraHaltafw = []			lxTraHoraimpo = []			lxTraSaltafw = []			lxTraSmodifw = []			lxTraHmodifw = []			lxTraHoraexpo = []			lxTraBdaltafw = []			lxTraEsttrans = []			lxTraVmodifw = []			lxTraZadsfw = []			lxTraValtafw = []			lxTraTrtlf = []			lxTraBdmodifw = []			lxTraUaltafw = []			lxTraTriva = 0			lxTraTimestamp = goLibrerias.ObtenerTimestamp()			lxTraTimagen = []			lxTraTrcod = []			lxTraTrobs = []			lxTraTrcuit = []			lxTraTrnro = 0			lxTraTrmovil = []			lxTraTrnom = []			lxTraTrtipodoc = []			lxTraTrpiso = []			lxTraTrfax = []			lxTraTremail = []			lxTraTrnrodoc = []			lxTraTrdepto = []			lxTraTrpageweb = []			lxTraTrloc = []			lxTraTrmsn = []			lxTraTrcp = []			lxTraTrprv = []			lxTraTrpais = []
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.VehiculoDet where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( [delete from ZooLogic.TRA where "TRCOD" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'TRA' + '_' + tcCampo
			lcMemoAscii = ''

			lnIndice = alen(.aSqlMemos)
			lnIndice = iif(lnIndice = 1, 1, lnIndice + 1 )
			dimension .aSqlMemos(lnIndice)

			.aSqlMemos(lnIndice) = 'delete from ' + lcTabla + ' where TRCOD = ' + txValorClavePrimaria
			.GenerarSentenciasInsertTablaMemo( lcValor, lcTabla, txValorClavePrimaria )
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerSentenciaInsertMemo( tcTabla as String, txValorClavePrimaria as String, tcOrden as String, tcTexto as String ) as String
		return "Insert  into " + tcTabla + "(TRCOD, Orden, texto ) values ( " + txValorClavePrimaria + "," + tcOrden + ",'"+ tcTexto + "')"
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosEntidad( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  TRA.TRCOD != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Cd1" as "Fechaultimamodificacion", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Trcalle" as "Calle", "Umodifw" as "Usuariomodificacionfw", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Horaexpo" as "Horaexpo", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Trtlf" as "Telefono", "Bdmodifw" as "Basededatosmodificacionfw", "Ualtafw" as "Usuarioaltafw", "Triva" as "Situacionfiscal", "Timestamp" as "Timestamp", "Timagen" as "Imagen", "Trcod" as "Codigo", "Trobs" as "Observacion", "Trcuit" as "Cuit", "Trnro" as "Numero", "Trmovil" as "Movil", "Trnom" as "Nombre", "Trtipodoc" as "Tipodocumento", "Trpiso" as "Piso", "Trfax" as "Fax", "Tremail" as "Email", "Trnrodoc" as "Nrodocumento", "Trdepto" as "Departamento", "Trpageweb" as "Paginaweb", "Trloc" as "Localidad", "Trmsn" as "Messenger", "Trcp" as "Codigopostal", "Trprv" as "Provincia", "Trpais" as "Pais"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'TRA', '', tnTope )
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
	Function ObtenerDatosDetalleVehiculoDetalle( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  VEHICULODET.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Nroitem" as "Nroitem", "Codigo" as "Codigo", "Dominio" as "Dominio", "Tipovehi" as "Tipovehiculo"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleVehiculoDetalle( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'VehiculoDet', 'VehiculoDetalle', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleVehiculoDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleVehiculoDetalle( lcAtributo )
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
				Case lcAtributo == 'FECHAULTIMAMODIFICACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CD1 AS FECHAULTIMAMODIFICACION'
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'FECHAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECEXPO AS FECHAEXPO'
				Case lcAtributo == 'FECHAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECIMPO AS FECHAIMPO'
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'FECHATRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRANS AS FECHATRANSFERENCIA'
				Case lcAtributo == 'CALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TRCALLE AS CALLE'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'TELEFONO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TRTLF AS TELEFONO'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'SITUACIONFISCAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TRIVA AS SITUACIONFISCAL'
				Case lcAtributo == 'TIMESTAMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIMESTAMP AS TIMESTAMP'
				Case lcAtributo == 'IMAGEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIMAGEN AS IMAGEN'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TRCOD AS CODIGO'
				Case lcAtributo == 'OBSERVACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TROBS AS OBSERVACION'
				Case lcAtributo == 'CUIT'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TRCUIT AS CUIT'
				Case lcAtributo == 'NUMERO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TRNRO AS NUMERO'
				Case lcAtributo == 'MOVIL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TRMOVIL AS MOVIL'
				Case lcAtributo == 'NOMBRE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TRNOM AS NOMBRE'
				Case lcAtributo == 'TIPODOCUMENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TRTIPODOC AS TIPODOCUMENTO'
				Case lcAtributo == 'PISO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TRPISO AS PISO'
				Case lcAtributo == 'FAX'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TRFAX AS FAX'
				Case lcAtributo == 'EMAIL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TREMAIL AS EMAIL'
				Case lcAtributo == 'NRODOCUMENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TRNRODOC AS NRODOCUMENTO'
				Case lcAtributo == 'DEPARTAMENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TRDEPTO AS DEPARTAMENTO'
				Case lcAtributo == 'PAGINAWEB'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TRPAGEWEB AS PAGINAWEB'
				Case lcAtributo == 'LOCALIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TRLOC AS LOCALIDAD'
				Case lcAtributo == 'MESSENGER'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TRMSN AS MESSENGER'
				Case lcAtributo == 'CODIGOPOSTAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TRCP AS CODIGOPOSTAL'
				Case lcAtributo == 'PROVINCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TRPRV AS PROVINCIA'
				Case lcAtributo == 'PAIS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TRPAIS AS PAIS'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleVehiculoDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'DOMINIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DOMINIO AS DOMINIO'
				Case lcAtributo == 'TIPOVEHICULO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPOVEHI AS TIPOVEHICULO'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoEntidad( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'FECHAULTIMAMODIFICACION'
				lcCampo = 'CD1'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEXPO'
				lcCampo = 'FECEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAIMPO'
				lcCampo = 'FECIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'CALLE'
				lcCampo = 'TRCALLE'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'TELEFONO'
				lcCampo = 'TRTLF'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SITUACIONFISCAL'
				lcCampo = 'TRIVA'
			Case upper( alltrim( tcAtributo ) ) == 'TIMESTAMP'
				lcCampo = 'TIMESTAMP'
			Case upper( alltrim( tcAtributo ) ) == 'IMAGEN'
				lcCampo = 'TIMAGEN'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'TRCOD'
			Case upper( alltrim( tcAtributo ) ) == 'OBSERVACION'
				lcCampo = 'TROBS'
			Case upper( alltrim( tcAtributo ) ) == 'CUIT'
				lcCampo = 'TRCUIT'
			Case upper( alltrim( tcAtributo ) ) == 'NUMERO'
				lcCampo = 'TRNRO'
			Case upper( alltrim( tcAtributo ) ) == 'MOVIL'
				lcCampo = 'TRMOVIL'
			Case upper( alltrim( tcAtributo ) ) == 'NOMBRE'
				lcCampo = 'TRNOM'
			Case upper( alltrim( tcAtributo ) ) == 'TIPODOCUMENTO'
				lcCampo = 'TRTIPODOC'
			Case upper( alltrim( tcAtributo ) ) == 'PISO'
				lcCampo = 'TRPISO'
			Case upper( alltrim( tcAtributo ) ) == 'FAX'
				lcCampo = 'TRFAX'
			Case upper( alltrim( tcAtributo ) ) == 'EMAIL'
				lcCampo = 'TREMAIL'
			Case upper( alltrim( tcAtributo ) ) == 'NRODOCUMENTO'
				lcCampo = 'TRNRODOC'
			Case upper( alltrim( tcAtributo ) ) == 'DEPARTAMENTO'
				lcCampo = 'TRDEPTO'
			Case upper( alltrim( tcAtributo ) ) == 'PAGINAWEB'
				lcCampo = 'TRPAGEWEB'
			Case upper( alltrim( tcAtributo ) ) == 'LOCALIDAD'
				lcCampo = 'TRLOC'
			Case upper( alltrim( tcAtributo ) ) == 'MESSENGER'
				lcCampo = 'TRMSN'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGOPOSTAL'
				lcCampo = 'TRCP'
			Case upper( alltrim( tcAtributo ) ) == 'PROVINCIA'
				lcCampo = 'TRPRV'
			Case upper( alltrim( tcAtributo ) ) == 'PAIS'
				lcCampo = 'TRPAIS'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleVehiculoDetalle( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'DOMINIO'
				lcCampo = 'DOMINIO'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOVEHICULO'
				lcCampo = 'TIPOVEHI'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerTablaDetalle( tcDetalle as string ) as String
		local lcRetorno as string
		lcRetorno = ''
		if upper( alltrim( tcDetalle ) ) == 'VEHICULODETALLE'
			lcRetorno = 'VEHICULODET'
		EndIf
		return lcRetorno
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasInsert() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcSentencia as string, loItem as object
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxTraCd1, lxTraFaltafw, lxTraFecexpo, lxTraFecimpo, lxTraFmodifw, lxTraFectrans, lxTraTrcalle, lxTraUmodifw, lxTraHaltafw, lxTraHoraimpo, lxTraSaltafw, lxTraSmodifw, lxTraHmodifw, lxTraHoraexpo, lxTraBdaltafw, lxTraEsttrans, lxTraVmodifw, lxTraZadsfw, lxTraValtafw, lxTraTrtlf, lxTraBdmodifw, lxTraUaltafw, lxTraTriva, lxTraTimestamp, lxTraTimagen, lxTraTrcod, lxTraTrobs, lxTraTrcuit, lxTraTrnro, lxTraTrmovil, lxTraTrnom, lxTraTrtipodoc, lxTraTrpiso, lxTraTrfax, lxTraTremail, lxTraTrnrodoc, lxTraTrdepto, lxTraTrpageweb, lxTraTrloc, lxTraTrmsn, lxTraTrcp, lxTraTrprv, lxTraTrpais
				lxTraCd1 =  .Fechaultimamodificacion			lxTraFaltafw =  .Fechaaltafw			lxTraFecexpo =  .Fechaexpo			lxTraFecimpo =  .Fechaimpo			lxTraFmodifw =  .Fechamodificacionfw			lxTraFectrans =  .Fechatransferencia			lxTraTrcalle =  .Calle			lxTraUmodifw =  .Usuariomodificacionfw			lxTraHaltafw =  .Horaaltafw			lxTraHoraimpo =  .Horaimpo			lxTraSaltafw =  .Seriealtafw			lxTraSmodifw =  .Seriemodificacionfw			lxTraHmodifw =  .Horamodificacionfw			lxTraHoraexpo =  .Horaexpo			lxTraBdaltafw =  .Basededatosaltafw			lxTraEsttrans =  .Estadotransferencia			lxTraVmodifw =  .Versionmodificacionfw			lxTraZadsfw =  .Zadsfw			lxTraValtafw =  .Versionaltafw			lxTraTrtlf =  .Telefono			lxTraBdmodifw =  .Basededatosmodificacionfw			lxTraUaltafw =  .Usuarioaltafw			lxTraTriva =  .Situacionfiscal_PK 			lxTraTimestamp = goLibrerias.ObtenerTimestamp()			lxTraTimagen =  .Imagen			lxTraTrcod =  .Codigo			lxTraTrobs =  .Observacion			lxTraTrcuit =  .Cuit			lxTraTrnro =  .Numero			lxTraTrmovil =  .Movil			lxTraTrnom =  .Nombre			lxTraTrtipodoc =  .Tipodocumento			lxTraTrpiso =  .Piso			lxTraTrfax =  .Fax			lxTraTremail =  .Email			lxTraTrnrodoc =  .Nrodocumento			lxTraTrdepto =  .Departamento			lxTraTrpageweb =  .Paginaweb			lxTraTrloc =  .Localidad			lxTraTrmsn =  .Messenger			lxTraTrcp =  .Codigopostal			lxTraTrprv =  upper( .Provincia_PK ) 			lxTraTrpais =  upper( .Pais_PK ) 
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.TRA ( "Cd1","Faltafw","Fecexpo","Fecimpo","Fmodifw","Fectrans","Trcalle","Umodifw","Haltafw","Horaimpo","Saltafw","Smodifw","Hmodifw","Horaexpo","Bdaltafw","Esttrans","Vmodifw","Zadsfw","Valtafw","Trtlf","Bdmodifw","Ualtafw","Triva","Timestamp","Timagen","Trcod","Trobs","Trcuit","Trnro","Trmovil","Trnom","Trtipodoc","Trpiso","Trfax","Tremail","Trnrodoc","Trdepto","Trpageweb","Trloc","Trmsn","Trcp","Trprv","Trpais" ) values ( <<"'" + this.ConvertirDateSql( lxTraCd1 ) + "'" >>, <<"'" + this.ConvertirDateSql( lxTraFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxTraFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxTraFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxTraFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxTraFectrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTraTrcalle ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTraUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTraHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTraHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTraSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTraSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTraHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTraHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTraBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTraEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTraVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTraZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTraValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTraTrtlf ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTraBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTraUaltafw ) + "'" >>, <<lxTraTriva >>, <<lxTraTimestamp >>, <<"'" + this.FormatearTextoSql( lxTraTimagen ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTraTrcod ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTraTrobs ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTraTrcuit ) + "'" >>, <<lxTraTrnro >>, <<"'" + this.FormatearTextoSql( lxTraTrmovil ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTraTrnom ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTraTrtipodoc ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTraTrpiso ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTraTrfax ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTraTremail ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTraTrnrodoc ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTraTrdepto ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTraTrpageweb ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTraTrloc ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTraTrmsn ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTraTrcp ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTraTrprv ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTraTrpais ) + "'" >> )
		endtext
		loColeccion.cTabla = 'TRA' 
		loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		With this
			local lcValorClavePrimariaString as String
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.VehiculoDetalle
				if this.oEntidad.VehiculoDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxDominio = loItem.Dominio
					lxTipovehiculo = loItem.Tipovehiculo
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.VehiculoDet("NROITEM","Codigo","Dominio","TipoVehi" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxDominio ) + "'">>, <<lxTipovehiculo>> ) 
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
			local  lxTraCd1, lxTraFaltafw, lxTraFecexpo, lxTraFecimpo, lxTraFmodifw, lxTraFectrans, lxTraTrcalle, lxTraUmodifw, lxTraHaltafw, lxTraHoraimpo, lxTraSaltafw, lxTraSmodifw, lxTraHmodifw, lxTraHoraexpo, lxTraBdaltafw, lxTraEsttrans, lxTraVmodifw, lxTraZadsfw, lxTraValtafw, lxTraTrtlf, lxTraBdmodifw, lxTraUaltafw, lxTraTriva, lxTraTimestamp, lxTraTimagen, lxTraTrcod, lxTraTrobs, lxTraTrcuit, lxTraTrnro, lxTraTrmovil, lxTraTrnom, lxTraTrtipodoc, lxTraTrpiso, lxTraTrfax, lxTraTremail, lxTraTrnrodoc, lxTraTrdepto, lxTraTrpageweb, lxTraTrloc, lxTraTrmsn, lxTraTrcp, lxTraTrprv, lxTraTrpais
				lxTraCd1 =  .Fechaultimamodificacion			lxTraFaltafw =  .Fechaaltafw			lxTraFecexpo =  .Fechaexpo			lxTraFecimpo =  .Fechaimpo			lxTraFmodifw =  .Fechamodificacionfw			lxTraFectrans =  .Fechatransferencia			lxTraTrcalle =  .Calle			lxTraUmodifw =  .Usuariomodificacionfw			lxTraHaltafw =  .Horaaltafw			lxTraHoraimpo =  .Horaimpo			lxTraSaltafw =  .Seriealtafw			lxTraSmodifw =  .Seriemodificacionfw			lxTraHmodifw =  .Horamodificacionfw			lxTraHoraexpo =  .Horaexpo			lxTraBdaltafw =  .Basededatosaltafw			lxTraEsttrans =  .Estadotransferencia			lxTraVmodifw =  .Versionmodificacionfw			lxTraZadsfw =  .Zadsfw			lxTraValtafw =  .Versionaltafw			lxTraTrtlf =  .Telefono			lxTraBdmodifw =  .Basededatosmodificacionfw			lxTraUaltafw =  .Usuarioaltafw			lxTraTriva =  .Situacionfiscal_PK 			lxTraTimestamp = goLibrerias.ObtenerTimestamp()			lxTraTimagen =  .Imagen			lxTraTrcod =  .Codigo			lxTraTrobs =  .Observacion			lxTraTrcuit =  .Cuit			lxTraTrnro =  .Numero			lxTraTrmovil =  .Movil			lxTraTrnom =  .Nombre			lxTraTrtipodoc =  .Tipodocumento			lxTraTrpiso =  .Piso			lxTraTrfax =  .Fax			lxTraTremail =  .Email			lxTraTrnrodoc =  .Nrodocumento			lxTraTrdepto =  .Departamento			lxTraTrpageweb =  .Paginaweb			lxTraTrloc =  .Localidad			lxTraTrmsn =  .Messenger			lxTraTrcp =  .Codigopostal			lxTraTrprv =  upper( .Provincia_PK ) 			lxTraTrpais =  upper( .Pais_PK ) 
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Trcod" = ] + lcValorClavePrimariaString  + [ and  TRA.TRCOD != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.TRA set "Cd1" = <<"'" + this.ConvertirDateSql( lxTraCd1 ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxTraFaltafw ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxTraFecexpo ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxTraFecimpo ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxTraFmodifw ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxTraFectrans ) + "'">>, "Trcalle" = <<"'" + this.FormatearTextoSql( lxTraTrcalle ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxTraUmodifw ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxTraHaltafw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxTraHoraimpo ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxTraSaltafw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxTraSmodifw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxTraHmodifw ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxTraHoraexpo ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxTraBdaltafw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxTraEsttrans ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxTraVmodifw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxTraZadsfw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxTraValtafw ) + "'">>, "Trtlf" = <<"'" + this.FormatearTextoSql( lxTraTrtlf ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxTraBdmodifw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxTraUaltafw ) + "'">>, "Triva" = <<lxTraTriva>>, "Timestamp" = <<lxTraTimestamp>>, "Timagen" = <<"'" + this.FormatearTextoSql( lxTraTimagen ) + "'">>, "Trcod" = <<"'" + this.FormatearTextoSql( lxTraTrcod ) + "'">>, "Trobs" = <<"'" + this.FormatearTextoSql( lxTraTrobs ) + "'">>, "Trcuit" = <<"'" + this.FormatearTextoSql( lxTraTrcuit ) + "'">>, "Trnro" = <<lxTraTrnro>>, "Trmovil" = <<"'" + this.FormatearTextoSql( lxTraTrmovil ) + "'">>, "Trnom" = <<"'" + this.FormatearTextoSql( lxTraTrnom ) + "'">>, "Trtipodoc" = <<"'" + this.FormatearTextoSql( lxTraTrtipodoc ) + "'">>, "Trpiso" = <<"'" + this.FormatearTextoSql( lxTraTrpiso ) + "'">>, "Trfax" = <<"'" + this.FormatearTextoSql( lxTraTrfax ) + "'">>, "Tremail" = <<"'" + this.FormatearTextoSql( lxTraTremail ) + "'">>, "Trnrodoc" = <<"'" + this.FormatearTextoSql( lxTraTrnrodoc ) + "'">>, "Trdepto" = <<"'" + this.FormatearTextoSql( lxTraTrdepto ) + "'">>, "Trpageweb" = <<"'" + this.FormatearTextoSql( lxTraTrpageweb ) + "'">>, "Trloc" = <<"'" + this.FormatearTextoSql( lxTraTrloc ) + "'">>, "Trmsn" = <<"'" + this.FormatearTextoSql( lxTraTrmsn ) + "'">>, "Trcp" = <<"'" + this.FormatearTextoSql( lxTraTrcp ) + "'">>, "Trprv" = <<"'" + this.FormatearTextoSql( lxTraTrprv ) + "'">>, "Trpais" = <<"'" + this.FormatearTextoSql( lxTraTrpais ) + "'">> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'TRA' 
		loColeccion.agregar( strtran(  lcSentencia, chr( 9 ), '' ) )
			loColeccion.Agregar([delete from ZooLogic.VehiculoDet where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.VehiculoDetalle
				if this.oEntidad.VehiculoDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxDominio = loItem.Dominio
					lxTipovehiculo = loItem.Tipovehiculo
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.VehiculoDet("NROITEM","Codigo","Dominio","TipoVehi" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxDominio ) + "'">>, <<lxTipovehiculo>> ) 
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

			lcFiltro = ["Trcod" = ] + lcValorClavePrimariaString  + [ and  TRA.TRCOD != '']
		loColeccion.Agregar( 'delete from ZooLogic.TRA where ' + lcFiltro )
			loColeccion.Agregar([delete from ZooLogic.VehiculoDet where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.cTabla = 'TRA' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.TRA where  TRA.TRCOD != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.TRA where TRCOD = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  TRA.TRCOD != ''" )
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
		lcCursor = This.oEntidad.cPrefijoRecibir + 'TRANSPORTISTA'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.TRA Where TRCOD = ] + "'" + this.FormatearTextoSql( &lcCursor..TRCOD ) + "'", 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					this.oConexion.EjecutarSql( [UPDATE ZooLogic.TRA set  CD1 = ] + "'" + this.ConvertirDateSql( &lcCursor..CD1 ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, TRCalle = ] + "'" + this.FormatearTextoSql( &lcCursor..TRCalle ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, TRTLF = ] + "'" + this.FormatearTextoSql( &lcCursor..TRTLF ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, TRIVA = ] + transform( &lcCursor..TRIVA )+ [, TIMESTAMP = ] + transform( &lcCursor..TIMESTAMP )+ [, TIMAGEN = ] + "'" + this.FormatearTextoSql( &lcCursor..TIMAGEN ) + "'"+ [, TRCOD = ] + "'" + this.FormatearTextoSql( &lcCursor..TRCOD ) + "'"+ [, TROBS = ] + "'" + this.FormatearTextoSql( &lcCursor..TROBS ) + "'"+ [, TRCUIT = ] + "'" + this.FormatearTextoSql( &lcCursor..TRCUIT ) + "'"+ [, TRNro = ] + transform( &lcCursor..TRNro )+ [, TRMovil = ] + "'" + this.FormatearTextoSql( &lcCursor..TRMovil ) + "'"+ [, TRNOM = ] + "'" + this.FormatearTextoSql( &lcCursor..TRNOM ) + "'"+ [, TRTIPODOC = ] + "'" + this.FormatearTextoSql( &lcCursor..TRTIPODOC ) + "'"+ [, TRPiso = ] + "'" + this.FormatearTextoSql( &lcCursor..TRPiso ) + "'"+ [, TRFAX = ] + "'" + this.FormatearTextoSql( &lcCursor..TRFAX ) + "'"+ [, TREMAIL = ] + "'" + this.FormatearTextoSql( &lcCursor..TREMAIL ) + "'"+ [, TRNRODOC = ] + "'" + this.FormatearTextoSql( &lcCursor..TRNRODOC ) + "'"+ [, TRDEPTO = ] + "'" + this.FormatearTextoSql( &lcCursor..TRDEPTO ) + "'"+ [, TRPAGEWEB = ] + "'" + this.FormatearTextoSql( &lcCursor..TRPAGEWEB ) + "'"+ [, TRLOC = ] + "'" + this.FormatearTextoSql( &lcCursor..TRLOC ) + "'"+ [, TRMSN = ] + "'" + this.FormatearTextoSql( &lcCursor..TRMSN ) + "'"+ [, TRCP = ] + "'" + this.FormatearTextoSql( &lcCursor..TRCP ) + "'"+ [, TRPRV = ] + "'" + this.FormatearTextoSql( &lcCursor..TRPRV ) + "'"+ [, TRPAIS = ] + "'" + this.FormatearTextoSql( &lcCursor..TRPAIS ) + "'" + [ Where TRCOD = ] + "'" + this.FormatearTextoSql( &lcCursor..TRCOD ) + "'" )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
				endIf
			else
				Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
				Text to lcCampos noShow
					 CD1, FALTAFW, FECEXPO, FECIMPO, FMODIFW, FECTRANS, TRCalle, UMODIFW, HALTAFW, HORAIMPO, SALTAFW, SMODIFW, HMODIFW, HORAEXPO, BDALTAFW, ESTTRANS, VMODIFW, ZADSFW, VALTAFW, TRTLF, BDMODIFW, UALTAFW, TRIVA, TIMESTAMP, TIMAGEN, TRCOD, TROBS, TRCUIT, TRNro, TRMovil, TRNOM, TRTIPODOC, TRPiso, TRFAX, TREMAIL, TRNRODOC, TRDEPTO, TRPAGEWEB, TRLOC, TRMSN, TRCP, TRPRV, TRPAIS
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..CD1 ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..TRCalle ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..TRTLF ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + transform( &lcCursor..TRIVA ) + ',' + transform( &lcCursor..TIMESTAMP ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..TIMAGEN ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..TRCOD ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..TROBS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..TRCUIT ) + "'" + ',' + transform( &lcCursor..TRNro )
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..TRMovil ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..TRNOM ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..TRTIPODOC ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..TRPiso ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..TRFAX ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..TREMAIL ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..TRNRODOC ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..TRDEPTO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..TRPAGEWEB ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..TRLOC ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..TRMSN ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..TRCP ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..TRPRV ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..TRPAIS ) + "'"
lcValoresCampos = substr(lcValoresCampos,2) 

				this.oConexion.EjecutarSql( [Insert into ZooLogic.TRA ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
				this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'TRANSPORTISTA'
		if This.ActualizaEnRecepcion()
		Local lcIn as String, lcCantRegistros as Integer
		Select( lcCursor )
		Count to lcCantRegistros
		If lcCantRegistros > 0
			lcIn = This.ObtenerInSqlServer( lcCursor, 'TRCOD','C')
			lnFragmento = goRegistry.nucleo.cantidadDeElementosEnSentenciaInSQL
			loIn = this.ObtenerColeccionInSqlServer( lcCursor,'','TRCOD')
			llEjecutaEnTransaccion = loIn.count > 0
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'BEGIN TRANSACTION' )
			endif
			for i = 1 to loIn.count step lnFragmento
				lcIn = this.ObtenerFragmentoColeccionInSqlServer( loIn, i, lnFragmento )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.VehiculoDet Where Codigo] + lcIn  )
			endfor
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'COMMIT TRANSACTION' )
			endif
		EndIf
	endif
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMVEHICULO'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where Codigo in ( select TRCOD from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"NROITEM","Codigo","Dominio","TipoVehi"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.VehiculoDet ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Codigo     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Dominio    ) + "'" + ',' + transform( cDetallesExistentes.TipoVehi   ) + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	Use in select( 'cExistentes' )
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearCursorMemo( tcCursorACrear as String, tcTablaConMemo as String ) as Void
		create cursor &tcCursorACrear ( TRCOD C (15) , Orden N(16), texto C(80))
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirComponentes() As Void
		
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function ObtenerIdentificadorParaLoguear( tcCursor as String ) As String
		local lcRetorno as String, lnCC as String , loCC as Object, lni as Integer, lcSecuencia as String
		lcRetorno = this.oEntidad.cDescripcion 
		lcRetorno = lcRetorno + ' - Código: ' + transform( &tcCursor..TRCOD      )
		Return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EsAliasDeProceso( tcAlias As String, tcPrefijo as string ) As Boolean
		local llRetorno as Boolean, lcAlias as String, lcPrefijo As String
		llRetorno = .F.
		lcAlias = upper( alltrim( tcAlias ) )
		lcPrefijo = upper( alltrim( tcPrefijo ) )
		Do Case
			Case  lcAlias == lcPrefijo + 'TRANSPORTISTA'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'TRANSPORTISTA_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'TRANSPORTISTA_TROBS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMVEHICULO'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_TRA')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'TRANSPORTISTA'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..TRCOD
		llCondicion = isnull( lxVar )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad TRANSPORTISTA. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'TRANSPORTISTA'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		select recno() as _Rec, * from &lcCursor into cursor CurConRecno
		select max( _Rec ) as Maximo,TRCOD as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( TRCOD, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		Use in select( 'CurConRecno' )
		Use in select( 'RepMax' )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDatosInvalidos( toConexion as Object ) as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'TRANSPORTISTA'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  CD1       
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_TRA') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_TRA
Create Table ZooLogic.TablaTrabajo_TRA ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"cd1" datetime  null, 
"faltafw" datetime  null, 
"fecexpo" datetime  null, 
"fecimpo" datetime  null, 
"fmodifw" datetime  null, 
"fectrans" datetime  null, 
"trcalle" char( 70 )  null, 
"umodifw" char( 100 )  null, 
"haltafw" char( 8 )  null, 
"horaimpo" char( 8 )  null, 
"saltafw" char( 7 )  null, 
"smodifw" char( 7 )  null, 
"hmodifw" char( 8 )  null, 
"horaexpo" char( 8 )  null, 
"bdaltafw" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"vmodifw" char( 13 )  null, 
"zadsfw" varchar(max)  null, 
"valtafw" char( 13 )  null, 
"trtlf" char( 30 )  null, 
"bdmodifw" char( 8 )  null, 
"ualtafw" char( 100 )  null, 
"triva" numeric( 2, 0 )  null, 
"timestamp" numeric( 20, 0 )  null, 
"timagen" char( 180 )  null, 
"trcod" char( 15 )  null, 
"trobs" varchar(max)  null, 
"trcuit" char( 15 )  null, 
"trnro" numeric( 5, 0 )  null, 
"trmovil" char( 30 )  null, 
"trnom" char( 30 )  null, 
"trtipodoc" char( 2 )  null, 
"trpiso" char( 3 )  null, 
"trfax" char( 20 )  null, 
"tremail" char( 250 )  null, 
"trnrodoc" char( 10 )  null, 
"trdepto" char( 3 )  null, 
"trpageweb" char( 60 )  null, 
"trloc" char( 70 )  null, 
"trmsn" char( 250 )  null, 
"trcp" char( 8 )  null, 
"trprv" char( 2 )  null, 
"trpais" char( 3 )  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_TRA' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_TRA' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'TRANSPORTISTA'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		with loManejador
			if this.oEntidad.VerificarContexto( 'CB' )
			else
				.AgregarMapeo('Nrolinea','Nrolinea')
			endif
			.AgregarMapeo('cd1','cd1')
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('trcalle','trcalle')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('trtlf','trtlf')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('triva','triva')
			.AgregarMapeo('timestamp','timestamp')
			.AgregarMapeo('timagen','timagen')
			.AgregarMapeo('trcod','trcod')
			.AgregarMapeo('trobs','trobs')
			.AgregarMapeo('trcuit','trcuit')
			.AgregarMapeo('trnro','trnro')
			.AgregarMapeo('trmovil','trmovil')
			.AgregarMapeo('trnom','trnom')
			.AgregarMapeo('trtipodoc','trtipodoc')
			.AgregarMapeo('trpiso','trpiso')
			.AgregarMapeo('trfax','trfax')
			.AgregarMapeo('tremail','tremail')
			.AgregarMapeo('trnrodoc','trnrodoc')
			.AgregarMapeo('trdepto','trdepto')
			.AgregarMapeo('trpageweb','trpageweb')
			.AgregarMapeo('trloc','trloc')
			.AgregarMapeo('trmsn','trmsn')
			.AgregarMapeo('trcp','trcp')
			.AgregarMapeo('trprv','trprv')
			.AgregarMapeo('trpais','trpais')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_TRA'
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
				Update t Set t.CD1 = isnull( d.CD1, t.CD1 ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.TRCALLE = isnull( d.TRCALLE, t.TRCALLE ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.TRTLF = isnull( d.TRTLF, t.TRTLF ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.TRIVA = isnull( d.TRIVA, t.TRIVA ),t.TIMESTAMP = isnull( d.TIMESTAMP, t.TIMESTAMP ),t.TIMAGEN = isnull( d.TIMAGEN, t.TIMAGEN ),t.TRCOD = isnull( d.TRCOD, t.TRCOD ),t.TROBS = isnull( d.TROBS, t.TROBS ),t.TRCUIT = isnull( d.TRCUIT, t.TRCUIT ),t.TRNRO = isnull( d.TRNRO, t.TRNRO ),t.TRMOVIL = isnull( d.TRMOVIL, t.TRMOVIL ),t.TRNOM = isnull( d.TRNOM, t.TRNOM ),t.TRTIPODOC = isnull( d.TRTIPODOC, t.TRTIPODOC ),t.TRPISO = isnull( d.TRPISO, t.TRPISO ),t.TRFAX = isnull( d.TRFAX, t.TRFAX ),t.TREMAIL = isnull( d.TREMAIL, t.TREMAIL ),t.TRNRODOC = isnull( d.TRNRODOC, t.TRNRODOC ),t.TRDEPTO = isnull( d.TRDEPTO, t.TRDEPTO ),t.TRPAGEWEB = isnull( d.TRPAGEWEB, t.TRPAGEWEB ),t.TRLOC = isnull( d.TRLOC, t.TRLOC ),t.TRMSN = isnull( d.TRMSN, t.TRMSN ),t.TRCP = isnull( d.TRCP, t.TRCP ),t.TRPRV = isnull( d.TRPRV, t.TRPRV ),t.TRPAIS = isnull( d.TRPAIS, t.TRPAIS )
					from ZooLogic.TRA t inner join deleted d 
							 on t.TRCOD = d.TRCOD
				-- Fin Updates
				insert into ZooLogic.TRA(Cd1,Faltafw,Fecexpo,Fecimpo,Fmodifw,Fectrans,Trcalle,Umodifw,Haltafw,Horaimpo,Saltafw,Smodifw,Hmodifw,Horaexpo,Bdaltafw,Esttrans,Vmodifw,Zadsfw,Valtafw,Trtlf,Bdmodifw,Ualtafw,Triva,Timestamp,Timagen,Trcod,Trobs,Trcuit,Trnro,Trmovil,Trnom,Trtipodoc,Trpiso,Trfax,Tremail,Trnrodoc,Trdepto,Trpageweb,Trloc,Trmsn,Trcp,Trprv,Trpais)
					Select isnull( d.CD1,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FECEXPO,''),isnull( d.FECIMPO,''),isnull( d.FMODIFW,''),isnull( d.FECTRANS,''),isnull( d.TRCALLE,''),isnull( d.UMODIFW,''),convert( char(8), getdate(), 108 ),isnull( d.HORAIMPO,''),isnull( d.SALTAFW,''),isnull( d.SMODIFW,''),isnull( d.HMODIFW,''),isnull( d.HORAEXPO,''),isnull( d.BDALTAFW,''),isnull( d.ESTTRANS,''),isnull( d.VMODIFW,''),isnull( d.ZADSFW,''),isnull( d.VALTAFW,''),isnull( d.TRTLF,''),isnull( d.BDMODIFW,''),isnull( d.UALTAFW,''),isnull( d.TRIVA,0),isnull( d.TIMESTAMP,0),isnull( d.TIMAGEN,''),isnull( d.TRCOD,''),isnull( d.TROBS,''),isnull( d.TRCUIT,''),isnull( d.TRNRO,0),isnull( d.TRMOVIL,''),isnull( d.TRNOM,''),isnull( d.TRTIPODOC,''),isnull( d.TRPISO,''),isnull( d.TRFAX,''),isnull( d.TREMAIL,''),isnull( d.TRNRODOC,''),isnull( d.TRDEPTO,''),isnull( d.TRPAGEWEB,''),isnull( d.TRLOC,''),isnull( d.TRMSN,''),isnull( d.TRCP,''),isnull( d.TRPRV,''),isnull( d.TRPAIS,'')
						From deleted d left join ZooLogic.TRA pk 
							 on d.TRCOD = pk.TRCOD
						Where pk.TRCOD Is Null 
				-- Fin Inserts
			End
		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_VehiculoDet( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_TRA_VehiculoDet
ON ZooLogic.TablaTrabajo_TRA_VehiculoDet
AFTER DELETE
As
Begin
Update t Set 
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.CODIGO = isnull( d.CODIGO, t.CODIGO ),
t.DOMINIO = isnull( d.DOMINIO, t.DOMINIO ),
t.TIPOVEHI = isnull( d.TIPOVEHI, t.TIPOVEHI )
from ZooLogic.VehiculoDet t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.VehiculoDet
( 
"NROITEM",
"CODIGO",
"DOMINIO",
"TIPOVEHI"
 )
Select 
d.NROITEM,
d.CODIGO,
d.DOMINIO,
d.TIPOVEHI
From deleted d left join ZooLogic.VehiculoDet pk 
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_TRA') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_TRA
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_TRANSPORTISTA' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaultimamodificacion = GoLibrerias.ObtenerFechaFormateada( nvl( c_TRANSPORTISTA.Fechaultimamodificacion, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_TRANSPORTISTA.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_TRANSPORTISTA.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_TRANSPORTISTA.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_TRANSPORTISTA.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_TRANSPORTISTA.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Calle = nvl( c_TRANSPORTISTA.Calle, [] )
					.Usuariomodificacionfw = nvl( c_TRANSPORTISTA.Usuariomodificacionfw, [] )
					.Horaaltafw = nvl( c_TRANSPORTISTA.Horaaltafw, [] )
					.Horaimpo = nvl( c_TRANSPORTISTA.Horaimpo, [] )
					.Seriealtafw = nvl( c_TRANSPORTISTA.Seriealtafw, [] )
					.Seriemodificacionfw = nvl( c_TRANSPORTISTA.Seriemodificacionfw, [] )
					.Horamodificacionfw = nvl( c_TRANSPORTISTA.Horamodificacionfw, [] )
					.Horaexpo = nvl( c_TRANSPORTISTA.Horaexpo, [] )
					.Basededatosaltafw = nvl( c_TRANSPORTISTA.Basededatosaltafw, [] )
					.Estadotransferencia = nvl( c_TRANSPORTISTA.Estadotransferencia, [] )
					.Versionmodificacionfw = nvl( c_TRANSPORTISTA.Versionmodificacionfw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Versionaltafw = nvl( c_TRANSPORTISTA.Versionaltafw, [] )
					.Telefono = nvl( c_TRANSPORTISTA.Telefono, [] )
					.Basededatosmodificacionfw = nvl( c_TRANSPORTISTA.Basededatosmodificacionfw, [] )
					.Usuarioaltafw = nvl( c_TRANSPORTISTA.Usuarioaltafw, [] )
					.Situacionfiscal_PK =  nvl( c_TRANSPORTISTA.Situacionfiscal, 0 )
					.Timestamp = nvl( c_TRANSPORTISTA.Timestamp, 0 )
					.Imagen = nvl( c_TRANSPORTISTA.Imagen, [] )
					.Codigo = nvl( c_TRANSPORTISTA.Codigo, [] )
					lcValor = This.ObtenerMemo( 'c_Observacion')
					.Observacion = lcValor 
					.Cuit = nvl( c_TRANSPORTISTA.Cuit, [] )
					.Numero = nvl( c_TRANSPORTISTA.Numero, 0 )
					.Movil = nvl( c_TRANSPORTISTA.Movil, [] )
					.Nombre = nvl( c_TRANSPORTISTA.Nombre, [] )
					.Vehiculodetalle.Limpiar()
					.Vehiculodetalle.SetearEsNavegacion( .lProcesando )
					.Vehiculodetalle.Cargar()
					.Tipodocumento = nvl( c_TRANSPORTISTA.Tipodocumento, [] )
					.Piso = nvl( c_TRANSPORTISTA.Piso, [] )
					.Fax = nvl( c_TRANSPORTISTA.Fax, [] )
					.Email = nvl( c_TRANSPORTISTA.Email, [] )
					.Nrodocumento = nvl( c_TRANSPORTISTA.Nrodocumento, [] )
					.Departamento = nvl( c_TRANSPORTISTA.Departamento, [] )
					.Paginaweb = nvl( c_TRANSPORTISTA.Paginaweb, [] )
					.Localidad = nvl( c_TRANSPORTISTA.Localidad, [] )
					.Messenger = nvl( c_TRANSPORTISTA.Messenger, [] )
					.Codigopostal = nvl( c_TRANSPORTISTA.Codigopostal, [] )
					.Provincia_PK =  nvl( c_TRANSPORTISTA.Provincia, [] )
					.Pais_PK =  nvl( c_TRANSPORTISTA.Pais, [] )
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
		
		loDetalle = this.oEntidad.VehiculoDetalle
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
		return c_TRANSPORTISTA.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.TRA' )
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
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "TRCOD"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
		text to lcSQL textmerge noshow
				SELECT nro,totalRegistros,TRCOD as Id
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    TRCOD from (
							select * 
								from ZooLogic.TRA 
								Where   TRA.TRCOD != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "TRA", "", lcCursor, set("Datasession") )
		lcXml = this.CursorAXml( lcCursor )
		
		use in select( lcCursor )
		
		Return lcXml 
		
	endfunc
	*-----------------------------------------------------------------------------------------
	function ObtenerDatosEntidadPaginado( tcOrderBy as String, tcFiltro as String, tnCantidad as Integer, tnPagina as Integer )  as String
		local lcOrderBy as String, lnCuantos as Integer, lnPagina as Integer, lnTope as Integer, lnDesde as Integer, lcSQL as String, lcCursor as String, lcXml as String
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "TRCOD"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
			text to lcAtributos textmerge noshow
			"Cd1" as "Fechaultimamodificacion", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Trcalle" as "Calle", "Umodifw" as "Usuariomodificacionfw", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Horaexpo" as "Horaexpo", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Trtlf" as "Telefono", "Bdmodifw" as "Basededatosmodificacionfw", "Ualtafw" as "Usuarioaltafw", "Triva" as "Situacionfiscal", "Timestamp" as "Timestamp", "Timagen" as "Imagen", "Trcod" as "Codigo", "Trobs" as "Observacion", "Trcuit" as "Cuit", "Trnro" as "Numero", "Trmovil" as "Movil", "Trnom" as "Nombre", "Trtipodoc" as "Tipodocumento", "Trpiso" as "Piso", "Trfax" as "Fax", "Tremail" as "Email", "Trnrodoc" as "Nrodocumento", "Trdepto" as "Departamento", "Trpageweb" as "Paginaweb", "Trloc" as "Localidad", "Trmsn" as "Messenger", "Trcp" as "Codigopostal", "Trprv" as "Provincia", "Trpais" as "Pais"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.TRA 
								Where   TRA.TRCOD != ''
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
	Tabla = 'TRA'
	Filtro = " TRA.TRCOD != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " TRA.TRCOD != ''"
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
	<row entidad="TRANSPORTISTA                           " atributo="FECHAULTIMAMODIFICACION                 " tabla="TRA            " campo="CD1       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Ultima Modificación                                                                                                                                             " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRANSPORTISTA                           " atributo="FECHAALTAFW                             " tabla="TRA            " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRANSPORTISTA                           " atributo="FECHAEXPO                               " tabla="TRA            " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRANSPORTISTA                           " atributo="FECHAIMPO                               " tabla="TRA            " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRANSPORTISTA                           " atributo="FECHAMODIFICACIONFW                     " tabla="TRA            " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRANSPORTISTA                           " atributo="FECHATRANSFERENCIA                      " tabla="TRA            " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha de novedad                                                                                                                                                " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRANSPORTISTA                           " atributo="CALLE                                   " tabla="TRA            " campo="TRCALLE   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="70" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="6" etiqueta="Calle                                                                                                                                                           " dominio="DIRECCION                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRANSPORTISTA                           " atributo="USUARIOMODIFICACIONFW                   " tabla="TRA            " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRANSPORTISTA                           " atributo="HORAALTAFW                              " tabla="TRA            " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRANSPORTISTA                           " atributo="HORAIMPO                                " tabla="TRA            " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRANSPORTISTA                           " atributo="SERIEALTAFW                             " tabla="TRA            " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRANSPORTISTA                           " atributo="SERIEMODIFICACIONFW                     " tabla="TRA            " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRANSPORTISTA                           " atributo="HORAMODIFICACIONFW                      " tabla="TRA            " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRANSPORTISTA                           " atributo="HORAEXPO                                " tabla="TRA            " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRANSPORTISTA                           " atributo="BASEDEDATOSALTAFW                       " tabla="TRA            " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRANSPORTISTA                           " atributo="ESTADOTRANSFERENCIA                     " tabla="TRA            " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado de novedad                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRANSPORTISTA                           " atributo="VERSIONMODIFICACIONFW                   " tabla="TRA            " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRANSPORTISTA                           " atributo="ZADSFW                                  " tabla="TRA            " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRANSPORTISTA                           " atributo="VERSIONALTAFW                           " tabla="TRA            " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRANSPORTISTA                           " atributo="TELEFONO                                " tabla="TRA            " campo="TRTLF     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="22" etiqueta="Teléfono                                                                                                                                                        " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRANSPORTISTA                           " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="TRA            " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRANSPORTISTA                           " atributo="USUARIOALTAFW                           " tabla="TRA            " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRANSPORTISTA                           " atributo="SITUACIONFISCAL                         " tabla="TRA            " campo="TRIVA     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="SITUACIONFISCAL                         " tipodato="N         " longitud="2" decimales="0" valorsugerido="3                                                                                                                                                                                                                                                             " obligatorio="false" admitebusqueda="400" etiqueta="Situación fiscal                                                                                                                                                " dominio="COMBOTABLA                    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="5" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRANSPORTISTA                           " atributo="TIMESTAMP                               " tabla="TRA            " campo="TIMESTAMP " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRANSPORTISTA                           " atributo="IMAGEN                                  " tabla="TRA            " campo="TIMAGEN   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="180" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="34" etiqueta="Archivo                                                                                                                                                         " dominio="IMAGENCONRUTADINAMICA         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="3" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRANSPORTISTA                           " atributo="CODIGO                                  " tabla="TRA            " campo="TRCOD     " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="2" etiqueta="Código                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRANSPORTISTA                           " atributo="OBSERVACION                             " tabla="TRA            " campo="TROBS     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="402" etiqueta="Observación                                                                                                                                                     " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRANSPORTISTA                           " atributo="CUIT                                    " tabla="TRA            " campo="TRCUIT    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="36" etiqueta="CUIT                                                                                                                                                            " dominio="CUIT                          " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="99-99999999-9            " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="5" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRANSPORTISTA                           " atributo="NUMERO                                  " tabla="TRA            " campo="TRNRO     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="8" etiqueta="Número                                                                                                                                                          " dominio="DIRECCION                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="99999                    " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRANSPORTISTA                           " atributo="MOVIL                                   " tabla="TRA            " campo="TRMOVIL   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="24" etiqueta="Teléfono móvil                                                                                                                                                  " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRANSPORTISTA                           " atributo="NOMBRE                                  " tabla="TRA            " campo="TRNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="4" etiqueta="Nombre                                                                                                                                                          " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRANSPORTISTA                           " atributo="VEHICULODETALLE                         " tabla="VEHICULODET    " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="404" etiqueta="Vehículos                                                                                                                                                       " dominio="DETALLEITEMVEHICULO           " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="6" orden="1" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRANSPORTISTA                           " atributo="TIPODOCUMENTO                           " tabla="TRA            " campo="TRTIPODOC " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="406" etiqueta="Tipo documento                                                                                                                                                  " dominio="DOCUMENTO                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="5" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRANSPORTISTA                           " atributo="PISO                                    " tabla="TRA            " campo="TRPISO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="3" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="10" etiqueta="Piso                                                                                                                                                            " dominio="DIRECCION                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRANSPORTISTA                           " atributo="FAX                                     " tabla="TRA            " campo="TRFAX     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="26" etiqueta="Fax                                                                                                                                                             " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRANSPORTISTA                           " atributo="EMAIL                                   " tabla="TRA            " campo="TREMAIL   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="250" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="28" etiqueta="Email                                                                                                                                                           " dominio="MAIL                          " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRANSPORTISTA                           " atributo="NRODOCUMENTO                            " tabla="TRA            " campo="TRNRODOC  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="38" etiqueta="Número documento                                                                                                                                                " dominio="DOCUMENTO                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="5" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRANSPORTISTA                           " atributo="DEPARTAMENTO                            " tabla="TRA            " campo="TRDEPTO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="3" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="12" etiqueta="Departamento                                                                                                                                                    " dominio="DIRECCION                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRANSPORTISTA                           " atributo="PAGINAWEB                               " tabla="TRA            " campo="TRPAGEWEB " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="30" etiqueta="Página web                                                                                                                                                      " dominio="WEB                           " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRANSPORTISTA                           " atributo="LOCALIDAD                               " tabla="TRA            " campo="TRLOC     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="70" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="14" etiqueta="Localidad                                                                                                                                                       " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRANSPORTISTA                           " atributo="MESSENGER                               " tabla="TRA            " campo="TRMSN     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="250" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="32" etiqueta="Messenger                                                                                                                                                       " dominio="MAIL                          " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRANSPORTISTA                           " atributo="CODIGOPOSTAL                            " tabla="TRA            " campo="TRCP      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="16" etiqueta="Código postal                                                                                                                                                   " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRANSPORTISTA                           " atributo="PROVINCIA                               " tabla="TRA            " campo="TRPRV     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="PROVINCIA                               " tipodato="C         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="18" etiqueta="Provincia                                                                                                                                                       " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRANSPORTISTA                           " atributo="PAIS                                    " tabla="TRA            " campo="TRPAIS    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="PAISES                                  " tipodato="C         " longitud="3" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="20" etiqueta="País                                                                                                                                                            " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SITUACIONFISCAL                         " atributo="DESCRIPCION                             " tabla="SITFISCAL      " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="401" etiqueta="Detalle Sit.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join SITFISCAL On TRA.TRIVA = SITFISCAL.Codigo And  SITFISCAL.CODIGO != 0                                                                                                                                                                               " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVINCIA                               " atributo="DESCRIPCION                             " tabla="PROVINCI       " campo="PRV_DES   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="19" etiqueta="Detalle Pro.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join PROVINCI On TRA.TRPRV = PROVINCI.PRV_COD And  PROVINCI.PRV_COD != ''                                                                                                                                                                               " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PAISES                                  " atributo="DESCRIPCION                             " tabla="PAISES         " campo="PDES      " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="21" etiqueta="Detalle Paí.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join PAISES On TRA.TRPAIS = PAISES.pcod And  PAISES.PCOD != ''                                                                                                                                                                                          " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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