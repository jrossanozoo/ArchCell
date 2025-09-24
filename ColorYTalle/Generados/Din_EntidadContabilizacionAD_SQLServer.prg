
define class Din_EntidadCONTABILIZACIONAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_CONTABILIZACION'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = []
	cExpresionCCPorCampos = []
	cTagClaveCandidata = ''
	cTagClavePk = '_CATPK'
	cTablaPrincipal = 'CONTABIL'
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
		this.GrabarNumeraciones()

		with this.oEntidad
			local  lxContabilFecexpo, lxContabilFectrans, lxContabilFecimpo, lxContabilFaltafw, lxContabilFmodifw, lxContabilBdmodifw, lxContabilBdaltafw, lxContabilHoraexpo, lxContabilEsttrans, lxContabilHaltafw, lxContabilHoraimpo, lxContabilUmodifw, lxContabilVmodifw, lxContabilUaltafw, lxContabilZadsfw, lxContabilValtafw, lxContabilHmodifw, lxContabilSaltafw, lxContabilSmodifw, lxContabilEobs, lxContabilEjercicio, lxContabilNumero, lxContabilRangoasie, lxContabilF_vtasloc, lxContabilF_factman, lxContabilF_vtasexp, lxContabilF_ndman, lxContabilDescrip, lxContabilRsocial, lxContabilBasesproc, lxContabilFecha, lxContabilFechades, lxContabilF_recibos, lxContabilF_ncman, lxContabilFechahas, lxContabilF_compras, lxContabilF_factfis, lxContabilSucursal, lxContabilF_ndfis, lxContabilF_pagos, lxContabilBase, lxContabilF_otrospag, lxContabilF_ncfis, lxContabilF_caja, lxContabilF_factele, lxContabilF_ndele, lxContabilF_canjes, lxContabilF_ncele, lxContabilF_desccheq, lxContabilF_liqtarj, lxContabilF_transf, lxContabilF_ccclient, lxContabilF_ccproved, lxContabilF_concilia, lxContabilF_cmv, lxContabilF_compr_fc, lxContabilF_compr_nc, lxContabilF_compr_nd, lxContabilF_compr_o1, lxContabilF_compr_o2, lxContabilF_compr_o3, lxContabilF_compr_o4
				lxContabilFecexpo =  .Fechaexpo			lxContabilFectrans =  .Fechatransferencia			lxContabilFecimpo =  .Fechaimpo			lxContabilFaltafw =  .Fechaaltafw			lxContabilFmodifw =  .Fechamodificacionfw			lxContabilBdmodifw =  .Basededatosmodificacionfw			lxContabilBdaltafw =  .Basededatosaltafw			lxContabilHoraexpo =  .Horaexpo			lxContabilEsttrans =  .Estadotransferencia			lxContabilHaltafw =  .Horaaltafw			lxContabilHoraimpo =  .Horaimpo			lxContabilUmodifw =  .Usuariomodificacionfw			lxContabilVmodifw =  .Versionmodificacionfw			lxContabilUaltafw =  .Usuarioaltafw			lxContabilZadsfw =  .Zadsfw			lxContabilValtafw =  .Versionaltafw			lxContabilHmodifw =  .Horamodificacionfw			lxContabilSaltafw =  .Seriealtafw			lxContabilSmodifw =  .Seriemodificacionfw			lxContabilEobs =  .Observacion			lxContabilEjercicio =  .Ejercicio_PK 			lxContabilNumero =  .Numero			lxContabilRangoasie =  .Rangodeasientosgenerados			lxContabilF_vtasloc =  .Contabilizaventaslocales			lxContabilF_factman =  .Contabilizafacturamanual			lxContabilF_vtasexp =  .Contabilizaventasexportacion			lxContabilF_ndman =  .Contabilizanotadebitomanual			lxContabilDescrip =  .Descripcion			lxContabilRsocial =  upper( .RazonSocial_PK ) 			lxContabilBasesproc =  .Bdprocesadas			lxContabilFecha =  .Fecha			lxContabilFechades =  .Fechadesde			lxContabilF_recibos =  .Contabilizarecibos			lxContabilF_ncman =  .Contabilizanotacreditomanual			lxContabilFechahas =  .Fechahasta			lxContabilF_compras =  .Contabilizacompras			lxContabilF_factfis =  .Contabilizafacturafiscal			lxContabilSucursal =  upper( .Sucursal_PK ) 			lxContabilF_ndfis =  .Contabilizanotadebitofiscal			lxContabilF_pagos =  .Contabilizapagos			lxContabilBase =  .Basededatos			lxContabilF_otrospag =  .Contabilizaotrospagos			lxContabilF_ncfis =  .Contabilizanotacreditofiscal			lxContabilF_caja =  .Contabilizacaja			lxContabilF_factele =  .Contabilizafacturaelectronica			lxContabilF_ndele =  .Contabilizanotadebitoelectronica			lxContabilF_canjes =  .Contabilizacanjes			lxContabilF_ncele =  .Contabilizanotacreditoelectronica			lxContabilF_desccheq =  .Contabilizadescargas			lxContabilF_liqtarj =  .Contabilizaliqtarjetas			lxContabilF_transf =  .Contabilizatransferencias			lxContabilF_ccclient =  .Contabilizaajustecccliente			lxContabilF_ccproved =  .Contabilizaajusteccproveedor			lxContabilF_concilia =  .Contabilizachequesconciliados			lxContabilF_cmv =  .Contabilizacostomercaderiavendida			lxContabilF_compr_fc =  .Contabilizafacturadecompra			lxContabilF_compr_nc =  .Contabilizanotacreditodecompra			lxContabilF_compr_nd =  .Contabilizanotadebitodecompra			lxContabilF_compr_o1 =  .Contabilizadespachoimportaccompra			lxContabilF_compr_o2 =  .Contabilizaliquidacionescompra			lxContabilF_compr_o3 =  .Contabilizaliqservpublcompra			lxContabilF_compr_o4 =  .Contabilizareciboscompra
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxContabilNumero = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.CONTABIL ( "Fecexpo","Fectrans","Fecimpo","Faltafw","Fmodifw","Bdmodifw","Bdaltafw","Horaexpo","Esttrans","Haltafw","Horaimpo","Umodifw","Vmodifw","Ualtafw","Zadsfw","Valtafw","Hmodifw","Saltafw","Smodifw","Eobs","Ejercicio","Numero","Rangoasie","F_vtasloc","F_factman","F_vtasexp","F_ndman","Descrip","Rsocial","Basesproc","Fecha","Fechades","F_recibos","F_ncman","Fechahas","F_compras","F_factfis","Sucursal","F_ndfis","F_pagos","Base","F_otrospag","F_ncfis","F_caja","F_factele","F_ndele","F_canjes","F_ncele","F_desccheq","F_liqtarj","F_transf","F_ccclient","F_ccproved","F_concilia","F_cmv","F_compr_fc","F_compr_nc","F_compr_nd","F_compr_o1","F_compr_o2","F_compr_o3","F_compr_o4" ) values ( <<"'" + this.ConvertirDateSql( lxContabilFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxContabilFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxContabilFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxContabilFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxContabilFmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxContabilBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxContabilBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxContabilHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxContabilEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxContabilHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxContabilHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxContabilUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxContabilVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxContabilUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxContabilZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxContabilValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxContabilHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxContabilSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxContabilSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxContabilEobs ) + "'" >>, <<lxContabilEjercicio >>, <<lxContabilNumero >>, <<"'" + this.FormatearTextoSql( lxContabilRangoasie ) + "'" >>, <<iif( lxContabilF_vtasloc, 1, 0 ) >>, <<iif( lxContabilF_factman, 1, 0 ) >>, <<iif( lxContabilF_vtasexp, 1, 0 ) >>, <<iif( lxContabilF_ndman, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxContabilDescrip ) + "'" >>, <<"'" + this.FormatearTextoSql( lxContabilRsocial ) + "'" >>, <<"'" + this.FormatearTextoSql( lxContabilBasesproc ) + "'" >>, <<"'" + this.ConvertirDateSql( lxContabilFecha ) + "'" >>, <<"'" + this.ConvertirDateSql( lxContabilFechades ) + "'" >>, <<iif( lxContabilF_recibos, 1, 0 ) >>, <<iif( lxContabilF_ncman, 1, 0 ) >>, <<"'" + this.ConvertirDateSql( lxContabilFechahas ) + "'" >>, <<iif( lxContabilF_compras, 1, 0 ) >>, <<iif( lxContabilF_factfis, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxContabilSucursal ) + "'" >>, <<iif( lxContabilF_ndfis, 1, 0 ) >>, <<iif( lxContabilF_pagos, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxContabilBase ) + "'" >>, <<iif( lxContabilF_otrospag, 1, 0 ) >>, <<iif( lxContabilF_ncfis, 1, 0 ) >>, <<iif( lxContabilF_caja, 1, 0 ) >>, <<iif( lxContabilF_factele, 1, 0 ) >>, <<iif( lxContabilF_ndele, 1, 0 ) >>, <<iif( lxContabilF_canjes, 1, 0 ) >>, <<iif( lxContabilF_ncele, 1, 0 ) >>, <<iif( lxContabilF_desccheq, 1, 0 ) >>, <<iif( lxContabilF_liqtarj, 1, 0 ) >>, <<iif( lxContabilF_transf, 1, 0 ) >>, <<iif( lxContabilF_ccclient, 1, 0 ) >>, <<iif( lxContabilF_ccproved, 1, 0 ) >>, <<iif( lxContabilF_concilia, 1, 0 ) >>, <<iif( lxContabilF_cmv, 1, 0 ) >>, <<iif( lxContabilF_compr_fc, 1, 0 ) >>, <<iif( lxContabilF_compr_nc, 1, 0 ) >>, <<iif( lxContabilF_compr_nd, 1, 0 ) >>, <<iif( lxContabilF_compr_o1, 1, 0 ) >>, <<iif( lxContabilF_compr_o2, 1, 0 ) >>, <<iif( lxContabilF_compr_o3, 1, 0 ) >>, <<iif( lxContabilF_compr_o4, 1, 0 ) >> )
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
		this.ComprobarTransaccion()
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.NUMERO
			lcValorClavePrimariaString = lxValorClavePrimaria

			.GenerarSentenciasComponentes()
			.EjecutarSentencias( This.ColSentencias )
		this.ComprobarTransaccion()
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
			this.GenerarSentenciasComponentes()
			local  lxContabilFecexpo, lxContabilFectrans, lxContabilFecimpo, lxContabilFaltafw, lxContabilFmodifw, lxContabilBdmodifw, lxContabilBdaltafw, lxContabilHoraexpo, lxContabilEsttrans, lxContabilHaltafw, lxContabilHoraimpo, lxContabilUmodifw, lxContabilVmodifw, lxContabilUaltafw, lxContabilZadsfw, lxContabilValtafw, lxContabilHmodifw, lxContabilSaltafw, lxContabilSmodifw, lxContabilEobs, lxContabilEjercicio, lxContabilNumero, lxContabilRangoasie, lxContabilF_vtasloc, lxContabilF_factman, lxContabilF_vtasexp, lxContabilF_ndman, lxContabilDescrip, lxContabilRsocial, lxContabilBasesproc, lxContabilFecha, lxContabilFechades, lxContabilF_recibos, lxContabilF_ncman, lxContabilFechahas, lxContabilF_compras, lxContabilF_factfis, lxContabilSucursal, lxContabilF_ndfis, lxContabilF_pagos, lxContabilBase, lxContabilF_otrospag, lxContabilF_ncfis, lxContabilF_caja, lxContabilF_factele, lxContabilF_ndele, lxContabilF_canjes, lxContabilF_ncele, lxContabilF_desccheq, lxContabilF_liqtarj, lxContabilF_transf, lxContabilF_ccclient, lxContabilF_ccproved, lxContabilF_concilia, lxContabilF_cmv, lxContabilF_compr_fc, lxContabilF_compr_nc, lxContabilF_compr_nd, lxContabilF_compr_o1, lxContabilF_compr_o2, lxContabilF_compr_o3, lxContabilF_compr_o4
				lxContabilFecexpo =  .Fechaexpo			lxContabilFectrans =  .Fechatransferencia			lxContabilFecimpo =  .Fechaimpo			lxContabilFaltafw =  .Fechaaltafw			lxContabilFmodifw =  .Fechamodificacionfw			lxContabilBdmodifw =  .Basededatosmodificacionfw			lxContabilBdaltafw =  .Basededatosaltafw			lxContabilHoraexpo =  .Horaexpo			lxContabilEsttrans =  .Estadotransferencia			lxContabilHaltafw =  .Horaaltafw			lxContabilHoraimpo =  .Horaimpo			lxContabilUmodifw =  .Usuariomodificacionfw			lxContabilVmodifw =  .Versionmodificacionfw			lxContabilUaltafw =  .Usuarioaltafw			lxContabilZadsfw =  .Zadsfw			lxContabilValtafw =  .Versionaltafw			lxContabilHmodifw =  .Horamodificacionfw			lxContabilSaltafw =  .Seriealtafw			lxContabilSmodifw =  .Seriemodificacionfw			lxContabilEobs =  .Observacion			lxContabilEjercicio =  .Ejercicio_PK 			lxContabilNumero =  .Numero			lxContabilRangoasie =  .Rangodeasientosgenerados			lxContabilF_vtasloc =  .Contabilizaventaslocales			lxContabilF_factman =  .Contabilizafacturamanual			lxContabilF_vtasexp =  .Contabilizaventasexportacion			lxContabilF_ndman =  .Contabilizanotadebitomanual			lxContabilDescrip =  .Descripcion			lxContabilRsocial =  upper( .RazonSocial_PK ) 			lxContabilBasesproc =  .Bdprocesadas			lxContabilFecha =  .Fecha			lxContabilFechades =  .Fechadesde			lxContabilF_recibos =  .Contabilizarecibos			lxContabilF_ncman =  .Contabilizanotacreditomanual			lxContabilFechahas =  .Fechahasta			lxContabilF_compras =  .Contabilizacompras			lxContabilF_factfis =  .Contabilizafacturafiscal			lxContabilSucursal =  upper( .Sucursal_PK ) 			lxContabilF_ndfis =  .Contabilizanotadebitofiscal			lxContabilF_pagos =  .Contabilizapagos			lxContabilBase =  .Basededatos			lxContabilF_otrospag =  .Contabilizaotrospagos			lxContabilF_ncfis =  .Contabilizanotacreditofiscal			lxContabilF_caja =  .Contabilizacaja			lxContabilF_factele =  .Contabilizafacturaelectronica			lxContabilF_ndele =  .Contabilizanotadebitoelectronica			lxContabilF_canjes =  .Contabilizacanjes			lxContabilF_ncele =  .Contabilizanotacreditoelectronica			lxContabilF_desccheq =  .Contabilizadescargas			lxContabilF_liqtarj =  .Contabilizaliqtarjetas			lxContabilF_transf =  .Contabilizatransferencias			lxContabilF_ccclient =  .Contabilizaajustecccliente			lxContabilF_ccproved =  .Contabilizaajusteccproveedor			lxContabilF_concilia =  .Contabilizachequesconciliados			lxContabilF_cmv =  .Contabilizacostomercaderiavendida			lxContabilF_compr_fc =  .Contabilizafacturadecompra			lxContabilF_compr_nc =  .Contabilizanotacreditodecompra			lxContabilF_compr_nd =  .Contabilizanotadebitodecompra			lxContabilF_compr_o1 =  .Contabilizadespachoimportaccompra			lxContabilF_compr_o2 =  .Contabilizaliquidacionescompra			lxContabilF_compr_o3 =  .Contabilizaliqservpublcompra			lxContabilF_compr_o4 =  .Contabilizareciboscompra
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()
			lxValorClavePrimaria = .oEntidad.NUMERO
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ZooLogic.CONTABIL set "Fecexpo" = <<"'" + this.ConvertirDateSql( lxContabilFecexpo ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxContabilFectrans ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxContabilFecimpo ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxContabilFaltafw ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxContabilFmodifw ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxContabilBdmodifw ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxContabilBdaltafw ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxContabilHoraexpo ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxContabilEsttrans ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxContabilHaltafw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxContabilHoraimpo ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxContabilUmodifw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxContabilVmodifw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxContabilUaltafw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxContabilZadsfw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxContabilValtafw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxContabilHmodifw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxContabilSaltafw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxContabilSmodifw ) + "'">>,"Eobs" = <<"'" + this.FormatearTextoSql( lxContabilEobs ) + "'">>,"Ejercicio" = <<lxContabilEjercicio>>,"Numero" = <<lxContabilNumero>>,"Rangoasie" = <<"'" + this.FormatearTextoSql( lxContabilRangoasie ) + "'">>,"F_vtasloc" = <<iif( lxContabilF_vtasloc, 1, 0 )>>,"F_factman" = <<iif( lxContabilF_factman, 1, 0 )>>,"F_vtasexp" = <<iif( lxContabilF_vtasexp, 1, 0 )>>,"F_ndman" = <<iif( lxContabilF_ndman, 1, 0 )>>,"Descrip" = <<"'" + this.FormatearTextoSql( lxContabilDescrip ) + "'">>,"Rsocial" = <<"'" + this.FormatearTextoSql( lxContabilRsocial ) + "'">>,"Basesproc" = <<"'" + this.FormatearTextoSql( lxContabilBasesproc ) + "'">>,"Fecha" = <<"'" + this.ConvertirDateSql( lxContabilFecha ) + "'">>,"Fechades" = <<"'" + this.ConvertirDateSql( lxContabilFechades ) + "'">>,"F_recibos" = <<iif( lxContabilF_recibos, 1, 0 )>>,"F_ncman" = <<iif( lxContabilF_ncman, 1, 0 )>>,"Fechahas" = <<"'" + this.ConvertirDateSql( lxContabilFechahas ) + "'">>,"F_compras" = <<iif( lxContabilF_compras, 1, 0 )>>,"F_factfis" = <<iif( lxContabilF_factfis, 1, 0 )>>,"Sucursal" = <<"'" + this.FormatearTextoSql( lxContabilSucursal ) + "'">>,"F_ndfis" = <<iif( lxContabilF_ndfis, 1, 0 )>>,"F_pagos" = <<iif( lxContabilF_pagos, 1, 0 )>>,"Base" = <<"'" + this.FormatearTextoSql( lxContabilBase ) + "'">>,"F_otrospag" = <<iif( lxContabilF_otrospag, 1, 0 )>>,"F_ncfis" = <<iif( lxContabilF_ncfis, 1, 0 )>>,"F_caja" = <<iif( lxContabilF_caja, 1, 0 )>>,"F_factele" = <<iif( lxContabilF_factele, 1, 0 )>>,"F_ndele" = <<iif( lxContabilF_ndele, 1, 0 )>>,"F_canjes" = <<iif( lxContabilF_canjes, 1, 0 )>>,"F_ncele" = <<iif( lxContabilF_ncele, 1, 0 )>>,"F_desccheq" = <<iif( lxContabilF_desccheq, 1, 0 )>>,"F_liqtarj" = <<iif( lxContabilF_liqtarj, 1, 0 )>>,"F_transf" = <<iif( lxContabilF_transf, 1, 0 )>>,"F_ccclient" = <<iif( lxContabilF_ccclient, 1, 0 )>>,"F_ccproved" = <<iif( lxContabilF_ccproved, 1, 0 )>>,"F_concilia" = <<iif( lxContabilF_concilia, 1, 0 )>>,"F_cmv" = <<iif( lxContabilF_cmv, 1, 0 )>>,"F_compr_fc" = <<iif( lxContabilF_compr_fc, 1, 0 )>>,"F_compr_nc" = <<iif( lxContabilF_compr_nc, 1, 0 )>>,"F_compr_nd" = <<iif( lxContabilF_compr_nd, 1, 0 )>>,"F_compr_o1" = <<iif( lxContabilF_compr_o1, 1, 0 )>>,"F_compr_o2" = <<iif( lxContabilF_compr_o2, 1, 0 )>>,"F_compr_o3" = <<iif( lxContabilF_compr_o3, 1, 0 )>>,"F_compr_o4" = <<iif( lxContabilF_compr_o4, 1, 0 )>> where "Numero" = <<lxContabilNumero>> and  CONTABIL.NUMERO != 0 << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			this.ComprobarResultadoDeEjecucionDelUpdate()
		this.ComprobarTransaccion()
			.EjecutarSentencias( This.ColSentencias )
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 NUMERO from ZooLogic.CONTABIL where " + this.ConvertirFuncionesSql( " CONTABIL.NUMERO != 0" ) )
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
			Local lxContabilNumero
			lxContabilNumero = .Numero

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Horaexpo" as "Horaexpo", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Ualtafw" as "Usuarioaltafw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Eobs" as "Observacion", "Ejercicio" as "Ejercicio", "Numero" as "Numero", "Rangoasie" as "Rangodeasientosgenerados", "F_vtasloc" as "Contabilizaventaslocales", "F_factman" as "Contabilizafacturamanual", "F_vtasexp" as "Contabilizaventasexportacion", "F_ndman" as "Contabilizanotadebitomanual", "Descrip" as "Descripcion", "Rsocial" as "Razonsocial", "Basesproc" as "Bdprocesadas", "Fecha" as "Fecha", "Fechades" as "Fechadesde", "F_recibos" as "Contabilizarecibos", "F_ncman" as "Contabilizanotacreditomanual", "Fechahas" as "Fechahasta", "F_compras" as "Contabilizacompras", "F_factfis" as "Contabilizafacturafiscal", "Sucursal" as "Sucursal", "F_ndfis" as "Contabilizanotadebitofiscal", "F_pagos" as "Contabilizapagos", "Base" as "Basededatos", "F_otrospag" as "Contabilizaotrospagos", "F_ncfis" as "Contabilizanotacreditofiscal", "F_caja" as "Contabilizacaja", "F_factele" as "Contabilizafacturaelectronica", "F_ndele" as "Contabilizanotadebitoelectronica", "F_canjes" as "Contabilizacanjes", "F_ncele" as "Contabilizanotacreditoelectronica", "F_desccheq" as "Contabilizadescargas", "F_liqtarj" as "Contabilizaliqtarjetas", "F_transf" as "Contabilizatransferencias", "F_ccclient" as "Contabilizaajustecccliente", "F_ccproved" as "Contabilizaajusteccproveedor", "F_concilia" as "Contabilizachequesconciliados", "F_cmv" as "Contabilizacostomercaderiavendida", "F_compr_fc" as "Contabilizafacturadecompra", "F_compr_nc" as "Contabilizanotacreditodecompra", "F_compr_nd" as "Contabilizanotadebitodecompra", "F_compr_o1" as "Contabilizadespachoimportaccompra", "F_compr_o2" as "Contabilizaliquidacionescompra", "F_compr_o3" as "Contabilizaliqservpublcompra", "F_compr_o4" as "Contabilizareciboscompra" from ZooLogic.CONTABIL where "Numero" = <<lxContabilNumero>> and  CONTABIL.NUMERO != 0
			endtext
			use in select('c_CONTABILIZACION')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CONTABILIZACION', set( 'Datasession' ) )

			if reccount( 'c_CONTABILIZACION' ) = 0
				llRetorno = .f.
			else
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxContabilNumero as Variant
		llRetorno = .t.
		lxContabilNumero = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.CONTABIL where "Numero" = <<lxContabilNumero>> and  CONTABIL.NUMERO != 0
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
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Horaexpo" as "Horaexpo", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Ualtafw" as "Usuarioaltafw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Eobs" as "Observacion", "Ejercicio" as "Ejercicio", "Numero" as "Numero", "Rangoasie" as "Rangodeasientosgenerados", "F_vtasloc" as "Contabilizaventaslocales", "F_factman" as "Contabilizafacturamanual", "F_vtasexp" as "Contabilizaventasexportacion", "F_ndman" as "Contabilizanotadebitomanual", "Descrip" as "Descripcion", "Rsocial" as "Razonsocial", "Basesproc" as "Bdprocesadas", "Fecha" as "Fecha", "Fechades" as "Fechadesde", "F_recibos" as "Contabilizarecibos", "F_ncman" as "Contabilizanotacreditomanual", "Fechahas" as "Fechahasta", "F_compras" as "Contabilizacompras", "F_factfis" as "Contabilizafacturafiscal", "Sucursal" as "Sucursal", "F_ndfis" as "Contabilizanotadebitofiscal", "F_pagos" as "Contabilizapagos", "Base" as "Basededatos", "F_otrospag" as "Contabilizaotrospagos", "F_ncfis" as "Contabilizanotacreditofiscal", "F_caja" as "Contabilizacaja", "F_factele" as "Contabilizafacturaelectronica", "F_ndele" as "Contabilizanotadebitoelectronica", "F_canjes" as "Contabilizacanjes", "F_ncele" as "Contabilizanotacreditoelectronica", "F_desccheq" as "Contabilizadescargas", "F_liqtarj" as "Contabilizaliqtarjetas", "F_transf" as "Contabilizatransferencias", "F_ccclient" as "Contabilizaajustecccliente", "F_ccproved" as "Contabilizaajusteccproveedor", "F_concilia" as "Contabilizachequesconciliados", "F_cmv" as "Contabilizacostomercaderiavendida", "F_compr_fc" as "Contabilizafacturadecompra", "F_compr_nc" as "Contabilizanotacreditodecompra", "F_compr_nd" as "Contabilizanotadebitodecompra", "F_compr_o1" as "Contabilizadespachoimportaccompra", "F_compr_o2" as "Contabilizaliquidacionescompra", "F_compr_o3" as "Contabilizaliqservpublcompra", "F_compr_o4" as "Contabilizareciboscompra" from ZooLogic.CONTABIL where  CONTABIL.NUMERO != 0 order by NUMERO
			endtext
			use in select('c_CONTABILIZACION')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CONTABILIZACION', set( 'Datasession' ) )
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
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Horaexpo" as "Horaexpo", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Ualtafw" as "Usuarioaltafw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Eobs" as "Observacion", "Ejercicio" as "Ejercicio", "Numero" as "Numero", "Rangoasie" as "Rangodeasientosgenerados", "F_vtasloc" as "Contabilizaventaslocales", "F_factman" as "Contabilizafacturamanual", "F_vtasexp" as "Contabilizaventasexportacion", "F_ndman" as "Contabilizanotadebitomanual", "Descrip" as "Descripcion", "Rsocial" as "Razonsocial", "Basesproc" as "Bdprocesadas", "Fecha" as "Fecha", "Fechades" as "Fechadesde", "F_recibos" as "Contabilizarecibos", "F_ncman" as "Contabilizanotacreditomanual", "Fechahas" as "Fechahasta", "F_compras" as "Contabilizacompras", "F_factfis" as "Contabilizafacturafiscal", "Sucursal" as "Sucursal", "F_ndfis" as "Contabilizanotadebitofiscal", "F_pagos" as "Contabilizapagos", "Base" as "Basededatos", "F_otrospag" as "Contabilizaotrospagos", "F_ncfis" as "Contabilizanotacreditofiscal", "F_caja" as "Contabilizacaja", "F_factele" as "Contabilizafacturaelectronica", "F_ndele" as "Contabilizanotadebitoelectronica", "F_canjes" as "Contabilizacanjes", "F_ncele" as "Contabilizanotacreditoelectronica", "F_desccheq" as "Contabilizadescargas", "F_liqtarj" as "Contabilizaliqtarjetas", "F_transf" as "Contabilizatransferencias", "F_ccclient" as "Contabilizaajustecccliente", "F_ccproved" as "Contabilizaajusteccproveedor", "F_concilia" as "Contabilizachequesconciliados", "F_cmv" as "Contabilizacostomercaderiavendida", "F_compr_fc" as "Contabilizafacturadecompra", "F_compr_nc" as "Contabilizanotacreditodecompra", "F_compr_nd" as "Contabilizanotadebitodecompra", "F_compr_o1" as "Contabilizadespachoimportaccompra", "F_compr_o2" as "Contabilizaliquidacionescompra", "F_compr_o3" as "Contabilizaliqservpublcompra", "F_compr_o4" as "Contabilizareciboscompra" from ZooLogic.CONTABIL where  str( NUMERO, 8, 0) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  CONTABIL.NUMERO != 0 order by NUMERO
			endtext
			use in select('c_CONTABILIZACION')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CONTABILIZACION', set( 'Datasession' ) )
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
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Horaexpo" as "Horaexpo", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Ualtafw" as "Usuarioaltafw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Eobs" as "Observacion", "Ejercicio" as "Ejercicio", "Numero" as "Numero", "Rangoasie" as "Rangodeasientosgenerados", "F_vtasloc" as "Contabilizaventaslocales", "F_factman" as "Contabilizafacturamanual", "F_vtasexp" as "Contabilizaventasexportacion", "F_ndman" as "Contabilizanotadebitomanual", "Descrip" as "Descripcion", "Rsocial" as "Razonsocial", "Basesproc" as "Bdprocesadas", "Fecha" as "Fecha", "Fechades" as "Fechadesde", "F_recibos" as "Contabilizarecibos", "F_ncman" as "Contabilizanotacreditomanual", "Fechahas" as "Fechahasta", "F_compras" as "Contabilizacompras", "F_factfis" as "Contabilizafacturafiscal", "Sucursal" as "Sucursal", "F_ndfis" as "Contabilizanotadebitofiscal", "F_pagos" as "Contabilizapagos", "Base" as "Basededatos", "F_otrospag" as "Contabilizaotrospagos", "F_ncfis" as "Contabilizanotacreditofiscal", "F_caja" as "Contabilizacaja", "F_factele" as "Contabilizafacturaelectronica", "F_ndele" as "Contabilizanotadebitoelectronica", "F_canjes" as "Contabilizacanjes", "F_ncele" as "Contabilizanotacreditoelectronica", "F_desccheq" as "Contabilizadescargas", "F_liqtarj" as "Contabilizaliqtarjetas", "F_transf" as "Contabilizatransferencias", "F_ccclient" as "Contabilizaajustecccliente", "F_ccproved" as "Contabilizaajusteccproveedor", "F_concilia" as "Contabilizachequesconciliados", "F_cmv" as "Contabilizacostomercaderiavendida", "F_compr_fc" as "Contabilizafacturadecompra", "F_compr_nc" as "Contabilizanotacreditodecompra", "F_compr_nd" as "Contabilizanotadebitodecompra", "F_compr_o1" as "Contabilizadespachoimportaccompra", "F_compr_o2" as "Contabilizaliquidacionescompra", "F_compr_o3" as "Contabilizaliqservpublcompra", "F_compr_o4" as "Contabilizareciboscompra" from ZooLogic.CONTABIL where  str( NUMERO, 8, 0) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  CONTABIL.NUMERO != 0 order by NUMERO desc
			endtext
			use in select('c_CONTABILIZACION')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CONTABILIZACION', set( 'Datasession' ) )
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
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Horaexpo" as "Horaexpo", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Ualtafw" as "Usuarioaltafw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Eobs" as "Observacion", "Ejercicio" as "Ejercicio", "Numero" as "Numero", "Rangoasie" as "Rangodeasientosgenerados", "F_vtasloc" as "Contabilizaventaslocales", "F_factman" as "Contabilizafacturamanual", "F_vtasexp" as "Contabilizaventasexportacion", "F_ndman" as "Contabilizanotadebitomanual", "Descrip" as "Descripcion", "Rsocial" as "Razonsocial", "Basesproc" as "Bdprocesadas", "Fecha" as "Fecha", "Fechades" as "Fechadesde", "F_recibos" as "Contabilizarecibos", "F_ncman" as "Contabilizanotacreditomanual", "Fechahas" as "Fechahasta", "F_compras" as "Contabilizacompras", "F_factfis" as "Contabilizafacturafiscal", "Sucursal" as "Sucursal", "F_ndfis" as "Contabilizanotadebitofiscal", "F_pagos" as "Contabilizapagos", "Base" as "Basededatos", "F_otrospag" as "Contabilizaotrospagos", "F_ncfis" as "Contabilizanotacreditofiscal", "F_caja" as "Contabilizacaja", "F_factele" as "Contabilizafacturaelectronica", "F_ndele" as "Contabilizanotadebitoelectronica", "F_canjes" as "Contabilizacanjes", "F_ncele" as "Contabilizanotacreditoelectronica", "F_desccheq" as "Contabilizadescargas", "F_liqtarj" as "Contabilizaliqtarjetas", "F_transf" as "Contabilizatransferencias", "F_ccclient" as "Contabilizaajustecccliente", "F_ccproved" as "Contabilizaajusteccproveedor", "F_concilia" as "Contabilizachequesconciliados", "F_cmv" as "Contabilizacostomercaderiavendida", "F_compr_fc" as "Contabilizafacturadecompra", "F_compr_nc" as "Contabilizanotacreditodecompra", "F_compr_nd" as "Contabilizanotadebitodecompra", "F_compr_o1" as "Contabilizadespachoimportaccompra", "F_compr_o2" as "Contabilizaliquidacionescompra", "F_compr_o3" as "Contabilizaliqservpublcompra", "F_compr_o4" as "Contabilizareciboscompra" from ZooLogic.CONTABIL where  CONTABIL.NUMERO != 0 order by NUMERO desc
			endtext
			use in select('c_CONTABILIZACION')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CONTABILIZACION', set( 'Datasession' ) )
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
			lcXml = this.oConexion.EjecutarSql( "select Fecexpo,Fectrans,Fecimpo,Faltafw,Fmodifw,Bdmodifw,Bdaltafw,Horaexpo,Esttrans,Haltafw,Horaimp" + ;
"o,Umodifw,Vmodifw,Ualtafw,Zadsfw,Valtafw,Hmodifw,Saltafw,Smodifw,Eobs,Ejercicio,Numero,Rangoasie,F_v" + ;
"tasloc,F_factman,F_vtasexp,F_ndman,Descrip,Rsocial,Basesproc,Fecha,Fechades,F_recibos,F_ncman,Fechah" + ;
"as,F_compras,F_factfis,Sucursal,F_ndfis,F_pagos,Base,F_otrospag,F_ncfis,F_caja,F_factele,F_ndele,F_c" + ;
"anjes,F_ncele,F_desccheq,F_liqtarj,F_transf,F_ccclient,F_ccproved,F_concilia,F_cmv,F_compr_fc,F_comp" + ;
"r_nc,F_compr_nd,F_compr_o1,F_compr_o2,F_compr_o3,F_compr_o4" + ;
" from ZooLogic.CONTABIL where  CONTABIL.NUMERO != 0 and " + lcFiltro )
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
			local  lxContabilFecexpo, lxContabilFectrans, lxContabilFecimpo, lxContabilFaltafw, lxContabilFmodifw, lxContabilBdmodifw, lxContabilBdaltafw, lxContabilHoraexpo, lxContabilEsttrans, lxContabilHaltafw, lxContabilHoraimpo, lxContabilUmodifw, lxContabilVmodifw, lxContabilUaltafw, lxContabilZadsfw, lxContabilValtafw, lxContabilHmodifw, lxContabilSaltafw, lxContabilSmodifw, lxContabilEobs, lxContabilEjercicio, lxContabilNumero, lxContabilRangoasie, lxContabilF_vtasloc, lxContabilF_factman, lxContabilF_vtasexp, lxContabilF_ndman, lxContabilDescrip, lxContabilRsocial, lxContabilBasesproc, lxContabilFecha, lxContabilFechades, lxContabilF_recibos, lxContabilF_ncman, lxContabilFechahas, lxContabilF_compras, lxContabilF_factfis, lxContabilSucursal, lxContabilF_ndfis, lxContabilF_pagos, lxContabilBase, lxContabilF_otrospag, lxContabilF_ncfis, lxContabilF_caja, lxContabilF_factele, lxContabilF_ndele, lxContabilF_canjes, lxContabilF_ncele, lxContabilF_desccheq, lxContabilF_liqtarj, lxContabilF_transf, lxContabilF_ccclient, lxContabilF_ccproved, lxContabilF_concilia, lxContabilF_cmv, lxContabilF_compr_fc, lxContabilF_compr_nc, lxContabilF_compr_nd, lxContabilF_compr_o1, lxContabilF_compr_o2, lxContabilF_compr_o3, lxContabilF_compr_o4
				lxContabilFecexpo = ctod( '  /  /    ' )			lxContabilFectrans = ctod( '  /  /    ' )			lxContabilFecimpo = ctod( '  /  /    ' )			lxContabilFaltafw = ctod( '  /  /    ' )			lxContabilFmodifw = ctod( '  /  /    ' )			lxContabilBdmodifw = []			lxContabilBdaltafw = []			lxContabilHoraexpo = []			lxContabilEsttrans = []			lxContabilHaltafw = []			lxContabilHoraimpo = []			lxContabilUmodifw = []			lxContabilVmodifw = []			lxContabilUaltafw = []			lxContabilZadsfw = []			lxContabilValtafw = []			lxContabilHmodifw = []			lxContabilSaltafw = []			lxContabilSmodifw = []			lxContabilEobs = []			lxContabilEjercicio = 0			lxContabilNumero = 0			lxContabilRangoasie = []			lxContabilF_vtasloc = .F.			lxContabilF_factman = .F.			lxContabilF_vtasexp = .F.			lxContabilF_ndman = .F.			lxContabilDescrip = []			lxContabilRsocial = []			lxContabilBasesproc = []			lxContabilFecha = ctod( '  /  /    ' )			lxContabilFechades = ctod( '  /  /    ' )			lxContabilF_recibos = .F.			lxContabilF_ncman = .F.			lxContabilFechahas = ctod( '  /  /    ' )			lxContabilF_compras = .F.			lxContabilF_factfis = .F.			lxContabilSucursal = []			lxContabilF_ndfis = .F.			lxContabilF_pagos = .F.			lxContabilBase = []			lxContabilF_otrospag = .F.			lxContabilF_ncfis = .F.			lxContabilF_caja = .F.			lxContabilF_factele = .F.			lxContabilF_ndele = .F.			lxContabilF_canjes = .F.			lxContabilF_ncele = .F.			lxContabilF_desccheq = .F.			lxContabilF_liqtarj = .F.			lxContabilF_transf = .F.			lxContabilF_ccclient = .F.			lxContabilF_ccproved = .F.			lxContabilF_concilia = .F.			lxContabilF_cmv = .F.			lxContabilF_compr_fc = .F.			lxContabilF_compr_nc = .F.			lxContabilF_compr_nd = .F.			lxContabilF_compr_o1 = .F.			lxContabilF_compr_o2 = .F.			lxContabilF_compr_o3 = .F.			lxContabilF_compr_o4 = .F.
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( [delete from ZooLogic.CONTABIL where "NUMERO" = ] + transform( .oEntidad.NUMERO )+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			.GenerarSentenciasComponentes()
			.EjecutarSentencias( This.ColSentencias )
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
			lcTabla = 'CONTABIL' + '_' + tcCampo
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
		lcWhere = " Where  CONTABIL.NUMERO != 0"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Horaexpo" as "Horaexpo", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Ualtafw" as "Usuarioaltafw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Eobs" as "Observacion", "Ejercicio" as "Ejercicio", "Numero" as "Numero", "Rangoasie" as "Rangodeasientosgenerados", "F_vtasloc" as "Contabilizaventaslocales", "F_factman" as "Contabilizafacturamanual", "F_vtasexp" as "Contabilizaventasexportacion", "F_ndman" as "Contabilizanotadebitomanual", "Descrip" as "Descripcion", "Rsocial" as "Razonsocial", "Basesproc" as "Bdprocesadas", "Fecha" as "Fecha", "Fechades" as "Fechadesde", "F_recibos" as "Contabilizarecibos", "F_ncman" as "Contabilizanotacreditomanual", "Fechahas" as "Fechahasta", "F_compras" as "Contabilizacompras", "F_factfis" as "Contabilizafacturafiscal", "Sucursal" as "Sucursal", "F_ndfis" as "Contabilizanotadebitofiscal", "F_pagos" as "Contabilizapagos", "Base" as "Basededatos", "F_otrospag" as "Contabilizaotrospagos", "F_ncfis" as "Contabilizanotacreditofiscal", "F_caja" as "Contabilizacaja", "F_factele" as "Contabilizafacturaelectronica", "F_ndele" as "Contabilizanotadebitoelectronica", "F_canjes" as "Contabilizacanjes", "F_ncele" as "Contabilizanotacreditoelectronica", "F_desccheq" as "Contabilizadescargas", "F_liqtarj" as "Contabilizaliqtarjetas", "F_transf" as "Contabilizatransferencias", "F_ccclient" as "Contabilizaajustecccliente", "F_ccproved" as "Contabilizaajusteccproveedor", "F_concilia" as "Contabilizachequesconciliados", "F_cmv" as "Contabilizacostomercaderiavendida", "F_compr_fc" as "Contabilizafacturadecompra", "F_compr_nc" as "Contabilizanotacreditodecompra", "F_compr_nd" as "Contabilizanotadebitodecompra", "F_compr_o1" as "Contabilizadespachoimportaccompra", "F_compr_o2" as "Contabilizaliquidacionescompra", "F_compr_o3" as "Contabilizaliqservpublcompra", "F_compr_o4" as "Contabilizareciboscompra"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'CONTABIL', '', tnTope )
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
				Case lcAtributo == 'FECHAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECEXPO AS FECHAEXPO'
				Case lcAtributo == 'FECHATRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRANS AS FECHATRANSFERENCIA'
				Case lcAtributo == 'FECHAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECIMPO AS FECHAIMPO'
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'OBSERVACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'EOBS AS OBSERVACION'
				Case lcAtributo == 'EJERCICIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'EJERCICIO AS EJERCICIO'
				Case lcAtributo == 'NUMERO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NUMERO AS NUMERO'
				Case lcAtributo == 'RANGODEASIENTOSGENERADOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RANGOASIE AS RANGODEASIENTOSGENERADOS'
				Case lcAtributo == 'CONTABILIZAVENTASLOCALES'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'F_VTASLOC AS CONTABILIZAVENTASLOCALES'
				Case lcAtributo == 'CONTABILIZAFACTURAMANUAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'F_FACTMAN AS CONTABILIZAFACTURAMANUAL'
				Case lcAtributo == 'CONTABILIZAVENTASEXPORTACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'F_VTASEXP AS CONTABILIZAVENTASEXPORTACION'
				Case lcAtributo == 'CONTABILIZANOTADEBITOMANUAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'F_NDMAN AS CONTABILIZANOTADEBITOMANUAL'
				Case lcAtributo == 'DESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCRIP AS DESCRIPCION'
				Case lcAtributo == 'RAZONSOCIAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RSOCIAL AS RAZONSOCIAL'
				Case lcAtributo == 'BDPROCESADAS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BASESPROC AS BDPROCESADAS'
				Case lcAtributo == 'FECHA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHA AS FECHA'
				Case lcAtributo == 'FECHADESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHADES AS FECHADESDE'
				Case lcAtributo == 'CONTABILIZARECIBOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'F_RECIBOS AS CONTABILIZARECIBOS'
				Case lcAtributo == 'CONTABILIZANOTACREDITOMANUAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'F_NCMAN AS CONTABILIZANOTACREDITOMANUAL'
				Case lcAtributo == 'FECHAHASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHAHAS AS FECHAHASTA'
				Case lcAtributo == 'CONTABILIZACOMPRAS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'F_COMPRAS AS CONTABILIZACOMPRAS'
				Case lcAtributo == 'CONTABILIZAFACTURAFISCAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'F_FACTFIS AS CONTABILIZAFACTURAFISCAL'
				Case lcAtributo == 'SUCURSAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SUCURSAL AS SUCURSAL'
				Case lcAtributo == 'CONTABILIZANOTADEBITOFISCAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'F_NDFIS AS CONTABILIZANOTADEBITOFISCAL'
				Case lcAtributo == 'CONTABILIZAPAGOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'F_PAGOS AS CONTABILIZAPAGOS'
				Case lcAtributo == 'BASEDEDATOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BASE AS BASEDEDATOS'
				Case lcAtributo == 'CONTABILIZAOTROSPAGOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'F_OTROSPAG AS CONTABILIZAOTROSPAGOS'
				Case lcAtributo == 'CONTABILIZANOTACREDITOFISCAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'F_NCFIS AS CONTABILIZANOTACREDITOFISCAL'
				Case lcAtributo == 'CONTABILIZACAJA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'F_CAJA AS CONTABILIZACAJA'
				Case lcAtributo == 'CONTABILIZAFACTURAELECTRONICA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'F_FACTELE AS CONTABILIZAFACTURAELECTRONICA'
				Case lcAtributo == 'CONTABILIZANOTADEBITOELECTRONICA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'F_NDELE AS CONTABILIZANOTADEBITOELECTRONICA'
				Case lcAtributo == 'CONTABILIZACANJES'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'F_CANJES AS CONTABILIZACANJES'
				Case lcAtributo == 'CONTABILIZANOTACREDITOELECTRONICA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'F_NCELE AS CONTABILIZANOTACREDITOELECTRONICA'
				Case lcAtributo == 'CONTABILIZADESCARGAS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'F_DESCCHEQ AS CONTABILIZADESCARGAS'
				Case lcAtributo == 'CONTABILIZALIQTARJETAS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'F_LIQTARJ AS CONTABILIZALIQTARJETAS'
				Case lcAtributo == 'CONTABILIZATRANSFERENCIAS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'F_TRANSF AS CONTABILIZATRANSFERENCIAS'
				Case lcAtributo == 'CONTABILIZAAJUSTECCCLIENTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'F_CCCLIENT AS CONTABILIZAAJUSTECCCLIENTE'
				Case lcAtributo == 'CONTABILIZAAJUSTECCPROVEEDOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'F_CCPROVED AS CONTABILIZAAJUSTECCPROVEEDOR'
				Case lcAtributo == 'CONTABILIZACHEQUESCONCILIADOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'F_CONCILIA AS CONTABILIZACHEQUESCONCILIADOS'
				Case lcAtributo == 'CONTABILIZACOSTOMERCADERIAVENDIDA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'F_CMV AS CONTABILIZACOSTOMERCADERIAVENDIDA'
				Case lcAtributo == 'CONTABILIZAFACTURADECOMPRA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'F_COMPR_FC AS CONTABILIZAFACTURADECOMPRA'
				Case lcAtributo == 'CONTABILIZANOTACREDITODECOMPRA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'F_COMPR_NC AS CONTABILIZANOTACREDITODECOMPRA'
				Case lcAtributo == 'CONTABILIZANOTADEBITODECOMPRA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'F_COMPR_ND AS CONTABILIZANOTADEBITODECOMPRA'
				Case lcAtributo == 'CONTABILIZADESPACHOIMPORTACCOMPRA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'F_COMPR_O1 AS CONTABILIZADESPACHOIMPORTACCOMPRA'
				Case lcAtributo == 'CONTABILIZALIQUIDACIONESCOMPRA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'F_COMPR_O2 AS CONTABILIZALIQUIDACIONESCOMPRA'
				Case lcAtributo == 'CONTABILIZALIQSERVPUBLCOMPRA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'F_COMPR_O3 AS CONTABILIZALIQSERVPUBLCOMPRA'
				Case lcAtributo == 'CONTABILIZARECIBOSCOMPRA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'F_COMPR_O4 AS CONTABILIZARECIBOSCOMPRA'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAIMPO'
				lcCampo = 'FECIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'OBSERVACION'
				lcCampo = 'EOBS'
			Case upper( alltrim( tcAtributo ) ) == 'EJERCICIO'
				lcCampo = 'EJERCICIO'
			Case upper( alltrim( tcAtributo ) ) == 'NUMERO'
				lcCampo = 'NUMERO'
			Case upper( alltrim( tcAtributo ) ) == 'RANGODEASIENTOSGENERADOS'
				lcCampo = 'RANGOASIE'
			Case upper( alltrim( tcAtributo ) ) == 'CONTABILIZAVENTASLOCALES'
				lcCampo = 'F_VTASLOC'
			Case upper( alltrim( tcAtributo ) ) == 'CONTABILIZAFACTURAMANUAL'
				lcCampo = 'F_FACTMAN'
			Case upper( alltrim( tcAtributo ) ) == 'CONTABILIZAVENTASEXPORTACION'
				lcCampo = 'F_VTASEXP'
			Case upper( alltrim( tcAtributo ) ) == 'CONTABILIZANOTADEBITOMANUAL'
				lcCampo = 'F_NDMAN'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCION'
				lcCampo = 'DESCRIP'
			Case upper( alltrim( tcAtributo ) ) == 'RAZONSOCIAL'
				lcCampo = 'RSOCIAL'
			Case upper( alltrim( tcAtributo ) ) == 'BDPROCESADAS'
				lcCampo = 'BASESPROC'
			Case upper( alltrim( tcAtributo ) ) == 'FECHA'
				lcCampo = 'FECHA'
			Case upper( alltrim( tcAtributo ) ) == 'FECHADESDE'
				lcCampo = 'FECHADES'
			Case upper( alltrim( tcAtributo ) ) == 'CONTABILIZARECIBOS'
				lcCampo = 'F_RECIBOS'
			Case upper( alltrim( tcAtributo ) ) == 'CONTABILIZANOTACREDITOMANUAL'
				lcCampo = 'F_NCMAN'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAHASTA'
				lcCampo = 'FECHAHAS'
			Case upper( alltrim( tcAtributo ) ) == 'CONTABILIZACOMPRAS'
				lcCampo = 'F_COMPRAS'
			Case upper( alltrim( tcAtributo ) ) == 'CONTABILIZAFACTURAFISCAL'
				lcCampo = 'F_FACTFIS'
			Case upper( alltrim( tcAtributo ) ) == 'SUCURSAL'
				lcCampo = 'SUCURSAL'
			Case upper( alltrim( tcAtributo ) ) == 'CONTABILIZANOTADEBITOFISCAL'
				lcCampo = 'F_NDFIS'
			Case upper( alltrim( tcAtributo ) ) == 'CONTABILIZAPAGOS'
				lcCampo = 'F_PAGOS'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOS'
				lcCampo = 'BASE'
			Case upper( alltrim( tcAtributo ) ) == 'CONTABILIZAOTROSPAGOS'
				lcCampo = 'F_OTROSPAG'
			Case upper( alltrim( tcAtributo ) ) == 'CONTABILIZANOTACREDITOFISCAL'
				lcCampo = 'F_NCFIS'
			Case upper( alltrim( tcAtributo ) ) == 'CONTABILIZACAJA'
				lcCampo = 'F_CAJA'
			Case upper( alltrim( tcAtributo ) ) == 'CONTABILIZAFACTURAELECTRONICA'
				lcCampo = 'F_FACTELE'
			Case upper( alltrim( tcAtributo ) ) == 'CONTABILIZANOTADEBITOELECTRONICA'
				lcCampo = 'F_NDELE'
			Case upper( alltrim( tcAtributo ) ) == 'CONTABILIZACANJES'
				lcCampo = 'F_CANJES'
			Case upper( alltrim( tcAtributo ) ) == 'CONTABILIZANOTACREDITOELECTRONICA'
				lcCampo = 'F_NCELE'
			Case upper( alltrim( tcAtributo ) ) == 'CONTABILIZADESCARGAS'
				lcCampo = 'F_DESCCHEQ'
			Case upper( alltrim( tcAtributo ) ) == 'CONTABILIZALIQTARJETAS'
				lcCampo = 'F_LIQTARJ'
			Case upper( alltrim( tcAtributo ) ) == 'CONTABILIZATRANSFERENCIAS'
				lcCampo = 'F_TRANSF'
			Case upper( alltrim( tcAtributo ) ) == 'CONTABILIZAAJUSTECCCLIENTE'
				lcCampo = 'F_CCCLIENT'
			Case upper( alltrim( tcAtributo ) ) == 'CONTABILIZAAJUSTECCPROVEEDOR'
				lcCampo = 'F_CCPROVED'
			Case upper( alltrim( tcAtributo ) ) == 'CONTABILIZACHEQUESCONCILIADOS'
				lcCampo = 'F_CONCILIA'
			Case upper( alltrim( tcAtributo ) ) == 'CONTABILIZACOSTOMERCADERIAVENDIDA'
				lcCampo = 'F_CMV'
			Case upper( alltrim( tcAtributo ) ) == 'CONTABILIZAFACTURADECOMPRA'
				lcCampo = 'F_COMPR_FC'
			Case upper( alltrim( tcAtributo ) ) == 'CONTABILIZANOTACREDITODECOMPRA'
				lcCampo = 'F_COMPR_NC'
			Case upper( alltrim( tcAtributo ) ) == 'CONTABILIZANOTADEBITODECOMPRA'
				lcCampo = 'F_COMPR_ND'
			Case upper( alltrim( tcAtributo ) ) == 'CONTABILIZADESPACHOIMPORTACCOMPRA'
				lcCampo = 'F_COMPR_O1'
			Case upper( alltrim( tcAtributo ) ) == 'CONTABILIZALIQUIDACIONESCOMPRA'
				lcCampo = 'F_COMPR_O2'
			Case upper( alltrim( tcAtributo ) ) == 'CONTABILIZALIQSERVPUBLCOMPRA'
				lcCampo = 'F_COMPR_O3'
			Case upper( alltrim( tcAtributo ) ) == 'CONTABILIZARECIBOSCOMPRA'
				lcCampo = 'F_COMPR_O4'
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
			local  lxContabilFecexpo, lxContabilFectrans, lxContabilFecimpo, lxContabilFaltafw, lxContabilFmodifw, lxContabilBdmodifw, lxContabilBdaltafw, lxContabilHoraexpo, lxContabilEsttrans, lxContabilHaltafw, lxContabilHoraimpo, lxContabilUmodifw, lxContabilVmodifw, lxContabilUaltafw, lxContabilZadsfw, lxContabilValtafw, lxContabilHmodifw, lxContabilSaltafw, lxContabilSmodifw, lxContabilEobs, lxContabilEjercicio, lxContabilNumero, lxContabilRangoasie, lxContabilF_vtasloc, lxContabilF_factman, lxContabilF_vtasexp, lxContabilF_ndman, lxContabilDescrip, lxContabilRsocial, lxContabilBasesproc, lxContabilFecha, lxContabilFechades, lxContabilF_recibos, lxContabilF_ncman, lxContabilFechahas, lxContabilF_compras, lxContabilF_factfis, lxContabilSucursal, lxContabilF_ndfis, lxContabilF_pagos, lxContabilBase, lxContabilF_otrospag, lxContabilF_ncfis, lxContabilF_caja, lxContabilF_factele, lxContabilF_ndele, lxContabilF_canjes, lxContabilF_ncele, lxContabilF_desccheq, lxContabilF_liqtarj, lxContabilF_transf, lxContabilF_ccclient, lxContabilF_ccproved, lxContabilF_concilia, lxContabilF_cmv, lxContabilF_compr_fc, lxContabilF_compr_nc, lxContabilF_compr_nd, lxContabilF_compr_o1, lxContabilF_compr_o2, lxContabilF_compr_o3, lxContabilF_compr_o4
				lxContabilFecexpo =  .Fechaexpo			lxContabilFectrans =  .Fechatransferencia			lxContabilFecimpo =  .Fechaimpo			lxContabilFaltafw =  .Fechaaltafw			lxContabilFmodifw =  .Fechamodificacionfw			lxContabilBdmodifw =  .Basededatosmodificacionfw			lxContabilBdaltafw =  .Basededatosaltafw			lxContabilHoraexpo =  .Horaexpo			lxContabilEsttrans =  .Estadotransferencia			lxContabilHaltafw =  .Horaaltafw			lxContabilHoraimpo =  .Horaimpo			lxContabilUmodifw =  .Usuariomodificacionfw			lxContabilVmodifw =  .Versionmodificacionfw			lxContabilUaltafw =  .Usuarioaltafw			lxContabilZadsfw =  .Zadsfw			lxContabilValtafw =  .Versionaltafw			lxContabilHmodifw =  .Horamodificacionfw			lxContabilSaltafw =  .Seriealtafw			lxContabilSmodifw =  .Seriemodificacionfw			lxContabilEobs =  .Observacion			lxContabilEjercicio =  .Ejercicio_PK 			lxContabilNumero =  .Numero			lxContabilRangoasie =  .Rangodeasientosgenerados			lxContabilF_vtasloc =  .Contabilizaventaslocales			lxContabilF_factman =  .Contabilizafacturamanual			lxContabilF_vtasexp =  .Contabilizaventasexportacion			lxContabilF_ndman =  .Contabilizanotadebitomanual			lxContabilDescrip =  .Descripcion			lxContabilRsocial =  upper( .RazonSocial_PK ) 			lxContabilBasesproc =  .Bdprocesadas			lxContabilFecha =  .Fecha			lxContabilFechades =  .Fechadesde			lxContabilF_recibos =  .Contabilizarecibos			lxContabilF_ncman =  .Contabilizanotacreditomanual			lxContabilFechahas =  .Fechahasta			lxContabilF_compras =  .Contabilizacompras			lxContabilF_factfis =  .Contabilizafacturafiscal			lxContabilSucursal =  upper( .Sucursal_PK ) 			lxContabilF_ndfis =  .Contabilizanotadebitofiscal			lxContabilF_pagos =  .Contabilizapagos			lxContabilBase =  .Basededatos			lxContabilF_otrospag =  .Contabilizaotrospagos			lxContabilF_ncfis =  .Contabilizanotacreditofiscal			lxContabilF_caja =  .Contabilizacaja			lxContabilF_factele =  .Contabilizafacturaelectronica			lxContabilF_ndele =  .Contabilizanotadebitoelectronica			lxContabilF_canjes =  .Contabilizacanjes			lxContabilF_ncele =  .Contabilizanotacreditoelectronica			lxContabilF_desccheq =  .Contabilizadescargas			lxContabilF_liqtarj =  .Contabilizaliqtarjetas			lxContabilF_transf =  .Contabilizatransferencias			lxContabilF_ccclient =  .Contabilizaajustecccliente			lxContabilF_ccproved =  .Contabilizaajusteccproveedor			lxContabilF_concilia =  .Contabilizachequesconciliados			lxContabilF_cmv =  .Contabilizacostomercaderiavendida			lxContabilF_compr_fc =  .Contabilizafacturadecompra			lxContabilF_compr_nc =  .Contabilizanotacreditodecompra			lxContabilF_compr_nd =  .Contabilizanotadebitodecompra			lxContabilF_compr_o1 =  .Contabilizadespachoimportaccompra			lxContabilF_compr_o2 =  .Contabilizaliquidacionescompra			lxContabilF_compr_o3 =  .Contabilizaliqservpublcompra			lxContabilF_compr_o4 =  .Contabilizareciboscompra
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.CONTABIL ( "Fecexpo","Fectrans","Fecimpo","Faltafw","Fmodifw","Bdmodifw","Bdaltafw","Horaexpo","Esttrans","Haltafw","Horaimpo","Umodifw","Vmodifw","Ualtafw","Zadsfw","Valtafw","Hmodifw","Saltafw","Smodifw","Eobs","Ejercicio","Numero","Rangoasie","F_vtasloc","F_factman","F_vtasexp","F_ndman","Descrip","Rsocial","Basesproc","Fecha","Fechades","F_recibos","F_ncman","Fechahas","F_compras","F_factfis","Sucursal","F_ndfis","F_pagos","Base","F_otrospag","F_ncfis","F_caja","F_factele","F_ndele","F_canjes","F_ncele","F_desccheq","F_liqtarj","F_transf","F_ccclient","F_ccproved","F_concilia","F_cmv","F_compr_fc","F_compr_nc","F_compr_nd","F_compr_o1","F_compr_o2","F_compr_o3","F_compr_o4" ) values ( <<"'" + this.ConvertirDateSql( lxContabilFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxContabilFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxContabilFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxContabilFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxContabilFmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxContabilBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxContabilBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxContabilHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxContabilEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxContabilHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxContabilHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxContabilUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxContabilVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxContabilUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxContabilZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxContabilValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxContabilHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxContabilSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxContabilSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxContabilEobs ) + "'" >>, <<lxContabilEjercicio >>, <<lxContabilNumero >>, <<"'" + this.FormatearTextoSql( lxContabilRangoasie ) + "'" >>, <<iif( lxContabilF_vtasloc, 1, 0 ) >>, <<iif( lxContabilF_factman, 1, 0 ) >>, <<iif( lxContabilF_vtasexp, 1, 0 ) >>, <<iif( lxContabilF_ndman, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxContabilDescrip ) + "'" >>, <<"'" + this.FormatearTextoSql( lxContabilRsocial ) + "'" >>, <<"'" + this.FormatearTextoSql( lxContabilBasesproc ) + "'" >>, <<"'" + this.ConvertirDateSql( lxContabilFecha ) + "'" >>, <<"'" + this.ConvertirDateSql( lxContabilFechades ) + "'" >>, <<iif( lxContabilF_recibos, 1, 0 ) >>, <<iif( lxContabilF_ncman, 1, 0 ) >>, <<"'" + this.ConvertirDateSql( lxContabilFechahas ) + "'" >>, <<iif( lxContabilF_compras, 1, 0 ) >>, <<iif( lxContabilF_factfis, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxContabilSucursal ) + "'" >>, <<iif( lxContabilF_ndfis, 1, 0 ) >>, <<iif( lxContabilF_pagos, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxContabilBase ) + "'" >>, <<iif( lxContabilF_otrospag, 1, 0 ) >>, <<iif( lxContabilF_ncfis, 1, 0 ) >>, <<iif( lxContabilF_caja, 1, 0 ) >>, <<iif( lxContabilF_factele, 1, 0 ) >>, <<iif( lxContabilF_ndele, 1, 0 ) >>, <<iif( lxContabilF_canjes, 1, 0 ) >>, <<iif( lxContabilF_ncele, 1, 0 ) >>, <<iif( lxContabilF_desccheq, 1, 0 ) >>, <<iif( lxContabilF_liqtarj, 1, 0 ) >>, <<iif( lxContabilF_transf, 1, 0 ) >>, <<iif( lxContabilF_ccclient, 1, 0 ) >>, <<iif( lxContabilF_ccproved, 1, 0 ) >>, <<iif( lxContabilF_concilia, 1, 0 ) >>, <<iif( lxContabilF_cmv, 1, 0 ) >>, <<iif( lxContabilF_compr_fc, 1, 0 ) >>, <<iif( lxContabilF_compr_nc, 1, 0 ) >>, <<iif( lxContabilF_compr_nd, 1, 0 ) >>, <<iif( lxContabilF_compr_o1, 1, 0 ) >>, <<iif( lxContabilF_compr_o2, 1, 0 ) >>, <<iif( lxContabilF_compr_o3, 1, 0 ) >>, <<iif( lxContabilF_compr_o4, 1, 0 ) >> )
		endtext
		loColeccion.cTabla = 'CONTABIL' 
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
			local  lxContabilFecexpo, lxContabilFectrans, lxContabilFecimpo, lxContabilFaltafw, lxContabilFmodifw, lxContabilBdmodifw, lxContabilBdaltafw, lxContabilHoraexpo, lxContabilEsttrans, lxContabilHaltafw, lxContabilHoraimpo, lxContabilUmodifw, lxContabilVmodifw, lxContabilUaltafw, lxContabilZadsfw, lxContabilValtafw, lxContabilHmodifw, lxContabilSaltafw, lxContabilSmodifw, lxContabilEobs, lxContabilEjercicio, lxContabilNumero, lxContabilRangoasie, lxContabilF_vtasloc, lxContabilF_factman, lxContabilF_vtasexp, lxContabilF_ndman, lxContabilDescrip, lxContabilRsocial, lxContabilBasesproc, lxContabilFecha, lxContabilFechades, lxContabilF_recibos, lxContabilF_ncman, lxContabilFechahas, lxContabilF_compras, lxContabilF_factfis, lxContabilSucursal, lxContabilF_ndfis, lxContabilF_pagos, lxContabilBase, lxContabilF_otrospag, lxContabilF_ncfis, lxContabilF_caja, lxContabilF_factele, lxContabilF_ndele, lxContabilF_canjes, lxContabilF_ncele, lxContabilF_desccheq, lxContabilF_liqtarj, lxContabilF_transf, lxContabilF_ccclient, lxContabilF_ccproved, lxContabilF_concilia, lxContabilF_cmv, lxContabilF_compr_fc, lxContabilF_compr_nc, lxContabilF_compr_nd, lxContabilF_compr_o1, lxContabilF_compr_o2, lxContabilF_compr_o3, lxContabilF_compr_o4
				lxContabilFecexpo =  .Fechaexpo			lxContabilFectrans =  .Fechatransferencia			lxContabilFecimpo =  .Fechaimpo			lxContabilFaltafw =  .Fechaaltafw			lxContabilFmodifw =  .Fechamodificacionfw			lxContabilBdmodifw =  .Basededatosmodificacionfw			lxContabilBdaltafw =  .Basededatosaltafw			lxContabilHoraexpo =  .Horaexpo			lxContabilEsttrans =  .Estadotransferencia			lxContabilHaltafw =  .Horaaltafw			lxContabilHoraimpo =  .Horaimpo			lxContabilUmodifw =  .Usuariomodificacionfw			lxContabilVmodifw =  .Versionmodificacionfw			lxContabilUaltafw =  .Usuarioaltafw			lxContabilZadsfw =  .Zadsfw			lxContabilValtafw =  .Versionaltafw			lxContabilHmodifw =  .Horamodificacionfw			lxContabilSaltafw =  .Seriealtafw			lxContabilSmodifw =  .Seriemodificacionfw			lxContabilEobs =  .Observacion			lxContabilEjercicio =  .Ejercicio_PK 			lxContabilNumero =  .Numero			lxContabilRangoasie =  .Rangodeasientosgenerados			lxContabilF_vtasloc =  .Contabilizaventaslocales			lxContabilF_factman =  .Contabilizafacturamanual			lxContabilF_vtasexp =  .Contabilizaventasexportacion			lxContabilF_ndman =  .Contabilizanotadebitomanual			lxContabilDescrip =  .Descripcion			lxContabilRsocial =  upper( .RazonSocial_PK ) 			lxContabilBasesproc =  .Bdprocesadas			lxContabilFecha =  .Fecha			lxContabilFechades =  .Fechadesde			lxContabilF_recibos =  .Contabilizarecibos			lxContabilF_ncman =  .Contabilizanotacreditomanual			lxContabilFechahas =  .Fechahasta			lxContabilF_compras =  .Contabilizacompras			lxContabilF_factfis =  .Contabilizafacturafiscal			lxContabilSucursal =  upper( .Sucursal_PK ) 			lxContabilF_ndfis =  .Contabilizanotadebitofiscal			lxContabilF_pagos =  .Contabilizapagos			lxContabilBase =  .Basededatos			lxContabilF_otrospag =  .Contabilizaotrospagos			lxContabilF_ncfis =  .Contabilizanotacreditofiscal			lxContabilF_caja =  .Contabilizacaja			lxContabilF_factele =  .Contabilizafacturaelectronica			lxContabilF_ndele =  .Contabilizanotadebitoelectronica			lxContabilF_canjes =  .Contabilizacanjes			lxContabilF_ncele =  .Contabilizanotacreditoelectronica			lxContabilF_desccheq =  .Contabilizadescargas			lxContabilF_liqtarj =  .Contabilizaliqtarjetas			lxContabilF_transf =  .Contabilizatransferencias			lxContabilF_ccclient =  .Contabilizaajustecccliente			lxContabilF_ccproved =  .Contabilizaajusteccproveedor			lxContabilF_concilia =  .Contabilizachequesconciliados			lxContabilF_cmv =  .Contabilizacostomercaderiavendida			lxContabilF_compr_fc =  .Contabilizafacturadecompra			lxContabilF_compr_nc =  .Contabilizanotacreditodecompra			lxContabilF_compr_nd =  .Contabilizanotadebitodecompra			lxContabilF_compr_o1 =  .Contabilizadespachoimportaccompra			lxContabilF_compr_o2 =  .Contabilizaliquidacionescompra			lxContabilF_compr_o3 =  .Contabilizaliqservpublcompra			lxContabilF_compr_o4 =  .Contabilizareciboscompra
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.NUMERO
			lcValorClavePrimariaString = transform( this.oEntidad.NUMERO )

			lcFiltro = ["Numero" = ] + lcValorClavePrimariaString  + [ and  CONTABIL.NUMERO != 0]
			text to lcSentencia noshow textmerge
				update ZooLogic.CONTABIL set "Fecexpo" = <<"'" + this.ConvertirDateSql( lxContabilFecexpo ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxContabilFectrans ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxContabilFecimpo ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxContabilFaltafw ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxContabilFmodifw ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxContabilBdmodifw ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxContabilBdaltafw ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxContabilHoraexpo ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxContabilEsttrans ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxContabilHaltafw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxContabilHoraimpo ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxContabilUmodifw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxContabilVmodifw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxContabilUaltafw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxContabilZadsfw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxContabilValtafw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxContabilHmodifw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxContabilSaltafw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxContabilSmodifw ) + "'">>, "Eobs" = <<"'" + this.FormatearTextoSql( lxContabilEobs ) + "'">>, "Ejercicio" = <<lxContabilEjercicio>>, "Numero" = <<lxContabilNumero>>, "Rangoasie" = <<"'" + this.FormatearTextoSql( lxContabilRangoasie ) + "'">>, "F_vtasloc" = <<iif( lxContabilF_vtasloc, 1, 0 )>>, "F_factman" = <<iif( lxContabilF_factman, 1, 0 )>>, "F_vtasexp" = <<iif( lxContabilF_vtasexp, 1, 0 )>>, "F_ndman" = <<iif( lxContabilF_ndman, 1, 0 )>>, "Descrip" = <<"'" + this.FormatearTextoSql( lxContabilDescrip ) + "'">>, "Rsocial" = <<"'" + this.FormatearTextoSql( lxContabilRsocial ) + "'">>, "Basesproc" = <<"'" + this.FormatearTextoSql( lxContabilBasesproc ) + "'">>, "Fecha" = <<"'" + this.ConvertirDateSql( lxContabilFecha ) + "'">>, "Fechades" = <<"'" + this.ConvertirDateSql( lxContabilFechades ) + "'">>, "F_recibos" = <<iif( lxContabilF_recibos, 1, 0 )>>, "F_ncman" = <<iif( lxContabilF_ncman, 1, 0 )>>, "Fechahas" = <<"'" + this.ConvertirDateSql( lxContabilFechahas ) + "'">>, "F_compras" = <<iif( lxContabilF_compras, 1, 0 )>>, "F_factfis" = <<iif( lxContabilF_factfis, 1, 0 )>>, "Sucursal" = <<"'" + this.FormatearTextoSql( lxContabilSucursal ) + "'">>, "F_ndfis" = <<iif( lxContabilF_ndfis, 1, 0 )>>, "F_pagos" = <<iif( lxContabilF_pagos, 1, 0 )>>, "Base" = <<"'" + this.FormatearTextoSql( lxContabilBase ) + "'">>, "F_otrospag" = <<iif( lxContabilF_otrospag, 1, 0 )>>, "F_ncfis" = <<iif( lxContabilF_ncfis, 1, 0 )>>, "F_caja" = <<iif( lxContabilF_caja, 1, 0 )>>, "F_factele" = <<iif( lxContabilF_factele, 1, 0 )>>, "F_ndele" = <<iif( lxContabilF_ndele, 1, 0 )>>, "F_canjes" = <<iif( lxContabilF_canjes, 1, 0 )>>, "F_ncele" = <<iif( lxContabilF_ncele, 1, 0 )>>, "F_desccheq" = <<iif( lxContabilF_desccheq, 1, 0 )>>, "F_liqtarj" = <<iif( lxContabilF_liqtarj, 1, 0 )>>, "F_transf" = <<iif( lxContabilF_transf, 1, 0 )>>, "F_ccclient" = <<iif( lxContabilF_ccclient, 1, 0 )>>, "F_ccproved" = <<iif( lxContabilF_ccproved, 1, 0 )>>, "F_concilia" = <<iif( lxContabilF_concilia, 1, 0 )>>, "F_cmv" = <<iif( lxContabilF_cmv, 1, 0 )>>, "F_compr_fc" = <<iif( lxContabilF_compr_fc, 1, 0 )>>, "F_compr_nc" = <<iif( lxContabilF_compr_nc, 1, 0 )>>, "F_compr_nd" = <<iif( lxContabilF_compr_nd, 1, 0 )>>, "F_compr_o1" = <<iif( lxContabilF_compr_o1, 1, 0 )>>, "F_compr_o2" = <<iif( lxContabilF_compr_o2, 1, 0 )>>, "F_compr_o3" = <<iif( lxContabilF_compr_o3, 1, 0 )>>, "F_compr_o4" = <<iif( lxContabilF_compr_o4, 1, 0 )>> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'CONTABIL' 
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

			lcFiltro = ["Numero" = ] + lcValorClavePrimariaString  + [ and  CONTABIL.NUMERO != 0]
		loColeccion.Agregar( 'delete from ZooLogic.CONTABIL where ' + lcFiltro )
			loColeccion.cTabla = 'CONTABIL' 
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
		
			.oCompAsientos.lNuevo = .EsNuevo()
			.oCompAsientos.lEdicion = .EsEdicion()
			.oCompAsientos.lEliminar = .lEliminar
			.oCompAsientos.lAnular = .lAnular
			loColSentencias = .oCompAsientos.grabar()
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
			lcRetorno = [update ZooLogic.CONTABIL set TimeStamp = ] + transform( lnTimeStamp ) + lcUpdateRealTime + [ where NUMERO = ] + transform( .Numero ) + [ and  CONTABIL.NUMERO != 0] + goServicios.RealTime.ObtenerTagEstimulo( .cNombre )
		
		endwith
		return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function ObtenerCantidadRegistros() as integer
		local lnCantReg as integer
			local lcXml as string
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.CONTABIL where  CONTABIL.NUMERO != 0" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.CONTABIL where NUMERO = " + transform( this.oEntidad.NUMERO )+ " and  CONTABIL.NUMERO != 0" )
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
		lcCursor = This.oEntidad.cPrefijoRecibir + 'CONTABILIZACION'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.CONTABIL Where NUMERO = ] + transform( &lcCursor..NUMERO ), 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				if This.ActualizaEnRecepcion() 
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					this.oConexion.EjecutarSql( [UPDATE ZooLogic.CONTABIL set  FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, EOBS = ] + "'" + this.FormatearTextoSql( &lcCursor..EOBS ) + "'"+ [, EJERCICIO = ] + transform( &lcCursor..EJERCICIO )+ [, NUMERO = ] + transform( &lcCursor..NUMERO )+ [, RANGOASIE = ] + "'" + this.FormatearTextoSql( &lcCursor..RANGOASIE ) + "'"+ [, F_VTASLOC = ] + Transform( iif( &lcCursor..F_VTASLOC, 1, 0 ))+ [, F_FACTMAN = ] + Transform( iif( &lcCursor..F_FACTMAN, 1, 0 ))+ [, F_VTASEXP = ] + Transform( iif( &lcCursor..F_VTASEXP, 1, 0 ))+ [, F_NDMAN = ] + Transform( iif( &lcCursor..F_NDMAN, 1, 0 ))+ [, DESCRIP = ] + "'" + this.FormatearTextoSql( &lcCursor..DESCRIP ) + "'"+ [, RSOCIAL = ] + "'" + this.FormatearTextoSql( &lcCursor..RSOCIAL ) + "'"+ [, BASESPROC = ] + "'" + this.FormatearTextoSql( &lcCursor..BASESPROC ) + "'"+ [, FECHA = ] + "'" + this.ConvertirDateSql( &lcCursor..FECHA ) + "'"+ [, FECHADES = ] + "'" + this.ConvertirDateSql( &lcCursor..FECHADES ) + "'"+ [, F_RECIBOS = ] + Transform( iif( &lcCursor..F_RECIBOS, 1, 0 ))+ [, F_NCMAN = ] + Transform( iif( &lcCursor..F_NCMAN, 1, 0 ))+ [, FECHAHAS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECHAHAS ) + "'"+ [, F_COMPRAS = ] + Transform( iif( &lcCursor..F_COMPRAS, 1, 0 ))+ [, F_FACTFIS = ] + Transform( iif( &lcCursor..F_FACTFIS, 1, 0 ))+ [, SUCURSAL = ] + "'" + this.FormatearTextoSql( &lcCursor..SUCURSAL ) + "'"+ [, F_NDFIS = ] + Transform( iif( &lcCursor..F_NDFIS, 1, 0 ))+ [, F_PAGOS = ] + Transform( iif( &lcCursor..F_PAGOS, 1, 0 ))+ [, BASE = ] + "'" + this.FormatearTextoSql( &lcCursor..BASE ) + "'"+ [, F_OTROSPAG = ] + Transform( iif( &lcCursor..F_OTROSPAG, 1, 0 ))+ [, F_NCFIS = ] + Transform( iif( &lcCursor..F_NCFIS, 1, 0 ))+ [, F_CAJA = ] + Transform( iif( &lcCursor..F_CAJA, 1, 0 ))+ [, F_FACTELE = ] + Transform( iif( &lcCursor..F_FACTELE, 1, 0 ))+ [, F_NDELE = ] + Transform( iif( &lcCursor..F_NDELE, 1, 0 ))+ [, F_CANJES = ] + Transform( iif( &lcCursor..F_CANJES, 1, 0 ))+ [, F_NCELE = ] + Transform( iif( &lcCursor..F_NCELE, 1, 0 ))+ [, F_DESCCHEQ = ] + Transform( iif( &lcCursor..F_DESCCHEQ, 1, 0 ))+ [, F_LIQTARJ = ] + Transform( iif( &lcCursor..F_LIQTARJ, 1, 0 ))+ [, F_TRANSF = ] + Transform( iif( &lcCursor..F_TRANSF, 1, 0 ))+ [, F_CCCLIENT = ] + Transform( iif( &lcCursor..F_CCCLIENT, 1, 0 ))+ [, F_CCPROVED = ] + Transform( iif( &lcCursor..F_CCPROVED, 1, 0 ))+ [, F_CONCILIA = ] + Transform( iif( &lcCursor..F_CONCILIA, 1, 0 ))+ [, F_CMV = ] + Transform( iif( &lcCursor..F_CMV, 1, 0 ))+ [, F_COMPR_FC = ] + Transform( iif( &lcCursor..F_COMPR_FC, 1, 0 ))+ [, F_COMPR_NC = ] + Transform( iif( &lcCursor..F_COMPR_NC, 1, 0 ))+ [, F_COMPR_ND = ] + Transform( iif( &lcCursor..F_COMPR_ND, 1, 0 ))+ [, F_COMPR_O1 = ] + Transform( iif( &lcCursor..F_COMPR_O1, 1, 0 ))+ [, F_COMPR_O2 = ] + Transform( iif( &lcCursor..F_COMPR_O2, 1, 0 ))+ [, F_COMPR_O3 = ] + Transform( iif( &lcCursor..F_COMPR_O3, 1, 0 ))+ [, F_COMPR_O4 = ] + Transform( iif( &lcCursor..F_COMPR_O4, 1, 0 )) + [ Where NUMERO = ] + transform( &lcCursor..NUMERO ) )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
				endIf
			else
				Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
				Text to lcCampos noShow
					 FECEXPO, FECTRANS, FECIMPO, FALTAFW, FMODIFW, BDMODIFW, BDALTAFW, HORAEXPO, ESTTRANS, HALTAFW, HORAIMPO, UMODIFW, VMODIFW, UALTAFW, ZADSFW, VALTAFW, HMODIFW, SALTAFW, SMODIFW, EOBS, EJERCICIO, NUMERO, RANGOASIE, F_VTASLOC, F_FACTMAN, F_VTASEXP, F_NDMAN, DESCRIP, RSOCIAL, BASESPROC, FECHA, FECHADES, F_RECIBOS, F_NCMAN, FECHAHAS, F_COMPRAS, F_FACTFIS, SUCURSAL, F_NDFIS, F_PAGOS, BASE, F_OTROSPAG, F_NCFIS, F_CAJA, F_FACTELE, F_NDELE, F_CANJES, F_NCELE, F_DESCCHEQ, F_LIQTARJ, F_TRANSF, F_CCCLIENT, F_CCPROVED, F_CONCILIA, F_CMV, F_COMPR_FC, F_COMPR_NC, F_COMPR_ND, F_COMPR_O1, F_COMPR_O2, F_COMPR_O3, F_COMPR_O4
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..EOBS ) + "'" + ',' + transform( &lcCursor..EJERCICIO )
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..NUMERO ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..RANGOASIE ) + "'" + ',' + Transform( iif( &lcCursor..F_VTASLOC, 1, 0 )) + ',' + Transform( iif( &lcCursor..F_FACTMAN, 1, 0 )) + ',' + Transform( iif( &lcCursor..F_VTASEXP, 1, 0 )) + ',' + Transform( iif( &lcCursor..F_NDMAN, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..DESCRIP ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..RSOCIAL ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..BASESPROC ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECHA ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECHADES ) + "'" + ',' + Transform( iif( &lcCursor..F_RECIBOS, 1, 0 )) + ',' + Transform( iif( &lcCursor..F_NCMAN, 1, 0 )) + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECHAHAS ) + "'" + ',' + Transform( iif( &lcCursor..F_COMPRAS, 1, 0 ))
lcValoresCampos = lcValoresCampos  + ',' + Transform( iif( &lcCursor..F_FACTFIS, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..SUCURSAL ) + "'" + ',' + Transform( iif( &lcCursor..F_NDFIS, 1, 0 )) + ',' + Transform( iif( &lcCursor..F_PAGOS, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..BASE ) + "'" + ',' + Transform( iif( &lcCursor..F_OTROSPAG, 1, 0 )) + ',' + Transform( iif( &lcCursor..F_NCFIS, 1, 0 )) + ',' + Transform( iif( &lcCursor..F_CAJA, 1, 0 ))
lcValoresCampos = lcValoresCampos  + ',' + Transform( iif( &lcCursor..F_FACTELE, 1, 0 )) + ',' + Transform( iif( &lcCursor..F_NDELE, 1, 0 )) + ',' + Transform( iif( &lcCursor..F_CANJES, 1, 0 )) + ',' + Transform( iif( &lcCursor..F_NCELE, 1, 0 )) + ',' + Transform( iif( &lcCursor..F_DESCCHEQ, 1, 0 )) + ',' + Transform( iif( &lcCursor..F_LIQTARJ, 1, 0 )) + ',' + Transform( iif( &lcCursor..F_TRANSF, 1, 0 )) + ',' + Transform( iif( &lcCursor..F_CCCLIENT, 1, 0 ))
lcValoresCampos = lcValoresCampos  + ',' + Transform( iif( &lcCursor..F_CCPROVED, 1, 0 )) + ',' + Transform( iif( &lcCursor..F_CONCILIA, 1, 0 )) + ',' + Transform( iif( &lcCursor..F_CMV, 1, 0 )) + ',' + Transform( iif( &lcCursor..F_COMPR_FC, 1, 0 )) + ',' + Transform( iif( &lcCursor..F_COMPR_NC, 1, 0 )) + ',' + Transform( iif( &lcCursor..F_COMPR_ND, 1, 0 )) + ',' + Transform( iif( &lcCursor..F_COMPR_O1, 1, 0 )) + ',' + Transform( iif( &lcCursor..F_COMPR_O2, 1, 0 ))
lcValoresCampos = lcValoresCampos  + ',' + Transform( iif( &lcCursor..F_COMPR_O3, 1, 0 )) + ',' + Transform( iif( &lcCursor..F_COMPR_O4, 1, 0 ))
lcValoresCampos = substr(lcValoresCampos,2) 

				this.oConexion.EjecutarSql( [Insert into ZooLogic.CONTABIL ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
				this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'CONTABILIZACION'
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
			Case  lcAlias == lcPrefijo + 'CONTABILIZACION'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'CONTABILIZACION_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'CONTABILIZACION_EOBS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'CONTABILIZACION_BASESPROC'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_CONTABIL')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'CONTABILIZACION'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..NUMERO
		llCondicion = isnull( lxVar )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad CONTABILIZACION. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'CONTABILIZACION'
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
			lcCursor = This.oEntidad.cPrefijoRecibir + 'CONTABILIZACION'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FECHA     
		* Validar ANTERIORES A 1/1/1753  FECHADES  
		* Validar ANTERIORES A 1/1/1753  FECHAHAS  
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_CONTABIL') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_CONTABIL
Create Table ZooLogic.TablaTrabajo_CONTABIL ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fecexpo" datetime  null, 
"fectrans" datetime  null, 
"fecimpo" datetime  null, 
"faltafw" datetime  null, 
"fmodifw" datetime  null, 
"bdmodifw" char( 8 )  null, 
"bdaltafw" char( 8 )  null, 
"horaexpo" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"haltafw" char( 8 )  null, 
"horaimpo" char( 8 )  null, 
"umodifw" char( 100 )  null, 
"vmodifw" char( 13 )  null, 
"ualtafw" char( 100 )  null, 
"zadsfw" varchar(max)  null, 
"valtafw" char( 13 )  null, 
"hmodifw" char( 8 )  null, 
"saltafw" char( 7 )  null, 
"smodifw" char( 7 )  null, 
"eobs" varchar(max)  null, 
"ejercicio" numeric( 8, 0 )  null, 
"numero" numeric( 8, 0 )  null, 
"rangoasie" char( 20 )  null, 
"f_vtasloc" bit  null, 
"f_factman" bit  null, 
"f_vtasexp" bit  null, 
"f_ndman" bit  null, 
"descrip" char( 50 )  null, 
"rsocial" char( 10 )  null, 
"basesproc" varchar(max)  null, 
"fecha" datetime  null, 
"fechades" datetime  null, 
"f_recibos" bit  null, 
"f_ncman" bit  null, 
"fechahas" datetime  null, 
"f_compras" bit  null, 
"f_factfis" bit  null, 
"sucursal" char( 10 )  null, 
"f_ndfis" bit  null, 
"f_pagos" bit  null, 
"base" char( 21 )  null, 
"f_otrospag" bit  null, 
"f_ncfis" bit  null, 
"f_caja" bit  null, 
"f_factele" bit  null, 
"f_ndele" bit  null, 
"f_canjes" bit  null, 
"f_ncele" bit  null, 
"f_desccheq" bit  null, 
"f_liqtarj" bit  null, 
"f_transf" bit  null, 
"f_ccclient" bit  null, 
"f_ccproved" bit  null, 
"f_concilia" bit  null, 
"f_cmv" bit  null, 
"f_compr_fc" bit  null, 
"f_compr_nc" bit  null, 
"f_compr_nd" bit  null, 
"f_compr_o1" bit  null, 
"f_compr_o2" bit  null, 
"f_compr_o3" bit  null, 
"f_compr_o4" bit  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_CONTABIL' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_CONTABIL' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'CONTABILIZACION'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		with loManejador
			if this.oEntidad.VerificarContexto( 'CB' )
			else
				.AgregarMapeo('Nrolinea','Nrolinea')
			endif
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('eobs','eobs')
			.AgregarMapeo('ejercicio','ejercicio')
			.AgregarMapeo('numero','numero')
			.AgregarMapeo('rangoasie','rangoasie')
			.AgregarMapeo('f_vtasloc','f_vtasloc')
			.AgregarMapeo('f_factman','f_factman')
			.AgregarMapeo('f_vtasexp','f_vtasexp')
			.AgregarMapeo('f_ndman','f_ndman')
			.AgregarMapeo('descrip','descrip')
			.AgregarMapeo('rsocial','rsocial')
			.AgregarMapeo('basesproc','basesproc')
			.AgregarMapeo('fecha','fecha')
			.AgregarMapeo('fechades','fechades')
			.AgregarMapeo('f_recibos','f_recibos')
			.AgregarMapeo('f_ncman','f_ncman')
			.AgregarMapeo('fechahas','fechahas')
			.AgregarMapeo('f_compras','f_compras')
			.AgregarMapeo('f_factfis','f_factfis')
			.AgregarMapeo('sucursal','sucursal')
			.AgregarMapeo('f_ndfis','f_ndfis')
			.AgregarMapeo('f_pagos','f_pagos')
			.AgregarMapeo('base','base')
			.AgregarMapeo('f_otrospag','f_otrospag')
			.AgregarMapeo('f_ncfis','f_ncfis')
			.AgregarMapeo('f_caja','f_caja')
			.AgregarMapeo('f_factele','f_factele')
			.AgregarMapeo('f_ndele','f_ndele')
			.AgregarMapeo('f_canjes','f_canjes')
			.AgregarMapeo('f_ncele','f_ncele')
			.AgregarMapeo('f_desccheq','f_desccheq')
			.AgregarMapeo('f_liqtarj','f_liqtarj')
			.AgregarMapeo('f_transf','f_transf')
			.AgregarMapeo('f_ccclient','f_ccclient')
			.AgregarMapeo('f_ccproved','f_ccproved')
			.AgregarMapeo('f_concilia','f_concilia')
			.AgregarMapeo('f_cmv','f_cmv')
			.AgregarMapeo('f_compr_fc','f_compr_fc')
			.AgregarMapeo('f_compr_nc','f_compr_nc')
			.AgregarMapeo('f_compr_nd','f_compr_nd')
			.AgregarMapeo('f_compr_o1','f_compr_o1')
			.AgregarMapeo('f_compr_o2','f_compr_o2')
			.AgregarMapeo('f_compr_o3','f_compr_o3')
			.AgregarMapeo('f_compr_o4','f_compr_o4')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_CONTABIL'
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
				Update t Set t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.EOBS = isnull( d.EOBS, t.EOBS ),t.EJERCICIO = isnull( d.EJERCICIO, t.EJERCICIO ),t.NUMERO = isnull( d.NUMERO, t.NUMERO ),t.RANGOASIE = isnull( d.RANGOASIE, t.RANGOASIE ),t.F_VTASLOC = isnull( d.F_VTASLOC, t.F_VTASLOC ),t.F_FACTMAN = isnull( d.F_FACTMAN, t.F_FACTMAN ),t.F_VTASEXP = isnull( d.F_VTASEXP, t.F_VTASEXP ),t.F_NDMAN = isnull( d.F_NDMAN, t.F_NDMAN ),t.DESCRIP = isnull( d.DESCRIP, t.DESCRIP ),t.RSOCIAL = isnull( d.RSOCIAL, t.RSOCIAL ),t.BASESPROC = isnull( d.BASESPROC, t.BASESPROC ),t.FECHA = isnull( d.FECHA, t.FECHA ),t.FECHADES = isnull( d.FECHADES, t.FECHADES ),t.F_RECIBOS = isnull( d.F_RECIBOS, t.F_RECIBOS ),t.F_NCMAN = isnull( d.F_NCMAN, t.F_NCMAN ),t.FECHAHAS = isnull( d.FECHAHAS, t.FECHAHAS ),t.F_COMPRAS = isnull( d.F_COMPRAS, t.F_COMPRAS ),t.F_FACTFIS = isnull( d.F_FACTFIS, t.F_FACTFIS ),t.SUCURSAL = isnull( d.SUCURSAL, t.SUCURSAL ),t.F_NDFIS = isnull( d.F_NDFIS, t.F_NDFIS ),t.F_PAGOS = isnull( d.F_PAGOS, t.F_PAGOS ),t.BASE = isnull( d.BASE, t.BASE ),t.F_OTROSPAG = isnull( d.F_OTROSPAG, t.F_OTROSPAG ),t.F_NCFIS = isnull( d.F_NCFIS, t.F_NCFIS ),t.F_CAJA = isnull( d.F_CAJA, t.F_CAJA ),t.F_FACTELE = isnull( d.F_FACTELE, t.F_FACTELE ),t.F_NDELE = isnull( d.F_NDELE, t.F_NDELE ),t.F_CANJES = isnull( d.F_CANJES, t.F_CANJES ),t.F_NCELE = isnull( d.F_NCELE, t.F_NCELE ),t.F_DESCCHEQ = isnull( d.F_DESCCHEQ, t.F_DESCCHEQ ),t.F_LIQTARJ = isnull( d.F_LIQTARJ, t.F_LIQTARJ ),t.F_TRANSF = isnull( d.F_TRANSF, t.F_TRANSF ),t.F_CCCLIENT = isnull( d.F_CCCLIENT, t.F_CCCLIENT ),t.F_CCPROVED = isnull( d.F_CCPROVED, t.F_CCPROVED ),t.F_CONCILIA = isnull( d.F_CONCILIA, t.F_CONCILIA ),t.F_CMV = isnull( d.F_CMV, t.F_CMV ),t.F_COMPR_FC = isnull( d.F_COMPR_FC, t.F_COMPR_FC ),t.F_COMPR_NC = isnull( d.F_COMPR_NC, t.F_COMPR_NC ),t.F_COMPR_ND = isnull( d.F_COMPR_ND, t.F_COMPR_ND ),t.F_COMPR_O1 = isnull( d.F_COMPR_O1, t.F_COMPR_O1 ),t.F_COMPR_O2 = isnull( d.F_COMPR_O2, t.F_COMPR_O2 ),t.F_COMPR_O3 = isnull( d.F_COMPR_O3, t.F_COMPR_O3 ),t.F_COMPR_O4 = isnull( d.F_COMPR_O4, t.F_COMPR_O4 )
					from ZooLogic.CONTABIL t inner join deleted d 
							 on t.NUMERO = d.NUMERO
				-- Fin Updates
				insert into ZooLogic.CONTABIL(Fecexpo,Fectrans,Fecimpo,Faltafw,Fmodifw,Bdmodifw,Bdaltafw,Horaexpo,Esttrans,Haltafw,Horaimpo,Umodifw,Vmodifw,Ualtafw,Zadsfw,Valtafw,Hmodifw,Saltafw,Smodifw,Eobs,Ejercicio,Numero,Rangoasie,F_vtasloc,F_factman,F_vtasexp,F_ndman,Descrip,Rsocial,Basesproc,Fecha,Fechades,F_recibos,F_ncman,Fechahas,F_compras,F_factfis,Sucursal,F_ndfis,F_pagos,Base,F_otrospag,F_ncfis,F_caja,F_factele,F_ndele,F_canjes,F_ncele,F_desccheq,F_liqtarj,F_transf,F_ccclient,F_ccproved,F_concilia,F_cmv,F_compr_fc,F_compr_nc,F_compr_nd,F_compr_o1,F_compr_o2,F_compr_o3,F_compr_o4)
					Select isnull( d.FECEXPO,''),isnull( d.FECTRANS,''),isnull( d.FECIMPO,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FMODIFW,''),isnull( d.BDMODIFW,''),isnull( d.BDALTAFW,''),isnull( d.HORAEXPO,''),isnull( d.ESTTRANS,''),convert( char(8), getdate(), 108 ),isnull( d.HORAIMPO,''),isnull( d.UMODIFW,''),isnull( d.VMODIFW,''),isnull( d.UALTAFW,''),isnull( d.ZADSFW,''),isnull( d.VALTAFW,''),isnull( d.HMODIFW,''),isnull( d.SALTAFW,''),isnull( d.SMODIFW,''),isnull( d.EOBS,''),isnull( d.EJERCICIO,0),isnull( d.NUMERO,0),isnull( d.RANGOASIE,''),isnull( d.F_VTASLOC,0),isnull( d.F_FACTMAN,0),isnull( d.F_VTASEXP,0),isnull( d.F_NDMAN,0),isnull( d.DESCRIP,''),isnull( d.RSOCIAL,''),isnull( d.BASESPROC,''),isnull( d.FECHA,''),isnull( d.FECHADES,''),isnull( d.F_RECIBOS,0),isnull( d.F_NCMAN,0),isnull( d.FECHAHAS,''),isnull( d.F_COMPRAS,0),isnull( d.F_FACTFIS,0),isnull( d.SUCURSAL,''),isnull( d.F_NDFIS,0),isnull( d.F_PAGOS,0),isnull( d.BASE,''),isnull( d.F_OTROSPAG,0),isnull( d.F_NCFIS,0),isnull( d.F_CAJA,0),isnull( d.F_FACTELE,0),isnull( d.F_NDELE,0),isnull( d.F_CANJES,0),isnull( d.F_NCELE,0),isnull( d.F_DESCCHEQ,0),isnull( d.F_LIQTARJ,0),isnull( d.F_TRANSF,0),isnull( d.F_CCCLIENT,0),isnull( d.F_CCPROVED,0),isnull( d.F_CONCILIA,0),isnull( d.F_CMV,0),isnull( d.F_COMPR_FC,0),isnull( d.F_COMPR_NC,0),isnull( d.F_COMPR_ND,0),isnull( d.F_COMPR_O1,0),isnull( d.F_COMPR_O2,0),isnull( d.F_COMPR_O3,0),isnull( d.F_COMPR_O4,0)
						From deleted d left join ZooLogic.CONTABIL pk 
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_CONTABIL') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_CONTABIL
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_CONTABILIZACION' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_CONTABILIZACION.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_CONTABILIZACION.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_CONTABILIZACION.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_CONTABILIZACION.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_CONTABILIZACION.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Basededatosmodificacionfw = nvl( c_CONTABILIZACION.Basededatosmodificacionfw, [] )
					.Basededatosaltafw = nvl( c_CONTABILIZACION.Basededatosaltafw, [] )
					.Horaexpo = nvl( c_CONTABILIZACION.Horaexpo, [] )
					.Estadotransferencia = nvl( c_CONTABILIZACION.Estadotransferencia, [] )
					.Horaaltafw = nvl( c_CONTABILIZACION.Horaaltafw, [] )
					.Horaimpo = nvl( c_CONTABILIZACION.Horaimpo, [] )
					.Usuariomodificacionfw = nvl( c_CONTABILIZACION.Usuariomodificacionfw, [] )
					.Versionmodificacionfw = nvl( c_CONTABILIZACION.Versionmodificacionfw, [] )
					.Usuarioaltafw = nvl( c_CONTABILIZACION.Usuarioaltafw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Versionaltafw = nvl( c_CONTABILIZACION.Versionaltafw, [] )
					.Horamodificacionfw = nvl( c_CONTABILIZACION.Horamodificacionfw, [] )
					.Seriealtafw = nvl( c_CONTABILIZACION.Seriealtafw, [] )
					.Seriemodificacionfw = nvl( c_CONTABILIZACION.Seriemodificacionfw, [] )
					lcValor = This.ObtenerMemo( 'c_Observacion')
					.Observacion = lcValor 
					.Ejercicio_PK =  nvl( c_CONTABILIZACION.Ejercicio, 0 )
					.Numero = nvl( c_CONTABILIZACION.Numero, 0 )
					.Rangodeasientosgenerados = nvl( c_CONTABILIZACION.Rangodeasientosgenerados, [] )
					.Contabilizaventaslocales = nvl( c_CONTABILIZACION.Contabilizaventaslocales, .F. )
					.Contabilizafacturamanual = nvl( c_CONTABILIZACION.Contabilizafacturamanual, .F. )
					.Contabilizaventasexportacion = nvl( c_CONTABILIZACION.Contabilizaventasexportacion, .F. )
					.Contabilizanotadebitomanual = nvl( c_CONTABILIZACION.Contabilizanotadebitomanual, .F. )
					.Descripcion = nvl( c_CONTABILIZACION.Descripcion, [] )
					.Razonsocial_PK =  nvl( c_CONTABILIZACION.Razonsocial, [] )
					lcValor = This.ObtenerMemo( 'c_Bdprocesadas')
					.Bdprocesadas = lcValor 
					.Fecha = GoLibrerias.ObtenerFechaFormateada( nvl( c_CONTABILIZACION.Fecha, ctod( '  /  /    ' ) ) )
					.Fechadesde = GoLibrerias.ObtenerFechaFormateada( nvl( c_CONTABILIZACION.Fechadesde, ctod( '  /  /    ' ) ) )
					.Contabilizarecibos = nvl( c_CONTABILIZACION.Contabilizarecibos, .F. )
					.Contabilizanotacreditomanual = nvl( c_CONTABILIZACION.Contabilizanotacreditomanual, .F. )
					.Fechahasta = GoLibrerias.ObtenerFechaFormateada( nvl( c_CONTABILIZACION.Fechahasta, ctod( '  /  /    ' ) ) )
					.Contabilizacompras = nvl( c_CONTABILIZACION.Contabilizacompras, .F. )
					.Contabilizafacturafiscal = nvl( c_CONTABILIZACION.Contabilizafacturafiscal, .F. )
					.Sucursal_PK =  nvl( c_CONTABILIZACION.Sucursal, [] )
					.Contabilizanotadebitofiscal = nvl( c_CONTABILIZACION.Contabilizanotadebitofiscal, .F. )
					.Contabilizapagos = nvl( c_CONTABILIZACION.Contabilizapagos, .F. )
					.Basededatos = nvl( c_CONTABILIZACION.Basededatos, [] )
					.Contabilizaotrospagos = nvl( c_CONTABILIZACION.Contabilizaotrospagos, .F. )
					.Contabilizanotacreditofiscal = nvl( c_CONTABILIZACION.Contabilizanotacreditofiscal, .F. )
					.Contabilizacaja = nvl( c_CONTABILIZACION.Contabilizacaja, .F. )
					.Contabilizafacturaelectronica = nvl( c_CONTABILIZACION.Contabilizafacturaelectronica, .F. )
					.Contabilizanotadebitoelectronica = nvl( c_CONTABILIZACION.Contabilizanotadebitoelectronica, .F. )
					.Contabilizacanjes = nvl( c_CONTABILIZACION.Contabilizacanjes, .F. )
					.Contabilizanotacreditoelectronica = nvl( c_CONTABILIZACION.Contabilizanotacreditoelectronica, .F. )
					.Contabilizadescargas = nvl( c_CONTABILIZACION.Contabilizadescargas, .F. )
					.Contabilizaliqtarjetas = nvl( c_CONTABILIZACION.Contabilizaliqtarjetas, .F. )
					.Contabilizatransferencias = nvl( c_CONTABILIZACION.Contabilizatransferencias, .F. )
					.Contabilizaajustecccliente = nvl( c_CONTABILIZACION.Contabilizaajustecccliente, .F. )
					.Contabilizaajusteccproveedor = nvl( c_CONTABILIZACION.Contabilizaajusteccproveedor, .F. )
					.Contabilizachequesconciliados = nvl( c_CONTABILIZACION.Contabilizachequesconciliados, .F. )
					.Contabilizacostomercaderiavendida = nvl( c_CONTABILIZACION.Contabilizacostomercaderiavendida, .F. )
					.Contabilizafacturadecompra = nvl( c_CONTABILIZACION.Contabilizafacturadecompra, .F. )
					.Contabilizanotacreditodecompra = nvl( c_CONTABILIZACION.Contabilizanotacreditodecompra, .F. )
					.Contabilizanotadebitodecompra = nvl( c_CONTABILIZACION.Contabilizanotadebitodecompra, .F. )
					.Contabilizadespachoimportaccompra = nvl( c_CONTABILIZACION.Contabilizadespachoimportaccompra, .F. )
					.Contabilizaliquidacionescompra = nvl( c_CONTABILIZACION.Contabilizaliquidacionescompra, .F. )
					.Contabilizaliqservpublcompra = nvl( c_CONTABILIZACION.Contabilizaliqservpublcompra, .F. )
					.Contabilizareciboscompra = nvl( c_CONTABILIZACION.Contabilizareciboscompra, .F. )
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
		return c_CONTABILIZACION.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.CONTABIL' )
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
								from ZooLogic.CONTABIL 
								Where   CONTABIL.NUMERO != 0
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "CONTABIL", "", lcCursor, set("Datasession") )
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
			"Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Horaexpo" as "Horaexpo", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Ualtafw" as "Usuarioaltafw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Eobs" as "Observacion", "Ejercicio" as "Ejercicio", "Numero" as "Numero", "Rangoasie" as "Rangodeasientosgenerados", "F_vtasloc" as "Contabilizaventaslocales", "F_factman" as "Contabilizafacturamanual", "F_vtasexp" as "Contabilizaventasexportacion", "F_ndman" as "Contabilizanotadebitomanual", "Descrip" as "Descripcion", "Rsocial" as "Razonsocial", "Basesproc" as "Bdprocesadas", "Fecha" as "Fecha", "Fechades" as "Fechadesde", "F_recibos" as "Contabilizarecibos", "F_ncman" as "Contabilizanotacreditomanual", "Fechahas" as "Fechahasta", "F_compras" as "Contabilizacompras", "F_factfis" as "Contabilizafacturafiscal", "Sucursal" as "Sucursal", "F_ndfis" as "Contabilizanotadebitofiscal", "F_pagos" as "Contabilizapagos", "Base" as "Basededatos", "F_otrospag" as "Contabilizaotrospagos", "F_ncfis" as "Contabilizanotacreditofiscal", "F_caja" as "Contabilizacaja", "F_factele" as "Contabilizafacturaelectronica", "F_ndele" as "Contabilizanotadebitoelectronica", "F_canjes" as "Contabilizacanjes", "F_ncele" as "Contabilizanotacreditoelectronica", "F_desccheq" as "Contabilizadescargas", "F_liqtarj" as "Contabilizaliqtarjetas", "F_transf" as "Contabilizatransferencias", "F_ccclient" as "Contabilizaajustecccliente", "F_ccproved" as "Contabilizaajusteccproveedor", "F_concilia" as "Contabilizachequesconciliados", "F_cmv" as "Contabilizacostomercaderiavendida", "F_compr_fc" as "Contabilizafacturadecompra", "F_compr_nc" as "Contabilizanotacreditodecompra", "F_compr_nd" as "Contabilizanotadebitodecompra", "F_compr_o1" as "Contabilizadespachoimportaccompra", "F_compr_o2" as "Contabilizaliquidacionescompra", "F_compr_o3" as "Contabilizaliqservpublcompra", "F_compr_o4" as "Contabilizareciboscompra"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.CONTABIL 
								Where   CONTABIL.NUMERO != 0
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
	Tabla = 'CONTABIL'
	Filtro = " CONTABIL.NUMERO != 0"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " CONTABIL.NUMERO != 0"
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
	<row entidad="CONTABILIZACION                         " atributo="FECHAEXPO                               " tabla="CONTABIL       " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONTABILIZACION                         " atributo="FECHATRANSFERENCIA                      " tabla="CONTABIL       " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha de novedad                                                                                                                                                " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONTABILIZACION                         " atributo="FECHAIMPO                               " tabla="CONTABIL       " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONTABILIZACION                         " atributo="FECHAALTAFW                             " tabla="CONTABIL       " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONTABILIZACION                         " atributo="FECHAMODIFICACIONFW                     " tabla="CONTABIL       " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONTABILIZACION                         " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="CONTABIL       " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONTABILIZACION                         " atributo="BASEDEDATOSALTAFW                       " tabla="CONTABIL       " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONTABILIZACION                         " atributo="HORAEXPO                                " tabla="CONTABIL       " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONTABILIZACION                         " atributo="ESTADOTRANSFERENCIA                     " tabla="CONTABIL       " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado de novedad                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONTABILIZACION                         " atributo="HORAALTAFW                              " tabla="CONTABIL       " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONTABILIZACION                         " atributo="HORAIMPO                                " tabla="CONTABIL       " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONTABILIZACION                         " atributo="USUARIOMODIFICACIONFW                   " tabla="CONTABIL       " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONTABILIZACION                         " atributo="VERSIONMODIFICACIONFW                   " tabla="CONTABIL       " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONTABILIZACION                         " atributo="USUARIOALTAFW                           " tabla="CONTABIL       " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONTABILIZACION                         " atributo="ZADSFW                                  " tabla="CONTABIL       " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONTABILIZACION                         " atributo="VERSIONALTAFW                           " tabla="CONTABIL       " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONTABILIZACION                         " atributo="HORAMODIFICACIONFW                      " tabla="CONTABIL       " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONTABILIZACION                         " atributo="SERIEALTAFW                             " tabla="CONTABIL       " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONTABILIZACION                         " atributo="SERIEMODIFICACIONFW                     " tabla="CONTABIL       " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONTABILIZACION                         " atributo="OBSERVACION                             " tabla="CONTABIL       " campo="EOBS      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="Observaciones                                                                                                                                                   " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="4" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONTABILIZACION                         " atributo="EJERCICIO                               " tabla="CONTABIL       " campo="EJERCICIO " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="EJERCICIO                               " tipodato="N         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="402" etiqueta="Ejercicio                                                                                                                                                       " dominio="CODIGONUMERICO                " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONTABILIZACION                         " atributo="NUMERO                                  " tabla="CONTABIL       " campo="NUMERO    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="8" etiqueta="Número                                                                                                                                                          " dominio="CODIGONUMERICO                " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONTABILIZACION                         " atributo="RANGODEASIENTOSGENERADOS                " tabla="CONTABIL       " campo="RANGOASIE " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="404" etiqueta="Rango de asientos generados                                                                                                                                     " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="6" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONTABILIZACION                         " atributo="CONTABILIZAVENTASLOCALES                " tabla="CONTABIL       " campo="F_VTASLOC " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="406" etiqueta="Ventas locales                                                                                                                                                  " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="5" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONTABILIZACION                         " atributo="CONTABILIZAFACTURAMANUAL                " tabla="CONTABIL       " campo="F_FACTMAN " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="408" etiqueta="Factura manual                                                                                                                                                  " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="10" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONTABILIZACION                         " atributo="CONTABILIZAVENTASEXPORTACION            " tabla="CONTABIL       " campo="F_VTASEXP " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="410" etiqueta="Ventas exportación                                                                                                                                              " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="5" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONTABILIZACION                         " atributo="CONTABILIZANOTADEBITOMANUAL             " tabla="CONTABIL       " campo="F_NDMAN   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="412" etiqueta="Nota de débito manual                                                                                                                                           " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="10" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONTABILIZACION                         " atributo="DESCRIPCION                             " tabla="CONTABIL       " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="4" etiqueta="Descripción                                                                                                                                                     " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONTABILIZACION                         " atributo="RAZONSOCIAL                             " tabla="CONTABIL       " campo="RSOCIAL   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="RAZONSOCIAL                             " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="4" etiqueta="Razón social                                                                                                                                                    " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONTABILIZACION                         " atributo="BDPROCESADAS                            " tabla="CONTABIL       " campo="BASESPROC " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="414" etiqueta="Bases de datos procesadas                                                                                                                                       " dominio="TEXTO1R                       " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="6" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONTABILIZACION                         " atributo="FECHA                                   " tabla="CONTABIL       " campo="FECHA     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goServicios.librerias.ObtenerFecha()                                                                                                                                                                                                                         " obligatorio="true" admitebusqueda="416" etiqueta="Fecha                                                                                                                                                           " dominio="FECHACALENDARIO               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONTABILIZACION                         " atributo="FECHADESDE                              " tabla="CONTABIL       " campo="FECHADES  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="418" etiqueta="Fecha desde                                                                                                                                                     " dominio="FECHACALENDARIO               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONTABILIZACION                         " atributo="CONTABILIZARECIBOS                      " tabla="CONTABIL       " campo="F_RECIBOS " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="420" etiqueta="Recibos                                                                                                                                                         " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="5" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONTABILIZACION                         " atributo="CONTABILIZANOTACREDITOMANUAL            " tabla="CONTABIL       " campo="F_NCMAN   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="422" etiqueta="Nota de crédito manual                                                                                                                                          " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="10" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONTABILIZACION                         " atributo="FECHAHASTA                              " tabla="CONTABIL       " campo="FECHAHAS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="424" etiqueta="Fecha hasta                                                                                                                                                     " dominio="FECHACALENDARIO               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONTABILIZACION                         " atributo="CONTABILIZACOMPRAS                      " tabla="CONTABIL       " campo="F_COMPRAS " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="426" etiqueta="Compras                                                                                                                                                         " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="5" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONTABILIZACION                         " atributo="CONTABILIZAFACTURAFISCAL                " tabla="CONTABIL       " campo="F_FACTFIS " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="428" etiqueta="Factura fiscal                                                                                                                                                  " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="10" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONTABILIZACION                         " atributo="SUCURSAL                                " tabla="CONTABIL       " campo="SUCURSAL  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="SUCURSAL                                " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="4" etiqueta="Sucursal                                                                                                                                                        " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="3" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONTABILIZACION                         " atributo="CONTABILIZANOTADEBITOFISCAL             " tabla="CONTABIL       " campo="F_NDFIS   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="430" etiqueta="Nota de débito fiscal                                                                                                                                           " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="10" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONTABILIZACION                         " atributo="CONTABILIZAPAGOS                        " tabla="CONTABIL       " campo="F_PAGOS   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="432" etiqueta="Pagos                                                                                                                                                           " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="5" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONTABILIZACION                         " atributo="BASEDEDATOS                             " tabla="CONTABIL       " campo="BASE      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="21" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="434" etiqueta="Base                                                                                                                                                            " dominio="COMBOSUCYAGRUCONVACIO         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="3" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONTABILIZACION                         " atributo="CONTABILIZAOTROSPAGOS                   " tabla="CONTABIL       " campo="F_OTROSPAG" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="436" etiqueta="Otros pagos                                                                                                                                                     " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="5" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONTABILIZACION                         " atributo="CONTABILIZANOTACREDITOFISCAL            " tabla="CONTABIL       " campo="F_NCFIS   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="438" etiqueta="Nota de crédito fiscal                                                                                                                                          " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="10" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONTABILIZACION                         " atributo="CONTABILIZACAJA                         " tabla="CONTABIL       " campo="F_CAJA    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="440" etiqueta="Comprobantes de caja                                                                                                                                            " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="5" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONTABILIZACION                         " atributo="CONTABILIZAFACTURAELECTRONICA           " tabla="CONTABIL       " campo="F_FACTELE " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="442" etiqueta="Factura electrónica                                                                                                                                             " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="10" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONTABILIZACION                         " atributo="CONTABILIZANOTADEBITOELECTRONICA        " tabla="CONTABIL       " campo="F_NDELE   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="444" etiqueta="Nota de débito electrónica                                                                                                                                      " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="10" orden="8" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONTABILIZACION                         " atributo="CONTABILIZACANJES                       " tabla="CONTABIL       " campo="F_CANJES  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="446" etiqueta="Canjes de valores                                                                                                                                               " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="5" orden="8" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONTABILIZACION                         " atributo="CONTABILIZANOTACREDITOELECTRONICA       " tabla="CONTABIL       " campo="F_NCELE   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="448" etiqueta="Nota de crédito electrónica                                                                                                                                     " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="10" orden="9" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONTABILIZACION                         " atributo="CONTABILIZADESCARGAS                    " tabla="CONTABIL       " campo="F_DESCCHEQ" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="450" etiqueta="Descarga de cheques                                                                                                                                             " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="5" orden="9" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONTABILIZACION                         " atributo="CONTABILIZALIQTARJETAS                  " tabla="CONTABIL       " campo="F_LIQTARJ " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="452" etiqueta="Liquidaciones de tarjetas                                                                                                                                       " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="5" orden="10" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONTABILIZACION                         " atributo="CONTABILIZATRANSFERENCIAS               " tabla="CONTABIL       " campo="F_TRANSF  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="454" etiqueta="Transferencias entre cuentas bancarias                                                                                                                          " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="5" orden="11" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONTABILIZACION                         " atributo="CONTABILIZAAJUSTECCCLIENTE              " tabla="CONTABIL       " campo="F_CCCLIENT" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="456" etiqueta="Ajustes de cc clientes                                                                                                                                          " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="5" orden="12" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONTABILIZACION                         " atributo="CONTABILIZAAJUSTECCPROVEEDOR            " tabla="CONTABIL       " campo="F_CCPROVED" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="458" etiqueta="Ajustes de cc proveedores                                                                                                                                       " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="5" orden="13" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONTABILIZACION                         " atributo="CONTABILIZACHEQUESCONCILIADOS           " tabla="CONTABIL       " campo="F_CONCILIA" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="460" etiqueta="Cheques conciliados                                                                                                                                             " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="5" orden="14" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONTABILIZACION                         " atributo="CONTABILIZACOSTOMERCADERIAVENDIDA       " tabla="CONTABIL       " campo="F_CMV     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="462" etiqueta="Costo mercadería vendida                                                                                                                                        " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="5" orden="17" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONTABILIZACION                         " atributo="CONTABILIZAFACTURADECOMPRA              " tabla="CONTABIL       " campo="F_COMPR_FC" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="464" etiqueta="Factura de compra                                                                                                                                               " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="11" orden="21" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONTABILIZACION                         " atributo="CONTABILIZANOTACREDITODECOMPRA          " tabla="CONTABIL       " campo="F_COMPR_NC" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="466" etiqueta="Nota de crédito de compra                                                                                                                                       " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="11" orden="22" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONTABILIZACION                         " atributo="CONTABILIZANOTADEBITODECOMPRA           " tabla="CONTABIL       " campo="F_COMPR_ND" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="468" etiqueta="Nota de débito de compra                                                                                                                                        " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="11" orden="23" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONTABILIZACION                         " atributo="CONTABILIZADESPACHOIMPORTACCOMPRA       " tabla="CONTABIL       " campo="F_COMPR_O1" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="470" etiqueta="Despachos importación                                                                                                                                           " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="11" orden="24" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONTABILIZACION                         " atributo="CONTABILIZALIQUIDACIONESCOMPRA          " tabla="CONTABIL       " campo="F_COMPR_O2" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="472" etiqueta="Liquidaciones (compras)                                                                                                                                         " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="11" orden="25" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONTABILIZACION                         " atributo="CONTABILIZALIQSERVPUBLCOMPRA            " tabla="CONTABIL       " campo="F_COMPR_O3" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="474" etiqueta="Liquidaciones serv. públicos                                                                                                                                    " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="11" orden="26" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONTABILIZACION                         " atributo="CONTABILIZARECIBOSCOMPRA                " tabla="CONTABIL       " campo="F_COMPR_O4" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="476" etiqueta="Recibos (compras)                                                                                                                                               " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="11" orden="27" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="EJERCICIO                               " atributo="DESCRIPCION                             " tabla="EJERCICIO      " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="403" etiqueta="Detalle Eje.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join EJERCICIO On CONTABIL.EJERCICIO = EJERCICIO.NUMERO And  EJERCICIO.NUMERO != 0                                                                                                                                                                      " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="RAZONSOCIAL                             " atributo="DESCRIPCION                             " tabla="RAZONS         " campo="RZDES     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="5" etiqueta="Detalle Raz.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join RAZONS On CONTABIL.RSOCIAL = RAZONS.RZCOD And  RAZONS.RZCOD != ''                                                                                                                                                                                  " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSAL                                " atributo="DESCRIPCION                             " tabla="SUC            " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="5" etiqueta="Detalle Suc.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join SUC On CONTABIL.SUCURSAL = SUC.codigo And  SUC.CODIGO != ''                                                                                                                                                                                        " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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