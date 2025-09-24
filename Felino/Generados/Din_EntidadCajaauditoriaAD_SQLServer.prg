
define class Din_EntidadCAJAAUDITORIAAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_CAJAAUDITORIA'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = []
	cExpresionCCPorCampos = []
	cTagClaveCandidata = ''
	cTagClavePk = '_033PK'
	cTablaPrincipal = 'CAJAAUDI'
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
			local  lxCajaaudiFecexpo, lxCajaaudiFectrans, lxCajaaudiFmodifw, lxCajaaudiFaltafw, lxCajaaudiFecimpo, lxCajaaudiFecha, lxCajaaudiCodigo, lxCajaaudiNumcaja, lxCajaaudiTimestamp, lxCajaaudiMontotot, lxCajaaudiSmodifw, lxCajaaudiUaltafw, lxCajaaudiUmodifw, lxCajaaudiZadsfw, lxCajaaudiValtafw, lxCajaaudiVmodifw, lxCajaaudiSaltafw, lxCajaaudiHaltafw, lxCajaaudiHmodifw, lxCajaaudiBdaltafw, lxCajaaudiUser, lxCajaaudiBdmodifw, lxCajaaudiTarea, lxCajaaudiEsttrans, lxCajaaudiHoraexpo, lxCajaaudiHora, lxCajaaudiHoraimpo
				lxCajaaudiFecexpo =  .Fechaexpo			lxCajaaudiFectrans =  .Fechatransferencia			lxCajaaudiFmodifw =  .Fechamodificacionfw			lxCajaaudiFaltafw =  .Fechaaltafw			lxCajaaudiFecimpo =  .Fechaimpo			lxCajaaudiFecha =  .Fecha			lxCajaaudiCodigo =  .Id			lxCajaaudiNumcaja =  .Cajaestado_PK 			lxCajaaudiTimestamp = goLibrerias.ObtenerTimestamp()			lxCajaaudiMontotot =  .Montototal			lxCajaaudiSmodifw =  .Seriemodificacionfw			lxCajaaudiUaltafw =  .Usuarioaltafw			lxCajaaudiUmodifw =  .Usuariomodificacionfw			lxCajaaudiZadsfw =  .Zadsfw			lxCajaaudiValtafw =  .Versionaltafw			lxCajaaudiVmodifw =  .Versionmodificacionfw			lxCajaaudiSaltafw =  .Seriealtafw			lxCajaaudiHaltafw =  .Horaaltafw			lxCajaaudiHmodifw =  .Horamodificacionfw			lxCajaaudiBdaltafw =  .Basededatosaltafw			lxCajaaudiUser =  .Usuario			lxCajaaudiBdmodifw =  .Basededatosmodificacionfw			lxCajaaudiTarea =  .Tarea			lxCajaaudiEsttrans =  .Estadotransferencia			lxCajaaudiHoraexpo =  .Horaexpo			lxCajaaudiHora =  .Hora			lxCajaaudiHoraimpo =  .Horaimpo
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxCajaaudiCodigo = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.CAJAAUDI ( "Fecexpo","Fectrans","Fmodifw","Faltafw","Fecimpo","Fecha","Codigo","Numcaja","Timestamp","Montotot","Smodifw","Ualtafw","Umodifw","Zadsfw","Valtafw","Vmodifw","Saltafw","Haltafw","Hmodifw","Bdaltafw","User","Bdmodifw","Tarea","Esttrans","Horaexpo","Hora","Horaimpo" ) values ( <<"'" + this.ConvertirDateSql( lxCajaaudiFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCajaaudiFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCajaaudiFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCajaaudiFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCajaaudiFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCajaaudiFecha ) + "'" >>, <<lxCajaaudiCodigo >>, <<lxCajaaudiNumcaja >>, <<lxCajaaudiTimestamp >>, <<lxCajaaudiMontotot >>, <<"'" + this.FormatearTextoSql( lxCajaaudiSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCajaaudiUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCajaaudiUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCajaaudiZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCajaaudiValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCajaaudiVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCajaaudiSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCajaaudiHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCajaaudiHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCajaaudiBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCajaaudiUser ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCajaaudiBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCajaaudiTarea ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCajaaudiEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCajaaudiHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCajaaudiHora ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCajaaudiHoraimpo ) + "'" >> )
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
		this.ComprobarTransaccion()
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.ID
			lcValorClavePrimariaString = lxValorClavePrimaria


			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.DetalleValoresAuditoria
				if this.oEntidad.DetalleValoresAuditoria.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxMonto = loItem.Monto
					lxValor_PK = loItem.Valor_PK
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.DetAudi("Codigo","NROITEM","Monto","Valor" ) values ( <<transform( lxValorClavePrimaria )>>, <<lxNroitem>>, <<lxMonto>>, <<"'" + this.FormatearTextoSql( lxValor_PK ) + "'">> ) 
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
		this.oEntidad.Timestamp = lxCajaaudiTimestamp
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
		return this.oEntidad.ID
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function Actualizar() as boolean
	local loError as Exception, loEx as Exception, lxValorClavePrimaria as variant, lnI as Integer, loSentenciasTriggers as zoocoleccion OF zoocoleccion.prg, lcSentencia as string

		with this.oEntidad
			local  lxCajaaudiFecexpo, lxCajaaudiFectrans, lxCajaaudiFmodifw, lxCajaaudiFaltafw, lxCajaaudiFecimpo, lxCajaaudiFecha, lxCajaaudiCodigo, lxCajaaudiNumcaja, lxCajaaudiTimestamp, lxCajaaudiMontotot, lxCajaaudiSmodifw, lxCajaaudiUaltafw, lxCajaaudiUmodifw, lxCajaaudiZadsfw, lxCajaaudiValtafw, lxCajaaudiVmodifw, lxCajaaudiSaltafw, lxCajaaudiHaltafw, lxCajaaudiHmodifw, lxCajaaudiBdaltafw, lxCajaaudiUser, lxCajaaudiBdmodifw, lxCajaaudiTarea, lxCajaaudiEsttrans, lxCajaaudiHoraexpo, lxCajaaudiHora, lxCajaaudiHoraimpo
				lxCajaaudiFecexpo =  .Fechaexpo			lxCajaaudiFectrans =  .Fechatransferencia			lxCajaaudiFmodifw =  .Fechamodificacionfw			lxCajaaudiFaltafw =  .Fechaaltafw			lxCajaaudiFecimpo =  .Fechaimpo			lxCajaaudiFecha =  .Fecha			lxCajaaudiCodigo =  .Id			lxCajaaudiNumcaja =  .Cajaestado_PK 			lxCajaaudiTimestamp = goLibrerias.ObtenerTimestamp()			lxCajaaudiMontotot =  .Montototal			lxCajaaudiSmodifw =  .Seriemodificacionfw			lxCajaaudiUaltafw =  .Usuarioaltafw			lxCajaaudiUmodifw =  .Usuariomodificacionfw			lxCajaaudiZadsfw =  .Zadsfw			lxCajaaudiValtafw =  .Versionaltafw			lxCajaaudiVmodifw =  .Versionmodificacionfw			lxCajaaudiSaltafw =  .Seriealtafw			lxCajaaudiHaltafw =  .Horaaltafw			lxCajaaudiHmodifw =  .Horamodificacionfw			lxCajaaudiBdaltafw =  .Basededatosaltafw			lxCajaaudiUser =  .Usuario			lxCajaaudiBdmodifw =  .Basededatosmodificacionfw			lxCajaaudiTarea =  .Tarea			lxCajaaudiEsttrans =  .Estadotransferencia			lxCajaaudiHoraexpo =  .Horaexpo			lxCajaaudiHora =  .Hora			lxCajaaudiHoraimpo =  .Horaimpo
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
			lxValorClavePrimaria = .oEntidad.ID
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ZooLogic.CAJAAUDI set "Fecexpo" = <<"'" + this.ConvertirDateSql( lxCajaaudiFecexpo ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxCajaaudiFectrans ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxCajaaudiFmodifw ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxCajaaudiFaltafw ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxCajaaudiFecimpo ) + "'">>,"Fecha" = <<"'" + this.ConvertirDateSql( lxCajaaudiFecha ) + "'">>,"Codigo" = <<lxCajaaudiCodigo>>,"Numcaja" = <<lxCajaaudiNumcaja>>,"Timestamp" = <<lxCajaaudiTimestamp>>,"Montotot" = <<lxCajaaudiMontotot>>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxCajaaudiSmodifw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxCajaaudiUaltafw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxCajaaudiUmodifw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxCajaaudiZadsfw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxCajaaudiValtafw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxCajaaudiVmodifw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxCajaaudiSaltafw ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxCajaaudiHaltafw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxCajaaudiHmodifw ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxCajaaudiBdaltafw ) + "'">>,"User" = <<"'" + this.FormatearTextoSql( lxCajaaudiUser ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxCajaaudiBdmodifw ) + "'">>,"Tarea" = <<"'" + this.FormatearTextoSql( lxCajaaudiTarea ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxCajaaudiEsttrans ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxCajaaudiHoraexpo ) + "'">>,"Hora" = <<"'" + this.FormatearTextoSql( lxCajaaudiHora ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxCajaaudiHoraimpo ) + "'">> where "Codigo" = <<lxCajaaudiCodigo>> and  CAJAAUDI.CODIGO != 0 << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			this.ComprobarResultadoDeEjecucionDelUpdate()
		this.ComprobarTransaccion()
			this.oConexion.EjecutarSql( 'delete from ZooLogic.DetAudi where "Codigo" = ' + transform( .oEntidad.ID ) )

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.DetalleValoresAuditoria
				if this.oEntidad.DetalleValoresAuditoria.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxMonto = loItem.Monto
					lxValor_PK = loItem.Valor_PK
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.DetAudi("Codigo","NROITEM","Monto","Valor" ) values ( <<transform( lxValorClavePrimaria )>>, <<lxNroitem>>, <<lxMonto>>, <<"'" + this.FormatearTextoSql( lxValor_PK ) + "'">> ) 
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
		this.oEntidad.Timestamp = lxCajaaudiTimestamp
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 Codigo from ZooLogic.CAJAAUDI where " + this.ConvertirFuncionesSql( " CAJAAUDI.CODIGO != 0" ) )
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
			Local lxCajaaudiCodigo
			lxCajaaudiCodigo = .Id

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fecha" as "Fecha", "Codigo" as "Id", "Numcaja" as "Cajaestado", "Timestamp" as "Timestamp", "Montotot" as "Montototal", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Saltafw" as "Seriealtafw", "Haltafw" as "Horaaltafw", "Hmodifw" as "Horamodificacionfw", "Bdaltafw" as "Basededatosaltafw", "User" as "Usuario", "Bdmodifw" as "Basededatosmodificacionfw", "Tarea" as "Tarea", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Hora" as "Hora", "Horaimpo" as "Horaimpo" from ZooLogic.CAJAAUDI where "Codigo" = <<lxCajaaudiCodigo>> and  CAJAAUDI.CODIGO != 0
			endtext
			use in select('c_CAJAAUDITORIA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CAJAAUDITORIA', set( 'Datasession' ) )

			if reccount( 'c_CAJAAUDITORIA' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Codigo" as "Idcajaauditoria", "Nroitem" as "Nroitem", "Monto" as "Monto", "Valor" as "Valor" from ZooLogic.DetAudi where Codigo = <<transform( c_CAJAAUDITORIA.ID )>> Order by NroItem
			endtext
			use in select('c_DetalleValoresAuditoria')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DetalleValoresAuditoria', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DetalleValoresAuditoria
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxCajaaudiCodigo as Variant
		llRetorno = .t.
		lxCajaaudiCodigo = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.CAJAAUDI where "Codigo" = <<lxCajaaudiCodigo>> and  CAJAAUDI.CODIGO != 0
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
				lcOrden =  str( .Id, 10, 0)
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fecha" as "Fecha", "Codigo" as "Id", "Numcaja" as "Cajaestado", "Timestamp" as "Timestamp", "Montotot" as "Montototal", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Saltafw" as "Seriealtafw", "Haltafw" as "Horaaltafw", "Hmodifw" as "Horamodificacionfw", "Bdaltafw" as "Basededatosaltafw", "User" as "Usuario", "Bdmodifw" as "Basededatosmodificacionfw", "Tarea" as "Tarea", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Hora" as "Hora", "Horaimpo" as "Horaimpo" from ZooLogic.CAJAAUDI where  CAJAAUDI.CODIGO != 0 order by Codigo
			endtext
			use in select('c_CAJAAUDITORIA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CAJAAUDITORIA', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Codigo" as "Idcajaauditoria", "Nroitem" as "Nroitem", "Monto" as "Monto", "Valor" as "Valor" from ZooLogic.DetAudi where Codigo = <<transform( c_CAJAAUDITORIA.ID )>> Order by NroItem
			endtext
			use in select('c_DetalleValoresAuditoria')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DetalleValoresAuditoria', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DetalleValoresAuditoria
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
				lcOrden =  str( .Id, 10, 0)
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fecha" as "Fecha", "Codigo" as "Id", "Numcaja" as "Cajaestado", "Timestamp" as "Timestamp", "Montotot" as "Montototal", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Saltafw" as "Seriealtafw", "Haltafw" as "Horaaltafw", "Hmodifw" as "Horamodificacionfw", "Bdaltafw" as "Basededatosaltafw", "User" as "Usuario", "Bdmodifw" as "Basededatosmodificacionfw", "Tarea" as "Tarea", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Hora" as "Hora", "Horaimpo" as "Horaimpo" from ZooLogic.CAJAAUDI where  str( Codigo, 10, 0) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  CAJAAUDI.CODIGO != 0 order by Codigo
			endtext
			use in select('c_CAJAAUDITORIA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CAJAAUDITORIA', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Codigo" as "Idcajaauditoria", "Nroitem" as "Nroitem", "Monto" as "Monto", "Valor" as "Valor" from ZooLogic.DetAudi where Codigo = <<transform( c_CAJAAUDITORIA.ID )>> Order by NroItem
			endtext
			use in select('c_DetalleValoresAuditoria')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DetalleValoresAuditoria', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DetalleValoresAuditoria
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
				lcOrden =  str( .Id, 10, 0)
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fecha" as "Fecha", "Codigo" as "Id", "Numcaja" as "Cajaestado", "Timestamp" as "Timestamp", "Montotot" as "Montototal", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Saltafw" as "Seriealtafw", "Haltafw" as "Horaaltafw", "Hmodifw" as "Horamodificacionfw", "Bdaltafw" as "Basededatosaltafw", "User" as "Usuario", "Bdmodifw" as "Basededatosmodificacionfw", "Tarea" as "Tarea", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Hora" as "Hora", "Horaimpo" as "Horaimpo" from ZooLogic.CAJAAUDI where  str( Codigo, 10, 0) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  CAJAAUDI.CODIGO != 0 order by Codigo desc
			endtext
			use in select('c_CAJAAUDITORIA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CAJAAUDITORIA', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Codigo" as "Idcajaauditoria", "Nroitem" as "Nroitem", "Monto" as "Monto", "Valor" as "Valor" from ZooLogic.DetAudi where Codigo = <<transform( c_CAJAAUDITORIA.ID )>> Order by NroItem
			endtext
			use in select('c_DetalleValoresAuditoria')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DetalleValoresAuditoria', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DetalleValoresAuditoria
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
				lcOrden =  str( .Id, 10, 0)
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fecha" as "Fecha", "Codigo" as "Id", "Numcaja" as "Cajaestado", "Timestamp" as "Timestamp", "Montotot" as "Montototal", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Saltafw" as "Seriealtafw", "Haltafw" as "Horaaltafw", "Hmodifw" as "Horamodificacionfw", "Bdaltafw" as "Basededatosaltafw", "User" as "Usuario", "Bdmodifw" as "Basededatosmodificacionfw", "Tarea" as "Tarea", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Hora" as "Hora", "Horaimpo" as "Horaimpo" from ZooLogic.CAJAAUDI where  CAJAAUDI.CODIGO != 0 order by Codigo desc
			endtext
			use in select('c_CAJAAUDITORIA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CAJAAUDITORIA', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Codigo" as "Idcajaauditoria", "Nroitem" as "Nroitem", "Monto" as "Monto", "Valor" as "Valor" from ZooLogic.DetAudi where Codigo = <<transform( c_CAJAAUDITORIA.ID )>> Order by NroItem
			endtext
			use in select('c_DetalleValoresAuditoria')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DetalleValoresAuditoria', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DetalleValoresAuditoria
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
				lcFiltroCodigo = ' and ' + .cCampoClavePrimaria + ' <> ' + transform( .oEntidad.ID )
			endif
			lcFiltro = lcCampo + ' = ' + goLibrerias.ValorAString(lxValor) + lcFiltroCodigo
			local lcXml as string
			lcXml = this.oConexion.EjecutarSql( "select Fecexpo,Fectrans,Fmodifw,Faltafw,Fecimpo,Fecha,Codigo,Numcaja,Timestamp,Montotot,Smodifw,Ual" + ;
"tafw,Umodifw,Zadsfw,Valtafw,Vmodifw,Saltafw,Haltafw,Hmodifw,Bdaltafw,User,Bdmodifw,Tarea,Esttrans,Ho" + ;
"raexpo,Hora,Horaimpo" + ;
" from ZooLogic.CAJAAUDI where  CAJAAUDI.CODIGO != 0 and " + lcFiltro )
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
			local  lxCajaaudiFecexpo, lxCajaaudiFectrans, lxCajaaudiFmodifw, lxCajaaudiFaltafw, lxCajaaudiFecimpo, lxCajaaudiFecha, lxCajaaudiCodigo, lxCajaaudiNumcaja, lxCajaaudiTimestamp, lxCajaaudiMontotot, lxCajaaudiSmodifw, lxCajaaudiUaltafw, lxCajaaudiUmodifw, lxCajaaudiZadsfw, lxCajaaudiValtafw, lxCajaaudiVmodifw, lxCajaaudiSaltafw, lxCajaaudiHaltafw, lxCajaaudiHmodifw, lxCajaaudiBdaltafw, lxCajaaudiUser, lxCajaaudiBdmodifw, lxCajaaudiTarea, lxCajaaudiEsttrans, lxCajaaudiHoraexpo, lxCajaaudiHora, lxCajaaudiHoraimpo
				lxCajaaudiFecexpo = ctod( '  /  /    ' )			lxCajaaudiFectrans = ctod( '  /  /    ' )			lxCajaaudiFmodifw = ctod( '  /  /    ' )			lxCajaaudiFaltafw = ctod( '  /  /    ' )			lxCajaaudiFecimpo = ctod( '  /  /    ' )			lxCajaaudiFecha = ctod( '  /  /    ' )			lxCajaaudiCodigo = 0			lxCajaaudiNumcaja = 0			lxCajaaudiTimestamp = goLibrerias.ObtenerTimestamp()			lxCajaaudiMontotot = 0			lxCajaaudiSmodifw = []			lxCajaaudiUaltafw = []			lxCajaaudiUmodifw = []			lxCajaaudiZadsfw = []			lxCajaaudiValtafw = []			lxCajaaudiVmodifw = []			lxCajaaudiSaltafw = []			lxCajaaudiHaltafw = []			lxCajaaudiHmodifw = []			lxCajaaudiBdaltafw = []			lxCajaaudiUser = []			lxCajaaudiBdmodifw = []			lxCajaaudiTarea = []			lxCajaaudiEsttrans = []			lxCajaaudiHoraexpo = []			lxCajaaudiHora = []			lxCajaaudiHoraimpo = []
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.DetAudi where "Codigo" = ' + transform( .oEntidad.ID ) )
			this.oConexion.EjecutarSql( [delete from ZooLogic.CAJAAUDI where "Codigo" = ] + transform( .oEntidad.ID )+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'CAJAAUDI' + '_' + tcCampo
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
		lcWhere = " Where  CAJAAUDI.CODIGO != 0"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fecha" as "Fecha", "Codigo" as "Id", "Numcaja" as "Cajaestado", "Timestamp" as "Timestamp", "Montotot" as "Montototal", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Saltafw" as "Seriealtafw", "Haltafw" as "Horaaltafw", "Hmodifw" as "Horamodificacionfw", "Bdaltafw" as "Basededatosaltafw", "User" as "Usuario", "Bdmodifw" as "Basededatosmodificacionfw", "Tarea" as "Tarea", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Hora" as "Hora", "Horaimpo" as "Horaimpo"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'CAJAAUDI', '', tnTope )
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
	Function ObtenerDatosDetalleDetalleValoresAuditoria( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  DETAUDI.CODIGO != 0"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Codigo" as "Idcajaauditoria", "Nroitem" as "Nroitem", "Monto" as "Monto", "Valor" as "Valor"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleDetalleValoresAuditoria( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'DetAudi', 'DetalleValoresAuditoria', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleDetalleValoresAuditoria( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleDetalleValoresAuditoria( lcAtributo )
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
				Case lcAtributo == 'FECHA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHA AS FECHA'
				Case lcAtributo == 'ID'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS ID'
				Case lcAtributo == 'CAJAESTADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NUMCAJA AS CAJAESTADO'
				Case lcAtributo == 'TIMESTAMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIMESTAMP AS TIMESTAMP'
				Case lcAtributo == 'MONTOTOTAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONTOTOT AS MONTOTOTAL'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'USUARIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'USER AS USUARIO'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'TAREA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TAREA AS TAREA'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'HORA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORA AS HORA'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleDetalleValoresAuditoria( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'IDCAJAAUDITORIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS IDCAJAAUDITORIA'
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'MONTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONTO AS MONTO'
				Case lcAtributo == 'VALOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALOR AS VALOR'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHA'
				lcCampo = 'FECHA'
			Case upper( alltrim( tcAtributo ) ) == 'ID'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'CAJAESTADO'
				lcCampo = 'NUMCAJA'
			Case upper( alltrim( tcAtributo ) ) == 'TIMESTAMP'
				lcCampo = 'TIMESTAMP'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOTOTAL'
				lcCampo = 'MONTOTOT'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIO'
				lcCampo = 'USER'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'TAREA'
				lcCampo = 'TAREA'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORA'
				lcCampo = 'HORA'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleDetalleValoresAuditoria( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'IDCAJAAUDITORIA'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'MONTO'
				lcCampo = 'MONTO'
			Case upper( alltrim( tcAtributo ) ) == 'VALOR'
				lcCampo = 'VALOR'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerTablaDetalle( tcDetalle as string ) as String
		local lcRetorno as string
		lcRetorno = ''
		if upper( alltrim( tcDetalle ) ) == 'DETALLEVALORESAUDITORIA'
			lcRetorno = 'DETAUDI'
		EndIf
		return lcRetorno
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasInsert() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcSentencia as string, loItem as object
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxCajaaudiFecexpo, lxCajaaudiFectrans, lxCajaaudiFmodifw, lxCajaaudiFaltafw, lxCajaaudiFecimpo, lxCajaaudiFecha, lxCajaaudiCodigo, lxCajaaudiNumcaja, lxCajaaudiTimestamp, lxCajaaudiMontotot, lxCajaaudiSmodifw, lxCajaaudiUaltafw, lxCajaaudiUmodifw, lxCajaaudiZadsfw, lxCajaaudiValtafw, lxCajaaudiVmodifw, lxCajaaudiSaltafw, lxCajaaudiHaltafw, lxCajaaudiHmodifw, lxCajaaudiBdaltafw, lxCajaaudiUser, lxCajaaudiBdmodifw, lxCajaaudiTarea, lxCajaaudiEsttrans, lxCajaaudiHoraexpo, lxCajaaudiHora, lxCajaaudiHoraimpo
				lxCajaaudiFecexpo =  .Fechaexpo			lxCajaaudiFectrans =  .Fechatransferencia			lxCajaaudiFmodifw =  .Fechamodificacionfw			lxCajaaudiFaltafw =  .Fechaaltafw			lxCajaaudiFecimpo =  .Fechaimpo			lxCajaaudiFecha =  .Fecha			lxCajaaudiCodigo =  .Id			lxCajaaudiNumcaja =  .Cajaestado_PK 			lxCajaaudiTimestamp = goLibrerias.ObtenerTimestamp()			lxCajaaudiMontotot =  .Montototal			lxCajaaudiSmodifw =  .Seriemodificacionfw			lxCajaaudiUaltafw =  .Usuarioaltafw			lxCajaaudiUmodifw =  .Usuariomodificacionfw			lxCajaaudiZadsfw =  .Zadsfw			lxCajaaudiValtafw =  .Versionaltafw			lxCajaaudiVmodifw =  .Versionmodificacionfw			lxCajaaudiSaltafw =  .Seriealtafw			lxCajaaudiHaltafw =  .Horaaltafw			lxCajaaudiHmodifw =  .Horamodificacionfw			lxCajaaudiBdaltafw =  .Basededatosaltafw			lxCajaaudiUser =  .Usuario			lxCajaaudiBdmodifw =  .Basededatosmodificacionfw			lxCajaaudiTarea =  .Tarea			lxCajaaudiEsttrans =  .Estadotransferencia			lxCajaaudiHoraexpo =  .Horaexpo			lxCajaaudiHora =  .Hora			lxCajaaudiHoraimpo =  .Horaimpo
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.CAJAAUDI ( "Fecexpo","Fectrans","Fmodifw","Faltafw","Fecimpo","Fecha","Codigo","Numcaja","Timestamp","Montotot","Smodifw","Ualtafw","Umodifw","Zadsfw","Valtafw","Vmodifw","Saltafw","Haltafw","Hmodifw","Bdaltafw","User","Bdmodifw","Tarea","Esttrans","Horaexpo","Hora","Horaimpo" ) values ( <<"'" + this.ConvertirDateSql( lxCajaaudiFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCajaaudiFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCajaaudiFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCajaaudiFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCajaaudiFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCajaaudiFecha ) + "'" >>, <<lxCajaaudiCodigo >>, <<lxCajaaudiNumcaja >>, <<lxCajaaudiTimestamp >>, <<lxCajaaudiMontotot >>, <<"'" + this.FormatearTextoSql( lxCajaaudiSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCajaaudiUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCajaaudiUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCajaaudiZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCajaaudiValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCajaaudiVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCajaaudiSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCajaaudiHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCajaaudiHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCajaaudiBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCajaaudiUser ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCajaaudiBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCajaaudiTarea ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCajaaudiEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCajaaudiHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCajaaudiHora ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCajaaudiHoraimpo ) + "'" >> )
		endtext
		loColeccion.cTabla = 'CAJAAUDI' 
		loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		With this
			local lcValorClavePrimariaString as String
			lcValorClavePrimariaString = transform( this.oEntidad.ID )

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.DetalleValoresAuditoria
				if this.oEntidad.DetalleValoresAuditoria.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxMonto = loItem.Monto
					lxValor_PK = loItem.Valor_PK
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.DetAudi("Codigo","NROITEM","Monto","Valor" ) values ( << lcValorClavePrimariaString >>, <<lxNroitem>>, <<lxMonto>>, <<"'" + this.FormatearTextoSql( lxValor_PK ) + "'">> ) 
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
			local  lxCajaaudiFecexpo, lxCajaaudiFectrans, lxCajaaudiFmodifw, lxCajaaudiFaltafw, lxCajaaudiFecimpo, lxCajaaudiFecha, lxCajaaudiCodigo, lxCajaaudiNumcaja, lxCajaaudiTimestamp, lxCajaaudiMontotot, lxCajaaudiSmodifw, lxCajaaudiUaltafw, lxCajaaudiUmodifw, lxCajaaudiZadsfw, lxCajaaudiValtafw, lxCajaaudiVmodifw, lxCajaaudiSaltafw, lxCajaaudiHaltafw, lxCajaaudiHmodifw, lxCajaaudiBdaltafw, lxCajaaudiUser, lxCajaaudiBdmodifw, lxCajaaudiTarea, lxCajaaudiEsttrans, lxCajaaudiHoraexpo, lxCajaaudiHora, lxCajaaudiHoraimpo
				lxCajaaudiFecexpo =  .Fechaexpo			lxCajaaudiFectrans =  .Fechatransferencia			lxCajaaudiFmodifw =  .Fechamodificacionfw			lxCajaaudiFaltafw =  .Fechaaltafw			lxCajaaudiFecimpo =  .Fechaimpo			lxCajaaudiFecha =  .Fecha			lxCajaaudiCodigo =  .Id			lxCajaaudiNumcaja =  .Cajaestado_PK 			lxCajaaudiTimestamp = goLibrerias.ObtenerTimestamp()			lxCajaaudiMontotot =  .Montototal			lxCajaaudiSmodifw =  .Seriemodificacionfw			lxCajaaudiUaltafw =  .Usuarioaltafw			lxCajaaudiUmodifw =  .Usuariomodificacionfw			lxCajaaudiZadsfw =  .Zadsfw			lxCajaaudiValtafw =  .Versionaltafw			lxCajaaudiVmodifw =  .Versionmodificacionfw			lxCajaaudiSaltafw =  .Seriealtafw			lxCajaaudiHaltafw =  .Horaaltafw			lxCajaaudiHmodifw =  .Horamodificacionfw			lxCajaaudiBdaltafw =  .Basededatosaltafw			lxCajaaudiUser =  .Usuario			lxCajaaudiBdmodifw =  .Basededatosmodificacionfw			lxCajaaudiTarea =  .Tarea			lxCajaaudiEsttrans =  .Estadotransferencia			lxCajaaudiHoraexpo =  .Horaexpo			lxCajaaudiHora =  .Hora			lxCajaaudiHoraimpo =  .Horaimpo
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.ID
			lcValorClavePrimariaString = transform( this.oEntidad.ID )

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  CAJAAUDI.CODIGO != 0]
			text to lcSentencia noshow textmerge
				update ZooLogic.CAJAAUDI set "Fecexpo" = <<"'" + this.ConvertirDateSql( lxCajaaudiFecexpo ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxCajaaudiFectrans ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxCajaaudiFmodifw ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxCajaaudiFaltafw ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxCajaaudiFecimpo ) + "'">>, "Fecha" = <<"'" + this.ConvertirDateSql( lxCajaaudiFecha ) + "'">>, "Codigo" = <<lxCajaaudiCodigo>>, "Numcaja" = <<lxCajaaudiNumcaja>>, "Timestamp" = <<lxCajaaudiTimestamp>>, "Montotot" = <<lxCajaaudiMontotot>>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxCajaaudiSmodifw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxCajaaudiUaltafw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxCajaaudiUmodifw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxCajaaudiZadsfw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxCajaaudiValtafw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxCajaaudiVmodifw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxCajaaudiSaltafw ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxCajaaudiHaltafw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxCajaaudiHmodifw ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxCajaaudiBdaltafw ) + "'">>, "User" = <<"'" + this.FormatearTextoSql( lxCajaaudiUser ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxCajaaudiBdmodifw ) + "'">>, "Tarea" = <<"'" + this.FormatearTextoSql( lxCajaaudiTarea ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxCajaaudiEsttrans ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxCajaaudiHoraexpo ) + "'">>, "Hora" = <<"'" + this.FormatearTextoSql( lxCajaaudiHora ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxCajaaudiHoraimpo ) + "'">> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'CAJAAUDI' 
		loColeccion.agregar( strtran(  lcSentencia, chr( 9 ), '' ) )
			loColeccion.Agregar([delete from ZooLogic.DetAudi where "Codigo" = ] + transform( .oEntidad.ID ))

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.DetalleValoresAuditoria
				if this.oEntidad.DetalleValoresAuditoria.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxMonto = loItem.Monto
					lxValor_PK = loItem.Valor_PK
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.DetAudi("Codigo","NROITEM","Monto","Valor" ) values ( << lcValorClavePrimariaString >>, <<lxNroitem>>, <<lxMonto>>, <<"'" + this.FormatearTextoSql( lxValor_PK ) + "'">> ) 
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
			lxValorClavePrimaria = this.oEntidad.ID
			lcValorClavePrimariaString = transform( this.oEntidad.ID )

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  CAJAAUDI.CODIGO != 0]
		loColeccion.Agregar( 'delete from ZooLogic.CAJAAUDI where ' + lcFiltro )
			loColeccion.Agregar([delete from ZooLogic.DetAudi where "Codigo" = ] + transform( .oEntidad.ID ))
			loColeccion.cTabla = 'CAJAAUDI' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.CAJAAUDI where  CAJAAUDI.CODIGO != 0" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.CAJAAUDI where Codigo = " + transform( this.oEntidad.ID )+ " and  CAJAAUDI.CODIGO != 0" )
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
		lcCursor = This.oEntidad.cPrefijoRecibir + 'CAJAAUDITORIA'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.CAJAAUDI Where Codigo = ] + transform( &lcCursor..Codigo ), 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					this.oConexion.EjecutarSql( [UPDATE ZooLogic.CAJAAUDI set  FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, Fecha = ] + "'" + this.ConvertirDateSql( &lcCursor..Fecha ) + "'"+ [, Codigo = ] + transform( &lcCursor..Codigo )+ [, NumCaja = ] + transform( &lcCursor..NumCaja )+ [, TIMESTAMP = ] + transform( &lcCursor..TIMESTAMP )+ [, MontoTot = ] + transform( &lcCursor..MontoTot )+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, USER = ] + "'" + this.FormatearTextoSql( &lcCursor..USER ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, Tarea = ] + "'" + this.FormatearTextoSql( &lcCursor..Tarea ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, Hora = ] + "'" + this.FormatearTextoSql( &lcCursor..Hora ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + [ Where Codigo = ] + transform( &lcCursor..Codigo ) )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
				endIf
			else
				Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
				Text to lcCampos noShow
					 FECEXPO, FECTRANS, FMODIFW, FALTAFW, FECIMPO, Fecha, Codigo, NumCaja, TIMESTAMP, MontoTot, SMODIFW, UALTAFW, UMODIFW, ZADSFW, VALTAFW, VMODIFW, SALTAFW, HALTAFW, HMODIFW, BDALTAFW, USER, BDMODIFW, Tarea, ESTTRANS, HORAEXPO, Hora, HORAIMPO
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..Fecha ) + "'" + ',' + transform( &lcCursor..Codigo )
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..NumCaja ) + ',' + transform( &lcCursor..TIMESTAMP ) + ',' + transform( &lcCursor..MontoTot ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..USER ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..Tarea ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Hora ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"
lcValoresCampos = substr(lcValoresCampos,2) 

				this.oConexion.EjecutarSql( [Insert into ZooLogic.CAJAAUDI ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
				this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'CAJAAUDITORIA'
		if This.ActualizaEnRecepcion()
		Local lcIn as String, lcCantRegistros as Integer
		Select( lcCursor )
		Count to lcCantRegistros
		If lcCantRegistros > 0
			lcIn = This.ObtenerInSqlServer( lcCursor, 'Codigo','N')
			lnFragmento = goRegistry.nucleo.cantidadDeElementosEnSentenciaInSQL
			loIn = this.ObtenerColeccionInSqlServer( lcCursor,'','Codigo')
			llEjecutaEnTransaccion = loIn.count > 0
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'BEGIN TRANSACTION' )
			endif
			for i = 1 to loIn.count step lnFragmento
				lcIn = this.ObtenerFragmentoColeccionInSqlServer( loIn, i, lnFragmento )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.DetAudi Where Codigo] + lcIn  )
			endfor
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'COMMIT TRANSACTION' )
			endif
		EndIf
	endif
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMCAJAAUDITORIA'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where Codigo in ( select Codigo from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"Codigo","NROITEM","Monto","Valor"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.DetAudi ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.Codigo     ) + ',' + transform( cDetallesExistentes.NROITEM    ) + ',' + transform( cDetallesExistentes.Monto      ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Valor      ) + "'" + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	Use in select( 'cExistentes' )
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearCursorMemo( tcCursorACrear as String, tcTablaConMemo as String ) as Void
		create cursor &tcCursorACrear ( Codigo N (10) , Orden N(16), texto C(80))
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirComponentes() As Void
		
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function ObtenerIdentificadorParaLoguear( tcCursor as String ) As String
		local lcRetorno as String, lnCC as String , loCC as Object, lni as Integer, lcSecuencia as String
		lcRetorno = this.oEntidad.cDescripcion 
		lcRetorno = lcRetorno + ' - : ' + transform( &tcCursor..Codigo     )
		Return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EsAliasDeProceso( tcAlias As String, tcPrefijo as string ) As Boolean
		local llRetorno as Boolean, lcAlias as String, lcPrefijo As String
		llRetorno = .F.
		lcAlias = upper( alltrim( tcAlias ) )
		lcPrefijo = upper( alltrim( tcPrefijo ) )
		Do Case
			Case  lcAlias == lcPrefijo + 'CAJAAUDITORIA'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'CAJAAUDITORIA_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMCAJAAUDITORIA'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_CajaAudi')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'CAJAAUDITORIA'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..Codigo
		llCondicion = isnull( lxVar )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad CAJAAUDITORIA. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'CAJAAUDITORIA'
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
			lcCursor = This.oEntidad.cPrefijoRecibir + 'CAJAAUDITORIA'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  Fecha     
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_CajaAudi') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_CajaAudi
Create Table ZooLogic.TablaTrabajo_CajaAudi ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fecexpo" datetime  null, 
"fectrans" datetime  null, 
"fmodifw" datetime  null, 
"faltafw" datetime  null, 
"fecimpo" datetime  null, 
"fecha" datetime  null, 
"codigo" numeric( 10, 0 )  null, 
"numcaja" numeric( 2, 0 )  null, 
"timestamp" numeric( 20, 0 )  null, 
"montotot" numeric( 16, 2 )  null, 
"smodifw" char( 7 )  null, 
"ualtafw" char( 100 )  null, 
"umodifw" char( 100 )  null, 
"zadsfw" varchar(max)  null, 
"valtafw" char( 13 )  null, 
"vmodifw" char( 13 )  null, 
"saltafw" char( 7 )  null, 
"haltafw" char( 8 )  null, 
"hmodifw" char( 8 )  null, 
"bdaltafw" char( 8 )  null, 
"user" char( 100 )  null, 
"bdmodifw" char( 8 )  null, 
"tarea" char( 50 )  null, 
"esttrans" char( 20 )  null, 
"horaexpo" char( 8 )  null, 
"hora" char( 8 )  null, 
"horaimpo" char( 8 )  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_CajaAudi' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_CajaAudi' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'CAJAAUDITORIA'
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
			.AgregarMapeo('fecha','fecha')
			.AgregarMapeo('codigo','codigo')
			.AgregarMapeo('numcaja','numcaja')
			.AgregarMapeo('timestamp','timestamp')
			.AgregarMapeo('montotot','montotot')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('user','user')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('tarea','tarea')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('hora','hora')
			.AgregarMapeo('horaimpo','horaimpo')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_CajaAudi'
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
				Update t Set t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FECHA = isnull( d.FECHA, t.FECHA ),t.CODIGO = isnull( d.CODIGO, t.CODIGO ),t.NUMCAJA = isnull( d.NUMCAJA, t.NUMCAJA ),t.TIMESTAMP = isnull( d.TIMESTAMP, t.TIMESTAMP ),t.MONTOTOT = isnull( d.MONTOTOT, t.MONTOTOT ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.USER = isnull( d.USER, t.USER ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.TAREA = isnull( d.TAREA, t.TAREA ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.HORA = isnull( d.HORA, t.HORA ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO )
					from ZooLogic.CAJAAUDI t inner join deleted d 
							 on t.Codigo = d.Codigo
				-- Fin Updates
				insert into ZooLogic.CAJAAUDI(Fecexpo,Fectrans,Fmodifw,Faltafw,Fecimpo,Fecha,Codigo,Numcaja,Timestamp,Montotot,Smodifw,Ualtafw,Umodifw,Zadsfw,Valtafw,Vmodifw,Saltafw,Haltafw,Hmodifw,Bdaltafw,User,Bdmodifw,Tarea,Esttrans,Horaexpo,Hora,Horaimpo)
					Select isnull( d.FECEXPO,''),isnull( d.FECTRANS,''),isnull( d.FMODIFW,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FECIMPO,''),isnull( d.FECHA,''),isnull( d.CODIGO,0),isnull( d.NUMCAJA,0),isnull( d.TIMESTAMP,0),isnull( d.MONTOTOT,0),isnull( d.SMODIFW,''),isnull( d.UALTAFW,''),isnull( d.UMODIFW,''),isnull( d.ZADSFW,''),isnull( d.VALTAFW,''),isnull( d.VMODIFW,''),isnull( d.SALTAFW,''),convert( char(8), getdate(), 108 ),isnull( d.HMODIFW,''),isnull( d.BDALTAFW,''),isnull( d.USER,''),isnull( d.BDMODIFW,''),isnull( d.TAREA,''),isnull( d.ESTTRANS,''),isnull( d.HORAEXPO,''),isnull( d.HORA,''),isnull( d.HORAIMPO,'')
						From deleted d left join ZooLogic.CAJAAUDI pk 
							 on d.Codigo = pk.Codigo
						Where pk.Codigo Is Null 
				-- Fin Inserts
			End
		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_DetAudi( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_CAJAAUDI_DetAudi
ON ZooLogic.TablaTrabajo_CAJAAUDI_DetAudi
AFTER DELETE
As
Begin
Update t Set 
t.CODIGO = isnull( d.CODIGO, t.CODIGO ),
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.MONTO = isnull( d.MONTO, t.MONTO ),
t.VALOR = isnull( d.VALOR, t.VALOR )
from ZooLogic.DetAudi t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.DetAudi
( 
"CODIGO",
"NROITEM",
"MONTO",
"VALOR"
 )
Select 
d.CODIGO,
d.NROITEM,
d.MONTO,
d.VALOR
From deleted d left join ZooLogic.DetAudi pk 
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_CajaAudi') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_CajaAudi
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_CAJAAUDITORIA' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_CAJAAUDITORIA.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_CAJAAUDITORIA.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_CAJAAUDITORIA.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_CAJAAUDITORIA.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_CAJAAUDITORIA.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fecha = GoLibrerias.ObtenerFechaFormateada( nvl( c_CAJAAUDITORIA.Fecha, ctod( '  /  /    ' ) ) )
					.Id = nvl( c_CAJAAUDITORIA.Id, 0 )
					.Cajaestado_PK =  nvl( c_CAJAAUDITORIA.Cajaestado, 0 )
					.Detallevaloresauditoria.Limpiar()
					.Detallevaloresauditoria.SetearEsNavegacion( .lProcesando )
					.Detallevaloresauditoria.Cargar()
					.Timestamp = nvl( c_CAJAAUDITORIA.Timestamp, 0 )
					.Montototal = nvl( c_CAJAAUDITORIA.Montototal, 0 )
					.Seriemodificacionfw = nvl( c_CAJAAUDITORIA.Seriemodificacionfw, [] )
					.Usuarioaltafw = nvl( c_CAJAAUDITORIA.Usuarioaltafw, [] )
					.Usuariomodificacionfw = nvl( c_CAJAAUDITORIA.Usuariomodificacionfw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Versionaltafw = nvl( c_CAJAAUDITORIA.Versionaltafw, [] )
					.Versionmodificacionfw = nvl( c_CAJAAUDITORIA.Versionmodificacionfw, [] )
					.Seriealtafw = nvl( c_CAJAAUDITORIA.Seriealtafw, [] )
					.Horaaltafw = nvl( c_CAJAAUDITORIA.Horaaltafw, [] )
					.Horamodificacionfw = nvl( c_CAJAAUDITORIA.Horamodificacionfw, [] )
					.Basededatosaltafw = nvl( c_CAJAAUDITORIA.Basededatosaltafw, [] )
					.Usuario = nvl( c_CAJAAUDITORIA.Usuario, [] )
					.Basededatosmodificacionfw = nvl( c_CAJAAUDITORIA.Basededatosmodificacionfw, [] )
					.Tarea = nvl( c_CAJAAUDITORIA.Tarea, [] )
					.Estadotransferencia = nvl( c_CAJAAUDITORIA.Estadotransferencia, [] )
					.Horaexpo = nvl( c_CAJAAUDITORIA.Horaexpo, [] )
					.Hora = nvl( c_CAJAAUDITORIA.Hora, [] )
					.Horaimpo = nvl( c_CAJAAUDITORIA.Horaimpo, [] )
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
		
		loDetalle = this.oEntidad.DetalleValoresAuditoria
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
		return c_CAJAAUDITORIA.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.CAJAAUDI' )
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
								from ZooLogic.CAJAAUDI 
								Where   CAJAAUDI.CODIGO != 0
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "CAJAAUDI", "", lcCursor, set("Datasession") )
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
			"Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fecha" as "Fecha", "Codigo" as "Id", "Numcaja" as "Cajaestado", "Timestamp" as "Timestamp", "Montotot" as "Montototal", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Saltafw" as "Seriealtafw", "Haltafw" as "Horaaltafw", "Hmodifw" as "Horamodificacionfw", "Bdaltafw" as "Basededatosaltafw", "User" as "Usuario", "Bdmodifw" as "Basededatosmodificacionfw", "Tarea" as "Tarea", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Hora" as "Hora", "Horaimpo" as "Horaimpo"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.CAJAAUDI 
								Where   CAJAAUDI.CODIGO != 0
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
	Tabla = 'CAJAAUDI'
	Filtro = " CAJAAUDI.CODIGO != 0"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " CAJAAUDI.CODIGO != 0"
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
	<row entidad="CAJAAUDITORIA                           " atributo="FECHAEXPO                               " tabla="CAJAAUDI       " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAJAAUDITORIA                           " atributo="FECHATRANSFERENCIA                      " tabla="CAJAAUDI       " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha transferencia                                                                                                                                             " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAJAAUDITORIA                           " atributo="FECHAMODIFICACIONFW                     " tabla="CAJAAUDI       " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAJAAUDITORIA                           " atributo="FECHAALTAFW                             " tabla="CAJAAUDI       " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAJAAUDITORIA                           " atributo="FECHAIMPO                               " tabla="CAJAAUDI       " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAJAAUDITORIA                           " atributo="FECHA                                   " tabla="CAJAAUDI       " campo="FECHA     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goServicios.Librerias.ObtenerFecha()                                                                                                                                                                                                                         " obligatorio="true" admitebusqueda="4" etiqueta="                                                                                                                                                                " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAJAAUDITORIA                           " atributo="ID                                      " tabla="CAJAAUDI       " campo="CODIGO    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="10" decimales="0" valorsugerido="@ObtenerSiguienteNumerico()                                                                                                                                                                                                                                   " obligatorio="true" admitebusqueda="2" etiqueta="                                                                                                                                                                " dominio="CODIGONUMERICO                " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAJAAUDITORIA                           " atributo="CAJAESTADO                              " tabla="CAJAAUDI       " campo="NUMCAJA   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CAJAESTADO                              " tipodato="N         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="Número de Caja                                                                                                                                                  " dominio="CODIGONUMERICO                " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAJAAUDITORIA                           " atributo="DETALLEVALORESAUDITORIA                 " tabla="DETAUDI        " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="402" etiqueta="Valor                                                                                                                                                           " dominio="DETALLEITEMCAJAAUDITORIA      " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAJAAUDITORIA                           " atributo="TIMESTAMP                               " tabla="CAJAAUDI       " campo="TIMESTAMP " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAJAAUDITORIA                           " atributo="MONTOTOTAL                              " tabla="CAJAAUDI       " campo="MONTOTOT  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="16" decimales="2" valorsugerido="0.00                                                                                                                                                                                                                                                          " obligatorio="false" admitebusqueda="404" etiqueta="Monto                                                                                                                                                           " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAJAAUDITORIA                           " atributo="SERIEMODIFICACIONFW                     " tabla="CAJAAUDI       " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAJAAUDITORIA                           " atributo="USUARIOALTAFW                           " tabla="CAJAAUDI       " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAJAAUDITORIA                           " atributo="USUARIOMODIFICACIONFW                   " tabla="CAJAAUDI       " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAJAAUDITORIA                           " atributo="ZADSFW                                  " tabla="CAJAAUDI       " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAJAAUDITORIA                           " atributo="VERSIONALTAFW                           " tabla="CAJAAUDI       " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAJAAUDITORIA                           " atributo="VERSIONMODIFICACIONFW                   " tabla="CAJAAUDI       " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAJAAUDITORIA                           " atributo="SERIEALTAFW                             " tabla="CAJAAUDI       " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAJAAUDITORIA                           " atributo="HORAALTAFW                              " tabla="CAJAAUDI       " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAJAAUDITORIA                           " atributo="HORAMODIFICACIONFW                      " tabla="CAJAAUDI       " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAJAAUDITORIA                           " atributo="BASEDEDATOSALTAFW                       " tabla="CAJAAUDI       " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAJAAUDITORIA                           " atributo="USUARIO                                 " tabla="CAJAAUDI       " campo="USER      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="=goServicios.Seguridad.cUsuarioLogueado                                                                                                                                                                                                                       " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAJAAUDITORIA                           " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="CAJAAUDI       " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAJAAUDITORIA                           " atributo="TAREA                                   " tabla="CAJAAUDI       " campo="TAREA     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="APERTURA                                                                                                                                                                                                                                                      " obligatorio="false" admitebusqueda="406" etiqueta="Tarea                                                                                                                                                           " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAJAAUDITORIA                           " atributo="ESTADOTRANSFERENCIA                     " tabla="CAJAAUDI       " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado transferencia                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAJAAUDITORIA                           " atributo="HORAEXPO                                " tabla="CAJAAUDI       " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAJAAUDITORIA                           " atributo="HORA                                    " tabla="CAJAAUDI       " campo="HORA      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="=goServicios.Librerias.ObtenerHora()                                                                                                                                                                                                                          " obligatorio="true" admitebusqueda="6" etiqueta="                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAJAAUDITORIA                           " atributo="HORAIMPO                                " tabla="CAJAAUDI       " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAJAESTADO                              " atributo="DESCRIPCION                             " tabla="CAJAESTA       " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="401" etiqueta="Detalle Núm.                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CAJAESTA On CAJAAUDI.NUMCAJA = CAJAESTA.NumCaja And  CAJAESTA.NUMCAJA != 0                                                                                                                                                                         " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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