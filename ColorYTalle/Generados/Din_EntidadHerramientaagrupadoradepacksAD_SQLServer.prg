
define class Din_EntidadHERRAMIENTAAGRUPADORADEPACKSAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_HERRAMIENTAAGRUPADORADEPACKS'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = []
	cExpresionCCPorCampos = []
	cTagClaveCandidata = ''
	cTagClavePk = '_PCKPK'
	cTablaPrincipal = 'HERPACK'
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
			local  lxHerpackFecimpo, lxHerpackFectrans, lxHerpackFmodifw, lxHerpackFaltafw, lxHerpackFecexpo, lxHerpackSaltafw, lxHerpackHoraimpo, lxHerpackHmodifw, lxHerpackSmodifw, lxHerpackUmodifw, lxHerpackUaltafw, lxHerpackZadsfw, lxHerpackValtafw, lxHerpackVmodifw, lxHerpackHoraexpo, lxHerpackHaltafw, lxHerpackBdmodifw, lxHerpackBdaltafw, lxHerpackEsttrans, lxHerpackNumero, lxHerpackMovent, lxHerpackObs, lxHerpackMovsal, lxHerpackMotivo, lxHerpackVendedor, lxHerpackFecha, lxHerpackAccion
				lxHerpackFecimpo =  .Fechaimpo			lxHerpackFectrans =  .Fechatransferencia			lxHerpackFmodifw =  .Fechamodificacionfw			lxHerpackFaltafw =  .Fechaaltafw			lxHerpackFecexpo =  .Fechaexpo			lxHerpackSaltafw =  .Seriealtafw			lxHerpackHoraimpo =  .Horaimpo			lxHerpackHmodifw =  .Horamodificacionfw			lxHerpackSmodifw =  .Seriemodificacionfw			lxHerpackUmodifw =  .Usuariomodificacionfw			lxHerpackUaltafw =  .Usuarioaltafw			lxHerpackZadsfw =  .Zadsfw			lxHerpackValtafw =  .Versionaltafw			lxHerpackVmodifw =  .Versionmodificacionfw			lxHerpackHoraexpo =  .Horaexpo			lxHerpackHaltafw =  .Horaaltafw			lxHerpackBdmodifw =  .Basededatosmodificacionfw			lxHerpackBdaltafw =  .Basededatosaltafw			lxHerpackEsttrans =  .Estadotransferencia			lxHerpackNumero =  .Numero			lxHerpackMovent =  .Moventrada			lxHerpackObs =  .Observacion			lxHerpackMovsal =  .Movsalida			lxHerpackMotivo =  upper( .Motivo_PK ) 			lxHerpackVendedor =  upper( .Vendedor_PK ) 			lxHerpackFecha =  .Fecha			lxHerpackAccion =  .Accion
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxHerpackNumero = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.HERPACK ( "Fecimpo","Fectrans","Fmodifw","Faltafw","Fecexpo","Saltafw","Horaimpo","Hmodifw","Smodifw","Umodifw","Ualtafw","Zadsfw","Valtafw","Vmodifw","Horaexpo","Haltafw","Bdmodifw","Bdaltafw","Esttrans","Numero","Movent","Obs","Movsal","Motivo","Vendedor","Fecha","Accion" ) values ( <<"'" + this.ConvertirDateSql( lxHerpackFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxHerpackFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxHerpackFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxHerpackFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxHerpackFecexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxHerpackSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxHerpackHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxHerpackHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxHerpackSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxHerpackUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxHerpackUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxHerpackZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxHerpackValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxHerpackVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxHerpackHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxHerpackHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxHerpackBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxHerpackBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxHerpackEsttrans ) + "'" >>, <<lxHerpackNumero >>, <<"'" + this.FormatearTextoSql( lxHerpackMovent ) + "'" >>, <<"'" + this.FormatearTextoSql( lxHerpackObs ) + "'" >>, <<"'" + this.FormatearTextoSql( lxHerpackMovsal ) + "'" >>, <<"'" + this.FormatearTextoSql( lxHerpackMotivo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxHerpackVendedor ) + "'" >>, <<"'" + this.ConvertirDateSql( lxHerpackFecha ) + "'" >>, <<lxHerpackAccion >> )
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
		this.ComprobarTransaccion()
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.NUMERO
			lcValorClavePrimariaString = lxValorClavePrimaria


			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.DetallePacks
				if this.oEntidad.DetallePacks.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxComportamiento = loItem.Comportamiento
					lxNroitem = lnContadorNroItem
					lxNoprocesarstock = loItem.Noprocesarstock
					lxEquivalencia_PK = loItem.Equivalencia_PK
					lxArticulo_PK = loItem.Articulo_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxTalle_PK = loItem.Talle_PK
					lxCantidad = loItem.Cantidad
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.HerPackDet("COMP","NROITEM","ProcStock","NUMERO","EQUIV","PACKS","PACKSDET","CODCOL","COLDET","TALLE","CANT" ) values ( <<lxComportamiento>>, <<lxNroitem>>, <<iif( lxNoprocesarstock, 1, 0 )>>, <<transform( lxValorClavePrimaria )>>, <<"'" + this.FormatearTextoSql( lxEquivalencia_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<lxCantidad>> ) 
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
			local  lxHerpackFecimpo, lxHerpackFectrans, lxHerpackFmodifw, lxHerpackFaltafw, lxHerpackFecexpo, lxHerpackSaltafw, lxHerpackHoraimpo, lxHerpackHmodifw, lxHerpackSmodifw, lxHerpackUmodifw, lxHerpackUaltafw, lxHerpackZadsfw, lxHerpackValtafw, lxHerpackVmodifw, lxHerpackHoraexpo, lxHerpackHaltafw, lxHerpackBdmodifw, lxHerpackBdaltafw, lxHerpackEsttrans, lxHerpackNumero, lxHerpackMovent, lxHerpackObs, lxHerpackMovsal, lxHerpackMotivo, lxHerpackVendedor, lxHerpackFecha, lxHerpackAccion
				lxHerpackFecimpo =  .Fechaimpo			lxHerpackFectrans =  .Fechatransferencia			lxHerpackFmodifw =  .Fechamodificacionfw			lxHerpackFaltafw =  .Fechaaltafw			lxHerpackFecexpo =  .Fechaexpo			lxHerpackSaltafw =  .Seriealtafw			lxHerpackHoraimpo =  .Horaimpo			lxHerpackHmodifw =  .Horamodificacionfw			lxHerpackSmodifw =  .Seriemodificacionfw			lxHerpackUmodifw =  .Usuariomodificacionfw			lxHerpackUaltafw =  .Usuarioaltafw			lxHerpackZadsfw =  .Zadsfw			lxHerpackValtafw =  .Versionaltafw			lxHerpackVmodifw =  .Versionmodificacionfw			lxHerpackHoraexpo =  .Horaexpo			lxHerpackHaltafw =  .Horaaltafw			lxHerpackBdmodifw =  .Basededatosmodificacionfw			lxHerpackBdaltafw =  .Basededatosaltafw			lxHerpackEsttrans =  .Estadotransferencia			lxHerpackNumero =  .Numero			lxHerpackMovent =  .Moventrada			lxHerpackObs =  .Observacion			lxHerpackMovsal =  .Movsalida			lxHerpackMotivo =  upper( .Motivo_PK ) 			lxHerpackVendedor =  upper( .Vendedor_PK ) 			lxHerpackFecha =  .Fecha			lxHerpackAccion =  .Accion
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()
			lxValorClavePrimaria = .oEntidad.NUMERO
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ZooLogic.HERPACK set "Fecimpo" = <<"'" + this.ConvertirDateSql( lxHerpackFecimpo ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxHerpackFectrans ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxHerpackFmodifw ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxHerpackFaltafw ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxHerpackFecexpo ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxHerpackSaltafw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxHerpackHoraimpo ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxHerpackHmodifw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxHerpackSmodifw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxHerpackUmodifw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxHerpackUaltafw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxHerpackZadsfw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxHerpackValtafw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxHerpackVmodifw ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxHerpackHoraexpo ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxHerpackHaltafw ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxHerpackBdmodifw ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxHerpackBdaltafw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxHerpackEsttrans ) + "'">>,"Numero" = <<lxHerpackNumero>>,"Movent" = <<"'" + this.FormatearTextoSql( lxHerpackMovent ) + "'">>,"Obs" = <<"'" + this.FormatearTextoSql( lxHerpackObs ) + "'">>,"Movsal" = <<"'" + this.FormatearTextoSql( lxHerpackMovsal ) + "'">>,"Motivo" = <<"'" + this.FormatearTextoSql( lxHerpackMotivo ) + "'">>,"Vendedor" = <<"'" + this.FormatearTextoSql( lxHerpackVendedor ) + "'">>,"Fecha" = <<"'" + this.ConvertirDateSql( lxHerpackFecha ) + "'">>,"Accion" = <<lxHerpackAccion>> where "Numero" = <<lxHerpackNumero>> and  HERPACK.NUMERO != 0 << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			this.ComprobarResultadoDeEjecucionDelUpdate()
		this.ComprobarTransaccion()
			this.oConexion.EjecutarSql( [delete from ZooLogic.HerPackDet where "Numero" = '] + transform( .oEntidad.NUMERO ) + ['])

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.DetallePacks
				if this.oEntidad.DetallePacks.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxComportamiento = loItem.Comportamiento
					lxNroitem = lnContadorNroItem
					lxNoprocesarstock = loItem.Noprocesarstock
					lxEquivalencia_PK = loItem.Equivalencia_PK
					lxArticulo_PK = loItem.Articulo_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxTalle_PK = loItem.Talle_PK
					lxCantidad = loItem.Cantidad
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.HerPackDet("COMP","NROITEM","ProcStock","NUMERO","EQUIV","PACKS","PACKSDET","CODCOL","COLDET","TALLE","CANT" ) values ( <<lxComportamiento>>, <<lxNroitem>>, <<iif( lxNoprocesarstock, 1, 0 )>>, <<transform( lxValorClavePrimaria )>>, <<"'" + this.FormatearTextoSql( lxEquivalencia_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<lxCantidad>> ) 
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 Numero from ZooLogic.HERPACK where " + this.ConvertirFuncionesSql( " HERPACK.NUMERO != 0" ) )
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
			Local lxHerpackNumero
			lxHerpackNumero = .Numero

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Numero" as "Numero", "Movent" as "Moventrada", "Obs" as "Observacion", "Movsal" as "Movsalida", "Motivo" as "Motivo", "Vendedor" as "Vendedor", "Fecha" as "Fecha", "Accion" as "Accion" from ZooLogic.HERPACK where "Numero" = <<lxHerpackNumero>> and  HERPACK.NUMERO != 0
			endtext
			use in select('c_HERRAMIENTAAGRUPADORADEPACKS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_HERRAMIENTAAGRUPADORADEPACKS', set( 'Datasession' ) )

			if reccount( 'c_HERRAMIENTAAGRUPADORADEPACKS' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Procstock" as "Noprocesarstock", "Numero" as "Numero", "Equiv" as "Equivalencia", "Packs" as "Articulo", "Packsdet" as "Articulodetalle", "Codcol" as "Color", "Coldet" as "Colordetalle", "Talle" as "Talle", "Cant" as "Cantidad" from ZooLogic.HerPackDet where Numero = <<transform( c_HERRAMIENTAAGRUPADORADEPACKS.NUMERO )>> Order by NroItem
			endtext
			use in select('c_DetallePacks')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DetallePacks', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DetallePacks
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxHerpackNumero as Variant
		llRetorno = .t.
		lxHerpackNumero = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.HERPACK where "Numero" = <<lxHerpackNumero>> and  HERPACK.NUMERO != 0
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
				lcOrden =  str( .Numero, 10, 0)
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Numero" as "Numero", "Movent" as "Moventrada", "Obs" as "Observacion", "Movsal" as "Movsalida", "Motivo" as "Motivo", "Vendedor" as "Vendedor", "Fecha" as "Fecha", "Accion" as "Accion" from ZooLogic.HERPACK where  HERPACK.NUMERO != 0 order by Numero
			endtext
			use in select('c_HERRAMIENTAAGRUPADORADEPACKS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_HERRAMIENTAAGRUPADORADEPACKS', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Procstock" as "Noprocesarstock", "Numero" as "Numero", "Equiv" as "Equivalencia", "Packs" as "Articulo", "Packsdet" as "Articulodetalle", "Codcol" as "Color", "Coldet" as "Colordetalle", "Talle" as "Talle", "Cant" as "Cantidad" from ZooLogic.HerPackDet where Numero = <<transform( c_HERRAMIENTAAGRUPADORADEPACKS.NUMERO )>> Order by NroItem
			endtext
			use in select('c_DetallePacks')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DetallePacks', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DetallePacks
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
				lcOrden =  str( .Numero, 10, 0)
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Numero" as "Numero", "Movent" as "Moventrada", "Obs" as "Observacion", "Movsal" as "Movsalida", "Motivo" as "Motivo", "Vendedor" as "Vendedor", "Fecha" as "Fecha", "Accion" as "Accion" from ZooLogic.HERPACK where  str( Numero, 10, 0) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  HERPACK.NUMERO != 0 order by Numero
			endtext
			use in select('c_HERRAMIENTAAGRUPADORADEPACKS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_HERRAMIENTAAGRUPADORADEPACKS', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Procstock" as "Noprocesarstock", "Numero" as "Numero", "Equiv" as "Equivalencia", "Packs" as "Articulo", "Packsdet" as "Articulodetalle", "Codcol" as "Color", "Coldet" as "Colordetalle", "Talle" as "Talle", "Cant" as "Cantidad" from ZooLogic.HerPackDet where Numero = <<transform( c_HERRAMIENTAAGRUPADORADEPACKS.NUMERO )>> Order by NroItem
			endtext
			use in select('c_DetallePacks')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DetallePacks', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DetallePacks
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
				lcOrden =  str( .Numero, 10, 0)
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Numero" as "Numero", "Movent" as "Moventrada", "Obs" as "Observacion", "Movsal" as "Movsalida", "Motivo" as "Motivo", "Vendedor" as "Vendedor", "Fecha" as "Fecha", "Accion" as "Accion" from ZooLogic.HERPACK where  str( Numero, 10, 0) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  HERPACK.NUMERO != 0 order by Numero desc
			endtext
			use in select('c_HERRAMIENTAAGRUPADORADEPACKS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_HERRAMIENTAAGRUPADORADEPACKS', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Procstock" as "Noprocesarstock", "Numero" as "Numero", "Equiv" as "Equivalencia", "Packs" as "Articulo", "Packsdet" as "Articulodetalle", "Codcol" as "Color", "Coldet" as "Colordetalle", "Talle" as "Talle", "Cant" as "Cantidad" from ZooLogic.HerPackDet where Numero = <<transform( c_HERRAMIENTAAGRUPADORADEPACKS.NUMERO )>> Order by NroItem
			endtext
			use in select('c_DetallePacks')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DetallePacks', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DetallePacks
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
				lcOrden =  str( .Numero, 10, 0)
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Numero" as "Numero", "Movent" as "Moventrada", "Obs" as "Observacion", "Movsal" as "Movsalida", "Motivo" as "Motivo", "Vendedor" as "Vendedor", "Fecha" as "Fecha", "Accion" as "Accion" from ZooLogic.HERPACK where  HERPACK.NUMERO != 0 order by Numero desc
			endtext
			use in select('c_HERRAMIENTAAGRUPADORADEPACKS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_HERRAMIENTAAGRUPADORADEPACKS', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Procstock" as "Noprocesarstock", "Numero" as "Numero", "Equiv" as "Equivalencia", "Packs" as "Articulo", "Packsdet" as "Articulodetalle", "Codcol" as "Color", "Coldet" as "Colordetalle", "Talle" as "Talle", "Cant" as "Cantidad" from ZooLogic.HerPackDet where Numero = <<transform( c_HERRAMIENTAAGRUPADORADEPACKS.NUMERO )>> Order by NroItem
			endtext
			use in select('c_DetallePacks')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DetallePacks', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DetallePacks
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
			lcXml = this.oConexion.EjecutarSql( "select Fecimpo,Fectrans,Fmodifw,Faltafw,Fecexpo,Saltafw,Horaimpo,Hmodifw,Smodifw,Umodifw,Ualtafw,Za" + ;
"dsfw,Valtafw,Vmodifw,Horaexpo,Haltafw,Bdmodifw,Bdaltafw,Esttrans,Numero,Movent,Obs,Movsal,Motivo,Ven" + ;
"dedor,Fecha,Accion" + ;
" from ZooLogic.HERPACK where  HERPACK.NUMERO != 0 and " + lcFiltro )
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
			local  lxHerpackFecimpo, lxHerpackFectrans, lxHerpackFmodifw, lxHerpackFaltafw, lxHerpackFecexpo, lxHerpackSaltafw, lxHerpackHoraimpo, lxHerpackHmodifw, lxHerpackSmodifw, lxHerpackUmodifw, lxHerpackUaltafw, lxHerpackZadsfw, lxHerpackValtafw, lxHerpackVmodifw, lxHerpackHoraexpo, lxHerpackHaltafw, lxHerpackBdmodifw, lxHerpackBdaltafw, lxHerpackEsttrans, lxHerpackNumero, lxHerpackMovent, lxHerpackObs, lxHerpackMovsal, lxHerpackMotivo, lxHerpackVendedor, lxHerpackFecha, lxHerpackAccion
				lxHerpackFecimpo = ctod( '  /  /    ' )			lxHerpackFectrans = ctod( '  /  /    ' )			lxHerpackFmodifw = ctod( '  /  /    ' )			lxHerpackFaltafw = ctod( '  /  /    ' )			lxHerpackFecexpo = ctod( '  /  /    ' )			lxHerpackSaltafw = []			lxHerpackHoraimpo = []			lxHerpackHmodifw = []			lxHerpackSmodifw = []			lxHerpackUmodifw = []			lxHerpackUaltafw = []			lxHerpackZadsfw = []			lxHerpackValtafw = []			lxHerpackVmodifw = []			lxHerpackHoraexpo = []			lxHerpackHaltafw = []			lxHerpackBdmodifw = []			lxHerpackBdaltafw = []			lxHerpackEsttrans = []			lxHerpackNumero = 0			lxHerpackMovent = []			lxHerpackObs = []			lxHerpackMovsal = []			lxHerpackMotivo = []			lxHerpackVendedor = []			lxHerpackFecha = ctod( '  /  /    ' )			lxHerpackAccion = 0
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( [delete from ZooLogic.HerPackDet where "Numero" = '] + transform( .oEntidad.NUMERO ) + ['])
			this.oConexion.EjecutarSql( [delete from ZooLogic.HERPACK where "Numero" = ] + transform( .oEntidad.NUMERO )+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'HERPACK' + '_' + tcCampo
			lcMemoAscii = ''

			lnIndice = alen(.aSqlMemos)
			lnIndice = iif(lnIndice = 1, 1, lnIndice + 1 )
			dimension .aSqlMemos(lnIndice)

			.aSqlMemos(lnIndice) = 'delete from ' + lcTabla + ' where Numero = ' + txValorClavePrimaria
			.GenerarSentenciasInsertTablaMemo( lcValor, lcTabla, txValorClavePrimaria )
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerSentenciaInsertMemo( tcTabla as String, txValorClavePrimaria as String, tcOrden as String, tcTexto as String ) as String
		return "Insert  into " + tcTabla + "(Numero, Orden, texto ) values ( " + txValorClavePrimaria + "," + tcOrden + ",'"+ tcTexto + "')"
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosEntidad( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  HERPACK.NUMERO != 0"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Numero" as "Numero", "Movent" as "Moventrada", "Obs" as "Observacion", "Movsal" as "Movsalida", "Motivo" as "Motivo", "Vendedor" as "Vendedor", "Fecha" as "Fecha", "Accion" as "Accion"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'HERPACK', '', tnTope )
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
	Function ObtenerDatosDetalleDetallePacks( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  HERPACKDET.NUMERO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Procstock" as "Noprocesarstock", "Numero" as "Numero", "Equiv" as "Equivalencia", "Packs" as "Articulo", "Packsdet" as "Articulodetalle", "Codcol" as "Color", "Coldet" as "Colordetalle", "Talle" as "Talle", "Cant" as "Cantidad"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleDetallePacks( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'HerPackDet', 'DetallePacks', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleDetallePacks( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleDetallePacks( lcAtributo )
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
				Case lcAtributo == 'FECHATRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRANS AS FECHATRANSFERENCIA'
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'FECHAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECEXPO AS FECHAEXPO'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'NUMERO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NUMERO AS NUMERO'
				Case lcAtributo == 'MOVENTRADA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MOVENT AS MOVENTRADA'
				Case lcAtributo == 'OBSERVACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'OBS AS OBSERVACION'
				Case lcAtributo == 'MOVSALIDA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MOVSAL AS MOVSALIDA'
				Case lcAtributo == 'MOTIVO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MOTIVO AS MOTIVO'
				Case lcAtributo == 'VENDEDOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VENDEDOR AS VENDEDOR'
				Case lcAtributo == 'FECHA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHA AS FECHA'
				Case lcAtributo == 'ACCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ACCION AS ACCION'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleDetallePacks( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'COMPORTAMIENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COMP AS COMPORTAMIENTO'
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'NOPROCESARSTOCK'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PROCSTOCK AS NOPROCESARSTOCK'
				Case lcAtributo == 'NUMERO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NUMERO AS NUMERO'
				Case lcAtributo == 'EQUIVALENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'EQUIV AS EQUIVALENCIA'
				Case lcAtributo == 'ARTICULO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PACKS AS ARTICULO'
				Case lcAtributo == 'ARTICULODETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PACKSDET AS ARTICULODETALLE'
				Case lcAtributo == 'COLOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODCOL AS COLOR'
				Case lcAtributo == 'COLORDETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COLDET AS COLORDETALLE'
				Case lcAtributo == 'TALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TALLE AS TALLE'
				Case lcAtributo == 'CANTIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CANT AS CANTIDAD'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEXPO'
				lcCampo = 'FECEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'NUMERO'
				lcCampo = 'NUMERO'
			Case upper( alltrim( tcAtributo ) ) == 'MOVENTRADA'
				lcCampo = 'MOVENT'
			Case upper( alltrim( tcAtributo ) ) == 'OBSERVACION'
				lcCampo = 'OBS'
			Case upper( alltrim( tcAtributo ) ) == 'MOVSALIDA'
				lcCampo = 'MOVSAL'
			Case upper( alltrim( tcAtributo ) ) == 'MOTIVO'
				lcCampo = 'MOTIVO'
			Case upper( alltrim( tcAtributo ) ) == 'VENDEDOR'
				lcCampo = 'VENDEDOR'
			Case upper( alltrim( tcAtributo ) ) == 'FECHA'
				lcCampo = 'FECHA'
			Case upper( alltrim( tcAtributo ) ) == 'ACCION'
				lcCampo = 'ACCION'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleDetallePacks( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'COMPORTAMIENTO'
				lcCampo = 'COMP'
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'NOPROCESARSTOCK'
				lcCampo = 'PROCSTOCK'
			Case upper( alltrim( tcAtributo ) ) == 'NUMERO'
				lcCampo = 'NUMERO'
			Case upper( alltrim( tcAtributo ) ) == 'EQUIVALENCIA'
				lcCampo = 'EQUIV'
			Case upper( alltrim( tcAtributo ) ) == 'ARTICULO'
				lcCampo = 'PACKS'
			Case upper( alltrim( tcAtributo ) ) == 'ARTICULODETALLE'
				lcCampo = 'PACKSDET'
			Case upper( alltrim( tcAtributo ) ) == 'COLOR'
				lcCampo = 'CODCOL'
			Case upper( alltrim( tcAtributo ) ) == 'COLORDETALLE'
				lcCampo = 'COLDET'
			Case upper( alltrim( tcAtributo ) ) == 'TALLE'
				lcCampo = 'TALLE'
			Case upper( alltrim( tcAtributo ) ) == 'CANTIDAD'
				lcCampo = 'CANT'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerTablaDetalle( tcDetalle as string ) as String
		local lcRetorno as string
		lcRetorno = ''
		if upper( alltrim( tcDetalle ) ) == 'DETALLEPACKS'
			lcRetorno = 'HERPACKDET'
		EndIf
		return lcRetorno
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasInsert() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcSentencia as string, loItem as object
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxHerpackFecimpo, lxHerpackFectrans, lxHerpackFmodifw, lxHerpackFaltafw, lxHerpackFecexpo, lxHerpackSaltafw, lxHerpackHoraimpo, lxHerpackHmodifw, lxHerpackSmodifw, lxHerpackUmodifw, lxHerpackUaltafw, lxHerpackZadsfw, lxHerpackValtafw, lxHerpackVmodifw, lxHerpackHoraexpo, lxHerpackHaltafw, lxHerpackBdmodifw, lxHerpackBdaltafw, lxHerpackEsttrans, lxHerpackNumero, lxHerpackMovent, lxHerpackObs, lxHerpackMovsal, lxHerpackMotivo, lxHerpackVendedor, lxHerpackFecha, lxHerpackAccion
				lxHerpackFecimpo =  .Fechaimpo			lxHerpackFectrans =  .Fechatransferencia			lxHerpackFmodifw =  .Fechamodificacionfw			lxHerpackFaltafw =  .Fechaaltafw			lxHerpackFecexpo =  .Fechaexpo			lxHerpackSaltafw =  .Seriealtafw			lxHerpackHoraimpo =  .Horaimpo			lxHerpackHmodifw =  .Horamodificacionfw			lxHerpackSmodifw =  .Seriemodificacionfw			lxHerpackUmodifw =  .Usuariomodificacionfw			lxHerpackUaltafw =  .Usuarioaltafw			lxHerpackZadsfw =  .Zadsfw			lxHerpackValtafw =  .Versionaltafw			lxHerpackVmodifw =  .Versionmodificacionfw			lxHerpackHoraexpo =  .Horaexpo			lxHerpackHaltafw =  .Horaaltafw			lxHerpackBdmodifw =  .Basededatosmodificacionfw			lxHerpackBdaltafw =  .Basededatosaltafw			lxHerpackEsttrans =  .Estadotransferencia			lxHerpackNumero =  .Numero			lxHerpackMovent =  .Moventrada			lxHerpackObs =  .Observacion			lxHerpackMovsal =  .Movsalida			lxHerpackMotivo =  upper( .Motivo_PK ) 			lxHerpackVendedor =  upper( .Vendedor_PK ) 			lxHerpackFecha =  .Fecha			lxHerpackAccion =  .Accion
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.HERPACK ( "Fecimpo","Fectrans","Fmodifw","Faltafw","Fecexpo","Saltafw","Horaimpo","Hmodifw","Smodifw","Umodifw","Ualtafw","Zadsfw","Valtafw","Vmodifw","Horaexpo","Haltafw","Bdmodifw","Bdaltafw","Esttrans","Numero","Movent","Obs","Movsal","Motivo","Vendedor","Fecha","Accion" ) values ( <<"'" + this.ConvertirDateSql( lxHerpackFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxHerpackFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxHerpackFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxHerpackFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxHerpackFecexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxHerpackSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxHerpackHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxHerpackHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxHerpackSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxHerpackUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxHerpackUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxHerpackZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxHerpackValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxHerpackVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxHerpackHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxHerpackHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxHerpackBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxHerpackBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxHerpackEsttrans ) + "'" >>, <<lxHerpackNumero >>, <<"'" + this.FormatearTextoSql( lxHerpackMovent ) + "'" >>, <<"'" + this.FormatearTextoSql( lxHerpackObs ) + "'" >>, <<"'" + this.FormatearTextoSql( lxHerpackMovsal ) + "'" >>, <<"'" + this.FormatearTextoSql( lxHerpackMotivo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxHerpackVendedor ) + "'" >>, <<"'" + this.ConvertirDateSql( lxHerpackFecha ) + "'" >>, <<lxHerpackAccion >> )
		endtext
		loColeccion.cTabla = 'HERPACK' 
		loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		With this
			local lcValorClavePrimariaString as String
			lcValorClavePrimariaString = transform( this.oEntidad.NUMERO )

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.DetallePacks
				if this.oEntidad.DetallePacks.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxComportamiento = loItem.Comportamiento
					lxNroitem = lnContadorNroItem
					lxNoprocesarstock = loItem.Noprocesarstock
					lxEquivalencia_PK = loItem.Equivalencia_PK
					lxArticulo_PK = loItem.Articulo_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxTalle_PK = loItem.Talle_PK
					lxCantidad = loItem.Cantidad
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.HerPackDet("COMP","NROITEM","ProcStock","NUMERO","EQUIV","PACKS","PACKSDET","CODCOL","COLDET","TALLE","CANT" ) values ( <<lxComportamiento>>, <<lxNroitem>>, <<iif( lxNoprocesarstock, 1, 0 )>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxEquivalencia_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<lxCantidad>> ) 
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
			local  lxHerpackFecimpo, lxHerpackFectrans, lxHerpackFmodifw, lxHerpackFaltafw, lxHerpackFecexpo, lxHerpackSaltafw, lxHerpackHoraimpo, lxHerpackHmodifw, lxHerpackSmodifw, lxHerpackUmodifw, lxHerpackUaltafw, lxHerpackZadsfw, lxHerpackValtafw, lxHerpackVmodifw, lxHerpackHoraexpo, lxHerpackHaltafw, lxHerpackBdmodifw, lxHerpackBdaltafw, lxHerpackEsttrans, lxHerpackNumero, lxHerpackMovent, lxHerpackObs, lxHerpackMovsal, lxHerpackMotivo, lxHerpackVendedor, lxHerpackFecha, lxHerpackAccion
				lxHerpackFecimpo =  .Fechaimpo			lxHerpackFectrans =  .Fechatransferencia			lxHerpackFmodifw =  .Fechamodificacionfw			lxHerpackFaltafw =  .Fechaaltafw			lxHerpackFecexpo =  .Fechaexpo			lxHerpackSaltafw =  .Seriealtafw			lxHerpackHoraimpo =  .Horaimpo			lxHerpackHmodifw =  .Horamodificacionfw			lxHerpackSmodifw =  .Seriemodificacionfw			lxHerpackUmodifw =  .Usuariomodificacionfw			lxHerpackUaltafw =  .Usuarioaltafw			lxHerpackZadsfw =  .Zadsfw			lxHerpackValtafw =  .Versionaltafw			lxHerpackVmodifw =  .Versionmodificacionfw			lxHerpackHoraexpo =  .Horaexpo			lxHerpackHaltafw =  .Horaaltafw			lxHerpackBdmodifw =  .Basededatosmodificacionfw			lxHerpackBdaltafw =  .Basededatosaltafw			lxHerpackEsttrans =  .Estadotransferencia			lxHerpackNumero =  .Numero			lxHerpackMovent =  .Moventrada			lxHerpackObs =  .Observacion			lxHerpackMovsal =  .Movsalida			lxHerpackMotivo =  upper( .Motivo_PK ) 			lxHerpackVendedor =  upper( .Vendedor_PK ) 			lxHerpackFecha =  .Fecha			lxHerpackAccion =  .Accion
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.NUMERO
			lcValorClavePrimariaString = transform( this.oEntidad.NUMERO )

			lcFiltro = ["Numero" = ] + lcValorClavePrimariaString  + [ and  HERPACK.NUMERO != 0]
			text to lcSentencia noshow textmerge
				update ZooLogic.HERPACK set "Fecimpo" = <<"'" + this.ConvertirDateSql( lxHerpackFecimpo ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxHerpackFectrans ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxHerpackFmodifw ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxHerpackFaltafw ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxHerpackFecexpo ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxHerpackSaltafw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxHerpackHoraimpo ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxHerpackHmodifw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxHerpackSmodifw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxHerpackUmodifw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxHerpackUaltafw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxHerpackZadsfw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxHerpackValtafw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxHerpackVmodifw ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxHerpackHoraexpo ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxHerpackHaltafw ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxHerpackBdmodifw ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxHerpackBdaltafw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxHerpackEsttrans ) + "'">>, "Numero" = <<lxHerpackNumero>>, "Movent" = <<"'" + this.FormatearTextoSql( lxHerpackMovent ) + "'">>, "Obs" = <<"'" + this.FormatearTextoSql( lxHerpackObs ) + "'">>, "Movsal" = <<"'" + this.FormatearTextoSql( lxHerpackMovsal ) + "'">>, "Motivo" = <<"'" + this.FormatearTextoSql( lxHerpackMotivo ) + "'">>, "Vendedor" = <<"'" + this.FormatearTextoSql( lxHerpackVendedor ) + "'">>, "Fecha" = <<"'" + this.ConvertirDateSql( lxHerpackFecha ) + "'">>, "Accion" = <<lxHerpackAccion>> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'HERPACK' 
		loColeccion.agregar( strtran(  lcSentencia, chr( 9 ), '' ) )
			loColeccion.Agregar([delete from ZooLogic.HerPackDet where "Numero" = ] + transform( .oEntidad.NUMERO ))

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.DetallePacks
				if this.oEntidad.DetallePacks.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxComportamiento = loItem.Comportamiento
					lxNroitem = lnContadorNroItem
					lxNoprocesarstock = loItem.Noprocesarstock
					lxEquivalencia_PK = loItem.Equivalencia_PK
					lxArticulo_PK = loItem.Articulo_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxTalle_PK = loItem.Talle_PK
					lxCantidad = loItem.Cantidad
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.HerPackDet("COMP","NROITEM","ProcStock","NUMERO","EQUIV","PACKS","PACKSDET","CODCOL","COLDET","TALLE","CANT" ) values ( <<lxComportamiento>>, <<lxNroitem>>, <<iif( lxNoprocesarstock, 1, 0 )>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxEquivalencia_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<lxCantidad>> ) 
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
			lxValorClavePrimaria = this.oEntidad.NUMERO
			lcValorClavePrimariaString = transform( this.oEntidad.NUMERO )

			lcFiltro = ["Numero" = ] + lcValorClavePrimariaString  + [ and  HERPACK.NUMERO != 0]
		loColeccion.Agregar( 'delete from ZooLogic.HERPACK where ' + lcFiltro )
			loColeccion.Agregar([delete from ZooLogic.HerPackDet where "Numero" = ] + transform( .oEntidad.NUMERO ))
			loColeccion.cTabla = 'HERPACK' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.HERPACK where  HERPACK.NUMERO != 0" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.HERPACK where Numero = " + transform( this.oEntidad.NUMERO )+ " and  HERPACK.NUMERO != 0" )
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
		lcCursor = This.oEntidad.cPrefijoRecibir + 'HERRAMIENTAAGRUPADORADEPACKS'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.HERPACK Where Numero = ] + transform( &lcCursor..Numero ), 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					this.oConexion.EjecutarSql( [UPDATE ZooLogic.HERPACK set  FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, Numero = ] + transform( &lcCursor..Numero )+ [, MovEnt = ] + "'" + this.FormatearTextoSql( &lcCursor..MovEnt ) + "'"+ [, Obs = ] + "'" + this.FormatearTextoSql( &lcCursor..Obs ) + "'"+ [, MovSal = ] + "'" + this.FormatearTextoSql( &lcCursor..MovSal ) + "'"+ [, Motivo = ] + "'" + this.FormatearTextoSql( &lcCursor..Motivo ) + "'"+ [, Vendedor = ] + "'" + this.FormatearTextoSql( &lcCursor..Vendedor ) + "'"+ [, Fecha = ] + "'" + this.ConvertirDateSql( &lcCursor..Fecha ) + "'"+ [, Accion = ] + transform( &lcCursor..Accion ) + [ Where Numero = ] + transform( &lcCursor..Numero ) )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
				endIf
			else
				Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
				Text to lcCampos noShow
					 FECIMPO, FECTRANS, FMODIFW, FALTAFW, FECEXPO, SALTAFW, HORAIMPO, HMODIFW, SMODIFW, UMODIFW, UALTAFW, ZADSFW, VALTAFW, VMODIFW, HORAEXPO, HALTAFW, BDMODIFW, BDALTAFW, ESTTRANS, Numero, MovEnt, Obs, MovSal, Motivo, Vendedor, Fecha, Accion
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + transform( &lcCursor..Numero ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..MovEnt ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..Obs ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..MovSal ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Motivo ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Vendedor ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..Fecha ) + "'" + ',' + transform( &lcCursor..Accion )
lcValoresCampos = substr(lcValoresCampos,2) 

				this.oConexion.EjecutarSql( [Insert into ZooLogic.HERPACK ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
				this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'HERRAMIENTAAGRUPADORADEPACKS'
		if This.ActualizaEnRecepcion()
		Local lcIn as String, lcCantRegistros as Integer
		Select( lcCursor )
		Count to lcCantRegistros
		If lcCantRegistros > 0
			lcIn = This.ObtenerInSqlServer( lcCursor, 'Numero','N')
			lnFragmento = goRegistry.nucleo.cantidadDeElementosEnSentenciaInSQL
			loIn = this.ObtenerColeccionInSqlServer( lcCursor,'','Numero')
			llEjecutaEnTransaccion = loIn.count > 0
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'BEGIN TRANSACTION' )
			endif
			for i = 1 to loIn.count step lnFragmento
				lcIn = this.ObtenerFragmentoColeccionInSqlServer( loIn, i, lnFragmento )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.HerPackDet Where Numero] + lcIn  )
			endfor
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'COMMIT TRANSACTION' )
			endif
		EndIf
	endif
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMAGRUPADORDEPACK'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where Numero in ( select transform( Numero ) from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"COMP","NROITEM","ProcStock","NUMERO","EQUIV","PACKS","PACKSDET","CODCOL","COLDET","TALLE","CANT"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.HerPackDet ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.COMP       ) + ',' + transform( cDetallesExistentes.NROITEM    ) + ',' + Transform( iif( cDetallesExistentes.ProcStock , 1, 0 )) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.NUMERO     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.EQUIV      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.PACKS      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.PACKSDET   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CODCOL     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.COLDET     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.TALLE      ) + "'" + ',' + transform( cDetallesExistentes.CANT       ) + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	Use in select( 'cExistentes' )
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearCursorMemo( tcCursorACrear as String, tcTablaConMemo as String ) as Void
		create cursor &tcCursorACrear ( Numero N (10) , Orden N(16), texto C(80))
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirComponentes() As Void
		
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function ObtenerIdentificadorParaLoguear( tcCursor as String ) As String
		local lcRetorno as String, lnCC as String , loCC as Object, lni as Integer, lcSecuencia as String
		lcRetorno = this.oEntidad.cDescripcion 
		lcRetorno = lcRetorno + ' - Número: ' + transform( &tcCursor..Numero     )
		Return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EsAliasDeProceso( tcAlias As String, tcPrefijo as string ) As Boolean
		local llRetorno as Boolean, lcAlias as String, lcPrefijo As String
		llRetorno = .F.
		lcAlias = upper( alltrim( tcAlias ) )
		lcPrefijo = upper( alltrim( tcPrefijo ) )
		Do Case
			Case  lcAlias == lcPrefijo + 'HERRAMIENTAAGRUPADORADEPACKS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'HERRAMIENTAAGRUPADORADEPACKS_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'HERRAMIENTAAGRUPADORADEPACKS_OBS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMAGRUPADORDEPACK'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_HerPack')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'HERRAMIENTAAGRUPADORADEPACKS'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..Numero
		llCondicion = isnull( lxVar )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad HERRAMIENTAAGRUPADORADEPACKS. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'HERRAMIENTAAGRUPADORADEPACKS'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		select recno() as _Rec, * from &lcCursor into cursor CurConRecno
		select max( _Rec ) as Maximo,Numero as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( Numero, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		Use in select( 'CurConRecno' )
		Use in select( 'RepMax' )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDatosInvalidos( toConexion as Object ) as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'HERRAMIENTAAGRUPADORADEPACKS'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  Fecha     
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_HerPack') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_HerPack
Create Table ZooLogic.TablaTrabajo_HerPack ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fecimpo" datetime  null, 
"fectrans" datetime  null, 
"fmodifw" datetime  null, 
"faltafw" datetime  null, 
"fecexpo" datetime  null, 
"saltafw" char( 7 )  null, 
"horaimpo" char( 8 )  null, 
"hmodifw" char( 8 )  null, 
"smodifw" char( 7 )  null, 
"umodifw" char( 100 )  null, 
"ualtafw" char( 100 )  null, 
"zadsfw" varchar(max)  null, 
"valtafw" char( 13 )  null, 
"vmodifw" char( 13 )  null, 
"horaexpo" char( 8 )  null, 
"haltafw" char( 8 )  null, 
"bdmodifw" char( 8 )  null, 
"bdaltafw" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"numero" numeric( 10, 0 )  null, 
"movent" char( 100 )  null, 
"obs" varchar(max)  null, 
"movsal" char( 100 )  null, 
"motivo" char( 3 )  null, 
"vendedor" char( 10 )  null, 
"fecha" datetime  null, 
"accion" numeric( 1, 0 )  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_HerPack' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_HerPack' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'HERRAMIENTAAGRUPADORADEPACKS'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		with loManejador
			if this.oEntidad.VerificarContexto( 'CB' )
			else
				.AgregarMapeo('Nrolinea','Nrolinea')
			endif
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('numero','numero')
			.AgregarMapeo('movent','movent')
			.AgregarMapeo('obs','obs')
			.AgregarMapeo('movsal','movsal')
			.AgregarMapeo('motivo','motivo')
			.AgregarMapeo('vendedor','vendedor')
			.AgregarMapeo('fecha','fecha')
			.AgregarMapeo('accion','accion')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_HerPack'
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
				Update t Set t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.NUMERO = isnull( d.NUMERO, t.NUMERO ),t.MOVENT = isnull( d.MOVENT, t.MOVENT ),t.OBS = isnull( d.OBS, t.OBS ),t.MOVSAL = isnull( d.MOVSAL, t.MOVSAL ),t.MOTIVO = isnull( d.MOTIVO, t.MOTIVO ),t.VENDEDOR = isnull( d.VENDEDOR, t.VENDEDOR ),t.FECHA = isnull( d.FECHA, t.FECHA ),t.ACCION = isnull( d.ACCION, t.ACCION )
					from ZooLogic.HERPACK t inner join deleted d 
							 on t.Numero = d.Numero
				-- Fin Updates
				insert into ZooLogic.HERPACK(Fecimpo,Fectrans,Fmodifw,Faltafw,Fecexpo,Saltafw,Horaimpo,Hmodifw,Smodifw,Umodifw,Ualtafw,Zadsfw,Valtafw,Vmodifw,Horaexpo,Haltafw,Bdmodifw,Bdaltafw,Esttrans,Numero,Movent,Obs,Movsal,Motivo,Vendedor,Fecha,Accion)
					Select isnull( d.FECIMPO,''),isnull( d.FECTRANS,''),isnull( d.FMODIFW,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FECEXPO,''),isnull( d.SALTAFW,''),isnull( d.HORAIMPO,''),isnull( d.HMODIFW,''),isnull( d.SMODIFW,''),isnull( d.UMODIFW,''),isnull( d.UALTAFW,''),isnull( d.ZADSFW,''),isnull( d.VALTAFW,''),isnull( d.VMODIFW,''),isnull( d.HORAEXPO,''),convert( char(8), getdate(), 108 ),isnull( d.BDMODIFW,''),isnull( d.BDALTAFW,''),isnull( d.ESTTRANS,''),isnull( d.NUMERO,0),isnull( d.MOVENT,''),isnull( d.OBS,''),isnull( d.MOVSAL,''),isnull( d.MOTIVO,''),isnull( d.VENDEDOR,''),isnull( d.FECHA,''),isnull( d.ACCION,0)
						From deleted d left join ZooLogic.HERPACK pk 
							 on d.Numero = pk.Numero
						Where pk.Numero Is Null 
				-- Fin Inserts
			End
		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_HerPackDet( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_HERPACK_HerPackDet
ON ZooLogic.TablaTrabajo_HERPACK_HerPackDet
AFTER DELETE
As
Begin
Update t Set 
t.COMP = isnull( d.COMP, t.COMP ),
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.PROCSTOCK = isnull( d.PROCSTOCK, t.PROCSTOCK ),
t.NUMERO = isnull( d.NUMERO, t.NUMERO ),
t.EQUIV = isnull( d.EQUIV, t.EQUIV ),
t.PACKS = isnull( d.PACKS, t.PACKS ),
t.PACKSDET = isnull( d.PACKSDET, t.PACKSDET ),
t.CODCOL = isnull( d.CODCOL, t.CODCOL ),
t.COLDET = isnull( d.COLDET, t.COLDET ),
t.TALLE = isnull( d.TALLE, t.TALLE ),
t.CANT = isnull( d.CANT, t.CANT )
from ZooLogic.HerPackDet t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.HerPackDet
( 
"COMP",
"NROITEM",
"PROCSTOCK",
"NUMERO",
"EQUIV",
"PACKS",
"PACKSDET",
"CODCOL",
"COLDET",
"TALLE",
"CANT"
 )
Select 
d.COMP,
d.NROITEM,
d.PROCSTOCK,
d.NUMERO,
d.EQUIV,
d.PACKS,
d.PACKSDET,
d.CODCOL,
d.COLDET,
d.TALLE,
d.CANT
From deleted d left join ZooLogic.HerPackDet pk 
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_HerPack') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_HerPack
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_HERRAMIENTAAGRUPADORADEPACKS' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_HERRAMIENTAAGRUPADORADEPACKS.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_HERRAMIENTAAGRUPADORADEPACKS.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_HERRAMIENTAAGRUPADORADEPACKS.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_HERRAMIENTAAGRUPADORADEPACKS.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_HERRAMIENTAAGRUPADORADEPACKS.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Seriealtafw = nvl( c_HERRAMIENTAAGRUPADORADEPACKS.Seriealtafw, [] )
					.Horaimpo = nvl( c_HERRAMIENTAAGRUPADORADEPACKS.Horaimpo, [] )
					.Horamodificacionfw = nvl( c_HERRAMIENTAAGRUPADORADEPACKS.Horamodificacionfw, [] )
					.Seriemodificacionfw = nvl( c_HERRAMIENTAAGRUPADORADEPACKS.Seriemodificacionfw, [] )
					.Usuariomodificacionfw = nvl( c_HERRAMIENTAAGRUPADORADEPACKS.Usuariomodificacionfw, [] )
					.Usuarioaltafw = nvl( c_HERRAMIENTAAGRUPADORADEPACKS.Usuarioaltafw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Versionaltafw = nvl( c_HERRAMIENTAAGRUPADORADEPACKS.Versionaltafw, [] )
					.Versionmodificacionfw = nvl( c_HERRAMIENTAAGRUPADORADEPACKS.Versionmodificacionfw, [] )
					.Horaexpo = nvl( c_HERRAMIENTAAGRUPADORADEPACKS.Horaexpo, [] )
					.Horaaltafw = nvl( c_HERRAMIENTAAGRUPADORADEPACKS.Horaaltafw, [] )
					.Basededatosmodificacionfw = nvl( c_HERRAMIENTAAGRUPADORADEPACKS.Basededatosmodificacionfw, [] )
					.Basededatosaltafw = nvl( c_HERRAMIENTAAGRUPADORADEPACKS.Basededatosaltafw, [] )
					.Estadotransferencia = nvl( c_HERRAMIENTAAGRUPADORADEPACKS.Estadotransferencia, [] )
					.Numero = nvl( c_HERRAMIENTAAGRUPADORADEPACKS.Numero, 0 )
					.Moventrada = nvl( c_HERRAMIENTAAGRUPADORADEPACKS.Moventrada, [] )
					lcValor = This.ObtenerMemo( 'c_Observacion')
					.Observacion = lcValor 
					.Detallepacks.Limpiar()
					.Detallepacks.SetearEsNavegacion( .lProcesando )
					.Detallepacks.Cargar()
					.Movsalida = nvl( c_HERRAMIENTAAGRUPADORADEPACKS.Movsalida, [] )
					.Motivo_PK =  nvl( c_HERRAMIENTAAGRUPADORADEPACKS.Motivo, [] )
					.Vendedor_PK =  nvl( c_HERRAMIENTAAGRUPADORADEPACKS.Vendedor, [] )
					.Fecha = GoLibrerias.ObtenerFechaFormateada( nvl( c_HERRAMIENTAAGRUPADORADEPACKS.Fecha, ctod( '  /  /    ' ) ) )
					.Accion = nvl( c_HERRAMIENTAAGRUPADORADEPACKS.Accion, 0 )
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
		
		loDetalle = this.oEntidad.DetallePacks
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
		return c_HERRAMIENTAAGRUPADORADEPACKS.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.HERPACK' )
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
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "Numero"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
		text to lcSQL textmerge noshow
				SELECT nro,totalRegistros,Numero as Id
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    Numero from (
							select * 
								from ZooLogic.HERPACK 
								Where   HERPACK.NUMERO != 0
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "HERPACK", "", lcCursor, set("Datasession") )
		lcXml = this.CursorAXml( lcCursor )
		
		use in select( lcCursor )
		
		Return lcXml 
		
	endfunc
	*-----------------------------------------------------------------------------------------
	function ObtenerDatosEntidadPaginado( tcOrderBy as String, tcFiltro as String, tnCantidad as Integer, tnPagina as Integer )  as String
		local lcOrderBy as String, lnCuantos as Integer, lnPagina as Integer, lnTope as Integer, lnDesde as Integer, lcSQL as String, lcCursor as String, lcXml as String
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "Numero"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
			text to lcAtributos textmerge noshow
			"Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Numero" as "Numero", "Movent" as "Moventrada", "Obs" as "Observacion", "Movsal" as "Movsalida", "Motivo" as "Motivo", "Vendedor" as "Vendedor", "Fecha" as "Fecha", "Accion" as "Accion"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.HERPACK 
								Where   HERPACK.NUMERO != 0
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
	Tabla = 'HERPACK'
	Filtro = " HERPACK.NUMERO != 0"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " HERPACK.NUMERO != 0"
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
	<row entidad="HERRAMIENTAAGRUPADORADEPACKS            " atributo="FECHAIMPO                               " tabla="HERPACK        " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="HERRAMIENTAAGRUPADORADEPACKS            " atributo="FECHATRANSFERENCIA                      " tabla="HERPACK        " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha de novedad                                                                                                                                                " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="HERRAMIENTAAGRUPADORADEPACKS            " atributo="FECHAMODIFICACIONFW                     " tabla="HERPACK        " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="HERRAMIENTAAGRUPADORADEPACKS            " atributo="FECHAALTAFW                             " tabla="HERPACK        " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="HERRAMIENTAAGRUPADORADEPACKS            " atributo="FECHAEXPO                               " tabla="HERPACK        " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="HERRAMIENTAAGRUPADORADEPACKS            " atributo="SERIEALTAFW                             " tabla="HERPACK        " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="HERRAMIENTAAGRUPADORADEPACKS            " atributo="HORAIMPO                                " tabla="HERPACK        " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="HERRAMIENTAAGRUPADORADEPACKS            " atributo="HORAMODIFICACIONFW                      " tabla="HERPACK        " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="HERRAMIENTAAGRUPADORADEPACKS            " atributo="SERIEMODIFICACIONFW                     " tabla="HERPACK        " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="HERRAMIENTAAGRUPADORADEPACKS            " atributo="USUARIOMODIFICACIONFW                   " tabla="HERPACK        " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="HERRAMIENTAAGRUPADORADEPACKS            " atributo="USUARIOALTAFW                           " tabla="HERPACK        " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="HERRAMIENTAAGRUPADORADEPACKS            " atributo="ZADSFW                                  " tabla="HERPACK        " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="HERRAMIENTAAGRUPADORADEPACKS            " atributo="VERSIONALTAFW                           " tabla="HERPACK        " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="HERRAMIENTAAGRUPADORADEPACKS            " atributo="VERSIONMODIFICACIONFW                   " tabla="HERPACK        " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="HERRAMIENTAAGRUPADORADEPACKS            " atributo="HORAEXPO                                " tabla="HERPACK        " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="HERRAMIENTAAGRUPADORADEPACKS            " atributo="HORAALTAFW                              " tabla="HERPACK        " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="HERRAMIENTAAGRUPADORADEPACKS            " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="HERPACK        " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="HERRAMIENTAAGRUPADORADEPACKS            " atributo="BASEDEDATOSALTAFW                       " tabla="HERPACK        " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="HERRAMIENTAAGRUPADORADEPACKS            " atributo="ESTADOTRANSFERENCIA                     " tabla="HERPACK        " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado de novedad                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="HERRAMIENTAAGRUPADORADEPACKS            " atributo="NUMERO                                  " tabla="HERPACK        " campo="NUMERO    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="2" etiqueta="Número                                                                                                                                                          " dominio="CODIGONUMERICO                " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="HERRAMIENTAAGRUPADORADEPACKS            " atributo="MOVENTRADA                              " tabla="HERPACK        " campo="MOVENT    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Entrada                                                                                                                                                         " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="6" orden="1" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="HERRAMIENTAAGRUPADORADEPACKS            " atributo="OBSERVACION                             " tabla="HERPACK        " campo="OBS       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="Observaciones                                                                                                                                                   " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="7" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="HERRAMIENTAAGRUPADORADEPACKS            " atributo="DETALLEPACKS                            " tabla="HERPACKDET     " campo="NUMERO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="402" etiqueta="Packs                                                                                                                                                           " dominio="DETALLEITEMAGRUPADORDEPACK    " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="HERRAMIENTAAGRUPADORADEPACKS            " atributo="MOVSALIDA                               " tabla="HERPACK        " campo="MOVSAL    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Salida                                                                                                                                                          " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="6" orden="2" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="HERRAMIENTAAGRUPADORADEPACKS            " atributo="MOTIVO                                  " tabla="HERPACK        " campo="MOTIVO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="MOTIVO                                  " tipodato="C         " longitud="3" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="6" etiqueta="Motivo                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="HERRAMIENTAAGRUPADORADEPACKS            " atributo="VENDEDOR                                " tabla="HERPACK        " campo="VENDEDOR  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="VENDEDOR                                " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="404" etiqueta="Vendedor                                                                                                                                                        " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="HERRAMIENTAAGRUPADORADEPACKS            " atributo="FECHA                                   " tabla="HERPACK        " campo="FECHA     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goServicios.Librerias.ObtenerFecha()                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="406" etiqueta="Fecha                                                                                                                                                           " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="4" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="HERRAMIENTAAGRUPADORADEPACKS            " atributo="ACCION                                  " tabla="HERPACK        " campo="ACCION    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="4" etiqueta="Acción                                                                                                                                                          " dominio="COMBOXML                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="5" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MOTIVO                                  " atributo="DESCRIPCION                             " tabla="MOTIVO         " campo="MOTDES    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="7" etiqueta="Detalle Mot.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join MOTIVO On HERPACK.MOTIVO = MOTIVO.MOTCOD And  MOTIVO.MOTCOD != ''                                                                                                                                                                                  " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VENDEDOR                                " atributo="NOMBRE                                  " tabla="VEN            " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="405" etiqueta="Detalle Ven.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join VEN On HERPACK.VENDEDOR = VEN.CLCOD And  VEN.CLCOD != ''                                                                                                                                                                                           " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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