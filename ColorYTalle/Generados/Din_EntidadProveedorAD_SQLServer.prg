
define class Din_EntidadPROVEEDORAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_PROVEEDOR'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = []
	cExpresionCCPorCampos = []
	cTagClaveCandidata = ''
	cTagClavePk = '_PRVPK'
	cTablaPrincipal = 'PROV'
	cCampoCodigoWH = 'CLCOD'
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

		with this.oEntidad
			local  lxProvFectrans, lxProvFmodifw, lxProvFaltafw, lxProvFecexpo, lxProvFecimpo, lxProvCltpo, lxProvClpun4, lxProvClcan4, lxProvClpun1, lxProvClpun2, lxProvClpun3, lxProvClemail, lxProvUaltafw, lxProvValtafw, lxProvUmodifw, lxProvSmodifw, lxProvSaltafw, lxProvHoraimpo, lxProvHmodifw, lxProvHaltafw, lxProvVmodifw, lxProvEsttrans, lxProvBdaltafw, lxProvBdmodifw, lxProvZadsfw, lxProvDescfw, lxProvHoraexpo, lxProvTipagrupub, lxProvClmon1, lxProvTimestamp, lxProvClmon4, lxProvClmonto, lxProvClmon3, lxProvClmon2, lxProvInactivofw, lxProvCimagen, lxProvClcondpag, lxProvClcod, lxProvClobs, lxProvPcalle, lxProvCltlf, lxProvCliva, lxProvExretsuss, lxProvCllistpre, lxProvClas, lxProvClfecha, lxProvExretiva, lxProvExretgan, lxProvCltipconv, lxProvCltipodoc, lxProvPnumero, lxProvTlfm, lxProvClretsuss, lxProvPvhastagan, lxProvPvhastaiva, lxProvClnroiibb, lxProvClnrodoc, lxProvPpiso, lxProvClfax, lxProvClsitgan, lxProvClobjiva, lxProvClpageweb, lxProvPdepto, lxProvClretgan, lxProvClretiva, lxProvClsiprib, lxProvClcuit, lxProvClcfi, lxProvClloc, lxProvClemplead, lxProvRut, lxProvClnom, lxProvPorcentc, lxProvClcp, lxProvClsujvinc, lxProvAplicatc, lxProvClprv, lxProvPpais
				lxProvFectrans =  .Fechatransferencia			lxProvFmodifw =  .Fechamodificacionfw			lxProvFaltafw =  .Fechaaltafw			lxProvFecexpo =  .Fechaexpo			lxProvFecimpo =  .Fechaimpo			lxProvCltpo =  .Tipointerno			lxProvClpun4 =  .Formula5			lxProvClcan4 =  .Formula1			lxProvClpun1 =  .Formula2			lxProvClpun2 =  .Formula3			lxProvClpun3 =  .Formula4			lxProvClemail =  .Email			lxProvUaltafw =  .Usuarioaltafw			lxProvValtafw =  .Versionaltafw			lxProvUmodifw =  .Usuariomodificacionfw			lxProvSmodifw =  .Seriemodificacionfw			lxProvSaltafw =  .Seriealtafw			lxProvHoraimpo =  .Horaimpo			lxProvHmodifw =  .Horamodificacionfw			lxProvHaltafw =  .Horaaltafw			lxProvVmodifw =  .Versionmodificacionfw			lxProvEsttrans =  .Estadotransferencia			lxProvBdaltafw =  .Basededatosaltafw			lxProvBdmodifw =  .Basededatosmodificacionfw			lxProvZadsfw =  .Zadsfw			lxProvDescfw =  .Descripcionfw			lxProvHoraexpo =  .Horaexpo			lxProvTipagrupub =  .Tipoagrupamientopublicaciones			lxProvClmon1 =  .Sobreprecio2			lxProvTimestamp = goLibrerias.ObtenerTimestamp()			lxProvClmon4 =  .Sobreprecio5			lxProvClmonto =  .Sobreprecio1			lxProvClmon3 =  .Sobreprecio4			lxProvClmon2 =  .Sobreprecio3			lxProvInactivofw =  .Inactivofw			lxProvCimagen =  .Imagen			lxProvClcondpag =  upper( .CondicionDePago_PK ) 			lxProvClcod =  .Codigo			lxProvClobs =  .Observacion			lxProvPcalle =  .Calle			lxProvCltlf =  .Telefono			lxProvCliva =  .Situacionfiscal_PK 			lxProvExretsuss =  .Excluidoretencionsuss			lxProvCllistpre =  upper( .ListaDePrecio_PK ) 			lxProvClas =  upper( .Clasificacion_PK ) 			lxProvClfecha =  .Fechanacimiento			lxProvExretiva =  .Excluidoretencioniva			lxProvExretgan =  .Excluidoretencionganancias			lxProvCltipconv =  .Tipoconvenio			lxProvCltipodoc =  .Tipodocumento			lxProvPnumero =  .Numero			lxProvTlfm =  .Movil			lxProvClretsuss =  upper( .RetencionSuss_PK ) 			lxProvPvhastagan =  .Vigenciahastagan			lxProvPvhastaiva =  .Vigenciahastaiva			lxProvClnroiibb =  .Nroiibb			lxProvClnrodoc =  .Nrodocumento			lxProvPpiso =  .Piso			lxProvClfax =  .Fax			lxProvClsitgan =  .Situacionganancias			lxProvClobjiva =  .Objetoiva			lxProvClpageweb =  .Paginaweb			lxProvPdepto =  .Departamento			lxProvClretgan =  upper( .RetencionGanancias_PK ) 			lxProvClretiva =  upper( .RetencionIva_PK ) 			lxProvClsiprib =  upper( .CodigoSiprib_PK ) 			lxProvClcuit =  .Cuit			lxProvClcfi =  .Tipointerno2			lxProvClloc =  .Localidad			lxProvClemplead =  .Empleador			lxProvRut =  .Rut			lxProvClnom =  .Nombre			lxProvPorcentc =  .Tasaceroporcen			lxProvClcp =  .Codigopostal			lxProvClsujvinc =  .Sujetovinculado			lxProvAplicatc =  .Tasaceroaplica			lxProvClprv =  upper( .Provincia_PK ) 			lxProvPpais =  upper( .Pais_PK ) 
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxProvClcod = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.PROV ( "Fectrans","Fmodifw","Faltafw","Fecexpo","Fecimpo","Cltpo","Clpun4","Clcan4","Clpun1","Clpun2","Clpun3","Clemail","Ualtafw","Valtafw","Umodifw","Smodifw","Saltafw","Horaimpo","Hmodifw","Haltafw","Vmodifw","Esttrans","Bdaltafw","Bdmodifw","Zadsfw","Descfw","Horaexpo","Tipagrupub","Clmon1","Timestamp","Clmon4","Clmonto","Clmon3","Clmon2","Inactivofw","Cimagen","Clcondpag","Clcod","Clobs","Pcalle","Cltlf","Cliva","Exretsuss","Cllistpre","Clas","Clfecha","Exretiva","Exretgan","Cltipconv","Cltipodoc","Pnumero","Tlfm","Clretsuss","Pvhastagan","Pvhastaiva","Clnroiibb","Clnrodoc","Ppiso","Clfax","Clsitgan","Clobjiva","Clpageweb","Pdepto","Clretgan","Clretiva","Clsiprib","Clcuit","Clcfi","Clloc","Clemplead","Rut","Clnom","Porcentc","Clcp","Clsujvinc","Aplicatc","Clprv","Ppais" ) values ( <<"'" + this.ConvertirDateSql( lxProvFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxProvFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxProvFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxProvFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxProvFecimpo ) + "'" >>, <<lxProvCltpo >>, <<lxProvClpun4 >>, <<lxProvClcan4 >>, <<lxProvClpun1 >>, <<lxProvClpun2 >>, <<lxProvClpun3 >>, <<"'" + this.FormatearTextoSql( lxProvClemail ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProvUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProvValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProvUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProvSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProvSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProvHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProvHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProvHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProvVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProvEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProvBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProvBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProvZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProvDescfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProvHoraexpo ) + "'" >>, <<lxProvTipagrupub >>, <<lxProvClmon1 >>, <<lxProvTimestamp >>, <<lxProvClmon4 >>, <<lxProvClmonto >>, <<lxProvClmon3 >>, <<lxProvClmon2 >>, <<iif( lxProvInactivofw, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxProvCimagen ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProvClcondpag ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProvClcod ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProvClobs ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProvPcalle ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProvCltlf ) + "'" >>, <<lxProvCliva >>, <<iif( lxProvExretsuss, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxProvCllistpre ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProvClas ) + "'" >>, <<"'" + this.ConvertirDateSql( lxProvClfecha ) + "'" >>, <<iif( lxProvExretiva, 1, 0 ) >>, <<iif( lxProvExretgan, 1, 0 ) >>, <<lxProvCltipconv >>, <<"'" + this.FormatearTextoSql( lxProvCltipodoc ) + "'" >>, <<lxProvPnumero >>, <<"'" + this.FormatearTextoSql( lxProvTlfm ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProvClretsuss ) + "'" >>, <<"'" + this.ConvertirDateSql( lxProvPvhastagan ) + "'" >>, <<"'" + this.ConvertirDateSql( lxProvPvhastaiva ) + "'" >>, <<lxProvClnroiibb >>, <<"'" + this.FormatearTextoSql( lxProvClnrodoc ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProvPpiso ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProvClfax ) + "'" >>, <<lxProvClsitgan >>, <<lxProvClobjiva >>, <<"'" + this.FormatearTextoSql( lxProvClpageweb ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProvPdepto ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProvClretgan ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProvClretiva ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProvClsiprib ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProvClcuit ) + "'" >>, <<lxProvClcfi >>, <<"'" + this.FormatearTextoSql( lxProvClloc ) + "'" >>, <<iif( lxProvClemplead, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxProvRut ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProvClnom ) + "'" >>, <<lxProvPorcentc >>, <<"'" + this.FormatearTextoSql( lxProvClcp ) + "'" >>, <<iif( lxProvClsujvinc, 1, 0 ) >>, <<iif( lxProvAplicatc, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxProvClprv ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProvPpais ) + "'" >> )
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
		this.ComprobarTransaccion()
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = lxValorClavePrimaria

			lcSentencia = this.ObtenerSentenciasInsertAuditoria()
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
		this.ComprobarTransaccion()
			.GenerarSentenciasComponentes()
			.EjecutarSentencias( This.ColSentencias )
		this.ComprobarTransaccion()

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.Contacto
				if this.oEntidad.Contacto.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxContacto = loItem.Contacto
					lxNombre = loItem.Nombre
					lxTelefonos = loItem.Telefonos
					lxEmail = loItem.Email
					lxNotas = loItem.Notas
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ContProvdet("NROITEM","Concod","ConCon","CONNOM","CONTEL","CONMAIL","CONNOT" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxContacto ) + "'">>, <<"'" + this.FormatearTextoSql( lxNombre ) + "'">>, <<"'" + this.FormatearTextoSql( lxTelefonos ) + "'">>, <<"'" + this.FormatearTextoSql( lxEmail ) + "'">>, <<"'" + this.FormatearTextoSql( lxNotas ) + "'">> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.AgruPubliDetalle
				if this.oEntidad.AgruPubliDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxAgrupamiento_PK = loItem.Agrupamiento_PK
					lxAgrupamientodetalle = loItem.Agrupamientodetalle
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.AgruPubPRV("NROITEM","Codigo","Agrup","AgrupDes" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxAgrupamiento_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxAgrupamientodetalle ) + "'">> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.Retenciones
				if this.oEntidad.Retenciones.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxJurisdiccion_PK = loItem.Jurisdiccion_PK
					lxJurisdicciondetalle = loItem.Jurisdicciondetalle
					lxResolucion = loItem.Resolucion
					lxPorcentaje = loItem.Porcentaje
					lxFechaexpiracion = loItem.Fechaexpiracion
					lxExcluido = loItem.Excluido
					lxSedeextrajuris = loItem.Sedeextrajuris
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.RetProDet("NROITEM","Cod","jurisdicci","DesJur","Resol","porcen","FecExp","Excluido","SedeExtJur" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxJurisdiccion_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxJurisdicciondetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxResolucion ) + "'">>, <<lxPorcentaje>>, <<"'" + this.ConvertirDateSql( lxFechaexpiracion ) + "'">>, <<iif( lxExcluido, 1, 0 )>>, <<iif( lxSedeextrajuris, 1, 0 )>> ) 
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
		this.oEntidad.Timestamp = lxProvTimestamp
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
			local  lxProvFectrans, lxProvFmodifw, lxProvFaltafw, lxProvFecexpo, lxProvFecimpo, lxProvCltpo, lxProvClpun4, lxProvClcan4, lxProvClpun1, lxProvClpun2, lxProvClpun3, lxProvClemail, lxProvUaltafw, lxProvValtafw, lxProvUmodifw, lxProvSmodifw, lxProvSaltafw, lxProvHoraimpo, lxProvHmodifw, lxProvHaltafw, lxProvVmodifw, lxProvEsttrans, lxProvBdaltafw, lxProvBdmodifw, lxProvZadsfw, lxProvDescfw, lxProvHoraexpo, lxProvTipagrupub, lxProvClmon1, lxProvTimestamp, lxProvClmon4, lxProvClmonto, lxProvClmon3, lxProvClmon2, lxProvInactivofw, lxProvCimagen, lxProvClcondpag, lxProvClcod, lxProvClobs, lxProvPcalle, lxProvCltlf, lxProvCliva, lxProvExretsuss, lxProvCllistpre, lxProvClas, lxProvClfecha, lxProvExretiva, lxProvExretgan, lxProvCltipconv, lxProvCltipodoc, lxProvPnumero, lxProvTlfm, lxProvClretsuss, lxProvPvhastagan, lxProvPvhastaiva, lxProvClnroiibb, lxProvClnrodoc, lxProvPpiso, lxProvClfax, lxProvClsitgan, lxProvClobjiva, lxProvClpageweb, lxProvPdepto, lxProvClretgan, lxProvClretiva, lxProvClsiprib, lxProvClcuit, lxProvClcfi, lxProvClloc, lxProvClemplead, lxProvRut, lxProvClnom, lxProvPorcentc, lxProvClcp, lxProvClsujvinc, lxProvAplicatc, lxProvClprv, lxProvPpais
				lxProvFectrans =  .Fechatransferencia			lxProvFmodifw =  .Fechamodificacionfw			lxProvFaltafw =  .Fechaaltafw			lxProvFecexpo =  .Fechaexpo			lxProvFecimpo =  .Fechaimpo			lxProvCltpo =  .Tipointerno			lxProvClpun4 =  .Formula5			lxProvClcan4 =  .Formula1			lxProvClpun1 =  .Formula2			lxProvClpun2 =  .Formula3			lxProvClpun3 =  .Formula4			lxProvClemail =  .Email			lxProvUaltafw =  .Usuarioaltafw			lxProvValtafw =  .Versionaltafw			lxProvUmodifw =  .Usuariomodificacionfw			lxProvSmodifw =  .Seriemodificacionfw			lxProvSaltafw =  .Seriealtafw			lxProvHoraimpo =  .Horaimpo			lxProvHmodifw =  .Horamodificacionfw			lxProvHaltafw =  .Horaaltafw			lxProvVmodifw =  .Versionmodificacionfw			lxProvEsttrans =  .Estadotransferencia			lxProvBdaltafw =  .Basededatosaltafw			lxProvBdmodifw =  .Basededatosmodificacionfw			lxProvZadsfw =  .Zadsfw			lxProvDescfw =  .Descripcionfw			lxProvHoraexpo =  .Horaexpo			lxProvTipagrupub =  .Tipoagrupamientopublicaciones			lxProvClmon1 =  .Sobreprecio2			lxProvTimestamp = goLibrerias.ObtenerTimestamp()			lxProvClmon4 =  .Sobreprecio5			lxProvClmonto =  .Sobreprecio1			lxProvClmon3 =  .Sobreprecio4			lxProvClmon2 =  .Sobreprecio3			lxProvInactivofw =  .Inactivofw			lxProvCimagen =  .Imagen			lxProvClcondpag =  upper( .CondicionDePago_PK ) 			lxProvClcod =  .Codigo			lxProvClobs =  .Observacion			lxProvPcalle =  .Calle			lxProvCltlf =  .Telefono			lxProvCliva =  .Situacionfiscal_PK 			lxProvExretsuss =  .Excluidoretencionsuss			lxProvCllistpre =  upper( .ListaDePrecio_PK ) 			lxProvClas =  upper( .Clasificacion_PK ) 			lxProvClfecha =  .Fechanacimiento			lxProvExretiva =  .Excluidoretencioniva			lxProvExretgan =  .Excluidoretencionganancias			lxProvCltipconv =  .Tipoconvenio			lxProvCltipodoc =  .Tipodocumento			lxProvPnumero =  .Numero			lxProvTlfm =  .Movil			lxProvClretsuss =  upper( .RetencionSuss_PK ) 			lxProvPvhastagan =  .Vigenciahastagan			lxProvPvhastaiva =  .Vigenciahastaiva			lxProvClnroiibb =  .Nroiibb			lxProvClnrodoc =  .Nrodocumento			lxProvPpiso =  .Piso			lxProvClfax =  .Fax			lxProvClsitgan =  .Situacionganancias			lxProvClobjiva =  .Objetoiva			lxProvClpageweb =  .Paginaweb			lxProvPdepto =  .Departamento			lxProvClretgan =  upper( .RetencionGanancias_PK ) 			lxProvClretiva =  upper( .RetencionIva_PK ) 			lxProvClsiprib =  upper( .CodigoSiprib_PK ) 			lxProvClcuit =  .Cuit			lxProvClcfi =  .Tipointerno2			lxProvClloc =  .Localidad			lxProvClemplead =  .Empleador			lxProvRut =  .Rut			lxProvClnom =  .Nombre			lxProvPorcentc =  .Tasaceroporcen			lxProvClcp =  .Codigopostal			lxProvClsujvinc =  .Sujetovinculado			lxProvAplicatc =  .Tasaceroaplica			lxProvClprv =  upper( .Provincia_PK ) 			lxProvPpais =  upper( .Pais_PK ) 
		endwith
		
		if this.oEntidad.VerificarContexto( 'CB' )
		else
			this.ValidarTimestamp()
		endif
		with this
		Try
			local llInsertarAuditoria as Boolean
			llInsertarAuditoria = (  .oEntidad.oAtributosAuditoria.INACTIVOFW != .oEntidad.INACTIVOFW or  .oEntidad.oAtributosAuditoria.Clasificacion != .oEntidad.Clasificacion_Pk or  .oEntidad.oAtributosAuditoria.TipoConvenio != .oEntidad.TipoConvenio or  .oEntidad.oAtributosAuditoria.NroIIBB != .oEntidad.NroIIBB or  .oEntidad.oAtributosAuditoria.RUT != .oEntidad.RUT )
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()
			lxValorClavePrimaria = .oEntidad.CODIGO
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ZooLogic.PROV set "Fectrans" = <<"'" + this.ConvertirDateSql( lxProvFectrans ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxProvFmodifw ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxProvFaltafw ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxProvFecexpo ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxProvFecimpo ) + "'">>,"Cltpo" = <<lxProvCltpo>>,"Clpun4" = <<lxProvClpun4>>,"Clcan4" = <<lxProvClcan4>>,"Clpun1" = <<lxProvClpun1>>,"Clpun2" = <<lxProvClpun2>>,"Clpun3" = <<lxProvClpun3>>,"Clemail" = <<"'" + this.FormatearTextoSql( lxProvClemail ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxProvUaltafw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxProvValtafw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxProvUmodifw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxProvSmodifw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxProvSaltafw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxProvHoraimpo ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxProvHmodifw ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxProvHaltafw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxProvVmodifw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxProvEsttrans ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxProvBdaltafw ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxProvBdmodifw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxProvZadsfw ) + "'">>,"Descfw" = <<"'" + this.FormatearTextoSql( lxProvDescfw ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxProvHoraexpo ) + "'">>,"Tipagrupub" = <<lxProvTipagrupub>>,"Clmon1" = <<lxProvClmon1>>,"Timestamp" = <<lxProvTimestamp>>,"Clmon4" = <<lxProvClmon4>>,"Clmonto" = <<lxProvClmonto>>,"Clmon3" = <<lxProvClmon3>>,"Clmon2" = <<lxProvClmon2>>,"Inactivofw" = <<iif( lxProvInactivofw, 1, 0 )>>,"Cimagen" = <<"'" + this.FormatearTextoSql( lxProvCimagen ) + "'">>,"Clcondpag" = <<"'" + this.FormatearTextoSql( lxProvClcondpag ) + "'">>,"Clcod" = <<"'" + this.FormatearTextoSql( lxProvClcod ) + "'">>,"Clobs" = <<"'" + this.FormatearTextoSql( lxProvClobs ) + "'">>,"Pcalle" = <<"'" + this.FormatearTextoSql( lxProvPcalle ) + "'">>,"Cltlf" = <<"'" + this.FormatearTextoSql( lxProvCltlf ) + "'">>,"Cliva" = <<lxProvCliva>>,"Exretsuss" = <<iif( lxProvExretsuss, 1, 0 )>>,"Cllistpre" = <<"'" + this.FormatearTextoSql( lxProvCllistpre ) + "'">>,"Clas" = <<"'" + this.FormatearTextoSql( lxProvClas ) + "'">>,"Clfecha" = <<"'" + this.ConvertirDateSql( lxProvClfecha ) + "'">>,"Exretiva" = <<iif( lxProvExretiva, 1, 0 )>>,"Exretgan" = <<iif( lxProvExretgan, 1, 0 )>>,"Cltipconv" = <<lxProvCltipconv>>,"Cltipodoc" = <<"'" + this.FormatearTextoSql( lxProvCltipodoc ) + "'">>,"Pnumero" = <<lxProvPnumero>>,"Tlfm" = <<"'" + this.FormatearTextoSql( lxProvTlfm ) + "'">>,"Clretsuss" = <<"'" + this.FormatearTextoSql( lxProvClretsuss ) + "'">>,"Pvhastagan" = <<"'" + this.ConvertirDateSql( lxProvPvhastagan ) + "'">>,"Pvhastaiva" = <<"'" + this.ConvertirDateSql( lxProvPvhastaiva ) + "'">>,"Clnroiibb" = <<lxProvClnroiibb>>,"Clnrodoc" = <<"'" + this.FormatearTextoSql( lxProvClnrodoc ) + "'">>,"Ppiso" = <<"'" + this.FormatearTextoSql( lxProvPpiso ) + "'">>,"Clfax" = <<"'" + this.FormatearTextoSql( lxProvClfax ) + "'">>,"Clsitgan" = <<lxProvClsitgan>>,"Clobjiva" = <<lxProvClobjiva>>,"Clpageweb" = <<"'" + this.FormatearTextoSql( lxProvClpageweb ) + "'">>,"Pdepto" = <<"'" + this.FormatearTextoSql( lxProvPdepto ) + "'">>,"Clretgan" = <<"'" + this.FormatearTextoSql( lxProvClretgan ) + "'">>,"Clretiva" = <<"'" + this.FormatearTextoSql( lxProvClretiva ) + "'">>,"Clsiprib" = <<"'" + this.FormatearTextoSql( lxProvClsiprib ) + "'">>,"Clcuit" = <<"'" + this.FormatearTextoSql( lxProvClcuit ) + "'">>,"Clcfi" = <<lxProvClcfi>>,"Clloc" = <<"'" + this.FormatearTextoSql( lxProvClloc ) + "'">>,"Clemplead" = <<iif( lxProvClemplead, 1, 0 )>>,"Rut" = <<"'" + this.FormatearTextoSql( lxProvRut ) + "'">>,"Clnom" = <<"'" + this.FormatearTextoSql( lxProvClnom ) + "'">>,"Porcentc" = <<lxProvPorcentc>>,"Clcp" = <<"'" + this.FormatearTextoSql( lxProvClcp ) + "'">>,"Clsujvinc" = <<iif( lxProvClsujvinc, 1, 0 )>>,"Aplicatc" = <<iif( lxProvAplicatc, 1, 0 )>>,"Clprv" = <<"'" + this.FormatearTextoSql( lxProvClprv ) + "'">>,"Ppais" = <<"'" + this.FormatearTextoSql( lxProvPpais ) + "'">> where "Clcod" = <<"'" + this.FormatearTextoSql( lxProvClcod ) + "'">> and  PROV.CLCOD != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			this.ComprobarResultadoDeEjecucionDelUpdate()
		this.ComprobarTransaccion()
			If llInsertarAuditoria
				lcSentencia = this.ObtenerSentenciasInsertAuditoria()
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			EndIf
			.EjecutarSentencias( This.ColSentencias )
		this.ComprobarTransaccion()
			this.oConexion.EjecutarSql( 'delete from ZooLogic.ContProvdet where "CONCOD" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.AgruPubPRV where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.RetProDet where "Cod" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.Contacto
				if this.oEntidad.Contacto.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxContacto = loItem.Contacto
					lxNombre = loItem.Nombre
					lxTelefonos = loItem.Telefonos
					lxEmail = loItem.Email
					lxNotas = loItem.Notas
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ContProvdet("NROITEM","Concod","ConCon","CONNOM","CONTEL","CONMAIL","CONNOT" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxContacto ) + "'">>, <<"'" + this.FormatearTextoSql( lxNombre ) + "'">>, <<"'" + this.FormatearTextoSql( lxTelefonos ) + "'">>, <<"'" + this.FormatearTextoSql( lxEmail ) + "'">>, <<"'" + this.FormatearTextoSql( lxNotas ) + "'">> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.AgruPubliDetalle
				if this.oEntidad.AgruPubliDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxAgrupamiento_PK = loItem.Agrupamiento_PK
					lxAgrupamientodetalle = loItem.Agrupamientodetalle
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.AgruPubPRV("NROITEM","Codigo","Agrup","AgrupDes" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxAgrupamiento_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxAgrupamientodetalle ) + "'">> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.Retenciones
				if this.oEntidad.Retenciones.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxJurisdiccion_PK = loItem.Jurisdiccion_PK
					lxJurisdicciondetalle = loItem.Jurisdicciondetalle
					lxResolucion = loItem.Resolucion
					lxPorcentaje = loItem.Porcentaje
					lxFechaexpiracion = loItem.Fechaexpiracion
					lxExcluido = loItem.Excluido
					lxSedeextrajuris = loItem.Sedeextrajuris
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.RetProDet("NROITEM","Cod","jurisdicci","DesJur","Resol","porcen","FecExp","Excluido","SedeExtJur" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxJurisdiccion_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxJurisdicciondetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxResolucion ) + "'">>, <<lxPorcentaje>>, <<"'" + this.ConvertirDateSql( lxFechaexpiracion ) + "'">>, <<iif( lxExcluido, 1, 0 )>>, <<iif( lxSedeextrajuris, 1, 0 )>> ) 
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
		this.oEntidad.Timestamp = lxProvTimestamp
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 CLCOD from ZooLogic.PROV where " + this.ConvertirFuncionesSql( " PROV.CLCOD != ''" ) )
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
			Local lxProvClcod
			lxProvClcod = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Cltpo" as "Tipointerno", "Clpun4" as "Formula5", "Clcan4" as "Formula1", "Clpun1" as "Formula2", "Clpun2" as "Formula3", "Clpun3" as "Formula4", "Clemail" as "Email", "Ualtafw" as "Usuarioaltafw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Haltafw" as "Horaaltafw", "Vmodifw" as "Versionmodificacionfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Zadsfw" as "Zadsfw", "Descfw" as "Descripcionfw", "Horaexpo" as "Horaexpo", "Tipagrupub" as "Tipoagrupamientopublicaciones", "Clmon1" as "Sobreprecio2", "Timestamp" as "Timestamp", "Clmon4" as "Sobreprecio5", "Clmonto" as "Sobreprecio1", "Clmon3" as "Sobreprecio4", "Clmon2" as "Sobreprecio3", "Inactivofw" as "Inactivofw", "Cimagen" as "Imagen", "Clcondpag" as "Condiciondepago", "Clcod" as "Codigo", "Clobs" as "Observacion", "Pcalle" as "Calle", "Cltlf" as "Telefono", "Cliva" as "Situacionfiscal", "Exretsuss" as "Excluidoretencionsuss", "Cllistpre" as "Listadeprecio", "Clas" as "Clasificacion", "Clfecha" as "Fechanacimiento", "Exretiva" as "Excluidoretencioniva", "Exretgan" as "Excluidoretencionganancias", "Cltipconv" as "Tipoconvenio", "Cltipodoc" as "Tipodocumento", "Pnumero" as "Numero", "Tlfm" as "Movil", "Clretsuss" as "Retencionsuss", "Pvhastagan" as "Vigenciahastagan", "Pvhastaiva" as "Vigenciahastaiva", "Clnroiibb" as "Nroiibb", "Clnrodoc" as "Nrodocumento", "Ppiso" as "Piso", "Clfax" as "Fax", "Clsitgan" as "Situacionganancias", "Clobjiva" as "Objetoiva", "Clpageweb" as "Paginaweb", "Pdepto" as "Departamento", "Clretgan" as "Retencionganancias", "Clretiva" as "Retencioniva", "Clsiprib" as "Codigosiprib", "Clcuit" as "Cuit", "Clcfi" as "Tipointerno2", "Clloc" as "Localidad", "Clemplead" as "Empleador", "Rut" as "Rut", "Clnom" as "Nombre", "Porcentc" as "Tasaceroporcen", "Clcp" as "Codigopostal", "Clsujvinc" as "Sujetovinculado", "Aplicatc" as "Tasaceroaplica", "Clprv" as "Provincia", "Ppais" as "Pais" from ZooLogic.PROV where "Clcod" = <<"'" + this.FormatearTextoSql( lxProvClcod ) + "'">> and  PROV.CLCOD != ''
			endtext
			use in select('c_PROVEEDOR')
			this.oConexion.EjecutarSql( lcSentencia, 'c_PROVEEDOR', set( 'Datasession' ) )

			if reccount( 'c_PROVEEDOR' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Concod" as "Codigo", "Concon" as "Contacto", "Connom" as "Nombre", "Contel" as "Telefonos", "Conmail" as "Email", "Connot" as "Notas" from ZooLogic.ContProvdet where CONCOD = <<"'" + this.FormatearTextoSql( c_PROVEEDOR.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_Contacto')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Contacto', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Contacto
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Agrup" as "Agrupamiento", "Agrupdes" as "Agrupamientodetalle" from ZooLogic.AgruPubPRV where Codigo = <<"'" + this.FormatearTextoSql( c_PROVEEDOR.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_AgruPubliDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_AgruPubliDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_AgruPubliDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Cod" as "Codigo", "Jurisdicci" as "Jurisdiccion", "Desjur" as "Jurisdicciondetalle", "Resol" as "Resolucion", "Porcen" as "Porcentaje", "Fecexp" as "Fechaexpiracion", "Excluido" as "Excluido", "Sedeextjur" as "Sedeextrajuris" from ZooLogic.RetProDet where Cod = <<"'" + this.FormatearTextoSql( c_PROVEEDOR.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_Retenciones')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Retenciones', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Retenciones
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxProvClcod as Variant
		llRetorno = .t.
		lxProvClcod = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.PROV where "Clcod" = <<"'" + this.FormatearTextoSql( lxProvClcod ) + "'">> and  PROV.CLCOD != ''
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
				select top 1 "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Cltpo" as "Tipointerno", "Clpun4" as "Formula5", "Clcan4" as "Formula1", "Clpun1" as "Formula2", "Clpun2" as "Formula3", "Clpun3" as "Formula4", "Clemail" as "Email", "Ualtafw" as "Usuarioaltafw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Haltafw" as "Horaaltafw", "Vmodifw" as "Versionmodificacionfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Zadsfw" as "Zadsfw", "Descfw" as "Descripcionfw", "Horaexpo" as "Horaexpo", "Tipagrupub" as "Tipoagrupamientopublicaciones", "Clmon1" as "Sobreprecio2", "Timestamp" as "Timestamp", "Clmon4" as "Sobreprecio5", "Clmonto" as "Sobreprecio1", "Clmon3" as "Sobreprecio4", "Clmon2" as "Sobreprecio3", "Inactivofw" as "Inactivofw", "Cimagen" as "Imagen", "Clcondpag" as "Condiciondepago", "Clcod" as "Codigo", "Clobs" as "Observacion", "Pcalle" as "Calle", "Cltlf" as "Telefono", "Cliva" as "Situacionfiscal", "Exretsuss" as "Excluidoretencionsuss", "Cllistpre" as "Listadeprecio", "Clas" as "Clasificacion", "Clfecha" as "Fechanacimiento", "Exretiva" as "Excluidoretencioniva", "Exretgan" as "Excluidoretencionganancias", "Cltipconv" as "Tipoconvenio", "Cltipodoc" as "Tipodocumento", "Pnumero" as "Numero", "Tlfm" as "Movil", "Clretsuss" as "Retencionsuss", "Pvhastagan" as "Vigenciahastagan", "Pvhastaiva" as "Vigenciahastaiva", "Clnroiibb" as "Nroiibb", "Clnrodoc" as "Nrodocumento", "Ppiso" as "Piso", "Clfax" as "Fax", "Clsitgan" as "Situacionganancias", "Clobjiva" as "Objetoiva", "Clpageweb" as "Paginaweb", "Pdepto" as "Departamento", "Clretgan" as "Retencionganancias", "Clretiva" as "Retencioniva", "Clsiprib" as "Codigosiprib", "Clcuit" as "Cuit", "Clcfi" as "Tipointerno2", "Clloc" as "Localidad", "Clemplead" as "Empleador", "Rut" as "Rut", "Clnom" as "Nombre", "Porcentc" as "Tasaceroporcen", "Clcp" as "Codigopostal", "Clsujvinc" as "Sujetovinculado", "Aplicatc" as "Tasaceroaplica", "Clprv" as "Provincia", "Ppais" as "Pais" from ZooLogic.PROV where  PROV.CLCOD != '' order by CLCOD
			endtext
			use in select('c_PROVEEDOR')
			this.oConexion.EjecutarSql( lcSentencia, 'c_PROVEEDOR', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Concod" as "Codigo", "Concon" as "Contacto", "Connom" as "Nombre", "Contel" as "Telefonos", "Conmail" as "Email", "Connot" as "Notas" from ZooLogic.ContProvdet where CONCOD = <<"'" + this.FormatearTextoSql( c_PROVEEDOR.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_Contacto')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Contacto', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Contacto
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Agrup" as "Agrupamiento", "Agrupdes" as "Agrupamientodetalle" from ZooLogic.AgruPubPRV where Codigo = <<"'" + this.FormatearTextoSql( c_PROVEEDOR.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_AgruPubliDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_AgruPubliDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_AgruPubliDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Cod" as "Codigo", "Jurisdicci" as "Jurisdiccion", "Desjur" as "Jurisdicciondetalle", "Resol" as "Resolucion", "Porcen" as "Porcentaje", "Fecexp" as "Fechaexpiracion", "Excluido" as "Excluido", "Sedeextjur" as "Sedeextrajuris" from ZooLogic.RetProDet where Cod = <<"'" + this.FormatearTextoSql( c_PROVEEDOR.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_Retenciones')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Retenciones', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Retenciones
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
				select top 1 "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Cltpo" as "Tipointerno", "Clpun4" as "Formula5", "Clcan4" as "Formula1", "Clpun1" as "Formula2", "Clpun2" as "Formula3", "Clpun3" as "Formula4", "Clemail" as "Email", "Ualtafw" as "Usuarioaltafw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Haltafw" as "Horaaltafw", "Vmodifw" as "Versionmodificacionfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Zadsfw" as "Zadsfw", "Descfw" as "Descripcionfw", "Horaexpo" as "Horaexpo", "Tipagrupub" as "Tipoagrupamientopublicaciones", "Clmon1" as "Sobreprecio2", "Timestamp" as "Timestamp", "Clmon4" as "Sobreprecio5", "Clmonto" as "Sobreprecio1", "Clmon3" as "Sobreprecio4", "Clmon2" as "Sobreprecio3", "Inactivofw" as "Inactivofw", "Cimagen" as "Imagen", "Clcondpag" as "Condiciondepago", "Clcod" as "Codigo", "Clobs" as "Observacion", "Pcalle" as "Calle", "Cltlf" as "Telefono", "Cliva" as "Situacionfiscal", "Exretsuss" as "Excluidoretencionsuss", "Cllistpre" as "Listadeprecio", "Clas" as "Clasificacion", "Clfecha" as "Fechanacimiento", "Exretiva" as "Excluidoretencioniva", "Exretgan" as "Excluidoretencionganancias", "Cltipconv" as "Tipoconvenio", "Cltipodoc" as "Tipodocumento", "Pnumero" as "Numero", "Tlfm" as "Movil", "Clretsuss" as "Retencionsuss", "Pvhastagan" as "Vigenciahastagan", "Pvhastaiva" as "Vigenciahastaiva", "Clnroiibb" as "Nroiibb", "Clnrodoc" as "Nrodocumento", "Ppiso" as "Piso", "Clfax" as "Fax", "Clsitgan" as "Situacionganancias", "Clobjiva" as "Objetoiva", "Clpageweb" as "Paginaweb", "Pdepto" as "Departamento", "Clretgan" as "Retencionganancias", "Clretiva" as "Retencioniva", "Clsiprib" as "Codigosiprib", "Clcuit" as "Cuit", "Clcfi" as "Tipointerno2", "Clloc" as "Localidad", "Clemplead" as "Empleador", "Rut" as "Rut", "Clnom" as "Nombre", "Porcentc" as "Tasaceroporcen", "Clcp" as "Codigopostal", "Clsujvinc" as "Sujetovinculado", "Aplicatc" as "Tasaceroaplica", "Clprv" as "Provincia", "Ppais" as "Pais" from ZooLogic.PROV where  funciones.padr( CLCOD, 10, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  PROV.CLCOD != '' order by CLCOD
			endtext
			use in select('c_PROVEEDOR')
			this.oConexion.EjecutarSql( lcSentencia, 'c_PROVEEDOR', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Concod" as "Codigo", "Concon" as "Contacto", "Connom" as "Nombre", "Contel" as "Telefonos", "Conmail" as "Email", "Connot" as "Notas" from ZooLogic.ContProvdet where CONCOD = <<"'" + this.FormatearTextoSql( c_PROVEEDOR.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_Contacto')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Contacto', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Contacto
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Agrup" as "Agrupamiento", "Agrupdes" as "Agrupamientodetalle" from ZooLogic.AgruPubPRV where Codigo = <<"'" + this.FormatearTextoSql( c_PROVEEDOR.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_AgruPubliDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_AgruPubliDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_AgruPubliDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Cod" as "Codigo", "Jurisdicci" as "Jurisdiccion", "Desjur" as "Jurisdicciondetalle", "Resol" as "Resolucion", "Porcen" as "Porcentaje", "Fecexp" as "Fechaexpiracion", "Excluido" as "Excluido", "Sedeextjur" as "Sedeextrajuris" from ZooLogic.RetProDet where Cod = <<"'" + this.FormatearTextoSql( c_PROVEEDOR.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_Retenciones')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Retenciones', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Retenciones
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
				select top 1 "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Cltpo" as "Tipointerno", "Clpun4" as "Formula5", "Clcan4" as "Formula1", "Clpun1" as "Formula2", "Clpun2" as "Formula3", "Clpun3" as "Formula4", "Clemail" as "Email", "Ualtafw" as "Usuarioaltafw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Haltafw" as "Horaaltafw", "Vmodifw" as "Versionmodificacionfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Zadsfw" as "Zadsfw", "Descfw" as "Descripcionfw", "Horaexpo" as "Horaexpo", "Tipagrupub" as "Tipoagrupamientopublicaciones", "Clmon1" as "Sobreprecio2", "Timestamp" as "Timestamp", "Clmon4" as "Sobreprecio5", "Clmonto" as "Sobreprecio1", "Clmon3" as "Sobreprecio4", "Clmon2" as "Sobreprecio3", "Inactivofw" as "Inactivofw", "Cimagen" as "Imagen", "Clcondpag" as "Condiciondepago", "Clcod" as "Codigo", "Clobs" as "Observacion", "Pcalle" as "Calle", "Cltlf" as "Telefono", "Cliva" as "Situacionfiscal", "Exretsuss" as "Excluidoretencionsuss", "Cllistpre" as "Listadeprecio", "Clas" as "Clasificacion", "Clfecha" as "Fechanacimiento", "Exretiva" as "Excluidoretencioniva", "Exretgan" as "Excluidoretencionganancias", "Cltipconv" as "Tipoconvenio", "Cltipodoc" as "Tipodocumento", "Pnumero" as "Numero", "Tlfm" as "Movil", "Clretsuss" as "Retencionsuss", "Pvhastagan" as "Vigenciahastagan", "Pvhastaiva" as "Vigenciahastaiva", "Clnroiibb" as "Nroiibb", "Clnrodoc" as "Nrodocumento", "Ppiso" as "Piso", "Clfax" as "Fax", "Clsitgan" as "Situacionganancias", "Clobjiva" as "Objetoiva", "Clpageweb" as "Paginaweb", "Pdepto" as "Departamento", "Clretgan" as "Retencionganancias", "Clretiva" as "Retencioniva", "Clsiprib" as "Codigosiprib", "Clcuit" as "Cuit", "Clcfi" as "Tipointerno2", "Clloc" as "Localidad", "Clemplead" as "Empleador", "Rut" as "Rut", "Clnom" as "Nombre", "Porcentc" as "Tasaceroporcen", "Clcp" as "Codigopostal", "Clsujvinc" as "Sujetovinculado", "Aplicatc" as "Tasaceroaplica", "Clprv" as "Provincia", "Ppais" as "Pais" from ZooLogic.PROV where  funciones.padr( CLCOD, 10, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  PROV.CLCOD != '' order by CLCOD desc
			endtext
			use in select('c_PROVEEDOR')
			this.oConexion.EjecutarSql( lcSentencia, 'c_PROVEEDOR', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Concod" as "Codigo", "Concon" as "Contacto", "Connom" as "Nombre", "Contel" as "Telefonos", "Conmail" as "Email", "Connot" as "Notas" from ZooLogic.ContProvdet where CONCOD = <<"'" + this.FormatearTextoSql( c_PROVEEDOR.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_Contacto')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Contacto', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Contacto
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Agrup" as "Agrupamiento", "Agrupdes" as "Agrupamientodetalle" from ZooLogic.AgruPubPRV where Codigo = <<"'" + this.FormatearTextoSql( c_PROVEEDOR.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_AgruPubliDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_AgruPubliDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_AgruPubliDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Cod" as "Codigo", "Jurisdicci" as "Jurisdiccion", "Desjur" as "Jurisdicciondetalle", "Resol" as "Resolucion", "Porcen" as "Porcentaje", "Fecexp" as "Fechaexpiracion", "Excluido" as "Excluido", "Sedeextjur" as "Sedeextrajuris" from ZooLogic.RetProDet where Cod = <<"'" + this.FormatearTextoSql( c_PROVEEDOR.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_Retenciones')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Retenciones', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Retenciones
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
				select top 1 "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Cltpo" as "Tipointerno", "Clpun4" as "Formula5", "Clcan4" as "Formula1", "Clpun1" as "Formula2", "Clpun2" as "Formula3", "Clpun3" as "Formula4", "Clemail" as "Email", "Ualtafw" as "Usuarioaltafw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Haltafw" as "Horaaltafw", "Vmodifw" as "Versionmodificacionfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Zadsfw" as "Zadsfw", "Descfw" as "Descripcionfw", "Horaexpo" as "Horaexpo", "Tipagrupub" as "Tipoagrupamientopublicaciones", "Clmon1" as "Sobreprecio2", "Timestamp" as "Timestamp", "Clmon4" as "Sobreprecio5", "Clmonto" as "Sobreprecio1", "Clmon3" as "Sobreprecio4", "Clmon2" as "Sobreprecio3", "Inactivofw" as "Inactivofw", "Cimagen" as "Imagen", "Clcondpag" as "Condiciondepago", "Clcod" as "Codigo", "Clobs" as "Observacion", "Pcalle" as "Calle", "Cltlf" as "Telefono", "Cliva" as "Situacionfiscal", "Exretsuss" as "Excluidoretencionsuss", "Cllistpre" as "Listadeprecio", "Clas" as "Clasificacion", "Clfecha" as "Fechanacimiento", "Exretiva" as "Excluidoretencioniva", "Exretgan" as "Excluidoretencionganancias", "Cltipconv" as "Tipoconvenio", "Cltipodoc" as "Tipodocumento", "Pnumero" as "Numero", "Tlfm" as "Movil", "Clretsuss" as "Retencionsuss", "Pvhastagan" as "Vigenciahastagan", "Pvhastaiva" as "Vigenciahastaiva", "Clnroiibb" as "Nroiibb", "Clnrodoc" as "Nrodocumento", "Ppiso" as "Piso", "Clfax" as "Fax", "Clsitgan" as "Situacionganancias", "Clobjiva" as "Objetoiva", "Clpageweb" as "Paginaweb", "Pdepto" as "Departamento", "Clretgan" as "Retencionganancias", "Clretiva" as "Retencioniva", "Clsiprib" as "Codigosiprib", "Clcuit" as "Cuit", "Clcfi" as "Tipointerno2", "Clloc" as "Localidad", "Clemplead" as "Empleador", "Rut" as "Rut", "Clnom" as "Nombre", "Porcentc" as "Tasaceroporcen", "Clcp" as "Codigopostal", "Clsujvinc" as "Sujetovinculado", "Aplicatc" as "Tasaceroaplica", "Clprv" as "Provincia", "Ppais" as "Pais" from ZooLogic.PROV where  PROV.CLCOD != '' order by CLCOD desc
			endtext
			use in select('c_PROVEEDOR')
			this.oConexion.EjecutarSql( lcSentencia, 'c_PROVEEDOR', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Concod" as "Codigo", "Concon" as "Contacto", "Connom" as "Nombre", "Contel" as "Telefonos", "Conmail" as "Email", "Connot" as "Notas" from ZooLogic.ContProvdet where CONCOD = <<"'" + this.FormatearTextoSql( c_PROVEEDOR.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_Contacto')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Contacto', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Contacto
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Agrup" as "Agrupamiento", "Agrupdes" as "Agrupamientodetalle" from ZooLogic.AgruPubPRV where Codigo = <<"'" + this.FormatearTextoSql( c_PROVEEDOR.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_AgruPubliDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_AgruPubliDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_AgruPubliDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Cod" as "Codigo", "Jurisdicci" as "Jurisdiccion", "Desjur" as "Jurisdicciondetalle", "Resol" as "Resolucion", "Porcen" as "Porcentaje", "Fecexp" as "Fechaexpiracion", "Excluido" as "Excluido", "Sedeextjur" as "Sedeextrajuris" from ZooLogic.RetProDet where Cod = <<"'" + this.FormatearTextoSql( c_PROVEEDOR.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_Retenciones')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Retenciones', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Retenciones
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
			lcXml = this.oConexion.EjecutarSql( "select Fectrans,Fmodifw,Faltafw,Fecexpo,Fecimpo,Cltpo,Clpun4,Clcan4,Clpun1,Clpun2,Clpun3,Clemail,Ua" + ;
"ltafw,Valtafw,Umodifw,Smodifw,Saltafw,Horaimpo,Hmodifw,Haltafw,Vmodifw,Esttrans,Bdaltafw,Bdmodifw,Za" + ;
"dsfw,Descfw,Horaexpo,Tipagrupub,Clmon1,Timestamp,Clmon4,Clmonto,Clmon3,Clmon2,Inactivofw,Cimagen,Clc" + ;
"ondpag,Clcod,Clobs,Pcalle,Cltlf,Cliva,Exretsuss,Cllistpre,Clas,Clfecha,Exretiva,Exretgan,Cltipconv,C" + ;
"ltipodoc,Pnumero,Tlfm,Clretsuss,Pvhastagan,Pvhastaiva,Clnroiibb,Clnrodoc,Ppiso,Clfax,Clsitgan,Clobji" + ;
"va,Clpageweb,Pdepto,Clretgan,Clretiva,Clsiprib,Clcuit,Clcfi,Clloc,Clemplead,Rut,Clnom,Porcentc,Clcp," + ;
"Clsujvinc,Aplicatc,Clprv,Ppais" + ;
" from ZooLogic.PROV where  PROV.CLCOD != '' and " + lcFiltro )
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
			local  lxProvFectrans, lxProvFmodifw, lxProvFaltafw, lxProvFecexpo, lxProvFecimpo, lxProvCltpo, lxProvClpun4, lxProvClcan4, lxProvClpun1, lxProvClpun2, lxProvClpun3, lxProvClemail, lxProvUaltafw, lxProvValtafw, lxProvUmodifw, lxProvSmodifw, lxProvSaltafw, lxProvHoraimpo, lxProvHmodifw, lxProvHaltafw, lxProvVmodifw, lxProvEsttrans, lxProvBdaltafw, lxProvBdmodifw, lxProvZadsfw, lxProvDescfw, lxProvHoraexpo, lxProvTipagrupub, lxProvClmon1, lxProvTimestamp, lxProvClmon4, lxProvClmonto, lxProvClmon3, lxProvClmon2, lxProvInactivofw, lxProvCimagen, lxProvClcondpag, lxProvClcod, lxProvClobs, lxProvPcalle, lxProvCltlf, lxProvCliva, lxProvExretsuss, lxProvCllistpre, lxProvClas, lxProvClfecha, lxProvExretiva, lxProvExretgan, lxProvCltipconv, lxProvCltipodoc, lxProvPnumero, lxProvTlfm, lxProvClretsuss, lxProvPvhastagan, lxProvPvhastaiva, lxProvClnroiibb, lxProvClnrodoc, lxProvPpiso, lxProvClfax, lxProvClsitgan, lxProvClobjiva, lxProvClpageweb, lxProvPdepto, lxProvClretgan, lxProvClretiva, lxProvClsiprib, lxProvClcuit, lxProvClcfi, lxProvClloc, lxProvClemplead, lxProvRut, lxProvClnom, lxProvPorcentc, lxProvClcp, lxProvClsujvinc, lxProvAplicatc, lxProvClprv, lxProvPpais
				lxProvFectrans = ctod( '  /  /    ' )			lxProvFmodifw = ctod( '  /  /    ' )			lxProvFaltafw = ctod( '  /  /    ' )			lxProvFecexpo = ctod( '  /  /    ' )			lxProvFecimpo = ctod( '  /  /    ' )			lxProvCltpo = 0			lxProvClpun4 = 0			lxProvClcan4 = 0			lxProvClpun1 = 0			lxProvClpun2 = 0			lxProvClpun3 = 0			lxProvClemail = []			lxProvUaltafw = []			lxProvValtafw = []			lxProvUmodifw = []			lxProvSmodifw = []			lxProvSaltafw = []			lxProvHoraimpo = []			lxProvHmodifw = []			lxProvHaltafw = []			lxProvVmodifw = []			lxProvEsttrans = []			lxProvBdaltafw = []			lxProvBdmodifw = []			lxProvZadsfw = []			lxProvDescfw = []			lxProvHoraexpo = []			lxProvTipagrupub = 0			lxProvClmon1 = 0			lxProvTimestamp = goLibrerias.ObtenerTimestamp()			lxProvClmon4 = 0			lxProvClmonto = 0			lxProvClmon3 = 0			lxProvClmon2 = 0			lxProvInactivofw = .F.			lxProvCimagen = []			lxProvClcondpag = []			lxProvClcod = []			lxProvClobs = []			lxProvPcalle = []			lxProvCltlf = []			lxProvCliva = 0			lxProvExretsuss = .F.			lxProvCllistpre = []			lxProvClas = []			lxProvClfecha = ctod( '  /  /    ' )			lxProvExretiva = .F.			lxProvExretgan = .F.			lxProvCltipconv = 0			lxProvCltipodoc = []			lxProvPnumero = 0			lxProvTlfm = []			lxProvClretsuss = []			lxProvPvhastagan = ctod( '  /  /    ' )			lxProvPvhastaiva = ctod( '  /  /    ' )			lxProvClnroiibb = 0			lxProvClnrodoc = []			lxProvPpiso = []			lxProvClfax = []			lxProvClsitgan = 0			lxProvClobjiva = 0			lxProvClpageweb = []			lxProvPdepto = []			lxProvClretgan = []			lxProvClretiva = []			lxProvClsiprib = []			lxProvClcuit = []			lxProvClcfi = 0			lxProvClloc = []			lxProvClemplead = .F.			lxProvRut = []			lxProvClnom = []			lxProvPorcentc = 0			lxProvClcp = []			lxProvClsujvinc = .F.			lxProvAplicatc = .F.			lxProvClprv = []			lxProvPpais = []
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.ContProvdet where "CONCOD" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.AgruPubPRV where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.RetProDet where "Cod" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( [delete from ZooLogic.PROV where "CLCOD" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			.GenerarSentenciasComponentes()
			.EjecutarSentencias( This.ColSentencias )
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
			lcTabla = 'PROV' + '_' + tcCampo
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
		lcWhere = " Where  PROV.CLCOD != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Cltpo" as "Tipointerno", "Clpun4" as "Formula5", "Clcan4" as "Formula1", "Clpun1" as "Formula2", "Clpun2" as "Formula3", "Clpun3" as "Formula4", "Clemail" as "Email", "Ualtafw" as "Usuarioaltafw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Haltafw" as "Horaaltafw", "Vmodifw" as "Versionmodificacionfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Zadsfw" as "Zadsfw", "Descfw" as "Descripcionfw", "Horaexpo" as "Horaexpo", "Tipagrupub" as "Tipoagrupamientopublicaciones", "Clmon1" as "Sobreprecio2", "Timestamp" as "Timestamp", "Clmon4" as "Sobreprecio5", "Clmonto" as "Sobreprecio1", "Clmon3" as "Sobreprecio4", "Clmon2" as "Sobreprecio3", "Inactivofw" as "Inactivofw", "Cimagen" as "Imagen", "Clcondpag" as "Condiciondepago", "Clcod" as "Codigo", "Clobs" as "Observacion", "Pcalle" as "Calle", "Cltlf" as "Telefono", "Cliva" as "Situacionfiscal", "Exretsuss" as "Excluidoretencionsuss", "Cllistpre" as "Listadeprecio", "Clas" as "Clasificacion", "Clfecha" as "Fechanacimiento", "Exretiva" as "Excluidoretencioniva", "Exretgan" as "Excluidoretencionganancias", "Cltipconv" as "Tipoconvenio", "Cltipodoc" as "Tipodocumento", "Pnumero" as "Numero", "Tlfm" as "Movil", "Clretsuss" as "Retencionsuss", "Pvhastagan" as "Vigenciahastagan", "Pvhastaiva" as "Vigenciahastaiva", "Clnroiibb" as "Nroiibb", "Clnrodoc" as "Nrodocumento", "Ppiso" as "Piso", "Clfax" as "Fax", "Clsitgan" as "Situacionganancias", "Clobjiva" as "Objetoiva", "Clpageweb" as "Paginaweb", "Pdepto" as "Departamento", "Clretgan" as "Retencionganancias", "Clretiva" as "Retencioniva", "Clsiprib" as "Codigosiprib", "Clcuit" as "Cuit", "Clcfi" as "Tipointerno2", "Clloc" as "Localidad", "Clemplead" as "Empleador", "Rut" as "Rut", "Clnom" as "Nombre", "Porcentc" as "Tasaceroporcen", "Clcp" as "Codigopostal", "Clsujvinc" as "Sujetovinculado", "Aplicatc" as "Tasaceroaplica", "Clprv" as "Provincia", "Ppais" as "Pais"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'PROV', '', tnTope )
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
	Function ObtenerDatosDetalleContacto( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  CONTPROVDET.CONCOD != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Nroitem" as "Nroitem", "Concod" as "Codigo", "Concon" as "Contacto", "Connom" as "Nombre", "Contel" as "Telefonos", "Conmail" as "Email", "Connot" as "Notas"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleContacto( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'ContProvdet', 'Contacto', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleContacto( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleContacto( lcAtributo )
		endfor
		lcSelect = substr( lcSelect, 2 )
		return lcSelect
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosDetalleAgruPubliDetalle( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  AGRUPUBPRV.CODIGO != ''"
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
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'AgruPubPRV', 'AgruPubliDetalle', tnTope )
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
	Function ObtenerDatosDetalleRetenciones( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  RETPRODET.COD != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Nroitem" as "Nroitem", "Cod" as "Codigo", "Jurisdicci" as "Jurisdiccion", "Desjur" as "Jurisdicciondetalle", "Resol" as "Resolucion", "Porcen" as "Porcentaje", "Fecexp" as "Fechaexpiracion", "Excluido" as "Excluido", "Sedeextjur" as "Sedeextrajuris"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleRetenciones( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'RetProDet', 'Retenciones', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleRetenciones( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleRetenciones( lcAtributo )
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
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'FECHAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECEXPO AS FECHAEXPO'
				Case lcAtributo == 'FECHAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECIMPO AS FECHAIMPO'
				Case lcAtributo == 'TIPOINTERNO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLTPO AS TIPOINTERNO'
				Case lcAtributo == 'FORMULA5'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLPUN4 AS FORMULA5'
				Case lcAtributo == 'FORMULA1'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLCAN4 AS FORMULA1'
				Case lcAtributo == 'FORMULA2'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLPUN1 AS FORMULA2'
				Case lcAtributo == 'FORMULA3'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLPUN2 AS FORMULA3'
				Case lcAtributo == 'FORMULA4'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLPUN3 AS FORMULA4'
				Case lcAtributo == 'EMAIL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLEMAIL AS EMAIL'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'DESCRIPCIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCFW AS DESCRIPCIONFW'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'TIPOAGRUPAMIENTOPUBLICACIONES'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPAGRUPUB AS TIPOAGRUPAMIENTOPUBLICACIONES'
				Case lcAtributo == 'SOBREPRECIO2'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLMON1 AS SOBREPRECIO2'
				Case lcAtributo == 'TIMESTAMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIMESTAMP AS TIMESTAMP'
				Case lcAtributo == 'SOBREPRECIO5'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLMON4 AS SOBREPRECIO5'
				Case lcAtributo == 'SOBREPRECIO1'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLMONTO AS SOBREPRECIO1'
				Case lcAtributo == 'SOBREPRECIO4'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLMON3 AS SOBREPRECIO4'
				Case lcAtributo == 'SOBREPRECIO3'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLMON2 AS SOBREPRECIO3'
				Case lcAtributo == 'INACTIVOFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'INACTIVOFW AS INACTIVOFW'
				Case lcAtributo == 'IMAGEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CIMAGEN AS IMAGEN'
				Case lcAtributo == 'CONDICIONDEPAGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLCONDPAG AS CONDICIONDEPAGO'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLCOD AS CODIGO'
				Case lcAtributo == 'OBSERVACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLOBS AS OBSERVACION'
				Case lcAtributo == 'CALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PCALLE AS CALLE'
				Case lcAtributo == 'TELEFONO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLTLF AS TELEFONO'
				Case lcAtributo == 'SITUACIONFISCAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLIVA AS SITUACIONFISCAL'
				Case lcAtributo == 'EXCLUIDORETENCIONSUSS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'EXRETSUSS AS EXCLUIDORETENCIONSUSS'
				Case lcAtributo == 'LISTADEPRECIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLLISTPRE AS LISTADEPRECIO'
				Case lcAtributo == 'CLASIFICACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLAS AS CLASIFICACION'
				Case lcAtributo == 'FECHANACIMIENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLFECHA AS FECHANACIMIENTO'
				Case lcAtributo == 'EXCLUIDORETENCIONIVA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'EXRETIVA AS EXCLUIDORETENCIONIVA'
				Case lcAtributo == 'EXCLUIDORETENCIONGANANCIAS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'EXRETGAN AS EXCLUIDORETENCIONGANANCIAS'
				Case lcAtributo == 'TIPOCONVENIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLTIPCONV AS TIPOCONVENIO'
				Case lcAtributo == 'TIPODOCUMENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLTIPODOC AS TIPODOCUMENTO'
				Case lcAtributo == 'NUMERO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PNUMERO AS NUMERO'
				Case lcAtributo == 'MOVIL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TLFM AS MOVIL'
				Case lcAtributo == 'RETENCIONSUSS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLRETSUSS AS RETENCIONSUSS'
				Case lcAtributo == 'VIGENCIAHASTAGAN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PVHASTAGAN AS VIGENCIAHASTAGAN'
				Case lcAtributo == 'VIGENCIAHASTAIVA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PVHASTAIVA AS VIGENCIAHASTAIVA'
				Case lcAtributo == 'NROIIBB'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLNROIIBB AS NROIIBB'
				Case lcAtributo == 'NRODOCUMENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLNRODOC AS NRODOCUMENTO'
				Case lcAtributo == 'PISO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PPISO AS PISO'
				Case lcAtributo == 'FAX'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLFAX AS FAX'
				Case lcAtributo == 'SITUACIONGANANCIAS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLSITGAN AS SITUACIONGANANCIAS'
				Case lcAtributo == 'OBJETOIVA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLOBJIVA AS OBJETOIVA'
				Case lcAtributo == 'PAGINAWEB'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLPAGEWEB AS PAGINAWEB'
				Case lcAtributo == 'DEPARTAMENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PDEPTO AS DEPARTAMENTO'
				Case lcAtributo == 'RETENCIONGANANCIAS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLRETGAN AS RETENCIONGANANCIAS'
				Case lcAtributo == 'RETENCIONIVA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLRETIVA AS RETENCIONIVA'
				Case lcAtributo == 'CODIGOSIPRIB'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLSIPRIB AS CODIGOSIPRIB'
				Case lcAtributo == 'CUIT'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLCUIT AS CUIT'
				Case lcAtributo == 'TIPOINTERNO2'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLCFI AS TIPOINTERNO2'
				Case lcAtributo == 'LOCALIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLLOC AS LOCALIDAD'
				Case lcAtributo == 'EMPLEADOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLEMPLEAD AS EMPLEADOR'
				Case lcAtributo == 'RUT'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RUT AS RUT'
				Case lcAtributo == 'NOMBRE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLNOM AS NOMBRE'
				Case lcAtributo == 'TASACEROPORCEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PORCENTC AS TASACEROPORCEN'
				Case lcAtributo == 'CODIGOPOSTAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLCP AS CODIGOPOSTAL'
				Case lcAtributo == 'SUJETOVINCULADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLSUJVINC AS SUJETOVINCULADO'
				Case lcAtributo == 'TASACEROAPLICA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'APLICATC AS TASACEROAPLICA'
				Case lcAtributo == 'PROVINCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLPRV AS PROVINCIA'
				Case lcAtributo == 'PAIS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PPAIS AS PAIS'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleContacto( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CONCOD AS CODIGO'
				Case lcAtributo == 'CONTACTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CONCON AS CONTACTO'
				Case lcAtributo == 'NOMBRE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CONNOM AS NOMBRE'
				Case lcAtributo == 'TELEFONOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CONTEL AS TELEFONOS'
				Case lcAtributo == 'EMAIL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CONMAIL AS EMAIL'
				Case lcAtributo == 'NOTAS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CONNOT AS NOTAS'
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
	Function ObtenerCamposSelectDetalleRetenciones( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COD AS CODIGO'
				Case lcAtributo == 'JURISDICCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'JURISDICCI AS JURISDICCION'
				Case lcAtributo == 'JURISDICCIONDETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESJUR AS JURISDICCIONDETALLE'
				Case lcAtributo == 'RESOLUCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RESOL AS RESOLUCION'
				Case lcAtributo == 'PORCENTAJE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PORCEN AS PORCENTAJE'
				Case lcAtributo == 'FECHAEXPIRACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECEXP AS FECHAEXPIRACION'
				Case lcAtributo == 'EXCLUIDO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'EXCLUIDO AS EXCLUIDO'
				Case lcAtributo == 'SEDEEXTRAJURIS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SEDEEXTJUR AS SEDEEXTRAJURIS'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEXPO'
				lcCampo = 'FECEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAIMPO'
				lcCampo = 'FECIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOINTERNO'
				lcCampo = 'CLTPO'
			Case upper( alltrim( tcAtributo ) ) == 'FORMULA5'
				lcCampo = 'CLPUN4'
			Case upper( alltrim( tcAtributo ) ) == 'FORMULA1'
				lcCampo = 'CLCAN4'
			Case upper( alltrim( tcAtributo ) ) == 'FORMULA2'
				lcCampo = 'CLPUN1'
			Case upper( alltrim( tcAtributo ) ) == 'FORMULA3'
				lcCampo = 'CLPUN2'
			Case upper( alltrim( tcAtributo ) ) == 'FORMULA4'
				lcCampo = 'CLPUN3'
			Case upper( alltrim( tcAtributo ) ) == 'EMAIL'
				lcCampo = 'CLEMAIL'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCIONFW'
				lcCampo = 'DESCFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOAGRUPAMIENTOPUBLICACIONES'
				lcCampo = 'TIPAGRUPUB'
			Case upper( alltrim( tcAtributo ) ) == 'SOBREPRECIO2'
				lcCampo = 'CLMON1'
			Case upper( alltrim( tcAtributo ) ) == 'TIMESTAMP'
				lcCampo = 'TIMESTAMP'
			Case upper( alltrim( tcAtributo ) ) == 'SOBREPRECIO5'
				lcCampo = 'CLMON4'
			Case upper( alltrim( tcAtributo ) ) == 'SOBREPRECIO1'
				lcCampo = 'CLMONTO'
			Case upper( alltrim( tcAtributo ) ) == 'SOBREPRECIO4'
				lcCampo = 'CLMON3'
			Case upper( alltrim( tcAtributo ) ) == 'SOBREPRECIO3'
				lcCampo = 'CLMON2'
			Case upper( alltrim( tcAtributo ) ) == 'INACTIVOFW'
				lcCampo = 'INACTIVOFW'
			Case upper( alltrim( tcAtributo ) ) == 'IMAGEN'
				lcCampo = 'CIMAGEN'
			Case upper( alltrim( tcAtributo ) ) == 'CONDICIONDEPAGO'
				lcCampo = 'CLCONDPAG'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CLCOD'
			Case upper( alltrim( tcAtributo ) ) == 'OBSERVACION'
				lcCampo = 'CLOBS'
			Case upper( alltrim( tcAtributo ) ) == 'CALLE'
				lcCampo = 'PCALLE'
			Case upper( alltrim( tcAtributo ) ) == 'TELEFONO'
				lcCampo = 'CLTLF'
			Case upper( alltrim( tcAtributo ) ) == 'SITUACIONFISCAL'
				lcCampo = 'CLIVA'
			Case upper( alltrim( tcAtributo ) ) == 'EXCLUIDORETENCIONSUSS'
				lcCampo = 'EXRETSUSS'
			Case upper( alltrim( tcAtributo ) ) == 'LISTADEPRECIO'
				lcCampo = 'CLLISTPRE'
			Case upper( alltrim( tcAtributo ) ) == 'CLASIFICACION'
				lcCampo = 'CLAS'
			Case upper( alltrim( tcAtributo ) ) == 'FECHANACIMIENTO'
				lcCampo = 'CLFECHA'
			Case upper( alltrim( tcAtributo ) ) == 'EXCLUIDORETENCIONIVA'
				lcCampo = 'EXRETIVA'
			Case upper( alltrim( tcAtributo ) ) == 'EXCLUIDORETENCIONGANANCIAS'
				lcCampo = 'EXRETGAN'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOCONVENIO'
				lcCampo = 'CLTIPCONV'
			Case upper( alltrim( tcAtributo ) ) == 'TIPODOCUMENTO'
				lcCampo = 'CLTIPODOC'
			Case upper( alltrim( tcAtributo ) ) == 'NUMERO'
				lcCampo = 'PNUMERO'
			Case upper( alltrim( tcAtributo ) ) == 'MOVIL'
				lcCampo = 'TLFM'
			Case upper( alltrim( tcAtributo ) ) == 'RETENCIONSUSS'
				lcCampo = 'CLRETSUSS'
			Case upper( alltrim( tcAtributo ) ) == 'VIGENCIAHASTAGAN'
				lcCampo = 'PVHASTAGAN'
			Case upper( alltrim( tcAtributo ) ) == 'VIGENCIAHASTAIVA'
				lcCampo = 'PVHASTAIVA'
			Case upper( alltrim( tcAtributo ) ) == 'NROIIBB'
				lcCampo = 'CLNROIIBB'
			Case upper( alltrim( tcAtributo ) ) == 'NRODOCUMENTO'
				lcCampo = 'CLNRODOC'
			Case upper( alltrim( tcAtributo ) ) == 'PISO'
				lcCampo = 'PPISO'
			Case upper( alltrim( tcAtributo ) ) == 'FAX'
				lcCampo = 'CLFAX'
			Case upper( alltrim( tcAtributo ) ) == 'SITUACIONGANANCIAS'
				lcCampo = 'CLSITGAN'
			Case upper( alltrim( tcAtributo ) ) == 'OBJETOIVA'
				lcCampo = 'CLOBJIVA'
			Case upper( alltrim( tcAtributo ) ) == 'PAGINAWEB'
				lcCampo = 'CLPAGEWEB'
			Case upper( alltrim( tcAtributo ) ) == 'DEPARTAMENTO'
				lcCampo = 'PDEPTO'
			Case upper( alltrim( tcAtributo ) ) == 'RETENCIONGANANCIAS'
				lcCampo = 'CLRETGAN'
			Case upper( alltrim( tcAtributo ) ) == 'RETENCIONIVA'
				lcCampo = 'CLRETIVA'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGOSIPRIB'
				lcCampo = 'CLSIPRIB'
			Case upper( alltrim( tcAtributo ) ) == 'CUIT'
				lcCampo = 'CLCUIT'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOINTERNO2'
				lcCampo = 'CLCFI'
			Case upper( alltrim( tcAtributo ) ) == 'LOCALIDAD'
				lcCampo = 'CLLOC'
			Case upper( alltrim( tcAtributo ) ) == 'EMPLEADOR'
				lcCampo = 'CLEMPLEAD'
			Case upper( alltrim( tcAtributo ) ) == 'RUT'
				lcCampo = 'RUT'
			Case upper( alltrim( tcAtributo ) ) == 'NOMBRE'
				lcCampo = 'CLNOM'
			Case upper( alltrim( tcAtributo ) ) == 'TASACEROPORCEN'
				lcCampo = 'PORCENTC'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGOPOSTAL'
				lcCampo = 'CLCP'
			Case upper( alltrim( tcAtributo ) ) == 'SUJETOVINCULADO'
				lcCampo = 'CLSUJVINC'
			Case upper( alltrim( tcAtributo ) ) == 'TASACEROAPLICA'
				lcCampo = 'APLICATC'
			Case upper( alltrim( tcAtributo ) ) == 'PROVINCIA'
				lcCampo = 'CLPRV'
			Case upper( alltrim( tcAtributo ) ) == 'PAIS'
				lcCampo = 'PPAIS'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleContacto( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CONCOD'
			Case upper( alltrim( tcAtributo ) ) == 'CONTACTO'
				lcCampo = 'CONCON'
			Case upper( alltrim( tcAtributo ) ) == 'NOMBRE'
				lcCampo = 'CONNOM'
			Case upper( alltrim( tcAtributo ) ) == 'TELEFONOS'
				lcCampo = 'CONTEL'
			Case upper( alltrim( tcAtributo ) ) == 'EMAIL'
				lcCampo = 'CONMAIL'
			Case upper( alltrim( tcAtributo ) ) == 'NOTAS'
				lcCampo = 'CONNOT'
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
	Function ObtenerCampoDetalleRetenciones( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'COD'
			Case upper( alltrim( tcAtributo ) ) == 'JURISDICCION'
				lcCampo = 'JURISDICCI'
			Case upper( alltrim( tcAtributo ) ) == 'JURISDICCIONDETALLE'
				lcCampo = 'DESJUR'
			Case upper( alltrim( tcAtributo ) ) == 'RESOLUCION'
				lcCampo = 'RESOL'
			Case upper( alltrim( tcAtributo ) ) == 'PORCENTAJE'
				lcCampo = 'PORCEN'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEXPIRACION'
				lcCampo = 'FECEXP'
			Case upper( alltrim( tcAtributo ) ) == 'EXCLUIDO'
				lcCampo = 'EXCLUIDO'
			Case upper( alltrim( tcAtributo ) ) == 'SEDEEXTRAJURIS'
				lcCampo = 'SEDEEXTJUR'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerTablaDetalle( tcDetalle as string ) as String
		local lcRetorno as string
		lcRetorno = ''
		if upper( alltrim( tcDetalle ) ) == 'CONTACTO'
			lcRetorno = 'CONTPROVDET'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'AGRUPUBLIDETALLE'
			lcRetorno = 'AGRUPUBPRV'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'RETENCIONES'
			lcRetorno = 'RETPRODET'
		EndIf
		return lcRetorno
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasInsert() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcSentencia as string, loItem as object
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxProvFectrans, lxProvFmodifw, lxProvFaltafw, lxProvFecexpo, lxProvFecimpo, lxProvCltpo, lxProvClpun4, lxProvClcan4, lxProvClpun1, lxProvClpun2, lxProvClpun3, lxProvClemail, lxProvUaltafw, lxProvValtafw, lxProvUmodifw, lxProvSmodifw, lxProvSaltafw, lxProvHoraimpo, lxProvHmodifw, lxProvHaltafw, lxProvVmodifw, lxProvEsttrans, lxProvBdaltafw, lxProvBdmodifw, lxProvZadsfw, lxProvDescfw, lxProvHoraexpo, lxProvTipagrupub, lxProvClmon1, lxProvTimestamp, lxProvClmon4, lxProvClmonto, lxProvClmon3, lxProvClmon2, lxProvInactivofw, lxProvCimagen, lxProvClcondpag, lxProvClcod, lxProvClobs, lxProvPcalle, lxProvCltlf, lxProvCliva, lxProvExretsuss, lxProvCllistpre, lxProvClas, lxProvClfecha, lxProvExretiva, lxProvExretgan, lxProvCltipconv, lxProvCltipodoc, lxProvPnumero, lxProvTlfm, lxProvClretsuss, lxProvPvhastagan, lxProvPvhastaiva, lxProvClnroiibb, lxProvClnrodoc, lxProvPpiso, lxProvClfax, lxProvClsitgan, lxProvClobjiva, lxProvClpageweb, lxProvPdepto, lxProvClretgan, lxProvClretiva, lxProvClsiprib, lxProvClcuit, lxProvClcfi, lxProvClloc, lxProvClemplead, lxProvRut, lxProvClnom, lxProvPorcentc, lxProvClcp, lxProvClsujvinc, lxProvAplicatc, lxProvClprv, lxProvPpais
				lxProvFectrans =  .Fechatransferencia			lxProvFmodifw =  .Fechamodificacionfw			lxProvFaltafw =  .Fechaaltafw			lxProvFecexpo =  .Fechaexpo			lxProvFecimpo =  .Fechaimpo			lxProvCltpo =  .Tipointerno			lxProvClpun4 =  .Formula5			lxProvClcan4 =  .Formula1			lxProvClpun1 =  .Formula2			lxProvClpun2 =  .Formula3			lxProvClpun3 =  .Formula4			lxProvClemail =  .Email			lxProvUaltafw =  .Usuarioaltafw			lxProvValtafw =  .Versionaltafw			lxProvUmodifw =  .Usuariomodificacionfw			lxProvSmodifw =  .Seriemodificacionfw			lxProvSaltafw =  .Seriealtafw			lxProvHoraimpo =  .Horaimpo			lxProvHmodifw =  .Horamodificacionfw			lxProvHaltafw =  .Horaaltafw			lxProvVmodifw =  .Versionmodificacionfw			lxProvEsttrans =  .Estadotransferencia			lxProvBdaltafw =  .Basededatosaltafw			lxProvBdmodifw =  .Basededatosmodificacionfw			lxProvZadsfw =  .Zadsfw			lxProvDescfw =  .Descripcionfw			lxProvHoraexpo =  .Horaexpo			lxProvTipagrupub =  .Tipoagrupamientopublicaciones			lxProvClmon1 =  .Sobreprecio2			lxProvTimestamp = goLibrerias.ObtenerTimestamp()			lxProvClmon4 =  .Sobreprecio5			lxProvClmonto =  .Sobreprecio1			lxProvClmon3 =  .Sobreprecio4			lxProvClmon2 =  .Sobreprecio3			lxProvInactivofw =  .Inactivofw			lxProvCimagen =  .Imagen			lxProvClcondpag =  upper( .CondicionDePago_PK ) 			lxProvClcod =  .Codigo			lxProvClobs =  .Observacion			lxProvPcalle =  .Calle			lxProvCltlf =  .Telefono			lxProvCliva =  .Situacionfiscal_PK 			lxProvExretsuss =  .Excluidoretencionsuss			lxProvCllistpre =  upper( .ListaDePrecio_PK ) 			lxProvClas =  upper( .Clasificacion_PK ) 			lxProvClfecha =  .Fechanacimiento			lxProvExretiva =  .Excluidoretencioniva			lxProvExretgan =  .Excluidoretencionganancias			lxProvCltipconv =  .Tipoconvenio			lxProvCltipodoc =  .Tipodocumento			lxProvPnumero =  .Numero			lxProvTlfm =  .Movil			lxProvClretsuss =  upper( .RetencionSuss_PK ) 			lxProvPvhastagan =  .Vigenciahastagan			lxProvPvhastaiva =  .Vigenciahastaiva			lxProvClnroiibb =  .Nroiibb			lxProvClnrodoc =  .Nrodocumento			lxProvPpiso =  .Piso			lxProvClfax =  .Fax			lxProvClsitgan =  .Situacionganancias			lxProvClobjiva =  .Objetoiva			lxProvClpageweb =  .Paginaweb			lxProvPdepto =  .Departamento			lxProvClretgan =  upper( .RetencionGanancias_PK ) 			lxProvClretiva =  upper( .RetencionIva_PK ) 			lxProvClsiprib =  upper( .CodigoSiprib_PK ) 			lxProvClcuit =  .Cuit			lxProvClcfi =  .Tipointerno2			lxProvClloc =  .Localidad			lxProvClemplead =  .Empleador			lxProvRut =  .Rut			lxProvClnom =  .Nombre			lxProvPorcentc =  .Tasaceroporcen			lxProvClcp =  .Codigopostal			lxProvClsujvinc =  .Sujetovinculado			lxProvAplicatc =  .Tasaceroaplica			lxProvClprv =  upper( .Provincia_PK ) 			lxProvPpais =  upper( .Pais_PK ) 
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.PROV ( "Fectrans","Fmodifw","Faltafw","Fecexpo","Fecimpo","Cltpo","Clpun4","Clcan4","Clpun1","Clpun2","Clpun3","Clemail","Ualtafw","Valtafw","Umodifw","Smodifw","Saltafw","Horaimpo","Hmodifw","Haltafw","Vmodifw","Esttrans","Bdaltafw","Bdmodifw","Zadsfw","Descfw","Horaexpo","Tipagrupub","Clmon1","Timestamp","Clmon4","Clmonto","Clmon3","Clmon2","Inactivofw","Cimagen","Clcondpag","Clcod","Clobs","Pcalle","Cltlf","Cliva","Exretsuss","Cllistpre","Clas","Clfecha","Exretiva","Exretgan","Cltipconv","Cltipodoc","Pnumero","Tlfm","Clretsuss","Pvhastagan","Pvhastaiva","Clnroiibb","Clnrodoc","Ppiso","Clfax","Clsitgan","Clobjiva","Clpageweb","Pdepto","Clretgan","Clretiva","Clsiprib","Clcuit","Clcfi","Clloc","Clemplead","Rut","Clnom","Porcentc","Clcp","Clsujvinc","Aplicatc","Clprv","Ppais" ) values ( <<"'" + this.ConvertirDateSql( lxProvFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxProvFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxProvFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxProvFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxProvFecimpo ) + "'" >>, <<lxProvCltpo >>, <<lxProvClpun4 >>, <<lxProvClcan4 >>, <<lxProvClpun1 >>, <<lxProvClpun2 >>, <<lxProvClpun3 >>, <<"'" + this.FormatearTextoSql( lxProvClemail ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProvUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProvValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProvUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProvSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProvSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProvHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProvHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProvHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProvVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProvEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProvBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProvBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProvZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProvDescfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProvHoraexpo ) + "'" >>, <<lxProvTipagrupub >>, <<lxProvClmon1 >>, <<lxProvTimestamp >>, <<lxProvClmon4 >>, <<lxProvClmonto >>, <<lxProvClmon3 >>, <<lxProvClmon2 >>, <<iif( lxProvInactivofw, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxProvCimagen ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProvClcondpag ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProvClcod ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProvClobs ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProvPcalle ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProvCltlf ) + "'" >>, <<lxProvCliva >>, <<iif( lxProvExretsuss, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxProvCllistpre ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProvClas ) + "'" >>, <<"'" + this.ConvertirDateSql( lxProvClfecha ) + "'" >>, <<iif( lxProvExretiva, 1, 0 ) >>, <<iif( lxProvExretgan, 1, 0 ) >>, <<lxProvCltipconv >>, <<"'" + this.FormatearTextoSql( lxProvCltipodoc ) + "'" >>, <<lxProvPnumero >>, <<"'" + this.FormatearTextoSql( lxProvTlfm ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProvClretsuss ) + "'" >>, <<"'" + this.ConvertirDateSql( lxProvPvhastagan ) + "'" >>, <<"'" + this.ConvertirDateSql( lxProvPvhastaiva ) + "'" >>, <<lxProvClnroiibb >>, <<"'" + this.FormatearTextoSql( lxProvClnrodoc ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProvPpiso ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProvClfax ) + "'" >>, <<lxProvClsitgan >>, <<lxProvClobjiva >>, <<"'" + this.FormatearTextoSql( lxProvClpageweb ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProvPdepto ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProvClretgan ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProvClretiva ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProvClsiprib ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProvClcuit ) + "'" >>, <<lxProvClcfi >>, <<"'" + this.FormatearTextoSql( lxProvClloc ) + "'" >>, <<iif( lxProvClemplead, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxProvRut ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProvClnom ) + "'" >>, <<lxProvPorcentc >>, <<"'" + this.FormatearTextoSql( lxProvClcp ) + "'" >>, <<iif( lxProvClsujvinc, 1, 0 ) >>, <<iif( lxProvAplicatc, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxProvClprv ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProvPpais ) + "'" >> )
		endtext
		loColeccion.cTabla = 'PROV' 
		loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		With this
			local lcValorClavePrimariaString as String
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcSentencia = this.ObtenerSentenciasInsertAuditoria()
			loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.Contacto
				if this.oEntidad.Contacto.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxContacto = loItem.Contacto
					lxNombre = loItem.Nombre
					lxTelefonos = loItem.Telefonos
					lxEmail = loItem.Email
					lxNotas = loItem.Notas
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ContProvdet("NROITEM","Concod","ConCon","CONNOM","CONTEL","CONMAIL","CONNOT" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxContacto ) + "'">>, <<"'" + this.FormatearTextoSql( lxNombre ) + "'">>, <<"'" + this.FormatearTextoSql( lxTelefonos ) + "'">>, <<"'" + this.FormatearTextoSql( lxEmail ) + "'">>, <<"'" + this.FormatearTextoSql( lxNotas ) + "'">> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.AgruPubliDetalle
				if this.oEntidad.AgruPubliDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxAgrupamiento_PK = loItem.Agrupamiento_PK
					lxAgrupamientodetalle = loItem.Agrupamientodetalle
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.AgruPubPRV("NROITEM","Codigo","Agrup","AgrupDes" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxAgrupamiento_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxAgrupamientodetalle ) + "'">> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.Retenciones
				if this.oEntidad.Retenciones.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxJurisdiccion_PK = loItem.Jurisdiccion_PK
					lxJurisdicciondetalle = loItem.Jurisdicciondetalle
					lxResolucion = loItem.Resolucion
					lxPorcentaje = loItem.Porcentaje
					lxFechaexpiracion = loItem.Fechaexpiracion
					lxExcluido = loItem.Excluido
					lxSedeextrajuris = loItem.Sedeextrajuris
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.RetProDet("NROITEM","Cod","jurisdicci","DesJur","Resol","porcen","FecExp","Excluido","SedeExtJur" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxJurisdiccion_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxJurisdicciondetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxResolucion ) + "'">>, <<lxPorcentaje>>, <<"'" + this.ConvertirDateSql( lxFechaexpiracion ) + "'">>, <<iif( lxExcluido, 1, 0 )>>, <<iif( lxSedeextrajuris, 1, 0 )>> ) 
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
			local  lxProvFectrans, lxProvFmodifw, lxProvFaltafw, lxProvFecexpo, lxProvFecimpo, lxProvCltpo, lxProvClpun4, lxProvClcan4, lxProvClpun1, lxProvClpun2, lxProvClpun3, lxProvClemail, lxProvUaltafw, lxProvValtafw, lxProvUmodifw, lxProvSmodifw, lxProvSaltafw, lxProvHoraimpo, lxProvHmodifw, lxProvHaltafw, lxProvVmodifw, lxProvEsttrans, lxProvBdaltafw, lxProvBdmodifw, lxProvZadsfw, lxProvDescfw, lxProvHoraexpo, lxProvTipagrupub, lxProvClmon1, lxProvTimestamp, lxProvClmon4, lxProvClmonto, lxProvClmon3, lxProvClmon2, lxProvInactivofw, lxProvCimagen, lxProvClcondpag, lxProvClcod, lxProvClobs, lxProvPcalle, lxProvCltlf, lxProvCliva, lxProvExretsuss, lxProvCllistpre, lxProvClas, lxProvClfecha, lxProvExretiva, lxProvExretgan, lxProvCltipconv, lxProvCltipodoc, lxProvPnumero, lxProvTlfm, lxProvClretsuss, lxProvPvhastagan, lxProvPvhastaiva, lxProvClnroiibb, lxProvClnrodoc, lxProvPpiso, lxProvClfax, lxProvClsitgan, lxProvClobjiva, lxProvClpageweb, lxProvPdepto, lxProvClretgan, lxProvClretiva, lxProvClsiprib, lxProvClcuit, lxProvClcfi, lxProvClloc, lxProvClemplead, lxProvRut, lxProvClnom, lxProvPorcentc, lxProvClcp, lxProvClsujvinc, lxProvAplicatc, lxProvClprv, lxProvPpais
				lxProvFectrans =  .Fechatransferencia			lxProvFmodifw =  .Fechamodificacionfw			lxProvFaltafw =  .Fechaaltafw			lxProvFecexpo =  .Fechaexpo			lxProvFecimpo =  .Fechaimpo			lxProvCltpo =  .Tipointerno			lxProvClpun4 =  .Formula5			lxProvClcan4 =  .Formula1			lxProvClpun1 =  .Formula2			lxProvClpun2 =  .Formula3			lxProvClpun3 =  .Formula4			lxProvClemail =  .Email			lxProvUaltafw =  .Usuarioaltafw			lxProvValtafw =  .Versionaltafw			lxProvUmodifw =  .Usuariomodificacionfw			lxProvSmodifw =  .Seriemodificacionfw			lxProvSaltafw =  .Seriealtafw			lxProvHoraimpo =  .Horaimpo			lxProvHmodifw =  .Horamodificacionfw			lxProvHaltafw =  .Horaaltafw			lxProvVmodifw =  .Versionmodificacionfw			lxProvEsttrans =  .Estadotransferencia			lxProvBdaltafw =  .Basededatosaltafw			lxProvBdmodifw =  .Basededatosmodificacionfw			lxProvZadsfw =  .Zadsfw			lxProvDescfw =  .Descripcionfw			lxProvHoraexpo =  .Horaexpo			lxProvTipagrupub =  .Tipoagrupamientopublicaciones			lxProvClmon1 =  .Sobreprecio2			lxProvTimestamp = goLibrerias.ObtenerTimestamp()			lxProvClmon4 =  .Sobreprecio5			lxProvClmonto =  .Sobreprecio1			lxProvClmon3 =  .Sobreprecio4			lxProvClmon2 =  .Sobreprecio3			lxProvInactivofw =  .Inactivofw			lxProvCimagen =  .Imagen			lxProvClcondpag =  upper( .CondicionDePago_PK ) 			lxProvClcod =  .Codigo			lxProvClobs =  .Observacion			lxProvPcalle =  .Calle			lxProvCltlf =  .Telefono			lxProvCliva =  .Situacionfiscal_PK 			lxProvExretsuss =  .Excluidoretencionsuss			lxProvCllistpre =  upper( .ListaDePrecio_PK ) 			lxProvClas =  upper( .Clasificacion_PK ) 			lxProvClfecha =  .Fechanacimiento			lxProvExretiva =  .Excluidoretencioniva			lxProvExretgan =  .Excluidoretencionganancias			lxProvCltipconv =  .Tipoconvenio			lxProvCltipodoc =  .Tipodocumento			lxProvPnumero =  .Numero			lxProvTlfm =  .Movil			lxProvClretsuss =  upper( .RetencionSuss_PK ) 			lxProvPvhastagan =  .Vigenciahastagan			lxProvPvhastaiva =  .Vigenciahastaiva			lxProvClnroiibb =  .Nroiibb			lxProvClnrodoc =  .Nrodocumento			lxProvPpiso =  .Piso			lxProvClfax =  .Fax			lxProvClsitgan =  .Situacionganancias			lxProvClobjiva =  .Objetoiva			lxProvClpageweb =  .Paginaweb			lxProvPdepto =  .Departamento			lxProvClretgan =  upper( .RetencionGanancias_PK ) 			lxProvClretiva =  upper( .RetencionIva_PK ) 			lxProvClsiprib =  upper( .CodigoSiprib_PK ) 			lxProvClcuit =  .Cuit			lxProvClcfi =  .Tipointerno2			lxProvClloc =  .Localidad			lxProvClemplead =  .Empleador			lxProvRut =  .Rut			lxProvClnom =  .Nombre			lxProvPorcentc =  .Tasaceroporcen			lxProvClcp =  .Codigopostal			lxProvClsujvinc =  .Sujetovinculado			lxProvAplicatc =  .Tasaceroaplica			lxProvClprv =  upper( .Provincia_PK ) 			lxProvPpais =  upper( .Pais_PK ) 
		endwith
		With this
			local llInsertarAuditoria as Boolean
			llInsertarAuditoria = (  .oEntidad.oAtributosAuditoria.INACTIVOFW != .oEntidad.INACTIVOFW or  .oEntidad.oAtributosAuditoria.Clasificacion != .oEntidad.Clasificacion_Pk or  .oEntidad.oAtributosAuditoria.TipoConvenio != .oEntidad.TipoConvenio or  .oEntidad.oAtributosAuditoria.NroIIBB != .oEntidad.NroIIBB or  .oEntidad.oAtributosAuditoria.RUT != .oEntidad.RUT )
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Clcod" = ] + lcValorClavePrimariaString  + [ and  PROV.CLCOD != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.PROV set "Fectrans" = <<"'" + this.ConvertirDateSql( lxProvFectrans ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxProvFmodifw ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxProvFaltafw ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxProvFecexpo ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxProvFecimpo ) + "'">>, "Cltpo" = <<lxProvCltpo>>, "Clpun4" = <<lxProvClpun4>>, "Clcan4" = <<lxProvClcan4>>, "Clpun1" = <<lxProvClpun1>>, "Clpun2" = <<lxProvClpun2>>, "Clpun3" = <<lxProvClpun3>>, "Clemail" = <<"'" + this.FormatearTextoSql( lxProvClemail ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxProvUaltafw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxProvValtafw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxProvUmodifw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxProvSmodifw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxProvSaltafw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxProvHoraimpo ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxProvHmodifw ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxProvHaltafw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxProvVmodifw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxProvEsttrans ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxProvBdaltafw ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxProvBdmodifw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxProvZadsfw ) + "'">>, "Descfw" = <<"'" + this.FormatearTextoSql( lxProvDescfw ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxProvHoraexpo ) + "'">>, "Tipagrupub" = <<lxProvTipagrupub>>, "Clmon1" = <<lxProvClmon1>>, "Timestamp" = <<lxProvTimestamp>>, "Clmon4" = <<lxProvClmon4>>, "Clmonto" = <<lxProvClmonto>>, "Clmon3" = <<lxProvClmon3>>, "Clmon2" = <<lxProvClmon2>>, "Inactivofw" = <<iif( lxProvInactivofw, 1, 0 )>>, "Cimagen" = <<"'" + this.FormatearTextoSql( lxProvCimagen ) + "'">>, "Clcondpag" = <<"'" + this.FormatearTextoSql( lxProvClcondpag ) + "'">>, "Clcod" = <<"'" + this.FormatearTextoSql( lxProvClcod ) + "'">>, "Clobs" = <<"'" + this.FormatearTextoSql( lxProvClobs ) + "'">>, "Pcalle" = <<"'" + this.FormatearTextoSql( lxProvPcalle ) + "'">>, "Cltlf" = <<"'" + this.FormatearTextoSql( lxProvCltlf ) + "'">>, "Cliva" = <<lxProvCliva>>, "Exretsuss" = <<iif( lxProvExretsuss, 1, 0 )>>, "Cllistpre" = <<"'" + this.FormatearTextoSql( lxProvCllistpre ) + "'">>, "Clas" = <<"'" + this.FormatearTextoSql( lxProvClas ) + "'">>, "Clfecha" = <<"'" + this.ConvertirDateSql( lxProvClfecha ) + "'">>, "Exretiva" = <<iif( lxProvExretiva, 1, 0 )>>, "Exretgan" = <<iif( lxProvExretgan, 1, 0 )>>, "Cltipconv" = <<lxProvCltipconv>>, "Cltipodoc" = <<"'" + this.FormatearTextoSql( lxProvCltipodoc ) + "'">>, "Pnumero" = <<lxProvPnumero>>, "Tlfm" = <<"'" + this.FormatearTextoSql( lxProvTlfm ) + "'">>, "Clretsuss" = <<"'" + this.FormatearTextoSql( lxProvClretsuss ) + "'">>, "Pvhastagan" = <<"'" + this.ConvertirDateSql( lxProvPvhastagan ) + "'">>, "Pvhastaiva" = <<"'" + this.ConvertirDateSql( lxProvPvhastaiva ) + "'">>, "Clnroiibb" = <<lxProvClnroiibb>>, "Clnrodoc" = <<"'" + this.FormatearTextoSql( lxProvClnrodoc ) + "'">>, "Ppiso" = <<"'" + this.FormatearTextoSql( lxProvPpiso ) + "'">>, "Clfax" = <<"'" + this.FormatearTextoSql( lxProvClfax ) + "'">>, "Clsitgan" = <<lxProvClsitgan>>, "Clobjiva" = <<lxProvClobjiva>>, "Clpageweb" = <<"'" + this.FormatearTextoSql( lxProvClpageweb ) + "'">>, "Pdepto" = <<"'" + this.FormatearTextoSql( lxProvPdepto ) + "'">>, "Clretgan" = <<"'" + this.FormatearTextoSql( lxProvClretgan ) + "'">>, "Clretiva" = <<"'" + this.FormatearTextoSql( lxProvClretiva ) + "'">>, "Clsiprib" = <<"'" + this.FormatearTextoSql( lxProvClsiprib ) + "'">>, "Clcuit" = <<"'" + this.FormatearTextoSql( lxProvClcuit ) + "'">>, "Clcfi" = <<lxProvClcfi>>, "Clloc" = <<"'" + this.FormatearTextoSql( lxProvClloc ) + "'">>, "Clemplead" = <<iif( lxProvClemplead, 1, 0 )>>, "Rut" = <<"'" + this.FormatearTextoSql( lxProvRut ) + "'">>, "Clnom" = <<"'" + this.FormatearTextoSql( lxProvClnom ) + "'">>, "Porcentc" = <<lxProvPorcentc>>, "Clcp" = <<"'" + this.FormatearTextoSql( lxProvClcp ) + "'">>, "Clsujvinc" = <<iif( lxProvClsujvinc, 1, 0 )>>, "Aplicatc" = <<iif( lxProvAplicatc, 1, 0 )>>, "Clprv" = <<"'" + this.FormatearTextoSql( lxProvClprv ) + "'">>, "Ppais" = <<"'" + this.FormatearTextoSql( lxProvPpais ) + "'">> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'PROV' 
		loColeccion.agregar( strtran(  lcSentencia, chr( 9 ), '' ) )
		If llInsertarAuditoria
			lcSentencia = this.ObtenerSentenciasInsertAuditoria()
			loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		EndIf
			loColeccion.Agregar([delete from ZooLogic.ContProvdet where "CONCOD" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.AgruPubPRV where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.RetProDet where "Cod" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.Contacto
				if this.oEntidad.Contacto.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxContacto = loItem.Contacto
					lxNombre = loItem.Nombre
					lxTelefonos = loItem.Telefonos
					lxEmail = loItem.Email
					lxNotas = loItem.Notas
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ContProvdet("NROITEM","Concod","ConCon","CONNOM","CONTEL","CONMAIL","CONNOT" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxContacto ) + "'">>, <<"'" + this.FormatearTextoSql( lxNombre ) + "'">>, <<"'" + this.FormatearTextoSql( lxTelefonos ) + "'">>, <<"'" + this.FormatearTextoSql( lxEmail ) + "'">>, <<"'" + this.FormatearTextoSql( lxNotas ) + "'">> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.AgruPubliDetalle
				if this.oEntidad.AgruPubliDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxAgrupamiento_PK = loItem.Agrupamiento_PK
					lxAgrupamientodetalle = loItem.Agrupamientodetalle
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.AgruPubPRV("NROITEM","Codigo","Agrup","AgrupDes" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxAgrupamiento_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxAgrupamientodetalle ) + "'">> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.Retenciones
				if this.oEntidad.Retenciones.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxJurisdiccion_PK = loItem.Jurisdiccion_PK
					lxJurisdicciondetalle = loItem.Jurisdicciondetalle
					lxResolucion = loItem.Resolucion
					lxPorcentaje = loItem.Porcentaje
					lxFechaexpiracion = loItem.Fechaexpiracion
					lxExcluido = loItem.Excluido
					lxSedeextrajuris = loItem.Sedeextrajuris
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.RetProDet("NROITEM","Cod","jurisdicci","DesJur","Resol","porcen","FecExp","Excluido","SedeExtJur" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxJurisdiccion_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxJurisdicciondetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxResolucion ) + "'">>, <<lxPorcentaje>>, <<"'" + this.ConvertirDateSql( lxFechaexpiracion ) + "'">>, <<iif( lxExcluido, 1, 0 )>>, <<iif( lxSedeextrajuris, 1, 0 )>> ) 
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

			lcFiltro = ["Clcod" = ] + lcValorClavePrimariaString  + [ and  PROV.CLCOD != '']
		loColeccion.Agregar( 'delete from ZooLogic.PROV where ' + lcFiltro )
			loColeccion.Agregar([delete from ZooLogic.ContProvdet where "CONCOD" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.AgruPubPRV where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.RetProDet where "Cod" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.cTabla = 'PROV' 
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

		with this.oEntidad
		
			.oCompDatosadicionalessiprib.lNuevo = .EsNuevo()
			.oCompDatosadicionalessiprib.lEdicion = .EsEdicion()
			.oCompDatosadicionalessiprib.lEliminar = .lEliminar
			.oCompDatosadicionalessiprib.lAnular = .lAnular
			loColSentencias = .oCompDatosadicionalessiprib.grabar()
			for each lcItem in loColSentencias
				this.colSentencias.Agregar( lcItem )
			endfor
			
		endwith
		
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ObtenerSentenciaActualizacionTimeStamp() As String
		local lnTimeStamp as integer, lcRetorno as string, lcUpdateRealTime as string
		with this.oEntidad
		
			lnTimeStamp = goLibrerias.ObtenerTimestamp()
			lcUpdateRealTime = ", "+this.obtenercampoentidad("fechamodificacionfw")+" = "+goServicios.Datos.ObtenerFechaFormateada(goServicios.Librerias.ObtenerFecha());
			+ ", "+this.obtenercampoentidad("horamodificacionfw")+" = '"+goServicios.Librerias.ObtenerHora()+"'"
			lcRetorno = [update ZooLogic.PROV set TimeStamp = ] + transform( lnTimeStamp ) + lcUpdateRealTime + [ where CLCOD = ] + "'" + this.FormatearTextoSql( .Codigo ) + "'" + [ and  PROV.CLCOD != ''] + goServicios.RealTime.ObtenerTagEstimulo( .cNombre )
		
		endwith
		return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function ObtenerCantidadRegistros() as integer
		local lnCantReg as integer
			local lcXml as string
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.PROV where  PROV.CLCOD != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.PROV where CLCOD = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  PROV.CLCOD != ''" )
			this.xmlacursor( lcXml, lcCursor )
		if reccount( lcCursor ) > 0
			lnTimeStamp = &lcCursor..Timestamp
		endif
		use in select( lcCursor )

		return lnTimeStamp 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirCabecera( tlLoguear as Boolean ) As Void
		local lcCursor as String, ldFecha as Date, lcHora as string, lcValorABuscar As String, lxValorClavePK As variant, lxValorClavePrimaria As variant, lcIdentificadorParaLoguear as string, lxPROVInactivoFW as variant, lxPROVCLAS as variant, lxPROVCLTIPCONV as variant, lxPROVCLNROIIBB as variant, lxPROVRUT as variant, lcMensajeExtra as String
		lcValorABuscar = ''
		lxValorClavePK = ''
		lcMensajeExtra = ''
		lcCursor = This.oEntidad.cPrefijoRecibir + 'PROVEEDOR'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.PROV Where CLCOD = ] + "'" + this.FormatearTextoSql( &lcCursor..CLCOD ) + "'", 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
					local llInsertarAuditoria as boolean
					llInsertarAuditoria = (  iif( isnull( curSeek.InactivoFW != &lcCursor..InactivoFW ), .F., curSeek.InactivoFW != &lcCursor..InactivoFW ) or  iif( isnull( curSeek.CLAS != &lcCursor..CLAS ), .F., curSeek.CLAS != &lcCursor..CLAS ) or  iif( isnull( curSeek.CLTIPCONV != &lcCursor..CLTIPCONV ), .F., curSeek.CLTIPCONV != &lcCursor..CLTIPCONV ) or  iif( isnull( curSeek.CLNROIIBB != &lcCursor..CLNROIIBB ), .F., curSeek.CLNROIIBB != &lcCursor..CLNROIIBB ) or  iif( isnull( curSeek.RUT != &lcCursor..RUT ), .F., curSeek.RUT != &lcCursor..RUT ) )
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					if this.oentidad.lActualizarSoloEquivalenciasDeLince
						local lcCadena as String, lnPos as integer
						lnPos = recno(lcCursor)
						afields( laEst, lcCursor )
						lcCadena = [Replace in &lcCursor ]
						if empty( this.oEntidad.CamposEquivalenciaLince )
							this.oEntidad.CamposEquivalenciaLince = this.oEntidad.ObtenerCamposSegunEquivalencia(@laEst)
						endif 
						lcCadena = lcCadena + this.oEntidad.CamposEquivalenciaLince
						lcCadena = lcCadena + [ for CLCOD= curseek.CLCOD]
						&lcCadena.
						select( lcCursor )
						go lnPos
					endif
					this.oConexion.EjecutarSql( [UPDATE ZooLogic.PROV set  FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, CLTPO = ] + transform( &lcCursor..CLTPO )+ [, CLPUN4 = ] + transform( &lcCursor..CLPUN4 )+ [, CLCAN4 = ] + transform( &lcCursor..CLCAN4 )+ [, CLPUN1 = ] + transform( &lcCursor..CLPUN1 )+ [, CLPUN2 = ] + transform( &lcCursor..CLPUN2 )+ [, CLPUN3 = ] + transform( &lcCursor..CLPUN3 )+ [, CLEMAIL = ] + "'" + this.FormatearTextoSql( &lcCursor..CLEMAIL ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, DescFW = ] + "'" + this.FormatearTextoSql( &lcCursor..DescFW ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, tipagrupub = ] + transform( &lcCursor..tipagrupub )+ [, CLMON1 = ] + transform( &lcCursor..CLMON1 )+ [, TIMESTAMP = ] + transform( &lcCursor..TIMESTAMP )+ [, CLMON4 = ] + transform( &lcCursor..CLMON4 )+ [, CLMONTO = ] + transform( &lcCursor..CLMONTO )+ [, CLMON3 = ] + transform( &lcCursor..CLMON3 )+ [, CLMON2 = ] + transform( &lcCursor..CLMON2 )+ [, InactivoFW = ] + Transform( iif( &lcCursor..InactivoFW, 1, 0 ))+ [, CIMAGEN = ] + "'" + this.FormatearTextoSql( &lcCursor..CIMAGEN ) + "'"+ [, CLCONDPAG = ] + "'" + this.FormatearTextoSql( &lcCursor..CLCONDPAG ) + "'"+ [, CLCOD = ] + "'" + this.FormatearTextoSql( &lcCursor..CLCOD ) + "'"+ [, CLOBS = ] + "'" + this.FormatearTextoSql( &lcCursor..CLOBS ) + "'"+ [, PCALLE = ] + "'" + this.FormatearTextoSql( &lcCursor..PCALLE ) + "'"+ [, CLTLF = ] + "'" + this.FormatearTextoSql( &lcCursor..CLTLF ) + "'"+ [, CLIVA = ] + transform( &lcCursor..CLIVA )+ [, EXRETSUSS = ] + Transform( iif( &lcCursor..EXRETSUSS, 1, 0 ))+ [, CLLISTPRE = ] + "'" + this.FormatearTextoSql( &lcCursor..CLLISTPRE ) + "'"+ [, CLAS = ] + "'" + this.FormatearTextoSql( &lcCursor..CLAS ) + "'"+ [, CLFECHA = ] + "'" + this.ConvertirDateSql( &lcCursor..CLFECHA ) + "'"+ [, EXRETIVA = ] + Transform( iif( &lcCursor..EXRETIVA, 1, 0 ))+ [, EXRETGAN = ] + Transform( iif( &lcCursor..EXRETGAN, 1, 0 ))+ [, CLTIPCONV = ] + transform( &lcCursor..CLTIPCONV )+ [, CLTIPODOC = ] + "'" + this.FormatearTextoSql( &lcCursor..CLTIPODOC ) + "'"+ [, PNUMERO = ] + transform( &lcCursor..PNUMERO )+ [, TLFM = ] + "'" + this.FormatearTextoSql( &lcCursor..TLFM ) + "'"+ [, CLRETSUSS = ] + "'" + this.FormatearTextoSql( &lcCursor..CLRETSUSS ) + "'"+ [, PVHastaGan = ] + "'" + this.ConvertirDateSql( &lcCursor..PVHastaGan ) + "'"+ [, PVHastaIva = ] + "'" + this.ConvertirDateSql( &lcCursor..PVHastaIva ) + "'"+ [, CLNROIIBB = ] + transform( &lcCursor..CLNROIIBB )+ [, CLNRODOC = ] + "'" + this.FormatearTextoSql( &lcCursor..CLNRODOC ) + "'"+ [, PPISO = ] + "'" + this.FormatearTextoSql( &lcCursor..PPISO ) + "'"+ [, CLFAX = ] + "'" + this.FormatearTextoSql( &lcCursor..CLFAX ) + "'"+ [, CLSITGAN = ] + transform( &lcCursor..CLSITGAN )+ [, CLOBJIVA = ] + transform( &lcCursor..CLOBJIVA )+ [, CLPAGEWEB = ] + "'" + this.FormatearTextoSql( &lcCursor..CLPAGEWEB ) + "'"+ [, PDEPTO = ] + "'" + this.FormatearTextoSql( &lcCursor..PDEPTO ) + "'"+ [, CLRETGAN = ] + "'" + this.FormatearTextoSql( &lcCursor..CLRETGAN ) + "'"+ [, CLRETIVA = ] + "'" + this.FormatearTextoSql( &lcCursor..CLRETIVA ) + "'"+ [, CLSIPRIB = ] + "'" + this.FormatearTextoSql( &lcCursor..CLSIPRIB ) + "'"+ [, CLCUIT = ] + "'" + this.FormatearTextoSql( &lcCursor..CLCUIT ) + "'"+ [, CLCFI = ] + transform( &lcCursor..CLCFI )+ [, CLLOC = ] + "'" + this.FormatearTextoSql( &lcCursor..CLLOC ) + "'"+ [, CLEMPLEAD = ] + Transform( iif( &lcCursor..CLEMPLEAD, 1, 0 ))+ [, RUT = ] + "'" + this.FormatearTextoSql( &lcCursor..RUT ) + "'"+ [, CLNOM = ] + "'" + this.FormatearTextoSql( &lcCursor..CLNOM ) + "'"+ [, PorcenTC = ] + transform( &lcCursor..PorcenTC )+ [, CLCP = ] + "'" + this.FormatearTextoSql( &lcCursor..CLCP ) + "'"+ [, CLSujVinc = ] + Transform( iif( &lcCursor..CLSujVinc, 1, 0 ))+ [, AplicaTC = ] + Transform( iif( &lcCursor..AplicaTC, 1, 0 ))+ [, CLPRV = ] + "'" + this.FormatearTextoSql( &lcCursor..CLPRV ) + "'"+ [, PPAIS = ] + "'" + this.FormatearTextoSql( &lcCursor..PPAIS ) + "'" + [ Where CLCOD = ] + "'" + this.FormatearTextoSql( &lcCursor..CLCOD ) + "'" )
					lcCampo = lcCursor + '.' + this.cCampoCodigoWH
					this.AgregarMensajeWebHook( 'MODIFICAR', &lcCampo )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
					if llInsertarAuditoria
						lcSentencia = this.ObtenerSentenciasInsertAuditoria( lcCursor )
						this.oConexion.EjecutarSql( lcSentencia )
					EndIf
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
				endIf
			else
				Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
				Text to lcCampos noShow
					 FECTRANS, FMODIFW, FALTAFW, FECEXPO, FECIMPO, CLTPO, CLPUN4, CLCAN4, CLPUN1, CLPUN2, CLPUN3, CLEMAIL, UALTAFW, VALTAFW, UMODIFW, SMODIFW, SALTAFW, HORAIMPO, HMODIFW, HALTAFW, VMODIFW, ESTTRANS, BDALTAFW, BDMODIFW, ZADSFW, DescFW, HORAEXPO, tipagrupub, CLMON1, TIMESTAMP, CLMON4, CLMONTO, CLMON3, CLMON2, InactivoFW, CIMAGEN, CLCONDPAG, CLCOD, CLOBS, PCALLE, CLTLF, CLIVA, EXRETSUSS, CLLISTPRE, CLAS, CLFECHA, EXRETIVA, EXRETGAN, CLTIPCONV, CLTIPODOC, PNUMERO, TLFM, CLRETSUSS, PVHastaGan, PVHastaIva, CLNROIIBB, CLNRODOC, PPISO, CLFAX, CLSITGAN, CLOBJIVA, CLPAGEWEB, PDEPTO, CLRETGAN, CLRETIVA, CLSIPRIB, CLCUIT, CLCFI, CLLOC, CLEMPLEAD, RUT, CLNOM, PorcenTC, CLCP, CLSujVinc, AplicaTC, CLPRV, PPAIS
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + transform( &lcCursor..CLTPO ) + ',' + transform( &lcCursor..CLPUN4 ) + ',' + transform( &lcCursor..CLCAN4 )
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..CLPUN1 ) + ',' + transform( &lcCursor..CLPUN2 ) + ',' + transform( &lcCursor..CLPUN3 ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLEMAIL ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..DescFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + transform( &lcCursor..tipagrupub ) + ',' + transform( &lcCursor..CLMON1 ) + ',' + transform( &lcCursor..TIMESTAMP ) + ',' + transform( &lcCursor..CLMON4 )
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..CLMONTO ) + ',' + transform( &lcCursor..CLMON3 ) + ',' + transform( &lcCursor..CLMON2 ) + ',' + Transform( iif( &lcCursor..InactivoFW, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..CIMAGEN ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLCONDPAG ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLCOD ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLOBS ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..PCALLE ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLTLF ) + "'" + ',' + transform( &lcCursor..CLIVA ) + ',' + Transform( iif( &lcCursor..EXRETSUSS, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLLISTPRE ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLAS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..CLFECHA ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + Transform( iif( &lcCursor..EXRETIVA, 1, 0 )) + ',' + Transform( iif( &lcCursor..EXRETGAN, 1, 0 )) + ',' + transform( &lcCursor..CLTIPCONV ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLTIPODOC ) + "'" + ',' + transform( &lcCursor..PNUMERO ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..TLFM ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLRETSUSS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..PVHastaGan ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..PVHastaIva ) + "'" + ',' + transform( &lcCursor..CLNROIIBB ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLNRODOC ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..PPISO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLFAX ) + "'" + ',' + transform( &lcCursor..CLSITGAN ) + ',' + transform( &lcCursor..CLOBJIVA ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLPAGEWEB ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..PDEPTO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLRETGAN ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLRETIVA ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLSIPRIB ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLCUIT ) + "'" + ',' + transform( &lcCursor..CLCFI ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLLOC ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + Transform( iif( &lcCursor..CLEMPLEAD, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..RUT ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLNOM ) + "'" + ',' + transform( &lcCursor..PorcenTC ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLCP ) + "'" + ',' + Transform( iif( &lcCursor..CLSujVinc, 1, 0 )) + ',' + Transform( iif( &lcCursor..AplicaTC, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLPRV ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..PPAIS ) + "'"
lcValoresCampos = substr(lcValoresCampos,2) 

				this.oConexion.EjecutarSql( [Insert into ZooLogic.PROV ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
				lcSentencia = this.ObtenerSentenciasInsertAuditoria( lcCursor )
				this.oConexion.EjecutarSql( lcSentencia )
				lcCampo = lcCursor + '.' + this.cCampoCodigoWH
				this.AgregarMensajeWebHook( 'INGRESAR', &lcCampo )
				this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'PROVEEDOR'
		if This.ActualizaEnRecepcion()
			if !This.oEntidad.lActualizarSoloEquivalenciasDeLince
				Local lcIn as String, lcCantRegistros as Integer
				Select( lcCursor )
				Count to lcCantRegistros
				If lcCantRegistros > 0
					lcIn = This.ObtenerInSqlServer( lcCursor, 'CLCOD','C')
					lnFragmento = goRegistry.nucleo.cantidadDeElementosEnSentenciaInSQL
					loIn = this.ObtenerColeccionInSqlServer( lcCursor,'','CLCOD')
					llEjecutaEnTransaccion = loIn.count > 0
					if llEjecutaEnTransaccion
						this.oConexion.EjecutarSQL( 'BEGIN TRANSACTION' )
					endif
					for i = 1 to loIn.count step lnFragmento
						lcIn = this.ObtenerFragmentoColeccionInSqlServer( loIn, i, lnFragmento )
					this.oConexion.EjecutarSql( [Delete From ZooLogic.ContProvdet Where CONCOD] + lcIn  )
					this.oConexion.EjecutarSql( [Delete From ZooLogic.AgruPubPRV Where Codigo] + lcIn  )
					this.oConexion.EjecutarSql( [Delete From ZooLogic.RetProDet Where Cod] + lcIn  )
					endfor
					if llEjecutaEnTransaccion
						this.oConexion.EjecutarSQL( 'COMMIT TRANSACTION' )
					endif
				EndIf
			endif
			lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMCONTACTOPROV'
			Select * From &lcDetalle into cursor cDetallesExistentes ;
				where CONCOD in ( select CLCOD from &lcCursor )
			select cDetallesExistentes
			Scan All
				Text to lcCamposInsert noShow
					"NROITEM","Concod","ConCon","CONNOM","CONTEL","CONMAIL","CONNOT"
				endText
				this.oConexion.EjecutarSql( [Insert into ZooLogic.ContProvdet ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Concod     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ConCon     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CONNOM     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CONTEL     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CONMAIL    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CONNOT     ) + "'" + ' )'  )
				select cDetallesExistentes
			EndScan
			Use in select( 'cDetallesExistentes' )
			lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMAGRUPAPUBLICPRV'
			Select * From &lcDetalle into cursor cDetallesExistentes ;
				where Codigo in ( select CLCOD from &lcCursor )
			select cDetallesExistentes
			Scan All
				Text to lcCamposInsert noShow
					"NROITEM","Codigo","Agrup","AgrupDes"
				endText
				this.oConexion.EjecutarSql( [Insert into ZooLogic.AgruPubPRV ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Codigo     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Agrup      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.AgrupDes   ) + "'" + ' )'  )
				select cDetallesExistentes
			EndScan
			Use in select( 'cDetallesExistentes' )
			lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMRETENCIONES'
			Select * From &lcDetalle into cursor cDetallesExistentes ;
				where Cod in ( select CLCOD from &lcCursor )
			select cDetallesExistentes
			Scan All
				Text to lcCamposInsert noShow
					"NROITEM","Cod","jurisdicci","DesJur","Resol","porcen","FecExp","Excluido","SedeExtJur"
				endText
				this.oConexion.EjecutarSql( [Insert into ZooLogic.RetProDet ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Cod        ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.jurisdicci ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.DesJur     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Resol      ) + "'" + ',' + transform( cDetallesExistentes.porcen     ) + ',' + "'" + this.ConvertirDateSql( cDetallesExistentes.FecExp     ) + "'" + ',' + Transform( iif( cDetallesExistentes.Excluido  , 1, 0 )) + ',' + Transform( iif( cDetallesExistentes.SedeExtJur, 1, 0 )) + ' )'  )
				select cDetallesExistentes
			EndScan
			Use in select( 'cDetallesExistentes' )
			Use in select( 'cExistentes' )
		endif
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
	protected Function AgregarMensajeWebHook( tcEvento as String, tcCodigo as String ) As Void

		if ( alltrim( tcEvento ) = 'MODIFICAR' and this.oEntidad.lWHModificar ) or ( alltrim( tcEvento ) = 'INGRESAR' and this.oEntidad.lWHIngresar )
			goServicios.WebHook.AgregarMensajeALaCola( tcEvento, tcCodigo, this.oEntidad.cNombre )
		endif
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function EnviarColaWebHook() As Void
		goServicios.WebHook.EnviarColaDeMensajes( this.oEntidad.cNombre )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EsAliasDeProceso( tcAlias As String, tcPrefijo as string ) As Boolean
		local llRetorno as Boolean, lcAlias as String, lcPrefijo As String
		llRetorno = .F.
		lcAlias = upper( alltrim( tcAlias ) )
		lcPrefijo = upper( alltrim( tcPrefijo ) )
		Do Case
			Case  lcAlias == lcPrefijo + 'PROVEEDOR'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'PROVEEDOR_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'PROVEEDOR_CLOBS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMCONTACTOPROV'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMAGRUPAPUBLICPRV'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMRETENCIONES'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_PROV')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'PROVEEDOR'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..CLCOD
		llCondicion = isnull( lxVar )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad PROVEEDOR. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'PROVEEDOR'
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
			lcCursor = This.oEntidad.cPrefijoRecibir + 'PROVEEDOR'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  CLFECHA   
		* Validar ANTERIORES A 1/1/1753  PVHastaGan
		* Validar ANTERIORES A 1/1/1753  PVHastaIva
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_PROV') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_PROV
Create Table ZooLogic.TablaTrabajo_PROV ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fectrans" datetime  null, 
"fmodifw" datetime  null, 
"faltafw" datetime  null, 
"fecexpo" datetime  null, 
"fecimpo" datetime  null, 
"cltpo" numeric( 1, 0 )  null, 
"clpun4" numeric( 1, 0 )  null, 
"clcan4" numeric( 1, 0 )  null, 
"clpun1" numeric( 1, 0 )  null, 
"clpun2" numeric( 1, 0 )  null, 
"clpun3" numeric( 1, 0 )  null, 
"clemail" char( 250 )  null, 
"ualtafw" char( 100 )  null, 
"valtafw" char( 13 )  null, 
"umodifw" char( 100 )  null, 
"smodifw" char( 7 )  null, 
"saltafw" char( 7 )  null, 
"horaimpo" char( 8 )  null, 
"hmodifw" char( 8 )  null, 
"haltafw" char( 8 )  null, 
"vmodifw" char( 13 )  null, 
"esttrans" char( 20 )  null, 
"bdaltafw" char( 8 )  null, 
"bdmodifw" char( 8 )  null, 
"zadsfw" varchar(max)  null, 
"descfw" char( 200 )  null, 
"horaexpo" char( 8 )  null, 
"tipagrupub" numeric( 1, 0 )  null, 
"clmon1" numeric( 15, 2 )  null, 
"timestamp" numeric( 20, 0 )  null, 
"clmon4" numeric( 15, 2 )  null, 
"clmonto" numeric( 15, 2 )  null, 
"clmon3" numeric( 15, 2 )  null, 
"clmon2" numeric( 15, 2 )  null, 
"inactivofw" bit  null, 
"cimagen" char( 180 )  null, 
"clcondpag" char( 5 )  null, 
"clcod" char( 10 )  null, 
"clobs" varchar(max)  null, 
"pcalle" char( 70 )  null, 
"cltlf" char( 30 )  null, 
"cliva" numeric( 2, 0 )  null, 
"exretsuss" bit  null, 
"cllistpre" char( 6 )  null, 
"clas" char( 10 )  null, 
"clfecha" datetime  null, 
"exretiva" bit  null, 
"exretgan" bit  null, 
"cltipconv" numeric( 1, 0 )  null, 
"cltipodoc" char( 2 )  null, 
"pnumero" numeric( 5, 0 )  null, 
"tlfm" char( 30 )  null, 
"clretsuss" char( 10 )  null, 
"pvhastagan" datetime  null, 
"pvhastaiva" datetime  null, 
"clnroiibb" numeric( 11, 0 )  null, 
"clnrodoc" char( 10 )  null, 
"ppiso" char( 3 )  null, 
"clfax" char( 60 )  null, 
"clsitgan" numeric( 1, 0 )  null, 
"clobjiva" numeric( 1, 0 )  null, 
"clpageweb" char( 60 )  null, 
"pdepto" char( 3 )  null, 
"clretgan" char( 10 )  null, 
"clretiva" char( 10 )  null, 
"clsiprib" char( 20 )  null, 
"clcuit" char( 15 )  null, 
"clcfi" numeric( 1, 0 )  null, 
"clloc" char( 70 )  null, 
"clemplead" bit  null, 
"rut" char( 12 )  null, 
"clnom" char( 60 )  null, 
"porcentc" numeric( 6, 2 )  null, 
"clcp" char( 8 )  null, 
"clsujvinc" bit  null, 
"aplicatc" bit  null, 
"clprv" char( 2 )  null, 
"ppais" char( 3 )  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_PROV' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_PROV' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'PROVEEDOR'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		with loManejador
			if this.oEntidad.VerificarContexto( 'CB' )
			else
				.AgregarMapeo('Nrolinea','Nrolinea')
			endif
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('cltpo','cltpo')
			.AgregarMapeo('clpun4','clpun4')
			.AgregarMapeo('clcan4','clcan4')
			.AgregarMapeo('clpun1','clpun1')
			.AgregarMapeo('clpun2','clpun2')
			.AgregarMapeo('clpun3','clpun3')
			.AgregarMapeo('clemail','clemail')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('descfw','descfw')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('tipagrupub','tipagrupub')
			.AgregarMapeo('clmon1','clmon1')
			.AgregarMapeo('timestamp','timestamp')
			.AgregarMapeo('clmon4','clmon4')
			.AgregarMapeo('clmonto','clmonto')
			.AgregarMapeo('clmon3','clmon3')
			.AgregarMapeo('clmon2','clmon2')
			.AgregarMapeo('inactivofw','inactivofw')
			.AgregarMapeo('cimagen','cimagen')
			.AgregarMapeo('clcondpag','clcondpag')
			.AgregarMapeo('clcod','clcod')
			.AgregarMapeo('clobs','clobs')
			.AgregarMapeo('pcalle','pcalle')
			.AgregarMapeo('cltlf','cltlf')
			.AgregarMapeo('cliva','cliva')
			.AgregarMapeo('exretsuss','exretsuss')
			.AgregarMapeo('cllistpre','cllistpre')
			.AgregarMapeo('clas','clas')
			.AgregarMapeo('clfecha','clfecha')
			.AgregarMapeo('exretiva','exretiva')
			.AgregarMapeo('exretgan','exretgan')
			.AgregarMapeo('cltipconv','cltipconv')
			.AgregarMapeo('cltipodoc','cltipodoc')
			.AgregarMapeo('pnumero','pnumero')
			.AgregarMapeo('tlfm','tlfm')
			.AgregarMapeo('clretsuss','clretsuss')
			.AgregarMapeo('pvhastagan','pvhastagan')
			.AgregarMapeo('pvhastaiva','pvhastaiva')
			.AgregarMapeo('clnroiibb','clnroiibb')
			.AgregarMapeo('clnrodoc','clnrodoc')
			.AgregarMapeo('ppiso','ppiso')
			.AgregarMapeo('clfax','clfax')
			.AgregarMapeo('clsitgan','clsitgan')
			.AgregarMapeo('clobjiva','clobjiva')
			.AgregarMapeo('clpageweb','clpageweb')
			.AgregarMapeo('pdepto','pdepto')
			.AgregarMapeo('clretgan','clretgan')
			.AgregarMapeo('clretiva','clretiva')
			.AgregarMapeo('clsiprib','clsiprib')
			.AgregarMapeo('clcuit','clcuit')
			.AgregarMapeo('clcfi','clcfi')
			.AgregarMapeo('clloc','clloc')
			.AgregarMapeo('clemplead','clemplead')
			.AgregarMapeo('rut','rut')
			.AgregarMapeo('clnom','clnom')
			.AgregarMapeo('porcentc','porcentc')
			.AgregarMapeo('clcp','clcp')
			.AgregarMapeo('clsujvinc','clsujvinc')
			.AgregarMapeo('aplicatc','aplicatc')
			.AgregarMapeo('clprv','clprv')
			.AgregarMapeo('ppais','ppais')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_PROV'
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
		Local lcCabecera1 as string, lcCabecera2 as string, lcCabecera3 as string, lcCabecera4 as string, lcCabecera5 as string, lcCabecera6 as string, lcCabecera7 as string, lcCabecera8 as string, lcCabecera9 as string
		lcCabecera1 = "replace( newId(),'-','1' )"
		lcCabecera2 = "'" + this.ConvertirDateSql( golibrerias.obtenerfechaformateada( golibrerias.obtenerfecha() ) ) + "'"
		lcCabecera3 = "'" + this.FormatearTextoSql( golibrerias.obtenerhora() ) + "'"
		lcCabecera4 = "'" + this.FormatearTextoSql( alltrim( _screen.zoo.app.cSerie ) ) + "'"
		lcCabecera5 = "'" + this.FormatearTextoSql( goServicios.Seguridad.cUsuarioLogueado ) + "'"
		lcCabecera6 = "'" + this.FormatearTextoSql( this.oEntidad.ObtenerNombre() ) + "'"
		lcCabecera7 = "'" + this.FormatearTextoSql( alltrim('1.00') ) + "'"
		lcCabecera8 = "'" + this.FormatearTextoSql( _Screen.zoo.app.obtenerversion() ) + "'"
		lcCabecera9 = iif( .F., 1, 0 )
		
		Text to lcCadena noshow textmerge
			CREATE TRIGGER ZooLogic.DELETE_<<lcTabla>>
				ON ZooLogic.<<lcTabla>>
				AFTER DELETE
			As
			Begin
				insert into ZooLogic.ADT_PROV ( "ADT_Cod","ADT_Fecha","ADT_Hora","ADT_Serie","ADT_Usr","ADT_Ent","ADT_Comp","ADT_ADN","ADT_Vers","ADT_Ext","CLCOD","Inactivofw","Clas","Cltipconv","Clnroiibb","Rut" ) 
					Select <<lcCabecera1>>, <<lcCabecera2>>, <<lcCabecera3>>, <<lcCabecera4>>, <<lcCabecera5>>, <<lcCabecera6>>, case when funciones.empty( d.DescFw ) = 1 then 'IMPORTACION' else d.descFw end, <<lcCabecera7>>, <<lcCabecera8>>, <<lcCabecera9>>, d.Clcod,Isnull( d.Inactivofw,t.Inactivofw),Isnull( d.Clas,t.Clas),Isnull( d.Cltipconv,t.Cltipconv),Isnull( d.Clnroiibb,t.Clnroiibb),Isnull( d.Rut,t.Rut)
						from ZooLogic.PROV t inner join deleted d 
							 on t.CLCOD = d.CLCOD
					where ( d.InactivoFW is not null and d.InactivoFW <> t.InactivoFW ) or ( d.CLAS is not null and d.CLAS <> t.CLAS ) or ( d.CLTIPCONV is not null and d.CLTIPCONV <> t.CLTIPCONV ) or ( d.CLNROIIBB is not null and d.CLNROIIBB <> t.CLNROIIBB ) or ( d.RUT is not null and d.RUT <> t.RUT )
				Update t Set t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.CLTPO = isnull( d.CLTPO, t.CLTPO ),t.CLPUN4 = isnull( d.CLPUN4, t.CLPUN4 ),t.CLCAN4 = isnull( d.CLCAN4, t.CLCAN4 ),t.CLPUN1 = isnull( d.CLPUN1, t.CLPUN1 ),t.CLPUN2 = isnull( d.CLPUN2, t.CLPUN2 ),t.CLPUN3 = isnull( d.CLPUN3, t.CLPUN3 ),t.CLEMAIL = isnull( d.CLEMAIL, t.CLEMAIL ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.DESCFW = isnull( d.DESCFW, t.DESCFW ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.TIPAGRUPUB = isnull( d.TIPAGRUPUB, t.TIPAGRUPUB ),t.CLMON1 = isnull( d.CLMON1, t.CLMON1 ),t.TIMESTAMP = isnull( d.TIMESTAMP, t.TIMESTAMP ),t.CLMON4 = isnull( d.CLMON4, t.CLMON4 ),t.CLMONTO = isnull( d.CLMONTO, t.CLMONTO ),t.CLMON3 = isnull( d.CLMON3, t.CLMON3 ),t.CLMON2 = isnull( d.CLMON2, t.CLMON2 ),t.INACTIVOFW = isnull( d.INACTIVOFW, t.INACTIVOFW ),t.CIMAGEN = isnull( d.CIMAGEN, t.CIMAGEN ),t.CLCONDPAG = isnull( d.CLCONDPAG, t.CLCONDPAG ),t.CLCOD = isnull( d.CLCOD, t.CLCOD ),t.CLOBS = isnull( d.CLOBS, t.CLOBS ),t.PCALLE = isnull( d.PCALLE, t.PCALLE ),t.CLTLF = isnull( d.CLTLF, t.CLTLF ),t.CLIVA = isnull( d.CLIVA, t.CLIVA ),t.EXRETSUSS = isnull( d.EXRETSUSS, t.EXRETSUSS ),t.CLLISTPRE = isnull( d.CLLISTPRE, t.CLLISTPRE ),t.CLAS = isnull( d.CLAS, t.CLAS ),t.CLFECHA = isnull( d.CLFECHA, t.CLFECHA ),t.EXRETIVA = isnull( d.EXRETIVA, t.EXRETIVA ),t.EXRETGAN = isnull( d.EXRETGAN, t.EXRETGAN ),t.CLTIPCONV = isnull( d.CLTIPCONV, t.CLTIPCONV ),t.CLTIPODOC = isnull( d.CLTIPODOC, t.CLTIPODOC ),t.PNUMERO = isnull( d.PNUMERO, t.PNUMERO ),t.TLFM = isnull( d.TLFM, t.TLFM ),t.CLRETSUSS = isnull( d.CLRETSUSS, t.CLRETSUSS ),t.PVHASTAGAN = isnull( d.PVHASTAGAN, t.PVHASTAGAN ),t.PVHASTAIVA = isnull( d.PVHASTAIVA, t.PVHASTAIVA ),t.CLNROIIBB = isnull( d.CLNROIIBB, t.CLNROIIBB ),t.CLNRODOC = isnull( d.CLNRODOC, t.CLNRODOC ),t.PPISO = isnull( d.PPISO, t.PPISO ),t.CLFAX = isnull( d.CLFAX, t.CLFAX ),t.CLSITGAN = isnull( d.CLSITGAN, t.CLSITGAN ),t.CLOBJIVA = isnull( d.CLOBJIVA, t.CLOBJIVA ),t.CLPAGEWEB = isnull( d.CLPAGEWEB, t.CLPAGEWEB ),t.PDEPTO = isnull( d.PDEPTO, t.PDEPTO ),t.CLRETGAN = isnull( d.CLRETGAN, t.CLRETGAN ),t.CLRETIVA = isnull( d.CLRETIVA, t.CLRETIVA ),t.CLSIPRIB = isnull( d.CLSIPRIB, t.CLSIPRIB ),t.CLCUIT = isnull( d.CLCUIT, t.CLCUIT ),t.CLCFI = isnull( d.CLCFI, t.CLCFI ),t.CLLOC = isnull( d.CLLOC, t.CLLOC ),t.CLEMPLEAD = isnull( d.CLEMPLEAD, t.CLEMPLEAD ),t.RUT = isnull( d.RUT, t.RUT ),t.CLNOM = isnull( d.CLNOM, t.CLNOM ),t.PORCENTC = isnull( d.PORCENTC, t.PORCENTC ),t.CLCP = isnull( d.CLCP, t.CLCP ),t.CLSUJVINC = isnull( d.CLSUJVINC, t.CLSUJVINC ),t.APLICATC = isnull( d.APLICATC, t.APLICATC ),t.CLPRV = isnull( d.CLPRV, t.CLPRV ),t.PPAIS = isnull( d.PPAIS, t.PPAIS )
					from ZooLogic.PROV t inner join deleted d 
							 on t.CLCOD = d.CLCOD
				-- Fin Updates
				insert into ZooLogic.ADT_PROV ( "ADT_Cod","ADT_Fecha","ADT_Hora","ADT_Serie","ADT_Usr","ADT_Ent","ADT_Comp","ADT_ADN","ADT_Vers","ADT_Ext","CLCOD","Inactivofw","Clas","Cltipconv","Clnroiibb","Rut" ) 
					Select <<lcCabecera1>>, <<lcCabecera2>>, <<lcCabecera3>>, <<lcCabecera4>>, <<lcCabecera5>>, <<lcCabecera6>>, case when funciones.empty( d.DescFw ) = 1 then 'IMPORTACION' else d.descFw end, <<lcCabecera7>>, <<lcCabecera8>>, <<lcCabecera9>>, d.Clcod,isnull( d.INACTIVOFW,0),isnull( d.CLAS,''),isnull( d.CLTIPCONV,0),isnull( d.CLNROIIBB,0),isnull( d.RUT,'')
						From deleted d left join ZooLogic.PROV pk 
							 on d.CLCOD = pk.CLCOD
						Where pk.CLCOD Is Null 
				insert into ZooLogic.PROV(Fectrans,Fmodifw,Faltafw,Fecexpo,Fecimpo,Cltpo,Clpun4,Clcan4,Clpun1,Clpun2,Clpun3,Clemail,Ualtafw,Valtafw,Umodifw,Smodifw,Saltafw,Horaimpo,Hmodifw,Haltafw,Vmodifw,Esttrans,Bdaltafw,Bdmodifw,Zadsfw,Descfw,Horaexpo,Tipagrupub,Clmon1,Timestamp,Clmon4,Clmonto,Clmon3,Clmon2,Inactivofw,Cimagen,Clcondpag,Clcod,Clobs,Pcalle,Cltlf,Cliva,Exretsuss,Cllistpre,Clas,Clfecha,Exretiva,Exretgan,Cltipconv,Cltipodoc,Pnumero,Tlfm,Clretsuss,Pvhastagan,Pvhastaiva,Clnroiibb,Clnrodoc,Ppiso,Clfax,Clsitgan,Clobjiva,Clpageweb,Pdepto,Clretgan,Clretiva,Clsiprib,Clcuit,Clcfi,Clloc,Clemplead,Rut,Clnom,Porcentc,Clcp,Clsujvinc,Aplicatc,Clprv,Ppais)
					Select isnull( d.FECTRANS,''),isnull( d.FMODIFW,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FECEXPO,''),isnull( d.FECIMPO,''),isnull( d.CLTPO,0),isnull( d.CLPUN4,0),isnull( d.CLCAN4,0),isnull( d.CLPUN1,0),isnull( d.CLPUN2,0),isnull( d.CLPUN3,0),isnull( d.CLEMAIL,''),isnull( d.UALTAFW,''),isnull( d.VALTAFW,''),isnull( d.UMODIFW,''),isnull( d.SMODIFW,''),isnull( d.SALTAFW,''),isnull( d.HORAIMPO,''),isnull( d.HMODIFW,''),convert( char(8), getdate(), 108 ),isnull( d.VMODIFW,''),isnull( d.ESTTRANS,''),isnull( d.BDALTAFW,''),isnull( d.BDMODIFW,''),isnull( d.ZADSFW,''),isnull( d.DESCFW,''),isnull( d.HORAEXPO,''),isnull( d.TIPAGRUPUB,0),isnull( d.CLMON1,0),isnull( d.TIMESTAMP,0),isnull( d.CLMON4,0),isnull( d.CLMONTO,0),isnull( d.CLMON3,0),isnull( d.CLMON2,0),isnull( d.INACTIVOFW,0),isnull( d.CIMAGEN,''),isnull( d.CLCONDPAG,''),isnull( d.CLCOD,''),isnull( d.CLOBS,''),isnull( d.PCALLE,''),isnull( d.CLTLF,''),isnull( d.CLIVA,0),isnull( d.EXRETSUSS,0),isnull( d.CLLISTPRE,''),isnull( d.CLAS,''),isnull( d.CLFECHA,''),isnull( d.EXRETIVA,0),isnull( d.EXRETGAN,0),isnull( d.CLTIPCONV,0),isnull( d.CLTIPODOC,''),isnull( d.PNUMERO,0),isnull( d.TLFM,''),isnull( d.CLRETSUSS,''),isnull( d.PVHASTAGAN,''),isnull( d.PVHASTAIVA,''),isnull( d.CLNROIIBB,0),isnull( d.CLNRODOC,''),isnull( d.PPISO,''),isnull( d.CLFAX,''),isnull( d.CLSITGAN,0),isnull( d.CLOBJIVA,0),isnull( d.CLPAGEWEB,''),isnull( d.PDEPTO,''),isnull( d.CLRETGAN,''),isnull( d.CLRETIVA,''),isnull( d.CLSIPRIB,''),isnull( d.CLCUIT,''),isnull( d.CLCFI,0),isnull( d.CLLOC,''),isnull( d.CLEMPLEAD,0),isnull( d.RUT,''),isnull( d.CLNOM,''),isnull( d.PORCENTC,0),isnull( d.CLCP,''),isnull( d.CLSUJVINC,0),isnull( d.APLICATC,0),isnull( d.CLPRV,''),isnull( d.PPAIS,'')
						From deleted d left join ZooLogic.PROV pk 
							 on d.CLCOD = pk.CLCOD
						Where pk.CLCOD Is Null 
				-- Fin Inserts
			End
		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_ContProvdet( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_PROV_ContProvdet
ON ZooLogic.TablaTrabajo_PROV_ContProvdet
AFTER DELETE
As
Begin
Update t Set 
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.CONCOD = isnull( d.CONCOD, t.CONCOD ),
t.CONCON = isnull( d.CONCON, t.CONCON ),
t.CONNOM = isnull( d.CONNOM, t.CONNOM ),
t.CONTEL = isnull( d.CONTEL, t.CONTEL ),
t.CONMAIL = isnull( d.CONMAIL, t.CONMAIL ),
t.CONNOT = isnull( d.CONNOT, t.CONNOT )
from ZooLogic.ContProvdet t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.ContProvdet
( 
"NROITEM",
"CONCOD",
"CONCON",
"CONNOM",
"CONTEL",
"CONMAIL",
"CONNOT"
 )
Select 
d.NROITEM,
d.CONCOD,
d.CONCON,
d.CONNOM,
d.CONTEL,
d.CONMAIL,
d.CONNOT
From deleted d left join ZooLogic.ContProvdet pk 
 on d.CODIGO = pk.CODIGO
Where pk.CODIGO Is Null 
-- Fin Inserts
End

		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_AgruPubPRV( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_PROV_AgruPubPRV
ON ZooLogic.TablaTrabajo_PROV_AgruPubPRV
AFTER DELETE
As
Begin
Update t Set 
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.CODIGO = isnull( d.CODIGO, t.CODIGO ),
t.AGRUP = isnull( d.AGRUP, t.AGRUP ),
t.AGRUPDES = isnull( d.AGRUPDES, t.AGRUPDES )
from ZooLogic.AgruPubPRV t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.AgruPubPRV
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
From deleted d left join ZooLogic.AgruPubPRV pk 
 on d.CODIGO = pk.CODIGO
Where pk.CODIGO Is Null 
-- Fin Inserts
End

		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_RetProDet( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_PROV_RetProDet
ON ZooLogic.TablaTrabajo_PROV_RetProDet
AFTER DELETE
As
Begin
Update t Set 
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.COD = isnull( d.COD, t.COD ),
t.JURISDICCI = isnull( d.JURISDICCI, t.JURISDICCI ),
t.DESJUR = isnull( d.DESJUR, t.DESJUR ),
t.RESOL = isnull( d.RESOL, t.RESOL ),
t.PORCEN = isnull( d.PORCEN, t.PORCEN ),
t.FECEXP = isnull( d.FECEXP, t.FECEXP ),
t.EXCLUIDO = isnull( d.EXCLUIDO, t.EXCLUIDO ),
t.SEDEEXTJUR = isnull( d.SEDEEXTJUR, t.SEDEEXTJUR )
from ZooLogic.RetProDet t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.RetProDet
( 
"NROITEM",
"COD",
"JURISDICCI",
"DESJUR",
"RESOL",
"PORCEN",
"FECEXP",
"EXCLUIDO",
"SEDEEXTJUR"
 )
Select 
d.NROITEM,
d.COD,
d.JURISDICCI,
d.DESJUR,
d.RESOL,
d.PORCEN,
d.FECEXP,
d.EXCLUIDO,
d.SEDEEXTJUR
From deleted d left join ZooLogic.RetProDet pk 
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_PROV') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_PROV
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_PROVEEDOR' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_PROVEEDOR.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_PROVEEDOR.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_PROVEEDOR.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_PROVEEDOR.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_PROVEEDOR.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Tipointerno = nvl( c_PROVEEDOR.Tipointerno, 0 )
					.Formula5 = nvl( c_PROVEEDOR.Formula5, 0 )
					.Formula1 = nvl( c_PROVEEDOR.Formula1, 0 )
					.Formula2 = nvl( c_PROVEEDOR.Formula2, 0 )
					.Formula3 = nvl( c_PROVEEDOR.Formula3, 0 )
					.Formula4 = nvl( c_PROVEEDOR.Formula4, 0 )
					.Email = nvl( c_PROVEEDOR.Email, [] )
					.Usuarioaltafw = nvl( c_PROVEEDOR.Usuarioaltafw, [] )
					.Versionaltafw = nvl( c_PROVEEDOR.Versionaltafw, [] )
					.Usuariomodificacionfw = nvl( c_PROVEEDOR.Usuariomodificacionfw, [] )
					.Seriemodificacionfw = nvl( c_PROVEEDOR.Seriemodificacionfw, [] )
					.Seriealtafw = nvl( c_PROVEEDOR.Seriealtafw, [] )
					.Horaimpo = nvl( c_PROVEEDOR.Horaimpo, [] )
					.Horamodificacionfw = nvl( c_PROVEEDOR.Horamodificacionfw, [] )
					.Horaaltafw = nvl( c_PROVEEDOR.Horaaltafw, [] )
					.Versionmodificacionfw = nvl( c_PROVEEDOR.Versionmodificacionfw, [] )
					.Estadotransferencia = nvl( c_PROVEEDOR.Estadotransferencia, [] )
					.Basededatosaltafw = nvl( c_PROVEEDOR.Basededatosaltafw, [] )
					.Basededatosmodificacionfw = nvl( c_PROVEEDOR.Basededatosmodificacionfw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Descripcionfw = nvl( c_PROVEEDOR.Descripcionfw, [] )
					.Horaexpo = nvl( c_PROVEEDOR.Horaexpo, [] )
					.Tipoagrupamientopublicaciones = nvl( c_PROVEEDOR.Tipoagrupamientopublicaciones, 0 )
					.Sobreprecio2 = nvl( c_PROVEEDOR.Sobreprecio2, 0 )
					.Timestamp = nvl( c_PROVEEDOR.Timestamp, 0 )
					.Sobreprecio5 = nvl( c_PROVEEDOR.Sobreprecio5, 0 )
					.Sobreprecio1 = nvl( c_PROVEEDOR.Sobreprecio1, 0 )
					.Sobreprecio4 = nvl( c_PROVEEDOR.Sobreprecio4, 0 )
					.Sobreprecio3 = nvl( c_PROVEEDOR.Sobreprecio3, 0 )
					.Inactivofw = nvl( c_PROVEEDOR.Inactivofw, .F. )
					.Imagen = nvl( c_PROVEEDOR.Imagen, [] )
					.Condiciondepago_PK =  nvl( c_PROVEEDOR.Condiciondepago, [] )
					.Codigo = nvl( c_PROVEEDOR.Codigo, [] )
					lcValor = This.ObtenerMemo( 'c_Observacion')
					.Observacion = lcValor 
					.Calle = nvl( c_PROVEEDOR.Calle, [] )
					.Telefono = nvl( c_PROVEEDOR.Telefono, [] )
					.Situacionfiscal_PK =  nvl( c_PROVEEDOR.Situacionfiscal, 0 )
					.Excluidoretencionsuss = nvl( c_PROVEEDOR.Excluidoretencionsuss, .F. )
					.Listadeprecio_PK =  nvl( c_PROVEEDOR.Listadeprecio, [] )
					.Clasificacion_PK =  nvl( c_PROVEEDOR.Clasificacion, [] )
					.Contacto.Limpiar()
					.Contacto.SetearEsNavegacion( .lProcesando )
					.Contacto.Cargar()
					.Fechanacimiento = GoLibrerias.ObtenerFechaFormateada( nvl( c_PROVEEDOR.Fechanacimiento, ctod( '  /  /    ' ) ) )
					.Excluidoretencioniva = nvl( c_PROVEEDOR.Excluidoretencioniva, .F. )
					.Excluidoretencionganancias = nvl( c_PROVEEDOR.Excluidoretencionganancias, .F. )
					.Tipoconvenio = nvl( c_PROVEEDOR.Tipoconvenio, 0 )
					if !.lEsSubEntidad
					.Agrupublidetalle.Limpiar()
					.Agrupublidetalle.SetearEsNavegacion( .lProcesando )
					.Agrupublidetalle.Cargar()
					endif
					.Tipodocumento = nvl( c_PROVEEDOR.Tipodocumento, [] )
					.Numero = nvl( c_PROVEEDOR.Numero, 0 )
					.Movil = nvl( c_PROVEEDOR.Movil, [] )
					.Retencionsuss_PK =  nvl( c_PROVEEDOR.Retencionsuss, [] )
					.Vigenciahastagan = GoLibrerias.ObtenerFechaFormateada( nvl( c_PROVEEDOR.Vigenciahastagan, ctod( '  /  /    ' ) ) )
					.Vigenciahastaiva = GoLibrerias.ObtenerFechaFormateada( nvl( c_PROVEEDOR.Vigenciahastaiva, ctod( '  /  /    ' ) ) )
					.Nroiibb = nvl( c_PROVEEDOR.Nroiibb, 0 )
					.Nrodocumento = nvl( c_PROVEEDOR.Nrodocumento, [] )
					.Piso = nvl( c_PROVEEDOR.Piso, [] )
					.Fax = nvl( c_PROVEEDOR.Fax, [] )
					.Situacionganancias = nvl( c_PROVEEDOR.Situacionganancias, 0 )
					.Objetoiva = nvl( c_PROVEEDOR.Objetoiva, 0 )
					.Retenciones.Limpiar()
					.Retenciones.SetearEsNavegacion( .lProcesando )
					.Retenciones.Cargar()
					.Paginaweb = nvl( c_PROVEEDOR.Paginaweb, [] )
					.Departamento = nvl( c_PROVEEDOR.Departamento, [] )
					.Retencionganancias_PK =  nvl( c_PROVEEDOR.Retencionganancias, [] )
					.Retencioniva_PK =  nvl( c_PROVEEDOR.Retencioniva, [] )
					.Codigosiprib_PK =  nvl( c_PROVEEDOR.Codigosiprib, [] )
					.Cuit = nvl( c_PROVEEDOR.Cuit, [] )
					.Tipointerno2 = nvl( c_PROVEEDOR.Tipointerno2, 0 )
					.Localidad = nvl( c_PROVEEDOR.Localidad, [] )
					.Empleador = nvl( c_PROVEEDOR.Empleador, .F. )
					.Rut = nvl( c_PROVEEDOR.Rut, [] )
					.Nombre = nvl( c_PROVEEDOR.Nombre, [] )
					.Tasaceroporcen = nvl( c_PROVEEDOR.Tasaceroporcen, 0 )
					.Codigopostal = nvl( c_PROVEEDOR.Codigopostal, [] )
					.Sujetovinculado = nvl( c_PROVEEDOR.Sujetovinculado, .F. )
					.Tasaceroaplica = nvl( c_PROVEEDOR.Tasaceroaplica, .F. )
					.Provincia_PK =  nvl( c_PROVEEDOR.Provincia, [] )
					.Pais_PK =  nvl( c_PROVEEDOR.Pais, [] )
					Select c_PROVEEDOR
					scatter name This.oEntidad.oAtributosAuditoria
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
	*-----------------------------------------------------------------------------------------
	function ObtenerSentenciasInsertAuditoria( tcCursor as string ) as String
		if empty( tcCursor )
			local lcDescripcionFW as string
			lcDescripcionFW = this.oEntidad.DescripcionFW
		else
			local lcDescripcionFW as string
			lcDescripcionFW = &tcCursor..DescFW
		endif
		Local lcCabecera1 as string, lcCabecera2 as string, lcCabecera3 as string, lcCabecera4 as string, lcCabecera5 as string, lcCabecera6 as string, lcCabecera7 as string, lcCabecera8 as string, lcCabecera9 as string;
		, lcCabecera10 as string
		lcCabecera1 = "'" + this.FormatearTextoSql( goLibrerias.ObtenerGuidPk() ) + "'"
		lcCabecera2 = "'" + this.ConvertirDateSql( golibrerias.obtenerfechaformateada( golibrerias.obtenerfecha() ) ) + "'"
		lcCabecera3 = "'" + this.FormatearTextoSql( golibrerias.obtenerhora() ) + "'"
		lcCabecera4 = "'" + this.FormatearTextoSql( alltrim( _screen.zoo.app.cSerie ) ) + "'"
		lcCabecera5 = "'" + this.FormatearTextoSql( goServicios.Seguridad.cUsuarioLogueado ) + "'"
		lcCabecera6 = "'" + this.FormatearTextoSql( this.oEntidad.ObtenerNombre() ) + "'"
		lcCabecera7 = "'" + this.FormatearTextoSql( lcDescripcionFW ) + "'"
		lcCabecera8 = "'" + this.FormatearTextoSql( alltrim('1.00') ) + "'"
		lcCabecera9 = "'" + this.FormatearTextoSql( _Screen.zoo.app.obtenerversion() ) + "'"
		lcCabecera10 = iif( .F., 1, 0 )
		
		local lxValorClavePrimaria as variant
		if empty( tcCursor )
			lxValorClavePrimaria = this.oEntidad.CODIGO
			Local lcEntidad1 as string, lcEntidad2 as string, lcEntidad3 as string, lcEntidad4 as string, lcEntidad5 as string, lcEntidad6 as string
			lcEntidad1 = "'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'"
			lcEntidad2 = iif( this.oEntidad.Inactivofw, 1, 0 )
			lcEntidad3 = "'" + this.FormatearTextoSql( this.oEntidad.Clasificacion_pk ) + "'"
			lcEntidad4 = transform( this.oEntidad.Tipoconvenio )
			lcEntidad5 = transform( this.oEntidad.Nroiibb )
			lcEntidad6 = "'" + this.FormatearTextoSql( this.oEntidad.Rut ) + "'"
			
		else
			lxValorClavePrimaria = &tcCursor..CLCOD
			Local lcEntidad1 as string, lcEntidad2 as string, lcEntidad3 as string, lcEntidad4 as string, lcEntidad5 as string, lcEntidad6 as string
			lcEntidad1 = "'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'"
			lcEntidad2 = iif( &tcCursor..Inactivofw, 1, 0 )
			lcEntidad3 = "'" + this.FormatearTextoSql( &tcCursor..Clas ) + "'"
			lcEntidad4 = transform( &tcCursor..Cltipconv )
			lcEntidad5 = transform( &tcCursor..Clnroiibb )
			lcEntidad6 = "'" + this.FormatearTextoSql( &tcCursor..Rut ) + "'"
			
		endif
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.ADT_PROV ( "ADT_Cod","ADT_Fecha","ADT_Hora","ADT_Serie","ADT_Usr","ADT_Ent","ADT_Comp","ADT_ADN","ADT_Vers","ADT_Ext","CLCOD","Inactivofw","Clas","Cltipconv","Clnroiibb","Rut" ) values ( <<lcCabecera1>>, <<lcCabecera2>>, <<lcCabecera3>>, <<lcCabecera4>>, <<lcCabecera5>>, <<lcCabecera6>>, <<lcCabecera7>>, <<lcCabecera8>>, <<lcCabecera9>>, <<lcCabecera10>>, <<lcEntidad1>>, <<lcEntidad2>>, <<lcEntidad3>>, <<lcEntidad4>>, <<lcEntidad5>>, <<lcEntidad6>> ) 
			endtext
		return lcSentencia
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function ActualizarLosNROItemDeLosDetalles() as void
		local loDetalle as object, loItem as object, lnContadorNroItem as integer, lnIndex as integer
		
		loDetalle = this.oEntidad.Contacto
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

		loDetalle = this.oEntidad.Retenciones
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
		return c_PROVEEDOR.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.PROV' )
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
								from ZooLogic.PROV 
								Where   PROV.CLCOD != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "PROV", "", lcCursor, set("Datasession") )
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
			"Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Cltpo" as "Tipointerno", "Clpun4" as "Formula5", "Clcan4" as "Formula1", "Clpun1" as "Formula2", "Clpun2" as "Formula3", "Clpun3" as "Formula4", "Clemail" as "Email", "Ualtafw" as "Usuarioaltafw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Haltafw" as "Horaaltafw", "Vmodifw" as "Versionmodificacionfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Zadsfw" as "Zadsfw", "Descfw" as "Descripcionfw", "Horaexpo" as "Horaexpo", "Tipagrupub" as "Tipoagrupamientopublicaciones", "Clmon1" as "Sobreprecio2", "Timestamp" as "Timestamp", "Clmon4" as "Sobreprecio5", "Clmonto" as "Sobreprecio1", "Clmon3" as "Sobreprecio4", "Clmon2" as "Sobreprecio3", "Inactivofw" as "Inactivofw", "Cimagen" as "Imagen", "Clcondpag" as "Condiciondepago", "Clcod" as "Codigo", "Clobs" as "Observacion", "Pcalle" as "Calle", "Cltlf" as "Telefono", "Cliva" as "Situacionfiscal", "Exretsuss" as "Excluidoretencionsuss", "Cllistpre" as "Listadeprecio", "Clas" as "Clasificacion", "Clfecha" as "Fechanacimiento", "Exretiva" as "Excluidoretencioniva", "Exretgan" as "Excluidoretencionganancias", "Cltipconv" as "Tipoconvenio", "Cltipodoc" as "Tipodocumento", "Pnumero" as "Numero", "Tlfm" as "Movil", "Clretsuss" as "Retencionsuss", "Pvhastagan" as "Vigenciahastagan", "Pvhastaiva" as "Vigenciahastaiva", "Clnroiibb" as "Nroiibb", "Clnrodoc" as "Nrodocumento", "Ppiso" as "Piso", "Clfax" as "Fax", "Clsitgan" as "Situacionganancias", "Clobjiva" as "Objetoiva", "Clpageweb" as "Paginaweb", "Pdepto" as "Departamento", "Clretgan" as "Retencionganancias", "Clretiva" as "Retencioniva", "Clsiprib" as "Codigosiprib", "Clcuit" as "Cuit", "Clcfi" as "Tipointerno2", "Clloc" as "Localidad", "Clemplead" as "Empleador", "Rut" as "Rut", "Clnom" as "Nombre", "Porcentc" as "Tasaceroporcen", "Clcp" as "Codigopostal", "Clsujvinc" as "Sujetovinculado", "Aplicatc" as "Tasaceroaplica", "Clprv" as "Provincia", "Ppais" as "Pais"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.PROV 
								Where   PROV.CLCOD != ''
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
	Tabla = 'PROV'
	Filtro = " PROV.CLCOD != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " PROV.CLCOD != ''"
	AnchoCampo = 13
	Caracteres = 13
	nrodecolumnas = 0
	signopregunta = .T.
	signopregunta2 = .t.
	TablaAuxiliar = .f.
	cOrden = ""
	FiltroSubEntidad = ' ( PROV.InactivoFW = 0)'

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
	<row entidad="PROVEEDOR                               " atributo="FECHATRANSFERENCIA                      " tabla="PROV           " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha de novedad                                                                                                                                                " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="FECHAMODIFICACIONFW                     " tabla="PROV           " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="FECHAALTAFW                             " tabla="PROV           " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="FECHAEXPO                               " tabla="PROV           " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="FECHAIMPO                               " tabla="PROV           " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="TIPOINTERNO                             " tabla="PROV           " campo="CLTPO     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="3                                                                                                                                                                                                                                                             " obligatorio="false" admitebusqueda="0" etiqueta="Tipo                                                                                                                                                            " dominio="COMBO                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="4" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="FORMULA5                                " tabla="PROV           " campo="CLPUN4    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="FORMULA                       " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="9" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="FORMULA1                                " tabla="PROV           " campo="CLCAN4    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="FORMULA                       " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="1" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="FORMULA2                                " tabla="PROV           " campo="CLPUN1    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="FORMULA                       " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="3" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="FORMULA3                                " tabla="PROV           " campo="CLPUN2    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="FORMULA                       " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="5" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="FORMULA4                                " tabla="PROV           " campo="CLPUN3    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="FORMULA                       " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="7" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="EMAIL                                   " tabla="PROV           " campo="CLEMAIL   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="250" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="28" etiqueta="Email                                                                                                                                                           " dominio="MAIL                          " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="USUARIOALTAFW                           " tabla="PROV           " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="VERSIONALTAFW                           " tabla="PROV           " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="USUARIOMODIFICACIONFW                   " tabla="PROV           " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="SERIEMODIFICACIONFW                     " tabla="PROV           " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="SERIEALTAFW                             " tabla="PROV           " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="HORAIMPO                                " tabla="PROV           " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="HORAMODIFICACIONFW                      " tabla="PROV           " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="HORAALTAFW                              " tabla="PROV           " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="VERSIONMODIFICACIONFW                   " tabla="PROV           " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="ESTADOTRANSFERENCIA                     " tabla="PROV           " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado de novedad                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="BASEDEDATOSALTAFW                       " tabla="PROV           " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="PROV           " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="ZADSFW                                  " tabla="PROV           " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="DESCRIPCIONFW                           " tabla="PROV           " campo="DESCFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="200" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="HORAEXPO                                " tabla="PROV           " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="TIPOAGRUPAMIENTOPUBLICACIONES           " tabla="PROV           " campo="TIPAGRUPUB" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="SOBREPRECIO2                            " tabla="PROV           " campo="CLMON1    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Lista 2                                                                                                                                                         " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="2" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="TIMESTAMP                               " tabla="PROV           " campo="TIMESTAMP " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="SOBREPRECIO5                            " tabla="PROV           " campo="CLMON4    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Lista 5                                                                                                                                                         " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="8" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="SOBREPRECIO1                            " tabla="PROV           " campo="CLMONTO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Lista 1                                                                                                                                                         " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="SOBREPRECIO4                            " tabla="PROV           " campo="CLMON3    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Lista 4                                                                                                                                                         " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="6" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="SOBREPRECIO3                            " tabla="PROV           " campo="CLMON2    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Lista 3                                                                                                                                                         " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="4" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="INACTIVOFW                              " tabla="PROV           " campo="INACTIVOFW" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Inactivo                                                                                                                                                        " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="IMAGEN                                  " tabla="PROV           " campo="CIMAGEN   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="180" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="34" etiqueta="Archivo                                                                                                                                                         " dominio="IMAGENCONRUTADINAMICA         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="3" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="CONDICIONDEPAGO                         " tabla="PROV           " campo="CLCONDPAG " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CONDICIONDEPAGO                         " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="Condición de pago                                                                                                                                               " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="5" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="CODIGO                                  " tabla="PROV           " campo="CLCOD     " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="2" etiqueta="Código                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="OBSERVACION                             " tabla="PROV           " campo="CLOBS     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="402" etiqueta="Observaciones                                                                                                                                                   " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="6" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="CALLE                                   " tabla="PROV           " campo="PCALLE    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="70" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="6" etiqueta="Calle                                                                                                                                                           " dominio="DIRECCION                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="TELEFONO                                " tabla="PROV           " campo="CLTLF     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="22" etiqueta="Teléfono                                                                                                                                                        " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="SITUACIONFISCAL                         " tabla="PROV           " campo="CLIVA     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="SITUACIONFISCAL                         " tipodato="N         " longitud="2" decimales="0" valorsugerido="1                                                                                                                                                                                                                                                             " obligatorio="false" admitebusqueda="404" etiqueta="Situación fiscal                                                                                                                                                " dominio="COMBOTABLA                    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="EXCLUIDORETENCIONSUSS                   " tabla="PROV           " campo="EXRETSUSS " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="406" etiqueta="Excluido retención SUSS                                                                                                                                         " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="7" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="LISTADEPRECIO                           " tabla="PROV           " campo="CLLISTPRE " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="LISTADEPRECIOS                          " tipodato="C         " longitud="6" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="408" etiqueta="Lista de precios                                                                                                                                                " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="5" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="CLASIFICACION                           " tabla="PROV           " campo="CLAS      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CLASIFICACIONPROVEEDOR                  " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="32" etiqueta="Clasificación                                                                                                                                                   " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="4" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="CONTACTO                                " tabla="CONTPROVDET    " campo="CONCOD    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="410" etiqueta="Contactos                                                                                                                                                       " dominio="DETALLEITEMCONTACTOPROV       " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="6" orden="1" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="FECHANACIMIENTO                         " tabla="PROV           " campo="CLFECHA   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="36" etiqueta="Fecha de nacimiento                                                                                                                                             " dominio="FECHALARGACALENDARIO          " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="3" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="EXCLUIDORETENCIONIVA                    " tabla="PROV           " campo="EXRETIVA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="412" etiqueta="Excluido retención IVA                                                                                                                                          " dominio="CheckConFecha                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="6" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="EXCLUIDORETENCIONGANANCIAS              " tabla="PROV           " campo="EXRETGAN  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="414" etiqueta="Excluido retención Ganancias                                                                                                                                    " dominio="CheckConFecha                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="4" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="TIPOCONVENIO                            " tabla="PROV           " campo="CLTIPCONV " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="416" etiqueta="Tipo de convenio                                                                                                                                                " dominio="CONVENIOCONNUMEROPROV         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="2" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="AGRUPUBLIDETALLE                        " tabla="AGRUPUBPRV     " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Agrupamientos                                                                                                                                                   " dominio="DETALLEITEMAGRUPAPUBLICPRV    " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="1" alta="false" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="FECHADEALTA                             " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha de alta                                                                                                                                                   " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="0" orden="2" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="TIPODOCUMENTO                           " tabla="PROV           " campo="CLTIPODOC " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="418" etiqueta="Tipo documento                                                                                                                                                  " dominio="DOCUMENTO                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="4" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="NUMERO                                  " tabla="PROV           " campo="PNUMERO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="8" etiqueta="Altura                                                                                                                                                          " dominio="DIRECCION                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="99999                    " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="MOVIL                                   " tabla="PROV           " campo="TLFM      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="24" etiqueta="Teléfono móvil                                                                                                                                                  " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="SITFISCALURUGUAY                        " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="2                                                                                                                                                                                                                                                             " obligatorio="false" admitebusqueda="420" etiqueta="Situación del proveedor                                                                                                                                         " dominio="COMBOXML                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="RETENCIONSUSS                           " tabla="PROV           " campo="CLRETSUSS " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="IMPUESTO                                " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="422" etiqueta="Retención SUSS                                                                                                                                                  " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="7" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="VIGENCIAHASTAGAN                        " tabla="PROV           " campo="PVHASTAGAN" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="8" etiqueta="Vigencia Fecha de Ganancia                                                                                                                                      " dominio="CheckConFecha                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="4" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="VIGENCIAHASTAIVA                        " tabla="PROV           " campo="PVHASTAIVA" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="8" etiqueta="Vigencia Fecha de Iva                                                                                                                                           " dominio="CheckConFecha                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="6" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="NROIIBB                                 " tabla="PROV           " campo="CLNROIIBB " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="11" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="424" etiqueta="Nro. IIBB                                                                                                                                                       " dominio="CONVENIOCONNUMEROPROV         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="2" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="FECHAULTIMAMODIFICACION                 " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Ultima Modificación                                                                                                                                             " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="0" orden="3" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="NRODOCUMENTO                            " tabla="PROV           " campo="CLNRODOC  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="426" etiqueta="Número documento                                                                                                                                                " dominio="DOCUMENTO                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="4" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="PISO                                    " tabla="PROV           " campo="PPISO     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="3" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="10" etiqueta="Piso                                                                                                                                                            " dominio="DIRECCION                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="FAX                                     " tabla="PROV           " campo="CLFAX     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="26" etiqueta="Fax                                                                                                                                                             " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="SITUACIONGANANCIAS                      " tabla="PROV           " campo="CLSITGAN  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="428" etiqueta="Situación                                                                                                                                                       " dominio="COMBOXML                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="4" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="OBJETOIVA                               " tabla="PROV           " campo="CLOBJIVA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="430" etiqueta="Actividad                                                                                                                                                       " dominio="COMBOXML                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="6" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="RETENCIONES                             " tabla="RETPRODET      " campo="COD       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="432" etiqueta="Retenciones                                                                                                                                                     " dominio="DETALLEITEMRETENCIONES        " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="2" orden="3" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="PAGINAWEB                               " tabla="PROV           " campo="CLPAGEWEB " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="30" etiqueta="Sitio web                                                                                                                                                       " dominio="WEB                           " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="DEPARTAMENTO                            " tabla="PROV           " campo="PDEPTO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="3" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="12" etiqueta="Departamento                                                                                                                                                    " dominio="DIRECCION                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="RETENCIONGANANCIAS                      " tabla="PROV           " campo="CLRETGAN  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="IMPUESTO                                " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="434" etiqueta="Retención Ganancias                                                                                                                                             " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="4" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="RETENCIONIVA                            " tabla="PROV           " campo="CLRETIVA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="IMPUESTO                                " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="436" etiqueta="Retención Iva                                                                                                                                                   " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="6" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="CODIGOSIPRIB                            " tabla="PROV           " campo="CLSIPRIB  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="DATOSADICIONALESSIPRIB                  " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="438" etiqueta="IIBB Santa Fe SIPRIB                                                                                                                                            " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="2" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="CUIT                                    " tabla="PROV           " campo="CLCUIT    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="440" etiqueta="CUIT                                                                                                                                                            " dominio="CUITBUSQUEDA                  " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="99-99999999-9            " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="TIPOINTERNO2                            " tabla="PROV           " campo="CLCFI     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="1                                                                                                                                                                                                                                                             " obligatorio="false" admitebusqueda="0" etiqueta="Cliente Frecuente Importante                                                                                                                                    " dominio="SINOGENERICO                  " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="5" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="LOCALIDAD                               " tabla="PROV           " campo="CLLOC     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="70" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="14" etiqueta="Localidad                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="EMPLEADOR                               " tabla="PROV           " campo="CLEMPLEAD " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="442" etiqueta="Empleador                                                                                                                                                       " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="1" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="RUT                                     " tabla="PROV           " campo="RUT       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="12" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="16" etiqueta="R.U.T.                                                                                                                                                          " dominio="RUT                           " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="NOMBRE                                  " tabla="PROV           " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="4" etiqueta="Nombre                                                                                                                                                          " dominio="TEXTOBUSQUEDA                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="5" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="TASACEROPORCEN                          " tabla="PROV           " campo="PORCENTC  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="6" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="444" etiqueta="IIBB Mendoza con certificado tasa cero                                                                                                                          " dominio="NUMERICOCHECK                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="999.99                   " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="2" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="CODIGOPOSTAL                            " tabla="PROV           " campo="CLCP      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="16" etiqueta="Código postal                                                                                                                                                   " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="SUJETOVINCULADO                         " tabla="PROV           " campo="CLSUJVINC " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="446" etiqueta="Sujeto vinculado                                                                                                                                                " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="1" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="TASACEROAPLICA                          " tabla="PROV           " campo="APLICATC  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="448" etiqueta="Aplica                                                                                                                                                          " dominio="NUMERICOCHECK                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="2" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="PROVINCIA                               " tabla="PROV           " campo="CLPRV     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="PROVINCIA                               " tipodato="C         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="18" etiqueta="Provincia                                                                                                                                                       " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="PAIS                                    " tabla="PROV           " campo="PPAIS     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="PAISES                                  " tipodato="C         " longitud="3" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="20" etiqueta="País                                                                                                                                                            " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="8" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONDICIONDEPAGO                         " atributo="DESCRIPCION                             " tabla="CONDPAGO       " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="401" etiqueta="Detalle Con.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CONDPAGO On PROV.CLCONDPAG = CONDPAGO.CLCOD And  CONDPAGO.CLCOD != ''                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SITUACIONFISCAL                         " atributo="DESCRIPCION                             " tabla="SITFISCAL      " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="405" etiqueta="Detalle Sit.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join SITFISCAL On PROV.CLIVA = SITFISCAL.Codigo And  SITFISCAL.CODIGO != 0                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADEPRECIOS                          " atributo="NOMBRE                                  " tabla="LPRECIO        " campo="LPR_NOMBRE" claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="409" etiqueta="Detalle Lis.                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join LPRECIO On PROV.CLLISTPRE = LPRECIO.LPR_NUMERO And  LPRECIO.LPR_NUMERO != ''                                                                                                                                                                       " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLASIFICACIONPROVEEDOR                  " atributo="DESCRIPCION                             " tabla="CLASPROV       " campo="CLADES    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="33" etiqueta="Detalle Cla.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CLASPROV On PROV.CLAS = CLASPROV.CLACOD And  CLASPROV.CLACOD != ''                                                                                                                                                                                 " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPUESTO                                " atributo="DESCRIPCION                             " tabla="IMPUESTO       " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="423" etiqueta="Detalle Ret.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join IMPUESTO On PROV.CLRETSUSS = IMPUESTO.codigo And  IMPUESTO.CODIGO != ''                                                                                                                                                                            " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPUESTO                                " atributo="DESCRIPCION                             " tabla="IMPUESTO       " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="435" etiqueta="Detalle Ret.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join IMPUESTO On PROV.CLRETGAN = IMPUESTO.codigo And  IMPUESTO.CODIGO != ''                                                                                                                                                                             " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPUESTO                                " atributo="DESCRIPCION                             " tabla="IMPUESTO       " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="437" etiqueta="Detalle Ret.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join IMPUESTO On PROV.CLRETIVA = IMPUESTO.codigo And  IMPUESTO.CODIGO != ''                                                                                                                                                                             " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DATOSADICIONALESSIPRIB                  " atributo="DESCRIPCION                             " tabla="SIPRIBDATADIC  " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="15" decimales="0" valorsugerido="Código SIPRIB                                                                                                                                                                                                                                                 " obligatorio="false" admitebusqueda="439" etiqueta="Detalle IIB.                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join SIPRIBDATADIC On PROV.CLSIPRIB = SIPRIBDATADIC.Codigo And  SIPRIBDATADIC.CODIGO != ''                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVINCIA                               " atributo="DESCRIPCION                             " tabla="PROVINCI       " campo="PRV_DES   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="19" etiqueta="Detalle Pro.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join PROVINCI On PROV.CLPRV = PROVINCI.PRV_COD And  PROVINCI.PRV_COD != ''                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PAISES                                  " atributo="DESCRIPCION                             " tabla="PAISES         " campo="PDES      " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="21" etiqueta="Detalle Paí.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join PAISES On PROV.PPAIS = PAISES.pcod And  PAISES.PCOD != ''                                                                                                                                                                                          " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
</VFPData>

			Endtext

			text to .cEstructuraDetalle noshow 
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
	<row entidad="ITEMCONTACTOPROV                        " atributo="NOMBRE                                  " tabla="CONTPROVDET    " campo="CONNOM    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="201" etiqueta="DetalleContactos, Nombre                                                                                                                                        " dominio="DESCRIPCION                   " detalle="false" tipo="I" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CONTPROVDET On PROV.CLCOD = CONTPROVDET.Concod And  PROV.CLCOD != ''                                                                                                                                                                               " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ITEMCONTACTOPROV                        " atributo="TELEFONOS                               " tabla="CONTPROVDET    " campo="CONTEL    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="202" etiqueta="DetalleContactos, Teléfonos                                                                                                                                     " dominio="CARACTER                      " detalle="false" tipo="I" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CONTPROVDET On PROV.CLCOD = CONTPROVDET.Concod And  PROV.CLCOD != ''                                                                                                                                                                               " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ITEMCONTACTOPROV                        " atributo="EMAIL                                   " tabla="CONTPROVDET    " campo="CONMAIL   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="250" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="203" etiqueta="DetalleContactos, Email                                                                                                                                         " dominio="MAIL                          " detalle="false" tipo="I" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CONTPROVDET On PROV.CLCOD = CONTPROVDET.Concod And  PROV.CLCOD != ''                                                                                                                                                                               " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ITEMCONTACTOPROV                        " atributo="NOTAS                                   " tabla="CONTPROVDET    " campo="CONNOT    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="204" etiqueta="DetalleContactos, Notas                                                                                                                                         " dominio="CARACTER                      " detalle="false" tipo="I" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CONTPROVDET On PROV.CLCOD = CONTPROVDET.Concod And  PROV.CLCOD != ''                                                                                                                                                                               " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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