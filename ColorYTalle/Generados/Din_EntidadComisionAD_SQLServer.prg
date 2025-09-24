
define class Din_EntidadCOMISIONAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_COMISION'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = []
	cExpresionCCPorCampos = []
	cTagClaveCandidata = ''
	cTagClavePk = '_COMPK'
	cTablaPrincipal = 'COMISION'
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
			local  lxComisionFecimpo, lxComisionFecexpo, lxComisionFectrans, lxComisionFaltafw, lxComisionBdaltafw, lxComisionBdmodifw, lxComisionEsttrans, lxComisionHaltafw, lxComisionValtafw, lxComisionZadsfw, lxComisionVmodifw, lxComisionUmodifw, lxComisionUaltafw, lxComisionHoraimpo, lxComisionSmodifw, lxComisionSaltafw, lxComisionHoraexpo, lxComisionTipagrupub, lxComisionCodigo, lxComisionFmodifw, lxComisionFechafd, lxComisionDescrip, lxComisionUnidesde, lxComisionArtdesde, lxComisionSucdesde, lxComisionSegsdesde, lxComisionTipsdesde, lxComisionLinsdesde, lxComisionFechah, lxComisionHmodifw, lxComisionArthasta, lxComisionUnihasta, lxComisionSegshasta, lxComisionSuchasta, lxComisionTipshasta, lxComisionLinshasta, lxComisionFamdesde, lxComisionColdesde, lxComisionPorcent, lxComisionConforma1, lxComisionColhasta, lxComisionFamhasta, lxComisionConforma2, lxComisionMontof, lxComisionTaldesde, lxComisionLindesde, lxComisionTalhasta, lxComisionLinhasta, lxComisionProvdesde, lxComisionCatdesde, lxComisionProvhasta, lxComisionCathasta, lxComisionTemdesde, lxComisionCladesde, lxComisionTemhasta, lxComisionClahasta, lxComisionAnodesde, lxComisionTipdesde, lxComisionAnohasta, lxComisionTiphasta, lxComisionMatdesde, lxComisionMathasta, lxComisionGrudesde, lxComisionGruhasta, lxComisionLisdesde, lxComisionMobs, lxComisionLishasta, lxComisionFpersond, lxComisionFpersonh, lxComisionClclasd, lxComisionClclash, lxComisionClcodfantd, lxComisionClcodfanth, lxComisionCltipoclid, lxComisionCltipoclih, lxComisionClcateclid, lxComisionClcateclih
				lxComisionFecimpo =  .Fechaimpo			lxComisionFecexpo =  .Fechaexpo			lxComisionFectrans =  .Fechatransferencia			lxComisionFaltafw =  .Fechaaltafw			lxComisionBdaltafw =  .Basededatosaltafw			lxComisionBdmodifw =  .Basededatosmodificacionfw			lxComisionEsttrans =  .Estadotransferencia			lxComisionHaltafw =  .Horaaltafw			lxComisionValtafw =  .Versionaltafw			lxComisionZadsfw =  .Zadsfw			lxComisionVmodifw =  .Versionmodificacionfw			lxComisionUmodifw =  .Usuariomodificacionfw			lxComisionUaltafw =  .Usuarioaltafw			lxComisionHoraimpo =  .Horaimpo			lxComisionSmodifw =  .Seriemodificacionfw			lxComisionSaltafw =  .Seriealtafw			lxComisionHoraexpo =  .Horaexpo			lxComisionTipagrupub =  .Tipoagrupamientopublicaciones			lxComisionCodigo =  .Codigo			lxComisionFmodifw =  .Fechamodificacionfw			lxComisionFechafd =  .Fechavigenciadesde			lxComisionDescrip =  .Descripcion			lxComisionUnidesde =  upper( .f_Articulo_UnidadDeMedida_Desde_PK ) 			lxComisionArtdesde =  upper( .f_Articulo_Desde_PK ) 			lxComisionSucdesde =  upper( .f_Sucursal_Codigo_desde_PK ) 			lxComisionSegsdesde =  upper( .f_Sucursal_Segmentacion_Desde_PK ) 			lxComisionTipsdesde =  upper( .f_Sucursal_Tipo_Desde_PK ) 			lxComisionLinsdesde =  upper( .f_Sucursal_Linea_Desde_PK ) 			lxComisionFechah =  .Fechavigenciahasta			lxComisionHmodifw =  .Horamodificacionfw			lxComisionArthasta =  upper( .f_Articulo_Hasta_PK ) 			lxComisionUnihasta =  upper( .f_Articulo_UnidadDeMedida_Hasta_PK ) 			lxComisionSegshasta =  upper( .f_Sucursal_Segmentacion_Hasta_PK ) 			lxComisionSuchasta =  upper( .f_Sucursal_Codigo_hasta_PK ) 			lxComisionTipshasta =  upper( .f_Sucursal_Tipo_Hasta_PK ) 			lxComisionLinshasta =  upper( .f_Sucursal_Linea_Hasta_PK ) 			lxComisionFamdesde =  upper( .f_Articulo_Familia_Desde_PK ) 			lxComisionColdesde =  upper( .f_Color_desde_PK ) 			lxComisionPorcent =  .Porcentaje			lxComisionConforma1 =  .Conformacion1			lxComisionColhasta =  upper( .f_Color_hasta_PK ) 			lxComisionFamhasta =  upper( .f_Articulo_Familia_Hasta_PK ) 			lxComisionConforma2 =  .Conformacion2			lxComisionMontof =  .Montofijo			lxComisionTaldesde =  upper( .f_Talle_Desde_PK ) 			lxComisionLindesde =  upper( .f_Articulo_Linea_Desde_PK ) 			lxComisionTalhasta =  upper( .f_Talle_Hasta_PK ) 			lxComisionLinhasta =  upper( .f_Articulo_Linea_Hasta_PK ) 			lxComisionProvdesde =  upper( .f_Articulo_Proveedor_Desde_PK ) 			lxComisionCatdesde =  upper( .f_Articulo_CategoriaDeArticulo_Desde_PK ) 			lxComisionProvhasta =  upper( .f_Articulo_Proveedor_Hasta_PK ) 			lxComisionCathasta =  upper( .f_Articulo_CategoriaDeArticulo_Hasta_PK ) 			lxComisionTemdesde =  upper( .f_Articulo_Temporada_Desde_PK ) 			lxComisionCladesde =  upper( .f_Articulo_Clasificacion_Desde_PK ) 			lxComisionTemhasta =  upper( .f_Articulo_Temporada_Hasta_PK ) 			lxComisionClahasta =  upper( .f_Articulo_Clasificacion_Hasta_PK ) 			lxComisionAnodesde =  .F_articulo_ano_desde			lxComisionTipdesde =  upper( .f_Articulo_TipodeArticulo_Desde_PK ) 			lxComisionAnohasta =  .F_articulo_ano_hasta			lxComisionTiphasta =  upper( .f_Articulo_TipodeArticulo_Hasta_PK ) 			lxComisionMatdesde =  upper( .f_Articulo_Material_Desde_PK ) 			lxComisionMathasta =  upper( .f_Articulo_Material_Hasta_PK ) 			lxComisionGrudesde =  upper( .f_Articulo_Grupo_Desde_PK ) 			lxComisionGruhasta =  upper( .f_Articulo_Grupo_Hasta_PK ) 			lxComisionLisdesde =  upper( .f_ListaDePrecio_Codigo_Desde_PK ) 			lxComisionMobs =  .Observacion			lxComisionLishasta =  upper( .f_ListaDePrecio_Codigo_Hasta_PK ) 			lxComisionFpersond =  upper( .f_Cliente_Desde_PK ) 			lxComisionFpersonh =  upper( .f_Cliente_Hasta_PK ) 			lxComisionClclasd =  upper( .f_Cliente_Clasificacion_Desde_PK ) 			lxComisionClclash =  upper( .f_Cliente_Clasificacion_Hasta_PK ) 			lxComisionClcodfantd =  upper( .f_Cliente_NFantasia_Desde_PK ) 			lxComisionClcodfanth =  upper( .f_Cliente_NFantasia_Hasta_PK ) 			lxComisionCltipoclid =  upper( .f_Cliente_Tipo_Desde_PK ) 			lxComisionCltipoclih =  upper( .f_Cliente_Tipo_Hasta_PK ) 			lxComisionClcateclid =  upper( .f_Cliente_Categoria_Desde_PK ) 			lxComisionClcateclih =  upper( .f_Cliente_Categoria_Hasta_PK ) 
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxComisionCodigo = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.COMISION ( "Fecimpo","Fecexpo","Fectrans","Faltafw","Bdaltafw","Bdmodifw","Esttrans","Haltafw","Valtafw","Zadsfw","Vmodifw","Umodifw","Ualtafw","Horaimpo","Smodifw","Saltafw","Horaexpo","Tipagrupub","Codigo","Fmodifw","Fechafd","Descrip","Unidesde","Artdesde","Sucdesde","Segsdesde","Tipsdesde","Linsdesde","Fechah","Hmodifw","Arthasta","Unihasta","Segshasta","Suchasta","Tipshasta","Linshasta","Famdesde","Coldesde","Porcent","Conforma1","Colhasta","Famhasta","Conforma2","Montof","Taldesde","Lindesde","Talhasta","Linhasta","Provdesde","Catdesde","Provhasta","Cathasta","Temdesde","Cladesde","Temhasta","Clahasta","Anodesde","Tipdesde","Anohasta","Tiphasta","Matdesde","Mathasta","Grudesde","Gruhasta","Lisdesde","Mobs","Lishasta","Fpersond","Fpersonh","Clclasd","Clclash","Clcodfantd","Clcodfanth","Cltipoclid","Cltipoclih","Clcateclid","Clcateclih" ) values ( <<"'" + this.ConvertirDateSql( lxComisionFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxComisionFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxComisionFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxComisionFaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionHoraexpo ) + "'" >>, <<lxComisionTipagrupub >>, <<"'" + this.FormatearTextoSql( lxComisionCodigo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxComisionFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxComisionFechafd ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionDescrip ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionUnidesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionArtdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionSucdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionSegsdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionTipsdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionLinsdesde ) + "'" >>, <<"'" + this.ConvertirDateSql( lxComisionFechah ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionArthasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionUnihasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionSegshasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionSuchasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionTipshasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionLinshasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionFamdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionColdesde ) + "'" >>, <<lxComisionPorcent >>, <<"'" + this.FormatearTextoSql( lxComisionConforma1 ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionColhasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionFamhasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionConforma2 ) + "'" >>, <<lxComisionMontof >>, <<"'" + this.FormatearTextoSql( lxComisionTaldesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionLindesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionTalhasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionLinhasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionProvdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionCatdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionProvhasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionCathasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionTemdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionCladesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionTemhasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionClahasta ) + "'" >>, <<lxComisionAnodesde >>, <<"'" + this.FormatearTextoSql( lxComisionTipdesde ) + "'" >>, <<lxComisionAnohasta >>, <<"'" + this.FormatearTextoSql( lxComisionTiphasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionMatdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionMathasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionGrudesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionGruhasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionLisdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionMobs ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionLishasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionFpersond ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionFpersonh ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionClclasd ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionClclash ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionClcodfantd ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionClcodfanth ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionCltipoclid ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionCltipoclih ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionClcateclid ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionClcateclih ) + "'" >> )
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
						Insert into ZooLogic.AgruPubCOM("NROITEM","Codigo","Agrup","AgrupDes" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxAgrupamiento_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxAgrupamientodetalle ) + "'">> ) 
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
			local  lxComisionFecimpo, lxComisionFecexpo, lxComisionFectrans, lxComisionFaltafw, lxComisionBdaltafw, lxComisionBdmodifw, lxComisionEsttrans, lxComisionHaltafw, lxComisionValtafw, lxComisionZadsfw, lxComisionVmodifw, lxComisionUmodifw, lxComisionUaltafw, lxComisionHoraimpo, lxComisionSmodifw, lxComisionSaltafw, lxComisionHoraexpo, lxComisionTipagrupub, lxComisionCodigo, lxComisionFmodifw, lxComisionFechafd, lxComisionDescrip, lxComisionUnidesde, lxComisionArtdesde, lxComisionSucdesde, lxComisionSegsdesde, lxComisionTipsdesde, lxComisionLinsdesde, lxComisionFechah, lxComisionHmodifw, lxComisionArthasta, lxComisionUnihasta, lxComisionSegshasta, lxComisionSuchasta, lxComisionTipshasta, lxComisionLinshasta, lxComisionFamdesde, lxComisionColdesde, lxComisionPorcent, lxComisionConforma1, lxComisionColhasta, lxComisionFamhasta, lxComisionConforma2, lxComisionMontof, lxComisionTaldesde, lxComisionLindesde, lxComisionTalhasta, lxComisionLinhasta, lxComisionProvdesde, lxComisionCatdesde, lxComisionProvhasta, lxComisionCathasta, lxComisionTemdesde, lxComisionCladesde, lxComisionTemhasta, lxComisionClahasta, lxComisionAnodesde, lxComisionTipdesde, lxComisionAnohasta, lxComisionTiphasta, lxComisionMatdesde, lxComisionMathasta, lxComisionGrudesde, lxComisionGruhasta, lxComisionLisdesde, lxComisionMobs, lxComisionLishasta, lxComisionFpersond, lxComisionFpersonh, lxComisionClclasd, lxComisionClclash, lxComisionClcodfantd, lxComisionClcodfanth, lxComisionCltipoclid, lxComisionCltipoclih, lxComisionClcateclid, lxComisionClcateclih
				lxComisionFecimpo =  .Fechaimpo			lxComisionFecexpo =  .Fechaexpo			lxComisionFectrans =  .Fechatransferencia			lxComisionFaltafw =  .Fechaaltafw			lxComisionBdaltafw =  .Basededatosaltafw			lxComisionBdmodifw =  .Basededatosmodificacionfw			lxComisionEsttrans =  .Estadotransferencia			lxComisionHaltafw =  .Horaaltafw			lxComisionValtafw =  .Versionaltafw			lxComisionZadsfw =  .Zadsfw			lxComisionVmodifw =  .Versionmodificacionfw			lxComisionUmodifw =  .Usuariomodificacionfw			lxComisionUaltafw =  .Usuarioaltafw			lxComisionHoraimpo =  .Horaimpo			lxComisionSmodifw =  .Seriemodificacionfw			lxComisionSaltafw =  .Seriealtafw			lxComisionHoraexpo =  .Horaexpo			lxComisionTipagrupub =  .Tipoagrupamientopublicaciones			lxComisionCodigo =  .Codigo			lxComisionFmodifw =  .Fechamodificacionfw			lxComisionFechafd =  .Fechavigenciadesde			lxComisionDescrip =  .Descripcion			lxComisionUnidesde =  upper( .f_Articulo_UnidadDeMedida_Desde_PK ) 			lxComisionArtdesde =  upper( .f_Articulo_Desde_PK ) 			lxComisionSucdesde =  upper( .f_Sucursal_Codigo_desde_PK ) 			lxComisionSegsdesde =  upper( .f_Sucursal_Segmentacion_Desde_PK ) 			lxComisionTipsdesde =  upper( .f_Sucursal_Tipo_Desde_PK ) 			lxComisionLinsdesde =  upper( .f_Sucursal_Linea_Desde_PK ) 			lxComisionFechah =  .Fechavigenciahasta			lxComisionHmodifw =  .Horamodificacionfw			lxComisionArthasta =  upper( .f_Articulo_Hasta_PK ) 			lxComisionUnihasta =  upper( .f_Articulo_UnidadDeMedida_Hasta_PK ) 			lxComisionSegshasta =  upper( .f_Sucursal_Segmentacion_Hasta_PK ) 			lxComisionSuchasta =  upper( .f_Sucursal_Codigo_hasta_PK ) 			lxComisionTipshasta =  upper( .f_Sucursal_Tipo_Hasta_PK ) 			lxComisionLinshasta =  upper( .f_Sucursal_Linea_Hasta_PK ) 			lxComisionFamdesde =  upper( .f_Articulo_Familia_Desde_PK ) 			lxComisionColdesde =  upper( .f_Color_desde_PK ) 			lxComisionPorcent =  .Porcentaje			lxComisionConforma1 =  .Conformacion1			lxComisionColhasta =  upper( .f_Color_hasta_PK ) 			lxComisionFamhasta =  upper( .f_Articulo_Familia_Hasta_PK ) 			lxComisionConforma2 =  .Conformacion2			lxComisionMontof =  .Montofijo			lxComisionTaldesde =  upper( .f_Talle_Desde_PK ) 			lxComisionLindesde =  upper( .f_Articulo_Linea_Desde_PK ) 			lxComisionTalhasta =  upper( .f_Talle_Hasta_PK ) 			lxComisionLinhasta =  upper( .f_Articulo_Linea_Hasta_PK ) 			lxComisionProvdesde =  upper( .f_Articulo_Proveedor_Desde_PK ) 			lxComisionCatdesde =  upper( .f_Articulo_CategoriaDeArticulo_Desde_PK ) 			lxComisionProvhasta =  upper( .f_Articulo_Proveedor_Hasta_PK ) 			lxComisionCathasta =  upper( .f_Articulo_CategoriaDeArticulo_Hasta_PK ) 			lxComisionTemdesde =  upper( .f_Articulo_Temporada_Desde_PK ) 			lxComisionCladesde =  upper( .f_Articulo_Clasificacion_Desde_PK ) 			lxComisionTemhasta =  upper( .f_Articulo_Temporada_Hasta_PK ) 			lxComisionClahasta =  upper( .f_Articulo_Clasificacion_Hasta_PK ) 			lxComisionAnodesde =  .F_articulo_ano_desde			lxComisionTipdesde =  upper( .f_Articulo_TipodeArticulo_Desde_PK ) 			lxComisionAnohasta =  .F_articulo_ano_hasta			lxComisionTiphasta =  upper( .f_Articulo_TipodeArticulo_Hasta_PK ) 			lxComisionMatdesde =  upper( .f_Articulo_Material_Desde_PK ) 			lxComisionMathasta =  upper( .f_Articulo_Material_Hasta_PK ) 			lxComisionGrudesde =  upper( .f_Articulo_Grupo_Desde_PK ) 			lxComisionGruhasta =  upper( .f_Articulo_Grupo_Hasta_PK ) 			lxComisionLisdesde =  upper( .f_ListaDePrecio_Codigo_Desde_PK ) 			lxComisionMobs =  .Observacion			lxComisionLishasta =  upper( .f_ListaDePrecio_Codigo_Hasta_PK ) 			lxComisionFpersond =  upper( .f_Cliente_Desde_PK ) 			lxComisionFpersonh =  upper( .f_Cliente_Hasta_PK ) 			lxComisionClclasd =  upper( .f_Cliente_Clasificacion_Desde_PK ) 			lxComisionClclash =  upper( .f_Cliente_Clasificacion_Hasta_PK ) 			lxComisionClcodfantd =  upper( .f_Cliente_NFantasia_Desde_PK ) 			lxComisionClcodfanth =  upper( .f_Cliente_NFantasia_Hasta_PK ) 			lxComisionCltipoclid =  upper( .f_Cliente_Tipo_Desde_PK ) 			lxComisionCltipoclih =  upper( .f_Cliente_Tipo_Hasta_PK ) 			lxComisionClcateclid =  upper( .f_Cliente_Categoria_Desde_PK ) 			lxComisionClcateclih =  upper( .f_Cliente_Categoria_Hasta_PK ) 
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()
			lxValorClavePrimaria = .oEntidad.CODIGO
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ZooLogic.COMISION set "Fecimpo" = <<"'" + this.ConvertirDateSql( lxComisionFecimpo ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxComisionFecexpo ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxComisionFectrans ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxComisionFaltafw ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxComisionBdaltafw ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxComisionBdmodifw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxComisionEsttrans ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxComisionHaltafw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxComisionValtafw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxComisionZadsfw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxComisionVmodifw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxComisionUmodifw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxComisionUaltafw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxComisionHoraimpo ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxComisionSmodifw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxComisionSaltafw ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxComisionHoraexpo ) + "'">>,"Tipagrupub" = <<lxComisionTipagrupub>>,"Codigo" = <<"'" + this.FormatearTextoSql( lxComisionCodigo ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxComisionFmodifw ) + "'">>,"Fechafd" = <<"'" + this.ConvertirDateSql( lxComisionFechafd ) + "'">>,"Descrip" = <<"'" + this.FormatearTextoSql( lxComisionDescrip ) + "'">>,"Unidesde" = <<"'" + this.FormatearTextoSql( lxComisionUnidesde ) + "'">>,"Artdesde" = <<"'" + this.FormatearTextoSql( lxComisionArtdesde ) + "'">>,"Sucdesde" = <<"'" + this.FormatearTextoSql( lxComisionSucdesde ) + "'">>,"Segsdesde" = <<"'" + this.FormatearTextoSql( lxComisionSegsdesde ) + "'">>,"Tipsdesde" = <<"'" + this.FormatearTextoSql( lxComisionTipsdesde ) + "'">>,"Linsdesde" = <<"'" + this.FormatearTextoSql( lxComisionLinsdesde ) + "'">>,"Fechah" = <<"'" + this.ConvertirDateSql( lxComisionFechah ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxComisionHmodifw ) + "'">>,"Arthasta" = <<"'" + this.FormatearTextoSql( lxComisionArthasta ) + "'">>,"Unihasta" = <<"'" + this.FormatearTextoSql( lxComisionUnihasta ) + "'">>,"Segshasta" = <<"'" + this.FormatearTextoSql( lxComisionSegshasta ) + "'">>,"Suchasta" = <<"'" + this.FormatearTextoSql( lxComisionSuchasta ) + "'">>,"Tipshasta" = <<"'" + this.FormatearTextoSql( lxComisionTipshasta ) + "'">>,"Linshasta" = <<"'" + this.FormatearTextoSql( lxComisionLinshasta ) + "'">>,"Famdesde" = <<"'" + this.FormatearTextoSql( lxComisionFamdesde ) + "'">>,"Coldesde" = <<"'" + this.FormatearTextoSql( lxComisionColdesde ) + "'">>,"Porcent" = <<lxComisionPorcent>>,"Conforma1" = <<"'" + this.FormatearTextoSql( lxComisionConforma1 ) + "'">>,"Colhasta" = <<"'" + this.FormatearTextoSql( lxComisionColhasta ) + "'">>,"Famhasta" = <<"'" + this.FormatearTextoSql( lxComisionFamhasta ) + "'">>,"Conforma2" = <<"'" + this.FormatearTextoSql( lxComisionConforma2 ) + "'">>,"Montof" = <<lxComisionMontof>>,"Taldesde" = <<"'" + this.FormatearTextoSql( lxComisionTaldesde ) + "'">>,"Lindesde" = <<"'" + this.FormatearTextoSql( lxComisionLindesde ) + "'">>,"Talhasta" = <<"'" + this.FormatearTextoSql( lxComisionTalhasta ) + "'">>,"Linhasta" = <<"'" + this.FormatearTextoSql( lxComisionLinhasta ) + "'">>,"Provdesde" = <<"'" + this.FormatearTextoSql( lxComisionProvdesde ) + "'">>,"Catdesde" = <<"'" + this.FormatearTextoSql( lxComisionCatdesde ) + "'">>,"Provhasta" = <<"'" + this.FormatearTextoSql( lxComisionProvhasta ) + "'">>,"Cathasta" = <<"'" + this.FormatearTextoSql( lxComisionCathasta ) + "'">>,"Temdesde" = <<"'" + this.FormatearTextoSql( lxComisionTemdesde ) + "'">>,"Cladesde" = <<"'" + this.FormatearTextoSql( lxComisionCladesde ) + "'">>,"Temhasta" = <<"'" + this.FormatearTextoSql( lxComisionTemhasta ) + "'">>,"Clahasta" = <<"'" + this.FormatearTextoSql( lxComisionClahasta ) + "'">>,"Anodesde" = <<lxComisionAnodesde>>,"Tipdesde" = <<"'" + this.FormatearTextoSql( lxComisionTipdesde ) + "'">>,"Anohasta" = <<lxComisionAnohasta>>,"Tiphasta" = <<"'" + this.FormatearTextoSql( lxComisionTiphasta ) + "'">>,"Matdesde" = <<"'" + this.FormatearTextoSql( lxComisionMatdesde ) + "'">>,"Mathasta" = <<"'" + this.FormatearTextoSql( lxComisionMathasta ) + "'">>,"Grudesde" = <<"'" + this.FormatearTextoSql( lxComisionGrudesde ) + "'">>,"Gruhasta" = <<"'" + this.FormatearTextoSql( lxComisionGruhasta ) + "'">>,"Lisdesde" = <<"'" + this.FormatearTextoSql( lxComisionLisdesde ) + "'">>,"Mobs" = <<"'" + this.FormatearTextoSql( lxComisionMobs ) + "'">>,"Lishasta" = <<"'" + this.FormatearTextoSql( lxComisionLishasta ) + "'">>,"Fpersond" = <<"'" + this.FormatearTextoSql( lxComisionFpersond ) + "'">>,"Fpersonh" = <<"'" + this.FormatearTextoSql( lxComisionFpersonh ) + "'">>,"Clclasd" = <<"'" + this.FormatearTextoSql( lxComisionClclasd ) + "'">>,"Clclash" = <<"'" + this.FormatearTextoSql( lxComisionClclash ) + "'">>,"Clcodfantd" = <<"'" + this.FormatearTextoSql( lxComisionClcodfantd ) + "'">>,"Clcodfanth" = <<"'" + this.FormatearTextoSql( lxComisionClcodfanth ) + "'">>,"Cltipoclid" = <<"'" + this.FormatearTextoSql( lxComisionCltipoclid ) + "'">>,"Cltipoclih" = <<"'" + this.FormatearTextoSql( lxComisionCltipoclih ) + "'">>,"Clcateclid" = <<"'" + this.FormatearTextoSql( lxComisionClcateclid ) + "'">>,"Clcateclih" = <<"'" + this.FormatearTextoSql( lxComisionClcateclih ) + "'">> where "Codigo" = <<"'" + this.FormatearTextoSql( lxComisionCodigo ) + "'">> and  COMISION.CODIGO != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			this.ComprobarResultadoDeEjecucionDelUpdate()
		this.ComprobarTransaccion()
			this.oConexion.EjecutarSql( 'delete from ZooLogic.AgruPubCOM where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.AgruPubliDetalle
				if this.oEntidad.AgruPubliDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxAgrupamiento_PK = loItem.Agrupamiento_PK
					lxAgrupamientodetalle = loItem.Agrupamientodetalle
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.AgruPubCOM("NROITEM","Codigo","Agrup","AgrupDes" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxAgrupamiento_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxAgrupamientodetalle ) + "'">> ) 
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
		endwith

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function HayDatos() as boolean
		local llhaydatos as boolean, lcXml as String
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 CODIGO from ZooLogic.COMISION where " + this.ConvertirFuncionesSql( " COMISION.CODIGO != ''" ) )
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
			Local lxComisionCodigo
			lxComisionCodigo = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Horaimpo" as "Horaimpo", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Horaexpo" as "Horaexpo", "Tipagrupub" as "Tipoagrupamientopublicaciones", "Codigo" as "Codigo", "Fmodifw" as "Fechamodificacionfw", "Fechafd" as "Fechavigenciadesde", "Descrip" as "Descripcion", "Unidesde" as "F_articulo_unidaddemedida_desde", "Artdesde" as "F_articulo_desde", "Sucdesde" as "F_sucursal_codigo_desde", "Segsdesde" as "F_sucursal_segmentacion_desde", "Tipsdesde" as "F_sucursal_tipo_desde", "Linsdesde" as "F_sucursal_linea_desde", "Fechah" as "Fechavigenciahasta", "Hmodifw" as "Horamodificacionfw", "Arthasta" as "F_articulo_hasta", "Unihasta" as "F_articulo_unidaddemedida_hasta", "Segshasta" as "F_sucursal_segmentacion_hasta", "Suchasta" as "F_sucursal_codigo_hasta", "Tipshasta" as "F_sucursal_tipo_hasta", "Linshasta" as "F_sucursal_linea_hasta", "Famdesde" as "F_articulo_familia_desde", "Coldesde" as "F_color_desde", "Porcent" as "Porcentaje", "Conforma1" as "Conformacion1", "Colhasta" as "F_color_hasta", "Famhasta" as "F_articulo_familia_hasta", "Conforma2" as "Conformacion2", "Montof" as "Montofijo", "Taldesde" as "F_talle_desde", "Lindesde" as "F_articulo_linea_desde", "Talhasta" as "F_talle_hasta", "Linhasta" as "F_articulo_linea_hasta", "Provdesde" as "F_articulo_proveedor_desde", "Catdesde" as "F_articulo_categoriadearticulo_desde", "Provhasta" as "F_articulo_proveedor_hasta", "Cathasta" as "F_articulo_categoriadearticulo_hasta", "Temdesde" as "F_articulo_temporada_desde", "Cladesde" as "F_articulo_clasificacion_desde", "Temhasta" as "F_articulo_temporada_hasta", "Clahasta" as "F_articulo_clasificacion_hasta", "Anodesde" as "F_articulo_ano_desde", "Tipdesde" as "F_articulo_tipodearticulo_desde", "Anohasta" as "F_articulo_ano_hasta", "Tiphasta" as "F_articulo_tipodearticulo_hasta", "Matdesde" as "F_articulo_material_desde", "Mathasta" as "F_articulo_material_hasta", "Grudesde" as "F_articulo_grupo_desde", "Gruhasta" as "F_articulo_grupo_hasta", "Lisdesde" as "F_listadeprecio_codigo_desde", "Mobs" as "Observacion", "Lishasta" as "F_listadeprecio_codigo_hasta", "Fpersond" as "F_cliente_desde", "Fpersonh" as "F_cliente_hasta", "Clclasd" as "F_cliente_clasificacion_desde", "Clclash" as "F_cliente_clasificacion_hasta", "Clcodfantd" as "F_cliente_nfantasia_desde", "Clcodfanth" as "F_cliente_nfantasia_hasta", "Cltipoclid" as "F_cliente_tipo_desde", "Cltipoclih" as "F_cliente_tipo_hasta", "Clcateclid" as "F_cliente_categoria_desde", "Clcateclih" as "F_cliente_categoria_hasta" from ZooLogic.COMISION where "Codigo" = <<"'" + this.FormatearTextoSql( lxComisionCodigo ) + "'">> and  COMISION.CODIGO != ''
			endtext
			use in select('c_COMISION')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMISION', set( 'Datasession' ) )

			if reccount( 'c_COMISION' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Agrup" as "Agrupamiento", "Agrupdes" as "Agrupamientodetalle" from ZooLogic.AgruPubCOM where Codigo = <<"'" + this.FormatearTextoSql( c_COMISION.CODIGO ) + "'">> Order by NroItem
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
		local llRetorno as boolean,lxComisionCodigo as Variant
		llRetorno = .t.
		lxComisionCodigo = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.COMISION where "Codigo" = <<"'" + this.FormatearTextoSql( lxComisionCodigo ) + "'">> and  COMISION.CODIGO != ''
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
				select top 1 "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Horaimpo" as "Horaimpo", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Horaexpo" as "Horaexpo", "Tipagrupub" as "Tipoagrupamientopublicaciones", "Codigo" as "Codigo", "Fmodifw" as "Fechamodificacionfw", "Fechafd" as "Fechavigenciadesde", "Descrip" as "Descripcion", "Unidesde" as "F_articulo_unidaddemedida_desde", "Artdesde" as "F_articulo_desde", "Sucdesde" as "F_sucursal_codigo_desde", "Segsdesde" as "F_sucursal_segmentacion_desde", "Tipsdesde" as "F_sucursal_tipo_desde", "Linsdesde" as "F_sucursal_linea_desde", "Fechah" as "Fechavigenciahasta", "Hmodifw" as "Horamodificacionfw", "Arthasta" as "F_articulo_hasta", "Unihasta" as "F_articulo_unidaddemedida_hasta", "Segshasta" as "F_sucursal_segmentacion_hasta", "Suchasta" as "F_sucursal_codigo_hasta", "Tipshasta" as "F_sucursal_tipo_hasta", "Linshasta" as "F_sucursal_linea_hasta", "Famdesde" as "F_articulo_familia_desde", "Coldesde" as "F_color_desde", "Porcent" as "Porcentaje", "Conforma1" as "Conformacion1", "Colhasta" as "F_color_hasta", "Famhasta" as "F_articulo_familia_hasta", "Conforma2" as "Conformacion2", "Montof" as "Montofijo", "Taldesde" as "F_talle_desde", "Lindesde" as "F_articulo_linea_desde", "Talhasta" as "F_talle_hasta", "Linhasta" as "F_articulo_linea_hasta", "Provdesde" as "F_articulo_proveedor_desde", "Catdesde" as "F_articulo_categoriadearticulo_desde", "Provhasta" as "F_articulo_proveedor_hasta", "Cathasta" as "F_articulo_categoriadearticulo_hasta", "Temdesde" as "F_articulo_temporada_desde", "Cladesde" as "F_articulo_clasificacion_desde", "Temhasta" as "F_articulo_temporada_hasta", "Clahasta" as "F_articulo_clasificacion_hasta", "Anodesde" as "F_articulo_ano_desde", "Tipdesde" as "F_articulo_tipodearticulo_desde", "Anohasta" as "F_articulo_ano_hasta", "Tiphasta" as "F_articulo_tipodearticulo_hasta", "Matdesde" as "F_articulo_material_desde", "Mathasta" as "F_articulo_material_hasta", "Grudesde" as "F_articulo_grupo_desde", "Gruhasta" as "F_articulo_grupo_hasta", "Lisdesde" as "F_listadeprecio_codigo_desde", "Mobs" as "Observacion", "Lishasta" as "F_listadeprecio_codigo_hasta", "Fpersond" as "F_cliente_desde", "Fpersonh" as "F_cliente_hasta", "Clclasd" as "F_cliente_clasificacion_desde", "Clclash" as "F_cliente_clasificacion_hasta", "Clcodfantd" as "F_cliente_nfantasia_desde", "Clcodfanth" as "F_cliente_nfantasia_hasta", "Cltipoclid" as "F_cliente_tipo_desde", "Cltipoclih" as "F_cliente_tipo_hasta", "Clcateclid" as "F_cliente_categoria_desde", "Clcateclih" as "F_cliente_categoria_hasta" from ZooLogic.COMISION where  COMISION.CODIGO != '' order by CODIGO
			endtext
			use in select('c_COMISION')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMISION', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Agrup" as "Agrupamiento", "Agrupdes" as "Agrupamientodetalle" from ZooLogic.AgruPubCOM where Codigo = <<"'" + this.FormatearTextoSql( c_COMISION.CODIGO ) + "'">> Order by NroItem
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
				select top 1 "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Horaimpo" as "Horaimpo", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Horaexpo" as "Horaexpo", "Tipagrupub" as "Tipoagrupamientopublicaciones", "Codigo" as "Codigo", "Fmodifw" as "Fechamodificacionfw", "Fechafd" as "Fechavigenciadesde", "Descrip" as "Descripcion", "Unidesde" as "F_articulo_unidaddemedida_desde", "Artdesde" as "F_articulo_desde", "Sucdesde" as "F_sucursal_codigo_desde", "Segsdesde" as "F_sucursal_segmentacion_desde", "Tipsdesde" as "F_sucursal_tipo_desde", "Linsdesde" as "F_sucursal_linea_desde", "Fechah" as "Fechavigenciahasta", "Hmodifw" as "Horamodificacionfw", "Arthasta" as "F_articulo_hasta", "Unihasta" as "F_articulo_unidaddemedida_hasta", "Segshasta" as "F_sucursal_segmentacion_hasta", "Suchasta" as "F_sucursal_codigo_hasta", "Tipshasta" as "F_sucursal_tipo_hasta", "Linshasta" as "F_sucursal_linea_hasta", "Famdesde" as "F_articulo_familia_desde", "Coldesde" as "F_color_desde", "Porcent" as "Porcentaje", "Conforma1" as "Conformacion1", "Colhasta" as "F_color_hasta", "Famhasta" as "F_articulo_familia_hasta", "Conforma2" as "Conformacion2", "Montof" as "Montofijo", "Taldesde" as "F_talle_desde", "Lindesde" as "F_articulo_linea_desde", "Talhasta" as "F_talle_hasta", "Linhasta" as "F_articulo_linea_hasta", "Provdesde" as "F_articulo_proveedor_desde", "Catdesde" as "F_articulo_categoriadearticulo_desde", "Provhasta" as "F_articulo_proveedor_hasta", "Cathasta" as "F_articulo_categoriadearticulo_hasta", "Temdesde" as "F_articulo_temporada_desde", "Cladesde" as "F_articulo_clasificacion_desde", "Temhasta" as "F_articulo_temporada_hasta", "Clahasta" as "F_articulo_clasificacion_hasta", "Anodesde" as "F_articulo_ano_desde", "Tipdesde" as "F_articulo_tipodearticulo_desde", "Anohasta" as "F_articulo_ano_hasta", "Tiphasta" as "F_articulo_tipodearticulo_hasta", "Matdesde" as "F_articulo_material_desde", "Mathasta" as "F_articulo_material_hasta", "Grudesde" as "F_articulo_grupo_desde", "Gruhasta" as "F_articulo_grupo_hasta", "Lisdesde" as "F_listadeprecio_codigo_desde", "Mobs" as "Observacion", "Lishasta" as "F_listadeprecio_codigo_hasta", "Fpersond" as "F_cliente_desde", "Fpersonh" as "F_cliente_hasta", "Clclasd" as "F_cliente_clasificacion_desde", "Clclash" as "F_cliente_clasificacion_hasta", "Clcodfantd" as "F_cliente_nfantasia_desde", "Clcodfanth" as "F_cliente_nfantasia_hasta", "Cltipoclid" as "F_cliente_tipo_desde", "Cltipoclih" as "F_cliente_tipo_hasta", "Clcateclid" as "F_cliente_categoria_desde", "Clcateclih" as "F_cliente_categoria_hasta" from ZooLogic.COMISION where  funciones.padr( CODIGO, 10, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  COMISION.CODIGO != '' order by CODIGO
			endtext
			use in select('c_COMISION')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMISION', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Agrup" as "Agrupamiento", "Agrupdes" as "Agrupamientodetalle" from ZooLogic.AgruPubCOM where Codigo = <<"'" + this.FormatearTextoSql( c_COMISION.CODIGO ) + "'">> Order by NroItem
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
				select top 1 "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Horaimpo" as "Horaimpo", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Horaexpo" as "Horaexpo", "Tipagrupub" as "Tipoagrupamientopublicaciones", "Codigo" as "Codigo", "Fmodifw" as "Fechamodificacionfw", "Fechafd" as "Fechavigenciadesde", "Descrip" as "Descripcion", "Unidesde" as "F_articulo_unidaddemedida_desde", "Artdesde" as "F_articulo_desde", "Sucdesde" as "F_sucursal_codigo_desde", "Segsdesde" as "F_sucursal_segmentacion_desde", "Tipsdesde" as "F_sucursal_tipo_desde", "Linsdesde" as "F_sucursal_linea_desde", "Fechah" as "Fechavigenciahasta", "Hmodifw" as "Horamodificacionfw", "Arthasta" as "F_articulo_hasta", "Unihasta" as "F_articulo_unidaddemedida_hasta", "Segshasta" as "F_sucursal_segmentacion_hasta", "Suchasta" as "F_sucursal_codigo_hasta", "Tipshasta" as "F_sucursal_tipo_hasta", "Linshasta" as "F_sucursal_linea_hasta", "Famdesde" as "F_articulo_familia_desde", "Coldesde" as "F_color_desde", "Porcent" as "Porcentaje", "Conforma1" as "Conformacion1", "Colhasta" as "F_color_hasta", "Famhasta" as "F_articulo_familia_hasta", "Conforma2" as "Conformacion2", "Montof" as "Montofijo", "Taldesde" as "F_talle_desde", "Lindesde" as "F_articulo_linea_desde", "Talhasta" as "F_talle_hasta", "Linhasta" as "F_articulo_linea_hasta", "Provdesde" as "F_articulo_proveedor_desde", "Catdesde" as "F_articulo_categoriadearticulo_desde", "Provhasta" as "F_articulo_proveedor_hasta", "Cathasta" as "F_articulo_categoriadearticulo_hasta", "Temdesde" as "F_articulo_temporada_desde", "Cladesde" as "F_articulo_clasificacion_desde", "Temhasta" as "F_articulo_temporada_hasta", "Clahasta" as "F_articulo_clasificacion_hasta", "Anodesde" as "F_articulo_ano_desde", "Tipdesde" as "F_articulo_tipodearticulo_desde", "Anohasta" as "F_articulo_ano_hasta", "Tiphasta" as "F_articulo_tipodearticulo_hasta", "Matdesde" as "F_articulo_material_desde", "Mathasta" as "F_articulo_material_hasta", "Grudesde" as "F_articulo_grupo_desde", "Gruhasta" as "F_articulo_grupo_hasta", "Lisdesde" as "F_listadeprecio_codigo_desde", "Mobs" as "Observacion", "Lishasta" as "F_listadeprecio_codigo_hasta", "Fpersond" as "F_cliente_desde", "Fpersonh" as "F_cliente_hasta", "Clclasd" as "F_cliente_clasificacion_desde", "Clclash" as "F_cliente_clasificacion_hasta", "Clcodfantd" as "F_cliente_nfantasia_desde", "Clcodfanth" as "F_cliente_nfantasia_hasta", "Cltipoclid" as "F_cliente_tipo_desde", "Cltipoclih" as "F_cliente_tipo_hasta", "Clcateclid" as "F_cliente_categoria_desde", "Clcateclih" as "F_cliente_categoria_hasta" from ZooLogic.COMISION where  funciones.padr( CODIGO, 10, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  COMISION.CODIGO != '' order by CODIGO desc
			endtext
			use in select('c_COMISION')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMISION', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Agrup" as "Agrupamiento", "Agrupdes" as "Agrupamientodetalle" from ZooLogic.AgruPubCOM where Codigo = <<"'" + this.FormatearTextoSql( c_COMISION.CODIGO ) + "'">> Order by NroItem
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
				select top 1 "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Horaimpo" as "Horaimpo", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Horaexpo" as "Horaexpo", "Tipagrupub" as "Tipoagrupamientopublicaciones", "Codigo" as "Codigo", "Fmodifw" as "Fechamodificacionfw", "Fechafd" as "Fechavigenciadesde", "Descrip" as "Descripcion", "Unidesde" as "F_articulo_unidaddemedida_desde", "Artdesde" as "F_articulo_desde", "Sucdesde" as "F_sucursal_codigo_desde", "Segsdesde" as "F_sucursal_segmentacion_desde", "Tipsdesde" as "F_sucursal_tipo_desde", "Linsdesde" as "F_sucursal_linea_desde", "Fechah" as "Fechavigenciahasta", "Hmodifw" as "Horamodificacionfw", "Arthasta" as "F_articulo_hasta", "Unihasta" as "F_articulo_unidaddemedida_hasta", "Segshasta" as "F_sucursal_segmentacion_hasta", "Suchasta" as "F_sucursal_codigo_hasta", "Tipshasta" as "F_sucursal_tipo_hasta", "Linshasta" as "F_sucursal_linea_hasta", "Famdesde" as "F_articulo_familia_desde", "Coldesde" as "F_color_desde", "Porcent" as "Porcentaje", "Conforma1" as "Conformacion1", "Colhasta" as "F_color_hasta", "Famhasta" as "F_articulo_familia_hasta", "Conforma2" as "Conformacion2", "Montof" as "Montofijo", "Taldesde" as "F_talle_desde", "Lindesde" as "F_articulo_linea_desde", "Talhasta" as "F_talle_hasta", "Linhasta" as "F_articulo_linea_hasta", "Provdesde" as "F_articulo_proveedor_desde", "Catdesde" as "F_articulo_categoriadearticulo_desde", "Provhasta" as "F_articulo_proveedor_hasta", "Cathasta" as "F_articulo_categoriadearticulo_hasta", "Temdesde" as "F_articulo_temporada_desde", "Cladesde" as "F_articulo_clasificacion_desde", "Temhasta" as "F_articulo_temporada_hasta", "Clahasta" as "F_articulo_clasificacion_hasta", "Anodesde" as "F_articulo_ano_desde", "Tipdesde" as "F_articulo_tipodearticulo_desde", "Anohasta" as "F_articulo_ano_hasta", "Tiphasta" as "F_articulo_tipodearticulo_hasta", "Matdesde" as "F_articulo_material_desde", "Mathasta" as "F_articulo_material_hasta", "Grudesde" as "F_articulo_grupo_desde", "Gruhasta" as "F_articulo_grupo_hasta", "Lisdesde" as "F_listadeprecio_codigo_desde", "Mobs" as "Observacion", "Lishasta" as "F_listadeprecio_codigo_hasta", "Fpersond" as "F_cliente_desde", "Fpersonh" as "F_cliente_hasta", "Clclasd" as "F_cliente_clasificacion_desde", "Clclash" as "F_cliente_clasificacion_hasta", "Clcodfantd" as "F_cliente_nfantasia_desde", "Clcodfanth" as "F_cliente_nfantasia_hasta", "Cltipoclid" as "F_cliente_tipo_desde", "Cltipoclih" as "F_cliente_tipo_hasta", "Clcateclid" as "F_cliente_categoria_desde", "Clcateclih" as "F_cliente_categoria_hasta" from ZooLogic.COMISION where  COMISION.CODIGO != '' order by CODIGO desc
			endtext
			use in select('c_COMISION')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMISION', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Agrup" as "Agrupamiento", "Agrupdes" as "Agrupamientodetalle" from ZooLogic.AgruPubCOM where Codigo = <<"'" + this.FormatearTextoSql( c_COMISION.CODIGO ) + "'">> Order by NroItem
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
			lcXml = this.oConexion.EjecutarSql( "select Fecimpo,Fecexpo,Fectrans,Faltafw,Bdaltafw,Bdmodifw,Esttrans,Haltafw,Valtafw,Zadsfw,Vmodifw,U" + ;
"modifw,Ualtafw,Horaimpo,Smodifw,Saltafw,Horaexpo,Tipagrupub,Codigo,Fmodifw,Fechafd,Descrip,Unidesde," + ;
"Artdesde,Sucdesde,Segsdesde,Tipsdesde,Linsdesde,Fechah,Hmodifw,Arthasta,Unihasta,Segshasta,Suchasta," + ;
"Tipshasta,Linshasta,Famdesde,Coldesde,Porcent,Conforma1,Colhasta,Famhasta,Conforma2,Montof,Taldesde," + ;
"Lindesde,Talhasta,Linhasta,Provdesde,Catdesde,Provhasta,Cathasta,Temdesde,Cladesde,Temhasta,Clahasta" + ;
",Anodesde,Tipdesde,Anohasta,Tiphasta,Matdesde,Mathasta,Grudesde,Gruhasta,Lisdesde,Mobs,Lishasta,Fper" + ;
"sond,Fpersonh,Clclasd,Clclash,Clcodfantd,Clcodfanth,Cltipoclid,Cltipoclih,Clcateclid,Clcateclih" + ;
" from ZooLogic.COMISION where  COMISION.CODIGO != '' and " + lcFiltro )
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
			local  lxComisionFecimpo, lxComisionFecexpo, lxComisionFectrans, lxComisionFaltafw, lxComisionBdaltafw, lxComisionBdmodifw, lxComisionEsttrans, lxComisionHaltafw, lxComisionValtafw, lxComisionZadsfw, lxComisionVmodifw, lxComisionUmodifw, lxComisionUaltafw, lxComisionHoraimpo, lxComisionSmodifw, lxComisionSaltafw, lxComisionHoraexpo, lxComisionTipagrupub, lxComisionCodigo, lxComisionFmodifw, lxComisionFechafd, lxComisionDescrip, lxComisionUnidesde, lxComisionArtdesde, lxComisionSucdesde, lxComisionSegsdesde, lxComisionTipsdesde, lxComisionLinsdesde, lxComisionFechah, lxComisionHmodifw, lxComisionArthasta, lxComisionUnihasta, lxComisionSegshasta, lxComisionSuchasta, lxComisionTipshasta, lxComisionLinshasta, lxComisionFamdesde, lxComisionColdesde, lxComisionPorcent, lxComisionConforma1, lxComisionColhasta, lxComisionFamhasta, lxComisionConforma2, lxComisionMontof, lxComisionTaldesde, lxComisionLindesde, lxComisionTalhasta, lxComisionLinhasta, lxComisionProvdesde, lxComisionCatdesde, lxComisionProvhasta, lxComisionCathasta, lxComisionTemdesde, lxComisionCladesde, lxComisionTemhasta, lxComisionClahasta, lxComisionAnodesde, lxComisionTipdesde, lxComisionAnohasta, lxComisionTiphasta, lxComisionMatdesde, lxComisionMathasta, lxComisionGrudesde, lxComisionGruhasta, lxComisionLisdesde, lxComisionMobs, lxComisionLishasta, lxComisionFpersond, lxComisionFpersonh, lxComisionClclasd, lxComisionClclash, lxComisionClcodfantd, lxComisionClcodfanth, lxComisionCltipoclid, lxComisionCltipoclih, lxComisionClcateclid, lxComisionClcateclih
				lxComisionFecimpo = ctod( '  /  /    ' )			lxComisionFecexpo = ctod( '  /  /    ' )			lxComisionFectrans = ctod( '  /  /    ' )			lxComisionFaltafw = ctod( '  /  /    ' )			lxComisionBdaltafw = []			lxComisionBdmodifw = []			lxComisionEsttrans = []			lxComisionHaltafw = []			lxComisionValtafw = []			lxComisionZadsfw = []			lxComisionVmodifw = []			lxComisionUmodifw = []			lxComisionUaltafw = []			lxComisionHoraimpo = []			lxComisionSmodifw = []			lxComisionSaltafw = []			lxComisionHoraexpo = []			lxComisionTipagrupub = 0			lxComisionCodigo = []			lxComisionFmodifw = ctod( '  /  /    ' )			lxComisionFechafd = ctod( '  /  /    ' )			lxComisionDescrip = []			lxComisionUnidesde = []			lxComisionArtdesde = []			lxComisionSucdesde = []			lxComisionSegsdesde = []			lxComisionTipsdesde = []			lxComisionLinsdesde = []			lxComisionFechah = ctod( '  /  /    ' )			lxComisionHmodifw = []			lxComisionArthasta = []			lxComisionUnihasta = []			lxComisionSegshasta = []			lxComisionSuchasta = []			lxComisionTipshasta = []			lxComisionLinshasta = []			lxComisionFamdesde = []			lxComisionColdesde = []			lxComisionPorcent = 0			lxComisionConforma1 = []			lxComisionColhasta = []			lxComisionFamhasta = []			lxComisionConforma2 = []			lxComisionMontof = 0			lxComisionTaldesde = []			lxComisionLindesde = []			lxComisionTalhasta = []			lxComisionLinhasta = []			lxComisionProvdesde = []			lxComisionCatdesde = []			lxComisionProvhasta = []			lxComisionCathasta = []			lxComisionTemdesde = []			lxComisionCladesde = []			lxComisionTemhasta = []			lxComisionClahasta = []			lxComisionAnodesde = 0			lxComisionTipdesde = []			lxComisionAnohasta = 0			lxComisionTiphasta = []			lxComisionMatdesde = []			lxComisionMathasta = []			lxComisionGrudesde = []			lxComisionGruhasta = []			lxComisionLisdesde = []			lxComisionMobs = []			lxComisionLishasta = []			lxComisionFpersond = []			lxComisionFpersonh = []			lxComisionClclasd = []			lxComisionClclash = []			lxComisionClcodfantd = []			lxComisionClcodfanth = []			lxComisionCltipoclid = []			lxComisionCltipoclih = []			lxComisionClcateclid = []			lxComisionClcateclih = []
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.AgruPubCOM where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( [delete from ZooLogic.COMISION where "CODIGO" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'COMISION' + '_' + tcCampo
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
		lcWhere = " Where  COMISION.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Horaimpo" as "Horaimpo", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Horaexpo" as "Horaexpo", "Tipagrupub" as "Tipoagrupamientopublicaciones", "Codigo" as "Codigo", "Fmodifw" as "Fechamodificacionfw", "Fechafd" as "Fechavigenciadesde", "Descrip" as "Descripcion", "Unidesde" as "F_articulo_unidaddemedida_desde", "Artdesde" as "F_articulo_desde", "Sucdesde" as "F_sucursal_codigo_desde", "Segsdesde" as "F_sucursal_segmentacion_desde", "Tipsdesde" as "F_sucursal_tipo_desde", "Linsdesde" as "F_sucursal_linea_desde", "Fechah" as "Fechavigenciahasta", "Hmodifw" as "Horamodificacionfw", "Arthasta" as "F_articulo_hasta", "Unihasta" as "F_articulo_unidaddemedida_hasta", "Segshasta" as "F_sucursal_segmentacion_hasta", "Suchasta" as "F_sucursal_codigo_hasta", "Tipshasta" as "F_sucursal_tipo_hasta", "Linshasta" as "F_sucursal_linea_hasta", "Famdesde" as "F_articulo_familia_desde", "Coldesde" as "F_color_desde", "Porcent" as "Porcentaje", "Conforma1" as "Conformacion1", "Colhasta" as "F_color_hasta", "Famhasta" as "F_articulo_familia_hasta", "Conforma2" as "Conformacion2", "Montof" as "Montofijo", "Taldesde" as "F_talle_desde", "Lindesde" as "F_articulo_linea_desde", "Talhasta" as "F_talle_hasta", "Linhasta" as "F_articulo_linea_hasta", "Provdesde" as "F_articulo_proveedor_desde", "Catdesde" as "F_articulo_categoriadearticulo_desde", "Provhasta" as "F_articulo_proveedor_hasta", "Cathasta" as "F_articulo_categoriadearticulo_hasta", "Temdesde" as "F_articulo_temporada_desde", "Cladesde" as "F_articulo_clasificacion_desde", "Temhasta" as "F_articulo_temporada_hasta", "Clahasta" as "F_articulo_clasificacion_hasta", "Anodesde" as "F_articulo_ano_desde", "Tipdesde" as "F_articulo_tipodearticulo_desde", "Anohasta" as "F_articulo_ano_hasta", "Tiphasta" as "F_articulo_tipodearticulo_hasta", "Matdesde" as "F_articulo_material_desde", "Mathasta" as "F_articulo_material_hasta", "Grudesde" as "F_articulo_grupo_desde", "Gruhasta" as "F_articulo_grupo_hasta", "Lisdesde" as "F_listadeprecio_codigo_desde", "Mobs" as "Observacion", "Lishasta" as "F_listadeprecio_codigo_hasta", "Fpersond" as "F_cliente_desde", "Fpersonh" as "F_cliente_hasta", "Clclasd" as "F_cliente_clasificacion_desde", "Clclash" as "F_cliente_clasificacion_hasta", "Clcodfantd" as "F_cliente_nfantasia_desde", "Clcodfanth" as "F_cliente_nfantasia_hasta", "Cltipoclid" as "F_cliente_tipo_desde", "Cltipoclih" as "F_cliente_tipo_hasta", "Clcateclid" as "F_cliente_categoria_desde", "Clcateclih" as "F_cliente_categoria_hasta"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'COMISION', '', tnTope )
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
		lcWhere = " Where  AGRUPUBCOM.CODIGO != ''"
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
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'AgruPubCOM', 'AgruPubliDetalle', tnTope )
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
				Case lcAtributo == 'FECHAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECEXPO AS FECHAEXPO'
				Case lcAtributo == 'FECHATRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRANS AS FECHATRANSFERENCIA'
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
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
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'TIPOAGRUPAMIENTOPUBLICACIONES'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPAGRUPUB AS TIPOAGRUPAMIENTOPUBLICACIONES'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'FECHAVIGENCIADESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHAFD AS FECHAVIGENCIADESDE'
				Case lcAtributo == 'DESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCRIP AS DESCRIPCION'
				Case lcAtributo == 'F_ARTICULO_UNIDADDEMEDIDA_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UNIDESDE AS F_ARTICULO_UNIDADDEMEDIDA_DESDE'
				Case lcAtributo == 'F_ARTICULO_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ARTDESDE AS F_ARTICULO_DESDE'
				Case lcAtributo == 'F_SUCURSAL_CODIGO_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SUCDESDE AS F_SUCURSAL_CODIGO_DESDE'
				Case lcAtributo == 'F_SUCURSAL_SEGMENTACION_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SEGSDESDE AS F_SUCURSAL_SEGMENTACION_DESDE'
				Case lcAtributo == 'F_SUCURSAL_TIPO_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPSDESDE AS F_SUCURSAL_TIPO_DESDE'
				Case lcAtributo == 'F_SUCURSAL_LINEA_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LINSDESDE AS F_SUCURSAL_LINEA_DESDE'
				Case lcAtributo == 'FECHAVIGENCIAHASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHAH AS FECHAVIGENCIAHASTA'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'F_ARTICULO_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ARTHASTA AS F_ARTICULO_HASTA'
				Case lcAtributo == 'F_ARTICULO_UNIDADDEMEDIDA_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UNIHASTA AS F_ARTICULO_UNIDADDEMEDIDA_HASTA'
				Case lcAtributo == 'F_SUCURSAL_SEGMENTACION_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SEGSHASTA AS F_SUCURSAL_SEGMENTACION_HASTA'
				Case lcAtributo == 'F_SUCURSAL_CODIGO_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SUCHASTA AS F_SUCURSAL_CODIGO_HASTA'
				Case lcAtributo == 'F_SUCURSAL_TIPO_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPSHASTA AS F_SUCURSAL_TIPO_HASTA'
				Case lcAtributo == 'F_SUCURSAL_LINEA_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LINSHASTA AS F_SUCURSAL_LINEA_HASTA'
				Case lcAtributo == 'F_ARTICULO_FAMILIA_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FAMDESDE AS F_ARTICULO_FAMILIA_DESDE'
				Case lcAtributo == 'F_COLOR_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COLDESDE AS F_COLOR_DESDE'
				Case lcAtributo == 'PORCENTAJE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PORCENT AS PORCENTAJE'
				Case lcAtributo == 'CONFORMACION1'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CONFORMA1 AS CONFORMACION1'
				Case lcAtributo == 'F_COLOR_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COLHASTA AS F_COLOR_HASTA'
				Case lcAtributo == 'F_ARTICULO_FAMILIA_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FAMHASTA AS F_ARTICULO_FAMILIA_HASTA'
				Case lcAtributo == 'CONFORMACION2'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CONFORMA2 AS CONFORMACION2'
				Case lcAtributo == 'MONTOFIJO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONTOF AS MONTOFIJO'
				Case lcAtributo == 'F_TALLE_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TALDESDE AS F_TALLE_DESDE'
				Case lcAtributo == 'F_ARTICULO_LINEA_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LINDESDE AS F_ARTICULO_LINEA_DESDE'
				Case lcAtributo == 'F_TALLE_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TALHASTA AS F_TALLE_HASTA'
				Case lcAtributo == 'F_ARTICULO_LINEA_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LINHASTA AS F_ARTICULO_LINEA_HASTA'
				Case lcAtributo == 'F_ARTICULO_PROVEEDOR_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PROVDESDE AS F_ARTICULO_PROVEEDOR_DESDE'
				Case lcAtributo == 'F_ARTICULO_CATEGORIADEARTICULO_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CATDESDE AS F_ARTICULO_CATEGORIADEARTICULO_DESDE'
				Case lcAtributo == 'F_ARTICULO_PROVEEDOR_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PROVHASTA AS F_ARTICULO_PROVEEDOR_HASTA'
				Case lcAtributo == 'F_ARTICULO_CATEGORIADEARTICULO_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CATHASTA AS F_ARTICULO_CATEGORIADEARTICULO_HASTA'
				Case lcAtributo == 'F_ARTICULO_TEMPORADA_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TEMDESDE AS F_ARTICULO_TEMPORADA_DESDE'
				Case lcAtributo == 'F_ARTICULO_CLASIFICACION_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLADESDE AS F_ARTICULO_CLASIFICACION_DESDE'
				Case lcAtributo == 'F_ARTICULO_TEMPORADA_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TEMHASTA AS F_ARTICULO_TEMPORADA_HASTA'
				Case lcAtributo == 'F_ARTICULO_CLASIFICACION_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLAHASTA AS F_ARTICULO_CLASIFICACION_HASTA'
				Case lcAtributo == 'F_ARTICULO_ANO_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ANODESDE AS F_ARTICULO_ANO_DESDE'
				Case lcAtributo == 'F_ARTICULO_TIPODEARTICULO_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPDESDE AS F_ARTICULO_TIPODEARTICULO_DESDE'
				Case lcAtributo == 'F_ARTICULO_ANO_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ANOHASTA AS F_ARTICULO_ANO_HASTA'
				Case lcAtributo == 'F_ARTICULO_TIPODEARTICULO_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPHASTA AS F_ARTICULO_TIPODEARTICULO_HASTA'
				Case lcAtributo == 'F_ARTICULO_MATERIAL_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MATDESDE AS F_ARTICULO_MATERIAL_DESDE'
				Case lcAtributo == 'F_ARTICULO_MATERIAL_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MATHASTA AS F_ARTICULO_MATERIAL_HASTA'
				Case lcAtributo == 'F_ARTICULO_GRUPO_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'GRUDESDE AS F_ARTICULO_GRUPO_DESDE'
				Case lcAtributo == 'F_ARTICULO_GRUPO_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'GRUHASTA AS F_ARTICULO_GRUPO_HASTA'
				Case lcAtributo == 'F_LISTADEPRECIO_CODIGO_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LISDESDE AS F_LISTADEPRECIO_CODIGO_DESDE'
				Case lcAtributo == 'OBSERVACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MOBS AS OBSERVACION'
				Case lcAtributo == 'F_LISTADEPRECIO_CODIGO_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LISHASTA AS F_LISTADEPRECIO_CODIGO_HASTA'
				Case lcAtributo == 'F_CLIENTE_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPERSOND AS F_CLIENTE_DESDE'
				Case lcAtributo == 'F_CLIENTE_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPERSONH AS F_CLIENTE_HASTA'
				Case lcAtributo == 'F_CLIENTE_CLASIFICACION_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLCLASD AS F_CLIENTE_CLASIFICACION_DESDE'
				Case lcAtributo == 'F_CLIENTE_CLASIFICACION_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLCLASH AS F_CLIENTE_CLASIFICACION_HASTA'
				Case lcAtributo == 'F_CLIENTE_NFANTASIA_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLCODFANTD AS F_CLIENTE_NFANTASIA_DESDE'
				Case lcAtributo == 'F_CLIENTE_NFANTASIA_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLCODFANTH AS F_CLIENTE_NFANTASIA_HASTA'
				Case lcAtributo == 'F_CLIENTE_TIPO_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLTIPOCLID AS F_CLIENTE_TIPO_DESDE'
				Case lcAtributo == 'F_CLIENTE_TIPO_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLTIPOCLIH AS F_CLIENTE_TIPO_HASTA'
				Case lcAtributo == 'F_CLIENTE_CATEGORIA_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLCATECLID AS F_CLIENTE_CATEGORIA_DESDE'
				Case lcAtributo == 'F_CLIENTE_CATEGORIA_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLCATECLIH AS F_CLIENTE_CATEGORIA_HASTA'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEXPO'
				lcCampo = 'FECEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
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
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOAGRUPAMIENTOPUBLICACIONES'
				lcCampo = 'TIPAGRUPUB'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAVIGENCIADESDE'
				lcCampo = 'FECHAFD'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCION'
				lcCampo = 'DESCRIP'
			Case upper( alltrim( tcAtributo ) ) == 'F_ARTICULO_UNIDADDEMEDIDA_DESDE'
				lcCampo = 'UNIDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'F_ARTICULO_DESDE'
				lcCampo = 'ARTDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'F_SUCURSAL_CODIGO_DESDE'
				lcCampo = 'SUCDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'F_SUCURSAL_SEGMENTACION_DESDE'
				lcCampo = 'SEGSDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'F_SUCURSAL_TIPO_DESDE'
				lcCampo = 'TIPSDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'F_SUCURSAL_LINEA_DESDE'
				lcCampo = 'LINSDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAVIGENCIAHASTA'
				lcCampo = 'FECHAH'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'F_ARTICULO_HASTA'
				lcCampo = 'ARTHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'F_ARTICULO_UNIDADDEMEDIDA_HASTA'
				lcCampo = 'UNIHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'F_SUCURSAL_SEGMENTACION_HASTA'
				lcCampo = 'SEGSHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'F_SUCURSAL_CODIGO_HASTA'
				lcCampo = 'SUCHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'F_SUCURSAL_TIPO_HASTA'
				lcCampo = 'TIPSHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'F_SUCURSAL_LINEA_HASTA'
				lcCampo = 'LINSHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'F_ARTICULO_FAMILIA_DESDE'
				lcCampo = 'FAMDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'F_COLOR_DESDE'
				lcCampo = 'COLDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'PORCENTAJE'
				lcCampo = 'PORCENT'
			Case upper( alltrim( tcAtributo ) ) == 'CONFORMACION1'
				lcCampo = 'CONFORMA1'
			Case upper( alltrim( tcAtributo ) ) == 'F_COLOR_HASTA'
				lcCampo = 'COLHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'F_ARTICULO_FAMILIA_HASTA'
				lcCampo = 'FAMHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'CONFORMACION2'
				lcCampo = 'CONFORMA2'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOFIJO'
				lcCampo = 'MONTOF'
			Case upper( alltrim( tcAtributo ) ) == 'F_TALLE_DESDE'
				lcCampo = 'TALDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'F_ARTICULO_LINEA_DESDE'
				lcCampo = 'LINDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'F_TALLE_HASTA'
				lcCampo = 'TALHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'F_ARTICULO_LINEA_HASTA'
				lcCampo = 'LINHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'F_ARTICULO_PROVEEDOR_DESDE'
				lcCampo = 'PROVDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'F_ARTICULO_CATEGORIADEARTICULO_DESDE'
				lcCampo = 'CATDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'F_ARTICULO_PROVEEDOR_HASTA'
				lcCampo = 'PROVHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'F_ARTICULO_CATEGORIADEARTICULO_HASTA'
				lcCampo = 'CATHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'F_ARTICULO_TEMPORADA_DESDE'
				lcCampo = 'TEMDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'F_ARTICULO_CLASIFICACION_DESDE'
				lcCampo = 'CLADESDE'
			Case upper( alltrim( tcAtributo ) ) == 'F_ARTICULO_TEMPORADA_HASTA'
				lcCampo = 'TEMHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'F_ARTICULO_CLASIFICACION_HASTA'
				lcCampo = 'CLAHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'F_ARTICULO_ANO_DESDE'
				lcCampo = 'ANODESDE'
			Case upper( alltrim( tcAtributo ) ) == 'F_ARTICULO_TIPODEARTICULO_DESDE'
				lcCampo = 'TIPDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'F_ARTICULO_ANO_HASTA'
				lcCampo = 'ANOHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'F_ARTICULO_TIPODEARTICULO_HASTA'
				lcCampo = 'TIPHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'F_ARTICULO_MATERIAL_DESDE'
				lcCampo = 'MATDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'F_ARTICULO_MATERIAL_HASTA'
				lcCampo = 'MATHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'F_ARTICULO_GRUPO_DESDE'
				lcCampo = 'GRUDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'F_ARTICULO_GRUPO_HASTA'
				lcCampo = 'GRUHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'F_LISTADEPRECIO_CODIGO_DESDE'
				lcCampo = 'LISDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'OBSERVACION'
				lcCampo = 'MOBS'
			Case upper( alltrim( tcAtributo ) ) == 'F_LISTADEPRECIO_CODIGO_HASTA'
				lcCampo = 'LISHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'F_CLIENTE_DESDE'
				lcCampo = 'FPERSOND'
			Case upper( alltrim( tcAtributo ) ) == 'F_CLIENTE_HASTA'
				lcCampo = 'FPERSONH'
			Case upper( alltrim( tcAtributo ) ) == 'F_CLIENTE_CLASIFICACION_DESDE'
				lcCampo = 'CLCLASD'
			Case upper( alltrim( tcAtributo ) ) == 'F_CLIENTE_CLASIFICACION_HASTA'
				lcCampo = 'CLCLASH'
			Case upper( alltrim( tcAtributo ) ) == 'F_CLIENTE_NFANTASIA_DESDE'
				lcCampo = 'CLCODFANTD'
			Case upper( alltrim( tcAtributo ) ) == 'F_CLIENTE_NFANTASIA_HASTA'
				lcCampo = 'CLCODFANTH'
			Case upper( alltrim( tcAtributo ) ) == 'F_CLIENTE_TIPO_DESDE'
				lcCampo = 'CLTIPOCLID'
			Case upper( alltrim( tcAtributo ) ) == 'F_CLIENTE_TIPO_HASTA'
				lcCampo = 'CLTIPOCLIH'
			Case upper( alltrim( tcAtributo ) ) == 'F_CLIENTE_CATEGORIA_DESDE'
				lcCampo = 'CLCATECLID'
			Case upper( alltrim( tcAtributo ) ) == 'F_CLIENTE_CATEGORIA_HASTA'
				lcCampo = 'CLCATECLIH'
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
			lcRetorno = 'AGRUPUBCOM'
		EndIf
		return lcRetorno
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasInsert() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcSentencia as string, loItem as object
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxComisionFecimpo, lxComisionFecexpo, lxComisionFectrans, lxComisionFaltafw, lxComisionBdaltafw, lxComisionBdmodifw, lxComisionEsttrans, lxComisionHaltafw, lxComisionValtafw, lxComisionZadsfw, lxComisionVmodifw, lxComisionUmodifw, lxComisionUaltafw, lxComisionHoraimpo, lxComisionSmodifw, lxComisionSaltafw, lxComisionHoraexpo, lxComisionTipagrupub, lxComisionCodigo, lxComisionFmodifw, lxComisionFechafd, lxComisionDescrip, lxComisionUnidesde, lxComisionArtdesde, lxComisionSucdesde, lxComisionSegsdesde, lxComisionTipsdesde, lxComisionLinsdesde, lxComisionFechah, lxComisionHmodifw, lxComisionArthasta, lxComisionUnihasta, lxComisionSegshasta, lxComisionSuchasta, lxComisionTipshasta, lxComisionLinshasta, lxComisionFamdesde, lxComisionColdesde, lxComisionPorcent, lxComisionConforma1, lxComisionColhasta, lxComisionFamhasta, lxComisionConforma2, lxComisionMontof, lxComisionTaldesde, lxComisionLindesde, lxComisionTalhasta, lxComisionLinhasta, lxComisionProvdesde, lxComisionCatdesde, lxComisionProvhasta, lxComisionCathasta, lxComisionTemdesde, lxComisionCladesde, lxComisionTemhasta, lxComisionClahasta, lxComisionAnodesde, lxComisionTipdesde, lxComisionAnohasta, lxComisionTiphasta, lxComisionMatdesde, lxComisionMathasta, lxComisionGrudesde, lxComisionGruhasta, lxComisionLisdesde, lxComisionMobs, lxComisionLishasta, lxComisionFpersond, lxComisionFpersonh, lxComisionClclasd, lxComisionClclash, lxComisionClcodfantd, lxComisionClcodfanth, lxComisionCltipoclid, lxComisionCltipoclih, lxComisionClcateclid, lxComisionClcateclih
				lxComisionFecimpo =  .Fechaimpo			lxComisionFecexpo =  .Fechaexpo			lxComisionFectrans =  .Fechatransferencia			lxComisionFaltafw =  .Fechaaltafw			lxComisionBdaltafw =  .Basededatosaltafw			lxComisionBdmodifw =  .Basededatosmodificacionfw			lxComisionEsttrans =  .Estadotransferencia			lxComisionHaltafw =  .Horaaltafw			lxComisionValtafw =  .Versionaltafw			lxComisionZadsfw =  .Zadsfw			lxComisionVmodifw =  .Versionmodificacionfw			lxComisionUmodifw =  .Usuariomodificacionfw			lxComisionUaltafw =  .Usuarioaltafw			lxComisionHoraimpo =  .Horaimpo			lxComisionSmodifw =  .Seriemodificacionfw			lxComisionSaltafw =  .Seriealtafw			lxComisionHoraexpo =  .Horaexpo			lxComisionTipagrupub =  .Tipoagrupamientopublicaciones			lxComisionCodigo =  .Codigo			lxComisionFmodifw =  .Fechamodificacionfw			lxComisionFechafd =  .Fechavigenciadesde			lxComisionDescrip =  .Descripcion			lxComisionUnidesde =  upper( .f_Articulo_UnidadDeMedida_Desde_PK ) 			lxComisionArtdesde =  upper( .f_Articulo_Desde_PK ) 			lxComisionSucdesde =  upper( .f_Sucursal_Codigo_desde_PK ) 			lxComisionSegsdesde =  upper( .f_Sucursal_Segmentacion_Desde_PK ) 			lxComisionTipsdesde =  upper( .f_Sucursal_Tipo_Desde_PK ) 			lxComisionLinsdesde =  upper( .f_Sucursal_Linea_Desde_PK ) 			lxComisionFechah =  .Fechavigenciahasta			lxComisionHmodifw =  .Horamodificacionfw			lxComisionArthasta =  upper( .f_Articulo_Hasta_PK ) 			lxComisionUnihasta =  upper( .f_Articulo_UnidadDeMedida_Hasta_PK ) 			lxComisionSegshasta =  upper( .f_Sucursal_Segmentacion_Hasta_PK ) 			lxComisionSuchasta =  upper( .f_Sucursal_Codigo_hasta_PK ) 			lxComisionTipshasta =  upper( .f_Sucursal_Tipo_Hasta_PK ) 			lxComisionLinshasta =  upper( .f_Sucursal_Linea_Hasta_PK ) 			lxComisionFamdesde =  upper( .f_Articulo_Familia_Desde_PK ) 			lxComisionColdesde =  upper( .f_Color_desde_PK ) 			lxComisionPorcent =  .Porcentaje			lxComisionConforma1 =  .Conformacion1			lxComisionColhasta =  upper( .f_Color_hasta_PK ) 			lxComisionFamhasta =  upper( .f_Articulo_Familia_Hasta_PK ) 			lxComisionConforma2 =  .Conformacion2			lxComisionMontof =  .Montofijo			lxComisionTaldesde =  upper( .f_Talle_Desde_PK ) 			lxComisionLindesde =  upper( .f_Articulo_Linea_Desde_PK ) 			lxComisionTalhasta =  upper( .f_Talle_Hasta_PK ) 			lxComisionLinhasta =  upper( .f_Articulo_Linea_Hasta_PK ) 			lxComisionProvdesde =  upper( .f_Articulo_Proveedor_Desde_PK ) 			lxComisionCatdesde =  upper( .f_Articulo_CategoriaDeArticulo_Desde_PK ) 			lxComisionProvhasta =  upper( .f_Articulo_Proveedor_Hasta_PK ) 			lxComisionCathasta =  upper( .f_Articulo_CategoriaDeArticulo_Hasta_PK ) 			lxComisionTemdesde =  upper( .f_Articulo_Temporada_Desde_PK ) 			lxComisionCladesde =  upper( .f_Articulo_Clasificacion_Desde_PK ) 			lxComisionTemhasta =  upper( .f_Articulo_Temporada_Hasta_PK ) 			lxComisionClahasta =  upper( .f_Articulo_Clasificacion_Hasta_PK ) 			lxComisionAnodesde =  .F_articulo_ano_desde			lxComisionTipdesde =  upper( .f_Articulo_TipodeArticulo_Desde_PK ) 			lxComisionAnohasta =  .F_articulo_ano_hasta			lxComisionTiphasta =  upper( .f_Articulo_TipodeArticulo_Hasta_PK ) 			lxComisionMatdesde =  upper( .f_Articulo_Material_Desde_PK ) 			lxComisionMathasta =  upper( .f_Articulo_Material_Hasta_PK ) 			lxComisionGrudesde =  upper( .f_Articulo_Grupo_Desde_PK ) 			lxComisionGruhasta =  upper( .f_Articulo_Grupo_Hasta_PK ) 			lxComisionLisdesde =  upper( .f_ListaDePrecio_Codigo_Desde_PK ) 			lxComisionMobs =  .Observacion			lxComisionLishasta =  upper( .f_ListaDePrecio_Codigo_Hasta_PK ) 			lxComisionFpersond =  upper( .f_Cliente_Desde_PK ) 			lxComisionFpersonh =  upper( .f_Cliente_Hasta_PK ) 			lxComisionClclasd =  upper( .f_Cliente_Clasificacion_Desde_PK ) 			lxComisionClclash =  upper( .f_Cliente_Clasificacion_Hasta_PK ) 			lxComisionClcodfantd =  upper( .f_Cliente_NFantasia_Desde_PK ) 			lxComisionClcodfanth =  upper( .f_Cliente_NFantasia_Hasta_PK ) 			lxComisionCltipoclid =  upper( .f_Cliente_Tipo_Desde_PK ) 			lxComisionCltipoclih =  upper( .f_Cliente_Tipo_Hasta_PK ) 			lxComisionClcateclid =  upper( .f_Cliente_Categoria_Desde_PK ) 			lxComisionClcateclih =  upper( .f_Cliente_Categoria_Hasta_PK ) 
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.COMISION ( "Fecimpo","Fecexpo","Fectrans","Faltafw","Bdaltafw","Bdmodifw","Esttrans","Haltafw","Valtafw","Zadsfw","Vmodifw","Umodifw","Ualtafw","Horaimpo","Smodifw","Saltafw","Horaexpo","Tipagrupub","Codigo","Fmodifw","Fechafd","Descrip","Unidesde","Artdesde","Sucdesde","Segsdesde","Tipsdesde","Linsdesde","Fechah","Hmodifw","Arthasta","Unihasta","Segshasta","Suchasta","Tipshasta","Linshasta","Famdesde","Coldesde","Porcent","Conforma1","Colhasta","Famhasta","Conforma2","Montof","Taldesde","Lindesde","Talhasta","Linhasta","Provdesde","Catdesde","Provhasta","Cathasta","Temdesde","Cladesde","Temhasta","Clahasta","Anodesde","Tipdesde","Anohasta","Tiphasta","Matdesde","Mathasta","Grudesde","Gruhasta","Lisdesde","Mobs","Lishasta","Fpersond","Fpersonh","Clclasd","Clclash","Clcodfantd","Clcodfanth","Cltipoclid","Cltipoclih","Clcateclid","Clcateclih" ) values ( <<"'" + this.ConvertirDateSql( lxComisionFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxComisionFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxComisionFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxComisionFaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionHoraexpo ) + "'" >>, <<lxComisionTipagrupub >>, <<"'" + this.FormatearTextoSql( lxComisionCodigo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxComisionFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxComisionFechafd ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionDescrip ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionUnidesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionArtdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionSucdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionSegsdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionTipsdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionLinsdesde ) + "'" >>, <<"'" + this.ConvertirDateSql( lxComisionFechah ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionArthasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionUnihasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionSegshasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionSuchasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionTipshasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionLinshasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionFamdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionColdesde ) + "'" >>, <<lxComisionPorcent >>, <<"'" + this.FormatearTextoSql( lxComisionConforma1 ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionColhasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionFamhasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionConforma2 ) + "'" >>, <<lxComisionMontof >>, <<"'" + this.FormatearTextoSql( lxComisionTaldesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionLindesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionTalhasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionLinhasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionProvdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionCatdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionProvhasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionCathasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionTemdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionCladesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionTemhasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionClahasta ) + "'" >>, <<lxComisionAnodesde >>, <<"'" + this.FormatearTextoSql( lxComisionTipdesde ) + "'" >>, <<lxComisionAnohasta >>, <<"'" + this.FormatearTextoSql( lxComisionTiphasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionMatdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionMathasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionGrudesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionGruhasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionLisdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionMobs ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionLishasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionFpersond ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionFpersonh ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionClclasd ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionClclash ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionClcodfantd ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionClcodfanth ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionCltipoclid ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionCltipoclih ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionClcateclid ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionClcateclih ) + "'" >> )
		endtext
		loColeccion.cTabla = 'COMISION' 
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
						Insert into ZooLogic.AgruPubCOM("NROITEM","Codigo","Agrup","AgrupDes" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxAgrupamiento_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxAgrupamientodetalle ) + "'">> ) 
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
			local  lxComisionFecimpo, lxComisionFecexpo, lxComisionFectrans, lxComisionFaltafw, lxComisionBdaltafw, lxComisionBdmodifw, lxComisionEsttrans, lxComisionHaltafw, lxComisionValtafw, lxComisionZadsfw, lxComisionVmodifw, lxComisionUmodifw, lxComisionUaltafw, lxComisionHoraimpo, lxComisionSmodifw, lxComisionSaltafw, lxComisionHoraexpo, lxComisionTipagrupub, lxComisionCodigo, lxComisionFmodifw, lxComisionFechafd, lxComisionDescrip, lxComisionUnidesde, lxComisionArtdesde, lxComisionSucdesde, lxComisionSegsdesde, lxComisionTipsdesde, lxComisionLinsdesde, lxComisionFechah, lxComisionHmodifw, lxComisionArthasta, lxComisionUnihasta, lxComisionSegshasta, lxComisionSuchasta, lxComisionTipshasta, lxComisionLinshasta, lxComisionFamdesde, lxComisionColdesde, lxComisionPorcent, lxComisionConforma1, lxComisionColhasta, lxComisionFamhasta, lxComisionConforma2, lxComisionMontof, lxComisionTaldesde, lxComisionLindesde, lxComisionTalhasta, lxComisionLinhasta, lxComisionProvdesde, lxComisionCatdesde, lxComisionProvhasta, lxComisionCathasta, lxComisionTemdesde, lxComisionCladesde, lxComisionTemhasta, lxComisionClahasta, lxComisionAnodesde, lxComisionTipdesde, lxComisionAnohasta, lxComisionTiphasta, lxComisionMatdesde, lxComisionMathasta, lxComisionGrudesde, lxComisionGruhasta, lxComisionLisdesde, lxComisionMobs, lxComisionLishasta, lxComisionFpersond, lxComisionFpersonh, lxComisionClclasd, lxComisionClclash, lxComisionClcodfantd, lxComisionClcodfanth, lxComisionCltipoclid, lxComisionCltipoclih, lxComisionClcateclid, lxComisionClcateclih
				lxComisionFecimpo =  .Fechaimpo			lxComisionFecexpo =  .Fechaexpo			lxComisionFectrans =  .Fechatransferencia			lxComisionFaltafw =  .Fechaaltafw			lxComisionBdaltafw =  .Basededatosaltafw			lxComisionBdmodifw =  .Basededatosmodificacionfw			lxComisionEsttrans =  .Estadotransferencia			lxComisionHaltafw =  .Horaaltafw			lxComisionValtafw =  .Versionaltafw			lxComisionZadsfw =  .Zadsfw			lxComisionVmodifw =  .Versionmodificacionfw			lxComisionUmodifw =  .Usuariomodificacionfw			lxComisionUaltafw =  .Usuarioaltafw			lxComisionHoraimpo =  .Horaimpo			lxComisionSmodifw =  .Seriemodificacionfw			lxComisionSaltafw =  .Seriealtafw			lxComisionHoraexpo =  .Horaexpo			lxComisionTipagrupub =  .Tipoagrupamientopublicaciones			lxComisionCodigo =  .Codigo			lxComisionFmodifw =  .Fechamodificacionfw			lxComisionFechafd =  .Fechavigenciadesde			lxComisionDescrip =  .Descripcion			lxComisionUnidesde =  upper( .f_Articulo_UnidadDeMedida_Desde_PK ) 			lxComisionArtdesde =  upper( .f_Articulo_Desde_PK ) 			lxComisionSucdesde =  upper( .f_Sucursal_Codigo_desde_PK ) 			lxComisionSegsdesde =  upper( .f_Sucursal_Segmentacion_Desde_PK ) 			lxComisionTipsdesde =  upper( .f_Sucursal_Tipo_Desde_PK ) 			lxComisionLinsdesde =  upper( .f_Sucursal_Linea_Desde_PK ) 			lxComisionFechah =  .Fechavigenciahasta			lxComisionHmodifw =  .Horamodificacionfw			lxComisionArthasta =  upper( .f_Articulo_Hasta_PK ) 			lxComisionUnihasta =  upper( .f_Articulo_UnidadDeMedida_Hasta_PK ) 			lxComisionSegshasta =  upper( .f_Sucursal_Segmentacion_Hasta_PK ) 			lxComisionSuchasta =  upper( .f_Sucursal_Codigo_hasta_PK ) 			lxComisionTipshasta =  upper( .f_Sucursal_Tipo_Hasta_PK ) 			lxComisionLinshasta =  upper( .f_Sucursal_Linea_Hasta_PK ) 			lxComisionFamdesde =  upper( .f_Articulo_Familia_Desde_PK ) 			lxComisionColdesde =  upper( .f_Color_desde_PK ) 			lxComisionPorcent =  .Porcentaje			lxComisionConforma1 =  .Conformacion1			lxComisionColhasta =  upper( .f_Color_hasta_PK ) 			lxComisionFamhasta =  upper( .f_Articulo_Familia_Hasta_PK ) 			lxComisionConforma2 =  .Conformacion2			lxComisionMontof =  .Montofijo			lxComisionTaldesde =  upper( .f_Talle_Desde_PK ) 			lxComisionLindesde =  upper( .f_Articulo_Linea_Desde_PK ) 			lxComisionTalhasta =  upper( .f_Talle_Hasta_PK ) 			lxComisionLinhasta =  upper( .f_Articulo_Linea_Hasta_PK ) 			lxComisionProvdesde =  upper( .f_Articulo_Proveedor_Desde_PK ) 			lxComisionCatdesde =  upper( .f_Articulo_CategoriaDeArticulo_Desde_PK ) 			lxComisionProvhasta =  upper( .f_Articulo_Proveedor_Hasta_PK ) 			lxComisionCathasta =  upper( .f_Articulo_CategoriaDeArticulo_Hasta_PK ) 			lxComisionTemdesde =  upper( .f_Articulo_Temporada_Desde_PK ) 			lxComisionCladesde =  upper( .f_Articulo_Clasificacion_Desde_PK ) 			lxComisionTemhasta =  upper( .f_Articulo_Temporada_Hasta_PK ) 			lxComisionClahasta =  upper( .f_Articulo_Clasificacion_Hasta_PK ) 			lxComisionAnodesde =  .F_articulo_ano_desde			lxComisionTipdesde =  upper( .f_Articulo_TipodeArticulo_Desde_PK ) 			lxComisionAnohasta =  .F_articulo_ano_hasta			lxComisionTiphasta =  upper( .f_Articulo_TipodeArticulo_Hasta_PK ) 			lxComisionMatdesde =  upper( .f_Articulo_Material_Desde_PK ) 			lxComisionMathasta =  upper( .f_Articulo_Material_Hasta_PK ) 			lxComisionGrudesde =  upper( .f_Articulo_Grupo_Desde_PK ) 			lxComisionGruhasta =  upper( .f_Articulo_Grupo_Hasta_PK ) 			lxComisionLisdesde =  upper( .f_ListaDePrecio_Codigo_Desde_PK ) 			lxComisionMobs =  .Observacion			lxComisionLishasta =  upper( .f_ListaDePrecio_Codigo_Hasta_PK ) 			lxComisionFpersond =  upper( .f_Cliente_Desde_PK ) 			lxComisionFpersonh =  upper( .f_Cliente_Hasta_PK ) 			lxComisionClclasd =  upper( .f_Cliente_Clasificacion_Desde_PK ) 			lxComisionClclash =  upper( .f_Cliente_Clasificacion_Hasta_PK ) 			lxComisionClcodfantd =  upper( .f_Cliente_NFantasia_Desde_PK ) 			lxComisionClcodfanth =  upper( .f_Cliente_NFantasia_Hasta_PK ) 			lxComisionCltipoclid =  upper( .f_Cliente_Tipo_Desde_PK ) 			lxComisionCltipoclih =  upper( .f_Cliente_Tipo_Hasta_PK ) 			lxComisionClcateclid =  upper( .f_Cliente_Categoria_Desde_PK ) 			lxComisionClcateclih =  upper( .f_Cliente_Categoria_Hasta_PK ) 
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  COMISION.CODIGO != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.COMISION set "Fecimpo" = <<"'" + this.ConvertirDateSql( lxComisionFecimpo ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxComisionFecexpo ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxComisionFectrans ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxComisionFaltafw ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxComisionBdaltafw ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxComisionBdmodifw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxComisionEsttrans ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxComisionHaltafw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxComisionValtafw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxComisionZadsfw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxComisionVmodifw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxComisionUmodifw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxComisionUaltafw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxComisionHoraimpo ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxComisionSmodifw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxComisionSaltafw ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxComisionHoraexpo ) + "'">>, "Tipagrupub" = <<lxComisionTipagrupub>>, "Codigo" = <<"'" + this.FormatearTextoSql( lxComisionCodigo ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxComisionFmodifw ) + "'">>, "Fechafd" = <<"'" + this.ConvertirDateSql( lxComisionFechafd ) + "'">>, "Descrip" = <<"'" + this.FormatearTextoSql( lxComisionDescrip ) + "'">>, "Unidesde" = <<"'" + this.FormatearTextoSql( lxComisionUnidesde ) + "'">>, "Artdesde" = <<"'" + this.FormatearTextoSql( lxComisionArtdesde ) + "'">>, "Sucdesde" = <<"'" + this.FormatearTextoSql( lxComisionSucdesde ) + "'">>, "Segsdesde" = <<"'" + this.FormatearTextoSql( lxComisionSegsdesde ) + "'">>, "Tipsdesde" = <<"'" + this.FormatearTextoSql( lxComisionTipsdesde ) + "'">>, "Linsdesde" = <<"'" + this.FormatearTextoSql( lxComisionLinsdesde ) + "'">>, "Fechah" = <<"'" + this.ConvertirDateSql( lxComisionFechah ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxComisionHmodifw ) + "'">>, "Arthasta" = <<"'" + this.FormatearTextoSql( lxComisionArthasta ) + "'">>, "Unihasta" = <<"'" + this.FormatearTextoSql( lxComisionUnihasta ) + "'">>, "Segshasta" = <<"'" + this.FormatearTextoSql( lxComisionSegshasta ) + "'">>, "Suchasta" = <<"'" + this.FormatearTextoSql( lxComisionSuchasta ) + "'">>, "Tipshasta" = <<"'" + this.FormatearTextoSql( lxComisionTipshasta ) + "'">>, "Linshasta" = <<"'" + this.FormatearTextoSql( lxComisionLinshasta ) + "'">>, "Famdesde" = <<"'" + this.FormatearTextoSql( lxComisionFamdesde ) + "'">>, "Coldesde" = <<"'" + this.FormatearTextoSql( lxComisionColdesde ) + "'">>, "Porcent" = <<lxComisionPorcent>>, "Conforma1" = <<"'" + this.FormatearTextoSql( lxComisionConforma1 ) + "'">>, "Colhasta" = <<"'" + this.FormatearTextoSql( lxComisionColhasta ) + "'">>, "Famhasta" = <<"'" + this.FormatearTextoSql( lxComisionFamhasta ) + "'">>, "Conforma2" = <<"'" + this.FormatearTextoSql( lxComisionConforma2 ) + "'">>, "Montof" = <<lxComisionMontof>>, "Taldesde" = <<"'" + this.FormatearTextoSql( lxComisionTaldesde ) + "'">>, "Lindesde" = <<"'" + this.FormatearTextoSql( lxComisionLindesde ) + "'">>, "Talhasta" = <<"'" + this.FormatearTextoSql( lxComisionTalhasta ) + "'">>, "Linhasta" = <<"'" + this.FormatearTextoSql( lxComisionLinhasta ) + "'">>, "Provdesde" = <<"'" + this.FormatearTextoSql( lxComisionProvdesde ) + "'">>, "Catdesde" = <<"'" + this.FormatearTextoSql( lxComisionCatdesde ) + "'">>, "Provhasta" = <<"'" + this.FormatearTextoSql( lxComisionProvhasta ) + "'">>, "Cathasta" = <<"'" + this.FormatearTextoSql( lxComisionCathasta ) + "'">>, "Temdesde" = <<"'" + this.FormatearTextoSql( lxComisionTemdesde ) + "'">>, "Cladesde" = <<"'" + this.FormatearTextoSql( lxComisionCladesde ) + "'">>, "Temhasta" = <<"'" + this.FormatearTextoSql( lxComisionTemhasta ) + "'">>, "Clahasta" = <<"'" + this.FormatearTextoSql( lxComisionClahasta ) + "'">>, "Anodesde" = <<lxComisionAnodesde>>, "Tipdesde" = <<"'" + this.FormatearTextoSql( lxComisionTipdesde ) + "'">>, "Anohasta" = <<lxComisionAnohasta>>, "Tiphasta" = <<"'" + this.FormatearTextoSql( lxComisionTiphasta ) + "'">>, "Matdesde" = <<"'" + this.FormatearTextoSql( lxComisionMatdesde ) + "'">>, "Mathasta" = <<"'" + this.FormatearTextoSql( lxComisionMathasta ) + "'">>, "Grudesde" = <<"'" + this.FormatearTextoSql( lxComisionGrudesde ) + "'">>, "Gruhasta" = <<"'" + this.FormatearTextoSql( lxComisionGruhasta ) + "'">>, "Lisdesde" = <<"'" + this.FormatearTextoSql( lxComisionLisdesde ) + "'">>, "Mobs" = <<"'" + this.FormatearTextoSql( lxComisionMobs ) + "'">>, "Lishasta" = <<"'" + this.FormatearTextoSql( lxComisionLishasta ) + "'">>, "Fpersond" = <<"'" + this.FormatearTextoSql( lxComisionFpersond ) + "'">>, "Fpersonh" = <<"'" + this.FormatearTextoSql( lxComisionFpersonh ) + "'">>, "Clclasd" = <<"'" + this.FormatearTextoSql( lxComisionClclasd ) + "'">>, "Clclash" = <<"'" + this.FormatearTextoSql( lxComisionClclash ) + "'">>, "Clcodfantd" = <<"'" + this.FormatearTextoSql( lxComisionClcodfantd ) + "'">>, "Clcodfanth" = <<"'" + this.FormatearTextoSql( lxComisionClcodfanth ) + "'">>, "Cltipoclid" = <<"'" + this.FormatearTextoSql( lxComisionCltipoclid ) + "'">>, "Cltipoclih" = <<"'" + this.FormatearTextoSql( lxComisionCltipoclih ) + "'">>, "Clcateclid" = <<"'" + this.FormatearTextoSql( lxComisionClcateclid ) + "'">>, "Clcateclih" = <<"'" + this.FormatearTextoSql( lxComisionClcateclih ) + "'">> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'COMISION' 
		loColeccion.agregar( strtran(  lcSentencia, chr( 9 ), '' ) )
			loColeccion.Agregar([delete from ZooLogic.AgruPubCOM where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.AgruPubliDetalle
				if this.oEntidad.AgruPubliDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxAgrupamiento_PK = loItem.Agrupamiento_PK
					lxAgrupamientodetalle = loItem.Agrupamientodetalle
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.AgruPubCOM("NROITEM","Codigo","Agrup","AgrupDes" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxAgrupamiento_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxAgrupamientodetalle ) + "'">> ) 
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

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  COMISION.CODIGO != '']
		loColeccion.Agregar( 'delete from ZooLogic.COMISION where ' + lcFiltro )
			loColeccion.Agregar([delete from ZooLogic.AgruPubCOM where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.cTabla = 'COMISION' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.COMISION where  COMISION.CODIGO != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.COMISION where CODIGO = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  COMISION.CODIGO != ''" )
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
		lcCursor = This.oEntidad.cPrefijoRecibir + 'COMISION'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.COMISION Where CODIGO = ] + "'" + this.FormatearTextoSql( &lcCursor..CODIGO ) + "'", 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					this.oConexion.EjecutarSql( [UPDATE ZooLogic.COMISION set  FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, tipagrupub = ] + transform( &lcCursor..tipagrupub )+ [, CODIGO = ] + "'" + this.FormatearTextoSql( &lcCursor..CODIGO ) + "'"+ [, FModiFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FModiFW ) + "'"+ [, FECHAFD = ] + "'" + this.ConvertirDateSql( &lcCursor..FECHAFD ) + "'"+ [, Descrip = ] + "'" + this.FormatearTextoSql( &lcCursor..Descrip ) + "'"+ [, UniDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..UniDesde ) + "'"+ [, ArtDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..ArtDesde ) + "'"+ [, SucDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..SucDesde ) + "'"+ [, SegSDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..SegSDesde ) + "'"+ [, TipSDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..TipSDesde ) + "'"+ [, LinSDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..LinSDesde ) + "'"+ [, FECHAH = ] + "'" + this.ConvertirDateSql( &lcCursor..FECHAH ) + "'"+ [, HModiFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HModiFW ) + "'"+ [, ArtHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..ArtHasta ) + "'"+ [, UniHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..UniHasta ) + "'"+ [, SegSHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..SegSHasta ) + "'"+ [, SucHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..SucHasta ) + "'"+ [, TipSHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..TipSHasta ) + "'"+ [, LinSHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..LinSHasta ) + "'"+ [, FamDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..FamDesde ) + "'"+ [, ColDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..ColDesde ) + "'"+ [, Porcent = ] + transform( &lcCursor..Porcent )+ [, Conforma1 = ] + "'" + this.FormatearTextoSql( &lcCursor..Conforma1 ) + "'"+ [, ColHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..ColHasta ) + "'"+ [, FamHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..FamHasta ) + "'"+ [, Conforma2 = ] + "'" + this.FormatearTextoSql( &lcCursor..Conforma2 ) + "'"+ [, MontoF = ] + transform( &lcCursor..MontoF )+ [, TalDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..TalDesde ) + "'"+ [, LinDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..LinDesde ) + "'"+ [, TalHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..TalHasta ) + "'"+ [, LinHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..LinHasta ) + "'"+ [, ProvDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..ProvDesde ) + "'"+ [, CatDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..CatDesde ) + "'"+ [, ProvHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..ProvHasta ) + "'"+ [, CatHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..CatHasta ) + "'"+ [, TemDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..TemDesde ) + "'"+ [, ClaDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..ClaDesde ) + "'"+ [, TemHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..TemHasta ) + "'"+ [, ClaHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..ClaHasta ) + "'"+ [, AnoDesde = ] + transform( &lcCursor..AnoDesde )+ [, TipDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..TipDesde ) + "'"+ [, AnoHasta = ] + transform( &lcCursor..AnoHasta )+ [, TipHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..TipHasta ) + "'"+ [, MatDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..MatDesde ) + "'"+ [, MatHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..MatHasta ) + "'"+ [, GruDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..GruDesde ) + "'"+ [, GruHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..GruHasta ) + "'"+ [, LisDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..LisDesde ) + "'"+ [, MObs = ] + "'" + this.FormatearTextoSql( &lcCursor..MObs ) + "'"+ [, LisHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..LisHasta ) + "'"+ [, FPersonD = ] + "'" + this.FormatearTextoSql( &lcCursor..FPersonD ) + "'"+ [, FPersonH = ] + "'" + this.FormatearTextoSql( &lcCursor..FPersonH ) + "'"+ [, CLCLASD = ] + "'" + this.FormatearTextoSql( &lcCursor..CLCLASD ) + "'"+ [, CLCLASH = ] + "'" + this.FormatearTextoSql( &lcCursor..CLCLASH ) + "'"+ [, CLCODFANTD = ] + "'" + this.FormatearTextoSql( &lcCursor..CLCODFANTD ) + "'"+ [, CLCODFANTH = ] + "'" + this.FormatearTextoSql( &lcCursor..CLCODFANTH ) + "'"+ [, CLTipoCliD = ] + "'" + this.FormatearTextoSql( &lcCursor..CLTipoCliD ) + "'"+ [, CLTipoCliH = ] + "'" + this.FormatearTextoSql( &lcCursor..CLTipoCliH ) + "'"+ [, CLCateCliD = ] + "'" + this.FormatearTextoSql( &lcCursor..CLCateCliD ) + "'"+ [, CLCateCliH = ] + "'" + this.FormatearTextoSql( &lcCursor..CLCateCliH ) + "'" + [ Where CODIGO = ] + "'" + this.FormatearTextoSql( &lcCursor..CODIGO ) + "'" )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
				endIf
			else
				Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
				Text to lcCampos noShow
					 FECIMPO, FECEXPO, FECTRANS, FALTAFW, BDALTAFW, BDMODIFW, ESTTRANS, HALTAFW, VALTAFW, ZADSFW, VMODIFW, UMODIFW, UALTAFW, HORAIMPO, SMODIFW, SALTAFW, HORAEXPO, tipagrupub, CODIGO, FModiFW, FECHAFD, Descrip, UniDesde, ArtDesde, SucDesde, SegSDesde, TipSDesde, LinSDesde, FECHAH, HModiFW, ArtHasta, UniHasta, SegSHasta, SucHasta, TipSHasta, LinSHasta, FamDesde, ColDesde, Porcent, Conforma1, ColHasta, FamHasta, Conforma2, MontoF, TalDesde, LinDesde, TalHasta, LinHasta, ProvDesde, CatDesde, ProvHasta, CatHasta, TemDesde, ClaDesde, TemHasta, ClaHasta, AnoDesde, TipDesde, AnoHasta, TipHasta, MatDesde, MatHasta, GruDesde, GruHasta, LisDesde, MObs, LisHasta, FPersonD, FPersonH, CLCLASD, CLCLASH, CLCODFANTD, CLCODFANTH, CLTipoCliD, CLTipoCliH, CLCateCliD, CLCateCliH
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + transform( &lcCursor..tipagrupub ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..CODIGO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FModiFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECHAFD ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..Descrip ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UniDesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ArtDesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SucDesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SegSDesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..TipSDesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..LinSDesde ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECHAH ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HModiFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ArtHasta ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UniHasta ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SegSHasta ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SucHasta ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..TipSHasta ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..LinSHasta ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..FamDesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ColDesde ) + "'" + ',' + transform( &lcCursor..Porcent ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..Conforma1 ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ColHasta ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..FamHasta ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..Conforma2 ) + "'" + ',' + transform( &lcCursor..MontoF ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..TalDesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..LinDesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..TalHasta ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..LinHasta ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ProvDesde ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..CatDesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ProvHasta ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CatHasta ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..TemDesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ClaDesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..TemHasta ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ClaHasta ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..AnoDesde ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..TipDesde ) + "'" + ',' + transform( &lcCursor..AnoHasta ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..TipHasta ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..MatDesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..MatHasta ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..GruDesde ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..GruHasta ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..LisDesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..MObs ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..LisHasta ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..FPersonD ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..FPersonH ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLCLASD ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLCLASH ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLCODFANTD ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLCODFANTH ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLTipoCliD ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLTipoCliH ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLCateCliD ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLCateCliH ) + "'"
lcValoresCampos = substr(lcValoresCampos,2) 

				this.oConexion.EjecutarSql( [Insert into ZooLogic.COMISION ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
				this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'COMISION'
		if This.ActualizaEnRecepcion()
		Local lcIn as String, lcCantRegistros as Integer
		Select( lcCursor )
		Count to lcCantRegistros
		If lcCantRegistros > 0
			lcIn = This.ObtenerInSqlServer( lcCursor, 'CODIGO','C')
			lnFragmento = goRegistry.nucleo.cantidadDeElementosEnSentenciaInSQL
			loIn = this.ObtenerColeccionInSqlServer( lcCursor,'','CODIGO')
			llEjecutaEnTransaccion = loIn.count > 0
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'BEGIN TRANSACTION' )
			endif
			for i = 1 to loIn.count step lnFragmento
				lcIn = this.ObtenerFragmentoColeccionInSqlServer( loIn, i, lnFragmento )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.AgruPubCOM Where Codigo] + lcIn  )
			endfor
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'COMMIT TRANSACTION' )
			endif
		EndIf
	endif
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMAGRUPAPUBLICCOM'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where Codigo in ( select CODIGO from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"NROITEM","Codigo","Agrup","AgrupDes"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.AgruPubCOM ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Codigo     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Agrup      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.AgrupDes   ) + "'" + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	Use in select( 'cExistentes' )
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearCursorMemo( tcCursorACrear as String, tcTablaConMemo as String ) as Void
		create cursor &tcCursorACrear ( CODIGO C (10) , Orden N(16), texto C(80))
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirComponentes() As Void
		
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function ObtenerIdentificadorParaLoguear( tcCursor as String ) As String
		local lcRetorno as String, lnCC as String , loCC as Object, lni as Integer, lcSecuencia as String
		lcRetorno = this.oEntidad.cDescripcion 
		lcRetorno = lcRetorno + ' - Código: ' + transform( &tcCursor..CODIGO     )
		Return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EsAliasDeProceso( tcAlias As String, tcPrefijo as string ) As Boolean
		local llRetorno as Boolean, lcAlias as String, lcPrefijo As String
		llRetorno = .F.
		lcAlias = upper( alltrim( tcAlias ) )
		lcPrefijo = upper( alltrim( tcPrefijo ) )
		Do Case
			Case  lcAlias == lcPrefijo + 'COMISION'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'COMISION_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'COMISION_MOBS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMAGRUPAPUBLICCOM'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_COMISION')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'COMISION'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..CODIGO
		llCondicion = isnull( lxVar )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad COMISION. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'COMISION'
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
			lcCursor = This.oEntidad.cPrefijoRecibir + 'COMISION'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FModiFW   
		* Validar ANTERIORES A 1/1/1753  FECHAFD   
		* Validar ANTERIORES A 1/1/1753  FECHAH    
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_COMISION') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_COMISION
Create Table ZooLogic.TablaTrabajo_COMISION ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fecimpo" datetime  null, 
"fecexpo" datetime  null, 
"fectrans" datetime  null, 
"faltafw" datetime  null, 
"bdaltafw" char( 8 )  null, 
"bdmodifw" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"haltafw" char( 8 )  null, 
"valtafw" char( 13 )  null, 
"zadsfw" varchar(max)  null, 
"vmodifw" char( 13 )  null, 
"umodifw" char( 100 )  null, 
"ualtafw" char( 100 )  null, 
"horaimpo" char( 8 )  null, 
"smodifw" char( 7 )  null, 
"saltafw" char( 7 )  null, 
"horaexpo" char( 8 )  null, 
"tipagrupub" numeric( 1, 0 )  null, 
"codigo" char( 10 )  null, 
"fmodifw" datetime  null, 
"fechafd" datetime  null, 
"descrip" char( 40 )  null, 
"unidesde" char( 3 )  null, 
"artdesde" char( 15 )  null, 
"sucdesde" char( 10 )  null, 
"segsdesde" char( 10 )  null, 
"tipsdesde" char( 10 )  null, 
"linsdesde" char( 10 )  null, 
"fechah" datetime  null, 
"hmodifw" char( 8 )  null, 
"arthasta" char( 15 )  null, 
"unihasta" char( 3 )  null, 
"segshasta" char( 10 )  null, 
"suchasta" char( 10 )  null, 
"tipshasta" char( 10 )  null, 
"linshasta" char( 10 )  null, 
"famdesde" char( 10 )  null, 
"coldesde" char( 6 )  null, 
"porcent" numeric( 7, 2 )  null, 
"conforma1" char( 200 )  null, 
"colhasta" char( 6 )  null, 
"famhasta" char( 10 )  null, 
"conforma2" char( 200 )  null, 
"montof" numeric( 15, 2 )  null, 
"taldesde" char( 5 )  null, 
"lindesde" char( 10 )  null, 
"talhasta" char( 5 )  null, 
"linhasta" char( 10 )  null, 
"provdesde" char( 10 )  null, 
"catdesde" char( 10 )  null, 
"provhasta" char( 10 )  null, 
"cathasta" char( 10 )  null, 
"temdesde" char( 5 )  null, 
"cladesde" char( 10 )  null, 
"temhasta" char( 5 )  null, 
"clahasta" char( 10 )  null, 
"anodesde" numeric( 4, 0 )  null, 
"tipdesde" char( 10 )  null, 
"anohasta" numeric( 4, 0 )  null, 
"tiphasta" char( 10 )  null, 
"matdesde" char( 10 )  null, 
"mathasta" char( 10 )  null, 
"grudesde" char( 10 )  null, 
"gruhasta" char( 10 )  null, 
"lisdesde" char( 6 )  null, 
"mobs" varchar(max)  null, 
"lishasta" char( 6 )  null, 
"fpersond" char( 10 )  null, 
"fpersonh" char( 10 )  null, 
"clclasd" char( 10 )  null, 
"clclash" char( 10 )  null, 
"clcodfantd" char( 50 )  null, 
"clcodfanth" char( 50 )  null, 
"cltipoclid" char( 10 )  null, 
"cltipoclih" char( 10 )  null, 
"clcateclid" char( 10 )  null, 
"clcateclih" char( 10 )  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_COMISION' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_COMISION' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'COMISION'
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
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('tipagrupub','tipagrupub')
			.AgregarMapeo('codigo','codigo')
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('fechafd','fechafd')
			.AgregarMapeo('descrip','descrip')
			.AgregarMapeo('unidesde','unidesde')
			.AgregarMapeo('artdesde','artdesde')
			.AgregarMapeo('sucdesde','sucdesde')
			.AgregarMapeo('segsdesde','segsdesde')
			.AgregarMapeo('tipsdesde','tipsdesde')
			.AgregarMapeo('linsdesde','linsdesde')
			.AgregarMapeo('fechah','fechah')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('arthasta','arthasta')
			.AgregarMapeo('unihasta','unihasta')
			.AgregarMapeo('segshasta','segshasta')
			.AgregarMapeo('suchasta','suchasta')
			.AgregarMapeo('tipshasta','tipshasta')
			.AgregarMapeo('linshasta','linshasta')
			.AgregarMapeo('famdesde','famdesde')
			.AgregarMapeo('coldesde','coldesde')
			.AgregarMapeo('porcent','porcent')
			.AgregarMapeo('conforma1','conforma1')
			.AgregarMapeo('colhasta','colhasta')
			.AgregarMapeo('famhasta','famhasta')
			.AgregarMapeo('conforma2','conforma2')
			.AgregarMapeo('montof','montof')
			.AgregarMapeo('taldesde','taldesde')
			.AgregarMapeo('lindesde','lindesde')
			.AgregarMapeo('talhasta','talhasta')
			.AgregarMapeo('linhasta','linhasta')
			.AgregarMapeo('provdesde','provdesde')
			.AgregarMapeo('catdesde','catdesde')
			.AgregarMapeo('provhasta','provhasta')
			.AgregarMapeo('cathasta','cathasta')
			.AgregarMapeo('temdesde','temdesde')
			.AgregarMapeo('cladesde','cladesde')
			.AgregarMapeo('temhasta','temhasta')
			.AgregarMapeo('clahasta','clahasta')
			.AgregarMapeo('anodesde','anodesde')
			.AgregarMapeo('tipdesde','tipdesde')
			.AgregarMapeo('anohasta','anohasta')
			.AgregarMapeo('tiphasta','tiphasta')
			.AgregarMapeo('matdesde','matdesde')
			.AgregarMapeo('mathasta','mathasta')
			.AgregarMapeo('grudesde','grudesde')
			.AgregarMapeo('gruhasta','gruhasta')
			.AgregarMapeo('lisdesde','lisdesde')
			.AgregarMapeo('mobs','mobs')
			.AgregarMapeo('lishasta','lishasta')
			.AgregarMapeo('fpersond','fpersond')
			.AgregarMapeo('fpersonh','fpersonh')
			.AgregarMapeo('clclasd','clclasd')
			.AgregarMapeo('clclash','clclash')
			.AgregarMapeo('clcodfantd','clcodfantd')
			.AgregarMapeo('clcodfanth','clcodfanth')
			.AgregarMapeo('cltipoclid','cltipoclid')
			.AgregarMapeo('cltipoclih','cltipoclih')
			.AgregarMapeo('clcateclid','clcateclid')
			.AgregarMapeo('clcateclih','clcateclih')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_COMISION'
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
				Update t Set t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.TIPAGRUPUB = isnull( d.TIPAGRUPUB, t.TIPAGRUPUB ),t.CODIGO = isnull( d.CODIGO, t.CODIGO ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FECHAFD = isnull( d.FECHAFD, t.FECHAFD ),t.DESCRIP = isnull( d.DESCRIP, t.DESCRIP ),t.UNIDESDE = isnull( d.UNIDESDE, t.UNIDESDE ),t.ARTDESDE = isnull( d.ARTDESDE, t.ARTDESDE ),t.SUCDESDE = isnull( d.SUCDESDE, t.SUCDESDE ),t.SEGSDESDE = isnull( d.SEGSDESDE, t.SEGSDESDE ),t.TIPSDESDE = isnull( d.TIPSDESDE, t.TIPSDESDE ),t.LINSDESDE = isnull( d.LINSDESDE, t.LINSDESDE ),t.FECHAH = isnull( d.FECHAH, t.FECHAH ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.ARTHASTA = isnull( d.ARTHASTA, t.ARTHASTA ),t.UNIHASTA = isnull( d.UNIHASTA, t.UNIHASTA ),t.SEGSHASTA = isnull( d.SEGSHASTA, t.SEGSHASTA ),t.SUCHASTA = isnull( d.SUCHASTA, t.SUCHASTA ),t.TIPSHASTA = isnull( d.TIPSHASTA, t.TIPSHASTA ),t.LINSHASTA = isnull( d.LINSHASTA, t.LINSHASTA ),t.FAMDESDE = isnull( d.FAMDESDE, t.FAMDESDE ),t.COLDESDE = isnull( d.COLDESDE, t.COLDESDE ),t.PORCENT = isnull( d.PORCENT, t.PORCENT ),t.CONFORMA1 = isnull( d.CONFORMA1, t.CONFORMA1 ),t.COLHASTA = isnull( d.COLHASTA, t.COLHASTA ),t.FAMHASTA = isnull( d.FAMHASTA, t.FAMHASTA ),t.CONFORMA2 = isnull( d.CONFORMA2, t.CONFORMA2 ),t.MONTOF = isnull( d.MONTOF, t.MONTOF ),t.TALDESDE = isnull( d.TALDESDE, t.TALDESDE ),t.LINDESDE = isnull( d.LINDESDE, t.LINDESDE ),t.TALHASTA = isnull( d.TALHASTA, t.TALHASTA ),t.LINHASTA = isnull( d.LINHASTA, t.LINHASTA ),t.PROVDESDE = isnull( d.PROVDESDE, t.PROVDESDE ),t.CATDESDE = isnull( d.CATDESDE, t.CATDESDE ),t.PROVHASTA = isnull( d.PROVHASTA, t.PROVHASTA ),t.CATHASTA = isnull( d.CATHASTA, t.CATHASTA ),t.TEMDESDE = isnull( d.TEMDESDE, t.TEMDESDE ),t.CLADESDE = isnull( d.CLADESDE, t.CLADESDE ),t.TEMHASTA = isnull( d.TEMHASTA, t.TEMHASTA ),t.CLAHASTA = isnull( d.CLAHASTA, t.CLAHASTA ),t.ANODESDE = isnull( d.ANODESDE, t.ANODESDE ),t.TIPDESDE = isnull( d.TIPDESDE, t.TIPDESDE ),t.ANOHASTA = isnull( d.ANOHASTA, t.ANOHASTA ),t.TIPHASTA = isnull( d.TIPHASTA, t.TIPHASTA ),t.MATDESDE = isnull( d.MATDESDE, t.MATDESDE ),t.MATHASTA = isnull( d.MATHASTA, t.MATHASTA ),t.GRUDESDE = isnull( d.GRUDESDE, t.GRUDESDE ),t.GRUHASTA = isnull( d.GRUHASTA, t.GRUHASTA ),t.LISDESDE = isnull( d.LISDESDE, t.LISDESDE ),t.MOBS = isnull( d.MOBS, t.MOBS ),t.LISHASTA = isnull( d.LISHASTA, t.LISHASTA ),t.FPERSOND = isnull( d.FPERSOND, t.FPERSOND ),t.FPERSONH = isnull( d.FPERSONH, t.FPERSONH ),t.CLCLASD = isnull( d.CLCLASD, t.CLCLASD ),t.CLCLASH = isnull( d.CLCLASH, t.CLCLASH ),t.CLCODFANTD = isnull( d.CLCODFANTD, t.CLCODFANTD ),t.CLCODFANTH = isnull( d.CLCODFANTH, t.CLCODFANTH ),t.CLTIPOCLID = isnull( d.CLTIPOCLID, t.CLTIPOCLID ),t.CLTIPOCLIH = isnull( d.CLTIPOCLIH, t.CLTIPOCLIH ),t.CLCATECLID = isnull( d.CLCATECLID, t.CLCATECLID ),t.CLCATECLIH = isnull( d.CLCATECLIH, t.CLCATECLIH )
					from ZooLogic.COMISION t inner join deleted d 
							 on t.CODIGO = d.CODIGO
				-- Fin Updates
				insert into ZooLogic.COMISION(Fecimpo,Fecexpo,Fectrans,Faltafw,Bdaltafw,Bdmodifw,Esttrans,Haltafw,Valtafw,Zadsfw,Vmodifw,Umodifw,Ualtafw,Horaimpo,Smodifw,Saltafw,Horaexpo,Tipagrupub,Codigo,Fmodifw,Fechafd,Descrip,Unidesde,Artdesde,Sucdesde,Segsdesde,Tipsdesde,Linsdesde,Fechah,Hmodifw,Arthasta,Unihasta,Segshasta,Suchasta,Tipshasta,Linshasta,Famdesde,Coldesde,Porcent,Conforma1,Colhasta,Famhasta,Conforma2,Montof,Taldesde,Lindesde,Talhasta,Linhasta,Provdesde,Catdesde,Provhasta,Cathasta,Temdesde,Cladesde,Temhasta,Clahasta,Anodesde,Tipdesde,Anohasta,Tiphasta,Matdesde,Mathasta,Grudesde,Gruhasta,Lisdesde,Mobs,Lishasta,Fpersond,Fpersonh,Clclasd,Clclash,Clcodfantd,Clcodfanth,Cltipoclid,Cltipoclih,Clcateclid,Clcateclih)
					Select isnull( d.FECIMPO,''),isnull( d.FECEXPO,''),isnull( d.FECTRANS,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.BDALTAFW,''),isnull( d.BDMODIFW,''),isnull( d.ESTTRANS,''),convert( char(8), getdate(), 108 ),isnull( d.VALTAFW,''),isnull( d.ZADSFW,''),isnull( d.VMODIFW,''),isnull( d.UMODIFW,''),isnull( d.UALTAFW,''),isnull( d.HORAIMPO,''),isnull( d.SMODIFW,''),isnull( d.SALTAFW,''),isnull( d.HORAEXPO,''),isnull( d.TIPAGRUPUB,0),isnull( d.CODIGO,''),isnull( d.FMODIFW,''),isnull( d.FECHAFD,''),isnull( d.DESCRIP,''),isnull( d.UNIDESDE,''),isnull( d.ARTDESDE,''),isnull( d.SUCDESDE,''),isnull( d.SEGSDESDE,''),isnull( d.TIPSDESDE,''),isnull( d.LINSDESDE,''),isnull( d.FECHAH,''),isnull( d.HMODIFW,''),isnull( d.ARTHASTA,''),isnull( d.UNIHASTA,''),isnull( d.SEGSHASTA,''),isnull( d.SUCHASTA,''),isnull( d.TIPSHASTA,''),isnull( d.LINSHASTA,''),isnull( d.FAMDESDE,''),isnull( d.COLDESDE,''),isnull( d.PORCENT,0),isnull( d.CONFORMA1,''),isnull( d.COLHASTA,''),isnull( d.FAMHASTA,''),isnull( d.CONFORMA2,''),isnull( d.MONTOF,0),isnull( d.TALDESDE,''),isnull( d.LINDESDE,''),isnull( d.TALHASTA,''),isnull( d.LINHASTA,''),isnull( d.PROVDESDE,''),isnull( d.CATDESDE,''),isnull( d.PROVHASTA,''),isnull( d.CATHASTA,''),isnull( d.TEMDESDE,''),isnull( d.CLADESDE,''),isnull( d.TEMHASTA,''),isnull( d.CLAHASTA,''),isnull( d.ANODESDE,0),isnull( d.TIPDESDE,''),isnull( d.ANOHASTA,0),isnull( d.TIPHASTA,''),isnull( d.MATDESDE,''),isnull( d.MATHASTA,''),isnull( d.GRUDESDE,''),isnull( d.GRUHASTA,''),isnull( d.LISDESDE,''),isnull( d.MOBS,''),isnull( d.LISHASTA,''),isnull( d.FPERSOND,''),isnull( d.FPERSONH,''),isnull( d.CLCLASD,''),isnull( d.CLCLASH,''),isnull( d.CLCODFANTD,''),isnull( d.CLCODFANTH,''),isnull( d.CLTIPOCLID,''),isnull( d.CLTIPOCLIH,''),isnull( d.CLCATECLID,''),isnull( d.CLCATECLIH,'')
						From deleted d left join ZooLogic.COMISION pk 
							 on d.CODIGO = pk.CODIGO
						Where pk.CODIGO Is Null 
				-- Fin Inserts
			End
		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_AgruPubCOM( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_COMISION_AgruPubCOM
ON ZooLogic.TablaTrabajo_COMISION_AgruPubCOM
AFTER DELETE
As
Begin
Update t Set 
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.CODIGO = isnull( d.CODIGO, t.CODIGO ),
t.AGRUP = isnull( d.AGRUP, t.AGRUP ),
t.AGRUPDES = isnull( d.AGRUPDES, t.AGRUPDES )
from ZooLogic.AgruPubCOM t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.AgruPubCOM
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
From deleted d left join ZooLogic.AgruPubCOM pk 
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_COMISION') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_COMISION
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_COMISION' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_COMISION.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_COMISION.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_COMISION.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_COMISION.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Basededatosaltafw = nvl( c_COMISION.Basededatosaltafw, [] )
					.Basededatosmodificacionfw = nvl( c_COMISION.Basededatosmodificacionfw, [] )
					.Estadotransferencia = nvl( c_COMISION.Estadotransferencia, [] )
					.Horaaltafw = nvl( c_COMISION.Horaaltafw, [] )
					.Versionaltafw = nvl( c_COMISION.Versionaltafw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Versionmodificacionfw = nvl( c_COMISION.Versionmodificacionfw, [] )
					.Usuariomodificacionfw = nvl( c_COMISION.Usuariomodificacionfw, [] )
					.Usuarioaltafw = nvl( c_COMISION.Usuarioaltafw, [] )
					.Horaimpo = nvl( c_COMISION.Horaimpo, [] )
					.Seriemodificacionfw = nvl( c_COMISION.Seriemodificacionfw, [] )
					.Seriealtafw = nvl( c_COMISION.Seriealtafw, [] )
					.Horaexpo = nvl( c_COMISION.Horaexpo, [] )
					.Tipoagrupamientopublicaciones = nvl( c_COMISION.Tipoagrupamientopublicaciones, 0 )
					.Codigo = nvl( c_COMISION.Codigo, [] )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_COMISION.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechavigenciadesde = GoLibrerias.ObtenerFechaFormateada( nvl( c_COMISION.Fechavigenciadesde, ctod( '  /  /    ' ) ) )
					.Descripcion = nvl( c_COMISION.Descripcion, [] )
					.F_articulo_unidaddemedida_desde_PK =  nvl( c_COMISION.F_articulo_unidaddemedida_desde, [] )
					.F_articulo_desde_PK =  nvl( c_COMISION.F_articulo_desde, [] )
					.F_sucursal_codigo_desde_PK =  nvl( c_COMISION.F_sucursal_codigo_desde, [] )
					.F_sucursal_segmentacion_desde_PK =  nvl( c_COMISION.F_sucursal_segmentacion_desde, [] )
					.F_sucursal_tipo_desde_PK =  nvl( c_COMISION.F_sucursal_tipo_desde, [] )
					.F_sucursal_linea_desde_PK =  nvl( c_COMISION.F_sucursal_linea_desde, [] )
					if !.lEsSubEntidad
					.Agrupublidetalle.Limpiar()
					.Agrupublidetalle.SetearEsNavegacion( .lProcesando )
					.Agrupublidetalle.Cargar()
					endif
					.Fechavigenciahasta = GoLibrerias.ObtenerFechaFormateada( nvl( c_COMISION.Fechavigenciahasta, ctod( '  /  /    ' ) ) )
					.Horamodificacionfw = nvl( c_COMISION.Horamodificacionfw, [] )
					.F_articulo_hasta_PK =  nvl( c_COMISION.F_articulo_hasta, [] )
					.F_articulo_unidaddemedida_hasta_PK =  nvl( c_COMISION.F_articulo_unidaddemedida_hasta, [] )
					.F_sucursal_segmentacion_hasta_PK =  nvl( c_COMISION.F_sucursal_segmentacion_hasta, [] )
					.F_sucursal_codigo_hasta_PK =  nvl( c_COMISION.F_sucursal_codigo_hasta, [] )
					.F_sucursal_tipo_hasta_PK =  nvl( c_COMISION.F_sucursal_tipo_hasta, [] )
					.F_sucursal_linea_hasta_PK =  nvl( c_COMISION.F_sucursal_linea_hasta, [] )
					.F_articulo_familia_desde_PK =  nvl( c_COMISION.F_articulo_familia_desde, [] )
					.F_color_desde_PK =  nvl( c_COMISION.F_color_desde, [] )
					.Porcentaje = nvl( c_COMISION.Porcentaje, 0 )
					.Conformacion1 = nvl( c_COMISION.Conformacion1, [] )
					.F_color_hasta_PK =  nvl( c_COMISION.F_color_hasta, [] )
					.F_articulo_familia_hasta_PK =  nvl( c_COMISION.F_articulo_familia_hasta, [] )
					.Conformacion2 = nvl( c_COMISION.Conformacion2, [] )
					.Montofijo = nvl( c_COMISION.Montofijo, 0 )
					.F_talle_desde_PK =  nvl( c_COMISION.F_talle_desde, [] )
					.F_articulo_linea_desde_PK =  nvl( c_COMISION.F_articulo_linea_desde, [] )
					.F_talle_hasta_PK =  nvl( c_COMISION.F_talle_hasta, [] )
					.F_articulo_linea_hasta_PK =  nvl( c_COMISION.F_articulo_linea_hasta, [] )
					.F_articulo_proveedor_desde_PK =  nvl( c_COMISION.F_articulo_proveedor_desde, [] )
					.F_articulo_categoriadearticulo_desde_PK =  nvl( c_COMISION.F_articulo_categoriadearticulo_desde, [] )
					.F_articulo_proveedor_hasta_PK =  nvl( c_COMISION.F_articulo_proveedor_hasta, [] )
					.F_articulo_categoriadearticulo_hasta_PK =  nvl( c_COMISION.F_articulo_categoriadearticulo_hasta, [] )
					.F_articulo_temporada_desde_PK =  nvl( c_COMISION.F_articulo_temporada_desde, [] )
					.F_articulo_clasificacion_desde_PK =  nvl( c_COMISION.F_articulo_clasificacion_desde, [] )
					.F_articulo_temporada_hasta_PK =  nvl( c_COMISION.F_articulo_temporada_hasta, [] )
					.F_articulo_clasificacion_hasta_PK =  nvl( c_COMISION.F_articulo_clasificacion_hasta, [] )
					.F_articulo_ano_desde = nvl( c_COMISION.F_articulo_ano_desde, 0 )
					.F_articulo_tipodearticulo_desde_PK =  nvl( c_COMISION.F_articulo_tipodearticulo_desde, [] )
					.F_articulo_ano_hasta = nvl( c_COMISION.F_articulo_ano_hasta, 0 )
					.F_articulo_tipodearticulo_hasta_PK =  nvl( c_COMISION.F_articulo_tipodearticulo_hasta, [] )
					.F_articulo_material_desde_PK =  nvl( c_COMISION.F_articulo_material_desde, [] )
					.F_articulo_material_hasta_PK =  nvl( c_COMISION.F_articulo_material_hasta, [] )
					.F_articulo_grupo_desde_PK =  nvl( c_COMISION.F_articulo_grupo_desde, [] )
					.F_articulo_grupo_hasta_PK =  nvl( c_COMISION.F_articulo_grupo_hasta, [] )
					.F_listadeprecio_codigo_desde_PK =  nvl( c_COMISION.F_listadeprecio_codigo_desde, [] )
					lcValor = This.ObtenerMemo( 'c_Observacion')
					.Observacion = lcValor 
					.F_listadeprecio_codigo_hasta_PK =  nvl( c_COMISION.F_listadeprecio_codigo_hasta, [] )
					.F_cliente_desde_PK =  nvl( c_COMISION.F_cliente_desde, [] )
					.F_cliente_hasta_PK =  nvl( c_COMISION.F_cliente_hasta, [] )
					.F_cliente_clasificacion_desde_PK =  nvl( c_COMISION.F_cliente_clasificacion_desde, [] )
					.F_cliente_clasificacion_hasta_PK =  nvl( c_COMISION.F_cliente_clasificacion_hasta, [] )
					.F_cliente_nfantasia_desde_PK =  nvl( c_COMISION.F_cliente_nfantasia_desde, [] )
					.F_cliente_nfantasia_hasta_PK =  nvl( c_COMISION.F_cliente_nfantasia_hasta, [] )
					.F_cliente_tipo_desde_PK =  nvl( c_COMISION.F_cliente_tipo_desde, [] )
					.F_cliente_tipo_hasta_PK =  nvl( c_COMISION.F_cliente_tipo_hasta, [] )
					.F_cliente_categoria_desde_PK =  nvl( c_COMISION.F_cliente_categoria_desde, [] )
					.F_cliente_categoria_hasta_PK =  nvl( c_COMISION.F_cliente_categoria_hasta, [] )
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
		return c_COMISION.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.COMISION' )
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
								from ZooLogic.COMISION 
								Where   COMISION.CODIGO != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "COMISION", "", lcCursor, set("Datasession") )
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
			"Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Horaimpo" as "Horaimpo", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Horaexpo" as "Horaexpo", "Tipagrupub" as "Tipoagrupamientopublicaciones", "Codigo" as "Codigo", "Fmodifw" as "Fechamodificacionfw", "Fechafd" as "Fechavigenciadesde", "Descrip" as "Descripcion", "Unidesde" as "F_articulo_unidaddemedida_desde", "Artdesde" as "F_articulo_desde", "Sucdesde" as "F_sucursal_codigo_desde", "Segsdesde" as "F_sucursal_segmentacion_desde", "Tipsdesde" as "F_sucursal_tipo_desde", "Linsdesde" as "F_sucursal_linea_desde", "Fechah" as "Fechavigenciahasta", "Hmodifw" as "Horamodificacionfw", "Arthasta" as "F_articulo_hasta", "Unihasta" as "F_articulo_unidaddemedida_hasta", "Segshasta" as "F_sucursal_segmentacion_hasta", "Suchasta" as "F_sucursal_codigo_hasta", "Tipshasta" as "F_sucursal_tipo_hasta", "Linshasta" as "F_sucursal_linea_hasta", "Famdesde" as "F_articulo_familia_desde", "Coldesde" as "F_color_desde", "Porcent" as "Porcentaje", "Conforma1" as "Conformacion1", "Colhasta" as "F_color_hasta", "Famhasta" as "F_articulo_familia_hasta", "Conforma2" as "Conformacion2", "Montof" as "Montofijo", "Taldesde" as "F_talle_desde", "Lindesde" as "F_articulo_linea_desde", "Talhasta" as "F_talle_hasta", "Linhasta" as "F_articulo_linea_hasta", "Provdesde" as "F_articulo_proveedor_desde", "Catdesde" as "F_articulo_categoriadearticulo_desde", "Provhasta" as "F_articulo_proveedor_hasta", "Cathasta" as "F_articulo_categoriadearticulo_hasta", "Temdesde" as "F_articulo_temporada_desde", "Cladesde" as "F_articulo_clasificacion_desde", "Temhasta" as "F_articulo_temporada_hasta", "Clahasta" as "F_articulo_clasificacion_hasta", "Anodesde" as "F_articulo_ano_desde", "Tipdesde" as "F_articulo_tipodearticulo_desde", "Anohasta" as "F_articulo_ano_hasta", "Tiphasta" as "F_articulo_tipodearticulo_hasta", "Matdesde" as "F_articulo_material_desde", "Mathasta" as "F_articulo_material_hasta", "Grudesde" as "F_articulo_grupo_desde", "Gruhasta" as "F_articulo_grupo_hasta", "Lisdesde" as "F_listadeprecio_codigo_desde", "Mobs" as "Observacion", "Lishasta" as "F_listadeprecio_codigo_hasta", "Fpersond" as "F_cliente_desde", "Fpersonh" as "F_cliente_hasta", "Clclasd" as "F_cliente_clasificacion_desde", "Clclash" as "F_cliente_clasificacion_hasta", "Clcodfantd" as "F_cliente_nfantasia_desde", "Clcodfanth" as "F_cliente_nfantasia_hasta", "Cltipoclid" as "F_cliente_tipo_desde", "Cltipoclih" as "F_cliente_tipo_hasta", "Clcateclid" as "F_cliente_categoria_desde", "Clcateclih" as "F_cliente_categoria_hasta"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.COMISION 
								Where   COMISION.CODIGO != ''
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
	Tabla = 'COMISION'
	Filtro = " COMISION.CODIGO != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " COMISION.CODIGO != ''"
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
	<row entidad="COMISION                                " atributo="FECHAIMPO                               " tabla="COMISION       " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMISION                                " atributo="FECHAEXPO                               " tabla="COMISION       " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMISION                                " atributo="FECHATRANSFERENCIA                      " tabla="COMISION       " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha de novedad                                                                                                                                                " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMISION                                " atributo="FECHAALTAFW                             " tabla="COMISION       " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMISION                                " atributo="BASEDEDATOSALTAFW                       " tabla="COMISION       " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMISION                                " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="COMISION       " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMISION                                " atributo="ESTADOTRANSFERENCIA                     " tabla="COMISION       " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado de novedad                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMISION                                " atributo="HORAALTAFW                              " tabla="COMISION       " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMISION                                " atributo="VERSIONALTAFW                           " tabla="COMISION       " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMISION                                " atributo="ZADSFW                                  " tabla="COMISION       " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMISION                                " atributo="VERSIONMODIFICACIONFW                   " tabla="COMISION       " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMISION                                " atributo="USUARIOMODIFICACIONFW                   " tabla="COMISION       " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMISION                                " atributo="USUARIOALTAFW                           " tabla="COMISION       " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMISION                                " atributo="HORAIMPO                                " tabla="COMISION       " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMISION                                " atributo="SERIEMODIFICACIONFW                     " tabla="COMISION       " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMISION                                " atributo="SERIEALTAFW                             " tabla="COMISION       " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMISION                                " atributo="HORAEXPO                                " tabla="COMISION       " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMISION                                " atributo="TIPOAGRUPAMIENTOPUBLICACIONES           " tabla="COMISION       " campo="TIPAGRUPUB" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMISION                                " atributo="CODIGO                                  " tabla="COMISION       " campo="CODIGO    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="2" etiqueta="Código                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMISION                                " atributo="FECHAMODIFICACIONFW                     " tabla="COMISION       " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="14" etiqueta="Registrado el                                                                                                                                                   " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="4" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMISION                                " atributo="FECHAVIGENCIADESDE                      " tabla="COMISION       " campo="FECHAFD   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goServicios.librerias.ObtenerFecha()                                                                                                                                                                                                                         " obligatorio="true" admitebusqueda="6" etiqueta="Desde                                                                                                                                                           " dominio="FECHACALENDARIO               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="5" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMISION                                " atributo="DESCRIPCION                             " tabla="COMISION       " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="4" etiqueta="Descripción                                                                                                                                                     " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMISION                                " atributo="F_ARTICULO_UNIDADDEMEDIDA_DESDE         " tabla="COMISION       " campo="UNIDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="UNIDADDEMEDIDA                          " tipodato="C         " longitud="3" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="Unidad de medida desde                                                                                                                                          " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="10" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMISION                                " atributo="F_ARTICULO_DESDE                        " tabla="COMISION       " campo="ARTDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="ARTICULO                                " tipodato="C         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="402" etiqueta="Artículo desde                                                                                                                                                  " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMISION                                " atributo="F_SUCURSAL_CODIGO_DESDE                 " tabla="COMISION       " campo="SUCDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="SUCURSAL                                " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="404" etiqueta="Sucursal desde                                                                                                                                                  " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="16" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMISION                                " atributo="F_SUCURSAL_SEGMENTACION_DESDE           " tabla="COMISION       " campo="SEGSDESDE " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="SEGMENTACION                            " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="406" etiqueta="Segmentación de sucursal desde                                                                                                                                  " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="19" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMISION                                " atributo="F_SUCURSAL_TIPO_DESDE                   " tabla="COMISION       " campo="TIPSDESDE " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="TIPOSUCURSAL                            " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="408" etiqueta="Tipo de sucursal desde                                                                                                                                          " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="17" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMISION                                " atributo="F_SUCURSAL_LINEA_DESDE                  " tabla="COMISION       " campo="LINSDESDE " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="LINEASUCURSAL                           " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="410" etiqueta="Línea de sucursal desde                                                                                                                                         " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="18" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMISION                                " atributo="AGRUPUBLIDETALLE                        " tabla="AGRUPUBCOM     " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Agrupamientos                                                                                                                                                   " dominio="DETALLEITEMAGRUPAPUBLICCOM    " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="1" alta="false" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMISION                                " atributo="FECHAVIGENCIAHASTA                      " tabla="COMISION       " campo="FECHAH    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goServicios.librerias.ObtenerFecha()+90                                                                                                                                                                                                                      " obligatorio="true" admitebusqueda="8" etiqueta="Hasta                                                                                                                                                           " dominio="FECHACALENDARIO               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="5" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMISION                                " atributo="HORAMODIFICACIONFW                      " tabla="COMISION       " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="16" etiqueta="A las                                                                                                                                                           " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="4" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMISION                                " atributo="F_ARTICULO_HASTA                        " tabla="COMISION       " campo="ARTHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="ARTICULO                                " tipodato="C         " longitud="15" decimales="0" valorsugerido="=Replicate( &quot;Z&quot;,15)                                                                                                                                                                                                                                           " obligatorio="false" admitebusqueda="412" etiqueta="Artículo hasta                                                                                                                                                  " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMISION                                " atributo="F_ARTICULO_UNIDADDEMEDIDA_HASTA         " tabla="COMISION       " campo="UNIHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="UNIDADDEMEDIDA                          " tipodato="C         " longitud="3" decimales="0" valorsugerido="=Replicate( &quot;Z&quot;,3)                                                                                                                                                                                                                                            " obligatorio="false" admitebusqueda="414" etiqueta="Unidad de medida hasta                                                                                                                                          " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="10" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMISION                                " atributo="F_SUCURSAL_SEGMENTACION_HASTA           " tabla="COMISION       " campo="SEGSHASTA " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="SEGMENTACION                            " tipodato="C         " longitud="10" decimales="0" valorsugerido="=Replicate( &quot;Z&quot;,10)                                                                                                                                                                                                                                           " obligatorio="false" admitebusqueda="416" etiqueta="Segmentación de sucursal hasta                                                                                                                                  " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="19" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMISION                                " atributo="F_SUCURSAL_CODIGO_HASTA                 " tabla="COMISION       " campo="SUCHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="SUCURSAL                                " tipodato="C         " longitud="10" decimales="0" valorsugerido="=Replicate( &quot;Z&quot;,10 )                                                                                                                                                                                                                                          " obligatorio="false" admitebusqueda="418" etiqueta="Sucursal hasta                                                                                                                                                  " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="16" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMISION                                " atributo="F_SUCURSAL_TIPO_HASTA                   " tabla="COMISION       " campo="TIPSHASTA " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="TIPOSUCURSAL                            " tipodato="C         " longitud="10" decimales="0" valorsugerido="=Replicate( &quot;Z&quot;,10)                                                                                                                                                                                                                                           " obligatorio="false" admitebusqueda="420" etiqueta="Tipo de sucursal hasta                                                                                                                                          " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="17" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMISION                                " atributo="F_SUCURSAL_LINEA_HASTA                  " tabla="COMISION       " campo="LINSHASTA " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="LINEASUCURSAL                           " tipodato="C         " longitud="10" decimales="0" valorsugerido="=Replicate( &quot;Z&quot;,10)                                                                                                                                                                                                                                           " obligatorio="false" admitebusqueda="422" etiqueta="Línea de sucursal hasta                                                                                                                                         " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="18" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMISION                                " atributo="F_ARTICULO_FAMILIA_DESDE                " tabla="COMISION       " campo="FAMDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="FAMILIA                                 " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="424" etiqueta="Familia desde                                                                                                                                                   " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="11" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMISION                                " atributo="F_COLOR_DESDE                           " tabla="COMISION       " campo="COLDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="COLOR                                   " tipodato="C         " longitud="6" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="426" etiqueta="Color desde                                                                                                                                                     " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMISION                                " atributo="PORCENTAJE                              " tabla="COMISION       " campo="PORCENT   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="7" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="10" etiqueta="Porcentaje                                                                                                                                                      " dominio="NUMERICOCONSIGNO              " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="7" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMISION                                " atributo="CONFORMACION1                           " tabla="COMISION       " campo="CONFORMA1 " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="200" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Conformación                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="4" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMISION                                " atributo="F_COLOR_HASTA                           " tabla="COMISION       " campo="COLHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="COLOR                                   " tipodato="C         " longitud="6" decimales="0" valorsugerido="=Replicate( &quot;Z&quot;,6 )                                                                                                                                                                                                                                           " obligatorio="false" admitebusqueda="428" etiqueta="Color hasta                                                                                                                                                     " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMISION                                " atributo="F_ARTICULO_FAMILIA_HASTA                " tabla="COMISION       " campo="FAMHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="FAMILIA                                 " tipodato="C         " longitud="10" decimales="0" valorsugerido="=Replicate( &quot;Z&quot;,10)                                                                                                                                                                                                                                           " obligatorio="false" admitebusqueda="430" etiqueta="Familia hasta                                                                                                                                                   " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="11" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMISION                                " atributo="CONFORMACION2                           " tabla="COMISION       " campo="CONFORMA2 " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="200" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Continuación                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="5" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMISION                                " atributo="MONTOFIJO                               " tabla="COMISION       " campo="MONTOF    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="12" etiqueta="Monto fijo                                                                                                                                                      " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="7" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMISION                                " atributo="F_TALLE_DESDE                           " tabla="COMISION       " campo="TALDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="TALLE                                   " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="432" etiqueta="Talle desde                                                                                                                                                     " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="3" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMISION                                " atributo="F_ARTICULO_LINEA_DESDE                  " tabla="COMISION       " campo="LINDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="LINEA                                   " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="434" etiqueta="Línea de artículo desde                                                                                                                                         " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="12" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMISION                                " atributo="F_TALLE_HASTA                           " tabla="COMISION       " campo="TALHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="TALLE                                   " tipodato="C         " longitud="5" decimales="0" valorsugerido="=Replicate( &quot;Z&quot;,5 )                                                                                                                                                                                                                                           " obligatorio="false" admitebusqueda="436" etiqueta="Talle hasta                                                                                                                                                     " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="3" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMISION                                " atributo="F_ARTICULO_LINEA_HASTA                  " tabla="COMISION       " campo="LINHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="LINEA                                   " tipodato="C         " longitud="10" decimales="0" valorsugerido="=Replicate( &quot;Z&quot;,10)                                                                                                                                                                                                                                           " obligatorio="false" admitebusqueda="438" etiqueta="Línea de artículo hasta                                                                                                                                         " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="12" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMISION                                " atributo="F_ARTICULO_PROVEEDOR_DESDE              " tabla="COMISION       " campo="PROVDESDE " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="PROVEEDOR                               " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="440" etiqueta="Proveedor desde                                                                                                                                                 " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="4" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMISION                                " atributo="F_ARTICULO_CATEGORIADEARTICULO_DESDE    " tabla="COMISION       " campo="CATDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CATEGORIADEARTICULO                     " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="442" etiqueta="Categoría de artículo desde                                                                                                                                     " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="13" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMISION                                " atributo="F_ARTICULO_PROVEEDOR_HASTA              " tabla="COMISION       " campo="PROVHASTA " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="PROVEEDOR                               " tipodato="C         " longitud="10" decimales="0" valorsugerido="=Replicate( &quot;Z&quot;,10)                                                                                                                                                                                                                                           " obligatorio="false" admitebusqueda="444" etiqueta="Proveedor hasta                                                                                                                                                 " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="4" orden="8" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMISION                                " atributo="F_ARTICULO_CATEGORIADEARTICULO_HASTA    " tabla="COMISION       " campo="CATHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CATEGORIADEARTICULO                     " tipodato="C         " longitud="10" decimales="0" valorsugerido="=Replicate( &quot;Z&quot;,10)                                                                                                                                                                                                                                           " obligatorio="false" admitebusqueda="446" etiqueta="Categoría de artículo hasta                                                                                                                                     " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="13" orden="8" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMISION                                " atributo="F_ARTICULO_TEMPORADA_DESDE              " tabla="COMISION       " campo="TEMDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="TEMPORADA                               " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="448" etiqueta="Temporada desde                                                                                                                                                 " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="5" orden="9" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMISION                                " atributo="F_ARTICULO_CLASIFICACION_DESDE          " tabla="COMISION       " campo="CLADESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CLASIFICACIONARTICULO                   " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="450" etiqueta="Clasificación desde                                                                                                                                             " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="14" orden="9" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMISION                                " atributo="F_ARTICULO_TEMPORADA_HASTA              " tabla="COMISION       " campo="TEMHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="TEMPORADA                               " tipodato="C         " longitud="5" decimales="0" valorsugerido="=Replicate( &quot;Z&quot;,5)                                                                                                                                                                                                                                            " obligatorio="false" admitebusqueda="452" etiqueta="Temporada hasta                                                                                                                                                 " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="5" orden="10" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMISION                                " atributo="F_ARTICULO_CLASIFICACION_HASTA          " tabla="COMISION       " campo="CLAHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CLASIFICACIONARTICULO                   " tipodato="C         " longitud="10" decimales="0" valorsugerido="=Replicate( &quot;Z&quot;,10)                                                                                                                                                                                                                                           " obligatorio="false" admitebusqueda="454" etiqueta="Clasificación hasta                                                                                                                                             " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="14" orden="10" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMISION                                " atributo="F_ARTICULO_ANO_DESDE                    " tabla="COMISION       " campo="ANODESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="4" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="456" etiqueta="Año desde                                                                                                                                                       " dominio="EtiquetaNumericoDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="6" orden="11" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMISION                                " atributo="F_ARTICULO_TIPODEARTICULO_DESDE         " tabla="COMISION       " campo="TIPDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="TIPODEARTICULO                          " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="458" etiqueta="Tipo de artículo desde                                                                                                                                          " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="15" orden="11" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMISION                                " atributo="F_ARTICULO_ANO_HASTA                    " tabla="COMISION       " campo="ANOHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="4" decimales="0" valorsugerido="9999                                                                                                                                                                                                                                                          " obligatorio="false" admitebusqueda="460" etiqueta="Año hasta                                                                                                                                                       " dominio="EtiquetaNumericoDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="6" orden="12" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMISION                                " atributo="F_ARTICULO_TIPODEARTICULO_HASTA         " tabla="COMISION       " campo="TIPHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="TIPODEARTICULO                          " tipodato="C         " longitud="10" decimales="0" valorsugerido="=Replicate( &quot;Z&quot;,10)                                                                                                                                                                                                                                           " obligatorio="false" admitebusqueda="462" etiqueta="Tipo de artículo hasta                                                                                                                                          " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="15" orden="12" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMISION                                " atributo="F_ARTICULO_MATERIAL_DESDE               " tabla="COMISION       " campo="MATDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="MATERIAL                                " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="464" etiqueta="Material desde                                                                                                                                                  " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="7" orden="13" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMISION                                " atributo="F_ARTICULO_MATERIAL_HASTA               " tabla="COMISION       " campo="MATHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="MATERIAL                                " tipodato="C         " longitud="10" decimales="0" valorsugerido="=Replicate( &quot;Z&quot;,10)                                                                                                                                                                                                                                           " obligatorio="false" admitebusqueda="466" etiqueta="Material hasta                                                                                                                                                  " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="7" orden="14" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMISION                                " atributo="F_ARTICULO_GRUPO_DESDE                  " tabla="COMISION       " campo="GRUDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="GRUPO                                   " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="468" etiqueta="Grupo desde                                                                                                                                                     " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="8" orden="15" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMISION                                " atributo="F_ARTICULO_GRUPO_HASTA                  " tabla="COMISION       " campo="GRUHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="GRUPO                                   " tipodato="C         " longitud="10" decimales="0" valorsugerido="=Replicate( &quot;Z&quot;,10)                                                                                                                                                                                                                                           " obligatorio="false" admitebusqueda="470" etiqueta="Grupo hasta                                                                                                                                                     " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="8" orden="16" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMISION                                " atributo="F_LISTADEPRECIO_CODIGO_DESDE            " tabla="COMISION       " campo="LISDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="LISTADEPRECIOS                          " tipodato="C         " longitud="6" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="472" etiqueta="Lista de precios desde                                                                                                                                          " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="10" orden="19" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMISION                                " atributo="OBSERVACION                             " tabla="COMISION       " campo="MOBS      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="474" etiqueta="Observaciones                                                                                                                                                   " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="8" orden="20" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMISION                                " atributo="F_LISTADEPRECIO_CODIGO_HASTA            " tabla="COMISION       " campo="LISHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="LISTADEPRECIOS                          " tipodato="C         " longitud="6" decimales="0" valorsugerido="=Replicate( &quot;Z&quot;,6)                                                                                                                                                                                                                                            " obligatorio="false" admitebusqueda="476" etiqueta="Lista de precios hasta                                                                                                                                          " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="10" orden="20" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMISION                                " atributo="F_CLIENTE_DESDE                         " tabla="COMISION       " campo="FPERSOND  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CLIENTE                                 " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="478" etiqueta="Cliente desde                                                                                                                                                   " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="20" orden="21" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMISION                                " atributo="F_CLIENTE_HASTA                         " tabla="COMISION       " campo="FPERSONH  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CLIENTE                                 " tipodato="C         " longitud="10" decimales="0" valorsugerido="=Replicate( &quot;Z&quot;,10)                                                                                                                                                                                                                                           " obligatorio="false" admitebusqueda="480" etiqueta="Cliente hasta                                                                                                                                                   " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="20" orden="22" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMISION                                " atributo="F_CLIENTE_CLASIFICACION_DESDE           " tabla="COMISION       " campo="CLCLASD   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CLASIFICACIONCLIENTE                    " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="482" etiqueta="Clasificación cliente desde                                                                                                                                     " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="21" orden="23" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMISION                                " atributo="F_CLIENTE_CLASIFICACION_HASTA           " tabla="COMISION       " campo="CLCLASH   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CLASIFICACIONCLIENTE                    " tipodato="C         " longitud="10" decimales="0" valorsugerido="=Replicate( &quot;Z&quot;,10)                                                                                                                                                                                                                                           " obligatorio="false" admitebusqueda="484" etiqueta="Clasificación cliente hasta                                                                                                                                     " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="21" orden="24" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMISION                                " atributo="F_CLIENTE_NFANTASIA_DESDE               " tabla="COMISION       " campo="CLCODFANTD" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="NOMBREDEFANTASIA                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="486" etiqueta="Nombre de fantasía del cliente desde                                                                                                                            " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="22" orden="25" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMISION                                " atributo="F_CLIENTE_NFANTASIA_HASTA               " tabla="COMISION       " campo="CLCODFANTH" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="NOMBREDEFANTASIA                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="=Replicate( &quot;Z&quot;,50)                                                                                                                                                                                                                                           " obligatorio="false" admitebusqueda="488" etiqueta="Nombre de fantasía del cliente hasta                                                                                                                            " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="22" orden="26" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMISION                                " atributo="F_CLIENTE_TIPO_DESDE                    " tabla="COMISION       " campo="CLTIPOCLID" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="TIPOCLIENTE                             " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="490" etiqueta="Tipo de cliente desde                                                                                                                                           " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="23" orden="27" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMISION                                " atributo="F_CLIENTE_TIPO_HASTA                    " tabla="COMISION       " campo="CLTIPOCLIH" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="TIPOCLIENTE                             " tipodato="C         " longitud="10" decimales="0" valorsugerido="=Replicate( &quot;Z&quot;,10)                                                                                                                                                                                                                                           " obligatorio="false" admitebusqueda="492" etiqueta="Tipo de cliente hasta                                                                                                                                           " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="23" orden="28" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMISION                                " atributo="F_CLIENTE_CATEGORIA_DESDE               " tabla="COMISION       " campo="CLCATECLID" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CATEGORIACLIENTE                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="494" etiqueta="Categoría de cliente desde                                                                                                                                      " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="24" orden="29" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMISION                                " atributo="F_CLIENTE_CATEGORIA_HASTA               " tabla="COMISION       " campo="CLCATECLIH" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CATEGORIACLIENTE                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="=Replicate( &quot;Z&quot;,10)                                                                                                                                                                                                                                           " obligatorio="false" admitebusqueda="496" etiqueta="Categoría de cliente hasta                                                                                                                                      " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="24" orden="30" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="UNIDADDEMEDIDA                          " atributo="DESCRIPCION                             " tabla="UNMED          " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="401" etiqueta="Detalle Uni.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join UNMED On COMISION.UNIDESDE = UNMED.Cod And  UNMED.COD != ''                                                                                                                                                                                        " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="DESCRIPCION                             " tabla="ART            " campo="ARTDES    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="403" etiqueta="Detalle Art.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join ART On COMISION.ARTDESDE = ART.ARTCOD And  ART.ARTCOD != ''                                                                                                                                                                                        " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSAL                                " atributo="DESCRIPCION                             " tabla="SUC            " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="405" etiqueta="Detalle Suc.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join SUC On COMISION.SUCDESDE = SUC.codigo And  SUC.CODIGO != ''                                                                                                                                                                                        " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SEGMENTACION                            " atributo="DESCRIPCION                             " tabla="SECOD          " campo="SDES      " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="407" etiqueta="Detalle Seg.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join SECOD On COMISION.SEGSDESDE = SECOD.SCOD And  SECOD.SCOD != ''                                                                                                                                                                                     " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIPOSUCURSAL                            " atributo="DESCRIPCION                             " tabla="TSUCUR         " campo="TDES      " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="409" etiqueta="Detalle Tip.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join TSUCUR On COMISION.TIPSDESDE = TSUCUR.TCOD And  TSUCUR.TCOD != ''                                                                                                                                                                                  " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LINEASUCURSAL                           " atributo="DESCRIPCION                             " tabla="LSUCUR         " campo="LSDES     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="411" etiqueta="Detalle Lín.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join LSUCUR On COMISION.LINSDESDE = LSUCUR.LSCOD And  LSUCUR.LSCOD != ''                                                                                                                                                                                " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="DESCRIPCION                             " tabla="ART            " campo="ARTDES    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="413" etiqueta="Detalle Art.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join ART On COMISION.ARTHASTA = ART.ARTCOD And  ART.ARTCOD != ''                                                                                                                                                                                        " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="UNIDADDEMEDIDA                          " atributo="DESCRIPCION                             " tabla="UNMED          " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="415" etiqueta="Detalle Uni.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join UNMED On COMISION.UNIHASTA = UNMED.Cod And  UNMED.COD != ''                                                                                                                                                                                        " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SEGMENTACION                            " atributo="DESCRIPCION                             " tabla="SECOD          " campo="SDES      " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="417" etiqueta="Detalle Seg.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join SECOD On COMISION.SEGSHASTA = SECOD.SCOD And  SECOD.SCOD != ''                                                                                                                                                                                     " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSAL                                " atributo="DESCRIPCION                             " tabla="SUC            " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="419" etiqueta="Detalle Suc.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join SUC On COMISION.SUCHASTA = SUC.codigo And  SUC.CODIGO != ''                                                                                                                                                                                        " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIPOSUCURSAL                            " atributo="DESCRIPCION                             " tabla="TSUCUR         " campo="TDES      " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="421" etiqueta="Detalle Tip.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join TSUCUR On COMISION.TIPSHASTA = TSUCUR.TCOD And  TSUCUR.TCOD != ''                                                                                                                                                                                  " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LINEASUCURSAL                           " atributo="DESCRIPCION                             " tabla="LSUCUR         " campo="LSDES     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="423" etiqueta="Detalle Lín.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join LSUCUR On COMISION.LINSHASTA = LSUCUR.LSCOD And  LSUCUR.LSCOD != ''                                                                                                                                                                                " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FAMILIA                                 " atributo="DESCRIPCION                             " tabla="FAMILIA        " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="425" etiqueta="Detalle Fam.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join FAMILIA On COMISION.FAMDESDE = FAMILIA.Cod And  FAMILIA.COD != ''                                                                                                                                                                                  " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COLOR                                   " atributo="DESCRIPCION                             " tabla="COL            " campo="COLDES    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="427" etiqueta="Detalle Col.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join COL On COMISION.COLDESDE = COL.COLCOD And  COL.COLCOD != ''                                                                                                                                                                                        " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COLOR                                   " atributo="DESCRIPCION                             " tabla="COL            " campo="COLDES    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="429" etiqueta="Detalle Col.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join COL On COMISION.COLHASTA = COL.COLCOD And  COL.COLCOD != ''                                                                                                                                                                                        " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FAMILIA                                 " atributo="DESCRIPCION                             " tabla="FAMILIA        " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="431" etiqueta="Detalle Fam.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join FAMILIA On COMISION.FAMHASTA = FAMILIA.Cod And  FAMILIA.COD != ''                                                                                                                                                                                  " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TALLE                                   " atributo="DESCRIPCION                             " tabla="TALLE          " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="433" etiqueta="Detalle Tal.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join TALLE On COMISION.TALDESDE = TALLE.Codigo And  TALLE.CODIGO != ''                                                                                                                                                                                  " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LINEA                                   " atributo="DESCRIPCION                             " tabla="LINEA          " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="435" etiqueta="Detalle Lín.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join LINEA On COMISION.LINDESDE = LINEA.Cod And  LINEA.COD != ''                                                                                                                                                                                        " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TALLE                                   " atributo="DESCRIPCION                             " tabla="TALLE          " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="437" etiqueta="Detalle Tal.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join TALLE On COMISION.TALHASTA = TALLE.Codigo And  TALLE.CODIGO != ''                                                                                                                                                                                  " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LINEA                                   " atributo="DESCRIPCION                             " tabla="LINEA          " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="439" etiqueta="Detalle Lín.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join LINEA On COMISION.LINHASTA = LINEA.Cod And  LINEA.COD != ''                                                                                                                                                                                        " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="NOMBRE                                  " tabla="PROV           " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="441" etiqueta="Detalle Pro.                                                                                                                                                    " dominio="TEXTOBUSQUEDA                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join PROV On COMISION.PROVDESDE = PROV.CLCOD And  PROV.CLCOD != ''                                                                                                                                                                                      " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="5" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CATEGORIADEARTICULO                     " atributo="DESCRIPCION                             " tabla="CATEGART       " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="443" etiqueta="Detalle Cat.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CATEGART On COMISION.CATDESDE = CATEGART.Cod And  CATEGART.COD != ''                                                                                                                                                                               " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="NOMBRE                                  " tabla="PROV           " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="445" etiqueta="Detalle Pro.                                                                                                                                                    " dominio="TEXTOBUSQUEDA                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join PROV On COMISION.PROVHASTA = PROV.CLCOD And  PROV.CLCOD != ''                                                                                                                                                                                      " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="5" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CATEGORIADEARTICULO                     " atributo="DESCRIPCION                             " tabla="CATEGART       " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="447" etiqueta="Detalle Cat.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CATEGART On COMISION.CATHASTA = CATEGART.Cod And  CATEGART.COD != ''                                                                                                                                                                               " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TEMPORADA                               " atributo="DESCRIPCION                             " tabla="TEMPORADA      " campo="TDES      " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="449" etiqueta="Detalle Tem.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join TEMPORADA On COMISION.TEMDESDE = TEMPORADA.TCOD And  TEMPORADA.TCOD != ''                                                                                                                                                                          " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLASIFICACIONARTICULO                   " atributo="DESCRIPCION                             " tabla="CLASIFART      " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="451" etiqueta="Detalle Cla.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CLASIFART On COMISION.CLADESDE = CLASIFART.CODIGO And  CLASIFART.CODIGO != ''                                                                                                                                                                      " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TEMPORADA                               " atributo="DESCRIPCION                             " tabla="TEMPORADA      " campo="TDES      " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="453" etiqueta="Detalle Tem.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join TEMPORADA On COMISION.TEMHASTA = TEMPORADA.TCOD And  TEMPORADA.TCOD != ''                                                                                                                                                                          " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLASIFICACIONARTICULO                   " atributo="DESCRIPCION                             " tabla="CLASIFART      " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="455" etiqueta="Detalle Cla.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CLASIFART On COMISION.CLAHASTA = CLASIFART.CODIGO And  CLASIFART.CODIGO != ''                                                                                                                                                                      " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIPODEARTICULO                          " atributo="DESCRIPCION                             " tabla="TIPOART        " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="459" etiqueta="Detalle Tip.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join TIPOART On COMISION.TIPDESDE = TIPOART.Cod And  TIPOART.COD != ''                                                                                                                                                                                  " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIPODEARTICULO                          " atributo="DESCRIPCION                             " tabla="TIPOART        " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="463" etiqueta="Detalle Tip.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join TIPOART On COMISION.TIPHASTA = TIPOART.Cod And  TIPOART.COD != ''                                                                                                                                                                                  " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MATERIAL                                " atributo="DESCRIPCION                             " tabla="MAT            " campo="MATDES    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="465" etiqueta="Detalle Mat.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join MAT On COMISION.MATDESDE = MAT.MATCOD And  MAT.MATCOD != ''                                                                                                                                                                                        " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MATERIAL                                " atributo="DESCRIPCION                             " tabla="MAT            " campo="MATDES    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="467" etiqueta="Detalle Mat.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join MAT On COMISION.MATHASTA = MAT.MATCOD And  MAT.MATCOD != ''                                                                                                                                                                                        " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="GRUPO                                   " atributo="DESCRIPCION                             " tabla="GRUPO          " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="469" etiqueta="Detalle Gru.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join GRUPO On COMISION.GRUDESDE = GRUPO.Cod And  GRUPO.COD != ''                                                                                                                                                                                        " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="GRUPO                                   " atributo="DESCRIPCION                             " tabla="GRUPO          " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="471" etiqueta="Detalle Gru.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join GRUPO On COMISION.GRUHASTA = GRUPO.Cod And  GRUPO.COD != ''                                                                                                                                                                                        " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADEPRECIOS                          " atributo="NOMBRE                                  " tabla="LPRECIO        " campo="LPR_NOMBRE" claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="473" etiqueta="Detalle Lis.                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join LPRECIO On COMISION.LISDESDE = LPRECIO.LPR_NUMERO And  LPRECIO.LPR_NUMERO != ''                                                                                                                                                                    " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADEPRECIOS                          " atributo="NOMBRE                                  " tabla="LPRECIO        " campo="LPR_NOMBRE" claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="477" etiqueta="Detalle Lis.                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join LPRECIO On COMISION.LISHASTA = LPRECIO.LPR_NUMERO And  LPRECIO.LPR_NUMERO != ''                                                                                                                                                                    " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="NOMBRE                                  " tabla="CLI            " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="185" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="479" etiqueta="Detalle Cli.                                                                                                                                                    " dominio="TEXTOBUSQUEDA                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CLI On COMISION.FPERSOND = CLI.CLCOD And  CLI.CLCOD != ''                                                                                                                                                                                          " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="5" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="NOMBRE                                  " tabla="CLI            " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="185" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="481" etiqueta="Detalle Cli.                                                                                                                                                    " dominio="TEXTOBUSQUEDA                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CLI On COMISION.FPERSONH = CLI.CLCOD And  CLI.CLCOD != ''                                                                                                                                                                                          " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="5" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLASIFICACIONCLIENTE                    " atributo="DESCRIPCION                             " tabla="CLASIF         " campo="CLADES    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="483" etiqueta="Detalle Cla.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CLASIF On COMISION.CLCLASD = CLASIF.CLACOD And  CLASIF.CLACOD != ''                                                                                                                                                                                " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLASIFICACIONCLIENTE                    " atributo="DESCRIPCION                             " tabla="CLASIF         " campo="CLADES    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="485" etiqueta="Detalle Cla.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CLASIF On COMISION.CLCLASH = CLASIF.CLACOD And  CLASIF.CLACOD != ''                                                                                                                                                                                " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOMBREDEFANTASIA                        " atributo="CODIGO                                  " tabla="NOMFANT        " campo="NFCOD     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="487" etiqueta="Detalle Nom.                                                                                                                                                    " dominio="CODIGOSINMUESTRARELACION      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join NOMFANT On COMISION.CLCODFANTD = NOMFANT.NFCOD And  NOMFANT.NFCOD != ''                                                                                                                                                                            " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOMBREDEFANTASIA                        " atributo="CODIGO                                  " tabla="NOMFANT        " campo="NFCOD     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="489" etiqueta="Detalle Nom.                                                                                                                                                    " dominio="CODIGOSINMUESTRARELACION      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join NOMFANT On COMISION.CLCODFANTH = NOMFANT.NFCOD And  NOMFANT.NFCOD != ''                                                                                                                                                                            " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIPOCLIENTE                             " atributo="DESCRIPCION                             " tabla="TIPOCLI        " campo="TCDES     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="491" etiqueta="Detalle Tip.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join TIPOCLI On COMISION.CLTIPOCLID = TIPOCLI.TCCOD And  TIPOCLI.TCCOD != ''                                                                                                                                                                            " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIPOCLIENTE                             " atributo="DESCRIPCION                             " tabla="TIPOCLI        " campo="TCDES     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="493" etiqueta="Detalle Tip.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join TIPOCLI On COMISION.CLTIPOCLIH = TIPOCLI.TCCOD And  TIPOCLI.TCCOD != ''                                                                                                                                                                            " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CATEGORIACLIENTE                        " atributo="DESCRIPCION                             " tabla="CATCLI         " campo="CGDES     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="495" etiqueta="Detalle Cat.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CATCLI On COMISION.CLCATECLID = CATCLI.CGCod And  CATCLI.CGCOD != ''                                                                                                                                                                               " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CATEGORIACLIENTE                        " atributo="DESCRIPCION                             " tabla="CATCLI         " campo="CGDES     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="497" etiqueta="Detalle Cat.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CATCLI On COMISION.CLCATECLIH = CATCLI.CGCod And  CATCLI.CGCOD != ''                                                                                                                                                                               " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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