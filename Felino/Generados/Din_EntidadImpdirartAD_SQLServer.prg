
define class Din_EntidadIMPDIRARTAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_IMPDIRART'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = []
	cExpresionCCPorCampos = []
	cTagClaveCandidata = ''
	cTagClavePk = '_IDAPK'
	cTablaPrincipal = 'IMPDIRART'
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
		this.GrabarNumeraciones()

		with this.oEntidad
			local  lxImpdirartFecimpo, lxImpdirartFecexpo, lxImpdirartFectrans, lxImpdirartFaltafw, lxImpdirartFmodifw, lxImpdirartTimestamp, lxImpdirartZadsfw, lxImpdirartEsttrans, lxImpdirartBdaltafw, lxImpdirartBdmodifw, lxImpdirartVmodifw, lxImpdirartHaltafw, lxImpdirartSmodifw, lxImpdirartValtafw, lxImpdirartUaltafw, lxImpdirartSaltafw, lxImpdirartUmodifw, lxImpdirartHoraimpo, lxImpdirartHoraexpo, lxImpdirartHmodifw, lxImpdirartComp, lxImpdirartNumero, lxImpdirartDescripcio, lxImpdirartPcuenta, lxImpdirartImportanci, lxImpdirartDisccos, lxImpdirartCcosto, lxImpdirartImportancc, lxImpdirartArtdesde, lxImpdirartArthasta, lxImpdirartProdesde, lxImpdirartProhasta, lxImpdirartTemdesde, lxImpdirartTemhasta, lxImpdirartAnidesde, lxImpdirartAnihasta, lxImpdirartFamdesde, lxImpdirartFamhasta, lxImpdirartMatdesde, lxImpdirartMathasta, lxImpdirartLindesde, lxImpdirartLinhasta, lxImpdirartGrudesde, lxImpdirartGruhasta, lxImpdirartCatdesde, lxImpdirartCathasta, lxImpdirartCladesde, lxImpdirartClahasta, lxImpdirartTipdesde, lxImpdirartTiphasta, lxImpdirartArtconiva, lxImpdirartIvvdesde, lxImpdirartIvvhasta, lxImpdirartArtiva, lxImpdirartIvcdesde, lxImpdirartIvchasta, lxImpdirartIvcdesde, lxImpdirartIvchasta, lxImpdirartTipoasi, lxImpdirartObs
				lxImpdirartFecimpo =  .Fechaimpo			lxImpdirartFecexpo =  .Fechaexpo			lxImpdirartFectrans =  .Fechatransferencia			lxImpdirartFaltafw =  .Fechaaltafw			lxImpdirartFmodifw =  .Fechamodificacionfw			lxImpdirartTimestamp = goLibrerias.ObtenerTimestamp()			lxImpdirartZadsfw =  .Zadsfw			lxImpdirartEsttrans =  .Estadotransferencia			lxImpdirartBdaltafw =  .Basededatosaltafw			lxImpdirartBdmodifw =  .Basededatosmodificacionfw			lxImpdirartVmodifw =  .Versionmodificacionfw			lxImpdirartHaltafw =  .Horaaltafw			lxImpdirartSmodifw =  .Seriemodificacionfw			lxImpdirartValtafw =  .Versionaltafw			lxImpdirartUaltafw =  .Usuarioaltafw			lxImpdirartSaltafw =  .Seriealtafw			lxImpdirartUmodifw =  .Usuariomodificacionfw			lxImpdirartHoraimpo =  .Horaimpo			lxImpdirartHoraexpo =  .Horaexpo			lxImpdirartHmodifw =  .Horamodificacionfw			lxImpdirartComp =  .Comportamiento			lxImpdirartNumero =  .Numero			lxImpdirartDescripcio =  .Descripcion			lxImpdirartPcuenta =  upper( .PlanDeCuentas_PK ) 			lxImpdirartImportanci =  .Importancia			lxImpdirartDisccos =  upper( .DistribucionPorCentroDeCosto_PK ) 			lxImpdirartCcosto =  upper( .CentroDeCosto_PK ) 			lxImpdirartImportancc =  .Prioridadccosto			lxImpdirartArtdesde =  .F_articulo_desde			lxImpdirartArthasta =  .F_articulo_hasta			lxImpdirartProdesde =  .F_proveedor_desde			lxImpdirartProhasta =  .F_proveedor_hasta			lxImpdirartTemdesde =  .F_temporada_desde			lxImpdirartTemhasta =  .F_temporada_hasta			lxImpdirartAnidesde =  .F_anio_desde			lxImpdirartAnihasta =  .F_anio_hasta			lxImpdirartFamdesde =  .F_familia_desde			lxImpdirartFamhasta =  .F_familia_hasta			lxImpdirartMatdesde =  .F_material_desde			lxImpdirartMathasta =  .F_material_hasta			lxImpdirartLindesde =  .F_linea_desde			lxImpdirartLinhasta =  .F_linea_hasta			lxImpdirartGrudesde =  .F_grupo_desde			lxImpdirartGruhasta =  .F_grupo_hasta			lxImpdirartCatdesde =  .F_categoria_desde			lxImpdirartCathasta =  .F_categoria_hasta			lxImpdirartCladesde =  .F_clasificacion_desde			lxImpdirartClahasta =  .F_clasificacion_hasta			lxImpdirartTipdesde =  .F_tipo_desde			lxImpdirartTiphasta =  .F_tipo_hasta			lxImpdirartArtconiva =  .Condicionivaventas			lxImpdirartIvvdesde =  .F_ivav_desde			lxImpdirartIvvhasta =  .F_ivav_hasta			lxImpdirartArtiva =  .Condicionivacompras			lxImpdirartIvcdesde =  .F_ivac_desde			lxImpdirartIvchasta =  .F_ivac_hasta			lxImpdirartIvcdesde =  .F_impi_desde			lxImpdirartIvchasta =  .F_impi_hasta			lxImpdirartTipoasi =  .Tipodeasiento			lxImpdirartObs =  .Observacion
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxImpdirartNumero = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.IMPDIRART ( "Fecimpo","Fecexpo","Fectrans","Faltafw","Fmodifw","Timestamp","Zadsfw","Esttrans","Bdaltafw","Bdmodifw","Vmodifw","Haltafw","Smodifw","Valtafw","Ualtafw","Saltafw","Umodifw","Horaimpo","Horaexpo","Hmodifw","Comp","Numero","Descripcio","Pcuenta","Importanci","Disccos","Ccosto","Importancc","Artdesde","Arthasta","Prodesde","Prohasta","Temdesde","Temhasta","Anidesde","Anihasta","Famdesde","Famhasta","Matdesde","Mathasta","Lindesde","Linhasta","Grudesde","Gruhasta","Catdesde","Cathasta","Cladesde","Clahasta","Tipdesde","Tiphasta","Artconiva","Ivvdesde","Ivvhasta","Artiva","Ivcdesde","Ivchasta","Tipoasi","Obs" ) values ( <<"'" + this.ConvertirDateSql( lxImpdirartFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxImpdirartFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxImpdirartFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxImpdirartFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxImpdirartFmodifw ) + "'" >>, <<lxImpdirartTimestamp >>, <<"'" + this.FormatearTextoSql( lxImpdirartZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirartEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirartBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirartBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirartVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirartHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirartSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirartValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirartUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirartSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirartUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirartHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirartHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirartHmodifw ) + "'" >>, <<lxImpdirartComp >>, <<lxImpdirartNumero >>, <<"'" + this.FormatearTextoSql( lxImpdirartDescripcio ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirartPcuenta ) + "'" >>, <<lxImpdirartImportanci >>, <<"'" + this.FormatearTextoSql( lxImpdirartDisccos ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirartCcosto ) + "'" >>, <<lxImpdirartImportancc >>, <<"'" + this.FormatearTextoSql( lxImpdirartArtdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirartArthasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirartProdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirartProhasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirartTemdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirartTemhasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirartAnidesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirartAnihasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirartFamdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirartFamhasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirartMatdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirartMathasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirartLindesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirartLinhasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirartGrudesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirartGruhasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirartCatdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirartCathasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirartCladesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirartClahasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirartTipdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirartTiphasta ) + "'" >>, <<lxImpdirartArtconiva >>, <<"'" + this.FormatearTextoSql( lxImpdirartIvvdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirartIvvhasta ) + "'" >>, <<lxImpdirartArtiva >>, <<"'" + this.FormatearTextoSql( lxImpdirartIvcdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirartIvchasta ) + "'" >>, <<lxImpdirartTipoasi >>, <<"'" + this.FormatearTextoSql( lxImpdirartObs ) + "'" >> )
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
		this.ComprobarTransaccion()
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.NUMERO
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
			.ActualizarNumeraciones()
					strtofile( transform( date() ) + ' ' + time() + ' Grabacion No exitosa. Intento ' + transform( lni ) + '. Clase ' + this.Class + chr( 13 ) + chr( 10 ), addbs( this.oConexion.oAccesoDatos.cRutaTablas ) + this.cArchivoLogPrueba, 1 )
					goServicios.Errores.LevantarExcepcion( loError )
				else
					strtofile( transform( date() ) + ' ' + time() + ' Grabacion. Intento ' + transform( lni ) + '. Clase ' + this.Class + chr( 13 ) + chr( 10 ), addbs( this.oConexion.oAccesoDatos.cRutaTablas ) + this.cArchivoLogPrueba, 1 )
				endif
			else
			.ActualizarNumeraciones()
				goServicios.Errores.LevantarExcepcion( loError )
			endif
		finally
			this.SetearConexionGlobal()
		EndTry
		this.ActualizarLosNROItemDeLosDetalles()
		this.oEntidad.Timestamp = lxImpdirartTimestamp
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
		return this.oEntidad.NUMERO
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function Actualizar() as boolean
	local loError as Exception, loEx as Exception, lxValorClavePrimaria as variant, lnI as Integer, loSentenciasTriggers as zoocoleccion OF zoocoleccion.prg, lcSentencia as string

		with this.oEntidad
			local  lxImpdirartFecimpo, lxImpdirartFecexpo, lxImpdirartFectrans, lxImpdirartFaltafw, lxImpdirartFmodifw, lxImpdirartTimestamp, lxImpdirartZadsfw, lxImpdirartEsttrans, lxImpdirartBdaltafw, lxImpdirartBdmodifw, lxImpdirartVmodifw, lxImpdirartHaltafw, lxImpdirartSmodifw, lxImpdirartValtafw, lxImpdirartUaltafw, lxImpdirartSaltafw, lxImpdirartUmodifw, lxImpdirartHoraimpo, lxImpdirartHoraexpo, lxImpdirartHmodifw, lxImpdirartComp, lxImpdirartNumero, lxImpdirartDescripcio, lxImpdirartPcuenta, lxImpdirartImportanci, lxImpdirartDisccos, lxImpdirartCcosto, lxImpdirartImportancc, lxImpdirartArtdesde, lxImpdirartArthasta, lxImpdirartProdesde, lxImpdirartProhasta, lxImpdirartTemdesde, lxImpdirartTemhasta, lxImpdirartAnidesde, lxImpdirartAnihasta, lxImpdirartFamdesde, lxImpdirartFamhasta, lxImpdirartMatdesde, lxImpdirartMathasta, lxImpdirartLindesde, lxImpdirartLinhasta, lxImpdirartGrudesde, lxImpdirartGruhasta, lxImpdirartCatdesde, lxImpdirartCathasta, lxImpdirartCladesde, lxImpdirartClahasta, lxImpdirartTipdesde, lxImpdirartTiphasta, lxImpdirartArtconiva, lxImpdirartIvvdesde, lxImpdirartIvvhasta, lxImpdirartArtiva, lxImpdirartIvcdesde, lxImpdirartIvchasta, lxImpdirartIvcdesde, lxImpdirartIvchasta, lxImpdirartTipoasi, lxImpdirartObs
				lxImpdirartFecimpo =  .Fechaimpo			lxImpdirartFecexpo =  .Fechaexpo			lxImpdirartFectrans =  .Fechatransferencia			lxImpdirartFaltafw =  .Fechaaltafw			lxImpdirartFmodifw =  .Fechamodificacionfw			lxImpdirartTimestamp = goLibrerias.ObtenerTimestamp()			lxImpdirartZadsfw =  .Zadsfw			lxImpdirartEsttrans =  .Estadotransferencia			lxImpdirartBdaltafw =  .Basededatosaltafw			lxImpdirartBdmodifw =  .Basededatosmodificacionfw			lxImpdirartVmodifw =  .Versionmodificacionfw			lxImpdirartHaltafw =  .Horaaltafw			lxImpdirartSmodifw =  .Seriemodificacionfw			lxImpdirartValtafw =  .Versionaltafw			lxImpdirartUaltafw =  .Usuarioaltafw			lxImpdirartSaltafw =  .Seriealtafw			lxImpdirartUmodifw =  .Usuariomodificacionfw			lxImpdirartHoraimpo =  .Horaimpo			lxImpdirartHoraexpo =  .Horaexpo			lxImpdirartHmodifw =  .Horamodificacionfw			lxImpdirartComp =  .Comportamiento			lxImpdirartNumero =  .Numero			lxImpdirartDescripcio =  .Descripcion			lxImpdirartPcuenta =  upper( .PlanDeCuentas_PK ) 			lxImpdirartImportanci =  .Importancia			lxImpdirartDisccos =  upper( .DistribucionPorCentroDeCosto_PK ) 			lxImpdirartCcosto =  upper( .CentroDeCosto_PK ) 			lxImpdirartImportancc =  .Prioridadccosto			lxImpdirartArtdesde =  .F_articulo_desde			lxImpdirartArthasta =  .F_articulo_hasta			lxImpdirartProdesde =  .F_proveedor_desde			lxImpdirartProhasta =  .F_proveedor_hasta			lxImpdirartTemdesde =  .F_temporada_desde			lxImpdirartTemhasta =  .F_temporada_hasta			lxImpdirartAnidesde =  .F_anio_desde			lxImpdirartAnihasta =  .F_anio_hasta			lxImpdirartFamdesde =  .F_familia_desde			lxImpdirartFamhasta =  .F_familia_hasta			lxImpdirartMatdesde =  .F_material_desde			lxImpdirartMathasta =  .F_material_hasta			lxImpdirartLindesde =  .F_linea_desde			lxImpdirartLinhasta =  .F_linea_hasta			lxImpdirartGrudesde =  .F_grupo_desde			lxImpdirartGruhasta =  .F_grupo_hasta			lxImpdirartCatdesde =  .F_categoria_desde			lxImpdirartCathasta =  .F_categoria_hasta			lxImpdirartCladesde =  .F_clasificacion_desde			lxImpdirartClahasta =  .F_clasificacion_hasta			lxImpdirartTipdesde =  .F_tipo_desde			lxImpdirartTiphasta =  .F_tipo_hasta			lxImpdirartArtconiva =  .Condicionivaventas			lxImpdirartIvvdesde =  .F_ivav_desde			lxImpdirartIvvhasta =  .F_ivav_hasta			lxImpdirartArtiva =  .Condicionivacompras			lxImpdirartIvcdesde =  .F_ivac_desde			lxImpdirartIvchasta =  .F_ivac_hasta			lxImpdirartIvcdesde =  .F_impi_desde			lxImpdirartIvchasta =  .F_impi_hasta			lxImpdirartTipoasi =  .Tipodeasiento			lxImpdirartObs =  .Observacion
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
			lxValorClavePrimaria = .oEntidad.NUMERO
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ZooLogic.IMPDIRART set "Fecimpo" = <<"'" + this.ConvertirDateSql( lxImpdirartFecimpo ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxImpdirartFecexpo ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxImpdirartFectrans ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxImpdirartFaltafw ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxImpdirartFmodifw ) + "'">>,"Timestamp" = <<lxImpdirartTimestamp>>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxImpdirartZadsfw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxImpdirartEsttrans ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxImpdirartBdaltafw ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxImpdirartBdmodifw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxImpdirartVmodifw ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxImpdirartHaltafw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxImpdirartSmodifw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxImpdirartValtafw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxImpdirartUaltafw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxImpdirartSaltafw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxImpdirartUmodifw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxImpdirartHoraimpo ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxImpdirartHoraexpo ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxImpdirartHmodifw ) + "'">>,"Comp" = <<lxImpdirartComp>>,"Numero" = <<lxImpdirartNumero>>,"Descripcio" = <<"'" + this.FormatearTextoSql( lxImpdirartDescripcio ) + "'">>,"Pcuenta" = <<"'" + this.FormatearTextoSql( lxImpdirartPcuenta ) + "'">>,"Importanci" = <<lxImpdirartImportanci>>,"Disccos" = <<"'" + this.FormatearTextoSql( lxImpdirartDisccos ) + "'">>,"Ccosto" = <<"'" + this.FormatearTextoSql( lxImpdirartCcosto ) + "'">>,"Importancc" = <<lxImpdirartImportancc>>,"Artdesde" = <<"'" + this.FormatearTextoSql( lxImpdirartArtdesde ) + "'">>,"Arthasta" = <<"'" + this.FormatearTextoSql( lxImpdirartArthasta ) + "'">>,"Prodesde" = <<"'" + this.FormatearTextoSql( lxImpdirartProdesde ) + "'">>,"Prohasta" = <<"'" + this.FormatearTextoSql( lxImpdirartProhasta ) + "'">>,"Temdesde" = <<"'" + this.FormatearTextoSql( lxImpdirartTemdesde ) + "'">>,"Temhasta" = <<"'" + this.FormatearTextoSql( lxImpdirartTemhasta ) + "'">>,"Anidesde" = <<"'" + this.FormatearTextoSql( lxImpdirartAnidesde ) + "'">>,"Anihasta" = <<"'" + this.FormatearTextoSql( lxImpdirartAnihasta ) + "'">>,"Famdesde" = <<"'" + this.FormatearTextoSql( lxImpdirartFamdesde ) + "'">>,"Famhasta" = <<"'" + this.FormatearTextoSql( lxImpdirartFamhasta ) + "'">>,"Matdesde" = <<"'" + this.FormatearTextoSql( lxImpdirartMatdesde ) + "'">>,"Mathasta" = <<"'" + this.FormatearTextoSql( lxImpdirartMathasta ) + "'">>,"Lindesde" = <<"'" + this.FormatearTextoSql( lxImpdirartLindesde ) + "'">>,"Linhasta" = <<"'" + this.FormatearTextoSql( lxImpdirartLinhasta ) + "'">>,"Grudesde" = <<"'" + this.FormatearTextoSql( lxImpdirartGrudesde ) + "'">>,"Gruhasta" = <<"'" + this.FormatearTextoSql( lxImpdirartGruhasta ) + "'">>,"Catdesde" = <<"'" + this.FormatearTextoSql( lxImpdirartCatdesde ) + "'">>,"Cathasta" = <<"'" + this.FormatearTextoSql( lxImpdirartCathasta ) + "'">>,"Cladesde" = <<"'" + this.FormatearTextoSql( lxImpdirartCladesde ) + "'">>,"Clahasta" = <<"'" + this.FormatearTextoSql( lxImpdirartClahasta ) + "'">>,"Tipdesde" = <<"'" + this.FormatearTextoSql( lxImpdirartTipdesde ) + "'">>,"Tiphasta" = <<"'" + this.FormatearTextoSql( lxImpdirartTiphasta ) + "'">>,"Artconiva" = <<lxImpdirartArtconiva>>,"Ivvdesde" = <<"'" + this.FormatearTextoSql( lxImpdirartIvvdesde ) + "'">>,"Ivvhasta" = <<"'" + this.FormatearTextoSql( lxImpdirartIvvhasta ) + "'">>,"Artiva" = <<lxImpdirartArtiva>>,"Ivcdesde" = <<"'" + this.FormatearTextoSql( lxImpdirartIvcdesde ) + "'">>,"Ivchasta" = <<"'" + this.FormatearTextoSql( lxImpdirartIvchasta ) + "'">>,"Tipoasi" = <<lxImpdirartTipoasi>>,"Obs" = <<"'" + this.FormatearTextoSql( lxImpdirartObs ) + "'">> where "Numero" = <<lxImpdirartNumero>> and  IMPDIRART.NUMERO != 0 << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
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
		this.oEntidad.Timestamp = lxImpdirartTimestamp
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 NUMERO from ZooLogic.IMPDIRART where " + this.ConvertirFuncionesSql( " IMPDIRART.NUMERO != 0" ) )
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
			Local lxImpdirartNumero
			lxImpdirartNumero = .Numero

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Timestamp" as "Timestamp", "Zadsfw" as "Zadsfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Haltafw" as "Horaaltafw", "Smodifw" as "Seriemodificacionfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Umodifw" as "Usuariomodificacionfw", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Comp" as "Comportamiento", "Numero" as "Numero", "Descripcio" as "Descripcion", "Pcuenta" as "Plandecuentas", "Importanci" as "Importancia", "Disccos" as "Distribucionporcentrodecosto", "Ccosto" as "Centrodecosto", "Importancc" as "Prioridadccosto", "Artdesde" as "F_articulo_desde", "Arthasta" as "F_articulo_hasta", "Prodesde" as "F_proveedor_desde", "Prohasta" as "F_proveedor_hasta", "Temdesde" as "F_temporada_desde", "Temhasta" as "F_temporada_hasta", "Anidesde" as "F_anio_desde", "Anihasta" as "F_anio_hasta", "Famdesde" as "F_familia_desde", "Famhasta" as "F_familia_hasta", "Matdesde" as "F_material_desde", "Mathasta" as "F_material_hasta", "Lindesde" as "F_linea_desde", "Linhasta" as "F_linea_hasta", "Grudesde" as "F_grupo_desde", "Gruhasta" as "F_grupo_hasta", "Catdesde" as "F_categoria_desde", "Cathasta" as "F_categoria_hasta", "Cladesde" as "F_clasificacion_desde", "Clahasta" as "F_clasificacion_hasta", "Tipdesde" as "F_tipo_desde", "Tiphasta" as "F_tipo_hasta", "Artconiva" as "Condicionivaventas", "Ivvdesde" as "F_ivav_desde", "Ivvhasta" as "F_ivav_hasta", "Artiva" as "Condicionivacompras", "Ivcdesde" as "F_ivac_desde", "Ivchasta" as "F_ivac_hasta", "Ivcdesde" as "F_impi_desde", "Ivchasta" as "F_impi_hasta", "Tipoasi" as "Tipodeasiento", "Obs" as "Observacion" from ZooLogic.IMPDIRART where "Numero" = <<lxImpdirartNumero>> and  IMPDIRART.NUMERO != 0
			endtext
			use in select('c_IMPDIRART')
			this.oConexion.EjecutarSql( lcSentencia, 'c_IMPDIRART', set( 'Datasession' ) )

			if reccount( 'c_IMPDIRART' ) = 0
				llRetorno = .f.
			else
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxImpdirartNumero as Variant
		llRetorno = .t.
		lxImpdirartNumero = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.IMPDIRART where "Numero" = <<lxImpdirartNumero>> and  IMPDIRART.NUMERO != 0
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
				lcOrden =  str( .Numero, 8, 0)
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Timestamp" as "Timestamp", "Zadsfw" as "Zadsfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Haltafw" as "Horaaltafw", "Smodifw" as "Seriemodificacionfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Umodifw" as "Usuariomodificacionfw", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Comp" as "Comportamiento", "Numero" as "Numero", "Descripcio" as "Descripcion", "Pcuenta" as "Plandecuentas", "Importanci" as "Importancia", "Disccos" as "Distribucionporcentrodecosto", "Ccosto" as "Centrodecosto", "Importancc" as "Prioridadccosto", "Artdesde" as "F_articulo_desde", "Arthasta" as "F_articulo_hasta", "Prodesde" as "F_proveedor_desde", "Prohasta" as "F_proveedor_hasta", "Temdesde" as "F_temporada_desde", "Temhasta" as "F_temporada_hasta", "Anidesde" as "F_anio_desde", "Anihasta" as "F_anio_hasta", "Famdesde" as "F_familia_desde", "Famhasta" as "F_familia_hasta", "Matdesde" as "F_material_desde", "Mathasta" as "F_material_hasta", "Lindesde" as "F_linea_desde", "Linhasta" as "F_linea_hasta", "Grudesde" as "F_grupo_desde", "Gruhasta" as "F_grupo_hasta", "Catdesde" as "F_categoria_desde", "Cathasta" as "F_categoria_hasta", "Cladesde" as "F_clasificacion_desde", "Clahasta" as "F_clasificacion_hasta", "Tipdesde" as "F_tipo_desde", "Tiphasta" as "F_tipo_hasta", "Artconiva" as "Condicionivaventas", "Ivvdesde" as "F_ivav_desde", "Ivvhasta" as "F_ivav_hasta", "Artiva" as "Condicionivacompras", "Ivcdesde" as "F_ivac_desde", "Ivchasta" as "F_ivac_hasta", "Ivcdesde" as "F_impi_desde", "Ivchasta" as "F_impi_hasta", "Tipoasi" as "Tipodeasiento", "Obs" as "Observacion" from ZooLogic.IMPDIRART where  IMPDIRART.NUMERO != 0 order by NUMERO
			endtext
			use in select('c_IMPDIRART')
			this.oConexion.EjecutarSql( lcSentencia, 'c_IMPDIRART', set( 'Datasession' ) )
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
				lcOrden =  str( .Numero, 8, 0)
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Timestamp" as "Timestamp", "Zadsfw" as "Zadsfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Haltafw" as "Horaaltafw", "Smodifw" as "Seriemodificacionfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Umodifw" as "Usuariomodificacionfw", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Comp" as "Comportamiento", "Numero" as "Numero", "Descripcio" as "Descripcion", "Pcuenta" as "Plandecuentas", "Importanci" as "Importancia", "Disccos" as "Distribucionporcentrodecosto", "Ccosto" as "Centrodecosto", "Importancc" as "Prioridadccosto", "Artdesde" as "F_articulo_desde", "Arthasta" as "F_articulo_hasta", "Prodesde" as "F_proveedor_desde", "Prohasta" as "F_proveedor_hasta", "Temdesde" as "F_temporada_desde", "Temhasta" as "F_temporada_hasta", "Anidesde" as "F_anio_desde", "Anihasta" as "F_anio_hasta", "Famdesde" as "F_familia_desde", "Famhasta" as "F_familia_hasta", "Matdesde" as "F_material_desde", "Mathasta" as "F_material_hasta", "Lindesde" as "F_linea_desde", "Linhasta" as "F_linea_hasta", "Grudesde" as "F_grupo_desde", "Gruhasta" as "F_grupo_hasta", "Catdesde" as "F_categoria_desde", "Cathasta" as "F_categoria_hasta", "Cladesde" as "F_clasificacion_desde", "Clahasta" as "F_clasificacion_hasta", "Tipdesde" as "F_tipo_desde", "Tiphasta" as "F_tipo_hasta", "Artconiva" as "Condicionivaventas", "Ivvdesde" as "F_ivav_desde", "Ivvhasta" as "F_ivav_hasta", "Artiva" as "Condicionivacompras", "Ivcdesde" as "F_ivac_desde", "Ivchasta" as "F_ivac_hasta", "Ivcdesde" as "F_impi_desde", "Ivchasta" as "F_impi_hasta", "Tipoasi" as "Tipodeasiento", "Obs" as "Observacion" from ZooLogic.IMPDIRART where  str( NUMERO, 8, 0) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  IMPDIRART.NUMERO != 0 order by NUMERO
			endtext
			use in select('c_IMPDIRART')
			this.oConexion.EjecutarSql( lcSentencia, 'c_IMPDIRART', set( 'Datasession' ) )
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
				lcOrden =  str( .Numero, 8, 0)
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Timestamp" as "Timestamp", "Zadsfw" as "Zadsfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Haltafw" as "Horaaltafw", "Smodifw" as "Seriemodificacionfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Umodifw" as "Usuariomodificacionfw", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Comp" as "Comportamiento", "Numero" as "Numero", "Descripcio" as "Descripcion", "Pcuenta" as "Plandecuentas", "Importanci" as "Importancia", "Disccos" as "Distribucionporcentrodecosto", "Ccosto" as "Centrodecosto", "Importancc" as "Prioridadccosto", "Artdesde" as "F_articulo_desde", "Arthasta" as "F_articulo_hasta", "Prodesde" as "F_proveedor_desde", "Prohasta" as "F_proveedor_hasta", "Temdesde" as "F_temporada_desde", "Temhasta" as "F_temporada_hasta", "Anidesde" as "F_anio_desde", "Anihasta" as "F_anio_hasta", "Famdesde" as "F_familia_desde", "Famhasta" as "F_familia_hasta", "Matdesde" as "F_material_desde", "Mathasta" as "F_material_hasta", "Lindesde" as "F_linea_desde", "Linhasta" as "F_linea_hasta", "Grudesde" as "F_grupo_desde", "Gruhasta" as "F_grupo_hasta", "Catdesde" as "F_categoria_desde", "Cathasta" as "F_categoria_hasta", "Cladesde" as "F_clasificacion_desde", "Clahasta" as "F_clasificacion_hasta", "Tipdesde" as "F_tipo_desde", "Tiphasta" as "F_tipo_hasta", "Artconiva" as "Condicionivaventas", "Ivvdesde" as "F_ivav_desde", "Ivvhasta" as "F_ivav_hasta", "Artiva" as "Condicionivacompras", "Ivcdesde" as "F_ivac_desde", "Ivchasta" as "F_ivac_hasta", "Ivcdesde" as "F_impi_desde", "Ivchasta" as "F_impi_hasta", "Tipoasi" as "Tipodeasiento", "Obs" as "Observacion" from ZooLogic.IMPDIRART where  str( NUMERO, 8, 0) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  IMPDIRART.NUMERO != 0 order by NUMERO desc
			endtext
			use in select('c_IMPDIRART')
			this.oConexion.EjecutarSql( lcSentencia, 'c_IMPDIRART', set( 'Datasession' ) )
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
				lcOrden =  str( .Numero, 8, 0)
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Timestamp" as "Timestamp", "Zadsfw" as "Zadsfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Haltafw" as "Horaaltafw", "Smodifw" as "Seriemodificacionfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Umodifw" as "Usuariomodificacionfw", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Comp" as "Comportamiento", "Numero" as "Numero", "Descripcio" as "Descripcion", "Pcuenta" as "Plandecuentas", "Importanci" as "Importancia", "Disccos" as "Distribucionporcentrodecosto", "Ccosto" as "Centrodecosto", "Importancc" as "Prioridadccosto", "Artdesde" as "F_articulo_desde", "Arthasta" as "F_articulo_hasta", "Prodesde" as "F_proveedor_desde", "Prohasta" as "F_proveedor_hasta", "Temdesde" as "F_temporada_desde", "Temhasta" as "F_temporada_hasta", "Anidesde" as "F_anio_desde", "Anihasta" as "F_anio_hasta", "Famdesde" as "F_familia_desde", "Famhasta" as "F_familia_hasta", "Matdesde" as "F_material_desde", "Mathasta" as "F_material_hasta", "Lindesde" as "F_linea_desde", "Linhasta" as "F_linea_hasta", "Grudesde" as "F_grupo_desde", "Gruhasta" as "F_grupo_hasta", "Catdesde" as "F_categoria_desde", "Cathasta" as "F_categoria_hasta", "Cladesde" as "F_clasificacion_desde", "Clahasta" as "F_clasificacion_hasta", "Tipdesde" as "F_tipo_desde", "Tiphasta" as "F_tipo_hasta", "Artconiva" as "Condicionivaventas", "Ivvdesde" as "F_ivav_desde", "Ivvhasta" as "F_ivav_hasta", "Artiva" as "Condicionivacompras", "Ivcdesde" as "F_ivac_desde", "Ivchasta" as "F_ivac_hasta", "Ivcdesde" as "F_impi_desde", "Ivchasta" as "F_impi_hasta", "Tipoasi" as "Tipodeasiento", "Obs" as "Observacion" from ZooLogic.IMPDIRART where  IMPDIRART.NUMERO != 0 order by NUMERO desc
			endtext
			use in select('c_IMPDIRART')
			this.oConexion.EjecutarSql( lcSentencia, 'c_IMPDIRART', set( 'Datasession' ) )
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
				lcFiltroCodigo = ' and ' + .cCampoClavePrimaria + ' <> ' + transform( .oEntidad.NUMERO )
			endif
			lcFiltro = lcCampo + ' = ' + goLibrerias.ValorAString(lxValor) + lcFiltroCodigo
			local lcXml as string
			lcXml = this.oConexion.EjecutarSql( "select Fecimpo,Fecexpo,Fectrans,Faltafw,Fmodifw,Timestamp,Zadsfw,Esttrans,Bdaltafw,Bdmodifw,Vmodifw" + ;
",Haltafw,Smodifw,Valtafw,Ualtafw,Saltafw,Umodifw,Horaimpo,Horaexpo,Hmodifw,Comp,Numero,Descripcio,Pc" + ;
"uenta,Importanci,Disccos,Ccosto,Importancc,Artdesde,Arthasta,Prodesde,Prohasta,Temdesde,Temhasta,Ani" + ;
"desde,Anihasta,Famdesde,Famhasta,Matdesde,Mathasta,Lindesde,Linhasta,Grudesde,Gruhasta,Catdesde,Cath" + ;
"asta,Cladesde,Clahasta,Tipdesde,Tiphasta,Artconiva,Ivvdesde,Ivvhasta,Artiva,Ivcdesde,Ivchasta,Tipoas" + ;
"i,Obs" + ;
" from ZooLogic.IMPDIRART where  IMPDIRART.NUMERO != 0 and " + lcFiltro )
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
			local  lxImpdirartFecimpo, lxImpdirartFecexpo, lxImpdirartFectrans, lxImpdirartFaltafw, lxImpdirartFmodifw, lxImpdirartTimestamp, lxImpdirartZadsfw, lxImpdirartEsttrans, lxImpdirartBdaltafw, lxImpdirartBdmodifw, lxImpdirartVmodifw, lxImpdirartHaltafw, lxImpdirartSmodifw, lxImpdirartValtafw, lxImpdirartUaltafw, lxImpdirartSaltafw, lxImpdirartUmodifw, lxImpdirartHoraimpo, lxImpdirartHoraexpo, lxImpdirartHmodifw, lxImpdirartComp, lxImpdirartNumero, lxImpdirartDescripcio, lxImpdirartPcuenta, lxImpdirartImportanci, lxImpdirartDisccos, lxImpdirartCcosto, lxImpdirartImportancc, lxImpdirartArtdesde, lxImpdirartArthasta, lxImpdirartProdesde, lxImpdirartProhasta, lxImpdirartTemdesde, lxImpdirartTemhasta, lxImpdirartAnidesde, lxImpdirartAnihasta, lxImpdirartFamdesde, lxImpdirartFamhasta, lxImpdirartMatdesde, lxImpdirartMathasta, lxImpdirartLindesde, lxImpdirartLinhasta, lxImpdirartGrudesde, lxImpdirartGruhasta, lxImpdirartCatdesde, lxImpdirartCathasta, lxImpdirartCladesde, lxImpdirartClahasta, lxImpdirartTipdesde, lxImpdirartTiphasta, lxImpdirartArtconiva, lxImpdirartIvvdesde, lxImpdirartIvvhasta, lxImpdirartArtiva, lxImpdirartIvcdesde, lxImpdirartIvchasta, lxImpdirartIvcdesde, lxImpdirartIvchasta, lxImpdirartTipoasi, lxImpdirartObs
				lxImpdirartFecimpo = ctod( '  /  /    ' )			lxImpdirartFecexpo = ctod( '  /  /    ' )			lxImpdirartFectrans = ctod( '  /  /    ' )			lxImpdirartFaltafw = ctod( '  /  /    ' )			lxImpdirartFmodifw = ctod( '  /  /    ' )			lxImpdirartTimestamp = goLibrerias.ObtenerTimestamp()			lxImpdirartZadsfw = []			lxImpdirartEsttrans = []			lxImpdirartBdaltafw = []			lxImpdirartBdmodifw = []			lxImpdirartVmodifw = []			lxImpdirartHaltafw = []			lxImpdirartSmodifw = []			lxImpdirartValtafw = []			lxImpdirartUaltafw = []			lxImpdirartSaltafw = []			lxImpdirartUmodifw = []			lxImpdirartHoraimpo = []			lxImpdirartHoraexpo = []			lxImpdirartHmodifw = []			lxImpdirartComp = 0			lxImpdirartNumero = 0			lxImpdirartDescripcio = []			lxImpdirartPcuenta = []			lxImpdirartImportanci = 0			lxImpdirartDisccos = []			lxImpdirartCcosto = []			lxImpdirartImportancc = 0			lxImpdirartArtdesde = []			lxImpdirartArthasta = []			lxImpdirartProdesde = []			lxImpdirartProhasta = []			lxImpdirartTemdesde = []			lxImpdirartTemhasta = []			lxImpdirartAnidesde = []			lxImpdirartAnihasta = []			lxImpdirartFamdesde = []			lxImpdirartFamhasta = []			lxImpdirartMatdesde = []			lxImpdirartMathasta = []			lxImpdirartLindesde = []			lxImpdirartLinhasta = []			lxImpdirartGrudesde = []			lxImpdirartGruhasta = []			lxImpdirartCatdesde = []			lxImpdirartCathasta = []			lxImpdirartCladesde = []			lxImpdirartClahasta = []			lxImpdirartTipdesde = []			lxImpdirartTiphasta = []			lxImpdirartArtconiva = 0			lxImpdirartIvvdesde = []			lxImpdirartIvvhasta = []			lxImpdirartArtiva = 0			lxImpdirartIvcdesde = []			lxImpdirartIvchasta = []			lxImpdirartIvcdesde = []			lxImpdirartIvchasta = []			lxImpdirartTipoasi = 0			lxImpdirartObs = []
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( [delete from ZooLogic.IMPDIRART where "NUMERO" = ] + transform( .oEntidad.NUMERO )+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			this.oConexion.EjecutarSql( 'COMMIT TRANSACTION' )
			.ActualizarNumeraciones()
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
			lcTabla = 'IMPDIRART' + '_' + tcCampo
			lcMemoAscii = ''

			lnIndice = alen(.aSqlMemos)
			lnIndice = iif(lnIndice = 1, 1, lnIndice + 1 )
			dimension .aSqlMemos(lnIndice)

			.aSqlMemos(lnIndice) = 'delete from ' + lcTabla + ' where NUMERO = ' + txValorClavePrimaria
			.GenerarSentenciasInsertTablaMemo( lcValor, lcTabla, txValorClavePrimaria )
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerSentenciaInsertMemo( tcTabla as String, txValorClavePrimaria as String, tcOrden as String, tcTexto as String ) as String
		return "Insert  into " + tcTabla + "(NUMERO, Orden, texto ) values ( " + txValorClavePrimaria + "," + tcOrden + ",'"+ tcTexto + "')"
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosEntidad( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  IMPDIRART.NUMERO != 0"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Timestamp" as "Timestamp", "Zadsfw" as "Zadsfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Haltafw" as "Horaaltafw", "Smodifw" as "Seriemodificacionfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Umodifw" as "Usuariomodificacionfw", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Comp" as "Comportamiento", "Numero" as "Numero", "Descripcio" as "Descripcion", "Pcuenta" as "Plandecuentas", "Importanci" as "Importancia", "Disccos" as "Distribucionporcentrodecosto", "Ccosto" as "Centrodecosto", "Importancc" as "Prioridadccosto", "Artdesde" as "F_articulo_desde", "Arthasta" as "F_articulo_hasta", "Prodesde" as "F_proveedor_desde", "Prohasta" as "F_proveedor_hasta", "Temdesde" as "F_temporada_desde", "Temhasta" as "F_temporada_hasta", "Anidesde" as "F_anio_desde", "Anihasta" as "F_anio_hasta", "Famdesde" as "F_familia_desde", "Famhasta" as "F_familia_hasta", "Matdesde" as "F_material_desde", "Mathasta" as "F_material_hasta", "Lindesde" as "F_linea_desde", "Linhasta" as "F_linea_hasta", "Grudesde" as "F_grupo_desde", "Gruhasta" as "F_grupo_hasta", "Catdesde" as "F_categoria_desde", "Cathasta" as "F_categoria_hasta", "Cladesde" as "F_clasificacion_desde", "Clahasta" as "F_clasificacion_hasta", "Tipdesde" as "F_tipo_desde", "Tiphasta" as "F_tipo_hasta", "Artconiva" as "Condicionivaventas", "Ivvdesde" as "F_ivav_desde", "Ivvhasta" as "F_ivav_hasta", "Artiva" as "Condicionivacompras", "Ivcdesde" as "F_ivac_desde", "Ivchasta" as "F_ivac_hasta", "Ivcdesde" as "F_impi_desde", "Ivchasta" as "F_impi_hasta", "Tipoasi" as "Tipodeasiento", "Obs" as "Observacion"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'IMPDIRART', '', tnTope )
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
				Case lcAtributo == 'FECHAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECIMPO AS FECHAIMPO'
				Case lcAtributo == 'FECHAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECEXPO AS FECHAEXPO'
				Case lcAtributo == 'FECHATRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRANS AS FECHATRANSFERENCIA'
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'TIMESTAMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIMESTAMP AS TIMESTAMP'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'COMPORTAMIENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COMP AS COMPORTAMIENTO'
				Case lcAtributo == 'NUMERO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NUMERO AS NUMERO'
				Case lcAtributo == 'DESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCRIPCIO AS DESCRIPCION'
				Case lcAtributo == 'PLANDECUENTAS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PCUENTA AS PLANDECUENTAS'
				Case lcAtributo == 'IMPORTANCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IMPORTANCI AS IMPORTANCIA'
				Case lcAtributo == 'DISTRIBUCIONPORCENTRODECOSTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DISCCOS AS DISTRIBUCIONPORCENTRODECOSTO'
				Case lcAtributo == 'CENTRODECOSTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CCOSTO AS CENTRODECOSTO'
				Case lcAtributo == 'PRIORIDADCCOSTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IMPORTANCC AS PRIORIDADCCOSTO'
				Case lcAtributo == 'F_ARTICULO_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ARTDESDE AS F_ARTICULO_DESDE'
				Case lcAtributo == 'F_ARTICULO_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ARTHASTA AS F_ARTICULO_HASTA'
				Case lcAtributo == 'F_PROVEEDOR_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PRODESDE AS F_PROVEEDOR_DESDE'
				Case lcAtributo == 'F_PROVEEDOR_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PROHASTA AS F_PROVEEDOR_HASTA'
				Case lcAtributo == 'F_TEMPORADA_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TEMDESDE AS F_TEMPORADA_DESDE'
				Case lcAtributo == 'F_TEMPORADA_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TEMHASTA AS F_TEMPORADA_HASTA'
				Case lcAtributo == 'F_ANIO_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ANIDESDE AS F_ANIO_DESDE'
				Case lcAtributo == 'F_ANIO_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ANIHASTA AS F_ANIO_HASTA'
				Case lcAtributo == 'F_FAMILIA_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FAMDESDE AS F_FAMILIA_DESDE'
				Case lcAtributo == 'F_FAMILIA_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FAMHASTA AS F_FAMILIA_HASTA'
				Case lcAtributo == 'F_MATERIAL_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MATDESDE AS F_MATERIAL_DESDE'
				Case lcAtributo == 'F_MATERIAL_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MATHASTA AS F_MATERIAL_HASTA'
				Case lcAtributo == 'F_LINEA_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LINDESDE AS F_LINEA_DESDE'
				Case lcAtributo == 'F_LINEA_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LINHASTA AS F_LINEA_HASTA'
				Case lcAtributo == 'F_GRUPO_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'GRUDESDE AS F_GRUPO_DESDE'
				Case lcAtributo == 'F_GRUPO_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'GRUHASTA AS F_GRUPO_HASTA'
				Case lcAtributo == 'F_CATEGORIA_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CATDESDE AS F_CATEGORIA_DESDE'
				Case lcAtributo == 'F_CATEGORIA_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CATHASTA AS F_CATEGORIA_HASTA'
				Case lcAtributo == 'F_CLASIFICACION_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLADESDE AS F_CLASIFICACION_DESDE'
				Case lcAtributo == 'F_CLASIFICACION_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLAHASTA AS F_CLASIFICACION_HASTA'
				Case lcAtributo == 'F_TIPO_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPDESDE AS F_TIPO_DESDE'
				Case lcAtributo == 'F_TIPO_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPHASTA AS F_TIPO_HASTA'
				Case lcAtributo == 'CONDICIONIVAVENTAS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ARTCONIVA AS CONDICIONIVAVENTAS'
				Case lcAtributo == 'F_IVAV_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IVVDESDE AS F_IVAV_DESDE'
				Case lcAtributo == 'F_IVAV_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IVVHASTA AS F_IVAV_HASTA'
				Case lcAtributo == 'CONDICIONIVACOMPRAS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ARTIVA AS CONDICIONIVACOMPRAS'
				Case lcAtributo == 'F_IVAC_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IVCDESDE AS F_IVAC_DESDE'
				Case lcAtributo == 'F_IVAC_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IVCHASTA AS F_IVAC_HASTA'
				Case lcAtributo == 'F_IMPI_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IVCDESDE AS F_IMPI_DESDE'
				Case lcAtributo == 'F_IMPI_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IVCHASTA AS F_IMPI_HASTA'
				Case lcAtributo == 'TIPODEASIENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPOASI AS TIPODEASIENTO'
				Case lcAtributo == 'OBSERVACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'OBS AS OBSERVACION'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEXPO'
				lcCampo = 'FECEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'TIMESTAMP'
				lcCampo = 'TIMESTAMP'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'COMPORTAMIENTO'
				lcCampo = 'COMP'
			Case upper( alltrim( tcAtributo ) ) == 'NUMERO'
				lcCampo = 'NUMERO'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCION'
				lcCampo = 'DESCRIPCIO'
			Case upper( alltrim( tcAtributo ) ) == 'PLANDECUENTAS'
				lcCampo = 'PCUENTA'
			Case upper( alltrim( tcAtributo ) ) == 'IMPORTANCIA'
				lcCampo = 'IMPORTANCI'
			Case upper( alltrim( tcAtributo ) ) == 'DISTRIBUCIONPORCENTRODECOSTO'
				lcCampo = 'DISCCOS'
			Case upper( alltrim( tcAtributo ) ) == 'CENTRODECOSTO'
				lcCampo = 'CCOSTO'
			Case upper( alltrim( tcAtributo ) ) == 'PRIORIDADCCOSTO'
				lcCampo = 'IMPORTANCC'
			Case upper( alltrim( tcAtributo ) ) == 'F_ARTICULO_DESDE'
				lcCampo = 'ARTDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'F_ARTICULO_HASTA'
				lcCampo = 'ARTHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'F_PROVEEDOR_DESDE'
				lcCampo = 'PRODESDE'
			Case upper( alltrim( tcAtributo ) ) == 'F_PROVEEDOR_HASTA'
				lcCampo = 'PROHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'F_TEMPORADA_DESDE'
				lcCampo = 'TEMDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'F_TEMPORADA_HASTA'
				lcCampo = 'TEMHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'F_ANIO_DESDE'
				lcCampo = 'ANIDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'F_ANIO_HASTA'
				lcCampo = 'ANIHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'F_FAMILIA_DESDE'
				lcCampo = 'FAMDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'F_FAMILIA_HASTA'
				lcCampo = 'FAMHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'F_MATERIAL_DESDE'
				lcCampo = 'MATDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'F_MATERIAL_HASTA'
				lcCampo = 'MATHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'F_LINEA_DESDE'
				lcCampo = 'LINDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'F_LINEA_HASTA'
				lcCampo = 'LINHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'F_GRUPO_DESDE'
				lcCampo = 'GRUDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'F_GRUPO_HASTA'
				lcCampo = 'GRUHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'F_CATEGORIA_DESDE'
				lcCampo = 'CATDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'F_CATEGORIA_HASTA'
				lcCampo = 'CATHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'F_CLASIFICACION_DESDE'
				lcCampo = 'CLADESDE'
			Case upper( alltrim( tcAtributo ) ) == 'F_CLASIFICACION_HASTA'
				lcCampo = 'CLAHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'F_TIPO_DESDE'
				lcCampo = 'TIPDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'F_TIPO_HASTA'
				lcCampo = 'TIPHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'CONDICIONIVAVENTAS'
				lcCampo = 'ARTCONIVA'
			Case upper( alltrim( tcAtributo ) ) == 'F_IVAV_DESDE'
				lcCampo = 'IVVDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'F_IVAV_HASTA'
				lcCampo = 'IVVHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'CONDICIONIVACOMPRAS'
				lcCampo = 'ARTIVA'
			Case upper( alltrim( tcAtributo ) ) == 'F_IVAC_DESDE'
				lcCampo = 'IVCDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'F_IVAC_HASTA'
				lcCampo = 'IVCHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'F_IMPI_DESDE'
				lcCampo = 'IVCDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'F_IMPI_HASTA'
				lcCampo = 'IVCHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'TIPODEASIENTO'
				lcCampo = 'TIPOASI'
			Case upper( alltrim( tcAtributo ) ) == 'OBSERVACION'
				lcCampo = 'OBS'
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
			local  lxImpdirartFecimpo, lxImpdirartFecexpo, lxImpdirartFectrans, lxImpdirartFaltafw, lxImpdirartFmodifw, lxImpdirartTimestamp, lxImpdirartZadsfw, lxImpdirartEsttrans, lxImpdirartBdaltafw, lxImpdirartBdmodifw, lxImpdirartVmodifw, lxImpdirartHaltafw, lxImpdirartSmodifw, lxImpdirartValtafw, lxImpdirartUaltafw, lxImpdirartSaltafw, lxImpdirartUmodifw, lxImpdirartHoraimpo, lxImpdirartHoraexpo, lxImpdirartHmodifw, lxImpdirartComp, lxImpdirartNumero, lxImpdirartDescripcio, lxImpdirartPcuenta, lxImpdirartImportanci, lxImpdirartDisccos, lxImpdirartCcosto, lxImpdirartImportancc, lxImpdirartArtdesde, lxImpdirartArthasta, lxImpdirartProdesde, lxImpdirartProhasta, lxImpdirartTemdesde, lxImpdirartTemhasta, lxImpdirartAnidesde, lxImpdirartAnihasta, lxImpdirartFamdesde, lxImpdirartFamhasta, lxImpdirartMatdesde, lxImpdirartMathasta, lxImpdirartLindesde, lxImpdirartLinhasta, lxImpdirartGrudesde, lxImpdirartGruhasta, lxImpdirartCatdesde, lxImpdirartCathasta, lxImpdirartCladesde, lxImpdirartClahasta, lxImpdirartTipdesde, lxImpdirartTiphasta, lxImpdirartArtconiva, lxImpdirartIvvdesde, lxImpdirartIvvhasta, lxImpdirartArtiva, lxImpdirartIvcdesde, lxImpdirartIvchasta, lxImpdirartIvcdesde, lxImpdirartIvchasta, lxImpdirartTipoasi, lxImpdirartObs
				lxImpdirartFecimpo =  .Fechaimpo			lxImpdirartFecexpo =  .Fechaexpo			lxImpdirartFectrans =  .Fechatransferencia			lxImpdirartFaltafw =  .Fechaaltafw			lxImpdirartFmodifw =  .Fechamodificacionfw			lxImpdirartTimestamp = goLibrerias.ObtenerTimestamp()			lxImpdirartZadsfw =  .Zadsfw			lxImpdirartEsttrans =  .Estadotransferencia			lxImpdirartBdaltafw =  .Basededatosaltafw			lxImpdirartBdmodifw =  .Basededatosmodificacionfw			lxImpdirartVmodifw =  .Versionmodificacionfw			lxImpdirartHaltafw =  .Horaaltafw			lxImpdirartSmodifw =  .Seriemodificacionfw			lxImpdirartValtafw =  .Versionaltafw			lxImpdirartUaltafw =  .Usuarioaltafw			lxImpdirartSaltafw =  .Seriealtafw			lxImpdirartUmodifw =  .Usuariomodificacionfw			lxImpdirartHoraimpo =  .Horaimpo			lxImpdirartHoraexpo =  .Horaexpo			lxImpdirartHmodifw =  .Horamodificacionfw			lxImpdirartComp =  .Comportamiento			lxImpdirartNumero =  .Numero			lxImpdirartDescripcio =  .Descripcion			lxImpdirartPcuenta =  upper( .PlanDeCuentas_PK ) 			lxImpdirartImportanci =  .Importancia			lxImpdirartDisccos =  upper( .DistribucionPorCentroDeCosto_PK ) 			lxImpdirartCcosto =  upper( .CentroDeCosto_PK ) 			lxImpdirartImportancc =  .Prioridadccosto			lxImpdirartArtdesde =  .F_articulo_desde			lxImpdirartArthasta =  .F_articulo_hasta			lxImpdirartProdesde =  .F_proveedor_desde			lxImpdirartProhasta =  .F_proveedor_hasta			lxImpdirartTemdesde =  .F_temporada_desde			lxImpdirartTemhasta =  .F_temporada_hasta			lxImpdirartAnidesde =  .F_anio_desde			lxImpdirartAnihasta =  .F_anio_hasta			lxImpdirartFamdesde =  .F_familia_desde			lxImpdirartFamhasta =  .F_familia_hasta			lxImpdirartMatdesde =  .F_material_desde			lxImpdirartMathasta =  .F_material_hasta			lxImpdirartLindesde =  .F_linea_desde			lxImpdirartLinhasta =  .F_linea_hasta			lxImpdirartGrudesde =  .F_grupo_desde			lxImpdirartGruhasta =  .F_grupo_hasta			lxImpdirartCatdesde =  .F_categoria_desde			lxImpdirartCathasta =  .F_categoria_hasta			lxImpdirartCladesde =  .F_clasificacion_desde			lxImpdirartClahasta =  .F_clasificacion_hasta			lxImpdirartTipdesde =  .F_tipo_desde			lxImpdirartTiphasta =  .F_tipo_hasta			lxImpdirartArtconiva =  .Condicionivaventas			lxImpdirartIvvdesde =  .F_ivav_desde			lxImpdirartIvvhasta =  .F_ivav_hasta			lxImpdirartArtiva =  .Condicionivacompras			lxImpdirartIvcdesde =  .F_ivac_desde			lxImpdirartIvchasta =  .F_ivac_hasta			lxImpdirartIvcdesde =  .F_impi_desde			lxImpdirartIvchasta =  .F_impi_hasta			lxImpdirartTipoasi =  .Tipodeasiento			lxImpdirartObs =  .Observacion
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.IMPDIRART ( "Fecimpo","Fecexpo","Fectrans","Faltafw","Fmodifw","Timestamp","Zadsfw","Esttrans","Bdaltafw","Bdmodifw","Vmodifw","Haltafw","Smodifw","Valtafw","Ualtafw","Saltafw","Umodifw","Horaimpo","Horaexpo","Hmodifw","Comp","Numero","Descripcio","Pcuenta","Importanci","Disccos","Ccosto","Importancc","Artdesde","Arthasta","Prodesde","Prohasta","Temdesde","Temhasta","Anidesde","Anihasta","Famdesde","Famhasta","Matdesde","Mathasta","Lindesde","Linhasta","Grudesde","Gruhasta","Catdesde","Cathasta","Cladesde","Clahasta","Tipdesde","Tiphasta","Artconiva","Ivvdesde","Ivvhasta","Artiva","Ivcdesde","Ivchasta","Tipoasi","Obs" ) values ( <<"'" + this.ConvertirDateSql( lxImpdirartFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxImpdirartFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxImpdirartFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxImpdirartFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxImpdirartFmodifw ) + "'" >>, <<lxImpdirartTimestamp >>, <<"'" + this.FormatearTextoSql( lxImpdirartZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirartEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirartBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirartBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirartVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirartHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirartSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirartValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirartUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirartSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirartUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirartHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirartHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirartHmodifw ) + "'" >>, <<lxImpdirartComp >>, <<lxImpdirartNumero >>, <<"'" + this.FormatearTextoSql( lxImpdirartDescripcio ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirartPcuenta ) + "'" >>, <<lxImpdirartImportanci >>, <<"'" + this.FormatearTextoSql( lxImpdirartDisccos ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirartCcosto ) + "'" >>, <<lxImpdirartImportancc >>, <<"'" + this.FormatearTextoSql( lxImpdirartArtdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirartArthasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirartProdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirartProhasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirartTemdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirartTemhasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirartAnidesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirartAnihasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirartFamdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirartFamhasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirartMatdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirartMathasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirartLindesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirartLinhasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirartGrudesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirartGruhasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirartCatdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirartCathasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirartCladesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirartClahasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirartTipdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirartTiphasta ) + "'" >>, <<lxImpdirartArtconiva >>, <<"'" + this.FormatearTextoSql( lxImpdirartIvvdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirartIvvhasta ) + "'" >>, <<lxImpdirartArtiva >>, <<"'" + this.FormatearTextoSql( lxImpdirartIvcdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirartIvchasta ) + "'" >>, <<lxImpdirartTipoasi >>, <<"'" + this.FormatearTextoSql( lxImpdirartObs ) + "'" >> )
		endtext
		loColeccion.cTabla = 'IMPDIRART' 
		loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		With this
			local lcValorClavePrimariaString as String
			lcValorClavePrimariaString = transform( this.oEntidad.NUMERO )
		EndWith
		return loColeccion
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasUpdate() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcFiltro as string, loItem as object, lcSentencia as string, lcSentencia as string
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxImpdirartFecimpo, lxImpdirartFecexpo, lxImpdirartFectrans, lxImpdirartFaltafw, lxImpdirartFmodifw, lxImpdirartTimestamp, lxImpdirartZadsfw, lxImpdirartEsttrans, lxImpdirartBdaltafw, lxImpdirartBdmodifw, lxImpdirartVmodifw, lxImpdirartHaltafw, lxImpdirartSmodifw, lxImpdirartValtafw, lxImpdirartUaltafw, lxImpdirartSaltafw, lxImpdirartUmodifw, lxImpdirartHoraimpo, lxImpdirartHoraexpo, lxImpdirartHmodifw, lxImpdirartComp, lxImpdirartNumero, lxImpdirartDescripcio, lxImpdirartPcuenta, lxImpdirartImportanci, lxImpdirartDisccos, lxImpdirartCcosto, lxImpdirartImportancc, lxImpdirartArtdesde, lxImpdirartArthasta, lxImpdirartProdesde, lxImpdirartProhasta, lxImpdirartTemdesde, lxImpdirartTemhasta, lxImpdirartAnidesde, lxImpdirartAnihasta, lxImpdirartFamdesde, lxImpdirartFamhasta, lxImpdirartMatdesde, lxImpdirartMathasta, lxImpdirartLindesde, lxImpdirartLinhasta, lxImpdirartGrudesde, lxImpdirartGruhasta, lxImpdirartCatdesde, lxImpdirartCathasta, lxImpdirartCladesde, lxImpdirartClahasta, lxImpdirartTipdesde, lxImpdirartTiphasta, lxImpdirartArtconiva, lxImpdirartIvvdesde, lxImpdirartIvvhasta, lxImpdirartArtiva, lxImpdirartIvcdesde, lxImpdirartIvchasta, lxImpdirartIvcdesde, lxImpdirartIvchasta, lxImpdirartTipoasi, lxImpdirartObs
				lxImpdirartFecimpo =  .Fechaimpo			lxImpdirartFecexpo =  .Fechaexpo			lxImpdirartFectrans =  .Fechatransferencia			lxImpdirartFaltafw =  .Fechaaltafw			lxImpdirartFmodifw =  .Fechamodificacionfw			lxImpdirartTimestamp = goLibrerias.ObtenerTimestamp()			lxImpdirartZadsfw =  .Zadsfw			lxImpdirartEsttrans =  .Estadotransferencia			lxImpdirartBdaltafw =  .Basededatosaltafw			lxImpdirartBdmodifw =  .Basededatosmodificacionfw			lxImpdirartVmodifw =  .Versionmodificacionfw			lxImpdirartHaltafw =  .Horaaltafw			lxImpdirartSmodifw =  .Seriemodificacionfw			lxImpdirartValtafw =  .Versionaltafw			lxImpdirartUaltafw =  .Usuarioaltafw			lxImpdirartSaltafw =  .Seriealtafw			lxImpdirartUmodifw =  .Usuariomodificacionfw			lxImpdirartHoraimpo =  .Horaimpo			lxImpdirartHoraexpo =  .Horaexpo			lxImpdirartHmodifw =  .Horamodificacionfw			lxImpdirartComp =  .Comportamiento			lxImpdirartNumero =  .Numero			lxImpdirartDescripcio =  .Descripcion			lxImpdirartPcuenta =  upper( .PlanDeCuentas_PK ) 			lxImpdirartImportanci =  .Importancia			lxImpdirartDisccos =  upper( .DistribucionPorCentroDeCosto_PK ) 			lxImpdirartCcosto =  upper( .CentroDeCosto_PK ) 			lxImpdirartImportancc =  .Prioridadccosto			lxImpdirartArtdesde =  .F_articulo_desde			lxImpdirartArthasta =  .F_articulo_hasta			lxImpdirartProdesde =  .F_proveedor_desde			lxImpdirartProhasta =  .F_proveedor_hasta			lxImpdirartTemdesde =  .F_temporada_desde			lxImpdirartTemhasta =  .F_temporada_hasta			lxImpdirartAnidesde =  .F_anio_desde			lxImpdirartAnihasta =  .F_anio_hasta			lxImpdirartFamdesde =  .F_familia_desde			lxImpdirartFamhasta =  .F_familia_hasta			lxImpdirartMatdesde =  .F_material_desde			lxImpdirartMathasta =  .F_material_hasta			lxImpdirartLindesde =  .F_linea_desde			lxImpdirartLinhasta =  .F_linea_hasta			lxImpdirartGrudesde =  .F_grupo_desde			lxImpdirartGruhasta =  .F_grupo_hasta			lxImpdirartCatdesde =  .F_categoria_desde			lxImpdirartCathasta =  .F_categoria_hasta			lxImpdirartCladesde =  .F_clasificacion_desde			lxImpdirartClahasta =  .F_clasificacion_hasta			lxImpdirartTipdesde =  .F_tipo_desde			lxImpdirartTiphasta =  .F_tipo_hasta			lxImpdirartArtconiva =  .Condicionivaventas			lxImpdirartIvvdesde =  .F_ivav_desde			lxImpdirartIvvhasta =  .F_ivav_hasta			lxImpdirartArtiva =  .Condicionivacompras			lxImpdirartIvcdesde =  .F_ivac_desde			lxImpdirartIvchasta =  .F_ivac_hasta			lxImpdirartIvcdesde =  .F_impi_desde			lxImpdirartIvchasta =  .F_impi_hasta			lxImpdirartTipoasi =  .Tipodeasiento			lxImpdirartObs =  .Observacion
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.NUMERO
			lcValorClavePrimariaString = transform( this.oEntidad.NUMERO )

			lcFiltro = ["Numero" = ] + lcValorClavePrimariaString  + [ and  IMPDIRART.NUMERO != 0]
			text to lcSentencia noshow textmerge
				update ZooLogic.IMPDIRART set "Fecimpo" = <<"'" + this.ConvertirDateSql( lxImpdirartFecimpo ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxImpdirartFecexpo ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxImpdirartFectrans ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxImpdirartFaltafw ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxImpdirartFmodifw ) + "'">>, "Timestamp" = <<lxImpdirartTimestamp>>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxImpdirartZadsfw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxImpdirartEsttrans ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxImpdirartBdaltafw ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxImpdirartBdmodifw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxImpdirartVmodifw ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxImpdirartHaltafw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxImpdirartSmodifw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxImpdirartValtafw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxImpdirartUaltafw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxImpdirartSaltafw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxImpdirartUmodifw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxImpdirartHoraimpo ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxImpdirartHoraexpo ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxImpdirartHmodifw ) + "'">>, "Comp" = <<lxImpdirartComp>>, "Numero" = <<lxImpdirartNumero>>, "Descripcio" = <<"'" + this.FormatearTextoSql( lxImpdirartDescripcio ) + "'">>, "Pcuenta" = <<"'" + this.FormatearTextoSql( lxImpdirartPcuenta ) + "'">>, "Importanci" = <<lxImpdirartImportanci>>, "Disccos" = <<"'" + this.FormatearTextoSql( lxImpdirartDisccos ) + "'">>, "Ccosto" = <<"'" + this.FormatearTextoSql( lxImpdirartCcosto ) + "'">>, "Importancc" = <<lxImpdirartImportancc>>, "Artdesde" = <<"'" + this.FormatearTextoSql( lxImpdirartArtdesde ) + "'">>, "Arthasta" = <<"'" + this.FormatearTextoSql( lxImpdirartArthasta ) + "'">>, "Prodesde" = <<"'" + this.FormatearTextoSql( lxImpdirartProdesde ) + "'">>, "Prohasta" = <<"'" + this.FormatearTextoSql( lxImpdirartProhasta ) + "'">>, "Temdesde" = <<"'" + this.FormatearTextoSql( lxImpdirartTemdesde ) + "'">>, "Temhasta" = <<"'" + this.FormatearTextoSql( lxImpdirartTemhasta ) + "'">>, "Anidesde" = <<"'" + this.FormatearTextoSql( lxImpdirartAnidesde ) + "'">>, "Anihasta" = <<"'" + this.FormatearTextoSql( lxImpdirartAnihasta ) + "'">>, "Famdesde" = <<"'" + this.FormatearTextoSql( lxImpdirartFamdesde ) + "'">>, "Famhasta" = <<"'" + this.FormatearTextoSql( lxImpdirartFamhasta ) + "'">>, "Matdesde" = <<"'" + this.FormatearTextoSql( lxImpdirartMatdesde ) + "'">>, "Mathasta" = <<"'" + this.FormatearTextoSql( lxImpdirartMathasta ) + "'">>, "Lindesde" = <<"'" + this.FormatearTextoSql( lxImpdirartLindesde ) + "'">>, "Linhasta" = <<"'" + this.FormatearTextoSql( lxImpdirartLinhasta ) + "'">>, "Grudesde" = <<"'" + this.FormatearTextoSql( lxImpdirartGrudesde ) + "'">>, "Gruhasta" = <<"'" + this.FormatearTextoSql( lxImpdirartGruhasta ) + "'">>, "Catdesde" = <<"'" + this.FormatearTextoSql( lxImpdirartCatdesde ) + "'">>, "Cathasta" = <<"'" + this.FormatearTextoSql( lxImpdirartCathasta ) + "'">>, "Cladesde" = <<"'" + this.FormatearTextoSql( lxImpdirartCladesde ) + "'">>, "Clahasta" = <<"'" + this.FormatearTextoSql( lxImpdirartClahasta ) + "'">>, "Tipdesde" = <<"'" + this.FormatearTextoSql( lxImpdirartTipdesde ) + "'">>, "Tiphasta" = <<"'" + this.FormatearTextoSql( lxImpdirartTiphasta ) + "'">>, "Artconiva" = <<lxImpdirartArtconiva>>, "Ivvdesde" = <<"'" + this.FormatearTextoSql( lxImpdirartIvvdesde ) + "'">>, "Ivvhasta" = <<"'" + this.FormatearTextoSql( lxImpdirartIvvhasta ) + "'">>, "Artiva" = <<lxImpdirartArtiva>>, "Ivcdesde" = <<"'" + this.FormatearTextoSql( lxImpdirartIvcdesde ) + "'">>, "Ivchasta" = <<"'" + this.FormatearTextoSql( lxImpdirartIvchasta ) + "'">>, "Tipoasi" = <<lxImpdirartTipoasi>>, "Obs" = <<"'" + this.FormatearTextoSql( lxImpdirartObs ) + "'">> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'IMPDIRART' 
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
			lxValorClavePrimaria = this.oEntidad.NUMERO
			lcValorClavePrimariaString = transform( this.oEntidad.NUMERO )

			lcFiltro = ["Numero" = ] + lcValorClavePrimariaString  + [ and  IMPDIRART.NUMERO != 0]
		loColeccion.Agregar( 'delete from ZooLogic.IMPDIRART where ' + lcFiltro )
			loColeccion.cTabla = 'IMPDIRART' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.IMPDIRART where  IMPDIRART.NUMERO != 0" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.IMPDIRART where NUMERO = " + transform( this.oEntidad.NUMERO )+ " and  IMPDIRART.NUMERO != 0" )
			this.xmlacursor( lcXml, lcCursor )
		if reccount( lcCursor ) > 0
			lnTimeStamp = &lcCursor..Timestamp
		endif
		use in select( lcCursor )

		return lnTimeStamp 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ActualizarNumeraciones() as void
		local loError as exception
		dodefault()

		with this.oEntidad
			if .VerificarContexto( 'C' )
			else
				.lCargando = .t.
				try
					if empty( .oNumeraciones.ObtenerServicio('NUMERO') ) and iif( type( '.NUMERO' ) = 'C', int( val( .NUMERO ) ),.NUMERO ) = .oNumeraciones.UltimoNumero( 'NUMERO' )
						.oNumeraciones.Actualizar( 'NUMERO' )
					endif
				catch to loError
					goServicios.Errores.LevantarExcepcion( loError ) 
				finally
					.lCargando = .f.
				endtry
			endif
		endwith
		
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function GrabarNumeraciones() as void

		dodefault()

		with this.oEntidad
			.lCargando = .t.
			Try
				If .VerificarContexto( 'C' )
				Else
					.NUMERO = .oNumeraciones.grabar( 'NUMERO' )
				EndIf
			Catch to loError
				goServicios.Errores.LevantarExcepcion( loError )
			Finally
				.lCargando = .f.
			EndTry
		endwith
		
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirCabecera( tlLoguear as Boolean ) As Void
		local lcCursor as String, ldFecha as Date, lcHora as string, lcValorABuscar As String, lxValorClavePK As variant, lxValorClavePrimaria As variant, lcIdentificadorParaLoguear as string, lcMensajeExtra as String
		lcValorABuscar = ''
		lxValorClavePK = ''
		lcMensajeExtra = ''
		lcCursor = This.oEntidad.cPrefijoRecibir + 'IMPDIRART'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.IMPDIRART Where NUMERO = ] + transform( &lcCursor..NUMERO ), 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					this.oConexion.EjecutarSql( [UPDATE ZooLogic.IMPDIRART set  FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, TIMESTAMP = ] + transform( &lcCursor..TIMESTAMP )+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, Comp = ] + transform( &lcCursor..Comp )+ [, NUMERO = ] + transform( &lcCursor..NUMERO )+ [, Descripcio = ] + "'" + this.FormatearTextoSql( &lcCursor..Descripcio ) + "'"+ [, PCUENTA = ] + "'" + this.FormatearTextoSql( &lcCursor..PCUENTA ) + "'"+ [, Importanci = ] + transform( &lcCursor..Importanci )+ [, DisCCos = ] + "'" + this.FormatearTextoSql( &lcCursor..DisCCos ) + "'"+ [, CCosto = ] + "'" + this.FormatearTextoSql( &lcCursor..CCosto ) + "'"+ [, ImportancC = ] + transform( &lcCursor..ImportancC )+ [, ArtDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..ArtDesde ) + "'"+ [, ArtHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..ArtHasta ) + "'"+ [, ProDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..ProDesde ) + "'"+ [, ProHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..ProHasta ) + "'"+ [, TemDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..TemDesde ) + "'"+ [, TemHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..TemHasta ) + "'"+ [, AniDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..AniDesde ) + "'"+ [, AniHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..AniHasta ) + "'"+ [, FamDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..FamDesde ) + "'"+ [, FamHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..FamHasta ) + "'"+ [, MatDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..MatDesde ) + "'"+ [, MatHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..MatHasta ) + "'"+ [, LinDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..LinDesde ) + "'"+ [, LinHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..LinHasta ) + "'"+ [, GruDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..GruDesde ) + "'"+ [, GruHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..GruHasta ) + "'"+ [, CatDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..CatDesde ) + "'"+ [, CatHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..CatHasta ) + "'"+ [, ClaDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..ClaDesde ) + "'"+ [, ClaHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..ClaHasta ) + "'"+ [, TipDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..TipDesde ) + "'"+ [, TipHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..TipHasta ) + "'"+ [, ARTCONIVA = ] + transform( &lcCursor..ARTCONIVA )+ [, IvvDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..IvvDesde ) + "'"+ [, IvvHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..IvvHasta ) + "'"+ [, ARTIVA = ] + transform( &lcCursor..ARTIVA )+ [, IvcDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..IvcDesde ) + "'"+ [, IvcHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..IvcHasta ) + "'"+ [, IvcDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..IvcDesde ) + "'"+ [, IvcHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..IvcHasta ) + "'"+ [, TipoAsi = ] + transform( &lcCursor..TipoAsi )+ [, OBS = ] + "'" + this.FormatearTextoSql( &lcCursor..OBS ) + "'" + [ Where NUMERO = ] + transform( &lcCursor..NUMERO ) )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
				endIf
			else
				Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
				Text to lcCampos noShow
					 FECIMPO, FECEXPO, FECTRANS, FALTAFW, FMODIFW, TIMESTAMP, ZADSFW, ESTTRANS, BDALTAFW, BDMODIFW, VMODIFW, HALTAFW, SMODIFW, VALTAFW, UALTAFW, SALTAFW, UMODIFW, HORAIMPO, HORAEXPO, HMODIFW, Comp, NUMERO, Descripcio, PCUENTA, Importanci, DisCCos, CCosto, ImportancC, ArtDesde, ArtHasta, ProDesde, ProHasta, TemDesde, TemHasta, AniDesde, AniHasta, FamDesde, FamHasta, MatDesde, MatHasta, LinDesde, LinHasta, GruDesde, GruHasta, CatDesde, CatHasta, ClaDesde, ClaHasta, TipDesde, TipHasta, ARTCONIVA, IvvDesde, IvvHasta, ARTIVA, IvcDesde, IvcHasta, IvcDesde, IvcHasta, TipoAsi, OBS
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + transform( &lcCursor..TIMESTAMP ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + transform( &lcCursor..Comp )
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..NUMERO ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..Descripcio ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..PCUENTA ) + "'" + ',' + transform( &lcCursor..Importanci ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..DisCCos ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CCosto ) + "'" + ',' + transform( &lcCursor..ImportancC ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..ArtDesde ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..ArtHasta ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ProDesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ProHasta ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..TemDesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..TemHasta ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..AniDesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..AniHasta ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..FamDesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..FamHasta ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..MatDesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..MatHasta ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..LinDesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..LinHasta ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..GruDesde ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..GruHasta ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CatDesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CatHasta ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ClaDesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ClaHasta ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..TipDesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..TipHasta ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..ARTCONIVA ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..IvvDesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..IvvHasta ) + "'" + ',' + transform( &lcCursor..ARTIVA ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..IvcDesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..IvcHasta ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..IvcDesde ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..IvcHasta ) + "'" + ',' + transform( &lcCursor..TipoAsi ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..OBS ) + "'"
lcValoresCampos = substr(lcValoresCampos,2) 

				this.oConexion.EjecutarSql( [Insert into ZooLogic.IMPDIRART ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
				this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'IMPDIRART'
		if This.ActualizaEnRecepcion()
	endif
	Use in select( 'cExistentes' )
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearCursorMemo( tcCursorACrear as String, tcTablaConMemo as String ) as Void
		create cursor &tcCursorACrear ( NUMERO N (8) , Orden N(16), texto C(80))
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirComponentes() As Void
		
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function ObtenerIdentificadorParaLoguear( tcCursor as String ) As String
		local lcRetorno as String, lnCC as String , loCC as Object, lni as Integer, lcSecuencia as String
		lcRetorno = this.oEntidad.cDescripcion 
		lcRetorno = lcRetorno + ' - Número: ' + transform( &tcCursor..NUMERO     )
		Return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EsAliasDeProceso( tcAlias As String, tcPrefijo as string ) As Boolean
		local llRetorno as Boolean, lcAlias as String, lcPrefijo As String
		llRetorno = .F.
		lcAlias = upper( alltrim( tcAlias ) )
		lcPrefijo = upper( alltrim( tcPrefijo ) )
		Do Case
			Case  lcAlias == lcPrefijo + 'IMPDIRART'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'IMPDIRART_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'IMPDIRART_OBS'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_IMPDIRART')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'IMPDIRART'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..NUMERO
		llCondicion = isnull( lxVar )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad IMPDIRART. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'IMPDIRART'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		select recno() as _Rec, * from &lcCursor into cursor CurConRecno
		select max( _Rec ) as Maximo,NUMERO as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( NUMERO, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		Use in select( 'CurConRecno' )
		Use in select( 'RepMax' )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDatosInvalidos( toConexion as Object ) as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'IMPDIRART'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_IMPDIRART') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_IMPDIRART
Create Table ZooLogic.TablaTrabajo_IMPDIRART ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fecimpo" datetime  null, 
"fecexpo" datetime  null, 
"fectrans" datetime  null, 
"faltafw" datetime  null, 
"fmodifw" datetime  null, 
"timestamp" numeric( 20, 0 )  null, 
"zadsfw" varchar(max)  null, 
"esttrans" char( 20 )  null, 
"bdaltafw" char( 8 )  null, 
"bdmodifw" char( 8 )  null, 
"vmodifw" char( 13 )  null, 
"haltafw" char( 8 )  null, 
"smodifw" char( 7 )  null, 
"valtafw" char( 13 )  null, 
"ualtafw" char( 100 )  null, 
"saltafw" char( 7 )  null, 
"umodifw" char( 100 )  null, 
"horaimpo" char( 8 )  null, 
"horaexpo" char( 8 )  null, 
"hmodifw" char( 8 )  null, 
"comp" numeric( 1, 0 )  null, 
"numero" numeric( 8, 0 )  null, 
"descripcio" char( 50 )  null, 
"pcuenta" char( 30 )  null, 
"importanci" numeric( 3, 0 )  null, 
"disccos" char( 20 )  null, 
"ccosto" char( 20 )  null, 
"importancc" numeric( 3, 0 )  null, 
"artdesde" char( 13 )  null, 
"arthasta" char( 13 )  null, 
"prodesde" char( 5 )  null, 
"prohasta" char( 5 )  null, 
"temdesde" char( 5 )  null, 
"temhasta" char( 5 )  null, 
"anidesde" char( 2 )  null, 
"anihasta" char( 2 )  null, 
"famdesde" char( 5 )  null, 
"famhasta" char( 5 )  null, 
"matdesde" char( 5 )  null, 
"mathasta" char( 5 )  null, 
"lindesde" char( 5 )  null, 
"linhasta" char( 5 )  null, 
"grudesde" char( 5 )  null, 
"gruhasta" char( 5 )  null, 
"catdesde" char( 5 )  null, 
"cathasta" char( 5 )  null, 
"cladesde" char( 5 )  null, 
"clahasta" char( 5 )  null, 
"tipdesde" char( 5 )  null, 
"tiphasta" char( 5 )  null, 
"artconiva" numeric( 1, 0 )  null, 
"ivvdesde" char( 5 )  null, 
"ivvhasta" char( 5 )  null, 
"artiva" numeric( 1, 0 )  null, 
"ivcdesde" char( 5 )  null, 
"ivchasta" char( 5 )  null, 
"ivcdesde" char( 5 )  null, 
"ivchasta" char( 5 )  null, 
"tipoasi" numeric( 1, 0 )  null, 
"obs" varchar(max)  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_IMPDIRART' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_IMPDIRART' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'IMPDIRART'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		with loManejador
			if this.oEntidad.VerificarContexto( 'CB' )
			else
				.AgregarMapeo('Nrolinea','Nrolinea')
			endif
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('timestamp','timestamp')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('comp','comp')
			.AgregarMapeo('numero','numero')
			.AgregarMapeo('descripcio','descripcio')
			.AgregarMapeo('pcuenta','pcuenta')
			.AgregarMapeo('importanci','importanci')
			.AgregarMapeo('disccos','disccos')
			.AgregarMapeo('ccosto','ccosto')
			.AgregarMapeo('importancc','importancc')
			.AgregarMapeo('artdesde','artdesde')
			.AgregarMapeo('arthasta','arthasta')
			.AgregarMapeo('prodesde','prodesde')
			.AgregarMapeo('prohasta','prohasta')
			.AgregarMapeo('temdesde','temdesde')
			.AgregarMapeo('temhasta','temhasta')
			.AgregarMapeo('anidesde','anidesde')
			.AgregarMapeo('anihasta','anihasta')
			.AgregarMapeo('famdesde','famdesde')
			.AgregarMapeo('famhasta','famhasta')
			.AgregarMapeo('matdesde','matdesde')
			.AgregarMapeo('mathasta','mathasta')
			.AgregarMapeo('lindesde','lindesde')
			.AgregarMapeo('linhasta','linhasta')
			.AgregarMapeo('grudesde','grudesde')
			.AgregarMapeo('gruhasta','gruhasta')
			.AgregarMapeo('catdesde','catdesde')
			.AgregarMapeo('cathasta','cathasta')
			.AgregarMapeo('cladesde','cladesde')
			.AgregarMapeo('clahasta','clahasta')
			.AgregarMapeo('tipdesde','tipdesde')
			.AgregarMapeo('tiphasta','tiphasta')
			.AgregarMapeo('artconiva','artconiva')
			.AgregarMapeo('ivvdesde','ivvdesde')
			.AgregarMapeo('ivvhasta','ivvhasta')
			.AgregarMapeo('artiva','artiva')
			.AgregarMapeo('ivcdesde','ivcdesde')
			.AgregarMapeo('ivchasta','ivchasta')
			.AgregarMapeo('ivcdesde','ivcdesde')
			.AgregarMapeo('ivchasta','ivchasta')
			.AgregarMapeo('tipoasi','tipoasi')
			.AgregarMapeo('obs','obs')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_IMPDIRART'
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
				Update t Set t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.TIMESTAMP = isnull( d.TIMESTAMP, t.TIMESTAMP ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.COMP = isnull( d.COMP, t.COMP ),t.NUMERO = isnull( d.NUMERO, t.NUMERO ),t.DESCRIPCIO = isnull( d.DESCRIPCIO, t.DESCRIPCIO ),t.PCUENTA = isnull( d.PCUENTA, t.PCUENTA ),t.IMPORTANCI = isnull( d.IMPORTANCI, t.IMPORTANCI ),t.DISCCOS = isnull( d.DISCCOS, t.DISCCOS ),t.CCOSTO = isnull( d.CCOSTO, t.CCOSTO ),t.IMPORTANCC = isnull( d.IMPORTANCC, t.IMPORTANCC ),t.ARTDESDE = isnull( d.ARTDESDE, t.ARTDESDE ),t.ARTHASTA = isnull( d.ARTHASTA, t.ARTHASTA ),t.PRODESDE = isnull( d.PRODESDE, t.PRODESDE ),t.PROHASTA = isnull( d.PROHASTA, t.PROHASTA ),t.TEMDESDE = isnull( d.TEMDESDE, t.TEMDESDE ),t.TEMHASTA = isnull( d.TEMHASTA, t.TEMHASTA ),t.ANIDESDE = isnull( d.ANIDESDE, t.ANIDESDE ),t.ANIHASTA = isnull( d.ANIHASTA, t.ANIHASTA ),t.FAMDESDE = isnull( d.FAMDESDE, t.FAMDESDE ),t.FAMHASTA = isnull( d.FAMHASTA, t.FAMHASTA ),t.MATDESDE = isnull( d.MATDESDE, t.MATDESDE ),t.MATHASTA = isnull( d.MATHASTA, t.MATHASTA ),t.LINDESDE = isnull( d.LINDESDE, t.LINDESDE ),t.LINHASTA = isnull( d.LINHASTA, t.LINHASTA ),t.GRUDESDE = isnull( d.GRUDESDE, t.GRUDESDE ),t.GRUHASTA = isnull( d.GRUHASTA, t.GRUHASTA ),t.CATDESDE = isnull( d.CATDESDE, t.CATDESDE ),t.CATHASTA = isnull( d.CATHASTA, t.CATHASTA ),t.CLADESDE = isnull( d.CLADESDE, t.CLADESDE ),t.CLAHASTA = isnull( d.CLAHASTA, t.CLAHASTA ),t.TIPDESDE = isnull( d.TIPDESDE, t.TIPDESDE ),t.TIPHASTA = isnull( d.TIPHASTA, t.TIPHASTA ),t.ARTCONIVA = isnull( d.ARTCONIVA, t.ARTCONIVA ),t.IVVDESDE = isnull( d.IVVDESDE, t.IVVDESDE ),t.IVVHASTA = isnull( d.IVVHASTA, t.IVVHASTA ),t.ARTIVA = isnull( d.ARTIVA, t.ARTIVA ),t.IVCDESDE = isnull( d.IVCDESDE, t.IVCDESDE ),t.IVCHASTA = isnull( d.IVCHASTA, t.IVCHASTA ),t.TIPOASI = isnull( d.TIPOASI, t.TIPOASI ),t.OBS = isnull( d.OBS, t.OBS )
					from ZooLogic.IMPDIRART t inner join deleted d 
							 on t.NUMERO = d.NUMERO
				-- Fin Updates
				insert into ZooLogic.IMPDIRART(Fecimpo,Fecexpo,Fectrans,Faltafw,Fmodifw,Timestamp,Zadsfw,Esttrans,Bdaltafw,Bdmodifw,Vmodifw,Haltafw,Smodifw,Valtafw,Ualtafw,Saltafw,Umodifw,Horaimpo,Horaexpo,Hmodifw,Comp,Numero,Descripcio,Pcuenta,Importanci,Disccos,Ccosto,Importancc,Artdesde,Arthasta,Prodesde,Prohasta,Temdesde,Temhasta,Anidesde,Anihasta,Famdesde,Famhasta,Matdesde,Mathasta,Lindesde,Linhasta,Grudesde,Gruhasta,Catdesde,Cathasta,Cladesde,Clahasta,Tipdesde,Tiphasta,Artconiva,Ivvdesde,Ivvhasta,Artiva,Ivcdesde,Ivchasta,Tipoasi,Obs)
					Select isnull( d.FECIMPO,''),isnull( d.FECEXPO,''),isnull( d.FECTRANS,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FMODIFW,''),isnull( d.TIMESTAMP,0),isnull( d.ZADSFW,''),isnull( d.ESTTRANS,''),isnull( d.BDALTAFW,''),isnull( d.BDMODIFW,''),isnull( d.VMODIFW,''),convert( char(8), getdate(), 108 ),isnull( d.SMODIFW,''),isnull( d.VALTAFW,''),isnull( d.UALTAFW,''),isnull( d.SALTAFW,''),isnull( d.UMODIFW,''),isnull( d.HORAIMPO,''),isnull( d.HORAEXPO,''),isnull( d.HMODIFW,''),isnull( d.COMP,0),isnull( d.NUMERO,0),isnull( d.DESCRIPCIO,''),isnull( d.PCUENTA,''),isnull( d.IMPORTANCI,0),isnull( d.DISCCOS,''),isnull( d.CCOSTO,''),isnull( d.IMPORTANCC,0),isnull( d.ARTDESDE,''),isnull( d.ARTHASTA,''),isnull( d.PRODESDE,''),isnull( d.PROHASTA,''),isnull( d.TEMDESDE,''),isnull( d.TEMHASTA,''),isnull( d.ANIDESDE,''),isnull( d.ANIHASTA,''),isnull( d.FAMDESDE,''),isnull( d.FAMHASTA,''),isnull( d.MATDESDE,''),isnull( d.MATHASTA,''),isnull( d.LINDESDE,''),isnull( d.LINHASTA,''),isnull( d.GRUDESDE,''),isnull( d.GRUHASTA,''),isnull( d.CATDESDE,''),isnull( d.CATHASTA,''),isnull( d.CLADESDE,''),isnull( d.CLAHASTA,''),isnull( d.TIPDESDE,''),isnull( d.TIPHASTA,''),isnull( d.ARTCONIVA,0),isnull( d.IVVDESDE,''),isnull( d.IVVHASTA,''),isnull( d.ARTIVA,0),isnull( d.IVCDESDE,''),isnull( d.IVCHASTA,''),isnull( d.TIPOASI,0),isnull( d.OBS,'')
						From deleted d left join ZooLogic.IMPDIRART pk 
							 on d.NUMERO = pk.NUMERO
						Where pk.NUMERO Is Null 
				-- Fin Inserts
			End
		EndText
		Return lcCadena
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	protected Function EliminarTablasDeTrabajo( toConexion as Object ) as void
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_IMPDIRART') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_IMPDIRART
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_IMPDIRART' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_IMPDIRART.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_IMPDIRART.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_IMPDIRART.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_IMPDIRART.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_IMPDIRART.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Timestamp = nvl( c_IMPDIRART.Timestamp, 0 )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Estadotransferencia = nvl( c_IMPDIRART.Estadotransferencia, [] )
					.Basededatosaltafw = nvl( c_IMPDIRART.Basededatosaltafw, [] )
					.Basededatosmodificacionfw = nvl( c_IMPDIRART.Basededatosmodificacionfw, [] )
					.Versionmodificacionfw = nvl( c_IMPDIRART.Versionmodificacionfw, [] )
					.Horaaltafw = nvl( c_IMPDIRART.Horaaltafw, [] )
					.Seriemodificacionfw = nvl( c_IMPDIRART.Seriemodificacionfw, [] )
					.Versionaltafw = nvl( c_IMPDIRART.Versionaltafw, [] )
					.Usuarioaltafw = nvl( c_IMPDIRART.Usuarioaltafw, [] )
					.Seriealtafw = nvl( c_IMPDIRART.Seriealtafw, [] )
					.Usuariomodificacionfw = nvl( c_IMPDIRART.Usuariomodificacionfw, [] )
					.Horaimpo = nvl( c_IMPDIRART.Horaimpo, [] )
					.Horaexpo = nvl( c_IMPDIRART.Horaexpo, [] )
					.Horamodificacionfw = nvl( c_IMPDIRART.Horamodificacionfw, [] )
					.Comportamiento = nvl( c_IMPDIRART.Comportamiento, 0 )
					.Numero = nvl( c_IMPDIRART.Numero, 0 )
					.Descripcion = nvl( c_IMPDIRART.Descripcion, [] )
					.Plandecuentas_PK =  nvl( c_IMPDIRART.Plandecuentas, [] )
					.Importancia = nvl( c_IMPDIRART.Importancia, 0 )
					.Distribucionporcentrodecosto_PK =  nvl( c_IMPDIRART.Distribucionporcentrodecosto, [] )
					.Centrodecosto_PK =  nvl( c_IMPDIRART.Centrodecosto, [] )
					.Prioridadccosto = nvl( c_IMPDIRART.Prioridadccosto, 0 )
					.F_articulo_desde = nvl( c_IMPDIRART.F_articulo_desde, [] )
					.F_articulo_hasta = nvl( c_IMPDIRART.F_articulo_hasta, [] )
					.F_proveedor_desde = nvl( c_IMPDIRART.F_proveedor_desde, [] )
					.F_proveedor_hasta = nvl( c_IMPDIRART.F_proveedor_hasta, [] )
					.F_temporada_desde = nvl( c_IMPDIRART.F_temporada_desde, [] )
					.F_temporada_hasta = nvl( c_IMPDIRART.F_temporada_hasta, [] )
					.F_anio_desde = nvl( c_IMPDIRART.F_anio_desde, [] )
					.F_anio_hasta = nvl( c_IMPDIRART.F_anio_hasta, [] )
					.F_familia_desde = nvl( c_IMPDIRART.F_familia_desde, [] )
					.F_familia_hasta = nvl( c_IMPDIRART.F_familia_hasta, [] )
					.F_material_desde = nvl( c_IMPDIRART.F_material_desde, [] )
					.F_material_hasta = nvl( c_IMPDIRART.F_material_hasta, [] )
					.F_linea_desde = nvl( c_IMPDIRART.F_linea_desde, [] )
					.F_linea_hasta = nvl( c_IMPDIRART.F_linea_hasta, [] )
					.F_grupo_desde = nvl( c_IMPDIRART.F_grupo_desde, [] )
					.F_grupo_hasta = nvl( c_IMPDIRART.F_grupo_hasta, [] )
					.F_categoria_desde = nvl( c_IMPDIRART.F_categoria_desde, [] )
					.F_categoria_hasta = nvl( c_IMPDIRART.F_categoria_hasta, [] )
					.F_clasificacion_desde = nvl( c_IMPDIRART.F_clasificacion_desde, [] )
					.F_clasificacion_hasta = nvl( c_IMPDIRART.F_clasificacion_hasta, [] )
					.F_tipo_desde = nvl( c_IMPDIRART.F_tipo_desde, [] )
					.F_tipo_hasta = nvl( c_IMPDIRART.F_tipo_hasta, [] )
					.Condicionivaventas = nvl( c_IMPDIRART.Condicionivaventas, 0 )
					.F_ivav_desde = nvl( c_IMPDIRART.F_ivav_desde, [] )
					.F_ivav_hasta = nvl( c_IMPDIRART.F_ivav_hasta, [] )
					.Condicionivacompras = nvl( c_IMPDIRART.Condicionivacompras, 0 )
					.F_ivac_desde = nvl( c_IMPDIRART.F_ivac_desde, [] )
					.F_ivac_hasta = nvl( c_IMPDIRART.F_ivac_hasta, [] )
					.F_impi_desde = nvl( c_IMPDIRART.F_impi_desde, [] )
					.F_impi_hasta = nvl( c_IMPDIRART.F_impi_hasta, [] )
					.Tipodeasiento = nvl( c_IMPDIRART.Tipodeasiento, 0 )
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
		
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function ObtenerMemo( tcTabla as String ) as string
		local lcAtributo as string
		lcAtributo = strtran( tcTabla, 'c_', '' )
		return c_IMPDIRART.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.IMPDIRART' )
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
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "NUMERO"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
		text to lcSQL textmerge noshow
				SELECT nro,totalRegistros,NUMERO as Id
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    NUMERO from (
							select * 
								from ZooLogic.IMPDIRART 
								Where   IMPDIRART.NUMERO != 0
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "IMPDIRART", "", lcCursor, set("Datasession") )
		lcXml = this.CursorAXml( lcCursor )
		
		use in select( lcCursor )
		
		Return lcXml 
		
	endfunc
	*-----------------------------------------------------------------------------------------
	function ObtenerDatosEntidadPaginado( tcOrderBy as String, tcFiltro as String, tnCantidad as Integer, tnPagina as Integer )  as String
		local lcOrderBy as String, lnCuantos as Integer, lnPagina as Integer, lnTope as Integer, lnDesde as Integer, lcSQL as String, lcCursor as String, lcXml as String
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "NUMERO"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
			text to lcAtributos textmerge noshow
			"Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Timestamp" as "Timestamp", "Zadsfw" as "Zadsfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Haltafw" as "Horaaltafw", "Smodifw" as "Seriemodificacionfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Umodifw" as "Usuariomodificacionfw", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Comp" as "Comportamiento", "Numero" as "Numero", "Descripcio" as "Descripcion", "Pcuenta" as "Plandecuentas", "Importanci" as "Importancia", "Disccos" as "Distribucionporcentrodecosto", "Ccosto" as "Centrodecosto", "Importancc" as "Prioridadccosto", "Artdesde" as "F_articulo_desde", "Arthasta" as "F_articulo_hasta", "Prodesde" as "F_proveedor_desde", "Prohasta" as "F_proveedor_hasta", "Temdesde" as "F_temporada_desde", "Temhasta" as "F_temporada_hasta", "Anidesde" as "F_anio_desde", "Anihasta" as "F_anio_hasta", "Famdesde" as "F_familia_desde", "Famhasta" as "F_familia_hasta", "Matdesde" as "F_material_desde", "Mathasta" as "F_material_hasta", "Lindesde" as "F_linea_desde", "Linhasta" as "F_linea_hasta", "Grudesde" as "F_grupo_desde", "Gruhasta" as "F_grupo_hasta", "Catdesde" as "F_categoria_desde", "Cathasta" as "F_categoria_hasta", "Cladesde" as "F_clasificacion_desde", "Clahasta" as "F_clasificacion_hasta", "Tipdesde" as "F_tipo_desde", "Tiphasta" as "F_tipo_hasta", "Artconiva" as "Condicionivaventas", "Ivvdesde" as "F_ivav_desde", "Ivvhasta" as "F_ivav_hasta", "Artiva" as "Condicionivacompras", "Ivcdesde" as "F_ivac_desde", "Ivchasta" as "F_ivac_hasta", "Ivcdesde" as "F_impi_desde", "Ivchasta" as "F_impi_hasta", "Tipoasi" as "Tipodeasiento", "Obs" as "Observacion"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.IMPDIRART 
								Where   IMPDIRART.NUMERO != 0
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
	Tabla = 'IMPDIRART'
	Filtro = " IMPDIRART.NUMERO != 0"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " IMPDIRART.NUMERO != 0"
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
	<row entidad="IMPDIRART                               " atributo="FECHAIMPO                               " tabla="IMPDIRART      " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRART                               " atributo="FECHAEXPO                               " tabla="IMPDIRART      " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRART                               " atributo="FECHATRANSFERENCIA                      " tabla="IMPDIRART      " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha transferencia                                                                                                                                             " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRART                               " atributo="FECHAALTAFW                             " tabla="IMPDIRART      " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRART                               " atributo="FECHAMODIFICACIONFW                     " tabla="IMPDIRART      " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRART                               " atributo="TIMESTAMP                               " tabla="IMPDIRART      " campo="TIMESTAMP " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRART                               " atributo="ZADSFW                                  " tabla="IMPDIRART      " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRART                               " atributo="ESTADOTRANSFERENCIA                     " tabla="IMPDIRART      " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado transferencia                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRART                               " atributo="BASEDEDATOSALTAFW                       " tabla="IMPDIRART      " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRART                               " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="IMPDIRART      " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRART                               " atributo="VERSIONMODIFICACIONFW                   " tabla="IMPDIRART      " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRART                               " atributo="HORAALTAFW                              " tabla="IMPDIRART      " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRART                               " atributo="SERIEMODIFICACIONFW                     " tabla="IMPDIRART      " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRART                               " atributo="VERSIONALTAFW                           " tabla="IMPDIRART      " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRART                               " atributo="USUARIOALTAFW                           " tabla="IMPDIRART      " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRART                               " atributo="SERIEALTAFW                             " tabla="IMPDIRART      " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRART                               " atributo="USUARIOMODIFICACIONFW                   " tabla="IMPDIRART      " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRART                               " atributo="HORAIMPO                                " tabla="IMPDIRART      " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRART                               " atributo="HORAEXPO                                " tabla="IMPDIRART      " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRART                               " atributo="HORAMODIFICACIONFW                      " tabla="IMPDIRART      " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRART                               " atributo="COMPORTAMIENTO                          " tabla="IMPDIRART      " campo="COMP      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="10" etiqueta="Comportamiento                                                                                                                                                  " dominio="COMBOXML                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="12" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRART                               " atributo="NUMERO                                  " tabla="IMPDIRART      " campo="NUMERO    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="8" etiqueta="Número                                                                                                                                                          " dominio="CODIGONUMERICO                " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRART                               " atributo="DESCRIPCION                             " tabla="IMPDIRART      " campo="DESCRIPCIO" claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="4" etiqueta="Descripción                                                                                                                                                     " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRART                               " atributo="PLANDECUENTAS                           " tabla="IMPDIRART      " campo="PCUENTA   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="PLANDECUENTAS                           " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="400" etiqueta="Cuenta                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="&quot; plancuenta.CTAIMPUT = .t. &quot;                                                                                                                                                                           " grupo="0" subgrupo="1" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRART                               " atributo="IMPORTANCIA                             " tabla="IMPDIRART      " campo="IMPORTANCI" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="3" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="4" etiqueta="Importancia                                                                                                                                                     " dominio="NUMERICONONEGATIVO            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRART                               " atributo="DISTRIBUCIONPORCENTRODECOSTO            " tabla="IMPDIRART      " campo="DISCCOS   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="DISTRIBUCIONCENTRODECOSTO               " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="402" etiqueta="Distribución por c. costos                                                                                                                                      " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRART                               " atributo="CENTRODECOSTO                           " tabla="IMPDIRART      " campo="CCOSTO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CENTRODECOSTO                           " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="404" etiqueta="Centro de costo                                                                                                                                                 " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRART                               " atributo="PRIORIDADCCOSTO                         " tabla="IMPDIRART      " campo="IMPORTANCC" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="3" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="4" etiqueta="Importancia                                                                                                                                                     " dominio="NUMERICONONEGATIVO            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRART                               " atributo="F_ARTICULO_DESDE                        " tabla="IMPDIRART      " campo="ARTDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="406" etiqueta="Artículo                                                                                                                                                        " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="11" orden="13" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRART                               " atributo="F_ARTICULO_HASTA                        " tabla="IMPDIRART      " campo="ARTHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="ZZZZZZZZZZZZZ                                                                                                                                                                                                                                                 " obligatorio="false" admitebusqueda="408" etiqueta="Artículo                                                                                                                                                        " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="11" orden="14" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRART                               " atributo="F_PROVEEDOR_DESDE                       " tabla="IMPDIRART      " campo="PRODESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="410" etiqueta="Proveedor                                                                                                                                                       " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="13" orden="15" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRART                               " atributo="F_PROVEEDOR_HASTA                       " tabla="IMPDIRART      " campo="PROHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="5" decimales="0" valorsugerido="ZZZZZ                                                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="412" etiqueta="Proveedor                                                                                                                                                       " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="13" orden="16" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRART                               " atributo="F_TEMPORADA_DESDE                       " tabla="IMPDIRART      " campo="TEMDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="414" etiqueta="Temporada                                                                                                                                                       " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="14" orden="17" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRART                               " atributo="F_TEMPORADA_HASTA                       " tabla="IMPDIRART      " campo="TEMHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="5" decimales="0" valorsugerido="ZZZZZ                                                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="416" etiqueta="Temporada                                                                                                                                                       " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="14" orden="18" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRART                               " atributo="F_ANIO_DESDE                            " tabla="IMPDIRART      " campo="ANIDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="418" etiqueta="Año                                                                                                                                                             " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="15" orden="19" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRART                               " atributo="F_ANIO_HASTA                            " tabla="IMPDIRART      " campo="ANIHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="2" decimales="0" valorsugerido="99                                                                                                                                                                                                                                                            " obligatorio="false" admitebusqueda="420" etiqueta="Año                                                                                                                                                             " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="15" orden="20" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRART                               " atributo="F_FAMILIA_DESDE                         " tabla="IMPDIRART      " campo="FAMDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="422" etiqueta="Familia                                                                                                                                                         " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="16" orden="21" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRART                               " atributo="F_FAMILIA_HASTA                         " tabla="IMPDIRART      " campo="FAMHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="5" decimales="0" valorsugerido="ZZZZZ                                                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="424" etiqueta="Familia                                                                                                                                                         " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="16" orden="22" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRART                               " atributo="F_MATERIAL_DESDE                        " tabla="IMPDIRART      " campo="MATDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="426" etiqueta="Material                                                                                                                                                        " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="17" orden="23" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRART                               " atributo="F_MATERIAL_HASTA                        " tabla="IMPDIRART      " campo="MATHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="5" decimales="0" valorsugerido="ZZZZZ                                                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="428" etiqueta="Material                                                                                                                                                        " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="17" orden="24" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRART                               " atributo="F_LINEA_DESDE                           " tabla="IMPDIRART      " campo="LINDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="430" etiqueta="Línea                                                                                                                                                           " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="18" orden="25" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRART                               " atributo="F_LINEA_HASTA                           " tabla="IMPDIRART      " campo="LINHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="5" decimales="0" valorsugerido="ZZZZZ                                                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="432" etiqueta="Línea                                                                                                                                                           " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="18" orden="26" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRART                               " atributo="F_GRUPO_DESDE                           " tabla="IMPDIRART      " campo="GRUDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="434" etiqueta="Grupo                                                                                                                                                           " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="19" orden="27" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRART                               " atributo="F_GRUPO_HASTA                           " tabla="IMPDIRART      " campo="GRUHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="5" decimales="0" valorsugerido="ZZZZZ                                                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="436" etiqueta="Grupo                                                                                                                                                           " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="19" orden="28" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRART                               " atributo="F_CATEGORIA_DESDE                       " tabla="IMPDIRART      " campo="CATDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="438" etiqueta="Categoria                                                                                                                                                       " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="20" orden="29" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRART                               " atributo="F_CATEGORIA_HASTA                       " tabla="IMPDIRART      " campo="CATHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="5" decimales="0" valorsugerido="ZZZZZ                                                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="440" etiqueta="Categoria                                                                                                                                                       " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="20" orden="30" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRART                               " atributo="F_CLASIFICACION_DESDE                   " tabla="IMPDIRART      " campo="CLADESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="442" etiqueta="Clasificación                                                                                                                                                   " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="21" orden="31" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRART                               " atributo="F_CLASIFICACION_HASTA                   " tabla="IMPDIRART      " campo="CLAHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="5" decimales="0" valorsugerido="ZZZZZ                                                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="444" etiqueta="Clasificación                                                                                                                                                   " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="21" orden="32" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRART                               " atributo="F_TIPO_DESDE                            " tabla="IMPDIRART      " campo="TIPDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="446" etiqueta="Tipo                                                                                                                                                            " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="22" orden="33" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRART                               " atributo="F_TIPO_HASTA                            " tabla="IMPDIRART      " campo="TIPHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="5" decimales="0" valorsugerido="ZZZZZ                                                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="448" etiqueta="Tipo                                                                                                                                                            " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="22" orden="34" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRART                               " atributo="CONDICIONIVAVENTAS                      " tabla="IMPDIRART      " campo="ARTCONIVA " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="450" etiqueta="I.V.A. ventas                                                                                                                                                   " dominio="COMBOF_CONDICIONIVA           " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="23" orden="35" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRART                               " atributo="F_IVAV_DESDE                            " tabla="IMPDIRART      " campo="IVVDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="452" etiqueta="Porcentaje                                                                                                                                                      " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="24" orden="36" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRART                               " atributo="F_IVAV_HASTA                            " tabla="IMPDIRART      " campo="IVVHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="5" decimales="0" valorsugerido="99.99                                                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="454" etiqueta="Porcentaje                                                                                                                                                      " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="24" orden="37" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRART                               " atributo="CONDICIONIVACOMPRAS                     " tabla="IMPDIRART      " campo="ARTIVA    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="456" etiqueta="I.V.A. compras                                                                                                                                                  " dominio="COMBOF_CONDICIONIVA           " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="25" orden="38" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRART                               " atributo="F_IVAC_DESDE                            " tabla="IMPDIRART      " campo="IVCDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="458" etiqueta="Porcentaje                                                                                                                                                      " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="26" orden="39" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRART                               " atributo="F_IVAC_HASTA                            " tabla="IMPDIRART      " campo="IVCHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="5" decimales="0" valorsugerido="99.99                                                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="460" etiqueta="Porcentaje                                                                                                                                                      " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="26" orden="40" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRART                               " atributo="F_IMPI_DESDE                            " tabla="IMPDIRART      " campo="IVCDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="462" etiqueta="Impuesto interno                                                                                                                                                " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="27" orden="41" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRART                               " atributo="F_IMPI_HASTA                            " tabla="IMPDIRART      " campo="IVCHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="5" decimales="0" valorsugerido="99.99                                                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="464" etiqueta="Impuesto interno                                                                                                                                                " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="27" orden="42" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRART                               " atributo="TIPODEASIENTO                           " tabla="IMPDIRART      " campo="TIPOASI   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="6" etiqueta="Imputación por tipo de asiento                                                                                                                                  " dominio="COMBOTIPODEASIENTO            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="28" orden="45" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRART                               " atributo="OBSERVACION                             " tabla="IMPDIRART      " campo="OBS       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="466" etiqueta="Observaciones                                                                                                                                                   " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="12" orden="90" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PLANDECUENTAS                           " atributo="DESCRIPCION                             " tabla="PLANCUENTA     " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="401" etiqueta="Detalle Cue.                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join PLANCUENTA On IMPDIRART.PCUENTA = PLANCUENTA.ctacodigo And  PLANCUENTA.CTACODIGO != ''                                                                                                                                                             " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISTRIBUCIONCENTRODECOSTO               " atributo="DESCRIPCION                             " tabla="DCCOSTO        " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="150" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="403" etiqueta="Detalle Dis.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join DCCOSTO On IMPDIRART.DISCCOS = DCCOSTO.Codigo And  DCCOSTO.CODIGO != ''                                                                                                                                                                            " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CENTRODECOSTO                           " atributo="DESCRIPCION                             " tabla="CCOSTO         " campo="COSDES    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="150" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="405" etiqueta="Detalle Cen.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CCOSTO On IMPDIRART.CCOSTO = CCOSTO.COSCOD And  CCOSTO.COSCOD != ''                                                                                                                                                                                " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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