
define class Din_EntidadCOMPLETARDESDEVENTASAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_COMPLETARDESDEVENTAS'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = []
	cExpresionCCPorCampos = []
	cTagClaveCandidata = ''
	cTagClavePk = '_CVEPK'
	cTablaPrincipal = 'COMPVTAS'
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
			local  lxCompvtasFecimpo, lxCompvtasFaltafw, lxCompvtasFecexpo, lxCompvtasFmodifw, lxCompvtasFectrans, lxCompvtasVmodifw, lxCompvtasZadsfw, lxCompvtasEsttrans, lxCompvtasBdaltafw, lxCompvtasBdmodifw, lxCompvtasUmodifw, lxCompvtasValtafw, lxCompvtasSmodifw, lxCompvtasSaltafw, lxCompvtasUaltafw, lxCompvtasHoraexpo, lxCompvtasHmodifw, lxCompvtasHaltafw, lxCompvtasHoraimpo, lxCompvtasCodigo, lxCompvtasFechadesde, lxCompvtasFechahasta, lxCompvtasBaseorig, lxCompvtasBasestock, lxCompvtasNocom, lxCompvtasArtdesde, lxCompvtasArthasta, lxCompvtasColdesde, lxCompvtasClidesde, lxCompvtasClidesde, lxCompvtasColhasta, lxCompvtasTaldesde, lxCompvtasTalhasta, lxCompvtasProdesde, lxCompvtasProhasta, lxCompvtasAnidesde, lxCompvtasAnihasta, lxCompvtasMatdesde, lxCompvtasMathasta, lxCompvtasClasidesde, lxCompvtasClasihasta, lxCompvtasUnidesde, lxCompvtasUnihasta, lxCompvtasNarbadesde, lxCompvtasNarbahasta, lxCompvtasPrecivades, lxCompvtasPrecivahas, lxCompvtasFecmoddesd, lxCompvtasFecmodhast, lxCompvtasFecaltades, lxCompvtasFecaltahas, lxCompvtasObs
				lxCompvtasFecimpo =  .Fechaimpo			lxCompvtasFaltafw =  .Fechaaltafw			lxCompvtasFecexpo =  .Fechaexpo			lxCompvtasFmodifw =  .Fechamodificacionfw			lxCompvtasFectrans =  .Fechatransferencia			lxCompvtasVmodifw =  .Versionmodificacionfw			lxCompvtasZadsfw =  .Zadsfw			lxCompvtasEsttrans =  .Estadotransferencia			lxCompvtasBdaltafw =  .Basededatosaltafw			lxCompvtasBdmodifw =  .Basededatosmodificacionfw			lxCompvtasUmodifw =  .Usuariomodificacionfw			lxCompvtasValtafw =  .Versionaltafw			lxCompvtasSmodifw =  .Seriemodificacionfw			lxCompvtasSaltafw =  .Seriealtafw			lxCompvtasUaltafw =  .Usuarioaltafw			lxCompvtasHoraexpo =  .Horaexpo			lxCompvtasHmodifw =  .Horamodificacionfw			lxCompvtasHaltafw =  .Horaaltafw			lxCompvtasHoraimpo =  .Horaimpo			lxCompvtasCodigo =  .Codigo			lxCompvtasFechadesde =  .Fechadesde			lxCompvtasFechahasta =  .Fechahasta			lxCompvtasBaseorig =  .Baseorigen			lxCompvtasBasestock =  .Basestock			lxCompvtasNocom =  .Nocomercializable			lxCompvtasArtdesde =  .F_articulo_desde			lxCompvtasArthasta =  .F_articulo_hasta			lxCompvtasColdesde =  .F_color_desde			lxCompvtasClidesde =  upper( .f_Cliente_Hasta_PK ) 			lxCompvtasClidesde =  upper( .f_Cliente_Desde_PK ) 			lxCompvtasColhasta =  .F_color_hasta			lxCompvtasTaldesde =  .F_talle_desde			lxCompvtasTalhasta =  .F_talle_hasta			lxCompvtasProdesde =  .F_articulo_proveedor_desde			lxCompvtasProhasta =  .F_articulo_proveedor_hasta			lxCompvtasAnidesde =  .F_articulo_anio_desde			lxCompvtasAnihasta =  .F_articulo_anio_hasta			lxCompvtasMatdesde =  .F_articulo_material_desde			lxCompvtasMathasta =  .F_articulo_material_hasta			lxCompvtasClasidesde =  .F_articulo_clasificacion_desde			lxCompvtasClasihasta =  .F_articulo_clasificacion_hasta			lxCompvtasUnidesde =  .F_articulo_unidad_desde			lxCompvtasUnihasta =  .F_articulo_unidad_hasta			lxCompvtasNarbadesde =  .F_articulo_nomenclador_desde			lxCompvtasNarbahasta =  .F_articulo_nomenclador_hasta			lxCompvtasPrecivades =  .F_precioconimpuestos_desde			lxCompvtasPrecivahas =  .F_precioconimpuestos_hasta			lxCompvtasFecmoddesd =  .F_articulo_fechamodificacionfw_desde			lxCompvtasFecmodhast =  .F_articulo_fechamodificacionfw_hasta			lxCompvtasFecaltades =  .F_articulo_fechaaltafw_desde			lxCompvtasFecaltahas =  .F_articulo_fechaaltafw_hasta			lxCompvtasObs =  .Observacion
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxCompvtasCodigo = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.COMPVTAS ( "Fecimpo","Faltafw","Fecexpo","Fmodifw","Fectrans","Vmodifw","Zadsfw","Esttrans","Bdaltafw","Bdmodifw","Umodifw","Valtafw","Smodifw","Saltafw","Ualtafw","Horaexpo","Hmodifw","Haltafw","Horaimpo","Codigo","Fechadesde","Fechahasta","Baseorig","Basestock","Nocom","Artdesde","Arthasta","Coldesde","Clidesde","Colhasta","Taldesde","Talhasta","Prodesde","Prohasta","Anidesde","Anihasta","Matdesde","Mathasta","Clasidesde","Clasihasta","Unidesde","Unihasta","Narbadesde","Narbahasta","Precivades","Precivahas","Fecmoddesd","Fecmodhast","Fecaltades","Fecaltahas","Obs" ) values ( <<"'" + this.ConvertirDateSql( lxCompvtasFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCompvtasFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCompvtasFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCompvtasFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCompvtasFectrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompvtasVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompvtasZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompvtasEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompvtasBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompvtasBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompvtasUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompvtasValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompvtasSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompvtasSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompvtasUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompvtasHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompvtasHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompvtasHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompvtasHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompvtasCodigo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCompvtasFechadesde ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCompvtasFechahasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompvtasBaseorig ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompvtasBasestock ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompvtasNocom ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompvtasArtdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompvtasArthasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompvtasColdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompvtasClidesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompvtasColhasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompvtasTaldesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompvtasTalhasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompvtasProdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompvtasProhasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompvtasAnidesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompvtasAnihasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompvtasMatdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompvtasMathasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompvtasClasidesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompvtasClasihasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompvtasUnidesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompvtasUnihasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompvtasNarbadesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompvtasNarbahasta ) + "'" >>, <<lxCompvtasPrecivades >>, <<lxCompvtasPrecivahas >>, <<"'" + this.ConvertirDateSql( lxCompvtasFecmoddesd ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCompvtasFecmodhast ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCompvtasFecaltades ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCompvtasFecaltahas ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompvtasObs ) + "'" >> )
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
		this.ComprobarTransaccion()
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
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
			local  lxCompvtasFecimpo, lxCompvtasFaltafw, lxCompvtasFecexpo, lxCompvtasFmodifw, lxCompvtasFectrans, lxCompvtasVmodifw, lxCompvtasZadsfw, lxCompvtasEsttrans, lxCompvtasBdaltafw, lxCompvtasBdmodifw, lxCompvtasUmodifw, lxCompvtasValtafw, lxCompvtasSmodifw, lxCompvtasSaltafw, lxCompvtasUaltafw, lxCompvtasHoraexpo, lxCompvtasHmodifw, lxCompvtasHaltafw, lxCompvtasHoraimpo, lxCompvtasCodigo, lxCompvtasFechadesde, lxCompvtasFechahasta, lxCompvtasBaseorig, lxCompvtasBasestock, lxCompvtasNocom, lxCompvtasArtdesde, lxCompvtasArthasta, lxCompvtasColdesde, lxCompvtasClidesde, lxCompvtasClidesde, lxCompvtasColhasta, lxCompvtasTaldesde, lxCompvtasTalhasta, lxCompvtasProdesde, lxCompvtasProhasta, lxCompvtasAnidesde, lxCompvtasAnihasta, lxCompvtasMatdesde, lxCompvtasMathasta, lxCompvtasClasidesde, lxCompvtasClasihasta, lxCompvtasUnidesde, lxCompvtasUnihasta, lxCompvtasNarbadesde, lxCompvtasNarbahasta, lxCompvtasPrecivades, lxCompvtasPrecivahas, lxCompvtasFecmoddesd, lxCompvtasFecmodhast, lxCompvtasFecaltades, lxCompvtasFecaltahas, lxCompvtasObs
				lxCompvtasFecimpo =  .Fechaimpo			lxCompvtasFaltafw =  .Fechaaltafw			lxCompvtasFecexpo =  .Fechaexpo			lxCompvtasFmodifw =  .Fechamodificacionfw			lxCompvtasFectrans =  .Fechatransferencia			lxCompvtasVmodifw =  .Versionmodificacionfw			lxCompvtasZadsfw =  .Zadsfw			lxCompvtasEsttrans =  .Estadotransferencia			lxCompvtasBdaltafw =  .Basededatosaltafw			lxCompvtasBdmodifw =  .Basededatosmodificacionfw			lxCompvtasUmodifw =  .Usuariomodificacionfw			lxCompvtasValtafw =  .Versionaltafw			lxCompvtasSmodifw =  .Seriemodificacionfw			lxCompvtasSaltafw =  .Seriealtafw			lxCompvtasUaltafw =  .Usuarioaltafw			lxCompvtasHoraexpo =  .Horaexpo			lxCompvtasHmodifw =  .Horamodificacionfw			lxCompvtasHaltafw =  .Horaaltafw			lxCompvtasHoraimpo =  .Horaimpo			lxCompvtasCodigo =  .Codigo			lxCompvtasFechadesde =  .Fechadesde			lxCompvtasFechahasta =  .Fechahasta			lxCompvtasBaseorig =  .Baseorigen			lxCompvtasBasestock =  .Basestock			lxCompvtasNocom =  .Nocomercializable			lxCompvtasArtdesde =  .F_articulo_desde			lxCompvtasArthasta =  .F_articulo_hasta			lxCompvtasColdesde =  .F_color_desde			lxCompvtasClidesde =  upper( .f_Cliente_Hasta_PK ) 			lxCompvtasClidesde =  upper( .f_Cliente_Desde_PK ) 			lxCompvtasColhasta =  .F_color_hasta			lxCompvtasTaldesde =  .F_talle_desde			lxCompvtasTalhasta =  .F_talle_hasta			lxCompvtasProdesde =  .F_articulo_proveedor_desde			lxCompvtasProhasta =  .F_articulo_proveedor_hasta			lxCompvtasAnidesde =  .F_articulo_anio_desde			lxCompvtasAnihasta =  .F_articulo_anio_hasta			lxCompvtasMatdesde =  .F_articulo_material_desde			lxCompvtasMathasta =  .F_articulo_material_hasta			lxCompvtasClasidesde =  .F_articulo_clasificacion_desde			lxCompvtasClasihasta =  .F_articulo_clasificacion_hasta			lxCompvtasUnidesde =  .F_articulo_unidad_desde			lxCompvtasUnihasta =  .F_articulo_unidad_hasta			lxCompvtasNarbadesde =  .F_articulo_nomenclador_desde			lxCompvtasNarbahasta =  .F_articulo_nomenclador_hasta			lxCompvtasPrecivades =  .F_precioconimpuestos_desde			lxCompvtasPrecivahas =  .F_precioconimpuestos_hasta			lxCompvtasFecmoddesd =  .F_articulo_fechamodificacionfw_desde			lxCompvtasFecmodhast =  .F_articulo_fechamodificacionfw_hasta			lxCompvtasFecaltades =  .F_articulo_fechaaltafw_desde			lxCompvtasFecaltahas =  .F_articulo_fechaaltafw_hasta			lxCompvtasObs =  .Observacion
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()
			lxValorClavePrimaria = .oEntidad.CODIGO
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ZooLogic.COMPVTAS set "Fecimpo" = <<"'" + this.ConvertirDateSql( lxCompvtasFecimpo ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxCompvtasFaltafw ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxCompvtasFecexpo ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxCompvtasFmodifw ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxCompvtasFectrans ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxCompvtasVmodifw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxCompvtasZadsfw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxCompvtasEsttrans ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxCompvtasBdaltafw ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxCompvtasBdmodifw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxCompvtasUmodifw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxCompvtasValtafw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxCompvtasSmodifw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxCompvtasSaltafw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxCompvtasUaltafw ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxCompvtasHoraexpo ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxCompvtasHmodifw ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxCompvtasHaltafw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxCompvtasHoraimpo ) + "'">>,"Codigo" = <<"'" + this.FormatearTextoSql( lxCompvtasCodigo ) + "'">>,"Fechadesde" = <<"'" + this.ConvertirDateSql( lxCompvtasFechadesde ) + "'">>,"Fechahasta" = <<"'" + this.ConvertirDateSql( lxCompvtasFechahasta ) + "'">>,"Baseorig" = <<"'" + this.FormatearTextoSql( lxCompvtasBaseorig ) + "'">>,"Basestock" = <<"'" + this.FormatearTextoSql( lxCompvtasBasestock ) + "'">>,"Nocom" = <<"'" + this.FormatearTextoSql( lxCompvtasNocom ) + "'">>,"Artdesde" = <<"'" + this.FormatearTextoSql( lxCompvtasArtdesde ) + "'">>,"Arthasta" = <<"'" + this.FormatearTextoSql( lxCompvtasArthasta ) + "'">>,"Coldesde" = <<"'" + this.FormatearTextoSql( lxCompvtasColdesde ) + "'">>,"Clidesde" = <<"'" + this.FormatearTextoSql( lxCompvtasClidesde ) + "'">>,"Colhasta" = <<"'" + this.FormatearTextoSql( lxCompvtasColhasta ) + "'">>,"Taldesde" = <<"'" + this.FormatearTextoSql( lxCompvtasTaldesde ) + "'">>,"Talhasta" = <<"'" + this.FormatearTextoSql( lxCompvtasTalhasta ) + "'">>,"Prodesde" = <<"'" + this.FormatearTextoSql( lxCompvtasProdesde ) + "'">>,"Prohasta" = <<"'" + this.FormatearTextoSql( lxCompvtasProhasta ) + "'">>,"Anidesde" = <<"'" + this.FormatearTextoSql( lxCompvtasAnidesde ) + "'">>,"Anihasta" = <<"'" + this.FormatearTextoSql( lxCompvtasAnihasta ) + "'">>,"Matdesde" = <<"'" + this.FormatearTextoSql( lxCompvtasMatdesde ) + "'">>,"Mathasta" = <<"'" + this.FormatearTextoSql( lxCompvtasMathasta ) + "'">>,"Clasidesde" = <<"'" + this.FormatearTextoSql( lxCompvtasClasidesde ) + "'">>,"Clasihasta" = <<"'" + this.FormatearTextoSql( lxCompvtasClasihasta ) + "'">>,"Unidesde" = <<"'" + this.FormatearTextoSql( lxCompvtasUnidesde ) + "'">>,"Unihasta" = <<"'" + this.FormatearTextoSql( lxCompvtasUnihasta ) + "'">>,"Narbadesde" = <<"'" + this.FormatearTextoSql( lxCompvtasNarbadesde ) + "'">>,"Narbahasta" = <<"'" + this.FormatearTextoSql( lxCompvtasNarbahasta ) + "'">>,"Precivades" = <<lxCompvtasPrecivades>>,"Precivahas" = <<lxCompvtasPrecivahas>>,"Fecmoddesd" = <<"'" + this.ConvertirDateSql( lxCompvtasFecmoddesd ) + "'">>,"Fecmodhast" = <<"'" + this.ConvertirDateSql( lxCompvtasFecmodhast ) + "'">>,"Fecaltades" = <<"'" + this.ConvertirDateSql( lxCompvtasFecaltades ) + "'">>,"Fecaltahas" = <<"'" + this.ConvertirDateSql( lxCompvtasFecaltahas ) + "'">>,"Obs" = <<"'" + this.FormatearTextoSql( lxCompvtasObs ) + "'">> where "Codigo" = <<"'" + this.FormatearTextoSql( lxCompvtasCodigo ) + "'">> and  COMPVTAS.CODIGO != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
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
		endwith

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function HayDatos() as boolean
		local llhaydatos as boolean, lcXml as String
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 Codigo from ZooLogic.COMPVTAS where " + this.ConvertirFuncionesSql( " COMPVTAS.CODIGO != ''" ) )
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
			Local lxCompvtasCodigo
			lxCompvtasCodigo = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Codigo" as "Codigo", "Fechadesde" as "Fechadesde", "Fechahasta" as "Fechahasta", "Baseorig" as "Baseorigen", "Basestock" as "Basestock", "Nocom" as "Nocomercializable", "Artdesde" as "F_articulo_desde", "Arthasta" as "F_articulo_hasta", "Coldesde" as "F_color_desde", "Clidesde" as "F_cliente_hasta", "Clidesde" as "F_cliente_desde", "Colhasta" as "F_color_hasta", "Taldesde" as "F_talle_desde", "Talhasta" as "F_talle_hasta", "Prodesde" as "F_articulo_proveedor_desde", "Prohasta" as "F_articulo_proveedor_hasta", "Anidesde" as "F_articulo_anio_desde", "Anihasta" as "F_articulo_anio_hasta", "Matdesde" as "F_articulo_material_desde", "Mathasta" as "F_articulo_material_hasta", "Clasidesde" as "F_articulo_clasificacion_desde", "Clasihasta" as "F_articulo_clasificacion_hasta", "Unidesde" as "F_articulo_unidad_desde", "Unihasta" as "F_articulo_unidad_hasta", "Narbadesde" as "F_articulo_nomenclador_desde", "Narbahasta" as "F_articulo_nomenclador_hasta", "Precivades" as "F_precioconimpuestos_desde", "Precivahas" as "F_precioconimpuestos_hasta", "Fecmoddesd" as "F_articulo_fechamodificacionfw_desde", "Fecmodhast" as "F_articulo_fechamodificacionfw_hasta", "Fecaltades" as "F_articulo_fechaaltafw_desde", "Fecaltahas" as "F_articulo_fechaaltafw_hasta", "Obs" as "Observacion" from ZooLogic.COMPVTAS where "Codigo" = <<"'" + this.FormatearTextoSql( lxCompvtasCodigo ) + "'">> and  COMPVTAS.CODIGO != ''
			endtext
			use in select('c_COMPLETARDESDEVENTAS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMPLETARDESDEVENTAS', set( 'Datasession' ) )

			if reccount( 'c_COMPLETARDESDEVENTAS' ) = 0
				llRetorno = .f.
			else
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxCompvtasCodigo as Variant
		llRetorno = .t.
		lxCompvtasCodigo = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.COMPVTAS where "Codigo" = <<"'" + this.FormatearTextoSql( lxCompvtasCodigo ) + "'">> and  COMPVTAS.CODIGO != ''
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
				select top 1 "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Codigo" as "Codigo", "Fechadesde" as "Fechadesde", "Fechahasta" as "Fechahasta", "Baseorig" as "Baseorigen", "Basestock" as "Basestock", "Nocom" as "Nocomercializable", "Artdesde" as "F_articulo_desde", "Arthasta" as "F_articulo_hasta", "Coldesde" as "F_color_desde", "Clidesde" as "F_cliente_hasta", "Clidesde" as "F_cliente_desde", "Colhasta" as "F_color_hasta", "Taldesde" as "F_talle_desde", "Talhasta" as "F_talle_hasta", "Prodesde" as "F_articulo_proveedor_desde", "Prohasta" as "F_articulo_proveedor_hasta", "Anidesde" as "F_articulo_anio_desde", "Anihasta" as "F_articulo_anio_hasta", "Matdesde" as "F_articulo_material_desde", "Mathasta" as "F_articulo_material_hasta", "Clasidesde" as "F_articulo_clasificacion_desde", "Clasihasta" as "F_articulo_clasificacion_hasta", "Unidesde" as "F_articulo_unidad_desde", "Unihasta" as "F_articulo_unidad_hasta", "Narbadesde" as "F_articulo_nomenclador_desde", "Narbahasta" as "F_articulo_nomenclador_hasta", "Precivades" as "F_precioconimpuestos_desde", "Precivahas" as "F_precioconimpuestos_hasta", "Fecmoddesd" as "F_articulo_fechamodificacionfw_desde", "Fecmodhast" as "F_articulo_fechamodificacionfw_hasta", "Fecaltades" as "F_articulo_fechaaltafw_desde", "Fecaltahas" as "F_articulo_fechaaltafw_hasta", "Obs" as "Observacion" from ZooLogic.COMPVTAS where  COMPVTAS.CODIGO != '' order by Codigo
			endtext
			use in select('c_COMPLETARDESDEVENTAS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMPLETARDESDEVENTAS', set( 'Datasession' ) )
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
				select top 1 "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Codigo" as "Codigo", "Fechadesde" as "Fechadesde", "Fechahasta" as "Fechahasta", "Baseorig" as "Baseorigen", "Basestock" as "Basestock", "Nocom" as "Nocomercializable", "Artdesde" as "F_articulo_desde", "Arthasta" as "F_articulo_hasta", "Coldesde" as "F_color_desde", "Clidesde" as "F_cliente_hasta", "Clidesde" as "F_cliente_desde", "Colhasta" as "F_color_hasta", "Taldesde" as "F_talle_desde", "Talhasta" as "F_talle_hasta", "Prodesde" as "F_articulo_proveedor_desde", "Prohasta" as "F_articulo_proveedor_hasta", "Anidesde" as "F_articulo_anio_desde", "Anihasta" as "F_articulo_anio_hasta", "Matdesde" as "F_articulo_material_desde", "Mathasta" as "F_articulo_material_hasta", "Clasidesde" as "F_articulo_clasificacion_desde", "Clasihasta" as "F_articulo_clasificacion_hasta", "Unidesde" as "F_articulo_unidad_desde", "Unihasta" as "F_articulo_unidad_hasta", "Narbadesde" as "F_articulo_nomenclador_desde", "Narbahasta" as "F_articulo_nomenclador_hasta", "Precivades" as "F_precioconimpuestos_desde", "Precivahas" as "F_precioconimpuestos_hasta", "Fecmoddesd" as "F_articulo_fechamodificacionfw_desde", "Fecmodhast" as "F_articulo_fechamodificacionfw_hasta", "Fecaltades" as "F_articulo_fechaaltafw_desde", "Fecaltahas" as "F_articulo_fechaaltafw_hasta", "Obs" as "Observacion" from ZooLogic.COMPVTAS where  funciones.padr( Codigo, 38, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  COMPVTAS.CODIGO != '' order by Codigo
			endtext
			use in select('c_COMPLETARDESDEVENTAS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMPLETARDESDEVENTAS', set( 'Datasession' ) )
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
				select top 1 "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Codigo" as "Codigo", "Fechadesde" as "Fechadesde", "Fechahasta" as "Fechahasta", "Baseorig" as "Baseorigen", "Basestock" as "Basestock", "Nocom" as "Nocomercializable", "Artdesde" as "F_articulo_desde", "Arthasta" as "F_articulo_hasta", "Coldesde" as "F_color_desde", "Clidesde" as "F_cliente_hasta", "Clidesde" as "F_cliente_desde", "Colhasta" as "F_color_hasta", "Taldesde" as "F_talle_desde", "Talhasta" as "F_talle_hasta", "Prodesde" as "F_articulo_proveedor_desde", "Prohasta" as "F_articulo_proveedor_hasta", "Anidesde" as "F_articulo_anio_desde", "Anihasta" as "F_articulo_anio_hasta", "Matdesde" as "F_articulo_material_desde", "Mathasta" as "F_articulo_material_hasta", "Clasidesde" as "F_articulo_clasificacion_desde", "Clasihasta" as "F_articulo_clasificacion_hasta", "Unidesde" as "F_articulo_unidad_desde", "Unihasta" as "F_articulo_unidad_hasta", "Narbadesde" as "F_articulo_nomenclador_desde", "Narbahasta" as "F_articulo_nomenclador_hasta", "Precivades" as "F_precioconimpuestos_desde", "Precivahas" as "F_precioconimpuestos_hasta", "Fecmoddesd" as "F_articulo_fechamodificacionfw_desde", "Fecmodhast" as "F_articulo_fechamodificacionfw_hasta", "Fecaltades" as "F_articulo_fechaaltafw_desde", "Fecaltahas" as "F_articulo_fechaaltafw_hasta", "Obs" as "Observacion" from ZooLogic.COMPVTAS where  funciones.padr( Codigo, 38, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  COMPVTAS.CODIGO != '' order by Codigo desc
			endtext
			use in select('c_COMPLETARDESDEVENTAS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMPLETARDESDEVENTAS', set( 'Datasession' ) )
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
				select top 1 "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Codigo" as "Codigo", "Fechadesde" as "Fechadesde", "Fechahasta" as "Fechahasta", "Baseorig" as "Baseorigen", "Basestock" as "Basestock", "Nocom" as "Nocomercializable", "Artdesde" as "F_articulo_desde", "Arthasta" as "F_articulo_hasta", "Coldesde" as "F_color_desde", "Clidesde" as "F_cliente_hasta", "Clidesde" as "F_cliente_desde", "Colhasta" as "F_color_hasta", "Taldesde" as "F_talle_desde", "Talhasta" as "F_talle_hasta", "Prodesde" as "F_articulo_proveedor_desde", "Prohasta" as "F_articulo_proveedor_hasta", "Anidesde" as "F_articulo_anio_desde", "Anihasta" as "F_articulo_anio_hasta", "Matdesde" as "F_articulo_material_desde", "Mathasta" as "F_articulo_material_hasta", "Clasidesde" as "F_articulo_clasificacion_desde", "Clasihasta" as "F_articulo_clasificacion_hasta", "Unidesde" as "F_articulo_unidad_desde", "Unihasta" as "F_articulo_unidad_hasta", "Narbadesde" as "F_articulo_nomenclador_desde", "Narbahasta" as "F_articulo_nomenclador_hasta", "Precivades" as "F_precioconimpuestos_desde", "Precivahas" as "F_precioconimpuestos_hasta", "Fecmoddesd" as "F_articulo_fechamodificacionfw_desde", "Fecmodhast" as "F_articulo_fechamodificacionfw_hasta", "Fecaltades" as "F_articulo_fechaaltafw_desde", "Fecaltahas" as "F_articulo_fechaaltafw_hasta", "Obs" as "Observacion" from ZooLogic.COMPVTAS where  COMPVTAS.CODIGO != '' order by Codigo desc
			endtext
			use in select('c_COMPLETARDESDEVENTAS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMPLETARDESDEVENTAS', set( 'Datasession' ) )
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
			lcXml = this.oConexion.EjecutarSql( "select Fecimpo,Faltafw,Fecexpo,Fmodifw,Fectrans,Vmodifw,Zadsfw,Esttrans,Bdaltafw,Bdmodifw,Umodifw,V" + ;
"altafw,Smodifw,Saltafw,Ualtafw,Horaexpo,Hmodifw,Haltafw,Horaimpo,Codigo,Fechadesde,Fechahasta,Baseor" + ;
"ig,Basestock,Nocom,Artdesde,Arthasta,Coldesde,Clidesde,Colhasta,Taldesde,Talhasta,Prodesde,Prohasta," + ;
"Anidesde,Anihasta,Matdesde,Mathasta,Clasidesde,Clasihasta,Unidesde,Unihasta,Narbadesde,Narbahasta,Pr" + ;
"ecivades,Precivahas,Fecmoddesd,Fecmodhast,Fecaltades,Fecaltahas,Obs" + ;
" from ZooLogic.COMPVTAS where  COMPVTAS.CODIGO != '' and " + lcFiltro )
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
			local  lxCompvtasFecimpo, lxCompvtasFaltafw, lxCompvtasFecexpo, lxCompvtasFmodifw, lxCompvtasFectrans, lxCompvtasVmodifw, lxCompvtasZadsfw, lxCompvtasEsttrans, lxCompvtasBdaltafw, lxCompvtasBdmodifw, lxCompvtasUmodifw, lxCompvtasValtafw, lxCompvtasSmodifw, lxCompvtasSaltafw, lxCompvtasUaltafw, lxCompvtasHoraexpo, lxCompvtasHmodifw, lxCompvtasHaltafw, lxCompvtasHoraimpo, lxCompvtasCodigo, lxCompvtasFechadesde, lxCompvtasFechahasta, lxCompvtasBaseorig, lxCompvtasBasestock, lxCompvtasNocom, lxCompvtasArtdesde, lxCompvtasArthasta, lxCompvtasColdesde, lxCompvtasClidesde, lxCompvtasClidesde, lxCompvtasColhasta, lxCompvtasTaldesde, lxCompvtasTalhasta, lxCompvtasProdesde, lxCompvtasProhasta, lxCompvtasAnidesde, lxCompvtasAnihasta, lxCompvtasMatdesde, lxCompvtasMathasta, lxCompvtasClasidesde, lxCompvtasClasihasta, lxCompvtasUnidesde, lxCompvtasUnihasta, lxCompvtasNarbadesde, lxCompvtasNarbahasta, lxCompvtasPrecivades, lxCompvtasPrecivahas, lxCompvtasFecmoddesd, lxCompvtasFecmodhast, lxCompvtasFecaltades, lxCompvtasFecaltahas, lxCompvtasObs
				lxCompvtasFecimpo = ctod( '  /  /    ' )			lxCompvtasFaltafw = ctod( '  /  /    ' )			lxCompvtasFecexpo = ctod( '  /  /    ' )			lxCompvtasFmodifw = ctod( '  /  /    ' )			lxCompvtasFectrans = ctod( '  /  /    ' )			lxCompvtasVmodifw = []			lxCompvtasZadsfw = []			lxCompvtasEsttrans = []			lxCompvtasBdaltafw = []			lxCompvtasBdmodifw = []			lxCompvtasUmodifw = []			lxCompvtasValtafw = []			lxCompvtasSmodifw = []			lxCompvtasSaltafw = []			lxCompvtasUaltafw = []			lxCompvtasHoraexpo = []			lxCompvtasHmodifw = []			lxCompvtasHaltafw = []			lxCompvtasHoraimpo = []			lxCompvtasCodigo = []			lxCompvtasFechadesde = ctod( '  /  /    ' )			lxCompvtasFechahasta = ctod( '  /  /    ' )			lxCompvtasBaseorig = []			lxCompvtasBasestock = []			lxCompvtasNocom = []			lxCompvtasArtdesde = []			lxCompvtasArthasta = []			lxCompvtasColdesde = []			lxCompvtasClidesde = []			lxCompvtasClidesde = []			lxCompvtasColhasta = []			lxCompvtasTaldesde = []			lxCompvtasTalhasta = []			lxCompvtasProdesde = []			lxCompvtasProhasta = []			lxCompvtasAnidesde = []			lxCompvtasAnihasta = []			lxCompvtasMatdesde = []			lxCompvtasMathasta = []			lxCompvtasClasidesde = []			lxCompvtasClasihasta = []			lxCompvtasUnidesde = []			lxCompvtasUnihasta = []			lxCompvtasNarbadesde = []			lxCompvtasNarbahasta = []			lxCompvtasPrecivades = 0			lxCompvtasPrecivahas = 0			lxCompvtasFecmoddesd = ctod( '  /  /    ' )			lxCompvtasFecmodhast = ctod( '  /  /    ' )			lxCompvtasFecaltades = ctod( '  /  /    ' )			lxCompvtasFecaltahas = ctod( '  /  /    ' )			lxCompvtasObs = []
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( [delete from ZooLogic.COMPVTAS where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'COMPVTAS' + '_' + tcCampo
			lcMemoAscii = ''

			lnIndice = alen(.aSqlMemos)
			lnIndice = iif(lnIndice = 1, 1, lnIndice + 1 )
			dimension .aSqlMemos(lnIndice)

			.aSqlMemos(lnIndice) = 'delete from ' + lcTabla + ' where Codigo = ' + txValorClavePrimaria
			.GenerarSentenciasInsertTablaMemo( lcValor, lcTabla, txValorClavePrimaria )
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerSentenciaInsertMemo( tcTabla as String, txValorClavePrimaria as String, tcOrden as String, tcTexto as String ) as String
		return "Insert  into " + tcTabla + "(Codigo, Orden, texto ) values ( " + txValorClavePrimaria + "," + tcOrden + ",'"+ tcTexto + "')"
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosEntidad( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  COMPVTAS.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Codigo" as "Codigo", "Fechadesde" as "Fechadesde", "Fechahasta" as "Fechahasta", "Baseorig" as "Baseorigen", "Basestock" as "Basestock", "Nocom" as "Nocomercializable", "Artdesde" as "F_articulo_desde", "Arthasta" as "F_articulo_hasta", "Coldesde" as "F_color_desde", "Clidesde" as "F_cliente_hasta", "Clidesde" as "F_cliente_desde", "Colhasta" as "F_color_hasta", "Taldesde" as "F_talle_desde", "Talhasta" as "F_talle_hasta", "Prodesde" as "F_articulo_proveedor_desde", "Prohasta" as "F_articulo_proveedor_hasta", "Anidesde" as "F_articulo_anio_desde", "Anihasta" as "F_articulo_anio_hasta", "Matdesde" as "F_articulo_material_desde", "Mathasta" as "F_articulo_material_hasta", "Clasidesde" as "F_articulo_clasificacion_desde", "Clasihasta" as "F_articulo_clasificacion_hasta", "Unidesde" as "F_articulo_unidad_desde", "Unihasta" as "F_articulo_unidad_hasta", "Narbadesde" as "F_articulo_nomenclador_desde", "Narbahasta" as "F_articulo_nomenclador_hasta", "Precivades" as "F_precioconimpuestos_desde", "Precivahas" as "F_precioconimpuestos_hasta", "Fecmoddesd" as "F_articulo_fechamodificacionfw_desde", "Fecmodhast" as "F_articulo_fechamodificacionfw_hasta", "Fecaltades" as "F_articulo_fechaaltafw_desde", "Fecaltahas" as "F_articulo_fechaaltafw_hasta", "Obs" as "Observacion"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'COMPVTAS', '', tnTope )
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
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'FECHAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECEXPO AS FECHAEXPO'
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'FECHATRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRANS AS FECHATRANSFERENCIA'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'FECHADESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHADESDE AS FECHADESDE'
				Case lcAtributo == 'FECHAHASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHAHASTA AS FECHAHASTA'
				Case lcAtributo == 'BASEORIGEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BASEORIG AS BASEORIGEN'
				Case lcAtributo == 'BASESTOCK'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BASESTOCK AS BASESTOCK'
				Case lcAtributo == 'NOCOMERCIALIZABLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NOCOM AS NOCOMERCIALIZABLE'
				Case lcAtributo == 'F_ARTICULO_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ARTDESDE AS F_ARTICULO_DESDE'
				Case lcAtributo == 'F_ARTICULO_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ARTHASTA AS F_ARTICULO_HASTA'
				Case lcAtributo == 'F_COLOR_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COLDESDE AS F_COLOR_DESDE'
				Case lcAtributo == 'F_CLIENTE_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLIDESDE AS F_CLIENTE_HASTA'
				Case lcAtributo == 'F_CLIENTE_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLIDESDE AS F_CLIENTE_DESDE'
				Case lcAtributo == 'F_COLOR_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COLHASTA AS F_COLOR_HASTA'
				Case lcAtributo == 'F_TALLE_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TALDESDE AS F_TALLE_DESDE'
				Case lcAtributo == 'F_TALLE_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TALHASTA AS F_TALLE_HASTA'
				Case lcAtributo == 'F_ARTICULO_PROVEEDOR_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PRODESDE AS F_ARTICULO_PROVEEDOR_DESDE'
				Case lcAtributo == 'F_ARTICULO_PROVEEDOR_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PROHASTA AS F_ARTICULO_PROVEEDOR_HASTA'
				Case lcAtributo == 'F_ARTICULO_ANIO_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ANIDESDE AS F_ARTICULO_ANIO_DESDE'
				Case lcAtributo == 'F_ARTICULO_ANIO_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ANIHASTA AS F_ARTICULO_ANIO_HASTA'
				Case lcAtributo == 'F_ARTICULO_MATERIAL_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MATDESDE AS F_ARTICULO_MATERIAL_DESDE'
				Case lcAtributo == 'F_ARTICULO_MATERIAL_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MATHASTA AS F_ARTICULO_MATERIAL_HASTA'
				Case lcAtributo == 'F_ARTICULO_CLASIFICACION_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLASIDESDE AS F_ARTICULO_CLASIFICACION_DESDE'
				Case lcAtributo == 'F_ARTICULO_CLASIFICACION_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLASIHASTA AS F_ARTICULO_CLASIFICACION_HASTA'
				Case lcAtributo == 'F_ARTICULO_UNIDAD_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UNIDESDE AS F_ARTICULO_UNIDAD_DESDE'
				Case lcAtributo == 'F_ARTICULO_UNIDAD_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UNIHASTA AS F_ARTICULO_UNIDAD_HASTA'
				Case lcAtributo == 'F_ARTICULO_NOMENCLADOR_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NARBADESDE AS F_ARTICULO_NOMENCLADOR_DESDE'
				Case lcAtributo == 'F_ARTICULO_NOMENCLADOR_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NARBAHASTA AS F_ARTICULO_NOMENCLADOR_HASTA'
				Case lcAtributo == 'F_PRECIOCONIMPUESTOS_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PRECIVADES AS F_PRECIOCONIMPUESTOS_DESDE'
				Case lcAtributo == 'F_PRECIOCONIMPUESTOS_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PRECIVAHAS AS F_PRECIOCONIMPUESTOS_HASTA'
				Case lcAtributo == 'F_ARTICULO_FECHAMODIFICACIONFW_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECMODDESD AS F_ARTICULO_FECHAMODIFICACIONFW_DESDE'
				Case lcAtributo == 'F_ARTICULO_FECHAMODIFICACIONFW_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECMODHAST AS F_ARTICULO_FECHAMODIFICACIONFW_HASTA'
				Case lcAtributo == 'F_ARTICULO_FECHAALTAFW_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECALTADES AS F_ARTICULO_FECHAALTAFW_DESDE'
				Case lcAtributo == 'F_ARTICULO_FECHAALTAFW_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECALTAHAS AS F_ARTICULO_FECHAALTAFW_HASTA'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEXPO'
				lcCampo = 'FECEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHADESDE'
				lcCampo = 'FECHADESDE'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAHASTA'
				lcCampo = 'FECHAHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'BASEORIGEN'
				lcCampo = 'BASEORIG'
			Case upper( alltrim( tcAtributo ) ) == 'BASESTOCK'
				lcCampo = 'BASESTOCK'
			Case upper( alltrim( tcAtributo ) ) == 'NOCOMERCIALIZABLE'
				lcCampo = 'NOCOM'
			Case upper( alltrim( tcAtributo ) ) == 'F_ARTICULO_DESDE'
				lcCampo = 'ARTDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'F_ARTICULO_HASTA'
				lcCampo = 'ARTHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'F_COLOR_DESDE'
				lcCampo = 'COLDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'F_CLIENTE_HASTA'
				lcCampo = 'CLIDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'F_CLIENTE_DESDE'
				lcCampo = 'CLIDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'F_COLOR_HASTA'
				lcCampo = 'COLHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'F_TALLE_DESDE'
				lcCampo = 'TALDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'F_TALLE_HASTA'
				lcCampo = 'TALHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'F_ARTICULO_PROVEEDOR_DESDE'
				lcCampo = 'PRODESDE'
			Case upper( alltrim( tcAtributo ) ) == 'F_ARTICULO_PROVEEDOR_HASTA'
				lcCampo = 'PROHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'F_ARTICULO_ANIO_DESDE'
				lcCampo = 'ANIDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'F_ARTICULO_ANIO_HASTA'
				lcCampo = 'ANIHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'F_ARTICULO_MATERIAL_DESDE'
				lcCampo = 'MATDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'F_ARTICULO_MATERIAL_HASTA'
				lcCampo = 'MATHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'F_ARTICULO_CLASIFICACION_DESDE'
				lcCampo = 'CLASIDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'F_ARTICULO_CLASIFICACION_HASTA'
				lcCampo = 'CLASIHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'F_ARTICULO_UNIDAD_DESDE'
				lcCampo = 'UNIDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'F_ARTICULO_UNIDAD_HASTA'
				lcCampo = 'UNIHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'F_ARTICULO_NOMENCLADOR_DESDE'
				lcCampo = 'NARBADESDE'
			Case upper( alltrim( tcAtributo ) ) == 'F_ARTICULO_NOMENCLADOR_HASTA'
				lcCampo = 'NARBAHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'F_PRECIOCONIMPUESTOS_DESDE'
				lcCampo = 'PRECIVADES'
			Case upper( alltrim( tcAtributo ) ) == 'F_PRECIOCONIMPUESTOS_HASTA'
				lcCampo = 'PRECIVAHAS'
			Case upper( alltrim( tcAtributo ) ) == 'F_ARTICULO_FECHAMODIFICACIONFW_DESDE'
				lcCampo = 'FECMODDESD'
			Case upper( alltrim( tcAtributo ) ) == 'F_ARTICULO_FECHAMODIFICACIONFW_HASTA'
				lcCampo = 'FECMODHAST'
			Case upper( alltrim( tcAtributo ) ) == 'F_ARTICULO_FECHAALTAFW_DESDE'
				lcCampo = 'FECALTADES'
			Case upper( alltrim( tcAtributo ) ) == 'F_ARTICULO_FECHAALTAFW_HASTA'
				lcCampo = 'FECALTAHAS'
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
			local  lxCompvtasFecimpo, lxCompvtasFaltafw, lxCompvtasFecexpo, lxCompvtasFmodifw, lxCompvtasFectrans, lxCompvtasVmodifw, lxCompvtasZadsfw, lxCompvtasEsttrans, lxCompvtasBdaltafw, lxCompvtasBdmodifw, lxCompvtasUmodifw, lxCompvtasValtafw, lxCompvtasSmodifw, lxCompvtasSaltafw, lxCompvtasUaltafw, lxCompvtasHoraexpo, lxCompvtasHmodifw, lxCompvtasHaltafw, lxCompvtasHoraimpo, lxCompvtasCodigo, lxCompvtasFechadesde, lxCompvtasFechahasta, lxCompvtasBaseorig, lxCompvtasBasestock, lxCompvtasNocom, lxCompvtasArtdesde, lxCompvtasArthasta, lxCompvtasColdesde, lxCompvtasClidesde, lxCompvtasClidesde, lxCompvtasColhasta, lxCompvtasTaldesde, lxCompvtasTalhasta, lxCompvtasProdesde, lxCompvtasProhasta, lxCompvtasAnidesde, lxCompvtasAnihasta, lxCompvtasMatdesde, lxCompvtasMathasta, lxCompvtasClasidesde, lxCompvtasClasihasta, lxCompvtasUnidesde, lxCompvtasUnihasta, lxCompvtasNarbadesde, lxCompvtasNarbahasta, lxCompvtasPrecivades, lxCompvtasPrecivahas, lxCompvtasFecmoddesd, lxCompvtasFecmodhast, lxCompvtasFecaltades, lxCompvtasFecaltahas, lxCompvtasObs
				lxCompvtasFecimpo =  .Fechaimpo			lxCompvtasFaltafw =  .Fechaaltafw			lxCompvtasFecexpo =  .Fechaexpo			lxCompvtasFmodifw =  .Fechamodificacionfw			lxCompvtasFectrans =  .Fechatransferencia			lxCompvtasVmodifw =  .Versionmodificacionfw			lxCompvtasZadsfw =  .Zadsfw			lxCompvtasEsttrans =  .Estadotransferencia			lxCompvtasBdaltafw =  .Basededatosaltafw			lxCompvtasBdmodifw =  .Basededatosmodificacionfw			lxCompvtasUmodifw =  .Usuariomodificacionfw			lxCompvtasValtafw =  .Versionaltafw			lxCompvtasSmodifw =  .Seriemodificacionfw			lxCompvtasSaltafw =  .Seriealtafw			lxCompvtasUaltafw =  .Usuarioaltafw			lxCompvtasHoraexpo =  .Horaexpo			lxCompvtasHmodifw =  .Horamodificacionfw			lxCompvtasHaltafw =  .Horaaltafw			lxCompvtasHoraimpo =  .Horaimpo			lxCompvtasCodigo =  .Codigo			lxCompvtasFechadesde =  .Fechadesde			lxCompvtasFechahasta =  .Fechahasta			lxCompvtasBaseorig =  .Baseorigen			lxCompvtasBasestock =  .Basestock			lxCompvtasNocom =  .Nocomercializable			lxCompvtasArtdesde =  .F_articulo_desde			lxCompvtasArthasta =  .F_articulo_hasta			lxCompvtasColdesde =  .F_color_desde			lxCompvtasClidesde =  upper( .f_Cliente_Hasta_PK ) 			lxCompvtasClidesde =  upper( .f_Cliente_Desde_PK ) 			lxCompvtasColhasta =  .F_color_hasta			lxCompvtasTaldesde =  .F_talle_desde			lxCompvtasTalhasta =  .F_talle_hasta			lxCompvtasProdesde =  .F_articulo_proveedor_desde			lxCompvtasProhasta =  .F_articulo_proveedor_hasta			lxCompvtasAnidesde =  .F_articulo_anio_desde			lxCompvtasAnihasta =  .F_articulo_anio_hasta			lxCompvtasMatdesde =  .F_articulo_material_desde			lxCompvtasMathasta =  .F_articulo_material_hasta			lxCompvtasClasidesde =  .F_articulo_clasificacion_desde			lxCompvtasClasihasta =  .F_articulo_clasificacion_hasta			lxCompvtasUnidesde =  .F_articulo_unidad_desde			lxCompvtasUnihasta =  .F_articulo_unidad_hasta			lxCompvtasNarbadesde =  .F_articulo_nomenclador_desde			lxCompvtasNarbahasta =  .F_articulo_nomenclador_hasta			lxCompvtasPrecivades =  .F_precioconimpuestos_desde			lxCompvtasPrecivahas =  .F_precioconimpuestos_hasta			lxCompvtasFecmoddesd =  .F_articulo_fechamodificacionfw_desde			lxCompvtasFecmodhast =  .F_articulo_fechamodificacionfw_hasta			lxCompvtasFecaltades =  .F_articulo_fechaaltafw_desde			lxCompvtasFecaltahas =  .F_articulo_fechaaltafw_hasta			lxCompvtasObs =  .Observacion
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.COMPVTAS ( "Fecimpo","Faltafw","Fecexpo","Fmodifw","Fectrans","Vmodifw","Zadsfw","Esttrans","Bdaltafw","Bdmodifw","Umodifw","Valtafw","Smodifw","Saltafw","Ualtafw","Horaexpo","Hmodifw","Haltafw","Horaimpo","Codigo","Fechadesde","Fechahasta","Baseorig","Basestock","Nocom","Artdesde","Arthasta","Coldesde","Clidesde","Colhasta","Taldesde","Talhasta","Prodesde","Prohasta","Anidesde","Anihasta","Matdesde","Mathasta","Clasidesde","Clasihasta","Unidesde","Unihasta","Narbadesde","Narbahasta","Precivades","Precivahas","Fecmoddesd","Fecmodhast","Fecaltades","Fecaltahas","Obs" ) values ( <<"'" + this.ConvertirDateSql( lxCompvtasFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCompvtasFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCompvtasFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCompvtasFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCompvtasFectrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompvtasVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompvtasZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompvtasEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompvtasBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompvtasBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompvtasUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompvtasValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompvtasSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompvtasSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompvtasUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompvtasHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompvtasHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompvtasHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompvtasHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompvtasCodigo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCompvtasFechadesde ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCompvtasFechahasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompvtasBaseorig ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompvtasBasestock ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompvtasNocom ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompvtasArtdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompvtasArthasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompvtasColdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompvtasClidesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompvtasColhasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompvtasTaldesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompvtasTalhasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompvtasProdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompvtasProhasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompvtasAnidesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompvtasAnihasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompvtasMatdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompvtasMathasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompvtasClasidesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompvtasClasihasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompvtasUnidesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompvtasUnihasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompvtasNarbadesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompvtasNarbahasta ) + "'" >>, <<lxCompvtasPrecivades >>, <<lxCompvtasPrecivahas >>, <<"'" + this.ConvertirDateSql( lxCompvtasFecmoddesd ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCompvtasFecmodhast ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCompvtasFecaltades ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCompvtasFecaltahas ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompvtasObs ) + "'" >> )
		endtext
		loColeccion.cTabla = 'COMPVTAS' 
		loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		With this
			local lcValorClavePrimariaString as String
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"
		EndWith
		return loColeccion
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasUpdate() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcFiltro as string, loItem as object, lcSentencia as string, lcSentencia as string
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxCompvtasFecimpo, lxCompvtasFaltafw, lxCompvtasFecexpo, lxCompvtasFmodifw, lxCompvtasFectrans, lxCompvtasVmodifw, lxCompvtasZadsfw, lxCompvtasEsttrans, lxCompvtasBdaltafw, lxCompvtasBdmodifw, lxCompvtasUmodifw, lxCompvtasValtafw, lxCompvtasSmodifw, lxCompvtasSaltafw, lxCompvtasUaltafw, lxCompvtasHoraexpo, lxCompvtasHmodifw, lxCompvtasHaltafw, lxCompvtasHoraimpo, lxCompvtasCodigo, lxCompvtasFechadesde, lxCompvtasFechahasta, lxCompvtasBaseorig, lxCompvtasBasestock, lxCompvtasNocom, lxCompvtasArtdesde, lxCompvtasArthasta, lxCompvtasColdesde, lxCompvtasClidesde, lxCompvtasClidesde, lxCompvtasColhasta, lxCompvtasTaldesde, lxCompvtasTalhasta, lxCompvtasProdesde, lxCompvtasProhasta, lxCompvtasAnidesde, lxCompvtasAnihasta, lxCompvtasMatdesde, lxCompvtasMathasta, lxCompvtasClasidesde, lxCompvtasClasihasta, lxCompvtasUnidesde, lxCompvtasUnihasta, lxCompvtasNarbadesde, lxCompvtasNarbahasta, lxCompvtasPrecivades, lxCompvtasPrecivahas, lxCompvtasFecmoddesd, lxCompvtasFecmodhast, lxCompvtasFecaltades, lxCompvtasFecaltahas, lxCompvtasObs
				lxCompvtasFecimpo =  .Fechaimpo			lxCompvtasFaltafw =  .Fechaaltafw			lxCompvtasFecexpo =  .Fechaexpo			lxCompvtasFmodifw =  .Fechamodificacionfw			lxCompvtasFectrans =  .Fechatransferencia			lxCompvtasVmodifw =  .Versionmodificacionfw			lxCompvtasZadsfw =  .Zadsfw			lxCompvtasEsttrans =  .Estadotransferencia			lxCompvtasBdaltafw =  .Basededatosaltafw			lxCompvtasBdmodifw =  .Basededatosmodificacionfw			lxCompvtasUmodifw =  .Usuariomodificacionfw			lxCompvtasValtafw =  .Versionaltafw			lxCompvtasSmodifw =  .Seriemodificacionfw			lxCompvtasSaltafw =  .Seriealtafw			lxCompvtasUaltafw =  .Usuarioaltafw			lxCompvtasHoraexpo =  .Horaexpo			lxCompvtasHmodifw =  .Horamodificacionfw			lxCompvtasHaltafw =  .Horaaltafw			lxCompvtasHoraimpo =  .Horaimpo			lxCompvtasCodigo =  .Codigo			lxCompvtasFechadesde =  .Fechadesde			lxCompvtasFechahasta =  .Fechahasta			lxCompvtasBaseorig =  .Baseorigen			lxCompvtasBasestock =  .Basestock			lxCompvtasNocom =  .Nocomercializable			lxCompvtasArtdesde =  .F_articulo_desde			lxCompvtasArthasta =  .F_articulo_hasta			lxCompvtasColdesde =  .F_color_desde			lxCompvtasClidesde =  upper( .f_Cliente_Hasta_PK ) 			lxCompvtasClidesde =  upper( .f_Cliente_Desde_PK ) 			lxCompvtasColhasta =  .F_color_hasta			lxCompvtasTaldesde =  .F_talle_desde			lxCompvtasTalhasta =  .F_talle_hasta			lxCompvtasProdesde =  .F_articulo_proveedor_desde			lxCompvtasProhasta =  .F_articulo_proveedor_hasta			lxCompvtasAnidesde =  .F_articulo_anio_desde			lxCompvtasAnihasta =  .F_articulo_anio_hasta			lxCompvtasMatdesde =  .F_articulo_material_desde			lxCompvtasMathasta =  .F_articulo_material_hasta			lxCompvtasClasidesde =  .F_articulo_clasificacion_desde			lxCompvtasClasihasta =  .F_articulo_clasificacion_hasta			lxCompvtasUnidesde =  .F_articulo_unidad_desde			lxCompvtasUnihasta =  .F_articulo_unidad_hasta			lxCompvtasNarbadesde =  .F_articulo_nomenclador_desde			lxCompvtasNarbahasta =  .F_articulo_nomenclador_hasta			lxCompvtasPrecivades =  .F_precioconimpuestos_desde			lxCompvtasPrecivahas =  .F_precioconimpuestos_hasta			lxCompvtasFecmoddesd =  .F_articulo_fechamodificacionfw_desde			lxCompvtasFecmodhast =  .F_articulo_fechamodificacionfw_hasta			lxCompvtasFecaltades =  .F_articulo_fechaaltafw_desde			lxCompvtasFecaltahas =  .F_articulo_fechaaltafw_hasta			lxCompvtasObs =  .Observacion
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  COMPVTAS.CODIGO != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.COMPVTAS set "Fecimpo" = <<"'" + this.ConvertirDateSql( lxCompvtasFecimpo ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxCompvtasFaltafw ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxCompvtasFecexpo ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxCompvtasFmodifw ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxCompvtasFectrans ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxCompvtasVmodifw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxCompvtasZadsfw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxCompvtasEsttrans ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxCompvtasBdaltafw ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxCompvtasBdmodifw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxCompvtasUmodifw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxCompvtasValtafw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxCompvtasSmodifw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxCompvtasSaltafw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxCompvtasUaltafw ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxCompvtasHoraexpo ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxCompvtasHmodifw ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxCompvtasHaltafw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxCompvtasHoraimpo ) + "'">>, "Codigo" = <<"'" + this.FormatearTextoSql( lxCompvtasCodigo ) + "'">>, "Fechadesde" = <<"'" + this.ConvertirDateSql( lxCompvtasFechadesde ) + "'">>, "Fechahasta" = <<"'" + this.ConvertirDateSql( lxCompvtasFechahasta ) + "'">>, "Baseorig" = <<"'" + this.FormatearTextoSql( lxCompvtasBaseorig ) + "'">>, "Basestock" = <<"'" + this.FormatearTextoSql( lxCompvtasBasestock ) + "'">>, "Nocom" = <<"'" + this.FormatearTextoSql( lxCompvtasNocom ) + "'">>, "Artdesde" = <<"'" + this.FormatearTextoSql( lxCompvtasArtdesde ) + "'">>, "Arthasta" = <<"'" + this.FormatearTextoSql( lxCompvtasArthasta ) + "'">>, "Coldesde" = <<"'" + this.FormatearTextoSql( lxCompvtasColdesde ) + "'">>, "Clidesde" = <<"'" + this.FormatearTextoSql( lxCompvtasClidesde ) + "'">>, "Colhasta" = <<"'" + this.FormatearTextoSql( lxCompvtasColhasta ) + "'">>, "Taldesde" = <<"'" + this.FormatearTextoSql( lxCompvtasTaldesde ) + "'">>, "Talhasta" = <<"'" + this.FormatearTextoSql( lxCompvtasTalhasta ) + "'">>, "Prodesde" = <<"'" + this.FormatearTextoSql( lxCompvtasProdesde ) + "'">>, "Prohasta" = <<"'" + this.FormatearTextoSql( lxCompvtasProhasta ) + "'">>, "Anidesde" = <<"'" + this.FormatearTextoSql( lxCompvtasAnidesde ) + "'">>, "Anihasta" = <<"'" + this.FormatearTextoSql( lxCompvtasAnihasta ) + "'">>, "Matdesde" = <<"'" + this.FormatearTextoSql( lxCompvtasMatdesde ) + "'">>, "Mathasta" = <<"'" + this.FormatearTextoSql( lxCompvtasMathasta ) + "'">>, "Clasidesde" = <<"'" + this.FormatearTextoSql( lxCompvtasClasidesde ) + "'">>, "Clasihasta" = <<"'" + this.FormatearTextoSql( lxCompvtasClasihasta ) + "'">>, "Unidesde" = <<"'" + this.FormatearTextoSql( lxCompvtasUnidesde ) + "'">>, "Unihasta" = <<"'" + this.FormatearTextoSql( lxCompvtasUnihasta ) + "'">>, "Narbadesde" = <<"'" + this.FormatearTextoSql( lxCompvtasNarbadesde ) + "'">>, "Narbahasta" = <<"'" + this.FormatearTextoSql( lxCompvtasNarbahasta ) + "'">>, "Precivades" = <<lxCompvtasPrecivades>>, "Precivahas" = <<lxCompvtasPrecivahas>>, "Fecmoddesd" = <<"'" + this.ConvertirDateSql( lxCompvtasFecmoddesd ) + "'">>, "Fecmodhast" = <<"'" + this.ConvertirDateSql( lxCompvtasFecmodhast ) + "'">>, "Fecaltades" = <<"'" + this.ConvertirDateSql( lxCompvtasFecaltades ) + "'">>, "Fecaltahas" = <<"'" + this.ConvertirDateSql( lxCompvtasFecaltahas ) + "'">>, "Obs" = <<"'" + this.FormatearTextoSql( lxCompvtasObs ) + "'">> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'COMPVTAS' 
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
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  COMPVTAS.CODIGO != '']
		loColeccion.Agregar( 'delete from ZooLogic.COMPVTAS where ' + lcFiltro )
			loColeccion.cTabla = 'COMPVTAS' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.COMPVTAS where  COMPVTAS.CODIGO != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.COMPVTAS where Codigo = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  COMPVTAS.CODIGO != ''" )
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
		lcCursor = This.oEntidad.cPrefijoRecibir + 'COMPLETARDESDEVENTAS'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.COMPVTAS Where Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'", 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					this.oConexion.EjecutarSql( [UPDATE ZooLogic.COMPVTAS set  FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'"+ [, FechaDesde = ] + "'" + this.ConvertirDateSql( &lcCursor..FechaDesde ) + "'"+ [, FechaHasta = ] + "'" + this.ConvertirDateSql( &lcCursor..FechaHasta ) + "'"+ [, BaseOrig = ] + "'" + this.FormatearTextoSql( &lcCursor..BaseOrig ) + "'"+ [, BaseStock = ] + "'" + this.FormatearTextoSql( &lcCursor..BaseStock ) + "'"+ [, NoCom = ] + "'" + this.FormatearTextoSql( &lcCursor..NoCom ) + "'"+ [, ArtDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..ArtDesde ) + "'"+ [, ArtHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..ArtHasta ) + "'"+ [, ColDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..ColDesde ) + "'"+ [, CliDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..CliDesde ) + "'"+ [, CliDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..CliDesde ) + "'"+ [, ColHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..ColHasta ) + "'"+ [, TalDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..TalDesde ) + "'"+ [, TalHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..TalHasta ) + "'"+ [, ProDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..ProDesde ) + "'"+ [, ProHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..ProHasta ) + "'"+ [, AniDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..AniDesde ) + "'"+ [, AniHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..AniHasta ) + "'"+ [, MatDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..MatDesde ) + "'"+ [, MatHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..MatHasta ) + "'"+ [, ClasiDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..ClasiDesde ) + "'"+ [, ClasiHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..ClasiHasta ) + "'"+ [, UniDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..UniDesde ) + "'"+ [, UniHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..UniHasta ) + "'"+ [, NARBADesde = ] + "'" + this.FormatearTextoSql( &lcCursor..NARBADesde ) + "'"+ [, NARBAHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..NARBAHasta ) + "'"+ [, PrecIVADes = ] + transform( &lcCursor..PrecIVADes )+ [, PrecIVAHas = ] + transform( &lcCursor..PrecIVAHas )+ [, FecModDesd = ] + "'" + this.ConvertirDateSql( &lcCursor..FecModDesd ) + "'"+ [, FecModHast = ] + "'" + this.ConvertirDateSql( &lcCursor..FecModHast ) + "'"+ [, FecAltaDes = ] + "'" + this.ConvertirDateSql( &lcCursor..FecAltaDes ) + "'"+ [, FecAltaHas = ] + "'" + this.ConvertirDateSql( &lcCursor..FecAltaHas ) + "'"+ [, Obs = ] + "'" + this.FormatearTextoSql( &lcCursor..Obs ) + "'" + [ Where Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'" )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
				endIf
			else
				Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
				Text to lcCampos noShow
					 FECIMPO, FALTAFW, FECEXPO, FMODIFW, FECTRANS, VMODIFW, ZADSFW, ESTTRANS, BDALTAFW, BDMODIFW, UMODIFW, VALTAFW, SMODIFW, SALTAFW, UALTAFW, HORAEXPO, HMODIFW, HALTAFW, HORAIMPO, Codigo, FechaDesde, FechaHasta, BaseOrig, BaseStock, NoCom, ArtDesde, ArtHasta, ColDesde, CliDesde, CliDesde, ColHasta, TalDesde, TalHasta, ProDesde, ProHasta, AniDesde, AniHasta, MatDesde, MatHasta, ClasiDesde, ClasiHasta, UniDesde, UniHasta, NARBADesde, NARBAHasta, PrecIVADes, PrecIVAHas, FecModDesd, FecModHast, FecAltaDes, FecAltaHas, Obs
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FechaDesde ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FechaHasta ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BaseOrig ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BaseStock ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..NoCom ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ArtDesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ArtHasta ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ColDesde ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..CliDesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CliDesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ColHasta ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..TalDesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..TalHasta ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ProDesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ProHasta ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..AniDesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..AniHasta ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..MatDesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..MatHasta ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ClasiDesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ClasiHasta ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UniDesde ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..UniHasta ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..NARBADesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..NARBAHasta ) + "'" + ',' + transform( &lcCursor..PrecIVADes ) + ',' + transform( &lcCursor..PrecIVAHas ) + ',' + "'" + this.ConvertirDateSql( &lcCursor..FecModDesd ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FecModHast ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FecAltaDes ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FecAltaHas ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Obs ) + "'"
lcValoresCampos = substr(lcValoresCampos,2) 

				this.oConexion.EjecutarSql( [Insert into ZooLogic.COMPVTAS ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
				this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'COMPLETARDESDEVENTAS'
		if This.ActualizaEnRecepcion()
	endif
	Use in select( 'cExistentes' )
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearCursorMemo( tcCursorACrear as String, tcTablaConMemo as String ) as Void
		create cursor &tcCursorACrear ( Codigo C (38) , Orden N(16), texto C(80))
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirComponentes() As Void
		
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function ObtenerIdentificadorParaLoguear( tcCursor as String ) As String
		local lcRetorno as String, lnCC as String , loCC as Object, lni as Integer, lcSecuencia as String
		lcRetorno = this.oEntidad.cDescripcion 
		lcRetorno = lcRetorno + ' - Número: ' + transform( &tcCursor..Codigo     )
		Return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EsAliasDeProceso( tcAlias As String, tcPrefijo as string ) As Boolean
		local llRetorno as Boolean, lcAlias as String, lcPrefijo As String
		llRetorno = .F.
		lcAlias = upper( alltrim( tcAlias ) )
		lcPrefijo = upper( alltrim( tcPrefijo ) )
		Do Case
			Case  lcAlias == lcPrefijo + 'COMPLETARDESDEVENTAS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'COMPLETARDESDEVENTAS_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'COMPLETARDESDEVENTAS_OBS'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_COMPVTAS')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'COMPLETARDESDEVENTAS'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..Codigo
		llCondicion = isnull( lxVar )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad COMPLETARDESDEVENTAS. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'COMPLETARDESDEVENTAS'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		select recno() as _Rec, * from &lcCursor into cursor CurConRecno
		select max( _Rec ) as Maximo,Codigo as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( Codigo, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		Use in select( 'CurConRecno' )
		Use in select( 'RepMax' )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDatosInvalidos( toConexion as Object ) as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'COMPLETARDESDEVENTAS'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FechaDesde
		* Validar ANTERIORES A 1/1/1753  FechaHasta
		* Validar ANTERIORES A 1/1/1753  FecModDesd
		* Validar ANTERIORES A 1/1/1753  FecModHast
		* Validar ANTERIORES A 1/1/1753  FecAltaDes
		* Validar ANTERIORES A 1/1/1753  FecAltaHas
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_COMPVTAS') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_COMPVTAS
Create Table ZooLogic.TablaTrabajo_COMPVTAS ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fecimpo" datetime  null, 
"faltafw" datetime  null, 
"fecexpo" datetime  null, 
"fmodifw" datetime  null, 
"fectrans" datetime  null, 
"vmodifw" char( 13 )  null, 
"zadsfw" varchar(max)  null, 
"esttrans" char( 20 )  null, 
"bdaltafw" char( 8 )  null, 
"bdmodifw" char( 8 )  null, 
"umodifw" char( 100 )  null, 
"valtafw" char( 13 )  null, 
"smodifw" char( 7 )  null, 
"saltafw" char( 7 )  null, 
"ualtafw" char( 100 )  null, 
"horaexpo" char( 8 )  null, 
"hmodifw" char( 8 )  null, 
"haltafw" char( 8 )  null, 
"horaimpo" char( 8 )  null, 
"codigo" char( 38 )  null, 
"fechadesde" datetime  null, 
"fechahasta" datetime  null, 
"baseorig" char( 21 )  null, 
"basestock" char( 21 )  null, 
"nocom" char( 20 )  null, 
"artdesde" char( 13 )  null, 
"arthasta" char( 13 )  null, 
"coldesde" char( 2 )  null, 
"clidesde" char( 5 )  null, 
"clidesde" char( 5 )  null, 
"colhasta" char( 2 )  null, 
"taldesde" char( 3 )  null, 
"talhasta" char( 3 )  null, 
"prodesde" char( 10 )  null, 
"prohasta" char( 10 )  null, 
"anidesde" char( 2 )  null, 
"anihasta" char( 2 )  null, 
"matdesde" char( 10 )  null, 
"mathasta" char( 10 )  null, 
"clasidesde" char( 10 )  null, 
"clasihasta" char( 10 )  null, 
"unidesde" char( 3 )  null, 
"unihasta" char( 3 )  null, 
"narbadesde" char( 6 )  null, 
"narbahasta" char( 6 )  null, 
"precivades" numeric( 15, 4 )  null, 
"precivahas" numeric( 15, 4 )  null, 
"fecmoddesd" datetime  null, 
"fecmodhast" datetime  null, 
"fecaltades" datetime  null, 
"fecaltahas" datetime  null, 
"obs" varchar(max)  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_COMPVTAS' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_COMPVTAS' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'COMPLETARDESDEVENTAS'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		with loManejador
			if this.oEntidad.VerificarContexto( 'CB' )
			else
				.AgregarMapeo('Nrolinea','Nrolinea')
			endif
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('codigo','codigo')
			.AgregarMapeo('fechadesde','fechadesde')
			.AgregarMapeo('fechahasta','fechahasta')
			.AgregarMapeo('baseorig','baseorig')
			.AgregarMapeo('basestock','basestock')
			.AgregarMapeo('nocom','nocom')
			.AgregarMapeo('artdesde','artdesde')
			.AgregarMapeo('arthasta','arthasta')
			.AgregarMapeo('coldesde','coldesde')
			.AgregarMapeo('clidesde','clidesde')
			.AgregarMapeo('clidesde','clidesde')
			.AgregarMapeo('colhasta','colhasta')
			.AgregarMapeo('taldesde','taldesde')
			.AgregarMapeo('talhasta','talhasta')
			.AgregarMapeo('prodesde','prodesde')
			.AgregarMapeo('prohasta','prohasta')
			.AgregarMapeo('anidesde','anidesde')
			.AgregarMapeo('anihasta','anihasta')
			.AgregarMapeo('matdesde','matdesde')
			.AgregarMapeo('mathasta','mathasta')
			.AgregarMapeo('clasidesde','clasidesde')
			.AgregarMapeo('clasihasta','clasihasta')
			.AgregarMapeo('unidesde','unidesde')
			.AgregarMapeo('unihasta','unihasta')
			.AgregarMapeo('narbadesde','narbadesde')
			.AgregarMapeo('narbahasta','narbahasta')
			.AgregarMapeo('precivades','precivades')
			.AgregarMapeo('precivahas','precivahas')
			.AgregarMapeo('fecmoddesd','fecmoddesd')
			.AgregarMapeo('fecmodhast','fecmodhast')
			.AgregarMapeo('fecaltades','fecaltades')
			.AgregarMapeo('fecaltahas','fecaltahas')
			.AgregarMapeo('obs','obs')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_COMPVTAS'
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
				Update t Set t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.CODIGO = isnull( d.CODIGO, t.CODIGO ),t.FECHADESDE = isnull( d.FECHADESDE, t.FECHADESDE ),t.FECHAHASTA = isnull( d.FECHAHASTA, t.FECHAHASTA ),t.BASEORIG = isnull( d.BASEORIG, t.BASEORIG ),t.BASESTOCK = isnull( d.BASESTOCK, t.BASESTOCK ),t.NOCOM = isnull( d.NOCOM, t.NOCOM ),t.ARTDESDE = isnull( d.ARTDESDE, t.ARTDESDE ),t.ARTHASTA = isnull( d.ARTHASTA, t.ARTHASTA ),t.COLDESDE = isnull( d.COLDESDE, t.COLDESDE ),t.CLIDESDE = isnull( d.CLIDESDE, t.CLIDESDE ),t.COLHASTA = isnull( d.COLHASTA, t.COLHASTA ),t.TALDESDE = isnull( d.TALDESDE, t.TALDESDE ),t.TALHASTA = isnull( d.TALHASTA, t.TALHASTA ),t.PRODESDE = isnull( d.PRODESDE, t.PRODESDE ),t.PROHASTA = isnull( d.PROHASTA, t.PROHASTA ),t.ANIDESDE = isnull( d.ANIDESDE, t.ANIDESDE ),t.ANIHASTA = isnull( d.ANIHASTA, t.ANIHASTA ),t.MATDESDE = isnull( d.MATDESDE, t.MATDESDE ),t.MATHASTA = isnull( d.MATHASTA, t.MATHASTA ),t.CLASIDESDE = isnull( d.CLASIDESDE, t.CLASIDESDE ),t.CLASIHASTA = isnull( d.CLASIHASTA, t.CLASIHASTA ),t.UNIDESDE = isnull( d.UNIDESDE, t.UNIDESDE ),t.UNIHASTA = isnull( d.UNIHASTA, t.UNIHASTA ),t.NARBADESDE = isnull( d.NARBADESDE, t.NARBADESDE ),t.NARBAHASTA = isnull( d.NARBAHASTA, t.NARBAHASTA ),t.PRECIVADES = isnull( d.PRECIVADES, t.PRECIVADES ),t.PRECIVAHAS = isnull( d.PRECIVAHAS, t.PRECIVAHAS ),t.FECMODDESD = isnull( d.FECMODDESD, t.FECMODDESD ),t.FECMODHAST = isnull( d.FECMODHAST, t.FECMODHAST ),t.FECALTADES = isnull( d.FECALTADES, t.FECALTADES ),t.FECALTAHAS = isnull( d.FECALTAHAS, t.FECALTAHAS ),t.OBS = isnull( d.OBS, t.OBS )
					from ZooLogic.COMPVTAS t inner join deleted d 
							 on t.Codigo = d.Codigo
				-- Fin Updates
				insert into ZooLogic.COMPVTAS(Fecimpo,Faltafw,Fecexpo,Fmodifw,Fectrans,Vmodifw,Zadsfw,Esttrans,Bdaltafw,Bdmodifw,Umodifw,Valtafw,Smodifw,Saltafw,Ualtafw,Horaexpo,Hmodifw,Haltafw,Horaimpo,Codigo,Fechadesde,Fechahasta,Baseorig,Basestock,Nocom,Artdesde,Arthasta,Coldesde,Clidesde,Colhasta,Taldesde,Talhasta,Prodesde,Prohasta,Anidesde,Anihasta,Matdesde,Mathasta,Clasidesde,Clasihasta,Unidesde,Unihasta,Narbadesde,Narbahasta,Precivades,Precivahas,Fecmoddesd,Fecmodhast,Fecaltades,Fecaltahas,Obs)
					Select isnull( d.FECIMPO,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FECEXPO,''),isnull( d.FMODIFW,''),isnull( d.FECTRANS,''),isnull( d.VMODIFW,''),isnull( d.ZADSFW,''),isnull( d.ESTTRANS,''),isnull( d.BDALTAFW,''),isnull( d.BDMODIFW,''),isnull( d.UMODIFW,''),isnull( d.VALTAFW,''),isnull( d.SMODIFW,''),isnull( d.SALTAFW,''),isnull( d.UALTAFW,''),isnull( d.HORAEXPO,''),isnull( d.HMODIFW,''),convert( char(8), getdate(), 108 ),isnull( d.HORAIMPO,''),isnull( d.CODIGO,''),isnull( d.FECHADESDE,''),isnull( d.FECHAHASTA,''),isnull( d.BASEORIG,''),isnull( d.BASESTOCK,''),isnull( d.NOCOM,''),isnull( d.ARTDESDE,''),isnull( d.ARTHASTA,''),isnull( d.COLDESDE,''),isnull( d.CLIDESDE,''),isnull( d.COLHASTA,''),isnull( d.TALDESDE,''),isnull( d.TALHASTA,''),isnull( d.PRODESDE,''),isnull( d.PROHASTA,''),isnull( d.ANIDESDE,''),isnull( d.ANIHASTA,''),isnull( d.MATDESDE,''),isnull( d.MATHASTA,''),isnull( d.CLASIDESDE,''),isnull( d.CLASIHASTA,''),isnull( d.UNIDESDE,''),isnull( d.UNIHASTA,''),isnull( d.NARBADESDE,''),isnull( d.NARBAHASTA,''),isnull( d.PRECIVADES,0),isnull( d.PRECIVAHAS,0),isnull( d.FECMODDESD,''),isnull( d.FECMODHAST,''),isnull( d.FECALTADES,''),isnull( d.FECALTAHAS,''),isnull( d.OBS,'')
						From deleted d left join ZooLogic.COMPVTAS pk 
							 on d.Codigo = pk.Codigo
						Where pk.Codigo Is Null 
				-- Fin Inserts
			End
		EndText
		Return lcCadena
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	protected Function EliminarTablasDeTrabajo( toConexion as Object ) as void
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_COMPVTAS') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_COMPVTAS
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_COMPLETARDESDEVENTAS' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_COMPLETARDESDEVENTAS.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_COMPLETARDESDEVENTAS.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_COMPLETARDESDEVENTAS.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_COMPLETARDESDEVENTAS.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_COMPLETARDESDEVENTAS.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Versionmodificacionfw = nvl( c_COMPLETARDESDEVENTAS.Versionmodificacionfw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Estadotransferencia = nvl( c_COMPLETARDESDEVENTAS.Estadotransferencia, [] )
					.Basededatosaltafw = nvl( c_COMPLETARDESDEVENTAS.Basededatosaltafw, [] )
					.Basededatosmodificacionfw = nvl( c_COMPLETARDESDEVENTAS.Basededatosmodificacionfw, [] )
					.Usuariomodificacionfw = nvl( c_COMPLETARDESDEVENTAS.Usuariomodificacionfw, [] )
					.Versionaltafw = nvl( c_COMPLETARDESDEVENTAS.Versionaltafw, [] )
					.Seriemodificacionfw = nvl( c_COMPLETARDESDEVENTAS.Seriemodificacionfw, [] )
					.Seriealtafw = nvl( c_COMPLETARDESDEVENTAS.Seriealtafw, [] )
					.Usuarioaltafw = nvl( c_COMPLETARDESDEVENTAS.Usuarioaltafw, [] )
					.Horaexpo = nvl( c_COMPLETARDESDEVENTAS.Horaexpo, [] )
					.Horamodificacionfw = nvl( c_COMPLETARDESDEVENTAS.Horamodificacionfw, [] )
					.Horaaltafw = nvl( c_COMPLETARDESDEVENTAS.Horaaltafw, [] )
					.Horaimpo = nvl( c_COMPLETARDESDEVENTAS.Horaimpo, [] )
					.Codigo = nvl( c_COMPLETARDESDEVENTAS.Codigo, [] )
					.Fechadesde = GoLibrerias.ObtenerFechaFormateada( nvl( c_COMPLETARDESDEVENTAS.Fechadesde, ctod( '  /  /    ' ) ) )
					.Fechahasta = GoLibrerias.ObtenerFechaFormateada( nvl( c_COMPLETARDESDEVENTAS.Fechahasta, ctod( '  /  /    ' ) ) )
					.Baseorigen = nvl( c_COMPLETARDESDEVENTAS.Baseorigen, [] )
					.Basestock = nvl( c_COMPLETARDESDEVENTAS.Basestock, [] )
					.Nocomercializable = nvl( c_COMPLETARDESDEVENTAS.Nocomercializable, [] )
					.F_articulo_desde = nvl( c_COMPLETARDESDEVENTAS.F_articulo_desde, [] )
					.F_articulo_hasta = nvl( c_COMPLETARDESDEVENTAS.F_articulo_hasta, [] )
					.F_color_desde = nvl( c_COMPLETARDESDEVENTAS.F_color_desde, [] )
					.F_cliente_hasta_PK =  nvl( c_COMPLETARDESDEVENTAS.F_cliente_hasta, [] )
					.F_cliente_desde_PK =  nvl( c_COMPLETARDESDEVENTAS.F_cliente_desde, [] )
					.F_color_hasta = nvl( c_COMPLETARDESDEVENTAS.F_color_hasta, [] )
					.F_talle_desde = nvl( c_COMPLETARDESDEVENTAS.F_talle_desde, [] )
					.F_talle_hasta = nvl( c_COMPLETARDESDEVENTAS.F_talle_hasta, [] )
					.F_articulo_proveedor_desde = nvl( c_COMPLETARDESDEVENTAS.F_articulo_proveedor_desde, [] )
					.F_articulo_proveedor_hasta = nvl( c_COMPLETARDESDEVENTAS.F_articulo_proveedor_hasta, [] )
					.F_articulo_anio_desde = nvl( c_COMPLETARDESDEVENTAS.F_articulo_anio_desde, [] )
					.F_articulo_anio_hasta = nvl( c_COMPLETARDESDEVENTAS.F_articulo_anio_hasta, [] )
					.F_articulo_material_desde = nvl( c_COMPLETARDESDEVENTAS.F_articulo_material_desde, [] )
					.F_articulo_material_hasta = nvl( c_COMPLETARDESDEVENTAS.F_articulo_material_hasta, [] )
					.F_articulo_clasificacion_desde = nvl( c_COMPLETARDESDEVENTAS.F_articulo_clasificacion_desde, [] )
					.F_articulo_clasificacion_hasta = nvl( c_COMPLETARDESDEVENTAS.F_articulo_clasificacion_hasta, [] )
					.F_articulo_unidad_desde = nvl( c_COMPLETARDESDEVENTAS.F_articulo_unidad_desde, [] )
					.F_articulo_unidad_hasta = nvl( c_COMPLETARDESDEVENTAS.F_articulo_unidad_hasta, [] )
					.F_articulo_nomenclador_desde = nvl( c_COMPLETARDESDEVENTAS.F_articulo_nomenclador_desde, [] )
					.F_articulo_nomenclador_hasta = nvl( c_COMPLETARDESDEVENTAS.F_articulo_nomenclador_hasta, [] )
					.F_precioconimpuestos_desde = nvl( c_COMPLETARDESDEVENTAS.F_precioconimpuestos_desde, 0 )
					.F_precioconimpuestos_hasta = nvl( c_COMPLETARDESDEVENTAS.F_precioconimpuestos_hasta, 0 )
					.F_articulo_fechamodificacionfw_desde = GoLibrerias.ObtenerFechaFormateada( nvl( c_COMPLETARDESDEVENTAS.F_articulo_fechamodificacionfw_desde, ctod( '  /  /    ' ) ) )
					.F_articulo_fechamodificacionfw_hasta = GoLibrerias.ObtenerFechaFormateada( nvl( c_COMPLETARDESDEVENTAS.F_articulo_fechamodificacionfw_hasta, ctod( '  /  /    ' ) ) )
					.F_articulo_fechaaltafw_desde = GoLibrerias.ObtenerFechaFormateada( nvl( c_COMPLETARDESDEVENTAS.F_articulo_fechaaltafw_desde, ctod( '  /  /    ' ) ) )
					.F_articulo_fechaaltafw_hasta = GoLibrerias.ObtenerFechaFormateada( nvl( c_COMPLETARDESDEVENTAS.F_articulo_fechaaltafw_hasta, ctod( '  /  /    ' ) ) )
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
		return c_COMPLETARDESDEVENTAS.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.COMPVTAS' )
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
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "Codigo"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
		text to lcSQL textmerge noshow
				SELECT nro,totalRegistros,Codigo as Id
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    Codigo from (
							select * 
								from ZooLogic.COMPVTAS 
								Where   COMPVTAS.CODIGO != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "COMPVTAS", "", lcCursor, set("Datasession") )
		lcXml = this.CursorAXml( lcCursor )
		
		use in select( lcCursor )
		
		Return lcXml 
		
	endfunc
	*-----------------------------------------------------------------------------------------
	function ObtenerDatosEntidadPaginado( tcOrderBy as String, tcFiltro as String, tnCantidad as Integer, tnPagina as Integer )  as String
		local lcOrderBy as String, lnCuantos as Integer, lnPagina as Integer, lnTope as Integer, lnDesde as Integer, lcSQL as String, lcCursor as String, lcXml as String
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "Codigo"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
			text to lcAtributos textmerge noshow
			"Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Codigo" as "Codigo", "Fechadesde" as "Fechadesde", "Fechahasta" as "Fechahasta", "Baseorig" as "Baseorigen", "Basestock" as "Basestock", "Nocom" as "Nocomercializable", "Artdesde" as "F_articulo_desde", "Arthasta" as "F_articulo_hasta", "Coldesde" as "F_color_desde", "Clidesde" as "F_cliente_hasta", "Clidesde" as "F_cliente_desde", "Colhasta" as "F_color_hasta", "Taldesde" as "F_talle_desde", "Talhasta" as "F_talle_hasta", "Prodesde" as "F_articulo_proveedor_desde", "Prohasta" as "F_articulo_proveedor_hasta", "Anidesde" as "F_articulo_anio_desde", "Anihasta" as "F_articulo_anio_hasta", "Matdesde" as "F_articulo_material_desde", "Mathasta" as "F_articulo_material_hasta", "Clasidesde" as "F_articulo_clasificacion_desde", "Clasihasta" as "F_articulo_clasificacion_hasta", "Unidesde" as "F_articulo_unidad_desde", "Unihasta" as "F_articulo_unidad_hasta", "Narbadesde" as "F_articulo_nomenclador_desde", "Narbahasta" as "F_articulo_nomenclador_hasta", "Precivades" as "F_precioconimpuestos_desde", "Precivahas" as "F_precioconimpuestos_hasta", "Fecmoddesd" as "F_articulo_fechamodificacionfw_desde", "Fecmodhast" as "F_articulo_fechamodificacionfw_hasta", "Fecaltades" as "F_articulo_fechaaltafw_desde", "Fecaltahas" as "F_articulo_fechaaltafw_hasta", "Obs" as "Observacion"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.COMPVTAS 
								Where   COMPVTAS.CODIGO != ''
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
	Tabla = 'COMPVTAS'
	Filtro = " COMPVTAS.CODIGO != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " COMPVTAS.CODIGO != ''"
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
	<row entidad="COMPLETARDESDEVENTAS                    " atributo="FECHAIMPO                               " tabla="COMPVTAS       " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPLETARDESDEVENTAS                    " atributo="FECHAALTAFW                             " tabla="COMPVTAS       " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPLETARDESDEVENTAS                    " atributo="FECHAEXPO                               " tabla="COMPVTAS       " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPLETARDESDEVENTAS                    " atributo="FECHAMODIFICACIONFW                     " tabla="COMPVTAS       " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPLETARDESDEVENTAS                    " atributo="FECHATRANSFERENCIA                      " tabla="COMPVTAS       " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha transferencia                                                                                                                                             " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPLETARDESDEVENTAS                    " atributo="VERSIONMODIFICACIONFW                   " tabla="COMPVTAS       " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPLETARDESDEVENTAS                    " atributo="ZADSFW                                  " tabla="COMPVTAS       " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPLETARDESDEVENTAS                    " atributo="ESTADOTRANSFERENCIA                     " tabla="COMPVTAS       " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado transferencia                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPLETARDESDEVENTAS                    " atributo="BASEDEDATOSALTAFW                       " tabla="COMPVTAS       " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPLETARDESDEVENTAS                    " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="COMPVTAS       " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPLETARDESDEVENTAS                    " atributo="USUARIOMODIFICACIONFW                   " tabla="COMPVTAS       " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPLETARDESDEVENTAS                    " atributo="VERSIONALTAFW                           " tabla="COMPVTAS       " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPLETARDESDEVENTAS                    " atributo="SERIEMODIFICACIONFW                     " tabla="COMPVTAS       " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPLETARDESDEVENTAS                    " atributo="SERIEALTAFW                             " tabla="COMPVTAS       " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPLETARDESDEVENTAS                    " atributo="USUARIOALTAFW                           " tabla="COMPVTAS       " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPLETARDESDEVENTAS                    " atributo="HORAEXPO                                " tabla="COMPVTAS       " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPLETARDESDEVENTAS                    " atributo="HORAMODIFICACIONFW                      " tabla="COMPVTAS       " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPLETARDESDEVENTAS                    " atributo="HORAALTAFW                              " tabla="COMPVTAS       " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPLETARDESDEVENTAS                    " atributo="HORAIMPO                                " tabla="COMPVTAS       " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPLETARDESDEVENTAS                    " atributo="CODIGO                                  " tabla="COMPVTAS       " campo="CODIGO    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="2" etiqueta="Número                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPLETARDESDEVENTAS                    " atributo="FECHADESDE                              " tabla="COMPVTAS       " campo="FECHADESDE" claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="400" etiqueta="Fecha desde                                                                                                                                                     " dominio="FECHACALENDARIO               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPLETARDESDEVENTAS                    " atributo="FECHAHASTA                              " tabla="COMPVTAS       " campo="FECHAHASTA" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goServicios.Librerias.ObtenerFecha()                                                                                                                                                                                                                         " obligatorio="true" admitebusqueda="402" etiqueta="Fecha hasta                                                                                                                                                     " dominio="FECHACALENDARIO               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPLETARDESDEVENTAS                    " atributo="BASEORIGEN                              " tabla="COMPVTAS       " campo="BASEORIG  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="21" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="404" etiqueta="Cantidades en base de ventas de                                                                                                                                 " dominio="COMBOSUCYAGRU                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPLETARDESDEVENTAS                    " atributo="BASESTOCK                               " tabla="COMPVTAS       " campo="BASESTOCK " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="21" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="406" etiqueta="Limita la cantidad al stock actual de                                                                                                                           " dominio="COMBOSUCYAGRUSTOCK            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPLETARDESDEVENTAS                    " atributo="NOCOMERCIALIZABLE                       " tabla="COMPVTAS       " campo="NOCOM     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="1                                                                                                                                                                                                                                                             " obligatorio="false" admitebusqueda="408" etiqueta="Fecha de no comercializable                                                                                                                                     " dominio="COMBOXML                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="4" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPLETARDESDEVENTAS                    " atributo="F_ARTICULO_DESDE                        " tabla="COMPVTAS       " campo="ARTDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="410" etiqueta="Artículo                                                                                                                                                        " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="4" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPLETARDESDEVENTAS                    " atributo="F_ARTICULO_HASTA                        " tabla="COMPVTAS       " campo="ARTHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="ZZZZZZZZZZZZZ                                                                                                                                                                                                                                                 " obligatorio="false" admitebusqueda="412" etiqueta="Artículo                                                                                                                                                        " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="4" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPLETARDESDEVENTAS                    " atributo="F_COLOR_DESDE                           " tabla="COMPVTAS       " campo="COLDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="414" etiqueta="Color                                                                                                                                                           " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="5" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPLETARDESDEVENTAS                    " atributo="F_CLIENTE_HASTA                         " tabla="COMPVTAS       " campo="CLIDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CLIENTE                                 " tipodato="C         " longitud="5" decimales="0" valorsugerido="ZZZZZ                                                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="416" etiqueta="Cliente hasta                                                                                                                                                   " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="3" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPLETARDESDEVENTAS                    " atributo="F_CLIENTE_DESDE                         " tabla="COMPVTAS       " campo="CLIDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CLIENTE                                 " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="418" etiqueta="Cliente desde                                                                                                                                                   " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="3" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPLETARDESDEVENTAS                    " atributo="F_COLOR_HASTA                           " tabla="COMPVTAS       " campo="COLHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="2" decimales="0" valorsugerido="ZZ                                                                                                                                                                                                                                                            " obligatorio="false" admitebusqueda="420" etiqueta="Color                                                                                                                                                           " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="5" orden="8" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPLETARDESDEVENTAS                    " atributo="F_TALLE_DESDE                           " tabla="COMPVTAS       " campo="TALDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="3" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="422" etiqueta="Talle                                                                                                                                                           " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="6" orden="9" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPLETARDESDEVENTAS                    " atributo="F_TALLE_HASTA                           " tabla="COMPVTAS       " campo="TALHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="3" decimales="0" valorsugerido="ZZZ                                                                                                                                                                                                                                                           " obligatorio="false" admitebusqueda="424" etiqueta="Talle                                                                                                                                                           " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="6" orden="10" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPLETARDESDEVENTAS                    " atributo="F_ARTICULO_PROVEEDOR_DESDE              " tabla="COMPVTAS       " campo="PRODESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="426" etiqueta="Proveedor                                                                                                                                                       " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="7" orden="11" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPLETARDESDEVENTAS                    " atributo="F_ARTICULO_PROVEEDOR_HASTA              " tabla="COMPVTAS       " campo="PROHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="ZZZZZZZZZZ                                                                                                                                                                                                                                                    " obligatorio="false" admitebusqueda="428" etiqueta="Proveedor                                                                                                                                                       " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="7" orden="12" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPLETARDESDEVENTAS                    " atributo="F_ARTICULO_ANIO_DESDE                   " tabla="COMPVTAS       " campo="ANIDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="430" etiqueta="Año                                                                                                                                                             " dominio="EtiquetaNumericoDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="9" orden="15" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPLETARDESDEVENTAS                    " atributo="F_ARTICULO_ANIO_HASTA                   " tabla="COMPVTAS       " campo="ANIHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="2" decimales="0" valorsugerido="99                                                                                                                                                                                                                                                            " obligatorio="false" admitebusqueda="432" etiqueta="Año                                                                                                                                                             " dominio="EtiquetaNumericoDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="9" orden="16" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPLETARDESDEVENTAS                    " atributo="F_ARTICULO_MATERIAL_DESDE               " tabla="COMPVTAS       " campo="MATDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="434" etiqueta="Material                                                                                                                                                        " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="11" orden="19" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPLETARDESDEVENTAS                    " atributo="F_ARTICULO_MATERIAL_HASTA               " tabla="COMPVTAS       " campo="MATHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="ZZZZZZZZZZ                                                                                                                                                                                                                                                    " obligatorio="false" admitebusqueda="436" etiqueta="Material                                                                                                                                                        " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="11" orden="20" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPLETARDESDEVENTAS                    " atributo="F_ARTICULO_CLASIFICACION_DESDE          " tabla="COMPVTAS       " campo="CLASIDESDE" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="438" etiqueta="Clasificación de artículo                                                                                                                                       " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="15" orden="26" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPLETARDESDEVENTAS                    " atributo="F_ARTICULO_CLASIFICACION_HASTA          " tabla="COMPVTAS       " campo="CLASIHASTA" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="ZZZZZZZZZZ                                                                                                                                                                                                                                                    " obligatorio="false" admitebusqueda="440" etiqueta="Clasificación de artículo                                                                                                                                       " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="15" orden="27" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPLETARDESDEVENTAS                    " atributo="F_ARTICULO_UNIDAD_DESDE                 " tabla="COMPVTAS       " campo="UNIDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="3" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="442" etiqueta="Unidad de Medida                                                                                                                                                " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="19" orden="34" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPLETARDESDEVENTAS                    " atributo="F_ARTICULO_UNIDAD_HASTA                 " tabla="COMPVTAS       " campo="UNIHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="3" decimales="0" valorsugerido="ZZZ                                                                                                                                                                                                                                                           " obligatorio="false" admitebusqueda="444" etiqueta="Unidad de Medida                                                                                                                                                " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="19" orden="35" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPLETARDESDEVENTAS                    " atributo="F_ARTICULO_NOMENCLADOR_DESDE            " tabla="COMPVTAS       " campo="NARBADESDE" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="6" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="446" etiqueta="Código del nomenclador ARBA                                                                                                                                     " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="20" orden="36" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPLETARDESDEVENTAS                    " atributo="F_ARTICULO_NOMENCLADOR_HASTA            " tabla="COMPVTAS       " campo="NARBAHASTA" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="6" decimales="0" valorsugerido="ZZZZZZ                                                                                                                                                                                                                                                        " obligatorio="false" admitebusqueda="448" etiqueta="Código del nomenclador ARBA                                                                                                                                     " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="20" orden="37" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPLETARDESDEVENTAS                    " atributo="F_PRECIOCONIMPUESTOS_DESDE              " tabla="COMPVTAS       " campo="PRECIVADES" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="4" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="450" etiqueta="Precio de venta con IVA                                                                                                                                         " dominio="EtiquetaNumericoDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="21" orden="38" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPLETARDESDEVENTAS                    " atributo="F_PRECIOCONIMPUESTOS_HASTA              " tabla="COMPVTAS       " campo="PRECIVAHAS" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="4" valorsugerido="999999.99                                                                                                                                                                                                                                                     " obligatorio="false" admitebusqueda="452" etiqueta="Precio de venta con IVA                                                                                                                                         " dominio="EtiquetaNumericoDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="21" orden="39" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPLETARDESDEVENTAS                    " atributo="F_ARTICULO_FECHAMODIFICACIONFW_DESDE    " tabla="COMPVTAS       " campo="FECMODDESD" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="454" etiqueta="Fecha modificación                                                                                                                                              " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="22" orden="40" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPLETARDESDEVENTAS                    " atributo="F_ARTICULO_FECHAMODIFICACIONFW_HASTA    " tabla="COMPVTAS       " campo="FECMODHAST" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goServicios.Librerias.ObtenerFecha()                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="456" etiqueta="Fecha modificación                                                                                                                                              " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="22" orden="41" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPLETARDESDEVENTAS                    " atributo="F_ARTICULO_FECHAALTAFW_DESDE            " tabla="COMPVTAS       " campo="FECALTADES" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="458" etiqueta="Fecha alta                                                                                                                                                      " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="23" orden="42" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPLETARDESDEVENTAS                    " atributo="F_ARTICULO_FECHAALTAFW_HASTA            " tabla="COMPVTAS       " campo="FECALTAHAS" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goServicios.Librerias.ObtenerFecha()                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="460" etiqueta="Fecha alta                                                                                                                                                      " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="23" orden="43" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPLETARDESDEVENTAS                    " atributo="OBSERVACION                             " tabla="COMPVTAS       " campo="OBS       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Observaciones                                                                                                                                                   " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="99" subgrupo="99" orden="99" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="NOMBRE                                  " tabla="CLI            " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="417" etiqueta="Detalle Cli.                                                                                                                                                    " dominio="TEXTOBUSQUEDA                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CLI On COMPVTAS.CLIDESDE = CLI.CLCOD And  CLI.CLCOD != ''                                                                                                                                                                                          " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="NOMBRE                                  " tabla="CLI            " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="419" etiqueta="Detalle Cli.                                                                                                                                                    " dominio="TEXTOBUSQUEDA                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CLI On COMPVTAS.CLIDESDE = CLI.CLCOD And  CLI.CLCOD != ''                                                                                                                                                                                          " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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