
define class Din_EntidadIMPDIRCCAAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_IMPDIRCCA'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = []
	cExpresionCCPorCampos = []
	cTagClaveCandidata = ''
	cTagClavePk = '_IDXPK'
	cTablaPrincipal = 'IMPDIRCCA'
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
			local  lxImpdirccaFmodifw, lxImpdirccaFecimpo, lxImpdirccaFaltafw, lxImpdirccaFecexpo, lxImpdirccaFectrans, lxImpdirccaTimestamp, lxImpdirccaHoraexpo, lxImpdirccaHaltafw, lxImpdirccaBdaltafw, lxImpdirccaEsttrans, lxImpdirccaBdmodifw, lxImpdirccaHoraimpo, lxImpdirccaHmodifw, lxImpdirccaSaltafw, lxImpdirccaUmodifw, lxImpdirccaZadsfw, lxImpdirccaValtafw, lxImpdirccaUaltafw, lxImpdirccaVmodifw, lxImpdirccaSmodifw, lxImpdirccaComp, lxImpdirccaNumero, lxImpdirccaDescripcio, lxImpdirccaCcosto, lxImpdirccaDccosto, lxImpdirccaImportanci, lxImpdirccaArtdesde, lxImpdirccaArthasta, lxImpdirccaProdesde, lxImpdirccaProhasta, lxImpdirccaTemdesde, lxImpdirccaTemhasta, lxImpdirccaAnidesde, lxImpdirccaAnihasta, lxImpdirccaFamdesde, lxImpdirccaFamhasta, lxImpdirccaMatdesde, lxImpdirccaMathasta, lxImpdirccaLindesde, lxImpdirccaLinhasta, lxImpdirccaGrudesde, lxImpdirccaGruhasta, lxImpdirccaCatdesde, lxImpdirccaCathasta, lxImpdirccaCladesde, lxImpdirccaClahasta, lxImpdirccaTipdesde, lxImpdirccaTiphasta, lxImpdirccaArtconiva, lxImpdirccaIvvdesde, lxImpdirccaIvvhasta, lxImpdirccaArtiva, lxImpdirccaIvcdesde, lxImpdirccaIvchasta, lxImpdirccaImpdesde, lxImpdirccaImphasta, lxImpdirccaTipoasi, lxImpdirccaObs
				lxImpdirccaFmodifw =  .Fechamodificacionfw			lxImpdirccaFecimpo =  .Fechaimpo			lxImpdirccaFaltafw =  .Fechaaltafw			lxImpdirccaFecexpo =  .Fechaexpo			lxImpdirccaFectrans =  .Fechatransferencia			lxImpdirccaTimestamp = goLibrerias.ObtenerTimestamp()			lxImpdirccaHoraexpo =  .Horaexpo			lxImpdirccaHaltafw =  .Horaaltafw			lxImpdirccaBdaltafw =  .Basededatosaltafw			lxImpdirccaEsttrans =  .Estadotransferencia			lxImpdirccaBdmodifw =  .Basededatosmodificacionfw			lxImpdirccaHoraimpo =  .Horaimpo			lxImpdirccaHmodifw =  .Horamodificacionfw			lxImpdirccaSaltafw =  .Seriealtafw			lxImpdirccaUmodifw =  .Usuariomodificacionfw			lxImpdirccaZadsfw =  .Zadsfw			lxImpdirccaValtafw =  .Versionaltafw			lxImpdirccaUaltafw =  .Usuarioaltafw			lxImpdirccaVmodifw =  .Versionmodificacionfw			lxImpdirccaSmodifw =  .Seriemodificacionfw			lxImpdirccaComp =  .Comportamiento			lxImpdirccaNumero =  .Numero			lxImpdirccaDescripcio =  .Descripcion			lxImpdirccaCcosto =  upper( .CentroDeCosto_PK ) 			lxImpdirccaDccosto =  upper( .DistribucionPorCentroDeCosto_PK ) 			lxImpdirccaImportanci =  .Importancia			lxImpdirccaArtdesde =  .F_articulo_desde			lxImpdirccaArthasta =  .F_articulo_hasta			lxImpdirccaProdesde =  .F_proveedor_desde			lxImpdirccaProhasta =  .F_proveedor_hasta			lxImpdirccaTemdesde =  .F_temporada_desde			lxImpdirccaTemhasta =  .F_temporada_hasta			lxImpdirccaAnidesde =  .F_anio_desde			lxImpdirccaAnihasta =  .F_anio_hasta			lxImpdirccaFamdesde =  .F_familia_desde			lxImpdirccaFamhasta =  .F_familia_hasta			lxImpdirccaMatdesde =  .F_material_desde			lxImpdirccaMathasta =  .F_material_hasta			lxImpdirccaLindesde =  .F_linea_desde			lxImpdirccaLinhasta =  .F_linea_hasta			lxImpdirccaGrudesde =  .F_grupo_desde			lxImpdirccaGruhasta =  .F_grupo_hasta			lxImpdirccaCatdesde =  .F_categoria_desde			lxImpdirccaCathasta =  .F_categoria_hasta			lxImpdirccaCladesde =  .F_clasificacion_desde			lxImpdirccaClahasta =  .F_clasificacion_hasta			lxImpdirccaTipdesde =  .F_tipo_desde			lxImpdirccaTiphasta =  .F_tipo_hasta			lxImpdirccaArtconiva =  .Condicionivaventas			lxImpdirccaIvvdesde =  .F_ivav_desde			lxImpdirccaIvvhasta =  .F_ivav_hasta			lxImpdirccaArtiva =  .Condicionivacompras			lxImpdirccaIvcdesde =  .F_ivac_desde			lxImpdirccaIvchasta =  .F_ivac_hasta			lxImpdirccaImpdesde =  .F_impi_desde			lxImpdirccaImphasta =  .F_impi_hasta			lxImpdirccaTipoasi =  .Tipodeasiento			lxImpdirccaObs =  .Observacion
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxImpdirccaNumero = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.IMPDIRCCA ( "Fmodifw","Fecimpo","Faltafw","Fecexpo","Fectrans","Timestamp","Horaexpo","Haltafw","Bdaltafw","Esttrans","Bdmodifw","Horaimpo","Hmodifw","Saltafw","Umodifw","Zadsfw","Valtafw","Ualtafw","Vmodifw","Smodifw","Comp","Numero","Descripcio","Ccosto","Dccosto","Importanci","Artdesde","Arthasta","Prodesde","Prohasta","Temdesde","Temhasta","Anidesde","Anihasta","Famdesde","Famhasta","Matdesde","Mathasta","Lindesde","Linhasta","Grudesde","Gruhasta","Catdesde","Cathasta","Cladesde","Clahasta","Tipdesde","Tiphasta","Artconiva","Ivvdesde","Ivvhasta","Artiva","Ivcdesde","Ivchasta","Impdesde","Imphasta","Tipoasi","Obs" ) values ( <<"'" + this.ConvertirDateSql( lxImpdirccaFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxImpdirccaFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxImpdirccaFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxImpdirccaFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxImpdirccaFectrans ) + "'" >>, <<lxImpdirccaTimestamp >>, <<"'" + this.FormatearTextoSql( lxImpdirccaHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirccaHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirccaBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirccaEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirccaBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirccaHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirccaHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirccaSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirccaUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirccaZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirccaValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirccaUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirccaVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirccaSmodifw ) + "'" >>, <<lxImpdirccaComp >>, <<lxImpdirccaNumero >>, <<"'" + this.FormatearTextoSql( lxImpdirccaDescripcio ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirccaCcosto ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirccaDccosto ) + "'" >>, <<lxImpdirccaImportanci >>, <<"'" + this.FormatearTextoSql( lxImpdirccaArtdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirccaArthasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirccaProdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirccaProhasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirccaTemdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirccaTemhasta ) + "'" >>, <<lxImpdirccaAnidesde >>, <<lxImpdirccaAnihasta >>, <<"'" + this.FormatearTextoSql( lxImpdirccaFamdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirccaFamhasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirccaMatdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirccaMathasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirccaLindesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirccaLinhasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirccaGrudesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirccaGruhasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirccaCatdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirccaCathasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirccaCladesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirccaClahasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirccaTipdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirccaTiphasta ) + "'" >>, <<lxImpdirccaArtconiva >>, <<lxImpdirccaIvvdesde >>, <<lxImpdirccaIvvhasta >>, <<lxImpdirccaArtiva >>, <<lxImpdirccaIvcdesde >>, <<lxImpdirccaIvchasta >>, <<lxImpdirccaImpdesde >>, <<lxImpdirccaImphasta >>, <<lxImpdirccaTipoasi >>, <<"'" + this.FormatearTextoSql( lxImpdirccaObs ) + "'" >> )
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
		this.oEntidad.Timestamp = lxImpdirccaTimestamp
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
			local  lxImpdirccaFmodifw, lxImpdirccaFecimpo, lxImpdirccaFaltafw, lxImpdirccaFecexpo, lxImpdirccaFectrans, lxImpdirccaTimestamp, lxImpdirccaHoraexpo, lxImpdirccaHaltafw, lxImpdirccaBdaltafw, lxImpdirccaEsttrans, lxImpdirccaBdmodifw, lxImpdirccaHoraimpo, lxImpdirccaHmodifw, lxImpdirccaSaltafw, lxImpdirccaUmodifw, lxImpdirccaZadsfw, lxImpdirccaValtafw, lxImpdirccaUaltafw, lxImpdirccaVmodifw, lxImpdirccaSmodifw, lxImpdirccaComp, lxImpdirccaNumero, lxImpdirccaDescripcio, lxImpdirccaCcosto, lxImpdirccaDccosto, lxImpdirccaImportanci, lxImpdirccaArtdesde, lxImpdirccaArthasta, lxImpdirccaProdesde, lxImpdirccaProhasta, lxImpdirccaTemdesde, lxImpdirccaTemhasta, lxImpdirccaAnidesde, lxImpdirccaAnihasta, lxImpdirccaFamdesde, lxImpdirccaFamhasta, lxImpdirccaMatdesde, lxImpdirccaMathasta, lxImpdirccaLindesde, lxImpdirccaLinhasta, lxImpdirccaGrudesde, lxImpdirccaGruhasta, lxImpdirccaCatdesde, lxImpdirccaCathasta, lxImpdirccaCladesde, lxImpdirccaClahasta, lxImpdirccaTipdesde, lxImpdirccaTiphasta, lxImpdirccaArtconiva, lxImpdirccaIvvdesde, lxImpdirccaIvvhasta, lxImpdirccaArtiva, lxImpdirccaIvcdesde, lxImpdirccaIvchasta, lxImpdirccaImpdesde, lxImpdirccaImphasta, lxImpdirccaTipoasi, lxImpdirccaObs
				lxImpdirccaFmodifw =  .Fechamodificacionfw			lxImpdirccaFecimpo =  .Fechaimpo			lxImpdirccaFaltafw =  .Fechaaltafw			lxImpdirccaFecexpo =  .Fechaexpo			lxImpdirccaFectrans =  .Fechatransferencia			lxImpdirccaTimestamp = goLibrerias.ObtenerTimestamp()			lxImpdirccaHoraexpo =  .Horaexpo			lxImpdirccaHaltafw =  .Horaaltafw			lxImpdirccaBdaltafw =  .Basededatosaltafw			lxImpdirccaEsttrans =  .Estadotransferencia			lxImpdirccaBdmodifw =  .Basededatosmodificacionfw			lxImpdirccaHoraimpo =  .Horaimpo			lxImpdirccaHmodifw =  .Horamodificacionfw			lxImpdirccaSaltafw =  .Seriealtafw			lxImpdirccaUmodifw =  .Usuariomodificacionfw			lxImpdirccaZadsfw =  .Zadsfw			lxImpdirccaValtafw =  .Versionaltafw			lxImpdirccaUaltafw =  .Usuarioaltafw			lxImpdirccaVmodifw =  .Versionmodificacionfw			lxImpdirccaSmodifw =  .Seriemodificacionfw			lxImpdirccaComp =  .Comportamiento			lxImpdirccaNumero =  .Numero			lxImpdirccaDescripcio =  .Descripcion			lxImpdirccaCcosto =  upper( .CentroDeCosto_PK ) 			lxImpdirccaDccosto =  upper( .DistribucionPorCentroDeCosto_PK ) 			lxImpdirccaImportanci =  .Importancia			lxImpdirccaArtdesde =  .F_articulo_desde			lxImpdirccaArthasta =  .F_articulo_hasta			lxImpdirccaProdesde =  .F_proveedor_desde			lxImpdirccaProhasta =  .F_proveedor_hasta			lxImpdirccaTemdesde =  .F_temporada_desde			lxImpdirccaTemhasta =  .F_temporada_hasta			lxImpdirccaAnidesde =  .F_anio_desde			lxImpdirccaAnihasta =  .F_anio_hasta			lxImpdirccaFamdesde =  .F_familia_desde			lxImpdirccaFamhasta =  .F_familia_hasta			lxImpdirccaMatdesde =  .F_material_desde			lxImpdirccaMathasta =  .F_material_hasta			lxImpdirccaLindesde =  .F_linea_desde			lxImpdirccaLinhasta =  .F_linea_hasta			lxImpdirccaGrudesde =  .F_grupo_desde			lxImpdirccaGruhasta =  .F_grupo_hasta			lxImpdirccaCatdesde =  .F_categoria_desde			lxImpdirccaCathasta =  .F_categoria_hasta			lxImpdirccaCladesde =  .F_clasificacion_desde			lxImpdirccaClahasta =  .F_clasificacion_hasta			lxImpdirccaTipdesde =  .F_tipo_desde			lxImpdirccaTiphasta =  .F_tipo_hasta			lxImpdirccaArtconiva =  .Condicionivaventas			lxImpdirccaIvvdesde =  .F_ivav_desde			lxImpdirccaIvvhasta =  .F_ivav_hasta			lxImpdirccaArtiva =  .Condicionivacompras			lxImpdirccaIvcdesde =  .F_ivac_desde			lxImpdirccaIvchasta =  .F_ivac_hasta			lxImpdirccaImpdesde =  .F_impi_desde			lxImpdirccaImphasta =  .F_impi_hasta			lxImpdirccaTipoasi =  .Tipodeasiento			lxImpdirccaObs =  .Observacion
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
				update ZooLogic.IMPDIRCCA set "Fmodifw" = <<"'" + this.ConvertirDateSql( lxImpdirccaFmodifw ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxImpdirccaFecimpo ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxImpdirccaFaltafw ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxImpdirccaFecexpo ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxImpdirccaFectrans ) + "'">>,"Timestamp" = <<lxImpdirccaTimestamp>>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxImpdirccaHoraexpo ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxImpdirccaHaltafw ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxImpdirccaBdaltafw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxImpdirccaEsttrans ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxImpdirccaBdmodifw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxImpdirccaHoraimpo ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxImpdirccaHmodifw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxImpdirccaSaltafw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxImpdirccaUmodifw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxImpdirccaZadsfw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxImpdirccaValtafw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxImpdirccaUaltafw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxImpdirccaVmodifw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxImpdirccaSmodifw ) + "'">>,"Comp" = <<lxImpdirccaComp>>,"Numero" = <<lxImpdirccaNumero>>,"Descripcio" = <<"'" + this.FormatearTextoSql( lxImpdirccaDescripcio ) + "'">>,"Ccosto" = <<"'" + this.FormatearTextoSql( lxImpdirccaCcosto ) + "'">>,"Dccosto" = <<"'" + this.FormatearTextoSql( lxImpdirccaDccosto ) + "'">>,"Importanci" = <<lxImpdirccaImportanci>>,"Artdesde" = <<"'" + this.FormatearTextoSql( lxImpdirccaArtdesde ) + "'">>,"Arthasta" = <<"'" + this.FormatearTextoSql( lxImpdirccaArthasta ) + "'">>,"Prodesde" = <<"'" + this.FormatearTextoSql( lxImpdirccaProdesde ) + "'">>,"Prohasta" = <<"'" + this.FormatearTextoSql( lxImpdirccaProhasta ) + "'">>,"Temdesde" = <<"'" + this.FormatearTextoSql( lxImpdirccaTemdesde ) + "'">>,"Temhasta" = <<"'" + this.FormatearTextoSql( lxImpdirccaTemhasta ) + "'">>,"Anidesde" = <<lxImpdirccaAnidesde>>,"Anihasta" = <<lxImpdirccaAnihasta>>,"Famdesde" = <<"'" + this.FormatearTextoSql( lxImpdirccaFamdesde ) + "'">>,"Famhasta" = <<"'" + this.FormatearTextoSql( lxImpdirccaFamhasta ) + "'">>,"Matdesde" = <<"'" + this.FormatearTextoSql( lxImpdirccaMatdesde ) + "'">>,"Mathasta" = <<"'" + this.FormatearTextoSql( lxImpdirccaMathasta ) + "'">>,"Lindesde" = <<"'" + this.FormatearTextoSql( lxImpdirccaLindesde ) + "'">>,"Linhasta" = <<"'" + this.FormatearTextoSql( lxImpdirccaLinhasta ) + "'">>,"Grudesde" = <<"'" + this.FormatearTextoSql( lxImpdirccaGrudesde ) + "'">>,"Gruhasta" = <<"'" + this.FormatearTextoSql( lxImpdirccaGruhasta ) + "'">>,"Catdesde" = <<"'" + this.FormatearTextoSql( lxImpdirccaCatdesde ) + "'">>,"Cathasta" = <<"'" + this.FormatearTextoSql( lxImpdirccaCathasta ) + "'">>,"Cladesde" = <<"'" + this.FormatearTextoSql( lxImpdirccaCladesde ) + "'">>,"Clahasta" = <<"'" + this.FormatearTextoSql( lxImpdirccaClahasta ) + "'">>,"Tipdesde" = <<"'" + this.FormatearTextoSql( lxImpdirccaTipdesde ) + "'">>,"Tiphasta" = <<"'" + this.FormatearTextoSql( lxImpdirccaTiphasta ) + "'">>,"Artconiva" = <<lxImpdirccaArtconiva>>,"Ivvdesde" = <<lxImpdirccaIvvdesde>>,"Ivvhasta" = <<lxImpdirccaIvvhasta>>,"Artiva" = <<lxImpdirccaArtiva>>,"Ivcdesde" = <<lxImpdirccaIvcdesde>>,"Ivchasta" = <<lxImpdirccaIvchasta>>,"Impdesde" = <<lxImpdirccaImpdesde>>,"Imphasta" = <<lxImpdirccaImphasta>>,"Tipoasi" = <<lxImpdirccaTipoasi>>,"Obs" = <<"'" + this.FormatearTextoSql( lxImpdirccaObs ) + "'">> where "Numero" = <<lxImpdirccaNumero>> and  IMPDIRCCA.NUMERO != 0 << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
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
		this.oEntidad.Timestamp = lxImpdirccaTimestamp
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 NUMERO from ZooLogic.IMPDIRCCA where " + this.ConvertirFuncionesSql( " IMPDIRCCA.NUMERO != 0" ) )
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
			Local lxImpdirccaNumero
			lxImpdirccaNumero = .Numero

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Timestamp" as "Timestamp", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Vmodifw" as "Versionmodificacionfw", "Smodifw" as "Seriemodificacionfw", "Comp" as "Comportamiento", "Numero" as "Numero", "Descripcio" as "Descripcion", "Ccosto" as "Centrodecosto", "Dccosto" as "Distribucionporcentrodecosto", "Importanci" as "Importancia", "Artdesde" as "F_articulo_desde", "Arthasta" as "F_articulo_hasta", "Prodesde" as "F_proveedor_desde", "Prohasta" as "F_proveedor_hasta", "Temdesde" as "F_temporada_desde", "Temhasta" as "F_temporada_hasta", "Anidesde" as "F_anio_desde", "Anihasta" as "F_anio_hasta", "Famdesde" as "F_familia_desde", "Famhasta" as "F_familia_hasta", "Matdesde" as "F_material_desde", "Mathasta" as "F_material_hasta", "Lindesde" as "F_linea_desde", "Linhasta" as "F_linea_hasta", "Grudesde" as "F_grupo_desde", "Gruhasta" as "F_grupo_hasta", "Catdesde" as "F_categoria_desde", "Cathasta" as "F_categoria_hasta", "Cladesde" as "F_clasificacion_desde", "Clahasta" as "F_clasificacion_hasta", "Tipdesde" as "F_tipo_desde", "Tiphasta" as "F_tipo_hasta", "Artconiva" as "Condicionivaventas", "Ivvdesde" as "F_ivav_desde", "Ivvhasta" as "F_ivav_hasta", "Artiva" as "Condicionivacompras", "Ivcdesde" as "F_ivac_desde", "Ivchasta" as "F_ivac_hasta", "Impdesde" as "F_impi_desde", "Imphasta" as "F_impi_hasta", "Tipoasi" as "Tipodeasiento", "Obs" as "Observacion" from ZooLogic.IMPDIRCCA where "Numero" = <<lxImpdirccaNumero>> and  IMPDIRCCA.NUMERO != 0
			endtext
			use in select('c_IMPDIRCCA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_IMPDIRCCA', set( 'Datasession' ) )

			if reccount( 'c_IMPDIRCCA' ) = 0
				llRetorno = .f.
			else
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxImpdirccaNumero as Variant
		llRetorno = .t.
		lxImpdirccaNumero = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.IMPDIRCCA where "Numero" = <<lxImpdirccaNumero>> and  IMPDIRCCA.NUMERO != 0
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
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Timestamp" as "Timestamp", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Vmodifw" as "Versionmodificacionfw", "Smodifw" as "Seriemodificacionfw", "Comp" as "Comportamiento", "Numero" as "Numero", "Descripcio" as "Descripcion", "Ccosto" as "Centrodecosto", "Dccosto" as "Distribucionporcentrodecosto", "Importanci" as "Importancia", "Artdesde" as "F_articulo_desde", "Arthasta" as "F_articulo_hasta", "Prodesde" as "F_proveedor_desde", "Prohasta" as "F_proveedor_hasta", "Temdesde" as "F_temporada_desde", "Temhasta" as "F_temporada_hasta", "Anidesde" as "F_anio_desde", "Anihasta" as "F_anio_hasta", "Famdesde" as "F_familia_desde", "Famhasta" as "F_familia_hasta", "Matdesde" as "F_material_desde", "Mathasta" as "F_material_hasta", "Lindesde" as "F_linea_desde", "Linhasta" as "F_linea_hasta", "Grudesde" as "F_grupo_desde", "Gruhasta" as "F_grupo_hasta", "Catdesde" as "F_categoria_desde", "Cathasta" as "F_categoria_hasta", "Cladesde" as "F_clasificacion_desde", "Clahasta" as "F_clasificacion_hasta", "Tipdesde" as "F_tipo_desde", "Tiphasta" as "F_tipo_hasta", "Artconiva" as "Condicionivaventas", "Ivvdesde" as "F_ivav_desde", "Ivvhasta" as "F_ivav_hasta", "Artiva" as "Condicionivacompras", "Ivcdesde" as "F_ivac_desde", "Ivchasta" as "F_ivac_hasta", "Impdesde" as "F_impi_desde", "Imphasta" as "F_impi_hasta", "Tipoasi" as "Tipodeasiento", "Obs" as "Observacion" from ZooLogic.IMPDIRCCA where  IMPDIRCCA.NUMERO != 0 order by NUMERO
			endtext
			use in select('c_IMPDIRCCA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_IMPDIRCCA', set( 'Datasession' ) )
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
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Timestamp" as "Timestamp", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Vmodifw" as "Versionmodificacionfw", "Smodifw" as "Seriemodificacionfw", "Comp" as "Comportamiento", "Numero" as "Numero", "Descripcio" as "Descripcion", "Ccosto" as "Centrodecosto", "Dccosto" as "Distribucionporcentrodecosto", "Importanci" as "Importancia", "Artdesde" as "F_articulo_desde", "Arthasta" as "F_articulo_hasta", "Prodesde" as "F_proveedor_desde", "Prohasta" as "F_proveedor_hasta", "Temdesde" as "F_temporada_desde", "Temhasta" as "F_temporada_hasta", "Anidesde" as "F_anio_desde", "Anihasta" as "F_anio_hasta", "Famdesde" as "F_familia_desde", "Famhasta" as "F_familia_hasta", "Matdesde" as "F_material_desde", "Mathasta" as "F_material_hasta", "Lindesde" as "F_linea_desde", "Linhasta" as "F_linea_hasta", "Grudesde" as "F_grupo_desde", "Gruhasta" as "F_grupo_hasta", "Catdesde" as "F_categoria_desde", "Cathasta" as "F_categoria_hasta", "Cladesde" as "F_clasificacion_desde", "Clahasta" as "F_clasificacion_hasta", "Tipdesde" as "F_tipo_desde", "Tiphasta" as "F_tipo_hasta", "Artconiva" as "Condicionivaventas", "Ivvdesde" as "F_ivav_desde", "Ivvhasta" as "F_ivav_hasta", "Artiva" as "Condicionivacompras", "Ivcdesde" as "F_ivac_desde", "Ivchasta" as "F_ivac_hasta", "Impdesde" as "F_impi_desde", "Imphasta" as "F_impi_hasta", "Tipoasi" as "Tipodeasiento", "Obs" as "Observacion" from ZooLogic.IMPDIRCCA where  str( NUMERO, 8, 0) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  IMPDIRCCA.NUMERO != 0 order by NUMERO
			endtext
			use in select('c_IMPDIRCCA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_IMPDIRCCA', set( 'Datasession' ) )
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
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Timestamp" as "Timestamp", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Vmodifw" as "Versionmodificacionfw", "Smodifw" as "Seriemodificacionfw", "Comp" as "Comportamiento", "Numero" as "Numero", "Descripcio" as "Descripcion", "Ccosto" as "Centrodecosto", "Dccosto" as "Distribucionporcentrodecosto", "Importanci" as "Importancia", "Artdesde" as "F_articulo_desde", "Arthasta" as "F_articulo_hasta", "Prodesde" as "F_proveedor_desde", "Prohasta" as "F_proveedor_hasta", "Temdesde" as "F_temporada_desde", "Temhasta" as "F_temporada_hasta", "Anidesde" as "F_anio_desde", "Anihasta" as "F_anio_hasta", "Famdesde" as "F_familia_desde", "Famhasta" as "F_familia_hasta", "Matdesde" as "F_material_desde", "Mathasta" as "F_material_hasta", "Lindesde" as "F_linea_desde", "Linhasta" as "F_linea_hasta", "Grudesde" as "F_grupo_desde", "Gruhasta" as "F_grupo_hasta", "Catdesde" as "F_categoria_desde", "Cathasta" as "F_categoria_hasta", "Cladesde" as "F_clasificacion_desde", "Clahasta" as "F_clasificacion_hasta", "Tipdesde" as "F_tipo_desde", "Tiphasta" as "F_tipo_hasta", "Artconiva" as "Condicionivaventas", "Ivvdesde" as "F_ivav_desde", "Ivvhasta" as "F_ivav_hasta", "Artiva" as "Condicionivacompras", "Ivcdesde" as "F_ivac_desde", "Ivchasta" as "F_ivac_hasta", "Impdesde" as "F_impi_desde", "Imphasta" as "F_impi_hasta", "Tipoasi" as "Tipodeasiento", "Obs" as "Observacion" from ZooLogic.IMPDIRCCA where  str( NUMERO, 8, 0) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  IMPDIRCCA.NUMERO != 0 order by NUMERO desc
			endtext
			use in select('c_IMPDIRCCA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_IMPDIRCCA', set( 'Datasession' ) )
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
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Timestamp" as "Timestamp", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Vmodifw" as "Versionmodificacionfw", "Smodifw" as "Seriemodificacionfw", "Comp" as "Comportamiento", "Numero" as "Numero", "Descripcio" as "Descripcion", "Ccosto" as "Centrodecosto", "Dccosto" as "Distribucionporcentrodecosto", "Importanci" as "Importancia", "Artdesde" as "F_articulo_desde", "Arthasta" as "F_articulo_hasta", "Prodesde" as "F_proveedor_desde", "Prohasta" as "F_proveedor_hasta", "Temdesde" as "F_temporada_desde", "Temhasta" as "F_temporada_hasta", "Anidesde" as "F_anio_desde", "Anihasta" as "F_anio_hasta", "Famdesde" as "F_familia_desde", "Famhasta" as "F_familia_hasta", "Matdesde" as "F_material_desde", "Mathasta" as "F_material_hasta", "Lindesde" as "F_linea_desde", "Linhasta" as "F_linea_hasta", "Grudesde" as "F_grupo_desde", "Gruhasta" as "F_grupo_hasta", "Catdesde" as "F_categoria_desde", "Cathasta" as "F_categoria_hasta", "Cladesde" as "F_clasificacion_desde", "Clahasta" as "F_clasificacion_hasta", "Tipdesde" as "F_tipo_desde", "Tiphasta" as "F_tipo_hasta", "Artconiva" as "Condicionivaventas", "Ivvdesde" as "F_ivav_desde", "Ivvhasta" as "F_ivav_hasta", "Artiva" as "Condicionivacompras", "Ivcdesde" as "F_ivac_desde", "Ivchasta" as "F_ivac_hasta", "Impdesde" as "F_impi_desde", "Imphasta" as "F_impi_hasta", "Tipoasi" as "Tipodeasiento", "Obs" as "Observacion" from ZooLogic.IMPDIRCCA where  IMPDIRCCA.NUMERO != 0 order by NUMERO desc
			endtext
			use in select('c_IMPDIRCCA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_IMPDIRCCA', set( 'Datasession' ) )
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
			lcXml = this.oConexion.EjecutarSql( "select Fmodifw,Fecimpo,Faltafw,Fecexpo,Fectrans,Timestamp,Horaexpo,Haltafw,Bdaltafw,Esttrans,Bdmodi" + ;
"fw,Horaimpo,Hmodifw,Saltafw,Umodifw,Zadsfw,Valtafw,Ualtafw,Vmodifw,Smodifw,Comp,Numero,Descripcio,Cc" + ;
"osto,Dccosto,Importanci,Artdesde,Arthasta,Prodesde,Prohasta,Temdesde,Temhasta,Anidesde,Anihasta,Famd" + ;
"esde,Famhasta,Matdesde,Mathasta,Lindesde,Linhasta,Grudesde,Gruhasta,Catdesde,Cathasta,Cladesde,Claha" + ;
"sta,Tipdesde,Tiphasta,Artconiva,Ivvdesde,Ivvhasta,Artiva,Ivcdesde,Ivchasta,Impdesde,Imphasta,Tipoasi" + ;
",Obs" + ;
" from ZooLogic.IMPDIRCCA where  IMPDIRCCA.NUMERO != 0 and " + lcFiltro )
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
			local  lxImpdirccaFmodifw, lxImpdirccaFecimpo, lxImpdirccaFaltafw, lxImpdirccaFecexpo, lxImpdirccaFectrans, lxImpdirccaTimestamp, lxImpdirccaHoraexpo, lxImpdirccaHaltafw, lxImpdirccaBdaltafw, lxImpdirccaEsttrans, lxImpdirccaBdmodifw, lxImpdirccaHoraimpo, lxImpdirccaHmodifw, lxImpdirccaSaltafw, lxImpdirccaUmodifw, lxImpdirccaZadsfw, lxImpdirccaValtafw, lxImpdirccaUaltafw, lxImpdirccaVmodifw, lxImpdirccaSmodifw, lxImpdirccaComp, lxImpdirccaNumero, lxImpdirccaDescripcio, lxImpdirccaCcosto, lxImpdirccaDccosto, lxImpdirccaImportanci, lxImpdirccaArtdesde, lxImpdirccaArthasta, lxImpdirccaProdesde, lxImpdirccaProhasta, lxImpdirccaTemdesde, lxImpdirccaTemhasta, lxImpdirccaAnidesde, lxImpdirccaAnihasta, lxImpdirccaFamdesde, lxImpdirccaFamhasta, lxImpdirccaMatdesde, lxImpdirccaMathasta, lxImpdirccaLindesde, lxImpdirccaLinhasta, lxImpdirccaGrudesde, lxImpdirccaGruhasta, lxImpdirccaCatdesde, lxImpdirccaCathasta, lxImpdirccaCladesde, lxImpdirccaClahasta, lxImpdirccaTipdesde, lxImpdirccaTiphasta, lxImpdirccaArtconiva, lxImpdirccaIvvdesde, lxImpdirccaIvvhasta, lxImpdirccaArtiva, lxImpdirccaIvcdesde, lxImpdirccaIvchasta, lxImpdirccaImpdesde, lxImpdirccaImphasta, lxImpdirccaTipoasi, lxImpdirccaObs
				lxImpdirccaFmodifw = ctod( '  /  /    ' )			lxImpdirccaFecimpo = ctod( '  /  /    ' )			lxImpdirccaFaltafw = ctod( '  /  /    ' )			lxImpdirccaFecexpo = ctod( '  /  /    ' )			lxImpdirccaFectrans = ctod( '  /  /    ' )			lxImpdirccaTimestamp = goLibrerias.ObtenerTimestamp()			lxImpdirccaHoraexpo = []			lxImpdirccaHaltafw = []			lxImpdirccaBdaltafw = []			lxImpdirccaEsttrans = []			lxImpdirccaBdmodifw = []			lxImpdirccaHoraimpo = []			lxImpdirccaHmodifw = []			lxImpdirccaSaltafw = []			lxImpdirccaUmodifw = []			lxImpdirccaZadsfw = []			lxImpdirccaValtafw = []			lxImpdirccaUaltafw = []			lxImpdirccaVmodifw = []			lxImpdirccaSmodifw = []			lxImpdirccaComp = 0			lxImpdirccaNumero = 0			lxImpdirccaDescripcio = []			lxImpdirccaCcosto = []			lxImpdirccaDccosto = []			lxImpdirccaImportanci = 0			lxImpdirccaArtdesde = []			lxImpdirccaArthasta = []			lxImpdirccaProdesde = []			lxImpdirccaProhasta = []			lxImpdirccaTemdesde = []			lxImpdirccaTemhasta = []			lxImpdirccaAnidesde = 0			lxImpdirccaAnihasta = 0			lxImpdirccaFamdesde = []			lxImpdirccaFamhasta = []			lxImpdirccaMatdesde = []			lxImpdirccaMathasta = []			lxImpdirccaLindesde = []			lxImpdirccaLinhasta = []			lxImpdirccaGrudesde = []			lxImpdirccaGruhasta = []			lxImpdirccaCatdesde = []			lxImpdirccaCathasta = []			lxImpdirccaCladesde = []			lxImpdirccaClahasta = []			lxImpdirccaTipdesde = []			lxImpdirccaTiphasta = []			lxImpdirccaArtconiva = 0			lxImpdirccaIvvdesde = 0			lxImpdirccaIvvhasta = 0			lxImpdirccaArtiva = 0			lxImpdirccaIvcdesde = 0			lxImpdirccaIvchasta = 0			lxImpdirccaImpdesde = 0			lxImpdirccaImphasta = 0			lxImpdirccaTipoasi = 0			lxImpdirccaObs = []
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( [delete from ZooLogic.IMPDIRCCA where "NUMERO" = ] + transform( .oEntidad.NUMERO )+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'IMPDIRCCA' + '_' + tcCampo
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
		lcWhere = " Where  IMPDIRCCA.NUMERO != 0"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Timestamp" as "Timestamp", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Vmodifw" as "Versionmodificacionfw", "Smodifw" as "Seriemodificacionfw", "Comp" as "Comportamiento", "Numero" as "Numero", "Descripcio" as "Descripcion", "Ccosto" as "Centrodecosto", "Dccosto" as "Distribucionporcentrodecosto", "Importanci" as "Importancia", "Artdesde" as "F_articulo_desde", "Arthasta" as "F_articulo_hasta", "Prodesde" as "F_proveedor_desde", "Prohasta" as "F_proveedor_hasta", "Temdesde" as "F_temporada_desde", "Temhasta" as "F_temporada_hasta", "Anidesde" as "F_anio_desde", "Anihasta" as "F_anio_hasta", "Famdesde" as "F_familia_desde", "Famhasta" as "F_familia_hasta", "Matdesde" as "F_material_desde", "Mathasta" as "F_material_hasta", "Lindesde" as "F_linea_desde", "Linhasta" as "F_linea_hasta", "Grudesde" as "F_grupo_desde", "Gruhasta" as "F_grupo_hasta", "Catdesde" as "F_categoria_desde", "Cathasta" as "F_categoria_hasta", "Cladesde" as "F_clasificacion_desde", "Clahasta" as "F_clasificacion_hasta", "Tipdesde" as "F_tipo_desde", "Tiphasta" as "F_tipo_hasta", "Artconiva" as "Condicionivaventas", "Ivvdesde" as "F_ivav_desde", "Ivvhasta" as "F_ivav_hasta", "Artiva" as "Condicionivacompras", "Ivcdesde" as "F_ivac_desde", "Ivchasta" as "F_ivac_hasta", "Impdesde" as "F_impi_desde", "Imphasta" as "F_impi_hasta", "Tipoasi" as "Tipodeasiento", "Obs" as "Observacion"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'IMPDIRCCA', '', tnTope )
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
				Case lcAtributo == 'FECHAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECIMPO AS FECHAIMPO'
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'FECHAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECEXPO AS FECHAEXPO'
				Case lcAtributo == 'FECHATRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRANS AS FECHATRANSFERENCIA'
				Case lcAtributo == 'TIMESTAMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIMESTAMP AS TIMESTAMP'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'COMPORTAMIENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COMP AS COMPORTAMIENTO'
				Case lcAtributo == 'NUMERO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NUMERO AS NUMERO'
				Case lcAtributo == 'DESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCRIPCIO AS DESCRIPCION'
				Case lcAtributo == 'CENTRODECOSTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CCOSTO AS CENTRODECOSTO'
				Case lcAtributo == 'DISTRIBUCIONPORCENTRODECOSTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DCCOSTO AS DISTRIBUCIONPORCENTRODECOSTO'
				Case lcAtributo == 'IMPORTANCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IMPORTANCI AS IMPORTANCIA'
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
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IMPDESDE AS F_IMPI_DESDE'
				Case lcAtributo == 'F_IMPI_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IMPHASTA AS F_IMPI_HASTA'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAIMPO'
				lcCampo = 'FECIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEXPO'
				lcCampo = 'FECEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'TIMESTAMP'
				lcCampo = 'TIMESTAMP'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'COMPORTAMIENTO'
				lcCampo = 'COMP'
			Case upper( alltrim( tcAtributo ) ) == 'NUMERO'
				lcCampo = 'NUMERO'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCION'
				lcCampo = 'DESCRIPCIO'
			Case upper( alltrim( tcAtributo ) ) == 'CENTRODECOSTO'
				lcCampo = 'CCOSTO'
			Case upper( alltrim( tcAtributo ) ) == 'DISTRIBUCIONPORCENTRODECOSTO'
				lcCampo = 'DCCOSTO'
			Case upper( alltrim( tcAtributo ) ) == 'IMPORTANCIA'
				lcCampo = 'IMPORTANCI'
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
				lcCampo = 'IMPDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'F_IMPI_HASTA'
				lcCampo = 'IMPHASTA'
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
			local  lxImpdirccaFmodifw, lxImpdirccaFecimpo, lxImpdirccaFaltafw, lxImpdirccaFecexpo, lxImpdirccaFectrans, lxImpdirccaTimestamp, lxImpdirccaHoraexpo, lxImpdirccaHaltafw, lxImpdirccaBdaltafw, lxImpdirccaEsttrans, lxImpdirccaBdmodifw, lxImpdirccaHoraimpo, lxImpdirccaHmodifw, lxImpdirccaSaltafw, lxImpdirccaUmodifw, lxImpdirccaZadsfw, lxImpdirccaValtafw, lxImpdirccaUaltafw, lxImpdirccaVmodifw, lxImpdirccaSmodifw, lxImpdirccaComp, lxImpdirccaNumero, lxImpdirccaDescripcio, lxImpdirccaCcosto, lxImpdirccaDccosto, lxImpdirccaImportanci, lxImpdirccaArtdesde, lxImpdirccaArthasta, lxImpdirccaProdesde, lxImpdirccaProhasta, lxImpdirccaTemdesde, lxImpdirccaTemhasta, lxImpdirccaAnidesde, lxImpdirccaAnihasta, lxImpdirccaFamdesde, lxImpdirccaFamhasta, lxImpdirccaMatdesde, lxImpdirccaMathasta, lxImpdirccaLindesde, lxImpdirccaLinhasta, lxImpdirccaGrudesde, lxImpdirccaGruhasta, lxImpdirccaCatdesde, lxImpdirccaCathasta, lxImpdirccaCladesde, lxImpdirccaClahasta, lxImpdirccaTipdesde, lxImpdirccaTiphasta, lxImpdirccaArtconiva, lxImpdirccaIvvdesde, lxImpdirccaIvvhasta, lxImpdirccaArtiva, lxImpdirccaIvcdesde, lxImpdirccaIvchasta, lxImpdirccaImpdesde, lxImpdirccaImphasta, lxImpdirccaTipoasi, lxImpdirccaObs
				lxImpdirccaFmodifw =  .Fechamodificacionfw			lxImpdirccaFecimpo =  .Fechaimpo			lxImpdirccaFaltafw =  .Fechaaltafw			lxImpdirccaFecexpo =  .Fechaexpo			lxImpdirccaFectrans =  .Fechatransferencia			lxImpdirccaTimestamp = goLibrerias.ObtenerTimestamp()			lxImpdirccaHoraexpo =  .Horaexpo			lxImpdirccaHaltafw =  .Horaaltafw			lxImpdirccaBdaltafw =  .Basededatosaltafw			lxImpdirccaEsttrans =  .Estadotransferencia			lxImpdirccaBdmodifw =  .Basededatosmodificacionfw			lxImpdirccaHoraimpo =  .Horaimpo			lxImpdirccaHmodifw =  .Horamodificacionfw			lxImpdirccaSaltafw =  .Seriealtafw			lxImpdirccaUmodifw =  .Usuariomodificacionfw			lxImpdirccaZadsfw =  .Zadsfw			lxImpdirccaValtafw =  .Versionaltafw			lxImpdirccaUaltafw =  .Usuarioaltafw			lxImpdirccaVmodifw =  .Versionmodificacionfw			lxImpdirccaSmodifw =  .Seriemodificacionfw			lxImpdirccaComp =  .Comportamiento			lxImpdirccaNumero =  .Numero			lxImpdirccaDescripcio =  .Descripcion			lxImpdirccaCcosto =  upper( .CentroDeCosto_PK ) 			lxImpdirccaDccosto =  upper( .DistribucionPorCentroDeCosto_PK ) 			lxImpdirccaImportanci =  .Importancia			lxImpdirccaArtdesde =  .F_articulo_desde			lxImpdirccaArthasta =  .F_articulo_hasta			lxImpdirccaProdesde =  .F_proveedor_desde			lxImpdirccaProhasta =  .F_proveedor_hasta			lxImpdirccaTemdesde =  .F_temporada_desde			lxImpdirccaTemhasta =  .F_temporada_hasta			lxImpdirccaAnidesde =  .F_anio_desde			lxImpdirccaAnihasta =  .F_anio_hasta			lxImpdirccaFamdesde =  .F_familia_desde			lxImpdirccaFamhasta =  .F_familia_hasta			lxImpdirccaMatdesde =  .F_material_desde			lxImpdirccaMathasta =  .F_material_hasta			lxImpdirccaLindesde =  .F_linea_desde			lxImpdirccaLinhasta =  .F_linea_hasta			lxImpdirccaGrudesde =  .F_grupo_desde			lxImpdirccaGruhasta =  .F_grupo_hasta			lxImpdirccaCatdesde =  .F_categoria_desde			lxImpdirccaCathasta =  .F_categoria_hasta			lxImpdirccaCladesde =  .F_clasificacion_desde			lxImpdirccaClahasta =  .F_clasificacion_hasta			lxImpdirccaTipdesde =  .F_tipo_desde			lxImpdirccaTiphasta =  .F_tipo_hasta			lxImpdirccaArtconiva =  .Condicionivaventas			lxImpdirccaIvvdesde =  .F_ivav_desde			lxImpdirccaIvvhasta =  .F_ivav_hasta			lxImpdirccaArtiva =  .Condicionivacompras			lxImpdirccaIvcdesde =  .F_ivac_desde			lxImpdirccaIvchasta =  .F_ivac_hasta			lxImpdirccaImpdesde =  .F_impi_desde			lxImpdirccaImphasta =  .F_impi_hasta			lxImpdirccaTipoasi =  .Tipodeasiento			lxImpdirccaObs =  .Observacion
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.IMPDIRCCA ( "Fmodifw","Fecimpo","Faltafw","Fecexpo","Fectrans","Timestamp","Horaexpo","Haltafw","Bdaltafw","Esttrans","Bdmodifw","Horaimpo","Hmodifw","Saltafw","Umodifw","Zadsfw","Valtafw","Ualtafw","Vmodifw","Smodifw","Comp","Numero","Descripcio","Ccosto","Dccosto","Importanci","Artdesde","Arthasta","Prodesde","Prohasta","Temdesde","Temhasta","Anidesde","Anihasta","Famdesde","Famhasta","Matdesde","Mathasta","Lindesde","Linhasta","Grudesde","Gruhasta","Catdesde","Cathasta","Cladesde","Clahasta","Tipdesde","Tiphasta","Artconiva","Ivvdesde","Ivvhasta","Artiva","Ivcdesde","Ivchasta","Impdesde","Imphasta","Tipoasi","Obs" ) values ( <<"'" + this.ConvertirDateSql( lxImpdirccaFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxImpdirccaFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxImpdirccaFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxImpdirccaFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxImpdirccaFectrans ) + "'" >>, <<lxImpdirccaTimestamp >>, <<"'" + this.FormatearTextoSql( lxImpdirccaHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirccaHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirccaBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirccaEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirccaBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirccaHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirccaHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirccaSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirccaUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirccaZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirccaValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirccaUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirccaVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirccaSmodifw ) + "'" >>, <<lxImpdirccaComp >>, <<lxImpdirccaNumero >>, <<"'" + this.FormatearTextoSql( lxImpdirccaDescripcio ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirccaCcosto ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirccaDccosto ) + "'" >>, <<lxImpdirccaImportanci >>, <<"'" + this.FormatearTextoSql( lxImpdirccaArtdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirccaArthasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirccaProdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirccaProhasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirccaTemdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirccaTemhasta ) + "'" >>, <<lxImpdirccaAnidesde >>, <<lxImpdirccaAnihasta >>, <<"'" + this.FormatearTextoSql( lxImpdirccaFamdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirccaFamhasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirccaMatdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirccaMathasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirccaLindesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirccaLinhasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirccaGrudesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirccaGruhasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirccaCatdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirccaCathasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirccaCladesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirccaClahasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirccaTipdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpdirccaTiphasta ) + "'" >>, <<lxImpdirccaArtconiva >>, <<lxImpdirccaIvvdesde >>, <<lxImpdirccaIvvhasta >>, <<lxImpdirccaArtiva >>, <<lxImpdirccaIvcdesde >>, <<lxImpdirccaIvchasta >>, <<lxImpdirccaImpdesde >>, <<lxImpdirccaImphasta >>, <<lxImpdirccaTipoasi >>, <<"'" + this.FormatearTextoSql( lxImpdirccaObs ) + "'" >> )
		endtext
		loColeccion.cTabla = 'IMPDIRCCA' 
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
			local  lxImpdirccaFmodifw, lxImpdirccaFecimpo, lxImpdirccaFaltafw, lxImpdirccaFecexpo, lxImpdirccaFectrans, lxImpdirccaTimestamp, lxImpdirccaHoraexpo, lxImpdirccaHaltafw, lxImpdirccaBdaltafw, lxImpdirccaEsttrans, lxImpdirccaBdmodifw, lxImpdirccaHoraimpo, lxImpdirccaHmodifw, lxImpdirccaSaltafw, lxImpdirccaUmodifw, lxImpdirccaZadsfw, lxImpdirccaValtafw, lxImpdirccaUaltafw, lxImpdirccaVmodifw, lxImpdirccaSmodifw, lxImpdirccaComp, lxImpdirccaNumero, lxImpdirccaDescripcio, lxImpdirccaCcosto, lxImpdirccaDccosto, lxImpdirccaImportanci, lxImpdirccaArtdesde, lxImpdirccaArthasta, lxImpdirccaProdesde, lxImpdirccaProhasta, lxImpdirccaTemdesde, lxImpdirccaTemhasta, lxImpdirccaAnidesde, lxImpdirccaAnihasta, lxImpdirccaFamdesde, lxImpdirccaFamhasta, lxImpdirccaMatdesde, lxImpdirccaMathasta, lxImpdirccaLindesde, lxImpdirccaLinhasta, lxImpdirccaGrudesde, lxImpdirccaGruhasta, lxImpdirccaCatdesde, lxImpdirccaCathasta, lxImpdirccaCladesde, lxImpdirccaClahasta, lxImpdirccaTipdesde, lxImpdirccaTiphasta, lxImpdirccaArtconiva, lxImpdirccaIvvdesde, lxImpdirccaIvvhasta, lxImpdirccaArtiva, lxImpdirccaIvcdesde, lxImpdirccaIvchasta, lxImpdirccaImpdesde, lxImpdirccaImphasta, lxImpdirccaTipoasi, lxImpdirccaObs
				lxImpdirccaFmodifw =  .Fechamodificacionfw			lxImpdirccaFecimpo =  .Fechaimpo			lxImpdirccaFaltafw =  .Fechaaltafw			lxImpdirccaFecexpo =  .Fechaexpo			lxImpdirccaFectrans =  .Fechatransferencia			lxImpdirccaTimestamp = goLibrerias.ObtenerTimestamp()			lxImpdirccaHoraexpo =  .Horaexpo			lxImpdirccaHaltafw =  .Horaaltafw			lxImpdirccaBdaltafw =  .Basededatosaltafw			lxImpdirccaEsttrans =  .Estadotransferencia			lxImpdirccaBdmodifw =  .Basededatosmodificacionfw			lxImpdirccaHoraimpo =  .Horaimpo			lxImpdirccaHmodifw =  .Horamodificacionfw			lxImpdirccaSaltafw =  .Seriealtafw			lxImpdirccaUmodifw =  .Usuariomodificacionfw			lxImpdirccaZadsfw =  .Zadsfw			lxImpdirccaValtafw =  .Versionaltafw			lxImpdirccaUaltafw =  .Usuarioaltafw			lxImpdirccaVmodifw =  .Versionmodificacionfw			lxImpdirccaSmodifw =  .Seriemodificacionfw			lxImpdirccaComp =  .Comportamiento			lxImpdirccaNumero =  .Numero			lxImpdirccaDescripcio =  .Descripcion			lxImpdirccaCcosto =  upper( .CentroDeCosto_PK ) 			lxImpdirccaDccosto =  upper( .DistribucionPorCentroDeCosto_PK ) 			lxImpdirccaImportanci =  .Importancia			lxImpdirccaArtdesde =  .F_articulo_desde			lxImpdirccaArthasta =  .F_articulo_hasta			lxImpdirccaProdesde =  .F_proveedor_desde			lxImpdirccaProhasta =  .F_proveedor_hasta			lxImpdirccaTemdesde =  .F_temporada_desde			lxImpdirccaTemhasta =  .F_temporada_hasta			lxImpdirccaAnidesde =  .F_anio_desde			lxImpdirccaAnihasta =  .F_anio_hasta			lxImpdirccaFamdesde =  .F_familia_desde			lxImpdirccaFamhasta =  .F_familia_hasta			lxImpdirccaMatdesde =  .F_material_desde			lxImpdirccaMathasta =  .F_material_hasta			lxImpdirccaLindesde =  .F_linea_desde			lxImpdirccaLinhasta =  .F_linea_hasta			lxImpdirccaGrudesde =  .F_grupo_desde			lxImpdirccaGruhasta =  .F_grupo_hasta			lxImpdirccaCatdesde =  .F_categoria_desde			lxImpdirccaCathasta =  .F_categoria_hasta			lxImpdirccaCladesde =  .F_clasificacion_desde			lxImpdirccaClahasta =  .F_clasificacion_hasta			lxImpdirccaTipdesde =  .F_tipo_desde			lxImpdirccaTiphasta =  .F_tipo_hasta			lxImpdirccaArtconiva =  .Condicionivaventas			lxImpdirccaIvvdesde =  .F_ivav_desde			lxImpdirccaIvvhasta =  .F_ivav_hasta			lxImpdirccaArtiva =  .Condicionivacompras			lxImpdirccaIvcdesde =  .F_ivac_desde			lxImpdirccaIvchasta =  .F_ivac_hasta			lxImpdirccaImpdesde =  .F_impi_desde			lxImpdirccaImphasta =  .F_impi_hasta			lxImpdirccaTipoasi =  .Tipodeasiento			lxImpdirccaObs =  .Observacion
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.NUMERO
			lcValorClavePrimariaString = transform( this.oEntidad.NUMERO )

			lcFiltro = ["Numero" = ] + lcValorClavePrimariaString  + [ and  IMPDIRCCA.NUMERO != 0]
			text to lcSentencia noshow textmerge
				update ZooLogic.IMPDIRCCA set "Fmodifw" = <<"'" + this.ConvertirDateSql( lxImpdirccaFmodifw ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxImpdirccaFecimpo ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxImpdirccaFaltafw ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxImpdirccaFecexpo ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxImpdirccaFectrans ) + "'">>, "Timestamp" = <<lxImpdirccaTimestamp>>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxImpdirccaHoraexpo ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxImpdirccaHaltafw ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxImpdirccaBdaltafw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxImpdirccaEsttrans ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxImpdirccaBdmodifw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxImpdirccaHoraimpo ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxImpdirccaHmodifw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxImpdirccaSaltafw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxImpdirccaUmodifw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxImpdirccaZadsfw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxImpdirccaValtafw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxImpdirccaUaltafw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxImpdirccaVmodifw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxImpdirccaSmodifw ) + "'">>, "Comp" = <<lxImpdirccaComp>>, "Numero" = <<lxImpdirccaNumero>>, "Descripcio" = <<"'" + this.FormatearTextoSql( lxImpdirccaDescripcio ) + "'">>, "Ccosto" = <<"'" + this.FormatearTextoSql( lxImpdirccaCcosto ) + "'">>, "Dccosto" = <<"'" + this.FormatearTextoSql( lxImpdirccaDccosto ) + "'">>, "Importanci" = <<lxImpdirccaImportanci>>, "Artdesde" = <<"'" + this.FormatearTextoSql( lxImpdirccaArtdesde ) + "'">>, "Arthasta" = <<"'" + this.FormatearTextoSql( lxImpdirccaArthasta ) + "'">>, "Prodesde" = <<"'" + this.FormatearTextoSql( lxImpdirccaProdesde ) + "'">>, "Prohasta" = <<"'" + this.FormatearTextoSql( lxImpdirccaProhasta ) + "'">>, "Temdesde" = <<"'" + this.FormatearTextoSql( lxImpdirccaTemdesde ) + "'">>, "Temhasta" = <<"'" + this.FormatearTextoSql( lxImpdirccaTemhasta ) + "'">>, "Anidesde" = <<lxImpdirccaAnidesde>>, "Anihasta" = <<lxImpdirccaAnihasta>>, "Famdesde" = <<"'" + this.FormatearTextoSql( lxImpdirccaFamdesde ) + "'">>, "Famhasta" = <<"'" + this.FormatearTextoSql( lxImpdirccaFamhasta ) + "'">>, "Matdesde" = <<"'" + this.FormatearTextoSql( lxImpdirccaMatdesde ) + "'">>, "Mathasta" = <<"'" + this.FormatearTextoSql( lxImpdirccaMathasta ) + "'">>, "Lindesde" = <<"'" + this.FormatearTextoSql( lxImpdirccaLindesde ) + "'">>, "Linhasta" = <<"'" + this.FormatearTextoSql( lxImpdirccaLinhasta ) + "'">>, "Grudesde" = <<"'" + this.FormatearTextoSql( lxImpdirccaGrudesde ) + "'">>, "Gruhasta" = <<"'" + this.FormatearTextoSql( lxImpdirccaGruhasta ) + "'">>, "Catdesde" = <<"'" + this.FormatearTextoSql( lxImpdirccaCatdesde ) + "'">>, "Cathasta" = <<"'" + this.FormatearTextoSql( lxImpdirccaCathasta ) + "'">>, "Cladesde" = <<"'" + this.FormatearTextoSql( lxImpdirccaCladesde ) + "'">>, "Clahasta" = <<"'" + this.FormatearTextoSql( lxImpdirccaClahasta ) + "'">>, "Tipdesde" = <<"'" + this.FormatearTextoSql( lxImpdirccaTipdesde ) + "'">>, "Tiphasta" = <<"'" + this.FormatearTextoSql( lxImpdirccaTiphasta ) + "'">>, "Artconiva" = <<lxImpdirccaArtconiva>>, "Ivvdesde" = <<lxImpdirccaIvvdesde>>, "Ivvhasta" = <<lxImpdirccaIvvhasta>>, "Artiva" = <<lxImpdirccaArtiva>>, "Ivcdesde" = <<lxImpdirccaIvcdesde>>, "Ivchasta" = <<lxImpdirccaIvchasta>>, "Impdesde" = <<lxImpdirccaImpdesde>>, "Imphasta" = <<lxImpdirccaImphasta>>, "Tipoasi" = <<lxImpdirccaTipoasi>>, "Obs" = <<"'" + this.FormatearTextoSql( lxImpdirccaObs ) + "'">> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'IMPDIRCCA' 
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

			lcFiltro = ["Numero" = ] + lcValorClavePrimariaString  + [ and  IMPDIRCCA.NUMERO != 0]
		loColeccion.Agregar( 'delete from ZooLogic.IMPDIRCCA where ' + lcFiltro )
			loColeccion.cTabla = 'IMPDIRCCA' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.IMPDIRCCA where  IMPDIRCCA.NUMERO != 0" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.IMPDIRCCA where NUMERO = " + transform( this.oEntidad.NUMERO )+ " and  IMPDIRCCA.NUMERO != 0" )
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
		lcCursor = This.oEntidad.cPrefijoRecibir + 'IMPDIRCCA'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.IMPDIRCCA Where NUMERO = ] + transform( &lcCursor..NUMERO ), 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					this.oConexion.EjecutarSql( [UPDATE ZooLogic.IMPDIRCCA set  FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, TIMESTAMP = ] + transform( &lcCursor..TIMESTAMP )+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, Comp = ] + transform( &lcCursor..Comp )+ [, NUMERO = ] + transform( &lcCursor..NUMERO )+ [, Descripcio = ] + "'" + this.FormatearTextoSql( &lcCursor..Descripcio ) + "'"+ [, CCosto = ] + "'" + this.FormatearTextoSql( &lcCursor..CCosto ) + "'"+ [, Dccosto = ] + "'" + this.FormatearTextoSql( &lcCursor..Dccosto ) + "'"+ [, Importanci = ] + transform( &lcCursor..Importanci )+ [, ArtDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..ArtDesde ) + "'"+ [, ArtHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..ArtHasta ) + "'"+ [, ProDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..ProDesde ) + "'"+ [, ProHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..ProHasta ) + "'"+ [, TemDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..TemDesde ) + "'"+ [, TemHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..TemHasta ) + "'"+ [, AniDesde = ] + transform( &lcCursor..AniDesde )+ [, AniHasta = ] + transform( &lcCursor..AniHasta )+ [, FamDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..FamDesde ) + "'"+ [, FamHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..FamHasta ) + "'"+ [, MatDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..MatDesde ) + "'"+ [, MatHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..MatHasta ) + "'"+ [, LinDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..LinDesde ) + "'"+ [, LinHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..LinHasta ) + "'"+ [, GruDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..GruDesde ) + "'"+ [, GruHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..GruHasta ) + "'"+ [, CatDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..CatDesde ) + "'"+ [, CatHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..CatHasta ) + "'"+ [, ClaDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..ClaDesde ) + "'"+ [, ClaHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..ClaHasta ) + "'"+ [, TipDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..TipDesde ) + "'"+ [, TipHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..TipHasta ) + "'"+ [, ARTCONIVA = ] + transform( &lcCursor..ARTCONIVA )+ [, IvvDesde = ] + transform( &lcCursor..IvvDesde )+ [, IvvHasta = ] + transform( &lcCursor..IvvHasta )+ [, ARTIVA = ] + transform( &lcCursor..ARTIVA )+ [, IvcDesde = ] + transform( &lcCursor..IvcDesde )+ [, IvcHasta = ] + transform( &lcCursor..IvcHasta )+ [, ImpDesde = ] + transform( &lcCursor..ImpDesde )+ [, ImpHasta = ] + transform( &lcCursor..ImpHasta )+ [, TipoAsi = ] + transform( &lcCursor..TipoAsi )+ [, OBS = ] + "'" + this.FormatearTextoSql( &lcCursor..OBS ) + "'" + [ Where NUMERO = ] + transform( &lcCursor..NUMERO ) )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
				endIf
			else
				Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
				Text to lcCampos noShow
					 FMODIFW, FECIMPO, FALTAFW, FECEXPO, FECTRANS, TIMESTAMP, HORAEXPO, HALTAFW, BDALTAFW, ESTTRANS, BDMODIFW, HORAIMPO, HMODIFW, SALTAFW, UMODIFW, ZADSFW, VALTAFW, UALTAFW, VMODIFW, SMODIFW, Comp, NUMERO, Descripcio, CCosto, Dccosto, Importanci, ArtDesde, ArtHasta, ProDesde, ProHasta, TemDesde, TemHasta, AniDesde, AniHasta, FamDesde, FamHasta, MatDesde, MatHasta, LinDesde, LinHasta, GruDesde, GruHasta, CatDesde, CatHasta, ClaDesde, ClaHasta, TipDesde, TipHasta, ARTCONIVA, IvvDesde, IvvHasta, ARTIVA, IvcDesde, IvcHasta, ImpDesde, ImpHasta, TipoAsi, OBS
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + transform( &lcCursor..TIMESTAMP ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + transform( &lcCursor..Comp )
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..NUMERO ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..Descripcio ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CCosto ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Dccosto ) + "'" + ',' + transform( &lcCursor..Importanci ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..ArtDesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ArtHasta ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..ProDesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ProHasta ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..TemDesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..TemHasta ) + "'" + ',' + transform( &lcCursor..AniDesde ) + ',' + transform( &lcCursor..AniHasta ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..FamDesde ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..FamHasta ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..MatDesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..MatHasta ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..LinDesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..LinHasta ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..GruDesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..GruHasta ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..CatDesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CatHasta ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ClaDesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ClaHasta ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..TipDesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..TipHasta ) + "'" + ',' + transform( &lcCursor..ARTCONIVA )
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..IvvDesde ) + ',' + transform( &lcCursor..IvvHasta ) + ',' + transform( &lcCursor..ARTIVA ) + ',' + transform( &lcCursor..IvcDesde ) + ',' + transform( &lcCursor..IvcHasta ) + ',' + transform( &lcCursor..ImpDesde ) + ',' + transform( &lcCursor..ImpHasta ) + ',' + transform( &lcCursor..TipoAsi ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..OBS ) + "'"
lcValoresCampos = substr(lcValoresCampos,2) 

				this.oConexion.EjecutarSql( [Insert into ZooLogic.IMPDIRCCA ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
				this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'IMPDIRCCA'
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
			Case  lcAlias == lcPrefijo + 'IMPDIRCCA'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'IMPDIRCCA_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'IMPDIRCCA_OBS'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_IMPDIRCCA')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'IMPDIRCCA'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..NUMERO
		llCondicion = isnull( lxVar )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad IMPDIRCCA. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'IMPDIRCCA'
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
			lcCursor = This.oEntidad.cPrefijoRecibir + 'IMPDIRCCA'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_IMPDIRCCA') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_IMPDIRCCA
Create Table ZooLogic.TablaTrabajo_IMPDIRCCA ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fmodifw" datetime  null, 
"fecimpo" datetime  null, 
"faltafw" datetime  null, 
"fecexpo" datetime  null, 
"fectrans" datetime  null, 
"timestamp" numeric( 20, 0 )  null, 
"horaexpo" char( 8 )  null, 
"haltafw" char( 8 )  null, 
"bdaltafw" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"bdmodifw" char( 8 )  null, 
"horaimpo" char( 8 )  null, 
"hmodifw" char( 8 )  null, 
"saltafw" char( 7 )  null, 
"umodifw" char( 100 )  null, 
"zadsfw" varchar(max)  null, 
"valtafw" char( 13 )  null, 
"ualtafw" char( 100 )  null, 
"vmodifw" char( 13 )  null, 
"smodifw" char( 7 )  null, 
"comp" numeric( 1, 0 )  null, 
"numero" numeric( 8, 0 )  null, 
"descripcio" char( 50 )  null, 
"ccosto" char( 20 )  null, 
"dccosto" char( 20 )  null, 
"importanci" numeric( 5, 0 )  null, 
"artdesde" char( 13 )  null, 
"arthasta" char( 13 )  null, 
"prodesde" char( 5 )  null, 
"prohasta" char( 5 )  null, 
"temdesde" char( 5 )  null, 
"temhasta" char( 5 )  null, 
"anidesde" numeric( 4, 0 )  null, 
"anihasta" numeric( 4, 0 )  null, 
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
"ivvdesde" numeric( 6, 2 )  null, 
"ivvhasta" numeric( 6, 2 )  null, 
"artiva" numeric( 1, 0 )  null, 
"ivcdesde" numeric( 6, 2 )  null, 
"ivchasta" numeric( 6, 2 )  null, 
"impdesde" numeric( 6, 2 )  null, 
"imphasta" numeric( 6, 2 )  null, 
"tipoasi" numeric( 1, 0 )  null, 
"obs" varchar(max)  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_IMPDIRCCA' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_IMPDIRCCA' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'IMPDIRCCA'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		with loManejador
			if this.oEntidad.VerificarContexto( 'CB' )
			else
				.AgregarMapeo('Nrolinea','Nrolinea')
			endif
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('timestamp','timestamp')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('comp','comp')
			.AgregarMapeo('numero','numero')
			.AgregarMapeo('descripcio','descripcio')
			.AgregarMapeo('ccosto','ccosto')
			.AgregarMapeo('dccosto','dccosto')
			.AgregarMapeo('importanci','importanci')
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
			.AgregarMapeo('impdesde','impdesde')
			.AgregarMapeo('imphasta','imphasta')
			.AgregarMapeo('tipoasi','tipoasi')
			.AgregarMapeo('obs','obs')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_IMPDIRCCA'
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
				Update t Set t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.TIMESTAMP = isnull( d.TIMESTAMP, t.TIMESTAMP ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.COMP = isnull( d.COMP, t.COMP ),t.NUMERO = isnull( d.NUMERO, t.NUMERO ),t.DESCRIPCIO = isnull( d.DESCRIPCIO, t.DESCRIPCIO ),t.CCOSTO = isnull( d.CCOSTO, t.CCOSTO ),t.DCCOSTO = isnull( d.DCCOSTO, t.DCCOSTO ),t.IMPORTANCI = isnull( d.IMPORTANCI, t.IMPORTANCI ),t.ARTDESDE = isnull( d.ARTDESDE, t.ARTDESDE ),t.ARTHASTA = isnull( d.ARTHASTA, t.ARTHASTA ),t.PRODESDE = isnull( d.PRODESDE, t.PRODESDE ),t.PROHASTA = isnull( d.PROHASTA, t.PROHASTA ),t.TEMDESDE = isnull( d.TEMDESDE, t.TEMDESDE ),t.TEMHASTA = isnull( d.TEMHASTA, t.TEMHASTA ),t.ANIDESDE = isnull( d.ANIDESDE, t.ANIDESDE ),t.ANIHASTA = isnull( d.ANIHASTA, t.ANIHASTA ),t.FAMDESDE = isnull( d.FAMDESDE, t.FAMDESDE ),t.FAMHASTA = isnull( d.FAMHASTA, t.FAMHASTA ),t.MATDESDE = isnull( d.MATDESDE, t.MATDESDE ),t.MATHASTA = isnull( d.MATHASTA, t.MATHASTA ),t.LINDESDE = isnull( d.LINDESDE, t.LINDESDE ),t.LINHASTA = isnull( d.LINHASTA, t.LINHASTA ),t.GRUDESDE = isnull( d.GRUDESDE, t.GRUDESDE ),t.GRUHASTA = isnull( d.GRUHASTA, t.GRUHASTA ),t.CATDESDE = isnull( d.CATDESDE, t.CATDESDE ),t.CATHASTA = isnull( d.CATHASTA, t.CATHASTA ),t.CLADESDE = isnull( d.CLADESDE, t.CLADESDE ),t.CLAHASTA = isnull( d.CLAHASTA, t.CLAHASTA ),t.TIPDESDE = isnull( d.TIPDESDE, t.TIPDESDE ),t.TIPHASTA = isnull( d.TIPHASTA, t.TIPHASTA ),t.ARTCONIVA = isnull( d.ARTCONIVA, t.ARTCONIVA ),t.IVVDESDE = isnull( d.IVVDESDE, t.IVVDESDE ),t.IVVHASTA = isnull( d.IVVHASTA, t.IVVHASTA ),t.ARTIVA = isnull( d.ARTIVA, t.ARTIVA ),t.IVCDESDE = isnull( d.IVCDESDE, t.IVCDESDE ),t.IVCHASTA = isnull( d.IVCHASTA, t.IVCHASTA ),t.IMPDESDE = isnull( d.IMPDESDE, t.IMPDESDE ),t.IMPHASTA = isnull( d.IMPHASTA, t.IMPHASTA ),t.TIPOASI = isnull( d.TIPOASI, t.TIPOASI ),t.OBS = isnull( d.OBS, t.OBS )
					from ZooLogic.IMPDIRCCA t inner join deleted d 
							 on t.NUMERO = d.NUMERO
				-- Fin Updates
				insert into ZooLogic.IMPDIRCCA(Fmodifw,Fecimpo,Faltafw,Fecexpo,Fectrans,Timestamp,Horaexpo,Haltafw,Bdaltafw,Esttrans,Bdmodifw,Horaimpo,Hmodifw,Saltafw,Umodifw,Zadsfw,Valtafw,Ualtafw,Vmodifw,Smodifw,Comp,Numero,Descripcio,Ccosto,Dccosto,Importanci,Artdesde,Arthasta,Prodesde,Prohasta,Temdesde,Temhasta,Anidesde,Anihasta,Famdesde,Famhasta,Matdesde,Mathasta,Lindesde,Linhasta,Grudesde,Gruhasta,Catdesde,Cathasta,Cladesde,Clahasta,Tipdesde,Tiphasta,Artconiva,Ivvdesde,Ivvhasta,Artiva,Ivcdesde,Ivchasta,Impdesde,Imphasta,Tipoasi,Obs)
					Select isnull( d.FMODIFW,''),isnull( d.FECIMPO,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FECEXPO,''),isnull( d.FECTRANS,''),isnull( d.TIMESTAMP,0),isnull( d.HORAEXPO,''),convert( char(8), getdate(), 108 ),isnull( d.BDALTAFW,''),isnull( d.ESTTRANS,''),isnull( d.BDMODIFW,''),isnull( d.HORAIMPO,''),isnull( d.HMODIFW,''),isnull( d.SALTAFW,''),isnull( d.UMODIFW,''),isnull( d.ZADSFW,''),isnull( d.VALTAFW,''),isnull( d.UALTAFW,''),isnull( d.VMODIFW,''),isnull( d.SMODIFW,''),isnull( d.COMP,0),isnull( d.NUMERO,0),isnull( d.DESCRIPCIO,''),isnull( d.CCOSTO,''),isnull( d.DCCOSTO,''),isnull( d.IMPORTANCI,0),isnull( d.ARTDESDE,''),isnull( d.ARTHASTA,''),isnull( d.PRODESDE,''),isnull( d.PROHASTA,''),isnull( d.TEMDESDE,''),isnull( d.TEMHASTA,''),isnull( d.ANIDESDE,0),isnull( d.ANIHASTA,0),isnull( d.FAMDESDE,''),isnull( d.FAMHASTA,''),isnull( d.MATDESDE,''),isnull( d.MATHASTA,''),isnull( d.LINDESDE,''),isnull( d.LINHASTA,''),isnull( d.GRUDESDE,''),isnull( d.GRUHASTA,''),isnull( d.CATDESDE,''),isnull( d.CATHASTA,''),isnull( d.CLADESDE,''),isnull( d.CLAHASTA,''),isnull( d.TIPDESDE,''),isnull( d.TIPHASTA,''),isnull( d.ARTCONIVA,0),isnull( d.IVVDESDE,0),isnull( d.IVVHASTA,0),isnull( d.ARTIVA,0),isnull( d.IVCDESDE,0),isnull( d.IVCHASTA,0),isnull( d.IMPDESDE,0),isnull( d.IMPHASTA,0),isnull( d.TIPOASI,0),isnull( d.OBS,'')
						From deleted d left join ZooLogic.IMPDIRCCA pk 
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_IMPDIRCCA') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_IMPDIRCCA
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_IMPDIRCCA' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_IMPDIRCCA.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_IMPDIRCCA.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_IMPDIRCCA.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_IMPDIRCCA.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_IMPDIRCCA.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Timestamp = nvl( c_IMPDIRCCA.Timestamp, 0 )
					.Horaexpo = nvl( c_IMPDIRCCA.Horaexpo, [] )
					.Horaaltafw = nvl( c_IMPDIRCCA.Horaaltafw, [] )
					.Basededatosaltafw = nvl( c_IMPDIRCCA.Basededatosaltafw, [] )
					.Estadotransferencia = nvl( c_IMPDIRCCA.Estadotransferencia, [] )
					.Basededatosmodificacionfw = nvl( c_IMPDIRCCA.Basededatosmodificacionfw, [] )
					.Horaimpo = nvl( c_IMPDIRCCA.Horaimpo, [] )
					.Horamodificacionfw = nvl( c_IMPDIRCCA.Horamodificacionfw, [] )
					.Seriealtafw = nvl( c_IMPDIRCCA.Seriealtafw, [] )
					.Usuariomodificacionfw = nvl( c_IMPDIRCCA.Usuariomodificacionfw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Versionaltafw = nvl( c_IMPDIRCCA.Versionaltafw, [] )
					.Usuarioaltafw = nvl( c_IMPDIRCCA.Usuarioaltafw, [] )
					.Versionmodificacionfw = nvl( c_IMPDIRCCA.Versionmodificacionfw, [] )
					.Seriemodificacionfw = nvl( c_IMPDIRCCA.Seriemodificacionfw, [] )
					.Comportamiento = nvl( c_IMPDIRCCA.Comportamiento, 0 )
					.Numero = nvl( c_IMPDIRCCA.Numero, 0 )
					.Descripcion = nvl( c_IMPDIRCCA.Descripcion, [] )
					.Centrodecosto_PK =  nvl( c_IMPDIRCCA.Centrodecosto, [] )
					.Distribucionporcentrodecosto_PK =  nvl( c_IMPDIRCCA.Distribucionporcentrodecosto, [] )
					.Importancia = nvl( c_IMPDIRCCA.Importancia, 0 )
					.F_articulo_desde = nvl( c_IMPDIRCCA.F_articulo_desde, [] )
					.F_articulo_hasta = nvl( c_IMPDIRCCA.F_articulo_hasta, [] )
					.F_proveedor_desde = nvl( c_IMPDIRCCA.F_proveedor_desde, [] )
					.F_proveedor_hasta = nvl( c_IMPDIRCCA.F_proveedor_hasta, [] )
					.F_temporada_desde = nvl( c_IMPDIRCCA.F_temporada_desde, [] )
					.F_temporada_hasta = nvl( c_IMPDIRCCA.F_temporada_hasta, [] )
					.F_anio_desde = nvl( c_IMPDIRCCA.F_anio_desde, 0 )
					.F_anio_hasta = nvl( c_IMPDIRCCA.F_anio_hasta, 0 )
					.F_familia_desde = nvl( c_IMPDIRCCA.F_familia_desde, [] )
					.F_familia_hasta = nvl( c_IMPDIRCCA.F_familia_hasta, [] )
					.F_material_desde = nvl( c_IMPDIRCCA.F_material_desde, [] )
					.F_material_hasta = nvl( c_IMPDIRCCA.F_material_hasta, [] )
					.F_linea_desde = nvl( c_IMPDIRCCA.F_linea_desde, [] )
					.F_linea_hasta = nvl( c_IMPDIRCCA.F_linea_hasta, [] )
					.F_grupo_desde = nvl( c_IMPDIRCCA.F_grupo_desde, [] )
					.F_grupo_hasta = nvl( c_IMPDIRCCA.F_grupo_hasta, [] )
					.F_categoria_desde = nvl( c_IMPDIRCCA.F_categoria_desde, [] )
					.F_categoria_hasta = nvl( c_IMPDIRCCA.F_categoria_hasta, [] )
					.F_clasificacion_desde = nvl( c_IMPDIRCCA.F_clasificacion_desde, [] )
					.F_clasificacion_hasta = nvl( c_IMPDIRCCA.F_clasificacion_hasta, [] )
					.F_tipo_desde = nvl( c_IMPDIRCCA.F_tipo_desde, [] )
					.F_tipo_hasta = nvl( c_IMPDIRCCA.F_tipo_hasta, [] )
					.Condicionivaventas = nvl( c_IMPDIRCCA.Condicionivaventas, 0 )
					.F_ivav_desde = nvl( c_IMPDIRCCA.F_ivav_desde, 0 )
					.F_ivav_hasta = nvl( c_IMPDIRCCA.F_ivav_hasta, 0 )
					.Condicionivacompras = nvl( c_IMPDIRCCA.Condicionivacompras, 0 )
					.F_ivac_desde = nvl( c_IMPDIRCCA.F_ivac_desde, 0 )
					.F_ivac_hasta = nvl( c_IMPDIRCCA.F_ivac_hasta, 0 )
					.F_impi_desde = nvl( c_IMPDIRCCA.F_impi_desde, 0 )
					.F_impi_hasta = nvl( c_IMPDIRCCA.F_impi_hasta, 0 )
					.Tipodeasiento = nvl( c_IMPDIRCCA.Tipodeasiento, 0 )
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
		return c_IMPDIRCCA.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.IMPDIRCCA' )
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
								from ZooLogic.IMPDIRCCA 
								Where   IMPDIRCCA.NUMERO != 0
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "IMPDIRCCA", "", lcCursor, set("Datasession") )
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
			"Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Timestamp" as "Timestamp", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Vmodifw" as "Versionmodificacionfw", "Smodifw" as "Seriemodificacionfw", "Comp" as "Comportamiento", "Numero" as "Numero", "Descripcio" as "Descripcion", "Ccosto" as "Centrodecosto", "Dccosto" as "Distribucionporcentrodecosto", "Importanci" as "Importancia", "Artdesde" as "F_articulo_desde", "Arthasta" as "F_articulo_hasta", "Prodesde" as "F_proveedor_desde", "Prohasta" as "F_proveedor_hasta", "Temdesde" as "F_temporada_desde", "Temhasta" as "F_temporada_hasta", "Anidesde" as "F_anio_desde", "Anihasta" as "F_anio_hasta", "Famdesde" as "F_familia_desde", "Famhasta" as "F_familia_hasta", "Matdesde" as "F_material_desde", "Mathasta" as "F_material_hasta", "Lindesde" as "F_linea_desde", "Linhasta" as "F_linea_hasta", "Grudesde" as "F_grupo_desde", "Gruhasta" as "F_grupo_hasta", "Catdesde" as "F_categoria_desde", "Cathasta" as "F_categoria_hasta", "Cladesde" as "F_clasificacion_desde", "Clahasta" as "F_clasificacion_hasta", "Tipdesde" as "F_tipo_desde", "Tiphasta" as "F_tipo_hasta", "Artconiva" as "Condicionivaventas", "Ivvdesde" as "F_ivav_desde", "Ivvhasta" as "F_ivav_hasta", "Artiva" as "Condicionivacompras", "Ivcdesde" as "F_ivac_desde", "Ivchasta" as "F_ivac_hasta", "Impdesde" as "F_impi_desde", "Imphasta" as "F_impi_hasta", "Tipoasi" as "Tipodeasiento", "Obs" as "Observacion"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.IMPDIRCCA 
								Where   IMPDIRCCA.NUMERO != 0
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
	Tabla = 'IMPDIRCCA'
	Filtro = " IMPDIRCCA.NUMERO != 0"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " IMPDIRCCA.NUMERO != 0"
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
										<xsd:maxLength value="250"/>
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
	<row entidad="IMPDIRCCA                               " atributo="FECHAMODIFICACIONFW                     " tabla="IMPDIRCCA      " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                                                                                                                        " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCCA                               " atributo="FECHAIMPO                               " tabla="IMPDIRCCA      " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                                                                                                                         " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCCA                               " atributo="FECHAALTAFW                             " tabla="IMPDIRCCA      " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                                                                                                                " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCCA                               " atributo="FECHAEXPO                               " tabla="IMPDIRCCA      " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                                                                                                                         " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCCA                               " atributo="FECHATRANSFERENCIA                      " tabla="IMPDIRCCA      " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha transferencia                                                                                                                                                                                                                                       " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCCA                               " atributo="TIMESTAMP                               " tabla="IMPDIRCCA      " campo="TIMESTAMP " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCCA                               " atributo="HORAEXPO                                " tabla="IMPDIRCCA      " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                                                                                                          " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCCA                               " atributo="HORAALTAFW                              " tabla="IMPDIRCCA      " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                                                                                                                 " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCCA                               " atributo="BASEDEDATOSALTAFW                       " tabla="IMPDIRCCA      " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                                                                                                                        " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCCA                               " atributo="ESTADOTRANSFERENCIA                     " tabla="IMPDIRCCA      " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado transferencia                                                                                                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCCA                               " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="IMPDIRCCA      " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCCA                               " atributo="HORAIMPO                                " tabla="IMPDIRCCA      " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                                                                                                          " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCCA                               " atributo="HORAMODIFICACIONFW                      " tabla="IMPDIRCCA      " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                                                                                                                         " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCCA                               " atributo="SERIEALTAFW                             " tabla="IMPDIRCCA      " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCCA                               " atributo="USUARIOMODIFICACIONFW                   " tabla="IMPDIRCCA      " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCCA                               " atributo="ZADSFW                                  " tabla="IMPDIRCCA      " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCCA                               " atributo="VERSIONALTAFW                           " tabla="IMPDIRCCA      " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCCA                               " atributo="USUARIOALTAFW                           " tabla="IMPDIRCCA      " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCCA                               " atributo="VERSIONMODIFICACIONFW                   " tabla="IMPDIRCCA      " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCCA                               " atributo="SERIEMODIFICACIONFW                     " tabla="IMPDIRCCA      " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                                                                                                                        " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCCA                               " atributo="COMPORTAMIENTO                          " tabla="IMPDIRCCA      " campo="COMP      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="10" etiqueta="Comportamiento                                                                                                                                                                                                                                            " dominio="COMBOXML                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="12" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCCA                               " atributo="NUMERO                                  " tabla="IMPDIRCCA      " campo="NUMERO    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="8" etiqueta="Número                                                                                                                                                                                                                                                    " dominio="CODIGONUMERICO                " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCCA                               " atributo="DESCRIPCION                             " tabla="IMPDIRCCA      " campo="DESCRIPCIO" claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="4" etiqueta="Descripción                                                                                                                                                                                                                                               " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCCA                               " atributo="CENTRODECOSTO                           " tabla="IMPDIRCCA      " campo="CCOSTO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CENTRODECOSTO                           " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="Centro de costo                                                                                                                                                                                                                                           " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCCA                               " atributo="DISTRIBUCIONPORCENTRODECOSTO            " tabla="IMPDIRCCA      " campo="DCCOSTO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="DISTRIBUCIONCENTRODECOSTO               " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="402" etiqueta="Distribución por c. costo                                                                                                                                                                                                                                 " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCCA                               " atributo="IMPORTANCIA                             " tabla="IMPDIRCCA      " campo="IMPORTANCI" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="4" etiqueta="Importancia                                                                                                                                                                                                                                               " dominio="NUMERICONONEGATIVO            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCCA                               " atributo="F_ARTICULO_DESDE                        " tabla="IMPDIRCCA      " campo="ARTDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="404" etiqueta="Artículo desde                                                                                                                                                                                                                                            " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="11" orden="13" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCCA                               " atributo="F_ARTICULO_HASTA                        " tabla="IMPDIRCCA      " campo="ARTHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="ZZZZZZZZZZZZZZZ                                                                                                                                                                                                                                               " obligatorio="false" admitebusqueda="406" etiqueta="Artículo hasta                                                                                                                                                                                                                                            " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="11" orden="14" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCCA                               " atributo="F_PROVEEDOR_DESDE                       " tabla="IMPDIRCCA      " campo="PRODESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="408" etiqueta="Proveedor desde                                                                                                                                                                                                                                           " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="13" orden="15" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCCA                               " atributo="F_PROVEEDOR_HASTA                       " tabla="IMPDIRCCA      " campo="PROHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="5" decimales="0" valorsugerido="ZZZZZZZZZZ                                                                                                                                                                                                                                                    " obligatorio="false" admitebusqueda="410" etiqueta="Proveedor hasta                                                                                                                                                                                                                                           " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="13" orden="16" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCCA                               " atributo="F_TEMPORADA_DESDE                       " tabla="IMPDIRCCA      " campo="TEMDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="412" etiqueta="Temporada hasta                                                                                                                                                                                                                                           " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="14" orden="17" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCCA                               " atributo="F_TEMPORADA_HASTA                       " tabla="IMPDIRCCA      " campo="TEMHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="5" decimales="0" valorsugerido="ZZZZZ                                                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="414" etiqueta="Temporada desde                                                                                                                                                                                                                                           " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="14" orden="18" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCCA                               " atributo="F_ANIO_DESDE                            " tabla="IMPDIRCCA      " campo="ANIDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="4" decimales="0" valorsugerido="1900                                                                                                                                                                                                                                                          " obligatorio="false" admitebusqueda="416" etiqueta="Año desde                                                                                                                                                                                                                                                 " dominio="EtiquetaNumericoDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="15" orden="19" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCCA                               " atributo="F_ANIO_HASTA                            " tabla="IMPDIRCCA      " campo="ANIHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="4" decimales="0" valorsugerido="2099                                                                                                                                                                                                                                                          " obligatorio="false" admitebusqueda="418" etiqueta="Año hasta                                                                                                                                                                                                                                                 " dominio="EtiquetaNumericoDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="15" orden="20" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCCA                               " atributo="F_FAMILIA_DESDE                         " tabla="IMPDIRCCA      " campo="FAMDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="420" etiqueta="Familia desde                                                                                                                                                                                                                                             " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="16" orden="21" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCCA                               " atributo="F_FAMILIA_HASTA                         " tabla="IMPDIRCCA      " campo="FAMHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="5" decimales="0" valorsugerido="ZZZZZZZZZZ                                                                                                                                                                                                                                                    " obligatorio="false" admitebusqueda="422" etiqueta="Familia hasta                                                                                                                                                                                                                                             " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="16" orden="22" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCCA                               " atributo="F_MATERIAL_DESDE                        " tabla="IMPDIRCCA      " campo="MATDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="424" etiqueta="Material desde                                                                                                                                                                                                                                            " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="17" orden="23" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCCA                               " atributo="F_MATERIAL_HASTA                        " tabla="IMPDIRCCA      " campo="MATHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="5" decimales="0" valorsugerido="ZZZZZZZZZZ                                                                                                                                                                                                                                                    " obligatorio="false" admitebusqueda="426" etiqueta="Material hasta                                                                                                                                                                                                                                            " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="17" orden="24" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCCA                               " atributo="F_LINEA_DESDE                           " tabla="IMPDIRCCA      " campo="LINDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="428" etiqueta="Línea desde                                                                                                                                                                                                                                               " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="18" orden="25" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCCA                               " atributo="F_LINEA_HASTA                           " tabla="IMPDIRCCA      " campo="LINHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="5" decimales="0" valorsugerido="ZZZZZZZZZZ                                                                                                                                                                                                                                                    " obligatorio="false" admitebusqueda="430" etiqueta="Línea hasta                                                                                                                                                                                                                                               " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="18" orden="26" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCCA                               " atributo="F_GRUPO_DESDE                           " tabla="IMPDIRCCA      " campo="GRUDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="432" etiqueta="Grupo desde                                                                                                                                                                                                                                               " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="19" orden="27" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCCA                               " atributo="F_GRUPO_HASTA                           " tabla="IMPDIRCCA      " campo="GRUHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="5" decimales="0" valorsugerido="ZZZZZZZZZZ                                                                                                                                                                                                                                                    " obligatorio="false" admitebusqueda="434" etiqueta="Grupo hasta                                                                                                                                                                                                                                               " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="19" orden="28" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCCA                               " atributo="F_CATEGORIA_DESDE                       " tabla="IMPDIRCCA      " campo="CATDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="436" etiqueta="Categoría desde                                                                                                                                                                                                                                           " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="20" orden="29" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCCA                               " atributo="F_CATEGORIA_HASTA                       " tabla="IMPDIRCCA      " campo="CATHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="5" decimales="0" valorsugerido="ZZZZZZZZZZ                                                                                                                                                                                                                                                    " obligatorio="false" admitebusqueda="438" etiqueta="Categoría hasta                                                                                                                                                                                                                                           " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="20" orden="30" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCCA                               " atributo="F_CLASIFICACION_DESDE                   " tabla="IMPDIRCCA      " campo="CLADESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="440" etiqueta="Clasificación desde                                                                                                                                                                                                                                       " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="21" orden="31" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCCA                               " atributo="F_CLASIFICACION_HASTA                   " tabla="IMPDIRCCA      " campo="CLAHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="5" decimales="0" valorsugerido="ZZZZZZZZZZ                                                                                                                                                                                                                                                    " obligatorio="false" admitebusqueda="442" etiqueta="Clasificación hasta                                                                                                                                                                                                                                       " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="21" orden="32" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCCA                               " atributo="F_TIPO_DESDE                            " tabla="IMPDIRCCA      " campo="TIPDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="444" etiqueta="Tipo desde                                                                                                                                                                                                                                                " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="22" orden="33" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCCA                               " atributo="F_TIPO_HASTA                            " tabla="IMPDIRCCA      " campo="TIPHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="5" decimales="0" valorsugerido="ZZZZZZZZZZ                                                                                                                                                                                                                                                    " obligatorio="false" admitebusqueda="446" etiqueta="Tipo hasta                                                                                                                                                                                                                                                " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="22" orden="34" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCCA                               " atributo="CONDICIONIVAVENTAS                      " tabla="IMPDIRCCA      " campo="ARTCONIVA " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="448" etiqueta="I.V.A. ventas                                                                                                                                                                                                                                             " dominio="COMBOF_CONDICIONIVA           " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="23" orden="35" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCCA                               " atributo="F_IVAV_DESDE                            " tabla="IMPDIRCCA      " campo="IVVDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="6" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="450" etiqueta="Iva venta desde                                                                                                                                                                                                                                           " dominio="EtiquetaNumericoDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="24" orden="36" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCCA                               " atributo="F_IVAV_HASTA                            " tabla="IMPDIRCCA      " campo="IVVHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="6" decimales="2" valorsugerido="100.00                                                                                                                                                                                                                                                        " obligatorio="false" admitebusqueda="452" etiqueta="Iva venta hasta                                                                                                                                                                                                                                           " dominio="EtiquetaNumericoDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="24" orden="37" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCCA                               " atributo="CONDICIONIVACOMPRAS                     " tabla="IMPDIRCCA      " campo="ARTIVA    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="454" etiqueta="I.V.A. compras                                                                                                                                                                                                                                            " dominio="COMBOF_CONDICIONIVA           " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="25" orden="38" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCCA                               " atributo="F_IVAC_DESDE                            " tabla="IMPDIRCCA      " campo="IVCDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="6" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="456" etiqueta="Iva compra desde                                                                                                                                                                                                                                          " dominio="EtiquetaNumericoDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="26" orden="39" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCCA                               " atributo="F_IVAC_HASTA                            " tabla="IMPDIRCCA      " campo="IVCHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="6" decimales="2" valorsugerido="100.00                                                                                                                                                                                                                                                        " obligatorio="false" admitebusqueda="458" etiqueta="Iva compra hasta                                                                                                                                                                                                                                          " dominio="EtiquetaNumericoDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="26" orden="40" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCCA                               " atributo="F_IMPI_DESDE                            " tabla="IMPDIRCCA      " campo="IMPDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="6" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="460" etiqueta="Impuesto desde                                                                                                                                                                                                                                            " dominio="EtiquetaNumericoDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="27" orden="41" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCCA                               " atributo="F_IMPI_HASTA                            " tabla="IMPDIRCCA      " campo="IMPHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="6" decimales="2" valorsugerido="100.00                                                                                                                                                                                                                                                        " obligatorio="false" admitebusqueda="462" etiqueta="Impuesto hasta                                                                                                                                                                                                                                            " dominio="EtiquetaNumericoDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="27" orden="42" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCCA                               " atributo="TIPODEASIENTO                           " tabla="IMPDIRCCA      " campo="TIPOASI   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="6" etiqueta="Imputación por tipo de asiento                                                                                                                                                                                                                            " dominio="COMBOTIPODEASIENTO            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="28" orden="45" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPDIRCCA                               " atributo="OBSERVACION                             " tabla="IMPDIRCCA      " campo="OBS       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="464" etiqueta="Observaciones                                                                                                                                                                                                                                             " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="12" orden="90" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CENTRODECOSTO                           " atributo="DESCRIPCION                             " tabla="CCOSTO         " campo="COSDES    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="150" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="401" etiqueta="Detalle Cen.                                                                                                                                                                                                                                              " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CCOSTO On IMPDIRCCA.CCOSTO = CCOSTO.COSCOD And  CCOSTO.COSCOD != ''                                                                                                                                                                                " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISTRIBUCIONCENTRODECOSTO               " atributo="DESCRIPCION                             " tabla="DCCOSTO        " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="150" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="403" etiqueta="Detalle Dis.                                                                                                                                                                                                                                              " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join DCCOSTO On IMPDIRCCA.DCCOSTO = DCCOSTO.Codigo And  DCCOSTO.CODIGO != ''                                                                                                                                                                            " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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