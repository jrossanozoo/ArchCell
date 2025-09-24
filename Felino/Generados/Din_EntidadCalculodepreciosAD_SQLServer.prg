
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
			local  lxCalcprecFecimpo, lxCalcprecFmodifw, lxCalcprecFectrans, lxCalcprecFaltafw, lxCalcprecFecexpo, lxCalcprecCodigo, lxCalcprecTimestamp, lxCalcprecAnulado, lxCalcprecSaltafw, lxCalcprecValtafw, lxCalcprecUaltafw, lxCalcprecVmodifw, lxCalcprecHaltafw, lxCalcprecDescfw, lxCalcprecZadsfw, lxCalcprecBdmodifw, lxCalcprecEsttrans, lxCalcprecBdaltafw, lxCalcprecHoraexpo, lxCalcprecUmodifw, lxCalcprecHoraimpo, lxCalcprecSmodifw, lxCalcprecHmodifw, lxCalcprecDescrip, lxCalcprecFecha, lxCalcprecFproceso, lxCalcprecFechavig, lxCalcprecFechabase, lxCalcprecArtdesde, lxCalcprecSintransac, lxCalcprecArthasta, lxCalcprecColdesde, lxCalcprecColhasta, lxCalcprecComporta, lxCalcprecTaldesde, lxCalcprecKpxpartic, lxCalcprecTalhasta, lxCalcprecProdesde, lxCalcprecUsacomb, lxCalcprecProhasta, lxCalcprecUnidesde, lxCalcprecUnihasta, lxCalcprecMatdesde, lxCalcprecMathasta, lxCalcprecEstdesde, lxCalcprecEsthasta, lxCalcprecUalta, lxCalcprecAnidesde, lxCalcprecUmod, lxCalcprecMobs, lxCalcprecAnihasta, lxCalcprecClasidesde, lxCalcprecNarbadesde, lxCalcprecClasihasta, lxCalcprecNarbahasta, lxCalcprecFtsadesde, lxCalcprecFtsahasta, lxCalcprecFecdesde, lxCalcprecFechasta, lxCalcprecCompdesde, lxCalcprecComphasta, lxCalcprecPrecdesde, lxCalcprecPrechasta, lxCalcprecMarcadesde, lxCalcprecMarcahasta
				lxCalcprecFecimpo =  .Fechaimpo			lxCalcprecFmodifw =  .Fechamodificacionfw			lxCalcprecFectrans =  .Fechatransferencia			lxCalcprecFaltafw =  .Fechaaltafw			lxCalcprecFecexpo =  .Fechaexpo			lxCalcprecCodigo =  .Codigo			lxCalcprecTimestamp = goLibrerias.ObtenerTimestamp()			lxCalcprecAnulado =  .Anulado			lxCalcprecSaltafw =  .Seriealtafw			lxCalcprecValtafw =  .Versionaltafw			lxCalcprecUaltafw =  .Usuarioaltafw			lxCalcprecVmodifw =  .Versionmodificacionfw			lxCalcprecHaltafw =  .Horaaltafw			lxCalcprecDescfw =  .Descripcionfw			lxCalcprecZadsfw =  .Zadsfw			lxCalcprecBdmodifw =  .Basededatosmodificacionfw			lxCalcprecEsttrans =  .Estadotransferencia			lxCalcprecBdaltafw =  .Basededatosaltafw			lxCalcprecHoraexpo =  .Horaexpo			lxCalcprecUmodifw =  .Usuariomodificacionfw			lxCalcprecHoraimpo =  .Horaimpo			lxCalcprecSmodifw =  .Seriemodificacionfw			lxCalcprecHmodifw =  .Horamodificacionfw			lxCalcprecDescrip =  .Descripcion			lxCalcprecFecha =  .Fecha			lxCalcprecFproceso =  .Fechaproceso			lxCalcprecFechavig =  .Fechavigencia			lxCalcprecFechabase =  .Fechabase			lxCalcprecArtdesde =  upper( .f_Articulo_Desde_PK ) 			lxCalcprecSintransac =  .Importarsintransaccion			lxCalcprecArthasta =  upper( .f_Articulo_Hasta_PK ) 			lxCalcprecColdesde =  upper( .f_Color_Desde_PK ) 			lxCalcprecColhasta =  upper( .f_Color_Hasta_PK ) 			lxCalcprecComporta =  .Articulo_comportamiento			lxCalcprecTaldesde =  .F_talle_desde			lxCalcprecKpxpartic =  .Preciokitpackxparticipante			lxCalcprecTalhasta =  .F_talle_hasta			lxCalcprecProdesde =  upper( .f_Articulo_Proveedor_Desde_PK ) 			lxCalcprecUsacomb =  .Usacombinacion			lxCalcprecProhasta =  upper( .f_Articulo_Proveedor_Hasta_PK ) 			lxCalcprecUnidesde =  upper( .f_Articulo_Unidad_Desde_PK ) 			lxCalcprecUnihasta =  upper( .f_Articulo_Unidad_Hasta_PK ) 			lxCalcprecMatdesde =  upper( .f_Articulo_Material_Desde_PK ) 			lxCalcprecMathasta =  upper( .f_Articulo_Material_Hasta_PK ) 			lxCalcprecEstdesde =  .F_articulo_estacion_desde			lxCalcprecEsthasta =  .F_articulo_estacion_hasta			lxCalcprecUalta =  .F_articulo_usuarioaltafw			lxCalcprecAnidesde =  .F_articulo_anio_desde			lxCalcprecUmod =  .F_articulo_usuariomodificacionfw			lxCalcprecMobs =  .Observacion			lxCalcprecAnihasta =  .F_articulo_anio_hasta			lxCalcprecClasidesde =  upper( .f_Articulo_clasificacion_desde_PK ) 			lxCalcprecNarbadesde =  upper( .f_Articulo_Nomenclador_Desde_PK ) 			lxCalcprecClasihasta =  upper( .f_Articulo_clasificacion_hasta_PK ) 			lxCalcprecNarbahasta =  upper( .f_Articulo_Nomenclador_Hasta_PK ) 			lxCalcprecFtsadesde =  .F_timestampalta_desde			lxCalcprecFtsahasta =  .F_timestampalta_hasta			lxCalcprecFecdesde =  .F_articulo_fechaaltafw_desde			lxCalcprecFechasta =  .F_articulo_fechaaltafw_hasta			lxCalcprecCompdesde =  .F_articulo_comportamiento_desde			lxCalcprecComphasta =  .F_articulo_comportamiento_hasta			lxCalcprecPrecdesde =  .F_preciodirecto_desde			lxCalcprecPrechasta =  .F_preciodirecto_hasta			lxCalcprecMarcadesde =  upper( .f_Articulo_Marca_Desde_PK ) 			lxCalcprecMarcahasta =  upper( .f_Articulo_Marca_Hasta_PK ) 
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
				insert into ZooLogic.CALCPREC ( "Fecimpo","Fmodifw","Fectrans","Faltafw","Fecexpo","Codigo","Timestamp","Anulado","Saltafw","Valtafw","Ualtafw","Vmodifw","Haltafw","Descfw","Zadsfw","Bdmodifw","Esttrans","Bdaltafw","Horaexpo","Umodifw","Horaimpo","Smodifw","Hmodifw","Descrip","Fecha","Fproceso","Fechavig","Fechabase","Artdesde","Sintransac","Arthasta","Coldesde","Colhasta","Comporta","Taldesde","Kpxpartic","Talhasta","Prodesde","Usacomb","Prohasta","Unidesde","Unihasta","Matdesde","Mathasta","Estdesde","Esthasta","Ualta","Anidesde","Umod","Mobs","Anihasta","Clasidesde","Narbadesde","Clasihasta","Narbahasta","Ftsadesde","Ftsahasta","Fecdesde","Fechasta","Compdesde","Comphasta","Precdesde","Prechasta","Marcadesde","Marcahasta" ) values ( <<"'" + this.ConvertirDateSql( lxCalcprecFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCalcprecFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCalcprecFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCalcprecFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCalcprecFecexpo ) + "'" >>, <<lxCalcprecCodigo >>, <<lxCalcprecTimestamp >>, <<iif( lxCalcprecAnulado, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxCalcprecSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecDescfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecDescrip ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCalcprecFecha ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCalcprecFproceso ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCalcprecFechavig ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCalcprecFechabase ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecArtdesde ) + "'" >>, <<iif( lxCalcprecSintransac, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxCalcprecArthasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecColdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecColhasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecComporta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecTaldesde ) + "'" >>, <<iif( lxCalcprecKpxpartic, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxCalcprecTalhasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecProdesde ) + "'" >>, <<iif( lxCalcprecUsacomb, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxCalcprecProhasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecUnidesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecUnihasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecMatdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecMathasta ) + "'" >>, <<lxCalcprecEstdesde >>, <<lxCalcprecEsthasta >>, <<"'" + this.FormatearTextoSql( lxCalcprecUalta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecAnidesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecUmod ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecMobs ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecAnihasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecClasidesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecNarbadesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecClasihasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecNarbahasta ) + "'" >>, <<lxCalcprecFtsadesde >>, <<lxCalcprecFtsahasta >>, <<"'" + this.ConvertirDateSql( lxCalcprecFecdesde ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCalcprecFechasta ) + "'" >>, <<lxCalcprecCompdesde >>, <<lxCalcprecComphasta >>, <<lxCalcprecPrecdesde >>, <<lxCalcprecPrechasta >>, <<"'" + this.FormatearTextoSql( lxCalcprecMarcadesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecMarcahasta ) + "'" >> )
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
			local  lxCalcprecFecimpo, lxCalcprecFmodifw, lxCalcprecFectrans, lxCalcprecFaltafw, lxCalcprecFecexpo, lxCalcprecCodigo, lxCalcprecTimestamp, lxCalcprecAnulado, lxCalcprecSaltafw, lxCalcprecValtafw, lxCalcprecUaltafw, lxCalcprecVmodifw, lxCalcprecHaltafw, lxCalcprecDescfw, lxCalcprecZadsfw, lxCalcprecBdmodifw, lxCalcprecEsttrans, lxCalcprecBdaltafw, lxCalcprecHoraexpo, lxCalcprecUmodifw, lxCalcprecHoraimpo, lxCalcprecSmodifw, lxCalcprecHmodifw, lxCalcprecDescrip, lxCalcprecFecha, lxCalcprecFproceso, lxCalcprecFechavig, lxCalcprecFechabase, lxCalcprecArtdesde, lxCalcprecSintransac, lxCalcprecArthasta, lxCalcprecColdesde, lxCalcprecColhasta, lxCalcprecComporta, lxCalcprecTaldesde, lxCalcprecKpxpartic, lxCalcprecTalhasta, lxCalcprecProdesde, lxCalcprecUsacomb, lxCalcprecProhasta, lxCalcprecUnidesde, lxCalcprecUnihasta, lxCalcprecMatdesde, lxCalcprecMathasta, lxCalcprecEstdesde, lxCalcprecEsthasta, lxCalcprecUalta, lxCalcprecAnidesde, lxCalcprecUmod, lxCalcprecMobs, lxCalcprecAnihasta, lxCalcprecClasidesde, lxCalcprecNarbadesde, lxCalcprecClasihasta, lxCalcprecNarbahasta, lxCalcprecFtsadesde, lxCalcprecFtsahasta, lxCalcprecFecdesde, lxCalcprecFechasta, lxCalcprecCompdesde, lxCalcprecComphasta, lxCalcprecPrecdesde, lxCalcprecPrechasta, lxCalcprecMarcadesde, lxCalcprecMarcahasta
				lxCalcprecFecimpo =  .Fechaimpo			lxCalcprecFmodifw =  .Fechamodificacionfw			lxCalcprecFectrans =  .Fechatransferencia			lxCalcprecFaltafw =  .Fechaaltafw			lxCalcprecFecexpo =  .Fechaexpo			lxCalcprecCodigo =  .Codigo			lxCalcprecTimestamp = goLibrerias.ObtenerTimestamp()			lxCalcprecAnulado =  .Anulado			lxCalcprecSaltafw =  .Seriealtafw			lxCalcprecValtafw =  .Versionaltafw			lxCalcprecUaltafw =  .Usuarioaltafw			lxCalcprecVmodifw =  .Versionmodificacionfw			lxCalcprecHaltafw =  .Horaaltafw			lxCalcprecDescfw =  .Descripcionfw			lxCalcprecZadsfw =  .Zadsfw			lxCalcprecBdmodifw =  .Basededatosmodificacionfw			lxCalcprecEsttrans =  .Estadotransferencia			lxCalcprecBdaltafw =  .Basededatosaltafw			lxCalcprecHoraexpo =  .Horaexpo			lxCalcprecUmodifw =  .Usuariomodificacionfw			lxCalcprecHoraimpo =  .Horaimpo			lxCalcprecSmodifw =  .Seriemodificacionfw			lxCalcprecHmodifw =  .Horamodificacionfw			lxCalcprecDescrip =  .Descripcion			lxCalcprecFecha =  .Fecha			lxCalcprecFproceso =  .Fechaproceso			lxCalcprecFechavig =  .Fechavigencia			lxCalcprecFechabase =  .Fechabase			lxCalcprecArtdesde =  upper( .f_Articulo_Desde_PK ) 			lxCalcprecSintransac =  .Importarsintransaccion			lxCalcprecArthasta =  upper( .f_Articulo_Hasta_PK ) 			lxCalcprecColdesde =  upper( .f_Color_Desde_PK ) 			lxCalcprecColhasta =  upper( .f_Color_Hasta_PK ) 			lxCalcprecComporta =  .Articulo_comportamiento			lxCalcprecTaldesde =  .F_talle_desde			lxCalcprecKpxpartic =  .Preciokitpackxparticipante			lxCalcprecTalhasta =  .F_talle_hasta			lxCalcprecProdesde =  upper( .f_Articulo_Proveedor_Desde_PK ) 			lxCalcprecUsacomb =  .Usacombinacion			lxCalcprecProhasta =  upper( .f_Articulo_Proveedor_Hasta_PK ) 			lxCalcprecUnidesde =  upper( .f_Articulo_Unidad_Desde_PK ) 			lxCalcprecUnihasta =  upper( .f_Articulo_Unidad_Hasta_PK ) 			lxCalcprecMatdesde =  upper( .f_Articulo_Material_Desde_PK ) 			lxCalcprecMathasta =  upper( .f_Articulo_Material_Hasta_PK ) 			lxCalcprecEstdesde =  .F_articulo_estacion_desde			lxCalcprecEsthasta =  .F_articulo_estacion_hasta			lxCalcprecUalta =  .F_articulo_usuarioaltafw			lxCalcprecAnidesde =  .F_articulo_anio_desde			lxCalcprecUmod =  .F_articulo_usuariomodificacionfw			lxCalcprecMobs =  .Observacion			lxCalcprecAnihasta =  .F_articulo_anio_hasta			lxCalcprecClasidesde =  upper( .f_Articulo_clasificacion_desde_PK ) 			lxCalcprecNarbadesde =  upper( .f_Articulo_Nomenclador_Desde_PK ) 			lxCalcprecClasihasta =  upper( .f_Articulo_clasificacion_hasta_PK ) 			lxCalcprecNarbahasta =  upper( .f_Articulo_Nomenclador_Hasta_PK ) 			lxCalcprecFtsadesde =  .F_timestampalta_desde			lxCalcprecFtsahasta =  .F_timestampalta_hasta			lxCalcprecFecdesde =  .F_articulo_fechaaltafw_desde			lxCalcprecFechasta =  .F_articulo_fechaaltafw_hasta			lxCalcprecCompdesde =  .F_articulo_comportamiento_desde			lxCalcprecComphasta =  .F_articulo_comportamiento_hasta			lxCalcprecPrecdesde =  .F_preciodirecto_desde			lxCalcprecPrechasta =  .F_preciodirecto_hasta			lxCalcprecMarcadesde =  upper( .f_Articulo_Marca_Desde_PK ) 			lxCalcprecMarcahasta =  upper( .f_Articulo_Marca_Hasta_PK ) 
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
				update ZooLogic.CALCPREC set "Fecimpo" = <<"'" + this.ConvertirDateSql( lxCalcprecFecimpo ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxCalcprecFmodifw ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxCalcprecFectrans ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxCalcprecFaltafw ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxCalcprecFecexpo ) + "'">>,"Codigo" = <<lxCalcprecCodigo>>,"Timestamp" = <<lxCalcprecTimestamp>>,"Anulado" = <<iif( lxCalcprecAnulado, 1, 0 )>>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxCalcprecSaltafw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxCalcprecValtafw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxCalcprecUaltafw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxCalcprecVmodifw ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxCalcprecHaltafw ) + "'">>,"Descfw" = <<"'" + this.FormatearTextoSql( lxCalcprecDescfw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxCalcprecZadsfw ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxCalcprecBdmodifw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxCalcprecEsttrans ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxCalcprecBdaltafw ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxCalcprecHoraexpo ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxCalcprecUmodifw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxCalcprecHoraimpo ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxCalcprecSmodifw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxCalcprecHmodifw ) + "'">>,"Descrip" = <<"'" + this.FormatearTextoSql( lxCalcprecDescrip ) + "'">>,"Fecha" = <<"'" + this.ConvertirDateSql( lxCalcprecFecha ) + "'">>,"Fproceso" = <<"'" + this.ConvertirDateSql( lxCalcprecFproceso ) + "'">>,"Fechavig" = <<"'" + this.ConvertirDateSql( lxCalcprecFechavig ) + "'">>,"Fechabase" = <<"'" + this.ConvertirDateSql( lxCalcprecFechabase ) + "'">>,"Artdesde" = <<"'" + this.FormatearTextoSql( lxCalcprecArtdesde ) + "'">>,"Sintransac" = <<iif( lxCalcprecSintransac, 1, 0 )>>,"Arthasta" = <<"'" + this.FormatearTextoSql( lxCalcprecArthasta ) + "'">>,"Coldesde" = <<"'" + this.FormatearTextoSql( lxCalcprecColdesde ) + "'">>,"Colhasta" = <<"'" + this.FormatearTextoSql( lxCalcprecColhasta ) + "'">>,"Comporta" = <<"'" + this.FormatearTextoSql( lxCalcprecComporta ) + "'">>,"Taldesde" = <<"'" + this.FormatearTextoSql( lxCalcprecTaldesde ) + "'">>,"Kpxpartic" = <<iif( lxCalcprecKpxpartic, 1, 0 )>>,"Talhasta" = <<"'" + this.FormatearTextoSql( lxCalcprecTalhasta ) + "'">>,"Prodesde" = <<"'" + this.FormatearTextoSql( lxCalcprecProdesde ) + "'">>,"Usacomb" = <<iif( lxCalcprecUsacomb, 1, 0 )>>,"Prohasta" = <<"'" + this.FormatearTextoSql( lxCalcprecProhasta ) + "'">>,"Unidesde" = <<"'" + this.FormatearTextoSql( lxCalcprecUnidesde ) + "'">>,"Unihasta" = <<"'" + this.FormatearTextoSql( lxCalcprecUnihasta ) + "'">>,"Matdesde" = <<"'" + this.FormatearTextoSql( lxCalcprecMatdesde ) + "'">>,"Mathasta" = <<"'" + this.FormatearTextoSql( lxCalcprecMathasta ) + "'">>,"Estdesde" = <<lxCalcprecEstdesde>>,"Esthasta" = <<lxCalcprecEsthasta>>,"Ualta" = <<"'" + this.FormatearTextoSql( lxCalcprecUalta ) + "'">>,"Anidesde" = <<"'" + this.FormatearTextoSql( lxCalcprecAnidesde ) + "'">>,"Umod" = <<"'" + this.FormatearTextoSql( lxCalcprecUmod ) + "'">>,"Mobs" = <<"'" + this.FormatearTextoSql( lxCalcprecMobs ) + "'">>,"Anihasta" = <<"'" + this.FormatearTextoSql( lxCalcprecAnihasta ) + "'">>,"Clasidesde" = <<"'" + this.FormatearTextoSql( lxCalcprecClasidesde ) + "'">>,"Narbadesde" = <<"'" + this.FormatearTextoSql( lxCalcprecNarbadesde ) + "'">>,"Clasihasta" = <<"'" + this.FormatearTextoSql( lxCalcprecClasihasta ) + "'">>,"Narbahasta" = <<"'" + this.FormatearTextoSql( lxCalcprecNarbahasta ) + "'">>,"Ftsadesde" = <<lxCalcprecFtsadesde>>,"Ftsahasta" = <<lxCalcprecFtsahasta>>,"Fecdesde" = <<"'" + this.ConvertirDateSql( lxCalcprecFecdesde ) + "'">>,"Fechasta" = <<"'" + this.ConvertirDateSql( lxCalcprecFechasta ) + "'">>,"Compdesde" = <<lxCalcprecCompdesde>>,"Comphasta" = <<lxCalcprecComphasta>>,"Precdesde" = <<lxCalcprecPrecdesde>>,"Prechasta" = <<lxCalcprecPrechasta>>,"Marcadesde" = <<"'" + this.FormatearTextoSql( lxCalcprecMarcadesde ) + "'">>,"Marcahasta" = <<"'" + this.FormatearTextoSql( lxCalcprecMarcahasta ) + "'">> where "Codigo" = <<lxCalcprecCodigo>> and  CALCPREC.CODIGO != 0 << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
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
				select "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Codigo" as "Codigo", "Timestamp" as "Timestamp", "Anulado" as "Anulado", "Saltafw" as "Seriealtafw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Vmodifw" as "Versionmodificacionfw", "Haltafw" as "Horaaltafw", "Descfw" as "Descripcionfw", "Zadsfw" as "Zadsfw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Horaexpo" as "Horaexpo", "Umodifw" as "Usuariomodificacionfw", "Horaimpo" as "Horaimpo", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Descrip" as "Descripcion", "Fecha" as "Fecha", "Fproceso" as "Fechaproceso", "Fechavig" as "Fechavigencia", "Fechabase" as "Fechabase", "Artdesde" as "F_articulo_desde", "Sintransac" as "Importarsintransaccion", "Arthasta" as "F_articulo_hasta", "Coldesde" as "F_color_desde", "Colhasta" as "F_color_hasta", "Comporta" as "Articulo_comportamiento", "Taldesde" as "F_talle_desde", "Kpxpartic" as "Preciokitpackxparticipante", "Talhasta" as "F_talle_hasta", "Prodesde" as "F_articulo_proveedor_desde", "Usacomb" as "Usacombinacion", "Prohasta" as "F_articulo_proveedor_hasta", "Unidesde" as "F_articulo_unidad_desde", "Unihasta" as "F_articulo_unidad_hasta", "Matdesde" as "F_articulo_material_desde", "Mathasta" as "F_articulo_material_hasta", "Estdesde" as "F_articulo_estacion_desde", "Esthasta" as "F_articulo_estacion_hasta", "Ualta" as "F_articulo_usuarioaltafw", "Anidesde" as "F_articulo_anio_desde", "Umod" as "F_articulo_usuariomodificacionfw", "Mobs" as "Observacion", "Anihasta" as "F_articulo_anio_hasta", "Clasidesde" as "F_articulo_clasificacion_desde", "Narbadesde" as "F_articulo_nomenclador_desde", "Clasihasta" as "F_articulo_clasificacion_hasta", "Narbahasta" as "F_articulo_nomenclador_hasta", "Ftsadesde" as "F_timestampalta_desde", "Ftsahasta" as "F_timestampalta_hasta", "Fecdesde" as "F_articulo_fechaaltafw_desde", "Fechasta" as "F_articulo_fechaaltafw_hasta", "Compdesde" as "F_articulo_comportamiento_desde", "Comphasta" as "F_articulo_comportamiento_hasta", "Precdesde" as "F_preciodirecto_desde", "Prechasta" as "F_preciodirecto_hasta", "Marcadesde" as "F_articulo_marca_desde", "Marcahasta" as "F_articulo_marca_hasta" from ZooLogic.CALCPREC where "Codigo" = <<lxCalcprecCodigo>> and  CALCPREC.CODIGO != 0
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
				select top 1 "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Codigo" as "Codigo", "Timestamp" as "Timestamp", "Anulado" as "Anulado", "Saltafw" as "Seriealtafw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Vmodifw" as "Versionmodificacionfw", "Haltafw" as "Horaaltafw", "Descfw" as "Descripcionfw", "Zadsfw" as "Zadsfw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Horaexpo" as "Horaexpo", "Umodifw" as "Usuariomodificacionfw", "Horaimpo" as "Horaimpo", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Descrip" as "Descripcion", "Fecha" as "Fecha", "Fproceso" as "Fechaproceso", "Fechavig" as "Fechavigencia", "Fechabase" as "Fechabase", "Artdesde" as "F_articulo_desde", "Sintransac" as "Importarsintransaccion", "Arthasta" as "F_articulo_hasta", "Coldesde" as "F_color_desde", "Colhasta" as "F_color_hasta", "Comporta" as "Articulo_comportamiento", "Taldesde" as "F_talle_desde", "Kpxpartic" as "Preciokitpackxparticipante", "Talhasta" as "F_talle_hasta", "Prodesde" as "F_articulo_proveedor_desde", "Usacomb" as "Usacombinacion", "Prohasta" as "F_articulo_proveedor_hasta", "Unidesde" as "F_articulo_unidad_desde", "Unihasta" as "F_articulo_unidad_hasta", "Matdesde" as "F_articulo_material_desde", "Mathasta" as "F_articulo_material_hasta", "Estdesde" as "F_articulo_estacion_desde", "Esthasta" as "F_articulo_estacion_hasta", "Ualta" as "F_articulo_usuarioaltafw", "Anidesde" as "F_articulo_anio_desde", "Umod" as "F_articulo_usuariomodificacionfw", "Mobs" as "Observacion", "Anihasta" as "F_articulo_anio_hasta", "Clasidesde" as "F_articulo_clasificacion_desde", "Narbadesde" as "F_articulo_nomenclador_desde", "Clasihasta" as "F_articulo_clasificacion_hasta", "Narbahasta" as "F_articulo_nomenclador_hasta", "Ftsadesde" as "F_timestampalta_desde", "Ftsahasta" as "F_timestampalta_hasta", "Fecdesde" as "F_articulo_fechaaltafw_desde", "Fechasta" as "F_articulo_fechaaltafw_hasta", "Compdesde" as "F_articulo_comportamiento_desde", "Comphasta" as "F_articulo_comportamiento_hasta", "Precdesde" as "F_preciodirecto_desde", "Prechasta" as "F_preciodirecto_hasta", "Marcadesde" as "F_articulo_marca_desde", "Marcahasta" as "F_articulo_marca_hasta" from ZooLogic.CALCPREC where  CALCPREC.CODIGO != 0 order by CODIGO
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
				select top 1 "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Codigo" as "Codigo", "Timestamp" as "Timestamp", "Anulado" as "Anulado", "Saltafw" as "Seriealtafw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Vmodifw" as "Versionmodificacionfw", "Haltafw" as "Horaaltafw", "Descfw" as "Descripcionfw", "Zadsfw" as "Zadsfw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Horaexpo" as "Horaexpo", "Umodifw" as "Usuariomodificacionfw", "Horaimpo" as "Horaimpo", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Descrip" as "Descripcion", "Fecha" as "Fecha", "Fproceso" as "Fechaproceso", "Fechavig" as "Fechavigencia", "Fechabase" as "Fechabase", "Artdesde" as "F_articulo_desde", "Sintransac" as "Importarsintransaccion", "Arthasta" as "F_articulo_hasta", "Coldesde" as "F_color_desde", "Colhasta" as "F_color_hasta", "Comporta" as "Articulo_comportamiento", "Taldesde" as "F_talle_desde", "Kpxpartic" as "Preciokitpackxparticipante", "Talhasta" as "F_talle_hasta", "Prodesde" as "F_articulo_proveedor_desde", "Usacomb" as "Usacombinacion", "Prohasta" as "F_articulo_proveedor_hasta", "Unidesde" as "F_articulo_unidad_desde", "Unihasta" as "F_articulo_unidad_hasta", "Matdesde" as "F_articulo_material_desde", "Mathasta" as "F_articulo_material_hasta", "Estdesde" as "F_articulo_estacion_desde", "Esthasta" as "F_articulo_estacion_hasta", "Ualta" as "F_articulo_usuarioaltafw", "Anidesde" as "F_articulo_anio_desde", "Umod" as "F_articulo_usuariomodificacionfw", "Mobs" as "Observacion", "Anihasta" as "F_articulo_anio_hasta", "Clasidesde" as "F_articulo_clasificacion_desde", "Narbadesde" as "F_articulo_nomenclador_desde", "Clasihasta" as "F_articulo_clasificacion_hasta", "Narbahasta" as "F_articulo_nomenclador_hasta", "Ftsadesde" as "F_timestampalta_desde", "Ftsahasta" as "F_timestampalta_hasta", "Fecdesde" as "F_articulo_fechaaltafw_desde", "Fechasta" as "F_articulo_fechaaltafw_hasta", "Compdesde" as "F_articulo_comportamiento_desde", "Comphasta" as "F_articulo_comportamiento_hasta", "Precdesde" as "F_preciodirecto_desde", "Prechasta" as "F_preciodirecto_hasta", "Marcadesde" as "F_articulo_marca_desde", "Marcahasta" as "F_articulo_marca_hasta" from ZooLogic.CALCPREC where  str( CODIGO, 8, 0) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  CALCPREC.CODIGO != 0 order by CODIGO
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
				select top 1 "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Codigo" as "Codigo", "Timestamp" as "Timestamp", "Anulado" as "Anulado", "Saltafw" as "Seriealtafw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Vmodifw" as "Versionmodificacionfw", "Haltafw" as "Horaaltafw", "Descfw" as "Descripcionfw", "Zadsfw" as "Zadsfw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Horaexpo" as "Horaexpo", "Umodifw" as "Usuariomodificacionfw", "Horaimpo" as "Horaimpo", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Descrip" as "Descripcion", "Fecha" as "Fecha", "Fproceso" as "Fechaproceso", "Fechavig" as "Fechavigencia", "Fechabase" as "Fechabase", "Artdesde" as "F_articulo_desde", "Sintransac" as "Importarsintransaccion", "Arthasta" as "F_articulo_hasta", "Coldesde" as "F_color_desde", "Colhasta" as "F_color_hasta", "Comporta" as "Articulo_comportamiento", "Taldesde" as "F_talle_desde", "Kpxpartic" as "Preciokitpackxparticipante", "Talhasta" as "F_talle_hasta", "Prodesde" as "F_articulo_proveedor_desde", "Usacomb" as "Usacombinacion", "Prohasta" as "F_articulo_proveedor_hasta", "Unidesde" as "F_articulo_unidad_desde", "Unihasta" as "F_articulo_unidad_hasta", "Matdesde" as "F_articulo_material_desde", "Mathasta" as "F_articulo_material_hasta", "Estdesde" as "F_articulo_estacion_desde", "Esthasta" as "F_articulo_estacion_hasta", "Ualta" as "F_articulo_usuarioaltafw", "Anidesde" as "F_articulo_anio_desde", "Umod" as "F_articulo_usuariomodificacionfw", "Mobs" as "Observacion", "Anihasta" as "F_articulo_anio_hasta", "Clasidesde" as "F_articulo_clasificacion_desde", "Narbadesde" as "F_articulo_nomenclador_desde", "Clasihasta" as "F_articulo_clasificacion_hasta", "Narbahasta" as "F_articulo_nomenclador_hasta", "Ftsadesde" as "F_timestampalta_desde", "Ftsahasta" as "F_timestampalta_hasta", "Fecdesde" as "F_articulo_fechaaltafw_desde", "Fechasta" as "F_articulo_fechaaltafw_hasta", "Compdesde" as "F_articulo_comportamiento_desde", "Comphasta" as "F_articulo_comportamiento_hasta", "Precdesde" as "F_preciodirecto_desde", "Prechasta" as "F_preciodirecto_hasta", "Marcadesde" as "F_articulo_marca_desde", "Marcahasta" as "F_articulo_marca_hasta" from ZooLogic.CALCPREC where  str( CODIGO, 8, 0) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  CALCPREC.CODIGO != 0 order by CODIGO desc
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
				select top 1 "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Codigo" as "Codigo", "Timestamp" as "Timestamp", "Anulado" as "Anulado", "Saltafw" as "Seriealtafw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Vmodifw" as "Versionmodificacionfw", "Haltafw" as "Horaaltafw", "Descfw" as "Descripcionfw", "Zadsfw" as "Zadsfw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Horaexpo" as "Horaexpo", "Umodifw" as "Usuariomodificacionfw", "Horaimpo" as "Horaimpo", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Descrip" as "Descripcion", "Fecha" as "Fecha", "Fproceso" as "Fechaproceso", "Fechavig" as "Fechavigencia", "Fechabase" as "Fechabase", "Artdesde" as "F_articulo_desde", "Sintransac" as "Importarsintransaccion", "Arthasta" as "F_articulo_hasta", "Coldesde" as "F_color_desde", "Colhasta" as "F_color_hasta", "Comporta" as "Articulo_comportamiento", "Taldesde" as "F_talle_desde", "Kpxpartic" as "Preciokitpackxparticipante", "Talhasta" as "F_talle_hasta", "Prodesde" as "F_articulo_proveedor_desde", "Usacomb" as "Usacombinacion", "Prohasta" as "F_articulo_proveedor_hasta", "Unidesde" as "F_articulo_unidad_desde", "Unihasta" as "F_articulo_unidad_hasta", "Matdesde" as "F_articulo_material_desde", "Mathasta" as "F_articulo_material_hasta", "Estdesde" as "F_articulo_estacion_desde", "Esthasta" as "F_articulo_estacion_hasta", "Ualta" as "F_articulo_usuarioaltafw", "Anidesde" as "F_articulo_anio_desde", "Umod" as "F_articulo_usuariomodificacionfw", "Mobs" as "Observacion", "Anihasta" as "F_articulo_anio_hasta", "Clasidesde" as "F_articulo_clasificacion_desde", "Narbadesde" as "F_articulo_nomenclador_desde", "Clasihasta" as "F_articulo_clasificacion_hasta", "Narbahasta" as "F_articulo_nomenclador_hasta", "Ftsadesde" as "F_timestampalta_desde", "Ftsahasta" as "F_timestampalta_hasta", "Fecdesde" as "F_articulo_fechaaltafw_desde", "Fechasta" as "F_articulo_fechaaltafw_hasta", "Compdesde" as "F_articulo_comportamiento_desde", "Comphasta" as "F_articulo_comportamiento_hasta", "Precdesde" as "F_preciodirecto_desde", "Prechasta" as "F_preciodirecto_hasta", "Marcadesde" as "F_articulo_marca_desde", "Marcahasta" as "F_articulo_marca_hasta" from ZooLogic.CALCPREC where  CALCPREC.CODIGO != 0 order by CODIGO desc
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
			lcXml = this.oConexion.EjecutarSql( "select Fecimpo,Fmodifw,Fectrans,Faltafw,Fecexpo,Codigo,Timestamp,Anulado,Saltafw,Valtafw,Ualtafw,Vm" + ;
"odifw,Haltafw,Descfw,Zadsfw,Bdmodifw,Esttrans,Bdaltafw,Horaexpo,Umodifw,Horaimpo,Smodifw,Hmodifw,Des" + ;
"crip,Fecha,Fproceso,Fechavig,Fechabase,Artdesde,Sintransac,Arthasta,Coldesde,Colhasta,Comporta,Talde" + ;
"sde,Kpxpartic,Talhasta,Prodesde,Usacomb,Prohasta,Unidesde,Unihasta,Matdesde,Mathasta,Estdesde,Esthas" + ;
"ta,Ualta,Anidesde,Umod,Mobs,Anihasta,Clasidesde,Narbadesde,Clasihasta,Narbahasta,Ftsadesde,Ftsahasta" + ;
",Fecdesde,Fechasta,Compdesde,Comphasta,Precdesde,Prechasta,Marcadesde,Marcahasta" + ;
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
			local  lxCalcprecFecimpo, lxCalcprecFmodifw, lxCalcprecFectrans, lxCalcprecFaltafw, lxCalcprecFecexpo, lxCalcprecCodigo, lxCalcprecTimestamp, lxCalcprecAnulado, lxCalcprecSaltafw, lxCalcprecValtafw, lxCalcprecUaltafw, lxCalcprecVmodifw, lxCalcprecHaltafw, lxCalcprecDescfw, lxCalcprecZadsfw, lxCalcprecBdmodifw, lxCalcprecEsttrans, lxCalcprecBdaltafw, lxCalcprecHoraexpo, lxCalcprecUmodifw, lxCalcprecHoraimpo, lxCalcprecSmodifw, lxCalcprecHmodifw, lxCalcprecDescrip, lxCalcprecFecha, lxCalcprecFproceso, lxCalcprecFechavig, lxCalcprecFechabase, lxCalcprecArtdesde, lxCalcprecSintransac, lxCalcprecArthasta, lxCalcprecColdesde, lxCalcprecColhasta, lxCalcprecComporta, lxCalcprecTaldesde, lxCalcprecKpxpartic, lxCalcprecTalhasta, lxCalcprecProdesde, lxCalcprecUsacomb, lxCalcprecProhasta, lxCalcprecUnidesde, lxCalcprecUnihasta, lxCalcprecMatdesde, lxCalcprecMathasta, lxCalcprecEstdesde, lxCalcprecEsthasta, lxCalcprecUalta, lxCalcprecAnidesde, lxCalcprecUmod, lxCalcprecMobs, lxCalcprecAnihasta, lxCalcprecClasidesde, lxCalcprecNarbadesde, lxCalcprecClasihasta, lxCalcprecNarbahasta, lxCalcprecFtsadesde, lxCalcprecFtsahasta, lxCalcprecFecdesde, lxCalcprecFechasta, lxCalcprecCompdesde, lxCalcprecComphasta, lxCalcprecPrecdesde, lxCalcprecPrechasta, lxCalcprecMarcadesde, lxCalcprecMarcahasta
				lxCalcprecFecimpo = ctod( '  /  /    ' )			lxCalcprecFmodifw = ctod( '  /  /    ' )			lxCalcprecFectrans = ctod( '  /  /    ' )			lxCalcprecFaltafw = ctod( '  /  /    ' )			lxCalcprecFecexpo = ctod( '  /  /    ' )			lxCalcprecCodigo = 0			lxCalcprecTimestamp = goLibrerias.ObtenerTimestamp()			lxCalcprecAnulado = .F.			lxCalcprecSaltafw = []			lxCalcprecValtafw = []			lxCalcprecUaltafw = []			lxCalcprecVmodifw = []			lxCalcprecHaltafw = []			lxCalcprecDescfw = []			lxCalcprecZadsfw = []			lxCalcprecBdmodifw = []			lxCalcprecEsttrans = []			lxCalcprecBdaltafw = []			lxCalcprecHoraexpo = []			lxCalcprecUmodifw = []			lxCalcprecHoraimpo = []			lxCalcprecSmodifw = []			lxCalcprecHmodifw = []			lxCalcprecDescrip = []			lxCalcprecFecha = ctod( '  /  /    ' )			lxCalcprecFproceso = ctod( '  /  /    ' )			lxCalcprecFechavig = ctod( '  /  /    ' )			lxCalcprecFechabase = ctod( '  /  /    ' )			lxCalcprecArtdesde = []			lxCalcprecSintransac = .F.			lxCalcprecArthasta = []			lxCalcprecColdesde = []			lxCalcprecColhasta = []			lxCalcprecComporta = []			lxCalcprecTaldesde = []			lxCalcprecKpxpartic = .F.			lxCalcprecTalhasta = []			lxCalcprecProdesde = []			lxCalcprecUsacomb = .F.			lxCalcprecProhasta = []			lxCalcprecUnidesde = []			lxCalcprecUnihasta = []			lxCalcprecMatdesde = []			lxCalcprecMathasta = []			lxCalcprecEstdesde = 0			lxCalcprecEsthasta = 0			lxCalcprecUalta = []			lxCalcprecAnidesde = []			lxCalcprecUmod = []			lxCalcprecMobs = []			lxCalcprecAnihasta = []			lxCalcprecClasidesde = []			lxCalcprecNarbadesde = []			lxCalcprecClasihasta = []			lxCalcprecNarbahasta = []			lxCalcprecFtsadesde = 0			lxCalcprecFtsahasta = 0			lxCalcprecFecdesde = ctod( '  /  /    ' )			lxCalcprecFechasta = ctod( '  /  /    ' )			lxCalcprecCompdesde = 0			lxCalcprecComphasta = 0			lxCalcprecPrecdesde = 0			lxCalcprecPrechasta = 0			lxCalcprecMarcadesde = []			lxCalcprecMarcahasta = []
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
					"Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Codigo" as "Codigo", "Timestamp" as "Timestamp", "Anulado" as "Anulado", "Saltafw" as "Seriealtafw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Vmodifw" as "Versionmodificacionfw", "Haltafw" as "Horaaltafw", "Descfw" as "Descripcionfw", "Zadsfw" as "Zadsfw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Horaexpo" as "Horaexpo", "Umodifw" as "Usuariomodificacionfw", "Horaimpo" as "Horaimpo", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Descrip" as "Descripcion", "Fecha" as "Fecha", "Fproceso" as "Fechaproceso", "Fechavig" as "Fechavigencia", "Fechabase" as "Fechabase", "Artdesde" as "F_articulo_desde", "Sintransac" as "Importarsintransaccion", "Arthasta" as "F_articulo_hasta", "Coldesde" as "F_color_desde", "Colhasta" as "F_color_hasta", "Comporta" as "Articulo_comportamiento", "Taldesde" as "F_talle_desde", "Kpxpartic" as "Preciokitpackxparticipante", "Talhasta" as "F_talle_hasta", "Prodesde" as "F_articulo_proveedor_desde", "Usacomb" as "Usacombinacion", "Prohasta" as "F_articulo_proveedor_hasta", "Unidesde" as "F_articulo_unidad_desde", "Unihasta" as "F_articulo_unidad_hasta", "Matdesde" as "F_articulo_material_desde", "Mathasta" as "F_articulo_material_hasta", "Estdesde" as "F_articulo_estacion_desde", "Esthasta" as "F_articulo_estacion_hasta", "Ualta" as "F_articulo_usuarioaltafw", "Anidesde" as "F_articulo_anio_desde", "Umod" as "F_articulo_usuariomodificacionfw", "Mobs" as "Observacion", "Anihasta" as "F_articulo_anio_hasta", "Clasidesde" as "F_articulo_clasificacion_desde", "Narbadesde" as "F_articulo_nomenclador_desde", "Clasihasta" as "F_articulo_clasificacion_hasta", "Narbahasta" as "F_articulo_nomenclador_hasta", "Ftsadesde" as "F_timestampalta_desde", "Ftsahasta" as "F_timestampalta_hasta", "Fecdesde" as "F_articulo_fechaaltafw_desde", "Fechasta" as "F_articulo_fechaaltafw_hasta", "Compdesde" as "F_articulo_comportamiento_desde", "Comphasta" as "F_articulo_comportamiento_hasta", "Precdesde" as "F_preciodirecto_desde", "Prechasta" as "F_preciodirecto_hasta", "Marcadesde" as "F_articulo_marca_desde", "Marcahasta" as "F_articulo_marca_hasta"
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
				Case lcAtributo == 'FECHAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECIMPO AS FECHAIMPO'
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'FECHATRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRANS AS FECHATRANSFERENCIA'
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'FECHAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECEXPO AS FECHAEXPO'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'TIMESTAMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIMESTAMP AS TIMESTAMP'
				Case lcAtributo == 'ANULADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ANULADO AS ANULADO'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'DESCRIPCIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCFW AS DESCRIPCIONFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'DESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCRIP AS DESCRIPCION'
				Case lcAtributo == 'FECHA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHA AS FECHA'
				Case lcAtributo == 'FECHAPROCESO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPROCESO AS FECHAPROCESO'
				Case lcAtributo == 'FECHAVIGENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHAVIG AS FECHAVIGENCIA'
				Case lcAtributo == 'FECHABASE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHABASE AS FECHABASE'
				Case lcAtributo == 'F_ARTICULO_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ARTDESDE AS F_ARTICULO_DESDE'
				Case lcAtributo == 'IMPORTARSINTRANSACCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SINTRANSAC AS IMPORTARSINTRANSACCION'
				Case lcAtributo == 'F_ARTICULO_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ARTHASTA AS F_ARTICULO_HASTA'
				Case lcAtributo == 'F_COLOR_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COLDESDE AS F_COLOR_DESDE'
				Case lcAtributo == 'F_COLOR_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COLHASTA AS F_COLOR_HASTA'
				Case lcAtributo == 'ARTICULO_COMPORTAMIENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COMPORTA AS ARTICULO_COMPORTAMIENTO'
				Case lcAtributo == 'F_TALLE_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TALDESDE AS F_TALLE_DESDE'
				Case lcAtributo == 'PRECIOKITPACKXPARTICIPANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'KPXPARTIC AS PRECIOKITPACKXPARTICIPANTE'
				Case lcAtributo == 'F_TALLE_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TALHASTA AS F_TALLE_HASTA'
				Case lcAtributo == 'F_ARTICULO_PROVEEDOR_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PRODESDE AS F_ARTICULO_PROVEEDOR_DESDE'
				Case lcAtributo == 'USACOMBINACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'USACOMB AS USACOMBINACION'
				Case lcAtributo == 'F_ARTICULO_PROVEEDOR_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PROHASTA AS F_ARTICULO_PROVEEDOR_HASTA'
				Case lcAtributo == 'F_ARTICULO_UNIDAD_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UNIDESDE AS F_ARTICULO_UNIDAD_DESDE'
				Case lcAtributo == 'F_ARTICULO_UNIDAD_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UNIHASTA AS F_ARTICULO_UNIDAD_HASTA'
				Case lcAtributo == 'F_ARTICULO_MATERIAL_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MATDESDE AS F_ARTICULO_MATERIAL_DESDE'
				Case lcAtributo == 'F_ARTICULO_MATERIAL_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MATHASTA AS F_ARTICULO_MATERIAL_HASTA'
				Case lcAtributo == 'F_ARTICULO_ESTACION_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTDESDE AS F_ARTICULO_ESTACION_DESDE'
				Case lcAtributo == 'F_ARTICULO_ESTACION_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTHASTA AS F_ARTICULO_ESTACION_HASTA'
				Case lcAtributo == 'F_ARTICULO_USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTA AS F_ARTICULO_USUARIOALTAFW'
				Case lcAtributo == 'F_ARTICULO_ANIO_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ANIDESDE AS F_ARTICULO_ANIO_DESDE'
				Case lcAtributo == 'F_ARTICULO_USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMOD AS F_ARTICULO_USUARIOMODIFICACIONFW'
				Case lcAtributo == 'OBSERVACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MOBS AS OBSERVACION'
				Case lcAtributo == 'F_ARTICULO_ANIO_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ANIHASTA AS F_ARTICULO_ANIO_HASTA'
				Case lcAtributo == 'F_ARTICULO_CLASIFICACION_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLASIDESDE AS F_ARTICULO_CLASIFICACION_DESDE'
				Case lcAtributo == 'F_ARTICULO_NOMENCLADOR_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NARBADESDE AS F_ARTICULO_NOMENCLADOR_DESDE'
				Case lcAtributo == 'F_ARTICULO_CLASIFICACION_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLASIHASTA AS F_ARTICULO_CLASIFICACION_HASTA'
				Case lcAtributo == 'F_ARTICULO_NOMENCLADOR_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NARBAHASTA AS F_ARTICULO_NOMENCLADOR_HASTA'
				Case lcAtributo == 'F_TIMESTAMPALTA_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FTSADESDE AS F_TIMESTAMPALTA_DESDE'
				Case lcAtributo == 'F_TIMESTAMPALTA_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FTSAHASTA AS F_TIMESTAMPALTA_HASTA'
				Case lcAtributo == 'F_ARTICULO_FECHAALTAFW_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECDESDE AS F_ARTICULO_FECHAALTAFW_DESDE'
				Case lcAtributo == 'F_ARTICULO_FECHAALTAFW_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHASTA AS F_ARTICULO_FECHAALTAFW_HASTA'
				Case lcAtributo == 'F_ARTICULO_COMPORTAMIENTO_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COMPDESDE AS F_ARTICULO_COMPORTAMIENTO_DESDE'
				Case lcAtributo == 'F_ARTICULO_COMPORTAMIENTO_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COMPHASTA AS F_ARTICULO_COMPORTAMIENTO_HASTA'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHAIMPO'
				lcCampo = 'FECIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEXPO'
				lcCampo = 'FECEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'TIMESTAMP'
				lcCampo = 'TIMESTAMP'
			Case upper( alltrim( tcAtributo ) ) == 'ANULADO'
				lcCampo = 'ANULADO'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCIONFW'
				lcCampo = 'DESCFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCION'
				lcCampo = 'DESCRIP'
			Case upper( alltrim( tcAtributo ) ) == 'FECHA'
				lcCampo = 'FECHA'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAPROCESO'
				lcCampo = 'FPROCESO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAVIGENCIA'
				lcCampo = 'FECHAVIG'
			Case upper( alltrim( tcAtributo ) ) == 'FECHABASE'
				lcCampo = 'FECHABASE'
			Case upper( alltrim( tcAtributo ) ) == 'F_ARTICULO_DESDE'
				lcCampo = 'ARTDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'IMPORTARSINTRANSACCION'
				lcCampo = 'SINTRANSAC'
			Case upper( alltrim( tcAtributo ) ) == 'F_ARTICULO_HASTA'
				lcCampo = 'ARTHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'F_COLOR_DESDE'
				lcCampo = 'COLDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'F_COLOR_HASTA'
				lcCampo = 'COLHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'ARTICULO_COMPORTAMIENTO'
				lcCampo = 'COMPORTA'
			Case upper( alltrim( tcAtributo ) ) == 'F_TALLE_DESDE'
				lcCampo = 'TALDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'PRECIOKITPACKXPARTICIPANTE'
				lcCampo = 'KPXPARTIC'
			Case upper( alltrim( tcAtributo ) ) == 'F_TALLE_HASTA'
				lcCampo = 'TALHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'F_ARTICULO_PROVEEDOR_DESDE'
				lcCampo = 'PRODESDE'
			Case upper( alltrim( tcAtributo ) ) == 'USACOMBINACION'
				lcCampo = 'USACOMB'
			Case upper( alltrim( tcAtributo ) ) == 'F_ARTICULO_PROVEEDOR_HASTA'
				lcCampo = 'PROHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'F_ARTICULO_UNIDAD_DESDE'
				lcCampo = 'UNIDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'F_ARTICULO_UNIDAD_HASTA'
				lcCampo = 'UNIHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'F_ARTICULO_MATERIAL_DESDE'
				lcCampo = 'MATDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'F_ARTICULO_MATERIAL_HASTA'
				lcCampo = 'MATHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'F_ARTICULO_ESTACION_DESDE'
				lcCampo = 'ESTDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'F_ARTICULO_ESTACION_HASTA'
				lcCampo = 'ESTHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'F_ARTICULO_USUARIOALTAFW'
				lcCampo = 'UALTA'
			Case upper( alltrim( tcAtributo ) ) == 'F_ARTICULO_ANIO_DESDE'
				lcCampo = 'ANIDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'F_ARTICULO_USUARIOMODIFICACIONFW'
				lcCampo = 'UMOD'
			Case upper( alltrim( tcAtributo ) ) == 'OBSERVACION'
				lcCampo = 'MOBS'
			Case upper( alltrim( tcAtributo ) ) == 'F_ARTICULO_ANIO_HASTA'
				lcCampo = 'ANIHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'F_ARTICULO_CLASIFICACION_DESDE'
				lcCampo = 'CLASIDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'F_ARTICULO_NOMENCLADOR_DESDE'
				lcCampo = 'NARBADESDE'
			Case upper( alltrim( tcAtributo ) ) == 'F_ARTICULO_CLASIFICACION_HASTA'
				lcCampo = 'CLASIHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'F_ARTICULO_NOMENCLADOR_HASTA'
				lcCampo = 'NARBAHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'F_TIMESTAMPALTA_DESDE'
				lcCampo = 'FTSADESDE'
			Case upper( alltrim( tcAtributo ) ) == 'F_TIMESTAMPALTA_HASTA'
				lcCampo = 'FTSAHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'F_ARTICULO_FECHAALTAFW_DESDE'
				lcCampo = 'FECDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'F_ARTICULO_FECHAALTAFW_HASTA'
				lcCampo = 'FECHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'F_ARTICULO_COMPORTAMIENTO_DESDE'
				lcCampo = 'COMPDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'F_ARTICULO_COMPORTAMIENTO_HASTA'
				lcCampo = 'COMPHASTA'
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
			local  lxCalcprecFecimpo, lxCalcprecFmodifw, lxCalcprecFectrans, lxCalcprecFaltafw, lxCalcprecFecexpo, lxCalcprecCodigo, lxCalcprecTimestamp, lxCalcprecAnulado, lxCalcprecSaltafw, lxCalcprecValtafw, lxCalcprecUaltafw, lxCalcprecVmodifw, lxCalcprecHaltafw, lxCalcprecDescfw, lxCalcprecZadsfw, lxCalcprecBdmodifw, lxCalcprecEsttrans, lxCalcprecBdaltafw, lxCalcprecHoraexpo, lxCalcprecUmodifw, lxCalcprecHoraimpo, lxCalcprecSmodifw, lxCalcprecHmodifw, lxCalcprecDescrip, lxCalcprecFecha, lxCalcprecFproceso, lxCalcprecFechavig, lxCalcprecFechabase, lxCalcprecArtdesde, lxCalcprecSintransac, lxCalcprecArthasta, lxCalcprecColdesde, lxCalcprecColhasta, lxCalcprecComporta, lxCalcprecTaldesde, lxCalcprecKpxpartic, lxCalcprecTalhasta, lxCalcprecProdesde, lxCalcprecUsacomb, lxCalcprecProhasta, lxCalcprecUnidesde, lxCalcprecUnihasta, lxCalcprecMatdesde, lxCalcprecMathasta, lxCalcprecEstdesde, lxCalcprecEsthasta, lxCalcprecUalta, lxCalcprecAnidesde, lxCalcprecUmod, lxCalcprecMobs, lxCalcprecAnihasta, lxCalcprecClasidesde, lxCalcprecNarbadesde, lxCalcprecClasihasta, lxCalcprecNarbahasta, lxCalcprecFtsadesde, lxCalcprecFtsahasta, lxCalcprecFecdesde, lxCalcprecFechasta, lxCalcprecCompdesde, lxCalcprecComphasta, lxCalcprecPrecdesde, lxCalcprecPrechasta, lxCalcprecMarcadesde, lxCalcprecMarcahasta
				lxCalcprecFecimpo =  .Fechaimpo			lxCalcprecFmodifw =  .Fechamodificacionfw			lxCalcprecFectrans =  .Fechatransferencia			lxCalcprecFaltafw =  .Fechaaltafw			lxCalcprecFecexpo =  .Fechaexpo			lxCalcprecCodigo =  .Codigo			lxCalcprecTimestamp = goLibrerias.ObtenerTimestamp()			lxCalcprecAnulado =  .Anulado			lxCalcprecSaltafw =  .Seriealtafw			lxCalcprecValtafw =  .Versionaltafw			lxCalcprecUaltafw =  .Usuarioaltafw			lxCalcprecVmodifw =  .Versionmodificacionfw			lxCalcprecHaltafw =  .Horaaltafw			lxCalcprecDescfw =  .Descripcionfw			lxCalcprecZadsfw =  .Zadsfw			lxCalcprecBdmodifw =  .Basededatosmodificacionfw			lxCalcprecEsttrans =  .Estadotransferencia			lxCalcprecBdaltafw =  .Basededatosaltafw			lxCalcprecHoraexpo =  .Horaexpo			lxCalcprecUmodifw =  .Usuariomodificacionfw			lxCalcprecHoraimpo =  .Horaimpo			lxCalcprecSmodifw =  .Seriemodificacionfw			lxCalcprecHmodifw =  .Horamodificacionfw			lxCalcprecDescrip =  .Descripcion			lxCalcprecFecha =  .Fecha			lxCalcprecFproceso =  .Fechaproceso			lxCalcprecFechavig =  .Fechavigencia			lxCalcprecFechabase =  .Fechabase			lxCalcprecArtdesde =  upper( .f_Articulo_Desde_PK ) 			lxCalcprecSintransac =  .Importarsintransaccion			lxCalcprecArthasta =  upper( .f_Articulo_Hasta_PK ) 			lxCalcprecColdesde =  upper( .f_Color_Desde_PK ) 			lxCalcprecColhasta =  upper( .f_Color_Hasta_PK ) 			lxCalcprecComporta =  .Articulo_comportamiento			lxCalcprecTaldesde =  .F_talle_desde			lxCalcprecKpxpartic =  .Preciokitpackxparticipante			lxCalcprecTalhasta =  .F_talle_hasta			lxCalcprecProdesde =  upper( .f_Articulo_Proveedor_Desde_PK ) 			lxCalcprecUsacomb =  .Usacombinacion			lxCalcprecProhasta =  upper( .f_Articulo_Proveedor_Hasta_PK ) 			lxCalcprecUnidesde =  upper( .f_Articulo_Unidad_Desde_PK ) 			lxCalcprecUnihasta =  upper( .f_Articulo_Unidad_Hasta_PK ) 			lxCalcprecMatdesde =  upper( .f_Articulo_Material_Desde_PK ) 			lxCalcprecMathasta =  upper( .f_Articulo_Material_Hasta_PK ) 			lxCalcprecEstdesde =  .F_articulo_estacion_desde			lxCalcprecEsthasta =  .F_articulo_estacion_hasta			lxCalcprecUalta =  .F_articulo_usuarioaltafw			lxCalcprecAnidesde =  .F_articulo_anio_desde			lxCalcprecUmod =  .F_articulo_usuariomodificacionfw			lxCalcprecMobs =  .Observacion			lxCalcprecAnihasta =  .F_articulo_anio_hasta			lxCalcprecClasidesde =  upper( .f_Articulo_clasificacion_desde_PK ) 			lxCalcprecNarbadesde =  upper( .f_Articulo_Nomenclador_Desde_PK ) 			lxCalcprecClasihasta =  upper( .f_Articulo_clasificacion_hasta_PK ) 			lxCalcprecNarbahasta =  upper( .f_Articulo_Nomenclador_Hasta_PK ) 			lxCalcprecFtsadesde =  .F_timestampalta_desde			lxCalcprecFtsahasta =  .F_timestampalta_hasta			lxCalcprecFecdesde =  .F_articulo_fechaaltafw_desde			lxCalcprecFechasta =  .F_articulo_fechaaltafw_hasta			lxCalcprecCompdesde =  .F_articulo_comportamiento_desde			lxCalcprecComphasta =  .F_articulo_comportamiento_hasta			lxCalcprecPrecdesde =  .F_preciodirecto_desde			lxCalcprecPrechasta =  .F_preciodirecto_hasta			lxCalcprecMarcadesde =  upper( .f_Articulo_Marca_Desde_PK ) 			lxCalcprecMarcahasta =  upper( .f_Articulo_Marca_Hasta_PK ) 
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.CALCPREC ( "Fecimpo","Fmodifw","Fectrans","Faltafw","Fecexpo","Codigo","Timestamp","Anulado","Saltafw","Valtafw","Ualtafw","Vmodifw","Haltafw","Descfw","Zadsfw","Bdmodifw","Esttrans","Bdaltafw","Horaexpo","Umodifw","Horaimpo","Smodifw","Hmodifw","Descrip","Fecha","Fproceso","Fechavig","Fechabase","Artdesde","Sintransac","Arthasta","Coldesde","Colhasta","Comporta","Taldesde","Kpxpartic","Talhasta","Prodesde","Usacomb","Prohasta","Unidesde","Unihasta","Matdesde","Mathasta","Estdesde","Esthasta","Ualta","Anidesde","Umod","Mobs","Anihasta","Clasidesde","Narbadesde","Clasihasta","Narbahasta","Ftsadesde","Ftsahasta","Fecdesde","Fechasta","Compdesde","Comphasta","Precdesde","Prechasta","Marcadesde","Marcahasta" ) values ( <<"'" + this.ConvertirDateSql( lxCalcprecFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCalcprecFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCalcprecFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCalcprecFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCalcprecFecexpo ) + "'" >>, <<lxCalcprecCodigo >>, <<lxCalcprecTimestamp >>, <<iif( lxCalcprecAnulado, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxCalcprecSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecDescfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecDescrip ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCalcprecFecha ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCalcprecFproceso ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCalcprecFechavig ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCalcprecFechabase ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecArtdesde ) + "'" >>, <<iif( lxCalcprecSintransac, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxCalcprecArthasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecColdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecColhasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecComporta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecTaldesde ) + "'" >>, <<iif( lxCalcprecKpxpartic, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxCalcprecTalhasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecProdesde ) + "'" >>, <<iif( lxCalcprecUsacomb, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxCalcprecProhasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecUnidesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecUnihasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecMatdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecMathasta ) + "'" >>, <<lxCalcprecEstdesde >>, <<lxCalcprecEsthasta >>, <<"'" + this.FormatearTextoSql( lxCalcprecUalta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecAnidesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecUmod ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecMobs ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecAnihasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecClasidesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecNarbadesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecClasihasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecNarbahasta ) + "'" >>, <<lxCalcprecFtsadesde >>, <<lxCalcprecFtsahasta >>, <<"'" + this.ConvertirDateSql( lxCalcprecFecdesde ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCalcprecFechasta ) + "'" >>, <<lxCalcprecCompdesde >>, <<lxCalcprecComphasta >>, <<lxCalcprecPrecdesde >>, <<lxCalcprecPrechasta >>, <<"'" + this.FormatearTextoSql( lxCalcprecMarcadesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCalcprecMarcahasta ) + "'" >> )
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
			local  lxCalcprecFecimpo, lxCalcprecFmodifw, lxCalcprecFectrans, lxCalcprecFaltafw, lxCalcprecFecexpo, lxCalcprecCodigo, lxCalcprecTimestamp, lxCalcprecAnulado, lxCalcprecSaltafw, lxCalcprecValtafw, lxCalcprecUaltafw, lxCalcprecVmodifw, lxCalcprecHaltafw, lxCalcprecDescfw, lxCalcprecZadsfw, lxCalcprecBdmodifw, lxCalcprecEsttrans, lxCalcprecBdaltafw, lxCalcprecHoraexpo, lxCalcprecUmodifw, lxCalcprecHoraimpo, lxCalcprecSmodifw, lxCalcprecHmodifw, lxCalcprecDescrip, lxCalcprecFecha, lxCalcprecFproceso, lxCalcprecFechavig, lxCalcprecFechabase, lxCalcprecArtdesde, lxCalcprecSintransac, lxCalcprecArthasta, lxCalcprecColdesde, lxCalcprecColhasta, lxCalcprecComporta, lxCalcprecTaldesde, lxCalcprecKpxpartic, lxCalcprecTalhasta, lxCalcprecProdesde, lxCalcprecUsacomb, lxCalcprecProhasta, lxCalcprecUnidesde, lxCalcprecUnihasta, lxCalcprecMatdesde, lxCalcprecMathasta, lxCalcprecEstdesde, lxCalcprecEsthasta, lxCalcprecUalta, lxCalcprecAnidesde, lxCalcprecUmod, lxCalcprecMobs, lxCalcprecAnihasta, lxCalcprecClasidesde, lxCalcprecNarbadesde, lxCalcprecClasihasta, lxCalcprecNarbahasta, lxCalcprecFtsadesde, lxCalcprecFtsahasta, lxCalcprecFecdesde, lxCalcprecFechasta, lxCalcprecCompdesde, lxCalcprecComphasta, lxCalcprecPrecdesde, lxCalcprecPrechasta, lxCalcprecMarcadesde, lxCalcprecMarcahasta
				lxCalcprecFecimpo =  .Fechaimpo			lxCalcprecFmodifw =  .Fechamodificacionfw			lxCalcprecFectrans =  .Fechatransferencia			lxCalcprecFaltafw =  .Fechaaltafw			lxCalcprecFecexpo =  .Fechaexpo			lxCalcprecCodigo =  .Codigo			lxCalcprecTimestamp = goLibrerias.ObtenerTimestamp()			lxCalcprecAnulado =  .Anulado			lxCalcprecSaltafw =  .Seriealtafw			lxCalcprecValtafw =  .Versionaltafw			lxCalcprecUaltafw =  .Usuarioaltafw			lxCalcprecVmodifw =  .Versionmodificacionfw			lxCalcprecHaltafw =  .Horaaltafw			lxCalcprecDescfw =  .Descripcionfw			lxCalcprecZadsfw =  .Zadsfw			lxCalcprecBdmodifw =  .Basededatosmodificacionfw			lxCalcprecEsttrans =  .Estadotransferencia			lxCalcprecBdaltafw =  .Basededatosaltafw			lxCalcprecHoraexpo =  .Horaexpo			lxCalcprecUmodifw =  .Usuariomodificacionfw			lxCalcprecHoraimpo =  .Horaimpo			lxCalcprecSmodifw =  .Seriemodificacionfw			lxCalcprecHmodifw =  .Horamodificacionfw			lxCalcprecDescrip =  .Descripcion			lxCalcprecFecha =  .Fecha			lxCalcprecFproceso =  .Fechaproceso			lxCalcprecFechavig =  .Fechavigencia			lxCalcprecFechabase =  .Fechabase			lxCalcprecArtdesde =  upper( .f_Articulo_Desde_PK ) 			lxCalcprecSintransac =  .Importarsintransaccion			lxCalcprecArthasta =  upper( .f_Articulo_Hasta_PK ) 			lxCalcprecColdesde =  upper( .f_Color_Desde_PK ) 			lxCalcprecColhasta =  upper( .f_Color_Hasta_PK ) 			lxCalcprecComporta =  .Articulo_comportamiento			lxCalcprecTaldesde =  .F_talle_desde			lxCalcprecKpxpartic =  .Preciokitpackxparticipante			lxCalcprecTalhasta =  .F_talle_hasta			lxCalcprecProdesde =  upper( .f_Articulo_Proveedor_Desde_PK ) 			lxCalcprecUsacomb =  .Usacombinacion			lxCalcprecProhasta =  upper( .f_Articulo_Proveedor_Hasta_PK ) 			lxCalcprecUnidesde =  upper( .f_Articulo_Unidad_Desde_PK ) 			lxCalcprecUnihasta =  upper( .f_Articulo_Unidad_Hasta_PK ) 			lxCalcprecMatdesde =  upper( .f_Articulo_Material_Desde_PK ) 			lxCalcprecMathasta =  upper( .f_Articulo_Material_Hasta_PK ) 			lxCalcprecEstdesde =  .F_articulo_estacion_desde			lxCalcprecEsthasta =  .F_articulo_estacion_hasta			lxCalcprecUalta =  .F_articulo_usuarioaltafw			lxCalcprecAnidesde =  .F_articulo_anio_desde			lxCalcprecUmod =  .F_articulo_usuariomodificacionfw			lxCalcprecMobs =  .Observacion			lxCalcprecAnihasta =  .F_articulo_anio_hasta			lxCalcprecClasidesde =  upper( .f_Articulo_clasificacion_desde_PK ) 			lxCalcprecNarbadesde =  upper( .f_Articulo_Nomenclador_Desde_PK ) 			lxCalcprecClasihasta =  upper( .f_Articulo_clasificacion_hasta_PK ) 			lxCalcprecNarbahasta =  upper( .f_Articulo_Nomenclador_Hasta_PK ) 			lxCalcprecFtsadesde =  .F_timestampalta_desde			lxCalcprecFtsahasta =  .F_timestampalta_hasta			lxCalcprecFecdesde =  .F_articulo_fechaaltafw_desde			lxCalcprecFechasta =  .F_articulo_fechaaltafw_hasta			lxCalcprecCompdesde =  .F_articulo_comportamiento_desde			lxCalcprecComphasta =  .F_articulo_comportamiento_hasta			lxCalcprecPrecdesde =  .F_preciodirecto_desde			lxCalcprecPrechasta =  .F_preciodirecto_hasta			lxCalcprecMarcadesde =  upper( .f_Articulo_Marca_Desde_PK ) 			lxCalcprecMarcahasta =  upper( .f_Articulo_Marca_Hasta_PK ) 
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = transform( this.oEntidad.CODIGO )

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  CALCPREC.CODIGO != 0]
			text to lcSentencia noshow textmerge
				update ZooLogic.CALCPREC set "Fecimpo" = <<"'" + this.ConvertirDateSql( lxCalcprecFecimpo ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxCalcprecFmodifw ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxCalcprecFectrans ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxCalcprecFaltafw ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxCalcprecFecexpo ) + "'">>, "Codigo" = <<lxCalcprecCodigo>>, "Timestamp" = <<lxCalcprecTimestamp>>, "Anulado" = <<iif( lxCalcprecAnulado, 1, 0 )>>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxCalcprecSaltafw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxCalcprecValtafw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxCalcprecUaltafw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxCalcprecVmodifw ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxCalcprecHaltafw ) + "'">>, "Descfw" = <<"'" + this.FormatearTextoSql( lxCalcprecDescfw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxCalcprecZadsfw ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxCalcprecBdmodifw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxCalcprecEsttrans ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxCalcprecBdaltafw ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxCalcprecHoraexpo ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxCalcprecUmodifw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxCalcprecHoraimpo ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxCalcprecSmodifw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxCalcprecHmodifw ) + "'">>, "Descrip" = <<"'" + this.FormatearTextoSql( lxCalcprecDescrip ) + "'">>, "Fecha" = <<"'" + this.ConvertirDateSql( lxCalcprecFecha ) + "'">>, "Fproceso" = <<"'" + this.ConvertirDateSql( lxCalcprecFproceso ) + "'">>, "Fechavig" = <<"'" + this.ConvertirDateSql( lxCalcprecFechavig ) + "'">>, "Fechabase" = <<"'" + this.ConvertirDateSql( lxCalcprecFechabase ) + "'">>, "Artdesde" = <<"'" + this.FormatearTextoSql( lxCalcprecArtdesde ) + "'">>, "Sintransac" = <<iif( lxCalcprecSintransac, 1, 0 )>>, "Arthasta" = <<"'" + this.FormatearTextoSql( lxCalcprecArthasta ) + "'">>, "Coldesde" = <<"'" + this.FormatearTextoSql( lxCalcprecColdesde ) + "'">>, "Colhasta" = <<"'" + this.FormatearTextoSql( lxCalcprecColhasta ) + "'">>, "Comporta" = <<"'" + this.FormatearTextoSql( lxCalcprecComporta ) + "'">>, "Taldesde" = <<"'" + this.FormatearTextoSql( lxCalcprecTaldesde ) + "'">>, "Kpxpartic" = <<iif( lxCalcprecKpxpartic, 1, 0 )>>, "Talhasta" = <<"'" + this.FormatearTextoSql( lxCalcprecTalhasta ) + "'">>, "Prodesde" = <<"'" + this.FormatearTextoSql( lxCalcprecProdesde ) + "'">>, "Usacomb" = <<iif( lxCalcprecUsacomb, 1, 0 )>>, "Prohasta" = <<"'" + this.FormatearTextoSql( lxCalcprecProhasta ) + "'">>, "Unidesde" = <<"'" + this.FormatearTextoSql( lxCalcprecUnidesde ) + "'">>, "Unihasta" = <<"'" + this.FormatearTextoSql( lxCalcprecUnihasta ) + "'">>, "Matdesde" = <<"'" + this.FormatearTextoSql( lxCalcprecMatdesde ) + "'">>, "Mathasta" = <<"'" + this.FormatearTextoSql( lxCalcprecMathasta ) + "'">>, "Estdesde" = <<lxCalcprecEstdesde>>, "Esthasta" = <<lxCalcprecEsthasta>>, "Ualta" = <<"'" + this.FormatearTextoSql( lxCalcprecUalta ) + "'">>, "Anidesde" = <<"'" + this.FormatearTextoSql( lxCalcprecAnidesde ) + "'">>, "Umod" = <<"'" + this.FormatearTextoSql( lxCalcprecUmod ) + "'">>, "Mobs" = <<"'" + this.FormatearTextoSql( lxCalcprecMobs ) + "'">>, "Anihasta" = <<"'" + this.FormatearTextoSql( lxCalcprecAnihasta ) + "'">>, "Clasidesde" = <<"'" + this.FormatearTextoSql( lxCalcprecClasidesde ) + "'">>, "Narbadesde" = <<"'" + this.FormatearTextoSql( lxCalcprecNarbadesde ) + "'">>, "Clasihasta" = <<"'" + this.FormatearTextoSql( lxCalcprecClasihasta ) + "'">>, "Narbahasta" = <<"'" + this.FormatearTextoSql( lxCalcprecNarbahasta ) + "'">>, "Ftsadesde" = <<lxCalcprecFtsadesde>>, "Ftsahasta" = <<lxCalcprecFtsahasta>>, "Fecdesde" = <<"'" + this.ConvertirDateSql( lxCalcprecFecdesde ) + "'">>, "Fechasta" = <<"'" + this.ConvertirDateSql( lxCalcprecFechasta ) + "'">>, "Compdesde" = <<lxCalcprecCompdesde>>, "Comphasta" = <<lxCalcprecComphasta>>, "Precdesde" = <<lxCalcprecPrecdesde>>, "Prechasta" = <<lxCalcprecPrechasta>>, "Marcadesde" = <<"'" + this.FormatearTextoSql( lxCalcprecMarcadesde ) + "'">>, "Marcahasta" = <<"'" + this.FormatearTextoSql( lxCalcprecMarcahasta ) + "'">> where << lcFiltro >>
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
							this.oConexion.EjecutarSql( [UPDATE ZooLogic.CALCPREC set  FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, CODIGO = ] + transform( &lcCursor..CODIGO )+ [, TIMESTAMP = ] + transform( &lcCursor..TIMESTAMP )+ [, Anulado = ] + Transform( iif( &lcCursor..Anulado, 1, 0 ))+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, DescFW = ] + "'" + this.FormatearTextoSql( &lcCursor..DescFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, Descrip = ] + "'" + this.FormatearTextoSql( &lcCursor..Descrip ) + "'"+ [, FECHA = ] + "'" + this.ConvertirDateSql( &lcCursor..FECHA ) + "'"+ [, FProceso = ] + "'" + this.ConvertirDateSql( &lcCursor..FProceso ) + "'"+ [, FECHAVIG = ] + "'" + this.ConvertirDateSql( &lcCursor..FECHAVIG ) + "'"+ [, Fechabase = ] + "'" + this.ConvertirDateSql( &lcCursor..Fechabase ) + "'"+ [, ArtDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..ArtDesde ) + "'"+ [, SinTransac = ] + Transform( iif( &lcCursor..SinTransac, 1, 0 ))+ [, ArtHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..ArtHasta ) + "'"+ [, ColDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..ColDesde ) + "'"+ [, ColHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..ColHasta ) + "'"+ [, Comporta = ] + "'" + this.FormatearTextoSql( &lcCursor..Comporta ) + "'"+ [, TalDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..TalDesde ) + "'"+ [, KPxPartic = ] + Transform( iif( &lcCursor..KPxPartic, 1, 0 ))+ [, TalHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..TalHasta ) + "'"+ [, ProDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..ProDesde ) + "'"+ [, UsaComb = ] + Transform( iif( &lcCursor..UsaComb, 1, 0 ))+ [, ProHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..ProHasta ) + "'"+ [, UniDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..UniDesde ) + "'"+ [, UniHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..UniHasta ) + "'"+ [, MatDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..MatDesde ) + "'"+ [, MatHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..MatHasta ) + "'"+ [, EstDesde = ] + transform( &lcCursor..EstDesde )+ [, EstHasta = ] + transform( &lcCursor..EstHasta )+ [, UAlta = ] + "'" + this.FormatearTextoSql( &lcCursor..UAlta ) + "'"+ [, AniDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..AniDesde ) + "'"+ [, UMod = ] + "'" + this.FormatearTextoSql( &lcCursor..UMod ) + "'"+ [, MObs = ] + "'" + this.FormatearTextoSql( &lcCursor..MObs ) + "'"+ [, AniHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..AniHasta ) + "'"+ [, ClasiDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..ClasiDesde ) + "'"+ [, NARBADesde = ] + "'" + this.FormatearTextoSql( &lcCursor..NARBADesde ) + "'"+ [, ClasiHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..ClasiHasta ) + "'"+ [, NARBAHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..NARBAHasta ) + "'"+ [, FTSADesde = ] + transform( &lcCursor..FTSADesde )+ [, FTSAHasta = ] + transform( &lcCursor..FTSAHasta )+ [, FecDesde = ] + "'" + this.ConvertirDateSql( &lcCursor..FecDesde ) + "'"+ [, FecHasta = ] + "'" + this.ConvertirDateSql( &lcCursor..FecHasta ) + "'"+ [, CompDesde = ] + transform( &lcCursor..CompDesde )+ [, CompHasta = ] + transform( &lcCursor..CompHasta )+ [, PrecDesde = ] + transform( &lcCursor..PrecDesde )+ [, PrecHasta = ] + transform( &lcCursor..PrecHasta )+ [, MarcaDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..MarcaDesde ) + "'"+ [, MarcaHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..MarcaHasta ) + "'" + [ Where CODIGO = ] + transform( &lcCursor..CODIGO ) )
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
					 FECIMPO, FMODIFW, FECTRANS, FALTAFW, FECEXPO, CODIGO, TIMESTAMP, Anulado, SALTAFW, VALTAFW, UALTAFW, VMODIFW, HALTAFW, DescFW, ZADSFW, BDMODIFW, ESTTRANS, BDALTAFW, HORAEXPO, UMODIFW, HORAIMPO, SMODIFW, HMODIFW, Descrip, FECHA, FProceso, FECHAVIG, Fechabase, ArtDesde, SinTransac, ArtHasta, ColDesde, ColHasta, Comporta, TalDesde, KPxPartic, TalHasta, ProDesde, UsaComb, ProHasta, UniDesde, UniHasta, MatDesde, MatHasta, EstDesde, EstHasta, UAlta, AniDesde, UMod, MObs, AniHasta, ClasiDesde, NARBADesde, ClasiHasta, NARBAHasta, FTSADesde, FTSAHasta, FecDesde, FecHasta, CompDesde, CompHasta, PrecDesde, PrecHasta, MarcaDesde, MarcaHasta
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + transform( &lcCursor..CODIGO ) + ',' + transform( &lcCursor..TIMESTAMP )
lcValoresCampos = lcValoresCampos  + ',' + Transform( iif( &lcCursor..Anulado, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..DescFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Descrip ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECHA ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FProceso ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECHAVIG ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..Fechabase ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..ArtDesde ) + "'" + ',' + Transform( iif( &lcCursor..SinTransac, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..ArtHasta ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ColDesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ColHasta ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Comporta ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..TalDesde ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + Transform( iif( &lcCursor..KPxPartic, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..TalHasta ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ProDesde ) + "'" + ',' + Transform( iif( &lcCursor..UsaComb, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..ProHasta ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UniDesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UniHasta ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..MatDesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..MatHasta ) + "'" + ',' + transform( &lcCursor..EstDesde ) + ',' + transform( &lcCursor..EstHasta ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..UAlta ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..AniDesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMod ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..MObs ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..AniHasta ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ClasiDesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..NARBADesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ClasiHasta ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..NARBAHasta ) + "'" + ',' + transform( &lcCursor..FTSADesde )
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..FTSAHasta ) + ',' + "'" + this.ConvertirDateSql( &lcCursor..FecDesde ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FecHasta ) + "'" + ',' + transform( &lcCursor..CompDesde ) + ',' + transform( &lcCursor..CompHasta ) + ',' + transform( &lcCursor..PrecDesde ) + ',' + transform( &lcCursor..PrecHasta ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..MarcaDesde ) + "'"
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
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FECHA     
		* Validar ANTERIORES A 1/1/1753  FProceso  
		* Validar ANTERIORES A 1/1/1753  FECHAVIG  
		* Validar ANTERIORES A 1/1/1753  Fechabase 
		* Validar ANTERIORES A 1/1/1753  FecDesde  
		* Validar ANTERIORES A 1/1/1753  FecHasta  
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_CALCPREC') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_CALCPREC
Create Table ZooLogic.TablaTrabajo_CALCPREC ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fecimpo" datetime  null, 
"fmodifw" datetime  null, 
"fectrans" datetime  null, 
"faltafw" datetime  null, 
"fecexpo" datetime  null, 
"codigo" numeric( 8, 0 )  null, 
"timestamp" numeric( 20, 0 )  null, 
"anulado" bit  null, 
"saltafw" char( 7 )  null, 
"valtafw" char( 13 )  null, 
"ualtafw" char( 100 )  null, 
"vmodifw" char( 13 )  null, 
"haltafw" char( 8 )  null, 
"descfw" char( 200 )  null, 
"zadsfw" varchar(max)  null, 
"bdmodifw" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"bdaltafw" char( 8 )  null, 
"horaexpo" char( 8 )  null, 
"umodifw" char( 100 )  null, 
"horaimpo" char( 8 )  null, 
"smodifw" char( 7 )  null, 
"hmodifw" char( 8 )  null, 
"descrip" char( 40 )  null, 
"fecha" datetime  null, 
"fproceso" datetime  null, 
"fechavig" datetime  null, 
"fechabase" datetime  null, 
"artdesde" char( 13 )  null, 
"sintransac" bit  null, 
"arthasta" char( 13 )  null, 
"coldesde" char( 2 )  null, 
"colhasta" char( 2 )  null, 
"comporta" char( 1 )  null, 
"taldesde" char( 3 )  null, 
"kpxpartic" bit  null, 
"talhasta" char( 3 )  null, 
"prodesde" char( 5 )  null, 
"usacomb" bit  null, 
"prohasta" char( 5 )  null, 
"unidesde" char( 3 )  null, 
"unihasta" char( 3 )  null, 
"matdesde" char( 10 )  null, 
"mathasta" char( 10 )  null, 
"estdesde" numeric( 1, 0 )  null, 
"esthasta" numeric( 1, 0 )  null, 
"ualta" char( 65 )  null, 
"anidesde" char( 2 )  null, 
"umod" char( 65 )  null, 
"mobs" varchar(max)  null, 
"anihasta" char( 2 )  null, 
"clasidesde" char( 10 )  null, 
"narbadesde" char( 6 )  null, 
"clasihasta" char( 10 )  null, 
"narbahasta" char( 6 )  null, 
"ftsadesde" numeric( 14, 0 )  null, 
"ftsahasta" numeric( 14, 0 )  null, 
"fecdesde" datetime  null, 
"fechasta" datetime  null, 
"compdesde" numeric( 1, 0 )  null, 
"comphasta" numeric( 1, 0 )  null, 
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
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('codigo','codigo')
			.AgregarMapeo('timestamp','timestamp')
			.AgregarMapeo('anulado','anulado')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('descfw','descfw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('descrip','descrip')
			.AgregarMapeo('fecha','fecha')
			.AgregarMapeo('fproceso','fproceso')
			.AgregarMapeo('fechavig','fechavig')
			.AgregarMapeo('fechabase','fechabase')
			.AgregarMapeo('artdesde','artdesde')
			.AgregarMapeo('sintransac','sintransac')
			.AgregarMapeo('arthasta','arthasta')
			.AgregarMapeo('coldesde','coldesde')
			.AgregarMapeo('colhasta','colhasta')
			.AgregarMapeo('comporta','comporta')
			.AgregarMapeo('taldesde','taldesde')
			.AgregarMapeo('kpxpartic','kpxpartic')
			.AgregarMapeo('talhasta','talhasta')
			.AgregarMapeo('prodesde','prodesde')
			.AgregarMapeo('usacomb','usacomb')
			.AgregarMapeo('prohasta','prohasta')
			.AgregarMapeo('unidesde','unidesde')
			.AgregarMapeo('unihasta','unihasta')
			.AgregarMapeo('matdesde','matdesde')
			.AgregarMapeo('mathasta','mathasta')
			.AgregarMapeo('estdesde','estdesde')
			.AgregarMapeo('esthasta','esthasta')
			.AgregarMapeo('ualta','ualta')
			.AgregarMapeo('anidesde','anidesde')
			.AgregarMapeo('umod','umod')
			.AgregarMapeo('mobs','mobs')
			.AgregarMapeo('anihasta','anihasta')
			.AgregarMapeo('clasidesde','clasidesde')
			.AgregarMapeo('narbadesde','narbadesde')
			.AgregarMapeo('clasihasta','clasihasta')
			.AgregarMapeo('narbahasta','narbahasta')
			.AgregarMapeo('ftsadesde','ftsadesde')
			.AgregarMapeo('ftsahasta','ftsahasta')
			.AgregarMapeo('fecdesde','fecdesde')
			.AgregarMapeo('fechasta','fechasta')
			.AgregarMapeo('compdesde','compdesde')
			.AgregarMapeo('comphasta','comphasta')
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
				insert into ZooLogic.CALCPREC(Fecimpo,Fmodifw,Fectrans,Faltafw,Fecexpo,Codigo,Timestamp,Anulado,Saltafw,Valtafw,Ualtafw,Vmodifw,Haltafw,Descfw,Zadsfw,Bdmodifw,Esttrans,Bdaltafw,Horaexpo,Umodifw,Horaimpo,Smodifw,Hmodifw,Descrip,Fecha,Fproceso,Fechavig,Fechabase,Artdesde,Sintransac,Arthasta,Coldesde,Colhasta,Comporta,Taldesde,Kpxpartic,Talhasta,Prodesde,Usacomb,Prohasta,Unidesde,Unihasta,Matdesde,Mathasta,Estdesde,Esthasta,Ualta,Anidesde,Umod,Mobs,Anihasta,Clasidesde,Narbadesde,Clasihasta,Narbahasta,Ftsadesde,Ftsahasta,Fecdesde,Fechasta,Compdesde,Comphasta,Precdesde,Prechasta,Marcadesde,Marcahasta)
					Select isnull( d.FECIMPO,''),isnull( d.FMODIFW,''),isnull( d.FECTRANS,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FECEXPO,''),isnull( d.CODIGO,0),isnull( d.TIMESTAMP,0),isnull( d.ANULADO,0),isnull( d.SALTAFW,''),isnull( d.VALTAFW,''),isnull( d.UALTAFW,''),isnull( d.VMODIFW,''),convert( char(8), getdate(), 108 ),isnull( d.DESCFW,''),isnull( d.ZADSFW,''),isnull( d.BDMODIFW,''),isnull( d.ESTTRANS,''),isnull( d.BDALTAFW,''),isnull( d.HORAEXPO,''),isnull( d.UMODIFW,''),isnull( d.HORAIMPO,''),isnull( d.SMODIFW,''),isnull( d.HMODIFW,''),isnull( d.DESCRIP,''),isnull( d.FECHA,''),isnull( d.FPROCESO,''),isnull( d.FECHAVIG,''),isnull( d.FECHABASE,''),isnull( d.ARTDESDE,''),isnull( d.SINTRANSAC,0),isnull( d.ARTHASTA,''),isnull( d.COLDESDE,''),isnull( d.COLHASTA,''),isnull( d.COMPORTA,''),isnull( d.TALDESDE,''),isnull( d.KPXPARTIC,0),isnull( d.TALHASTA,''),isnull( d.PRODESDE,''),isnull( d.USACOMB,0),isnull( d.PROHASTA,''),isnull( d.UNIDESDE,''),isnull( d.UNIHASTA,''),isnull( d.MATDESDE,''),isnull( d.MATHASTA,''),isnull( d.ESTDESDE,0),isnull( d.ESTHASTA,0),isnull( d.UALTA,''),isnull( d.ANIDESDE,''),isnull( d.UMOD,''),isnull( d.MOBS,''),isnull( d.ANIHASTA,''),isnull( d.CLASIDESDE,''),isnull( d.NARBADESDE,''),isnull( d.CLASIHASTA,''),isnull( d.NARBAHASTA,''),isnull( d.FTSADESDE,0),isnull( d.FTSAHASTA,0),isnull( d.FECDESDE,''),isnull( d.FECHASTA,''),isnull( d.COMPDESDE,0),isnull( d.COMPHASTA,0),isnull( d.PRECDESDE,0),isnull( d.PRECHASTA,0),isnull( d.MARCADESDE,''),isnull( d.MARCAHASTA,'')
						From deleted d 
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
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_CALCULODEPRECIOS.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_CALCULODEPRECIOS.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_CALCULODEPRECIOS.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_CALCULODEPRECIOS.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_CALCULODEPRECIOS.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Codigo = nvl( c_CALCULODEPRECIOS.Codigo, 0 )
					.Timestamp = nvl( c_CALCULODEPRECIOS.Timestamp, 0 )
					.Anulado = nvl( c_CALCULODEPRECIOS.Anulado, .F. )
					.Seriealtafw = nvl( c_CALCULODEPRECIOS.Seriealtafw, [] )
					.Versionaltafw = nvl( c_CALCULODEPRECIOS.Versionaltafw, [] )
					.Usuarioaltafw = nvl( c_CALCULODEPRECIOS.Usuarioaltafw, [] )
					.Versionmodificacionfw = nvl( c_CALCULODEPRECIOS.Versionmodificacionfw, [] )
					.Horaaltafw = nvl( c_CALCULODEPRECIOS.Horaaltafw, [] )
					.Descripcionfw = nvl( c_CALCULODEPRECIOS.Descripcionfw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Basededatosmodificacionfw = nvl( c_CALCULODEPRECIOS.Basededatosmodificacionfw, [] )
					.Estadotransferencia = nvl( c_CALCULODEPRECIOS.Estadotransferencia, [] )
					.Basededatosaltafw = nvl( c_CALCULODEPRECIOS.Basededatosaltafw, [] )
					.Horaexpo = nvl( c_CALCULODEPRECIOS.Horaexpo, [] )
					.Usuariomodificacionfw = nvl( c_CALCULODEPRECIOS.Usuariomodificacionfw, [] )
					.Horaimpo = nvl( c_CALCULODEPRECIOS.Horaimpo, [] )
					.Seriemodificacionfw = nvl( c_CALCULODEPRECIOS.Seriemodificacionfw, [] )
					.Horamodificacionfw = nvl( c_CALCULODEPRECIOS.Horamodificacionfw, [] )
					.Descripcion = nvl( c_CALCULODEPRECIOS.Descripcion, [] )
					.Fecha = GoLibrerias.ObtenerFechaFormateada( nvl( c_CALCULODEPRECIOS.Fecha, ctod( '  /  /    ' ) ) )
					.Fechaproceso = GoLibrerias.ObtenerFechaFormateada( nvl( c_CALCULODEPRECIOS.Fechaproceso, ctod( '  /  /    ' ) ) )
					.Fechavigencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_CALCULODEPRECIOS.Fechavigencia, ctod( '  /  /    ' ) ) )
					.Fechabase = GoLibrerias.ObtenerFechaFormateada( nvl( c_CALCULODEPRECIOS.Fechabase, ctod( '  /  /    ' ) ) )
					.F_articulo_desde_PK =  nvl( c_CALCULODEPRECIOS.F_articulo_desde, [] )
					.Importarsintransaccion = nvl( c_CALCULODEPRECIOS.Importarsintransaccion, .F. )
					.F_articulo_hasta_PK =  nvl( c_CALCULODEPRECIOS.F_articulo_hasta, [] )
					.F_color_desde_PK =  nvl( c_CALCULODEPRECIOS.F_color_desde, [] )
					.F_color_hasta_PK =  nvl( c_CALCULODEPRECIOS.F_color_hasta, [] )
					.Articulo_comportamiento = nvl( c_CALCULODEPRECIOS.Articulo_comportamiento, [] )
					.F_talle_desde = nvl( c_CALCULODEPRECIOS.F_talle_desde, [] )
					.Preciokitpackxparticipante = nvl( c_CALCULODEPRECIOS.Preciokitpackxparticipante, .F. )
					.F_talle_hasta = nvl( c_CALCULODEPRECIOS.F_talle_hasta, [] )
					.F_articulo_proveedor_desde_PK =  nvl( c_CALCULODEPRECIOS.F_articulo_proveedor_desde, [] )
					.Usacombinacion = nvl( c_CALCULODEPRECIOS.Usacombinacion, .F. )
					.F_articulo_proveedor_hasta_PK =  nvl( c_CALCULODEPRECIOS.F_articulo_proveedor_hasta, [] )
					.F_articulo_unidad_desde_PK =  nvl( c_CALCULODEPRECIOS.F_articulo_unidad_desde, [] )
					.F_articulo_unidad_hasta_PK =  nvl( c_CALCULODEPRECIOS.F_articulo_unidad_hasta, [] )
					.F_articulo_material_desde_PK =  nvl( c_CALCULODEPRECIOS.F_articulo_material_desde, [] )
					.F_articulo_material_hasta_PK =  nvl( c_CALCULODEPRECIOS.F_articulo_material_hasta, [] )
					.F_articulo_estacion_desde = nvl( c_CALCULODEPRECIOS.F_articulo_estacion_desde, 0 )
					.F_articulo_estacion_hasta = nvl( c_CALCULODEPRECIOS.F_articulo_estacion_hasta, 0 )
					.F_articulo_usuarioaltafw = nvl( c_CALCULODEPRECIOS.F_articulo_usuarioaltafw, [] )
					.Modprecios.Limpiar()
					.Modprecios.SetearEsNavegacion( .lProcesando )
					.Modprecios.Cargar()
					.F_articulo_anio_desde = nvl( c_CALCULODEPRECIOS.F_articulo_anio_desde, [] )
					.F_articulo_usuariomodificacionfw = nvl( c_CALCULODEPRECIOS.F_articulo_usuariomodificacionfw, [] )
					lcValor = This.ObtenerMemo( 'c_Observacion')
					.Observacion = lcValor 
					.F_articulo_anio_hasta = nvl( c_CALCULODEPRECIOS.F_articulo_anio_hasta, [] )
					.F_articulo_clasificacion_desde_PK =  nvl( c_CALCULODEPRECIOS.F_articulo_clasificacion_desde, [] )
					.F_articulo_nomenclador_desde_PK =  nvl( c_CALCULODEPRECIOS.F_articulo_nomenclador_desde, [] )
					.F_articulo_clasificacion_hasta_PK =  nvl( c_CALCULODEPRECIOS.F_articulo_clasificacion_hasta, [] )
					.F_articulo_nomenclador_hasta_PK =  nvl( c_CALCULODEPRECIOS.F_articulo_nomenclador_hasta, [] )
					.F_timestampalta_desde = nvl( c_CALCULODEPRECIOS.F_timestampalta_desde, 0 )
					.F_timestampalta_hasta = nvl( c_CALCULODEPRECIOS.F_timestampalta_hasta, 0 )
					.F_articulo_fechaaltafw_desde = GoLibrerias.ObtenerFechaFormateada( nvl( c_CALCULODEPRECIOS.F_articulo_fechaaltafw_desde, ctod( '  /  /    ' ) ) )
					.F_articulo_fechaaltafw_hasta = GoLibrerias.ObtenerFechaFormateada( nvl( c_CALCULODEPRECIOS.F_articulo_fechaaltafw_hasta, ctod( '  /  /    ' ) ) )
					.F_articulo_comportamiento_desde = nvl( c_CALCULODEPRECIOS.F_articulo_comportamiento_desde, 0 )
					.F_articulo_comportamiento_hasta = nvl( c_CALCULODEPRECIOS.F_articulo_comportamiento_hasta, 0 )
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
			"Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Codigo" as "Codigo", "Timestamp" as "Timestamp", "Anulado" as "Anulado", "Saltafw" as "Seriealtafw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Vmodifw" as "Versionmodificacionfw", "Haltafw" as "Horaaltafw", "Descfw" as "Descripcionfw", "Zadsfw" as "Zadsfw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Horaexpo" as "Horaexpo", "Umodifw" as "Usuariomodificacionfw", "Horaimpo" as "Horaimpo", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Descrip" as "Descripcion", "Fecha" as "Fecha", "Fproceso" as "Fechaproceso", "Fechavig" as "Fechavigencia", "Fechabase" as "Fechabase", "Artdesde" as "F_articulo_desde", "Sintransac" as "Importarsintransaccion", "Arthasta" as "F_articulo_hasta", "Coldesde" as "F_color_desde", "Colhasta" as "F_color_hasta", "Comporta" as "Articulo_comportamiento", "Taldesde" as "F_talle_desde", "Kpxpartic" as "Preciokitpackxparticipante", "Talhasta" as "F_talle_hasta", "Prodesde" as "F_articulo_proveedor_desde", "Usacomb" as "Usacombinacion", "Prohasta" as "F_articulo_proveedor_hasta", "Unidesde" as "F_articulo_unidad_desde", "Unihasta" as "F_articulo_unidad_hasta", "Matdesde" as "F_articulo_material_desde", "Mathasta" as "F_articulo_material_hasta", "Estdesde" as "F_articulo_estacion_desde", "Esthasta" as "F_articulo_estacion_hasta", "Ualta" as "F_articulo_usuarioaltafw", "Anidesde" as "F_articulo_anio_desde", "Umod" as "F_articulo_usuariomodificacionfw", "Mobs" as "Observacion", "Anihasta" as "F_articulo_anio_hasta", "Clasidesde" as "F_articulo_clasificacion_desde", "Narbadesde" as "F_articulo_nomenclador_desde", "Clasihasta" as "F_articulo_clasificacion_hasta", "Narbahasta" as "F_articulo_nomenclador_hasta", "Ftsadesde" as "F_timestampalta_desde", "Ftsahasta" as "F_timestampalta_hasta", "Fecdesde" as "F_articulo_fechaaltafw_desde", "Fechasta" as "F_articulo_fechaaltafw_hasta", "Compdesde" as "F_articulo_comportamiento_desde", "Comphasta" as "F_articulo_comportamiento_hasta", "Precdesde" as "F_preciodirecto_desde", "Prechasta" as "F_preciodirecto_hasta", "Marcadesde" as "F_articulo_marca_desde", "Marcahasta" as "F_articulo_marca_hasta"
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
	<row entidad="CALCULODEPRECIOS                        " atributo="FECHAIMPO                               " tabla="CALCPREC       " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="FECHAMODIFICACIONFW                     " tabla="CALCPREC       " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="FECHATRANSFERENCIA                      " tabla="CALCPREC       " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha transferencia                                                                                                                                             " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="FECHAALTAFW                             " tabla="CALCPREC       " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="FECHAEXPO                               " tabla="CALCPREC       " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="CODIGO                                  " tabla="CALCPREC       " campo="CODIGO    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="2" etiqueta="Número                                                                                                                                                          " dominio="CODIGONUMERICO                " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="TIMESTAMP                               " tabla="CALCPREC       " campo="TIMESTAMP " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="ANULADO                                 " tabla="CALCPREC       " campo="ANULADO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Anulado                                                                                                                                                         " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="SERIEALTAFW                             " tabla="CALCPREC       " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="VERSIONALTAFW                           " tabla="CALCPREC       " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="USUARIOALTAFW                           " tabla="CALCPREC       " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="VERSIONMODIFICACIONFW                   " tabla="CALCPREC       " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="HORAALTAFW                              " tabla="CALCPREC       " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="DESCRIPCIONFW                           " tabla="CALCPREC       " campo="DESCFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="200" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="ZADSFW                                  " tabla="CALCPREC       " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="CALCPREC       " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="ESTADOTRANSFERENCIA                     " tabla="CALCPREC       " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado transferencia                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="BASEDEDATOSALTAFW                       " tabla="CALCPREC       " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="HORAEXPO                                " tabla="CALCPREC       " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="USUARIOMODIFICACIONFW                   " tabla="CALCPREC       " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="HORAIMPO                                " tabla="CALCPREC       " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="SERIEMODIFICACIONFW                     " tabla="CALCPREC       " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="HORAMODIFICACIONFW                      " tabla="CALCPREC       " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="DESCRIPCION                             " tabla="CALCPREC       " campo="DESCRIP   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="4" etiqueta="Descripción                                                                                                                                                     " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="FECHA                                   " tabla="CALCPREC       " campo="FECHA     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goServicios.Librerias.ObtenerFecha()                                                                                                                                                                                                                         " obligatorio="true" admitebusqueda="400" etiqueta="Fecha                                                                                                                                                           " dominio="FECHACALENDARIO               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="FECHAPROCESO                            " tabla="CALCPREC       " campo="FPROCESO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Procesado el                                                                                                                                                    " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="3" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="FECHAVIGENCIA                           " tabla="CALCPREC       " campo="FECHAVIG  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goServicios.librerias.ObtenerFecha() +1                                                                                                                                                                                                                      " obligatorio="true" admitebusqueda="402" etiqueta="Vigencia desde                                                                                                                                                  " dominio="FECHACALENDARIO               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="FECHABASE                               " tabla="CALCPREC       " campo="FECHABASE " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goServicios.librerias.ObtenerFecha()                                                                                                                                                                                                                         " obligatorio="true" admitebusqueda="404" etiqueta="Fecha base de precios                                                                                                                                           " dominio="FECHACALENDARIO               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="F_ARTICULO_DESDE                        " tabla="CALCPREC       " campo="ARTDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="ARTICULO                                " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="406" etiqueta="Artículo                                                                                                                                                        " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="4" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="IMPORTARSINTRANSACCION                  " tabla="CALCPREC       " campo="SINTRANSAC" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="=.T.                                                                                                                                                                                                                                                          " obligatorio="false" admitebusqueda="408" etiqueta="Procesar modo rápido                                                                                                                                            " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="F_ARTICULO_HASTA                        " tabla="CALCPREC       " campo="ARTHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="ARTICULO                                " tipodato="C         " longitud="13" decimales="0" valorsugerido="ZZZZZZZZZZZZZ                                                                                                                                                                                                                                                 " obligatorio="false" admitebusqueda="410" etiqueta="Artículo                                                                                                                                                        " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="4" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="F_COLOR_DESDE                           " tabla="CALCPREC       " campo="COLDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="COLOR                                   " tipodato="C         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="412" etiqueta="Color                                                                                                                                                           " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="5" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="F_COLOR_HASTA                           " tabla="CALCPREC       " campo="COLHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="COLOR                                   " tipodato="C         " longitud="2" decimales="0" valorsugerido="ZZ                                                                                                                                                                                                                                                            " obligatorio="false" admitebusqueda="414" etiqueta="Color                                                                                                                                                           " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="5" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="ARTICULO_COMPORTAMIENTO                 " tabla="CALCPREC       " campo="COMPORTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="416" etiqueta="Comportamiento                                                                                                                                                  " dominio="COMBOCOMPORTAMIENTO           " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="7" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="F_TALLE_DESDE                           " tabla="CALCPREC       " campo="TALDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="3" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="418" etiqueta="Talle                                                                                                                                                           " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="6" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="PRECIOKITPACKXPARTICIPANTE              " tabla="CALCPREC       " campo="KPXPARTIC " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="=.F.                                                                                                                                                                                                                                                          " obligatorio="false" admitebusqueda="420" etiqueta="Cálculo de precio de kit / pack en base a sus participantes                                                                                                     " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="8" orden="8" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="F_TALLE_HASTA                           " tabla="CALCPREC       " campo="TALHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="3" decimales="0" valorsugerido="ZZZ                                                                                                                                                                                                                                                           " obligatorio="false" admitebusqueda="422" etiqueta="Talle                                                                                                                                                           " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="6" orden="8" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="F_ARTICULO_PROVEEDOR_DESDE              " tabla="CALCPREC       " campo="PRODESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="PROVEEDOR                               " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="424" etiqueta="Proveedor                                                                                                                                                       " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="7" orden="9" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="USACOMBINACION                          " tabla="CALCPREC       " campo="USACOMB   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="=.F.                                                                                                                                                                                                                                                          " obligatorio="false" admitebusqueda="426" etiqueta="Maneja precio por combinación                                                                                                                                   " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="10" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="F_ARTICULO_PROVEEDOR_HASTA              " tabla="CALCPREC       " campo="PROHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="PROVEEDOR                               " tipodato="C         " longitud="5" decimales="0" valorsugerido="ZZZZZ                                                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="428" etiqueta="Proveedor                                                                                                                                                       " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="7" orden="10" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="F_ARTICULO_UNIDAD_DESDE                 " tabla="CALCPREC       " campo="UNIDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="UNIDADDEMEDIDA                          " tipodato="C         " longitud="3" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="430" etiqueta="Unidad                                                                                                                                                          " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="8" orden="11" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="F_ARTICULO_UNIDAD_HASTA                 " tabla="CALCPREC       " campo="UNIHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="UNIDADDEMEDIDA                          " tipodato="C         " longitud="3" decimales="0" valorsugerido="ZZZ                                                                                                                                                                                                                                                           " obligatorio="false" admitebusqueda="432" etiqueta="Unidad                                                                                                                                                          " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="8" orden="12" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="F_ARTICULO_MATERIAL_DESDE               " tabla="CALCPREC       " campo="MATDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="MATERIAL                                " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="434" etiqueta="Material                                                                                                                                                        " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="9" orden="15" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="F_ARTICULO_MATERIAL_HASTA               " tabla="CALCPREC       " campo="MATHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="MATERIAL                                " tipodato="C         " longitud="10" decimales="0" valorsugerido="ZZZZZZZZZZ                                                                                                                                                                                                                                                    " obligatorio="false" admitebusqueda="436" etiqueta="Material                                                                                                                                                        " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="9" orden="16" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="F_ARTICULO_ESTACION_DESDE               " tabla="CALCPREC       " campo="ESTDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="1                                                                                                                                                                                                                                                             " obligatorio="false" admitebusqueda="438" etiqueta="Estación                                                                                                                                                        " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="10" orden="17" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="F_ARTICULO_ESTACION_HASTA               " tabla="CALCPREC       " campo="ESTHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="4                                                                                                                                                                                                                                                             " obligatorio="false" admitebusqueda="440" etiqueta="Estación                                                                                                                                                        " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="10" orden="18" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="F_ARTICULO_USUARIOALTAFW                " tabla="CALCPREC       " campo="UALTA     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="65" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="442" etiqueta="Usuario que dio de alta                                                                                                                                         " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="20" orden="19" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="MODPRECIOS                              " tabla="CALCPRECDET    " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="444" etiqueta="                                                                                                                                                                " dominio="DETALLEITEMCALCULODEPRECIOS   " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="4" orden="19" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="F_ARTICULO_ANIO_DESDE                   " tabla="CALCPREC       " campo="ANIDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="446" etiqueta="Año                                                                                                                                                             " dominio="EtiquetaNumericoDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="11" orden="19" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="F_ARTICULO_USUARIOMODIFICACIONFW        " tabla="CALCPREC       " campo="UMOD      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="65" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="448" etiqueta="Ultimo usuario que modifico                                                                                                                                     " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="21" orden="20" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="OBSERVACION                             " tabla="CALCPREC       " campo="MOBS      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="450" etiqueta="Observaciones                                                                                                                                                   " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="20" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="F_ARTICULO_ANIO_HASTA                   " tabla="CALCPREC       " campo="ANIHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="2" decimales="0" valorsugerido="99                                                                                                                                                                                                                                                            " obligatorio="false" admitebusqueda="452" etiqueta="Año                                                                                                                                                             " dominio="EtiquetaNumericoDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="11" orden="20" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="F_ARTICULO_CLASIFICACION_DESDE          " tabla="CALCPREC       " campo="CLASIDESDE" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CLASIFICACIONARTICULO                   " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="454" etiqueta="Clasificación                                                                                                                                                   " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="13" orden="25" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="F_ARTICULO_NOMENCLADOR_DESDE            " tabla="CALCPREC       " campo="NARBADESDE" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="NOMENCLADORARBA                         " tipodato="C         " longitud="6" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="456" etiqueta="Código del nomenclador ARBA                                                                                                                                     " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="12" orden="25" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="F_ARTICULO_CLASIFICACION_HASTA          " tabla="CALCPREC       " campo="CLASIHASTA" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CLASIFICACIONARTICULO                   " tipodato="C         " longitud="10" decimales="0" valorsugerido="ZZZZZZZZZZ                                                                                                                                                                                                                                                    " obligatorio="false" admitebusqueda="458" etiqueta="Clasificación                                                                                                                                                   " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="13" orden="26" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="F_ARTICULO_NOMENCLADOR_HASTA            " tabla="CALCPREC       " campo="NARBAHASTA" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="NOMENCLADORARBA                         " tipodato="C         " longitud="6" decimales="0" valorsugerido="ZZZZZZ                                                                                                                                                                                                                                                        " obligatorio="false" admitebusqueda="460" etiqueta="Código del nomenclador ARBA                                                                                                                                     " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="12" orden="26" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="F_TIMESTAMPALTA_DESDE                   " tabla="CALCPREC       " campo="FTSADESDE " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="14" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="462" etiqueta="Timestamp alta                                                                                                                                                  " dominio="EtiquetaNumericoDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="31" orden="30" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="F_TIMESTAMPALTA_HASTA                   " tabla="CALCPREC       " campo="FTSAHASTA " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="14" decimales="0" valorsugerido="99999999999999                                                                                                                                                                                                                                                " obligatorio="false" admitebusqueda="464" etiqueta="Timestamp alta                                                                                                                                                  " dominio="EtiquetaNumericoDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="31" orden="31" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="F_ARTICULO_FECHAALTAFW_DESDE            " tabla="CALCPREC       " campo="FECDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="466" etiqueta="Fecha de Alta                                                                                                                                                   " dominio="EtiquetaFechaDesdeHasta       " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="14" orden="31" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="F_ARTICULO_FECHAALTAFW_HASTA            " tabla="CALCPREC       " campo="FECHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goServicios.Librerias.ObtenerFecha()                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="468" etiqueta="Fecha de Alta                                                                                                                                                   " dominio="EtiquetaFechaDesdeHasta       " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="14" orden="32" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="F_ARTICULO_COMPORTAMIENTO_DESDE         " tabla="CALCPREC       " campo="COMPDESDE " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="0                                                                                                                                                                                                                                                             " obligatorio="false" admitebusqueda="0" etiqueta="Comportamiento                                                                                                                                                  " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="15" orden="33" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="F_ARTICULO_COMPORTAMIENTO_HASTA         " tabla="CALCPREC       " campo="COMPHASTA " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="9                                                                                                                                                                                                                                                             " obligatorio="false" admitebusqueda="0" etiqueta="Comportamiento                                                                                                                                                  " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="15" orden="34" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="F_PRECIODIRECTO_DESDE                   " tabla="CALCPREC       " campo="PRECDESDE " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="470" etiqueta="Precio                                                                                                                                                          " dominio="EtiquetaNumericoDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="16" orden="37" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="F_PRECIODIRECTO_HASTA                   " tabla="CALCPREC       " campo="PRECHASTA " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="999999999999.99                                                                                                                                                                                                                                               " obligatorio="false" admitebusqueda="472" etiqueta="Precio                                                                                                                                                          " dominio="EtiquetaNumericoDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="16" orden="38" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="F_ARTICULO_MARCA_DESDE                  " tabla="CALCPREC       " campo="MARCADESDE" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="MARCA                                   " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="474" etiqueta="Marca del artículo desde                                                                                                                                        " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="42" orden="39" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CALCULODEPRECIOS                        " atributo="F_ARTICULO_MARCA_HASTA                  " tabla="CALCPREC       " campo="MARCAHASTA" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="MARCA                                   " tipodato="C         " longitud="30" decimales="0" valorsugerido="=Replicate( &quot;Z&quot;,30)                                                                                                                                                                                                                                           " obligatorio="false" admitebusqueda="476" etiqueta="Marca del artículo hasta                                                                                                                                        " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="42" orden="40" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="DESCRIPCION                             " tabla="ART            " campo="ARTDES    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="407" etiqueta="Detalle Art.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join ART On CALCPREC.ARTDESDE = ART.ARTCOD And  ART.ARTCOD != ''                                                                                                                                                                                        " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="DESCRIPCION                             " tabla="ART            " campo="ARTDES    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="411" etiqueta="Detalle Art.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join ART On CALCPREC.ARTHASTA = ART.ARTCOD And  ART.ARTCOD != ''                                                                                                                                                                                        " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COLOR                                   " atributo="DESCRIPCION                             " tabla="COL            " campo="COLDES    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="413" etiqueta="Detalle Col.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join COL On CALCPREC.COLDESDE = COL.COLCOD And  COL.COLCOD != ''                                                                                                                                                                                        " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COLOR                                   " atributo="DESCRIPCION                             " tabla="COL            " campo="COLDES    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="415" etiqueta="Detalle Col.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join COL On CALCPREC.COLHASTA = COL.COLCOD And  COL.COLCOD != ''                                                                                                                                                                                        " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="NOMBRE                                  " tabla="PROVEED        " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="425" etiqueta="Detalle Pro.                                                                                                                                                    " dominio="TEXTOBUSQUEDA                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join PROVEED On CALCPREC.PRODESDE = PROVEED.CLCOD And  PROVEED.CLCOD != ''                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="NOMBRE                                  " tabla="PROVEED        " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="429" etiqueta="Detalle Pro.                                                                                                                                                    " dominio="TEXTOBUSQUEDA                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join PROVEED On CALCPREC.PROHASTA = PROVEED.CLCOD And  PROVEED.CLCOD != ''                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="UNIDADDEMEDIDA                          " atributo="DESCRIPCION                             " tabla="UNMED          " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="431" etiqueta="Detalle Uni.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join UNMED On CALCPREC.UNIDESDE = UNMED.Cod And  UNMED.COD != ''                                                                                                                                                                                        " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="UNIDADDEMEDIDA                          " atributo="DESCRIPCION                             " tabla="UNMED          " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="433" etiqueta="Detalle Uni.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join UNMED On CALCPREC.UNIHASTA = UNMED.Cod And  UNMED.COD != ''                                                                                                                                                                                        " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MATERIAL                                " atributo="DESCRIPCION                             " tabla="MAT            " campo="MATDES    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="435" etiqueta="Detalle Mat.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join MAT On CALCPREC.MATDESDE = MAT.MATCOD And  MAT.MATCOD != ''                                                                                                                                                                                        " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MATERIAL                                " atributo="DESCRIPCION                             " tabla="MAT            " campo="MATDES    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="437" etiqueta="Detalle Mat.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join MAT On CALCPREC.MATHASTA = MAT.MATCOD And  MAT.MATCOD != ''                                                                                                                                                                                        " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLASIFICACIONARTICULO                   " atributo="DESCRIPCION                             " tabla="CLASIFART      " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="455" etiqueta="Detalle Cla.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CLASIFART On CALCPREC.CLASIDESDE = CLASIFART.CODIGO And  CLASIFART.CODIGO != ''                                                                                                                                                                    " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOMENCLADORARBA                         " atributo="DESCRIPCION                             " tabla="NMCARBA        " campo="NMCDES    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="150" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="457" etiqueta="Detalle Cód.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join NMCARBA On CALCPREC.NARBADESDE = NMCARBA.NMCCOD And  NMCARBA.NMCCOD != ''                                                                                                                                                                          " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLASIFICACIONARTICULO                   " atributo="DESCRIPCION                             " tabla="CLASIFART      " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="459" etiqueta="Detalle Cla.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CLASIFART On CALCPREC.CLASIHASTA = CLASIFART.CODIGO And  CLASIFART.CODIGO != ''                                                                                                                                                                    " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOMENCLADORARBA                         " atributo="DESCRIPCION                             " tabla="NMCARBA        " campo="NMCDES    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="150" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="461" etiqueta="Detalle Cód.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join NMCARBA On CALCPREC.NARBAHASTA = NMCARBA.NMCCOD And  NMCARBA.NMCCOD != ''                                                                                                                                                                          " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MARCA                                   " atributo="DESCRIPCION                             " tabla="MARCAS         " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="475" etiqueta="Detalle Mar.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join MARCAS On CALCPREC.MARCADESDE = MARCAS.Codigo And  MARCAS.CODIGO != ''                                                                                                                                                                             " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MARCA                                   " atributo="DESCRIPCION                             " tabla="MARCAS         " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="477" etiqueta="Detalle Mar.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join MARCAS On CALCPREC.MARCAHASTA = MARCAS.Codigo And  MARCAS.CODIGO != ''                                                                                                                                                                             " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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