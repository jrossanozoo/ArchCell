
define class Din_EntidadTALLERAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_TALLER'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = []
	cExpresionCCPorCampos = []
	cTagClaveCandidata = ''
	cTagClavePk = '_TLLPK'
	cTablaPrincipal = 'TALLER'
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
			local  lxTallerFecimpo, lxTallerFectrans, lxTallerFmodifw, lxTallerFaltafw, lxTallerFecexpo, lxTallerValtafw, lxTallerSaltafw, lxTallerHmodifw, lxTallerHoraexpo, lxTallerHaltafw, lxTallerSmodifw, lxTallerEsttrans, lxTallerVmodifw, lxTallerZadsfw, lxTallerUmodifw, lxTallerUaltafw, lxTallerBdmodifw, lxTallerBdaltafw, lxTallerHoraimpo, lxTallerObs, lxTallerCodigo, lxTallerDescrip, lxTallerTipo, lxTallerProveedor, lxTallerInventario, lxTallerListacosto, lxTallerInsumos, lxTallerDescartes
				lxTallerFecimpo =  .Fechaimpo			lxTallerFectrans =  .Fechatransferencia			lxTallerFmodifw =  .Fechamodificacionfw			lxTallerFaltafw =  .Fechaaltafw			lxTallerFecexpo =  .Fechaexpo			lxTallerValtafw =  .Versionaltafw			lxTallerSaltafw =  .Seriealtafw			lxTallerHmodifw =  .Horamodificacionfw			lxTallerHoraexpo =  .Horaexpo			lxTallerHaltafw =  .Horaaltafw			lxTallerSmodifw =  .Seriemodificacionfw			lxTallerEsttrans =  .Estadotransferencia			lxTallerVmodifw =  .Versionmodificacionfw			lxTallerZadsfw =  .Zadsfw			lxTallerUmodifw =  .Usuariomodificacionfw			lxTallerUaltafw =  .Usuarioaltafw			lxTallerBdmodifw =  .Basededatosmodificacionfw			lxTallerBdaltafw =  .Basededatosaltafw			lxTallerHoraimpo =  .Horaimpo			lxTallerObs =  .Obs			lxTallerCodigo =  .Codigo			lxTallerDescrip =  .Descripcion			lxTallerTipo =  .Tipotaller			lxTallerProveedor =  upper( .Proveedor_PK ) 			lxTallerInventario =  upper( .Inventario_PK ) 			lxTallerListacosto =  upper( .ListaDeCosto_PK ) 			lxTallerInsumos =  .Insumoenliquidacion			lxTallerDescartes =  .Descarteenliquidacion
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxTallerCodigo = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.TALLER ( "Fecimpo","Fectrans","Fmodifw","Faltafw","Fecexpo","Valtafw","Saltafw","Hmodifw","Horaexpo","Haltafw","Smodifw","Esttrans","Vmodifw","Zadsfw","Umodifw","Ualtafw","Bdmodifw","Bdaltafw","Horaimpo","Obs","Codigo","Descrip","Tipo","Proveedor","Inventario","Listacosto","Insumos","Descartes" ) values ( <<"'" + this.ConvertirDateSql( lxTallerFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxTallerFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxTallerFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxTallerFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxTallerFecexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTallerValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTallerSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTallerHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTallerHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTallerHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTallerSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTallerEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTallerVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTallerZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTallerUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTallerUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTallerBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTallerBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTallerHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTallerObs ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTallerCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTallerDescrip ) + "'" >>, <<lxTallerTipo >>, <<"'" + this.FormatearTextoSql( lxTallerProveedor ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTallerInventario ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTallerListacosto ) + "'" >>, <<lxTallerInsumos >>, <<lxTallerDescartes >> )
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
		this.ComprobarTransaccion()
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = lxValorClavePrimaria


			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.Procesos
				if this.oEntidad.Procesos.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxProceso_PK = loItem.Proceso_PK
					lxProcesodescripcion = loItem.Procesodescripcion
					lxInventarioentrada_PK = loItem.Inventarioentrada_PK
					lxInventariosalida_PK = loItem.Inventariosalida_PK
					lxListadecosto_PK = loItem.Listadecosto_PK
					lxInsumoenliquidacion = loItem.Insumoenliquidacion
					lxDescarteenliquidacion = loItem.Descarteenliquidacion
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.TALLERPROC("NROITEM","CodProc","Proceso","ProcDet","InvEnt","InvSal","LCosto","Insumos","Descartes" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxProceso_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxProcesodescripcion ) + "'">>, <<"'" + this.FormatearTextoSql( lxInventarioentrada_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxInventariosalida_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxListadecosto_PK ) + "'">>, <<lxInsumoenliquidacion>>, <<lxDescarteenliquidacion>> ) 
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
			local  lxTallerFecimpo, lxTallerFectrans, lxTallerFmodifw, lxTallerFaltafw, lxTallerFecexpo, lxTallerValtafw, lxTallerSaltafw, lxTallerHmodifw, lxTallerHoraexpo, lxTallerHaltafw, lxTallerSmodifw, lxTallerEsttrans, lxTallerVmodifw, lxTallerZadsfw, lxTallerUmodifw, lxTallerUaltafw, lxTallerBdmodifw, lxTallerBdaltafw, lxTallerHoraimpo, lxTallerObs, lxTallerCodigo, lxTallerDescrip, lxTallerTipo, lxTallerProveedor, lxTallerInventario, lxTallerListacosto, lxTallerInsumos, lxTallerDescartes
				lxTallerFecimpo =  .Fechaimpo			lxTallerFectrans =  .Fechatransferencia			lxTallerFmodifw =  .Fechamodificacionfw			lxTallerFaltafw =  .Fechaaltafw			lxTallerFecexpo =  .Fechaexpo			lxTallerValtafw =  .Versionaltafw			lxTallerSaltafw =  .Seriealtafw			lxTallerHmodifw =  .Horamodificacionfw			lxTallerHoraexpo =  .Horaexpo			lxTallerHaltafw =  .Horaaltafw			lxTallerSmodifw =  .Seriemodificacionfw			lxTallerEsttrans =  .Estadotransferencia			lxTallerVmodifw =  .Versionmodificacionfw			lxTallerZadsfw =  .Zadsfw			lxTallerUmodifw =  .Usuariomodificacionfw			lxTallerUaltafw =  .Usuarioaltafw			lxTallerBdmodifw =  .Basededatosmodificacionfw			lxTallerBdaltafw =  .Basededatosaltafw			lxTallerHoraimpo =  .Horaimpo			lxTallerObs =  .Obs			lxTallerCodigo =  .Codigo			lxTallerDescrip =  .Descripcion			lxTallerTipo =  .Tipotaller			lxTallerProveedor =  upper( .Proveedor_PK ) 			lxTallerInventario =  upper( .Inventario_PK ) 			lxTallerListacosto =  upper( .ListaDeCosto_PK ) 			lxTallerInsumos =  .Insumoenliquidacion			lxTallerDescartes =  .Descarteenliquidacion
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()
			lxValorClavePrimaria = .oEntidad.CODIGO
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ZooLogic.TALLER set "Fecimpo" = <<"'" + this.ConvertirDateSql( lxTallerFecimpo ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxTallerFectrans ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxTallerFmodifw ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxTallerFaltafw ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxTallerFecexpo ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxTallerValtafw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxTallerSaltafw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxTallerHmodifw ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxTallerHoraexpo ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxTallerHaltafw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxTallerSmodifw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxTallerEsttrans ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxTallerVmodifw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxTallerZadsfw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxTallerUmodifw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxTallerUaltafw ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxTallerBdmodifw ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxTallerBdaltafw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxTallerHoraimpo ) + "'">>,"Obs" = <<"'" + this.FormatearTextoSql( lxTallerObs ) + "'">>,"Codigo" = <<"'" + this.FormatearTextoSql( lxTallerCodigo ) + "'">>,"Descrip" = <<"'" + this.FormatearTextoSql( lxTallerDescrip ) + "'">>,"Tipo" = <<lxTallerTipo>>,"Proveedor" = <<"'" + this.FormatearTextoSql( lxTallerProveedor ) + "'">>,"Inventario" = <<"'" + this.FormatearTextoSql( lxTallerInventario ) + "'">>,"Listacosto" = <<"'" + this.FormatearTextoSql( lxTallerListacosto ) + "'">>,"Insumos" = <<lxTallerInsumos>>,"Descartes" = <<lxTallerDescartes>> where "Codigo" = <<"'" + this.FormatearTextoSql( lxTallerCodigo ) + "'">> and  TALLER.CODIGO != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			this.ComprobarResultadoDeEjecucionDelUpdate()
		this.ComprobarTransaccion()
			this.oConexion.EjecutarSql( 'delete from ZooLogic.TALLERPROC where "CodProc" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.Procesos
				if this.oEntidad.Procesos.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxProceso_PK = loItem.Proceso_PK
					lxProcesodescripcion = loItem.Procesodescripcion
					lxInventarioentrada_PK = loItem.Inventarioentrada_PK
					lxInventariosalida_PK = loItem.Inventariosalida_PK
					lxListadecosto_PK = loItem.Listadecosto_PK
					lxInsumoenliquidacion = loItem.Insumoenliquidacion
					lxDescarteenliquidacion = loItem.Descarteenliquidacion
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.TALLERPROC("NROITEM","CodProc","Proceso","ProcDet","InvEnt","InvSal","LCosto","Insumos","Descartes" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxProceso_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxProcesodescripcion ) + "'">>, <<"'" + this.FormatearTextoSql( lxInventarioentrada_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxInventariosalida_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxListadecosto_PK ) + "'">>, <<lxInsumoenliquidacion>>, <<lxDescarteenliquidacion>> ) 
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 Codigo from ZooLogic.TALLER where " + this.ConvertirFuncionesSql( " TALLER.CODIGO != ''" ) )
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
			Local lxTallerCodigo
			lxTallerCodigo = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Valtafw" as "Versionaltafw", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Smodifw" as "Seriemodificacionfw", "Esttrans" as "Estadotransferencia", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Horaimpo" as "Horaimpo", "Obs" as "Obs", "Codigo" as "Codigo", "Descrip" as "Descripcion", "Tipo" as "Tipotaller", "Proveedor" as "Proveedor", "Inventario" as "Inventario", "Listacosto" as "Listadecosto", "Insumos" as "Insumoenliquidacion", "Descartes" as "Descarteenliquidacion" from ZooLogic.TALLER where "Codigo" = <<"'" + this.FormatearTextoSql( lxTallerCodigo ) + "'">> and  TALLER.CODIGO != ''
			endtext
			use in select('c_TALLER')
			this.oConexion.EjecutarSql( lcSentencia, 'c_TALLER', set( 'Datasession' ) )

			if reccount( 'c_TALLER' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codproc" as "Codigo", "Proceso" as "Proceso", "Procdet" as "Procesodescripcion", "Invent" as "Inventarioentrada", "Invsal" as "Inventariosalida", "Lcosto" as "Listadecosto", "Insumos" as "Insumoenliquidacion", "Descartes" as "Descarteenliquidacion" from ZooLogic.TALLERPROC where CodProc = <<"'" + this.FormatearTextoSql( c_TALLER.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_Procesos')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Procesos', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Procesos
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxTallerCodigo as Variant
		llRetorno = .t.
		lxTallerCodigo = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.TALLER where "Codigo" = <<"'" + this.FormatearTextoSql( lxTallerCodigo ) + "'">> and  TALLER.CODIGO != ''
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
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Valtafw" as "Versionaltafw", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Smodifw" as "Seriemodificacionfw", "Esttrans" as "Estadotransferencia", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Horaimpo" as "Horaimpo", "Obs" as "Obs", "Codigo" as "Codigo", "Descrip" as "Descripcion", "Tipo" as "Tipotaller", "Proveedor" as "Proveedor", "Inventario" as "Inventario", "Listacosto" as "Listadecosto", "Insumos" as "Insumoenliquidacion", "Descartes" as "Descarteenliquidacion" from ZooLogic.TALLER where  TALLER.CODIGO != '' order by Codigo
			endtext
			use in select('c_TALLER')
			this.oConexion.EjecutarSql( lcSentencia, 'c_TALLER', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codproc" as "Codigo", "Proceso" as "Proceso", "Procdet" as "Procesodescripcion", "Invent" as "Inventarioentrada", "Invsal" as "Inventariosalida", "Lcosto" as "Listadecosto", "Insumos" as "Insumoenliquidacion", "Descartes" as "Descarteenliquidacion" from ZooLogic.TALLERPROC where CodProc = <<"'" + this.FormatearTextoSql( c_TALLER.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_Procesos')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Procesos', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Procesos
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
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Valtafw" as "Versionaltafw", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Smodifw" as "Seriemodificacionfw", "Esttrans" as "Estadotransferencia", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Horaimpo" as "Horaimpo", "Obs" as "Obs", "Codigo" as "Codigo", "Descrip" as "Descripcion", "Tipo" as "Tipotaller", "Proveedor" as "Proveedor", "Inventario" as "Inventario", "Listacosto" as "Listadecosto", "Insumos" as "Insumoenliquidacion", "Descartes" as "Descarteenliquidacion" from ZooLogic.TALLER where  funciones.padr( Codigo, 15, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  TALLER.CODIGO != '' order by Codigo
			endtext
			use in select('c_TALLER')
			this.oConexion.EjecutarSql( lcSentencia, 'c_TALLER', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codproc" as "Codigo", "Proceso" as "Proceso", "Procdet" as "Procesodescripcion", "Invent" as "Inventarioentrada", "Invsal" as "Inventariosalida", "Lcosto" as "Listadecosto", "Insumos" as "Insumoenliquidacion", "Descartes" as "Descarteenliquidacion" from ZooLogic.TALLERPROC where CodProc = <<"'" + this.FormatearTextoSql( c_TALLER.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_Procesos')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Procesos', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Procesos
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
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Valtafw" as "Versionaltafw", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Smodifw" as "Seriemodificacionfw", "Esttrans" as "Estadotransferencia", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Horaimpo" as "Horaimpo", "Obs" as "Obs", "Codigo" as "Codigo", "Descrip" as "Descripcion", "Tipo" as "Tipotaller", "Proveedor" as "Proveedor", "Inventario" as "Inventario", "Listacosto" as "Listadecosto", "Insumos" as "Insumoenliquidacion", "Descartes" as "Descarteenliquidacion" from ZooLogic.TALLER where  funciones.padr( Codigo, 15, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  TALLER.CODIGO != '' order by Codigo desc
			endtext
			use in select('c_TALLER')
			this.oConexion.EjecutarSql( lcSentencia, 'c_TALLER', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codproc" as "Codigo", "Proceso" as "Proceso", "Procdet" as "Procesodescripcion", "Invent" as "Inventarioentrada", "Invsal" as "Inventariosalida", "Lcosto" as "Listadecosto", "Insumos" as "Insumoenliquidacion", "Descartes" as "Descarteenliquidacion" from ZooLogic.TALLERPROC where CodProc = <<"'" + this.FormatearTextoSql( c_TALLER.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_Procesos')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Procesos', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Procesos
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
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Valtafw" as "Versionaltafw", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Smodifw" as "Seriemodificacionfw", "Esttrans" as "Estadotransferencia", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Horaimpo" as "Horaimpo", "Obs" as "Obs", "Codigo" as "Codigo", "Descrip" as "Descripcion", "Tipo" as "Tipotaller", "Proveedor" as "Proveedor", "Inventario" as "Inventario", "Listacosto" as "Listadecosto", "Insumos" as "Insumoenliquidacion", "Descartes" as "Descarteenliquidacion" from ZooLogic.TALLER where  TALLER.CODIGO != '' order by Codigo desc
			endtext
			use in select('c_TALLER')
			this.oConexion.EjecutarSql( lcSentencia, 'c_TALLER', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codproc" as "Codigo", "Proceso" as "Proceso", "Procdet" as "Procesodescripcion", "Invent" as "Inventarioentrada", "Invsal" as "Inventariosalida", "Lcosto" as "Listadecosto", "Insumos" as "Insumoenliquidacion", "Descartes" as "Descarteenliquidacion" from ZooLogic.TALLERPROC where CodProc = <<"'" + this.FormatearTextoSql( c_TALLER.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_Procesos')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Procesos', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Procesos
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
			lcXml = this.oConexion.EjecutarSql( "select Fecimpo,Fectrans,Fmodifw,Faltafw,Fecexpo,Valtafw,Saltafw,Hmodifw,Horaexpo,Haltafw,Smodifw,Es" + ;
"ttrans,Vmodifw,Zadsfw,Umodifw,Ualtafw,Bdmodifw,Bdaltafw,Horaimpo,Obs,Codigo,Descrip,Tipo,Proveedor,I" + ;
"nventario,Listacosto,Insumos,Descartes" + ;
" from ZooLogic.TALLER where  TALLER.CODIGO != '' and " + lcFiltro )
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
			local  lxTallerFecimpo, lxTallerFectrans, lxTallerFmodifw, lxTallerFaltafw, lxTallerFecexpo, lxTallerValtafw, lxTallerSaltafw, lxTallerHmodifw, lxTallerHoraexpo, lxTallerHaltafw, lxTallerSmodifw, lxTallerEsttrans, lxTallerVmodifw, lxTallerZadsfw, lxTallerUmodifw, lxTallerUaltafw, lxTallerBdmodifw, lxTallerBdaltafw, lxTallerHoraimpo, lxTallerObs, lxTallerCodigo, lxTallerDescrip, lxTallerTipo, lxTallerProveedor, lxTallerInventario, lxTallerListacosto, lxTallerInsumos, lxTallerDescartes
				lxTallerFecimpo = ctod( '  /  /    ' )			lxTallerFectrans = ctod( '  /  /    ' )			lxTallerFmodifw = ctod( '  /  /    ' )			lxTallerFaltafw = ctod( '  /  /    ' )			lxTallerFecexpo = ctod( '  /  /    ' )			lxTallerValtafw = []			lxTallerSaltafw = []			lxTallerHmodifw = []			lxTallerHoraexpo = []			lxTallerHaltafw = []			lxTallerSmodifw = []			lxTallerEsttrans = []			lxTallerVmodifw = []			lxTallerZadsfw = []			lxTallerUmodifw = []			lxTallerUaltafw = []			lxTallerBdmodifw = []			lxTallerBdaltafw = []			lxTallerHoraimpo = []			lxTallerObs = []			lxTallerCodigo = []			lxTallerDescrip = []			lxTallerTipo = 0			lxTallerProveedor = []			lxTallerInventario = []			lxTallerListacosto = []			lxTallerInsumos = 0			lxTallerDescartes = 0
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.TALLERPROC where "CodProc" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( [delete from ZooLogic.TALLER where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'TALLER' + '_' + tcCampo
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
		lcWhere = " Where  TALLER.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Valtafw" as "Versionaltafw", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Smodifw" as "Seriemodificacionfw", "Esttrans" as "Estadotransferencia", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Horaimpo" as "Horaimpo", "Obs" as "Obs", "Codigo" as "Codigo", "Descrip" as "Descripcion", "Tipo" as "Tipotaller", "Proveedor" as "Proveedor", "Inventario" as "Inventario", "Listacosto" as "Listadecosto", "Insumos" as "Insumoenliquidacion", "Descartes" as "Descarteenliquidacion"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'TALLER', '', tnTope )
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
	Function ObtenerDatosDetalleProcesos( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  TALLERPROC.CODPROC != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Nroitem" as "Nroitem", "Codproc" as "Codigo", "Proceso" as "Proceso", "Procdet" as "Procesodescripcion", "Invent" as "Inventarioentrada", "Invsal" as "Inventariosalida", "Lcosto" as "Listadecosto", "Insumos" as "Insumoenliquidacion", "Descartes" as "Descarteenliquidacion"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleProcesos( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'TALLERPROC', 'Procesos', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleProcesos( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleProcesos( lcAtributo )
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
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'OBS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'OBS AS OBS'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'DESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCRIP AS DESCRIPCION'
				Case lcAtributo == 'TIPOTALLER'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPO AS TIPOTALLER'
				Case lcAtributo == 'PROVEEDOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PROVEEDOR AS PROVEEDOR'
				Case lcAtributo == 'INVENTARIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'INVENTARIO AS INVENTARIO'
				Case lcAtributo == 'LISTADECOSTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LISTACOSTO AS LISTADECOSTO'
				Case lcAtributo == 'INSUMOENLIQUIDACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'INSUMOS AS INSUMOENLIQUIDACION'
				Case lcAtributo == 'DESCARTEENLIQUIDACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCARTES AS DESCARTEENLIQUIDACION'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleProcesos( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODPROC AS CODIGO'
				Case lcAtributo == 'PROCESO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PROCESO AS PROCESO'
				Case lcAtributo == 'PROCESODESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PROCDET AS PROCESODESCRIPCION'
				Case lcAtributo == 'INVENTARIOENTRADA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'INVENT AS INVENTARIOENTRADA'
				Case lcAtributo == 'INVENTARIOSALIDA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'INVSAL AS INVENTARIOSALIDA'
				Case lcAtributo == 'LISTADECOSTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LCOSTO AS LISTADECOSTO'
				Case lcAtributo == 'INSUMOENLIQUIDACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'INSUMOS AS INSUMOENLIQUIDACION'
				Case lcAtributo == 'DESCARTEENLIQUIDACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCARTES AS DESCARTEENLIQUIDACION'
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
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'OBS'
				lcCampo = 'OBS'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCION'
				lcCampo = 'DESCRIP'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOTALLER'
				lcCampo = 'TIPO'
			Case upper( alltrim( tcAtributo ) ) == 'PROVEEDOR'
				lcCampo = 'PROVEEDOR'
			Case upper( alltrim( tcAtributo ) ) == 'INVENTARIO'
				lcCampo = 'INVENTARIO'
			Case upper( alltrim( tcAtributo ) ) == 'LISTADECOSTO'
				lcCampo = 'LISTACOSTO'
			Case upper( alltrim( tcAtributo ) ) == 'INSUMOENLIQUIDACION'
				lcCampo = 'INSUMOS'
			Case upper( alltrim( tcAtributo ) ) == 'DESCARTEENLIQUIDACION'
				lcCampo = 'DESCARTES'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleProcesos( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODPROC'
			Case upper( alltrim( tcAtributo ) ) == 'PROCESO'
				lcCampo = 'PROCESO'
			Case upper( alltrim( tcAtributo ) ) == 'PROCESODESCRIPCION'
				lcCampo = 'PROCDET'
			Case upper( alltrim( tcAtributo ) ) == 'INVENTARIOENTRADA'
				lcCampo = 'INVENT'
			Case upper( alltrim( tcAtributo ) ) == 'INVENTARIOSALIDA'
				lcCampo = 'INVSAL'
			Case upper( alltrim( tcAtributo ) ) == 'LISTADECOSTO'
				lcCampo = 'LCOSTO'
			Case upper( alltrim( tcAtributo ) ) == 'INSUMOENLIQUIDACION'
				lcCampo = 'INSUMOS'
			Case upper( alltrim( tcAtributo ) ) == 'DESCARTEENLIQUIDACION'
				lcCampo = 'DESCARTES'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerTablaDetalle( tcDetalle as string ) as String
		local lcRetorno as string
		lcRetorno = ''
		if upper( alltrim( tcDetalle ) ) == 'PROCESOS'
			lcRetorno = 'TALLERPROC'
		EndIf
		return lcRetorno
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasInsert() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcSentencia as string, loItem as object
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxTallerFecimpo, lxTallerFectrans, lxTallerFmodifw, lxTallerFaltafw, lxTallerFecexpo, lxTallerValtafw, lxTallerSaltafw, lxTallerHmodifw, lxTallerHoraexpo, lxTallerHaltafw, lxTallerSmodifw, lxTallerEsttrans, lxTallerVmodifw, lxTallerZadsfw, lxTallerUmodifw, lxTallerUaltafw, lxTallerBdmodifw, lxTallerBdaltafw, lxTallerHoraimpo, lxTallerObs, lxTallerCodigo, lxTallerDescrip, lxTallerTipo, lxTallerProveedor, lxTallerInventario, lxTallerListacosto, lxTallerInsumos, lxTallerDescartes
				lxTallerFecimpo =  .Fechaimpo			lxTallerFectrans =  .Fechatransferencia			lxTallerFmodifw =  .Fechamodificacionfw			lxTallerFaltafw =  .Fechaaltafw			lxTallerFecexpo =  .Fechaexpo			lxTallerValtafw =  .Versionaltafw			lxTallerSaltafw =  .Seriealtafw			lxTallerHmodifw =  .Horamodificacionfw			lxTallerHoraexpo =  .Horaexpo			lxTallerHaltafw =  .Horaaltafw			lxTallerSmodifw =  .Seriemodificacionfw			lxTallerEsttrans =  .Estadotransferencia			lxTallerVmodifw =  .Versionmodificacionfw			lxTallerZadsfw =  .Zadsfw			lxTallerUmodifw =  .Usuariomodificacionfw			lxTallerUaltafw =  .Usuarioaltafw			lxTallerBdmodifw =  .Basededatosmodificacionfw			lxTallerBdaltafw =  .Basededatosaltafw			lxTallerHoraimpo =  .Horaimpo			lxTallerObs =  .Obs			lxTallerCodigo =  .Codigo			lxTallerDescrip =  .Descripcion			lxTallerTipo =  .Tipotaller			lxTallerProveedor =  upper( .Proveedor_PK ) 			lxTallerInventario =  upper( .Inventario_PK ) 			lxTallerListacosto =  upper( .ListaDeCosto_PK ) 			lxTallerInsumos =  .Insumoenliquidacion			lxTallerDescartes =  .Descarteenliquidacion
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.TALLER ( "Fecimpo","Fectrans","Fmodifw","Faltafw","Fecexpo","Valtafw","Saltafw","Hmodifw","Horaexpo","Haltafw","Smodifw","Esttrans","Vmodifw","Zadsfw","Umodifw","Ualtafw","Bdmodifw","Bdaltafw","Horaimpo","Obs","Codigo","Descrip","Tipo","Proveedor","Inventario","Listacosto","Insumos","Descartes" ) values ( <<"'" + this.ConvertirDateSql( lxTallerFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxTallerFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxTallerFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxTallerFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxTallerFecexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTallerValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTallerSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTallerHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTallerHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTallerHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTallerSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTallerEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTallerVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTallerZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTallerUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTallerUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTallerBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTallerBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTallerHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTallerObs ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTallerCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTallerDescrip ) + "'" >>, <<lxTallerTipo >>, <<"'" + this.FormatearTextoSql( lxTallerProveedor ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTallerInventario ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTallerListacosto ) + "'" >>, <<lxTallerInsumos >>, <<lxTallerDescartes >> )
		endtext
		loColeccion.cTabla = 'TALLER' 
		loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		With this
			local lcValorClavePrimariaString as String
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.Procesos
				if this.oEntidad.Procesos.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxProceso_PK = loItem.Proceso_PK
					lxProcesodescripcion = loItem.Procesodescripcion
					lxInventarioentrada_PK = loItem.Inventarioentrada_PK
					lxInventariosalida_PK = loItem.Inventariosalida_PK
					lxListadecosto_PK = loItem.Listadecosto_PK
					lxInsumoenliquidacion = loItem.Insumoenliquidacion
					lxDescarteenliquidacion = loItem.Descarteenliquidacion
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.TALLERPROC("NROITEM","CodProc","Proceso","ProcDet","InvEnt","InvSal","LCosto","Insumos","Descartes" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxProceso_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxProcesodescripcion ) + "'">>, <<"'" + this.FormatearTextoSql( lxInventarioentrada_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxInventariosalida_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxListadecosto_PK ) + "'">>, <<lxInsumoenliquidacion>>, <<lxDescarteenliquidacion>> ) 
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
			local  lxTallerFecimpo, lxTallerFectrans, lxTallerFmodifw, lxTallerFaltafw, lxTallerFecexpo, lxTallerValtafw, lxTallerSaltafw, lxTallerHmodifw, lxTallerHoraexpo, lxTallerHaltafw, lxTallerSmodifw, lxTallerEsttrans, lxTallerVmodifw, lxTallerZadsfw, lxTallerUmodifw, lxTallerUaltafw, lxTallerBdmodifw, lxTallerBdaltafw, lxTallerHoraimpo, lxTallerObs, lxTallerCodigo, lxTallerDescrip, lxTallerTipo, lxTallerProveedor, lxTallerInventario, lxTallerListacosto, lxTallerInsumos, lxTallerDescartes
				lxTallerFecimpo =  .Fechaimpo			lxTallerFectrans =  .Fechatransferencia			lxTallerFmodifw =  .Fechamodificacionfw			lxTallerFaltafw =  .Fechaaltafw			lxTallerFecexpo =  .Fechaexpo			lxTallerValtafw =  .Versionaltafw			lxTallerSaltafw =  .Seriealtafw			lxTallerHmodifw =  .Horamodificacionfw			lxTallerHoraexpo =  .Horaexpo			lxTallerHaltafw =  .Horaaltafw			lxTallerSmodifw =  .Seriemodificacionfw			lxTallerEsttrans =  .Estadotransferencia			lxTallerVmodifw =  .Versionmodificacionfw			lxTallerZadsfw =  .Zadsfw			lxTallerUmodifw =  .Usuariomodificacionfw			lxTallerUaltafw =  .Usuarioaltafw			lxTallerBdmodifw =  .Basededatosmodificacionfw			lxTallerBdaltafw =  .Basededatosaltafw			lxTallerHoraimpo =  .Horaimpo			lxTallerObs =  .Obs			lxTallerCodigo =  .Codigo			lxTallerDescrip =  .Descripcion			lxTallerTipo =  .Tipotaller			lxTallerProveedor =  upper( .Proveedor_PK ) 			lxTallerInventario =  upper( .Inventario_PK ) 			lxTallerListacosto =  upper( .ListaDeCosto_PK ) 			lxTallerInsumos =  .Insumoenliquidacion			lxTallerDescartes =  .Descarteenliquidacion
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  TALLER.CODIGO != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.TALLER set "Fecimpo" = <<"'" + this.ConvertirDateSql( lxTallerFecimpo ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxTallerFectrans ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxTallerFmodifw ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxTallerFaltafw ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxTallerFecexpo ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxTallerValtafw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxTallerSaltafw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxTallerHmodifw ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxTallerHoraexpo ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxTallerHaltafw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxTallerSmodifw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxTallerEsttrans ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxTallerVmodifw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxTallerZadsfw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxTallerUmodifw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxTallerUaltafw ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxTallerBdmodifw ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxTallerBdaltafw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxTallerHoraimpo ) + "'">>, "Obs" = <<"'" + this.FormatearTextoSql( lxTallerObs ) + "'">>, "Codigo" = <<"'" + this.FormatearTextoSql( lxTallerCodigo ) + "'">>, "Descrip" = <<"'" + this.FormatearTextoSql( lxTallerDescrip ) + "'">>, "Tipo" = <<lxTallerTipo>>, "Proveedor" = <<"'" + this.FormatearTextoSql( lxTallerProveedor ) + "'">>, "Inventario" = <<"'" + this.FormatearTextoSql( lxTallerInventario ) + "'">>, "Listacosto" = <<"'" + this.FormatearTextoSql( lxTallerListacosto ) + "'">>, "Insumos" = <<lxTallerInsumos>>, "Descartes" = <<lxTallerDescartes>> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'TALLER' 
		loColeccion.agregar( strtran(  lcSentencia, chr( 9 ), '' ) )
			loColeccion.Agregar([delete from ZooLogic.TALLERPROC where "CodProc" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.Procesos
				if this.oEntidad.Procesos.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxProceso_PK = loItem.Proceso_PK
					lxProcesodescripcion = loItem.Procesodescripcion
					lxInventarioentrada_PK = loItem.Inventarioentrada_PK
					lxInventariosalida_PK = loItem.Inventariosalida_PK
					lxListadecosto_PK = loItem.Listadecosto_PK
					lxInsumoenliquidacion = loItem.Insumoenliquidacion
					lxDescarteenliquidacion = loItem.Descarteenliquidacion
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.TALLERPROC("NROITEM","CodProc","Proceso","ProcDet","InvEnt","InvSal","LCosto","Insumos","Descartes" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxProceso_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxProcesodescripcion ) + "'">>, <<"'" + this.FormatearTextoSql( lxInventarioentrada_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxInventariosalida_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxListadecosto_PK ) + "'">>, <<lxInsumoenliquidacion>>, <<lxDescarteenliquidacion>> ) 
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

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  TALLER.CODIGO != '']
		loColeccion.Agregar( 'delete from ZooLogic.TALLER where ' + lcFiltro )
			loColeccion.Agregar([delete from ZooLogic.TALLERPROC where "CodProc" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.cTabla = 'TALLER' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.TALLER where  TALLER.CODIGO != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.TALLER where Codigo = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  TALLER.CODIGO != ''" )
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
		lcCursor = This.oEntidad.cPrefijoRecibir + 'TALLER'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.TALLER Where Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'", 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					this.oConexion.EjecutarSql( [UPDATE ZooLogic.TALLER set  FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, Obs = ] + "'" + this.FormatearTextoSql( &lcCursor..Obs ) + "'"+ [, Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'"+ [, Descrip = ] + "'" + this.FormatearTextoSql( &lcCursor..Descrip ) + "'"+ [, Tipo = ] + transform( &lcCursor..Tipo )+ [, Proveedor = ] + "'" + this.FormatearTextoSql( &lcCursor..Proveedor ) + "'"+ [, Inventario = ] + "'" + this.FormatearTextoSql( &lcCursor..Inventario ) + "'"+ [, ListaCosto = ] + "'" + this.FormatearTextoSql( &lcCursor..ListaCosto ) + "'"+ [, Insumos = ] + transform( &lcCursor..Insumos )+ [, Descartes = ] + transform( &lcCursor..Descartes ) + [ Where Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'" )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
				endIf
			else
				Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
				Text to lcCampos noShow
					 FECIMPO, FECTRANS, FMODIFW, FALTAFW, FECEXPO, VALTAFW, SALTAFW, HMODIFW, HORAEXPO, HALTAFW, SMODIFW, ESTTRANS, VMODIFW, ZADSFW, UMODIFW, UALTAFW, BDMODIFW, BDALTAFW, HORAIMPO, Obs, Codigo, Descrip, Tipo, Proveedor, Inventario, ListaCosto, Insumos, Descartes
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Obs ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..Descrip ) + "'" + ',' + transform( &lcCursor..Tipo ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..Proveedor ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Inventario ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ListaCosto ) + "'" + ',' + transform( &lcCursor..Insumos ) + ',' + transform( &lcCursor..Descartes )
lcValoresCampos = substr(lcValoresCampos,2) 

				this.oConexion.EjecutarSql( [Insert into ZooLogic.TALLER ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
				this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'TALLER'
		if This.ActualizaEnRecepcion()
		Local lcIn as String, lcCantRegistros as Integer
		Select( lcCursor )
		Count to lcCantRegistros
		If lcCantRegistros > 0
			lcIn = This.ObtenerInSqlServer( lcCursor, 'Codigo','C')
			lnFragmento = goRegistry.nucleo.cantidadDeElementosEnSentenciaInSQL
			loIn = this.ObtenerColeccionInSqlServer( lcCursor,'','Codigo')
			llEjecutaEnTransaccion = loIn.count > 0
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'BEGIN TRANSACTION' )
			endif
			for i = 1 to loIn.count step lnFragmento
				lcIn = this.ObtenerFragmentoColeccionInSqlServer( loIn, i, lnFragmento )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.TALLERPROC Where CodProc] + lcIn  )
			endfor
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'COMMIT TRANSACTION' )
			endif
		EndIf
	endif
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMTALLERPROCESO'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where CodProc in ( select Codigo from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"NROITEM","CodProc","Proceso","ProcDet","InvEnt","InvSal","LCosto","Insumos","Descartes"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.TALLERPROC ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CodProc    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Proceso    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ProcDet    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.InvEnt     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.InvSal     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.LCosto     ) + "'" + ',' + transform( cDetallesExistentes.Insumos    ) + ',' + transform( cDetallesExistentes.Descartes  ) + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	Use in select( 'cExistentes' )
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearCursorMemo( tcCursorACrear as String, tcTablaConMemo as String ) as Void
		create cursor &tcCursorACrear ( Codigo C (15) , Orden N(16), texto C(80))
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirComponentes() As Void
		
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function ObtenerIdentificadorParaLoguear( tcCursor as String ) As String
		local lcRetorno as String, lnCC as String , loCC as Object, lni as Integer, lcSecuencia as String
		lcRetorno = this.oEntidad.cDescripcion 
		lcRetorno = lcRetorno + ' - Código: ' + transform( &tcCursor..Codigo     )
		Return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EsAliasDeProceso( tcAlias As String, tcPrefijo as string ) As Boolean
		local llRetorno as Boolean, lcAlias as String, lcPrefijo As String
		llRetorno = .F.
		lcAlias = upper( alltrim( tcAlias ) )
		lcPrefijo = upper( alltrim( tcPrefijo ) )
		Do Case
			Case  lcAlias == lcPrefijo + 'TALLER'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'TALLER_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'TALLER_OBS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMTALLERPROCESO'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_TALLER')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'TALLER'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..Codigo
		llCondicion = isnull( lxVar )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad TALLER. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'TALLER'
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
			lcCursor = This.oEntidad.cPrefijoRecibir + 'TALLER'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_TALLER') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_TALLER
Create Table ZooLogic.TablaTrabajo_TALLER ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fecimpo" datetime  null, 
"fectrans" datetime  null, 
"fmodifw" datetime  null, 
"faltafw" datetime  null, 
"fecexpo" datetime  null, 
"valtafw" char( 13 )  null, 
"saltafw" char( 7 )  null, 
"hmodifw" char( 8 )  null, 
"horaexpo" char( 8 )  null, 
"haltafw" char( 8 )  null, 
"smodifw" char( 7 )  null, 
"esttrans" char( 20 )  null, 
"vmodifw" char( 13 )  null, 
"zadsfw" varchar(max)  null, 
"umodifw" char( 100 )  null, 
"ualtafw" char( 100 )  null, 
"bdmodifw" char( 8 )  null, 
"bdaltafw" char( 8 )  null, 
"horaimpo" char( 8 )  null, 
"obs" varchar(max)  null, 
"codigo" char( 15 )  null, 
"descrip" char( 100 )  null, 
"tipo" numeric( 2, 0 )  null, 
"proveedor" char( 10 )  null, 
"inventario" char( 15 )  null, 
"listacosto" char( 6 )  null, 
"insumos" numeric( 2, 0 )  null, 
"descartes" numeric( 2, 0 )  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_TALLER' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_TALLER' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'TALLER'
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
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('obs','obs')
			.AgregarMapeo('codigo','codigo')
			.AgregarMapeo('descrip','descrip')
			.AgregarMapeo('tipo','tipo')
			.AgregarMapeo('proveedor','proveedor')
			.AgregarMapeo('inventario','inventario')
			.AgregarMapeo('listacosto','listacosto')
			.AgregarMapeo('insumos','insumos')
			.AgregarMapeo('descartes','descartes')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_TALLER'
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
				Update t Set t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.OBS = isnull( d.OBS, t.OBS ),t.CODIGO = isnull( d.CODIGO, t.CODIGO ),t.DESCRIP = isnull( d.DESCRIP, t.DESCRIP ),t.TIPO = isnull( d.TIPO, t.TIPO ),t.PROVEEDOR = isnull( d.PROVEEDOR, t.PROVEEDOR ),t.INVENTARIO = isnull( d.INVENTARIO, t.INVENTARIO ),t.LISTACOSTO = isnull( d.LISTACOSTO, t.LISTACOSTO ),t.INSUMOS = isnull( d.INSUMOS, t.INSUMOS ),t.DESCARTES = isnull( d.DESCARTES, t.DESCARTES )
					from ZooLogic.TALLER t inner join deleted d 
							 on t.Codigo = d.Codigo
				-- Fin Updates
				insert into ZooLogic.TALLER(Fecimpo,Fectrans,Fmodifw,Faltafw,Fecexpo,Valtafw,Saltafw,Hmodifw,Horaexpo,Haltafw,Smodifw,Esttrans,Vmodifw,Zadsfw,Umodifw,Ualtafw,Bdmodifw,Bdaltafw,Horaimpo,Obs,Codigo,Descrip,Tipo,Proveedor,Inventario,Listacosto,Insumos,Descartes)
					Select isnull( d.FECIMPO,''),isnull( d.FECTRANS,''),isnull( d.FMODIFW,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FECEXPO,''),isnull( d.VALTAFW,''),isnull( d.SALTAFW,''),isnull( d.HMODIFW,''),isnull( d.HORAEXPO,''),convert( char(8), getdate(), 108 ),isnull( d.SMODIFW,''),isnull( d.ESTTRANS,''),isnull( d.VMODIFW,''),isnull( d.ZADSFW,''),isnull( d.UMODIFW,''),isnull( d.UALTAFW,''),isnull( d.BDMODIFW,''),isnull( d.BDALTAFW,''),isnull( d.HORAIMPO,''),isnull( d.OBS,''),isnull( d.CODIGO,''),isnull( d.DESCRIP,''),isnull( d.TIPO,0),isnull( d.PROVEEDOR,''),isnull( d.INVENTARIO,''),isnull( d.LISTACOSTO,''),isnull( d.INSUMOS,0),isnull( d.DESCARTES,0)
						From deleted d left join ZooLogic.TALLER pk 
							 on d.Codigo = pk.Codigo
						Where pk.Codigo Is Null 
				-- Fin Inserts
			End
		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_TALLERPROC( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_TALLER_TALLERPROC
ON ZooLogic.TablaTrabajo_TALLER_TALLERPROC
AFTER DELETE
As
Begin
Update t Set 
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.CODPROC = isnull( d.CODPROC, t.CODPROC ),
t.PROCESO = isnull( d.PROCESO, t.PROCESO ),
t.PROCDET = isnull( d.PROCDET, t.PROCDET ),
t.INVENT = isnull( d.INVENT, t.INVENT ),
t.INVSAL = isnull( d.INVSAL, t.INVSAL ),
t.LCOSTO = isnull( d.LCOSTO, t.LCOSTO ),
t.INSUMOS = isnull( d.INSUMOS, t.INSUMOS ),
t.DESCARTES = isnull( d.DESCARTES, t.DESCARTES )
from ZooLogic.TALLERPROC t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.TALLERPROC
( 
"NROITEM",
"CODPROC",
"PROCESO",
"PROCDET",
"INVENT",
"INVSAL",
"LCOSTO",
"INSUMOS",
"DESCARTES"
 )
Select 
d.NROITEM,
d.CODPROC,
d.PROCESO,
d.PROCDET,
d.INVENT,
d.INVSAL,
d.LCOSTO,
d.INSUMOS,
d.DESCARTES
From deleted d left join ZooLogic.TALLERPROC pk 
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_TALLER') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_TALLER
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_TALLER' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_TALLER.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_TALLER.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_TALLER.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_TALLER.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_TALLER.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Versionaltafw = nvl( c_TALLER.Versionaltafw, [] )
					.Seriealtafw = nvl( c_TALLER.Seriealtafw, [] )
					.Horamodificacionfw = nvl( c_TALLER.Horamodificacionfw, [] )
					.Horaexpo = nvl( c_TALLER.Horaexpo, [] )
					.Horaaltafw = nvl( c_TALLER.Horaaltafw, [] )
					.Seriemodificacionfw = nvl( c_TALLER.Seriemodificacionfw, [] )
					.Estadotransferencia = nvl( c_TALLER.Estadotransferencia, [] )
					.Versionmodificacionfw = nvl( c_TALLER.Versionmodificacionfw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Usuariomodificacionfw = nvl( c_TALLER.Usuariomodificacionfw, [] )
					.Usuarioaltafw = nvl( c_TALLER.Usuarioaltafw, [] )
					.Basededatosmodificacionfw = nvl( c_TALLER.Basededatosmodificacionfw, [] )
					.Basededatosaltafw = nvl( c_TALLER.Basededatosaltafw, [] )
					.Horaimpo = nvl( c_TALLER.Horaimpo, [] )
					lcValor = This.ObtenerMemo( 'c_Obs')
					.Obs = lcValor 
					.Procesos.Limpiar()
					.Procesos.SetearEsNavegacion( .lProcesando )
					.Procesos.Cargar()
					.Codigo = nvl( c_TALLER.Codigo, [] )
					.Descripcion = nvl( c_TALLER.Descripcion, [] )
					.Tipotaller = nvl( c_TALLER.Tipotaller, 0 )
					.Proveedor_PK =  nvl( c_TALLER.Proveedor, [] )
					.Inventario_PK =  nvl( c_TALLER.Inventario, [] )
					.Listadecosto_PK =  nvl( c_TALLER.Listadecosto, [] )
					.Insumoenliquidacion = nvl( c_TALLER.Insumoenliquidacion, 0 )
					.Descarteenliquidacion = nvl( c_TALLER.Descarteenliquidacion, 0 )
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
		
		loDetalle = this.oEntidad.Procesos
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
		return c_TALLER.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.TALLER' )
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
								from ZooLogic.TALLER 
								Where   TALLER.CODIGO != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "TALLER", "", lcCursor, set("Datasession") )
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
			"Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Valtafw" as "Versionaltafw", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Smodifw" as "Seriemodificacionfw", "Esttrans" as "Estadotransferencia", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Horaimpo" as "Horaimpo", "Obs" as "Obs", "Codigo" as "Codigo", "Descrip" as "Descripcion", "Tipo" as "Tipotaller", "Proveedor" as "Proveedor", "Inventario" as "Inventario", "Listacosto" as "Listadecosto", "Insumos" as "Insumoenliquidacion", "Descartes" as "Descarteenliquidacion"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.TALLER 
								Where   TALLER.CODIGO != ''
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
	Tabla = 'TALLER'
	Filtro = " TALLER.CODIGO != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " TALLER.CODIGO != ''"
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
	<row entidad="TALLER                                  " atributo="FECHAIMPO                               " tabla="TALLER         " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TALLER                                  " atributo="FECHATRANSFERENCIA                      " tabla="TALLER         " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha de novedad                                                                                                                                                " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TALLER                                  " atributo="FECHAMODIFICACIONFW                     " tabla="TALLER         " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TALLER                                  " atributo="FECHAALTAFW                             " tabla="TALLER         " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TALLER                                  " atributo="FECHAEXPO                               " tabla="TALLER         " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TALLER                                  " atributo="VERSIONALTAFW                           " tabla="TALLER         " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TALLER                                  " atributo="SERIEALTAFW                             " tabla="TALLER         " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TALLER                                  " atributo="HORAMODIFICACIONFW                      " tabla="TALLER         " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TALLER                                  " atributo="HORAEXPO                                " tabla="TALLER         " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TALLER                                  " atributo="HORAALTAFW                              " tabla="TALLER         " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TALLER                                  " atributo="SERIEMODIFICACIONFW                     " tabla="TALLER         " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TALLER                                  " atributo="ESTADOTRANSFERENCIA                     " tabla="TALLER         " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado de novedad                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TALLER                                  " atributo="VERSIONMODIFICACIONFW                   " tabla="TALLER         " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TALLER                                  " atributo="ZADSFW                                  " tabla="TALLER         " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TALLER                                  " atributo="USUARIOMODIFICACIONFW                   " tabla="TALLER         " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TALLER                                  " atributo="USUARIOALTAFW                           " tabla="TALLER         " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TALLER                                  " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="TALLER         " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TALLER                                  " atributo="BASEDEDATOSALTAFW                       " tabla="TALLER         " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TALLER                                  " atributo="HORAIMPO                                " tabla="TALLER         " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TALLER                                  " atributo="OBS                                     " tabla="TALLER         " campo="OBS       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="Observaciones                                                                                                                                                   " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TALLER                                  " atributo="PROCESOS                                " tabla="TALLERPROC     " campo="CODPROC   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="402" etiqueta="Procesos habilitados en el taller                                                                                                                               " dominio="DETALLEITEMTALLERPROCESO      " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="0" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TALLER                                  " atributo="CODIGO                                  " tabla="TALLER         " campo="CODIGO    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="2" etiqueta="Código                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TALLER                                  " atributo="DESCRIPCION                             " tabla="TALLER         " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="4" etiqueta="Descripción                                                                                                                                                     " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TALLER                                  " atributo="TIPOTALLER                              " tabla="TALLER         " campo="TIPO      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="=1                                                                                                                                                                                                                                                            " obligatorio="false" admitebusqueda="6" etiqueta="Tipo                                                                                                                                                            " dominio="COMBOSERVICIOPRODUCCION       " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TALLER                                  " atributo="PROVEEDOR                               " tabla="TALLER         " campo="PROVEEDOR " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="PROVEEDOR                               " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="8" etiqueta="Proveedor                                                                                                                                                       " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TALLER                                  " atributo="INVENTARIO                              " tabla="TALLER         " campo="INVENTARIO" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="INVENTARIO                              " tipodato="C         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="10" etiqueta="Inventario                                                                                                                                                      " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TALLER                                  " atributo="LISTADECOSTO                            " tabla="TALLER         " campo="LISTACOSTO" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="LISTADECOSTOSDEPRODUCCION               " tipodato="C         " longitud="6" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="10" etiqueta="Lista de costo                                                                                                                                                  " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="10" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TALLER                                  " atributo="INSUMOENLIQUIDACION                     " tabla="TALLER         " campo="INSUMOS   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="6" etiqueta="Insumos                                                                                                                                                         " dominio="COMBOSERVICIOPRODUCCION       " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="11" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TALLER                                  " atributo="DESCARTEENLIQUIDACION                   " tabla="TALLER         " campo="DESCARTES " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="6" etiqueta="Descartes                                                                                                                                                       " dominio="COMBOSERVICIOPRODUCCION       " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="12" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="NOMBRE                                  " tabla="PROV           " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="9" etiqueta="Detalle Pro.                                                                                                                                                    " dominio="TEXTOBUSQUEDA                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join PROV On TALLER.PROVEEDOR = PROV.CLCOD And  PROV.CLCOD != ''                                                                                                                                                                                        " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="5" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INVENTARIO                              " atributo="DESCRIPCION                             " tabla="INV            " campo="INVDES    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="11" etiqueta="Detalle Inv.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join INV On TALLER.INVENTARIO = INV.invcod And  INV.INVCOD != ''                                                                                                                                                                                        " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADECOSTOSDEPRODUCCION               " atributo="DESCRIPCION                             " tabla="LCOSTOP        " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="11" etiqueta="Detalle Lis.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join LCOSTOP On TALLER.LISTACOSTO = LCOSTOP.Codigo And  LCOSTOP.CODIGO != ''                                                                                                                                                                            " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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