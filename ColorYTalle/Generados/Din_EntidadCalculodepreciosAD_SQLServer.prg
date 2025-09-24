
define class Din_EntidadCALCULODEPRECIOSAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_CALCULODEPRECIOS'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = []
	cExpresionCCPorCampos = []
	cTagClaveCandidata = ''
	cTagClavePk = '_041PK'
	cTablaPrincipal = 'CALCPREC'
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
			local  lxCalcprecFecexpo, lxCalcprecFaltafw, lxCalcprecFecimpo, lxCalcprecFmodifw, lxCalcprecFectrans, lxCalcprecCodigo, lxCalcprecUaltafw, lxCalcprecSmodifw, lxCalcprecValtafw, lxCalcprecHoraexpo, lxCalcprecVmodifw, lxCalcprecUmodifw, lxCalcprecBdaltafw, lxCalcprecEsttrans, lxCalcprecHaltafw, lxCalcprecBdmodifw, lxCalcprecDescfw, lxCalcprecHmodifw, lxCalcprecHoraimpo, lxCalcprecSaltafw, lxCalcprecZadsfw, lxCalcprecTimestamp, lxCalcprecAnulado, lxCalcprecDescrip, lxCalcprecArtdesde, lxCalcprecUnidesde, lxCalcprecFecha, lxCalcprecArthasta, lxCalcprecUnihasta, lxCalcprecFproceso, lxCalcprecFechabase, lxCalcprecColdesde, lxCalcprecFamdesde, lxCalcprecColhasta, lxCalcprecFamhasta, lxCalcprecFechavig, lxCalcprecSintransac, lxCalcprecTaldesde, lxCalcprecLindesde, lxCalcprecTalhasta, lxCalcprecLinhasta, lxCalcprecComporta, lxCalcprecCatdesde, lxCalcprecProvdesde, lxCalcprecKpxpartic, lxCalcprecCathasta, lxCalcprecProvhasta, lxCalcprecPdcdesde, lxCalcprecCdtdesde, lxCalcprecNarbadesde, lxCalcprecTemdesde, lxCalcprecPdchasta, lxCalcprecCdthasta, lxCalcprecNarbahasta, lxCalcprecTemhasta, lxCalcprecAnodesde, lxCalcprecCladesde, lxCalcprecAnohasta, lxCalcprecClahasta, lxCalcprecTipdesde, lxCalcprecMatdesde, lxCalcprecTiphasta, lxCalcprecMathasta, lxCalcprecGrudesde, lxCalcprecAltdesde, lxCalcprecGruhasta, lxCalcprecAlthasta, lxCalcprecModdesde, lxCalcprecTradesde, lxCalcprecUsacomb, lxCalcprecModhasta, lxCalcprecTrahasta, lxCalcprecUalta, lxCalcprecImpdesde, lxCalcprecUmod, lxCalcprecMobs, lxCalcprecImphasta, lxCalcprecExpdesde, lxCalcprecExphasta, lxCalcprecCompdesde, lxCalcprecComphasta, lxCalcprecFtsadesde, lxCalcprecFtsahasta, lxCalcprecPrecdesde, lxCalcprecPrechasta, lxCalcprecMarcadesde, lxCalcprecMarcahasta
				lxCalcprecFecexpo =  .Fechaexpo			lxCalcprecFaltafw =  .Fechaaltafw			lxCalcprecFecimpo =  .Fechaimpo			lxCalcprecFmodifw =  .Fechamodificacionfw			lxCalcprecFectrans =  .Fechatransferencia			lxCalcprecCodigo =  .Codigo			lxCalcprecUaltafw =  .Usuarioaltafw			lxCalcprecSmodifw =  .Seriemodificacionfw			lxCalcprecValtafw =  .Versionaltafw			lxCalcprecHoraexpo =  .Horaexpo			lxCalcprecVmodifw =  .Versionmodificacionfw			lxCalcprecUmodifw =  .Usuariomodificacionfw			lxCalcprecBdaltafw =  .Basededatosaltafw			lxCalcprecEsttrans =  .Estadotransferencia			lxCalcprecHaltafw =  .Horaaltafw			lxCalcprecBdmodifw =  .Basededatosmodificacionfw			lxCalcprecDescfw =  .Descripcionfw			lxCalcprecHmodifw =  .Horamodificacionfw			lxCalcprecHoraimpo =  .Horaimpo			lxCalcprecSaltafw =  .Seriealtafw			lxCalcprecZadsfw =  .Zadsfw			lxCalcprecTimestamp = goLibrerias.ObtenerTimestamp()			lxCalcprecAnulado =  .Anulado			lxCalcprecDescrip =  .Descripcion			lxCalcprecArtdesde =  upper( .f_Articulo_Desde_PK ) 			lxCalcprecUnidesde =  upper( .f_Articulo_UnidadDeMedida_Desde_PK ) 			lxCalcprecFecha =  .Fecha			lxCalcprecArthasta =  upper( .f_Articulo_Hasta_PK ) 			lxCalcprecUnihasta =  upper( .f_Articulo_UnidadDeMedida_Hasta_PK ) 			lxCalcprecFproceso =  .Fechaproceso			lxCalcprecFechabase =  .Fechabase			lxCalcprecColdesde =  upper( .f_Color_desde_PK ) 			lxCalcprecFamdesde =  upper( .f_Articulo_Familia_Desde_PK ) 			lxCalcprecColhasta =  upper( .f_Color_hasta_PK ) 			lxCalcprecFamhasta =  upper( .f_Articulo_Familia_Hasta_PK ) 			lxCalcprecFechavig =  .Fechavigencia			lxCalcprecSintransac =  .Importarsintransaccion			lxCalcprecTaldesde =  upper( .f_Talle_Desde_PK ) 			lxCalcprecLindesde =  upper( .f_Articulo_Linea_Desde_PK ) 			lxCalcprecTalhasta =  upper( .f_Talle_Hasta_PK ) 			lxCalcprecLinhasta =  upper( .f_Articulo_Linea_Hasta_PK ) 			lxCalcprecComporta =  .Articulo_comportamiento			lxCalcprecCatdesde =  upper( .f_Articulo_CategoriaDeArticulo_Desde_PK ) 			lxCalcprecProvdesde =  upper( .f_Articulo_Proveedor_Desde_PK ) 			lxCalcprecKpxpartic =  .Preciokitpackxparticipante			lxCalcprecCathasta =  upper( .f_Articulo_CategoriaDeArticulo_Hasta_PK ) 			lxCalcprecProvhasta =  upper( .f_Articulo_Proveedor_Hasta_PK ) 			lxCalcprecPdcdesde =  upper( .f_Articulo_PaletaDeColores_Desde_PK ) 			lxCalcprecCdtdesde =  upper( .f_Articulo_CurvaDeTalles_Desde_PK ) 			lxCalcprecNarbadesde =  upper( .f_Articulo_Nomenclador_Desde_PK ) 			lxCalcprecTemdesde =  upper( .f_Articulo_Temporada_Desde_PK ) 			lxCalcprecPdchasta =  upper( .f_Articulo_PaletaDeColores_Hasta_PK ) 			lxCalcprecCdthasta =  upper( .f_Articulo_CurvaDeTalles_Hasta_PK ) 			lxCalcprecNarbahasta =  upper( .f_Articulo_Nomenclador_Hasta_PK ) 			lxCalcprecTemhasta =  upper( .f_Articulo_Temporada_Hasta_PK ) 			lxCalcprecAnodesde =  .F_articulo_ano_desde			lxCalcprecCladesde =  upper( .f_Articulo_Clasificacion_Desde_PK ) 			lxCalcprecAnohasta =  .F_articulo_ano_hasta			lxCalcprecClahasta =  upper( .f_Articulo_Clasificacion_Hasta_PK ) 			lxCalcprecTipdesde =  upper( .f_Articulo_TipodeArticulo_Desde_PK ) 			lxCalcprecMatdesde =  upper( .f_Articulo_Material_Desde_PK ) 			lxCalcprecTiphasta =  upper( .f_Articulo_TipodeArticulo_Hasta_PK ) 			lxCalcprecMathasta =  upper( .f_Articulo_Material_Hasta_PK ) 			lxCalcprecGrudesde =  upper( .f_Articulo_Grupo_Desde_PK ) 			lxCalcprecAltdesde =  .F_articulo_fechaaltafw_desde			lxCalcprecGruhasta =  upper( .f_Articulo_Grupo_Hasta_PK ) 			lxCalcprecAlthasta =  .F_articulo_fechaaltafw_hasta			lxCalcprecModdesde =  .F_articulo_fechamodificacionfw_desde			lxCalcprecTradesde =  .F_articulo_fechatransferencia_desde			lxCalcprecUsacomb =  .Usacombinacion			lxCalcprecModhasta =  .F_articulo_fechamodificacionfw_hasta			lxCalcprecTrahasta =  .F_articulo_fechatransferencia_hasta			lxCalcprecUalta =  .F_articulo_usuarioaltafw			lxCalcprecImpdesde =  .F_articulo_fechaimpo_desde			lxCalcprecUmod =  .F_articulo_usuariomodificacionfw			lxCalcprecMobs =  .Observacion			lxCalcprecImphasta =  .F_articulo_fechaimpo_hasta			lxCalcprecExpdesde =  .F_articulo_fechaexpo_desde			lxCalcprecExphasta =  .F_articulo_fechaexpo_hasta			lxCalcprecCompdesde =  .F_articulo_comportamiento_desde			lxCalcprecComphasta =  .F_articulo_comportamiento_hasta			lxCalcprecFtsadesde =  .F_timestampalta_desde			lxCalcprecFtsahasta =  .F_timestampalta_hasta			lxCalcprecPrecdesde =  .F_preciodirecto_desde			lxCalcprecPrechasta =  .F_preciodirecto_hasta			lxCalcprecMarcadesde =  upper( .f_Articulo_Marca_Desde_PK ) 			lxCalcprecMarcahasta =  upper( .f_Articulo_Marca_Hasta_PK ) 
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxCalcprecCodigo = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.CALCPREC ( "Fecexpo","Faltafw","Fecimpo","Fmodifw","Fectrans","Codigo","Ualtafw","Smodifw","Valtafw","Horaexpo","Vmodifw","Umodifw","Bdaltafw","Esttrans","Haltafw","Bdmodifw","Descfw","Hmodifw","Horaimpo","Saltafw","Zadsfw","Timestamp","Anulado","Descrip","Artdesde","Unidesde","Fecha","Arthasta","Unihasta","Fproceso","Fechabase","Coldesde","Famdesde","Colhasta","Famhasta","Fechavig","Sintransac","Taldesde","Lindesde","Talhasta","Linhasta","Comporta","Catdesde","Provdesde","Kpxpartic","Cathasta","Provhasta","Pdcdesde","Cdtdesde","Narbadesde","Temdesde","Pdchasta","Cdthasta","Narbahasta","Temhasta","Anodesde","Cladesde","Anohasta","Clahasta","Tipdesde","Matdesde","Tiphasta","Mathasta","Grudesde","Altdesde","Gruhasta","Althasta","Moddesde","Tradesde","Usacomb","Modhasta","Trahasta","Ualta","Impdesde","Umod","Mobs","Imphasta","Expdesde","Exphasta","Compdesde","Comphasta","Ftsadesde","Ftsahasta","Precdesde","Prechasta","Marcadesde","Marcahasta" ) values ( <<"'" + this.ConvertirDateSql( lxCalcprecFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCalcprecFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCalcprecFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCalcprecFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCalcprecFectrans ) + "'" >>, <<lxCalcprecCodigo >>, <<"'" + this.FormatearTextoSql( lxCalcprecUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecDescfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecZadsfw ) + "'" >>, <<lxCalcprecTimestamp >>, <<iif( lxCalcprecAnulado, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxCalcprecDescrip ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecArtdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecUnidesde ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCalcprecFecha ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecArthasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecUnihasta ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCalcprecFproceso ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCalcprecFechabase ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecColdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecFamdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecColhasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecFamhasta ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCalcprecFechavig ) + "'" >>, <<iif( lxCalcprecSintransac, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxCalcprecTaldesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecLindesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecTalhasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecLinhasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecComporta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecCatdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecProvdesde ) + "'" >>, <<iif( lxCalcprecKpxpartic, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxCalcprecCathasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecProvhasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecPdcdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecCdtdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecNarbadesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecTemdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecPdchasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecCdthasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecNarbahasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecTemhasta ) + "'" >>, <<lxCalcprecAnodesde >>, <<"'" + this.FormatearTextoSql( lxCalcprecCladesde ) + "'" >>, <<lxCalcprecAnohasta >>, <<"'" + this.FormatearTextoSql( lxCalcprecClahasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecTipdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecMatdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecTiphasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecMathasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecGrudesde ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCalcprecAltdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecGruhasta ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCalcprecAlthasta ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCalcprecModdesde ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCalcprecTradesde ) + "'" >>, <<iif( lxCalcprecUsacomb, 1, 0 ) >>, <<"'" + this.ConvertirDateSql( lxCalcprecModhasta ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCalcprecTrahasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecUalta ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCalcprecImpdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecUmod ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecMobs ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCalcprecImphasta ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCalcprecExpdesde ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCalcprecExphasta ) + "'" >>, <<lxCalcprecCompdesde >>, <<lxCalcprecComphasta >>, <<lxCalcprecFtsadesde >>, <<lxCalcprecFtsahasta >>, <<lxCalcprecPrecdesde >>, <<lxCalcprecPrechasta >>, <<"'" + this.FormatearTextoSql( lxCalcprecMarcadesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecMarcahasta ) + "'" >> )
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
		this.ComprobarTransaccion()
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = lxValorClavePrimaria


			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ModPrecios
				if this.oEntidad.ModPrecios.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxLprecio_PK = loItem.Lprecio_PK
					lxLpreciodetalle = loItem.Lpreciodetalle
					lxAccion = loItem.Accion
					lxLprecioa_PK = loItem.Lprecioa_PK
					lxValor = loItem.Valor
					lxFormula_PK = loItem.Formula_PK
					lxRedondeo_PK = loItem.Redondeo_PK
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.CALCPRECDET("Codigo","NROITEM","LPrecio","LPrecioNom","Accion","LPrecioA","Valor","Formula","Redondeo" ) values ( <<transform( lxValorClavePrimaria )>>, <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxLprecio_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxLpreciodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxAccion ) + "'">>, <<"'" + this.FormatearTextoSql( lxLprecioa_PK ) + "'">>, <<lxValor>>, <<"'" + this.FormatearTextoSql( lxFormula_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxRedondeo_PK ) + "'">> ) 
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
		this.oEntidad.Timestamp = lxCalcprecTimestamp
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
			if .lAnular
				.Limpiar()
				.CargarAtributosAnulacion()
			endif
			local  lxCalcprecFecexpo, lxCalcprecFaltafw, lxCalcprecFecimpo, lxCalcprecFmodifw, lxCalcprecFectrans, lxCalcprecCodigo, lxCalcprecUaltafw, lxCalcprecSmodifw, lxCalcprecValtafw, lxCalcprecHoraexpo, lxCalcprecVmodifw, lxCalcprecUmodifw, lxCalcprecBdaltafw, lxCalcprecEsttrans, lxCalcprecHaltafw, lxCalcprecBdmodifw, lxCalcprecDescfw, lxCalcprecHmodifw, lxCalcprecHoraimpo, lxCalcprecSaltafw, lxCalcprecZadsfw, lxCalcprecTimestamp, lxCalcprecAnulado, lxCalcprecDescrip, lxCalcprecArtdesde, lxCalcprecUnidesde, lxCalcprecFecha, lxCalcprecArthasta, lxCalcprecUnihasta, lxCalcprecFproceso, lxCalcprecFechabase, lxCalcprecColdesde, lxCalcprecFamdesde, lxCalcprecColhasta, lxCalcprecFamhasta, lxCalcprecFechavig, lxCalcprecSintransac, lxCalcprecTaldesde, lxCalcprecLindesde, lxCalcprecTalhasta, lxCalcprecLinhasta, lxCalcprecComporta, lxCalcprecCatdesde, lxCalcprecProvdesde, lxCalcprecKpxpartic, lxCalcprecCathasta, lxCalcprecProvhasta, lxCalcprecPdcdesde, lxCalcprecCdtdesde, lxCalcprecNarbadesde, lxCalcprecTemdesde, lxCalcprecPdchasta, lxCalcprecCdthasta, lxCalcprecNarbahasta, lxCalcprecTemhasta, lxCalcprecAnodesde, lxCalcprecCladesde, lxCalcprecAnohasta, lxCalcprecClahasta, lxCalcprecTipdesde, lxCalcprecMatdesde, lxCalcprecTiphasta, lxCalcprecMathasta, lxCalcprecGrudesde, lxCalcprecAltdesde, lxCalcprecGruhasta, lxCalcprecAlthasta, lxCalcprecModdesde, lxCalcprecTradesde, lxCalcprecUsacomb, lxCalcprecModhasta, lxCalcprecTrahasta, lxCalcprecUalta, lxCalcprecImpdesde, lxCalcprecUmod, lxCalcprecMobs, lxCalcprecImphasta, lxCalcprecExpdesde, lxCalcprecExphasta, lxCalcprecCompdesde, lxCalcprecComphasta, lxCalcprecFtsadesde, lxCalcprecFtsahasta, lxCalcprecPrecdesde, lxCalcprecPrechasta, lxCalcprecMarcadesde, lxCalcprecMarcahasta
				lxCalcprecFecexpo =  .Fechaexpo			lxCalcprecFaltafw =  .Fechaaltafw			lxCalcprecFecimpo =  .Fechaimpo			lxCalcprecFmodifw =  .Fechamodificacionfw			lxCalcprecFectrans =  .Fechatransferencia			lxCalcprecCodigo =  .Codigo			lxCalcprecUaltafw =  .Usuarioaltafw			lxCalcprecSmodifw =  .Seriemodificacionfw			lxCalcprecValtafw =  .Versionaltafw			lxCalcprecHoraexpo =  .Horaexpo			lxCalcprecVmodifw =  .Versionmodificacionfw			lxCalcprecUmodifw =  .Usuariomodificacionfw			lxCalcprecBdaltafw =  .Basededatosaltafw			lxCalcprecEsttrans =  .Estadotransferencia			lxCalcprecHaltafw =  .Horaaltafw			lxCalcprecBdmodifw =  .Basededatosmodificacionfw			lxCalcprecDescfw =  .Descripcionfw			lxCalcprecHmodifw =  .Horamodificacionfw			lxCalcprecHoraimpo =  .Horaimpo			lxCalcprecSaltafw =  .Seriealtafw			lxCalcprecZadsfw =  .Zadsfw			lxCalcprecTimestamp = goLibrerias.ObtenerTimestamp()			lxCalcprecAnulado =  .Anulado			lxCalcprecDescrip =  .Descripcion			lxCalcprecArtdesde =  upper( .f_Articulo_Desde_PK ) 			lxCalcprecUnidesde =  upper( .f_Articulo_UnidadDeMedida_Desde_PK ) 			lxCalcprecFecha =  .Fecha			lxCalcprecArthasta =  upper( .f_Articulo_Hasta_PK ) 			lxCalcprecUnihasta =  upper( .f_Articulo_UnidadDeMedida_Hasta_PK ) 			lxCalcprecFproceso =  .Fechaproceso			lxCalcprecFechabase =  .Fechabase			lxCalcprecColdesde =  upper( .f_Color_desde_PK ) 			lxCalcprecFamdesde =  upper( .f_Articulo_Familia_Desde_PK ) 			lxCalcprecColhasta =  upper( .f_Color_hasta_PK ) 			lxCalcprecFamhasta =  upper( .f_Articulo_Familia_Hasta_PK ) 			lxCalcprecFechavig =  .Fechavigencia			lxCalcprecSintransac =  .Importarsintransaccion			lxCalcprecTaldesde =  upper( .f_Talle_Desde_PK ) 			lxCalcprecLindesde =  upper( .f_Articulo_Linea_Desde_PK ) 			lxCalcprecTalhasta =  upper( .f_Talle_Hasta_PK ) 			lxCalcprecLinhasta =  upper( .f_Articulo_Linea_Hasta_PK ) 			lxCalcprecComporta =  .Articulo_comportamiento			lxCalcprecCatdesde =  upper( .f_Articulo_CategoriaDeArticulo_Desde_PK ) 			lxCalcprecProvdesde =  upper( .f_Articulo_Proveedor_Desde_PK ) 			lxCalcprecKpxpartic =  .Preciokitpackxparticipante			lxCalcprecCathasta =  upper( .f_Articulo_CategoriaDeArticulo_Hasta_PK ) 			lxCalcprecProvhasta =  upper( .f_Articulo_Proveedor_Hasta_PK ) 			lxCalcprecPdcdesde =  upper( .f_Articulo_PaletaDeColores_Desde_PK ) 			lxCalcprecCdtdesde =  upper( .f_Articulo_CurvaDeTalles_Desde_PK ) 			lxCalcprecNarbadesde =  upper( .f_Articulo_Nomenclador_Desde_PK ) 			lxCalcprecTemdesde =  upper( .f_Articulo_Temporada_Desde_PK ) 			lxCalcprecPdchasta =  upper( .f_Articulo_PaletaDeColores_Hasta_PK ) 			lxCalcprecCdthasta =  upper( .f_Articulo_CurvaDeTalles_Hasta_PK ) 			lxCalcprecNarbahasta =  upper( .f_Articulo_Nomenclador_Hasta_PK ) 			lxCalcprecTemhasta =  upper( .f_Articulo_Temporada_Hasta_PK ) 			lxCalcprecAnodesde =  .F_articulo_ano_desde			lxCalcprecCladesde =  upper( .f_Articulo_Clasificacion_Desde_PK ) 			lxCalcprecAnohasta =  .F_articulo_ano_hasta			lxCalcprecClahasta =  upper( .f_Articulo_Clasificacion_Hasta_PK ) 			lxCalcprecTipdesde =  upper( .f_Articulo_TipodeArticulo_Desde_PK ) 			lxCalcprecMatdesde =  upper( .f_Articulo_Material_Desde_PK ) 			lxCalcprecTiphasta =  upper( .f_Articulo_TipodeArticulo_Hasta_PK ) 			lxCalcprecMathasta =  upper( .f_Articulo_Material_Hasta_PK ) 			lxCalcprecGrudesde =  upper( .f_Articulo_Grupo_Desde_PK ) 			lxCalcprecAltdesde =  .F_articulo_fechaaltafw_desde			lxCalcprecGruhasta =  upper( .f_Articulo_Grupo_Hasta_PK ) 			lxCalcprecAlthasta =  .F_articulo_fechaaltafw_hasta			lxCalcprecModdesde =  .F_articulo_fechamodificacionfw_desde			lxCalcprecTradesde =  .F_articulo_fechatransferencia_desde			lxCalcprecUsacomb =  .Usacombinacion			lxCalcprecModhasta =  .F_articulo_fechamodificacionfw_hasta			lxCalcprecTrahasta =  .F_articulo_fechatransferencia_hasta			lxCalcprecUalta =  .F_articulo_usuarioaltafw			lxCalcprecImpdesde =  .F_articulo_fechaimpo_desde			lxCalcprecUmod =  .F_articulo_usuariomodificacionfw			lxCalcprecMobs =  .Observacion			lxCalcprecImphasta =  .F_articulo_fechaimpo_hasta			lxCalcprecExpdesde =  .F_articulo_fechaexpo_desde			lxCalcprecExphasta =  .F_articulo_fechaexpo_hasta			lxCalcprecCompdesde =  .F_articulo_comportamiento_desde			lxCalcprecComphasta =  .F_articulo_comportamiento_hasta			lxCalcprecFtsadesde =  .F_timestampalta_desde			lxCalcprecFtsahasta =  .F_timestampalta_hasta			lxCalcprecPrecdesde =  .F_preciodirecto_desde			lxCalcprecPrechasta =  .F_preciodirecto_hasta			lxCalcprecMarcadesde =  upper( .f_Articulo_Marca_Desde_PK ) 			lxCalcprecMarcahasta =  upper( .f_Articulo_Marca_Hasta_PK ) 
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
				update ZooLogic.CALCPREC set "Fecexpo" = <<"'" + this.ConvertirDateSql( lxCalcprecFecexpo ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxCalcprecFaltafw ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxCalcprecFecimpo ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxCalcprecFmodifw ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxCalcprecFectrans ) + "'">>,"Codigo" = <<lxCalcprecCodigo>>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxCalcprecUaltafw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxCalcprecSmodifw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxCalcprecValtafw ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxCalcprecHoraexpo ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxCalcprecVmodifw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxCalcprecUmodifw ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxCalcprecBdaltafw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxCalcprecEsttrans ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxCalcprecHaltafw ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxCalcprecBdmodifw ) + "'">>,"Descfw" = <<"'" + this.FormatearTextoSql( lxCalcprecDescfw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxCalcprecHmodifw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxCalcprecHoraimpo ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxCalcprecSaltafw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxCalcprecZadsfw ) + "'">>,"Timestamp" = <<lxCalcprecTimestamp>>,"Anulado" = <<iif( lxCalcprecAnulado, 1, 0 )>>,"Descrip" = <<"'" + this.FormatearTextoSql( lxCalcprecDescrip ) + "'">>,"Artdesde" = <<"'" + this.FormatearTextoSql( lxCalcprecArtdesde ) + "'">>,"Unidesde" = <<"'" + this.FormatearTextoSql( lxCalcprecUnidesde ) + "'">>,"Fecha" = <<"'" + this.ConvertirDateSql( lxCalcprecFecha ) + "'">>,"Arthasta" = <<"'" + this.FormatearTextoSql( lxCalcprecArthasta ) + "'">>,"Unihasta" = <<"'" + this.FormatearTextoSql( lxCalcprecUnihasta ) + "'">>,"Fproceso" = <<"'" + this.ConvertirDateSql( lxCalcprecFproceso ) + "'">>,"Fechabase" = <<"'" + this.ConvertirDateSql( lxCalcprecFechabase ) + "'">>,"Coldesde" = <<"'" + this.FormatearTextoSql( lxCalcprecColdesde ) + "'">>,"Famdesde" = <<"'" + this.FormatearTextoSql( lxCalcprecFamdesde ) + "'">>,"Colhasta" = <<"'" + this.FormatearTextoSql( lxCalcprecColhasta ) + "'">>,"Famhasta" = <<"'" + this.FormatearTextoSql( lxCalcprecFamhasta ) + "'">>,"Fechavig" = <<"'" + this.ConvertirDateSql( lxCalcprecFechavig ) + "'">>,"Sintransac" = <<iif( lxCalcprecSintransac, 1, 0 )>>,"Taldesde" = <<"'" + this.FormatearTextoSql( lxCalcprecTaldesde ) + "'">>,"Lindesde" = <<"'" + this.FormatearTextoSql( lxCalcprecLindesde ) + "'">>,"Talhasta" = <<"'" + this.FormatearTextoSql( lxCalcprecTalhasta ) + "'">>,"Linhasta" = <<"'" + this.FormatearTextoSql( lxCalcprecLinhasta ) + "'">>,"Comporta" = <<"'" + this.FormatearTextoSql( lxCalcprecComporta ) + "'">>,"Catdesde" = <<"'" + this.FormatearTextoSql( lxCalcprecCatdesde ) + "'">>,"Provdesde" = <<"'" + this.FormatearTextoSql( lxCalcprecProvdesde ) + "'">>,"Kpxpartic" = <<iif( lxCalcprecKpxpartic, 1, 0 )>>,"Cathasta" = <<"'" + this.FormatearTextoSql( lxCalcprecCathasta ) + "'">>,"Provhasta" = <<"'" + this.FormatearTextoSql( lxCalcprecProvhasta ) + "'">>,"Pdcdesde" = <<"'" + this.FormatearTextoSql( lxCalcprecPdcdesde ) + "'">>,"Cdtdesde" = <<"'" + this.FormatearTextoSql( lxCalcprecCdtdesde ) + "'">>,"Narbadesde" = <<"'" + this.FormatearTextoSql( lxCalcprecNarbadesde ) + "'">>,"Temdesde" = <<"'" + this.FormatearTextoSql( lxCalcprecTemdesde ) + "'">>,"Pdchasta" = <<"'" + this.FormatearTextoSql( lxCalcprecPdchasta ) + "'">>,"Cdthasta" = <<"'" + this.FormatearTextoSql( lxCalcprecCdthasta ) + "'">>,"Narbahasta" = <<"'" + this.FormatearTextoSql( lxCalcprecNarbahasta ) + "'">>,"Temhasta" = <<"'" + this.FormatearTextoSql( lxCalcprecTemhasta ) + "'">>,"Anodesde" = <<lxCalcprecAnodesde>>,"Cladesde" = <<"'" + this.FormatearTextoSql( lxCalcprecCladesde ) + "'">>,"Anohasta" = <<lxCalcprecAnohasta>>,"Clahasta" = <<"'" + this.FormatearTextoSql( lxCalcprecClahasta ) + "'">>,"Tipdesde" = <<"'" + this.FormatearTextoSql( lxCalcprecTipdesde ) + "'">>,"Matdesde" = <<"'" + this.FormatearTextoSql( lxCalcprecMatdesde ) + "'">>,"Tiphasta" = <<"'" + this.FormatearTextoSql( lxCalcprecTiphasta ) + "'">>,"Mathasta" = <<"'" + this.FormatearTextoSql( lxCalcprecMathasta ) + "'">>,"Grudesde" = <<"'" + this.FormatearTextoSql( lxCalcprecGrudesde ) + "'">>,"Altdesde" = <<"'" + this.ConvertirDateSql( lxCalcprecAltdesde ) + "'">>,"Gruhasta" = <<"'" + this.FormatearTextoSql( lxCalcprecGruhasta ) + "'">>,"Althasta" = <<"'" + this.ConvertirDateSql( lxCalcprecAlthasta ) + "'">>,"Moddesde" = <<"'" + this.ConvertirDateSql( lxCalcprecModdesde ) + "'">>,"Tradesde" = <<"'" + this.ConvertirDateSql( lxCalcprecTradesde ) + "'">>,"Usacomb" = <<iif( lxCalcprecUsacomb, 1, 0 )>>,"Modhasta" = <<"'" + this.ConvertirDateSql( lxCalcprecModhasta ) + "'">>,"Trahasta" = <<"'" + this.ConvertirDateSql( lxCalcprecTrahasta ) + "'">>,"Ualta" = <<"'" + this.FormatearTextoSql( lxCalcprecUalta ) + "'">>,"Impdesde" = <<"'" + this.ConvertirDateSql( lxCalcprecImpdesde ) + "'">>,"Umod" = <<"'" + this.FormatearTextoSql( lxCalcprecUmod ) + "'">>,"Mobs" = <<"'" + this.FormatearTextoSql( lxCalcprecMobs ) + "'">>,"Imphasta" = <<"'" + this.ConvertirDateSql( lxCalcprecImphasta ) + "'">>,"Expdesde" = <<"'" + this.ConvertirDateSql( lxCalcprecExpdesde ) + "'">>,"Exphasta" = <<"'" + this.ConvertirDateSql( lxCalcprecExphasta ) + "'">>,"Compdesde" = <<lxCalcprecCompdesde>>,"Comphasta" = <<lxCalcprecComphasta>>,"Ftsadesde" = <<lxCalcprecFtsadesde>>,"Ftsahasta" = <<lxCalcprecFtsahasta>>,"Precdesde" = <<lxCalcprecPrecdesde>>,"Prechasta" = <<lxCalcprecPrechasta>>,"Marcadesde" = <<"'" + this.FormatearTextoSql( lxCalcprecMarcadesde ) + "'">>,"Marcahasta" = <<"'" + this.FormatearTextoSql( lxCalcprecMarcahasta ) + "'">> where "Codigo" = <<lxCalcprecCodigo>> and  CALCPREC.CODIGO != 0 << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			this.ComprobarResultadoDeEjecucionDelUpdate()
		this.ComprobarTransaccion()
			this.oConexion.EjecutarSql( 'delete from ZooLogic.CALCPRECDET where "CODIGO" = ' + transform( .oEntidad.CODIGO ) )

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ModPrecios
				if this.oEntidad.ModPrecios.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxLprecio_PK = loItem.Lprecio_PK
					lxLpreciodetalle = loItem.Lpreciodetalle
					lxAccion = loItem.Accion
					lxLprecioa_PK = loItem.Lprecioa_PK
					lxValor = loItem.Valor
					lxFormula_PK = loItem.Formula_PK
					lxRedondeo_PK = loItem.Redondeo_PK
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.CALCPRECDET("Codigo","NROITEM","LPrecio","LPrecioNom","Accion","LPrecioA","Valor","Formula","Redondeo" ) values ( <<transform( lxValorClavePrimaria )>>, <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxLprecio_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxLpreciodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxAccion ) + "'">>, <<"'" + this.FormatearTextoSql( lxLprecioa_PK ) + "'">>, <<lxValor>>, <<"'" + this.FormatearTextoSql( lxFormula_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxRedondeo_PK ) + "'">> ) 
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
		this.oEntidad.Timestamp = lxCalcprecTimestamp
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 CODIGO from ZooLogic.CALCPREC where " + this.ConvertirFuncionesSql( " CALCPREC.CODIGO != 0" ) )
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
			Local lxCalcprecCodigo
			lxCalcprecCodigo = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Codigo" as "Codigo", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Valtafw" as "Versionaltafw", "Horaexpo" as "Horaexpo", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Descfw" as "Descripcionfw", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Zadsfw" as "Zadsfw", "Timestamp" as "Timestamp", "Anulado" as "Anulado", "Descrip" as "Descripcion", "Artdesde" as "F_articulo_desde", "Unidesde" as "F_articulo_unidaddemedida_desde", "Fecha" as "Fecha", "Arthasta" as "F_articulo_hasta", "Unihasta" as "F_articulo_unidaddemedida_hasta", "Fproceso" as "Fechaproceso", "Fechabase" as "Fechabase", "Coldesde" as "F_color_desde", "Famdesde" as "F_articulo_familia_desde", "Colhasta" as "F_color_hasta", "Famhasta" as "F_articulo_familia_hasta", "Fechavig" as "Fechavigencia", "Sintransac" as "Importarsintransaccion", "Taldesde" as "F_talle_desde", "Lindesde" as "F_articulo_linea_desde", "Talhasta" as "F_talle_hasta", "Linhasta" as "F_articulo_linea_hasta", "Comporta" as "Articulo_comportamiento", "Catdesde" as "F_articulo_categoriadearticulo_desde", "Provdesde" as "F_articulo_proveedor_desde", "Kpxpartic" as "Preciokitpackxparticipante", "Cathasta" as "F_articulo_categoriadearticulo_hasta", "Provhasta" as "F_articulo_proveedor_hasta", "Pdcdesde" as "F_articulo_paletadecolores_desde", "Cdtdesde" as "F_articulo_curvadetalles_desde", "Narbadesde" as "F_articulo_nomenclador_desde", "Temdesde" as "F_articulo_temporada_desde", "Pdchasta" as "F_articulo_paletadecolores_hasta", "Cdthasta" as "F_articulo_curvadetalles_hasta", "Narbahasta" as "F_articulo_nomenclador_hasta", "Temhasta" as "F_articulo_temporada_hasta", "Anodesde" as "F_articulo_ano_desde", "Cladesde" as "F_articulo_clasificacion_desde", "Anohasta" as "F_articulo_ano_hasta", "Clahasta" as "F_articulo_clasificacion_hasta", "Tipdesde" as "F_articulo_tipodearticulo_desde", "Matdesde" as "F_articulo_material_desde", "Tiphasta" as "F_articulo_tipodearticulo_hasta", "Mathasta" as "F_articulo_material_hasta", "Grudesde" as "F_articulo_grupo_desde", "Altdesde" as "F_articulo_fechaaltafw_desde", "Gruhasta" as "F_articulo_grupo_hasta", "Althasta" as "F_articulo_fechaaltafw_hasta", "Moddesde" as "F_articulo_fechamodificacionfw_desde", "Tradesde" as "F_articulo_fechatransferencia_desde", "Usacomb" as "Usacombinacion", "Modhasta" as "F_articulo_fechamodificacionfw_hasta", "Trahasta" as "F_articulo_fechatransferencia_hasta", "Ualta" as "F_articulo_usuarioaltafw", "Impdesde" as "F_articulo_fechaimpo_desde", "Umod" as "F_articulo_usuariomodificacionfw", "Mobs" as "Observacion", "Imphasta" as "F_articulo_fechaimpo_hasta", "Expdesde" as "F_articulo_fechaexpo_desde", "Exphasta" as "F_articulo_fechaexpo_hasta", "Compdesde" as "F_articulo_comportamiento_desde", "Comphasta" as "F_articulo_comportamiento_hasta", "Ftsadesde" as "F_timestampalta_desde", "Ftsahasta" as "F_timestampalta_hasta", "Precdesde" as "F_preciodirecto_desde", "Prechasta" as "F_preciodirecto_hasta", "Marcadesde" as "F_articulo_marca_desde", "Marcahasta" as "F_articulo_marca_hasta" from ZooLogic.CALCPREC where "Codigo" = <<lxCalcprecCodigo>> and  CALCPREC.CODIGO != 0
			endtext
			use in select('c_CALCULODEPRECIOS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CALCULODEPRECIOS', set( 'Datasession' ) )

			if reccount( 'c_CALCULODEPRECIOS' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Codigo" as "Codigo", "Nroitem" as "Nroitem", "Lprecio" as "Lprecio", "Lprecionom" as "Lpreciodetalle", "Accion" as "Accion", "Lprecioa" as "Lprecioa", "Valor" as "Valor", "Formula" as "Formula", "Redondeo" as "Redondeo" from ZooLogic.CALCPRECDET where CODIGO = <<transform( c_CALCULODEPRECIOS.CODIGO )>> Order by NroItem
			endtext
			use in select('c_ModPrecios')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ModPrecios', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ModPrecios
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxCalcprecCodigo as Variant
		llRetorno = .t.
		lxCalcprecCodigo = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.CALCPREC where "Codigo" = <<lxCalcprecCodigo>> and  CALCPREC.CODIGO != 0
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
				lcOrden =  str( .Codigo, 8, 0)
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Codigo" as "Codigo", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Valtafw" as "Versionaltafw", "Horaexpo" as "Horaexpo", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Descfw" as "Descripcionfw", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Zadsfw" as "Zadsfw", "Timestamp" as "Timestamp", "Anulado" as "Anulado", "Descrip" as "Descripcion", "Artdesde" as "F_articulo_desde", "Unidesde" as "F_articulo_unidaddemedida_desde", "Fecha" as "Fecha", "Arthasta" as "F_articulo_hasta", "Unihasta" as "F_articulo_unidaddemedida_hasta", "Fproceso" as "Fechaproceso", "Fechabase" as "Fechabase", "Coldesde" as "F_color_desde", "Famdesde" as "F_articulo_familia_desde", "Colhasta" as "F_color_hasta", "Famhasta" as "F_articulo_familia_hasta", "Fechavig" as "Fechavigencia", "Sintransac" as "Importarsintransaccion", "Taldesde" as "F_talle_desde", "Lindesde" as "F_articulo_linea_desde", "Talhasta" as "F_talle_hasta", "Linhasta" as "F_articulo_linea_hasta", "Comporta" as "Articulo_comportamiento", "Catdesde" as "F_articulo_categoriadearticulo_desde", "Provdesde" as "F_articulo_proveedor_desde", "Kpxpartic" as "Preciokitpackxparticipante", "Cathasta" as "F_articulo_categoriadearticulo_hasta", "Provhasta" as "F_articulo_proveedor_hasta", "Pdcdesde" as "F_articulo_paletadecolores_desde", "Cdtdesde" as "F_articulo_curvadetalles_desde", "Narbadesde" as "F_articulo_nomenclador_desde", "Temdesde" as "F_articulo_temporada_desde", "Pdchasta" as "F_articulo_paletadecolores_hasta", "Cdthasta" as "F_articulo_curvadetalles_hasta", "Narbahasta" as "F_articulo_nomenclador_hasta", "Temhasta" as "F_articulo_temporada_hasta", "Anodesde" as "F_articulo_ano_desde", "Cladesde" as "F_articulo_clasificacion_desde", "Anohasta" as "F_articulo_ano_hasta", "Clahasta" as "F_articulo_clasificacion_hasta", "Tipdesde" as "F_articulo_tipodearticulo_desde", "Matdesde" as "F_articulo_material_desde", "Tiphasta" as "F_articulo_tipodearticulo_hasta", "Mathasta" as "F_articulo_material_hasta", "Grudesde" as "F_articulo_grupo_desde", "Altdesde" as "F_articulo_fechaaltafw_desde", "Gruhasta" as "F_articulo_grupo_hasta", "Althasta" as "F_articulo_fechaaltafw_hasta", "Moddesde" as "F_articulo_fechamodificacionfw_desde", "Tradesde" as "F_articulo_fechatransferencia_desde", "Usacomb" as "Usacombinacion", "Modhasta" as "F_articulo_fechamodificacionfw_hasta", "Trahasta" as "F_articulo_fechatransferencia_hasta", "Ualta" as "F_articulo_usuarioaltafw", "Impdesde" as "F_articulo_fechaimpo_desde", "Umod" as "F_articulo_usuariomodificacionfw", "Mobs" as "Observacion", "Imphasta" as "F_articulo_fechaimpo_hasta", "Expdesde" as "F_articulo_fechaexpo_desde", "Exphasta" as "F_articulo_fechaexpo_hasta", "Compdesde" as "F_articulo_comportamiento_desde", "Comphasta" as "F_articulo_comportamiento_hasta", "Ftsadesde" as "F_timestampalta_desde", "Ftsahasta" as "F_timestampalta_hasta", "Precdesde" as "F_preciodirecto_desde", "Prechasta" as "F_preciodirecto_hasta", "Marcadesde" as "F_articulo_marca_desde", "Marcahasta" as "F_articulo_marca_hasta" from ZooLogic.CALCPREC where  CALCPREC.CODIGO != 0 order by CODIGO
			endtext
			use in select('c_CALCULODEPRECIOS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CALCULODEPRECIOS', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Codigo" as "Codigo", "Nroitem" as "Nroitem", "Lprecio" as "Lprecio", "Lprecionom" as "Lpreciodetalle", "Accion" as "Accion", "Lprecioa" as "Lprecioa", "Valor" as "Valor", "Formula" as "Formula", "Redondeo" as "Redondeo" from ZooLogic.CALCPRECDET where CODIGO = <<transform( c_CALCULODEPRECIOS.CODIGO )>> Order by NroItem
			endtext
			use in select('c_ModPrecios')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ModPrecios', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ModPrecios
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
				lcOrden =  str( .Codigo, 8, 0)
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Codigo" as "Codigo", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Valtafw" as "Versionaltafw", "Horaexpo" as "Horaexpo", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Descfw" as "Descripcionfw", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Zadsfw" as "Zadsfw", "Timestamp" as "Timestamp", "Anulado" as "Anulado", "Descrip" as "Descripcion", "Artdesde" as "F_articulo_desde", "Unidesde" as "F_articulo_unidaddemedida_desde", "Fecha" as "Fecha", "Arthasta" as "F_articulo_hasta", "Unihasta" as "F_articulo_unidaddemedida_hasta", "Fproceso" as "Fechaproceso", "Fechabase" as "Fechabase", "Coldesde" as "F_color_desde", "Famdesde" as "F_articulo_familia_desde", "Colhasta" as "F_color_hasta", "Famhasta" as "F_articulo_familia_hasta", "Fechavig" as "Fechavigencia", "Sintransac" as "Importarsintransaccion", "Taldesde" as "F_talle_desde", "Lindesde" as "F_articulo_linea_desde", "Talhasta" as "F_talle_hasta", "Linhasta" as "F_articulo_linea_hasta", "Comporta" as "Articulo_comportamiento", "Catdesde" as "F_articulo_categoriadearticulo_desde", "Provdesde" as "F_articulo_proveedor_desde", "Kpxpartic" as "Preciokitpackxparticipante", "Cathasta" as "F_articulo_categoriadearticulo_hasta", "Provhasta" as "F_articulo_proveedor_hasta", "Pdcdesde" as "F_articulo_paletadecolores_desde", "Cdtdesde" as "F_articulo_curvadetalles_desde", "Narbadesde" as "F_articulo_nomenclador_desde", "Temdesde" as "F_articulo_temporada_desde", "Pdchasta" as "F_articulo_paletadecolores_hasta", "Cdthasta" as "F_articulo_curvadetalles_hasta", "Narbahasta" as "F_articulo_nomenclador_hasta", "Temhasta" as "F_articulo_temporada_hasta", "Anodesde" as "F_articulo_ano_desde", "Cladesde" as "F_articulo_clasificacion_desde", "Anohasta" as "F_articulo_ano_hasta", "Clahasta" as "F_articulo_clasificacion_hasta", "Tipdesde" as "F_articulo_tipodearticulo_desde", "Matdesde" as "F_articulo_material_desde", "Tiphasta" as "F_articulo_tipodearticulo_hasta", "Mathasta" as "F_articulo_material_hasta", "Grudesde" as "F_articulo_grupo_desde", "Altdesde" as "F_articulo_fechaaltafw_desde", "Gruhasta" as "F_articulo_grupo_hasta", "Althasta" as "F_articulo_fechaaltafw_hasta", "Moddesde" as "F_articulo_fechamodificacionfw_desde", "Tradesde" as "F_articulo_fechatransferencia_desde", "Usacomb" as "Usacombinacion", "Modhasta" as "F_articulo_fechamodificacionfw_hasta", "Trahasta" as "F_articulo_fechatransferencia_hasta", "Ualta" as "F_articulo_usuarioaltafw", "Impdesde" as "F_articulo_fechaimpo_desde", "Umod" as "F_articulo_usuariomodificacionfw", "Mobs" as "Observacion", "Imphasta" as "F_articulo_fechaimpo_hasta", "Expdesde" as "F_articulo_fechaexpo_desde", "Exphasta" as "F_articulo_fechaexpo_hasta", "Compdesde" as "F_articulo_comportamiento_desde", "Comphasta" as "F_articulo_comportamiento_hasta", "Ftsadesde" as "F_timestampalta_desde", "Ftsahasta" as "F_timestampalta_hasta", "Precdesde" as "F_preciodirecto_desde", "Prechasta" as "F_preciodirecto_hasta", "Marcadesde" as "F_articulo_marca_desde", "Marcahasta" as "F_articulo_marca_hasta" from ZooLogic.CALCPREC where  str( CODIGO, 8, 0) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  CALCPREC.CODIGO != 0 order by CODIGO
			endtext
			use in select('c_CALCULODEPRECIOS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CALCULODEPRECIOS', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Codigo" as "Codigo", "Nroitem" as "Nroitem", "Lprecio" as "Lprecio", "Lprecionom" as "Lpreciodetalle", "Accion" as "Accion", "Lprecioa" as "Lprecioa", "Valor" as "Valor", "Formula" as "Formula", "Redondeo" as "Redondeo" from ZooLogic.CALCPRECDET where CODIGO = <<transform( c_CALCULODEPRECIOS.CODIGO )>> Order by NroItem
			endtext
			use in select('c_ModPrecios')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ModPrecios', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ModPrecios
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
				lcOrden =  str( .Codigo, 8, 0)
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Codigo" as "Codigo", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Valtafw" as "Versionaltafw", "Horaexpo" as "Horaexpo", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Descfw" as "Descripcionfw", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Zadsfw" as "Zadsfw", "Timestamp" as "Timestamp", "Anulado" as "Anulado", "Descrip" as "Descripcion", "Artdesde" as "F_articulo_desde", "Unidesde" as "F_articulo_unidaddemedida_desde", "Fecha" as "Fecha", "Arthasta" as "F_articulo_hasta", "Unihasta" as "F_articulo_unidaddemedida_hasta", "Fproceso" as "Fechaproceso", "Fechabase" as "Fechabase", "Coldesde" as "F_color_desde", "Famdesde" as "F_articulo_familia_desde", "Colhasta" as "F_color_hasta", "Famhasta" as "F_articulo_familia_hasta", "Fechavig" as "Fechavigencia", "Sintransac" as "Importarsintransaccion", "Taldesde" as "F_talle_desde", "Lindesde" as "F_articulo_linea_desde", "Talhasta" as "F_talle_hasta", "Linhasta" as "F_articulo_linea_hasta", "Comporta" as "Articulo_comportamiento", "Catdesde" as "F_articulo_categoriadearticulo_desde", "Provdesde" as "F_articulo_proveedor_desde", "Kpxpartic" as "Preciokitpackxparticipante", "Cathasta" as "F_articulo_categoriadearticulo_hasta", "Provhasta" as "F_articulo_proveedor_hasta", "Pdcdesde" as "F_articulo_paletadecolores_desde", "Cdtdesde" as "F_articulo_curvadetalles_desde", "Narbadesde" as "F_articulo_nomenclador_desde", "Temdesde" as "F_articulo_temporada_desde", "Pdchasta" as "F_articulo_paletadecolores_hasta", "Cdthasta" as "F_articulo_curvadetalles_hasta", "Narbahasta" as "F_articulo_nomenclador_hasta", "Temhasta" as "F_articulo_temporada_hasta", "Anodesde" as "F_articulo_ano_desde", "Cladesde" as "F_articulo_clasificacion_desde", "Anohasta" as "F_articulo_ano_hasta", "Clahasta" as "F_articulo_clasificacion_hasta", "Tipdesde" as "F_articulo_tipodearticulo_desde", "Matdesde" as "F_articulo_material_desde", "Tiphasta" as "F_articulo_tipodearticulo_hasta", "Mathasta" as "F_articulo_material_hasta", "Grudesde" as "F_articulo_grupo_desde", "Altdesde" as "F_articulo_fechaaltafw_desde", "Gruhasta" as "F_articulo_grupo_hasta", "Althasta" as "F_articulo_fechaaltafw_hasta", "Moddesde" as "F_articulo_fechamodificacionfw_desde", "Tradesde" as "F_articulo_fechatransferencia_desde", "Usacomb" as "Usacombinacion", "Modhasta" as "F_articulo_fechamodificacionfw_hasta", "Trahasta" as "F_articulo_fechatransferencia_hasta", "Ualta" as "F_articulo_usuarioaltafw", "Impdesde" as "F_articulo_fechaimpo_desde", "Umod" as "F_articulo_usuariomodificacionfw", "Mobs" as "Observacion", "Imphasta" as "F_articulo_fechaimpo_hasta", "Expdesde" as "F_articulo_fechaexpo_desde", "Exphasta" as "F_articulo_fechaexpo_hasta", "Compdesde" as "F_articulo_comportamiento_desde", "Comphasta" as "F_articulo_comportamiento_hasta", "Ftsadesde" as "F_timestampalta_desde", "Ftsahasta" as "F_timestampalta_hasta", "Precdesde" as "F_preciodirecto_desde", "Prechasta" as "F_preciodirecto_hasta", "Marcadesde" as "F_articulo_marca_desde", "Marcahasta" as "F_articulo_marca_hasta" from ZooLogic.CALCPREC where  str( CODIGO, 8, 0) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  CALCPREC.CODIGO != 0 order by CODIGO desc
			endtext
			use in select('c_CALCULODEPRECIOS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CALCULODEPRECIOS', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Codigo" as "Codigo", "Nroitem" as "Nroitem", "Lprecio" as "Lprecio", "Lprecionom" as "Lpreciodetalle", "Accion" as "Accion", "Lprecioa" as "Lprecioa", "Valor" as "Valor", "Formula" as "Formula", "Redondeo" as "Redondeo" from ZooLogic.CALCPRECDET where CODIGO = <<transform( c_CALCULODEPRECIOS.CODIGO )>> Order by NroItem
			endtext
			use in select('c_ModPrecios')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ModPrecios', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ModPrecios
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
				lcOrden =  str( .Codigo, 8, 0)
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Codigo" as "Codigo", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Valtafw" as "Versionaltafw", "Horaexpo" as "Horaexpo", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Descfw" as "Descripcionfw", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Zadsfw" as "Zadsfw", "Timestamp" as "Timestamp", "Anulado" as "Anulado", "Descrip" as "Descripcion", "Artdesde" as "F_articulo_desde", "Unidesde" as "F_articulo_unidaddemedida_desde", "Fecha" as "Fecha", "Arthasta" as "F_articulo_hasta", "Unihasta" as "F_articulo_unidaddemedida_hasta", "Fproceso" as "Fechaproceso", "Fechabase" as "Fechabase", "Coldesde" as "F_color_desde", "Famdesde" as "F_articulo_familia_desde", "Colhasta" as "F_color_hasta", "Famhasta" as "F_articulo_familia_hasta", "Fechavig" as "Fechavigencia", "Sintransac" as "Importarsintransaccion", "Taldesde" as "F_talle_desde", "Lindesde" as "F_articulo_linea_desde", "Talhasta" as "F_talle_hasta", "Linhasta" as "F_articulo_linea_hasta", "Comporta" as "Articulo_comportamiento", "Catdesde" as "F_articulo_categoriadearticulo_desde", "Provdesde" as "F_articulo_proveedor_desde", "Kpxpartic" as "Preciokitpackxparticipante", "Cathasta" as "F_articulo_categoriadearticulo_hasta", "Provhasta" as "F_articulo_proveedor_hasta", "Pdcdesde" as "F_articulo_paletadecolores_desde", "Cdtdesde" as "F_articulo_curvadetalles_desde", "Narbadesde" as "F_articulo_nomenclador_desde", "Temdesde" as "F_articulo_temporada_desde", "Pdchasta" as "F_articulo_paletadecolores_hasta", "Cdthasta" as "F_articulo_curvadetalles_hasta", "Narbahasta" as "F_articulo_nomenclador_hasta", "Temhasta" as "F_articulo_temporada_hasta", "Anodesde" as "F_articulo_ano_desde", "Cladesde" as "F_articulo_clasificacion_desde", "Anohasta" as "F_articulo_ano_hasta", "Clahasta" as "F_articulo_clasificacion_hasta", "Tipdesde" as "F_articulo_tipodearticulo_desde", "Matdesde" as "F_articulo_material_desde", "Tiphasta" as "F_articulo_tipodearticulo_hasta", "Mathasta" as "F_articulo_material_hasta", "Grudesde" as "F_articulo_grupo_desde", "Altdesde" as "F_articulo_fechaaltafw_desde", "Gruhasta" as "F_articulo_grupo_hasta", "Althasta" as "F_articulo_fechaaltafw_hasta", "Moddesde" as "F_articulo_fechamodificacionfw_desde", "Tradesde" as "F_articulo_fechatransferencia_desde", "Usacomb" as "Usacombinacion", "Modhasta" as "F_articulo_fechamodificacionfw_hasta", "Trahasta" as "F_articulo_fechatransferencia_hasta", "Ualta" as "F_articulo_usuarioaltafw", "Impdesde" as "F_articulo_fechaimpo_desde", "Umod" as "F_articulo_usuariomodificacionfw", "Mobs" as "Observacion", "Imphasta" as "F_articulo_fechaimpo_hasta", "Expdesde" as "F_articulo_fechaexpo_desde", "Exphasta" as "F_articulo_fechaexpo_hasta", "Compdesde" as "F_articulo_comportamiento_desde", "Comphasta" as "F_articulo_comportamiento_hasta", "Ftsadesde" as "F_timestampalta_desde", "Ftsahasta" as "F_timestampalta_hasta", "Precdesde" as "F_preciodirecto_desde", "Prechasta" as "F_preciodirecto_hasta", "Marcadesde" as "F_articulo_marca_desde", "Marcahasta" as "F_articulo_marca_hasta" from ZooLogic.CALCPREC where  CALCPREC.CODIGO != 0 order by CODIGO desc
			endtext
			use in select('c_CALCULODEPRECIOS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CALCULODEPRECIOS', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Codigo" as "Codigo", "Nroitem" as "Nroitem", "Lprecio" as "Lprecio", "Lprecionom" as "Lpreciodetalle", "Accion" as "Accion", "Lprecioa" as "Lprecioa", "Valor" as "Valor", "Formula" as "Formula", "Redondeo" as "Redondeo" from ZooLogic.CALCPRECDET where CODIGO = <<transform( c_CALCULODEPRECIOS.CODIGO )>> Order by NroItem
			endtext
			use in select('c_ModPrecios')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ModPrecios', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ModPrecios
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
				lcFiltroCodigo = ' and ' + .cCampoClavePrimaria + ' <> ' + transform( .oEntidad.CODIGO )
			endif
			lcFiltro = lcCampo + ' = ' + goLibrerias.ValorAString(lxValor) + lcFiltroCodigo
			local lcXml as string
			lcXml = this.oConexion.EjecutarSql( "select Fecexpo,Faltafw,Fecimpo,Fmodifw,Fectrans,Codigo,Ualtafw,Smodifw,Valtafw,Horaexpo,Vmodifw,Umo" + ;
"difw,Bdaltafw,Esttrans,Haltafw,Bdmodifw,Descfw,Hmodifw,Horaimpo,Saltafw,Zadsfw,Timestamp,Anulado,Des" + ;
"crip,Artdesde,Unidesde,Fecha,Arthasta,Unihasta,Fproceso,Fechabase,Coldesde,Famdesde,Colhasta,Famhast" + ;
"a,Fechavig,Sintransac,Taldesde,Lindesde,Talhasta,Linhasta,Comporta,Catdesde,Provdesde,Kpxpartic,Cath" + ;
"asta,Provhasta,Pdcdesde,Cdtdesde,Narbadesde,Temdesde,Pdchasta,Cdthasta,Narbahasta,Temhasta,Anodesde," + ;
"Cladesde,Anohasta,Clahasta,Tipdesde,Matdesde,Tiphasta,Mathasta,Grudesde,Altdesde,Gruhasta,Althasta,M" + ;
"oddesde,Tradesde,Usacomb,Modhasta,Trahasta,Ualta,Impdesde,Umod,Mobs,Imphasta,Expdesde,Exphasta,Compd" + ;
"esde,Comphasta,Ftsadesde,Ftsahasta,Precdesde,Prechasta,Marcadesde,Marcahasta" + ;
" from ZooLogic.CALCPREC where  CALCPREC.CODIGO != 0 and " + lcFiltro )
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
			local  lxCalcprecFecexpo, lxCalcprecFaltafw, lxCalcprecFecimpo, lxCalcprecFmodifw, lxCalcprecFectrans, lxCalcprecCodigo, lxCalcprecUaltafw, lxCalcprecSmodifw, lxCalcprecValtafw, lxCalcprecHoraexpo, lxCalcprecVmodifw, lxCalcprecUmodifw, lxCalcprecBdaltafw, lxCalcprecEsttrans, lxCalcprecHaltafw, lxCalcprecBdmodifw, lxCalcprecDescfw, lxCalcprecHmodifw, lxCalcprecHoraimpo, lxCalcprecSaltafw, lxCalcprecZadsfw, lxCalcprecTimestamp, lxCalcprecAnulado, lxCalcprecDescrip, lxCalcprecArtdesde, lxCalcprecUnidesde, lxCalcprecFecha, lxCalcprecArthasta, lxCalcprecUnihasta, lxCalcprecFproceso, lxCalcprecFechabase, lxCalcprecColdesde, lxCalcprecFamdesde, lxCalcprecColhasta, lxCalcprecFamhasta, lxCalcprecFechavig, lxCalcprecSintransac, lxCalcprecTaldesde, lxCalcprecLindesde, lxCalcprecTalhasta, lxCalcprecLinhasta, lxCalcprecComporta, lxCalcprecCatdesde, lxCalcprecProvdesde, lxCalcprecKpxpartic, lxCalcprecCathasta, lxCalcprecProvhasta, lxCalcprecPdcdesde, lxCalcprecCdtdesde, lxCalcprecNarbadesde, lxCalcprecTemdesde, lxCalcprecPdchasta, lxCalcprecCdthasta, lxCalcprecNarbahasta, lxCalcprecTemhasta, lxCalcprecAnodesde, lxCalcprecCladesde, lxCalcprecAnohasta, lxCalcprecClahasta, lxCalcprecTipdesde, lxCalcprecMatdesde, lxCalcprecTiphasta, lxCalcprecMathasta, lxCalcprecGrudesde, lxCalcprecAltdesde, lxCalcprecGruhasta, lxCalcprecAlthasta, lxCalcprecModdesde, lxCalcprecTradesde, lxCalcprecUsacomb, lxCalcprecModhasta, lxCalcprecTrahasta, lxCalcprecUalta, lxCalcprecImpdesde, lxCalcprecUmod, lxCalcprecMobs, lxCalcprecImphasta, lxCalcprecExpdesde, lxCalcprecExphasta, lxCalcprecCompdesde, lxCalcprecComphasta, lxCalcprecFtsadesde, lxCalcprecFtsahasta, lxCalcprecPrecdesde, lxCalcprecPrechasta, lxCalcprecMarcadesde, lxCalcprecMarcahasta
				lxCalcprecFecexpo = ctod( '  /  /    ' )			lxCalcprecFaltafw = ctod( '  /  /    ' )			lxCalcprecFecimpo = ctod( '  /  /    ' )			lxCalcprecFmodifw = ctod( '  /  /    ' )			lxCalcprecFectrans = ctod( '  /  /    ' )			lxCalcprecCodigo = 0			lxCalcprecUaltafw = []			lxCalcprecSmodifw = []			lxCalcprecValtafw = []			lxCalcprecHoraexpo = []			lxCalcprecVmodifw = []			lxCalcprecUmodifw = []			lxCalcprecBdaltafw = []			lxCalcprecEsttrans = []			lxCalcprecHaltafw = []			lxCalcprecBdmodifw = []			lxCalcprecDescfw = []			lxCalcprecHmodifw = []			lxCalcprecHoraimpo = []			lxCalcprecSaltafw = []			lxCalcprecZadsfw = []			lxCalcprecTimestamp = goLibrerias.ObtenerTimestamp()			lxCalcprecAnulado = .F.			lxCalcprecDescrip = []			lxCalcprecArtdesde = []			lxCalcprecUnidesde = []			lxCalcprecFecha = ctod( '  /  /    ' )			lxCalcprecArthasta = []			lxCalcprecUnihasta = []			lxCalcprecFproceso = ctod( '  /  /    ' )			lxCalcprecFechabase = ctod( '  /  /    ' )			lxCalcprecColdesde = []			lxCalcprecFamdesde = []			lxCalcprecColhasta = []			lxCalcprecFamhasta = []			lxCalcprecFechavig = ctod( '  /  /    ' )			lxCalcprecSintransac = .F.			lxCalcprecTaldesde = []			lxCalcprecLindesde = []			lxCalcprecTalhasta = []			lxCalcprecLinhasta = []			lxCalcprecComporta = []			lxCalcprecCatdesde = []			lxCalcprecProvdesde = []			lxCalcprecKpxpartic = .F.			lxCalcprecCathasta = []			lxCalcprecProvhasta = []			lxCalcprecPdcdesde = []			lxCalcprecCdtdesde = []			lxCalcprecNarbadesde = []			lxCalcprecTemdesde = []			lxCalcprecPdchasta = []			lxCalcprecCdthasta = []			lxCalcprecNarbahasta = []			lxCalcprecTemhasta = []			lxCalcprecAnodesde = 0			lxCalcprecCladesde = []			lxCalcprecAnohasta = 0			lxCalcprecClahasta = []			lxCalcprecTipdesde = []			lxCalcprecMatdesde = []			lxCalcprecTiphasta = []			lxCalcprecMathasta = []			lxCalcprecGrudesde = []			lxCalcprecAltdesde = ctod( '  /  /    ' )			lxCalcprecGruhasta = []			lxCalcprecAlthasta = ctod( '  /  /    ' )			lxCalcprecModdesde = ctod( '  /  /    ' )			lxCalcprecTradesde = ctod( '  /  /    ' )			lxCalcprecUsacomb = .F.			lxCalcprecModhasta = ctod( '  /  /    ' )			lxCalcprecTrahasta = ctod( '  /  /    ' )			lxCalcprecUalta = []			lxCalcprecImpdesde = ctod( '  /  /    ' )			lxCalcprecUmod = []			lxCalcprecMobs = []			lxCalcprecImphasta = ctod( '  /  /    ' )			lxCalcprecExpdesde = ctod( '  /  /    ' )			lxCalcprecExphasta = ctod( '  /  /    ' )			lxCalcprecCompdesde = 0			lxCalcprecComphasta = 0			lxCalcprecFtsadesde = 0			lxCalcprecFtsahasta = 0			lxCalcprecPrecdesde = 0			lxCalcprecPrechasta = 0			lxCalcprecMarcadesde = []			lxCalcprecMarcahasta = []
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.CALCPRECDET where "CODIGO" = ' + transform( .oEntidad.CODIGO ) )
			this.oConexion.EjecutarSql( [delete from ZooLogic.CALCPREC where "CODIGO" = ] + transform( .oEntidad.CODIGO )+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'CALCPREC' + '_' + tcCampo
			lcMemoAscii = ''

			lnIndice = alen(.aSqlMemos)
			lnIndice = iif(lnIndice = 1, 1, lnIndice + 1 )
			dimension .aSqlMemos(lnIndice)

			.aSqlMemos(lnIndice) = 'delete from ' + lcTabla + ' where CODIGO = ' + txValorClavePrimaria
			.GenerarSentenciasInsertTablaMemo( lcValor, lcTabla, txValorClavePrimaria )
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerSentenciaInsertMemo( tcTabla as String, txValorClavePrimaria as String, tcOrden as String, tcTexto as String ) as String
		return "Insert  into " + tcTabla + "(CODIGO, Orden, texto ) values ( " + txValorClavePrimaria + "," + tcOrden + ",'"+ tcTexto + "')"
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosEntidad( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  CALCPREC.CODIGO != 0"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Codigo" as "Codigo", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Valtafw" as "Versionaltafw", "Horaexpo" as "Horaexpo", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Descfw" as "Descripcionfw", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Zadsfw" as "Zadsfw", "Timestamp" as "Timestamp", "Anulado" as "Anulado", "Descrip" as "Descripcion", "Artdesde" as "F_articulo_desde", "Unidesde" as "F_articulo_unidaddemedida_desde", "Fecha" as "Fecha", "Arthasta" as "F_articulo_hasta", "Unihasta" as "F_articulo_unidaddemedida_hasta", "Fproceso" as "Fechaproceso", "Fechabase" as "Fechabase", "Coldesde" as "F_color_desde", "Famdesde" as "F_articulo_familia_desde", "Colhasta" as "F_color_hasta", "Famhasta" as "F_articulo_familia_hasta", "Fechavig" as "Fechavigencia", "Sintransac" as "Importarsintransaccion", "Taldesde" as "F_talle_desde", "Lindesde" as "F_articulo_linea_desde", "Talhasta" as "F_talle_hasta", "Linhasta" as "F_articulo_linea_hasta", "Comporta" as "Articulo_comportamiento", "Catdesde" as "F_articulo_categoriadearticulo_desde", "Provdesde" as "F_articulo_proveedor_desde", "Kpxpartic" as "Preciokitpackxparticipante", "Cathasta" as "F_articulo_categoriadearticulo_hasta", "Provhasta" as "F_articulo_proveedor_hasta", "Pdcdesde" as "F_articulo_paletadecolores_desde", "Cdtdesde" as "F_articulo_curvadetalles_desde", "Narbadesde" as "F_articulo_nomenclador_desde", "Temdesde" as "F_articulo_temporada_desde", "Pdchasta" as "F_articulo_paletadecolores_hasta", "Cdthasta" as "F_articulo_curvadetalles_hasta", "Narbahasta" as "F_articulo_nomenclador_hasta", "Temhasta" as "F_articulo_temporada_hasta", "Anodesde" as "F_articulo_ano_desde", "Cladesde" as "F_articulo_clasificacion_desde", "Anohasta" as "F_articulo_ano_hasta", "Clahasta" as "F_articulo_clasificacion_hasta", "Tipdesde" as "F_articulo_tipodearticulo_desde", "Matdesde" as "F_articulo_material_desde", "Tiphasta" as "F_articulo_tipodearticulo_hasta", "Mathasta" as "F_articulo_material_hasta", "Grudesde" as "F_articulo_grupo_desde", "Altdesde" as "F_articulo_fechaaltafw_desde", "Gruhasta" as "F_articulo_grupo_hasta", "Althasta" as "F_articulo_fechaaltafw_hasta", "Moddesde" as "F_articulo_fechamodificacionfw_desde", "Tradesde" as "F_articulo_fechatransferencia_desde", "Usacomb" as "Usacombinacion", "Modhasta" as "F_articulo_fechamodificacionfw_hasta", "Trahasta" as "F_articulo_fechatransferencia_hasta", "Ualta" as "F_articulo_usuarioaltafw", "Impdesde" as "F_articulo_fechaimpo_desde", "Umod" as "F_articulo_usuariomodificacionfw", "Mobs" as "Observacion", "Imphasta" as "F_articulo_fechaimpo_hasta", "Expdesde" as "F_articulo_fechaexpo_desde", "Exphasta" as "F_articulo_fechaexpo_hasta", "Compdesde" as "F_articulo_comportamiento_desde", "Comphasta" as "F_articulo_comportamiento_hasta", "Ftsadesde" as "F_timestampalta_desde", "Ftsahasta" as "F_timestampalta_hasta", "Precdesde" as "F_preciodirecto_desde", "Prechasta" as "F_preciodirecto_hasta", "Marcadesde" as "F_articulo_marca_desde", "Marcahasta" as "F_articulo_marca_hasta"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'CALCPREC', '', tnTope )
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
	Function ObtenerDatosDetalleModPrecios( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  CALCPRECDET.CODIGO != 0"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Codigo" as "Codigo", "Nroitem" as "Nroitem", "Lprecio" as "Lprecio", "Lprecionom" as "Lpreciodetalle", "Accion" as "Accion", "Lprecioa" as "Lprecioa", "Valor" as "Valor", "Formula" as "Formula", "Redondeo" as "Redondeo"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleModPrecios( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'CALCPRECDET', 'ModPrecios', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleModPrecios( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleModPrecios( lcAtributo )
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
				Case lcAtributo == 'FECHAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECEXPO AS FECHAEXPO'
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'FECHAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECIMPO AS FECHAIMPO'
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'FECHATRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRANS AS FECHATRANSFERENCIA'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'DESCRIPCIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCFW AS DESCRIPCIONFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'TIMESTAMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIMESTAMP AS TIMESTAMP'
				Case lcAtributo == 'ANULADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ANULADO AS ANULADO'
				Case lcAtributo == 'DESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCRIP AS DESCRIPCION'
				Case lcAtributo == 'F_ARTICULO_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ARTDESDE AS F_ARTICULO_DESDE'
				Case lcAtributo == 'F_ARTICULO_UNIDADDEMEDIDA_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UNIDESDE AS F_ARTICULO_UNIDADDEMEDIDA_DESDE'
				Case lcAtributo == 'FECHA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHA AS FECHA'
				Case lcAtributo == 'F_ARTICULO_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ARTHASTA AS F_ARTICULO_HASTA'
				Case lcAtributo == 'F_ARTICULO_UNIDADDEMEDIDA_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UNIHASTA AS F_ARTICULO_UNIDADDEMEDIDA_HASTA'
				Case lcAtributo == 'FECHAPROCESO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPROCESO AS FECHAPROCESO'
				Case lcAtributo == 'FECHABASE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHABASE AS FECHABASE'
				Case lcAtributo == 'F_COLOR_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COLDESDE AS F_COLOR_DESDE'
				Case lcAtributo == 'F_ARTICULO_FAMILIA_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FAMDESDE AS F_ARTICULO_FAMILIA_DESDE'
				Case lcAtributo == 'F_COLOR_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COLHASTA AS F_COLOR_HASTA'
				Case lcAtributo == 'F_ARTICULO_FAMILIA_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FAMHASTA AS F_ARTICULO_FAMILIA_HASTA'
				Case lcAtributo == 'FECHAVIGENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHAVIG AS FECHAVIGENCIA'
				Case lcAtributo == 'IMPORTARSINTRANSACCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SINTRANSAC AS IMPORTARSINTRANSACCION'
				Case lcAtributo == 'F_TALLE_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TALDESDE AS F_TALLE_DESDE'
				Case lcAtributo == 'F_ARTICULO_LINEA_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LINDESDE AS F_ARTICULO_LINEA_DESDE'
				Case lcAtributo == 'F_TALLE_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TALHASTA AS F_TALLE_HASTA'
				Case lcAtributo == 'F_ARTICULO_LINEA_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LINHASTA AS F_ARTICULO_LINEA_HASTA'
				Case lcAtributo == 'ARTICULO_COMPORTAMIENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COMPORTA AS ARTICULO_COMPORTAMIENTO'
				Case lcAtributo == 'F_ARTICULO_CATEGORIADEARTICULO_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CATDESDE AS F_ARTICULO_CATEGORIADEARTICULO_DESDE'
				Case lcAtributo == 'F_ARTICULO_PROVEEDOR_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PROVDESDE AS F_ARTICULO_PROVEEDOR_DESDE'
				Case lcAtributo == 'PRECIOKITPACKXPARTICIPANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'KPXPARTIC AS PRECIOKITPACKXPARTICIPANTE'
				Case lcAtributo == 'F_ARTICULO_CATEGORIADEARTICULO_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CATHASTA AS F_ARTICULO_CATEGORIADEARTICULO_HASTA'
				Case lcAtributo == 'F_ARTICULO_PROVEEDOR_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PROVHASTA AS F_ARTICULO_PROVEEDOR_HASTA'
				Case lcAtributo == 'F_ARTICULO_PALETADECOLORES_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PDCDESDE AS F_ARTICULO_PALETADECOLORES_DESDE'
				Case lcAtributo == 'F_ARTICULO_CURVADETALLES_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CDTDESDE AS F_ARTICULO_CURVADETALLES_DESDE'
				Case lcAtributo == 'F_ARTICULO_NOMENCLADOR_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NARBADESDE AS F_ARTICULO_NOMENCLADOR_DESDE'
				Case lcAtributo == 'F_ARTICULO_TEMPORADA_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TEMDESDE AS F_ARTICULO_TEMPORADA_DESDE'
				Case lcAtributo == 'F_ARTICULO_PALETADECOLORES_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PDCHASTA AS F_ARTICULO_PALETADECOLORES_HASTA'
				Case lcAtributo == 'F_ARTICULO_CURVADETALLES_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CDTHASTA AS F_ARTICULO_CURVADETALLES_HASTA'
				Case lcAtributo == 'F_ARTICULO_NOMENCLADOR_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NARBAHASTA AS F_ARTICULO_NOMENCLADOR_HASTA'
				Case lcAtributo == 'F_ARTICULO_TEMPORADA_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TEMHASTA AS F_ARTICULO_TEMPORADA_HASTA'
				Case lcAtributo == 'F_ARTICULO_ANO_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ANODESDE AS F_ARTICULO_ANO_DESDE'
				Case lcAtributo == 'F_ARTICULO_CLASIFICACION_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLADESDE AS F_ARTICULO_CLASIFICACION_DESDE'
				Case lcAtributo == 'F_ARTICULO_ANO_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ANOHASTA AS F_ARTICULO_ANO_HASTA'
				Case lcAtributo == 'F_ARTICULO_CLASIFICACION_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLAHASTA AS F_ARTICULO_CLASIFICACION_HASTA'
				Case lcAtributo == 'F_ARTICULO_TIPODEARTICULO_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPDESDE AS F_ARTICULO_TIPODEARTICULO_DESDE'
				Case lcAtributo == 'F_ARTICULO_MATERIAL_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MATDESDE AS F_ARTICULO_MATERIAL_DESDE'
				Case lcAtributo == 'F_ARTICULO_TIPODEARTICULO_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPHASTA AS F_ARTICULO_TIPODEARTICULO_HASTA'
				Case lcAtributo == 'F_ARTICULO_MATERIAL_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MATHASTA AS F_ARTICULO_MATERIAL_HASTA'
				Case lcAtributo == 'F_ARTICULO_GRUPO_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'GRUDESDE AS F_ARTICULO_GRUPO_DESDE'
				Case lcAtributo == 'F_ARTICULO_FECHAALTAFW_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ALTDESDE AS F_ARTICULO_FECHAALTAFW_DESDE'
				Case lcAtributo == 'F_ARTICULO_GRUPO_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'GRUHASTA AS F_ARTICULO_GRUPO_HASTA'
				Case lcAtributo == 'F_ARTICULO_FECHAALTAFW_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ALTHASTA AS F_ARTICULO_FECHAALTAFW_HASTA'
				Case lcAtributo == 'F_ARTICULO_FECHAMODIFICACIONFW_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MODDESDE AS F_ARTICULO_FECHAMODIFICACIONFW_DESDE'
				Case lcAtributo == 'F_ARTICULO_FECHATRANSFERENCIA_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TRADESDE AS F_ARTICULO_FECHATRANSFERENCIA_DESDE'
				Case lcAtributo == 'USACOMBINACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'USACOMB AS USACOMBINACION'
				Case lcAtributo == 'F_ARTICULO_FECHAMODIFICACIONFW_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MODHASTA AS F_ARTICULO_FECHAMODIFICACIONFW_HASTA'
				Case lcAtributo == 'F_ARTICULO_FECHATRANSFERENCIA_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TRAHASTA AS F_ARTICULO_FECHATRANSFERENCIA_HASTA'
				Case lcAtributo == 'F_ARTICULO_USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTA AS F_ARTICULO_USUARIOALTAFW'
				Case lcAtributo == 'F_ARTICULO_FECHAIMPO_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IMPDESDE AS F_ARTICULO_FECHAIMPO_DESDE'
				Case lcAtributo == 'F_ARTICULO_USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMOD AS F_ARTICULO_USUARIOMODIFICACIONFW'
				Case lcAtributo == 'OBSERVACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MOBS AS OBSERVACION'
				Case lcAtributo == 'F_ARTICULO_FECHAIMPO_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IMPHASTA AS F_ARTICULO_FECHAIMPO_HASTA'
				Case lcAtributo == 'F_ARTICULO_FECHAEXPO_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'EXPDESDE AS F_ARTICULO_FECHAEXPO_DESDE'
				Case lcAtributo == 'F_ARTICULO_FECHAEXPO_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'EXPHASTA AS F_ARTICULO_FECHAEXPO_HASTA'
				Case lcAtributo == 'F_ARTICULO_COMPORTAMIENTO_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COMPDESDE AS F_ARTICULO_COMPORTAMIENTO_DESDE'
				Case lcAtributo == 'F_ARTICULO_COMPORTAMIENTO_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COMPHASTA AS F_ARTICULO_COMPORTAMIENTO_HASTA'
				Case lcAtributo == 'F_TIMESTAMPALTA_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FTSADESDE AS F_TIMESTAMPALTA_DESDE'
				Case lcAtributo == 'F_TIMESTAMPALTA_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FTSAHASTA AS F_TIMESTAMPALTA_HASTA'
				Case lcAtributo == 'F_PRECIODIRECTO_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PRECDESDE AS F_PRECIODIRECTO_DESDE'
				Case lcAtributo == 'F_PRECIODIRECTO_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PRECHASTA AS F_PRECIODIRECTO_HASTA'
				Case lcAtributo == 'F_ARTICULO_MARCA_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MARCADESDE AS F_ARTICULO_MARCA_DESDE'
				Case lcAtributo == 'F_ARTICULO_MARCA_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MARCAHASTA AS F_ARTICULO_MARCA_HASTA'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleModPrecios( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'LPRECIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LPRECIO AS LPRECIO'
				Case lcAtributo == 'LPRECIODETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LPRECIONOM AS LPRECIODETALLE'
				Case lcAtributo == 'ACCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ACCION AS ACCION'
				Case lcAtributo == 'LPRECIOA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LPRECIOA AS LPRECIOA'
				Case lcAtributo == 'VALOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALOR AS VALOR'
				Case lcAtributo == 'FORMULA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FORMULA AS FORMULA'
				Case lcAtributo == 'REDONDEO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'REDONDEO AS REDONDEO'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoEntidad( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEXPO'
				lcCampo = 'FECEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAIMPO'
				lcCampo = 'FECIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCIONFW'
				lcCampo = 'DESCFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'TIMESTAMP'
				lcCampo = 'TIMESTAMP'
			Case upper( alltrim( tcAtributo ) ) == 'ANULADO'
				lcCampo = 'ANULADO'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCION'
				lcCampo = 'DESCRIP'
			Case upper( alltrim( tcAtributo ) ) == 'F_ARTICULO_DESDE'
				lcCampo = 'ARTDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'F_ARTICULO_UNIDADDEMEDIDA_DESDE'
				lcCampo = 'UNIDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'FECHA'
				lcCampo = 'FECHA'
			Case upper( alltrim( tcAtributo ) ) == 'F_ARTICULO_HASTA'
				lcCampo = 'ARTHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'F_ARTICULO_UNIDADDEMEDIDA_HASTA'
				lcCampo = 'UNIHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAPROCESO'
				lcCampo = 'FPROCESO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHABASE'
				lcCampo = 'FECHABASE'
			Case upper( alltrim( tcAtributo ) ) == 'F_COLOR_DESDE'
				lcCampo = 'COLDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'F_ARTICULO_FAMILIA_DESDE'
				lcCampo = 'FAMDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'F_COLOR_HASTA'
				lcCampo = 'COLHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'F_ARTICULO_FAMILIA_HASTA'
				lcCampo = 'FAMHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAVIGENCIA'
				lcCampo = 'FECHAVIG'
			Case upper( alltrim( tcAtributo ) ) == 'IMPORTARSINTRANSACCION'
				lcCampo = 'SINTRANSAC'
			Case upper( alltrim( tcAtributo ) ) == 'F_TALLE_DESDE'
				lcCampo = 'TALDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'F_ARTICULO_LINEA_DESDE'
				lcCampo = 'LINDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'F_TALLE_HASTA'
				lcCampo = 'TALHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'F_ARTICULO_LINEA_HASTA'
				lcCampo = 'LINHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'ARTICULO_COMPORTAMIENTO'
				lcCampo = 'COMPORTA'
			Case upper( alltrim( tcAtributo ) ) == 'F_ARTICULO_CATEGORIADEARTICULO_DESDE'
				lcCampo = 'CATDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'F_ARTICULO_PROVEEDOR_DESDE'
				lcCampo = 'PROVDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'PRECIOKITPACKXPARTICIPANTE'
				lcCampo = 'KPXPARTIC'
			Case upper( alltrim( tcAtributo ) ) == 'F_ARTICULO_CATEGORIADEARTICULO_HASTA'
				lcCampo = 'CATHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'F_ARTICULO_PROVEEDOR_HASTA'
				lcCampo = 'PROVHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'F_ARTICULO_PALETADECOLORES_DESDE'
				lcCampo = 'PDCDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'F_ARTICULO_CURVADETALLES_DESDE'
				lcCampo = 'CDTDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'F_ARTICULO_NOMENCLADOR_DESDE'
				lcCampo = 'NARBADESDE'
			Case upper( alltrim( tcAtributo ) ) == 'F_ARTICULO_TEMPORADA_DESDE'
				lcCampo = 'TEMDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'F_ARTICULO_PALETADECOLORES_HASTA'
				lcCampo = 'PDCHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'F_ARTICULO_CURVADETALLES_HASTA'
				lcCampo = 'CDTHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'F_ARTICULO_NOMENCLADOR_HASTA'
				lcCampo = 'NARBAHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'F_ARTICULO_TEMPORADA_HASTA'
				lcCampo = 'TEMHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'F_ARTICULO_ANO_DESDE'
				lcCampo = 'ANODESDE'
			Case upper( alltrim( tcAtributo ) ) == 'F_ARTICULO_CLASIFICACION_DESDE'
				lcCampo = 'CLADESDE'
			Case upper( alltrim( tcAtributo ) ) == 'F_ARTICULO_ANO_HASTA'
				lcCampo = 'ANOHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'F_ARTICULO_CLASIFICACION_HASTA'
				lcCampo = 'CLAHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'F_ARTICULO_TIPODEARTICULO_DESDE'
				lcCampo = 'TIPDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'F_ARTICULO_MATERIAL_DESDE'
				lcCampo = 'MATDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'F_ARTICULO_TIPODEARTICULO_HASTA'
				lcCampo = 'TIPHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'F_ARTICULO_MATERIAL_HASTA'
				lcCampo = 'MATHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'F_ARTICULO_GRUPO_DESDE'
				lcCampo = 'GRUDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'F_ARTICULO_FECHAALTAFW_DESDE'
				lcCampo = 'ALTDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'F_ARTICULO_GRUPO_HASTA'
				lcCampo = 'GRUHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'F_ARTICULO_FECHAALTAFW_HASTA'
				lcCampo = 'ALTHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'F_ARTICULO_FECHAMODIFICACIONFW_DESDE'
				lcCampo = 'MODDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'F_ARTICULO_FECHATRANSFERENCIA_DESDE'
				lcCampo = 'TRADESDE'
			Case upper( alltrim( tcAtributo ) ) == 'USACOMBINACION'
				lcCampo = 'USACOMB'
			Case upper( alltrim( tcAtributo ) ) == 'F_ARTICULO_FECHAMODIFICACIONFW_HASTA'
				lcCampo = 'MODHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'F_ARTICULO_FECHATRANSFERENCIA_HASTA'
				lcCampo = 'TRAHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'F_ARTICULO_USUARIOALTAFW'
				lcCampo = 'UALTA'
			Case upper( alltrim( tcAtributo ) ) == 'F_ARTICULO_FECHAIMPO_DESDE'
				lcCampo = 'IMPDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'F_ARTICULO_USUARIOMODIFICACIONFW'
				lcCampo = 'UMOD'
			Case upper( alltrim( tcAtributo ) ) == 'OBSERVACION'
				lcCampo = 'MOBS'
			Case upper( alltrim( tcAtributo ) ) == 'F_ARTICULO_FECHAIMPO_HASTA'
				lcCampo = 'IMPHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'F_ARTICULO_FECHAEXPO_DESDE'
				lcCampo = 'EXPDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'F_ARTICULO_FECHAEXPO_HASTA'
				lcCampo = 'EXPHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'F_ARTICULO_COMPORTAMIENTO_DESDE'
				lcCampo = 'COMPDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'F_ARTICULO_COMPORTAMIENTO_HASTA'
				lcCampo = 'COMPHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'F_TIMESTAMPALTA_DESDE'
				lcCampo = 'FTSADESDE'
			Case upper( alltrim( tcAtributo ) ) == 'F_TIMESTAMPALTA_HASTA'
				lcCampo = 'FTSAHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'F_PRECIODIRECTO_DESDE'
				lcCampo = 'PRECDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'F_PRECIODIRECTO_HASTA'
				lcCampo = 'PRECHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'F_ARTICULO_MARCA_DESDE'
				lcCampo = 'MARCADESDE'
			Case upper( alltrim( tcAtributo ) ) == 'F_ARTICULO_MARCA_HASTA'
				lcCampo = 'MARCAHASTA'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleModPrecios( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'LPRECIO'
				lcCampo = 'LPRECIO'
			Case upper( alltrim( tcAtributo ) ) == 'LPRECIODETALLE'
				lcCampo = 'LPRECIONOM'
			Case upper( alltrim( tcAtributo ) ) == 'ACCION'
				lcCampo = 'ACCION'
			Case upper( alltrim( tcAtributo ) ) == 'LPRECIOA'
				lcCampo = 'LPRECIOA'
			Case upper( alltrim( tcAtributo ) ) == 'VALOR'
				lcCampo = 'VALOR'
			Case upper( alltrim( tcAtributo ) ) == 'FORMULA'
				lcCampo = 'FORMULA'
			Case upper( alltrim( tcAtributo ) ) == 'REDONDEO'
				lcCampo = 'REDONDEO'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerTablaDetalle( tcDetalle as string ) as String
		local lcRetorno as string
		lcRetorno = ''
		if upper( alltrim( tcDetalle ) ) == 'MODPRECIOS'
			lcRetorno = 'CALCPRECDET'
		EndIf
		return lcRetorno
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasInsert() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcSentencia as string, loItem as object
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxCalcprecFecexpo, lxCalcprecFaltafw, lxCalcprecFecimpo, lxCalcprecFmodifw, lxCalcprecFectrans, lxCalcprecCodigo, lxCalcprecUaltafw, lxCalcprecSmodifw, lxCalcprecValtafw, lxCalcprecHoraexpo, lxCalcprecVmodifw, lxCalcprecUmodifw, lxCalcprecBdaltafw, lxCalcprecEsttrans, lxCalcprecHaltafw, lxCalcprecBdmodifw, lxCalcprecDescfw, lxCalcprecHmodifw, lxCalcprecHoraimpo, lxCalcprecSaltafw, lxCalcprecZadsfw, lxCalcprecTimestamp, lxCalcprecAnulado, lxCalcprecDescrip, lxCalcprecArtdesde, lxCalcprecUnidesde, lxCalcprecFecha, lxCalcprecArthasta, lxCalcprecUnihasta, lxCalcprecFproceso, lxCalcprecFechabase, lxCalcprecColdesde, lxCalcprecFamdesde, lxCalcprecColhasta, lxCalcprecFamhasta, lxCalcprecFechavig, lxCalcprecSintransac, lxCalcprecTaldesde, lxCalcprecLindesde, lxCalcprecTalhasta, lxCalcprecLinhasta, lxCalcprecComporta, lxCalcprecCatdesde, lxCalcprecProvdesde, lxCalcprecKpxpartic, lxCalcprecCathasta, lxCalcprecProvhasta, lxCalcprecPdcdesde, lxCalcprecCdtdesde, lxCalcprecNarbadesde, lxCalcprecTemdesde, lxCalcprecPdchasta, lxCalcprecCdthasta, lxCalcprecNarbahasta, lxCalcprecTemhasta, lxCalcprecAnodesde, lxCalcprecCladesde, lxCalcprecAnohasta, lxCalcprecClahasta, lxCalcprecTipdesde, lxCalcprecMatdesde, lxCalcprecTiphasta, lxCalcprecMathasta, lxCalcprecGrudesde, lxCalcprecAltdesde, lxCalcprecGruhasta, lxCalcprecAlthasta, lxCalcprecModdesde, lxCalcprecTradesde, lxCalcprecUsacomb, lxCalcprecModhasta, lxCalcprecTrahasta, lxCalcprecUalta, lxCalcprecImpdesde, lxCalcprecUmod, lxCalcprecMobs, lxCalcprecImphasta, lxCalcprecExpdesde, lxCalcprecExphasta, lxCalcprecCompdesde, lxCalcprecComphasta, lxCalcprecFtsadesde, lxCalcprecFtsahasta, lxCalcprecPrecdesde, lxCalcprecPrechasta, lxCalcprecMarcadesde, lxCalcprecMarcahasta
				lxCalcprecFecexpo =  .Fechaexpo			lxCalcprecFaltafw =  .Fechaaltafw			lxCalcprecFecimpo =  .Fechaimpo			lxCalcprecFmodifw =  .Fechamodificacionfw			lxCalcprecFectrans =  .Fechatransferencia			lxCalcprecCodigo =  .Codigo			lxCalcprecUaltafw =  .Usuarioaltafw			lxCalcprecSmodifw =  .Seriemodificacionfw			lxCalcprecValtafw =  .Versionaltafw			lxCalcprecHoraexpo =  .Horaexpo			lxCalcprecVmodifw =  .Versionmodificacionfw			lxCalcprecUmodifw =  .Usuariomodificacionfw			lxCalcprecBdaltafw =  .Basededatosaltafw			lxCalcprecEsttrans =  .Estadotransferencia			lxCalcprecHaltafw =  .Horaaltafw			lxCalcprecBdmodifw =  .Basededatosmodificacionfw			lxCalcprecDescfw =  .Descripcionfw			lxCalcprecHmodifw =  .Horamodificacionfw			lxCalcprecHoraimpo =  .Horaimpo			lxCalcprecSaltafw =  .Seriealtafw			lxCalcprecZadsfw =  .Zadsfw			lxCalcprecTimestamp = goLibrerias.ObtenerTimestamp()			lxCalcprecAnulado =  .Anulado			lxCalcprecDescrip =  .Descripcion			lxCalcprecArtdesde =  upper( .f_Articulo_Desde_PK ) 			lxCalcprecUnidesde =  upper( .f_Articulo_UnidadDeMedida_Desde_PK ) 			lxCalcprecFecha =  .Fecha			lxCalcprecArthasta =  upper( .f_Articulo_Hasta_PK ) 			lxCalcprecUnihasta =  upper( .f_Articulo_UnidadDeMedida_Hasta_PK ) 			lxCalcprecFproceso =  .Fechaproceso			lxCalcprecFechabase =  .Fechabase			lxCalcprecColdesde =  upper( .f_Color_desde_PK ) 			lxCalcprecFamdesde =  upper( .f_Articulo_Familia_Desde_PK ) 			lxCalcprecColhasta =  upper( .f_Color_hasta_PK ) 			lxCalcprecFamhasta =  upper( .f_Articulo_Familia_Hasta_PK ) 			lxCalcprecFechavig =  .Fechavigencia			lxCalcprecSintransac =  .Importarsintransaccion			lxCalcprecTaldesde =  upper( .f_Talle_Desde_PK ) 			lxCalcprecLindesde =  upper( .f_Articulo_Linea_Desde_PK ) 			lxCalcprecTalhasta =  upper( .f_Talle_Hasta_PK ) 			lxCalcprecLinhasta =  upper( .f_Articulo_Linea_Hasta_PK ) 			lxCalcprecComporta =  .Articulo_comportamiento			lxCalcprecCatdesde =  upper( .f_Articulo_CategoriaDeArticulo_Desde_PK ) 			lxCalcprecProvdesde =  upper( .f_Articulo_Proveedor_Desde_PK ) 			lxCalcprecKpxpartic =  .Preciokitpackxparticipante			lxCalcprecCathasta =  upper( .f_Articulo_CategoriaDeArticulo_Hasta_PK ) 			lxCalcprecProvhasta =  upper( .f_Articulo_Proveedor_Hasta_PK ) 			lxCalcprecPdcdesde =  upper( .f_Articulo_PaletaDeColores_Desde_PK ) 			lxCalcprecCdtdesde =  upper( .f_Articulo_CurvaDeTalles_Desde_PK ) 			lxCalcprecNarbadesde =  upper( .f_Articulo_Nomenclador_Desde_PK ) 			lxCalcprecTemdesde =  upper( .f_Articulo_Temporada_Desde_PK ) 			lxCalcprecPdchasta =  upper( .f_Articulo_PaletaDeColores_Hasta_PK ) 			lxCalcprecCdthasta =  upper( .f_Articulo_CurvaDeTalles_Hasta_PK ) 			lxCalcprecNarbahasta =  upper( .f_Articulo_Nomenclador_Hasta_PK ) 			lxCalcprecTemhasta =  upper( .f_Articulo_Temporada_Hasta_PK ) 			lxCalcprecAnodesde =  .F_articulo_ano_desde			lxCalcprecCladesde =  upper( .f_Articulo_Clasificacion_Desde_PK ) 			lxCalcprecAnohasta =  .F_articulo_ano_hasta			lxCalcprecClahasta =  upper( .f_Articulo_Clasificacion_Hasta_PK ) 			lxCalcprecTipdesde =  upper( .f_Articulo_TipodeArticulo_Desde_PK ) 			lxCalcprecMatdesde =  upper( .f_Articulo_Material_Desde_PK ) 			lxCalcprecTiphasta =  upper( .f_Articulo_TipodeArticulo_Hasta_PK ) 			lxCalcprecMathasta =  upper( .f_Articulo_Material_Hasta_PK ) 			lxCalcprecGrudesde =  upper( .f_Articulo_Grupo_Desde_PK ) 			lxCalcprecAltdesde =  .F_articulo_fechaaltafw_desde			lxCalcprecGruhasta =  upper( .f_Articulo_Grupo_Hasta_PK ) 			lxCalcprecAlthasta =  .F_articulo_fechaaltafw_hasta			lxCalcprecModdesde =  .F_articulo_fechamodificacionfw_desde			lxCalcprecTradesde =  .F_articulo_fechatransferencia_desde			lxCalcprecUsacomb =  .Usacombinacion			lxCalcprecModhasta =  .F_articulo_fechamodificacionfw_hasta			lxCalcprecTrahasta =  .F_articulo_fechatransferencia_hasta			lxCalcprecUalta =  .F_articulo_usuarioaltafw			lxCalcprecImpdesde =  .F_articulo_fechaimpo_desde			lxCalcprecUmod =  .F_articulo_usuariomodificacionfw			lxCalcprecMobs =  .Observacion			lxCalcprecImphasta =  .F_articulo_fechaimpo_hasta			lxCalcprecExpdesde =  .F_articulo_fechaexpo_desde			lxCalcprecExphasta =  .F_articulo_fechaexpo_hasta			lxCalcprecCompdesde =  .F_articulo_comportamiento_desde			lxCalcprecComphasta =  .F_articulo_comportamiento_hasta			lxCalcprecFtsadesde =  .F_timestampalta_desde			lxCalcprecFtsahasta =  .F_timestampalta_hasta			lxCalcprecPrecdesde =  .F_preciodirecto_desde			lxCalcprecPrechasta =  .F_preciodirecto_hasta			lxCalcprecMarcadesde =  upper( .f_Articulo_Marca_Desde_PK ) 			lxCalcprecMarcahasta =  upper( .f_Articulo_Marca_Hasta_PK ) 
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.CALCPREC ( "Fecexpo","Faltafw","Fecimpo","Fmodifw","Fectrans","Codigo","Ualtafw","Smodifw","Valtafw","Horaexpo","Vmodifw","Umodifw","Bdaltafw","Esttrans","Haltafw","Bdmodifw","Descfw","Hmodifw","Horaimpo","Saltafw","Zadsfw","Timestamp","Anulado","Descrip","Artdesde","Unidesde","Fecha","Arthasta","Unihasta","Fproceso","Fechabase","Coldesde","Famdesde","Colhasta","Famhasta","Fechavig","Sintransac","Taldesde","Lindesde","Talhasta","Linhasta","Comporta","Catdesde","Provdesde","Kpxpartic","Cathasta","Provhasta","Pdcdesde","Cdtdesde","Narbadesde","Temdesde","Pdchasta","Cdthasta","Narbahasta","Temhasta","Anodesde","Cladesde","Anohasta","Clahasta","Tipdesde","Matdesde","Tiphasta","Mathasta","Grudesde","Altdesde","Gruhasta","Althasta","Moddesde","Tradesde","Usacomb","Modhasta","Trahasta","Ualta","Impdesde","Umod","Mobs","Imphasta","Expdesde","Exphasta","Compdesde","Comphasta","Ftsadesde","Ftsahasta","Precdesde","Prechasta","Marcadesde","Marcahasta" ) values ( <<"'" + this.ConvertirDateSql( lxCalcprecFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCalcprecFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCalcprecFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCalcprecFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCalcprecFectrans ) + "'" >>, <<lxCalcprecCodigo >>, <<"'" + this.FormatearTextoSql( lxCalcprecUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecDescfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecZadsfw ) + "'" >>, <<lxCalcprecTimestamp >>, <<iif( lxCalcprecAnulado, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxCalcprecDescrip ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecArtdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecUnidesde ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCalcprecFecha ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecArthasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecUnihasta ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCalcprecFproceso ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCalcprecFechabase ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecColdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecFamdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecColhasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecFamhasta ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCalcprecFechavig ) + "'" >>, <<iif( lxCalcprecSintransac, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxCalcprecTaldesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecLindesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecTalhasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecLinhasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecComporta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecCatdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecProvdesde ) + "'" >>, <<iif( lxCalcprecKpxpartic, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxCalcprecCathasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecProvhasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecPdcdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecCdtdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecNarbadesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecTemdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecPdchasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecCdthasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecNarbahasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecTemhasta ) + "'" >>, <<lxCalcprecAnodesde >>, <<"'" + this.FormatearTextoSql( lxCalcprecCladesde ) + "'" >>, <<lxCalcprecAnohasta >>, <<"'" + this.FormatearTextoSql( lxCalcprecClahasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecTipdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecMatdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecTiphasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecMathasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecGrudesde ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCalcprecAltdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecGruhasta ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCalcprecAlthasta ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCalcprecModdesde ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCalcprecTradesde ) + "'" >>, <<iif( lxCalcprecUsacomb, 1, 0 ) >>, <<"'" + this.ConvertirDateSql( lxCalcprecModhasta ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCalcprecTrahasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecUalta ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCalcprecImpdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecUmod ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecMobs ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCalcprecImphasta ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCalcprecExpdesde ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCalcprecExphasta ) + "'" >>, <<lxCalcprecCompdesde >>, <<lxCalcprecComphasta >>, <<lxCalcprecFtsadesde >>, <<lxCalcprecFtsahasta >>, <<lxCalcprecPrecdesde >>, <<lxCalcprecPrechasta >>, <<"'" + this.FormatearTextoSql( lxCalcprecMarcadesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecMarcahasta ) + "'" >> )
		endtext
		loColeccion.cTabla = 'CALCPREC' 
		loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		With this
			local lcValorClavePrimariaString as String
			lcValorClavePrimariaString = transform( this.oEntidad.CODIGO )

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ModPrecios
				if this.oEntidad.ModPrecios.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxLprecio_PK = loItem.Lprecio_PK
					lxLpreciodetalle = loItem.Lpreciodetalle
					lxAccion = loItem.Accion
					lxLprecioa_PK = loItem.Lprecioa_PK
					lxValor = loItem.Valor
					lxFormula_PK = loItem.Formula_PK
					lxRedondeo_PK = loItem.Redondeo_PK
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.CALCPRECDET("Codigo","NROITEM","LPrecio","LPrecioNom","Accion","LPrecioA","Valor","Formula","Redondeo" ) values ( << lcValorClavePrimariaString >>, <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxLprecio_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxLpreciodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxAccion ) + "'">>, <<"'" + this.FormatearTextoSql( lxLprecioa_PK ) + "'">>, <<lxValor>>, <<"'" + this.FormatearTextoSql( lxFormula_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxRedondeo_PK ) + "'">> ) 
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
			if .lAnular
				.oAtributosAnulacion = .CrearObjeto( 'zooColeccion' )
				.ObtenerAtributosAnulacion()
				.Limpiar()
				.CargarAtributosAnulacion()
			endif
			local  lxCalcprecFecexpo, lxCalcprecFaltafw, lxCalcprecFecimpo, lxCalcprecFmodifw, lxCalcprecFectrans, lxCalcprecCodigo, lxCalcprecUaltafw, lxCalcprecSmodifw, lxCalcprecValtafw, lxCalcprecHoraexpo, lxCalcprecVmodifw, lxCalcprecUmodifw, lxCalcprecBdaltafw, lxCalcprecEsttrans, lxCalcprecHaltafw, lxCalcprecBdmodifw, lxCalcprecDescfw, lxCalcprecHmodifw, lxCalcprecHoraimpo, lxCalcprecSaltafw, lxCalcprecZadsfw, lxCalcprecTimestamp, lxCalcprecAnulado, lxCalcprecDescrip, lxCalcprecArtdesde, lxCalcprecUnidesde, lxCalcprecFecha, lxCalcprecArthasta, lxCalcprecUnihasta, lxCalcprecFproceso, lxCalcprecFechabase, lxCalcprecColdesde, lxCalcprecFamdesde, lxCalcprecColhasta, lxCalcprecFamhasta, lxCalcprecFechavig, lxCalcprecSintransac, lxCalcprecTaldesde, lxCalcprecLindesde, lxCalcprecTalhasta, lxCalcprecLinhasta, lxCalcprecComporta, lxCalcprecCatdesde, lxCalcprecProvdesde, lxCalcprecKpxpartic, lxCalcprecCathasta, lxCalcprecProvhasta, lxCalcprecPdcdesde, lxCalcprecCdtdesde, lxCalcprecNarbadesde, lxCalcprecTemdesde, lxCalcprecPdchasta, lxCalcprecCdthasta, lxCalcprecNarbahasta, lxCalcprecTemhasta, lxCalcprecAnodesde, lxCalcprecCladesde, lxCalcprecAnohasta, lxCalcprecClahasta, lxCalcprecTipdesde, lxCalcprecMatdesde, lxCalcprecTiphasta, lxCalcprecMathasta, lxCalcprecGrudesde, lxCalcprecAltdesde, lxCalcprecGruhasta, lxCalcprecAlthasta, lxCalcprecModdesde, lxCalcprecTradesde, lxCalcprecUsacomb, lxCalcprecModhasta, lxCalcprecTrahasta, lxCalcprecUalta, lxCalcprecImpdesde, lxCalcprecUmod, lxCalcprecMobs, lxCalcprecImphasta, lxCalcprecExpdesde, lxCalcprecExphasta, lxCalcprecCompdesde, lxCalcprecComphasta, lxCalcprecFtsadesde, lxCalcprecFtsahasta, lxCalcprecPrecdesde, lxCalcprecPrechasta, lxCalcprecMarcadesde, lxCalcprecMarcahasta
				lxCalcprecFecexpo =  .Fechaexpo			lxCalcprecFaltafw =  .Fechaaltafw			lxCalcprecFecimpo =  .Fechaimpo			lxCalcprecFmodifw =  .Fechamodificacionfw			lxCalcprecFectrans =  .Fechatransferencia			lxCalcprecCodigo =  .Codigo			lxCalcprecUaltafw =  .Usuarioaltafw			lxCalcprecSmodifw =  .Seriemodificacionfw			lxCalcprecValtafw =  .Versionaltafw			lxCalcprecHoraexpo =  .Horaexpo			lxCalcprecVmodifw =  .Versionmodificacionfw			lxCalcprecUmodifw =  .Usuariomodificacionfw			lxCalcprecBdaltafw =  .Basededatosaltafw			lxCalcprecEsttrans =  .Estadotransferencia			lxCalcprecHaltafw =  .Horaaltafw			lxCalcprecBdmodifw =  .Basededatosmodificacionfw			lxCalcprecDescfw =  .Descripcionfw			lxCalcprecHmodifw =  .Horamodificacionfw			lxCalcprecHoraimpo =  .Horaimpo			lxCalcprecSaltafw =  .Seriealtafw			lxCalcprecZadsfw =  .Zadsfw			lxCalcprecTimestamp = goLibrerias.ObtenerTimestamp()			lxCalcprecAnulado =  .Anulado			lxCalcprecDescrip =  .Descripcion			lxCalcprecArtdesde =  upper( .f_Articulo_Desde_PK ) 			lxCalcprecUnidesde =  upper( .f_Articulo_UnidadDeMedida_Desde_PK ) 			lxCalcprecFecha =  .Fecha			lxCalcprecArthasta =  upper( .f_Articulo_Hasta_PK ) 			lxCalcprecUnihasta =  upper( .f_Articulo_UnidadDeMedida_Hasta_PK ) 			lxCalcprecFproceso =  .Fechaproceso			lxCalcprecFechabase =  .Fechabase			lxCalcprecColdesde =  upper( .f_Color_desde_PK ) 			lxCalcprecFamdesde =  upper( .f_Articulo_Familia_Desde_PK ) 			lxCalcprecColhasta =  upper( .f_Color_hasta_PK ) 			lxCalcprecFamhasta =  upper( .f_Articulo_Familia_Hasta_PK ) 			lxCalcprecFechavig =  .Fechavigencia			lxCalcprecSintransac =  .Importarsintransaccion			lxCalcprecTaldesde =  upper( .f_Talle_Desde_PK ) 			lxCalcprecLindesde =  upper( .f_Articulo_Linea_Desde_PK ) 			lxCalcprecTalhasta =  upper( .f_Talle_Hasta_PK ) 			lxCalcprecLinhasta =  upper( .f_Articulo_Linea_Hasta_PK ) 			lxCalcprecComporta =  .Articulo_comportamiento			lxCalcprecCatdesde =  upper( .f_Articulo_CategoriaDeArticulo_Desde_PK ) 			lxCalcprecProvdesde =  upper( .f_Articulo_Proveedor_Desde_PK ) 			lxCalcprecKpxpartic =  .Preciokitpackxparticipante			lxCalcprecCathasta =  upper( .f_Articulo_CategoriaDeArticulo_Hasta_PK ) 			lxCalcprecProvhasta =  upper( .f_Articulo_Proveedor_Hasta_PK ) 			lxCalcprecPdcdesde =  upper( .f_Articulo_PaletaDeColores_Desde_PK ) 			lxCalcprecCdtdesde =  upper( .f_Articulo_CurvaDeTalles_Desde_PK ) 			lxCalcprecNarbadesde =  upper( .f_Articulo_Nomenclador_Desde_PK ) 			lxCalcprecTemdesde =  upper( .f_Articulo_Temporada_Desde_PK ) 			lxCalcprecPdchasta =  upper( .f_Articulo_PaletaDeColores_Hasta_PK ) 			lxCalcprecCdthasta =  upper( .f_Articulo_CurvaDeTalles_Hasta_PK ) 			lxCalcprecNarbahasta =  upper( .f_Articulo_Nomenclador_Hasta_PK ) 			lxCalcprecTemhasta =  upper( .f_Articulo_Temporada_Hasta_PK ) 			lxCalcprecAnodesde =  .F_articulo_ano_desde			lxCalcprecCladesde =  upper( .f_Articulo_Clasificacion_Desde_PK ) 			lxCalcprecAnohasta =  .F_articulo_ano_hasta			lxCalcprecClahasta =  upper( .f_Articulo_Clasificacion_Hasta_PK ) 			lxCalcprecTipdesde =  upper( .f_Articulo_TipodeArticulo_Desde_PK ) 			lxCalcprecMatdesde =  upper( .f_Articulo_Material_Desde_PK ) 			lxCalcprecTiphasta =  upper( .f_Articulo_TipodeArticulo_Hasta_PK ) 			lxCalcprecMathasta =  upper( .f_Articulo_Material_Hasta_PK ) 			lxCalcprecGrudesde =  upper( .f_Articulo_Grupo_Desde_PK ) 			lxCalcprecAltdesde =  .F_articulo_fechaaltafw_desde			lxCalcprecGruhasta =  upper( .f_Articulo_Grupo_Hasta_PK ) 			lxCalcprecAlthasta =  .F_articulo_fechaaltafw_hasta			lxCalcprecModdesde =  .F_articulo_fechamodificacionfw_desde			lxCalcprecTradesde =  .F_articulo_fechatransferencia_desde			lxCalcprecUsacomb =  .Usacombinacion			lxCalcprecModhasta =  .F_articulo_fechamodificacionfw_hasta			lxCalcprecTrahasta =  .F_articulo_fechatransferencia_hasta			lxCalcprecUalta =  .F_articulo_usuarioaltafw			lxCalcprecImpdesde =  .F_articulo_fechaimpo_desde			lxCalcprecUmod =  .F_articulo_usuariomodificacionfw			lxCalcprecMobs =  .Observacion			lxCalcprecImphasta =  .F_articulo_fechaimpo_hasta			lxCalcprecExpdesde =  .F_articulo_fechaexpo_desde			lxCalcprecExphasta =  .F_articulo_fechaexpo_hasta			lxCalcprecCompdesde =  .F_articulo_comportamiento_desde			lxCalcprecComphasta =  .F_articulo_comportamiento_hasta			lxCalcprecFtsadesde =  .F_timestampalta_desde			lxCalcprecFtsahasta =  .F_timestampalta_hasta			lxCalcprecPrecdesde =  .F_preciodirecto_desde			lxCalcprecPrechasta =  .F_preciodirecto_hasta			lxCalcprecMarcadesde =  upper( .f_Articulo_Marca_Desde_PK ) 			lxCalcprecMarcahasta =  upper( .f_Articulo_Marca_Hasta_PK ) 
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = transform( this.oEntidad.CODIGO )

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  CALCPREC.CODIGO != 0]
			text to lcSentencia noshow textmerge
				update ZooLogic.CALCPREC set "Fecexpo" = <<"'" + this.ConvertirDateSql( lxCalcprecFecexpo ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxCalcprecFaltafw ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxCalcprecFecimpo ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxCalcprecFmodifw ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxCalcprecFectrans ) + "'">>, "Codigo" = <<lxCalcprecCodigo>>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxCalcprecUaltafw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxCalcprecSmodifw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxCalcprecValtafw ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxCalcprecHoraexpo ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxCalcprecVmodifw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxCalcprecUmodifw ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxCalcprecBdaltafw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxCalcprecEsttrans ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxCalcprecHaltafw ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxCalcprecBdmodifw ) + "'">>, "Descfw" = <<"'" + this.FormatearTextoSql( lxCalcprecDescfw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxCalcprecHmodifw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxCalcprecHoraimpo ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxCalcprecSaltafw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxCalcprecZadsfw ) + "'">>, "Timestamp" = <<lxCalcprecTimestamp>>, "Anulado" = <<iif( lxCalcprecAnulado, 1, 0 )>>, "Descrip" = <<"'" + this.FormatearTextoSql( lxCalcprecDescrip ) + "'">>, "Artdesde" = <<"'" + this.FormatearTextoSql( lxCalcprecArtdesde ) + "'">>, "Unidesde" = <<"'" + this.FormatearTextoSql( lxCalcprecUnidesde ) + "'">>, "Fecha" = <<"'" + this.ConvertirDateSql( lxCalcprecFecha ) + "'">>, "Arthasta" = <<"'" + this.FormatearTextoSql( lxCalcprecArthasta ) + "'">>, "Unihasta" = <<"'" + this.FormatearTextoSql( lxCalcprecUnihasta ) + "'">>, "Fproceso" = <<"'" + this.ConvertirDateSql( lxCalcprecFproceso ) + "'">>, "Fechabase" = <<"'" + this.ConvertirDateSql( lxCalcprecFechabase ) + "'">>, "Coldesde" = <<"'" + this.FormatearTextoSql( lxCalcprecColdesde ) + "'">>, "Famdesde" = <<"'" + this.FormatearTextoSql( lxCalcprecFamdesde ) + "'">>, "Colhasta" = <<"'" + this.FormatearTextoSql( lxCalcprecColhasta ) + "'">>, "Famhasta" = <<"'" + this.FormatearTextoSql( lxCalcprecFamhasta ) + "'">>, "Fechavig" = <<"'" + this.ConvertirDateSql( lxCalcprecFechavig ) + "'">>, "Sintransac" = <<iif( lxCalcprecSintransac, 1, 0 )>>, "Taldesde" = <<"'" + this.FormatearTextoSql( lxCalcprecTaldesde ) + "'">>, "Lindesde" = <<"'" + this.FormatearTextoSql( lxCalcprecLindesde ) + "'">>, "Talhasta" = <<"'" + this.FormatearTextoSql( lxCalcprecTalhasta ) + "'">>, "Linhasta" = <<"'" + this.FormatearTextoSql( lxCalcprecLinhasta ) + "'">>, "Comporta" = <<"'" + this.FormatearTextoSql( lxCalcprecComporta ) + "'">>, "Catdesde" = <<"'" + this.FormatearTextoSql( lxCalcprecCatdesde ) + "'">>, "Provdesde" = <<"'" + this.FormatearTextoSql( lxCalcprecProvdesde ) + "'">>, "Kpxpartic" = <<iif( lxCalcprecKpxpartic, 1, 0 )>>, "Cathasta" = <<"'" + this.FormatearTextoSql( lxCalcprecCathasta ) + "'">>, "Provhasta" = <<"'" + this.FormatearTextoSql( lxCalcprecProvhasta ) + "'">>, "Pdcdesde" = <<"'" + this.FormatearTextoSql( lxCalcprecPdcdesde ) + "'">>, "Cdtdesde" = <<"'" + this.FormatearTextoSql( lxCalcprecCdtdesde ) + "'">>, "Narbadesde" = <<"'" + this.FormatearTextoSql( lxCalcprecNarbadesde ) + "'">>, "Temdesde" = <<"'" + this.FormatearTextoSql( lxCalcprecTemdesde ) + "'">>, "Pdchasta" = <<"'" + this.FormatearTextoSql( lxCalcprecPdchasta ) + "'">>, "Cdthasta" = <<"'" + this.FormatearTextoSql( lxCalcprecCdthasta ) + "'">>, "Narbahasta" = <<"'" + this.FormatearTextoSql( lxCalcprecNarbahasta ) + "'">>, "Temhasta" = <<"'" + this.FormatearTextoSql( lxCalcprecTemhasta ) + "'">>, "Anodesde" = <<lxCalcprecAnodesde>>, "Cladesde" = <<"'" + this.FormatearTextoSql( lxCalcprecCladesde ) + "'">>, "Anohasta" = <<lxCalcprecAnohasta>>, "Clahasta" = <<"'" + this.FormatearTextoSql( lxCalcprecClahasta ) + "'">>, "Tipdesde" = <<"'" + this.FormatearTextoSql( lxCalcprecTipdesde ) + "'">>, "Matdesde" = <<"'" + this.FormatearTextoSql( lxCalcprecMatdesde ) + "'">>, "Tiphasta" = <<"'" + this.FormatearTextoSql( lxCalcprecTiphasta ) + "'">>, "Mathasta" = <<"'" + this.FormatearTextoSql( lxCalcprecMathasta ) + "'">>, "Grudesde" = <<"'" + this.FormatearTextoSql( lxCalcprecGrudesde ) + "'">>, "Altdesde" = <<"'" + this.ConvertirDateSql( lxCalcprecAltdesde ) + "'">>, "Gruhasta" = <<"'" + this.FormatearTextoSql( lxCalcprecGruhasta ) + "'">>, "Althasta" = <<"'" + this.ConvertirDateSql( lxCalcprecAlthasta ) + "'">>, "Moddesde" = <<"'" + this.ConvertirDateSql( lxCalcprecModdesde ) + "'">>, "Tradesde" = <<"'" + this.ConvertirDateSql( lxCalcprecTradesde ) + "'">>, "Usacomb" = <<iif( lxCalcprecUsacomb, 1, 0 )>>, "Modhasta" = <<"'" + this.ConvertirDateSql( lxCalcprecModhasta ) + "'">>, "Trahasta" = <<"'" + this.ConvertirDateSql( lxCalcprecTrahasta ) + "'">>, "Ualta" = <<"'" + this.FormatearTextoSql( lxCalcprecUalta ) + "'">>, "Impdesde" = <<"'" + this.ConvertirDateSql( lxCalcprecImpdesde ) + "'">>, "Umod" = <<"'" + this.FormatearTextoSql( lxCalcprecUmod ) + "'">>, "Mobs" = <<"'" + this.FormatearTextoSql( lxCalcprecMobs ) + "'">>, "Imphasta" = <<"'" + this.ConvertirDateSql( lxCalcprecImphasta ) + "'">>, "Expdesde" = <<"'" + this.ConvertirDateSql( lxCalcprecExpdesde ) + "'">>, "Exphasta" = <<"'" + this.ConvertirDateSql( lxCalcprecExphasta ) + "'">>, "Compdesde" = <<lxCalcprecCompdesde>>, "Comphasta" = <<lxCalcprecComphasta>>, "Ftsadesde" = <<lxCalcprecFtsadesde>>, "Ftsahasta" = <<lxCalcprecFtsahasta>>, "Precdesde" = <<lxCalcprecPrecdesde>>, "Prechasta" = <<lxCalcprecPrechasta>>, "Marcadesde" = <<"'" + this.FormatearTextoSql( lxCalcprecMarcadesde ) + "'">>, "Marcahasta" = <<"'" + this.FormatearTextoSql( lxCalcprecMarcahasta ) + "'">> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'CALCPREC' 
		loColeccion.agregar( strtran(  lcSentencia, chr( 9 ), '' ) )
			loColeccion.Agregar([delete from ZooLogic.CALCPRECDET where "CODIGO" = ] + transform( .oEntidad.CODIGO ))

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ModPrecios
				if this.oEntidad.ModPrecios.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxLprecio_PK = loItem.Lprecio_PK
					lxLpreciodetalle = loItem.Lpreciodetalle
					lxAccion = loItem.Accion
					lxLprecioa_PK = loItem.Lprecioa_PK
					lxValor = loItem.Valor
					lxFormula_PK = loItem.Formula_PK
					lxRedondeo_PK = loItem.Redondeo_PK
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.CALCPRECDET("Codigo","NROITEM","LPrecio","LPrecioNom","Accion","LPrecioA","Valor","Formula","Redondeo" ) values ( << lcValorClavePrimariaString >>, <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxLprecio_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxLpreciodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxAccion ) + "'">>, <<"'" + this.FormatearTextoSql( lxLprecioa_PK ) + "'">>, <<lxValor>>, <<"'" + this.FormatearTextoSql( lxFormula_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxRedondeo_PK ) + "'">> ) 
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
			lcValorClavePrimariaString = transform( this.oEntidad.CODIGO )

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  CALCPREC.CODIGO != 0]
		loColeccion.Agregar( 'delete from ZooLogic.CALCPREC where ' + lcFiltro )
			loColeccion.Agregar([delete from ZooLogic.CALCPRECDET where "CODIGO" = ] + transform( .oEntidad.CODIGO ))
			loColeccion.cTabla = 'CALCPREC' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.CALCPREC where  CALCPREC.CODIGO != 0" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.CALCPREC where CODIGO = " + transform( this.oEntidad.CODIGO )+ " and  CALCPREC.CODIGO != 0" )
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
					if empty( .oNumeraciones.ObtenerServicio('CODIGO') ) and iif( type( '.CODIGO' ) = 'C', int( val( .CODIGO ) ),.CODIGO ) = .oNumeraciones.UltimoNumero( 'CODIGO' )
						.oNumeraciones.Actualizar( 'CODIGO' )
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
					.CODIGO = .oNumeraciones.grabar( 'CODIGO' )
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
		lcCursor = This.oEntidad.cPrefijoRecibir + 'CALCULODEPRECIOS'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.CALCPREC Where CODIGO = ] + transform( &lcCursor..CODIGO ), 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				if This.ActualizaEnRecepcion() 
					if this.oEntidad.cContexto == 'C'
						if curSeek.ANULADO
							Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
							this.oConexion.EjecutarSql( [UPDATE ZooLogic.CALCPREC set  FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, CODIGO = ] + transform( &lcCursor..CODIGO )+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, DescFW = ] + "'" + this.FormatearTextoSql( &lcCursor..DescFW ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, TIMESTAMP = ] + transform( &lcCursor..TIMESTAMP )+ [, Anulado = ] + Transform( iif( &lcCursor..Anulado, 1, 0 ))+ [, Descrip = ] + "'" + this.FormatearTextoSql( &lcCursor..Descrip ) + "'"+ [, ArtDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..ArtDesde ) + "'"+ [, UniDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..UniDesde ) + "'"+ [, FECHA = ] + "'" + this.ConvertirDateSql( &lcCursor..FECHA ) + "'"+ [, ArtHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..ArtHasta ) + "'"+ [, UniHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..UniHasta ) + "'"+ [, FProceso = ] + "'" + this.ConvertirDateSql( &lcCursor..FProceso ) + "'"+ [, Fechabase = ] + "'" + this.ConvertirDateSql( &lcCursor..Fechabase ) + "'"+ [, ColDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..ColDesde ) + "'"+ [, FamDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..FamDesde ) + "'"+ [, ColHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..ColHasta ) + "'"+ [, FamHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..FamHasta ) + "'"+ [, FECHAVIG = ] + "'" + this.ConvertirDateSql( &lcCursor..FECHAVIG ) + "'"+ [, SinTransac = ] + Transform( iif( &lcCursor..SinTransac, 1, 0 ))+ [, TalDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..TalDesde ) + "'"+ [, LinDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..LinDesde ) + "'"+ [, TalHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..TalHasta ) + "'"+ [, LinHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..LinHasta ) + "'"+ [, Comporta = ] + "'" + this.FormatearTextoSql( &lcCursor..Comporta ) + "'"+ [, CatDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..CatDesde ) + "'"+ [, ProvDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..ProvDesde ) + "'"+ [, KPxPartic = ] + Transform( iif( &lcCursor..KPxPartic, 1, 0 ))+ [, CatHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..CatHasta ) + "'"+ [, ProvHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..ProvHasta ) + "'"+ [, PDCDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..PDCDesde ) + "'"+ [, CDTDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..CDTDesde ) + "'"+ [, NARBADesde = ] + "'" + this.FormatearTextoSql( &lcCursor..NARBADesde ) + "'"+ [, TemDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..TemDesde ) + "'"+ [, PDCHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..PDCHasta ) + "'"+ [, CDTHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..CDTHasta ) + "'"+ [, NARBAHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..NARBAHasta ) + "'"+ [, TemHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..TemHasta ) + "'"+ [, AnoDesde = ] + transform( &lcCursor..AnoDesde )+ [, ClaDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..ClaDesde ) + "'"+ [, AnoHasta = ] + transform( &lcCursor..AnoHasta )+ [, ClaHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..ClaHasta ) + "'"+ [, TipDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..TipDesde ) + "'"+ [, MatDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..MatDesde ) + "'"+ [, TipHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..TipHasta ) + "'"+ [, MatHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..MatHasta ) + "'"+ [, GruDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..GruDesde ) + "'"+ [, AltDesde = ] + "'" + this.ConvertirDateSql( &lcCursor..AltDesde ) + "'"+ [, GruHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..GruHasta ) + "'"+ [, AltHasta = ] + "'" + this.ConvertirDateSql( &lcCursor..AltHasta ) + "'"+ [, ModDesde = ] + "'" + this.ConvertirDateSql( &lcCursor..ModDesde ) + "'"+ [, traDesde = ] + "'" + this.ConvertirDateSql( &lcCursor..traDesde ) + "'"+ [, UsaComb = ] + Transform( iif( &lcCursor..UsaComb, 1, 0 ))+ [, ModHasta = ] + "'" + this.ConvertirDateSql( &lcCursor..ModHasta ) + "'"+ [, TraHasta = ] + "'" + this.ConvertirDateSql( &lcCursor..TraHasta ) + "'"+ [, UAlta = ] + "'" + this.FormatearTextoSql( &lcCursor..UAlta ) + "'"+ [, ImpDesde = ] + "'" + this.ConvertirDateSql( &lcCursor..ImpDesde ) + "'"+ [, UMod = ] + "'" + this.FormatearTextoSql( &lcCursor..UMod ) + "'"+ [, MObs = ] + "'" + this.FormatearTextoSql( &lcCursor..MObs ) + "'"+ [, impHasta = ] + "'" + this.ConvertirDateSql( &lcCursor..impHasta ) + "'"+ [, ExpDesde = ] + "'" + this.ConvertirDateSql( &lcCursor..ExpDesde ) + "'"+ [, ExpHasta = ] + "'" + this.ConvertirDateSql( &lcCursor..ExpHasta ) + "'"+ [, CompDesde = ] + transform( &lcCursor..CompDesde )+ [, CompHasta = ] + transform( &lcCursor..CompHasta )+ [, FTSADesde = ] + transform( &lcCursor..FTSADesde )+ [, FTSAHasta = ] + transform( &lcCursor..FTSAHasta )+ [, PrecDesde = ] + transform( &lcCursor..PrecDesde )+ [, PrecHasta = ] + transform( &lcCursor..PrecHasta )+ [, MarcaDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..MarcaDesde ) + "'"+ [, MarcaHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..MarcaHasta ) + "'" + [ Where CODIGO = ] + transform( &lcCursor..CODIGO ) )
							this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica anulado ).', tlLoguear )
						else
							this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir porque ya existe y no esta anulado.', tlLoguear )
						endif
					else
						this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir porque ya existe.', tlLoguear )
					endif
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
				endIf
			else
				Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
				Text to lcCampos noShow
					 FECEXPO, FALTAFW, FECIMPO, FMODIFW, FECTRANS, CODIGO, UALTAFW, SMODIFW, VALTAFW, HORAEXPO, VMODIFW, UMODIFW, BDALTAFW, ESTTRANS, HALTAFW, BDMODIFW, DescFW, HMODIFW, HORAIMPO, SALTAFW, ZADSFW, TIMESTAMP, Anulado, Descrip, ArtDesde, UniDesde, FECHA, ArtHasta, UniHasta, FProceso, Fechabase, ColDesde, FamDesde, ColHasta, FamHasta, FECHAVIG, SinTransac, TalDesde, LinDesde, TalHasta, LinHasta, Comporta, CatDesde, ProvDesde, KPxPartic, CatHasta, ProvHasta, PDCDesde, CDTDesde, NARBADesde, TemDesde, PDCHasta, CDTHasta, NARBAHasta, TemHasta, AnoDesde, ClaDesde, AnoHasta, ClaHasta, TipDesde, MatDesde, TipHasta, MatHasta, GruDesde, AltDesde, GruHasta, AltHasta, ModDesde, traDesde, UsaComb, ModHasta, TraHasta, UAlta, ImpDesde, UMod, MObs, impHasta, ExpDesde, ExpHasta, CompDesde, CompHasta, FTSADesde, FTSAHasta, PrecDesde, PrecHasta, MarcaDesde, MarcaHasta
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + transform( &lcCursor..CODIGO ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..DescFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..TIMESTAMP ) + ',' + Transform( iif( &lcCursor..Anulado, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..Descrip ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ArtDesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UniDesde ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECHA ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ArtHasta ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..UniHasta ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FProceso ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..Fechabase ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ColDesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..FamDesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ColHasta ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..FamHasta ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECHAVIG ) + "'" + ',' + Transform( iif( &lcCursor..SinTransac, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..TalDesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..LinDesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..TalHasta ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..LinHasta ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Comporta ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..CatDesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ProvDesde ) + "'" + ',' + Transform( iif( &lcCursor..KPxPartic, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..CatHasta ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ProvHasta ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..PDCDesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CDTDesde ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..NARBADesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..TemDesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..PDCHasta ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CDTHasta ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..NARBAHasta ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..TemHasta ) + "'" + ',' + transform( &lcCursor..AnoDesde )
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..ClaDesde ) + "'" + ',' + transform( &lcCursor..AnoHasta ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..ClaHasta ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..TipDesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..MatDesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..TipHasta ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..MatHasta ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..GruDesde ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..AltDesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..GruHasta ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..AltHasta ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..ModDesde ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..traDesde ) + "'" + ',' + Transform( iif( &lcCursor..UsaComb, 1, 0 ))
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..ModHasta ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..TraHasta ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UAlta ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..ImpDesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMod ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..MObs ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..impHasta ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..ExpDesde ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..ExpHasta ) + "'" + ',' + transform( &lcCursor..CompDesde ) + ',' + transform( &lcCursor..CompHasta ) + ',' + transform( &lcCursor..FTSADesde ) + ',' + transform( &lcCursor..FTSAHasta ) + ',' + transform( &lcCursor..PrecDesde ) + ',' + transform( &lcCursor..PrecHasta ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..MarcaDesde ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..MarcaHasta ) + "'"
lcValoresCampos = substr(lcValoresCampos,2) 

				this.oConexion.EjecutarSql( [Insert into ZooLogic.CALCPREC ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
				this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'CALCULODEPRECIOS'
		if This.ActualizaEnRecepcion()
		Local lcIn as String, lcCantRegistros as Integer
		Select( lcCursor )
		Count to lcCantRegistros
		If lcCantRegistros > 0
			lcIn = This.ObtenerInSqlServer( lcCursor, 'CODIGO','N')
			lnFragmento = goRegistry.nucleo.cantidadDeElementosEnSentenciaInSQL
			loIn = this.ObtenerColeccionInSqlServer( lcCursor,'','CODIGO')
			llEjecutaEnTransaccion = loIn.count > 0
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'BEGIN TRANSACTION' )
			endif
			for i = 1 to loIn.count step lnFragmento
				lcIn = this.ObtenerFragmentoColeccionInSqlServer( loIn, i, lnFragmento )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.CALCPRECDET Where CODIGO] + lcIn  )
			endfor
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'COMMIT TRANSACTION' )
			endif
		EndIf
	endif
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMCALCULODEPRECIOS'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where CODIGO in ( select CODIGO from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"Codigo","NROITEM","LPrecio","LPrecioNom","Accion","LPrecioA","Valor","Formula","Redondeo"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.CALCPRECDET ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.Codigo     ) + ',' + transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.LPrecio    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.LPrecioNom ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Accion     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.LPrecioA   ) + "'" + ',' + transform( cDetallesExistentes.Valor      ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Formula    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Redondeo   ) + "'" + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	Use in select( 'cExistentes' )
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearCursorMemo( tcCursorACrear as String, tcTablaConMemo as String ) as Void
		create cursor &tcCursorACrear ( CODIGO N (8) , Orden N(16), texto C(80))
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirComponentes() As Void
		
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function ObtenerIdentificadorParaLoguear( tcCursor as String ) As String
		local lcRetorno as String, lnCC as String , loCC as Object, lni as Integer, lcSecuencia as String
		lcRetorno = this.oEntidad.cDescripcion 
		lcRetorno = lcRetorno + ' - Número: ' + transform( &tcCursor..CODIGO     )
		Return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EsAliasDeProceso( tcAlias As String, tcPrefijo as string ) As Boolean
		local llRetorno as Boolean, lcAlias as String, lcPrefijo As String
		llRetorno = .F.
		lcAlias = upper( alltrim( tcAlias ) )
		lcPrefijo = upper( alltrim( tcPrefijo ) )
		Do Case
			Case  lcAlias == lcPrefijo + 'CALCULODEPRECIOS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'CALCULODEPRECIOS_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'CALCULODEPRECIOS_MOBS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMCALCULODEPRECIOS'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_CALCPREC')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'CALCULODEPRECIOS'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..CODIGO
		llCondicion = isnull( lxVar )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad CALCULODEPRECIOS. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'CALCULODEPRECIOS'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		select recno() as _Rec, * from &lcCursor into cursor CurConRecno
		select max( _Rec ) as Maximo,CODIGO as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( CODIGO, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		Use in select( 'CurConRecno' )
		Use in select( 'RepMax' )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDatosInvalidos( toConexion as Object ) as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'CALCULODEPRECIOS'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FECHA     
		* Validar ANTERIORES A 1/1/1753  FProceso  
		* Validar ANTERIORES A 1/1/1753  Fechabase 
		* Validar ANTERIORES A 1/1/1753  FECHAVIG  
		* Validar ANTERIORES A 1/1/1753  AltDesde  
		* Validar ANTERIORES A 1/1/1753  AltHasta  
		* Validar ANTERIORES A 1/1/1753  ModDesde  
		* Validar ANTERIORES A 1/1/1753  traDesde  
		* Validar ANTERIORES A 1/1/1753  ModHasta  
		* Validar ANTERIORES A 1/1/1753  TraHasta  
		* Validar ANTERIORES A 1/1/1753  ImpDesde  
		* Validar ANTERIORES A 1/1/1753  impHasta  
		* Validar ANTERIORES A 1/1/1753  ExpDesde  
		* Validar ANTERIORES A 1/1/1753  ExpHasta  
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_CALCPREC') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_CALCPREC
Create Table ZooLogic.TablaTrabajo_CALCPREC ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fecexpo" datetime  null, 
"faltafw" datetime  null, 
"fecimpo" datetime  null, 
"fmodifw" datetime  null, 
"fectrans" datetime  null, 
"codigo" numeric( 8, 0 )  null, 
"ualtafw" char( 100 )  null, 
"smodifw" char( 7 )  null, 
"valtafw" char( 13 )  null, 
"horaexpo" char( 8 )  null, 
"vmodifw" char( 13 )  null, 
"umodifw" char( 100 )  null, 
"bdaltafw" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"haltafw" char( 8 )  null, 
"bdmodifw" char( 8 )  null, 
"descfw" char( 200 )  null, 
"hmodifw" char( 8 )  null, 
"horaimpo" char( 8 )  null, 
"saltafw" char( 7 )  null, 
"zadsfw" varchar(max)  null, 
"timestamp" numeric( 20, 0 )  null, 
"anulado" bit  null, 
"descrip" char( 40 )  null, 
"artdesde" char( 15 )  null, 
"unidesde" char( 3 )  null, 
"fecha" datetime  null, 
"arthasta" char( 15 )  null, 
"unihasta" char( 3 )  null, 
"fproceso" datetime  null, 
"fechabase" datetime  null, 
"coldesde" char( 6 )  null, 
"famdesde" char( 10 )  null, 
"colhasta" char( 6 )  null, 
"famhasta" char( 10 )  null, 
"fechavig" datetime  null, 
"sintransac" bit  null, 
"taldesde" char( 5 )  null, 
"lindesde" char( 10 )  null, 
"talhasta" char( 5 )  null, 
"linhasta" char( 10 )  null, 
"comporta" char( 1 )  null, 
"catdesde" char( 10 )  null, 
"provdesde" char( 10 )  null, 
"kpxpartic" bit  null, 
"cathasta" char( 10 )  null, 
"provhasta" char( 10 )  null, 
"pdcdesde" char( 10 )  null, 
"cdtdesde" char( 10 )  null, 
"narbadesde" char( 6 )  null, 
"temdesde" char( 5 )  null, 
"pdchasta" char( 10 )  null, 
"cdthasta" char( 10 )  null, 
"narbahasta" char( 6 )  null, 
"temhasta" char( 5 )  null, 
"anodesde" numeric( 4, 0 )  null, 
"cladesde" char( 10 )  null, 
"anohasta" numeric( 4, 0 )  null, 
"clahasta" char( 10 )  null, 
"tipdesde" char( 10 )  null, 
"matdesde" char( 10 )  null, 
"tiphasta" char( 10 )  null, 
"mathasta" char( 10 )  null, 
"grudesde" char( 10 )  null, 
"altdesde" datetime  null, 
"gruhasta" char( 10 )  null, 
"althasta" datetime  null, 
"moddesde" datetime  null, 
"tradesde" datetime  null, 
"usacomb" bit  null, 
"modhasta" datetime  null, 
"trahasta" datetime  null, 
"ualta" char( 65 )  null, 
"impdesde" datetime  null, 
"umod" char( 65 )  null, 
"mobs" varchar(max)  null, 
"imphasta" datetime  null, 
"expdesde" datetime  null, 
"exphasta" datetime  null, 
"compdesde" numeric( 1, 0 )  null, 
"comphasta" numeric( 1, 0 )  null, 
"ftsadesde" numeric( 14, 0 )  null, 
"ftsahasta" numeric( 14, 0 )  null, 
"precdesde" numeric( 15, 2 )  null, 
"prechasta" numeric( 15, 2 )  null, 
"marcadesde" char( 30 )  null, 
"marcahasta" char( 30 )  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_CALCPREC' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_CALCPREC' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'CALCULODEPRECIOS'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		with loManejador
			if this.oEntidad.VerificarContexto( 'CB' )
			else
				.AgregarMapeo('Nrolinea','Nrolinea')
			endif
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('codigo','codigo')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('descfw','descfw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('timestamp','timestamp')
			.AgregarMapeo('anulado','anulado')
			.AgregarMapeo('descrip','descrip')
			.AgregarMapeo('artdesde','artdesde')
			.AgregarMapeo('unidesde','unidesde')
			.AgregarMapeo('fecha','fecha')
			.AgregarMapeo('arthasta','arthasta')
			.AgregarMapeo('unihasta','unihasta')
			.AgregarMapeo('fproceso','fproceso')
			.AgregarMapeo('fechabase','fechabase')
			.AgregarMapeo('coldesde','coldesde')
			.AgregarMapeo('famdesde','famdesde')
			.AgregarMapeo('colhasta','colhasta')
			.AgregarMapeo('famhasta','famhasta')
			.AgregarMapeo('fechavig','fechavig')
			.AgregarMapeo('sintransac','sintransac')
			.AgregarMapeo('taldesde','taldesde')
			.AgregarMapeo('lindesde','lindesde')
			.AgregarMapeo('talhasta','talhasta')
			.AgregarMapeo('linhasta','linhasta')
			.AgregarMapeo('comporta','comporta')
			.AgregarMapeo('catdesde','catdesde')
			.AgregarMapeo('provdesde','provdesde')
			.AgregarMapeo('kpxpartic','kpxpartic')
			.AgregarMapeo('cathasta','cathasta')
			.AgregarMapeo('provhasta','provhasta')
			.AgregarMapeo('pdcdesde','pdcdesde')
			.AgregarMapeo('cdtdesde','cdtdesde')
			.AgregarMapeo('narbadesde','narbadesde')
			.AgregarMapeo('temdesde','temdesde')
			.AgregarMapeo('pdchasta','pdchasta')
			.AgregarMapeo('cdthasta','cdthasta')
			.AgregarMapeo('narbahasta','narbahasta')
			.AgregarMapeo('temhasta','temhasta')
			.AgregarMapeo('anodesde','anodesde')
			.AgregarMapeo('cladesde','cladesde')
			.AgregarMapeo('anohasta','anohasta')
			.AgregarMapeo('clahasta','clahasta')
			.AgregarMapeo('tipdesde','tipdesde')
			.AgregarMapeo('matdesde','matdesde')
			.AgregarMapeo('tiphasta','tiphasta')
			.AgregarMapeo('mathasta','mathasta')
			.AgregarMapeo('grudesde','grudesde')
			.AgregarMapeo('altdesde','altdesde')
			.AgregarMapeo('gruhasta','gruhasta')
			.AgregarMapeo('althasta','althasta')
			.AgregarMapeo('moddesde','moddesde')
			.AgregarMapeo('tradesde','tradesde')
			.AgregarMapeo('usacomb','usacomb')
			.AgregarMapeo('modhasta','modhasta')
			.AgregarMapeo('trahasta','trahasta')
			.AgregarMapeo('ualta','ualta')
			.AgregarMapeo('impdesde','impdesde')
			.AgregarMapeo('umod','umod')
			.AgregarMapeo('mobs','mobs')
			.AgregarMapeo('imphasta','imphasta')
			.AgregarMapeo('expdesde','expdesde')
			.AgregarMapeo('exphasta','exphasta')
			.AgregarMapeo('compdesde','compdesde')
			.AgregarMapeo('comphasta','comphasta')
			.AgregarMapeo('ftsadesde','ftsadesde')
			.AgregarMapeo('ftsahasta','ftsahasta')
			.AgregarMapeo('precdesde','precdesde')
			.AgregarMapeo('prechasta','prechasta')
			.AgregarMapeo('marcadesde','marcadesde')
			.AgregarMapeo('marcahasta','marcahasta')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_CALCPREC'
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
				Update t Set t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.CODIGO = isnull( d.CODIGO, t.CODIGO ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.DESCFW = isnull( d.DESCFW, t.DESCFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.TIMESTAMP = isnull( d.TIMESTAMP, t.TIMESTAMP ),t.ANULADO = isnull( d.ANULADO, t.ANULADO ),t.DESCRIP = isnull( d.DESCRIP, t.DESCRIP ),t.ARTDESDE = isnull( d.ARTDESDE, t.ARTDESDE ),t.UNIDESDE = isnull( d.UNIDESDE, t.UNIDESDE ),t.FECHA = isnull( d.FECHA, t.FECHA ),t.ARTHASTA = isnull( d.ARTHASTA, t.ARTHASTA ),t.UNIHASTA = isnull( d.UNIHASTA, t.UNIHASTA ),t.FPROCESO = isnull( d.FPROCESO, t.FPROCESO ),t.FECHABASE = isnull( d.FECHABASE, t.FECHABASE ),t.COLDESDE = isnull( d.COLDESDE, t.COLDESDE ),t.FAMDESDE = isnull( d.FAMDESDE, t.FAMDESDE ),t.COLHASTA = isnull( d.COLHASTA, t.COLHASTA ),t.FAMHASTA = isnull( d.FAMHASTA, t.FAMHASTA ),t.FECHAVIG = isnull( d.FECHAVIG, t.FECHAVIG ),t.SINTRANSAC = isnull( d.SINTRANSAC, t.SINTRANSAC ),t.TALDESDE = isnull( d.TALDESDE, t.TALDESDE ),t.LINDESDE = isnull( d.LINDESDE, t.LINDESDE ),t.TALHASTA = isnull( d.TALHASTA, t.TALHASTA ),t.LINHASTA = isnull( d.LINHASTA, t.LINHASTA ),t.COMPORTA = isnull( d.COMPORTA, t.COMPORTA ),t.CATDESDE = isnull( d.CATDESDE, t.CATDESDE ),t.PROVDESDE = isnull( d.PROVDESDE, t.PROVDESDE ),t.KPXPARTIC = isnull( d.KPXPARTIC, t.KPXPARTIC ),t.CATHASTA = isnull( d.CATHASTA, t.CATHASTA ),t.PROVHASTA = isnull( d.PROVHASTA, t.PROVHASTA ),t.PDCDESDE = isnull( d.PDCDESDE, t.PDCDESDE ),t.CDTDESDE = isnull( d.CDTDESDE, t.CDTDESDE ),t.NARBADESDE = isnull( d.NARBADESDE, t.NARBADESDE ),t.TEMDESDE = isnull( d.TEMDESDE, t.TEMDESDE ),t.PDCHASTA = isnull( d.PDCHASTA, t.PDCHASTA ),t.CDTHASTA = isnull( d.CDTHASTA, t.CDTHASTA ),t.NARBAHASTA = isnull( d.NARBAHASTA, t.NARBAHASTA ),t.TEMHASTA = isnull( d.TEMHASTA, t.TEMHASTA ),t.ANODESDE = isnull( d.ANODESDE, t.ANODESDE ),t.CLADESDE = isnull( d.CLADESDE, t.CLADESDE ),t.ANOHASTA = isnull( d.ANOHASTA, t.ANOHASTA ),t.CLAHASTA = isnull( d.CLAHASTA, t.CLAHASTA ),t.TIPDESDE = isnull( d.TIPDESDE, t.TIPDESDE ),t.MATDESDE = isnull( d.MATDESDE, t.MATDESDE ),t.TIPHASTA = isnull( d.TIPHASTA, t.TIPHASTA ),t.MATHASTA = isnull( d.MATHASTA, t.MATHASTA ),t.GRUDESDE = isnull( d.GRUDESDE, t.GRUDESDE ),t.ALTDESDE = isnull( d.ALTDESDE, t.ALTDESDE ),t.GRUHASTA = isnull( d.GRUHASTA, t.GRUHASTA ),t.ALTHASTA = isnull( d.ALTHASTA, t.ALTHASTA ),t.MODDESDE = isnull( d.MODDESDE, t.MODDESDE ),t.TRADESDE = isnull( d.TRADESDE, t.TRADESDE ),t.USACOMB = isnull( d.USACOMB, t.USACOMB ),t.MODHASTA = isnull( d.MODHASTA, t.MODHASTA ),t.TRAHASTA = isnull( d.TRAHASTA, t.TRAHASTA ),t.UALTA = isnull( d.UALTA, t.UALTA ),t.IMPDESDE = isnull( d.IMPDESDE, t.IMPDESDE ),t.UMOD = isnull( d.UMOD, t.UMOD ),t.MOBS = isnull( d.MOBS, t.MOBS ),t.IMPHASTA = isnull( d.IMPHASTA, t.IMPHASTA ),t.EXPDESDE = isnull( d.EXPDESDE, t.EXPDESDE ),t.EXPHASTA = isnull( d.EXPHASTA, t.EXPHASTA ),t.COMPDESDE = isnull( d.COMPDESDE, t.COMPDESDE ),t.COMPHASTA = isnull( d.COMPHASTA, t.COMPHASTA ),t.FTSADESDE = isnull( d.FTSADESDE, t.FTSADESDE ),t.FTSAHASTA = isnull( d.FTSAHASTA, t.FTSAHASTA ),t.PRECDESDE = isnull( d.PRECDESDE, t.PRECDESDE ),t.PRECHASTA = isnull( d.PRECHASTA, t.PRECHASTA ),t.MARCADESDE = isnull( d.MARCADESDE, t.MARCADESDE ),t.MARCAHASTA = isnull( d.MARCAHASTA, t.MARCAHASTA )
					from ZooLogic.CALCPREC t inner join deleted d 
							 on t.CODIGO = d.CODIGO
				-- Fin Updates
				insert into ZooLogic.CALCPREC(Fecexpo,Faltafw,Fecimpo,Fmodifw,Fectrans,Codigo,Ualtafw,Smodifw,Valtafw,Horaexpo,Vmodifw,Umodifw,Bdaltafw,Esttrans,Haltafw,Bdmodifw,Descfw,Hmodifw,Horaimpo,Saltafw,Zadsfw,Timestamp,Anulado,Descrip,Artdesde,Unidesde,Fecha,Arthasta,Unihasta,Fproceso,Fechabase,Coldesde,Famdesde,Colhasta,Famhasta,Fechavig,Sintransac,Taldesde,Lindesde,Talhasta,Linhasta,Comporta,Catdesde,Provdesde,Kpxpartic,Cathasta,Provhasta,Pdcdesde,Cdtdesde,Narbadesde,Temdesde,Pdchasta,Cdthasta,Narbahasta,Temhasta,Anodesde,Cladesde,Anohasta,Clahasta,Tipdesde,Matdesde,Tiphasta,Mathasta,Grudesde,Altdesde,Gruhasta,Althasta,Moddesde,Tradesde,Usacomb,Modhasta,Trahasta,Ualta,Impdesde,Umod,Mobs,Imphasta,Expdesde,Exphasta,Compdesde,Comphasta,Ftsadesde,Ftsahasta,Precdesde,Prechasta,Marcadesde,Marcahasta)
					Select isnull( d.FECEXPO,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FECIMPO,''),isnull( d.FMODIFW,''),isnull( d.FECTRANS,''),isnull( d.CODIGO,0),isnull( d.UALTAFW,''),isnull( d.SMODIFW,''),isnull( d.VALTAFW,''),isnull( d.HORAEXPO,''),isnull( d.VMODIFW,''),isnull( d.UMODIFW,''),isnull( d.BDALTAFW,''),isnull( d.ESTTRANS,''),convert( char(8), getdate(), 108 ),isnull( d.BDMODIFW,''),isnull( d.DESCFW,''),isnull( d.HMODIFW,''),isnull( d.HORAIMPO,''),isnull( d.SALTAFW,''),isnull( d.ZADSFW,''),isnull( d.TIMESTAMP,0),isnull( d.ANULADO,0),isnull( d.DESCRIP,''),isnull( d.ARTDESDE,''),isnull( d.UNIDESDE,''),isnull( d.FECHA,''),isnull( d.ARTHASTA,''),isnull( d.UNIHASTA,''),isnull( d.FPROCESO,''),isnull( d.FECHABASE,''),isnull( d.COLDESDE,''),isnull( d.FAMDESDE,''),isnull( d.COLHASTA,''),isnull( d.FAMHASTA,''),isnull( d.FECHAVIG,''),isnull( d.SINTRANSAC,0),isnull( d.TALDESDE,''),isnull( d.LINDESDE,''),isnull( d.TALHASTA,''),isnull( d.LINHASTA,''),isnull( d.COMPORTA,''),isnull( d.CATDESDE,''),isnull( d.PROVDESDE,''),isnull( d.KPXPARTIC,0),isnull( d.CATHASTA,''),isnull( d.PROVHASTA,''),isnull( d.PDCDESDE,''),isnull( d.CDTDESDE,''),isnull( d.NARBADESDE,''),isnull( d.TEMDESDE,''),isnull( d.PDCHASTA,''),isnull( d.CDTHASTA,''),isnull( d.NARBAHASTA,''),isnull( d.TEMHASTA,''),isnull( d.ANODESDE,0),isnull( d.CLADESDE,''),isnull( d.ANOHASTA,0),isnull( d.CLAHASTA,''),isnull( d.TIPDESDE,''),isnull( d.MATDESDE,''),isnull( d.TIPHASTA,''),isnull( d.MATHASTA,''),isnull( d.GRUDESDE,''),isnull( d.ALTDESDE,''),isnull( d.GRUHASTA,''),isnull( d.ALTHASTA,''),isnull( d.MODDESDE,''),isnull( d.TRADESDE,''),isnull( d.USACOMB,0),isnull( d.MODHASTA,''),isnull( d.TRAHASTA,''),isnull( d.UALTA,''),isnull( d.IMPDESDE,''),isnull( d.UMOD,''),isnull( d.MOBS,''),isnull( d.IMPHASTA,''),isnull( d.EXPDESDE,''),isnull( d.EXPHASTA,''),isnull( d.COMPDESDE,0),isnull( d.COMPHASTA,0),isnull( d.FTSADESDE,0),isnull( d.FTSAHASTA,0),isnull( d.PRECDESDE,0),isnull( d.PRECHASTA,0),isnull( d.MARCADESDE,''),isnull( d.MARCAHASTA,'')
						From deleted d left join ZooLogic.CALCPREC pk 
							 on d.CODIGO = pk.CODIGO
						Where pk.CODIGO Is Null 
				-- Fin Inserts
			End
		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_CALCPRECDET( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_CALCPREC_CALCPRECDET
ON ZooLogic.TablaTrabajo_CALCPREC_CALCPRECDET
AFTER DELETE
As
Begin
Update t Set 
t.CODIGO = isnull( d.CODIGO, t.CODIGO ),
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.LPRECIO = isnull( d.LPRECIO, t.LPRECIO ),
t.LPRECIONOM = isnull( d.LPRECIONOM, t.LPRECIONOM ),
t.ACCION = isnull( d.ACCION, t.ACCION ),
t.LPRECIOA = isnull( d.LPRECIOA, t.LPRECIOA ),
t.VALOR = isnull( d.VALOR, t.VALOR ),
t.FORMULA = isnull( d.FORMULA, t.FORMULA ),
t.REDONDEO = isnull( d.REDONDEO, t.REDONDEO )
from ZooLogic.CALCPRECDET t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.CALCPRECDET
( 
"CODIGO",
"NROITEM",
"LPRECIO",
"LPRECIONOM",
"ACCION",
"LPRECIOA",
"VALOR",
"FORMULA",
"REDONDEO"
 )
Select 
d.CODIGO,
d.NROITEM,
d.LPRECIO,
d.LPRECIONOM,
d.ACCION,
d.LPRECIOA,
d.VALOR,
d.FORMULA,
d.REDONDEO
From deleted d left join ZooLogic.CALCPRECDET pk 
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_CALCPREC') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_CALCPREC
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_CALCULODEPRECIOS' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_CALCULODEPRECIOS.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_CALCULODEPRECIOS.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_CALCULODEPRECIOS.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_CALCULODEPRECIOS.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_CALCULODEPRECIOS.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Codigo = nvl( c_CALCULODEPRECIOS.Codigo, 0 )
					.Usuarioaltafw = nvl( c_CALCULODEPRECIOS.Usuarioaltafw, [] )
					.Seriemodificacionfw = nvl( c_CALCULODEPRECIOS.Seriemodificacionfw, [] )
					.Versionaltafw = nvl( c_CALCULODEPRECIOS.Versionaltafw, [] )
					.Horaexpo = nvl( c_CALCULODEPRECIOS.Horaexpo, [] )
					.Versionmodificacionfw = nvl( c_CALCULODEPRECIOS.Versionmodificacionfw, [] )
					.Usuariomodificacionfw = nvl( c_CALCULODEPRECIOS.Usuariomodificacionfw, [] )
					.Basededatosaltafw = nvl( c_CALCULODEPRECIOS.Basededatosaltafw, [] )
					.Estadotransferencia = nvl( c_CALCULODEPRECIOS.Estadotransferencia, [] )
					.Horaaltafw = nvl( c_CALCULODEPRECIOS.Horaaltafw, [] )
					.Basededatosmodificacionfw = nvl( c_CALCULODEPRECIOS.Basededatosmodificacionfw, [] )
					.Descripcionfw = nvl( c_CALCULODEPRECIOS.Descripcionfw, [] )
					.Horamodificacionfw = nvl( c_CALCULODEPRECIOS.Horamodificacionfw, [] )
					.Horaimpo = nvl( c_CALCULODEPRECIOS.Horaimpo, [] )
					.Seriealtafw = nvl( c_CALCULODEPRECIOS.Seriealtafw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Timestamp = nvl( c_CALCULODEPRECIOS.Timestamp, 0 )
					.Anulado = nvl( c_CALCULODEPRECIOS.Anulado, .F. )
					.Descripcion = nvl( c_CALCULODEPRECIOS.Descripcion, [] )
					.F_articulo_desde_PK =  nvl( c_CALCULODEPRECIOS.F_articulo_desde, [] )
					.F_articulo_unidaddemedida_desde_PK =  nvl( c_CALCULODEPRECIOS.F_articulo_unidaddemedida_desde, [] )
					.Fecha = GoLibrerias.ObtenerFechaFormateada( nvl( c_CALCULODEPRECIOS.Fecha, ctod( '  /  /    ' ) ) )
					.F_articulo_hasta_PK =  nvl( c_CALCULODEPRECIOS.F_articulo_hasta, [] )
					.F_articulo_unidaddemedida_hasta_PK =  nvl( c_CALCULODEPRECIOS.F_articulo_unidaddemedida_hasta, [] )
					.Fechaproceso = GoLibrerias.ObtenerFechaFormateada( nvl( c_CALCULODEPRECIOS.Fechaproceso, ctod( '  /  /    ' ) ) )
					.Fechabase = GoLibrerias.ObtenerFechaFormateada( nvl( c_CALCULODEPRECIOS.Fechabase, ctod( '  /  /    ' ) ) )
					.F_color_desde_PK =  nvl( c_CALCULODEPRECIOS.F_color_desde, [] )
					.F_articulo_familia_desde_PK =  nvl( c_CALCULODEPRECIOS.F_articulo_familia_desde, [] )
					.F_color_hasta_PK =  nvl( c_CALCULODEPRECIOS.F_color_hasta, [] )
					.F_articulo_familia_hasta_PK =  nvl( c_CALCULODEPRECIOS.F_articulo_familia_hasta, [] )
					.Fechavigencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_CALCULODEPRECIOS.Fechavigencia, ctod( '  /  /    ' ) ) )
					.Importarsintransaccion = nvl( c_CALCULODEPRECIOS.Importarsintransaccion, .F. )
					.F_talle_desde_PK =  nvl( c_CALCULODEPRECIOS.F_talle_desde, [] )
					.F_articulo_linea_desde_PK =  nvl( c_CALCULODEPRECIOS.F_articulo_linea_desde, [] )
					.F_talle_hasta_PK =  nvl( c_CALCULODEPRECIOS.F_talle_hasta, [] )
					.F_articulo_linea_hasta_PK =  nvl( c_CALCULODEPRECIOS.F_articulo_linea_hasta, [] )
					.Articulo_comportamiento = nvl( c_CALCULODEPRECIOS.Articulo_comportamiento, [] )
					.F_articulo_categoriadearticulo_desde_PK =  nvl( c_CALCULODEPRECIOS.F_articulo_categoriadearticulo_desde, [] )
					.F_articulo_proveedor_desde_PK =  nvl( c_CALCULODEPRECIOS.F_articulo_proveedor_desde, [] )
					.Preciokitpackxparticipante = nvl( c_CALCULODEPRECIOS.Preciokitpackxparticipante, .F. )
					.F_articulo_categoriadearticulo_hasta_PK =  nvl( c_CALCULODEPRECIOS.F_articulo_categoriadearticulo_hasta, [] )
					.F_articulo_proveedor_hasta_PK =  nvl( c_CALCULODEPRECIOS.F_articulo_proveedor_hasta, [] )
					.F_articulo_paletadecolores_desde_PK =  nvl( c_CALCULODEPRECIOS.F_articulo_paletadecolores_desde, [] )
					.F_articulo_curvadetalles_desde_PK =  nvl( c_CALCULODEPRECIOS.F_articulo_curvadetalles_desde, [] )
					.F_articulo_nomenclador_desde_PK =  nvl( c_CALCULODEPRECIOS.F_articulo_nomenclador_desde, [] )
					.F_articulo_temporada_desde_PK =  nvl( c_CALCULODEPRECIOS.F_articulo_temporada_desde, [] )
					.F_articulo_paletadecolores_hasta_PK =  nvl( c_CALCULODEPRECIOS.F_articulo_paletadecolores_hasta, [] )
					.F_articulo_curvadetalles_hasta_PK =  nvl( c_CALCULODEPRECIOS.F_articulo_curvadetalles_hasta, [] )
					.F_articulo_nomenclador_hasta_PK =  nvl( c_CALCULODEPRECIOS.F_articulo_nomenclador_hasta, [] )
					.F_articulo_temporada_hasta_PK =  nvl( c_CALCULODEPRECIOS.F_articulo_temporada_hasta, [] )
					.F_articulo_ano_desde = nvl( c_CALCULODEPRECIOS.F_articulo_ano_desde, 0 )
					.F_articulo_clasificacion_desde_PK =  nvl( c_CALCULODEPRECIOS.F_articulo_clasificacion_desde, [] )
					.F_articulo_ano_hasta = nvl( c_CALCULODEPRECIOS.F_articulo_ano_hasta, 0 )
					.F_articulo_clasificacion_hasta_PK =  nvl( c_CALCULODEPRECIOS.F_articulo_clasificacion_hasta, [] )
					.F_articulo_tipodearticulo_desde_PK =  nvl( c_CALCULODEPRECIOS.F_articulo_tipodearticulo_desde, [] )
					.F_articulo_material_desde_PK =  nvl( c_CALCULODEPRECIOS.F_articulo_material_desde, [] )
					.F_articulo_tipodearticulo_hasta_PK =  nvl( c_CALCULODEPRECIOS.F_articulo_tipodearticulo_hasta, [] )
					.F_articulo_material_hasta_PK =  nvl( c_CALCULODEPRECIOS.F_articulo_material_hasta, [] )
					.F_articulo_grupo_desde_PK =  nvl( c_CALCULODEPRECIOS.F_articulo_grupo_desde, [] )
					.F_articulo_fechaaltafw_desde = GoLibrerias.ObtenerFechaFormateada( nvl( c_CALCULODEPRECIOS.F_articulo_fechaaltafw_desde, ctod( '  /  /    ' ) ) )
					.F_articulo_grupo_hasta_PK =  nvl( c_CALCULODEPRECIOS.F_articulo_grupo_hasta, [] )
					.F_articulo_fechaaltafw_hasta = GoLibrerias.ObtenerFechaFormateada( nvl( c_CALCULODEPRECIOS.F_articulo_fechaaltafw_hasta, ctod( '  /  /    ' ) ) )
					.F_articulo_fechamodificacionfw_desde = GoLibrerias.ObtenerFechaFormateada( nvl( c_CALCULODEPRECIOS.F_articulo_fechamodificacionfw_desde, ctod( '  /  /    ' ) ) )
					.F_articulo_fechatransferencia_desde = GoLibrerias.ObtenerFechaFormateada( nvl( c_CALCULODEPRECIOS.F_articulo_fechatransferencia_desde, ctod( '  /  /    ' ) ) )
					.Usacombinacion = nvl( c_CALCULODEPRECIOS.Usacombinacion, .F. )
					.F_articulo_fechamodificacionfw_hasta = GoLibrerias.ObtenerFechaFormateada( nvl( c_CALCULODEPRECIOS.F_articulo_fechamodificacionfw_hasta, ctod( '  /  /    ' ) ) )
					.F_articulo_fechatransferencia_hasta = GoLibrerias.ObtenerFechaFormateada( nvl( c_CALCULODEPRECIOS.F_articulo_fechatransferencia_hasta, ctod( '  /  /    ' ) ) )
					.F_articulo_usuarioaltafw = nvl( c_CALCULODEPRECIOS.F_articulo_usuarioaltafw, [] )
					.Modprecios.Limpiar()
					.Modprecios.SetearEsNavegacion( .lProcesando )
					.Modprecios.Cargar()
					.F_articulo_fechaimpo_desde = GoLibrerias.ObtenerFechaFormateada( nvl( c_CALCULODEPRECIOS.F_articulo_fechaimpo_desde, ctod( '  /  /    ' ) ) )
					.F_articulo_usuariomodificacionfw = nvl( c_CALCULODEPRECIOS.F_articulo_usuariomodificacionfw, [] )
					lcValor = This.ObtenerMemo( 'c_Observacion')
					.Observacion = lcValor 
					.F_articulo_fechaimpo_hasta = GoLibrerias.ObtenerFechaFormateada( nvl( c_CALCULODEPRECIOS.F_articulo_fechaimpo_hasta, ctod( '  /  /    ' ) ) )
					.F_articulo_fechaexpo_desde = GoLibrerias.ObtenerFechaFormateada( nvl( c_CALCULODEPRECIOS.F_articulo_fechaexpo_desde, ctod( '  /  /    ' ) ) )
					.F_articulo_fechaexpo_hasta = GoLibrerias.ObtenerFechaFormateada( nvl( c_CALCULODEPRECIOS.F_articulo_fechaexpo_hasta, ctod( '  /  /    ' ) ) )
					.F_articulo_comportamiento_desde = nvl( c_CALCULODEPRECIOS.F_articulo_comportamiento_desde, 0 )
					.F_articulo_comportamiento_hasta = nvl( c_CALCULODEPRECIOS.F_articulo_comportamiento_hasta, 0 )
					.F_timestampalta_desde = nvl( c_CALCULODEPRECIOS.F_timestampalta_desde, 0 )
					.F_timestampalta_hasta = nvl( c_CALCULODEPRECIOS.F_timestampalta_hasta, 0 )
					.F_preciodirecto_desde = nvl( c_CALCULODEPRECIOS.F_preciodirecto_desde, 0 )
					.F_preciodirecto_hasta = nvl( c_CALCULODEPRECIOS.F_preciodirecto_hasta, 0 )
					.F_articulo_marca_desde_PK =  nvl( c_CALCULODEPRECIOS.F_articulo_marca_desde, [] )
					.F_articulo_marca_hasta_PK =  nvl( c_CALCULODEPRECIOS.F_articulo_marca_hasta, [] )
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
		
		loDetalle = this.oEntidad.ModPrecios
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
		return c_CALCULODEPRECIOS.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.CALCPREC' )
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
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "CODIGO"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
		text to lcSQL textmerge noshow
				SELECT nro,totalRegistros,CODIGO as Id
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    CODIGO from (
							select * 
								from ZooLogic.CALCPREC 
								Where   CALCPREC.CODIGO != 0
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "CALCPREC", "", lcCursor, set("Datasession") )
		lcXml = this.CursorAXml( lcCursor )
		
		use in select( lcCursor )
		
		Return lcXml 
		
	endfunc
	*-----------------------------------------------------------------------------------------
	function ObtenerDatosEntidadPaginado( tcOrderBy as String, tcFiltro as String, tnCantidad as Integer, tnPagina as Integer )  as String
		local lcOrderBy as String, lnCuantos as Integer, lnPagina as Integer, lnTope as Integer, lnDesde as Integer, lcSQL as String, lcCursor as String, lcXml as String
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "CODIGO"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
			text to lcAtributos textmerge noshow
			"Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Codigo" as "Codigo", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Valtafw" as "Versionaltafw", "Horaexpo" as "Horaexpo", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Descfw" as "Descripcionfw", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Zadsfw" as "Zadsfw", "Timestamp" as "Timestamp", "Anulado" as "Anulado", "Descrip" as "Descripcion", "Artdesde" as "F_articulo_desde", "Unidesde" as "F_articulo_unidaddemedida_desde", "Fecha" as "Fecha", "Arthasta" as "F_articulo_hasta", "Unihasta" as "F_articulo_unidaddemedida_hasta", "Fproceso" as "Fechaproceso", "Fechabase" as "Fechabase", "Coldesde" as "F_color_desde", "Famdesde" as "F_articulo_familia_desde", "Colhasta" as "F_color_hasta", "Famhasta" as "F_articulo_familia_hasta", "Fechavig" as "Fechavigencia", "Sintransac" as "Importarsintransaccion", "Taldesde" as "F_talle_desde", "Lindesde" as "F_articulo_linea_desde", "Talhasta" as "F_talle_hasta", "Linhasta" as "F_articulo_linea_hasta", "Comporta" as "Articulo_comportamiento", "Catdesde" as "F_articulo_categoriadearticulo_desde", "Provdesde" as "F_articulo_proveedor_desde", "Kpxpartic" as "Preciokitpackxparticipante", "Cathasta" as "F_articulo_categoriadearticulo_hasta", "Provhasta" as "F_articulo_proveedor_hasta", "Pdcdesde" as "F_articulo_paletadecolores_desde", "Cdtdesde" as "F_articulo_curvadetalles_desde", "Narbadesde" as "F_articulo_nomenclador_desde", "Temdesde" as "F_articulo_temporada_desde", "Pdchasta" as "F_articulo_paletadecolores_hasta", "Cdthasta" as "F_articulo_curvadetalles_hasta", "Narbahasta" as "F_articulo_nomenclador_hasta", "Temhasta" as "F_articulo_temporada_hasta", "Anodesde" as "F_articulo_ano_desde", "Cladesde" as "F_articulo_clasificacion_desde", "Anohasta" as "F_articulo_ano_hasta", "Clahasta" as "F_articulo_clasificacion_hasta", "Tipdesde" as "F_articulo_tipodearticulo_desde", "Matdesde" as "F_articulo_material_desde", "Tiphasta" as "F_articulo_tipodearticulo_hasta", "Mathasta" as "F_articulo_material_hasta", "Grudesde" as "F_articulo_grupo_desde", "Altdesde" as "F_articulo_fechaaltafw_desde", "Gruhasta" as "F_articulo_grupo_hasta", "Althasta" as "F_articulo_fechaaltafw_hasta", "Moddesde" as "F_articulo_fechamodificacionfw_desde", "Tradesde" as "F_articulo_fechatransferencia_desde", "Usacomb" as "Usacombinacion", "Modhasta" as "F_articulo_fechamodificacionfw_hasta", "Trahasta" as "F_articulo_fechatransferencia_hasta", "Ualta" as "F_articulo_usuarioaltafw", "Impdesde" as "F_articulo_fechaimpo_desde", "Umod" as "F_articulo_usuariomodificacionfw", "Mobs" as "Observacion", "Imphasta" as "F_articulo_fechaimpo_hasta", "Expdesde" as "F_articulo_fechaexpo_desde", "Exphasta" as "F_articulo_fechaexpo_hasta", "Compdesde" as "F_articulo_comportamiento_desde", "Comphasta" as "F_articulo_comportamiento_hasta", "Ftsadesde" as "F_timestampalta_desde", "Ftsahasta" as "F_timestampalta_hasta", "Precdesde" as "F_preciodirecto_desde", "Prechasta" as "F_preciodirecto_hasta", "Marcadesde" as "F_articulo_marca_desde", "Marcahasta" as "F_articulo_marca_hasta"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.CALCPREC 
								Where   CALCPREC.CODIGO != 0
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
	Tabla = 'CALCPREC'
	Filtro = " CALCPREC.CODIGO != 0"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " CALCPREC.CODIGO != 0"
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
	<row entidad="CALCULODEPRECIOS                        " atributo="FECHAEXPO                               " tabla="CALCPREC       " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="FECHAALTAFW                             " tabla="CALCPREC       " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="FECHAIMPO                               " tabla="CALCPREC       " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="FECHAMODIFICACIONFW                     " tabla="CALCPREC       " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="FECHATRANSFERENCIA                      " tabla="CALCPREC       " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha de novedad                                                                                                                                                " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="CODIGO                                  " tabla="CALCPREC       " campo="CODIGO    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="2" etiqueta="Número                                                                                                                                                          " dominio="CODIGONUMERICO                " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="USUARIOALTAFW                           " tabla="CALCPREC       " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="SERIEMODIFICACIONFW                     " tabla="CALCPREC       " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="VERSIONALTAFW                           " tabla="CALCPREC       " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="HORAEXPO                                " tabla="CALCPREC       " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="VERSIONMODIFICACIONFW                   " tabla="CALCPREC       " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="USUARIOMODIFICACIONFW                   " tabla="CALCPREC       " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="BASEDEDATOSALTAFW                       " tabla="CALCPREC       " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="ESTADOTRANSFERENCIA                     " tabla="CALCPREC       " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado de novedad                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="HORAALTAFW                              " tabla="CALCPREC       " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="CALCPREC       " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="DESCRIPCIONFW                           " tabla="CALCPREC       " campo="DESCFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="200" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="HORAMODIFICACIONFW                      " tabla="CALCPREC       " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="HORAIMPO                                " tabla="CALCPREC       " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="SERIEALTAFW                             " tabla="CALCPREC       " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="ZADSFW                                  " tabla="CALCPREC       " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="TIMESTAMP                               " tabla="CALCPREC       " campo="TIMESTAMP " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="ANULADO                                 " tabla="CALCPREC       " campo="ANULADO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Anulado                                                                                                                                                         " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="DESCRIPCION                             " tabla="CALCPREC       " campo="DESCRIP   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="4" etiqueta="Descripción                                                                                                                                                     " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="F_ARTICULO_DESDE                        " tabla="CALCPREC       " campo="ARTDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="ARTICULO                                " tipodato="C         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="Artículo desde                                                                                                                                                  " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="F_ARTICULO_UNIDADDEMEDIDA_DESDE         " tabla="CALCPREC       " campo="UNIDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="UNIDADDEMEDIDA                          " tipodato="C         " longitud="3" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="402" etiqueta="Unidad de medida desde                                                                                                                                          " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="25" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="FECHA                                   " tabla="CALCPREC       " campo="FECHA     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goServicios.librerias.ObtenerFecha()                                                                                                                                                                                                                         " obligatorio="true" admitebusqueda="404" etiqueta="Fecha                                                                                                                                                           " dominio="FECHACALENDARIO               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="4" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="F_ARTICULO_HASTA                        " tabla="CALCPREC       " campo="ARTHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="ARTICULO                                " tipodato="C         " longitud="15" decimales="0" valorsugerido="=Replicate( &quot;Z&quot;,15)                                                                                                                                                                                                                                           " obligatorio="false" admitebusqueda="406" etiqueta="Artículo hasta                                                                                                                                                  " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="F_ARTICULO_UNIDADDEMEDIDA_HASTA         " tabla="CALCPREC       " campo="UNIHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="UNIDADDEMEDIDA                          " tipodato="C         " longitud="3" decimales="0" valorsugerido="=Replicate( &quot;Z&quot;,3)                                                                                                                                                                                                                                            " obligatorio="false" admitebusqueda="408" etiqueta="Unidad de medida hasta                                                                                                                                          " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="25" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="FECHAPROCESO                            " tabla="CALCPREC       " campo="FPROCESO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Procesado el                                                                                                                                                    " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="3" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="FECHABASE                               " tabla="CALCPREC       " campo="FECHABASE " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goServicios.librerias.ObtenerFecha()                                                                                                                                                                                                                         " obligatorio="true" admitebusqueda="410" etiqueta="Fecha base de precios                                                                                                                                           " dominio="FECHACALENDARIO               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="4" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="F_COLOR_DESDE                           " tabla="CALCPREC       " campo="COLDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="COLOR                                   " tipodato="C         " longitud="6" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="412" etiqueta="Color desde                                                                                                                                                     " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="F_ARTICULO_FAMILIA_DESDE                " tabla="CALCPREC       " campo="FAMDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="FAMILIA                                 " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="414" etiqueta="Familia desde                                                                                                                                                   " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="7" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="F_COLOR_HASTA                           " tabla="CALCPREC       " campo="COLHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="COLOR                                   " tipodato="C         " longitud="6" decimales="0" valorsugerido="=Replicate( &quot;Z&quot;,6 )                                                                                                                                                                                                                                           " obligatorio="false" admitebusqueda="416" etiqueta="Color hasta                                                                                                                                                     " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="F_ARTICULO_FAMILIA_HASTA                " tabla="CALCPREC       " campo="FAMHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="FAMILIA                                 " tipodato="C         " longitud="10" decimales="0" valorsugerido="=Replicate( &quot;Z&quot;,10)                                                                                                                                                                                                                                           " obligatorio="false" admitebusqueda="418" etiqueta="Familia hasta                                                                                                                                                   " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="7" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="FECHAVIGENCIA                           " tabla="CALCPREC       " campo="FECHAVIG  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goServicios.librerias.ObtenerFecha() +1                                                                                                                                                                                                                      " obligatorio="true" admitebusqueda="420" etiqueta="Vigencia desde                                                                                                                                                  " dominio="FECHACALENDARIO               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="4" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="IMPORTARSINTRANSACCION                  " tabla="CALCPREC       " campo="SINTRANSAC" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="=.T.                                                                                                                                                                                                                                                          " obligatorio="false" admitebusqueda="422" etiqueta="Procesar sin validaciones                                                                                                                                       " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="F_TALLE_DESDE                           " tabla="CALCPREC       " campo="TALDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="TALLE                                   " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="424" etiqueta="Talle desde                                                                                                                                                     " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="3" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="F_ARTICULO_LINEA_DESDE                  " tabla="CALCPREC       " campo="LINDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="LINEA                                   " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="426" etiqueta="Línea desde                                                                                                                                                     " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="9" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="F_TALLE_HASTA                           " tabla="CALCPREC       " campo="TALHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="TALLE                                   " tipodato="C         " longitud="5" decimales="0" valorsugerido="=Replicate( &quot;Z&quot;,5 )                                                                                                                                                                                                                                           " obligatorio="false" admitebusqueda="428" etiqueta="Talle hasta                                                                                                                                                     " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="3" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="F_ARTICULO_LINEA_HASTA                  " tabla="CALCPREC       " campo="LINHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="LINEA                                   " tipodato="C         " longitud="10" decimales="0" valorsugerido="=Replicate( &quot;Z&quot;,10)                                                                                                                                                                                                                                           " obligatorio="false" admitebusqueda="430" etiqueta="Línea hasta                                                                                                                                                     " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="9" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="ARTICULO_COMPORTAMIENTO                 " tabla="CALCPREC       " campo="COMPORTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="432" etiqueta="Comportamiento                                                                                                                                                  " dominio="COMBOCOMPORTAMIENTO           " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="7" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="F_ARTICULO_CATEGORIADEARTICULO_DESDE    " tabla="CALCPREC       " campo="CATDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CATEGORIADEARTICULO                     " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="434" etiqueta="Categoría de artículo desde                                                                                                                                     " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="11" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="F_ARTICULO_PROVEEDOR_DESDE              " tabla="CALCPREC       " campo="PROVDESDE " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="PROVEEDOR                               " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="436" etiqueta="Proveedor desde                                                                                                                                                 " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="4" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="PRECIOKITPACKXPARTICIPANTE              " tabla="CALCPREC       " campo="KPXPARTIC " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="=.F.                                                                                                                                                                                                                                                          " obligatorio="false" admitebusqueda="438" etiqueta="Cálculo de precio de kit / pack en base a sus participantes                                                                                                     " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="8" orden="8" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="F_ARTICULO_CATEGORIADEARTICULO_HASTA    " tabla="CALCPREC       " campo="CATHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CATEGORIADEARTICULO                     " tipodato="C         " longitud="10" decimales="0" valorsugerido="=Replicate( &quot;Z&quot;,10)                                                                                                                                                                                                                                           " obligatorio="false" admitebusqueda="440" etiqueta="Categoría de artículo hasta                                                                                                                                     " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="11" orden="8" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="F_ARTICULO_PROVEEDOR_HASTA              " tabla="CALCPREC       " campo="PROVHASTA " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="PROVEEDOR                               " tipodato="C         " longitud="10" decimales="0" valorsugerido="=Replicate( &quot;Z&quot;,10)                                                                                                                                                                                                                                           " obligatorio="false" admitebusqueda="442" etiqueta="Proveedor hasta                                                                                                                                                 " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="4" orden="8" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="F_ARTICULO_PALETADECOLORES_DESDE        " tabla="CALCPREC       " campo="PDCDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="PALETADECOLORES                         " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Paleta de colores desde                                                                                                                                         " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="9" orden="9" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="F_ARTICULO_CURVADETALLES_DESDE          " tabla="CALCPREC       " campo="CDTDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CURVADETALLES                           " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Curva talles desde                                                                                                                                              " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="10" orden="9" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="F_ARTICULO_NOMENCLADOR_DESDE            " tabla="CALCPREC       " campo="NARBADESDE" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="NOMENCLADORARBA                         " tipodato="C         " longitud="6" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="444" etiqueta="Código nomenclador desde                                                                                                                                        " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="30" orden="9" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="F_ARTICULO_TEMPORADA_DESDE              " tabla="CALCPREC       " campo="TEMDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="TEMPORADA                               " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="446" etiqueta="Temporada desde                                                                                                                                                 " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="5" orden="9" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="F_ARTICULO_PALETADECOLORES_HASTA        " tabla="CALCPREC       " campo="PDCHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="PALETADECOLORES                         " tipodato="C         " longitud="10" decimales="0" valorsugerido="=Replicate( &quot;Z&quot;,10 )                                                                                                                                                                                                                                          " obligatorio="false" admitebusqueda="0" etiqueta="Paleta de colores hasta                                                                                                                                         " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="9" orden="10" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="F_ARTICULO_CURVADETALLES_HASTA          " tabla="CALCPREC       " campo="CDTHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CURVADETALLES                           " tipodato="C         " longitud="10" decimales="0" valorsugerido="=Replicate( &quot;Z&quot;,10 )                                                                                                                                                                                                                                          " obligatorio="false" admitebusqueda="0" etiqueta="Curva talles hasta                                                                                                                                              " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="10" orden="10" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="F_ARTICULO_NOMENCLADOR_HASTA            " tabla="CALCPREC       " campo="NARBAHASTA" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="NOMENCLADORARBA                         " tipodato="C         " longitud="6" decimales="0" valorsugerido="=Replicate( &quot;Z&quot;,6 )                                                                                                                                                                                                                                           " obligatorio="false" admitebusqueda="448" etiqueta="Código nomenclador hasta                                                                                                                                        " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="30" orden="10" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="F_ARTICULO_TEMPORADA_HASTA              " tabla="CALCPREC       " campo="TEMHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="TEMPORADA                               " tipodato="C         " longitud="5" decimales="0" valorsugerido="=Replicate( &quot;Z&quot;,5)                                                                                                                                                                                                                                            " obligatorio="false" admitebusqueda="450" etiqueta="Temporada hasta                                                                                                                                                 " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="5" orden="10" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="F_ARTICULO_ANO_DESDE                    " tabla="CALCPREC       " campo="ANODESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="4" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="452" etiqueta="Año desde                                                                                                                                                       " dominio="EtiquetaNumericoDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="6" orden="11" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="F_ARTICULO_CLASIFICACION_DESDE          " tabla="CALCPREC       " campo="CLADESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CLASIFICACIONARTICULO                   " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="454" etiqueta="Clasificación desde                                                                                                                                             " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="12" orden="11" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="F_ARTICULO_ANO_HASTA                    " tabla="CALCPREC       " campo="ANOHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="4" decimales="0" valorsugerido="9999                                                                                                                                                                                                                                                          " obligatorio="false" admitebusqueda="456" etiqueta="Año hasta                                                                                                                                                       " dominio="EtiquetaNumericoDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="6" orden="12" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="F_ARTICULO_CLASIFICACION_HASTA          " tabla="CALCPREC       " campo="CLAHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CLASIFICACIONARTICULO                   " tipodato="C         " longitud="10" decimales="0" valorsugerido="=Replicate( &quot;Z&quot;,10)                                                                                                                                                                                                                                           " obligatorio="false" admitebusqueda="458" etiqueta="Clasificación hasta                                                                                                                                             " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="12" orden="12" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="F_ARTICULO_TIPODEARTICULO_DESDE         " tabla="CALCPREC       " campo="TIPDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="TIPODEARTICULO                          " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="460" etiqueta="Tipo de artículo desde                                                                                                                                          " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="13" orden="13" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="F_ARTICULO_MATERIAL_DESDE               " tabla="CALCPREC       " campo="MATDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="MATERIAL                                " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="462" etiqueta="Material desde                                                                                                                                                  " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="8" orden="13" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="F_ARTICULO_TIPODEARTICULO_HASTA         " tabla="CALCPREC       " campo="TIPHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="TIPODEARTICULO                          " tipodato="C         " longitud="10" decimales="0" valorsugerido="=Replicate( &quot;Z&quot;,10)                                                                                                                                                                                                                                           " obligatorio="false" admitebusqueda="464" etiqueta="Tipo de artículo hasta                                                                                                                                          " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="13" orden="14" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="F_ARTICULO_MATERIAL_HASTA               " tabla="CALCPREC       " campo="MATHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="MATERIAL                                " tipodato="C         " longitud="10" decimales="0" valorsugerido="=Replicate( &quot;Z&quot;,10)                                                                                                                                                                                                                                           " obligatorio="false" admitebusqueda="466" etiqueta="Material hasta                                                                                                                                                  " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="8" orden="14" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="F_ARTICULO_GRUPO_DESDE                  " tabla="CALCPREC       " campo="GRUDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="GRUPO                                   " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="468" etiqueta="Grupo desde                                                                                                                                                     " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="10" orden="15" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="F_ARTICULO_FECHAALTAFW_DESDE            " tabla="CALCPREC       " campo="ALTDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="470" etiqueta="Fecha alta desde                                                                                                                                                " dominio="EtiquetaFechaDesdeHastaBusc   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="32" orden="15" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="F_ARTICULO_GRUPO_HASTA                  " tabla="CALCPREC       " campo="GRUHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="GRUPO                                   " tipodato="C         " longitud="10" decimales="0" valorsugerido="=Replicate( &quot;Z&quot;,10)                                                                                                                                                                                                                                           " obligatorio="false" admitebusqueda="472" etiqueta="Grupo hasta                                                                                                                                                     " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="10" orden="16" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="F_ARTICULO_FECHAALTAFW_HASTA            " tabla="CALCPREC       " campo="ALTHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goServicios.librerias.ObtenerFecha()                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="474" etiqueta="Fecha alta hasta                                                                                                                                                " dominio="EtiquetaFechaDesdeHastaBusc   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="32" orden="16" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="F_ARTICULO_FECHAMODIFICACIONFW_DESDE    " tabla="CALCPREC       " campo="MODDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="476" etiqueta="Fecha modificación desde                                                                                                                                        " dominio="EtiquetaFechaDesdeHastaBusc   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="31" orden="17" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="F_ARTICULO_FECHATRANSFERENCIA_DESDE     " tabla="CALCPREC       " campo="TRADESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="478" etiqueta="Fecha recepción desde                                                                                                                                           " dominio="EtiquetaFechaDesdeHastaBusc   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="36" orden="17" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="USACOMBINACION                          " tabla="CALCPREC       " campo="USACOMB   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="=.F.                                                                                                                                                                                                                                                          " obligatorio="false" admitebusqueda="480" etiqueta="Maneja precio por combinación                                                                                                                                   " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="18" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="F_ARTICULO_FECHAMODIFICACIONFW_HASTA    " tabla="CALCPREC       " campo="MODHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goServicios.librerias.ObtenerFecha()                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="482" etiqueta="Fecha modificación hasta                                                                                                                                        " dominio="EtiquetaFechaDesdeHastaBusc   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="31" orden="18" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="F_ARTICULO_FECHATRANSFERENCIA_HASTA     " tabla="CALCPREC       " campo="TRAHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goServicios.librerias.ObtenerFecha()                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="484" etiqueta="Fecha recepción hasta                                                                                                                                           " dominio="EtiquetaFechaDesdeHastaBusc   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="36" orden="18" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="F_ARTICULO_USUARIOALTAFW                " tabla="CALCPREC       " campo="UALTA     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="65" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="486" etiqueta="Usuario que dio de alta                                                                                                                                         " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="45" orden="19" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="MODPRECIOS                              " tabla="CALCPRECDET    " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="488" etiqueta="                                                                                                                                                                " dominio="DETALLEITEMCALCULODEPRECIOS   " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="19" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="F_ARTICULO_FECHAIMPO_DESDE              " tabla="CALCPREC       " campo="IMPDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="490" etiqueta="Fecha importación desde                                                                                                                                         " dominio="EtiquetaFechaDesdeHastaBusc   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="37" orden="19" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="F_ARTICULO_USUARIOMODIFICACIONFW        " tabla="CALCPREC       " campo="UMOD      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="65" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="492" etiqueta="Ultimo usuario que modifico                                                                                                                                     " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="46" orden="20" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="OBSERVACION                             " tabla="CALCPREC       " campo="MOBS      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="494" etiqueta="Observaciones                                                                                                                                                   " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="20" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="F_ARTICULO_FECHAIMPO_HASTA              " tabla="CALCPREC       " campo="IMPHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goServicios.librerias.ObtenerFecha()                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="496" etiqueta="Fecha importación hasta                                                                                                                                         " dominio="EtiquetaFechaDesdeHastaBusc   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="37" orden="20" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="F_ARTICULO_FECHAEXPO_DESDE              " tabla="CALCPREC       " campo="EXPDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="498" etiqueta="Fecha exportación desde                                                                                                                                         " dominio="EtiquetaFechaDesdeHastaBusc   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="38" orden="21" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="F_ARTICULO_FECHAEXPO_HASTA              " tabla="CALCPREC       " campo="EXPHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goServicios.librerias.ObtenerFecha()                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="500" etiqueta="Fecha exportación hasta                                                                                                                                         " dominio="EtiquetaFechaDesdeHastaBusc   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="38" orden="22" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="F_ARTICULO_COMPORTAMIENTO_DESDE         " tabla="CALCPREC       " campo="COMPDESDE " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="0                                                                                                                                                                                                                                                             " obligatorio="false" admitebusqueda="0" etiqueta="Comportamiento desde                                                                                                                                            " dominio="EtiquetaFechaDesdeHastaBusc   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="15" orden="25" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="F_ARTICULO_COMPORTAMIENTO_HASTA         " tabla="CALCPREC       " campo="COMPHASTA " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="9                                                                                                                                                                                                                                                             " obligatorio="false" admitebusqueda="0" etiqueta="Comportamiento hasa                                                                                                                                             " dominio="EtiquetaFechaDesdeHastaBusc   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="15" orden="26" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="F_TIMESTAMPALTA_DESDE                   " tabla="CALCPREC       " campo="FTSADESDE " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="14" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="502" etiqueta="Timestamp alta desde                                                                                                                                            " dominio="EtiquetaNumericoDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="35" orden="30" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="F_TIMESTAMPALTA_HASTA                   " tabla="CALCPREC       " campo="FTSAHASTA " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="14" decimales="0" valorsugerido="99999999999999                                                                                                                                                                                                                                                " obligatorio="false" admitebusqueda="504" etiqueta="Timestamp alta hasta                                                                                                                                            " dominio="EtiquetaNumericoDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="35" orden="31" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="F_PRECIODIRECTO_DESDE                   " tabla="CALCPREC       " campo="PRECDESDE " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="506" etiqueta="Precio directo desde                                                                                                                                            " dominio="EtiquetaNumericoDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="40" orden="37" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="F_PRECIODIRECTO_HASTA                   " tabla="CALCPREC       " campo="PRECHASTA " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="999999999999.99                                                                                                                                                                                                                                               " obligatorio="false" admitebusqueda="508" etiqueta="Precio directo hasta                                                                                                                                            " dominio="EtiquetaNumericoDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="40" orden="38" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="F_ARTICULO_MARCA_DESDE                  " tabla="CALCPREC       " campo="MARCADESDE" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="MARCA                                   " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="510" etiqueta="Marca del artículo desde                                                                                                                                        " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="42" orden="39" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="F_ARTICULO_MARCA_HASTA                  " tabla="CALCPREC       " campo="MARCAHASTA" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="MARCA                                   " tipodato="C         " longitud="30" decimales="0" valorsugerido="=Replicate( &quot;Z&quot;,30)                                                                                                                                                                                                                                           " obligatorio="false" admitebusqueda="512" etiqueta="Marca del artículo hasta                                                                                                                                        " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="42" orden="40" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="DESCRIPCION                             " tabla="ART            " campo="ARTDES    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="401" etiqueta="Detalle Art.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join ART On CALCPREC.ARTDESDE = ART.ARTCOD And  ART.ARTCOD != ''                                                                                                                                                                                        " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="UNIDADDEMEDIDA                          " atributo="DESCRIPCION                             " tabla="UNMED          " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="403" etiqueta="Detalle Uni.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join UNMED On CALCPREC.UNIDESDE = UNMED.Cod And  UNMED.COD != ''                                                                                                                                                                                        " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="DESCRIPCION                             " tabla="ART            " campo="ARTDES    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="407" etiqueta="Detalle Art.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join ART On CALCPREC.ARTHASTA = ART.ARTCOD And  ART.ARTCOD != ''                                                                                                                                                                                        " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="UNIDADDEMEDIDA                          " atributo="DESCRIPCION                             " tabla="UNMED          " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="409" etiqueta="Detalle Uni.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join UNMED On CALCPREC.UNIHASTA = UNMED.Cod And  UNMED.COD != ''                                                                                                                                                                                        " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COLOR                                   " atributo="DESCRIPCION                             " tabla="COL            " campo="COLDES    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="413" etiqueta="Detalle Col.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join COL On CALCPREC.COLDESDE = COL.COLCOD And  COL.COLCOD != ''                                                                                                                                                                                        " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FAMILIA                                 " atributo="DESCRIPCION                             " tabla="FAMILIA        " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="415" etiqueta="Detalle Fam.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join FAMILIA On CALCPREC.FAMDESDE = FAMILIA.Cod And  FAMILIA.COD != ''                                                                                                                                                                                  " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COLOR                                   " atributo="DESCRIPCION                             " tabla="COL            " campo="COLDES    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="417" etiqueta="Detalle Col.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join COL On CALCPREC.COLHASTA = COL.COLCOD And  COL.COLCOD != ''                                                                                                                                                                                        " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FAMILIA                                 " atributo="DESCRIPCION                             " tabla="FAMILIA        " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="419" etiqueta="Detalle Fam.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join FAMILIA On CALCPREC.FAMHASTA = FAMILIA.Cod And  FAMILIA.COD != ''                                                                                                                                                                                  " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TALLE                                   " atributo="DESCRIPCION                             " tabla="TALLE          " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="425" etiqueta="Detalle Tal.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join TALLE On CALCPREC.TALDESDE = TALLE.Codigo And  TALLE.CODIGO != ''                                                                                                                                                                                  " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LINEA                                   " atributo="DESCRIPCION                             " tabla="LINEA          " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="427" etiqueta="Detalle Lín.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join LINEA On CALCPREC.LINDESDE = LINEA.Cod And  LINEA.COD != ''                                                                                                                                                                                        " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TALLE                                   " atributo="DESCRIPCION                             " tabla="TALLE          " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="429" etiqueta="Detalle Tal.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join TALLE On CALCPREC.TALHASTA = TALLE.Codigo And  TALLE.CODIGO != ''                                                                                                                                                                                  " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LINEA                                   " atributo="DESCRIPCION                             " tabla="LINEA          " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="431" etiqueta="Detalle Lín.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join LINEA On CALCPREC.LINHASTA = LINEA.Cod And  LINEA.COD != ''                                                                                                                                                                                        " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CATEGORIADEARTICULO                     " atributo="DESCRIPCION                             " tabla="CATEGART       " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="435" etiqueta="Detalle Cat.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CATEGART On CALCPREC.CATDESDE = CATEGART.Cod And  CATEGART.COD != ''                                                                                                                                                                               " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="NOMBRE                                  " tabla="PROV           " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="437" etiqueta="Detalle Pro.                                                                                                                                                    " dominio="TEXTOBUSQUEDA                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join PROV On CALCPREC.PROVDESDE = PROV.CLCOD And  PROV.CLCOD != ''                                                                                                                                                                                      " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="5" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CATEGORIADEARTICULO                     " atributo="DESCRIPCION                             " tabla="CATEGART       " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="441" etiqueta="Detalle Cat.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CATEGART On CALCPREC.CATHASTA = CATEGART.Cod And  CATEGART.COD != ''                                                                                                                                                                               " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="NOMBRE                                  " tabla="PROV           " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="443" etiqueta="Detalle Pro.                                                                                                                                                    " dominio="TEXTOBUSQUEDA                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join PROV On CALCPREC.PROVHASTA = PROV.CLCOD And  PROV.CLCOD != ''                                                                                                                                                                                      " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="5" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOMENCLADORARBA                         " atributo="DESCRIPCION                             " tabla="NMCARBA        " campo="NMCDES    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="150" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="445" etiqueta="Detalle Cód.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join NMCARBA On CALCPREC.NARBADESDE = NMCARBA.NMCCOD And  NMCARBA.NMCCOD != ''                                                                                                                                                                          " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TEMPORADA                               " atributo="DESCRIPCION                             " tabla="TEMPORADA      " campo="TDES      " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="447" etiqueta="Detalle Tem.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join TEMPORADA On CALCPREC.TEMDESDE = TEMPORADA.TCOD And  TEMPORADA.TCOD != ''                                                                                                                                                                          " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOMENCLADORARBA                         " atributo="DESCRIPCION                             " tabla="NMCARBA        " campo="NMCDES    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="150" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="449" etiqueta="Detalle Cód.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join NMCARBA On CALCPREC.NARBAHASTA = NMCARBA.NMCCOD And  NMCARBA.NMCCOD != ''                                                                                                                                                                          " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TEMPORADA                               " atributo="DESCRIPCION                             " tabla="TEMPORADA      " campo="TDES      " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="451" etiqueta="Detalle Tem.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join TEMPORADA On CALCPREC.TEMHASTA = TEMPORADA.TCOD And  TEMPORADA.TCOD != ''                                                                                                                                                                          " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLASIFICACIONARTICULO                   " atributo="DESCRIPCION                             " tabla="CLASIFART      " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="455" etiqueta="Detalle Cla.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CLASIFART On CALCPREC.CLADESDE = CLASIFART.CODIGO And  CLASIFART.CODIGO != ''                                                                                                                                                                      " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLASIFICACIONARTICULO                   " atributo="DESCRIPCION                             " tabla="CLASIFART      " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="459" etiqueta="Detalle Cla.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CLASIFART On CALCPREC.CLAHASTA = CLASIFART.CODIGO And  CLASIFART.CODIGO != ''                                                                                                                                                                      " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIPODEARTICULO                          " atributo="DESCRIPCION                             " tabla="TIPOART        " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="461" etiqueta="Detalle Tip.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join TIPOART On CALCPREC.TIPDESDE = TIPOART.Cod And  TIPOART.COD != ''                                                                                                                                                                                  " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MATERIAL                                " atributo="DESCRIPCION                             " tabla="MAT            " campo="MATDES    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="463" etiqueta="Detalle Mat.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join MAT On CALCPREC.MATDESDE = MAT.MATCOD And  MAT.MATCOD != ''                                                                                                                                                                                        " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIPODEARTICULO                          " atributo="DESCRIPCION                             " tabla="TIPOART        " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="465" etiqueta="Detalle Tip.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join TIPOART On CALCPREC.TIPHASTA = TIPOART.Cod And  TIPOART.COD != ''                                                                                                                                                                                  " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MATERIAL                                " atributo="DESCRIPCION                             " tabla="MAT            " campo="MATDES    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="467" etiqueta="Detalle Mat.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join MAT On CALCPREC.MATHASTA = MAT.MATCOD And  MAT.MATCOD != ''                                                                                                                                                                                        " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="GRUPO                                   " atributo="DESCRIPCION                             " tabla="GRUPO          " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="469" etiqueta="Detalle Gru.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join GRUPO On CALCPREC.GRUDESDE = GRUPO.Cod And  GRUPO.COD != ''                                                                                                                                                                                        " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="GRUPO                                   " atributo="DESCRIPCION                             " tabla="GRUPO          " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="473" etiqueta="Detalle Gru.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join GRUPO On CALCPREC.GRUHASTA = GRUPO.Cod And  GRUPO.COD != ''                                                                                                                                                                                        " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MARCA                                   " atributo="DESCRIPCION                             " tabla="MARCAS         " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="511" etiqueta="Detalle Mar.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join MARCAS On CALCPREC.MARCADESDE = MARCAS.Codigo And  MARCAS.CODIGO != ''                                                                                                                                                                             " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MARCA                                   " atributo="DESCRIPCION                             " tabla="MARCAS         " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="513" etiqueta="Detalle Mar.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join MARCAS On CALCPREC.MARCAHASTA = MARCAS.Codigo And  MARCAS.CODIGO != ''                                                                                                                                                                             " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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