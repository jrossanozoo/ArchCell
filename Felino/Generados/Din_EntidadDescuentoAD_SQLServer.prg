
define class Din_EntidadDESCUENTOAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_DESCUENTO'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = []
	cExpresionCCPorCampos = []
	cTagClaveCandidata = ''
	cTagClavePk = '_DESPK'
	cTablaPrincipal = 'DESCUENTOS'
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
			local  lxDescuentosFmodifw, lxDescuentosFectrans, lxDescuentosFecexpo, lxDescuentosFecimpo, lxDescuentosFaltafw, lxDescuentosTimestamp, lxDescuentosTipagrupub, lxDescuentosInactivofw, lxDescuentosHoraexpo, lxDescuentosBdmodifw, lxDescuentosHaltafw, lxDescuentosZadsfw, lxDescuentosEsttrans, lxDescuentosDescfw, lxDescuentosHmodifw, lxDescuentosHoraimpo, lxDescuentosSaltafw, lxDescuentosValtafw, lxDescuentosVmodifw, lxDescuentosBdaltafw, lxDescuentosUmodifw, lxDescuentosUaltafw, lxDescuentosSmodifw, lxDescuentosCodigo, lxDescuentosDes, lxDescuentosMondes, lxDescuentosMonhas, lxDescuentosIntera, lxDescuentosTobs, lxDescuentosFecdes, lxDescuentosMonto, lxDescuentosFechas, lxDescuentosPorcdes, lxDescuentosHordes, lxDescuentosMontomax, lxDescuentosHorhas, lxDescuentosPorcmax, lxDescuentosOrden, lxDescuentosFunc, lxDescuentosCantdes, lxDescuentosCanthas, lxDescuentosPerfdesde, lxDescuentosPerfhasta, lxDescuentosListdesde, lxDescuentosListhasta, lxDescuentosVenddesde, lxDescuentosVendhasta, lxDescuentosDialu, lxDescuentosDiama, lxDescuentosDiami, lxDescuentosDiaju, lxDescuentosClascdesde, lxDescuentosDiavi, lxDescuentosClaschasta, lxDescuentosDiasa, lxDescuentosTipocdesde, lxDescuentosDiado, lxDescuentosTipochasta, lxDescuentosCatecdesde, lxDescuentosCatechasta
				lxDescuentosFmodifw =  .Fechamodificacionfw			lxDescuentosFectrans =  .Fechatransferencia			lxDescuentosFecexpo =  .Fechaexpo			lxDescuentosFecimpo =  .Fechaimpo			lxDescuentosFaltafw =  .Fechaaltafw			lxDescuentosTimestamp = goLibrerias.ObtenerTimestamp()			lxDescuentosTipagrupub =  .Tipoagrupamientopublicaciones			lxDescuentosInactivofw =  .Inactivofw			lxDescuentosHoraexpo =  .Horaexpo			lxDescuentosBdmodifw =  .Basededatosmodificacionfw			lxDescuentosHaltafw =  .Horaaltafw			lxDescuentosZadsfw =  .Zadsfw			lxDescuentosEsttrans =  .Estadotransferencia			lxDescuentosDescfw =  .Descripcionfw			lxDescuentosHmodifw =  .Horamodificacionfw			lxDescuentosHoraimpo =  .Horaimpo			lxDescuentosSaltafw =  .Seriealtafw			lxDescuentosValtafw =  .Versionaltafw			lxDescuentosVmodifw =  .Versionmodificacionfw			lxDescuentosBdaltafw =  .Basededatosaltafw			lxDescuentosUmodifw =  .Usuariomodificacionfw			lxDescuentosUaltafw =  .Usuarioaltafw			lxDescuentosSmodifw =  .Seriemodificacionfw			lxDescuentosCodigo =  .Codigo			lxDescuentosDes =  .Descripcion			lxDescuentosMondes =  .Montodesde			lxDescuentosMonhas =  .Montohasta			lxDescuentosIntera =  .Interaccion			lxDescuentosTobs =  .Obs			lxDescuentosFecdes =  .Fechadesde			lxDescuentosMonto =  .Monto			lxDescuentosFechas =  .Fechahasta			lxDescuentosPorcdes =  .Porcentaje			lxDescuentosHordes =  .Horadesde			lxDescuentosMontomax =  .Montomax			lxDescuentosHorhas =  .Horahasta			lxDescuentosPorcmax =  .Porcentajemax			lxDescuentosOrden =  .Orden			lxDescuentosFunc =  .Modofuncionamiento			lxDescuentosCantdes =  .Cantidaddesde			lxDescuentosCanthas =  .Cantidadhasta			lxDescuentosPerfdesde =  .Perfildesde			lxDescuentosPerfhasta =  .Perfilhasta			lxDescuentosListdesde =  upper( .ListaDesde_PK ) 			lxDescuentosListhasta =  upper( .ListaHasta_PK ) 			lxDescuentosVenddesde =  upper( .VendDesde_PK ) 			lxDescuentosVendhasta =  upper( .VendHasta_PK ) 			lxDescuentosDialu =  .Dialu			lxDescuentosDiama =  .Diama			lxDescuentosDiami =  .Diami			lxDescuentosDiaju =  .Diaju			lxDescuentosClascdesde =  upper( .Cliente_ClasificacionCDesde_PK ) 			lxDescuentosDiavi =  .Diavi			lxDescuentosClaschasta =  upper( .Cliente_ClasificacionCHasta_PK ) 			lxDescuentosDiasa =  .Diasa			lxDescuentosTipocdesde =  upper( .Cliente_TipoCDesde_PK ) 			lxDescuentosDiado =  .Diado			lxDescuentosTipochasta =  upper( .Cliente_TipoCHasta_PK ) 			lxDescuentosCatecdesde =  upper( .Cliente_CategoriaCDesde_PK ) 			lxDescuentosCatechasta =  upper( .Cliente_CategoriaCHasta_PK ) 
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxDescuentosCodigo = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.DESCUENTOS ( "Fmodifw","Fectrans","Fecexpo","Fecimpo","Faltafw","Timestamp","Tipagrupub","Inactivofw","Horaexpo","Bdmodifw","Haltafw","Zadsfw","Esttrans","Descfw","Hmodifw","Horaimpo","Saltafw","Valtafw","Vmodifw","Bdaltafw","Umodifw","Ualtafw","Smodifw","Codigo","Des","Mondes","Monhas","Intera","Tobs","Fecdes","Monto","Fechas","Porcdes","Hordes","Montomax","Horhas","Porcmax","Orden","Func","Cantdes","Canthas","Perfdesde","Perfhasta","Listdesde","Listhasta","Venddesde","Vendhasta","Dialu","Diama","Diami","Diaju","Clascdesde","Diavi","Claschasta","Diasa","Tipocdesde","Diado","Tipochasta","Catecdesde","Catechasta" ) values ( <<"'" + this.ConvertirDateSql( lxDescuentosFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxDescuentosFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxDescuentosFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxDescuentosFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxDescuentosFaltafw ) + "'" >>, <<lxDescuentosTimestamp >>, <<lxDescuentosTipagrupub >>, <<iif( lxDescuentosInactivofw, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxDescuentosHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDescuentosBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDescuentosHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDescuentosZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDescuentosEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDescuentosDescfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDescuentosHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDescuentosHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDescuentosSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDescuentosValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDescuentosVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDescuentosBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDescuentosUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDescuentosUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDescuentosSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDescuentosCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDescuentosDes ) + "'" >>, <<lxDescuentosMondes >>, <<lxDescuentosMonhas >>, <<lxDescuentosIntera >>, <<"'" + this.FormatearTextoSql( lxDescuentosTobs ) + "'" >>, <<"'" + this.ConvertirDateSql( lxDescuentosFecdes ) + "'" >>, <<lxDescuentosMonto >>, <<"'" + this.ConvertirDateSql( lxDescuentosFechas ) + "'" >>, <<lxDescuentosPorcdes >>, <<"'" + this.FormatearTextoSql( lxDescuentosHordes ) + "'" >>, <<lxDescuentosMontomax >>, <<"'" + this.FormatearTextoSql( lxDescuentosHorhas ) + "'" >>, <<lxDescuentosPorcmax >>, <<lxDescuentosOrden >>, <<lxDescuentosFunc >>, <<lxDescuentosCantdes >>, <<lxDescuentosCanthas >>, <<"'" + this.FormatearTextoSql( lxDescuentosPerfdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDescuentosPerfhasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDescuentosListdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDescuentosListhasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDescuentosVenddesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDescuentosVendhasta ) + "'" >>, <<iif( lxDescuentosDialu, 1, 0 ) >>, <<iif( lxDescuentosDiama, 1, 0 ) >>, <<iif( lxDescuentosDiami, 1, 0 ) >>, <<iif( lxDescuentosDiaju, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxDescuentosClascdesde ) + "'" >>, <<iif( lxDescuentosDiavi, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxDescuentosClaschasta ) + "'" >>, <<iif( lxDescuentosDiasa, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxDescuentosTipocdesde ) + "'" >>, <<iif( lxDescuentosDiado, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxDescuentosTipochasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDescuentosCatecdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDescuentosCatechasta ) + "'" >> )
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
		this.ComprobarTransaccion()
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = lxValorClavePrimaria

			lcSentencia = this.ObtenerSentenciasInsertAuditoria()
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
		this.ComprobarTransaccion()

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.DescuentoDetalle
				if this.oEntidad.DescuentoDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxComprobante = loItem.Comprobante
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.DescuentoDet("NROITEM","CODIGO","Comprobant" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxComprobante ) + "'">> ) 
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
						Insert into ZooLogic.AgruPubDES("NROITEM","Codigo","Agrup","AgrupDes" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxAgrupamiento_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxAgrupamientodetalle ) + "'">> ) 
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
		this.oEntidad.Timestamp = lxDescuentosTimestamp
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
			local  lxDescuentosFmodifw, lxDescuentosFectrans, lxDescuentosFecexpo, lxDescuentosFecimpo, lxDescuentosFaltafw, lxDescuentosTimestamp, lxDescuentosTipagrupub, lxDescuentosInactivofw, lxDescuentosHoraexpo, lxDescuentosBdmodifw, lxDescuentosHaltafw, lxDescuentosZadsfw, lxDescuentosEsttrans, lxDescuentosDescfw, lxDescuentosHmodifw, lxDescuentosHoraimpo, lxDescuentosSaltafw, lxDescuentosValtafw, lxDescuentosVmodifw, lxDescuentosBdaltafw, lxDescuentosUmodifw, lxDescuentosUaltafw, lxDescuentosSmodifw, lxDescuentosCodigo, lxDescuentosDes, lxDescuentosMondes, lxDescuentosMonhas, lxDescuentosIntera, lxDescuentosTobs, lxDescuentosFecdes, lxDescuentosMonto, lxDescuentosFechas, lxDescuentosPorcdes, lxDescuentosHordes, lxDescuentosMontomax, lxDescuentosHorhas, lxDescuentosPorcmax, lxDescuentosOrden, lxDescuentosFunc, lxDescuentosCantdes, lxDescuentosCanthas, lxDescuentosPerfdesde, lxDescuentosPerfhasta, lxDescuentosListdesde, lxDescuentosListhasta, lxDescuentosVenddesde, lxDescuentosVendhasta, lxDescuentosDialu, lxDescuentosDiama, lxDescuentosDiami, lxDescuentosDiaju, lxDescuentosClascdesde, lxDescuentosDiavi, lxDescuentosClaschasta, lxDescuentosDiasa, lxDescuentosTipocdesde, lxDescuentosDiado, lxDescuentosTipochasta, lxDescuentosCatecdesde, lxDescuentosCatechasta
				lxDescuentosFmodifw =  .Fechamodificacionfw			lxDescuentosFectrans =  .Fechatransferencia			lxDescuentosFecexpo =  .Fechaexpo			lxDescuentosFecimpo =  .Fechaimpo			lxDescuentosFaltafw =  .Fechaaltafw			lxDescuentosTimestamp = goLibrerias.ObtenerTimestamp()			lxDescuentosTipagrupub =  .Tipoagrupamientopublicaciones			lxDescuentosInactivofw =  .Inactivofw			lxDescuentosHoraexpo =  .Horaexpo			lxDescuentosBdmodifw =  .Basededatosmodificacionfw			lxDescuentosHaltafw =  .Horaaltafw			lxDescuentosZadsfw =  .Zadsfw			lxDescuentosEsttrans =  .Estadotransferencia			lxDescuentosDescfw =  .Descripcionfw			lxDescuentosHmodifw =  .Horamodificacionfw			lxDescuentosHoraimpo =  .Horaimpo			lxDescuentosSaltafw =  .Seriealtafw			lxDescuentosValtafw =  .Versionaltafw			lxDescuentosVmodifw =  .Versionmodificacionfw			lxDescuentosBdaltafw =  .Basededatosaltafw			lxDescuentosUmodifw =  .Usuariomodificacionfw			lxDescuentosUaltafw =  .Usuarioaltafw			lxDescuentosSmodifw =  .Seriemodificacionfw			lxDescuentosCodigo =  .Codigo			lxDescuentosDes =  .Descripcion			lxDescuentosMondes =  .Montodesde			lxDescuentosMonhas =  .Montohasta			lxDescuentosIntera =  .Interaccion			lxDescuentosTobs =  .Obs			lxDescuentosFecdes =  .Fechadesde			lxDescuentosMonto =  .Monto			lxDescuentosFechas =  .Fechahasta			lxDescuentosPorcdes =  .Porcentaje			lxDescuentosHordes =  .Horadesde			lxDescuentosMontomax =  .Montomax			lxDescuentosHorhas =  .Horahasta			lxDescuentosPorcmax =  .Porcentajemax			lxDescuentosOrden =  .Orden			lxDescuentosFunc =  .Modofuncionamiento			lxDescuentosCantdes =  .Cantidaddesde			lxDescuentosCanthas =  .Cantidadhasta			lxDescuentosPerfdesde =  .Perfildesde			lxDescuentosPerfhasta =  .Perfilhasta			lxDescuentosListdesde =  upper( .ListaDesde_PK ) 			lxDescuentosListhasta =  upper( .ListaHasta_PK ) 			lxDescuentosVenddesde =  upper( .VendDesde_PK ) 			lxDescuentosVendhasta =  upper( .VendHasta_PK ) 			lxDescuentosDialu =  .Dialu			lxDescuentosDiama =  .Diama			lxDescuentosDiami =  .Diami			lxDescuentosDiaju =  .Diaju			lxDescuentosClascdesde =  upper( .Cliente_ClasificacionCDesde_PK ) 			lxDescuentosDiavi =  .Diavi			lxDescuentosClaschasta =  upper( .Cliente_ClasificacionCHasta_PK ) 			lxDescuentosDiasa =  .Diasa			lxDescuentosTipocdesde =  upper( .Cliente_TipoCDesde_PK ) 			lxDescuentosDiado =  .Diado			lxDescuentosTipochasta =  upper( .Cliente_TipoCHasta_PK ) 			lxDescuentosCatecdesde =  upper( .Cliente_CategoriaCDesde_PK ) 			lxDescuentosCatechasta =  upper( .Cliente_CategoriaCHasta_PK ) 
		endwith
		
		if this.oEntidad.VerificarContexto( 'CB' )
		else
			this.ValidarTimestamp()
		endif
		with this
		Try
			local llInsertarAuditoria as Boolean
			llInsertarAuditoria = (  .oEntidad.oAtributosAuditoria.INACTIVOFW != .oEntidad.INACTIVOFW )
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()
			lxValorClavePrimaria = .oEntidad.CODIGO
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ZooLogic.DESCUENTOS set "Fmodifw" = <<"'" + this.ConvertirDateSql( lxDescuentosFmodifw ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxDescuentosFectrans ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxDescuentosFecexpo ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxDescuentosFecimpo ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxDescuentosFaltafw ) + "'">>,"Timestamp" = <<lxDescuentosTimestamp>>,"Tipagrupub" = <<lxDescuentosTipagrupub>>,"Inactivofw" = <<iif( lxDescuentosInactivofw, 1, 0 )>>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxDescuentosHoraexpo ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxDescuentosBdmodifw ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxDescuentosHaltafw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxDescuentosZadsfw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxDescuentosEsttrans ) + "'">>,"Descfw" = <<"'" + this.FormatearTextoSql( lxDescuentosDescfw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxDescuentosHmodifw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxDescuentosHoraimpo ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxDescuentosSaltafw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxDescuentosValtafw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxDescuentosVmodifw ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxDescuentosBdaltafw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxDescuentosUmodifw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxDescuentosUaltafw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxDescuentosSmodifw ) + "'">>,"Codigo" = <<"'" + this.FormatearTextoSql( lxDescuentosCodigo ) + "'">>,"Des" = <<"'" + this.FormatearTextoSql( lxDescuentosDes ) + "'">>,"Mondes" = <<lxDescuentosMondes>>,"Monhas" = <<lxDescuentosMonhas>>,"Intera" = <<lxDescuentosIntera>>,"Tobs" = <<"'" + this.FormatearTextoSql( lxDescuentosTobs ) + "'">>,"Fecdes" = <<"'" + this.ConvertirDateSql( lxDescuentosFecdes ) + "'">>,"Monto" = <<lxDescuentosMonto>>,"Fechas" = <<"'" + this.ConvertirDateSql( lxDescuentosFechas ) + "'">>,"Porcdes" = <<lxDescuentosPorcdes>>,"Hordes" = <<"'" + this.FormatearTextoSql( lxDescuentosHordes ) + "'">>,"Montomax" = <<lxDescuentosMontomax>>,"Horhas" = <<"'" + this.FormatearTextoSql( lxDescuentosHorhas ) + "'">>,"Porcmax" = <<lxDescuentosPorcmax>>,"Orden" = <<lxDescuentosOrden>>,"Func" = <<lxDescuentosFunc>>,"Cantdes" = <<lxDescuentosCantdes>>,"Canthas" = <<lxDescuentosCanthas>>,"Perfdesde" = <<"'" + this.FormatearTextoSql( lxDescuentosPerfdesde ) + "'">>,"Perfhasta" = <<"'" + this.FormatearTextoSql( lxDescuentosPerfhasta ) + "'">>,"Listdesde" = <<"'" + this.FormatearTextoSql( lxDescuentosListdesde ) + "'">>,"Listhasta" = <<"'" + this.FormatearTextoSql( lxDescuentosListhasta ) + "'">>,"Venddesde" = <<"'" + this.FormatearTextoSql( lxDescuentosVenddesde ) + "'">>,"Vendhasta" = <<"'" + this.FormatearTextoSql( lxDescuentosVendhasta ) + "'">>,"Dialu" = <<iif( lxDescuentosDialu, 1, 0 )>>,"Diama" = <<iif( lxDescuentosDiama, 1, 0 )>>,"Diami" = <<iif( lxDescuentosDiami, 1, 0 )>>,"Diaju" = <<iif( lxDescuentosDiaju, 1, 0 )>>,"Clascdesde" = <<"'" + this.FormatearTextoSql( lxDescuentosClascdesde ) + "'">>,"Diavi" = <<iif( lxDescuentosDiavi, 1, 0 )>>,"Claschasta" = <<"'" + this.FormatearTextoSql( lxDescuentosClaschasta ) + "'">>,"Diasa" = <<iif( lxDescuentosDiasa, 1, 0 )>>,"Tipocdesde" = <<"'" + this.FormatearTextoSql( lxDescuentosTipocdesde ) + "'">>,"Diado" = <<iif( lxDescuentosDiado, 1, 0 )>>,"Tipochasta" = <<"'" + this.FormatearTextoSql( lxDescuentosTipochasta ) + "'">>,"Catecdesde" = <<"'" + this.FormatearTextoSql( lxDescuentosCatecdesde ) + "'">>,"Catechasta" = <<"'" + this.FormatearTextoSql( lxDescuentosCatechasta ) + "'">> where "Codigo" = <<"'" + this.FormatearTextoSql( lxDescuentosCodigo ) + "'">> and  DESCUENTOS.CODIGO != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			this.ComprobarResultadoDeEjecucionDelUpdate()
		this.ComprobarTransaccion()
			If llInsertarAuditoria
				lcSentencia = this.ObtenerSentenciasInsertAuditoria()
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			EndIf
			this.oConexion.EjecutarSql( 'delete from ZooLogic.DescuentoDet where "CODIGO" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.AgruPubDES where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.DescuentoDetalle
				if this.oEntidad.DescuentoDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxComprobante = loItem.Comprobante
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.DescuentoDet("NROITEM","CODIGO","Comprobant" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxComprobante ) + "'">> ) 
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
						Insert into ZooLogic.AgruPubDES("NROITEM","Codigo","Agrup","AgrupDes" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxAgrupamiento_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxAgrupamientodetalle ) + "'">> ) 
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
		this.oEntidad.Timestamp = lxDescuentosTimestamp
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 codigo from ZooLogic.DESCUENTOS where " + this.ConvertirFuncionesSql( " DESCUENTOS.CODIGO != ''" ) )
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
			Local lxDescuentosCodigo
			lxDescuentosCodigo = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Timestamp" as "Timestamp", "Tipagrupub" as "Tipoagrupamientopublicaciones", "Inactivofw" as "Inactivofw", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Haltafw" as "Horaaltafw", "Zadsfw" as "Zadsfw", "Esttrans" as "Estadotransferencia", "Descfw" as "Descripcionfw", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Codigo" as "Codigo", "Des" as "Descripcion", "Mondes" as "Montodesde", "Monhas" as "Montohasta", "Intera" as "Interaccion", "Tobs" as "Obs", "Fecdes" as "Fechadesde", "Monto" as "Monto", "Fechas" as "Fechahasta", "Porcdes" as "Porcentaje", "Hordes" as "Horadesde", "Montomax" as "Montomax", "Horhas" as "Horahasta", "Porcmax" as "Porcentajemax", "Orden" as "Orden", "Func" as "Modofuncionamiento", "Cantdes" as "Cantidaddesde", "Canthas" as "Cantidadhasta", "Perfdesde" as "Perfildesde", "Perfhasta" as "Perfilhasta", "Listdesde" as "Listadesde", "Listhasta" as "Listahasta", "Venddesde" as "Venddesde", "Vendhasta" as "Vendhasta", "Dialu" as "Dialu", "Diama" as "Diama", "Diami" as "Diami", "Diaju" as "Diaju", "Clascdesde" as "Cliente_clasificacioncdesde", "Diavi" as "Diavi", "Claschasta" as "Cliente_clasificacionchasta", "Diasa" as "Diasa", "Tipocdesde" as "Cliente_tipocdesde", "Diado" as "Diado", "Tipochasta" as "Cliente_tipochasta", "Catecdesde" as "Cliente_categoriacdesde", "Catechasta" as "Cliente_categoriachasta" from ZooLogic.DESCUENTOS where "Codigo" = <<"'" + this.FormatearTextoSql( lxDescuentosCodigo ) + "'">> and  DESCUENTOS.CODIGO != ''
			endtext
			use in select('c_DESCUENTO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DESCUENTO', set( 'Datasession' ) )

			if reccount( 'c_DESCUENTO' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Comprobant" as "Comprobante" from ZooLogic.DescuentoDet where CODIGO = <<"'" + this.FormatearTextoSql( c_DESCUENTO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_DescuentoDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DescuentoDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DescuentoDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Agrup" as "Agrupamiento", "Agrupdes" as "Agrupamientodetalle" from ZooLogic.AgruPubDES where Codigo = <<"'" + this.FormatearTextoSql( c_DESCUENTO.CODIGO ) + "'">> Order by NroItem
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
		local llRetorno as boolean,lxDescuentosCodigo as Variant
		llRetorno = .t.
		lxDescuentosCodigo = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.DESCUENTOS where "Codigo" = <<"'" + this.FormatearTextoSql( lxDescuentosCodigo ) + "'">> and  DESCUENTOS.CODIGO != ''
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
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Timestamp" as "Timestamp", "Tipagrupub" as "Tipoagrupamientopublicaciones", "Inactivofw" as "Inactivofw", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Haltafw" as "Horaaltafw", "Zadsfw" as "Zadsfw", "Esttrans" as "Estadotransferencia", "Descfw" as "Descripcionfw", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Codigo" as "Codigo", "Des" as "Descripcion", "Mondes" as "Montodesde", "Monhas" as "Montohasta", "Intera" as "Interaccion", "Tobs" as "Obs", "Fecdes" as "Fechadesde", "Monto" as "Monto", "Fechas" as "Fechahasta", "Porcdes" as "Porcentaje", "Hordes" as "Horadesde", "Montomax" as "Montomax", "Horhas" as "Horahasta", "Porcmax" as "Porcentajemax", "Orden" as "Orden", "Func" as "Modofuncionamiento", "Cantdes" as "Cantidaddesde", "Canthas" as "Cantidadhasta", "Perfdesde" as "Perfildesde", "Perfhasta" as "Perfilhasta", "Listdesde" as "Listadesde", "Listhasta" as "Listahasta", "Venddesde" as "Venddesde", "Vendhasta" as "Vendhasta", "Dialu" as "Dialu", "Diama" as "Diama", "Diami" as "Diami", "Diaju" as "Diaju", "Clascdesde" as "Cliente_clasificacioncdesde", "Diavi" as "Diavi", "Claschasta" as "Cliente_clasificacionchasta", "Diasa" as "Diasa", "Tipocdesde" as "Cliente_tipocdesde", "Diado" as "Diado", "Tipochasta" as "Cliente_tipochasta", "Catecdesde" as "Cliente_categoriacdesde", "Catechasta" as "Cliente_categoriachasta" from ZooLogic.DESCUENTOS where  DESCUENTOS.CODIGO != '' order by codigo
			endtext
			use in select('c_DESCUENTO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DESCUENTO', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Comprobant" as "Comprobante" from ZooLogic.DescuentoDet where CODIGO = <<"'" + this.FormatearTextoSql( c_DESCUENTO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_DescuentoDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DescuentoDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DescuentoDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Agrup" as "Agrupamiento", "Agrupdes" as "Agrupamientodetalle" from ZooLogic.AgruPubDES where Codigo = <<"'" + this.FormatearTextoSql( c_DESCUENTO.CODIGO ) + "'">> Order by NroItem
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
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Timestamp" as "Timestamp", "Tipagrupub" as "Tipoagrupamientopublicaciones", "Inactivofw" as "Inactivofw", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Haltafw" as "Horaaltafw", "Zadsfw" as "Zadsfw", "Esttrans" as "Estadotransferencia", "Descfw" as "Descripcionfw", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Codigo" as "Codigo", "Des" as "Descripcion", "Mondes" as "Montodesde", "Monhas" as "Montohasta", "Intera" as "Interaccion", "Tobs" as "Obs", "Fecdes" as "Fechadesde", "Monto" as "Monto", "Fechas" as "Fechahasta", "Porcdes" as "Porcentaje", "Hordes" as "Horadesde", "Montomax" as "Montomax", "Horhas" as "Horahasta", "Porcmax" as "Porcentajemax", "Orden" as "Orden", "Func" as "Modofuncionamiento", "Cantdes" as "Cantidaddesde", "Canthas" as "Cantidadhasta", "Perfdesde" as "Perfildesde", "Perfhasta" as "Perfilhasta", "Listdesde" as "Listadesde", "Listhasta" as "Listahasta", "Venddesde" as "Venddesde", "Vendhasta" as "Vendhasta", "Dialu" as "Dialu", "Diama" as "Diama", "Diami" as "Diami", "Diaju" as "Diaju", "Clascdesde" as "Cliente_clasificacioncdesde", "Diavi" as "Diavi", "Claschasta" as "Cliente_clasificacionchasta", "Diasa" as "Diasa", "Tipocdesde" as "Cliente_tipocdesde", "Diado" as "Diado", "Tipochasta" as "Cliente_tipochasta", "Catecdesde" as "Cliente_categoriacdesde", "Catechasta" as "Cliente_categoriachasta" from ZooLogic.DESCUENTOS where  funciones.padr( codigo, 10, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  DESCUENTOS.CODIGO != '' order by codigo
			endtext
			use in select('c_DESCUENTO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DESCUENTO', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Comprobant" as "Comprobante" from ZooLogic.DescuentoDet where CODIGO = <<"'" + this.FormatearTextoSql( c_DESCUENTO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_DescuentoDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DescuentoDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DescuentoDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Agrup" as "Agrupamiento", "Agrupdes" as "Agrupamientodetalle" from ZooLogic.AgruPubDES where Codigo = <<"'" + this.FormatearTextoSql( c_DESCUENTO.CODIGO ) + "'">> Order by NroItem
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
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Timestamp" as "Timestamp", "Tipagrupub" as "Tipoagrupamientopublicaciones", "Inactivofw" as "Inactivofw", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Haltafw" as "Horaaltafw", "Zadsfw" as "Zadsfw", "Esttrans" as "Estadotransferencia", "Descfw" as "Descripcionfw", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Codigo" as "Codigo", "Des" as "Descripcion", "Mondes" as "Montodesde", "Monhas" as "Montohasta", "Intera" as "Interaccion", "Tobs" as "Obs", "Fecdes" as "Fechadesde", "Monto" as "Monto", "Fechas" as "Fechahasta", "Porcdes" as "Porcentaje", "Hordes" as "Horadesde", "Montomax" as "Montomax", "Horhas" as "Horahasta", "Porcmax" as "Porcentajemax", "Orden" as "Orden", "Func" as "Modofuncionamiento", "Cantdes" as "Cantidaddesde", "Canthas" as "Cantidadhasta", "Perfdesde" as "Perfildesde", "Perfhasta" as "Perfilhasta", "Listdesde" as "Listadesde", "Listhasta" as "Listahasta", "Venddesde" as "Venddesde", "Vendhasta" as "Vendhasta", "Dialu" as "Dialu", "Diama" as "Diama", "Diami" as "Diami", "Diaju" as "Diaju", "Clascdesde" as "Cliente_clasificacioncdesde", "Diavi" as "Diavi", "Claschasta" as "Cliente_clasificacionchasta", "Diasa" as "Diasa", "Tipocdesde" as "Cliente_tipocdesde", "Diado" as "Diado", "Tipochasta" as "Cliente_tipochasta", "Catecdesde" as "Cliente_categoriacdesde", "Catechasta" as "Cliente_categoriachasta" from ZooLogic.DESCUENTOS where  funciones.padr( codigo, 10, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  DESCUENTOS.CODIGO != '' order by codigo desc
			endtext
			use in select('c_DESCUENTO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DESCUENTO', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Comprobant" as "Comprobante" from ZooLogic.DescuentoDet where CODIGO = <<"'" + this.FormatearTextoSql( c_DESCUENTO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_DescuentoDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DescuentoDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DescuentoDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Agrup" as "Agrupamiento", "Agrupdes" as "Agrupamientodetalle" from ZooLogic.AgruPubDES where Codigo = <<"'" + this.FormatearTextoSql( c_DESCUENTO.CODIGO ) + "'">> Order by NroItem
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
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Timestamp" as "Timestamp", "Tipagrupub" as "Tipoagrupamientopublicaciones", "Inactivofw" as "Inactivofw", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Haltafw" as "Horaaltafw", "Zadsfw" as "Zadsfw", "Esttrans" as "Estadotransferencia", "Descfw" as "Descripcionfw", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Codigo" as "Codigo", "Des" as "Descripcion", "Mondes" as "Montodesde", "Monhas" as "Montohasta", "Intera" as "Interaccion", "Tobs" as "Obs", "Fecdes" as "Fechadesde", "Monto" as "Monto", "Fechas" as "Fechahasta", "Porcdes" as "Porcentaje", "Hordes" as "Horadesde", "Montomax" as "Montomax", "Horhas" as "Horahasta", "Porcmax" as "Porcentajemax", "Orden" as "Orden", "Func" as "Modofuncionamiento", "Cantdes" as "Cantidaddesde", "Canthas" as "Cantidadhasta", "Perfdesde" as "Perfildesde", "Perfhasta" as "Perfilhasta", "Listdesde" as "Listadesde", "Listhasta" as "Listahasta", "Venddesde" as "Venddesde", "Vendhasta" as "Vendhasta", "Dialu" as "Dialu", "Diama" as "Diama", "Diami" as "Diami", "Diaju" as "Diaju", "Clascdesde" as "Cliente_clasificacioncdesde", "Diavi" as "Diavi", "Claschasta" as "Cliente_clasificacionchasta", "Diasa" as "Diasa", "Tipocdesde" as "Cliente_tipocdesde", "Diado" as "Diado", "Tipochasta" as "Cliente_tipochasta", "Catecdesde" as "Cliente_categoriacdesde", "Catechasta" as "Cliente_categoriachasta" from ZooLogic.DESCUENTOS where  DESCUENTOS.CODIGO != '' order by codigo desc
			endtext
			use in select('c_DESCUENTO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DESCUENTO', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Comprobant" as "Comprobante" from ZooLogic.DescuentoDet where CODIGO = <<"'" + this.FormatearTextoSql( c_DESCUENTO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_DescuentoDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DescuentoDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DescuentoDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Agrup" as "Agrupamiento", "Agrupdes" as "Agrupamientodetalle" from ZooLogic.AgruPubDES where Codigo = <<"'" + this.FormatearTextoSql( c_DESCUENTO.CODIGO ) + "'">> Order by NroItem
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
			lcXml = this.oConexion.EjecutarSql( "select Fmodifw,Fectrans,Fecexpo,Fecimpo,Faltafw,Timestamp,Tipagrupub,Inactivofw,Horaexpo,Bdmodifw,H" + ;
"altafw,Zadsfw,Esttrans,Descfw,Hmodifw,Horaimpo,Saltafw,Valtafw,Vmodifw,Bdaltafw,Umodifw,Ualtafw,Smod" + ;
"ifw,Codigo,Des,Mondes,Monhas,Intera,Tobs,Fecdes,Monto,Fechas,Porcdes,Hordes,Montomax,Horhas,Porcmax," + ;
"Orden,Func,Cantdes,Canthas,Perfdesde,Perfhasta,Listdesde,Listhasta,Venddesde,Vendhasta,Dialu,Diama,D" + ;
"iami,Diaju,Clascdesde,Diavi,Claschasta,Diasa,Tipocdesde,Diado,Tipochasta,Catecdesde,Catechasta" + ;
" from ZooLogic.DESCUENTOS where  DESCUENTOS.CODIGO != '' and " + lcFiltro )
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
			local  lxDescuentosFmodifw, lxDescuentosFectrans, lxDescuentosFecexpo, lxDescuentosFecimpo, lxDescuentosFaltafw, lxDescuentosTimestamp, lxDescuentosTipagrupub, lxDescuentosInactivofw, lxDescuentosHoraexpo, lxDescuentosBdmodifw, lxDescuentosHaltafw, lxDescuentosZadsfw, lxDescuentosEsttrans, lxDescuentosDescfw, lxDescuentosHmodifw, lxDescuentosHoraimpo, lxDescuentosSaltafw, lxDescuentosValtafw, lxDescuentosVmodifw, lxDescuentosBdaltafw, lxDescuentosUmodifw, lxDescuentosUaltafw, lxDescuentosSmodifw, lxDescuentosCodigo, lxDescuentosDes, lxDescuentosMondes, lxDescuentosMonhas, lxDescuentosIntera, lxDescuentosTobs, lxDescuentosFecdes, lxDescuentosMonto, lxDescuentosFechas, lxDescuentosPorcdes, lxDescuentosHordes, lxDescuentosMontomax, lxDescuentosHorhas, lxDescuentosPorcmax, lxDescuentosOrden, lxDescuentosFunc, lxDescuentosCantdes, lxDescuentosCanthas, lxDescuentosPerfdesde, lxDescuentosPerfhasta, lxDescuentosListdesde, lxDescuentosListhasta, lxDescuentosVenddesde, lxDescuentosVendhasta, lxDescuentosDialu, lxDescuentosDiama, lxDescuentosDiami, lxDescuentosDiaju, lxDescuentosClascdesde, lxDescuentosDiavi, lxDescuentosClaschasta, lxDescuentosDiasa, lxDescuentosTipocdesde, lxDescuentosDiado, lxDescuentosTipochasta, lxDescuentosCatecdesde, lxDescuentosCatechasta
				lxDescuentosFmodifw = ctod( '  /  /    ' )			lxDescuentosFectrans = ctod( '  /  /    ' )			lxDescuentosFecexpo = ctod( '  /  /    ' )			lxDescuentosFecimpo = ctod( '  /  /    ' )			lxDescuentosFaltafw = ctod( '  /  /    ' )			lxDescuentosTimestamp = goLibrerias.ObtenerTimestamp()			lxDescuentosTipagrupub = 0			lxDescuentosInactivofw = .F.			lxDescuentosHoraexpo = []			lxDescuentosBdmodifw = []			lxDescuentosHaltafw = []			lxDescuentosZadsfw = []			lxDescuentosEsttrans = []			lxDescuentosDescfw = []			lxDescuentosHmodifw = []			lxDescuentosHoraimpo = []			lxDescuentosSaltafw = []			lxDescuentosValtafw = []			lxDescuentosVmodifw = []			lxDescuentosBdaltafw = []			lxDescuentosUmodifw = []			lxDescuentosUaltafw = []			lxDescuentosSmodifw = []			lxDescuentosCodigo = []			lxDescuentosDes = []			lxDescuentosMondes = 0			lxDescuentosMonhas = 0			lxDescuentosIntera = 0			lxDescuentosTobs = []			lxDescuentosFecdes = ctod( '  /  /    ' )			lxDescuentosMonto = 0			lxDescuentosFechas = ctod( '  /  /    ' )			lxDescuentosPorcdes = 0			lxDescuentosHordes = []			lxDescuentosMontomax = 0			lxDescuentosHorhas = []			lxDescuentosPorcmax = 0			lxDescuentosOrden = 0			lxDescuentosFunc = 0			lxDescuentosCantdes = 0			lxDescuentosCanthas = 0			lxDescuentosPerfdesde = []			lxDescuentosPerfhasta = []			lxDescuentosListdesde = []			lxDescuentosListhasta = []			lxDescuentosVenddesde = []			lxDescuentosVendhasta = []			lxDescuentosDialu = .F.			lxDescuentosDiama = .F.			lxDescuentosDiami = .F.			lxDescuentosDiaju = .F.			lxDescuentosClascdesde = []			lxDescuentosDiavi = .F.			lxDescuentosClaschasta = []			lxDescuentosDiasa = .F.			lxDescuentosTipocdesde = []			lxDescuentosDiado = .F.			lxDescuentosTipochasta = []			lxDescuentosCatecdesde = []			lxDescuentosCatechasta = []
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.DescuentoDet where "CODIGO" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.AgruPubDES where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( [delete from ZooLogic.DESCUENTOS where "codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'DESCUENTOS' + '_' + tcCampo
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
		lcWhere = " Where  DESCUENTOS.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Timestamp" as "Timestamp", "Tipagrupub" as "Tipoagrupamientopublicaciones", "Inactivofw" as "Inactivofw", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Haltafw" as "Horaaltafw", "Zadsfw" as "Zadsfw", "Esttrans" as "Estadotransferencia", "Descfw" as "Descripcionfw", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Codigo" as "Codigo", "Des" as "Descripcion", "Mondes" as "Montodesde", "Monhas" as "Montohasta", "Intera" as "Interaccion", "Tobs" as "Obs", "Fecdes" as "Fechadesde", "Monto" as "Monto", "Fechas" as "Fechahasta", "Porcdes" as "Porcentaje", "Hordes" as "Horadesde", "Montomax" as "Montomax", "Horhas" as "Horahasta", "Porcmax" as "Porcentajemax", "Orden" as "Orden", "Func" as "Modofuncionamiento", "Cantdes" as "Cantidaddesde", "Canthas" as "Cantidadhasta", "Perfdesde" as "Perfildesde", "Perfhasta" as "Perfilhasta", "Listdesde" as "Listadesde", "Listhasta" as "Listahasta", "Venddesde" as "Venddesde", "Vendhasta" as "Vendhasta", "Dialu" as "Dialu", "Diama" as "Diama", "Diami" as "Diami", "Diaju" as "Diaju", "Clascdesde" as "Cliente_clasificacioncdesde", "Diavi" as "Diavi", "Claschasta" as "Cliente_clasificacionchasta", "Diasa" as "Diasa", "Tipocdesde" as "Cliente_tipocdesde", "Diado" as "Diado", "Tipochasta" as "Cliente_tipochasta", "Catecdesde" as "Cliente_categoriacdesde", "Catechasta" as "Cliente_categoriachasta"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'DESCUENTOS', '', tnTope )
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
	Function ObtenerDatosDetalleDescuentoDetalle( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  DESCUENTODET.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Nroitem" as "Nroitem", "Codigo" as "Codigo", "Comprobant" as "Comprobante"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleDescuentoDetalle( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'DescuentoDet', 'DescuentoDetalle', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleDescuentoDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleDescuentoDetalle( lcAtributo )
		endfor
		lcSelect = substr( lcSelect, 2 )
		return lcSelect
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosDetalleAgruPubliDetalle( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  AGRUPUBDES.CODIGO != ''"
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
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'AgruPubDES', 'AgruPubliDetalle', tnTope )
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
				Case lcAtributo == 'FECHATRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRANS AS FECHATRANSFERENCIA'
				Case lcAtributo == 'FECHAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECEXPO AS FECHAEXPO'
				Case lcAtributo == 'FECHAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECIMPO AS FECHAIMPO'
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'TIMESTAMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIMESTAMP AS TIMESTAMP'
				Case lcAtributo == 'TIPOAGRUPAMIENTOPUBLICACIONES'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPAGRUPUB AS TIPOAGRUPAMIENTOPUBLICACIONES'
				Case lcAtributo == 'INACTIVOFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'INACTIVOFW AS INACTIVOFW'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'DESCRIPCIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCFW AS DESCRIPCIONFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'DESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DES AS DESCRIPCION'
				Case lcAtributo == 'MONTODESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONDES AS MONTODESDE'
				Case lcAtributo == 'MONTOHASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONHAS AS MONTOHASTA'
				Case lcAtributo == 'INTERACCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'INTERA AS INTERACCION'
				Case lcAtributo == 'OBS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TOBS AS OBS'
				Case lcAtributo == 'FECHADESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECDES AS FECHADESDE'
				Case lcAtributo == 'MONTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONTO AS MONTO'
				Case lcAtributo == 'FECHAHASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHAS AS FECHAHASTA'
				Case lcAtributo == 'PORCENTAJE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PORCDES AS PORCENTAJE'
				Case lcAtributo == 'HORADESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORDES AS HORADESDE'
				Case lcAtributo == 'MONTOMAX'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONTOMAX AS MONTOMAX'
				Case lcAtributo == 'HORAHASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORHAS AS HORAHASTA'
				Case lcAtributo == 'PORCENTAJEMAX'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PORCMAX AS PORCENTAJEMAX'
				Case lcAtributo == 'ORDEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ORDEN AS ORDEN'
				Case lcAtributo == 'MODOFUNCIONAMIENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FUNC AS MODOFUNCIONAMIENTO'
				Case lcAtributo == 'CANTIDADDESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CANTDES AS CANTIDADDESDE'
				Case lcAtributo == 'CANTIDADHASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CANTHAS AS CANTIDADHASTA'
				Case lcAtributo == 'PERFILDESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PERFDESDE AS PERFILDESDE'
				Case lcAtributo == 'PERFILHASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PERFHASTA AS PERFILHASTA'
				Case lcAtributo == 'LISTADESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LISTDESDE AS LISTADESDE'
				Case lcAtributo == 'LISTAHASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LISTHASTA AS LISTAHASTA'
				Case lcAtributo == 'VENDDESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VENDDESDE AS VENDDESDE'
				Case lcAtributo == 'VENDHASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VENDHASTA AS VENDHASTA'
				Case lcAtributo == 'DIALU'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DIALU AS DIALU'
				Case lcAtributo == 'DIAMA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DIAMA AS DIAMA'
				Case lcAtributo == 'DIAMI'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DIAMI AS DIAMI'
				Case lcAtributo == 'DIAJU'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DIAJU AS DIAJU'
				Case lcAtributo == 'CLIENTE_CLASIFICACIONCDESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLASCDESDE AS CLIENTE_CLASIFICACIONCDESDE'
				Case lcAtributo == 'DIAVI'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DIAVI AS DIAVI'
				Case lcAtributo == 'CLIENTE_CLASIFICACIONCHASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLASCHASTA AS CLIENTE_CLASIFICACIONCHASTA'
				Case lcAtributo == 'DIASA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DIASA AS DIASA'
				Case lcAtributo == 'CLIENTE_TIPOCDESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPOCDESDE AS CLIENTE_TIPOCDESDE'
				Case lcAtributo == 'DIADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DIADO AS DIADO'
				Case lcAtributo == 'CLIENTE_TIPOCHASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPOCHASTA AS CLIENTE_TIPOCHASTA'
				Case lcAtributo == 'CLIENTE_CATEGORIACDESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CATECDESDE AS CLIENTE_CATEGORIACDESDE'
				Case lcAtributo == 'CLIENTE_CATEGORIACHASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CATECHASTA AS CLIENTE_CATEGORIACHASTA'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleDescuentoDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'COMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COMPROBANT AS COMPROBANTE'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEXPO'
				lcCampo = 'FECEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAIMPO'
				lcCampo = 'FECIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'TIMESTAMP'
				lcCampo = 'TIMESTAMP'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOAGRUPAMIENTOPUBLICACIONES'
				lcCampo = 'TIPAGRUPUB'
			Case upper( alltrim( tcAtributo ) ) == 'INACTIVOFW'
				lcCampo = 'INACTIVOFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCIONFW'
				lcCampo = 'DESCFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCION'
				lcCampo = 'DES'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESDE'
				lcCampo = 'MONDES'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOHASTA'
				lcCampo = 'MONHAS'
			Case upper( alltrim( tcAtributo ) ) == 'INTERACCION'
				lcCampo = 'INTERA'
			Case upper( alltrim( tcAtributo ) ) == 'OBS'
				lcCampo = 'TOBS'
			Case upper( alltrim( tcAtributo ) ) == 'FECHADESDE'
				lcCampo = 'FECDES'
			Case upper( alltrim( tcAtributo ) ) == 'MONTO'
				lcCampo = 'MONTO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAHASTA'
				lcCampo = 'FECHAS'
			Case upper( alltrim( tcAtributo ) ) == 'PORCENTAJE'
				lcCampo = 'PORCDES'
			Case upper( alltrim( tcAtributo ) ) == 'HORADESDE'
				lcCampo = 'HORDES'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOMAX'
				lcCampo = 'MONTOMAX'
			Case upper( alltrim( tcAtributo ) ) == 'HORAHASTA'
				lcCampo = 'HORHAS'
			Case upper( alltrim( tcAtributo ) ) == 'PORCENTAJEMAX'
				lcCampo = 'PORCMAX'
			Case upper( alltrim( tcAtributo ) ) == 'ORDEN'
				lcCampo = 'ORDEN'
			Case upper( alltrim( tcAtributo ) ) == 'MODOFUNCIONAMIENTO'
				lcCampo = 'FUNC'
			Case upper( alltrim( tcAtributo ) ) == 'CANTIDADDESDE'
				lcCampo = 'CANTDES'
			Case upper( alltrim( tcAtributo ) ) == 'CANTIDADHASTA'
				lcCampo = 'CANTHAS'
			Case upper( alltrim( tcAtributo ) ) == 'PERFILDESDE'
				lcCampo = 'PERFDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'PERFILHASTA'
				lcCampo = 'PERFHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'LISTADESDE'
				lcCampo = 'LISTDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'LISTAHASTA'
				lcCampo = 'LISTHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'VENDDESDE'
				lcCampo = 'VENDDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'VENDHASTA'
				lcCampo = 'VENDHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'DIALU'
				lcCampo = 'DIALU'
			Case upper( alltrim( tcAtributo ) ) == 'DIAMA'
				lcCampo = 'DIAMA'
			Case upper( alltrim( tcAtributo ) ) == 'DIAMI'
				lcCampo = 'DIAMI'
			Case upper( alltrim( tcAtributo ) ) == 'DIAJU'
				lcCampo = 'DIAJU'
			Case upper( alltrim( tcAtributo ) ) == 'CLIENTE_CLASIFICACIONCDESDE'
				lcCampo = 'CLASCDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'DIAVI'
				lcCampo = 'DIAVI'
			Case upper( alltrim( tcAtributo ) ) == 'CLIENTE_CLASIFICACIONCHASTA'
				lcCampo = 'CLASCHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'DIASA'
				lcCampo = 'DIASA'
			Case upper( alltrim( tcAtributo ) ) == 'CLIENTE_TIPOCDESDE'
				lcCampo = 'TIPOCDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'DIADO'
				lcCampo = 'DIADO'
			Case upper( alltrim( tcAtributo ) ) == 'CLIENTE_TIPOCHASTA'
				lcCampo = 'TIPOCHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'CLIENTE_CATEGORIACDESDE'
				lcCampo = 'CATECDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'CLIENTE_CATEGORIACHASTA'
				lcCampo = 'CATECHASTA'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleDescuentoDetalle( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'COMPROBANTE'
				lcCampo = 'COMPROBANT'
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
		if upper( alltrim( tcDetalle ) ) == 'DESCUENTODETALLE'
			lcRetorno = 'DESCUENTODET'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'AGRUPUBLIDETALLE'
			lcRetorno = 'AGRUPUBDES'
		EndIf
		return lcRetorno
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasInsert() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcSentencia as string, loItem as object
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxDescuentosFmodifw, lxDescuentosFectrans, lxDescuentosFecexpo, lxDescuentosFecimpo, lxDescuentosFaltafw, lxDescuentosTimestamp, lxDescuentosTipagrupub, lxDescuentosInactivofw, lxDescuentosHoraexpo, lxDescuentosBdmodifw, lxDescuentosHaltafw, lxDescuentosZadsfw, lxDescuentosEsttrans, lxDescuentosDescfw, lxDescuentosHmodifw, lxDescuentosHoraimpo, lxDescuentosSaltafw, lxDescuentosValtafw, lxDescuentosVmodifw, lxDescuentosBdaltafw, lxDescuentosUmodifw, lxDescuentosUaltafw, lxDescuentosSmodifw, lxDescuentosCodigo, lxDescuentosDes, lxDescuentosMondes, lxDescuentosMonhas, lxDescuentosIntera, lxDescuentosTobs, lxDescuentosFecdes, lxDescuentosMonto, lxDescuentosFechas, lxDescuentosPorcdes, lxDescuentosHordes, lxDescuentosMontomax, lxDescuentosHorhas, lxDescuentosPorcmax, lxDescuentosOrden, lxDescuentosFunc, lxDescuentosCantdes, lxDescuentosCanthas, lxDescuentosPerfdesde, lxDescuentosPerfhasta, lxDescuentosListdesde, lxDescuentosListhasta, lxDescuentosVenddesde, lxDescuentosVendhasta, lxDescuentosDialu, lxDescuentosDiama, lxDescuentosDiami, lxDescuentosDiaju, lxDescuentosClascdesde, lxDescuentosDiavi, lxDescuentosClaschasta, lxDescuentosDiasa, lxDescuentosTipocdesde, lxDescuentosDiado, lxDescuentosTipochasta, lxDescuentosCatecdesde, lxDescuentosCatechasta
				lxDescuentosFmodifw =  .Fechamodificacionfw			lxDescuentosFectrans =  .Fechatransferencia			lxDescuentosFecexpo =  .Fechaexpo			lxDescuentosFecimpo =  .Fechaimpo			lxDescuentosFaltafw =  .Fechaaltafw			lxDescuentosTimestamp = goLibrerias.ObtenerTimestamp()			lxDescuentosTipagrupub =  .Tipoagrupamientopublicaciones			lxDescuentosInactivofw =  .Inactivofw			lxDescuentosHoraexpo =  .Horaexpo			lxDescuentosBdmodifw =  .Basededatosmodificacionfw			lxDescuentosHaltafw =  .Horaaltafw			lxDescuentosZadsfw =  .Zadsfw			lxDescuentosEsttrans =  .Estadotransferencia			lxDescuentosDescfw =  .Descripcionfw			lxDescuentosHmodifw =  .Horamodificacionfw			lxDescuentosHoraimpo =  .Horaimpo			lxDescuentosSaltafw =  .Seriealtafw			lxDescuentosValtafw =  .Versionaltafw			lxDescuentosVmodifw =  .Versionmodificacionfw			lxDescuentosBdaltafw =  .Basededatosaltafw			lxDescuentosUmodifw =  .Usuariomodificacionfw			lxDescuentosUaltafw =  .Usuarioaltafw			lxDescuentosSmodifw =  .Seriemodificacionfw			lxDescuentosCodigo =  .Codigo			lxDescuentosDes =  .Descripcion			lxDescuentosMondes =  .Montodesde			lxDescuentosMonhas =  .Montohasta			lxDescuentosIntera =  .Interaccion			lxDescuentosTobs =  .Obs			lxDescuentosFecdes =  .Fechadesde			lxDescuentosMonto =  .Monto			lxDescuentosFechas =  .Fechahasta			lxDescuentosPorcdes =  .Porcentaje			lxDescuentosHordes =  .Horadesde			lxDescuentosMontomax =  .Montomax			lxDescuentosHorhas =  .Horahasta			lxDescuentosPorcmax =  .Porcentajemax			lxDescuentosOrden =  .Orden			lxDescuentosFunc =  .Modofuncionamiento			lxDescuentosCantdes =  .Cantidaddesde			lxDescuentosCanthas =  .Cantidadhasta			lxDescuentosPerfdesde =  .Perfildesde			lxDescuentosPerfhasta =  .Perfilhasta			lxDescuentosListdesde =  upper( .ListaDesde_PK ) 			lxDescuentosListhasta =  upper( .ListaHasta_PK ) 			lxDescuentosVenddesde =  upper( .VendDesde_PK ) 			lxDescuentosVendhasta =  upper( .VendHasta_PK ) 			lxDescuentosDialu =  .Dialu			lxDescuentosDiama =  .Diama			lxDescuentosDiami =  .Diami			lxDescuentosDiaju =  .Diaju			lxDescuentosClascdesde =  upper( .Cliente_ClasificacionCDesde_PK ) 			lxDescuentosDiavi =  .Diavi			lxDescuentosClaschasta =  upper( .Cliente_ClasificacionCHasta_PK ) 			lxDescuentosDiasa =  .Diasa			lxDescuentosTipocdesde =  upper( .Cliente_TipoCDesde_PK ) 			lxDescuentosDiado =  .Diado			lxDescuentosTipochasta =  upper( .Cliente_TipoCHasta_PK ) 			lxDescuentosCatecdesde =  upper( .Cliente_CategoriaCDesde_PK ) 			lxDescuentosCatechasta =  upper( .Cliente_CategoriaCHasta_PK ) 
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.DESCUENTOS ( "Fmodifw","Fectrans","Fecexpo","Fecimpo","Faltafw","Timestamp","Tipagrupub","Inactivofw","Horaexpo","Bdmodifw","Haltafw","Zadsfw","Esttrans","Descfw","Hmodifw","Horaimpo","Saltafw","Valtafw","Vmodifw","Bdaltafw","Umodifw","Ualtafw","Smodifw","Codigo","Des","Mondes","Monhas","Intera","Tobs","Fecdes","Monto","Fechas","Porcdes","Hordes","Montomax","Horhas","Porcmax","Orden","Func","Cantdes","Canthas","Perfdesde","Perfhasta","Listdesde","Listhasta","Venddesde","Vendhasta","Dialu","Diama","Diami","Diaju","Clascdesde","Diavi","Claschasta","Diasa","Tipocdesde","Diado","Tipochasta","Catecdesde","Catechasta" ) values ( <<"'" + this.ConvertirDateSql( lxDescuentosFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxDescuentosFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxDescuentosFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxDescuentosFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxDescuentosFaltafw ) + "'" >>, <<lxDescuentosTimestamp >>, <<lxDescuentosTipagrupub >>, <<iif( lxDescuentosInactivofw, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxDescuentosHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDescuentosBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDescuentosHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDescuentosZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDescuentosEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDescuentosDescfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDescuentosHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDescuentosHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDescuentosSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDescuentosValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDescuentosVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDescuentosBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDescuentosUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDescuentosUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDescuentosSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDescuentosCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDescuentosDes ) + "'" >>, <<lxDescuentosMondes >>, <<lxDescuentosMonhas >>, <<lxDescuentosIntera >>, <<"'" + this.FormatearTextoSql( lxDescuentosTobs ) + "'" >>, <<"'" + this.ConvertirDateSql( lxDescuentosFecdes ) + "'" >>, <<lxDescuentosMonto >>, <<"'" + this.ConvertirDateSql( lxDescuentosFechas ) + "'" >>, <<lxDescuentosPorcdes >>, <<"'" + this.FormatearTextoSql( lxDescuentosHordes ) + "'" >>, <<lxDescuentosMontomax >>, <<"'" + this.FormatearTextoSql( lxDescuentosHorhas ) + "'" >>, <<lxDescuentosPorcmax >>, <<lxDescuentosOrden >>, <<lxDescuentosFunc >>, <<lxDescuentosCantdes >>, <<lxDescuentosCanthas >>, <<"'" + this.FormatearTextoSql( lxDescuentosPerfdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDescuentosPerfhasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDescuentosListdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDescuentosListhasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDescuentosVenddesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDescuentosVendhasta ) + "'" >>, <<iif( lxDescuentosDialu, 1, 0 ) >>, <<iif( lxDescuentosDiama, 1, 0 ) >>, <<iif( lxDescuentosDiami, 1, 0 ) >>, <<iif( lxDescuentosDiaju, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxDescuentosClascdesde ) + "'" >>, <<iif( lxDescuentosDiavi, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxDescuentosClaschasta ) + "'" >>, <<iif( lxDescuentosDiasa, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxDescuentosTipocdesde ) + "'" >>, <<iif( lxDescuentosDiado, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxDescuentosTipochasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDescuentosCatecdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDescuentosCatechasta ) + "'" >> )
		endtext
		loColeccion.cTabla = 'DESCUENTOS' 
		loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		With this
			local lcValorClavePrimariaString as String
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcSentencia = this.ObtenerSentenciasInsertAuditoria()
			loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.DescuentoDetalle
				if this.oEntidad.DescuentoDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxComprobante = loItem.Comprobante
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.DescuentoDet("NROITEM","CODIGO","Comprobant" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxComprobante ) + "'">> ) 
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
						Insert into ZooLogic.AgruPubDES("NROITEM","Codigo","Agrup","AgrupDes" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxAgrupamiento_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxAgrupamientodetalle ) + "'">> ) 
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
			local  lxDescuentosFmodifw, lxDescuentosFectrans, lxDescuentosFecexpo, lxDescuentosFecimpo, lxDescuentosFaltafw, lxDescuentosTimestamp, lxDescuentosTipagrupub, lxDescuentosInactivofw, lxDescuentosHoraexpo, lxDescuentosBdmodifw, lxDescuentosHaltafw, lxDescuentosZadsfw, lxDescuentosEsttrans, lxDescuentosDescfw, lxDescuentosHmodifw, lxDescuentosHoraimpo, lxDescuentosSaltafw, lxDescuentosValtafw, lxDescuentosVmodifw, lxDescuentosBdaltafw, lxDescuentosUmodifw, lxDescuentosUaltafw, lxDescuentosSmodifw, lxDescuentosCodigo, lxDescuentosDes, lxDescuentosMondes, lxDescuentosMonhas, lxDescuentosIntera, lxDescuentosTobs, lxDescuentosFecdes, lxDescuentosMonto, lxDescuentosFechas, lxDescuentosPorcdes, lxDescuentosHordes, lxDescuentosMontomax, lxDescuentosHorhas, lxDescuentosPorcmax, lxDescuentosOrden, lxDescuentosFunc, lxDescuentosCantdes, lxDescuentosCanthas, lxDescuentosPerfdesde, lxDescuentosPerfhasta, lxDescuentosListdesde, lxDescuentosListhasta, lxDescuentosVenddesde, lxDescuentosVendhasta, lxDescuentosDialu, lxDescuentosDiama, lxDescuentosDiami, lxDescuentosDiaju, lxDescuentosClascdesde, lxDescuentosDiavi, lxDescuentosClaschasta, lxDescuentosDiasa, lxDescuentosTipocdesde, lxDescuentosDiado, lxDescuentosTipochasta, lxDescuentosCatecdesde, lxDescuentosCatechasta
				lxDescuentosFmodifw =  .Fechamodificacionfw			lxDescuentosFectrans =  .Fechatransferencia			lxDescuentosFecexpo =  .Fechaexpo			lxDescuentosFecimpo =  .Fechaimpo			lxDescuentosFaltafw =  .Fechaaltafw			lxDescuentosTimestamp = goLibrerias.ObtenerTimestamp()			lxDescuentosTipagrupub =  .Tipoagrupamientopublicaciones			lxDescuentosInactivofw =  .Inactivofw			lxDescuentosHoraexpo =  .Horaexpo			lxDescuentosBdmodifw =  .Basededatosmodificacionfw			lxDescuentosHaltafw =  .Horaaltafw			lxDescuentosZadsfw =  .Zadsfw			lxDescuentosEsttrans =  .Estadotransferencia			lxDescuentosDescfw =  .Descripcionfw			lxDescuentosHmodifw =  .Horamodificacionfw			lxDescuentosHoraimpo =  .Horaimpo			lxDescuentosSaltafw =  .Seriealtafw			lxDescuentosValtafw =  .Versionaltafw			lxDescuentosVmodifw =  .Versionmodificacionfw			lxDescuentosBdaltafw =  .Basededatosaltafw			lxDescuentosUmodifw =  .Usuariomodificacionfw			lxDescuentosUaltafw =  .Usuarioaltafw			lxDescuentosSmodifw =  .Seriemodificacionfw			lxDescuentosCodigo =  .Codigo			lxDescuentosDes =  .Descripcion			lxDescuentosMondes =  .Montodesde			lxDescuentosMonhas =  .Montohasta			lxDescuentosIntera =  .Interaccion			lxDescuentosTobs =  .Obs			lxDescuentosFecdes =  .Fechadesde			lxDescuentosMonto =  .Monto			lxDescuentosFechas =  .Fechahasta			lxDescuentosPorcdes =  .Porcentaje			lxDescuentosHordes =  .Horadesde			lxDescuentosMontomax =  .Montomax			lxDescuentosHorhas =  .Horahasta			lxDescuentosPorcmax =  .Porcentajemax			lxDescuentosOrden =  .Orden			lxDescuentosFunc =  .Modofuncionamiento			lxDescuentosCantdes =  .Cantidaddesde			lxDescuentosCanthas =  .Cantidadhasta			lxDescuentosPerfdesde =  .Perfildesde			lxDescuentosPerfhasta =  .Perfilhasta			lxDescuentosListdesde =  upper( .ListaDesde_PK ) 			lxDescuentosListhasta =  upper( .ListaHasta_PK ) 			lxDescuentosVenddesde =  upper( .VendDesde_PK ) 			lxDescuentosVendhasta =  upper( .VendHasta_PK ) 			lxDescuentosDialu =  .Dialu			lxDescuentosDiama =  .Diama			lxDescuentosDiami =  .Diami			lxDescuentosDiaju =  .Diaju			lxDescuentosClascdesde =  upper( .Cliente_ClasificacionCDesde_PK ) 			lxDescuentosDiavi =  .Diavi			lxDescuentosClaschasta =  upper( .Cliente_ClasificacionCHasta_PK ) 			lxDescuentosDiasa =  .Diasa			lxDescuentosTipocdesde =  upper( .Cliente_TipoCDesde_PK ) 			lxDescuentosDiado =  .Diado			lxDescuentosTipochasta =  upper( .Cliente_TipoCHasta_PK ) 			lxDescuentosCatecdesde =  upper( .Cliente_CategoriaCDesde_PK ) 			lxDescuentosCatechasta =  upper( .Cliente_CategoriaCHasta_PK ) 
		endwith
		With this
			local llInsertarAuditoria as Boolean
			llInsertarAuditoria = (  .oEntidad.oAtributosAuditoria.INACTIVOFW != .oEntidad.INACTIVOFW )
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  DESCUENTOS.CODIGO != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.DESCUENTOS set "Fmodifw" = <<"'" + this.ConvertirDateSql( lxDescuentosFmodifw ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxDescuentosFectrans ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxDescuentosFecexpo ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxDescuentosFecimpo ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxDescuentosFaltafw ) + "'">>, "Timestamp" = <<lxDescuentosTimestamp>>, "Tipagrupub" = <<lxDescuentosTipagrupub>>, "Inactivofw" = <<iif( lxDescuentosInactivofw, 1, 0 )>>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxDescuentosHoraexpo ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxDescuentosBdmodifw ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxDescuentosHaltafw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxDescuentosZadsfw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxDescuentosEsttrans ) + "'">>, "Descfw" = <<"'" + this.FormatearTextoSql( lxDescuentosDescfw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxDescuentosHmodifw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxDescuentosHoraimpo ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxDescuentosSaltafw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxDescuentosValtafw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxDescuentosVmodifw ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxDescuentosBdaltafw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxDescuentosUmodifw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxDescuentosUaltafw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxDescuentosSmodifw ) + "'">>, "Codigo" = <<"'" + this.FormatearTextoSql( lxDescuentosCodigo ) + "'">>, "Des" = <<"'" + this.FormatearTextoSql( lxDescuentosDes ) + "'">>, "Mondes" = <<lxDescuentosMondes>>, "Monhas" = <<lxDescuentosMonhas>>, "Intera" = <<lxDescuentosIntera>>, "Tobs" = <<"'" + this.FormatearTextoSql( lxDescuentosTobs ) + "'">>, "Fecdes" = <<"'" + this.ConvertirDateSql( lxDescuentosFecdes ) + "'">>, "Monto" = <<lxDescuentosMonto>>, "Fechas" = <<"'" + this.ConvertirDateSql( lxDescuentosFechas ) + "'">>, "Porcdes" = <<lxDescuentosPorcdes>>, "Hordes" = <<"'" + this.FormatearTextoSql( lxDescuentosHordes ) + "'">>, "Montomax" = <<lxDescuentosMontomax>>, "Horhas" = <<"'" + this.FormatearTextoSql( lxDescuentosHorhas ) + "'">>, "Porcmax" = <<lxDescuentosPorcmax>>, "Orden" = <<lxDescuentosOrden>>, "Func" = <<lxDescuentosFunc>>, "Cantdes" = <<lxDescuentosCantdes>>, "Canthas" = <<lxDescuentosCanthas>>, "Perfdesde" = <<"'" + this.FormatearTextoSql( lxDescuentosPerfdesde ) + "'">>, "Perfhasta" = <<"'" + this.FormatearTextoSql( lxDescuentosPerfhasta ) + "'">>, "Listdesde" = <<"'" + this.FormatearTextoSql( lxDescuentosListdesde ) + "'">>, "Listhasta" = <<"'" + this.FormatearTextoSql( lxDescuentosListhasta ) + "'">>, "Venddesde" = <<"'" + this.FormatearTextoSql( lxDescuentosVenddesde ) + "'">>, "Vendhasta" = <<"'" + this.FormatearTextoSql( lxDescuentosVendhasta ) + "'">>, "Dialu" = <<iif( lxDescuentosDialu, 1, 0 )>>, "Diama" = <<iif( lxDescuentosDiama, 1, 0 )>>, "Diami" = <<iif( lxDescuentosDiami, 1, 0 )>>, "Diaju" = <<iif( lxDescuentosDiaju, 1, 0 )>>, "Clascdesde" = <<"'" + this.FormatearTextoSql( lxDescuentosClascdesde ) + "'">>, "Diavi" = <<iif( lxDescuentosDiavi, 1, 0 )>>, "Claschasta" = <<"'" + this.FormatearTextoSql( lxDescuentosClaschasta ) + "'">>, "Diasa" = <<iif( lxDescuentosDiasa, 1, 0 )>>, "Tipocdesde" = <<"'" + this.FormatearTextoSql( lxDescuentosTipocdesde ) + "'">>, "Diado" = <<iif( lxDescuentosDiado, 1, 0 )>>, "Tipochasta" = <<"'" + this.FormatearTextoSql( lxDescuentosTipochasta ) + "'">>, "Catecdesde" = <<"'" + this.FormatearTextoSql( lxDescuentosCatecdesde ) + "'">>, "Catechasta" = <<"'" + this.FormatearTextoSql( lxDescuentosCatechasta ) + "'">> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'DESCUENTOS' 
		loColeccion.agregar( strtran(  lcSentencia, chr( 9 ), '' ) )
		If llInsertarAuditoria
			lcSentencia = this.ObtenerSentenciasInsertAuditoria()
			loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		EndIf
			loColeccion.Agregar([delete from ZooLogic.DescuentoDet where "CODIGO" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.AgruPubDES where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.DescuentoDetalle
				if this.oEntidad.DescuentoDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxComprobante = loItem.Comprobante
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.DescuentoDet("NROITEM","CODIGO","Comprobant" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxComprobante ) + "'">> ) 
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
						Insert into ZooLogic.AgruPubDES("NROITEM","Codigo","Agrup","AgrupDes" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxAgrupamiento_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxAgrupamientodetalle ) + "'">> ) 
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

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  DESCUENTOS.CODIGO != '']
		loColeccion.Agregar( 'delete from ZooLogic.DESCUENTOS where ' + lcFiltro )
			loColeccion.Agregar([delete from ZooLogic.DescuentoDet where "CODIGO" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.AgruPubDES where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.cTabla = 'DESCUENTOS' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.DESCUENTOS where  DESCUENTOS.CODIGO != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.DESCUENTOS where codigo = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  DESCUENTOS.CODIGO != ''" )
			this.xmlacursor( lcXml, lcCursor )
		if reccount( lcCursor ) > 0
			lnTimeStamp = &lcCursor..Timestamp
		endif
		use in select( lcCursor )

		return lnTimeStamp 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirCabecera( tlLoguear as Boolean ) As Void
		local lcCursor as String, ldFecha as Date, lcHora as string, lcValorABuscar As String, lxValorClavePK As variant, lxValorClavePrimaria As variant, lcIdentificadorParaLoguear as string, lxDescuentosInactivoFW as variant, lcMensajeExtra as String
		lcValorABuscar = ''
		lxValorClavePK = ''
		lcMensajeExtra = ''
		lcCursor = This.oEntidad.cPrefijoRecibir + 'DESCUENTO'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.DESCUENTOS Where codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..codigo ) + "'", 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
					local llInsertarAuditoria as boolean
					llInsertarAuditoria = (  iif( isnull( curSeek.InactivoFW != &lcCursor..InactivoFW ), .F., curSeek.InactivoFW != &lcCursor..InactivoFW ) )
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
						lcCadena = lcCadena + [ for codigo= curseek.codigo]
						&lcCadena.
						select( lcCursor )
						go lnPos
					endif
					this.oConexion.EjecutarSql( [UPDATE ZooLogic.DESCUENTOS set  FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, TIMESTAMP = ] + transform( &lcCursor..TIMESTAMP )+ [, tipagrupub = ] + transform( &lcCursor..tipagrupub )+ [, InactivoFW = ] + Transform( iif( &lcCursor..InactivoFW, 1, 0 ))+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, DescFW = ] + "'" + this.FormatearTextoSql( &lcCursor..DescFW ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..codigo ) + "'"+ [, Des = ] + "'" + this.FormatearTextoSql( &lcCursor..Des ) + "'"+ [, mondes = ] + transform( &lcCursor..mondes )+ [, monhas = ] + transform( &lcCursor..monhas )+ [, intera = ] + transform( &lcCursor..intera )+ [, TObs = ] + "'" + this.FormatearTextoSql( &lcCursor..TObs ) + "'"+ [, fecdes = ] + "'" + this.ConvertirDateSql( &lcCursor..fecdes ) + "'"+ [, monto = ] + transform( &lcCursor..monto )+ [, fechas = ] + "'" + this.ConvertirDateSql( &lcCursor..fechas ) + "'"+ [, Porcdes = ] + transform( &lcCursor..Porcdes )+ [, hordes = ] + "'" + this.FormatearTextoSql( &lcCursor..hordes ) + "'"+ [, montomax = ] + transform( &lcCursor..montomax )+ [, horhas = ] + "'" + this.FormatearTextoSql( &lcCursor..horhas ) + "'"+ [, Porcmax = ] + transform( &lcCursor..Porcmax )+ [, orden = ] + transform( &lcCursor..orden )+ [, func = ] + transform( &lcCursor..func )+ [, cantdes = ] + transform( &lcCursor..cantdes )+ [, canthas = ] + transform( &lcCursor..canthas )+ [, perfdesde = ] + "'" + this.FormatearTextoSql( &lcCursor..perfdesde ) + "'"+ [, perfhasta = ] + "'" + this.FormatearTextoSql( &lcCursor..perfhasta ) + "'"+ [, ListDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..ListDesde ) + "'"+ [, ListHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..ListHasta ) + "'"+ [, VendDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..VendDesde ) + "'"+ [, VendHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..VendHasta ) + "'"+ [, DiaLu = ] + Transform( iif( &lcCursor..DiaLu, 1, 0 ))+ [, DiaMa = ] + Transform( iif( &lcCursor..DiaMa, 1, 0 ))+ [, DiaMi = ] + Transform( iif( &lcCursor..DiaMi, 1, 0 ))+ [, DiaJu = ] + Transform( iif( &lcCursor..DiaJu, 1, 0 ))+ [, ClascDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..ClascDesde ) + "'"+ [, DiaVi = ] + Transform( iif( &lcCursor..DiaVi, 1, 0 ))+ [, ClascHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..ClascHasta ) + "'"+ [, DiaSa = ] + Transform( iif( &lcCursor..DiaSa, 1, 0 ))+ [, TipocDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..TipocDesde ) + "'"+ [, DiaDo = ] + Transform( iif( &lcCursor..DiaDo, 1, 0 ))+ [, TipocHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..TipocHasta ) + "'"+ [, CatecDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..CatecDesde ) + "'"+ [, CatecHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..CatecHasta ) + "'" + [ Where codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..codigo ) + "'" )
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
					 FMODIFW, FECTRANS, FECEXPO, FECIMPO, FALTAFW, TIMESTAMP, tipagrupub, InactivoFW, HORAEXPO, BDMODIFW, HALTAFW, ZADSFW, ESTTRANS, DescFW, HMODIFW, HORAIMPO, SALTAFW, VALTAFW, VMODIFW, BDALTAFW, UMODIFW, UALTAFW, SMODIFW, codigo, Des, mondes, monhas, intera, TObs, fecdes, monto, fechas, Porcdes, hordes, montomax, horhas, Porcmax, orden, func, cantdes, canthas, perfdesde, perfhasta, ListDesde, ListHasta, VendDesde, VendHasta, DiaLu, DiaMa, DiaMi, DiaJu, ClascDesde, DiaVi, ClascHasta, DiaSa, TipocDesde, DiaDo, TipocHasta, CatecDesde, CatecHasta
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + transform( &lcCursor..TIMESTAMP ) + ',' + transform( &lcCursor..tipagrupub )
lcValoresCampos = lcValoresCampos  + ',' + Transform( iif( &lcCursor..InactivoFW, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..DescFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..codigo ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Des ) + "'" + ',' + transform( &lcCursor..mondes ) + ',' + transform( &lcCursor..monhas ) + ',' + transform( &lcCursor..intera ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..TObs ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..fecdes ) + "'" + ',' + transform( &lcCursor..monto ) + ',' + "'" + this.ConvertirDateSql( &lcCursor..fechas ) + "'" + ',' + transform( &lcCursor..Porcdes ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..hordes ) + "'" + ',' + transform( &lcCursor..montomax ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..horhas ) + "'" + ',' + transform( &lcCursor..Porcmax )
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..orden ) + ',' + transform( &lcCursor..func ) + ',' + transform( &lcCursor..cantdes ) + ',' + transform( &lcCursor..canthas ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..perfdesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..perfhasta ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ListDesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ListHasta ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..VendDesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VendHasta ) + "'" + ',' + Transform( iif( &lcCursor..DiaLu, 1, 0 )) + ',' + Transform( iif( &lcCursor..DiaMa, 1, 0 )) + ',' + Transform( iif( &lcCursor..DiaMi, 1, 0 )) + ',' + Transform( iif( &lcCursor..DiaJu, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..ClascDesde ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + Transform( iif( &lcCursor..DiaVi, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..ClascHasta ) + "'" + ',' + Transform( iif( &lcCursor..DiaSa, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..TipocDesde ) + "'" + ',' + Transform( iif( &lcCursor..DiaDo, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..TipocHasta ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CatecDesde ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..CatecHasta ) + "'"
lcValoresCampos = substr(lcValoresCampos,2) 

				this.oConexion.EjecutarSql( [Insert into ZooLogic.DESCUENTOS ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
				lcSentencia = this.ObtenerSentenciasInsertAuditoria( lcCursor )
				this.oConexion.EjecutarSql( lcSentencia )
				this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'DESCUENTO'
		if This.ActualizaEnRecepcion()
		Local lcIn as String, lcCantRegistros as Integer
		Select( lcCursor )
		Count to lcCantRegistros
		If lcCantRegistros > 0
			lcIn = This.ObtenerInSqlServer( lcCursor, 'codigo','C')
			lnFragmento = goRegistry.nucleo.cantidadDeElementosEnSentenciaInSQL
			loIn = this.ObtenerColeccionInSqlServer( lcCursor,'','codigo')
			llEjecutaEnTransaccion = loIn.count > 0
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'BEGIN TRANSACTION' )
			endif
			for i = 1 to loIn.count step lnFragmento
				lcIn = this.ObtenerFragmentoColeccionInSqlServer( loIn, i, lnFragmento )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.DescuentoDet Where CODIGO] + lcIn  )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.AgruPubDES Where Codigo] + lcIn  )
			endfor
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'COMMIT TRANSACTION' )
			endif
		EndIf
	endif
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMDESCUENTO'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where CODIGO in ( select codigo from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"NROITEM","CODIGO","Comprobant"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.DescuentoDet ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CODIGO     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Comprobant ) + "'" + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMAGRUPAPUBLICDES'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where Codigo in ( select codigo from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"NROITEM","Codigo","Agrup","AgrupDes"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.AgruPubDES ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Codigo     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Agrup      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.AgrupDes   ) + "'" + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	Use in select( 'cExistentes' )
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearCursorMemo( tcCursorACrear as String, tcTablaConMemo as String ) as Void
		create cursor &tcCursorACrear ( codigo C (10) , Orden N(16), texto C(80))
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
			Case  lcAlias == lcPrefijo + 'DESCUENTO'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'DESCUENTO_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'DESCUENTO_TOBS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMDESCUENTO'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMAGRUPAPUBLICDES'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_Descuentos')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'DESCUENTO'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..codigo
		llCondicion = isnull( lxVar )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad DESCUENTO. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'DESCUENTO'
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
			lcCursor = This.oEntidad.cPrefijoRecibir + 'DESCUENTO'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  fecdes    
		* Validar ANTERIORES A 1/1/1753  fechas    
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_Descuentos') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_Descuentos
Create Table ZooLogic.TablaTrabajo_Descuentos ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fmodifw" datetime  null, 
"fectrans" datetime  null, 
"fecexpo" datetime  null, 
"fecimpo" datetime  null, 
"faltafw" datetime  null, 
"timestamp" numeric( 20, 0 )  null, 
"tipagrupub" numeric( 1, 0 )  null, 
"inactivofw" bit  null, 
"horaexpo" char( 8 )  null, 
"bdmodifw" char( 8 )  null, 
"haltafw" char( 8 )  null, 
"zadsfw" varchar(max)  null, 
"esttrans" char( 20 )  null, 
"descfw" char( 200 )  null, 
"hmodifw" char( 8 )  null, 
"horaimpo" char( 8 )  null, 
"saltafw" char( 7 )  null, 
"valtafw" char( 13 )  null, 
"vmodifw" char( 13 )  null, 
"bdaltafw" char( 8 )  null, 
"umodifw" char( 100 )  null, 
"ualtafw" char( 100 )  null, 
"smodifw" char( 7 )  null, 
"codigo" char( 10 )  null, 
"des" char( 30 )  null, 
"mondes" numeric( 16, 2 )  null, 
"monhas" numeric( 16, 2 )  null, 
"intera" numeric( 1, 0 )  null, 
"tobs" varchar(max)  null, 
"fecdes" datetime  null, 
"monto" numeric( 15, 2 )  null, 
"fechas" datetime  null, 
"porcdes" numeric( 7, 2 )  null, 
"hordes" char( 5 )  null, 
"montomax" numeric( 15, 2 )  null, 
"horhas" char( 5 )  null, 
"porcmax" numeric( 7, 2 )  null, 
"orden" numeric( 4, 0 )  null, 
"func" numeric( 1, 0 )  null, 
"cantdes" numeric( 10, 0 )  null, 
"canthas" numeric( 10, 0 )  null, 
"perfdesde" char( 30 )  null, 
"perfhasta" char( 30 )  null, 
"listdesde" char( 6 )  null, 
"listhasta" char( 6 )  null, 
"venddesde" char( 5 )  null, 
"vendhasta" char( 5 )  null, 
"dialu" bit  null, 
"diama" bit  null, 
"diami" bit  null, 
"diaju" bit  null, 
"clascdesde" char( 10 )  null, 
"diavi" bit  null, 
"claschasta" char( 10 )  null, 
"diasa" bit  null, 
"tipocdesde" char( 10 )  null, 
"diado" bit  null, 
"tipochasta" char( 10 )  null, 
"catecdesde" char( 10 )  null, 
"catechasta" char( 10 )  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_Descuentos' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_Descuentos' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'DESCUENTO'
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
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('timestamp','timestamp')
			.AgregarMapeo('tipagrupub','tipagrupub')
			.AgregarMapeo('inactivofw','inactivofw')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('descfw','descfw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('codigo','codigo')
			.AgregarMapeo('des','des')
			.AgregarMapeo('mondes','mondes')
			.AgregarMapeo('monhas','monhas')
			.AgregarMapeo('intera','intera')
			.AgregarMapeo('tobs','tobs')
			.AgregarMapeo('fecdes','fecdes')
			.AgregarMapeo('monto','monto')
			.AgregarMapeo('fechas','fechas')
			.AgregarMapeo('porcdes','porcdes')
			.AgregarMapeo('hordes','hordes')
			.AgregarMapeo('montomax','montomax')
			.AgregarMapeo('horhas','horhas')
			.AgregarMapeo('porcmax','porcmax')
			.AgregarMapeo('orden','orden')
			.AgregarMapeo('func','func')
			.AgregarMapeo('cantdes','cantdes')
			.AgregarMapeo('canthas','canthas')
			.AgregarMapeo('perfdesde','perfdesde')
			.AgregarMapeo('perfhasta','perfhasta')
			.AgregarMapeo('listdesde','listdesde')
			.AgregarMapeo('listhasta','listhasta')
			.AgregarMapeo('venddesde','venddesde')
			.AgregarMapeo('vendhasta','vendhasta')
			.AgregarMapeo('dialu','dialu')
			.AgregarMapeo('diama','diama')
			.AgregarMapeo('diami','diami')
			.AgregarMapeo('diaju','diaju')
			.AgregarMapeo('clascdesde','clascdesde')
			.AgregarMapeo('diavi','diavi')
			.AgregarMapeo('claschasta','claschasta')
			.AgregarMapeo('diasa','diasa')
			.AgregarMapeo('tipocdesde','tipocdesde')
			.AgregarMapeo('diado','diado')
			.AgregarMapeo('tipochasta','tipochasta')
			.AgregarMapeo('catecdesde','catecdesde')
			.AgregarMapeo('catechasta','catechasta')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_Descuentos'
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
				insert into ZooLogic.ADT_DESCUENTOS ( "ADT_Cod","ADT_Fecha","ADT_Hora","ADT_Serie","ADT_Usr","ADT_Ent","ADT_Comp","ADT_ADN","ADT_Vers","ADT_Ext","codigo","Inactivofw" ) 
					Select <<lcCabecera1>>, <<lcCabecera2>>, <<lcCabecera3>>, <<lcCabecera4>>, <<lcCabecera5>>, <<lcCabecera6>>, case when funciones.empty( d.DescFw ) = 1 then 'IMPORTACION' else d.descFw end, <<lcCabecera7>>, <<lcCabecera8>>, <<lcCabecera9>>, d.Codigo,Isnull( d.Inactivofw,t.Inactivofw)
						from ZooLogic.DESCUENTOS t inner join deleted d 
							 on t.codigo = d.codigo
					where ( d.InactivoFW is not null and d.InactivoFW <> t.InactivoFW )
				Update t Set t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.TIMESTAMP = isnull( d.TIMESTAMP, t.TIMESTAMP ),t.TIPAGRUPUB = isnull( d.TIPAGRUPUB, t.TIPAGRUPUB ),t.INACTIVOFW = isnull( d.INACTIVOFW, t.INACTIVOFW ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.DESCFW = isnull( d.DESCFW, t.DESCFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.CODIGO = isnull( d.CODIGO, t.CODIGO ),t.DES = isnull( d.DES, t.DES ),t.MONDES = isnull( d.MONDES, t.MONDES ),t.MONHAS = isnull( d.MONHAS, t.MONHAS ),t.INTERA = isnull( d.INTERA, t.INTERA ),t.TOBS = isnull( d.TOBS, t.TOBS ),t.FECDES = isnull( d.FECDES, t.FECDES ),t.MONTO = isnull( d.MONTO, t.MONTO ),t.FECHAS = isnull( d.FECHAS, t.FECHAS ),t.PORCDES = isnull( d.PORCDES, t.PORCDES ),t.HORDES = isnull( d.HORDES, t.HORDES ),t.MONTOMAX = isnull( d.MONTOMAX, t.MONTOMAX ),t.HORHAS = isnull( d.HORHAS, t.HORHAS ),t.PORCMAX = isnull( d.PORCMAX, t.PORCMAX ),t.ORDEN = isnull( d.ORDEN, t.ORDEN ),t.FUNC = isnull( d.FUNC, t.FUNC ),t.CANTDES = isnull( d.CANTDES, t.CANTDES ),t.CANTHAS = isnull( d.CANTHAS, t.CANTHAS ),t.PERFDESDE = isnull( d.PERFDESDE, t.PERFDESDE ),t.PERFHASTA = isnull( d.PERFHASTA, t.PERFHASTA ),t.LISTDESDE = isnull( d.LISTDESDE, t.LISTDESDE ),t.LISTHASTA = isnull( d.LISTHASTA, t.LISTHASTA ),t.VENDDESDE = isnull( d.VENDDESDE, t.VENDDESDE ),t.VENDHASTA = isnull( d.VENDHASTA, t.VENDHASTA ),t.DIALU = isnull( d.DIALU, t.DIALU ),t.DIAMA = isnull( d.DIAMA, t.DIAMA ),t.DIAMI = isnull( d.DIAMI, t.DIAMI ),t.DIAJU = isnull( d.DIAJU, t.DIAJU ),t.CLASCDESDE = isnull( d.CLASCDESDE, t.CLASCDESDE ),t.DIAVI = isnull( d.DIAVI, t.DIAVI ),t.CLASCHASTA = isnull( d.CLASCHASTA, t.CLASCHASTA ),t.DIASA = isnull( d.DIASA, t.DIASA ),t.TIPOCDESDE = isnull( d.TIPOCDESDE, t.TIPOCDESDE ),t.DIADO = isnull( d.DIADO, t.DIADO ),t.TIPOCHASTA = isnull( d.TIPOCHASTA, t.TIPOCHASTA ),t.CATECDESDE = isnull( d.CATECDESDE, t.CATECDESDE ),t.CATECHASTA = isnull( d.CATECHASTA, t.CATECHASTA )
					from ZooLogic.DESCUENTOS t inner join deleted d 
							 on t.codigo = d.codigo
				-- Fin Updates
				insert into ZooLogic.ADT_DESCUENTOS ( "ADT_Cod","ADT_Fecha","ADT_Hora","ADT_Serie","ADT_Usr","ADT_Ent","ADT_Comp","ADT_ADN","ADT_Vers","ADT_Ext","codigo","Inactivofw" ) 
					Select <<lcCabecera1>>, <<lcCabecera2>>, <<lcCabecera3>>, <<lcCabecera4>>, <<lcCabecera5>>, <<lcCabecera6>>, case when funciones.empty( d.DescFw ) = 1 then 'IMPORTACION' else d.descFw end, <<lcCabecera7>>, <<lcCabecera8>>, <<lcCabecera9>>, d.Codigo,isnull( d.INACTIVOFW,0)
						From deleted d left join ZooLogic.DESCUENTOS pk 
							 on d.codigo = pk.codigo
						Where pk.codigo Is Null 
				insert into ZooLogic.DESCUENTOS(Fmodifw,Fectrans,Fecexpo,Fecimpo,Faltafw,Timestamp,Tipagrupub,Inactivofw,Horaexpo,Bdmodifw,Haltafw,Zadsfw,Esttrans,Descfw,Hmodifw,Horaimpo,Saltafw,Valtafw,Vmodifw,Bdaltafw,Umodifw,Ualtafw,Smodifw,Codigo,Des,Mondes,Monhas,Intera,Tobs,Fecdes,Monto,Fechas,Porcdes,Hordes,Montomax,Horhas,Porcmax,Orden,Func,Cantdes,Canthas,Perfdesde,Perfhasta,Listdesde,Listhasta,Venddesde,Vendhasta,Dialu,Diama,Diami,Diaju,Clascdesde,Diavi,Claschasta,Diasa,Tipocdesde,Diado,Tipochasta,Catecdesde,Catechasta)
					Select isnull( d.FMODIFW,''),isnull( d.FECTRANS,''),isnull( d.FECEXPO,''),isnull( d.FECIMPO,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.TIMESTAMP,0),isnull( d.TIPAGRUPUB,0),isnull( d.INACTIVOFW,0),isnull( d.HORAEXPO,''),isnull( d.BDMODIFW,''),convert( char(8), getdate(), 108 ),isnull( d.ZADSFW,''),isnull( d.ESTTRANS,''),isnull( d.DESCFW,''),isnull( d.HMODIFW,''),isnull( d.HORAIMPO,''),isnull( d.SALTAFW,''),isnull( d.VALTAFW,''),isnull( d.VMODIFW,''),isnull( d.BDALTAFW,''),isnull( d.UMODIFW,''),isnull( d.UALTAFW,''),isnull( d.SMODIFW,''),isnull( d.CODIGO,''),isnull( d.DES,''),isnull( d.MONDES,0),isnull( d.MONHAS,0),isnull( d.INTERA,0),isnull( d.TOBS,''),isnull( d.FECDES,''),isnull( d.MONTO,0),isnull( d.FECHAS,''),isnull( d.PORCDES,0),isnull( d.HORDES,''),isnull( d.MONTOMAX,0),isnull( d.HORHAS,''),isnull( d.PORCMAX,0),isnull( d.ORDEN,0),isnull( d.FUNC,0),isnull( d.CANTDES,0),isnull( d.CANTHAS,0),isnull( d.PERFDESDE,''),isnull( d.PERFHASTA,''),isnull( d.LISTDESDE,''),isnull( d.LISTHASTA,''),isnull( d.VENDDESDE,''),isnull( d.VENDHASTA,''),isnull( d.DIALU,0),isnull( d.DIAMA,0),isnull( d.DIAMI,0),isnull( d.DIAJU,0),isnull( d.CLASCDESDE,''),isnull( d.DIAVI,0),isnull( d.CLASCHASTA,''),isnull( d.DIASA,0),isnull( d.TIPOCDESDE,''),isnull( d.DIADO,0),isnull( d.TIPOCHASTA,''),isnull( d.CATECDESDE,''),isnull( d.CATECHASTA,'')
						From deleted d left join ZooLogic.DESCUENTOS pk 
							 on d.codigo = pk.codigo
						Where pk.codigo Is Null 
				-- Fin Inserts
			End
		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_DescuentoDet( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_DESCUENTOS_DescuentoDet
ON ZooLogic.TablaTrabajo_DESCUENTOS_DescuentoDet
AFTER DELETE
As
Begin
Update t Set 
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.CODIGO = isnull( d.CODIGO, t.CODIGO ),
t.COMPROBANT = isnull( d.COMPROBANT, t.COMPROBANT )
from ZooLogic.DescuentoDet t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.DescuentoDet
( 
"NROITEM",
"CODIGO",
"COMPROBANT"
 )
Select 
d.NROITEM,
d.CODIGO,
d.COMPROBANT
From deleted d left join ZooLogic.DescuentoDet pk 
 on d.CODIGO = pk.CODIGO
Where pk.CODIGO Is Null 
-- Fin Inserts
End

		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_AgruPubDES( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_DESCUENTOS_AgruPubDES
ON ZooLogic.TablaTrabajo_DESCUENTOS_AgruPubDES
AFTER DELETE
As
Begin
Update t Set 
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.CODIGO = isnull( d.CODIGO, t.CODIGO ),
t.AGRUP = isnull( d.AGRUP, t.AGRUP ),
t.AGRUPDES = isnull( d.AGRUPDES, t.AGRUPDES )
from ZooLogic.AgruPubDES t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.AgruPubDES
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
From deleted d left join ZooLogic.AgruPubDES pk 
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_Descuentos') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_Descuentos
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_DESCUENTO' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_DESCUENTO.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_DESCUENTO.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_DESCUENTO.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_DESCUENTO.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_DESCUENTO.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Timestamp = nvl( c_DESCUENTO.Timestamp, 0 )
					.Tipoagrupamientopublicaciones = nvl( c_DESCUENTO.Tipoagrupamientopublicaciones, 0 )
					.Inactivofw = nvl( c_DESCUENTO.Inactivofw, .F. )
					.Horaexpo = nvl( c_DESCUENTO.Horaexpo, [] )
					.Basededatosmodificacionfw = nvl( c_DESCUENTO.Basededatosmodificacionfw, [] )
					.Horaaltafw = nvl( c_DESCUENTO.Horaaltafw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Estadotransferencia = nvl( c_DESCUENTO.Estadotransferencia, [] )
					.Descripcionfw = nvl( c_DESCUENTO.Descripcionfw, [] )
					.Horamodificacionfw = nvl( c_DESCUENTO.Horamodificacionfw, [] )
					.Horaimpo = nvl( c_DESCUENTO.Horaimpo, [] )
					.Seriealtafw = nvl( c_DESCUENTO.Seriealtafw, [] )
					.Versionaltafw = nvl( c_DESCUENTO.Versionaltafw, [] )
					.Versionmodificacionfw = nvl( c_DESCUENTO.Versionmodificacionfw, [] )
					.Basededatosaltafw = nvl( c_DESCUENTO.Basededatosaltafw, [] )
					.Usuariomodificacionfw = nvl( c_DESCUENTO.Usuariomodificacionfw, [] )
					.Usuarioaltafw = nvl( c_DESCUENTO.Usuarioaltafw, [] )
					.Seriemodificacionfw = nvl( c_DESCUENTO.Seriemodificacionfw, [] )
					.Codigo = nvl( c_DESCUENTO.Codigo, [] )
					.Descuentodetalle.Limpiar()
					.Descuentodetalle.SetearEsNavegacion( .lProcesando )
					.Descuentodetalle.Cargar()
					.Descripcion = nvl( c_DESCUENTO.Descripcion, [] )
					if !.lEsSubEntidad
					.Agrupublidetalle.Limpiar()
					.Agrupublidetalle.SetearEsNavegacion( .lProcesando )
					.Agrupublidetalle.Cargar()
					endif
					.Montodesde = nvl( c_DESCUENTO.Montodesde, 0 )
					.Montohasta = nvl( c_DESCUENTO.Montohasta, 0 )
					.Interaccion = nvl( c_DESCUENTO.Interaccion, 0 )
					lcValor = This.ObtenerMemo( 'c_Obs')
					.Obs = lcValor 
					.Fechadesde = GoLibrerias.ObtenerFechaFormateada( nvl( c_DESCUENTO.Fechadesde, ctod( '  /  /    ' ) ) )
					.Monto = nvl( c_DESCUENTO.Monto, 0 )
					.Fechahasta = GoLibrerias.ObtenerFechaFormateada( nvl( c_DESCUENTO.Fechahasta, ctod( '  /  /    ' ) ) )
					.Porcentaje = nvl( c_DESCUENTO.Porcentaje, 0 )
					.Horadesde = nvl( c_DESCUENTO.Horadesde, [] )
					.Montomax = nvl( c_DESCUENTO.Montomax, 0 )
					.Horahasta = nvl( c_DESCUENTO.Horahasta, [] )
					.Porcentajemax = nvl( c_DESCUENTO.Porcentajemax, 0 )
					.Orden = nvl( c_DESCUENTO.Orden, 0 )
					.Modofuncionamiento = nvl( c_DESCUENTO.Modofuncionamiento, 0 )
					.Cantidaddesde = nvl( c_DESCUENTO.Cantidaddesde, 0 )
					.Cantidadhasta = nvl( c_DESCUENTO.Cantidadhasta, 0 )
					.Perfildesde = nvl( c_DESCUENTO.Perfildesde, [] )
					.Perfilhasta = nvl( c_DESCUENTO.Perfilhasta, [] )
					.Listadesde_PK =  nvl( c_DESCUENTO.Listadesde, [] )
					.Listahasta_PK =  nvl( c_DESCUENTO.Listahasta, [] )
					.Venddesde_PK =  nvl( c_DESCUENTO.Venddesde, [] )
					.Vendhasta_PK =  nvl( c_DESCUENTO.Vendhasta, [] )
					.Dialu = nvl( c_DESCUENTO.Dialu, .F. )
					.Diama = nvl( c_DESCUENTO.Diama, .F. )
					.Diami = nvl( c_DESCUENTO.Diami, .F. )
					.Diaju = nvl( c_DESCUENTO.Diaju, .F. )
					.Cliente_clasificacioncdesde_PK =  nvl( c_DESCUENTO.Cliente_clasificacioncdesde, [] )
					.Diavi = nvl( c_DESCUENTO.Diavi, .F. )
					.Cliente_clasificacionchasta_PK =  nvl( c_DESCUENTO.Cliente_clasificacionchasta, [] )
					.Diasa = nvl( c_DESCUENTO.Diasa, .F. )
					.Cliente_tipocdesde_PK =  nvl( c_DESCUENTO.Cliente_tipocdesde, [] )
					.Diado = nvl( c_DESCUENTO.Diado, .F. )
					.Cliente_tipochasta_PK =  nvl( c_DESCUENTO.Cliente_tipochasta, [] )
					.Cliente_categoriacdesde_PK =  nvl( c_DESCUENTO.Cliente_categoriacdesde, [] )
					.Cliente_categoriachasta_PK =  nvl( c_DESCUENTO.Cliente_categoriachasta, [] )
					Select c_DESCUENTO
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
			Local lcEntidad1 as string, lcEntidad2 as string
			lcEntidad1 = "'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'"
			lcEntidad2 = iif( this.oEntidad.Inactivofw, 1, 0 )
			
		else
			lxValorClavePrimaria = &tcCursor..codigo
			Local lcEntidad1 as string, lcEntidad2 as string
			lcEntidad1 = "'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'"
			lcEntidad2 = iif( &tcCursor..Inactivofw, 1, 0 )
			
		endif
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.ADT_DESCUENTOS ( "ADT_Cod","ADT_Fecha","ADT_Hora","ADT_Serie","ADT_Usr","ADT_Ent","ADT_Comp","ADT_ADN","ADT_Vers","ADT_Ext","codigo","Inactivofw" ) values ( <<lcCabecera1>>, <<lcCabecera2>>, <<lcCabecera3>>, <<lcCabecera4>>, <<lcCabecera5>>, <<lcCabecera6>>, <<lcCabecera7>>, <<lcCabecera8>>, <<lcCabecera9>>, <<lcCabecera10>>, <<lcEntidad1>>, <<lcEntidad2>> ) 
			endtext
		return lcSentencia
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function ActualizarLosNROItemDeLosDetalles() as void
		local loDetalle as object, loItem as object, lnContadorNroItem as integer, lnIndex as integer
		
		loDetalle = this.oEntidad.DescuentoDetalle
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

	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function ObtenerMemo( tcTabla as String ) as string
		local lcAtributo as string
		lcAtributo = strtran( tcTabla, 'c_', '' )
		return c_DESCUENTO.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.DESCUENTOS' )
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
								from ZooLogic.DESCUENTOS 
								Where   DESCUENTOS.CODIGO != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "DESCUENTOS", "", lcCursor, set("Datasession") )
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
			"Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Timestamp" as "Timestamp", "Tipagrupub" as "Tipoagrupamientopublicaciones", "Inactivofw" as "Inactivofw", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Haltafw" as "Horaaltafw", "Zadsfw" as "Zadsfw", "Esttrans" as "Estadotransferencia", "Descfw" as "Descripcionfw", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Codigo" as "Codigo", "Des" as "Descripcion", "Mondes" as "Montodesde", "Monhas" as "Montohasta", "Intera" as "Interaccion", "Tobs" as "Obs", "Fecdes" as "Fechadesde", "Monto" as "Monto", "Fechas" as "Fechahasta", "Porcdes" as "Porcentaje", "Hordes" as "Horadesde", "Montomax" as "Montomax", "Horhas" as "Horahasta", "Porcmax" as "Porcentajemax", "Orden" as "Orden", "Func" as "Modofuncionamiento", "Cantdes" as "Cantidaddesde", "Canthas" as "Cantidadhasta", "Perfdesde" as "Perfildesde", "Perfhasta" as "Perfilhasta", "Listdesde" as "Listadesde", "Listhasta" as "Listahasta", "Venddesde" as "Venddesde", "Vendhasta" as "Vendhasta", "Dialu" as "Dialu", "Diama" as "Diama", "Diami" as "Diami", "Diaju" as "Diaju", "Clascdesde" as "Cliente_clasificacioncdesde", "Diavi" as "Diavi", "Claschasta" as "Cliente_clasificacionchasta", "Diasa" as "Diasa", "Tipocdesde" as "Cliente_tipocdesde", "Diado" as "Diado", "Tipochasta" as "Cliente_tipochasta", "Catecdesde" as "Cliente_categoriacdesde", "Catechasta" as "Cliente_categoriachasta"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.DESCUENTOS 
								Where   DESCUENTOS.CODIGO != ''
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
	Tabla = 'DESCUENTOS'
	Filtro = " DESCUENTOS.CODIGO != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " DESCUENTOS.CODIGO != ''"
	AnchoCampo = 13
	Caracteres = 13
	nrodecolumnas = 0
	signopregunta = .T.
	signopregunta2 = .t.
	TablaAuxiliar = .f.
	cOrden = ""
	FiltroSubEntidad = ' ( DESCUENTOS.InactivoFW = 0)'

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
	<row entidad="DESCUENTO                               " atributo="FECHAMODIFICACIONFW                     " tabla="DESCUENTOS     " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESCUENTO                               " atributo="FECHATRANSFERENCIA                      " tabla="DESCUENTOS     " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha transferencia                                                                                                                                             " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESCUENTO                               " atributo="FECHAEXPO                               " tabla="DESCUENTOS     " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESCUENTO                               " atributo="FECHAIMPO                               " tabla="DESCUENTOS     " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESCUENTO                               " atributo="FECHAALTAFW                             " tabla="DESCUENTOS     " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESCUENTO                               " atributo="TIMESTAMP                               " tabla="DESCUENTOS     " campo="TIMESTAMP " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESCUENTO                               " atributo="TIPOAGRUPAMIENTOPUBLICACIONES           " tabla="DESCUENTOS     " campo="TIPAGRUPUB" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESCUENTO                               " atributo="INACTIVOFW                              " tabla="DESCUENTOS     " campo="INACTIVOFW" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Inactivo                                                                                                                                                        " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESCUENTO                               " atributo="HORAEXPO                                " tabla="DESCUENTOS     " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESCUENTO                               " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="DESCUENTOS     " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESCUENTO                               " atributo="HORAALTAFW                              " tabla="DESCUENTOS     " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESCUENTO                               " atributo="ZADSFW                                  " tabla="DESCUENTOS     " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESCUENTO                               " atributo="ESTADOTRANSFERENCIA                     " tabla="DESCUENTOS     " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado transferencia                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESCUENTO                               " atributo="DESCRIPCIONFW                           " tabla="DESCUENTOS     " campo="DESCFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="200" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESCUENTO                               " atributo="HORAMODIFICACIONFW                      " tabla="DESCUENTOS     " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESCUENTO                               " atributo="HORAIMPO                                " tabla="DESCUENTOS     " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESCUENTO                               " atributo="SERIEALTAFW                             " tabla="DESCUENTOS     " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESCUENTO                               " atributo="VERSIONALTAFW                           " tabla="DESCUENTOS     " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESCUENTO                               " atributo="VERSIONMODIFICACIONFW                   " tabla="DESCUENTOS     " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESCUENTO                               " atributo="BASEDEDATOSALTAFW                       " tabla="DESCUENTOS     " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESCUENTO                               " atributo="USUARIOMODIFICACIONFW                   " tabla="DESCUENTOS     " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESCUENTO                               " atributo="USUARIOALTAFW                           " tabla="DESCUENTOS     " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESCUENTO                               " atributo="SERIEMODIFICACIONFW                     " tabla="DESCUENTOS     " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESCUENTO                               " atributo="CODIGO                                  " tabla="DESCUENTOS     " campo="CODIGO    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="2" etiqueta="Código                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESCUENTO                               " atributo="DESCUENTODETALLE                        " tabla="DESCUENTODET   " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="Detalle                                                                                                                                                         " dominio="DETALLEITEMDESCUENTO          " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="0" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESCUENTO                               " atributo="DESCRIPCION                             " tabla="DESCUENTOS     " campo="DES       " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="402" etiqueta="Descripción                                                                                                                                                     " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESCUENTO                               " atributo="AGRUPUBLIDETALLE                        " tabla="AGRUPUBDES     " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Agrupamientos                                                                                                                                                   " dominio="DETALLEITEMAGRUPAPUBLICDES    " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="1" alta="false" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESCUENTO                               " atributo="MONTODESDE                              " tabla="DESCUENTOS     " campo="MONDES    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="16" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="404" etiqueta="Sub total con IVA                                                                                                                                               " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="12" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESCUENTO                               " atributo="MONTOHASTA                              " tabla="DESCUENTOS     " campo="MONHAS    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="16" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="406" etiqueta="Sub total con IVA                                                                                                                                               " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="12" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESCUENTO                               " atributo="INTERACCION                             " tabla="DESCUENTOS     " campo="INTERA    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="=1                                                                                                                                                                                                                                                            " obligatorio="false" admitebusqueda="6" etiqueta="Interacción con el usuario                                                                                                                                      " dominio="COMBOXML                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESCUENTO                               " atributo="OBS                                     " tabla="DESCUENTOS     " campo="TOBS      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="408" etiqueta="Observaciones                                                                                                                                                   " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="5" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESCUENTO                               " atributo="FECHADESDE                              " tabla="DESCUENTOS     " campo="FECDES    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="410" etiqueta="Fecha                                                                                                                                                           " dominio="EtiquetaFechaDesdeHastaBusc   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="14" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESCUENTO                               " atributo="MONTO                                   " tabla="DESCUENTOS     " campo="MONTO     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="412" etiqueta="Monto                                                                                                                                                           " dominio="NUMERICONONEGATIVO            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="3" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESCUENTO                               " atributo="FECHAHASTA                              " tabla="DESCUENTOS     " campo="FECHAS    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="414" etiqueta="Fecha                                                                                                                                                           " dominio="EtiquetaFechaDesdeHastaBusc   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="14" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESCUENTO                               " atributo="PORCENTAJE                              " tabla="DESCUENTOS     " campo="PORCDES   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="7" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="416" etiqueta="Des%                                                                                                                                                            " dominio="NUMERICOCONSIGNO              " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="3" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESCUENTO                               " atributo="ESPACIOBLANCO                           " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="418" etiqueta="Vacío                                                                                                                                                           " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESCUENTO                               " atributo="HORADESDE                               " tabla="DESCUENTOS     " campo="HORDES    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="420" etiqueta="Hora                                                                                                                                                            " dominio="EtiquetaHoraDesdeHasta        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="6" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESCUENTO                               " atributo="MONTOMAX                                " tabla="DESCUENTOS     " campo="MONTOMAX  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="422" etiqueta="Monto máximo                                                                                                                                                    " dominio="NUMERICONONEGATIVO            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="4" orden="8" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESCUENTO                               " atributo="HORAHASTA                               " tabla="DESCUENTOS     " campo="HORHAS    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="424" etiqueta="Hora                                                                                                                                                            " dominio="EtiquetaHoraDesdeHasta        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="6" orden="8" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESCUENTO                               " atributo="PORCENTAJEMAX                           " tabla="DESCUENTOS     " campo="PORCMAX   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="7" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="426" etiqueta="Porcentaje máximo                                                                                                                                               " dominio="NUMERICOCONSIGNO              " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="4" orden="9" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESCUENTO                               " atributo="ORDEN                                   " tabla="DESCUENTOS     " campo="ORDEN     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="4" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="428" etiqueta="Importancia                                                                                                                                                     " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="9" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESCUENTO                               " atributo="MODOFUNCIONAMIENTO                      " tabla="DESCUENTOS     " campo="FUNC      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="1                                                                                                                                                                                                                                                             " obligatorio="false" admitebusqueda="430" etiqueta="Modo funcionamiento                                                                                                                                             " dominio="COMBO                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="10" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESCUENTO                               " atributo="CANTIDADDESDE                           " tabla="DESCUENTOS     " campo="CANTDES   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="10" decimales="0" valorsugerido="0                                                                                                                                                                                                                                                             " obligatorio="false" admitebusqueda="432" etiqueta="Cantidad Desde                                                                                                                                                  " dominio="EtiquetaNumericoDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="13" orden="11" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESCUENTO                               " atributo="CANTIDADHASTA                           " tabla="DESCUENTOS     " campo="CANTHAS   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="10" decimales="0" valorsugerido="9999999999                                                                                                                                                                                                                                                    " obligatorio="false" admitebusqueda="434" etiqueta="Cantidad Hasta                                                                                                                                                  " dominio="EtiquetaNumericoDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="13" orden="12" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESCUENTO                               " atributo="PERFILDESDE                             " tabla="DESCUENTOS     " campo="PERFDESDE " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="436" etiqueta="Perfil desde                                                                                                                                                    " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="20" orden="20" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESCUENTO                               " atributo="PERFILHASTA                             " tabla="DESCUENTOS     " campo="PERFHASTA " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="=Replicate( &quot;Z&quot;,30)                                                                                                                                                                                                                                           " obligatorio="false" admitebusqueda="438" etiqueta="Perfil hasta                                                                                                                                                    " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="20" orden="21" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESCUENTO                               " atributo="LISTADESDE                              " tabla="DESCUENTOS     " campo="LISTDESDE " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="LISTADEPRECIOS                          " tipodato="C         " longitud="6" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="440" etiqueta="Lista desde                                                                                                                                                     " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="21" orden="22" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESCUENTO                               " atributo="LISTAHASTA                              " tabla="DESCUENTOS     " campo="LISTHASTA " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="LISTADEPRECIOS                          " tipodato="C         " longitud="6" decimales="0" valorsugerido="=Replicate( &quot;Z&quot;,6)                                                                                                                                                                                                                                            " obligatorio="false" admitebusqueda="442" etiqueta="Lista Hasta                                                                                                                                                     " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="21" orden="23" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESCUENTO                               " atributo="VENDDESDE                               " tabla="DESCUENTOS     " campo="VENDDESDE " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="VENDEDOR                                " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="444" etiqueta="Vendedor desde                                                                                                                                                  " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="22" orden="24" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESCUENTO                               " atributo="VENDHASTA                               " tabla="DESCUENTOS     " campo="VENDHASTA " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="VENDEDOR                                " tipodato="C         " longitud="5" decimales="0" valorsugerido="=Replicate( &quot;Z&quot;,5)                                                                                                                                                                                                                                            " obligatorio="false" admitebusqueda="446" etiqueta="Vendedor hasta                                                                                                                                                  " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="22" orden="25" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESCUENTO                               " atributo="DIALU                                   " tabla="DESCUENTOS     " campo="DIALU     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="= .T.                                                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="448" etiqueta="Lunes                                                                                                                                                           " dominio="DIASDESEMANA                  " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="16" orden="26" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESCUENTO                               " atributo="DIAMA                                   " tabla="DESCUENTOS     " campo="DIAMA     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="= .T.                                                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="450" etiqueta="Martes                                                                                                                                                          " dominio="DIASDESEMANA                  " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="16" orden="27" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESCUENTO                               " atributo="DIAMI                                   " tabla="DESCUENTOS     " campo="DIAMI     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="= .T.                                                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="452" etiqueta="Miércoles                                                                                                                                                       " dominio="DIASDESEMANA                  " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="16" orden="28" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESCUENTO                               " atributo="DIAJU                                   " tabla="DESCUENTOS     " campo="DIAJU     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="= .T.                                                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="454" etiqueta="Jueves                                                                                                                                                          " dominio="DIASDESEMANA                  " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="16" orden="29" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESCUENTO                               " atributo="CLIENTE_CLASIFICACIONCDESDE             " tabla="DESCUENTOS     " campo="CLASCDESDE" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CLASIFICACIONCLIENTE                    " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="456" etiqueta="Clasificación cliente desde                                                                                                                                     " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="25" orden="30" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESCUENTO                               " atributo="DIAVI                                   " tabla="DESCUENTOS     " campo="DIAVI     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="= .T.                                                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="458" etiqueta="Viernes                                                                                                                                                         " dominio="DIASDESEMANA                  " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="16" orden="30" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESCUENTO                               " atributo="CLIENTE_CLASIFICACIONCHASTA             " tabla="DESCUENTOS     " campo="CLASCHASTA" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CLASIFICACIONCLIENTE                    " tipodato="C         " longitud="10" decimales="0" valorsugerido="=Replicate( &quot;Z&quot;,10)                                                                                                                                                                                                                                           " obligatorio="false" admitebusqueda="460" etiqueta="Clasificación cliente hasta                                                                                                                                     " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="25" orden="31" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESCUENTO                               " atributo="DIASA                                   " tabla="DESCUENTOS     " campo="DIASA     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="= .T.                                                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="462" etiqueta="Sábado                                                                                                                                                          " dominio="DIASDESEMANA                  " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="16" orden="31" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESCUENTO                               " atributo="CLIENTE_TIPOCDESDE                      " tabla="DESCUENTOS     " campo="TIPOCDESDE" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="TIPOCLIENTE                             " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="464" etiqueta="Tipo de cliente desde                                                                                                                                           " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="26" orden="32" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESCUENTO                               " atributo="DIADO                                   " tabla="DESCUENTOS     " campo="DIADO     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="= .T.                                                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="466" etiqueta="Domingo                                                                                                                                                         " dominio="DIASDESEMANA                  " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="16" orden="32" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESCUENTO                               " atributo="CLIENTE_TIPOCHASTA                      " tabla="DESCUENTOS     " campo="TIPOCHASTA" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="TIPOCLIENTE                             " tipodato="C         " longitud="10" decimales="0" valorsugerido="=Replicate( &quot;Z&quot;,10)                                                                                                                                                                                                                                           " obligatorio="false" admitebusqueda="468" etiqueta="Tipo de cliente hasta                                                                                                                                           " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="26" orden="33" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESCUENTO                               " atributo="CLIENTE_CATEGORIACDESDE                 " tabla="DESCUENTOS     " campo="CATECDESDE" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CATEGORIACLIENTE                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="470" etiqueta="Categoría de cliente desde                                                                                                                                      " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="27" orden="34" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESCUENTO                               " atributo="CLIENTE_CATEGORIACHASTA                 " tabla="DESCUENTOS     " campo="CATECHASTA" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CATEGORIACLIENTE                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="=Replicate( &quot;Z&quot;,10)                                                                                                                                                                                                                                           " obligatorio="false" admitebusqueda="472" etiqueta="Categoría de cliente hasta                                                                                                                                      " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="27" orden="35" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADEPRECIOS                          " atributo="NOMBRE                                  " tabla="LPRECIO        " campo="LPR_NOMBRE" claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="441" etiqueta="Detalle Lis.                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join LPRECIO On DESCUENTOS.LISTDESDE = LPRECIO.LPR_NUMERO And  LPRECIO.LPR_NUMERO != ''                                                                                                                                                                 " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADEPRECIOS                          " atributo="NOMBRE                                  " tabla="LPRECIO        " campo="LPR_NOMBRE" claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="443" etiqueta="Detalle Lis.                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join LPRECIO On DESCUENTOS.LISTHASTA = LPRECIO.LPR_NUMERO And  LPRECIO.LPR_NUMERO != ''                                                                                                                                                                 " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VENDEDOR                                " atributo="NOMBRE                                  " tabla="VEN            " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="445" etiqueta="Detalle Ven.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join VEN On DESCUENTOS.VENDDESDE = VEN.CLCOD And  VEN.CLCOD != ''                                                                                                                                                                                       " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VENDEDOR                                " atributo="NOMBRE                                  " tabla="VEN            " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="447" etiqueta="Detalle Ven.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join VEN On DESCUENTOS.VENDHASTA = VEN.CLCOD And  VEN.CLCOD != ''                                                                                                                                                                                       " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLASIFICACIONCLIENTE                    " atributo="DESCRIPCION                             " tabla="CLASIF         " campo="CLADES    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="457" etiqueta="Detalle Cla.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CLASIF On DESCUENTOS.CLASCDESDE = CLASIF.CLACOD And  CLASIF.CLACOD != ''                                                                                                                                                                           " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLASIFICACIONCLIENTE                    " atributo="DESCRIPCION                             " tabla="CLASIF         " campo="CLADES    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="461" etiqueta="Detalle Cla.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CLASIF On DESCUENTOS.CLASCHASTA = CLASIF.CLACOD And  CLASIF.CLACOD != ''                                                                                                                                                                           " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIPOCLIENTE                             " atributo="DESCRIPCION                             " tabla="TIPOCLI        " campo="TCDES     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="465" etiqueta="Detalle Tip.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join TIPOCLI On DESCUENTOS.TIPOCDESDE = TIPOCLI.TCCOD And  TIPOCLI.TCCOD != ''                                                                                                                                                                          " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIPOCLIENTE                             " atributo="DESCRIPCION                             " tabla="TIPOCLI        " campo="TCDES     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="469" etiqueta="Detalle Tip.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join TIPOCLI On DESCUENTOS.TIPOCHASTA = TIPOCLI.TCCOD And  TIPOCLI.TCCOD != ''                                                                                                                                                                          " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CATEGORIACLIENTE                        " atributo="DESCRIPCION                             " tabla="CATCLI         " campo="CGDES     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="471" etiqueta="Detalle Cat.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CATCLI On DESCUENTOS.CATECDESDE = CATCLI.CGCod And  CATCLI.CGCOD != ''                                                                                                                                                                             " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CATEGORIACLIENTE                        " atributo="DESCRIPCION                             " tabla="CATCLI         " campo="CGDES     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="473" etiqueta="Detalle Cat.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CATCLI On DESCUENTOS.CATECHASTA = CATCLI.CGCod And  CATCLI.CGCOD != ''                                                                                                                                                                             " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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