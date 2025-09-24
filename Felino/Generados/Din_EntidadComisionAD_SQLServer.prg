
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
			local  lxComisionFmodifw, lxComisionFaltafw, lxComisionFecexpo, lxComisionFecimpo, lxComisionFectrans, lxComisionValtafw, lxComisionHmodifw, lxComisionBdaltafw, lxComisionBdmodifw, lxComisionEsttrans, lxComisionUmodifw, lxComisionUaltafw, lxComisionSaltafw, lxComisionHoraexpo, lxComisionVmodifw, lxComisionHaltafw, lxComisionZadsfw, lxComisionSmodifw, lxComisionHoraimpo, lxComisionCodigo, lxComisionFechah, lxComisionFechafd, lxComisionDescrip, lxComisionSucdesde, lxComisionArtdesde, lxComisionUnidesde, lxComisionLinsdesde, lxComisionTipsdesde, lxComisionMatdesde, lxComisionSegsdesde, lxComisionSegshasta, lxComisionArthasta, lxComisionUnihasta, lxComisionLinshasta, lxComisionTipshasta, lxComisionSuchasta, lxComisionMathasta, lxComisionColdesde, lxComisionPorcent, lxComisionConforma1, lxComisionColhasta, lxComisionMontof, lxComisionConforma2, lxComisionTaldesde, lxComisionTalhasta, lxComisionProvdesde, lxComisionProvhasta, lxComisionMobs
				lxComisionFmodifw =  .Fechamodificacionfw			lxComisionFaltafw =  .Fechaaltafw			lxComisionFecexpo =  .Fechaexpo			lxComisionFecimpo =  .Fechaimpo			lxComisionFectrans =  .Fechatransferencia			lxComisionValtafw =  .Versionaltafw			lxComisionHmodifw =  .Horamodificacionfw			lxComisionBdaltafw =  .Basededatosaltafw			lxComisionBdmodifw =  .Basededatosmodificacionfw			lxComisionEsttrans =  .Estadotransferencia			lxComisionUmodifw =  .Usuariomodificacionfw			lxComisionUaltafw =  .Usuarioaltafw			lxComisionSaltafw =  .Seriealtafw			lxComisionHoraexpo =  .Horaexpo			lxComisionVmodifw =  .Versionmodificacionfw			lxComisionHaltafw =  .Horaaltafw			lxComisionZadsfw =  .Zadsfw			lxComisionSmodifw =  .Seriemodificacionfw			lxComisionHoraimpo =  .Horaimpo			lxComisionCodigo =  .Codigo			lxComisionFechah =  .Fechavigenciahasta			lxComisionFechafd =  .Fechavigenciadesde			lxComisionDescrip =  .Descripcion			lxComisionSucdesde =  .F_sucursal_codigo_desde			lxComisionArtdesde =  .F_articulo_desde			lxComisionUnidesde =  .F_articulo_unidad_desde			lxComisionLinsdesde =  .F_sucursal_linea_desde			lxComisionTipsdesde =  .F_sucursal_tipo_desde			lxComisionMatdesde =  .F_articulo_material_desde			lxComisionSegsdesde =  .F_sucursal_segmentacion_desde			lxComisionSegshasta =  .F_sucursal_segmentacion_hasta			lxComisionArthasta =  .F_articulo_hasta			lxComisionUnihasta =  .F_articulo_unidad_hasta			lxComisionLinshasta =  .F_sucursal_linea_hasta			lxComisionTipshasta =  .F_sucursal_tipo_hasta			lxComisionSuchasta =  .F_sucursal_codigo_hasta			lxComisionMathasta =  .F_articulo_material_hasta			lxComisionColdesde =  .F_color_desde			lxComisionPorcent =  .Porcentaje			lxComisionConforma1 =  .Conformacion1			lxComisionColhasta =  .F_color_hasta			lxComisionMontof =  .Montofijo			lxComisionConforma2 =  .Conformacion2			lxComisionTaldesde =  .F_talle_desde			lxComisionTalhasta =  .F_talle_hasta			lxComisionProvdesde =  .F_articulo_proveedor_desde			lxComisionProvhasta =  .F_articulo_proveedor_hasta			lxComisionMobs =  .Observacion
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
				insert into ZooLogic.COMISION ( "Fmodifw","Faltafw","Fecexpo","Fecimpo","Fectrans","Valtafw","Hmodifw","Bdaltafw","Bdmodifw","Esttrans","Umodifw","Ualtafw","Saltafw","Horaexpo","Vmodifw","Haltafw","Zadsfw","Smodifw","Horaimpo","Codigo","Fechah","Fechafd","Descrip","Sucdesde","Artdesde","Unidesde","Linsdesde","Tipsdesde","Matdesde","Segsdesde","Segshasta","Arthasta","Unihasta","Linshasta","Tipshasta","Suchasta","Mathasta","Coldesde","Porcent","Conforma1","Colhasta","Montof","Conforma2","Taldesde","Talhasta","Provdesde","Provhasta","Mobs" ) values ( <<"'" + this.ConvertirDateSql( lxComisionFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxComisionFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxComisionFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxComisionFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxComisionFectrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionCodigo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxComisionFechah ) + "'" >>, <<"'" + this.ConvertirDateSql( lxComisionFechafd ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionDescrip ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionSucdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionArtdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionUnidesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionLinsdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionTipsdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionMatdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionSegsdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionSegshasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionArthasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionUnihasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionLinshasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionTipshasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionSuchasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionMathasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionColdesde ) + "'" >>, <<lxComisionPorcent >>, <<"'" + this.FormatearTextoSql( lxComisionConforma1 ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionColhasta ) + "'" >>, <<lxComisionMontof >>, <<"'" + this.FormatearTextoSql( lxComisionConforma2 ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionTaldesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionTalhasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionProvdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionProvhasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionMobs ) + "'" >> )
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
			local  lxComisionFmodifw, lxComisionFaltafw, lxComisionFecexpo, lxComisionFecimpo, lxComisionFectrans, lxComisionValtafw, lxComisionHmodifw, lxComisionBdaltafw, lxComisionBdmodifw, lxComisionEsttrans, lxComisionUmodifw, lxComisionUaltafw, lxComisionSaltafw, lxComisionHoraexpo, lxComisionVmodifw, lxComisionHaltafw, lxComisionZadsfw, lxComisionSmodifw, lxComisionHoraimpo, lxComisionCodigo, lxComisionFechah, lxComisionFechafd, lxComisionDescrip, lxComisionSucdesde, lxComisionArtdesde, lxComisionUnidesde, lxComisionLinsdesde, lxComisionTipsdesde, lxComisionMatdesde, lxComisionSegsdesde, lxComisionSegshasta, lxComisionArthasta, lxComisionUnihasta, lxComisionLinshasta, lxComisionTipshasta, lxComisionSuchasta, lxComisionMathasta, lxComisionColdesde, lxComisionPorcent, lxComisionConforma1, lxComisionColhasta, lxComisionMontof, lxComisionConforma2, lxComisionTaldesde, lxComisionTalhasta, lxComisionProvdesde, lxComisionProvhasta, lxComisionMobs
				lxComisionFmodifw =  .Fechamodificacionfw			lxComisionFaltafw =  .Fechaaltafw			lxComisionFecexpo =  .Fechaexpo			lxComisionFecimpo =  .Fechaimpo			lxComisionFectrans =  .Fechatransferencia			lxComisionValtafw =  .Versionaltafw			lxComisionHmodifw =  .Horamodificacionfw			lxComisionBdaltafw =  .Basededatosaltafw			lxComisionBdmodifw =  .Basededatosmodificacionfw			lxComisionEsttrans =  .Estadotransferencia			lxComisionUmodifw =  .Usuariomodificacionfw			lxComisionUaltafw =  .Usuarioaltafw			lxComisionSaltafw =  .Seriealtafw			lxComisionHoraexpo =  .Horaexpo			lxComisionVmodifw =  .Versionmodificacionfw			lxComisionHaltafw =  .Horaaltafw			lxComisionZadsfw =  .Zadsfw			lxComisionSmodifw =  .Seriemodificacionfw			lxComisionHoraimpo =  .Horaimpo			lxComisionCodigo =  .Codigo			lxComisionFechah =  .Fechavigenciahasta			lxComisionFechafd =  .Fechavigenciadesde			lxComisionDescrip =  .Descripcion			lxComisionSucdesde =  .F_sucursal_codigo_desde			lxComisionArtdesde =  .F_articulo_desde			lxComisionUnidesde =  .F_articulo_unidad_desde			lxComisionLinsdesde =  .F_sucursal_linea_desde			lxComisionTipsdesde =  .F_sucursal_tipo_desde			lxComisionMatdesde =  .F_articulo_material_desde			lxComisionSegsdesde =  .F_sucursal_segmentacion_desde			lxComisionSegshasta =  .F_sucursal_segmentacion_hasta			lxComisionArthasta =  .F_articulo_hasta			lxComisionUnihasta =  .F_articulo_unidad_hasta			lxComisionLinshasta =  .F_sucursal_linea_hasta			lxComisionTipshasta =  .F_sucursal_tipo_hasta			lxComisionSuchasta =  .F_sucursal_codigo_hasta			lxComisionMathasta =  .F_articulo_material_hasta			lxComisionColdesde =  .F_color_desde			lxComisionPorcent =  .Porcentaje			lxComisionConforma1 =  .Conformacion1			lxComisionColhasta =  .F_color_hasta			lxComisionMontof =  .Montofijo			lxComisionConforma2 =  .Conformacion2			lxComisionTaldesde =  .F_talle_desde			lxComisionTalhasta =  .F_talle_hasta			lxComisionProvdesde =  .F_articulo_proveedor_desde			lxComisionProvhasta =  .F_articulo_proveedor_hasta			lxComisionMobs =  .Observacion
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()
			lxValorClavePrimaria = .oEntidad.CODIGO
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ZooLogic.COMISION set "Fmodifw" = <<"'" + this.ConvertirDateSql( lxComisionFmodifw ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxComisionFaltafw ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxComisionFecexpo ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxComisionFecimpo ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxComisionFectrans ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxComisionValtafw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxComisionHmodifw ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxComisionBdaltafw ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxComisionBdmodifw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxComisionEsttrans ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxComisionUmodifw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxComisionUaltafw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxComisionSaltafw ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxComisionHoraexpo ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxComisionVmodifw ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxComisionHaltafw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxComisionZadsfw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxComisionSmodifw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxComisionHoraimpo ) + "'">>,"Codigo" = <<"'" + this.FormatearTextoSql( lxComisionCodigo ) + "'">>,"Fechah" = <<"'" + this.ConvertirDateSql( lxComisionFechah ) + "'">>,"Fechafd" = <<"'" + this.ConvertirDateSql( lxComisionFechafd ) + "'">>,"Descrip" = <<"'" + this.FormatearTextoSql( lxComisionDescrip ) + "'">>,"Sucdesde" = <<"'" + this.FormatearTextoSql( lxComisionSucdesde ) + "'">>,"Artdesde" = <<"'" + this.FormatearTextoSql( lxComisionArtdesde ) + "'">>,"Unidesde" = <<"'" + this.FormatearTextoSql( lxComisionUnidesde ) + "'">>,"Linsdesde" = <<"'" + this.FormatearTextoSql( lxComisionLinsdesde ) + "'">>,"Tipsdesde" = <<"'" + this.FormatearTextoSql( lxComisionTipsdesde ) + "'">>,"Matdesde" = <<"'" + this.FormatearTextoSql( lxComisionMatdesde ) + "'">>,"Segsdesde" = <<"'" + this.FormatearTextoSql( lxComisionSegsdesde ) + "'">>,"Segshasta" = <<"'" + this.FormatearTextoSql( lxComisionSegshasta ) + "'">>,"Arthasta" = <<"'" + this.FormatearTextoSql( lxComisionArthasta ) + "'">>,"Unihasta" = <<"'" + this.FormatearTextoSql( lxComisionUnihasta ) + "'">>,"Linshasta" = <<"'" + this.FormatearTextoSql( lxComisionLinshasta ) + "'">>,"Tipshasta" = <<"'" + this.FormatearTextoSql( lxComisionTipshasta ) + "'">>,"Suchasta" = <<"'" + this.FormatearTextoSql( lxComisionSuchasta ) + "'">>,"Mathasta" = <<"'" + this.FormatearTextoSql( lxComisionMathasta ) + "'">>,"Coldesde" = <<"'" + this.FormatearTextoSql( lxComisionColdesde ) + "'">>,"Porcent" = <<lxComisionPorcent>>,"Conforma1" = <<"'" + this.FormatearTextoSql( lxComisionConforma1 ) + "'">>,"Colhasta" = <<"'" + this.FormatearTextoSql( lxComisionColhasta ) + "'">>,"Montof" = <<lxComisionMontof>>,"Conforma2" = <<"'" + this.FormatearTextoSql( lxComisionConforma2 ) + "'">>,"Taldesde" = <<"'" + this.FormatearTextoSql( lxComisionTaldesde ) + "'">>,"Talhasta" = <<"'" + this.FormatearTextoSql( lxComisionTalhasta ) + "'">>,"Provdesde" = <<"'" + this.FormatearTextoSql( lxComisionProvdesde ) + "'">>,"Provhasta" = <<"'" + this.FormatearTextoSql( lxComisionProvhasta ) + "'">>,"Mobs" = <<"'" + this.FormatearTextoSql( lxComisionMobs ) + "'">> where "Codigo" = <<"'" + this.FormatearTextoSql( lxComisionCodigo ) + "'">> and  COMISION.CODIGO != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
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
				select "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Valtafw" as "Versionaltafw", "Hmodifw" as "Horamodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Horaexpo" as "Horaexpo", "Vmodifw" as "Versionmodificacionfw", "Haltafw" as "Horaaltafw", "Zadsfw" as "Zadsfw", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Codigo" as "Codigo", "Fechah" as "Fechavigenciahasta", "Fechafd" as "Fechavigenciadesde", "Descrip" as "Descripcion", "Sucdesde" as "F_sucursal_codigo_desde", "Artdesde" as "F_articulo_desde", "Unidesde" as "F_articulo_unidad_desde", "Linsdesde" as "F_sucursal_linea_desde", "Tipsdesde" as "F_sucursal_tipo_desde", "Matdesde" as "F_articulo_material_desde", "Segsdesde" as "F_sucursal_segmentacion_desde", "Segshasta" as "F_sucursal_segmentacion_hasta", "Arthasta" as "F_articulo_hasta", "Unihasta" as "F_articulo_unidad_hasta", "Linshasta" as "F_sucursal_linea_hasta", "Tipshasta" as "F_sucursal_tipo_hasta", "Suchasta" as "F_sucursal_codigo_hasta", "Mathasta" as "F_articulo_material_hasta", "Coldesde" as "F_color_desde", "Porcent" as "Porcentaje", "Conforma1" as "Conformacion1", "Colhasta" as "F_color_hasta", "Montof" as "Montofijo", "Conforma2" as "Conformacion2", "Taldesde" as "F_talle_desde", "Talhasta" as "F_talle_hasta", "Provdesde" as "F_articulo_proveedor_desde", "Provhasta" as "F_articulo_proveedor_hasta", "Mobs" as "Observacion" from ZooLogic.COMISION where "Codigo" = <<"'" + this.FormatearTextoSql( lxComisionCodigo ) + "'">> and  COMISION.CODIGO != ''
			endtext
			use in select('c_COMISION')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMISION', set( 'Datasession' ) )

			if reccount( 'c_COMISION' ) = 0
				llRetorno = .f.
			else
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
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Valtafw" as "Versionaltafw", "Hmodifw" as "Horamodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Horaexpo" as "Horaexpo", "Vmodifw" as "Versionmodificacionfw", "Haltafw" as "Horaaltafw", "Zadsfw" as "Zadsfw", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Codigo" as "Codigo", "Fechah" as "Fechavigenciahasta", "Fechafd" as "Fechavigenciadesde", "Descrip" as "Descripcion", "Sucdesde" as "F_sucursal_codigo_desde", "Artdesde" as "F_articulo_desde", "Unidesde" as "F_articulo_unidad_desde", "Linsdesde" as "F_sucursal_linea_desde", "Tipsdesde" as "F_sucursal_tipo_desde", "Matdesde" as "F_articulo_material_desde", "Segsdesde" as "F_sucursal_segmentacion_desde", "Segshasta" as "F_sucursal_segmentacion_hasta", "Arthasta" as "F_articulo_hasta", "Unihasta" as "F_articulo_unidad_hasta", "Linshasta" as "F_sucursal_linea_hasta", "Tipshasta" as "F_sucursal_tipo_hasta", "Suchasta" as "F_sucursal_codigo_hasta", "Mathasta" as "F_articulo_material_hasta", "Coldesde" as "F_color_desde", "Porcent" as "Porcentaje", "Conforma1" as "Conformacion1", "Colhasta" as "F_color_hasta", "Montof" as "Montofijo", "Conforma2" as "Conformacion2", "Taldesde" as "F_talle_desde", "Talhasta" as "F_talle_hasta", "Provdesde" as "F_articulo_proveedor_desde", "Provhasta" as "F_articulo_proveedor_hasta", "Mobs" as "Observacion" from ZooLogic.COMISION where  COMISION.CODIGO != '' order by CODIGO
			endtext
			use in select('c_COMISION')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMISION', set( 'Datasession' ) )
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
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Valtafw" as "Versionaltafw", "Hmodifw" as "Horamodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Horaexpo" as "Horaexpo", "Vmodifw" as "Versionmodificacionfw", "Haltafw" as "Horaaltafw", "Zadsfw" as "Zadsfw", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Codigo" as "Codigo", "Fechah" as "Fechavigenciahasta", "Fechafd" as "Fechavigenciadesde", "Descrip" as "Descripcion", "Sucdesde" as "F_sucursal_codigo_desde", "Artdesde" as "F_articulo_desde", "Unidesde" as "F_articulo_unidad_desde", "Linsdesde" as "F_sucursal_linea_desde", "Tipsdesde" as "F_sucursal_tipo_desde", "Matdesde" as "F_articulo_material_desde", "Segsdesde" as "F_sucursal_segmentacion_desde", "Segshasta" as "F_sucursal_segmentacion_hasta", "Arthasta" as "F_articulo_hasta", "Unihasta" as "F_articulo_unidad_hasta", "Linshasta" as "F_sucursal_linea_hasta", "Tipshasta" as "F_sucursal_tipo_hasta", "Suchasta" as "F_sucursal_codigo_hasta", "Mathasta" as "F_articulo_material_hasta", "Coldesde" as "F_color_desde", "Porcent" as "Porcentaje", "Conforma1" as "Conformacion1", "Colhasta" as "F_color_hasta", "Montof" as "Montofijo", "Conforma2" as "Conformacion2", "Taldesde" as "F_talle_desde", "Talhasta" as "F_talle_hasta", "Provdesde" as "F_articulo_proveedor_desde", "Provhasta" as "F_articulo_proveedor_hasta", "Mobs" as "Observacion" from ZooLogic.COMISION where  funciones.padr( CODIGO, 10, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  COMISION.CODIGO != '' order by CODIGO
			endtext
			use in select('c_COMISION')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMISION', set( 'Datasession' ) )
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
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Valtafw" as "Versionaltafw", "Hmodifw" as "Horamodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Horaexpo" as "Horaexpo", "Vmodifw" as "Versionmodificacionfw", "Haltafw" as "Horaaltafw", "Zadsfw" as "Zadsfw", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Codigo" as "Codigo", "Fechah" as "Fechavigenciahasta", "Fechafd" as "Fechavigenciadesde", "Descrip" as "Descripcion", "Sucdesde" as "F_sucursal_codigo_desde", "Artdesde" as "F_articulo_desde", "Unidesde" as "F_articulo_unidad_desde", "Linsdesde" as "F_sucursal_linea_desde", "Tipsdesde" as "F_sucursal_tipo_desde", "Matdesde" as "F_articulo_material_desde", "Segsdesde" as "F_sucursal_segmentacion_desde", "Segshasta" as "F_sucursal_segmentacion_hasta", "Arthasta" as "F_articulo_hasta", "Unihasta" as "F_articulo_unidad_hasta", "Linshasta" as "F_sucursal_linea_hasta", "Tipshasta" as "F_sucursal_tipo_hasta", "Suchasta" as "F_sucursal_codigo_hasta", "Mathasta" as "F_articulo_material_hasta", "Coldesde" as "F_color_desde", "Porcent" as "Porcentaje", "Conforma1" as "Conformacion1", "Colhasta" as "F_color_hasta", "Montof" as "Montofijo", "Conforma2" as "Conformacion2", "Taldesde" as "F_talle_desde", "Talhasta" as "F_talle_hasta", "Provdesde" as "F_articulo_proveedor_desde", "Provhasta" as "F_articulo_proveedor_hasta", "Mobs" as "Observacion" from ZooLogic.COMISION where  funciones.padr( CODIGO, 10, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  COMISION.CODIGO != '' order by CODIGO desc
			endtext
			use in select('c_COMISION')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMISION', set( 'Datasession' ) )
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
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Valtafw" as "Versionaltafw", "Hmodifw" as "Horamodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Horaexpo" as "Horaexpo", "Vmodifw" as "Versionmodificacionfw", "Haltafw" as "Horaaltafw", "Zadsfw" as "Zadsfw", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Codigo" as "Codigo", "Fechah" as "Fechavigenciahasta", "Fechafd" as "Fechavigenciadesde", "Descrip" as "Descripcion", "Sucdesde" as "F_sucursal_codigo_desde", "Artdesde" as "F_articulo_desde", "Unidesde" as "F_articulo_unidad_desde", "Linsdesde" as "F_sucursal_linea_desde", "Tipsdesde" as "F_sucursal_tipo_desde", "Matdesde" as "F_articulo_material_desde", "Segsdesde" as "F_sucursal_segmentacion_desde", "Segshasta" as "F_sucursal_segmentacion_hasta", "Arthasta" as "F_articulo_hasta", "Unihasta" as "F_articulo_unidad_hasta", "Linshasta" as "F_sucursal_linea_hasta", "Tipshasta" as "F_sucursal_tipo_hasta", "Suchasta" as "F_sucursal_codigo_hasta", "Mathasta" as "F_articulo_material_hasta", "Coldesde" as "F_color_desde", "Porcent" as "Porcentaje", "Conforma1" as "Conformacion1", "Colhasta" as "F_color_hasta", "Montof" as "Montofijo", "Conforma2" as "Conformacion2", "Taldesde" as "F_talle_desde", "Talhasta" as "F_talle_hasta", "Provdesde" as "F_articulo_proveedor_desde", "Provhasta" as "F_articulo_proveedor_hasta", "Mobs" as "Observacion" from ZooLogic.COMISION where  COMISION.CODIGO != '' order by CODIGO desc
			endtext
			use in select('c_COMISION')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMISION', set( 'Datasession' ) )
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
			lcXml = this.oConexion.EjecutarSql( "select Fmodifw,Faltafw,Fecexpo,Fecimpo,Fectrans,Valtafw,Hmodifw,Bdaltafw,Bdmodifw,Esttrans,Umodifw," + ;
"Ualtafw,Saltafw,Horaexpo,Vmodifw,Haltafw,Zadsfw,Smodifw,Horaimpo,Codigo,Fechah,Fechafd,Descrip,Sucde" + ;
"sde,Artdesde,Unidesde,Linsdesde,Tipsdesde,Matdesde,Segsdesde,Segshasta,Arthasta,Unihasta,Linshasta,T" + ;
"ipshasta,Suchasta,Mathasta,Coldesde,Porcent,Conforma1,Colhasta,Montof,Conforma2,Taldesde,Talhasta,Pr" + ;
"ovdesde,Provhasta,Mobs" + ;
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
			local  lxComisionFmodifw, lxComisionFaltafw, lxComisionFecexpo, lxComisionFecimpo, lxComisionFectrans, lxComisionValtafw, lxComisionHmodifw, lxComisionBdaltafw, lxComisionBdmodifw, lxComisionEsttrans, lxComisionUmodifw, lxComisionUaltafw, lxComisionSaltafw, lxComisionHoraexpo, lxComisionVmodifw, lxComisionHaltafw, lxComisionZadsfw, lxComisionSmodifw, lxComisionHoraimpo, lxComisionCodigo, lxComisionFechah, lxComisionFechafd, lxComisionDescrip, lxComisionSucdesde, lxComisionArtdesde, lxComisionUnidesde, lxComisionLinsdesde, lxComisionTipsdesde, lxComisionMatdesde, lxComisionSegsdesde, lxComisionSegshasta, lxComisionArthasta, lxComisionUnihasta, lxComisionLinshasta, lxComisionTipshasta, lxComisionSuchasta, lxComisionMathasta, lxComisionColdesde, lxComisionPorcent, lxComisionConforma1, lxComisionColhasta, lxComisionMontof, lxComisionConforma2, lxComisionTaldesde, lxComisionTalhasta, lxComisionProvdesde, lxComisionProvhasta, lxComisionMobs
				lxComisionFmodifw = ctod( '  /  /    ' )			lxComisionFaltafw = ctod( '  /  /    ' )			lxComisionFecexpo = ctod( '  /  /    ' )			lxComisionFecimpo = ctod( '  /  /    ' )			lxComisionFectrans = ctod( '  /  /    ' )			lxComisionValtafw = []			lxComisionHmodifw = []			lxComisionBdaltafw = []			lxComisionBdmodifw = []			lxComisionEsttrans = []			lxComisionUmodifw = []			lxComisionUaltafw = []			lxComisionSaltafw = []			lxComisionHoraexpo = []			lxComisionVmodifw = []			lxComisionHaltafw = []			lxComisionZadsfw = []			lxComisionSmodifw = []			lxComisionHoraimpo = []			lxComisionCodigo = []			lxComisionFechah = ctod( '  /  /    ' )			lxComisionFechafd = ctod( '  /  /    ' )			lxComisionDescrip = []			lxComisionSucdesde = []			lxComisionArtdesde = []			lxComisionUnidesde = []			lxComisionLinsdesde = []			lxComisionTipsdesde = []			lxComisionMatdesde = []			lxComisionSegsdesde = []			lxComisionSegshasta = []			lxComisionArthasta = []			lxComisionUnihasta = []			lxComisionLinshasta = []			lxComisionTipshasta = []			lxComisionSuchasta = []			lxComisionMathasta = []			lxComisionColdesde = []			lxComisionPorcent = 0			lxComisionConforma1 = []			lxComisionColhasta = []			lxComisionMontof = 0			lxComisionConforma2 = []			lxComisionTaldesde = []			lxComisionTalhasta = []			lxComisionProvdesde = []			lxComisionProvhasta = []			lxComisionMobs = []
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
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
					"Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Valtafw" as "Versionaltafw", "Hmodifw" as "Horamodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Horaexpo" as "Horaexpo", "Vmodifw" as "Versionmodificacionfw", "Haltafw" as "Horaaltafw", "Zadsfw" as "Zadsfw", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Codigo" as "Codigo", "Fechah" as "Fechavigenciahasta", "Fechafd" as "Fechavigenciadesde", "Descrip" as "Descripcion", "Sucdesde" as "F_sucursal_codigo_desde", "Artdesde" as "F_articulo_desde", "Unidesde" as "F_articulo_unidad_desde", "Linsdesde" as "F_sucursal_linea_desde", "Tipsdesde" as "F_sucursal_tipo_desde", "Matdesde" as "F_articulo_material_desde", "Segsdesde" as "F_sucursal_segmentacion_desde", "Segshasta" as "F_sucursal_segmentacion_hasta", "Arthasta" as "F_articulo_hasta", "Unihasta" as "F_articulo_unidad_hasta", "Linshasta" as "F_sucursal_linea_hasta", "Tipshasta" as "F_sucursal_tipo_hasta", "Suchasta" as "F_sucursal_codigo_hasta", "Mathasta" as "F_articulo_material_hasta", "Coldesde" as "F_color_desde", "Porcent" as "Porcentaje", "Conforma1" as "Conformacion1", "Colhasta" as "F_color_hasta", "Montof" as "Montofijo", "Conforma2" as "Conformacion2", "Taldesde" as "F_talle_desde", "Talhasta" as "F_talle_hasta", "Provdesde" as "F_articulo_proveedor_desde", "Provhasta" as "F_articulo_proveedor_hasta", "Mobs" as "Observacion"
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
	Function ObtenerCamposSelectEntidad( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'FECHAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECEXPO AS FECHAEXPO'
				Case lcAtributo == 'FECHAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECIMPO AS FECHAIMPO'
				Case lcAtributo == 'FECHATRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRANS AS FECHATRANSFERENCIA'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'FECHAVIGENCIAHASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHAH AS FECHAVIGENCIAHASTA'
				Case lcAtributo == 'FECHAVIGENCIADESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHAFD AS FECHAVIGENCIADESDE'
				Case lcAtributo == 'DESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCRIP AS DESCRIPCION'
				Case lcAtributo == 'F_SUCURSAL_CODIGO_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SUCDESDE AS F_SUCURSAL_CODIGO_DESDE'
				Case lcAtributo == 'F_ARTICULO_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ARTDESDE AS F_ARTICULO_DESDE'
				Case lcAtributo == 'F_ARTICULO_UNIDAD_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UNIDESDE AS F_ARTICULO_UNIDAD_DESDE'
				Case lcAtributo == 'F_SUCURSAL_LINEA_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LINSDESDE AS F_SUCURSAL_LINEA_DESDE'
				Case lcAtributo == 'F_SUCURSAL_TIPO_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPSDESDE AS F_SUCURSAL_TIPO_DESDE'
				Case lcAtributo == 'F_ARTICULO_MATERIAL_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MATDESDE AS F_ARTICULO_MATERIAL_DESDE'
				Case lcAtributo == 'F_SUCURSAL_SEGMENTACION_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SEGSDESDE AS F_SUCURSAL_SEGMENTACION_DESDE'
				Case lcAtributo == 'F_SUCURSAL_SEGMENTACION_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SEGSHASTA AS F_SUCURSAL_SEGMENTACION_HASTA'
				Case lcAtributo == 'F_ARTICULO_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ARTHASTA AS F_ARTICULO_HASTA'
				Case lcAtributo == 'F_ARTICULO_UNIDAD_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UNIHASTA AS F_ARTICULO_UNIDAD_HASTA'
				Case lcAtributo == 'F_SUCURSAL_LINEA_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LINSHASTA AS F_SUCURSAL_LINEA_HASTA'
				Case lcAtributo == 'F_SUCURSAL_TIPO_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPSHASTA AS F_SUCURSAL_TIPO_HASTA'
				Case lcAtributo == 'F_SUCURSAL_CODIGO_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SUCHASTA AS F_SUCURSAL_CODIGO_HASTA'
				Case lcAtributo == 'F_ARTICULO_MATERIAL_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MATHASTA AS F_ARTICULO_MATERIAL_HASTA'
				Case lcAtributo == 'F_COLOR_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COLDESDE AS F_COLOR_DESDE'
				Case lcAtributo == 'PORCENTAJE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PORCENT AS PORCENTAJE'
				Case lcAtributo == 'CONFORMACION1'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CONFORMA1 AS CONFORMACION1'
				Case lcAtributo == 'F_COLOR_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COLHASTA AS F_COLOR_HASTA'
				Case lcAtributo == 'MONTOFIJO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONTOF AS MONTOFIJO'
				Case lcAtributo == 'CONFORMACION2'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CONFORMA2 AS CONFORMACION2'
				Case lcAtributo == 'F_TALLE_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TALDESDE AS F_TALLE_DESDE'
				Case lcAtributo == 'F_TALLE_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TALHASTA AS F_TALLE_HASTA'
				Case lcAtributo == 'F_ARTICULO_PROVEEDOR_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PROVDESDE AS F_ARTICULO_PROVEEDOR_DESDE'
				Case lcAtributo == 'F_ARTICULO_PROVEEDOR_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PROVHASTA AS F_ARTICULO_PROVEEDOR_HASTA'
				Case lcAtributo == 'OBSERVACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MOBS AS OBSERVACION'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEXPO'
				lcCampo = 'FECEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAIMPO'
				lcCampo = 'FECIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAVIGENCIAHASTA'
				lcCampo = 'FECHAH'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAVIGENCIADESDE'
				lcCampo = 'FECHAFD'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCION'
				lcCampo = 'DESCRIP'
			Case upper( alltrim( tcAtributo ) ) == 'F_SUCURSAL_CODIGO_DESDE'
				lcCampo = 'SUCDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'F_ARTICULO_DESDE'
				lcCampo = 'ARTDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'F_ARTICULO_UNIDAD_DESDE'
				lcCampo = 'UNIDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'F_SUCURSAL_LINEA_DESDE'
				lcCampo = 'LINSDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'F_SUCURSAL_TIPO_DESDE'
				lcCampo = 'TIPSDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'F_ARTICULO_MATERIAL_DESDE'
				lcCampo = 'MATDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'F_SUCURSAL_SEGMENTACION_DESDE'
				lcCampo = 'SEGSDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'F_SUCURSAL_SEGMENTACION_HASTA'
				lcCampo = 'SEGSHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'F_ARTICULO_HASTA'
				lcCampo = 'ARTHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'F_ARTICULO_UNIDAD_HASTA'
				lcCampo = 'UNIHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'F_SUCURSAL_LINEA_HASTA'
				lcCampo = 'LINSHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'F_SUCURSAL_TIPO_HASTA'
				lcCampo = 'TIPSHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'F_SUCURSAL_CODIGO_HASTA'
				lcCampo = 'SUCHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'F_ARTICULO_MATERIAL_HASTA'
				lcCampo = 'MATHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'F_COLOR_DESDE'
				lcCampo = 'COLDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'PORCENTAJE'
				lcCampo = 'PORCENT'
			Case upper( alltrim( tcAtributo ) ) == 'CONFORMACION1'
				lcCampo = 'CONFORMA1'
			Case upper( alltrim( tcAtributo ) ) == 'F_COLOR_HASTA'
				lcCampo = 'COLHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOFIJO'
				lcCampo = 'MONTOF'
			Case upper( alltrim( tcAtributo ) ) == 'CONFORMACION2'
				lcCampo = 'CONFORMA2'
			Case upper( alltrim( tcAtributo ) ) == 'F_TALLE_DESDE'
				lcCampo = 'TALDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'F_TALLE_HASTA'
				lcCampo = 'TALHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'F_ARTICULO_PROVEEDOR_DESDE'
				lcCampo = 'PROVDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'F_ARTICULO_PROVEEDOR_HASTA'
				lcCampo = 'PROVHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'OBSERVACION'
				lcCampo = 'MOBS'
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
			local  lxComisionFmodifw, lxComisionFaltafw, lxComisionFecexpo, lxComisionFecimpo, lxComisionFectrans, lxComisionValtafw, lxComisionHmodifw, lxComisionBdaltafw, lxComisionBdmodifw, lxComisionEsttrans, lxComisionUmodifw, lxComisionUaltafw, lxComisionSaltafw, lxComisionHoraexpo, lxComisionVmodifw, lxComisionHaltafw, lxComisionZadsfw, lxComisionSmodifw, lxComisionHoraimpo, lxComisionCodigo, lxComisionFechah, lxComisionFechafd, lxComisionDescrip, lxComisionSucdesde, lxComisionArtdesde, lxComisionUnidesde, lxComisionLinsdesde, lxComisionTipsdesde, lxComisionMatdesde, lxComisionSegsdesde, lxComisionSegshasta, lxComisionArthasta, lxComisionUnihasta, lxComisionLinshasta, lxComisionTipshasta, lxComisionSuchasta, lxComisionMathasta, lxComisionColdesde, lxComisionPorcent, lxComisionConforma1, lxComisionColhasta, lxComisionMontof, lxComisionConforma2, lxComisionTaldesde, lxComisionTalhasta, lxComisionProvdesde, lxComisionProvhasta, lxComisionMobs
				lxComisionFmodifw =  .Fechamodificacionfw			lxComisionFaltafw =  .Fechaaltafw			lxComisionFecexpo =  .Fechaexpo			lxComisionFecimpo =  .Fechaimpo			lxComisionFectrans =  .Fechatransferencia			lxComisionValtafw =  .Versionaltafw			lxComisionHmodifw =  .Horamodificacionfw			lxComisionBdaltafw =  .Basededatosaltafw			lxComisionBdmodifw =  .Basededatosmodificacionfw			lxComisionEsttrans =  .Estadotransferencia			lxComisionUmodifw =  .Usuariomodificacionfw			lxComisionUaltafw =  .Usuarioaltafw			lxComisionSaltafw =  .Seriealtafw			lxComisionHoraexpo =  .Horaexpo			lxComisionVmodifw =  .Versionmodificacionfw			lxComisionHaltafw =  .Horaaltafw			lxComisionZadsfw =  .Zadsfw			lxComisionSmodifw =  .Seriemodificacionfw			lxComisionHoraimpo =  .Horaimpo			lxComisionCodigo =  .Codigo			lxComisionFechah =  .Fechavigenciahasta			lxComisionFechafd =  .Fechavigenciadesde			lxComisionDescrip =  .Descripcion			lxComisionSucdesde =  .F_sucursal_codigo_desde			lxComisionArtdesde =  .F_articulo_desde			lxComisionUnidesde =  .F_articulo_unidad_desde			lxComisionLinsdesde =  .F_sucursal_linea_desde			lxComisionTipsdesde =  .F_sucursal_tipo_desde			lxComisionMatdesde =  .F_articulo_material_desde			lxComisionSegsdesde =  .F_sucursal_segmentacion_desde			lxComisionSegshasta =  .F_sucursal_segmentacion_hasta			lxComisionArthasta =  .F_articulo_hasta			lxComisionUnihasta =  .F_articulo_unidad_hasta			lxComisionLinshasta =  .F_sucursal_linea_hasta			lxComisionTipshasta =  .F_sucursal_tipo_hasta			lxComisionSuchasta =  .F_sucursal_codigo_hasta			lxComisionMathasta =  .F_articulo_material_hasta			lxComisionColdesde =  .F_color_desde			lxComisionPorcent =  .Porcentaje			lxComisionConforma1 =  .Conformacion1			lxComisionColhasta =  .F_color_hasta			lxComisionMontof =  .Montofijo			lxComisionConforma2 =  .Conformacion2			lxComisionTaldesde =  .F_talle_desde			lxComisionTalhasta =  .F_talle_hasta			lxComisionProvdesde =  .F_articulo_proveedor_desde			lxComisionProvhasta =  .F_articulo_proveedor_hasta			lxComisionMobs =  .Observacion
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.COMISION ( "Fmodifw","Faltafw","Fecexpo","Fecimpo","Fectrans","Valtafw","Hmodifw","Bdaltafw","Bdmodifw","Esttrans","Umodifw","Ualtafw","Saltafw","Horaexpo","Vmodifw","Haltafw","Zadsfw","Smodifw","Horaimpo","Codigo","Fechah","Fechafd","Descrip","Sucdesde","Artdesde","Unidesde","Linsdesde","Tipsdesde","Matdesde","Segsdesde","Segshasta","Arthasta","Unihasta","Linshasta","Tipshasta","Suchasta","Mathasta","Coldesde","Porcent","Conforma1","Colhasta","Montof","Conforma2","Taldesde","Talhasta","Provdesde","Provhasta","Mobs" ) values ( <<"'" + this.ConvertirDateSql( lxComisionFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxComisionFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxComisionFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxComisionFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxComisionFectrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionCodigo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxComisionFechah ) + "'" >>, <<"'" + this.ConvertirDateSql( lxComisionFechafd ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionDescrip ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionSucdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionArtdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionUnidesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionLinsdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionTipsdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionMatdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionSegsdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionSegshasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionArthasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionUnihasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionLinshasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionTipshasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionSuchasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionMathasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionColdesde ) + "'" >>, <<lxComisionPorcent >>, <<"'" + this.FormatearTextoSql( lxComisionConforma1 ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionColhasta ) + "'" >>, <<lxComisionMontof >>, <<"'" + this.FormatearTextoSql( lxComisionConforma2 ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionTaldesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionTalhasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionProvdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionProvhasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComisionMobs ) + "'" >> )
		endtext
		loColeccion.cTabla = 'COMISION' 
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
			local  lxComisionFmodifw, lxComisionFaltafw, lxComisionFecexpo, lxComisionFecimpo, lxComisionFectrans, lxComisionValtafw, lxComisionHmodifw, lxComisionBdaltafw, lxComisionBdmodifw, lxComisionEsttrans, lxComisionUmodifw, lxComisionUaltafw, lxComisionSaltafw, lxComisionHoraexpo, lxComisionVmodifw, lxComisionHaltafw, lxComisionZadsfw, lxComisionSmodifw, lxComisionHoraimpo, lxComisionCodigo, lxComisionFechah, lxComisionFechafd, lxComisionDescrip, lxComisionSucdesde, lxComisionArtdesde, lxComisionUnidesde, lxComisionLinsdesde, lxComisionTipsdesde, lxComisionMatdesde, lxComisionSegsdesde, lxComisionSegshasta, lxComisionArthasta, lxComisionUnihasta, lxComisionLinshasta, lxComisionTipshasta, lxComisionSuchasta, lxComisionMathasta, lxComisionColdesde, lxComisionPorcent, lxComisionConforma1, lxComisionColhasta, lxComisionMontof, lxComisionConforma2, lxComisionTaldesde, lxComisionTalhasta, lxComisionProvdesde, lxComisionProvhasta, lxComisionMobs
				lxComisionFmodifw =  .Fechamodificacionfw			lxComisionFaltafw =  .Fechaaltafw			lxComisionFecexpo =  .Fechaexpo			lxComisionFecimpo =  .Fechaimpo			lxComisionFectrans =  .Fechatransferencia			lxComisionValtafw =  .Versionaltafw			lxComisionHmodifw =  .Horamodificacionfw			lxComisionBdaltafw =  .Basededatosaltafw			lxComisionBdmodifw =  .Basededatosmodificacionfw			lxComisionEsttrans =  .Estadotransferencia			lxComisionUmodifw =  .Usuariomodificacionfw			lxComisionUaltafw =  .Usuarioaltafw			lxComisionSaltafw =  .Seriealtafw			lxComisionHoraexpo =  .Horaexpo			lxComisionVmodifw =  .Versionmodificacionfw			lxComisionHaltafw =  .Horaaltafw			lxComisionZadsfw =  .Zadsfw			lxComisionSmodifw =  .Seriemodificacionfw			lxComisionHoraimpo =  .Horaimpo			lxComisionCodigo =  .Codigo			lxComisionFechah =  .Fechavigenciahasta			lxComisionFechafd =  .Fechavigenciadesde			lxComisionDescrip =  .Descripcion			lxComisionSucdesde =  .F_sucursal_codigo_desde			lxComisionArtdesde =  .F_articulo_desde			lxComisionUnidesde =  .F_articulo_unidad_desde			lxComisionLinsdesde =  .F_sucursal_linea_desde			lxComisionTipsdesde =  .F_sucursal_tipo_desde			lxComisionMatdesde =  .F_articulo_material_desde			lxComisionSegsdesde =  .F_sucursal_segmentacion_desde			lxComisionSegshasta =  .F_sucursal_segmentacion_hasta			lxComisionArthasta =  .F_articulo_hasta			lxComisionUnihasta =  .F_articulo_unidad_hasta			lxComisionLinshasta =  .F_sucursal_linea_hasta			lxComisionTipshasta =  .F_sucursal_tipo_hasta			lxComisionSuchasta =  .F_sucursal_codigo_hasta			lxComisionMathasta =  .F_articulo_material_hasta			lxComisionColdesde =  .F_color_desde			lxComisionPorcent =  .Porcentaje			lxComisionConforma1 =  .Conformacion1			lxComisionColhasta =  .F_color_hasta			lxComisionMontof =  .Montofijo			lxComisionConforma2 =  .Conformacion2			lxComisionTaldesde =  .F_talle_desde			lxComisionTalhasta =  .F_talle_hasta			lxComisionProvdesde =  .F_articulo_proveedor_desde			lxComisionProvhasta =  .F_articulo_proveedor_hasta			lxComisionMobs =  .Observacion
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  COMISION.CODIGO != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.COMISION set "Fmodifw" = <<"'" + this.ConvertirDateSql( lxComisionFmodifw ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxComisionFaltafw ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxComisionFecexpo ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxComisionFecimpo ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxComisionFectrans ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxComisionValtafw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxComisionHmodifw ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxComisionBdaltafw ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxComisionBdmodifw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxComisionEsttrans ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxComisionUmodifw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxComisionUaltafw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxComisionSaltafw ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxComisionHoraexpo ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxComisionVmodifw ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxComisionHaltafw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxComisionZadsfw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxComisionSmodifw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxComisionHoraimpo ) + "'">>, "Codigo" = <<"'" + this.FormatearTextoSql( lxComisionCodigo ) + "'">>, "Fechah" = <<"'" + this.ConvertirDateSql( lxComisionFechah ) + "'">>, "Fechafd" = <<"'" + this.ConvertirDateSql( lxComisionFechafd ) + "'">>, "Descrip" = <<"'" + this.FormatearTextoSql( lxComisionDescrip ) + "'">>, "Sucdesde" = <<"'" + this.FormatearTextoSql( lxComisionSucdesde ) + "'">>, "Artdesde" = <<"'" + this.FormatearTextoSql( lxComisionArtdesde ) + "'">>, "Unidesde" = <<"'" + this.FormatearTextoSql( lxComisionUnidesde ) + "'">>, "Linsdesde" = <<"'" + this.FormatearTextoSql( lxComisionLinsdesde ) + "'">>, "Tipsdesde" = <<"'" + this.FormatearTextoSql( lxComisionTipsdesde ) + "'">>, "Matdesde" = <<"'" + this.FormatearTextoSql( lxComisionMatdesde ) + "'">>, "Segsdesde" = <<"'" + this.FormatearTextoSql( lxComisionSegsdesde ) + "'">>, "Segshasta" = <<"'" + this.FormatearTextoSql( lxComisionSegshasta ) + "'">>, "Arthasta" = <<"'" + this.FormatearTextoSql( lxComisionArthasta ) + "'">>, "Unihasta" = <<"'" + this.FormatearTextoSql( lxComisionUnihasta ) + "'">>, "Linshasta" = <<"'" + this.FormatearTextoSql( lxComisionLinshasta ) + "'">>, "Tipshasta" = <<"'" + this.FormatearTextoSql( lxComisionTipshasta ) + "'">>, "Suchasta" = <<"'" + this.FormatearTextoSql( lxComisionSuchasta ) + "'">>, "Mathasta" = <<"'" + this.FormatearTextoSql( lxComisionMathasta ) + "'">>, "Coldesde" = <<"'" + this.FormatearTextoSql( lxComisionColdesde ) + "'">>, "Porcent" = <<lxComisionPorcent>>, "Conforma1" = <<"'" + this.FormatearTextoSql( lxComisionConforma1 ) + "'">>, "Colhasta" = <<"'" + this.FormatearTextoSql( lxComisionColhasta ) + "'">>, "Montof" = <<lxComisionMontof>>, "Conforma2" = <<"'" + this.FormatearTextoSql( lxComisionConforma2 ) + "'">>, "Taldesde" = <<"'" + this.FormatearTextoSql( lxComisionTaldesde ) + "'">>, "Talhasta" = <<"'" + this.FormatearTextoSql( lxComisionTalhasta ) + "'">>, "Provdesde" = <<"'" + this.FormatearTextoSql( lxComisionProvdesde ) + "'">>, "Provhasta" = <<"'" + this.FormatearTextoSql( lxComisionProvhasta ) + "'">>, "Mobs" = <<"'" + this.FormatearTextoSql( lxComisionMobs ) + "'">> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'COMISION' 
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

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  COMISION.CODIGO != '']
		loColeccion.Agregar( 'delete from ZooLogic.COMISION where ' + lcFiltro )
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
					this.oConexion.EjecutarSql( [UPDATE ZooLogic.COMISION set  FModiFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FModiFW ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, HModiFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HModiFW ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, CODIGO = ] + "'" + this.FormatearTextoSql( &lcCursor..CODIGO ) + "'"+ [, FECHAH = ] + "'" + this.ConvertirDateSql( &lcCursor..FECHAH ) + "'"+ [, FECHAFD = ] + "'" + this.ConvertirDateSql( &lcCursor..FECHAFD ) + "'"+ [, Descrip = ] + "'" + this.FormatearTextoSql( &lcCursor..Descrip ) + "'"+ [, SucDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..SucDesde ) + "'"+ [, ArtDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..ArtDesde ) + "'"+ [, UniDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..UniDesde ) + "'"+ [, LinSDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..LinSDesde ) + "'"+ [, TipSDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..TipSDesde ) + "'"+ [, MatDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..MatDesde ) + "'"+ [, SegSDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..SegSDesde ) + "'"+ [, SegSHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..SegSHasta ) + "'"+ [, ArtHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..ArtHasta ) + "'"+ [, UniHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..UniHasta ) + "'"+ [, LinSHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..LinSHasta ) + "'"+ [, TipSHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..TipSHasta ) + "'"+ [, SucHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..SucHasta ) + "'"+ [, MatHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..MatHasta ) + "'"+ [, ColDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..ColDesde ) + "'"+ [, Porcent = ] + transform( &lcCursor..Porcent )+ [, Conforma1 = ] + "'" + this.FormatearTextoSql( &lcCursor..Conforma1 ) + "'"+ [, ColHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..ColHasta ) + "'"+ [, MontoF = ] + transform( &lcCursor..MontoF )+ [, Conforma2 = ] + "'" + this.FormatearTextoSql( &lcCursor..Conforma2 ) + "'"+ [, TalDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..TalDesde ) + "'"+ [, TalHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..TalHasta ) + "'"+ [, ProvDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..ProvDesde ) + "'"+ [, ProvHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..ProvHasta ) + "'"+ [, MObs = ] + "'" + this.FormatearTextoSql( &lcCursor..MObs ) + "'" + [ Where CODIGO = ] + "'" + this.FormatearTextoSql( &lcCursor..CODIGO ) + "'" )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
				endIf
			else
				Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
				Text to lcCampos noShow
					 FModiFW, FALTAFW, FECEXPO, FECIMPO, FECTRANS, VALTAFW, HModiFW, BDALTAFW, BDMODIFW, ESTTRANS, UMODIFW, UALTAFW, SALTAFW, HORAEXPO, VMODIFW, HALTAFW, ZADSFW, SMODIFW, HORAIMPO, CODIGO, FECHAH, FECHAFD, Descrip, SucDesde, ArtDesde, UniDesde, LinSDesde, TipSDesde, MatDesde, SegSDesde, SegSHasta, ArtHasta, UniHasta, LinSHasta, TipSHasta, SucHasta, MatHasta, ColDesde, Porcent, Conforma1, ColHasta, MontoF, Conforma2, TalDesde, TalHasta, ProvDesde, ProvHasta, MObs
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FModiFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HModiFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CODIGO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECHAH ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECHAFD ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Descrip ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SucDesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ArtDesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UniDesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..LinSDesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..TipSDesde ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..MatDesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SegSDesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SegSHasta ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ArtHasta ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UniHasta ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..LinSHasta ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..TipSHasta ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..SucHasta ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..MatHasta ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ColDesde ) + "'" + ',' + transform( &lcCursor..Porcent ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..Conforma1 ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ColHasta ) + "'" + ',' + transform( &lcCursor..MontoF )
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..Conforma2 ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..TalDesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..TalHasta ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ProvDesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ProvHasta ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..MObs ) + "'"
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
	endif
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
		* Validar ANTERIORES A 1/1/1753  FModiFW   
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FECHAH    
		* Validar ANTERIORES A 1/1/1753  FECHAFD   
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_COMISION') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_COMISION
Create Table ZooLogic.TablaTrabajo_COMISION ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fmodifw" datetime  null, 
"faltafw" datetime  null, 
"fecexpo" datetime  null, 
"fecimpo" datetime  null, 
"fectrans" datetime  null, 
"valtafw" char( 13 )  null, 
"hmodifw" char( 8 )  null, 
"bdaltafw" char( 8 )  null, 
"bdmodifw" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"umodifw" char( 100 )  null, 
"ualtafw" char( 100 )  null, 
"saltafw" char( 7 )  null, 
"horaexpo" char( 8 )  null, 
"vmodifw" char( 13 )  null, 
"haltafw" char( 8 )  null, 
"zadsfw" varchar(max)  null, 
"smodifw" char( 7 )  null, 
"horaimpo" char( 8 )  null, 
"codigo" char( 10 )  null, 
"fechah" datetime  null, 
"fechafd" datetime  null, 
"descrip" char( 40 )  null, 
"sucdesde" char( 10 )  null, 
"artdesde" char( 15 )  null, 
"unidesde" char( 3 )  null, 
"linsdesde" char( 10 )  null, 
"tipsdesde" char( 10 )  null, 
"matdesde" char( 10 )  null, 
"segsdesde" char( 10 )  null, 
"segshasta" char( 10 )  null, 
"arthasta" char( 15 )  null, 
"unihasta" char( 3 )  null, 
"linshasta" char( 10 )  null, 
"tipshasta" char( 10 )  null, 
"suchasta" char( 10 )  null, 
"mathasta" char( 10 )  null, 
"coldesde" char( 6 )  null, 
"porcent" numeric( 7, 2 )  null, 
"conforma1" char( 200 )  null, 
"colhasta" char( 6 )  null, 
"montof" numeric( 15, 2 )  null, 
"conforma2" char( 200 )  null, 
"taldesde" char( 5 )  null, 
"talhasta" char( 5 )  null, 
"provdesde" char( 10 )  null, 
"provhasta" char( 10 )  null, 
"mobs" varchar(max)  null )
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
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('codigo','codigo')
			.AgregarMapeo('fechah','fechah')
			.AgregarMapeo('fechafd','fechafd')
			.AgregarMapeo('descrip','descrip')
			.AgregarMapeo('sucdesde','sucdesde')
			.AgregarMapeo('artdesde','artdesde')
			.AgregarMapeo('unidesde','unidesde')
			.AgregarMapeo('linsdesde','linsdesde')
			.AgregarMapeo('tipsdesde','tipsdesde')
			.AgregarMapeo('matdesde','matdesde')
			.AgregarMapeo('segsdesde','segsdesde')
			.AgregarMapeo('segshasta','segshasta')
			.AgregarMapeo('arthasta','arthasta')
			.AgregarMapeo('unihasta','unihasta')
			.AgregarMapeo('linshasta','linshasta')
			.AgregarMapeo('tipshasta','tipshasta')
			.AgregarMapeo('suchasta','suchasta')
			.AgregarMapeo('mathasta','mathasta')
			.AgregarMapeo('coldesde','coldesde')
			.AgregarMapeo('porcent','porcent')
			.AgregarMapeo('conforma1','conforma1')
			.AgregarMapeo('colhasta','colhasta')
			.AgregarMapeo('montof','montof')
			.AgregarMapeo('conforma2','conforma2')
			.AgregarMapeo('taldesde','taldesde')
			.AgregarMapeo('talhasta','talhasta')
			.AgregarMapeo('provdesde','provdesde')
			.AgregarMapeo('provhasta','provhasta')
			.AgregarMapeo('mobs','mobs')
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
				Update t Set t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.CODIGO = isnull( d.CODIGO, t.CODIGO ),t.FECHAH = isnull( d.FECHAH, t.FECHAH ),t.FECHAFD = isnull( d.FECHAFD, t.FECHAFD ),t.DESCRIP = isnull( d.DESCRIP, t.DESCRIP ),t.SUCDESDE = isnull( d.SUCDESDE, t.SUCDESDE ),t.ARTDESDE = isnull( d.ARTDESDE, t.ARTDESDE ),t.UNIDESDE = isnull( d.UNIDESDE, t.UNIDESDE ),t.LINSDESDE = isnull( d.LINSDESDE, t.LINSDESDE ),t.TIPSDESDE = isnull( d.TIPSDESDE, t.TIPSDESDE ),t.MATDESDE = isnull( d.MATDESDE, t.MATDESDE ),t.SEGSDESDE = isnull( d.SEGSDESDE, t.SEGSDESDE ),t.SEGSHASTA = isnull( d.SEGSHASTA, t.SEGSHASTA ),t.ARTHASTA = isnull( d.ARTHASTA, t.ARTHASTA ),t.UNIHASTA = isnull( d.UNIHASTA, t.UNIHASTA ),t.LINSHASTA = isnull( d.LINSHASTA, t.LINSHASTA ),t.TIPSHASTA = isnull( d.TIPSHASTA, t.TIPSHASTA ),t.SUCHASTA = isnull( d.SUCHASTA, t.SUCHASTA ),t.MATHASTA = isnull( d.MATHASTA, t.MATHASTA ),t.COLDESDE = isnull( d.COLDESDE, t.COLDESDE ),t.PORCENT = isnull( d.PORCENT, t.PORCENT ),t.CONFORMA1 = isnull( d.CONFORMA1, t.CONFORMA1 ),t.COLHASTA = isnull( d.COLHASTA, t.COLHASTA ),t.MONTOF = isnull( d.MONTOF, t.MONTOF ),t.CONFORMA2 = isnull( d.CONFORMA2, t.CONFORMA2 ),t.TALDESDE = isnull( d.TALDESDE, t.TALDESDE ),t.TALHASTA = isnull( d.TALHASTA, t.TALHASTA ),t.PROVDESDE = isnull( d.PROVDESDE, t.PROVDESDE ),t.PROVHASTA = isnull( d.PROVHASTA, t.PROVHASTA ),t.MOBS = isnull( d.MOBS, t.MOBS )
					from ZooLogic.COMISION t inner join deleted d 
							 on t.CODIGO = d.CODIGO
				-- Fin Updates
				insert into ZooLogic.COMISION(Fmodifw,Faltafw,Fecexpo,Fecimpo,Fectrans,Valtafw,Hmodifw,Bdaltafw,Bdmodifw,Esttrans,Umodifw,Ualtafw,Saltafw,Horaexpo,Vmodifw,Haltafw,Zadsfw,Smodifw,Horaimpo,Codigo,Fechah,Fechafd,Descrip,Sucdesde,Artdesde,Unidesde,Linsdesde,Tipsdesde,Matdesde,Segsdesde,Segshasta,Arthasta,Unihasta,Linshasta,Tipshasta,Suchasta,Mathasta,Coldesde,Porcent,Conforma1,Colhasta,Montof,Conforma2,Taldesde,Talhasta,Provdesde,Provhasta,Mobs)
					Select isnull( d.FMODIFW,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FECEXPO,''),isnull( d.FECIMPO,''),isnull( d.FECTRANS,''),isnull( d.VALTAFW,''),isnull( d.HMODIFW,''),isnull( d.BDALTAFW,''),isnull( d.BDMODIFW,''),isnull( d.ESTTRANS,''),isnull( d.UMODIFW,''),isnull( d.UALTAFW,''),isnull( d.SALTAFW,''),isnull( d.HORAEXPO,''),isnull( d.VMODIFW,''),convert( char(8), getdate(), 108 ),isnull( d.ZADSFW,''),isnull( d.SMODIFW,''),isnull( d.HORAIMPO,''),isnull( d.CODIGO,''),isnull( d.FECHAH,''),isnull( d.FECHAFD,''),isnull( d.DESCRIP,''),isnull( d.SUCDESDE,''),isnull( d.ARTDESDE,''),isnull( d.UNIDESDE,''),isnull( d.LINSDESDE,''),isnull( d.TIPSDESDE,''),isnull( d.MATDESDE,''),isnull( d.SEGSDESDE,''),isnull( d.SEGSHASTA,''),isnull( d.ARTHASTA,''),isnull( d.UNIHASTA,''),isnull( d.LINSHASTA,''),isnull( d.TIPSHASTA,''),isnull( d.SUCHASTA,''),isnull( d.MATHASTA,''),isnull( d.COLDESDE,''),isnull( d.PORCENT,0),isnull( d.CONFORMA1,''),isnull( d.COLHASTA,''),isnull( d.MONTOF,0),isnull( d.CONFORMA2,''),isnull( d.TALDESDE,''),isnull( d.TALHASTA,''),isnull( d.PROVDESDE,''),isnull( d.PROVHASTA,''),isnull( d.MOBS,'')
						From deleted d left join ZooLogic.COMISION pk 
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
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_COMISION.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_COMISION.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_COMISION.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_COMISION.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_COMISION.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Versionaltafw = nvl( c_COMISION.Versionaltafw, [] )
					.Horamodificacionfw = nvl( c_COMISION.Horamodificacionfw, [] )
					.Basededatosaltafw = nvl( c_COMISION.Basededatosaltafw, [] )
					.Basededatosmodificacionfw = nvl( c_COMISION.Basededatosmodificacionfw, [] )
					.Estadotransferencia = nvl( c_COMISION.Estadotransferencia, [] )
					.Usuariomodificacionfw = nvl( c_COMISION.Usuariomodificacionfw, [] )
					.Usuarioaltafw = nvl( c_COMISION.Usuarioaltafw, [] )
					.Seriealtafw = nvl( c_COMISION.Seriealtafw, [] )
					.Horaexpo = nvl( c_COMISION.Horaexpo, [] )
					.Versionmodificacionfw = nvl( c_COMISION.Versionmodificacionfw, [] )
					.Horaaltafw = nvl( c_COMISION.Horaaltafw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Seriemodificacionfw = nvl( c_COMISION.Seriemodificacionfw, [] )
					.Horaimpo = nvl( c_COMISION.Horaimpo, [] )
					.Codigo = nvl( c_COMISION.Codigo, [] )
					.Fechavigenciahasta = GoLibrerias.ObtenerFechaFormateada( nvl( c_COMISION.Fechavigenciahasta, ctod( '  /  /    ' ) ) )
					.Fechavigenciadesde = GoLibrerias.ObtenerFechaFormateada( nvl( c_COMISION.Fechavigenciadesde, ctod( '  /  /    ' ) ) )
					.Descripcion = nvl( c_COMISION.Descripcion, [] )
					.F_sucursal_codigo_desde = nvl( c_COMISION.F_sucursal_codigo_desde, [] )
					.F_articulo_desde = nvl( c_COMISION.F_articulo_desde, [] )
					.F_articulo_unidad_desde = nvl( c_COMISION.F_articulo_unidad_desde, [] )
					.F_sucursal_linea_desde = nvl( c_COMISION.F_sucursal_linea_desde, [] )
					.F_sucursal_tipo_desde = nvl( c_COMISION.F_sucursal_tipo_desde, [] )
					.F_articulo_material_desde = nvl( c_COMISION.F_articulo_material_desde, [] )
					.F_sucursal_segmentacion_desde = nvl( c_COMISION.F_sucursal_segmentacion_desde, [] )
					.F_sucursal_segmentacion_hasta = nvl( c_COMISION.F_sucursal_segmentacion_hasta, [] )
					.F_articulo_hasta = nvl( c_COMISION.F_articulo_hasta, [] )
					.F_articulo_unidad_hasta = nvl( c_COMISION.F_articulo_unidad_hasta, [] )
					.F_sucursal_linea_hasta = nvl( c_COMISION.F_sucursal_linea_hasta, [] )
					.F_sucursal_tipo_hasta = nvl( c_COMISION.F_sucursal_tipo_hasta, [] )
					.F_sucursal_codigo_hasta = nvl( c_COMISION.F_sucursal_codigo_hasta, [] )
					.F_articulo_material_hasta = nvl( c_COMISION.F_articulo_material_hasta, [] )
					.F_color_desde = nvl( c_COMISION.F_color_desde, [] )
					.Porcentaje = nvl( c_COMISION.Porcentaje, 0 )
					.Conformacion1 = nvl( c_COMISION.Conformacion1, [] )
					.F_color_hasta = nvl( c_COMISION.F_color_hasta, [] )
					.Montofijo = nvl( c_COMISION.Montofijo, 0 )
					.Conformacion2 = nvl( c_COMISION.Conformacion2, [] )
					.F_talle_desde = nvl( c_COMISION.F_talle_desde, [] )
					.F_talle_hasta = nvl( c_COMISION.F_talle_hasta, [] )
					.F_articulo_proveedor_desde = nvl( c_COMISION.F_articulo_proveedor_desde, [] )
					.F_articulo_proveedor_hasta = nvl( c_COMISION.F_articulo_proveedor_hasta, [] )
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
			"Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Valtafw" as "Versionaltafw", "Hmodifw" as "Horamodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Horaexpo" as "Horaexpo", "Vmodifw" as "Versionmodificacionfw", "Haltafw" as "Horaaltafw", "Zadsfw" as "Zadsfw", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Codigo" as "Codigo", "Fechah" as "Fechavigenciahasta", "Fechafd" as "Fechavigenciadesde", "Descrip" as "Descripcion", "Sucdesde" as "F_sucursal_codigo_desde", "Artdesde" as "F_articulo_desde", "Unidesde" as "F_articulo_unidad_desde", "Linsdesde" as "F_sucursal_linea_desde", "Tipsdesde" as "F_sucursal_tipo_desde", "Matdesde" as "F_articulo_material_desde", "Segsdesde" as "F_sucursal_segmentacion_desde", "Segshasta" as "F_sucursal_segmentacion_hasta", "Arthasta" as "F_articulo_hasta", "Unihasta" as "F_articulo_unidad_hasta", "Linshasta" as "F_sucursal_linea_hasta", "Tipshasta" as "F_sucursal_tipo_hasta", "Suchasta" as "F_sucursal_codigo_hasta", "Mathasta" as "F_articulo_material_hasta", "Coldesde" as "F_color_desde", "Porcent" as "Porcentaje", "Conforma1" as "Conformacion1", "Colhasta" as "F_color_hasta", "Montof" as "Montofijo", "Conforma2" as "Conformacion2", "Taldesde" as "F_talle_desde", "Talhasta" as "F_talle_hasta", "Provdesde" as "F_articulo_proveedor_desde", "Provhasta" as "F_articulo_proveedor_hasta", "Mobs" as "Observacion"
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
	<row entidad="COMISION                                " atributo="FECHAMODIFICACIONFW                     " tabla="COMISION       " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="7" etiqueta="Fecha                                                                                                                                                           " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="4" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMISION                                " atributo="FECHAALTAFW                             " tabla="COMISION       " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMISION                                " atributo="FECHAEXPO                               " tabla="COMISION       " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMISION                                " atributo="FECHAIMPO                               " tabla="COMISION       " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMISION                                " atributo="FECHATRANSFERENCIA                      " tabla="COMISION       " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha transferencia                                                                                                                                             " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMISION                                " atributo="VERSIONALTAFW                           " tabla="COMISION       " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMISION                                " atributo="HORAMODIFICACIONFW                      " tabla="COMISION       " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="8" etiqueta="Hora                                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="4" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMISION                                " atributo="BASEDEDATOSALTAFW                       " tabla="COMISION       " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMISION                                " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="COMISION       " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMISION                                " atributo="ESTADOTRANSFERENCIA                     " tabla="COMISION       " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado transferencia                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMISION                                " atributo="USUARIOMODIFICACIONFW                   " tabla="COMISION       " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMISION                                " atributo="USUARIOALTAFW                           " tabla="COMISION       " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMISION                                " atributo="SERIEALTAFW                             " tabla="COMISION       " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMISION                                " atributo="HORAEXPO                                " tabla="COMISION       " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMISION                                " atributo="VERSIONMODIFICACIONFW                   " tabla="COMISION       " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMISION                                " atributo="HORAALTAFW                              " tabla="COMISION       " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMISION                                " atributo="ZADSFW                                  " tabla="COMISION       " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMISION                                " atributo="SERIEMODIFICACIONFW                     " tabla="COMISION       " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMISION                                " atributo="HORAIMPO                                " tabla="COMISION       " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMISION                                " atributo="CODIGO                                  " tabla="COMISION       " campo="CODIGO    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="1" etiqueta="Código                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMISION                                " atributo="FECHAVIGENCIAHASTA                      " tabla="COMISION       " campo="FECHAH    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goServicios.librerias.ObtenerFecha()+90                                                                                                                                                                                                                      " obligatorio="true" admitebusqueda="200" etiqueta="Hasta                                                                                                                                                           " dominio="FECHACALENDARIO               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMISION                                " atributo="FECHAVIGENCIADESDE                      " tabla="COMISION       " campo="FECHAFD   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goServicios.librerias.ObtenerFecha()                                                                                                                                                                                                                         " obligatorio="true" admitebusqueda="201" etiqueta="Desde                                                                                                                                                           " dominio="FECHACALENDARIO               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMISION                                " atributo="DESCRIPCION                             " tabla="COMISION       " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="2" etiqueta="Descripción                                                                                                                                                     " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMISION                                " atributo="F_SUCURSAL_CODIGO_DESDE                 " tabla="COMISION       " campo="SUCDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="202" etiqueta="Sucursal                                                                                                                                                        " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMISION                                " atributo="F_ARTICULO_DESDE                        " tabla="COMISION       " campo="ARTDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="203" etiqueta="Artículo                                                                                                                                                        " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMISION                                " atributo="F_ARTICULO_UNIDAD_DESDE                 " tabla="COMISION       " campo="UNIDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="3" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="204" etiqueta="Unidad de medida                                                                                                                                                " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="5" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMISION                                " atributo="F_SUCURSAL_LINEA_DESDE                  " tabla="COMISION       " campo="LINSDESDE " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="205" etiqueta="Línea de sucursal                                                                                                                                               " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="3" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMISION                                " atributo="F_SUCURSAL_TIPO_DESDE                   " tabla="COMISION       " campo="TIPSDESDE " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="206" etiqueta="Tipo de sucursal                                                                                                                                                " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="2" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMISION                                " atributo="F_ARTICULO_MATERIAL_DESDE               " tabla="COMISION       " campo="MATDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="207" etiqueta="Material                                                                                                                                                        " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="6" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMISION                                " atributo="F_SUCURSAL_SEGMENTACION_DESDE           " tabla="COMISION       " campo="SEGSDESDE " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="208" etiqueta="Segmentación de sucursal                                                                                                                                        " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="4" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMISION                                " atributo="F_SUCURSAL_SEGMENTACION_HASTA           " tabla="COMISION       " campo="SEGSHASTA " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="=Replicate( &quot;Z&quot;,10)                                                                                                                                                                                                                                           " obligatorio="false" admitebusqueda="209" etiqueta="Segmentación de sucursal                                                                                                                                        " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="4" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMISION                                " atributo="F_ARTICULO_HASTA                        " tabla="COMISION       " campo="ARTHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="15" decimales="0" valorsugerido="=Replicate( &quot;Z&quot;,15)                                                                                                                                                                                                                                           " obligatorio="false" admitebusqueda="210" etiqueta="Artículo                                                                                                                                                        " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMISION                                " atributo="F_ARTICULO_UNIDAD_HASTA                 " tabla="COMISION       " campo="UNIHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="3" decimales="0" valorsugerido="=Replicate( &quot;Z&quot;,3)                                                                                                                                                                                                                                            " obligatorio="false" admitebusqueda="211" etiqueta="Unidad de medida                                                                                                                                                " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="5" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMISION                                " atributo="F_SUCURSAL_LINEA_HASTA                  " tabla="COMISION       " campo="LINSHASTA " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="=Replicate( &quot;Z&quot;,10)                                                                                                                                                                                                                                           " obligatorio="false" admitebusqueda="212" etiqueta="Línea de sucursal                                                                                                                                               " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="3" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMISION                                " atributo="F_SUCURSAL_TIPO_HASTA                   " tabla="COMISION       " campo="TIPSHASTA " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="=Replicate( &quot;Z&quot;,10)                                                                                                                                                                                                                                           " obligatorio="false" admitebusqueda="213" etiqueta="Tipo de sucursal                                                                                                                                                " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="2" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMISION                                " atributo="F_SUCURSAL_CODIGO_HASTA                 " tabla="COMISION       " campo="SUCHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="=Replicate( &quot;Z&quot;,10 )                                                                                                                                                                                                                                          " obligatorio="false" admitebusqueda="214" etiqueta="Sucursal                                                                                                                                                        " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="1" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMISION                                " atributo="F_ARTICULO_MATERIAL_HASTA               " tabla="COMISION       " campo="MATHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="=Replicate( &quot;Z&quot;,10)                                                                                                                                                                                                                                           " obligatorio="false" admitebusqueda="215" etiqueta="Material                                                                                                                                                        " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="6" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMISION                                " atributo="F_COLOR_DESDE                           " tabla="COMISION       " campo="COLDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="6" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="216" etiqueta="Color                                                                                                                                                           " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMISION                                " atributo="PORCENTAJE                              " tabla="COMISION       " campo="PORCENT   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="7" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="217" etiqueta="Porcentaje                                                                                                                                                      " dominio="NUMERICONONEGATIVO            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="5" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMISION                                " atributo="CONFORMACION1                           " tabla="COMISION       " campo="CONFORMA1 " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="200" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Conformación                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="4" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMISION                                " atributo="F_COLOR_HASTA                           " tabla="COMISION       " campo="COLHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="6" decimales="0" valorsugerido="=Replicate( &quot;Z&quot;,6 )                                                                                                                                                                                                                                           " obligatorio="false" admitebusqueda="218" etiqueta="Color                                                                                                                                                           " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMISION                                " atributo="MONTOFIJO                               " tabla="COMISION       " campo="MONTOF    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="219" etiqueta="Monto fijo                                                                                                                                                      " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="5" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMISION                                " atributo="CONFORMACION2                           " tabla="COMISION       " campo="CONFORMA2 " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="200" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Continuación                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="5" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMISION                                " atributo="F_TALLE_DESDE                           " tabla="COMISION       " campo="TALDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="220" etiqueta="Talle                                                                                                                                                           " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="3" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMISION                                " atributo="F_TALLE_HASTA                           " tabla="COMISION       " campo="TALHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="5" decimales="0" valorsugerido="=Replicate( &quot;Z&quot;,5 )                                                                                                                                                                                                                                           " obligatorio="false" admitebusqueda="221" etiqueta="Talle                                                                                                                                                           " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="3" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMISION                                " atributo="F_ARTICULO_PROVEEDOR_DESDE              " tabla="COMISION       " campo="PROVDESDE " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="222" etiqueta="Proveedor                                                                                                                                                       " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="4" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMISION                                " atributo="F_ARTICULO_PROVEEDOR_HASTA              " tabla="COMISION       " campo="PROVHASTA " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="=Replicate( &quot;Z&quot;,10)                                                                                                                                                                                                                                           " obligatorio="false" admitebusqueda="223" etiqueta="Proveedor                                                                                                                                                       " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="4" orden="8" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMISION                                " atributo="OBSERVACION                             " tabla="COMISION       " campo="MOBS      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="224" etiqueta="Observaciones                                                                                                                                                   " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="6" orden="20" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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