
define class Din_EntidadMODIFICACIONDECOSTOSDEPRODUCCIONAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_MODIFICACIONDECOSTOSDEPRODUCCION'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = []
	cExpresionCCPorCampos = []
	cTagClaveCandidata = ''
	cTagClavePk = '_MCPPK'
	cTablaPrincipal = 'MODCOSTOP'
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

		with this.oEntidad
			local  lxModcostopFecexpo, lxModcostopFmodifw, lxModcostopFecimpo, lxModcostopFaltafw, lxModcostopFectrans, lxModcostopTimestamp, lxModcostopUmodifw, lxModcostopSmodifw, lxModcostopUaltafw, lxModcostopValtafw, lxModcostopZadsfw, lxModcostopVmodifw, lxModcostopSaltafw, lxModcostopHoraimpo, lxModcostopHmodifw, lxModcostopBdmodifw, lxModcostopEsttrans, lxModcostopHaltafw, lxModcostopBdaltafw, lxModcostopHoraexpo, lxModcostopCodigo, lxModcostopCobs, lxModcostopDescrip
				lxModcostopFecexpo =  .Fechaexpo			lxModcostopFmodifw =  .Fechamodificacionfw			lxModcostopFecimpo =  .Fechaimpo			lxModcostopFaltafw =  .Fechaaltafw			lxModcostopFectrans =  .Fechatransferencia			lxModcostopTimestamp = goLibrerias.ObtenerTimestamp()			lxModcostopUmodifw =  .Usuariomodificacionfw			lxModcostopSmodifw =  .Seriemodificacionfw			lxModcostopUaltafw =  .Usuarioaltafw			lxModcostopValtafw =  .Versionaltafw			lxModcostopZadsfw =  .Zadsfw			lxModcostopVmodifw =  .Versionmodificacionfw			lxModcostopSaltafw =  .Seriealtafw			lxModcostopHoraimpo =  .Horaimpo			lxModcostopHmodifw =  .Horamodificacionfw			lxModcostopBdmodifw =  .Basededatosmodificacionfw			lxModcostopEsttrans =  .Estadotransferencia			lxModcostopHaltafw =  .Horaaltafw			lxModcostopBdaltafw =  .Basededatosaltafw			lxModcostopHoraexpo =  .Horaexpo			lxModcostopCodigo =  .Codigo			lxModcostopCobs =  .Observ			lxModcostopDescrip =  .Descripcion
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxModcostopCodigo = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.MODCOSTOP ( "Fecexpo","Fmodifw","Fecimpo","Faltafw","Fectrans","Timestamp","Umodifw","Smodifw","Ualtafw","Valtafw","Zadsfw","Vmodifw","Saltafw","Horaimpo","Hmodifw","Bdmodifw","Esttrans","Haltafw","Bdaltafw","Horaexpo","Codigo","Cobs","Descrip" ) values ( <<"'" + this.ConvertirDateSql( lxModcostopFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxModcostopFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxModcostopFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxModcostopFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxModcostopFectrans ) + "'" >>, <<lxModcostopTimestamp >>, <<"'" + this.FormatearTextoSql( lxModcostopUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModcostopSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModcostopUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModcostopValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModcostopZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModcostopVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModcostopSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModcostopHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModcostopHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModcostopBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModcostopEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModcostopHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModcostopBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModcostopHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModcostopCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModcostopCobs ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModcostopDescrip ) + "'" >> )
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
		this.ComprobarTransaccion()
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = lxValorClavePrimaria

			.GenerarSentenciasComponentes()
			.EjecutarSentencias( This.ColSentencias )
		this.ComprobarTransaccion()

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ModCostos
				if this.oEntidad.ModCostos.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxSemielaborado_PK = loItem.Semielaborado_PK
					lxSemielaboradodetalle = loItem.Semielaboradodetalle
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxProceso_PK = loItem.Proceso_PK
					lxProcesodetalle = loItem.Procesodetalle
					lxTaller_PK = loItem.Taller_PK
					lxTallerdetalle = loItem.Tallerdetalle
					lxDesdecantidad = loItem.Desdecantidad
					lxListadecosto_PK = loItem.Listadecosto_PK
					lxCostodelista = loItem.Costodelista
					lxCostoactualizado = loItem.Costoactualizado
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.MODCOSTPROD("NROITEM","CODIGO","SemiElab","SemiDeta","codColor","ColorDeta","Proceso","ProcDeta","Taller","TallerDeta","Cantidad","CodLisCost","CostoVig","CostoNue" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxSemielaborado_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxSemielaboradodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxProceso_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxProcesodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTaller_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTallerdetalle ) + "'">>, <<lxDesdecantidad>>, <<"'" + this.FormatearTextoSql( lxListadecosto_PK ) + "'">>, <<lxCostodelista>>, <<lxCostoactualizado>> ) 
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
		this.oEntidad.Timestamp = lxModcostopTimestamp
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
			this.GenerarSentenciasComponentes()
			local  lxModcostopFecexpo, lxModcostopFmodifw, lxModcostopFecimpo, lxModcostopFaltafw, lxModcostopFectrans, lxModcostopTimestamp, lxModcostopUmodifw, lxModcostopSmodifw, lxModcostopUaltafw, lxModcostopValtafw, lxModcostopZadsfw, lxModcostopVmodifw, lxModcostopSaltafw, lxModcostopHoraimpo, lxModcostopHmodifw, lxModcostopBdmodifw, lxModcostopEsttrans, lxModcostopHaltafw, lxModcostopBdaltafw, lxModcostopHoraexpo, lxModcostopCodigo, lxModcostopCobs, lxModcostopDescrip
				lxModcostopFecexpo =  .Fechaexpo			lxModcostopFmodifw =  .Fechamodificacionfw			lxModcostopFecimpo =  .Fechaimpo			lxModcostopFaltafw =  .Fechaaltafw			lxModcostopFectrans =  .Fechatransferencia			lxModcostopTimestamp = goLibrerias.ObtenerTimestamp()			lxModcostopUmodifw =  .Usuariomodificacionfw			lxModcostopSmodifw =  .Seriemodificacionfw			lxModcostopUaltafw =  .Usuarioaltafw			lxModcostopValtafw =  .Versionaltafw			lxModcostopZadsfw =  .Zadsfw			lxModcostopVmodifw =  .Versionmodificacionfw			lxModcostopSaltafw =  .Seriealtafw			lxModcostopHoraimpo =  .Horaimpo			lxModcostopHmodifw =  .Horamodificacionfw			lxModcostopBdmodifw =  .Basededatosmodificacionfw			lxModcostopEsttrans =  .Estadotransferencia			lxModcostopHaltafw =  .Horaaltafw			lxModcostopBdaltafw =  .Basededatosaltafw			lxModcostopHoraexpo =  .Horaexpo			lxModcostopCodigo =  .Codigo			lxModcostopCobs =  .Observ			lxModcostopDescrip =  .Descripcion
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
				update ZooLogic.MODCOSTOP set "Fecexpo" = <<"'" + this.ConvertirDateSql( lxModcostopFecexpo ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxModcostopFmodifw ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxModcostopFecimpo ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxModcostopFaltafw ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxModcostopFectrans ) + "'">>,"Timestamp" = <<lxModcostopTimestamp>>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxModcostopUmodifw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxModcostopSmodifw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxModcostopUaltafw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxModcostopValtafw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxModcostopZadsfw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxModcostopVmodifw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxModcostopSaltafw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxModcostopHoraimpo ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxModcostopHmodifw ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxModcostopBdmodifw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxModcostopEsttrans ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxModcostopHaltafw ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxModcostopBdaltafw ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxModcostopHoraexpo ) + "'">>,"Codigo" = <<"'" + this.FormatearTextoSql( lxModcostopCodigo ) + "'">>,"Cobs" = <<"'" + this.FormatearTextoSql( lxModcostopCobs ) + "'">>,"Descrip" = <<"'" + this.FormatearTextoSql( lxModcostopDescrip ) + "'">> where "Codigo" = <<"'" + this.FormatearTextoSql( lxModcostopCodigo ) + "'">> and  MODCOSTOP.CODIGO != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			this.ComprobarResultadoDeEjecucionDelUpdate()
		this.ComprobarTransaccion()
			.EjecutarSentencias( This.ColSentencias )
		this.ComprobarTransaccion()
			this.oConexion.EjecutarSql( 'delete from ZooLogic.MODCOSTPROD where "CODIGO" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ModCostos
				if this.oEntidad.ModCostos.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxSemielaborado_PK = loItem.Semielaborado_PK
					lxSemielaboradodetalle = loItem.Semielaboradodetalle
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxProceso_PK = loItem.Proceso_PK
					lxProcesodetalle = loItem.Procesodetalle
					lxTaller_PK = loItem.Taller_PK
					lxTallerdetalle = loItem.Tallerdetalle
					lxDesdecantidad = loItem.Desdecantidad
					lxListadecosto_PK = loItem.Listadecosto_PK
					lxCostodelista = loItem.Costodelista
					lxCostoactualizado = loItem.Costoactualizado
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.MODCOSTPROD("NROITEM","CODIGO","SemiElab","SemiDeta","codColor","ColorDeta","Proceso","ProcDeta","Taller","TallerDeta","Cantidad","CodLisCost","CostoVig","CostoNue" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxSemielaborado_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxSemielaboradodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxProceso_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxProcesodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTaller_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTallerdetalle ) + "'">>, <<lxDesdecantidad>>, <<"'" + this.FormatearTextoSql( lxListadecosto_PK ) + "'">>, <<lxCostodelista>>, <<lxCostoactualizado>> ) 
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
		this.oEntidad.Timestamp = lxModcostopTimestamp
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 Codigo from ZooLogic.MODCOSTOP where " + this.ConvertirFuncionesSql( " MODCOSTOP.CODIGO != ''" ) )
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
			Local lxModcostopCodigo
			lxModcostopCodigo = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Timestamp" as "Timestamp", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Horaexpo" as "Horaexpo", "Codigo" as "Codigo", "Cobs" as "Observ", "Descrip" as "Descripcion" from ZooLogic.MODCOSTOP where "Codigo" = <<"'" + this.FormatearTextoSql( lxModcostopCodigo ) + "'">> and  MODCOSTOP.CODIGO != ''
			endtext
			use in select('c_MODIFICACIONDECOSTOSDEPRODUCCION')
			this.oConexion.EjecutarSql( lcSentencia, 'c_MODIFICACIONDECOSTOSDEPRODUCCION', set( 'Datasession' ) )

			if reccount( 'c_MODIFICACIONDECOSTOSDEPRODUCCION' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Semielab" as "Semielaborado", "Semideta" as "Semielaboradodetalle", "Codcolor" as "Color", "Colordeta" as "Colordetalle", "Proceso" as "Proceso", "Procdeta" as "Procesodetalle", "Taller" as "Taller", "Tallerdeta" as "Tallerdetalle", "Cantidad" as "Desdecantidad", "Codliscost" as "Listadecosto", "Costovig" as "Costodelista", "Costonue" as "Costoactualizado" from ZooLogic.MODCOSTPROD where CODIGO = <<"'" + this.FormatearTextoSql( c_MODIFICACIONDECOSTOSDEPRODUCCION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ModCostos')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ModCostos', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ModCostos
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxModcostopCodigo as Variant
		llRetorno = .t.
		lxModcostopCodigo = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.MODCOSTOP where "Codigo" = <<"'" + this.FormatearTextoSql( lxModcostopCodigo ) + "'">> and  MODCOSTOP.CODIGO != ''
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
				select top 1 "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Timestamp" as "Timestamp", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Horaexpo" as "Horaexpo", "Codigo" as "Codigo", "Cobs" as "Observ", "Descrip" as "Descripcion" from ZooLogic.MODCOSTOP where  MODCOSTOP.CODIGO != '' order by Codigo
			endtext
			use in select('c_MODIFICACIONDECOSTOSDEPRODUCCION')
			this.oConexion.EjecutarSql( lcSentencia, 'c_MODIFICACIONDECOSTOSDEPRODUCCION', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Semielab" as "Semielaborado", "Semideta" as "Semielaboradodetalle", "Codcolor" as "Color", "Colordeta" as "Colordetalle", "Proceso" as "Proceso", "Procdeta" as "Procesodetalle", "Taller" as "Taller", "Tallerdeta" as "Tallerdetalle", "Cantidad" as "Desdecantidad", "Codliscost" as "Listadecosto", "Costovig" as "Costodelista", "Costonue" as "Costoactualizado" from ZooLogic.MODCOSTPROD where CODIGO = <<"'" + this.FormatearTextoSql( c_MODIFICACIONDECOSTOSDEPRODUCCION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ModCostos')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ModCostos', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ModCostos
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
				select top 1 "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Timestamp" as "Timestamp", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Horaexpo" as "Horaexpo", "Codigo" as "Codigo", "Cobs" as "Observ", "Descrip" as "Descripcion" from ZooLogic.MODCOSTOP where  funciones.padr( Codigo, 10, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  MODCOSTOP.CODIGO != '' order by Codigo
			endtext
			use in select('c_MODIFICACIONDECOSTOSDEPRODUCCION')
			this.oConexion.EjecutarSql( lcSentencia, 'c_MODIFICACIONDECOSTOSDEPRODUCCION', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Semielab" as "Semielaborado", "Semideta" as "Semielaboradodetalle", "Codcolor" as "Color", "Colordeta" as "Colordetalle", "Proceso" as "Proceso", "Procdeta" as "Procesodetalle", "Taller" as "Taller", "Tallerdeta" as "Tallerdetalle", "Cantidad" as "Desdecantidad", "Codliscost" as "Listadecosto", "Costovig" as "Costodelista", "Costonue" as "Costoactualizado" from ZooLogic.MODCOSTPROD where CODIGO = <<"'" + this.FormatearTextoSql( c_MODIFICACIONDECOSTOSDEPRODUCCION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ModCostos')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ModCostos', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ModCostos
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
				select top 1 "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Timestamp" as "Timestamp", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Horaexpo" as "Horaexpo", "Codigo" as "Codigo", "Cobs" as "Observ", "Descrip" as "Descripcion" from ZooLogic.MODCOSTOP where  funciones.padr( Codigo, 10, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  MODCOSTOP.CODIGO != '' order by Codigo desc
			endtext
			use in select('c_MODIFICACIONDECOSTOSDEPRODUCCION')
			this.oConexion.EjecutarSql( lcSentencia, 'c_MODIFICACIONDECOSTOSDEPRODUCCION', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Semielab" as "Semielaborado", "Semideta" as "Semielaboradodetalle", "Codcolor" as "Color", "Colordeta" as "Colordetalle", "Proceso" as "Proceso", "Procdeta" as "Procesodetalle", "Taller" as "Taller", "Tallerdeta" as "Tallerdetalle", "Cantidad" as "Desdecantidad", "Codliscost" as "Listadecosto", "Costovig" as "Costodelista", "Costonue" as "Costoactualizado" from ZooLogic.MODCOSTPROD where CODIGO = <<"'" + this.FormatearTextoSql( c_MODIFICACIONDECOSTOSDEPRODUCCION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ModCostos')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ModCostos', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ModCostos
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
				select top 1 "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Timestamp" as "Timestamp", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Horaexpo" as "Horaexpo", "Codigo" as "Codigo", "Cobs" as "Observ", "Descrip" as "Descripcion" from ZooLogic.MODCOSTOP where  MODCOSTOP.CODIGO != '' order by Codigo desc
			endtext
			use in select('c_MODIFICACIONDECOSTOSDEPRODUCCION')
			this.oConexion.EjecutarSql( lcSentencia, 'c_MODIFICACIONDECOSTOSDEPRODUCCION', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Semielab" as "Semielaborado", "Semideta" as "Semielaboradodetalle", "Codcolor" as "Color", "Colordeta" as "Colordetalle", "Proceso" as "Proceso", "Procdeta" as "Procesodetalle", "Taller" as "Taller", "Tallerdeta" as "Tallerdetalle", "Cantidad" as "Desdecantidad", "Codliscost" as "Listadecosto", "Costovig" as "Costodelista", "Costonue" as "Costoactualizado" from ZooLogic.MODCOSTPROD where CODIGO = <<"'" + this.FormatearTextoSql( c_MODIFICACIONDECOSTOSDEPRODUCCION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ModCostos')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ModCostos', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ModCostos
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
			lcXml = this.oConexion.EjecutarSql( "select Fecexpo,Fmodifw,Fecimpo,Faltafw,Fectrans,Timestamp,Umodifw,Smodifw,Ualtafw,Valtafw,Zadsfw,Vm" + ;
"odifw,Saltafw,Horaimpo,Hmodifw,Bdmodifw,Esttrans,Haltafw,Bdaltafw,Horaexpo,Codigo,Cobs,Descrip" + ;
" from ZooLogic.MODCOSTOP where  MODCOSTOP.CODIGO != '' and " + lcFiltro )
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
			local  lxModcostopFecexpo, lxModcostopFmodifw, lxModcostopFecimpo, lxModcostopFaltafw, lxModcostopFectrans, lxModcostopTimestamp, lxModcostopUmodifw, lxModcostopSmodifw, lxModcostopUaltafw, lxModcostopValtafw, lxModcostopZadsfw, lxModcostopVmodifw, lxModcostopSaltafw, lxModcostopHoraimpo, lxModcostopHmodifw, lxModcostopBdmodifw, lxModcostopEsttrans, lxModcostopHaltafw, lxModcostopBdaltafw, lxModcostopHoraexpo, lxModcostopCodigo, lxModcostopCobs, lxModcostopDescrip
				lxModcostopFecexpo = ctod( '  /  /    ' )			lxModcostopFmodifw = ctod( '  /  /    ' )			lxModcostopFecimpo = ctod( '  /  /    ' )			lxModcostopFaltafw = ctod( '  /  /    ' )			lxModcostopFectrans = ctod( '  /  /    ' )			lxModcostopTimestamp = goLibrerias.ObtenerTimestamp()			lxModcostopUmodifw = []			lxModcostopSmodifw = []			lxModcostopUaltafw = []			lxModcostopValtafw = []			lxModcostopZadsfw = []			lxModcostopVmodifw = []			lxModcostopSaltafw = []			lxModcostopHoraimpo = []			lxModcostopHmodifw = []			lxModcostopBdmodifw = []			lxModcostopEsttrans = []			lxModcostopHaltafw = []			lxModcostopBdaltafw = []			lxModcostopHoraexpo = []			lxModcostopCodigo = []			lxModcostopCobs = []			lxModcostopDescrip = []
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.MODCOSTPROD where "CODIGO" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( [delete from ZooLogic.MODCOSTOP where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			.GenerarSentenciasComponentes()
			.EjecutarSentencias( This.ColSentencias )
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
			lcTabla = 'MODCOSTOP' + '_' + tcCampo
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
		lcWhere = " Where  MODCOSTOP.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Timestamp" as "Timestamp", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Horaexpo" as "Horaexpo", "Codigo" as "Codigo", "Cobs" as "Observ", "Descrip" as "Descripcion"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'MODCOSTOP', '', tnTope )
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
	Function ObtenerDatosDetalleModCostos( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  MODCOSTPROD.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Nroitem" as "Nroitem", "Codigo" as "Codigo", "Semielab" as "Semielaborado", "Semideta" as "Semielaboradodetalle", "Codcolor" as "Color", "Colordeta" as "Colordetalle", "Proceso" as "Proceso", "Procdeta" as "Procesodetalle", "Taller" as "Taller", "Tallerdeta" as "Tallerdetalle", "Cantidad" as "Desdecantidad", "Codliscost" as "Listadecosto", "Costovig" as "Costodelista", "Costonue" as "Costoactualizado"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleModCostos( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'MODCOSTPROD', 'ModCostos', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleModCostos( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleModCostos( lcAtributo )
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
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'FECHAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECIMPO AS FECHAIMPO'
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'FECHATRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRANS AS FECHATRANSFERENCIA'
				Case lcAtributo == 'TIMESTAMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIMESTAMP AS TIMESTAMP'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'OBSERV'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COBS AS OBSERV'
				Case lcAtributo == 'DESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCRIP AS DESCRIPCION'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleModCostos( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'SEMIELABORADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SEMIELAB AS SEMIELABORADO'
				Case lcAtributo == 'SEMIELABORADODETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SEMIDETA AS SEMIELABORADODETALLE'
				Case lcAtributo == 'COLOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODCOLOR AS COLOR'
				Case lcAtributo == 'COLORDETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COLORDETA AS COLORDETALLE'
				Case lcAtributo == 'PROCESO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PROCESO AS PROCESO'
				Case lcAtributo == 'PROCESODETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PROCDETA AS PROCESODETALLE'
				Case lcAtributo == 'TALLER'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TALLER AS TALLER'
				Case lcAtributo == 'TALLERDETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TALLERDETA AS TALLERDETALLE'
				Case lcAtributo == 'DESDECANTIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CANTIDAD AS DESDECANTIDAD'
				Case lcAtributo == 'LISTADECOSTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODLISCOST AS LISTADECOSTO'
				Case lcAtributo == 'COSTODELISTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COSTOVIG AS COSTODELISTA'
				Case lcAtributo == 'COSTOACTUALIZADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COSTONUE AS COSTOACTUALIZADO'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAIMPO'
				lcCampo = 'FECIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'TIMESTAMP'
				lcCampo = 'TIMESTAMP'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'OBSERV'
				lcCampo = 'COBS'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCION'
				lcCampo = 'DESCRIP'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleModCostos( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'SEMIELABORADO'
				lcCampo = 'SEMIELAB'
			Case upper( alltrim( tcAtributo ) ) == 'SEMIELABORADODETALLE'
				lcCampo = 'SEMIDETA'
			Case upper( alltrim( tcAtributo ) ) == 'COLOR'
				lcCampo = 'CODCOLOR'
			Case upper( alltrim( tcAtributo ) ) == 'COLORDETALLE'
				lcCampo = 'COLORDETA'
			Case upper( alltrim( tcAtributo ) ) == 'PROCESO'
				lcCampo = 'PROCESO'
			Case upper( alltrim( tcAtributo ) ) == 'PROCESODETALLE'
				lcCampo = 'PROCDETA'
			Case upper( alltrim( tcAtributo ) ) == 'TALLER'
				lcCampo = 'TALLER'
			Case upper( alltrim( tcAtributo ) ) == 'TALLERDETALLE'
				lcCampo = 'TALLERDETA'
			Case upper( alltrim( tcAtributo ) ) == 'DESDECANTIDAD'
				lcCampo = 'CANTIDAD'
			Case upper( alltrim( tcAtributo ) ) == 'LISTADECOSTO'
				lcCampo = 'CODLISCOST'
			Case upper( alltrim( tcAtributo ) ) == 'COSTODELISTA'
				lcCampo = 'COSTOVIG'
			Case upper( alltrim( tcAtributo ) ) == 'COSTOACTUALIZADO'
				lcCampo = 'COSTONUE'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerTablaDetalle( tcDetalle as string ) as String
		local lcRetorno as string
		lcRetorno = ''
		if upper( alltrim( tcDetalle ) ) == 'MODCOSTOS'
			lcRetorno = 'MODCOSTPROD'
		EndIf
		return lcRetorno
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasInsert() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcSentencia as string, loItem as object
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxModcostopFecexpo, lxModcostopFmodifw, lxModcostopFecimpo, lxModcostopFaltafw, lxModcostopFectrans, lxModcostopTimestamp, lxModcostopUmodifw, lxModcostopSmodifw, lxModcostopUaltafw, lxModcostopValtafw, lxModcostopZadsfw, lxModcostopVmodifw, lxModcostopSaltafw, lxModcostopHoraimpo, lxModcostopHmodifw, lxModcostopBdmodifw, lxModcostopEsttrans, lxModcostopHaltafw, lxModcostopBdaltafw, lxModcostopHoraexpo, lxModcostopCodigo, lxModcostopCobs, lxModcostopDescrip
				lxModcostopFecexpo =  .Fechaexpo			lxModcostopFmodifw =  .Fechamodificacionfw			lxModcostopFecimpo =  .Fechaimpo			lxModcostopFaltafw =  .Fechaaltafw			lxModcostopFectrans =  .Fechatransferencia			lxModcostopTimestamp = goLibrerias.ObtenerTimestamp()			lxModcostopUmodifw =  .Usuariomodificacionfw			lxModcostopSmodifw =  .Seriemodificacionfw			lxModcostopUaltafw =  .Usuarioaltafw			lxModcostopValtafw =  .Versionaltafw			lxModcostopZadsfw =  .Zadsfw			lxModcostopVmodifw =  .Versionmodificacionfw			lxModcostopSaltafw =  .Seriealtafw			lxModcostopHoraimpo =  .Horaimpo			lxModcostopHmodifw =  .Horamodificacionfw			lxModcostopBdmodifw =  .Basededatosmodificacionfw			lxModcostopEsttrans =  .Estadotransferencia			lxModcostopHaltafw =  .Horaaltafw			lxModcostopBdaltafw =  .Basededatosaltafw			lxModcostopHoraexpo =  .Horaexpo			lxModcostopCodigo =  .Codigo			lxModcostopCobs =  .Observ			lxModcostopDescrip =  .Descripcion
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.MODCOSTOP ( "Fecexpo","Fmodifw","Fecimpo","Faltafw","Fectrans","Timestamp","Umodifw","Smodifw","Ualtafw","Valtafw","Zadsfw","Vmodifw","Saltafw","Horaimpo","Hmodifw","Bdmodifw","Esttrans","Haltafw","Bdaltafw","Horaexpo","Codigo","Cobs","Descrip" ) values ( <<"'" + this.ConvertirDateSql( lxModcostopFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxModcostopFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxModcostopFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxModcostopFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxModcostopFectrans ) + "'" >>, <<lxModcostopTimestamp >>, <<"'" + this.FormatearTextoSql( lxModcostopUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModcostopSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModcostopUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModcostopValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModcostopZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModcostopVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModcostopSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModcostopHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModcostopHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModcostopBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModcostopEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModcostopHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModcostopBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModcostopHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModcostopCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModcostopCobs ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModcostopDescrip ) + "'" >> )
		endtext
		loColeccion.cTabla = 'MODCOSTOP' 
		loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		With this
			local lcValorClavePrimariaString as String
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ModCostos
				if this.oEntidad.ModCostos.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxSemielaborado_PK = loItem.Semielaborado_PK
					lxSemielaboradodetalle = loItem.Semielaboradodetalle
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxProceso_PK = loItem.Proceso_PK
					lxProcesodetalle = loItem.Procesodetalle
					lxTaller_PK = loItem.Taller_PK
					lxTallerdetalle = loItem.Tallerdetalle
					lxDesdecantidad = loItem.Desdecantidad
					lxListadecosto_PK = loItem.Listadecosto_PK
					lxCostodelista = loItem.Costodelista
					lxCostoactualizado = loItem.Costoactualizado
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.MODCOSTPROD("NROITEM","CODIGO","SemiElab","SemiDeta","codColor","ColorDeta","Proceso","ProcDeta","Taller","TallerDeta","Cantidad","CodLisCost","CostoVig","CostoNue" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxSemielaborado_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxSemielaboradodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxProceso_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxProcesodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTaller_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTallerdetalle ) + "'">>, <<lxDesdecantidad>>, <<"'" + this.FormatearTextoSql( lxListadecosto_PK ) + "'">>, <<lxCostodelista>>, <<lxCostoactualizado>> ) 
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
			local  lxModcostopFecexpo, lxModcostopFmodifw, lxModcostopFecimpo, lxModcostopFaltafw, lxModcostopFectrans, lxModcostopTimestamp, lxModcostopUmodifw, lxModcostopSmodifw, lxModcostopUaltafw, lxModcostopValtafw, lxModcostopZadsfw, lxModcostopVmodifw, lxModcostopSaltafw, lxModcostopHoraimpo, lxModcostopHmodifw, lxModcostopBdmodifw, lxModcostopEsttrans, lxModcostopHaltafw, lxModcostopBdaltafw, lxModcostopHoraexpo, lxModcostopCodigo, lxModcostopCobs, lxModcostopDescrip
				lxModcostopFecexpo =  .Fechaexpo			lxModcostopFmodifw =  .Fechamodificacionfw			lxModcostopFecimpo =  .Fechaimpo			lxModcostopFaltafw =  .Fechaaltafw			lxModcostopFectrans =  .Fechatransferencia			lxModcostopTimestamp = goLibrerias.ObtenerTimestamp()			lxModcostopUmodifw =  .Usuariomodificacionfw			lxModcostopSmodifw =  .Seriemodificacionfw			lxModcostopUaltafw =  .Usuarioaltafw			lxModcostopValtafw =  .Versionaltafw			lxModcostopZadsfw =  .Zadsfw			lxModcostopVmodifw =  .Versionmodificacionfw			lxModcostopSaltafw =  .Seriealtafw			lxModcostopHoraimpo =  .Horaimpo			lxModcostopHmodifw =  .Horamodificacionfw			lxModcostopBdmodifw =  .Basededatosmodificacionfw			lxModcostopEsttrans =  .Estadotransferencia			lxModcostopHaltafw =  .Horaaltafw			lxModcostopBdaltafw =  .Basededatosaltafw			lxModcostopHoraexpo =  .Horaexpo			lxModcostopCodigo =  .Codigo			lxModcostopCobs =  .Observ			lxModcostopDescrip =  .Descripcion
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  MODCOSTOP.CODIGO != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.MODCOSTOP set "Fecexpo" = <<"'" + this.ConvertirDateSql( lxModcostopFecexpo ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxModcostopFmodifw ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxModcostopFecimpo ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxModcostopFaltafw ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxModcostopFectrans ) + "'">>, "Timestamp" = <<lxModcostopTimestamp>>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxModcostopUmodifw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxModcostopSmodifw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxModcostopUaltafw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxModcostopValtafw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxModcostopZadsfw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxModcostopVmodifw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxModcostopSaltafw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxModcostopHoraimpo ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxModcostopHmodifw ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxModcostopBdmodifw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxModcostopEsttrans ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxModcostopHaltafw ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxModcostopBdaltafw ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxModcostopHoraexpo ) + "'">>, "Codigo" = <<"'" + this.FormatearTextoSql( lxModcostopCodigo ) + "'">>, "Cobs" = <<"'" + this.FormatearTextoSql( lxModcostopCobs ) + "'">>, "Descrip" = <<"'" + this.FormatearTextoSql( lxModcostopDescrip ) + "'">> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'MODCOSTOP' 
		loColeccion.agregar( strtran(  lcSentencia, chr( 9 ), '' ) )
			loColeccion.Agregar([delete from ZooLogic.MODCOSTPROD where "CODIGO" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ModCostos
				if this.oEntidad.ModCostos.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxSemielaborado_PK = loItem.Semielaborado_PK
					lxSemielaboradodetalle = loItem.Semielaboradodetalle
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxProceso_PK = loItem.Proceso_PK
					lxProcesodetalle = loItem.Procesodetalle
					lxTaller_PK = loItem.Taller_PK
					lxTallerdetalle = loItem.Tallerdetalle
					lxDesdecantidad = loItem.Desdecantidad
					lxListadecosto_PK = loItem.Listadecosto_PK
					lxCostodelista = loItem.Costodelista
					lxCostoactualizado = loItem.Costoactualizado
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.MODCOSTPROD("NROITEM","CODIGO","SemiElab","SemiDeta","codColor","ColorDeta","Proceso","ProcDeta","Taller","TallerDeta","Cantidad","CodLisCost","CostoVig","CostoNue" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxSemielaborado_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxSemielaboradodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxProceso_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxProcesodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTaller_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTallerdetalle ) + "'">>, <<lxDesdecantidad>>, <<"'" + this.FormatearTextoSql( lxListadecosto_PK ) + "'">>, <<lxCostodelista>>, <<lxCostoactualizado>> ) 
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

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  MODCOSTOP.CODIGO != '']
		loColeccion.Agregar( 'delete from ZooLogic.MODCOSTOP where ' + lcFiltro )
			loColeccion.Agregar([delete from ZooLogic.MODCOSTPROD where "CODIGO" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.cTabla = 'MODCOSTOP' 
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
			.ModCostos.oItem.oCompCostosproduccion.lNuevo = .EsNuevo()
			.ModCostos.oItem.oCompCostosproduccion.lEdicion = .EsEdicion()
			.ModCostos.oItem.oCompCostosproduccion.lEliminar = .lEliminar
			.ModCostos.oItem.oCompCostosproduccion.lAnular = .lAnular
			loColSentencias = .ModCostos.oItem.oCompCostosproduccion.grabar()
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
			lcRetorno = [update ZooLogic.MODCOSTOP set TimeStamp = ] + transform( lnTimeStamp ) + lcUpdateRealTime + [ where Codigo = ] + "'" + this.FormatearTextoSql( .Codigo ) + "'" + [ and  MODCOSTOP.CODIGO != ''] + goServicios.RealTime.ObtenerTagEstimulo( .cNombre )
		
		endwith
		return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function ObtenerCantidadRegistros() as integer
		local lnCantReg as integer
			local lcXml as string
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.MODCOSTOP where  MODCOSTOP.CODIGO != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.MODCOSTOP where Codigo = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  MODCOSTOP.CODIGO != ''" )
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
		lcCursor = This.oEntidad.cPrefijoRecibir + 'MODIFICACIONDECOSTOSDEPRODUCCION'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.MODCOSTOP Where Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'", 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					this.oConexion.EjecutarSql( [UPDATE ZooLogic.MODCOSTOP set  FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, TIMESTAMP = ] + transform( &lcCursor..TIMESTAMP )+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'"+ [, CObs = ] + "'" + this.FormatearTextoSql( &lcCursor..CObs ) + "'"+ [, Descrip = ] + "'" + this.FormatearTextoSql( &lcCursor..Descrip ) + "'" + [ Where Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'" )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
				endIf
			else
				Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
				Text to lcCampos noShow
					 FECEXPO, FMODIFW, FECIMPO, FALTAFW, FECTRANS, TIMESTAMP, UMODIFW, SMODIFW, UALTAFW, VALTAFW, ZADSFW, VMODIFW, SALTAFW, HORAIMPO, HMODIFW, BDMODIFW, ESTTRANS, HALTAFW, BDALTAFW, HORAEXPO, Codigo, CObs, Descrip
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + transform( &lcCursor..TIMESTAMP ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..CObs ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Descrip ) + "'"
lcValoresCampos = substr(lcValoresCampos,2) 

				this.oConexion.EjecutarSql( [Insert into ZooLogic.MODCOSTOP ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
				this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'MODIFICACIONDECOSTOSDEPRODUCCION'
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
			this.oConexion.EjecutarSql( [Delete From ZooLogic.MODCOSTPROD Where CODIGO] + lcIn  )
			endfor
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'COMMIT TRANSACTION' )
			endif
		EndIf
	endif
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMMODCOSTOPROD'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where CODIGO in ( select Codigo from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"NROITEM","CODIGO","SemiElab","SemiDeta","codColor","ColorDeta","Proceso","ProcDeta","Taller","TallerDeta","Cantidad","CodLisCost","CostoVig","CostoNue"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.MODCOSTPROD ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CODIGO     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.SemiElab   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.SemiDeta   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.codColor   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ColorDeta  ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Proceso    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ProcDeta   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Taller     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.TallerDeta ) + "'" + ',' + transform( cDetallesExistentes.Cantidad   ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CodLisCost ) + "'" + ',' + transform( cDetallesExistentes.CostoVig   ) + ',' + transform( cDetallesExistentes.CostoNue   ) + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	Use in select( 'cExistentes' )
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearCursorMemo( tcCursorACrear as String, tcTablaConMemo as String ) as Void
		create cursor &tcCursorACrear ( Codigo C (10) , Orden N(16), texto C(80))
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirComponentes() As Void
		this.oEntidad.ModCostos.oItem.oCompCostosproduccion.Recibir( this.oEntidad, 'ModCostos',this.oEntidad.cPrefijoRecibir + 'ITEMMODCOSTOPROD',this.oEntidad.cPrefijoRecibir + 'MODIFICACIONDECOSTOSDEPRODUCCION')
		
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
			Case  lcAlias == lcPrefijo + 'MODIFICACIONDECOSTOSDEPRODUCCION'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'MODIFICACIONDECOSTOSDEPRODUCCION_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'MODIFICACIONDECOSTOSDEPRODUCCION_COBS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMMODCOSTOPROD'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_MODCOSTOP')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'MODIFICACIONDECOSTOSDEPRODUCCION'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..Codigo
		llCondicion = isnull( lxVar )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad MODIFICACIONDECOSTOSDEPRODUCCION. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'MODIFICACIONDECOSTOSDEPRODUCCION'
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
			lcCursor = This.oEntidad.cPrefijoRecibir + 'MODIFICACIONDECOSTOSDEPRODUCCION'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_MODCOSTOP') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_MODCOSTOP
Create Table ZooLogic.TablaTrabajo_MODCOSTOP ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fecexpo" datetime  null, 
"fmodifw" datetime  null, 
"fecimpo" datetime  null, 
"faltafw" datetime  null, 
"fectrans" datetime  null, 
"timestamp" numeric( 20, 0 )  null, 
"umodifw" char( 100 )  null, 
"smodifw" char( 7 )  null, 
"ualtafw" char( 100 )  null, 
"valtafw" char( 13 )  null, 
"zadsfw" varchar(max)  null, 
"vmodifw" char( 13 )  null, 
"saltafw" char( 7 )  null, 
"horaimpo" char( 8 )  null, 
"hmodifw" char( 8 )  null, 
"bdmodifw" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"haltafw" char( 8 )  null, 
"bdaltafw" char( 8 )  null, 
"horaexpo" char( 8 )  null, 
"codigo" char( 10 )  null, 
"cobs" varchar(max)  null, 
"descrip" char( 100 )  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_MODCOSTOP' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_MODCOSTOP' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'MODIFICACIONDECOSTOSDEPRODUCCION'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		with loManejador
			if this.oEntidad.VerificarContexto( 'CB' )
			else
				.AgregarMapeo('Nrolinea','Nrolinea')
			endif
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('timestamp','timestamp')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('codigo','codigo')
			.AgregarMapeo('cobs','cobs')
			.AgregarMapeo('descrip','descrip')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_MODCOSTOP'
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
				Update t Set t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.TIMESTAMP = isnull( d.TIMESTAMP, t.TIMESTAMP ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.CODIGO = isnull( d.CODIGO, t.CODIGO ),t.COBS = isnull( d.COBS, t.COBS ),t.DESCRIP = isnull( d.DESCRIP, t.DESCRIP )
					from ZooLogic.MODCOSTOP t inner join deleted d 
							 on t.Codigo = d.Codigo
				-- Fin Updates
				insert into ZooLogic.MODCOSTOP(Fecexpo,Fmodifw,Fecimpo,Faltafw,Fectrans,Timestamp,Umodifw,Smodifw,Ualtafw,Valtafw,Zadsfw,Vmodifw,Saltafw,Horaimpo,Hmodifw,Bdmodifw,Esttrans,Haltafw,Bdaltafw,Horaexpo,Codigo,Cobs,Descrip)
					Select isnull( d.FECEXPO,''),isnull( d.FMODIFW,''),isnull( d.FECIMPO,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FECTRANS,''),isnull( d.TIMESTAMP,0),isnull( d.UMODIFW,''),isnull( d.SMODIFW,''),isnull( d.UALTAFW,''),isnull( d.VALTAFW,''),isnull( d.ZADSFW,''),isnull( d.VMODIFW,''),isnull( d.SALTAFW,''),isnull( d.HORAIMPO,''),isnull( d.HMODIFW,''),isnull( d.BDMODIFW,''),isnull( d.ESTTRANS,''),convert( char(8), getdate(), 108 ),isnull( d.BDALTAFW,''),isnull( d.HORAEXPO,''),isnull( d.CODIGO,''),isnull( d.COBS,''),isnull( d.DESCRIP,'')
						From deleted d left join ZooLogic.MODCOSTOP pk 
							 on d.Codigo = pk.Codigo
						Where pk.Codigo Is Null 
				-- Fin Inserts
			End
		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_MODCOSTPROD( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_MODCOSTOP_MODCOSTPROD
ON ZooLogic.TablaTrabajo_MODCOSTOP_MODCOSTPROD
AFTER DELETE
As
Begin
Update t Set 
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.CODIGO = isnull( d.CODIGO, t.CODIGO ),
t.SEMIELAB = isnull( d.SEMIELAB, t.SEMIELAB ),
t.SEMIDETA = isnull( d.SEMIDETA, t.SEMIDETA ),
t.CODCOLOR = isnull( d.CODCOLOR, t.CODCOLOR ),
t.COLORDETA = isnull( d.COLORDETA, t.COLORDETA ),
t.PROCESO = isnull( d.PROCESO, t.PROCESO ),
t.PROCDETA = isnull( d.PROCDETA, t.PROCDETA ),
t.TALLER = isnull( d.TALLER, t.TALLER ),
t.TALLERDETA = isnull( d.TALLERDETA, t.TALLERDETA ),
t.CANTIDAD = isnull( d.CANTIDAD, t.CANTIDAD ),
t.CODLISCOST = isnull( d.CODLISCOST, t.CODLISCOST ),
t.COSTOVIG = isnull( d.COSTOVIG, t.COSTOVIG ),
t.COSTONUE = isnull( d.COSTONUE, t.COSTONUE )
from ZooLogic.MODCOSTPROD t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.MODCOSTPROD
( 
"NROITEM",
"CODIGO",
"SEMIELAB",
"SEMIDETA",
"CODCOLOR",
"COLORDETA",
"PROCESO",
"PROCDETA",
"TALLER",
"TALLERDETA",
"CANTIDAD",
"CODLISCOST",
"COSTOVIG",
"COSTONUE"
 )
Select 
d.NROITEM,
d.CODIGO,
d.SEMIELAB,
d.SEMIDETA,
d.CODCOLOR,
d.COLORDETA,
d.PROCESO,
d.PROCDETA,
d.TALLER,
d.TALLERDETA,
d.CANTIDAD,
d.CODLISCOST,
d.COSTOVIG,
d.COSTONUE
From deleted d left join ZooLogic.MODCOSTPROD pk 
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_MODCOSTOP') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_MODCOSTOP
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_MODIFICACIONDECOSTOSDEPRODUCCION' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_MODIFICACIONDECOSTOSDEPRODUCCION.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_MODIFICACIONDECOSTOSDEPRODUCCION.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_MODIFICACIONDECOSTOSDEPRODUCCION.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_MODIFICACIONDECOSTOSDEPRODUCCION.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_MODIFICACIONDECOSTOSDEPRODUCCION.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Timestamp = nvl( c_MODIFICACIONDECOSTOSDEPRODUCCION.Timestamp, 0 )
					.Usuariomodificacionfw = nvl( c_MODIFICACIONDECOSTOSDEPRODUCCION.Usuariomodificacionfw, [] )
					.Seriemodificacionfw = nvl( c_MODIFICACIONDECOSTOSDEPRODUCCION.Seriemodificacionfw, [] )
					.Usuarioaltafw = nvl( c_MODIFICACIONDECOSTOSDEPRODUCCION.Usuarioaltafw, [] )
					.Versionaltafw = nvl( c_MODIFICACIONDECOSTOSDEPRODUCCION.Versionaltafw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Versionmodificacionfw = nvl( c_MODIFICACIONDECOSTOSDEPRODUCCION.Versionmodificacionfw, [] )
					.Seriealtafw = nvl( c_MODIFICACIONDECOSTOSDEPRODUCCION.Seriealtafw, [] )
					.Horaimpo = nvl( c_MODIFICACIONDECOSTOSDEPRODUCCION.Horaimpo, [] )
					.Horamodificacionfw = nvl( c_MODIFICACIONDECOSTOSDEPRODUCCION.Horamodificacionfw, [] )
					.Basededatosmodificacionfw = nvl( c_MODIFICACIONDECOSTOSDEPRODUCCION.Basededatosmodificacionfw, [] )
					.Estadotransferencia = nvl( c_MODIFICACIONDECOSTOSDEPRODUCCION.Estadotransferencia, [] )
					.Horaaltafw = nvl( c_MODIFICACIONDECOSTOSDEPRODUCCION.Horaaltafw, [] )
					.Basededatosaltafw = nvl( c_MODIFICACIONDECOSTOSDEPRODUCCION.Basededatosaltafw, [] )
					.Horaexpo = nvl( c_MODIFICACIONDECOSTOSDEPRODUCCION.Horaexpo, [] )
					.Codigo = nvl( c_MODIFICACIONDECOSTOSDEPRODUCCION.Codigo, [] )
					lcValor = This.ObtenerMemo( 'c_Observ')
					.Observ = lcValor 
					.Descripcion = nvl( c_MODIFICACIONDECOSTOSDEPRODUCCION.Descripcion, [] )
					.Modcostos.Limpiar()
					.Modcostos.SetearEsNavegacion( .lProcesando )
					.Modcostos.Cargar()
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
		
		loDetalle = this.oEntidad.ModCostos
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
		return c_MODIFICACIONDECOSTOSDEPRODUCCION.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.MODCOSTOP' )
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
								from ZooLogic.MODCOSTOP 
								Where   MODCOSTOP.CODIGO != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "MODCOSTOP", "", lcCursor, set("Datasession") )
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
			"Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Timestamp" as "Timestamp", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Horaexpo" as "Horaexpo", "Codigo" as "Codigo", "Cobs" as "Observ", "Descrip" as "Descripcion"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.MODCOSTOP 
								Where   MODCOSTOP.CODIGO != ''
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
	Tabla = 'MODCOSTOP'
	Filtro = " MODCOSTOP.CODIGO != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " MODCOSTOP.CODIGO != ''"
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
	<row entidad="MODIFICACIONDECOSTOSDEPRODUCCION        " atributo="FECHAEXPO                               " tabla="MODCOSTOP      " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MODIFICACIONDECOSTOSDEPRODUCCION        " atributo="FECHAMODIFICACIONFW                     " tabla="MODCOSTOP      " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MODIFICACIONDECOSTOSDEPRODUCCION        " atributo="FECHAIMPO                               " tabla="MODCOSTOP      " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MODIFICACIONDECOSTOSDEPRODUCCION        " atributo="FECHAALTAFW                             " tabla="MODCOSTOP      " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MODIFICACIONDECOSTOSDEPRODUCCION        " atributo="FECHATRANSFERENCIA                      " tabla="MODCOSTOP      " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha transferencia                                                                                                                                             " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MODIFICACIONDECOSTOSDEPRODUCCION        " atributo="TIMESTAMP                               " tabla="MODCOSTOP      " campo="TIMESTAMP " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MODIFICACIONDECOSTOSDEPRODUCCION        " atributo="USUARIOMODIFICACIONFW                   " tabla="MODCOSTOP      " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MODIFICACIONDECOSTOSDEPRODUCCION        " atributo="SERIEMODIFICACIONFW                     " tabla="MODCOSTOP      " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MODIFICACIONDECOSTOSDEPRODUCCION        " atributo="USUARIOALTAFW                           " tabla="MODCOSTOP      " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MODIFICACIONDECOSTOSDEPRODUCCION        " atributo="VERSIONALTAFW                           " tabla="MODCOSTOP      " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MODIFICACIONDECOSTOSDEPRODUCCION        " atributo="ZADSFW                                  " tabla="MODCOSTOP      " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MODIFICACIONDECOSTOSDEPRODUCCION        " atributo="VERSIONMODIFICACIONFW                   " tabla="MODCOSTOP      " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MODIFICACIONDECOSTOSDEPRODUCCION        " atributo="SERIEALTAFW                             " tabla="MODCOSTOP      " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MODIFICACIONDECOSTOSDEPRODUCCION        " atributo="HORAIMPO                                " tabla="MODCOSTOP      " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MODIFICACIONDECOSTOSDEPRODUCCION        " atributo="HORAMODIFICACIONFW                      " tabla="MODCOSTOP      " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MODIFICACIONDECOSTOSDEPRODUCCION        " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="MODCOSTOP      " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MODIFICACIONDECOSTOSDEPRODUCCION        " atributo="ESTADOTRANSFERENCIA                     " tabla="MODCOSTOP      " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado transferencia                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MODIFICACIONDECOSTOSDEPRODUCCION        " atributo="HORAALTAFW                              " tabla="MODCOSTOP      " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MODIFICACIONDECOSTOSDEPRODUCCION        " atributo="BASEDEDATOSALTAFW                       " tabla="MODCOSTOP      " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MODIFICACIONDECOSTOSDEPRODUCCION        " atributo="HORAEXPO                                " tabla="MODCOSTOP      " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MODIFICACIONDECOSTOSDEPRODUCCION        " atributo="CODIGO                                  " tabla="MODCOSTOP      " campo="CODIGO    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="1" etiqueta="Código                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MODIFICACIONDECOSTOSDEPRODUCCION        " atributo="OBSERV                                  " tabla="MODCOSTOP      " campo="COBS      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="200" etiqueta="Observaciones                                                                                                                                                   " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MODIFICACIONDECOSTOSDEPRODUCCION        " atributo="DESCRIPCION                             " tabla="MODCOSTOP      " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="2" etiqueta="Descripción                                                                                                                                                     " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MODIFICACIONDECOSTOSDEPRODUCCION        " atributo="MODCOSTOS                               " tabla="MODCOSTPROD    " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="201" etiqueta="Costos de talleres                                                                                                                                              " dominio="DETALLEITEMMODCOSTOPROD       " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
</VFPData>

			Endtext

			text to .cEstructuraDetalle noshow 
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
	<row entidad="ITEMMODCOSTOPROD                        " atributo="SEMIELABORADO                           " tabla="MODCOSTPROD    " campo="SEMIELAB  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="INSUMO                                  " tipodato="C         " longitud="23" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="201" etiqueta="DetalleCostosDeTalleres, Semielaborado                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="I" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join MODCOSTPROD On MODCOSTOP.Codigo = MODCOSTPROD.CODIGO And  MODCOSTOP.CODIGO != ''                                                                                                                                                                   " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ITEMMODCOSTOPROD                        " atributo="SEMIELABORADODETALLE                    " tabla="MODCOSTPROD    " campo="SEMIDETA  " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="202" etiqueta="DetalleCostosDeTalleres, Descripción                                                                                                                            " dominio="DESCRIPCION                   " detalle="false" tipo="I" atributoforaneo="Semielaborado.Descripcion                                                                                                                                                                                                                                     " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join MODCOSTPROD On MODCOSTOP.Codigo = MODCOSTPROD.CODIGO And  MODCOSTOP.CODIGO != ''                                                                                                                                                                   " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ITEMMODCOSTOPROD                        " atributo="COLOR                                   " tabla="MODCOSTPROD    " campo="CODCOLOR  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="COLOR                                   " tipodato="C         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="203" etiqueta="DetalleCostosDeTalleres, Color                                                                                                                                  " dominio="CODIGO                        " detalle="false" tipo="I" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join MODCOSTPROD On MODCOSTOP.Codigo = MODCOSTPROD.CODIGO And  MODCOSTOP.CODIGO != ''                                                                                                                                                                   " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ITEMMODCOSTOPROD                        " atributo="COLORDETALLE                            " tabla="MODCOSTPROD    " campo="COLORDETA " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="204" etiqueta="DetalleCostosDeTalleres, Descripción del color                                                                                                                  " dominio="DESCRIPCION                   " detalle="false" tipo="I" atributoforaneo="Color.Descripcion                                                                                                                                                                                                                                             " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join MODCOSTPROD On MODCOSTOP.Codigo = MODCOSTPROD.CODIGO And  MODCOSTOP.CODIGO != ''                                                                                                                                                                   " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ITEMMODCOSTOPROD                        " atributo="PROCESO                                 " tabla="MODCOSTPROD    " campo="PROCESO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="PROCESOPRODUCCION                       " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="205" etiqueta="DetalleCostosDeTalleres, Proceso                                                                                                                                " dominio="CODIGO                        " detalle="false" tipo="I" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join MODCOSTPROD On MODCOSTOP.Codigo = MODCOSTPROD.CODIGO And  MODCOSTOP.CODIGO != ''                                                                                                                                                                   " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ITEMMODCOSTOPROD                        " atributo="PROCESODETALLE                          " tabla="MODCOSTPROD    " campo="PROCDETA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="206" etiqueta="DetalleCostosDeTalleres, Descripción del proceso                                                                                                                " dominio="DESCRIPCION                   " detalle="false" tipo="I" atributoforaneo="Proceso.Descripcion                                                                                                                                                                                                                                           " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join MODCOSTPROD On MODCOSTOP.Codigo = MODCOSTPROD.CODIGO And  MODCOSTOP.CODIGO != ''                                                                                                                                                                   " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="8" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ITEMMODCOSTOPROD                        " atributo="TALLER                                  " tabla="MODCOSTPROD    " campo="TALLER    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="TALLER                                  " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="207" etiqueta="DetalleCostosDeTalleres, Taller                                                                                                                                 " dominio="CODIGO                        " detalle="false" tipo="I" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join MODCOSTPROD On MODCOSTOP.Codigo = MODCOSTPROD.CODIGO And  MODCOSTOP.CODIGO != ''                                                                                                                                                                   " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="9" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ITEMMODCOSTOPROD                        " atributo="TALLERDETALLE                           " tabla="MODCOSTPROD    " campo="TALLERDETA" claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="254" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="208" etiqueta="DetalleCostosDeTalleres, Descripción del taller                                                                                                                 " dominio="DESCRIPCION                   " detalle="false" tipo="I" atributoforaneo="Taller.Descripcion                                                                                                                                                                                                                                            " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join MODCOSTPROD On MODCOSTOP.Codigo = MODCOSTPROD.CODIGO And  MODCOSTOP.CODIGO != ''                                                                                                                                                                   " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="10" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ITEMMODCOSTOPROD                        " atributo="DESDECANTIDAD                           " tabla="MODCOSTPROD    " campo="CANTIDAD  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="209" etiqueta="DetalleCostosDeTalleres, Desde cantidad                                                                                                                         " dominio="NUMERICONONEGATIVO            " detalle="false" tipo="I" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join MODCOSTPROD On MODCOSTOP.Codigo = MODCOSTPROD.CODIGO And  MODCOSTOP.CODIGO != ''                                                                                                                                                                   " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="11" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ITEMMODCOSTOPROD                        " atributo="LISTADECOSTO                            " tabla="MODCOSTPROD    " campo="CODLISCOST" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="LISTADECOSTOSDEPRODUCCION               " tipodato="C         " longitud="6" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="210" etiqueta="DetalleCostosDeTalleres, L. precio                                                                                                                              " dominio="CODIGO                        " detalle="false" tipo="I" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join MODCOSTPROD On MODCOSTOP.Codigo = MODCOSTPROD.CODIGO And  MODCOSTOP.CODIGO != ''                                                                                                                                                                   " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="12" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ITEMMODCOSTOPROD                        " atributo="COSTODELISTA                            " tabla="MODCOSTPROD    " campo="COSTOVIG  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="12" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="211" etiqueta="DetalleCostosDeTalleres, C. vigente                                                                                                                             " dominio="NUMERICO                      " detalle="false" tipo="I" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join MODCOSTPROD On MODCOSTOP.Codigo = MODCOSTPROD.CODIGO And  MODCOSTOP.CODIGO != ''                                                                                                                                                                   " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="13" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ITEMMODCOSTOPROD                        " atributo="COSTOACTUALIZADO                        " tabla="MODCOSTPROD    " campo="COSTONUE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="12" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="212" etiqueta="DetalleCostosDeTalleres, C. nuevo                                                                                                                               " dominio="PRECIONONEGATIVO              " detalle="false" tipo="I" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join MODCOSTPROD On MODCOSTOP.Codigo = MODCOSTPROD.CODIGO And  MODCOSTOP.CODIGO != ''                                                                                                                                                                   " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="14" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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