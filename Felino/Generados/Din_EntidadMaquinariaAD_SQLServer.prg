
define class Din_EntidadMAQUINARIAAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_MAQUINARIA'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = []
	cExpresionCCPorCampos = []
	cTagClaveCandidata = ''
	cTagClavePk = '_MQPPK'
	cTablaPrincipal = 'MAQUINARIA'
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
			local  lxMaquinariaFmodifw, lxMaquinariaFecimpo, lxMaquinariaFectrans, lxMaquinariaFaltafw, lxMaquinariaFecexpo, lxMaquinariaHaltafw, lxMaquinariaHoraexpo, lxMaquinariaHmodifw, lxMaquinariaVmodifw, lxMaquinariaZadsfw, lxMaquinariaValtafw, lxMaquinariaUaltafw, lxMaquinariaUmodifw, lxMaquinariaSaltafw, lxMaquinariaSmodifw, lxMaquinariaHoraimpo, lxMaquinariaEsttrans, lxMaquinariaBdaltafw, lxMaquinariaBdmodifw, lxMaquinariaObs, lxMaquinariaMarca, lxMaquinariaTipifica1, lxMaquinariaCodigo, lxMaquinariaUnidad, lxMaquinariaCantidadp, lxMaquinariaModelo, lxMaquinariaDescrip, lxMaquinariaTipifica2, lxMaquinariaDesperd, lxMaquinariaSerie, lxMaquinariaTipo
				lxMaquinariaFmodifw =  .Fechamodificacionfw			lxMaquinariaFecimpo =  .Fechaimpo			lxMaquinariaFectrans =  .Fechatransferencia			lxMaquinariaFaltafw =  .Fechaaltafw			lxMaquinariaFecexpo =  .Fechaexpo			lxMaquinariaHaltafw =  .Horaaltafw			lxMaquinariaHoraexpo =  .Horaexpo			lxMaquinariaHmodifw =  .Horamodificacionfw			lxMaquinariaVmodifw =  .Versionmodificacionfw			lxMaquinariaZadsfw =  .Zadsfw			lxMaquinariaValtafw =  .Versionaltafw			lxMaquinariaUaltafw =  .Usuarioaltafw			lxMaquinariaUmodifw =  .Usuariomodificacionfw			lxMaquinariaSaltafw =  .Seriealtafw			lxMaquinariaSmodifw =  .Seriemodificacionfw			lxMaquinariaHoraimpo =  .Horaimpo			lxMaquinariaEsttrans =  .Estadotransferencia			lxMaquinariaBdaltafw =  .Basededatosaltafw			lxMaquinariaBdmodifw =  .Basededatosmodificacionfw			lxMaquinariaObs =  .Obs			lxMaquinariaMarca =  .Marca			lxMaquinariaTipifica1 =  upper( .Tipificación1_PK ) 			lxMaquinariaCodigo =  .Codigo			lxMaquinariaUnidad =  .Unidaddetiempo			lxMaquinariaCantidadp =  .Cantidadproducida			lxMaquinariaModelo =  .Modelo			lxMaquinariaDescrip =  .Descripcion			lxMaquinariaTipifica2 =  upper( .Tipificación2_PK ) 			lxMaquinariaDesperd =  .Desperdicio			lxMaquinariaSerie =  .Serie			lxMaquinariaTipo =  .Tipomaquinaria
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxMaquinariaCodigo = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.MAQUINARIA ( "Fmodifw","Fecimpo","Fectrans","Faltafw","Fecexpo","Haltafw","Horaexpo","Hmodifw","Vmodifw","Zadsfw","Valtafw","Ualtafw","Umodifw","Saltafw","Smodifw","Horaimpo","Esttrans","Bdaltafw","Bdmodifw","Obs","Marca","Tipifica1","Codigo","Unidad","Cantidadp","Modelo","Descrip","Tipifica2","Desperd","Serie","Tipo" ) values ( <<"'" + this.ConvertirDateSql( lxMaquinariaFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxMaquinariaFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxMaquinariaFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxMaquinariaFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxMaquinariaFecexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMaquinariaHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMaquinariaHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMaquinariaHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMaquinariaVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMaquinariaZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMaquinariaValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMaquinariaUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMaquinariaUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMaquinariaSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMaquinariaSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMaquinariaHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMaquinariaEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMaquinariaBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMaquinariaBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMaquinariaObs ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMaquinariaMarca ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMaquinariaTipifica1 ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMaquinariaCodigo ) + "'" >>, <<lxMaquinariaUnidad >>, <<lxMaquinariaCantidadp >>, <<"'" + this.FormatearTextoSql( lxMaquinariaModelo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMaquinariaDescrip ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMaquinariaTipifica2 ) + "'" >>, <<lxMaquinariaDesperd >>, <<"'" + this.FormatearTextoSql( lxMaquinariaSerie ) + "'" >>, <<lxMaquinariaTipo >> )
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
		this.ComprobarTransaccion()
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = lxValorClavePrimaria


			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.Consumos
				if this.oEntidad.Consumos.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxConsumo_PK = loItem.Consumo_PK
					lxDescripcion = loItem.Descripcion
					lxValor = loItem.Valor
					lxUnidadmedida = loItem.Unidadmedida
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.MAQDETCONS("NROITEM","CodCons","Consumo","Detalle","Valor","Unidad" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxConsumo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxDescripcion ) + "'">>, <<lxValor>>, <<"'" + this.FormatearTextoSql( lxUnidadmedida ) + "'">> ) 
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
			local  lxMaquinariaFmodifw, lxMaquinariaFecimpo, lxMaquinariaFectrans, lxMaquinariaFaltafw, lxMaquinariaFecexpo, lxMaquinariaHaltafw, lxMaquinariaHoraexpo, lxMaquinariaHmodifw, lxMaquinariaVmodifw, lxMaquinariaZadsfw, lxMaquinariaValtafw, lxMaquinariaUaltafw, lxMaquinariaUmodifw, lxMaquinariaSaltafw, lxMaquinariaSmodifw, lxMaquinariaHoraimpo, lxMaquinariaEsttrans, lxMaquinariaBdaltafw, lxMaquinariaBdmodifw, lxMaquinariaObs, lxMaquinariaMarca, lxMaquinariaTipifica1, lxMaquinariaCodigo, lxMaquinariaUnidad, lxMaquinariaCantidadp, lxMaquinariaModelo, lxMaquinariaDescrip, lxMaquinariaTipifica2, lxMaquinariaDesperd, lxMaquinariaSerie, lxMaquinariaTipo
				lxMaquinariaFmodifw =  .Fechamodificacionfw			lxMaquinariaFecimpo =  .Fechaimpo			lxMaquinariaFectrans =  .Fechatransferencia			lxMaquinariaFaltafw =  .Fechaaltafw			lxMaquinariaFecexpo =  .Fechaexpo			lxMaquinariaHaltafw =  .Horaaltafw			lxMaquinariaHoraexpo =  .Horaexpo			lxMaquinariaHmodifw =  .Horamodificacionfw			lxMaquinariaVmodifw =  .Versionmodificacionfw			lxMaquinariaZadsfw =  .Zadsfw			lxMaquinariaValtafw =  .Versionaltafw			lxMaquinariaUaltafw =  .Usuarioaltafw			lxMaquinariaUmodifw =  .Usuariomodificacionfw			lxMaquinariaSaltafw =  .Seriealtafw			lxMaquinariaSmodifw =  .Seriemodificacionfw			lxMaquinariaHoraimpo =  .Horaimpo			lxMaquinariaEsttrans =  .Estadotransferencia			lxMaquinariaBdaltafw =  .Basededatosaltafw			lxMaquinariaBdmodifw =  .Basededatosmodificacionfw			lxMaquinariaObs =  .Obs			lxMaquinariaMarca =  .Marca			lxMaquinariaTipifica1 =  upper( .Tipificación1_PK ) 			lxMaquinariaCodigo =  .Codigo			lxMaquinariaUnidad =  .Unidaddetiempo			lxMaquinariaCantidadp =  .Cantidadproducida			lxMaquinariaModelo =  .Modelo			lxMaquinariaDescrip =  .Descripcion			lxMaquinariaTipifica2 =  upper( .Tipificación2_PK ) 			lxMaquinariaDesperd =  .Desperdicio			lxMaquinariaSerie =  .Serie			lxMaquinariaTipo =  .Tipomaquinaria
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()
			lxValorClavePrimaria = .oEntidad.CODIGO
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ZooLogic.MAQUINARIA set "Fmodifw" = <<"'" + this.ConvertirDateSql( lxMaquinariaFmodifw ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxMaquinariaFecimpo ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxMaquinariaFectrans ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxMaquinariaFaltafw ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxMaquinariaFecexpo ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxMaquinariaHaltafw ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxMaquinariaHoraexpo ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxMaquinariaHmodifw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxMaquinariaVmodifw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxMaquinariaZadsfw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxMaquinariaValtafw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxMaquinariaUaltafw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxMaquinariaUmodifw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxMaquinariaSaltafw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxMaquinariaSmodifw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxMaquinariaHoraimpo ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxMaquinariaEsttrans ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxMaquinariaBdaltafw ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxMaquinariaBdmodifw ) + "'">>,"Obs" = <<"'" + this.FormatearTextoSql( lxMaquinariaObs ) + "'">>,"Marca" = <<"'" + this.FormatearTextoSql( lxMaquinariaMarca ) + "'">>,"Tipifica1" = <<"'" + this.FormatearTextoSql( lxMaquinariaTipifica1 ) + "'">>,"Codigo" = <<"'" + this.FormatearTextoSql( lxMaquinariaCodigo ) + "'">>,"Unidad" = <<lxMaquinariaUnidad>>,"Cantidadp" = <<lxMaquinariaCantidadp>>,"Modelo" = <<"'" + this.FormatearTextoSql( lxMaquinariaModelo ) + "'">>,"Descrip" = <<"'" + this.FormatearTextoSql( lxMaquinariaDescrip ) + "'">>,"Tipifica2" = <<"'" + this.FormatearTextoSql( lxMaquinariaTipifica2 ) + "'">>,"Desperd" = <<lxMaquinariaDesperd>>,"Serie" = <<"'" + this.FormatearTextoSql( lxMaquinariaSerie ) + "'">>,"Tipo" = <<lxMaquinariaTipo>> where "Codigo" = <<"'" + this.FormatearTextoSql( lxMaquinariaCodigo ) + "'">> and  MAQUINARIA.CODIGO != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			this.ComprobarResultadoDeEjecucionDelUpdate()
		this.ComprobarTransaccion()
			this.oConexion.EjecutarSql( 'delete from ZooLogic.MAQDETCONS where "CodCons" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.Consumos
				if this.oEntidad.Consumos.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxConsumo_PK = loItem.Consumo_PK
					lxDescripcion = loItem.Descripcion
					lxValor = loItem.Valor
					lxUnidadmedida = loItem.Unidadmedida
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.MAQDETCONS("NROITEM","CodCons","Consumo","Detalle","Valor","Unidad" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxConsumo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxDescripcion ) + "'">>, <<lxValor>>, <<"'" + this.FormatearTextoSql( lxUnidadmedida ) + "'">> ) 
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 Codigo from ZooLogic.MAQUINARIA where " + this.ConvertirFuncionesSql( " MAQUINARIA.CODIGO != ''" ) )
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
			Local lxMaquinariaCodigo
			lxMaquinariaCodigo = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Obs" as "Obs", "Marca" as "Marca", "Tipifica1" as "Tipificación1", "Codigo" as "Codigo", "Unidad" as "Unidaddetiempo", "Cantidadp" as "Cantidadproducida", "Modelo" as "Modelo", "Descrip" as "Descripcion", "Tipifica2" as "Tipificación2", "Desperd" as "Desperdicio", "Serie" as "Serie", "Tipo" as "Tipomaquinaria" from ZooLogic.MAQUINARIA where "Codigo" = <<"'" + this.FormatearTextoSql( lxMaquinariaCodigo ) + "'">> and  MAQUINARIA.CODIGO != ''
			endtext
			use in select('c_MAQUINARIA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_MAQUINARIA', set( 'Datasession' ) )

			if reccount( 'c_MAQUINARIA' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codcons" as "Codigo", "Consumo" as "Consumo", "Detalle" as "Descripcion", "Valor" as "Valor", "Unidad" as "Unidadmedida" from ZooLogic.MAQDETCONS where CodCons = <<"'" + this.FormatearTextoSql( c_MAQUINARIA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_Consumos')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Consumos', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Consumos
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxMaquinariaCodigo as Variant
		llRetorno = .t.
		lxMaquinariaCodigo = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.MAQUINARIA where "Codigo" = <<"'" + this.FormatearTextoSql( lxMaquinariaCodigo ) + "'">> and  MAQUINARIA.CODIGO != ''
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
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Obs" as "Obs", "Marca" as "Marca", "Tipifica1" as "Tipificación1", "Codigo" as "Codigo", "Unidad" as "Unidaddetiempo", "Cantidadp" as "Cantidadproducida", "Modelo" as "Modelo", "Descrip" as "Descripcion", "Tipifica2" as "Tipificación2", "Desperd" as "Desperdicio", "Serie" as "Serie", "Tipo" as "Tipomaquinaria" from ZooLogic.MAQUINARIA where  MAQUINARIA.CODIGO != '' order by Codigo
			endtext
			use in select('c_MAQUINARIA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_MAQUINARIA', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codcons" as "Codigo", "Consumo" as "Consumo", "Detalle" as "Descripcion", "Valor" as "Valor", "Unidad" as "Unidadmedida" from ZooLogic.MAQDETCONS where CodCons = <<"'" + this.FormatearTextoSql( c_MAQUINARIA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_Consumos')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Consumos', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Consumos
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
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Obs" as "Obs", "Marca" as "Marca", "Tipifica1" as "Tipificación1", "Codigo" as "Codigo", "Unidad" as "Unidaddetiempo", "Cantidadp" as "Cantidadproducida", "Modelo" as "Modelo", "Descrip" as "Descripcion", "Tipifica2" as "Tipificación2", "Desperd" as "Desperdicio", "Serie" as "Serie", "Tipo" as "Tipomaquinaria" from ZooLogic.MAQUINARIA where  funciones.padr( Codigo, 10, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  MAQUINARIA.CODIGO != '' order by Codigo
			endtext
			use in select('c_MAQUINARIA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_MAQUINARIA', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codcons" as "Codigo", "Consumo" as "Consumo", "Detalle" as "Descripcion", "Valor" as "Valor", "Unidad" as "Unidadmedida" from ZooLogic.MAQDETCONS where CodCons = <<"'" + this.FormatearTextoSql( c_MAQUINARIA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_Consumos')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Consumos', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Consumos
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
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Obs" as "Obs", "Marca" as "Marca", "Tipifica1" as "Tipificación1", "Codigo" as "Codigo", "Unidad" as "Unidaddetiempo", "Cantidadp" as "Cantidadproducida", "Modelo" as "Modelo", "Descrip" as "Descripcion", "Tipifica2" as "Tipificación2", "Desperd" as "Desperdicio", "Serie" as "Serie", "Tipo" as "Tipomaquinaria" from ZooLogic.MAQUINARIA where  funciones.padr( Codigo, 10, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  MAQUINARIA.CODIGO != '' order by Codigo desc
			endtext
			use in select('c_MAQUINARIA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_MAQUINARIA', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codcons" as "Codigo", "Consumo" as "Consumo", "Detalle" as "Descripcion", "Valor" as "Valor", "Unidad" as "Unidadmedida" from ZooLogic.MAQDETCONS where CodCons = <<"'" + this.FormatearTextoSql( c_MAQUINARIA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_Consumos')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Consumos', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Consumos
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
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Obs" as "Obs", "Marca" as "Marca", "Tipifica1" as "Tipificación1", "Codigo" as "Codigo", "Unidad" as "Unidaddetiempo", "Cantidadp" as "Cantidadproducida", "Modelo" as "Modelo", "Descrip" as "Descripcion", "Tipifica2" as "Tipificación2", "Desperd" as "Desperdicio", "Serie" as "Serie", "Tipo" as "Tipomaquinaria" from ZooLogic.MAQUINARIA where  MAQUINARIA.CODIGO != '' order by Codigo desc
			endtext
			use in select('c_MAQUINARIA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_MAQUINARIA', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codcons" as "Codigo", "Consumo" as "Consumo", "Detalle" as "Descripcion", "Valor" as "Valor", "Unidad" as "Unidadmedida" from ZooLogic.MAQDETCONS where CodCons = <<"'" + this.FormatearTextoSql( c_MAQUINARIA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_Consumos')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Consumos', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Consumos
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
			lcXml = this.oConexion.EjecutarSql( "select Fmodifw,Fecimpo,Fectrans,Faltafw,Fecexpo,Haltafw,Horaexpo,Hmodifw,Vmodifw,Zadsfw,Valtafw,Ual" + ;
"tafw,Umodifw,Saltafw,Smodifw,Horaimpo,Esttrans,Bdaltafw,Bdmodifw,Obs,Marca,Tipifica1,Codigo,Unidad,C" + ;
"antidadp,Modelo,Descrip,Tipifica2,Desperd,Serie,Tipo" + ;
" from ZooLogic.MAQUINARIA where  MAQUINARIA.CODIGO != '' and " + lcFiltro )
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
			local  lxMaquinariaFmodifw, lxMaquinariaFecimpo, lxMaquinariaFectrans, lxMaquinariaFaltafw, lxMaquinariaFecexpo, lxMaquinariaHaltafw, lxMaquinariaHoraexpo, lxMaquinariaHmodifw, lxMaquinariaVmodifw, lxMaquinariaZadsfw, lxMaquinariaValtafw, lxMaquinariaUaltafw, lxMaquinariaUmodifw, lxMaquinariaSaltafw, lxMaquinariaSmodifw, lxMaquinariaHoraimpo, lxMaquinariaEsttrans, lxMaquinariaBdaltafw, lxMaquinariaBdmodifw, lxMaquinariaObs, lxMaquinariaMarca, lxMaquinariaTipifica1, lxMaquinariaCodigo, lxMaquinariaUnidad, lxMaquinariaCantidadp, lxMaquinariaModelo, lxMaquinariaDescrip, lxMaquinariaTipifica2, lxMaquinariaDesperd, lxMaquinariaSerie, lxMaquinariaTipo
				lxMaquinariaFmodifw = ctod( '  /  /    ' )			lxMaquinariaFecimpo = ctod( '  /  /    ' )			lxMaquinariaFectrans = ctod( '  /  /    ' )			lxMaquinariaFaltafw = ctod( '  /  /    ' )			lxMaquinariaFecexpo = ctod( '  /  /    ' )			lxMaquinariaHaltafw = []			lxMaquinariaHoraexpo = []			lxMaquinariaHmodifw = []			lxMaquinariaVmodifw = []			lxMaquinariaZadsfw = []			lxMaquinariaValtafw = []			lxMaquinariaUaltafw = []			lxMaquinariaUmodifw = []			lxMaquinariaSaltafw = []			lxMaquinariaSmodifw = []			lxMaquinariaHoraimpo = []			lxMaquinariaEsttrans = []			lxMaquinariaBdaltafw = []			lxMaquinariaBdmodifw = []			lxMaquinariaObs = []			lxMaquinariaMarca = []			lxMaquinariaTipifica1 = []			lxMaquinariaCodigo = []			lxMaquinariaUnidad = 0			lxMaquinariaCantidadp = 0			lxMaquinariaModelo = []			lxMaquinariaDescrip = []			lxMaquinariaTipifica2 = []			lxMaquinariaDesperd = 0			lxMaquinariaSerie = []			lxMaquinariaTipo = 0
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.MAQDETCONS where "CodCons" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( [delete from ZooLogic.MAQUINARIA where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'MAQUINARIA' + '_' + tcCampo
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
		lcWhere = " Where  MAQUINARIA.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Obs" as "Obs", "Marca" as "Marca", "Tipifica1" as "Tipificación1", "Codigo" as "Codigo", "Unidad" as "Unidaddetiempo", "Cantidadp" as "Cantidadproducida", "Modelo" as "Modelo", "Descrip" as "Descripcion", "Tipifica2" as "Tipificación2", "Desperd" as "Desperdicio", "Serie" as "Serie", "Tipo" as "Tipomaquinaria"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'MAQUINARIA', '', tnTope )
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
	Function ObtenerDatosDetalleConsumos( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  MAQDETCONS.CODCONS != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Nroitem" as "Nroitem", "Codcons" as "Codigo", "Consumo" as "Consumo", "Detalle" as "Descripcion", "Valor" as "Valor", "Unidad" as "Unidadmedida"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleConsumos( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'MAQDETCONS', 'Consumos', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleConsumos( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleConsumos( lcAtributo )
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
				Case lcAtributo == 'FECHAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECIMPO AS FECHAIMPO'
				Case lcAtributo == 'FECHATRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRANS AS FECHATRANSFERENCIA'
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'FECHAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECEXPO AS FECHAEXPO'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'OBS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'OBS AS OBS'
				Case lcAtributo == 'MARCA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MARCA AS MARCA'
				Case lcAtributo == 'TIPIFICACIÓN1'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPIFICA1 AS TIPIFICACIÓN1'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'UNIDADDETIEMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UNIDAD AS UNIDADDETIEMPO'
				Case lcAtributo == 'CANTIDADPRODUCIDA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CANTIDADP AS CANTIDADPRODUCIDA'
				Case lcAtributo == 'MODELO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MODELO AS MODELO'
				Case lcAtributo == 'DESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCRIP AS DESCRIPCION'
				Case lcAtributo == 'TIPIFICACIÓN2'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPIFICA2 AS TIPIFICACIÓN2'
				Case lcAtributo == 'DESPERDICIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESPERD AS DESPERDICIO'
				Case lcAtributo == 'SERIE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SERIE AS SERIE'
				Case lcAtributo == 'TIPOMAQUINARIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPO AS TIPOMAQUINARIA'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleConsumos( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODCONS AS CODIGO'
				Case lcAtributo == 'CONSUMO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CONSUMO AS CONSUMO'
				Case lcAtributo == 'DESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DETALLE AS DESCRIPCION'
				Case lcAtributo == 'VALOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALOR AS VALOR'
				Case lcAtributo == 'UNIDADMEDIDA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UNIDAD AS UNIDADMEDIDA'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHAIMPO'
				lcCampo = 'FECIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEXPO'
				lcCampo = 'FECEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'OBS'
				lcCampo = 'OBS'
			Case upper( alltrim( tcAtributo ) ) == 'MARCA'
				lcCampo = 'MARCA'
			Case upper( alltrim( tcAtributo ) ) == 'TIPIFICACIÓN1'
				lcCampo = 'TIPIFICA1'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'UNIDADDETIEMPO'
				lcCampo = 'UNIDAD'
			Case upper( alltrim( tcAtributo ) ) == 'CANTIDADPRODUCIDA'
				lcCampo = 'CANTIDADP'
			Case upper( alltrim( tcAtributo ) ) == 'MODELO'
				lcCampo = 'MODELO'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCION'
				lcCampo = 'DESCRIP'
			Case upper( alltrim( tcAtributo ) ) == 'TIPIFICACIÓN2'
				lcCampo = 'TIPIFICA2'
			Case upper( alltrim( tcAtributo ) ) == 'DESPERDICIO'
				lcCampo = 'DESPERD'
			Case upper( alltrim( tcAtributo ) ) == 'SERIE'
				lcCampo = 'SERIE'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOMAQUINARIA'
				lcCampo = 'TIPO'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleConsumos( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODCONS'
			Case upper( alltrim( tcAtributo ) ) == 'CONSUMO'
				lcCampo = 'CONSUMO'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCION'
				lcCampo = 'DETALLE'
			Case upper( alltrim( tcAtributo ) ) == 'VALOR'
				lcCampo = 'VALOR'
			Case upper( alltrim( tcAtributo ) ) == 'UNIDADMEDIDA'
				lcCampo = 'UNIDAD'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerTablaDetalle( tcDetalle as string ) as String
		local lcRetorno as string
		lcRetorno = ''
		if upper( alltrim( tcDetalle ) ) == 'CONSUMOS'
			lcRetorno = 'MAQDETCONS'
		EndIf
		return lcRetorno
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasInsert() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcSentencia as string, loItem as object
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxMaquinariaFmodifw, lxMaquinariaFecimpo, lxMaquinariaFectrans, lxMaquinariaFaltafw, lxMaquinariaFecexpo, lxMaquinariaHaltafw, lxMaquinariaHoraexpo, lxMaquinariaHmodifw, lxMaquinariaVmodifw, lxMaquinariaZadsfw, lxMaquinariaValtafw, lxMaquinariaUaltafw, lxMaquinariaUmodifw, lxMaquinariaSaltafw, lxMaquinariaSmodifw, lxMaquinariaHoraimpo, lxMaquinariaEsttrans, lxMaquinariaBdaltafw, lxMaquinariaBdmodifw, lxMaquinariaObs, lxMaquinariaMarca, lxMaquinariaTipifica1, lxMaquinariaCodigo, lxMaquinariaUnidad, lxMaquinariaCantidadp, lxMaquinariaModelo, lxMaquinariaDescrip, lxMaquinariaTipifica2, lxMaquinariaDesperd, lxMaquinariaSerie, lxMaquinariaTipo
				lxMaquinariaFmodifw =  .Fechamodificacionfw			lxMaquinariaFecimpo =  .Fechaimpo			lxMaquinariaFectrans =  .Fechatransferencia			lxMaquinariaFaltafw =  .Fechaaltafw			lxMaquinariaFecexpo =  .Fechaexpo			lxMaquinariaHaltafw =  .Horaaltafw			lxMaquinariaHoraexpo =  .Horaexpo			lxMaquinariaHmodifw =  .Horamodificacionfw			lxMaquinariaVmodifw =  .Versionmodificacionfw			lxMaquinariaZadsfw =  .Zadsfw			lxMaquinariaValtafw =  .Versionaltafw			lxMaquinariaUaltafw =  .Usuarioaltafw			lxMaquinariaUmodifw =  .Usuariomodificacionfw			lxMaquinariaSaltafw =  .Seriealtafw			lxMaquinariaSmodifw =  .Seriemodificacionfw			lxMaquinariaHoraimpo =  .Horaimpo			lxMaquinariaEsttrans =  .Estadotransferencia			lxMaquinariaBdaltafw =  .Basededatosaltafw			lxMaquinariaBdmodifw =  .Basededatosmodificacionfw			lxMaquinariaObs =  .Obs			lxMaquinariaMarca =  .Marca			lxMaquinariaTipifica1 =  upper( .Tipificación1_PK ) 			lxMaquinariaCodigo =  .Codigo			lxMaquinariaUnidad =  .Unidaddetiempo			lxMaquinariaCantidadp =  .Cantidadproducida			lxMaquinariaModelo =  .Modelo			lxMaquinariaDescrip =  .Descripcion			lxMaquinariaTipifica2 =  upper( .Tipificación2_PK ) 			lxMaquinariaDesperd =  .Desperdicio			lxMaquinariaSerie =  .Serie			lxMaquinariaTipo =  .Tipomaquinaria
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.MAQUINARIA ( "Fmodifw","Fecimpo","Fectrans","Faltafw","Fecexpo","Haltafw","Horaexpo","Hmodifw","Vmodifw","Zadsfw","Valtafw","Ualtafw","Umodifw","Saltafw","Smodifw","Horaimpo","Esttrans","Bdaltafw","Bdmodifw","Obs","Marca","Tipifica1","Codigo","Unidad","Cantidadp","Modelo","Descrip","Tipifica2","Desperd","Serie","Tipo" ) values ( <<"'" + this.ConvertirDateSql( lxMaquinariaFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxMaquinariaFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxMaquinariaFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxMaquinariaFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxMaquinariaFecexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMaquinariaHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMaquinariaHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMaquinariaHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMaquinariaVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMaquinariaZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMaquinariaValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMaquinariaUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMaquinariaUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMaquinariaSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMaquinariaSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMaquinariaHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMaquinariaEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMaquinariaBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMaquinariaBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMaquinariaObs ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMaquinariaMarca ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMaquinariaTipifica1 ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMaquinariaCodigo ) + "'" >>, <<lxMaquinariaUnidad >>, <<lxMaquinariaCantidadp >>, <<"'" + this.FormatearTextoSql( lxMaquinariaModelo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMaquinariaDescrip ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMaquinariaTipifica2 ) + "'" >>, <<lxMaquinariaDesperd >>, <<"'" + this.FormatearTextoSql( lxMaquinariaSerie ) + "'" >>, <<lxMaquinariaTipo >> )
		endtext
		loColeccion.cTabla = 'MAQUINARIA' 
		loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		With this
			local lcValorClavePrimariaString as String
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.Consumos
				if this.oEntidad.Consumos.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxConsumo_PK = loItem.Consumo_PK
					lxDescripcion = loItem.Descripcion
					lxValor = loItem.Valor
					lxUnidadmedida = loItem.Unidadmedida
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.MAQDETCONS("NROITEM","CodCons","Consumo","Detalle","Valor","Unidad" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxConsumo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxDescripcion ) + "'">>, <<lxValor>>, <<"'" + this.FormatearTextoSql( lxUnidadmedida ) + "'">> ) 
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
			local  lxMaquinariaFmodifw, lxMaquinariaFecimpo, lxMaquinariaFectrans, lxMaquinariaFaltafw, lxMaquinariaFecexpo, lxMaquinariaHaltafw, lxMaquinariaHoraexpo, lxMaquinariaHmodifw, lxMaquinariaVmodifw, lxMaquinariaZadsfw, lxMaquinariaValtafw, lxMaquinariaUaltafw, lxMaquinariaUmodifw, lxMaquinariaSaltafw, lxMaquinariaSmodifw, lxMaquinariaHoraimpo, lxMaquinariaEsttrans, lxMaquinariaBdaltafw, lxMaquinariaBdmodifw, lxMaquinariaObs, lxMaquinariaMarca, lxMaquinariaTipifica1, lxMaquinariaCodigo, lxMaquinariaUnidad, lxMaquinariaCantidadp, lxMaquinariaModelo, lxMaquinariaDescrip, lxMaquinariaTipifica2, lxMaquinariaDesperd, lxMaquinariaSerie, lxMaquinariaTipo
				lxMaquinariaFmodifw =  .Fechamodificacionfw			lxMaquinariaFecimpo =  .Fechaimpo			lxMaquinariaFectrans =  .Fechatransferencia			lxMaquinariaFaltafw =  .Fechaaltafw			lxMaquinariaFecexpo =  .Fechaexpo			lxMaquinariaHaltafw =  .Horaaltafw			lxMaquinariaHoraexpo =  .Horaexpo			lxMaquinariaHmodifw =  .Horamodificacionfw			lxMaquinariaVmodifw =  .Versionmodificacionfw			lxMaquinariaZadsfw =  .Zadsfw			lxMaquinariaValtafw =  .Versionaltafw			lxMaquinariaUaltafw =  .Usuarioaltafw			lxMaquinariaUmodifw =  .Usuariomodificacionfw			lxMaquinariaSaltafw =  .Seriealtafw			lxMaquinariaSmodifw =  .Seriemodificacionfw			lxMaquinariaHoraimpo =  .Horaimpo			lxMaquinariaEsttrans =  .Estadotransferencia			lxMaquinariaBdaltafw =  .Basededatosaltafw			lxMaquinariaBdmodifw =  .Basededatosmodificacionfw			lxMaquinariaObs =  .Obs			lxMaquinariaMarca =  .Marca			lxMaquinariaTipifica1 =  upper( .Tipificación1_PK ) 			lxMaquinariaCodigo =  .Codigo			lxMaquinariaUnidad =  .Unidaddetiempo			lxMaquinariaCantidadp =  .Cantidadproducida			lxMaquinariaModelo =  .Modelo			lxMaquinariaDescrip =  .Descripcion			lxMaquinariaTipifica2 =  upper( .Tipificación2_PK ) 			lxMaquinariaDesperd =  .Desperdicio			lxMaquinariaSerie =  .Serie			lxMaquinariaTipo =  .Tipomaquinaria
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  MAQUINARIA.CODIGO != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.MAQUINARIA set "Fmodifw" = <<"'" + this.ConvertirDateSql( lxMaquinariaFmodifw ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxMaquinariaFecimpo ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxMaquinariaFectrans ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxMaquinariaFaltafw ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxMaquinariaFecexpo ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxMaquinariaHaltafw ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxMaquinariaHoraexpo ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxMaquinariaHmodifw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxMaquinariaVmodifw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxMaquinariaZadsfw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxMaquinariaValtafw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxMaquinariaUaltafw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxMaquinariaUmodifw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxMaquinariaSaltafw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxMaquinariaSmodifw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxMaquinariaHoraimpo ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxMaquinariaEsttrans ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxMaquinariaBdaltafw ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxMaquinariaBdmodifw ) + "'">>, "Obs" = <<"'" + this.FormatearTextoSql( lxMaquinariaObs ) + "'">>, "Marca" = <<"'" + this.FormatearTextoSql( lxMaquinariaMarca ) + "'">>, "Tipifica1" = <<"'" + this.FormatearTextoSql( lxMaquinariaTipifica1 ) + "'">>, "Codigo" = <<"'" + this.FormatearTextoSql( lxMaquinariaCodigo ) + "'">>, "Unidad" = <<lxMaquinariaUnidad>>, "Cantidadp" = <<lxMaquinariaCantidadp>>, "Modelo" = <<"'" + this.FormatearTextoSql( lxMaquinariaModelo ) + "'">>, "Descrip" = <<"'" + this.FormatearTextoSql( lxMaquinariaDescrip ) + "'">>, "Tipifica2" = <<"'" + this.FormatearTextoSql( lxMaquinariaTipifica2 ) + "'">>, "Desperd" = <<lxMaquinariaDesperd>>, "Serie" = <<"'" + this.FormatearTextoSql( lxMaquinariaSerie ) + "'">>, "Tipo" = <<lxMaquinariaTipo>> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'MAQUINARIA' 
		loColeccion.agregar( strtran(  lcSentencia, chr( 9 ), '' ) )
			loColeccion.Agregar([delete from ZooLogic.MAQDETCONS where "CodCons" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.Consumos
				if this.oEntidad.Consumos.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxConsumo_PK = loItem.Consumo_PK
					lxDescripcion = loItem.Descripcion
					lxValor = loItem.Valor
					lxUnidadmedida = loItem.Unidadmedida
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.MAQDETCONS("NROITEM","CodCons","Consumo","Detalle","Valor","Unidad" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxConsumo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxDescripcion ) + "'">>, <<lxValor>>, <<"'" + this.FormatearTextoSql( lxUnidadmedida ) + "'">> ) 
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

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  MAQUINARIA.CODIGO != '']
		loColeccion.Agregar( 'delete from ZooLogic.MAQUINARIA where ' + lcFiltro )
			loColeccion.Agregar([delete from ZooLogic.MAQDETCONS where "CodCons" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.cTabla = 'MAQUINARIA' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.MAQUINARIA where  MAQUINARIA.CODIGO != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.MAQUINARIA where Codigo = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  MAQUINARIA.CODIGO != ''" )
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
		lcCursor = This.oEntidad.cPrefijoRecibir + 'MAQUINARIA'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.MAQUINARIA Where Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'", 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					this.oConexion.EjecutarSql( [UPDATE ZooLogic.MAQUINARIA set  FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, Obs = ] + "'" + this.FormatearTextoSql( &lcCursor..Obs ) + "'"+ [, Marca = ] + "'" + this.FormatearTextoSql( &lcCursor..Marca ) + "'"+ [, Tipifica1 = ] + "'" + this.FormatearTextoSql( &lcCursor..Tipifica1 ) + "'"+ [, Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'"+ [, Unidad = ] + transform( &lcCursor..Unidad )+ [, CantidadP = ] + transform( &lcCursor..CantidadP )+ [, Modelo = ] + "'" + this.FormatearTextoSql( &lcCursor..Modelo ) + "'"+ [, Descrip = ] + "'" + this.FormatearTextoSql( &lcCursor..Descrip ) + "'"+ [, Tipifica2 = ] + "'" + this.FormatearTextoSql( &lcCursor..Tipifica2 ) + "'"+ [, Desperd = ] + transform( &lcCursor..Desperd )+ [, Serie = ] + "'" + this.FormatearTextoSql( &lcCursor..Serie ) + "'"+ [, Tipo = ] + transform( &lcCursor..Tipo ) + [ Where Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'" )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
				endIf
			else
				Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
				Text to lcCampos noShow
					 FMODIFW, FECIMPO, FECTRANS, FALTAFW, FECEXPO, HALTAFW, HORAEXPO, HMODIFW, VMODIFW, ZADSFW, VALTAFW, UALTAFW, UMODIFW, SALTAFW, SMODIFW, HORAIMPO, ESTTRANS, BDALTAFW, BDMODIFW, Obs, Marca, Tipifica1, Codigo, Unidad, CantidadP, Modelo, Descrip, Tipifica2, Desperd, Serie, Tipo
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Obs ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Marca ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..Tipifica1 ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'" + ',' + transform( &lcCursor..Unidad ) + ',' + transform( &lcCursor..CantidadP ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..Modelo ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Descrip ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Tipifica2 ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..Desperd ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..Serie ) + "'" + ',' + transform( &lcCursor..Tipo )
lcValoresCampos = substr(lcValoresCampos,2) 

				this.oConexion.EjecutarSql( [Insert into ZooLogic.MAQUINARIA ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
				this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'MAQUINARIA'
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
			this.oConexion.EjecutarSql( [Delete From ZooLogic.MAQDETCONS Where CodCons] + lcIn  )
			endfor
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'COMMIT TRANSACTION' )
			endif
		EndIf
	endif
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMMAQUINARIACONSUMO'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where CodCons in ( select Codigo from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"NROITEM","CodCons","Consumo","Detalle","Valor","Unidad"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.MAQDETCONS ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CodCons    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Consumo    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Detalle    ) + "'" + ',' + transform( cDetallesExistentes.Valor      ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Unidad     ) + "'" + ' )'  )
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
			Case  lcAlias == lcPrefijo + 'MAQUINARIA'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'MAQUINARIA_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'MAQUINARIA_OBS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMMAQUINARIACONSUMO'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_MAQUINARIA')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'MAQUINARIA'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..Codigo
		llCondicion = isnull( lxVar )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad MAQUINARIA. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'MAQUINARIA'
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
			lcCursor = This.oEntidad.cPrefijoRecibir + 'MAQUINARIA'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_MAQUINARIA') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_MAQUINARIA
Create Table ZooLogic.TablaTrabajo_MAQUINARIA ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fmodifw" datetime  null, 
"fecimpo" datetime  null, 
"fectrans" datetime  null, 
"faltafw" datetime  null, 
"fecexpo" datetime  null, 
"haltafw" char( 8 )  null, 
"horaexpo" char( 8 )  null, 
"hmodifw" char( 8 )  null, 
"vmodifw" char( 13 )  null, 
"zadsfw" varchar(max)  null, 
"valtafw" char( 13 )  null, 
"ualtafw" char( 100 )  null, 
"umodifw" char( 100 )  null, 
"saltafw" char( 7 )  null, 
"smodifw" char( 7 )  null, 
"horaimpo" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"bdaltafw" char( 8 )  null, 
"bdmodifw" char( 8 )  null, 
"obs" varchar(max)  null, 
"marca" char( 60 )  null, 
"tipifica1" char( 10 )  null, 
"codigo" char( 10 )  null, 
"unidad" numeric( 1, 0 )  null, 
"cantidadp" numeric( 11, 6 )  null, 
"modelo" char( 60 )  null, 
"descrip" char( 100 )  null, 
"tipifica2" char( 10 )  null, 
"desperd" numeric( 11, 6 )  null, 
"serie" char( 60 )  null, 
"tipo" numeric( 1, 0 )  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_MAQUINARIA' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_MAQUINARIA' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'MAQUINARIA'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		with loManejador
			if this.oEntidad.VerificarContexto( 'CB' )
			else
				.AgregarMapeo('Nrolinea','Nrolinea')
			endif
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('obs','obs')
			.AgregarMapeo('marca','marca')
			.AgregarMapeo('tipifica1','tipifica1')
			.AgregarMapeo('codigo','codigo')
			.AgregarMapeo('unidad','unidad')
			.AgregarMapeo('cantidadp','cantidadp')
			.AgregarMapeo('modelo','modelo')
			.AgregarMapeo('descrip','descrip')
			.AgregarMapeo('tipifica2','tipifica2')
			.AgregarMapeo('desperd','desperd')
			.AgregarMapeo('serie','serie')
			.AgregarMapeo('tipo','tipo')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_MAQUINARIA'
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
				Update t Set t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.OBS = isnull( d.OBS, t.OBS ),t.MARCA = isnull( d.MARCA, t.MARCA ),t.TIPIFICA1 = isnull( d.TIPIFICA1, t.TIPIFICA1 ),t.CODIGO = isnull( d.CODIGO, t.CODIGO ),t.UNIDAD = isnull( d.UNIDAD, t.UNIDAD ),t.CANTIDADP = isnull( d.CANTIDADP, t.CANTIDADP ),t.MODELO = isnull( d.MODELO, t.MODELO ),t.DESCRIP = isnull( d.DESCRIP, t.DESCRIP ),t.TIPIFICA2 = isnull( d.TIPIFICA2, t.TIPIFICA2 ),t.DESPERD = isnull( d.DESPERD, t.DESPERD ),t.SERIE = isnull( d.SERIE, t.SERIE ),t.TIPO = isnull( d.TIPO, t.TIPO )
					from ZooLogic.MAQUINARIA t inner join deleted d 
							 on t.Codigo = d.Codigo
				-- Fin Updates
				insert into ZooLogic.MAQUINARIA(Fmodifw,Fecimpo,Fectrans,Faltafw,Fecexpo,Haltafw,Horaexpo,Hmodifw,Vmodifw,Zadsfw,Valtafw,Ualtafw,Umodifw,Saltafw,Smodifw,Horaimpo,Esttrans,Bdaltafw,Bdmodifw,Obs,Marca,Tipifica1,Codigo,Unidad,Cantidadp,Modelo,Descrip,Tipifica2,Desperd,Serie,Tipo)
					Select isnull( d.FMODIFW,''),isnull( d.FECIMPO,''),isnull( d.FECTRANS,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FECEXPO,''),convert( char(8), getdate(), 108 ),isnull( d.HORAEXPO,''),isnull( d.HMODIFW,''),isnull( d.VMODIFW,''),isnull( d.ZADSFW,''),isnull( d.VALTAFW,''),isnull( d.UALTAFW,''),isnull( d.UMODIFW,''),isnull( d.SALTAFW,''),isnull( d.SMODIFW,''),isnull( d.HORAIMPO,''),isnull( d.ESTTRANS,''),isnull( d.BDALTAFW,''),isnull( d.BDMODIFW,''),isnull( d.OBS,''),isnull( d.MARCA,''),isnull( d.TIPIFICA1,''),isnull( d.CODIGO,''),isnull( d.UNIDAD,0),isnull( d.CANTIDADP,0),isnull( d.MODELO,''),isnull( d.DESCRIP,''),isnull( d.TIPIFICA2,''),isnull( d.DESPERD,0),isnull( d.SERIE,''),isnull( d.TIPO,0)
						From deleted d left join ZooLogic.MAQUINARIA pk 
							 on d.Codigo = pk.Codigo
						Where pk.Codigo Is Null 
				-- Fin Inserts
			End
		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_MAQDETCONS( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_MAQUINARIA_MAQDETCONS
ON ZooLogic.TablaTrabajo_MAQUINARIA_MAQDETCONS
AFTER DELETE
As
Begin
Update t Set 
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.CODCONS = isnull( d.CODCONS, t.CODCONS ),
t.CONSUMO = isnull( d.CONSUMO, t.CONSUMO ),
t.DETALLE = isnull( d.DETALLE, t.DETALLE ),
t.VALOR = isnull( d.VALOR, t.VALOR ),
t.UNIDAD = isnull( d.UNIDAD, t.UNIDAD )
from ZooLogic.MAQDETCONS t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.MAQDETCONS
( 
"NROITEM",
"CODCONS",
"CONSUMO",
"DETALLE",
"VALOR",
"UNIDAD"
 )
Select 
d.NROITEM,
d.CODCONS,
d.CONSUMO,
d.DETALLE,
d.VALOR,
d.UNIDAD
From deleted d left join ZooLogic.MAQDETCONS pk 
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_MAQUINARIA') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_MAQUINARIA
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_MAQUINARIA' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_MAQUINARIA.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_MAQUINARIA.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_MAQUINARIA.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_MAQUINARIA.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_MAQUINARIA.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Horaaltafw = nvl( c_MAQUINARIA.Horaaltafw, [] )
					.Horaexpo = nvl( c_MAQUINARIA.Horaexpo, [] )
					.Horamodificacionfw = nvl( c_MAQUINARIA.Horamodificacionfw, [] )
					.Versionmodificacionfw = nvl( c_MAQUINARIA.Versionmodificacionfw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Versionaltafw = nvl( c_MAQUINARIA.Versionaltafw, [] )
					.Usuarioaltafw = nvl( c_MAQUINARIA.Usuarioaltafw, [] )
					.Usuariomodificacionfw = nvl( c_MAQUINARIA.Usuariomodificacionfw, [] )
					.Seriealtafw = nvl( c_MAQUINARIA.Seriealtafw, [] )
					.Seriemodificacionfw = nvl( c_MAQUINARIA.Seriemodificacionfw, [] )
					.Horaimpo = nvl( c_MAQUINARIA.Horaimpo, [] )
					.Estadotransferencia = nvl( c_MAQUINARIA.Estadotransferencia, [] )
					.Basededatosaltafw = nvl( c_MAQUINARIA.Basededatosaltafw, [] )
					.Basededatosmodificacionfw = nvl( c_MAQUINARIA.Basededatosmodificacionfw, [] )
					lcValor = This.ObtenerMemo( 'c_Obs')
					.Obs = lcValor 
					.Consumos.Limpiar()
					.Consumos.SetearEsNavegacion( .lProcesando )
					.Consumos.Cargar()
					.Marca = nvl( c_MAQUINARIA.Marca, [] )
					.Tipificación1_PK =  nvl( c_MAQUINARIA.Tipificación1, [] )
					.Codigo = nvl( c_MAQUINARIA.Codigo, [] )
					.Unidaddetiempo = nvl( c_MAQUINARIA.Unidaddetiempo, 0 )
					.Cantidadproducida = nvl( c_MAQUINARIA.Cantidadproducida, 0 )
					.Modelo = nvl( c_MAQUINARIA.Modelo, [] )
					.Descripcion = nvl( c_MAQUINARIA.Descripcion, [] )
					.Tipificación2_PK =  nvl( c_MAQUINARIA.Tipificación2, [] )
					.Desperdicio = nvl( c_MAQUINARIA.Desperdicio, 0 )
					.Serie = nvl( c_MAQUINARIA.Serie, [] )
					.Tipomaquinaria = nvl( c_MAQUINARIA.Tipomaquinaria, 0 )
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
		
		loDetalle = this.oEntidad.Consumos
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
		return c_MAQUINARIA.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.MAQUINARIA' )
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
								from ZooLogic.MAQUINARIA 
								Where   MAQUINARIA.CODIGO != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "MAQUINARIA", "", lcCursor, set("Datasession") )
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
			"Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Obs" as "Obs", "Marca" as "Marca", "Tipifica1" as "Tipificación1", "Codigo" as "Codigo", "Unidad" as "Unidaddetiempo", "Cantidadp" as "Cantidadproducida", "Modelo" as "Modelo", "Descrip" as "Descripcion", "Tipifica2" as "Tipificación2", "Desperd" as "Desperdicio", "Serie" as "Serie", "Tipo" as "Tipomaquinaria"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.MAQUINARIA 
								Where   MAQUINARIA.CODIGO != ''
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
	Tabla = 'MAQUINARIA'
	Filtro = " MAQUINARIA.CODIGO != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " MAQUINARIA.CODIGO != ''"
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
										<xsd:maxLength value="250"/>
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
	<row entidad="MAQUINARIA                              " atributo="FECHAMODIFICACIONFW                     " tabla="MAQUINARIA     " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                                                                                                                        " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MAQUINARIA                              " atributo="FECHAIMPO                               " tabla="MAQUINARIA     " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                                                                                                                         " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MAQUINARIA                              " atributo="FECHATRANSFERENCIA                      " tabla="MAQUINARIA     " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha transferencia                                                                                                                                                                                                                                       " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MAQUINARIA                              " atributo="FECHAALTAFW                             " tabla="MAQUINARIA     " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                                                                                                                " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MAQUINARIA                              " atributo="FECHAEXPO                               " tabla="MAQUINARIA     " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                                                                                                                         " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MAQUINARIA                              " atributo="HORAALTAFW                              " tabla="MAQUINARIA     " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                                                                                                                 " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MAQUINARIA                              " atributo="HORAEXPO                                " tabla="MAQUINARIA     " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                                                                                                          " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MAQUINARIA                              " atributo="HORAMODIFICACIONFW                      " tabla="MAQUINARIA     " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                                                                                                                         " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MAQUINARIA                              " atributo="VERSIONMODIFICACIONFW                   " tabla="MAQUINARIA     " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MAQUINARIA                              " atributo="ZADSFW                                  " tabla="MAQUINARIA     " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MAQUINARIA                              " atributo="VERSIONALTAFW                           " tabla="MAQUINARIA     " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MAQUINARIA                              " atributo="USUARIOALTAFW                           " tabla="MAQUINARIA     " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MAQUINARIA                              " atributo="USUARIOMODIFICACIONFW                   " tabla="MAQUINARIA     " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MAQUINARIA                              " atributo="SERIEALTAFW                             " tabla="MAQUINARIA     " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MAQUINARIA                              " atributo="SERIEMODIFICACIONFW                     " tabla="MAQUINARIA     " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                                                                                                                        " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MAQUINARIA                              " atributo="HORAIMPO                                " tabla="MAQUINARIA     " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                                                                                                          " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MAQUINARIA                              " atributo="ESTADOTRANSFERENCIA                     " tabla="MAQUINARIA     " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado transferencia                                                                                                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MAQUINARIA                              " atributo="BASEDEDATOSALTAFW                       " tabla="MAQUINARIA     " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                                                                                                                        " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MAQUINARIA                              " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="MAQUINARIA     " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MAQUINARIA                              " atributo="OBS                                     " tabla="MAQUINARIA     " campo="OBS       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="Observaciones                                                                                                                                                                                                                                             " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MAQUINARIA                              " atributo="CONSUMOS                                " tabla="MAQDETCONS     " campo="CODCONS   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="402" etiqueta="Consumos                                                                                                                                                                                                                                                  " dominio="DETALLEITEMMAQUINARIACONSUMO  " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="4" orden="0" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MAQUINARIA                              " atributo="MARCA                                   " tabla="MAQUINARIA     " campo="MARCA     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="8" etiqueta="Marca                                                                                                                                                                                                                                                     " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MAQUINARIA                              " atributo="TIPIFICACIÓN1                           " tabla="MAQUINARIA     " campo="TIPIFICA1 " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="TIPIFICACIONPRODUCCION1                 " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="14" etiqueta="Tipificación 1                                                                                                                                                                                                                                            " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MAQUINARIA                              " atributo="CODIGO                                  " tabla="MAQUINARIA     " campo="CODIGO    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="2" etiqueta="Código motivo de descarte                                                                                                                                                                                                                                 " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MAQUINARIA                              " atributo="UNIDADDETIEMPO                          " tabla="MAQUINARIA     " campo="UNIDAD    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="404" etiqueta="Unidad de tiempo                                                                                                                                                                                                                                          " dominio="COMBOSERVICIOPRODUCCION       " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="3" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MAQUINARIA                              " atributo="CANTIDADPRODUCIDA                       " tabla="MAQUINARIA     " campo="CANTIDADP " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="11" decimales="6" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="406" etiqueta="Cantidad producida                                                                                                                                                                                                                                        " dominio="NUMERICONONEGATIVO            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="3" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MAQUINARIA                              " atributo="MODELO                                  " tabla="MAQUINARIA     " campo="MODELO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="10" etiqueta="Modelo                                                                                                                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MAQUINARIA                              " atributo="DESCRIPCION                             " tabla="MAQUINARIA     " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="4" etiqueta="Descripción del imotivo de descarte                                                                                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MAQUINARIA                              " atributo="TIPIFICACIÓN2                           " tabla="MAQUINARIA     " campo="TIPIFICA2 " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="TIPIFICACIONPRODUCCION2                 " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="16" etiqueta="Tipificación 2                                                                                                                                                                                                                                            " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MAQUINARIA                              " atributo="DESPERDICIO                             " tabla="MAQUINARIA     " campo="DESPERD   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="11" decimales="6" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="408" etiqueta="Desperdicio                                                                                                                                                                                                                                               " dominio="NUMERICONONEGATIVO            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="3" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MAQUINARIA                              " atributo="SERIE                                   " tabla="MAQUINARIA     " campo="SERIE     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="12" etiqueta="N° de serie                                                                                                                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MAQUINARIA                              " atributo="TIPOMAQUINARIA                          " tabla="MAQUINARIA     " campo="TIPO      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="=1                                                                                                                                                                                                                                                            " obligatorio="false" admitebusqueda="6" etiqueta="Tipo                                                                                                                                                                                                                                                      " dominio="COMBOSERVICIOPRODUCCION       " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIPIFICACIONPRODUCCION1                 " atributo="DESCRIPCION                             " tabla="TIPOPROD1      " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="15" etiqueta="Detalle Tip.                                                                                                                                                                                                                                              " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join TIPOPROD1 On MAQUINARIA.TIPIFICA1 = TIPOPROD1.CodCons And  TIPOPROD1.CODCONS != ''                                                                                                                                                                 " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIPIFICACIONPRODUCCION2                 " atributo="DESCRIPCION                             " tabla="TIPOPROD2      " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="17" etiqueta="Detalle Tip.                                                                                                                                                                                                                                              " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join TIPOPROD2 On MAQUINARIA.TIPIFICA2 = TIPOPROD2.CodCons And  TIPOPROD2.CODCONS != ''                                                                                                                                                                 " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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