
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
	cTagClavePk = '_002PK'
	cTablaPrincipal = 'PROVEED'
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
			local  lxProveedFectrans, lxProveedFmodifw, lxProveedFecimpo, lxProveedFaltafw, lxProveedFecexpo, lxProveedCltpo, lxProveedClpun3, lxProveedClpun2, lxProveedClpun4, lxProveedClcan4, lxProveedClpun1, lxProveedCldir, lxProveedCliva, lxProveedClmon2, lxProveedClmon4, lxProveedClmon3, lxProveedClmon1, lxProveedClmonto, lxProveedTimestamp, lxProveedHoraexpo, lxProveedHaltafw, lxProveedHoraimpo, lxProveedZadsfw, lxProveedEsttrans, lxProveedBdaltafw, lxProveedCltlf, lxProveedHmodifw, lxProveedBdmodifw, lxProveedVmodifw, lxProveedValtafw, lxProveedUaltafw, lxProveedUmodifw, lxProveedClimpd, lxProveedSaltafw, lxProveedSmodifw, lxProveedCimagen, lxProveedClcondpag, lxProveedClcod, lxProveedClobs, lxProveedCltipconv, lxProveedClloc, lxProveedClfax, lxProveedClsitgan, lxProveedClobjiva, lxProveedRut, lxProveedCllistpre, lxProveedClretsuss, lxProveedClnroiibb, lxProveedClnom, lxProveedClcuit, lxProveedCltipodoc, lxProveedClemplead, lxProveedExretsuss, lxProveedClemail, lxProveedClcp, lxProveedClretgan, lxProveedClretiva, lxProveedClnrodoc, lxProveedClsujvinc, lxProveedClpageweb, lxProveedClprv, lxProveedExretgan, lxProveedExretiva, lxProveedClcontac, lxProveedPvhastagan, lxProveedPvhastaiva, lxProveedClcfi, lxProveedClsiprib, lxProveedPorcentc, lxProveedAplicatc
				lxProveedFectrans =  .Fechatransferencia			lxProveedFmodifw =  .Fechamodificacionfw			lxProveedFecimpo =  .Fechaimpo			lxProveedFaltafw =  .Fechaaltafw			lxProveedFecexpo =  .Fechaexpo			lxProveedCltpo =  .Tipointerno			lxProveedClpun3 =  .Formula4			lxProveedClpun2 =  .Formula3			lxProveedClpun4 =  .Formula5			lxProveedClcan4 =  .Formula1			lxProveedClpun1 =  .Formula2			lxProveedCldir =  .Direccion			lxProveedCliva =  .Situacionfiscal_PK 			lxProveedClmon2 =  .Sobreprecio3			lxProveedClmon4 =  .Sobreprecio5			lxProveedClmon3 =  .Sobreprecio4			lxProveedClmon1 =  .Sobreprecio2			lxProveedClmonto =  .Sobreprecio1			lxProveedTimestamp = goLibrerias.ObtenerTimestamp()			lxProveedHoraexpo =  .Horaexpo			lxProveedHaltafw =  .Horaaltafw			lxProveedHoraimpo =  .Horaimpo			lxProveedZadsfw =  .Zadsfw			lxProveedEsttrans =  .Estadotransferencia			lxProveedBdaltafw =  .Basededatosaltafw			lxProveedCltlf =  .Telefono			lxProveedHmodifw =  .Horamodificacionfw			lxProveedBdmodifw =  .Basededatosmodificacionfw			lxProveedVmodifw =  .Versionmodificacionfw			lxProveedValtafw =  .Versionaltafw			lxProveedUaltafw =  .Usuarioaltafw			lxProveedUmodifw =  .Usuariomodificacionfw			lxProveedClimpd =  .Clasificacion			lxProveedSaltafw =  .Seriealtafw			lxProveedSmodifw =  .Seriemodificacionfw			lxProveedCimagen =  .Imagen			lxProveedClcondpag =  upper( .CondicionDePago_PK ) 			lxProveedClcod =  .Codigo			lxProveedClobs =  .Observacion			lxProveedCltipconv =  .Tipoconvenio			lxProveedClloc =  .Localidad			lxProveedClfax =  .Fax			lxProveedClsitgan =  .Situacionganancias			lxProveedClobjiva =  .Objetoiva			lxProveedRut =  .Rut			lxProveedCllistpre =  upper( .ListaDePrecio_PK ) 			lxProveedClretsuss =  upper( .RetencionSuss_PK ) 			lxProveedClnroiibb =  .Nroiibb			lxProveedClnom =  .Nombre			lxProveedClcuit =  .Cuit			lxProveedCltipodoc =  .Tipodocumento			lxProveedClemplead =  .Empleador			lxProveedExretsuss =  .Excluidoretencionsuss			lxProveedClemail =  .Email			lxProveedClcp =  .Codigopostal			lxProveedClretgan =  upper( .RetencionGanancias_PK ) 			lxProveedClretiva =  upper( .RetencionIva_PK ) 			lxProveedClnrodoc =  .Nrodocumento			lxProveedClsujvinc =  .Sujetovinculado			lxProveedClpageweb =  .Paginaweb			lxProveedClprv =  upper( .Provincia_PK ) 			lxProveedExretgan =  .Excluidoretencionganancias			lxProveedExretiva =  .Excluidoretencioniva			lxProveedClcontac =  .Contacto			lxProveedPvhastagan =  .Vigenciahastagan			lxProveedPvhastaiva =  .Vigenciahastaiva			lxProveedClcfi =  .Tipointerno2			lxProveedClsiprib =  upper( .CodigoSiprib_PK ) 			lxProveedPorcentc =  .Tasaceroporcen			lxProveedAplicatc =  .Tasaceroaplica
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxProveedClcod = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.PROVEED ( "Fectrans","Fmodifw","Fecimpo","Faltafw","Fecexpo","Cltpo","Clpun3","Clpun2","Clpun4","Clcan4","Clpun1","Cldir","Cliva","Clmon2","Clmon4","Clmon3","Clmon1","Clmonto","Timestamp","Horaexpo","Haltafw","Horaimpo","Zadsfw","Esttrans","Bdaltafw","Cltlf","Hmodifw","Bdmodifw","Vmodifw","Valtafw","Ualtafw","Umodifw","Climpd","Saltafw","Smodifw","Cimagen","Clcondpag","Clcod","Clobs","Cltipconv","Clloc","Clfax","Clsitgan","Clobjiva","Rut","Cllistpre","Clretsuss","Clnroiibb","Clnom","Clcuit","Cltipodoc","Clemplead","Exretsuss","Clemail","Clcp","Clretgan","Clretiva","Clnrodoc","Clsujvinc","Clpageweb","Clprv","Exretgan","Exretiva","Clcontac","Pvhastagan","Pvhastaiva","Clcfi","Clsiprib","Porcentc","Aplicatc" ) values ( <<"'" + this.ConvertirDateSql( lxProveedFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxProveedFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxProveedFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxProveedFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxProveedFecexpo ) + "'" >>, <<lxProveedCltpo >>, <<lxProveedClpun3 >>, <<lxProveedClpun2 >>, <<lxProveedClpun4 >>, <<lxProveedClcan4 >>, <<lxProveedClpun1 >>, <<"'" + this.FormatearTextoSql( lxProveedCldir ) + "'" >>, <<lxProveedCliva >>, <<lxProveedClmon2 >>, <<lxProveedClmon4 >>, <<lxProveedClmon3 >>, <<lxProveedClmon1 >>, <<lxProveedClmonto >>, <<lxProveedTimestamp >>, <<"'" + this.FormatearTextoSql( lxProveedHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProveedHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProveedHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProveedZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProveedEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProveedBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProveedCltlf ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProveedHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProveedBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProveedVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProveedValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProveedUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProveedUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProveedClimpd ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProveedSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProveedSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProveedCimagen ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProveedClcondpag ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProveedClcod ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProveedClobs ) + "'" >>, <<lxProveedCltipconv >>, <<"'" + this.FormatearTextoSql( lxProveedClloc ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProveedClfax ) + "'" >>, <<lxProveedClsitgan >>, <<lxProveedClobjiva >>, <<"'" + this.FormatearTextoSql( lxProveedRut ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProveedCllistpre ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProveedClretsuss ) + "'" >>, <<lxProveedClnroiibb >>, <<"'" + this.FormatearTextoSql( lxProveedClnom ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProveedClcuit ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProveedCltipodoc ) + "'" >>, <<iif( lxProveedClemplead, 1, 0 ) >>, <<iif( lxProveedExretsuss, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxProveedClemail ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProveedClcp ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProveedClretgan ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProveedClretiva ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProveedClnrodoc ) + "'" >>, <<iif( lxProveedClsujvinc, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxProveedClpageweb ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProveedClprv ) + "'" >>, <<iif( lxProveedExretgan, 1, 0 ) >>, <<iif( lxProveedExretiva, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxProveedClcontac ) + "'" >>, <<"'" + this.ConvertirDateSql( lxProveedPvhastagan ) + "'" >>, <<"'" + this.ConvertirDateSql( lxProveedPvhastaiva ) + "'" >>, <<lxProveedClcfi >>, <<"'" + this.FormatearTextoSql( lxProveedClsiprib ) + "'" >>, <<lxProveedPorcentc >>, <<iif( lxProveedAplicatc, 1, 0 ) >> )
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
		this.oEntidad.Timestamp = lxProveedTimestamp
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
			local  lxProveedFectrans, lxProveedFmodifw, lxProveedFecimpo, lxProveedFaltafw, lxProveedFecexpo, lxProveedCltpo, lxProveedClpun3, lxProveedClpun2, lxProveedClpun4, lxProveedClcan4, lxProveedClpun1, lxProveedCldir, lxProveedCliva, lxProveedClmon2, lxProveedClmon4, lxProveedClmon3, lxProveedClmon1, lxProveedClmonto, lxProveedTimestamp, lxProveedHoraexpo, lxProveedHaltafw, lxProveedHoraimpo, lxProveedZadsfw, lxProveedEsttrans, lxProveedBdaltafw, lxProveedCltlf, lxProveedHmodifw, lxProveedBdmodifw, lxProveedVmodifw, lxProveedValtafw, lxProveedUaltafw, lxProveedUmodifw, lxProveedClimpd, lxProveedSaltafw, lxProveedSmodifw, lxProveedCimagen, lxProveedClcondpag, lxProveedClcod, lxProveedClobs, lxProveedCltipconv, lxProveedClloc, lxProveedClfax, lxProveedClsitgan, lxProveedClobjiva, lxProveedRut, lxProveedCllistpre, lxProveedClretsuss, lxProveedClnroiibb, lxProveedClnom, lxProveedClcuit, lxProveedCltipodoc, lxProveedClemplead, lxProveedExretsuss, lxProveedClemail, lxProveedClcp, lxProveedClretgan, lxProveedClretiva, lxProveedClnrodoc, lxProveedClsujvinc, lxProveedClpageweb, lxProveedClprv, lxProveedExretgan, lxProveedExretiva, lxProveedClcontac, lxProveedPvhastagan, lxProveedPvhastaiva, lxProveedClcfi, lxProveedClsiprib, lxProveedPorcentc, lxProveedAplicatc
				lxProveedFectrans =  .Fechatransferencia			lxProveedFmodifw =  .Fechamodificacionfw			lxProveedFecimpo =  .Fechaimpo			lxProveedFaltafw =  .Fechaaltafw			lxProveedFecexpo =  .Fechaexpo			lxProveedCltpo =  .Tipointerno			lxProveedClpun3 =  .Formula4			lxProveedClpun2 =  .Formula3			lxProveedClpun4 =  .Formula5			lxProveedClcan4 =  .Formula1			lxProveedClpun1 =  .Formula2			lxProveedCldir =  .Direccion			lxProveedCliva =  .Situacionfiscal_PK 			lxProveedClmon2 =  .Sobreprecio3			lxProveedClmon4 =  .Sobreprecio5			lxProveedClmon3 =  .Sobreprecio4			lxProveedClmon1 =  .Sobreprecio2			lxProveedClmonto =  .Sobreprecio1			lxProveedTimestamp = goLibrerias.ObtenerTimestamp()			lxProveedHoraexpo =  .Horaexpo			lxProveedHaltafw =  .Horaaltafw			lxProveedHoraimpo =  .Horaimpo			lxProveedZadsfw =  .Zadsfw			lxProveedEsttrans =  .Estadotransferencia			lxProveedBdaltafw =  .Basededatosaltafw			lxProveedCltlf =  .Telefono			lxProveedHmodifw =  .Horamodificacionfw			lxProveedBdmodifw =  .Basededatosmodificacionfw			lxProveedVmodifw =  .Versionmodificacionfw			lxProveedValtafw =  .Versionaltafw			lxProveedUaltafw =  .Usuarioaltafw			lxProveedUmodifw =  .Usuariomodificacionfw			lxProveedClimpd =  .Clasificacion			lxProveedSaltafw =  .Seriealtafw			lxProveedSmodifw =  .Seriemodificacionfw			lxProveedCimagen =  .Imagen			lxProveedClcondpag =  upper( .CondicionDePago_PK ) 			lxProveedClcod =  .Codigo			lxProveedClobs =  .Observacion			lxProveedCltipconv =  .Tipoconvenio			lxProveedClloc =  .Localidad			lxProveedClfax =  .Fax			lxProveedClsitgan =  .Situacionganancias			lxProveedClobjiva =  .Objetoiva			lxProveedRut =  .Rut			lxProveedCllistpre =  upper( .ListaDePrecio_PK ) 			lxProveedClretsuss =  upper( .RetencionSuss_PK ) 			lxProveedClnroiibb =  .Nroiibb			lxProveedClnom =  .Nombre			lxProveedClcuit =  .Cuit			lxProveedCltipodoc =  .Tipodocumento			lxProveedClemplead =  .Empleador			lxProveedExretsuss =  .Excluidoretencionsuss			lxProveedClemail =  .Email			lxProveedClcp =  .Codigopostal			lxProveedClretgan =  upper( .RetencionGanancias_PK ) 			lxProveedClretiva =  upper( .RetencionIva_PK ) 			lxProveedClnrodoc =  .Nrodocumento			lxProveedClsujvinc =  .Sujetovinculado			lxProveedClpageweb =  .Paginaweb			lxProveedClprv =  upper( .Provincia_PK ) 			lxProveedExretgan =  .Excluidoretencionganancias			lxProveedExretiva =  .Excluidoretencioniva			lxProveedClcontac =  .Contacto			lxProveedPvhastagan =  .Vigenciahastagan			lxProveedPvhastaiva =  .Vigenciahastaiva			lxProveedClcfi =  .Tipointerno2			lxProveedClsiprib =  upper( .CodigoSiprib_PK ) 			lxProveedPorcentc =  .Tasaceroporcen			lxProveedAplicatc =  .Tasaceroaplica
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
				update ZooLogic.PROVEED set "Fectrans" = <<"'" + this.ConvertirDateSql( lxProveedFectrans ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxProveedFmodifw ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxProveedFecimpo ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxProveedFaltafw ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxProveedFecexpo ) + "'">>,"Cltpo" = <<lxProveedCltpo>>,"Clpun3" = <<lxProveedClpun3>>,"Clpun2" = <<lxProveedClpun2>>,"Clpun4" = <<lxProveedClpun4>>,"Clcan4" = <<lxProveedClcan4>>,"Clpun1" = <<lxProveedClpun1>>,"Cldir" = <<"'" + this.FormatearTextoSql( lxProveedCldir ) + "'">>,"Cliva" = <<lxProveedCliva>>,"Clmon2" = <<lxProveedClmon2>>,"Clmon4" = <<lxProveedClmon4>>,"Clmon3" = <<lxProveedClmon3>>,"Clmon1" = <<lxProveedClmon1>>,"Clmonto" = <<lxProveedClmonto>>,"Timestamp" = <<lxProveedTimestamp>>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxProveedHoraexpo ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxProveedHaltafw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxProveedHoraimpo ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxProveedZadsfw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxProveedEsttrans ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxProveedBdaltafw ) + "'">>,"Cltlf" = <<"'" + this.FormatearTextoSql( lxProveedCltlf ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxProveedHmodifw ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxProveedBdmodifw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxProveedVmodifw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxProveedValtafw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxProveedUaltafw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxProveedUmodifw ) + "'">>,"Climpd" = <<"'" + this.FormatearTextoSql( lxProveedClimpd ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxProveedSaltafw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxProveedSmodifw ) + "'">>,"Cimagen" = <<"'" + this.FormatearTextoSql( lxProveedCimagen ) + "'">>,"Clcondpag" = <<"'" + this.FormatearTextoSql( lxProveedClcondpag ) + "'">>,"Clcod" = <<"'" + this.FormatearTextoSql( lxProveedClcod ) + "'">>,"Clobs" = <<"'" + this.FormatearTextoSql( lxProveedClobs ) + "'">>,"Cltipconv" = <<lxProveedCltipconv>>,"Clloc" = <<"'" + this.FormatearTextoSql( lxProveedClloc ) + "'">>,"Clfax" = <<"'" + this.FormatearTextoSql( lxProveedClfax ) + "'">>,"Clsitgan" = <<lxProveedClsitgan>>,"Clobjiva" = <<lxProveedClobjiva>>,"Rut" = <<"'" + this.FormatearTextoSql( lxProveedRut ) + "'">>,"Cllistpre" = <<"'" + this.FormatearTextoSql( lxProveedCllistpre ) + "'">>,"Clretsuss" = <<"'" + this.FormatearTextoSql( lxProveedClretsuss ) + "'">>,"Clnroiibb" = <<lxProveedClnroiibb>>,"Clnom" = <<"'" + this.FormatearTextoSql( lxProveedClnom ) + "'">>,"Clcuit" = <<"'" + this.FormatearTextoSql( lxProveedClcuit ) + "'">>,"Cltipodoc" = <<"'" + this.FormatearTextoSql( lxProveedCltipodoc ) + "'">>,"Clemplead" = <<iif( lxProveedClemplead, 1, 0 )>>,"Exretsuss" = <<iif( lxProveedExretsuss, 1, 0 )>>,"Clemail" = <<"'" + this.FormatearTextoSql( lxProveedClemail ) + "'">>,"Clcp" = <<"'" + this.FormatearTextoSql( lxProveedClcp ) + "'">>,"Clretgan" = <<"'" + this.FormatearTextoSql( lxProveedClretgan ) + "'">>,"Clretiva" = <<"'" + this.FormatearTextoSql( lxProveedClretiva ) + "'">>,"Clnrodoc" = <<"'" + this.FormatearTextoSql( lxProveedClnrodoc ) + "'">>,"Clsujvinc" = <<iif( lxProveedClsujvinc, 1, 0 )>>,"Clpageweb" = <<"'" + this.FormatearTextoSql( lxProveedClpageweb ) + "'">>,"Clprv" = <<"'" + this.FormatearTextoSql( lxProveedClprv ) + "'">>,"Exretgan" = <<iif( lxProveedExretgan, 1, 0 )>>,"Exretiva" = <<iif( lxProveedExretiva, 1, 0 )>>,"Clcontac" = <<"'" + this.FormatearTextoSql( lxProveedClcontac ) + "'">>,"Pvhastagan" = <<"'" + this.ConvertirDateSql( lxProveedPvhastagan ) + "'">>,"Pvhastaiva" = <<"'" + this.ConvertirDateSql( lxProveedPvhastaiva ) + "'">>,"Clcfi" = <<lxProveedClcfi>>,"Clsiprib" = <<"'" + this.FormatearTextoSql( lxProveedClsiprib ) + "'">>,"Porcentc" = <<lxProveedPorcentc>>,"Aplicatc" = <<iif( lxProveedAplicatc, 1, 0 )>> where "Clcod" = <<"'" + this.FormatearTextoSql( lxProveedClcod ) + "'">> and  PROVEED.CLCOD != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			this.ComprobarResultadoDeEjecucionDelUpdate()
		this.ComprobarTransaccion()
			.EjecutarSentencias( This.ColSentencias )
		this.ComprobarTransaccion()
			this.oConexion.EjecutarSql( 'delete from ZooLogic.RetProDet where "Cod" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )

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
		this.oEntidad.Timestamp = lxProveedTimestamp
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 CLCOD from ZooLogic.PROVEED where " + this.ConvertirFuncionesSql( " PROVEED.CLCOD != ''" ) )
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
			Local lxProveedClcod
			lxProveedClcod = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Cltpo" as "Tipointerno", "Clpun3" as "Formula4", "Clpun2" as "Formula3", "Clpun4" as "Formula5", "Clcan4" as "Formula1", "Clpun1" as "Formula2", "Cldir" as "Direccion", "Cliva" as "Situacionfiscal", "Clmon2" as "Sobreprecio3", "Clmon4" as "Sobreprecio5", "Clmon3" as "Sobreprecio4", "Clmon1" as "Sobreprecio2", "Clmonto" as "Sobreprecio1", "Timestamp" as "Timestamp", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Zadsfw" as "Zadsfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Cltlf" as "Telefono", "Hmodifw" as "Horamodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Climpd" as "Clasificacion", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Cimagen" as "Imagen", "Clcondpag" as "Condiciondepago", "Clcod" as "Codigo", "Clobs" as "Observacion", "Cltipconv" as "Tipoconvenio", "Clloc" as "Localidad", "Clfax" as "Fax", "Clsitgan" as "Situacionganancias", "Clobjiva" as "Objetoiva", "Rut" as "Rut", "Cllistpre" as "Listadeprecio", "Clretsuss" as "Retencionsuss", "Clnroiibb" as "Nroiibb", "Clnom" as "Nombre", "Clcuit" as "Cuit", "Cltipodoc" as "Tipodocumento", "Clemplead" as "Empleador", "Exretsuss" as "Excluidoretencionsuss", "Clemail" as "Email", "Clcp" as "Codigopostal", "Clretgan" as "Retencionganancias", "Clretiva" as "Retencioniva", "Clnrodoc" as "Nrodocumento", "Clsujvinc" as "Sujetovinculado", "Clpageweb" as "Paginaweb", "Clprv" as "Provincia", "Exretgan" as "Excluidoretencionganancias", "Exretiva" as "Excluidoretencioniva", "Clcontac" as "Contacto", "Pvhastagan" as "Vigenciahastagan", "Pvhastaiva" as "Vigenciahastaiva", "Clcfi" as "Tipointerno2", "Clsiprib" as "Codigosiprib", "Porcentc" as "Tasaceroporcen", "Aplicatc" as "Tasaceroaplica" from ZooLogic.PROVEED where "Clcod" = <<"'" + this.FormatearTextoSql( lxProveedClcod ) + "'">> and  PROVEED.CLCOD != ''
			endtext
			use in select('c_PROVEEDOR')
			this.oConexion.EjecutarSql( lcSentencia, 'c_PROVEEDOR', set( 'Datasession' ) )

			if reccount( 'c_PROVEEDOR' ) = 0
				llRetorno = .f.
			else
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
		local llRetorno as boolean,lxProveedClcod as Variant
		llRetorno = .t.
		lxProveedClcod = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.PROVEED where "Clcod" = <<"'" + this.FormatearTextoSql( lxProveedClcod ) + "'">> and  PROVEED.CLCOD != ''
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
				select top 1 "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Cltpo" as "Tipointerno", "Clpun3" as "Formula4", "Clpun2" as "Formula3", "Clpun4" as "Formula5", "Clcan4" as "Formula1", "Clpun1" as "Formula2", "Cldir" as "Direccion", "Cliva" as "Situacionfiscal", "Clmon2" as "Sobreprecio3", "Clmon4" as "Sobreprecio5", "Clmon3" as "Sobreprecio4", "Clmon1" as "Sobreprecio2", "Clmonto" as "Sobreprecio1", "Timestamp" as "Timestamp", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Zadsfw" as "Zadsfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Cltlf" as "Telefono", "Hmodifw" as "Horamodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Climpd" as "Clasificacion", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Cimagen" as "Imagen", "Clcondpag" as "Condiciondepago", "Clcod" as "Codigo", "Clobs" as "Observacion", "Cltipconv" as "Tipoconvenio", "Clloc" as "Localidad", "Clfax" as "Fax", "Clsitgan" as "Situacionganancias", "Clobjiva" as "Objetoiva", "Rut" as "Rut", "Cllistpre" as "Listadeprecio", "Clretsuss" as "Retencionsuss", "Clnroiibb" as "Nroiibb", "Clnom" as "Nombre", "Clcuit" as "Cuit", "Cltipodoc" as "Tipodocumento", "Clemplead" as "Empleador", "Exretsuss" as "Excluidoretencionsuss", "Clemail" as "Email", "Clcp" as "Codigopostal", "Clretgan" as "Retencionganancias", "Clretiva" as "Retencioniva", "Clnrodoc" as "Nrodocumento", "Clsujvinc" as "Sujetovinculado", "Clpageweb" as "Paginaweb", "Clprv" as "Provincia", "Exretgan" as "Excluidoretencionganancias", "Exretiva" as "Excluidoretencioniva", "Clcontac" as "Contacto", "Pvhastagan" as "Vigenciahastagan", "Pvhastaiva" as "Vigenciahastaiva", "Clcfi" as "Tipointerno2", "Clsiprib" as "Codigosiprib", "Porcentc" as "Tasaceroporcen", "Aplicatc" as "Tasaceroaplica" from ZooLogic.PROVEED where  PROVEED.CLCOD != '' order by CLCOD
			endtext
			use in select('c_PROVEEDOR')
			this.oConexion.EjecutarSql( lcSentencia, 'c_PROVEEDOR', set( 'Datasession' ) )
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
				select top 1 "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Cltpo" as "Tipointerno", "Clpun3" as "Formula4", "Clpun2" as "Formula3", "Clpun4" as "Formula5", "Clcan4" as "Formula1", "Clpun1" as "Formula2", "Cldir" as "Direccion", "Cliva" as "Situacionfiscal", "Clmon2" as "Sobreprecio3", "Clmon4" as "Sobreprecio5", "Clmon3" as "Sobreprecio4", "Clmon1" as "Sobreprecio2", "Clmonto" as "Sobreprecio1", "Timestamp" as "Timestamp", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Zadsfw" as "Zadsfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Cltlf" as "Telefono", "Hmodifw" as "Horamodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Climpd" as "Clasificacion", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Cimagen" as "Imagen", "Clcondpag" as "Condiciondepago", "Clcod" as "Codigo", "Clobs" as "Observacion", "Cltipconv" as "Tipoconvenio", "Clloc" as "Localidad", "Clfax" as "Fax", "Clsitgan" as "Situacionganancias", "Clobjiva" as "Objetoiva", "Rut" as "Rut", "Cllistpre" as "Listadeprecio", "Clretsuss" as "Retencionsuss", "Clnroiibb" as "Nroiibb", "Clnom" as "Nombre", "Clcuit" as "Cuit", "Cltipodoc" as "Tipodocumento", "Clemplead" as "Empleador", "Exretsuss" as "Excluidoretencionsuss", "Clemail" as "Email", "Clcp" as "Codigopostal", "Clretgan" as "Retencionganancias", "Clretiva" as "Retencioniva", "Clnrodoc" as "Nrodocumento", "Clsujvinc" as "Sujetovinculado", "Clpageweb" as "Paginaweb", "Clprv" as "Provincia", "Exretgan" as "Excluidoretencionganancias", "Exretiva" as "Excluidoretencioniva", "Clcontac" as "Contacto", "Pvhastagan" as "Vigenciahastagan", "Pvhastaiva" as "Vigenciahastaiva", "Clcfi" as "Tipointerno2", "Clsiprib" as "Codigosiprib", "Porcentc" as "Tasaceroporcen", "Aplicatc" as "Tasaceroaplica" from ZooLogic.PROVEED where  funciones.padr( CLCOD, 5, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  PROVEED.CLCOD != '' order by CLCOD
			endtext
			use in select('c_PROVEEDOR')
			this.oConexion.EjecutarSql( lcSentencia, 'c_PROVEEDOR', set( 'Datasession' ) )
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
				select top 1 "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Cltpo" as "Tipointerno", "Clpun3" as "Formula4", "Clpun2" as "Formula3", "Clpun4" as "Formula5", "Clcan4" as "Formula1", "Clpun1" as "Formula2", "Cldir" as "Direccion", "Cliva" as "Situacionfiscal", "Clmon2" as "Sobreprecio3", "Clmon4" as "Sobreprecio5", "Clmon3" as "Sobreprecio4", "Clmon1" as "Sobreprecio2", "Clmonto" as "Sobreprecio1", "Timestamp" as "Timestamp", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Zadsfw" as "Zadsfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Cltlf" as "Telefono", "Hmodifw" as "Horamodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Climpd" as "Clasificacion", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Cimagen" as "Imagen", "Clcondpag" as "Condiciondepago", "Clcod" as "Codigo", "Clobs" as "Observacion", "Cltipconv" as "Tipoconvenio", "Clloc" as "Localidad", "Clfax" as "Fax", "Clsitgan" as "Situacionganancias", "Clobjiva" as "Objetoiva", "Rut" as "Rut", "Cllistpre" as "Listadeprecio", "Clretsuss" as "Retencionsuss", "Clnroiibb" as "Nroiibb", "Clnom" as "Nombre", "Clcuit" as "Cuit", "Cltipodoc" as "Tipodocumento", "Clemplead" as "Empleador", "Exretsuss" as "Excluidoretencionsuss", "Clemail" as "Email", "Clcp" as "Codigopostal", "Clretgan" as "Retencionganancias", "Clretiva" as "Retencioniva", "Clnrodoc" as "Nrodocumento", "Clsujvinc" as "Sujetovinculado", "Clpageweb" as "Paginaweb", "Clprv" as "Provincia", "Exretgan" as "Excluidoretencionganancias", "Exretiva" as "Excluidoretencioniva", "Clcontac" as "Contacto", "Pvhastagan" as "Vigenciahastagan", "Pvhastaiva" as "Vigenciahastaiva", "Clcfi" as "Tipointerno2", "Clsiprib" as "Codigosiprib", "Porcentc" as "Tasaceroporcen", "Aplicatc" as "Tasaceroaplica" from ZooLogic.PROVEED where  funciones.padr( CLCOD, 5, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  PROVEED.CLCOD != '' order by CLCOD desc
			endtext
			use in select('c_PROVEEDOR')
			this.oConexion.EjecutarSql( lcSentencia, 'c_PROVEEDOR', set( 'Datasession' ) )
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
				select top 1 "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Cltpo" as "Tipointerno", "Clpun3" as "Formula4", "Clpun2" as "Formula3", "Clpun4" as "Formula5", "Clcan4" as "Formula1", "Clpun1" as "Formula2", "Cldir" as "Direccion", "Cliva" as "Situacionfiscal", "Clmon2" as "Sobreprecio3", "Clmon4" as "Sobreprecio5", "Clmon3" as "Sobreprecio4", "Clmon1" as "Sobreprecio2", "Clmonto" as "Sobreprecio1", "Timestamp" as "Timestamp", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Zadsfw" as "Zadsfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Cltlf" as "Telefono", "Hmodifw" as "Horamodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Climpd" as "Clasificacion", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Cimagen" as "Imagen", "Clcondpag" as "Condiciondepago", "Clcod" as "Codigo", "Clobs" as "Observacion", "Cltipconv" as "Tipoconvenio", "Clloc" as "Localidad", "Clfax" as "Fax", "Clsitgan" as "Situacionganancias", "Clobjiva" as "Objetoiva", "Rut" as "Rut", "Cllistpre" as "Listadeprecio", "Clretsuss" as "Retencionsuss", "Clnroiibb" as "Nroiibb", "Clnom" as "Nombre", "Clcuit" as "Cuit", "Cltipodoc" as "Tipodocumento", "Clemplead" as "Empleador", "Exretsuss" as "Excluidoretencionsuss", "Clemail" as "Email", "Clcp" as "Codigopostal", "Clretgan" as "Retencionganancias", "Clretiva" as "Retencioniva", "Clnrodoc" as "Nrodocumento", "Clsujvinc" as "Sujetovinculado", "Clpageweb" as "Paginaweb", "Clprv" as "Provincia", "Exretgan" as "Excluidoretencionganancias", "Exretiva" as "Excluidoretencioniva", "Clcontac" as "Contacto", "Pvhastagan" as "Vigenciahastagan", "Pvhastaiva" as "Vigenciahastaiva", "Clcfi" as "Tipointerno2", "Clsiprib" as "Codigosiprib", "Porcentc" as "Tasaceroporcen", "Aplicatc" as "Tasaceroaplica" from ZooLogic.PROVEED where  PROVEED.CLCOD != '' order by CLCOD desc
			endtext
			use in select('c_PROVEEDOR')
			this.oConexion.EjecutarSql( lcSentencia, 'c_PROVEEDOR', set( 'Datasession' ) )
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
			lcXml = this.oConexion.EjecutarSql( "select Fectrans,Fmodifw,Fecimpo,Faltafw,Fecexpo,Cltpo,Clpun3,Clpun2,Clpun4,Clcan4,Clpun1,Cldir,Cliv" + ;
"a,Clmon2,Clmon4,Clmon3,Clmon1,Clmonto,Timestamp,Horaexpo,Haltafw,Horaimpo,Zadsfw,Esttrans,Bdaltafw,C" + ;
"ltlf,Hmodifw,Bdmodifw,Vmodifw,Valtafw,Ualtafw,Umodifw,Climpd,Saltafw,Smodifw,Cimagen,Clcondpag,Clcod" + ;
",Clobs,Cltipconv,Clloc,Clfax,Clsitgan,Clobjiva,Rut,Cllistpre,Clretsuss,Clnroiibb,Clnom,Clcuit,Cltipo" + ;
"doc,Clemplead,Exretsuss,Clemail,Clcp,Clretgan,Clretiva,Clnrodoc,Clsujvinc,Clpageweb,Clprv,Exretgan,E" + ;
"xretiva,Clcontac,Pvhastagan,Pvhastaiva,Clcfi,Clsiprib,Porcentc,Aplicatc" + ;
" from ZooLogic.PROVEED where  PROVEED.CLCOD != '' and " + lcFiltro )
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
			local  lxProveedFectrans, lxProveedFmodifw, lxProveedFecimpo, lxProveedFaltafw, lxProveedFecexpo, lxProveedCltpo, lxProveedClpun3, lxProveedClpun2, lxProveedClpun4, lxProveedClcan4, lxProveedClpun1, lxProveedCldir, lxProveedCliva, lxProveedClmon2, lxProveedClmon4, lxProveedClmon3, lxProveedClmon1, lxProveedClmonto, lxProveedTimestamp, lxProveedHoraexpo, lxProveedHaltafw, lxProveedHoraimpo, lxProveedZadsfw, lxProveedEsttrans, lxProveedBdaltafw, lxProveedCltlf, lxProveedHmodifw, lxProveedBdmodifw, lxProveedVmodifw, lxProveedValtafw, lxProveedUaltafw, lxProveedUmodifw, lxProveedClimpd, lxProveedSaltafw, lxProveedSmodifw, lxProveedCimagen, lxProveedClcondpag, lxProveedClcod, lxProveedClobs, lxProveedCltipconv, lxProveedClloc, lxProveedClfax, lxProveedClsitgan, lxProveedClobjiva, lxProveedRut, lxProveedCllistpre, lxProveedClretsuss, lxProveedClnroiibb, lxProveedClnom, lxProveedClcuit, lxProveedCltipodoc, lxProveedClemplead, lxProveedExretsuss, lxProveedClemail, lxProveedClcp, lxProveedClretgan, lxProveedClretiva, lxProveedClnrodoc, lxProveedClsujvinc, lxProveedClpageweb, lxProveedClprv, lxProveedExretgan, lxProveedExretiva, lxProveedClcontac, lxProveedPvhastagan, lxProveedPvhastaiva, lxProveedClcfi, lxProveedClsiprib, lxProveedPorcentc, lxProveedAplicatc
				lxProveedFectrans = ctod( '  /  /    ' )			lxProveedFmodifw = ctod( '  /  /    ' )			lxProveedFecimpo = ctod( '  /  /    ' )			lxProveedFaltafw = ctod( '  /  /    ' )			lxProveedFecexpo = ctod( '  /  /    ' )			lxProveedCltpo = 0			lxProveedClpun3 = 0			lxProveedClpun2 = 0			lxProveedClpun4 = 0			lxProveedClcan4 = 0			lxProveedClpun1 = 0			lxProveedCldir = []			lxProveedCliva = 0			lxProveedClmon2 = 0			lxProveedClmon4 = 0			lxProveedClmon3 = 0			lxProveedClmon1 = 0			lxProveedClmonto = 0			lxProveedTimestamp = goLibrerias.ObtenerTimestamp()			lxProveedHoraexpo = []			lxProveedHaltafw = []			lxProveedHoraimpo = []			lxProveedZadsfw = []			lxProveedEsttrans = []			lxProveedBdaltafw = []			lxProveedCltlf = []			lxProveedHmodifw = []			lxProveedBdmodifw = []			lxProveedVmodifw = []			lxProveedValtafw = []			lxProveedUaltafw = []			lxProveedUmodifw = []			lxProveedClimpd = []			lxProveedSaltafw = []			lxProveedSmodifw = []			lxProveedCimagen = []			lxProveedClcondpag = []			lxProveedClcod = []			lxProveedClobs = []			lxProveedCltipconv = 0			lxProveedClloc = []			lxProveedClfax = []			lxProveedClsitgan = 0			lxProveedClobjiva = 0			lxProveedRut = []			lxProveedCllistpre = []			lxProveedClretsuss = []			lxProveedClnroiibb = 0			lxProveedClnom = []			lxProveedClcuit = []			lxProveedCltipodoc = []			lxProveedClemplead = .F.			lxProveedExretsuss = .F.			lxProveedClemail = []			lxProveedClcp = []			lxProveedClretgan = []			lxProveedClretiva = []			lxProveedClnrodoc = []			lxProveedClsujvinc = .F.			lxProveedClpageweb = []			lxProveedClprv = []			lxProveedExretgan = .F.			lxProveedExretiva = .F.			lxProveedClcontac = []			lxProveedPvhastagan = ctod( '  /  /    ' )			lxProveedPvhastaiva = ctod( '  /  /    ' )			lxProveedClcfi = 0			lxProveedClsiprib = []			lxProveedPorcentc = 0			lxProveedAplicatc = .F.
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.RetProDet where "Cod" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( [delete from ZooLogic.PROVEED where "CLCOD" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'PROVEED' + '_' + tcCampo
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
		lcWhere = " Where  PROVEED.CLCOD != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Cltpo" as "Tipointerno", "Clpun3" as "Formula4", "Clpun2" as "Formula3", "Clpun4" as "Formula5", "Clcan4" as "Formula1", "Clpun1" as "Formula2", "Cldir" as "Direccion", "Cliva" as "Situacionfiscal", "Clmon2" as "Sobreprecio3", "Clmon4" as "Sobreprecio5", "Clmon3" as "Sobreprecio4", "Clmon1" as "Sobreprecio2", "Clmonto" as "Sobreprecio1", "Timestamp" as "Timestamp", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Zadsfw" as "Zadsfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Cltlf" as "Telefono", "Hmodifw" as "Horamodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Climpd" as "Clasificacion", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Cimagen" as "Imagen", "Clcondpag" as "Condiciondepago", "Clcod" as "Codigo", "Clobs" as "Observacion", "Cltipconv" as "Tipoconvenio", "Clloc" as "Localidad", "Clfax" as "Fax", "Clsitgan" as "Situacionganancias", "Clobjiva" as "Objetoiva", "Rut" as "Rut", "Cllistpre" as "Listadeprecio", "Clretsuss" as "Retencionsuss", "Clnroiibb" as "Nroiibb", "Clnom" as "Nombre", "Clcuit" as "Cuit", "Cltipodoc" as "Tipodocumento", "Clemplead" as "Empleador", "Exretsuss" as "Excluidoretencionsuss", "Clemail" as "Email", "Clcp" as "Codigopostal", "Clretgan" as "Retencionganancias", "Clretiva" as "Retencioniva", "Clnrodoc" as "Nrodocumento", "Clsujvinc" as "Sujetovinculado", "Clpageweb" as "Paginaweb", "Clprv" as "Provincia", "Exretgan" as "Excluidoretencionganancias", "Exretiva" as "Excluidoretencioniva", "Clcontac" as "Contacto", "Pvhastagan" as "Vigenciahastagan", "Pvhastaiva" as "Vigenciahastaiva", "Clcfi" as "Tipointerno2", "Clsiprib" as "Codigosiprib", "Porcentc" as "Tasaceroporcen", "Aplicatc" as "Tasaceroaplica"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'PROVEED', '', tnTope )
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
				Case lcAtributo == 'FECHAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECIMPO AS FECHAIMPO'
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'FECHAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECEXPO AS FECHAEXPO'
				Case lcAtributo == 'TIPOINTERNO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLTPO AS TIPOINTERNO'
				Case lcAtributo == 'FORMULA4'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLPUN3 AS FORMULA4'
				Case lcAtributo == 'FORMULA3'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLPUN2 AS FORMULA3'
				Case lcAtributo == 'FORMULA5'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLPUN4 AS FORMULA5'
				Case lcAtributo == 'FORMULA1'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLCAN4 AS FORMULA1'
				Case lcAtributo == 'FORMULA2'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLPUN1 AS FORMULA2'
				Case lcAtributo == 'DIRECCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLDIR AS DIRECCION'
				Case lcAtributo == 'SITUACIONFISCAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLIVA AS SITUACIONFISCAL'
				Case lcAtributo == 'SOBREPRECIO3'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLMON2 AS SOBREPRECIO3'
				Case lcAtributo == 'SOBREPRECIO5'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLMON4 AS SOBREPRECIO5'
				Case lcAtributo == 'SOBREPRECIO4'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLMON3 AS SOBREPRECIO4'
				Case lcAtributo == 'SOBREPRECIO2'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLMON1 AS SOBREPRECIO2'
				Case lcAtributo == 'SOBREPRECIO1'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLMONTO AS SOBREPRECIO1'
				Case lcAtributo == 'TIMESTAMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIMESTAMP AS TIMESTAMP'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'TELEFONO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLTLF AS TELEFONO'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'CLASIFICACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLIMPD AS CLASIFICACION'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'IMAGEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CIMAGEN AS IMAGEN'
				Case lcAtributo == 'CONDICIONDEPAGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLCONDPAG AS CONDICIONDEPAGO'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLCOD AS CODIGO'
				Case lcAtributo == 'OBSERVACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLOBS AS OBSERVACION'
				Case lcAtributo == 'TIPOCONVENIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLTIPCONV AS TIPOCONVENIO'
				Case lcAtributo == 'LOCALIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLLOC AS LOCALIDAD'
				Case lcAtributo == 'FAX'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLFAX AS FAX'
				Case lcAtributo == 'SITUACIONGANANCIAS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLSITGAN AS SITUACIONGANANCIAS'
				Case lcAtributo == 'OBJETOIVA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLOBJIVA AS OBJETOIVA'
				Case lcAtributo == 'RUT'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RUT AS RUT'
				Case lcAtributo == 'LISTADEPRECIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLLISTPRE AS LISTADEPRECIO'
				Case lcAtributo == 'RETENCIONSUSS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLRETSUSS AS RETENCIONSUSS'
				Case lcAtributo == 'NROIIBB'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLNROIIBB AS NROIIBB'
				Case lcAtributo == 'NOMBRE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLNOM AS NOMBRE'
				Case lcAtributo == 'CUIT'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLCUIT AS CUIT'
				Case lcAtributo == 'TIPODOCUMENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLTIPODOC AS TIPODOCUMENTO'
				Case lcAtributo == 'EMPLEADOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLEMPLEAD AS EMPLEADOR'
				Case lcAtributo == 'EXCLUIDORETENCIONSUSS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'EXRETSUSS AS EXCLUIDORETENCIONSUSS'
				Case lcAtributo == 'EMAIL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLEMAIL AS EMAIL'
				Case lcAtributo == 'CODIGOPOSTAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLCP AS CODIGOPOSTAL'
				Case lcAtributo == 'RETENCIONGANANCIAS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLRETGAN AS RETENCIONGANANCIAS'
				Case lcAtributo == 'RETENCIONIVA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLRETIVA AS RETENCIONIVA'
				Case lcAtributo == 'NRODOCUMENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLNRODOC AS NRODOCUMENTO'
				Case lcAtributo == 'SUJETOVINCULADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLSUJVINC AS SUJETOVINCULADO'
				Case lcAtributo == 'PAGINAWEB'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLPAGEWEB AS PAGINAWEB'
				Case lcAtributo == 'PROVINCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLPRV AS PROVINCIA'
				Case lcAtributo == 'EXCLUIDORETENCIONGANANCIAS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'EXRETGAN AS EXCLUIDORETENCIONGANANCIAS'
				Case lcAtributo == 'EXCLUIDORETENCIONIVA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'EXRETIVA AS EXCLUIDORETENCIONIVA'
				Case lcAtributo == 'CONTACTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLCONTAC AS CONTACTO'
				Case lcAtributo == 'VIGENCIAHASTAGAN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PVHASTAGAN AS VIGENCIAHASTAGAN'
				Case lcAtributo == 'VIGENCIAHASTAIVA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PVHASTAIVA AS VIGENCIAHASTAIVA'
				Case lcAtributo == 'TIPOINTERNO2'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLCFI AS TIPOINTERNO2'
				Case lcAtributo == 'CODIGOSIPRIB'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLSIPRIB AS CODIGOSIPRIB'
				Case lcAtributo == 'TASACEROPORCEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PORCENTC AS TASACEROPORCEN'
				Case lcAtributo == 'TASACEROAPLICA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'APLICATC AS TASACEROAPLICA'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHAIMPO'
				lcCampo = 'FECIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEXPO'
				lcCampo = 'FECEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOINTERNO'
				lcCampo = 'CLTPO'
			Case upper( alltrim( tcAtributo ) ) == 'FORMULA4'
				lcCampo = 'CLPUN3'
			Case upper( alltrim( tcAtributo ) ) == 'FORMULA3'
				lcCampo = 'CLPUN2'
			Case upper( alltrim( tcAtributo ) ) == 'FORMULA5'
				lcCampo = 'CLPUN4'
			Case upper( alltrim( tcAtributo ) ) == 'FORMULA1'
				lcCampo = 'CLCAN4'
			Case upper( alltrim( tcAtributo ) ) == 'FORMULA2'
				lcCampo = 'CLPUN1'
			Case upper( alltrim( tcAtributo ) ) == 'DIRECCION'
				lcCampo = 'CLDIR'
			Case upper( alltrim( tcAtributo ) ) == 'SITUACIONFISCAL'
				lcCampo = 'CLIVA'
			Case upper( alltrim( tcAtributo ) ) == 'SOBREPRECIO3'
				lcCampo = 'CLMON2'
			Case upper( alltrim( tcAtributo ) ) == 'SOBREPRECIO5'
				lcCampo = 'CLMON4'
			Case upper( alltrim( tcAtributo ) ) == 'SOBREPRECIO4'
				lcCampo = 'CLMON3'
			Case upper( alltrim( tcAtributo ) ) == 'SOBREPRECIO2'
				lcCampo = 'CLMON1'
			Case upper( alltrim( tcAtributo ) ) == 'SOBREPRECIO1'
				lcCampo = 'CLMONTO'
			Case upper( alltrim( tcAtributo ) ) == 'TIMESTAMP'
				lcCampo = 'TIMESTAMP'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'TELEFONO'
				lcCampo = 'CLTLF'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'CLASIFICACION'
				lcCampo = 'CLIMPD'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'IMAGEN'
				lcCampo = 'CIMAGEN'
			Case upper( alltrim( tcAtributo ) ) == 'CONDICIONDEPAGO'
				lcCampo = 'CLCONDPAG'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CLCOD'
			Case upper( alltrim( tcAtributo ) ) == 'OBSERVACION'
				lcCampo = 'CLOBS'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOCONVENIO'
				lcCampo = 'CLTIPCONV'
			Case upper( alltrim( tcAtributo ) ) == 'LOCALIDAD'
				lcCampo = 'CLLOC'
			Case upper( alltrim( tcAtributo ) ) == 'FAX'
				lcCampo = 'CLFAX'
			Case upper( alltrim( tcAtributo ) ) == 'SITUACIONGANANCIAS'
				lcCampo = 'CLSITGAN'
			Case upper( alltrim( tcAtributo ) ) == 'OBJETOIVA'
				lcCampo = 'CLOBJIVA'
			Case upper( alltrim( tcAtributo ) ) == 'RUT'
				lcCampo = 'RUT'
			Case upper( alltrim( tcAtributo ) ) == 'LISTADEPRECIO'
				lcCampo = 'CLLISTPRE'
			Case upper( alltrim( tcAtributo ) ) == 'RETENCIONSUSS'
				lcCampo = 'CLRETSUSS'
			Case upper( alltrim( tcAtributo ) ) == 'NROIIBB'
				lcCampo = 'CLNROIIBB'
			Case upper( alltrim( tcAtributo ) ) == 'NOMBRE'
				lcCampo = 'CLNOM'
			Case upper( alltrim( tcAtributo ) ) == 'CUIT'
				lcCampo = 'CLCUIT'
			Case upper( alltrim( tcAtributo ) ) == 'TIPODOCUMENTO'
				lcCampo = 'CLTIPODOC'
			Case upper( alltrim( tcAtributo ) ) == 'EMPLEADOR'
				lcCampo = 'CLEMPLEAD'
			Case upper( alltrim( tcAtributo ) ) == 'EXCLUIDORETENCIONSUSS'
				lcCampo = 'EXRETSUSS'
			Case upper( alltrim( tcAtributo ) ) == 'EMAIL'
				lcCampo = 'CLEMAIL'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGOPOSTAL'
				lcCampo = 'CLCP'
			Case upper( alltrim( tcAtributo ) ) == 'RETENCIONGANANCIAS'
				lcCampo = 'CLRETGAN'
			Case upper( alltrim( tcAtributo ) ) == 'RETENCIONIVA'
				lcCampo = 'CLRETIVA'
			Case upper( alltrim( tcAtributo ) ) == 'NRODOCUMENTO'
				lcCampo = 'CLNRODOC'
			Case upper( alltrim( tcAtributo ) ) == 'SUJETOVINCULADO'
				lcCampo = 'CLSUJVINC'
			Case upper( alltrim( tcAtributo ) ) == 'PAGINAWEB'
				lcCampo = 'CLPAGEWEB'
			Case upper( alltrim( tcAtributo ) ) == 'PROVINCIA'
				lcCampo = 'CLPRV'
			Case upper( alltrim( tcAtributo ) ) == 'EXCLUIDORETENCIONGANANCIAS'
				lcCampo = 'EXRETGAN'
			Case upper( alltrim( tcAtributo ) ) == 'EXCLUIDORETENCIONIVA'
				lcCampo = 'EXRETIVA'
			Case upper( alltrim( tcAtributo ) ) == 'CONTACTO'
				lcCampo = 'CLCONTAC'
			Case upper( alltrim( tcAtributo ) ) == 'VIGENCIAHASTAGAN'
				lcCampo = 'PVHASTAGAN'
			Case upper( alltrim( tcAtributo ) ) == 'VIGENCIAHASTAIVA'
				lcCampo = 'PVHASTAIVA'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOINTERNO2'
				lcCampo = 'CLCFI'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGOSIPRIB'
				lcCampo = 'CLSIPRIB'
			Case upper( alltrim( tcAtributo ) ) == 'TASACEROPORCEN'
				lcCampo = 'PORCENTC'
			Case upper( alltrim( tcAtributo ) ) == 'TASACEROAPLICA'
				lcCampo = 'APLICATC'
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
			local  lxProveedFectrans, lxProveedFmodifw, lxProveedFecimpo, lxProveedFaltafw, lxProveedFecexpo, lxProveedCltpo, lxProveedClpun3, lxProveedClpun2, lxProveedClpun4, lxProveedClcan4, lxProveedClpun1, lxProveedCldir, lxProveedCliva, lxProveedClmon2, lxProveedClmon4, lxProveedClmon3, lxProveedClmon1, lxProveedClmonto, lxProveedTimestamp, lxProveedHoraexpo, lxProveedHaltafw, lxProveedHoraimpo, lxProveedZadsfw, lxProveedEsttrans, lxProveedBdaltafw, lxProveedCltlf, lxProveedHmodifw, lxProveedBdmodifw, lxProveedVmodifw, lxProveedValtafw, lxProveedUaltafw, lxProveedUmodifw, lxProveedClimpd, lxProveedSaltafw, lxProveedSmodifw, lxProveedCimagen, lxProveedClcondpag, lxProveedClcod, lxProveedClobs, lxProveedCltipconv, lxProveedClloc, lxProveedClfax, lxProveedClsitgan, lxProveedClobjiva, lxProveedRut, lxProveedCllistpre, lxProveedClretsuss, lxProveedClnroiibb, lxProveedClnom, lxProveedClcuit, lxProveedCltipodoc, lxProveedClemplead, lxProveedExretsuss, lxProveedClemail, lxProveedClcp, lxProveedClretgan, lxProveedClretiva, lxProveedClnrodoc, lxProveedClsujvinc, lxProveedClpageweb, lxProveedClprv, lxProveedExretgan, lxProveedExretiva, lxProveedClcontac, lxProveedPvhastagan, lxProveedPvhastaiva, lxProveedClcfi, lxProveedClsiprib, lxProveedPorcentc, lxProveedAplicatc
				lxProveedFectrans =  .Fechatransferencia			lxProveedFmodifw =  .Fechamodificacionfw			lxProveedFecimpo =  .Fechaimpo			lxProveedFaltafw =  .Fechaaltafw			lxProveedFecexpo =  .Fechaexpo			lxProveedCltpo =  .Tipointerno			lxProveedClpun3 =  .Formula4			lxProveedClpun2 =  .Formula3			lxProveedClpun4 =  .Formula5			lxProveedClcan4 =  .Formula1			lxProveedClpun1 =  .Formula2			lxProveedCldir =  .Direccion			lxProveedCliva =  .Situacionfiscal_PK 			lxProveedClmon2 =  .Sobreprecio3			lxProveedClmon4 =  .Sobreprecio5			lxProveedClmon3 =  .Sobreprecio4			lxProveedClmon1 =  .Sobreprecio2			lxProveedClmonto =  .Sobreprecio1			lxProveedTimestamp = goLibrerias.ObtenerTimestamp()			lxProveedHoraexpo =  .Horaexpo			lxProveedHaltafw =  .Horaaltafw			lxProveedHoraimpo =  .Horaimpo			lxProveedZadsfw =  .Zadsfw			lxProveedEsttrans =  .Estadotransferencia			lxProveedBdaltafw =  .Basededatosaltafw			lxProveedCltlf =  .Telefono			lxProveedHmodifw =  .Horamodificacionfw			lxProveedBdmodifw =  .Basededatosmodificacionfw			lxProveedVmodifw =  .Versionmodificacionfw			lxProveedValtafw =  .Versionaltafw			lxProveedUaltafw =  .Usuarioaltafw			lxProveedUmodifw =  .Usuariomodificacionfw			lxProveedClimpd =  .Clasificacion			lxProveedSaltafw =  .Seriealtafw			lxProveedSmodifw =  .Seriemodificacionfw			lxProveedCimagen =  .Imagen			lxProveedClcondpag =  upper( .CondicionDePago_PK ) 			lxProveedClcod =  .Codigo			lxProveedClobs =  .Observacion			lxProveedCltipconv =  .Tipoconvenio			lxProveedClloc =  .Localidad			lxProveedClfax =  .Fax			lxProveedClsitgan =  .Situacionganancias			lxProveedClobjiva =  .Objetoiva			lxProveedRut =  .Rut			lxProveedCllistpre =  upper( .ListaDePrecio_PK ) 			lxProveedClretsuss =  upper( .RetencionSuss_PK ) 			lxProveedClnroiibb =  .Nroiibb			lxProveedClnom =  .Nombre			lxProveedClcuit =  .Cuit			lxProveedCltipodoc =  .Tipodocumento			lxProveedClemplead =  .Empleador			lxProveedExretsuss =  .Excluidoretencionsuss			lxProveedClemail =  .Email			lxProveedClcp =  .Codigopostal			lxProveedClretgan =  upper( .RetencionGanancias_PK ) 			lxProveedClretiva =  upper( .RetencionIva_PK ) 			lxProveedClnrodoc =  .Nrodocumento			lxProveedClsujvinc =  .Sujetovinculado			lxProveedClpageweb =  .Paginaweb			lxProveedClprv =  upper( .Provincia_PK ) 			lxProveedExretgan =  .Excluidoretencionganancias			lxProveedExretiva =  .Excluidoretencioniva			lxProveedClcontac =  .Contacto			lxProveedPvhastagan =  .Vigenciahastagan			lxProveedPvhastaiva =  .Vigenciahastaiva			lxProveedClcfi =  .Tipointerno2			lxProveedClsiprib =  upper( .CodigoSiprib_PK ) 			lxProveedPorcentc =  .Tasaceroporcen			lxProveedAplicatc =  .Tasaceroaplica
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.PROVEED ( "Fectrans","Fmodifw","Fecimpo","Faltafw","Fecexpo","Cltpo","Clpun3","Clpun2","Clpun4","Clcan4","Clpun1","Cldir","Cliva","Clmon2","Clmon4","Clmon3","Clmon1","Clmonto","Timestamp","Horaexpo","Haltafw","Horaimpo","Zadsfw","Esttrans","Bdaltafw","Cltlf","Hmodifw","Bdmodifw","Vmodifw","Valtafw","Ualtafw","Umodifw","Climpd","Saltafw","Smodifw","Cimagen","Clcondpag","Clcod","Clobs","Cltipconv","Clloc","Clfax","Clsitgan","Clobjiva","Rut","Cllistpre","Clretsuss","Clnroiibb","Clnom","Clcuit","Cltipodoc","Clemplead","Exretsuss","Clemail","Clcp","Clretgan","Clretiva","Clnrodoc","Clsujvinc","Clpageweb","Clprv","Exretgan","Exretiva","Clcontac","Pvhastagan","Pvhastaiva","Clcfi","Clsiprib","Porcentc","Aplicatc" ) values ( <<"'" + this.ConvertirDateSql( lxProveedFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxProveedFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxProveedFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxProveedFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxProveedFecexpo ) + "'" >>, <<lxProveedCltpo >>, <<lxProveedClpun3 >>, <<lxProveedClpun2 >>, <<lxProveedClpun4 >>, <<lxProveedClcan4 >>, <<lxProveedClpun1 >>, <<"'" + this.FormatearTextoSql( lxProveedCldir ) + "'" >>, <<lxProveedCliva >>, <<lxProveedClmon2 >>, <<lxProveedClmon4 >>, <<lxProveedClmon3 >>, <<lxProveedClmon1 >>, <<lxProveedClmonto >>, <<lxProveedTimestamp >>, <<"'" + this.FormatearTextoSql( lxProveedHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProveedHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProveedHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProveedZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProveedEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProveedBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProveedCltlf ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProveedHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProveedBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProveedVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProveedValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProveedUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProveedUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProveedClimpd ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProveedSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProveedSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProveedCimagen ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProveedClcondpag ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProveedClcod ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProveedClobs ) + "'" >>, <<lxProveedCltipconv >>, <<"'" + this.FormatearTextoSql( lxProveedClloc ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProveedClfax ) + "'" >>, <<lxProveedClsitgan >>, <<lxProveedClobjiva >>, <<"'" + this.FormatearTextoSql( lxProveedRut ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProveedCllistpre ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProveedClretsuss ) + "'" >>, <<lxProveedClnroiibb >>, <<"'" + this.FormatearTextoSql( lxProveedClnom ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProveedClcuit ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProveedCltipodoc ) + "'" >>, <<iif( lxProveedClemplead, 1, 0 ) >>, <<iif( lxProveedExretsuss, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxProveedClemail ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProveedClcp ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProveedClretgan ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProveedClretiva ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProveedClnrodoc ) + "'" >>, <<iif( lxProveedClsujvinc, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxProveedClpageweb ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProveedClprv ) + "'" >>, <<iif( lxProveedExretgan, 1, 0 ) >>, <<iif( lxProveedExretiva, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxProveedClcontac ) + "'" >>, <<"'" + this.ConvertirDateSql( lxProveedPvhastagan ) + "'" >>, <<"'" + this.ConvertirDateSql( lxProveedPvhastaiva ) + "'" >>, <<lxProveedClcfi >>, <<"'" + this.FormatearTextoSql( lxProveedClsiprib ) + "'" >>, <<lxProveedPorcentc >>, <<iif( lxProveedAplicatc, 1, 0 ) >> )
		endtext
		loColeccion.cTabla = 'PROVEED' 
		loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		With this
			local lcValorClavePrimariaString as String
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

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
			local  lxProveedFectrans, lxProveedFmodifw, lxProveedFecimpo, lxProveedFaltafw, lxProveedFecexpo, lxProveedCltpo, lxProveedClpun3, lxProveedClpun2, lxProveedClpun4, lxProveedClcan4, lxProveedClpun1, lxProveedCldir, lxProveedCliva, lxProveedClmon2, lxProveedClmon4, lxProveedClmon3, lxProveedClmon1, lxProveedClmonto, lxProveedTimestamp, lxProveedHoraexpo, lxProveedHaltafw, lxProveedHoraimpo, lxProveedZadsfw, lxProveedEsttrans, lxProveedBdaltafw, lxProveedCltlf, lxProveedHmodifw, lxProveedBdmodifw, lxProveedVmodifw, lxProveedValtafw, lxProveedUaltafw, lxProveedUmodifw, lxProveedClimpd, lxProveedSaltafw, lxProveedSmodifw, lxProveedCimagen, lxProveedClcondpag, lxProveedClcod, lxProveedClobs, lxProveedCltipconv, lxProveedClloc, lxProveedClfax, lxProveedClsitgan, lxProveedClobjiva, lxProveedRut, lxProveedCllistpre, lxProveedClretsuss, lxProveedClnroiibb, lxProveedClnom, lxProveedClcuit, lxProveedCltipodoc, lxProveedClemplead, lxProveedExretsuss, lxProveedClemail, lxProveedClcp, lxProveedClretgan, lxProveedClretiva, lxProveedClnrodoc, lxProveedClsujvinc, lxProveedClpageweb, lxProveedClprv, lxProveedExretgan, lxProveedExretiva, lxProveedClcontac, lxProveedPvhastagan, lxProveedPvhastaiva, lxProveedClcfi, lxProveedClsiprib, lxProveedPorcentc, lxProveedAplicatc
				lxProveedFectrans =  .Fechatransferencia			lxProveedFmodifw =  .Fechamodificacionfw			lxProveedFecimpo =  .Fechaimpo			lxProveedFaltafw =  .Fechaaltafw			lxProveedFecexpo =  .Fechaexpo			lxProveedCltpo =  .Tipointerno			lxProveedClpun3 =  .Formula4			lxProveedClpun2 =  .Formula3			lxProveedClpun4 =  .Formula5			lxProveedClcan4 =  .Formula1			lxProveedClpun1 =  .Formula2			lxProveedCldir =  .Direccion			lxProveedCliva =  .Situacionfiscal_PK 			lxProveedClmon2 =  .Sobreprecio3			lxProveedClmon4 =  .Sobreprecio5			lxProveedClmon3 =  .Sobreprecio4			lxProveedClmon1 =  .Sobreprecio2			lxProveedClmonto =  .Sobreprecio1			lxProveedTimestamp = goLibrerias.ObtenerTimestamp()			lxProveedHoraexpo =  .Horaexpo			lxProveedHaltafw =  .Horaaltafw			lxProveedHoraimpo =  .Horaimpo			lxProveedZadsfw =  .Zadsfw			lxProveedEsttrans =  .Estadotransferencia			lxProveedBdaltafw =  .Basededatosaltafw			lxProveedCltlf =  .Telefono			lxProveedHmodifw =  .Horamodificacionfw			lxProveedBdmodifw =  .Basededatosmodificacionfw			lxProveedVmodifw =  .Versionmodificacionfw			lxProveedValtafw =  .Versionaltafw			lxProveedUaltafw =  .Usuarioaltafw			lxProveedUmodifw =  .Usuariomodificacionfw			lxProveedClimpd =  .Clasificacion			lxProveedSaltafw =  .Seriealtafw			lxProveedSmodifw =  .Seriemodificacionfw			lxProveedCimagen =  .Imagen			lxProveedClcondpag =  upper( .CondicionDePago_PK ) 			lxProveedClcod =  .Codigo			lxProveedClobs =  .Observacion			lxProveedCltipconv =  .Tipoconvenio			lxProveedClloc =  .Localidad			lxProveedClfax =  .Fax			lxProveedClsitgan =  .Situacionganancias			lxProveedClobjiva =  .Objetoiva			lxProveedRut =  .Rut			lxProveedCllistpre =  upper( .ListaDePrecio_PK ) 			lxProveedClretsuss =  upper( .RetencionSuss_PK ) 			lxProveedClnroiibb =  .Nroiibb			lxProveedClnom =  .Nombre			lxProveedClcuit =  .Cuit			lxProveedCltipodoc =  .Tipodocumento			lxProveedClemplead =  .Empleador			lxProveedExretsuss =  .Excluidoretencionsuss			lxProveedClemail =  .Email			lxProveedClcp =  .Codigopostal			lxProveedClretgan =  upper( .RetencionGanancias_PK ) 			lxProveedClretiva =  upper( .RetencionIva_PK ) 			lxProveedClnrodoc =  .Nrodocumento			lxProveedClsujvinc =  .Sujetovinculado			lxProveedClpageweb =  .Paginaweb			lxProveedClprv =  upper( .Provincia_PK ) 			lxProveedExretgan =  .Excluidoretencionganancias			lxProveedExretiva =  .Excluidoretencioniva			lxProveedClcontac =  .Contacto			lxProveedPvhastagan =  .Vigenciahastagan			lxProveedPvhastaiva =  .Vigenciahastaiva			lxProveedClcfi =  .Tipointerno2			lxProveedClsiprib =  upper( .CodigoSiprib_PK ) 			lxProveedPorcentc =  .Tasaceroporcen			lxProveedAplicatc =  .Tasaceroaplica
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Clcod" = ] + lcValorClavePrimariaString  + [ and  PROVEED.CLCOD != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.PROVEED set "Fectrans" = <<"'" + this.ConvertirDateSql( lxProveedFectrans ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxProveedFmodifw ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxProveedFecimpo ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxProveedFaltafw ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxProveedFecexpo ) + "'">>, "Cltpo" = <<lxProveedCltpo>>, "Clpun3" = <<lxProveedClpun3>>, "Clpun2" = <<lxProveedClpun2>>, "Clpun4" = <<lxProveedClpun4>>, "Clcan4" = <<lxProveedClcan4>>, "Clpun1" = <<lxProveedClpun1>>, "Cldir" = <<"'" + this.FormatearTextoSql( lxProveedCldir ) + "'">>, "Cliva" = <<lxProveedCliva>>, "Clmon2" = <<lxProveedClmon2>>, "Clmon4" = <<lxProveedClmon4>>, "Clmon3" = <<lxProveedClmon3>>, "Clmon1" = <<lxProveedClmon1>>, "Clmonto" = <<lxProveedClmonto>>, "Timestamp" = <<lxProveedTimestamp>>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxProveedHoraexpo ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxProveedHaltafw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxProveedHoraimpo ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxProveedZadsfw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxProveedEsttrans ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxProveedBdaltafw ) + "'">>, "Cltlf" = <<"'" + this.FormatearTextoSql( lxProveedCltlf ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxProveedHmodifw ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxProveedBdmodifw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxProveedVmodifw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxProveedValtafw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxProveedUaltafw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxProveedUmodifw ) + "'">>, "Climpd" = <<"'" + this.FormatearTextoSql( lxProveedClimpd ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxProveedSaltafw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxProveedSmodifw ) + "'">>, "Cimagen" = <<"'" + this.FormatearTextoSql( lxProveedCimagen ) + "'">>, "Clcondpag" = <<"'" + this.FormatearTextoSql( lxProveedClcondpag ) + "'">>, "Clcod" = <<"'" + this.FormatearTextoSql( lxProveedClcod ) + "'">>, "Clobs" = <<"'" + this.FormatearTextoSql( lxProveedClobs ) + "'">>, "Cltipconv" = <<lxProveedCltipconv>>, "Clloc" = <<"'" + this.FormatearTextoSql( lxProveedClloc ) + "'">>, "Clfax" = <<"'" + this.FormatearTextoSql( lxProveedClfax ) + "'">>, "Clsitgan" = <<lxProveedClsitgan>>, "Clobjiva" = <<lxProveedClobjiva>>, "Rut" = <<"'" + this.FormatearTextoSql( lxProveedRut ) + "'">>, "Cllistpre" = <<"'" + this.FormatearTextoSql( lxProveedCllistpre ) + "'">>, "Clretsuss" = <<"'" + this.FormatearTextoSql( lxProveedClretsuss ) + "'">>, "Clnroiibb" = <<lxProveedClnroiibb>>, "Clnom" = <<"'" + this.FormatearTextoSql( lxProveedClnom ) + "'">>, "Clcuit" = <<"'" + this.FormatearTextoSql( lxProveedClcuit ) + "'">>, "Cltipodoc" = <<"'" + this.FormatearTextoSql( lxProveedCltipodoc ) + "'">>, "Clemplead" = <<iif( lxProveedClemplead, 1, 0 )>>, "Exretsuss" = <<iif( lxProveedExretsuss, 1, 0 )>>, "Clemail" = <<"'" + this.FormatearTextoSql( lxProveedClemail ) + "'">>, "Clcp" = <<"'" + this.FormatearTextoSql( lxProveedClcp ) + "'">>, "Clretgan" = <<"'" + this.FormatearTextoSql( lxProveedClretgan ) + "'">>, "Clretiva" = <<"'" + this.FormatearTextoSql( lxProveedClretiva ) + "'">>, "Clnrodoc" = <<"'" + this.FormatearTextoSql( lxProveedClnrodoc ) + "'">>, "Clsujvinc" = <<iif( lxProveedClsujvinc, 1, 0 )>>, "Clpageweb" = <<"'" + this.FormatearTextoSql( lxProveedClpageweb ) + "'">>, "Clprv" = <<"'" + this.FormatearTextoSql( lxProveedClprv ) + "'">>, "Exretgan" = <<iif( lxProveedExretgan, 1, 0 )>>, "Exretiva" = <<iif( lxProveedExretiva, 1, 0 )>>, "Clcontac" = <<"'" + this.FormatearTextoSql( lxProveedClcontac ) + "'">>, "Pvhastagan" = <<"'" + this.ConvertirDateSql( lxProveedPvhastagan ) + "'">>, "Pvhastaiva" = <<"'" + this.ConvertirDateSql( lxProveedPvhastaiva ) + "'">>, "Clcfi" = <<lxProveedClcfi>>, "Clsiprib" = <<"'" + this.FormatearTextoSql( lxProveedClsiprib ) + "'">>, "Porcentc" = <<lxProveedPorcentc>>, "Aplicatc" = <<iif( lxProveedAplicatc, 1, 0 )>> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'PROVEED' 
		loColeccion.agregar( strtran(  lcSentencia, chr( 9 ), '' ) )
			loColeccion.Agregar([delete from ZooLogic.RetProDet where "Cod" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")

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

			lcFiltro = ["Clcod" = ] + lcValorClavePrimariaString  + [ and  PROVEED.CLCOD != '']
		loColeccion.Agregar( 'delete from ZooLogic.PROVEED where ' + lcFiltro )
			loColeccion.Agregar([delete from ZooLogic.RetProDet where "Cod" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.cTabla = 'PROVEED' 
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
			lcRetorno = [update ZooLogic.PROVEED set TimeStamp = ] + transform( lnTimeStamp ) + lcUpdateRealTime + [ where CLCOD = ] + "'" + this.FormatearTextoSql( .Codigo ) + "'" + [ and  PROVEED.CLCOD != ''] + goServicios.RealTime.ObtenerTagEstimulo( .cNombre )
		
		endwith
		return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function ObtenerCantidadRegistros() as integer
		local lnCantReg as integer
			local lcXml as string
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.PROVEED where  PROVEED.CLCOD != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.PROVEED where CLCOD = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  PROVEED.CLCOD != ''" )
			this.xmlacursor( lcXml, lcCursor )
		if reccount( lcCursor ) > 0
			lnTimeStamp = &lcCursor..Timestamp
		endif
		use in select( lcCursor )

		return lnTimeStamp 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirCabecera( tlLoguear as Boolean ) As Void
		local lcCursor as String, ldFecha as Date, lcHora as string, lcValorABuscar As String, lxValorClavePK As variant, lxValorClavePrimaria As variant, lcIdentificadorParaLoguear as string, lxPROVEEDCLTIPCONV as variant, lxPROVEEDRUT as variant, lxPROVEEDCLNROIIBB as variant, lcMensajeExtra as String
		lcValorABuscar = ''
		lxValorClavePK = ''
		lcMensajeExtra = ''
		lcCursor = This.oEntidad.cPrefijoRecibir + 'PROVEEDOR'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.PROVEED Where CLCOD = ] + "'" + this.FormatearTextoSql( &lcCursor..CLCOD ) + "'", 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					this.oConexion.EjecutarSql( [UPDATE ZooLogic.PROVEED set  FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, CLTPO = ] + transform( &lcCursor..CLTPO )+ [, CLPUN3 = ] + transform( &lcCursor..CLPUN3 )+ [, CLPUN2 = ] + transform( &lcCursor..CLPUN2 )+ [, CLPUN4 = ] + transform( &lcCursor..CLPUN4 )+ [, CLCAN4 = ] + transform( &lcCursor..CLCAN4 )+ [, CLPUN1 = ] + transform( &lcCursor..CLPUN1 )+ [, CLDIR = ] + "'" + this.FormatearTextoSql( &lcCursor..CLDIR ) + "'"+ [, CLIVA = ] + transform( &lcCursor..CLIVA )+ [, CLMON2 = ] + transform( &lcCursor..CLMON2 )+ [, CLMON4 = ] + transform( &lcCursor..CLMON4 )+ [, CLMON3 = ] + transform( &lcCursor..CLMON3 )+ [, CLMON1 = ] + transform( &lcCursor..CLMON1 )+ [, CLMONTO = ] + transform( &lcCursor..CLMONTO )+ [, TIMESTAMP = ] + transform( &lcCursor..TIMESTAMP )+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, CLTLF = ] + "'" + this.FormatearTextoSql( &lcCursor..CLTLF ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, CLIMPD = ] + "'" + this.FormatearTextoSql( &lcCursor..CLIMPD ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, CIMAGEN = ] + "'" + this.FormatearTextoSql( &lcCursor..CIMAGEN ) + "'"+ [, CLCONDPAG = ] + "'" + this.FormatearTextoSql( &lcCursor..CLCONDPAG ) + "'"+ [, CLCOD = ] + "'" + this.FormatearTextoSql( &lcCursor..CLCOD ) + "'"+ [, CLOBS = ] + "'" + this.FormatearTextoSql( &lcCursor..CLOBS ) + "'"+ [, CLTIPCONV = ] + transform( &lcCursor..CLTIPCONV )+ [, CLLOC = ] + "'" + this.FormatearTextoSql( &lcCursor..CLLOC ) + "'"+ [, CLFAX = ] + "'" + this.FormatearTextoSql( &lcCursor..CLFAX ) + "'"+ [, CLSITGAN = ] + transform( &lcCursor..CLSITGAN )+ [, CLOBJIVA = ] + transform( &lcCursor..CLOBJIVA )+ [, RUT = ] + "'" + this.FormatearTextoSql( &lcCursor..RUT ) + "'"+ [, CLLISTPRE = ] + "'" + this.FormatearTextoSql( &lcCursor..CLLISTPRE ) + "'"+ [, CLRETSUSS = ] + "'" + this.FormatearTextoSql( &lcCursor..CLRETSUSS ) + "'"+ [, CLNROIIBB = ] + transform( &lcCursor..CLNROIIBB )+ [, CLNOM = ] + "'" + this.FormatearTextoSql( &lcCursor..CLNOM ) + "'"+ [, CLCUIT = ] + "'" + this.FormatearTextoSql( &lcCursor..CLCUIT ) + "'"+ [, CLTIPODOC = ] + "'" + this.FormatearTextoSql( &lcCursor..CLTIPODOC ) + "'"+ [, CLEMPLEAD = ] + Transform( iif( &lcCursor..CLEMPLEAD, 1, 0 ))+ [, EXRETSUSS = ] + Transform( iif( &lcCursor..EXRETSUSS, 1, 0 ))+ [, CLEMAIL = ] + "'" + this.FormatearTextoSql( &lcCursor..CLEMAIL ) + "'"+ [, CLCP = ] + "'" + this.FormatearTextoSql( &lcCursor..CLCP ) + "'"+ [, CLRETGAN = ] + "'" + this.FormatearTextoSql( &lcCursor..CLRETGAN ) + "'"+ [, CLRETIVA = ] + "'" + this.FormatearTextoSql( &lcCursor..CLRETIVA ) + "'"+ [, CLNRODOC = ] + "'" + this.FormatearTextoSql( &lcCursor..CLNRODOC ) + "'"+ [, ClSujVinc = ] + Transform( iif( &lcCursor..ClSujVinc, 1, 0 ))+ [, CLPAGEWEB = ] + "'" + this.FormatearTextoSql( &lcCursor..CLPAGEWEB ) + "'"+ [, CLPRV = ] + "'" + this.FormatearTextoSql( &lcCursor..CLPRV ) + "'"+ [, EXRETGAN = ] + Transform( iif( &lcCursor..EXRETGAN, 1, 0 ))+ [, EXRETIVA = ] + Transform( iif( &lcCursor..EXRETIVA, 1, 0 ))+ [, CLCONTAC = ] + "'" + this.FormatearTextoSql( &lcCursor..CLCONTAC ) + "'"+ [, PVHastaGan = ] + "'" + this.ConvertirDateSql( &lcCursor..PVHastaGan ) + "'"+ [, PVHastaIva = ] + "'" + this.ConvertirDateSql( &lcCursor..PVHastaIva ) + "'"+ [, CLCFI = ] + transform( &lcCursor..CLCFI )+ [, CLSIPRIB = ] + "'" + this.FormatearTextoSql( &lcCursor..CLSIPRIB ) + "'"+ [, PorcenTC = ] + transform( &lcCursor..PorcenTC )+ [, AplicaTC = ] + Transform( iif( &lcCursor..AplicaTC, 1, 0 )) + [ Where CLCOD = ] + "'" + this.FormatearTextoSql( &lcCursor..CLCOD ) + "'" )
					lcCampo = lcCursor + '.' + this.cCampoCodigoWH
					this.AgregarMensajeWebHook( 'MODIFICAR', &lcCampo )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
				endIf
			else
				Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
				Text to lcCampos noShow
					 FECTRANS, FMODIFW, FECIMPO, FALTAFW, FECEXPO, CLTPO, CLPUN3, CLPUN2, CLPUN4, CLCAN4, CLPUN1, CLDIR, CLIVA, CLMON2, CLMON4, CLMON3, CLMON1, CLMONTO, TIMESTAMP, HORAEXPO, HALTAFW, HORAIMPO, ZADSFW, ESTTRANS, BDALTAFW, CLTLF, HMODIFW, BDMODIFW, VMODIFW, VALTAFW, UALTAFW, UMODIFW, CLIMPD, SALTAFW, SMODIFW, CIMAGEN, CLCONDPAG, CLCOD, CLOBS, CLTIPCONV, CLLOC, CLFAX, CLSITGAN, CLOBJIVA, RUT, CLLISTPRE, CLRETSUSS, CLNROIIBB, CLNOM, CLCUIT, CLTIPODOC, CLEMPLEAD, EXRETSUSS, CLEMAIL, CLCP, CLRETGAN, CLRETIVA, CLNRODOC, ClSujVinc, CLPAGEWEB, CLPRV, EXRETGAN, EXRETIVA, CLCONTAC, PVHastaGan, PVHastaIva, CLCFI, CLSIPRIB, PorcenTC, AplicaTC
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + transform( &lcCursor..CLTPO ) + ',' + transform( &lcCursor..CLPUN3 ) + ',' + transform( &lcCursor..CLPUN2 )
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..CLPUN4 ) + ',' + transform( &lcCursor..CLCAN4 ) + ',' + transform( &lcCursor..CLPUN1 ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLDIR ) + "'" + ',' + transform( &lcCursor..CLIVA ) + ',' + transform( &lcCursor..CLMON2 ) + ',' + transform( &lcCursor..CLMON4 ) + ',' + transform( &lcCursor..CLMON3 ) + ',' + transform( &lcCursor..CLMON1 ) + ',' + transform( &lcCursor..CLMONTO )
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..TIMESTAMP ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLTLF ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLIMPD ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CIMAGEN ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLCONDPAG ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLCOD ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLOBS ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..CLTIPCONV ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLLOC ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLFAX ) + "'" + ',' + transform( &lcCursor..CLSITGAN ) + ',' + transform( &lcCursor..CLOBJIVA ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..RUT ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLLISTPRE ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLRETSUSS ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..CLNROIIBB ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLNOM ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLCUIT ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLTIPODOC ) + "'" + ',' + Transform( iif( &lcCursor..CLEMPLEAD, 1, 0 )) + ',' + Transform( iif( &lcCursor..EXRETSUSS, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLEMAIL ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLCP ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLRETGAN ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLRETIVA ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLNRODOC ) + "'" + ',' + Transform( iif( &lcCursor..ClSujVinc, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLPAGEWEB ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLPRV ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + Transform( iif( &lcCursor..EXRETGAN, 1, 0 )) + ',' + Transform( iif( &lcCursor..EXRETIVA, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLCONTAC ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..PVHastaGan ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..PVHastaIva ) + "'" + ',' + transform( &lcCursor..CLCFI ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLSIPRIB ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..PorcenTC ) + ',' + Transform( iif( &lcCursor..AplicaTC, 1, 0 ))
lcValoresCampos = substr(lcValoresCampos,2) 

				this.oConexion.EjecutarSql( [Insert into ZooLogic.PROVEED ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
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
			this.oConexion.EjecutarSql( [Delete From ZooLogic.RetProDet Where Cod] + lcIn  )
			endfor
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'COMMIT TRANSACTION' )
			endif
		EndIf
	endif
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
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearCursorMemo( tcCursorACrear as String, tcTablaConMemo as String ) as Void
		create cursor &tcCursorACrear ( CLCOD C (5) , Orden N(16), texto C(80))
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_PROVEED')

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
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  PVHastaGan
		* Validar ANTERIORES A 1/1/1753  PVHastaIva
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_PROVEED') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_PROVEED
Create Table ZooLogic.TablaTrabajo_PROVEED ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fectrans" datetime  null, 
"fmodifw" datetime  null, 
"fecimpo" datetime  null, 
"faltafw" datetime  null, 
"fecexpo" datetime  null, 
"cltpo" numeric( 1, 0 )  null, 
"clpun3" numeric( 1, 0 )  null, 
"clpun2" numeric( 1, 0 )  null, 
"clpun4" numeric( 1, 0 )  null, 
"clcan4" numeric( 1, 0 )  null, 
"clpun1" numeric( 1, 0 )  null, 
"cldir" char( 70 )  null, 
"cliva" numeric( 2, 0 )  null, 
"clmon2" numeric( 16, 2 )  null, 
"clmon4" numeric( 16, 2 )  null, 
"clmon3" numeric( 16, 2 )  null, 
"clmon1" numeric( 16, 2 )  null, 
"clmonto" numeric( 16, 2 )  null, 
"timestamp" numeric( 20, 0 )  null, 
"horaexpo" char( 8 )  null, 
"haltafw" char( 8 )  null, 
"horaimpo" char( 8 )  null, 
"zadsfw" varchar(max)  null, 
"esttrans" char( 20 )  null, 
"bdaltafw" char( 8 )  null, 
"cltlf" char( 30 )  null, 
"hmodifw" char( 8 )  null, 
"bdmodifw" char( 8 )  null, 
"vmodifw" char( 13 )  null, 
"valtafw" char( 13 )  null, 
"ualtafw" char( 100 )  null, 
"umodifw" char( 100 )  null, 
"climpd" char( 8 )  null, 
"saltafw" char( 7 )  null, 
"smodifw" char( 7 )  null, 
"cimagen" char( 180 )  null, 
"clcondpag" char( 5 )  null, 
"clcod" char( 5 )  null, 
"clobs" varchar(max)  null, 
"cltipconv" numeric( 1, 0 )  null, 
"clloc" char( 70 )  null, 
"clfax" char( 60 )  null, 
"clsitgan" numeric( 1, 0 )  null, 
"clobjiva" numeric( 1, 0 )  null, 
"rut" char( 12 )  null, 
"cllistpre" char( 6 )  null, 
"clretsuss" char( 10 )  null, 
"clnroiibb" numeric( 11, 0 )  null, 
"clnom" char( 60 )  null, 
"clcuit" char( 15 )  null, 
"cltipodoc" char( 2 )  null, 
"clemplead" bit  null, 
"exretsuss" bit  null, 
"clemail" char( 60 )  null, 
"clcp" char( 8 )  null, 
"clretgan" char( 10 )  null, 
"clretiva" char( 10 )  null, 
"clnrodoc" char( 10 )  null, 
"clsujvinc" bit  null, 
"clpageweb" char( 60 )  null, 
"clprv" char( 2 )  null, 
"exretgan" bit  null, 
"exretiva" bit  null, 
"clcontac" char( 60 )  null, 
"pvhastagan" datetime  null, 
"pvhastaiva" datetime  null, 
"clcfi" numeric( 1, 0 )  null, 
"clsiprib" char( 20 )  null, 
"porcentc" numeric( 6, 2 )  null, 
"aplicatc" bit  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_PROVEED' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_PROVEED' )
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
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('cltpo','cltpo')
			.AgregarMapeo('clpun3','clpun3')
			.AgregarMapeo('clpun2','clpun2')
			.AgregarMapeo('clpun4','clpun4')
			.AgregarMapeo('clcan4','clcan4')
			.AgregarMapeo('clpun1','clpun1')
			.AgregarMapeo('cldir','cldir')
			.AgregarMapeo('cliva','cliva')
			.AgregarMapeo('clmon2','clmon2')
			.AgregarMapeo('clmon4','clmon4')
			.AgregarMapeo('clmon3','clmon3')
			.AgregarMapeo('clmon1','clmon1')
			.AgregarMapeo('clmonto','clmonto')
			.AgregarMapeo('timestamp','timestamp')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('cltlf','cltlf')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('climpd','climpd')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('cimagen','cimagen')
			.AgregarMapeo('clcondpag','clcondpag')
			.AgregarMapeo('clcod','clcod')
			.AgregarMapeo('clobs','clobs')
			.AgregarMapeo('cltipconv','cltipconv')
			.AgregarMapeo('clloc','clloc')
			.AgregarMapeo('clfax','clfax')
			.AgregarMapeo('clsitgan','clsitgan')
			.AgregarMapeo('clobjiva','clobjiva')
			.AgregarMapeo('rut','rut')
			.AgregarMapeo('cllistpre','cllistpre')
			.AgregarMapeo('clretsuss','clretsuss')
			.AgregarMapeo('clnroiibb','clnroiibb')
			.AgregarMapeo('clnom','clnom')
			.AgregarMapeo('clcuit','clcuit')
			.AgregarMapeo('cltipodoc','cltipodoc')
			.AgregarMapeo('clemplead','clemplead')
			.AgregarMapeo('exretsuss','exretsuss')
			.AgregarMapeo('clemail','clemail')
			.AgregarMapeo('clcp','clcp')
			.AgregarMapeo('clretgan','clretgan')
			.AgregarMapeo('clretiva','clretiva')
			.AgregarMapeo('clnrodoc','clnrodoc')
			.AgregarMapeo('clsujvinc','clsujvinc')
			.AgregarMapeo('clpageweb','clpageweb')
			.AgregarMapeo('clprv','clprv')
			.AgregarMapeo('exretgan','exretgan')
			.AgregarMapeo('exretiva','exretiva')
			.AgregarMapeo('clcontac','clcontac')
			.AgregarMapeo('pvhastagan','pvhastagan')
			.AgregarMapeo('pvhastaiva','pvhastaiva')
			.AgregarMapeo('clcfi','clcfi')
			.AgregarMapeo('clsiprib','clsiprib')
			.AgregarMapeo('porcentc','porcentc')
			.AgregarMapeo('aplicatc','aplicatc')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_PROVEED'
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
				Update t Set t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.CLTPO = isnull( d.CLTPO, t.CLTPO ),t.CLPUN3 = isnull( d.CLPUN3, t.CLPUN3 ),t.CLPUN2 = isnull( d.CLPUN2, t.CLPUN2 ),t.CLPUN4 = isnull( d.CLPUN4, t.CLPUN4 ),t.CLCAN4 = isnull( d.CLCAN4, t.CLCAN4 ),t.CLPUN1 = isnull( d.CLPUN1, t.CLPUN1 ),t.CLDIR = isnull( d.CLDIR, t.CLDIR ),t.CLIVA = isnull( d.CLIVA, t.CLIVA ),t.CLMON2 = isnull( d.CLMON2, t.CLMON2 ),t.CLMON4 = isnull( d.CLMON4, t.CLMON4 ),t.CLMON3 = isnull( d.CLMON3, t.CLMON3 ),t.CLMON1 = isnull( d.CLMON1, t.CLMON1 ),t.CLMONTO = isnull( d.CLMONTO, t.CLMONTO ),t.TIMESTAMP = isnull( d.TIMESTAMP, t.TIMESTAMP ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.CLTLF = isnull( d.CLTLF, t.CLTLF ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.CLIMPD = isnull( d.CLIMPD, t.CLIMPD ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.CIMAGEN = isnull( d.CIMAGEN, t.CIMAGEN ),t.CLCONDPAG = isnull( d.CLCONDPAG, t.CLCONDPAG ),t.CLCOD = isnull( d.CLCOD, t.CLCOD ),t.CLOBS = isnull( d.CLOBS, t.CLOBS ),t.CLTIPCONV = isnull( d.CLTIPCONV, t.CLTIPCONV ),t.CLLOC = isnull( d.CLLOC, t.CLLOC ),t.CLFAX = isnull( d.CLFAX, t.CLFAX ),t.CLSITGAN = isnull( d.CLSITGAN, t.CLSITGAN ),t.CLOBJIVA = isnull( d.CLOBJIVA, t.CLOBJIVA ),t.RUT = isnull( d.RUT, t.RUT ),t.CLLISTPRE = isnull( d.CLLISTPRE, t.CLLISTPRE ),t.CLRETSUSS = isnull( d.CLRETSUSS, t.CLRETSUSS ),t.CLNROIIBB = isnull( d.CLNROIIBB, t.CLNROIIBB ),t.CLNOM = isnull( d.CLNOM, t.CLNOM ),t.CLCUIT = isnull( d.CLCUIT, t.CLCUIT ),t.CLTIPODOC = isnull( d.CLTIPODOC, t.CLTIPODOC ),t.CLEMPLEAD = isnull( d.CLEMPLEAD, t.CLEMPLEAD ),t.EXRETSUSS = isnull( d.EXRETSUSS, t.EXRETSUSS ),t.CLEMAIL = isnull( d.CLEMAIL, t.CLEMAIL ),t.CLCP = isnull( d.CLCP, t.CLCP ),t.CLRETGAN = isnull( d.CLRETGAN, t.CLRETGAN ),t.CLRETIVA = isnull( d.CLRETIVA, t.CLRETIVA ),t.CLNRODOC = isnull( d.CLNRODOC, t.CLNRODOC ),t.CLSUJVINC = isnull( d.CLSUJVINC, t.CLSUJVINC ),t.CLPAGEWEB = isnull( d.CLPAGEWEB, t.CLPAGEWEB ),t.CLPRV = isnull( d.CLPRV, t.CLPRV ),t.EXRETGAN = isnull( d.EXRETGAN, t.EXRETGAN ),t.EXRETIVA = isnull( d.EXRETIVA, t.EXRETIVA ),t.CLCONTAC = isnull( d.CLCONTAC, t.CLCONTAC ),t.PVHASTAGAN = isnull( d.PVHASTAGAN, t.PVHASTAGAN ),t.PVHASTAIVA = isnull( d.PVHASTAIVA, t.PVHASTAIVA ),t.CLCFI = isnull( d.CLCFI, t.CLCFI ),t.CLSIPRIB = isnull( d.CLSIPRIB, t.CLSIPRIB ),t.PORCENTC = isnull( d.PORCENTC, t.PORCENTC ),t.APLICATC = isnull( d.APLICATC, t.APLICATC )
					from ZooLogic.PROVEED t inner join deleted d 
							 on t.CLCOD = d.CLCOD
				-- Fin Updates
				insert into ZooLogic.PROVEED(Fectrans,Fmodifw,Fecimpo,Faltafw,Fecexpo,Cltpo,Clpun3,Clpun2,Clpun4,Clcan4,Clpun1,Cldir,Cliva,Clmon2,Clmon4,Clmon3,Clmon1,Clmonto,Timestamp,Horaexpo,Haltafw,Horaimpo,Zadsfw,Esttrans,Bdaltafw,Cltlf,Hmodifw,Bdmodifw,Vmodifw,Valtafw,Ualtafw,Umodifw,Climpd,Saltafw,Smodifw,Cimagen,Clcondpag,Clcod,Clobs,Cltipconv,Clloc,Clfax,Clsitgan,Clobjiva,Rut,Cllistpre,Clretsuss,Clnroiibb,Clnom,Clcuit,Cltipodoc,Clemplead,Exretsuss,Clemail,Clcp,Clretgan,Clretiva,Clnrodoc,Clsujvinc,Clpageweb,Clprv,Exretgan,Exretiva,Clcontac,Pvhastagan,Pvhastaiva,Clcfi,Clsiprib,Porcentc,Aplicatc)
					Select isnull( d.FECTRANS,''),isnull( d.FMODIFW,''),isnull( d.FECIMPO,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FECEXPO,''),isnull( d.CLTPO,0),isnull( d.CLPUN3,0),isnull( d.CLPUN2,0),isnull( d.CLPUN4,0),isnull( d.CLCAN4,0),isnull( d.CLPUN1,0),isnull( d.CLDIR,''),isnull( d.CLIVA,0),isnull( d.CLMON2,0),isnull( d.CLMON4,0),isnull( d.CLMON3,0),isnull( d.CLMON1,0),isnull( d.CLMONTO,0),isnull( d.TIMESTAMP,0),isnull( d.HORAEXPO,''),convert( char(8), getdate(), 108 ),isnull( d.HORAIMPO,''),isnull( d.ZADSFW,''),isnull( d.ESTTRANS,''),isnull( d.BDALTAFW,''),isnull( d.CLTLF,''),isnull( d.HMODIFW,''),isnull( d.BDMODIFW,''),isnull( d.VMODIFW,''),isnull( d.VALTAFW,''),isnull( d.UALTAFW,''),isnull( d.UMODIFW,''),isnull( d.CLIMPD,''),isnull( d.SALTAFW,''),isnull( d.SMODIFW,''),isnull( d.CIMAGEN,''),isnull( d.CLCONDPAG,''),isnull( d.CLCOD,''),isnull( d.CLOBS,''),isnull( d.CLTIPCONV,0),isnull( d.CLLOC,''),isnull( d.CLFAX,''),isnull( d.CLSITGAN,0),isnull( d.CLOBJIVA,0),isnull( d.RUT,''),isnull( d.CLLISTPRE,''),isnull( d.CLRETSUSS,''),isnull( d.CLNROIIBB,0),isnull( d.CLNOM,''),isnull( d.CLCUIT,''),isnull( d.CLTIPODOC,''),isnull( d.CLEMPLEAD,0),isnull( d.EXRETSUSS,0),isnull( d.CLEMAIL,''),isnull( d.CLCP,''),isnull( d.CLRETGAN,''),isnull( d.CLRETIVA,''),isnull( d.CLNRODOC,''),isnull( d.CLSUJVINC,0),isnull( d.CLPAGEWEB,''),isnull( d.CLPRV,''),isnull( d.EXRETGAN,0),isnull( d.EXRETIVA,0),isnull( d.CLCONTAC,''),isnull( d.PVHASTAGAN,''),isnull( d.PVHASTAIVA,''),isnull( d.CLCFI,0),isnull( d.CLSIPRIB,''),isnull( d.PORCENTC,0),isnull( d.APLICATC,0)
						From deleted d left join ZooLogic.PROVEED pk 
							 on d.CLCOD = pk.CLCOD
						Where pk.CLCOD Is Null 
				-- Fin Inserts
			End
		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_RetProDet( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_PROVEED_RetProDet
ON ZooLogic.TablaTrabajo_PROVEED_RetProDet
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_PROVEED') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_PROVEED
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
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_PROVEEDOR.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_PROVEEDOR.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_PROVEEDOR.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Tipointerno = nvl( c_PROVEEDOR.Tipointerno, 0 )
					.Formula4 = nvl( c_PROVEEDOR.Formula4, 0 )
					.Formula3 = nvl( c_PROVEEDOR.Formula3, 0 )
					.Formula5 = nvl( c_PROVEEDOR.Formula5, 0 )
					.Formula1 = nvl( c_PROVEEDOR.Formula1, 0 )
					.Formula2 = nvl( c_PROVEEDOR.Formula2, 0 )
					.Direccion = nvl( c_PROVEEDOR.Direccion, [] )
					.Situacionfiscal_PK =  nvl( c_PROVEEDOR.Situacionfiscal, 0 )
					.Sobreprecio3 = nvl( c_PROVEEDOR.Sobreprecio3, 0 )
					.Sobreprecio5 = nvl( c_PROVEEDOR.Sobreprecio5, 0 )
					.Sobreprecio4 = nvl( c_PROVEEDOR.Sobreprecio4, 0 )
					.Sobreprecio2 = nvl( c_PROVEEDOR.Sobreprecio2, 0 )
					.Sobreprecio1 = nvl( c_PROVEEDOR.Sobreprecio1, 0 )
					.Timestamp = nvl( c_PROVEEDOR.Timestamp, 0 )
					.Horaexpo = nvl( c_PROVEEDOR.Horaexpo, [] )
					.Horaaltafw = nvl( c_PROVEEDOR.Horaaltafw, [] )
					.Horaimpo = nvl( c_PROVEEDOR.Horaimpo, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Estadotransferencia = nvl( c_PROVEEDOR.Estadotransferencia, [] )
					.Basededatosaltafw = nvl( c_PROVEEDOR.Basededatosaltafw, [] )
					.Telefono = nvl( c_PROVEEDOR.Telefono, [] )
					.Horamodificacionfw = nvl( c_PROVEEDOR.Horamodificacionfw, [] )
					.Basededatosmodificacionfw = nvl( c_PROVEEDOR.Basededatosmodificacionfw, [] )
					.Versionmodificacionfw = nvl( c_PROVEEDOR.Versionmodificacionfw, [] )
					.Versionaltafw = nvl( c_PROVEEDOR.Versionaltafw, [] )
					.Usuarioaltafw = nvl( c_PROVEEDOR.Usuarioaltafw, [] )
					.Usuariomodificacionfw = nvl( c_PROVEEDOR.Usuariomodificacionfw, [] )
					.Clasificacion = nvl( c_PROVEEDOR.Clasificacion, [] )
					.Seriealtafw = nvl( c_PROVEEDOR.Seriealtafw, [] )
					.Seriemodificacionfw = nvl( c_PROVEEDOR.Seriemodificacionfw, [] )
					.Imagen = nvl( c_PROVEEDOR.Imagen, [] )
					.Condiciondepago_PK =  nvl( c_PROVEEDOR.Condiciondepago, [] )
					.Codigo = nvl( c_PROVEEDOR.Codigo, [] )
					lcValor = This.ObtenerMemo( 'c_Observacion')
					.Observacion = lcValor 
					.Tipoconvenio = nvl( c_PROVEEDOR.Tipoconvenio, 0 )
					.Localidad = nvl( c_PROVEEDOR.Localidad, [] )
					.Fax = nvl( c_PROVEEDOR.Fax, [] )
					.Situacionganancias = nvl( c_PROVEEDOR.Situacionganancias, 0 )
					.Objetoiva = nvl( c_PROVEEDOR.Objetoiva, 0 )
					.Rut = nvl( c_PROVEEDOR.Rut, [] )
					.Retenciones.Limpiar()
					.Retenciones.SetearEsNavegacion( .lProcesando )
					.Retenciones.Cargar()
					.Listadeprecio_PK =  nvl( c_PROVEEDOR.Listadeprecio, [] )
					.Retencionsuss_PK =  nvl( c_PROVEEDOR.Retencionsuss, [] )
					.Nroiibb = nvl( c_PROVEEDOR.Nroiibb, 0 )
					.Nombre = nvl( c_PROVEEDOR.Nombre, [] )
					.Cuit = nvl( c_PROVEEDOR.Cuit, [] )
					.Tipodocumento = nvl( c_PROVEEDOR.Tipodocumento, [] )
					.Empleador = nvl( c_PROVEEDOR.Empleador, .F. )
					.Excluidoretencionsuss = nvl( c_PROVEEDOR.Excluidoretencionsuss, .F. )
					.Email = nvl( c_PROVEEDOR.Email, [] )
					.Codigopostal = nvl( c_PROVEEDOR.Codigopostal, [] )
					.Retencionganancias_PK =  nvl( c_PROVEEDOR.Retencionganancias, [] )
					.Retencioniva_PK =  nvl( c_PROVEEDOR.Retencioniva, [] )
					.Nrodocumento = nvl( c_PROVEEDOR.Nrodocumento, [] )
					.Sujetovinculado = nvl( c_PROVEEDOR.Sujetovinculado, .F. )
					.Paginaweb = nvl( c_PROVEEDOR.Paginaweb, [] )
					.Provincia_PK =  nvl( c_PROVEEDOR.Provincia, [] )
					.Excluidoretencionganancias = nvl( c_PROVEEDOR.Excluidoretencionganancias, .F. )
					.Excluidoretencioniva = nvl( c_PROVEEDOR.Excluidoretencioniva, .F. )
					.Contacto = nvl( c_PROVEEDOR.Contacto, [] )
					.Vigenciahastagan = GoLibrerias.ObtenerFechaFormateada( nvl( c_PROVEEDOR.Vigenciahastagan, ctod( '  /  /    ' ) ) )
					.Vigenciahastaiva = GoLibrerias.ObtenerFechaFormateada( nvl( c_PROVEEDOR.Vigenciahastaiva, ctod( '  /  /    ' ) ) )
					.Tipointerno2 = nvl( c_PROVEEDOR.Tipointerno2, 0 )
					.Codigosiprib_PK =  nvl( c_PROVEEDOR.Codigosiprib, [] )
					.Tasaceroporcen = nvl( c_PROVEEDOR.Tasaceroporcen, 0 )
					.Tasaceroaplica = nvl( c_PROVEEDOR.Tasaceroaplica, .F. )
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
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.PROVEED' )
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
								from ZooLogic.PROVEED 
								Where   PROVEED.CLCOD != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "PROVEED", "", lcCursor, set("Datasession") )
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
			"Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Cltpo" as "Tipointerno", "Clpun3" as "Formula4", "Clpun2" as "Formula3", "Clpun4" as "Formula5", "Clcan4" as "Formula1", "Clpun1" as "Formula2", "Cldir" as "Direccion", "Cliva" as "Situacionfiscal", "Clmon2" as "Sobreprecio3", "Clmon4" as "Sobreprecio5", "Clmon3" as "Sobreprecio4", "Clmon1" as "Sobreprecio2", "Clmonto" as "Sobreprecio1", "Timestamp" as "Timestamp", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Zadsfw" as "Zadsfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Cltlf" as "Telefono", "Hmodifw" as "Horamodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Climpd" as "Clasificacion", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Cimagen" as "Imagen", "Clcondpag" as "Condiciondepago", "Clcod" as "Codigo", "Clobs" as "Observacion", "Cltipconv" as "Tipoconvenio", "Clloc" as "Localidad", "Clfax" as "Fax", "Clsitgan" as "Situacionganancias", "Clobjiva" as "Objetoiva", "Rut" as "Rut", "Cllistpre" as "Listadeprecio", "Clretsuss" as "Retencionsuss", "Clnroiibb" as "Nroiibb", "Clnom" as "Nombre", "Clcuit" as "Cuit", "Cltipodoc" as "Tipodocumento", "Clemplead" as "Empleador", "Exretsuss" as "Excluidoretencionsuss", "Clemail" as "Email", "Clcp" as "Codigopostal", "Clretgan" as "Retencionganancias", "Clretiva" as "Retencioniva", "Clnrodoc" as "Nrodocumento", "Clsujvinc" as "Sujetovinculado", "Clpageweb" as "Paginaweb", "Clprv" as "Provincia", "Exretgan" as "Excluidoretencionganancias", "Exretiva" as "Excluidoretencioniva", "Clcontac" as "Contacto", "Pvhastagan" as "Vigenciahastagan", "Pvhastaiva" as "Vigenciahastaiva", "Clcfi" as "Tipointerno2", "Clsiprib" as "Codigosiprib", "Porcentc" as "Tasaceroporcen", "Aplicatc" as "Tasaceroaplica"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.PROVEED 
								Where   PROVEED.CLCOD != ''
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
	Tabla = 'PROVEED'
	Filtro = " PROVEED.CLCOD != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " PROVEED.CLCOD != ''"
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
	<row entidad="PROVEEDOR                               " atributo="FECHATRANSFERENCIA                      " tabla="PROVEED        " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha transferencia                                                                                                                                             " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="FECHAMODIFICACIONFW                     " tabla="PROVEED        " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="FECHAIMPO                               " tabla="PROVEED        " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="FECHAALTAFW                             " tabla="PROVEED        " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="FECHAEXPO                               " tabla="PROVEED        " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="TIPOINTERNO                             " tabla="PROVEED        " campo="CLTPO     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="3                                                                                                                                                                                                                                                             " obligatorio="false" admitebusqueda="0" etiqueta="Tipo                                                                                                                                                            " dominio="COMBO                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="FORMULA4                                " tabla="PROVEED        " campo="CLPUN3    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="FORMULA                       " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="7" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="FORMULA3                                " tabla="PROVEED        " campo="CLPUN2    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="FORMULA                       " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="5" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="FORMULA5                                " tabla="PROVEED        " campo="CLPUN4    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="FORMULA                       " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="9" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="FORMULA1                                " tabla="PROVEED        " campo="CLCAN4    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="FORMULA                       " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="1" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="FORMULA2                                " tabla="PROVEED        " campo="CLPUN1    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="FORMULA                       " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="3" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="DIRECCION                               " tabla="PROVEED        " campo="CLDIR     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="70" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="6" etiqueta="Direccion                                                                                                                                                       " dominio="TEXTO                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="SITUACIONFISCAL                         " tabla="PROVEED        " campo="CLIVA     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="SITUACIONFISCAL                         " tipodato="N         " longitud="2" decimales="0" valorsugerido="1                                                                                                                                                                                                                                                             " obligatorio="false" admitebusqueda="400" etiqueta="Situación Fiscal                                                                                                                                                " dominio="COMBOTABLA                    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="1" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="SOBREPRECIO3                            " tabla="PROVEED        " campo="CLMON2    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="16" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Lista 3                                                                                                                                                         " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="4" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="SOBREPRECIO5                            " tabla="PROVEED        " campo="CLMON4    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="16" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Lista 5                                                                                                                                                         " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="8" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="SOBREPRECIO4                            " tabla="PROVEED        " campo="CLMON3    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="16" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Lista 4                                                                                                                                                         " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="6" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="SOBREPRECIO2                            " tabla="PROVEED        " campo="CLMON1    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="16" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Lista 2                                                                                                                                                         " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="2" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="SOBREPRECIO1                            " tabla="PROVEED        " campo="CLMONTO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="16" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Lista 1                                                                                                                                                         " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="TIMESTAMP                               " tabla="PROVEED        " campo="TIMESTAMP " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="HORAEXPO                                " tabla="PROVEED        " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="HORAALTAFW                              " tabla="PROVEED        " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="HORAIMPO                                " tabla="PROVEED        " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="ZADSFW                                  " tabla="PROVEED        " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="ESTADOTRANSFERENCIA                     " tabla="PROVEED        " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado transferencia                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="BASEDEDATOSALTAFW                       " tabla="PROVEED        " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="TELEFONO                                " tabla="PROVEED        " campo="CLTLF     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="10" etiqueta="Telefono                                                                                                                                                        " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="HORAMODIFICACIONFW                      " tabla="PROVEED        " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="PROVEED        " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="VERSIONMODIFICACIONFW                   " tabla="PROVEED        " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="VERSIONALTAFW                           " tabla="PROVEED        " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="USUARIOALTAFW                           " tabla="PROVEED        " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="USUARIOMODIFICACIONFW                   " tabla="PROVEED        " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="CLASIFICACION                           " tabla="PROVEED        " campo="CLIMPD    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Clasificación                                                                                                                                                   " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="4" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="SERIEALTAFW                             " tabla="PROVEED        " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="SERIEMODIFICACIONFW                     " tabla="PROVEED        " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="SITFISCALURUGUAY                        " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="2                                                                                                                                                                                                                                                             " obligatorio="false" admitebusqueda="402" etiqueta="Situación del proveedor                                                                                                                                         " dominio="COMBOXML                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="1" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="IMAGEN                                  " tabla="PROVEED        " campo="CIMAGEN   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="180" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="20" etiqueta="Imagen                                                                                                                                                          " dominio="IMAGENCONRUTADINAMICA         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="3" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="CONDICIONDEPAGO                         " tabla="PROVEED        " campo="CLCONDPAG " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CONDICIONDEPAGO                         " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="404" etiqueta="Condición de pago                                                                                                                                               " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="10" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="CODIGO                                  " tabla="PROVEED        " campo="CLCOD     " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="2" etiqueta="Código                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="OBSERVACION                             " tabla="PROVEED        " campo="CLOBS     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="406" etiqueta="Observaciones                                                                                                                                                   " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="TIPOCONVENIO                            " tabla="PROVEED        " campo="CLTIPCONV " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="408" etiqueta="Tipo de Convenio                                                                                                                                                " dominio="CONVENIOCONNUMEROPROV         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="2" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="LOCALIDAD                               " tabla="PROVEED        " campo="CLLOC     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="70" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="8" etiqueta="Localidad                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="FAX                                     " tabla="PROVEED        " campo="CLFAX     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="410" etiqueta="Fax                                                                                                                                                             " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="SITUACIONGANANCIAS                      " tabla="PROVEED        " campo="CLSITGAN  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="412" etiqueta="Situación                                                                                                                                                       " dominio="COMBOXML                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="4" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="OBJETOIVA                               " tabla="PROVEED        " campo="CLOBJIVA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="414" etiqueta="Actividad                                                                                                                                                       " dominio="COMBOXML                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="6" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="RUT                                     " tabla="PROVEED        " campo="RUT       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="12" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="16" etiqueta="R.U.T.                                                                                                                                                          " dominio="RUT                           " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="RETENCIONES                             " tabla="RETPRODET      " campo="COD       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="416" etiqueta="Retenciones                                                                                                                                                     " dominio="DETALLEITEMRETENCIONES        " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="3" orden="1" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="LISTADEPRECIO                           " tabla="PROVEED        " campo="CLLISTPRE " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="Listadeprecios                          " tipodato="C         " longitud="6" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="418" etiqueta="Lista de precios                                                                                                                                                " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="10" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="RETENCIONSUSS                           " tabla="PROVEED        " campo="CLRETSUSS " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="IMPUESTO                                " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="420" etiqueta="Código de retención                                                                                                                                             " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="7" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="NROIIBB                                 " tabla="PROVEED        " campo="CLNROIIBB " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="11" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="422" etiqueta="Nro. de IIBB                                                                                                                                                    " dominio="CONVENIOCONNUMEROPROV         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="2" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="NOMBRE                                  " tabla="PROVEED        " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="4" etiqueta="Nombre                                                                                                                                                          " dominio="TEXTOBUSQUEDA                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="CUIT                                    " tabla="PROVEED        " campo="CLCUIT    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="16" etiqueta="C.U.I.T                                                                                                                                                         " dominio="CUITBUSQUEDA                  " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="99-99999999-9            " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="FECHADEALTA                             " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha Alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="0" orden="2" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="TIPODOCUMENTO                           " tabla="PROVEED        " campo="CLTIPODOC " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="424" etiqueta="T./Nro.Doc                                                                                                                                                      " dominio="DOCUMENTO                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="5" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="EMPLEADOR                               " tabla="PROVEED        " campo="CLEMPLEAD " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="426" etiqueta="Empleador                                                                                                                                                       " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="1" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="EXCLUIDORETENCIONSUSS                   " tabla="PROVEED        " campo="EXRETSUSS " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="428" etiqueta="Excluido                                                                                                                                                        " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="7" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="EMAIL                                   " tabla="PROVEED        " campo="CLEMAIL   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="430" etiqueta="E-Mail                                                                                                                                                          " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="CODIGOPOSTAL                            " tabla="PROVEED        " campo="CLCP      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="432" etiqueta="Código Postal                                                                                                                                                   " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="RETENCIONGANANCIAS                      " tabla="PROVEED        " campo="CLRETGAN  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="IMPUESTO                                " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="434" etiqueta="Código de retención                                                                                                                                             " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="4" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="RETENCIONIVA                            " tabla="PROVEED        " campo="CLRETIVA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="IMPUESTO                                " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="436" etiqueta="Código de retención                                                                                                                                             " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="6" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="FECHAULTIMAMODIFICACION                 " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Ultima Modificacion                                                                                                                                             " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="0" orden="3" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="NRODOCUMENTO                            " tabla="PROVEED        " campo="CLNRODOC  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="438" etiqueta="T./Nro.Doc                                                                                                                                                      " dominio="DOCUMENTO                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="5" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="SUJETOVINCULADO                         " tabla="PROVEED        " campo="CLSUJVINC " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Sujeto vinculado                                                                                                                                                " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="1" orden="3" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="PAGINAWEB                               " tabla="PROVEED        " campo="CLPAGEWEB " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="440" etiqueta="Página Web                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="PROVINCIA                               " tabla="PROVEED        " campo="CLPRV     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="PROVINCIA                               " tipodato="C         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="442" etiqueta="Provincia                                                                                                                                                       " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="EXCLUIDORETENCIONGANANCIAS              " tabla="PROVEED        " campo="EXRETGAN  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="444" etiqueta="Excluido                                                                                                                                                        " dominio="CheckConFecha                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="4" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="EXCLUIDORETENCIONIVA                    " tabla="PROVEED        " campo="EXRETIVA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="446" etiqueta="Excluido                                                                                                                                                        " dominio="CheckConFecha                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="6" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="CONTACTO                                " tabla="PROVEED        " campo="CLCONTAC  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="12" etiqueta="Contacto                                                                                                                                                        " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="VIGENCIAHASTAGAN                        " tabla="PROVEED        " campo="PVHASTAGAN" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="8" etiqueta="Vigencia Fecha de Ganancia                                                                                                                                      " dominio="CheckConFecha                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="4" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="VIGENCIAHASTAIVA                        " tabla="PROVEED        " campo="PVHASTAIVA" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="8" etiqueta="Vigencia Fecha de Iva                                                                                                                                           " dominio="CheckConFecha                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="6" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="TIPOINTERNO2                            " tabla="PROVEED        " campo="CLCFI     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="1                                                                                                                                                                                                                                                             " obligatorio="false" admitebusqueda="0" etiqueta="CFI                                                                                                                                                             " dominio="SINOGENERICO                  " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="5" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="CODIGOSIPRIB                            " tabla="PROVEED        " campo="CLSIPRIB  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="DATOSADICIONALESSIPRIB                  " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="448" etiqueta="IIBB Santa Fe SIPRIB                                                                                                                                            " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="3" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="TASACEROPORCEN                          " tabla="PROVEED        " campo="PORCENTC  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="6" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="450" etiqueta="IIBB Mendoza con certificado tasa cero                                                                                                                          " dominio="NUMERICOCHECK                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="999.99                   " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="2" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="TASACEROAPLICA                          " tabla="PROVEED        " campo="APLICATC  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="452" etiqueta="Aplica                                                                                                                                                          " dominio="NUMERICOCHECK                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="2" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SITUACIONFISCAL                         " atributo="DESCRIPCION                             " tabla="SITFISCAL      " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="401" etiqueta="Detalle Sit.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join SITFISCAL On PROVEED.CLIVA = SITFISCAL.Codigo And  SITFISCAL.CODIGO != 0                                                                                                                                                                           " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONDICIONDEPAGO                         " atributo="DESCRIPCION                             " tabla="CONDPAGO       " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="405" etiqueta="Detalle Con.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CONDPAGO On PROVEED.CLCONDPAG = CONDPAGO.CLCOD And  CONDPAGO.CLCOD != ''                                                                                                                                                                           " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADEPRECIOS                          " atributo="NOMBRE                                  " tabla="LPRECIO        " campo="LPR_NOMBRE" claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="419" etiqueta="Detalle Lis.                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join LPRECIO On PROVEED.CLLISTPRE = LPRECIO.LPR_NUMERO And  LPRECIO.LPR_NUMERO != ''                                                                                                                                                                    " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPUESTO                                " atributo="DESCRIPCION                             " tabla="IMPUESTO       " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="421" etiqueta="Detalle Cód.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join IMPUESTO On PROVEED.CLRETSUSS = IMPUESTO.codigo And  IMPUESTO.CODIGO != ''                                                                                                                                                                         " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPUESTO                                " atributo="DESCRIPCION                             " tabla="IMPUESTO       " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="435" etiqueta="Detalle Cód.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join IMPUESTO On PROVEED.CLRETGAN = IMPUESTO.codigo And  IMPUESTO.CODIGO != ''                                                                                                                                                                          " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPUESTO                                " atributo="DESCRIPCION                             " tabla="IMPUESTO       " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="437" etiqueta="Detalle Cód.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join IMPUESTO On PROVEED.CLRETIVA = IMPUESTO.codigo And  IMPUESTO.CODIGO != ''                                                                                                                                                                          " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVINCIA                               " atributo="DESCRIPCION                             " tabla="PROVINCI       " campo="PRV_DES   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="443" etiqueta="Detalle Pro.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join PROVINCI On PROVEED.CLPRV = PROVINCI.PRV_COD And  PROVINCI.PRV_COD != ''                                                                                                                                                                           " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DATOSADICIONALESSIPRIB                  " atributo="DESCRIPCION                             " tabla="SIPRIBDATADIC  " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="15" decimales="0" valorsugerido="Código SIPRIB                                                                                                                                                                                                                                                 " obligatorio="false" admitebusqueda="449" etiqueta="Detalle IIB.                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join SIPRIBDATADIC On PROVEED.CLSIPRIB = SIPRIBDATADIC.Codigo And  SIPRIBDATADIC.CODIGO != ''                                                                                                                                                           " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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