
define class Din_EntidadSTOCKINVENTARIOAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_STOCKINVENTARIO'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = [Insumo + Color + Talle + Partida + Inventario]
	cExpresionCCPorCampos = [#tabla#.COART + #tabla#.COCOL + #tabla#.Talle + #tabla#.NroPartida + #tabla#.Invent]
	cTagClaveCandidata = '_013CC'
	cTagClavePk = '_013PK'
	cTablaPrincipal = 'STOCKINV'
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
			local  lxStockinvFecexpo, lxStockinvFectrans, lxStockinvFmodifw, lxStockinvFaltafw, lxStockinvFecimpo, lxStockinvHaltafw, lxStockinvHoraexpo, lxStockinvHmodifw, lxStockinvHoraimpo, lxStockinvSmodifw, lxStockinvSaltafw, lxStockinvUmodifw, lxStockinvVmodifw, lxStockinvValtafw, lxStockinvNropartida, lxStockinvInvent, lxStockinvDescfw, lxStockinvBdmodifw, lxStockinvBdaltafw, lxStockinvZadsfw, lxStockinvEsttrans, lxStockinvUaltafw, lxStockinvCocod, lxStockinvTalle, lxStockinvCocol, lxStockinvCoart, lxStockinvCocant, lxStockinvCorig
				lxStockinvFecexpo =  .Fechaexpo			lxStockinvFectrans =  .Fechatransferencia			lxStockinvFmodifw =  .Fechamodificacionfw			lxStockinvFaltafw =  .Fechaaltafw			lxStockinvFecimpo =  .Fechaimpo			lxStockinvHaltafw =  .Horaaltafw			lxStockinvHoraexpo =  .Horaexpo			lxStockinvHmodifw =  .Horamodificacionfw			lxStockinvHoraimpo =  .Horaimpo			lxStockinvSmodifw =  .Seriemodificacionfw			lxStockinvSaltafw =  .Seriealtafw			lxStockinvUmodifw =  .Usuariomodificacionfw			lxStockinvVmodifw =  .Versionmodificacionfw			lxStockinvValtafw =  .Versionaltafw			lxStockinvNropartida =  .Partida			lxStockinvInvent =  upper( .Inventario_PK ) 			lxStockinvDescfw =  .Descripcionfw			lxStockinvBdmodifw =  .Basededatosmodificacionfw			lxStockinvBdaltafw =  .Basededatosaltafw			lxStockinvZadsfw =  .Zadsfw			lxStockinvEsttrans =  .Estadotransferencia			lxStockinvUaltafw =  .Usuarioaltafw			lxStockinvCocod =  .Codigo			lxStockinvTalle =  upper( .Talle_PK ) 			lxStockinvCocol =  upper( .Color_PK ) 			lxStockinvCoart =  upper( .Insumo_PK ) 			lxStockinvCocant =  .Cantidad			lxStockinvCorig =  .Cantidadoriginal
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxStockinvCocod = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.STOCKINV ( "Fecexpo","Fectrans","Fmodifw","Faltafw","Fecimpo","Haltafw","Horaexpo","Hmodifw","Horaimpo","Smodifw","Saltafw","Umodifw","Vmodifw","Valtafw","Nropartida","Invent","Descfw","Bdmodifw","Bdaltafw","Zadsfw","Esttrans","Ualtafw","Cocod","Talle","Cocol","Coart","Cocant","Corig" ) values ( <<"'" + this.ConvertirDateSql( lxStockinvFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxStockinvFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxStockinvFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxStockinvFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxStockinvFecimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxStockinvHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxStockinvHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxStockinvHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxStockinvHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxStockinvSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxStockinvSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxStockinvUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxStockinvVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxStockinvValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxStockinvNropartida ) + "'" >>, <<"'" + this.FormatearTextoSql( lxStockinvInvent ) + "'" >>, <<"'" + this.FormatearTextoSql( lxStockinvDescfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxStockinvBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxStockinvBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxStockinvZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxStockinvEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxStockinvUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxStockinvCocod ) + "'" >>, <<"'" + this.FormatearTextoSql( lxStockinvTalle ) + "'" >>, <<"'" + this.FormatearTextoSql( lxStockinvCocol ) + "'" >>, <<"'" + this.FormatearTextoSql( lxStockinvCoart ) + "'" >>, <<lxStockinvCocant >>, <<lxStockinvCorig >> )
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
		this.ComprobarTransaccion()
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = lxValorClavePrimaria

			lcSentencia = this.ObtenerSentenciasInsertAuditoria()
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			If this.ConsultarPorClaveCandidata()
				lcError  = this.oEntidad.ObtenerMensajeClaveCandidataExistente()
			endif
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
			local  lxStockinvFecexpo, lxStockinvFectrans, lxStockinvFmodifw, lxStockinvFaltafw, lxStockinvFecimpo, lxStockinvHaltafw, lxStockinvHoraexpo, lxStockinvHmodifw, lxStockinvHoraimpo, lxStockinvSmodifw, lxStockinvSaltafw, lxStockinvUmodifw, lxStockinvVmodifw, lxStockinvValtafw, lxStockinvNropartida, lxStockinvInvent, lxStockinvDescfw, lxStockinvBdmodifw, lxStockinvBdaltafw, lxStockinvZadsfw, lxStockinvEsttrans, lxStockinvUaltafw, lxStockinvCocod, lxStockinvTalle, lxStockinvCocol, lxStockinvCoart, lxStockinvCocant, lxStockinvCorig
				lxStockinvFecexpo =  .Fechaexpo			lxStockinvFectrans =  .Fechatransferencia			lxStockinvFmodifw =  .Fechamodificacionfw			lxStockinvFaltafw =  .Fechaaltafw			lxStockinvFecimpo =  .Fechaimpo			lxStockinvHaltafw =  .Horaaltafw			lxStockinvHoraexpo =  .Horaexpo			lxStockinvHmodifw =  .Horamodificacionfw			lxStockinvHoraimpo =  .Horaimpo			lxStockinvSmodifw =  .Seriemodificacionfw			lxStockinvSaltafw =  .Seriealtafw			lxStockinvUmodifw =  .Usuariomodificacionfw			lxStockinvVmodifw =  .Versionmodificacionfw			lxStockinvValtafw =  .Versionaltafw			lxStockinvNropartida =  .Partida			lxStockinvInvent =  upper( .Inventario_PK ) 			lxStockinvDescfw =  .Descripcionfw			lxStockinvBdmodifw =  .Basededatosmodificacionfw			lxStockinvBdaltafw =  .Basededatosaltafw			lxStockinvZadsfw =  .Zadsfw			lxStockinvEsttrans =  .Estadotransferencia			lxStockinvUaltafw =  .Usuarioaltafw			lxStockinvCocod =  .Codigo			lxStockinvTalle =  upper( .Talle_PK ) 			lxStockinvCocol =  upper( .Color_PK ) 			lxStockinvCoart =  upper( .Insumo_PK ) 			lxStockinvCocant =  .Cantidad			lxStockinvCorig =  .Cantidadoriginal
		endwith
		
		with this
		Try
			local llInsertarAuditoria as Boolean
			llInsertarAuditoria = (  0 != .oEntidad.Cantidad )
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()
			lxValorClavePrimaria = .oEntidad.CODIGO
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ZooLogic.STOCKINV set "Fecexpo" = <<"'" + this.ConvertirDateSql( lxStockinvFecexpo ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxStockinvFectrans ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxStockinvFmodifw ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxStockinvFaltafw ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxStockinvFecimpo ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxStockinvHaltafw ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxStockinvHoraexpo ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxStockinvHmodifw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxStockinvHoraimpo ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxStockinvSmodifw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxStockinvSaltafw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxStockinvUmodifw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxStockinvVmodifw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxStockinvValtafw ) + "'">>,"Nropartida" = <<"'" + this.FormatearTextoSql( lxStockinvNropartida ) + "'">>,"Invent" = <<"'" + this.FormatearTextoSql( lxStockinvInvent ) + "'">>,"Descfw" = <<"'" + this.FormatearTextoSql( lxStockinvDescfw ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxStockinvBdmodifw ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxStockinvBdaltafw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxStockinvZadsfw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxStockinvEsttrans ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxStockinvUaltafw ) + "'">>,"Cocod" = <<"'" + this.FormatearTextoSql( lxStockinvCocod ) + "'">>,"Talle" = <<"'" + this.FormatearTextoSql( lxStockinvTalle ) + "'">>,"Cocol" = <<"'" + this.FormatearTextoSql( lxStockinvCocol ) + "'">>,"Coart" = <<"'" + this.FormatearTextoSql( lxStockinvCoart ) + "'">>,"Cocant" = "Cocant" + <<lxStockinvCocant>>,"Corig" = <<lxStockinvCorig>> where "Cocod" = <<"'" + this.FormatearTextoSql( lxStockinvCocod ) + "'">> and  STOCKINV.COCOD != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			this.ComprobarResultadoDeEjecucionDelUpdate()
		this.ComprobarTransaccion()
			If llInsertarAuditoria
				lcSentencia = this.ObtenerSentenciasInsertAuditoria()
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			EndIf
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 COCOD from ZooLogic.STOCKINV where " + this.ConvertirFuncionesSql( " STOCKINV.COCOD != ''" ) )
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
			Local lxStockinvCocod
			lxStockinvCocod = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Nropartida" as "Partida", "Invent" as "Inventario", "Descfw" as "Descripcionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Zadsfw" as "Zadsfw", "Esttrans" as "Estadotransferencia", "Ualtafw" as "Usuarioaltafw", "Cocod" as "Codigo", "Talle" as "Talle", "Cocol" as "Color", "Coart" as "Insumo", "Cocant" as "Cantidad", "Corig" as "Cantidadoriginal" from ZooLogic.STOCKINV where "Cocod" = <<"'" + this.FormatearTextoSql( lxStockinvCocod ) + "'">> and  STOCKINV.COCOD != ''
			endtext
			use in select('c_STOCKINVENTARIO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_STOCKINVENTARIO', set( 'Datasession' ) )

			if reccount( 'c_STOCKINVENTARIO' ) = 0
				llRetorno = .f.
			else
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ConsultarPorClaveCandidata() as Boolean
		local llRetorno as Boolean
		llRetorno = .t.
		with this.oEntidad
			Local lxSTOCKINVCOART As Variant, lxSTOCKINVCOCOL As Variant, lxSTOCKINVTalle As Variant, lxSTOCKINVNroPartida As Variant, lxSTOCKINVInvent As Variant
			lxSTOCKINVCOART = .Insumo_Pk
			lxSTOCKINVCOCOL = .Color_Pk
			lxSTOCKINVTalle = .Talle_Pk
			lxSTOCKINVNroPartida = .Partida
			lxSTOCKINVInvent = .Inventario_Pk
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Nropartida" as "Partida", "Invent" as "Inventario", "Descfw" as "Descripcionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Zadsfw" as "Zadsfw", "Esttrans" as "Estadotransferencia", "Ualtafw" as "Usuarioaltafw", "Cocod" as "Codigo", "Talle" as "Talle", "Cocol" as "Color", "Coart" as "Insumo", "Cocant" as "Cantidad", "Corig" as "Cantidadoriginal" from ZooLogic.STOCKINV where  STOCKINV.COCOD != '' And COART = <<"'" + this.FormatearTextoSql( lxSTOCKINVCOART ) + "'">> and COCOL = <<"'" + this.FormatearTextoSql( lxSTOCKINVCOCOL ) + "'">> and Talle = <<"'" + this.FormatearTextoSql( lxSTOCKINVTalle ) + "'">> and NroPartida = <<"'" + this.FormatearTextoSql( lxSTOCKINVNroPartida ) + "'">> and Invent = <<"'" + this.FormatearTextoSql( lxSTOCKINVInvent ) + "'">>
			endtext
			use in select('c_STOCKINVENTARIO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_STOCKINVENTARIO', set( 'Datasession' ) )
			if reccount( 'c_STOCKINVENTARIO' ) = 0
				llRetorno = .f.
			else
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxStockinvCocod as Variant
		llRetorno = .t.
		lxStockinvCocod = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.STOCKINV where "Cocod" = <<"'" + this.FormatearTextoSql( lxStockinvCocod ) + "'">> and  STOCKINV.COCOD != ''
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
				lcOrden =  .Insumo_PK + .Color_PK + .Talle_PK + .Partida + .Inventario_PK
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Nropartida" as "Partida", "Invent" as "Inventario", "Descfw" as "Descripcionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Zadsfw" as "Zadsfw", "Esttrans" as "Estadotransferencia", "Ualtafw" as "Usuarioaltafw", "Cocod" as "Codigo", "Talle" as "Talle", "Cocol" as "Color", "Coart" as "Insumo", "Cocant" as "Cantidad", "Corig" as "Cantidadoriginal" from ZooLogic.STOCKINV where  STOCKINV.COCOD != '' order by COART,COCOL,Talle,NroPartida,Invent
			endtext
			use in select('c_STOCKINVENTARIO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_STOCKINVENTARIO', set( 'Datasession' ) )
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
				lcOrden =  .Insumo_PK + .Color_PK + .Talle_PK + .Partida + .Inventario_PK
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Nropartida" as "Partida", "Invent" as "Inventario", "Descfw" as "Descripcionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Zadsfw" as "Zadsfw", "Esttrans" as "Estadotransferencia", "Ualtafw" as "Usuarioaltafw", "Cocod" as "Codigo", "Talle" as "Talle", "Cocol" as "Color", "Coart" as "Insumo", "Cocant" as "Cantidad", "Corig" as "Cantidadoriginal" from ZooLogic.STOCKINV where  funciones.padr( COART, 25, ' ' ) + funciones.padr( COCOL, 6, ' ' ) + funciones.padr( Talle, 5, ' ' ) + funciones.padr( NroPartida, 25, ' ' ) + funciones.padr( Invent, 15, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  STOCKINV.COCOD != '' order by COART,COCOL,Talle,NroPartida,Invent
			endtext
			use in select('c_STOCKINVENTARIO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_STOCKINVENTARIO', set( 'Datasession' ) )
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
				lcOrden =  .Insumo_PK + .Color_PK + .Talle_PK + .Partida + .Inventario_PK
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Nropartida" as "Partida", "Invent" as "Inventario", "Descfw" as "Descripcionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Zadsfw" as "Zadsfw", "Esttrans" as "Estadotransferencia", "Ualtafw" as "Usuarioaltafw", "Cocod" as "Codigo", "Talle" as "Talle", "Cocol" as "Color", "Coart" as "Insumo", "Cocant" as "Cantidad", "Corig" as "Cantidadoriginal" from ZooLogic.STOCKINV where  funciones.padr( COART, 25, ' ' ) + funciones.padr( COCOL, 6, ' ' ) + funciones.padr( Talle, 5, ' ' ) + funciones.padr( NroPartida, 25, ' ' ) + funciones.padr( Invent, 15, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  STOCKINV.COCOD != '' order by COART desc,COCOL desc,Talle desc,NroPartida desc,Invent desc
			endtext
			use in select('c_STOCKINVENTARIO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_STOCKINVENTARIO', set( 'Datasession' ) )
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
				lcOrden =  .Insumo_PK + .Color_PK + .Talle_PK + .Partida + .Inventario_PK
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Nropartida" as "Partida", "Invent" as "Inventario", "Descfw" as "Descripcionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Zadsfw" as "Zadsfw", "Esttrans" as "Estadotransferencia", "Ualtafw" as "Usuarioaltafw", "Cocod" as "Codigo", "Talle" as "Talle", "Cocol" as "Color", "Coart" as "Insumo", "Cocant" as "Cantidad", "Corig" as "Cantidadoriginal" from ZooLogic.STOCKINV where  STOCKINV.COCOD != '' order by COART desc,COCOL desc,Talle desc,NroPartida desc,Invent desc
			endtext
			use in select('c_STOCKINVENTARIO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_STOCKINVENTARIO', set( 'Datasession' ) )
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
			lcXml = this.oConexion.EjecutarSql( "select Fecexpo,Fectrans,Fmodifw,Faltafw,Fecimpo,Haltafw,Horaexpo,Hmodifw,Horaimpo,Smodifw,Saltafw,U" + ;
"modifw,Vmodifw,Valtafw,Nropartida,Invent,Descfw,Bdmodifw,Bdaltafw,Zadsfw,Esttrans,Ualtafw,Cocod,Tall" + ;
"e,Cocol,Coart,Cocant,Corig" + ;
" from ZooLogic.STOCKINV where  STOCKINV.COCOD != '' and " + lcFiltro )
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
			local  lxStockinvFecexpo, lxStockinvFectrans, lxStockinvFmodifw, lxStockinvFaltafw, lxStockinvFecimpo, lxStockinvHaltafw, lxStockinvHoraexpo, lxStockinvHmodifw, lxStockinvHoraimpo, lxStockinvSmodifw, lxStockinvSaltafw, lxStockinvUmodifw, lxStockinvVmodifw, lxStockinvValtafw, lxStockinvNropartida, lxStockinvInvent, lxStockinvDescfw, lxStockinvBdmodifw, lxStockinvBdaltafw, lxStockinvZadsfw, lxStockinvEsttrans, lxStockinvUaltafw, lxStockinvCocod, lxStockinvTalle, lxStockinvCocol, lxStockinvCoart, lxStockinvCocant, lxStockinvCorig
				lxStockinvFecexpo = ctod( '  /  /    ' )			lxStockinvFectrans = ctod( '  /  /    ' )			lxStockinvFmodifw = ctod( '  /  /    ' )			lxStockinvFaltafw = ctod( '  /  /    ' )			lxStockinvFecimpo = ctod( '  /  /    ' )			lxStockinvHaltafw = []			lxStockinvHoraexpo = []			lxStockinvHmodifw = []			lxStockinvHoraimpo = []			lxStockinvSmodifw = []			lxStockinvSaltafw = []			lxStockinvUmodifw = []			lxStockinvVmodifw = []			lxStockinvValtafw = []			lxStockinvNropartida = []			lxStockinvInvent = []			lxStockinvDescfw = []			lxStockinvBdmodifw = []			lxStockinvBdaltafw = []			lxStockinvZadsfw = []			lxStockinvEsttrans = []			lxStockinvUaltafw = []			lxStockinvCocod = []			lxStockinvTalle = []			lxStockinvCocol = []			lxStockinvCoart = []			lxStockinvCocant = 0			lxStockinvCorig = 0
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( [delete from ZooLogic.STOCKINV where "COCOD" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'STOCKINV' + '_' + tcCampo
			lcMemoAscii = ''

			lnIndice = alen(.aSqlMemos)
			lnIndice = iif(lnIndice = 1, 1, lnIndice + 1 )
			dimension .aSqlMemos(lnIndice)

			.aSqlMemos(lnIndice) = 'delete from ' + lcTabla + ' where COCOD = ' + txValorClavePrimaria
			.GenerarSentenciasInsertTablaMemo( lcValor, lcTabla, txValorClavePrimaria )
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerSentenciaInsertMemo( tcTabla as String, txValorClavePrimaria as String, tcOrden as String, tcTexto as String ) as String
		return "Insert  into " + tcTabla + "(COCOD, Orden, texto ) values ( " + txValorClavePrimaria + "," + tcOrden + ",'"+ tcTexto + "')"
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosEntidad( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  STOCKINV.COCOD != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Nropartida" as "Partida", "Invent" as "Inventario", "Descfw" as "Descripcionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Zadsfw" as "Zadsfw", "Esttrans" as "Estadotransferencia", "Ualtafw" as "Usuarioaltafw", "Cocod" as "Codigo", "Talle" as "Talle", "Cocol" as "Color", "Coart" as "Insumo", "Cocant" as "Cantidad", "Corig" as "Cantidadoriginal"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'STOCKINV', '', tnTope )
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
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'FECHAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECIMPO AS FECHAIMPO'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'PARTIDA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROPARTIDA AS PARTIDA'
				Case lcAtributo == 'INVENTARIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'INVENT AS INVENTARIO'
				Case lcAtributo == 'DESCRIPCIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCFW AS DESCRIPCIONFW'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COCOD AS CODIGO'
				Case lcAtributo == 'TALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TALLE AS TALLE'
				Case lcAtributo == 'COLOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COCOL AS COLOR'
				Case lcAtributo == 'INSUMO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COART AS INSUMO'
				Case lcAtributo == 'CANTIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COCANT AS CANTIDAD'
				Case lcAtributo == 'CANTIDADORIGINAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CORIG AS CANTIDADORIGINAL'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAIMPO'
				lcCampo = 'FECIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'PARTIDA'
				lcCampo = 'NROPARTIDA'
			Case upper( alltrim( tcAtributo ) ) == 'INVENTARIO'
				lcCampo = 'INVENT'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCIONFW'
				lcCampo = 'DESCFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'COCOD'
			Case upper( alltrim( tcAtributo ) ) == 'TALLE'
				lcCampo = 'TALLE'
			Case upper( alltrim( tcAtributo ) ) == 'COLOR'
				lcCampo = 'COCOL'
			Case upper( alltrim( tcAtributo ) ) == 'INSUMO'
				lcCampo = 'COART'
			Case upper( alltrim( tcAtributo ) ) == 'CANTIDAD'
				lcCampo = 'COCANT'
			Case upper( alltrim( tcAtributo ) ) == 'CANTIDADORIGINAL'
				lcCampo = 'CORIG'
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
			local  lxStockinvFecexpo, lxStockinvFectrans, lxStockinvFmodifw, lxStockinvFaltafw, lxStockinvFecimpo, lxStockinvHaltafw, lxStockinvHoraexpo, lxStockinvHmodifw, lxStockinvHoraimpo, lxStockinvSmodifw, lxStockinvSaltafw, lxStockinvUmodifw, lxStockinvVmodifw, lxStockinvValtafw, lxStockinvNropartida, lxStockinvInvent, lxStockinvDescfw, lxStockinvBdmodifw, lxStockinvBdaltafw, lxStockinvZadsfw, lxStockinvEsttrans, lxStockinvUaltafw, lxStockinvCocod, lxStockinvTalle, lxStockinvCocol, lxStockinvCoart, lxStockinvCocant, lxStockinvCorig
				lxStockinvFecexpo =  .Fechaexpo			lxStockinvFectrans =  .Fechatransferencia			lxStockinvFmodifw =  .Fechamodificacionfw			lxStockinvFaltafw =  .Fechaaltafw			lxStockinvFecimpo =  .Fechaimpo			lxStockinvHaltafw =  .Horaaltafw			lxStockinvHoraexpo =  .Horaexpo			lxStockinvHmodifw =  .Horamodificacionfw			lxStockinvHoraimpo =  .Horaimpo			lxStockinvSmodifw =  .Seriemodificacionfw			lxStockinvSaltafw =  .Seriealtafw			lxStockinvUmodifw =  .Usuariomodificacionfw			lxStockinvVmodifw =  .Versionmodificacionfw			lxStockinvValtafw =  .Versionaltafw			lxStockinvNropartida =  .Partida			lxStockinvInvent =  upper( .Inventario_PK ) 			lxStockinvDescfw =  .Descripcionfw			lxStockinvBdmodifw =  .Basededatosmodificacionfw			lxStockinvBdaltafw =  .Basededatosaltafw			lxStockinvZadsfw =  .Zadsfw			lxStockinvEsttrans =  .Estadotransferencia			lxStockinvUaltafw =  .Usuarioaltafw			lxStockinvCocod =  .Codigo			lxStockinvTalle =  upper( .Talle_PK ) 			lxStockinvCocol =  upper( .Color_PK ) 			lxStockinvCoart =  upper( .Insumo_PK ) 			lxStockinvCocant =  .Cantidad			lxStockinvCorig =  .Cantidadoriginal
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.STOCKINV ( "Fecexpo","Fectrans","Fmodifw","Faltafw","Fecimpo","Haltafw","Horaexpo","Hmodifw","Horaimpo","Smodifw","Saltafw","Umodifw","Vmodifw","Valtafw","Nropartida","Invent","Descfw","Bdmodifw","Bdaltafw","Zadsfw","Esttrans","Ualtafw","Cocod","Talle","Cocol","Coart","Cocant","Corig" ) values ( <<"'" + this.ConvertirDateSql( lxStockinvFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxStockinvFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxStockinvFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxStockinvFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxStockinvFecimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxStockinvHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxStockinvHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxStockinvHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxStockinvHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxStockinvSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxStockinvSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxStockinvUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxStockinvVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxStockinvValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxStockinvNropartida ) + "'" >>, <<"'" + this.FormatearTextoSql( lxStockinvInvent ) + "'" >>, <<"'" + this.FormatearTextoSql( lxStockinvDescfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxStockinvBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxStockinvBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxStockinvZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxStockinvEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxStockinvUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxStockinvCocod ) + "'" >>, <<"'" + this.FormatearTextoSql( lxStockinvTalle ) + "'" >>, <<"'" + this.FormatearTextoSql( lxStockinvCocol ) + "'" >>, <<"'" + this.FormatearTextoSql( lxStockinvCoart ) + "'" >>, <<lxStockinvCocant >>, <<lxStockinvCorig >> )
		endtext
		loColeccion.cTabla = 'STOCKINV' 
		loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		With this
			local lcValorClavePrimariaString as String
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcSentencia = this.ObtenerSentenciasInsertAuditoria()
			loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		EndWith
		return loColeccion
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasUpdate() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcFiltro as string, loItem as object, lcSentencia as string, lcSentencia as string
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxStockinvFecexpo, lxStockinvFectrans, lxStockinvFmodifw, lxStockinvFaltafw, lxStockinvFecimpo, lxStockinvHaltafw, lxStockinvHoraexpo, lxStockinvHmodifw, lxStockinvHoraimpo, lxStockinvSmodifw, lxStockinvSaltafw, lxStockinvUmodifw, lxStockinvVmodifw, lxStockinvValtafw, lxStockinvNropartida, lxStockinvInvent, lxStockinvDescfw, lxStockinvBdmodifw, lxStockinvBdaltafw, lxStockinvZadsfw, lxStockinvEsttrans, lxStockinvUaltafw, lxStockinvCocod, lxStockinvTalle, lxStockinvCocol, lxStockinvCoart, lxStockinvCocant, lxStockinvCorig
				lxStockinvFecexpo =  .Fechaexpo			lxStockinvFectrans =  .Fechatransferencia			lxStockinvFmodifw =  .Fechamodificacionfw			lxStockinvFaltafw =  .Fechaaltafw			lxStockinvFecimpo =  .Fechaimpo			lxStockinvHaltafw =  .Horaaltafw			lxStockinvHoraexpo =  .Horaexpo			lxStockinvHmodifw =  .Horamodificacionfw			lxStockinvHoraimpo =  .Horaimpo			lxStockinvSmodifw =  .Seriemodificacionfw			lxStockinvSaltafw =  .Seriealtafw			lxStockinvUmodifw =  .Usuariomodificacionfw			lxStockinvVmodifw =  .Versionmodificacionfw			lxStockinvValtafw =  .Versionaltafw			lxStockinvNropartida =  .Partida			lxStockinvInvent =  upper( .Inventario_PK ) 			lxStockinvDescfw =  .Descripcionfw			lxStockinvBdmodifw =  .Basededatosmodificacionfw			lxStockinvBdaltafw =  .Basededatosaltafw			lxStockinvZadsfw =  .Zadsfw			lxStockinvEsttrans =  .Estadotransferencia			lxStockinvUaltafw =  .Usuarioaltafw			lxStockinvCocod =  .Codigo			lxStockinvTalle =  upper( .Talle_PK ) 			lxStockinvCocol =  upper( .Color_PK ) 			lxStockinvCoart =  upper( .Insumo_PK ) 			lxStockinvCocant =  .Cantidad			lxStockinvCorig =  .Cantidadoriginal
		endwith
		With this
			local llInsertarAuditoria as Boolean
			llInsertarAuditoria = (  0 != .oEntidad.Cantidad )
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Cocod" = ] + lcValorClavePrimariaString  + [ and  STOCKINV.COCOD != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.STOCKINV set "Fecexpo" = <<"'" + this.ConvertirDateSql( lxStockinvFecexpo ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxStockinvFectrans ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxStockinvFmodifw ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxStockinvFaltafw ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxStockinvFecimpo ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxStockinvHaltafw ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxStockinvHoraexpo ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxStockinvHmodifw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxStockinvHoraimpo ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxStockinvSmodifw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxStockinvSaltafw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxStockinvUmodifw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxStockinvVmodifw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxStockinvValtafw ) + "'">>, "Nropartida" = <<"'" + this.FormatearTextoSql( lxStockinvNropartida ) + "'">>, "Invent" = <<"'" + this.FormatearTextoSql( lxStockinvInvent ) + "'">>, "Descfw" = <<"'" + this.FormatearTextoSql( lxStockinvDescfw ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxStockinvBdmodifw ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxStockinvBdaltafw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxStockinvZadsfw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxStockinvEsttrans ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxStockinvUaltafw ) + "'">>, "Cocod" = <<"'" + this.FormatearTextoSql( lxStockinvCocod ) + "'">>, "Talle" = <<"'" + this.FormatearTextoSql( lxStockinvTalle ) + "'">>, "Cocol" = <<"'" + this.FormatearTextoSql( lxStockinvCocol ) + "'">>, "Coart" = <<"'" + this.FormatearTextoSql( lxStockinvCoart ) + "'">>, "Cocant" = Cocant + ( <<lxStockinvCocant>> ), "Corig" = <<lxStockinvCorig>> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'STOCKINV' 
		loColeccion.agregar( strtran(  lcSentencia, chr( 9 ), '' ) )
		If llInsertarAuditoria
			lcSentencia = this.ObtenerSentenciasInsertAuditoria()
			loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		EndIf
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

			lcFiltro = ["Cocod" = ] + lcValorClavePrimariaString  + [ and  STOCKINV.COCOD != '']
		loColeccion.Agregar( 'delete from ZooLogic.STOCKINV where ' + lcFiltro )
			loColeccion.cTabla = 'STOCKINV' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.STOCKINV where  STOCKINV.COCOD != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.STOCKINV where COCOD = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  STOCKINV.COCOD != ''" )
			this.xmlacursor( lcXml, lcCursor )
		if reccount( lcCursor ) > 0
			lnTimeStamp = &lcCursor..Timestamp
		endif
		use in select( lcCursor )

		return lnTimeStamp 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirCabecera( tlLoguear as Boolean ) As Void
		local lcCursor as String, ldFecha as Date, lcHora as string, lcValorABuscar As String, lxValorClavePK As variant, lxValorClavePrimaria As variant, lcIdentificadorParaLoguear as string, lxSTOCKINVNroPartida as variant, lxSTOCKINVInvent as variant, lxSTOCKINVTalle as variant, lxSTOCKINVCOCOL as variant, lxSTOCKINVCOART as variant, lxSTOCKINVCOCANT as variant, lcMensajeExtra as String
		lcValorABuscar = ''
		lxValorClavePK = ''
		lcMensajeExtra = ''
		lcCursor = This.oEntidad.cPrefijoRecibir + 'STOCKINVENTARIO'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.STOCKINV Where  COART = ] + "'" + this.FormatearTextoSql( &lcCursor..COART      ) + "'" + [ and COCOL = ] + "'" + this.FormatearTextoSql( &lcCursor..COCOL      ) + "'" + [ and Talle = ] + "'" + this.FormatearTextoSql( &lcCursor..Talle      ) + "'" + [ and NroPartida = ] + "'" + this.FormatearTextoSql( &lcCursor..NroPartida ) + "'" + [ and Invent = ] + "'" + this.FormatearTextoSql( &lcCursor..Invent     ) + "'", 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				lxValorClavePK = &lcCursor..COCOD
				if lxValorClavePK == curSeek.COCOD or this.oEntidad.lIgnorarClaveprimariaEnRecepcionBD 
					if lxValorClavePK != curSeek.COCOD and this.oEntidad.lIgnorarClaveprimariaEnRecepcionBD 
						lcValorABuscar = curSeek.COCOD
					else 
						lcValorABuscar = lxValorClavePK 
					endif 
					if This.ActualizaEnRecepcion() 
						local llInsertarAuditoria as boolean
						llInsertarAuditoria = (  iif( isnull( 0 != &lcCursor..COCANT ), .F., 0 != &lcCursor..COCANT ) )
						Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
						this.oConexion.EjecutarSql( [UPDATE ZooLogic.STOCKINV set  FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, NroPartida = ] + "'" + this.FormatearTextoSql( &lcCursor..NroPartida ) + "'"+ [, Invent = ] + "'" + this.FormatearTextoSql( &lcCursor..Invent ) + "'"+ [, DescFW = ] + "'" + this.FormatearTextoSql( &lcCursor..DescFW ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, COCOD = ] + "'" + this.FormatearTextoSql( &lcCursor..COCOD ) + "'"+ [, Talle = ] + "'" + this.FormatearTextoSql( &lcCursor..Talle ) + "'"+ [, COCOL = ] + "'" + this.FormatearTextoSql( &lcCursor..COCOL ) + "'"+ [, COART = ] + "'" + this.FormatearTextoSql( &lcCursor..COART ) + "'"+ [, COCANT = ZooLogic.STOCKINV.COCANT + ] + transform( &lcCursor..COCANT )+ [, CORIG = ] + transform( &lcCursor..CORIG ) + [ Where COCOD = ] + "'" + this.FormatearTextoSql( lcValorABuscar ) + "'" )
						this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
						if llInsertarAuditoria
							lcSentencia = this.ObtenerSentenciasInsertAuditoria( lcCursor )
							this.oConexion.EjecutarSql( lcSentencia )
						EndIf
					else
						this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
					endIf
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir porque no coincide la clave principal.', tlLoguear )
				endIf
			else
				this.oConexion.EjecutarSql( [Select * From ZooLogic.STOCKINV Where COCOD = ] + "'" + this.FormatearTextoSql( &lcCursor..COCOD ) + "'", 'curSeek', this.datasessionid )
				if reccount( 'curSeek' ) > 0
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir como alta porque la clave principal ya existe', tlLoguear )
				Else
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					Text to lcCampos noShow
						 FECEXPO, FECTRANS, FMODIFW, FALTAFW, FECIMPO, HALTAFW, HORAEXPO, HMODIFW, HORAIMPO, SMODIFW, SALTAFW, UMODIFW, VMODIFW, VALTAFW, NroPartida, Invent, DescFW, BDMODIFW, BDALTAFW, ZADSFW, ESTTRANS, UALTAFW, COCOD, Talle, COCOL, COART, COCANT, CORIG
					EndText
					local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..NroPartida ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Invent ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..DescFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..COCOD ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Talle ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..COCOL ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..COART ) + "'" + ',' + transform( &lcCursor..COCANT ) + ',' + transform( &lcCursor..CORIG )
lcValoresCampos = substr(lcValoresCampos,2) 

					this.oConexion.EjecutarSql( [Insert into ZooLogic.STOCKINV ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
					lcSentencia = this.ObtenerSentenciasInsertAuditoria( lcCursor )
					this.oConexion.EjecutarSql( lcSentencia )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
				EndIf
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'STOCKINVENTARIO'
		if This.ActualizaEnRecepcion()
	endif
	Use in select( 'cExistentes' )
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearCursorMemo( tcCursorACrear as String, tcTablaConMemo as String ) as Void
		create cursor &tcCursorACrear ( COCOD C (38) , Orden N(16), texto C(80))
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirComponentes() As Void
		
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function ObtenerIdentificadorParaLoguear( tcCursor as String ) As String
		local lcRetorno as String, lnCC as String , loCC as Object, lni as Integer, lcSecuencia as String
		lcRetorno = this.oEntidad.cDescripcion 
		lcRetorno = lcRetorno + ' - Insumo: ' + transform( &tcCursor..COART      )
		lcRetorno = lcRetorno + ' - Color: ' + transform( &tcCursor..COCOL      )
		lcRetorno = lcRetorno + ' - Talle: ' + transform( &tcCursor..Talle      )
		lcRetorno = lcRetorno + ' - Número de partida: ' + transform( &tcCursor..NroPartida )
		lcRetorno = lcRetorno + ' - Inventario: ' + transform( &tcCursor..Invent     )
		Return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EsAliasDeProceso( tcAlias As String, tcPrefijo as string ) As Boolean
		local llRetorno as Boolean, lcAlias as String, lcPrefijo As String
		llRetorno = .F.
		lcAlias = upper( alltrim( tcAlias ) )
		lcPrefijo = upper( alltrim( tcPrefijo ) )
		Do Case
			Case  lcAlias == lcPrefijo + 'STOCKINVENTARIO'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'STOCKINVENTARIO_ZADSFW'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_STOCKINV')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'STOCKINVENTARIO'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..COCOD
		llCondicion = isnull( lxVar ) or isnull( &lcCursor..COART ) or isnull( &lcCursor..COCOL ) or isnull( &lcCursor..Talle ) or isnull( &lcCursor..NroPartida ) or isnull( &lcCursor..Invent )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad STOCKINVENTARIO. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'STOCKINVENTARIO'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		select recno() as _Rec, * from &lcCursor into cursor CurConRecno
		select max( _Rec ) as Maximo,COCOD as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( COCOD, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		select max( _Rec ) as Maximo,COART + COCOL + Talle + NroPartida + Invent as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( COART + COCOL + Talle + NroPartida + Invent, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		Use in select( 'CurConRecno' )
		Use in select( 'RepMax' )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDatosInvalidos( toConexion as Object ) as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'STOCKINVENTARIO'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_STOCKINV') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_STOCKINV
Create Table ZooLogic.TablaTrabajo_STOCKINV ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fecexpo" datetime  null, 
"fectrans" datetime  null, 
"fmodifw" datetime  null, 
"faltafw" datetime  null, 
"fecimpo" datetime  null, 
"haltafw" char( 8 )  null, 
"horaexpo" char( 8 )  null, 
"hmodifw" char( 8 )  null, 
"horaimpo" char( 8 )  null, 
"smodifw" char( 7 )  null, 
"saltafw" char( 7 )  null, 
"umodifw" char( 100 )  null, 
"vmodifw" char( 13 )  null, 
"valtafw" char( 13 )  null, 
"nropartida" char( 25 )  null, 
"invent" char( 15 )  null, 
"descfw" char( 200 )  null, 
"bdmodifw" char( 8 )  null, 
"bdaltafw" char( 8 )  null, 
"zadsfw" varchar(max)  null, 
"esttrans" char( 20 )  null, 
"ualtafw" char( 100 )  null, 
"cocod" char( 38 )  null, 
"talle" char( 5 )  null, 
"cocol" char( 6 )  null, 
"coart" char( 25 )  null, 
"cocant" numeric( 17, 6 )  null, 
"corig" numeric( 17, 6 )  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_STOCKINV' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_STOCKINV' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'STOCKINVENTARIO'
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
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('nropartida','nropartida')
			.AgregarMapeo('invent','invent')
			.AgregarMapeo('descfw','descfw')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('cocod','cocod')
			.AgregarMapeo('talle','talle')
			.AgregarMapeo('cocol','cocol')
			.AgregarMapeo('coart','coart')
			.AgregarMapeo('cocant','cocant')
			.AgregarMapeo('corig','corig')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_STOCKINV'
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
				insert into ZooLogic.ADT_STOCKINV ( "ADT_Cod","ADT_Fecha","ADT_Hora","ADT_Serie","ADT_Usr","ADT_Ent","ADT_Comp","ADT_ADN","ADT_Vers","ADT_Ext","NroPartida","Invent","COCOD","Talle","COCOL","COART","Cocant" ) 
					Select <<lcCabecera1>>, <<lcCabecera2>>, <<lcCabecera3>>, <<lcCabecera4>>, <<lcCabecera5>>, <<lcCabecera6>>, case when funciones.empty( d.DescFw ) = 1 then 'IMPORTACION' else d.descFw end, <<lcCabecera7>>, <<lcCabecera8>>, <<lcCabecera9>>, d.Nropartida,d.Invent,d.Cocod,d.Talle,d.Cocol,d.Coart,Isnull( d.Cocant,t.Cocant)
						from ZooLogic.STOCKINV t inner join deleted d 
							 on t.COCOD = d.COCOD
							 and  t.COART = d.COART
							 and  t.COCOL = d.COCOL
							 and  t.Talle = d.Talle
							 and  t.NroPartida = d.NroPartida
							 and  t.Invent = d.Invent
					where ( d.COCANT is not null and d.COCANT <> t.COCANT )
				Update t Set t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.NROPARTIDA = isnull( d.NROPARTIDA, t.NROPARTIDA ),t.INVENT = isnull( d.INVENT, t.INVENT ),t.DESCFW = isnull( d.DESCFW, t.DESCFW ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.COCOD = isnull( d.COCOD, t.COCOD ),t.TALLE = isnull( d.TALLE, t.TALLE ),t.COCOL = isnull( d.COCOL, t.COCOL ),t.COART = isnull( d.COART, t.COART ),t.COCANT = isnull( d.COCANT, t.COCANT ),t.CORIG = isnull( d.CORIG, t.CORIG )
					from ZooLogic.STOCKINV t inner join deleted d 
							 on t.COCOD = d.COCOD
							 and  t.COART = d.COART
							 and  t.COCOL = d.COCOL
							 and  t.Talle = d.Talle
							 and  t.NroPartida = d.NroPartida
							 and  t.Invent = d.Invent
				-- Fin Updates
				insert into ZooLogic.ADT_STOCKINV ( "ADT_Cod","ADT_Fecha","ADT_Hora","ADT_Serie","ADT_Usr","ADT_Ent","ADT_Comp","ADT_ADN","ADT_Vers","ADT_Ext","NroPartida","Invent","COCOD","Talle","COCOL","COART","Cocant" ) 
					Select <<lcCabecera1>>, <<lcCabecera2>>, <<lcCabecera3>>, <<lcCabecera4>>, <<lcCabecera5>>, <<lcCabecera6>>, case when funciones.empty( d.DescFw ) = 1 then 'IMPORTACION' else d.descFw end, <<lcCabecera7>>, <<lcCabecera8>>, <<lcCabecera9>>, d.Nropartida,d.Invent,d.Cocod,d.Talle,d.Cocol,d.Coart,isnull( d.COCANT,0)
						From deleted d left join ZooLogic.STOCKINV pk 
							 on d.COCOD = pk.COCOD
						 left join ZooLogic.STOCKINV cc 
							 on  d.COART = cc.COART
							 and  d.COCOL = cc.COCOL
							 and  d.Talle = cc.Talle
							 and  d.NroPartida = cc.NroPartida
							 and  d.Invent = cc.Invent
						Where pk.COCOD Is Null 
							 and cc.COART Is Null 
							 and cc.COCOL Is Null 
							 and cc.Talle Is Null 
							 and cc.NroPartida Is Null 
							 and cc.Invent Is Null 
				insert into ZooLogic.STOCKINV(Fecexpo,Fectrans,Fmodifw,Faltafw,Fecimpo,Haltafw,Horaexpo,Hmodifw,Horaimpo,Smodifw,Saltafw,Umodifw,Vmodifw,Valtafw,Nropartida,Invent,Descfw,Bdmodifw,Bdaltafw,Zadsfw,Esttrans,Ualtafw,Cocod,Talle,Cocol,Coart,Cocant,Corig)
					Select isnull( d.FECEXPO,''),isnull( d.FECTRANS,''),isnull( d.FMODIFW,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FECIMPO,''),convert( char(8), getdate(), 108 ),isnull( d.HORAEXPO,''),isnull( d.HMODIFW,''),isnull( d.HORAIMPO,''),isnull( d.SMODIFW,''),isnull( d.SALTAFW,''),isnull( d.UMODIFW,''),isnull( d.VMODIFW,''),isnull( d.VALTAFW,''),isnull( d.NROPARTIDA,''),isnull( d.INVENT,''),isnull( d.DESCFW,''),isnull( d.BDMODIFW,''),isnull( d.BDALTAFW,''),isnull( d.ZADSFW,''),isnull( d.ESTTRANS,''),isnull( d.UALTAFW,''),isnull( d.COCOD,''),isnull( d.TALLE,''),isnull( d.COCOL,''),isnull( d.COART,''),isnull( d.COCANT,0),isnull( d.CORIG,0)
						From deleted d left join ZooLogic.STOCKINV pk 
							 on d.COCOD = pk.COCOD
						 left join ZooLogic.STOCKINV cc 
							 on  d.COART = cc.COART
							 and  d.COCOL = cc.COCOL
							 and  d.Talle = cc.Talle
							 and  d.NroPartida = cc.NroPartida
							 and  d.Invent = cc.Invent
						Where pk.COCOD Is Null 
							 and cc.COART Is Null 
							 and cc.COCOL Is Null 
							 and cc.Talle Is Null 
							 and cc.NroPartida Is Null 
							 and cc.Invent Is Null 
				-- Fin Inserts
				Insert into ZooLogic.Logueos ( Fecha, Nivel, Logger, Accion, BaseDeDatos, 
					EstadoDelSistema, Aplicacion, Version, 
					Serie, Usuario, NombrePc, 
					UsuarioPc, OrigenLogueo, Mensaje, Excepcion)
				select GetDate(), 'INFO', '', 'Importación <<lcEntidad>>','<<loLogueo.BaseDatos>>',
					<<loLogueo.EstadoSistema>>,'<<loLogueo.Aplicacion>>','<<loLogueo.Version>>',
					'<<loLogueo.Serie>>','<<loLogueo.Usuario>>','<<loLogueo.NombrePc>>',
					'<<loLogueo.UsuarioPc>>','<<loLogueo.OrigenLogueo>>','No se pudo importar la entidad <<lcEntidad>>: INSUMO ' + cast( d.COART as Varchar(25) ) + ', COLOR ' + cast( d.COCOL as Varchar(6) ) + ', TALLE ' + cast( d.Talle as Varchar(5) ) + ', NÚMERO DE PARTIDA ' + cast( d.NroPartida as Varchar(25) ) + ', INVENTARIO ' + cast( d.Invent as Varchar(15) ) + '','La clave principal no es la esperada'
					from ZooLogic.STOCKINV t inner join deleted d 
							on   t.COART = d.COART
							 and  t.COCOL = d.COCOL
							 and  t.Talle = d.Talle
							 and  t.NroPartida = d.NroPartida
							 and  t.Invent = d.Invent
						left join deleted h 
							 on t.COCOD = h.COCOD
							 where h.COCOD is null 
				Insert into ZooLogic.Logueos ( Fecha, Nivel, Logger, Accion, BaseDeDatos, 
					EstadoDelSistema, Aplicacion, Version, 
					Serie, Usuario, NombrePc, 
					UsuarioPc, OrigenLogueo, Mensaje, Excepcion)
				select GetDate(), 'INFO', '', 'Importación <<lcEntidad>>','<<loLogueo.BaseDatos>>',
					<<loLogueo.EstadoSistema>>,'<<loLogueo.Aplicacion>>','<<loLogueo.Version>>',
					'<<loLogueo.Serie>>','<<loLogueo.Usuario>>','<<loLogueo.NombrePc>>',
					'<<loLogueo.UsuarioPc>>','<<loLogueo.OrigenLogueo>>','No se pudo importar la entidad <<lcEntidad>>: INSUMO ' + cast( d.COART as Varchar(25) ) + ', COLOR ' + cast( d.COCOL as Varchar(6) ) + ', TALLE ' + cast( d.Talle as Varchar(5) ) + ', NÚMERO DE PARTIDA ' + cast( d.NroPartida as Varchar(25) ) + ', INVENTARIO ' + cast( d.Invent as Varchar(15) ) + '','La clave principal a importar ya existe'
					from ZooLogic.STOCKINV t inner join deleted d 
							 on t.COCOD = d.COCOD
						left join deleted h 
							on   t.COART = h.COART
							 and   t.COCOL = h.COCOL
							 and   t.Talle = h.Talle
							 and   t.NroPartida = h.NroPartida
							 and   t.Invent = h.Invent
							where   h.COART is null 
							 and   h.COCOL is null 
							 and   h.Talle is null 
							 and   h.NroPartida is null 
							 and   h.Invent is null 
			End
		EndText
		Return lcCadena
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	protected Function EliminarTablasDeTrabajo( toConexion as Object ) as void
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_STOCKINV') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_STOCKINV
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_STOCKINVENTARIO' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_STOCKINVENTARIO.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_STOCKINVENTARIO.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_STOCKINVENTARIO.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_STOCKINVENTARIO.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_STOCKINVENTARIO.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Horaaltafw = nvl( c_STOCKINVENTARIO.Horaaltafw, [] )
					.Horaexpo = nvl( c_STOCKINVENTARIO.Horaexpo, [] )
					.Horamodificacionfw = nvl( c_STOCKINVENTARIO.Horamodificacionfw, [] )
					.Horaimpo = nvl( c_STOCKINVENTARIO.Horaimpo, [] )
					.Seriemodificacionfw = nvl( c_STOCKINVENTARIO.Seriemodificacionfw, [] )
					.Seriealtafw = nvl( c_STOCKINVENTARIO.Seriealtafw, [] )
					.Usuariomodificacionfw = nvl( c_STOCKINVENTARIO.Usuariomodificacionfw, [] )
					.Versionmodificacionfw = nvl( c_STOCKINVENTARIO.Versionmodificacionfw, [] )
					.Versionaltafw = nvl( c_STOCKINVENTARIO.Versionaltafw, [] )
					.Partida = nvl( c_STOCKINVENTARIO.Partida, [] )
					.Inventario_PK =  nvl( c_STOCKINVENTARIO.Inventario, [] )
					.Descripcionfw = nvl( c_STOCKINVENTARIO.Descripcionfw, [] )
					.Basededatosmodificacionfw = nvl( c_STOCKINVENTARIO.Basededatosmodificacionfw, [] )
					.Basededatosaltafw = nvl( c_STOCKINVENTARIO.Basededatosaltafw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Estadotransferencia = nvl( c_STOCKINVENTARIO.Estadotransferencia, [] )
					.Usuarioaltafw = nvl( c_STOCKINVENTARIO.Usuarioaltafw, [] )
					.Codigo = nvl( c_STOCKINVENTARIO.Codigo, [] )
					.Talle_PK =  nvl( c_STOCKINVENTARIO.Talle, [] )
					.Color_PK =  nvl( c_STOCKINVENTARIO.Color, [] )
					.Insumo_PK =  nvl( c_STOCKINVENTARIO.Insumo, [] )
					.Cantidad = nvl( c_STOCKINVENTARIO.Cantidad, 0 )
					.Cantidadoriginal = nvl( c_STOCKINVENTARIO.Cantidadoriginal, 0 )
					Select c_STOCKINVENTARIO
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
			Local lcEntidad1 as string, lcEntidad2 as string, lcEntidad3 as string, lcEntidad4 as string, lcEntidad5 as string, lcEntidad6 as string, lcEntidad7 as string
			lcEntidad1 = "'" + this.FormatearTextoSql( this.oEntidad.Partida ) + "'"
			lcEntidad2 = "'" + this.FormatearTextoSql( this.oEntidad.Inventario_pk ) + "'"
			lcEntidad3 = "'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'"
			lcEntidad4 = "'" + this.FormatearTextoSql( this.oEntidad.Talle_pk ) + "'"
			lcEntidad5 = "'" + this.FormatearTextoSql( this.oEntidad.Color_pk ) + "'"
			lcEntidad6 = "'" + this.FormatearTextoSql( this.oEntidad.Insumo_pk ) + "'"
			lcEntidad7 = transform( this.oEntidad.Cantidad )
			
		else
			lxValorClavePrimaria = &tcCursor..COCOD
			Local lcEntidad1 as string, lcEntidad2 as string, lcEntidad3 as string, lcEntidad4 as string, lcEntidad5 as string, lcEntidad6 as string, lcEntidad7 as string
			lcEntidad1 = "'" + this.FormatearTextoSql( &tcCursor..Nropartida ) + "'"
			lcEntidad2 = "'" + this.FormatearTextoSql( &tcCursor..Invent ) + "'"
			lcEntidad3 = "'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'"
			lcEntidad4 = "'" + this.FormatearTextoSql( &tcCursor..Talle ) + "'"
			lcEntidad5 = "'" + this.FormatearTextoSql( &tcCursor..Cocol ) + "'"
			lcEntidad6 = "'" + this.FormatearTextoSql( &tcCursor..Coart ) + "'"
			lcEntidad7 = transform( &tcCursor..Cocant )
			
		endif
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.ADT_STOCKINV ( "ADT_Cod","ADT_Fecha","ADT_Hora","ADT_Serie","ADT_Usr","ADT_Ent","ADT_Comp","ADT_ADN","ADT_Vers","ADT_Ext","NroPartida","Invent","COCOD","Talle","COCOL","COART","Cocant" ) values ( <<lcCabecera1>>, <<lcCabecera2>>, <<lcCabecera3>>, <<lcCabecera4>>, <<lcCabecera5>>, <<lcCabecera6>>, <<lcCabecera7>>, <<lcCabecera8>>, <<lcCabecera9>>, <<lcCabecera10>>, <<lcEntidad1>>, <<lcEntidad2>>, <<lcEntidad3>>, <<lcEntidad4>>, <<lcEntidad5>>, <<lcEntidad6>>, <<lcEntidad7>> ) 
			endtext
		return lcSentencia
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function ObtenerIdPorClaveCandidata() as variant
		local lxRetorno as Variant
		lxRetorno = ''
		if this.ConsultarPorClaveCandidata()
			lxRetorno = c_STOCKINVENTARIO.CODIGO
		endif
		return lxRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function ActualizarLosNROItemDeLosDetalles() as void
		local loDetalle as object, loItem as object, lnContadorNroItem as integer, lnIndex as integer
		
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function ObtenerMemo( tcTabla as String ) as string
		local lcAtributo as string
		lcAtributo = strtran( tcTabla, 'c_', '' )
		return c_STOCKINVENTARIO.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.STOCKINV' )
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
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "COCOD"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
		text to lcSQL textmerge noshow
				SELECT nro,totalRegistros,COCOD as Id
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    COCOD from (
							select * 
								from ZooLogic.STOCKINV 
								Where   STOCKINV.COCOD != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "STOCKINV", "", lcCursor, set("Datasession") )
		lcXml = this.CursorAXml( lcCursor )
		
		use in select( lcCursor )
		
		Return lcXml 
		
	endfunc
	*-----------------------------------------------------------------------------------------
	function ObtenerDatosEntidadPaginado( tcOrderBy as String, tcFiltro as String, tnCantidad as Integer, tnPagina as Integer )  as String
		local lcOrderBy as String, lnCuantos as Integer, lnPagina as Integer, lnTope as Integer, lnDesde as Integer, lcSQL as String, lcCursor as String, lcXml as String
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "COCOD"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
			text to lcAtributos textmerge noshow
			"Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Nropartida" as "Partida", "Invent" as "Inventario", "Descfw" as "Descripcionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Zadsfw" as "Zadsfw", "Esttrans" as "Estadotransferencia", "Ualtafw" as "Usuarioaltafw", "Cocod" as "Codigo", "Talle" as "Talle", "Cocol" as "Color", "Coart" as "Insumo", "Cocant" as "Cantidad", "Corig" as "Cantidadoriginal"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.STOCKINV 
								Where   STOCKINV.COCOD != ''
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
	Tabla = 'STOCKINV'
	Filtro = " STOCKINV.COCOD != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " STOCKINV.COCOD != ''"
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
	<row entidad="STOCKINVENTARIO                         " atributo="FECHAEXPO                               " tabla="STOCKINV       " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="STOCKINVENTARIO                         " atributo="FECHATRANSFERENCIA                      " tabla="STOCKINV       " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha de novedad                                                                                                                                                " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="STOCKINVENTARIO                         " atributo="FECHAMODIFICACIONFW                     " tabla="STOCKINV       " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="STOCKINVENTARIO                         " atributo="FECHAALTAFW                             " tabla="STOCKINV       " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="STOCKINVENTARIO                         " atributo="FECHAIMPO                               " tabla="STOCKINV       " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="STOCKINVENTARIO                         " atributo="HORAALTAFW                              " tabla="STOCKINV       " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="STOCKINVENTARIO                         " atributo="DESCRIPCIONCOMPROBANTE                  " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="254" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="STOCKINVENTARIO                         " atributo="HORAEXPO                                " tabla="STOCKINV       " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="STOCKINVENTARIO                         " atributo="HORAMODIFICACIONFW                      " tabla="STOCKINV       " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="STOCKINVENTARIO                         " atributo="HORAIMPO                                " tabla="STOCKINV       " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="STOCKINVENTARIO                         " atributo="SERIEMODIFICACIONFW                     " tabla="STOCKINV       " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="STOCKINVENTARIO                         " atributo="SERIEALTAFW                             " tabla="STOCKINV       " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="STOCKINVENTARIO                         " atributo="USUARIOMODIFICACIONFW                   " tabla="STOCKINV       " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="STOCKINVENTARIO                         " atributo="VERSIONMODIFICACIONFW                   " tabla="STOCKINV       " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="STOCKINVENTARIO                         " atributo="VERSIONALTAFW                           " tabla="STOCKINV       " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="STOCKINVENTARIO                         " atributo="PARTIDA                                 " tabla="STOCKINV       " campo="NROPARTIDA" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="25" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="10" etiqueta="Número de partida                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="4" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="STOCKINVENTARIO                         " atributo="INVENTARIO                              " tabla="STOCKINV       " campo="INVENT    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="INVENTARIO                              " tipodato="C         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="8" etiqueta="Inventario                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="5" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="STOCKINVENTARIO                         " atributo="DESCRIPCIONFW                           " tabla="STOCKINV       " campo="DESCFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="200" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="STOCKINVENTARIO                         " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="STOCKINV       " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="STOCKINVENTARIO                         " atributo="BASEDEDATOSALTAFW                       " tabla="STOCKINV       " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="STOCKINVENTARIO                         " atributo="ZADSFW                                  " tabla="STOCKINV       " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="STOCKINVENTARIO                         " atributo="ESTADOTRANSFERENCIA                     " tabla="STOCKINV       " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado de novedad                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="STOCKINVENTARIO                         " atributo="USUARIOALTAFW                           " tabla="STOCKINV       " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="STOCKINVENTARIO                         " atributo="CODIGO                                  " tabla="STOCKINV       " campo="COCOD     " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="12" etiqueta="Código                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="STOCKINVENTARIO                         " atributo="TALLE                                   " tabla="STOCKINV       " campo="TALLE     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="TALLE                                   " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="6" etiqueta="Talle                                                                                                                                                           " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="3" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="STOCKINVENTARIO                         " atributo="COLOR                                   " tabla="STOCKINV       " campo="COCOL     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="COLOR                                   " tipodato="C         " longitud="6" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="4" etiqueta="Color                                                                                                                                                           " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="2" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="STOCKINVENTARIO                         " atributo="INSUMO                                  " tabla="STOCKINV       " campo="COART     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="INSUMO                                  " tipodato="C         " longitud="25" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="2" etiqueta="Insumo                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="1" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="STOCKINVENTARIO                         " atributo="CANTIDAD                                " tabla="STOCKINV       " campo="COCANT    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="17" decimales="6" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="Cantidad en stock                                                                                                                                               " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="STOCKINVENTARIO                         " atributo="CANTIDADORIGINAL                        " tabla="STOCKINV       " campo="CORIG     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="17" decimales="6" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Cantidad original                                                                                                                                               " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="6" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INVENTARIO                              " atributo="DESCRIPCION                             " tabla="INV            " campo="INVDES    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="9" etiqueta="Detalle Inv.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join INV On STOCKINV.INVENT = INV.invcod And  INV.INVCOD != ''                                                                                                                                                                                          " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TALLE                                   " atributo="DESCRIPCION                             " tabla="TALLE          " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="7" etiqueta="Detalle Tal.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join TALLE On STOCKINV.TALLE = TALLE.Codigo And  TALLE.CODIGO != ''                                                                                                                                                                                     " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COLOR                                   " atributo="DESCRIPCION                             " tabla="COL            " campo="COLDES    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="5" etiqueta="Detalle Col.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join COL On STOCKINV.COCOL = COL.COLCOD And  COL.COLCOD != ''                                                                                                                                                                                           " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INSUMO                                  " atributo="DESCRIPCION                             " tabla="INS            " campo="INSDES    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="3" etiqueta="Detalle Ins.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join INS On STOCKINV.COART = INS.INSCOD And  INS.INSCOD != ''                                                                                                                                                                                           " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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