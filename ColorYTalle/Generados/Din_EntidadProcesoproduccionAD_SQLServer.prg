
define class Din_EntidadPROCESOPRODUCCIONAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_PROCESOPRODUCCION'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = []
	cExpresionCCPorCampos = []
	cTagClaveCandidata = ''
	cTagClavePk = '_PRPPK'
	cTablaPrincipal = 'PROCPRODUC'
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
			local  lxProcproducFecexpo, lxProcproducFectrans, lxProcproducFmodifw, lxProcproducFaltafw, lxProcproducFecimpo, lxProcproducSaltafw, lxProcproducHoraimpo, lxProcproducHmodifw, lxProcproducSmodifw, lxProcproducUmodifw, lxProcproducUaltafw, lxProcproducZadsfw, lxProcproducValtafw, lxProcproducVmodifw, lxProcproducHoraexpo, lxProcproducHaltafw, lxProcproducBdmodifw, lxProcproducBdaltafw, lxProcproducEsttrans, lxProcproducObs, lxProcproducCodigo, lxProcproducDescrip, lxProcproducRubro, lxProcproducClasif, lxProcproducCodartliqp, lxProcproducCodartliqd
				lxProcproducFecexpo =  .Fechaexpo			lxProcproducFectrans =  .Fechatransferencia			lxProcproducFmodifw =  .Fechamodificacionfw			lxProcproducFaltafw =  .Fechaaltafw			lxProcproducFecimpo =  .Fechaimpo			lxProcproducSaltafw =  .Seriealtafw			lxProcproducHoraimpo =  .Horaimpo			lxProcproducHmodifw =  .Horamodificacionfw			lxProcproducSmodifw =  .Seriemodificacionfw			lxProcproducUmodifw =  .Usuariomodificacionfw			lxProcproducUaltafw =  .Usuarioaltafw			lxProcproducZadsfw =  .Zadsfw			lxProcproducValtafw =  .Versionaltafw			lxProcproducVmodifw =  .Versionmodificacionfw			lxProcproducHoraexpo =  .Horaexpo			lxProcproducHaltafw =  .Horaaltafw			lxProcproducBdmodifw =  .Basededatosmodificacionfw			lxProcproducBdaltafw =  .Basededatosaltafw			lxProcproducEsttrans =  .Estadotransferencia			lxProcproducObs =  .Obs			lxProcproducCodigo =  .Codigo			lxProcproducDescrip =  .Descripcion			lxProcproducRubro =  upper( .Rubro_PK ) 			lxProcproducClasif =  upper( .Clasificacion_PK ) 			lxProcproducCodartliqp =  upper( .ArticuloLiquidacionProduccion_PK ) 			lxProcproducCodartliqd =  upper( .ArticuloLiquidacionDescarte_PK ) 
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxProcproducCodigo = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.PROCPRODUC ( "Fecexpo","Fectrans","Fmodifw","Faltafw","Fecimpo","Saltafw","Horaimpo","Hmodifw","Smodifw","Umodifw","Ualtafw","Zadsfw","Valtafw","Vmodifw","Horaexpo","Haltafw","Bdmodifw","Bdaltafw","Esttrans","Obs","Codigo","Descrip","Rubro","Clasif","Codartliqp","Codartliqd" ) values ( <<"'" + this.ConvertirDateSql( lxProcproducFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxProcproducFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxProcproducFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxProcproducFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxProcproducFecimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProcproducSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProcproducHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProcproducHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProcproducSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProcproducUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProcproducUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProcproducZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProcproducValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProcproducVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProcproducHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProcproducHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProcproducBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProcproducBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProcproducEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProcproducObs ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProcproducCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProcproducDescrip ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProcproducRubro ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProcproducClasif ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProcproducCodartliqp ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProcproducCodartliqd ) + "'" >> )
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
		this.ComprobarTransaccion()
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = lxValorClavePrimaria


			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ProcesoMaquina
				if this.oEntidad.ProcesoMaquina.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxMaquina_PK = loItem.Maquina_PK
					lxMaquinadescripcion = loItem.Maquinadescripcion
					lxTipomaquinaria = loItem.Tipomaquinaria
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.PROCPRMAQ("NROITEM","CodProcMaq","Maquina","Detalle","TipoMaquin" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxMaquina_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxMaquinadescripcion ) + "'">>, <<lxTipomaquinaria>> ) 
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
			local  lxProcproducFecexpo, lxProcproducFectrans, lxProcproducFmodifw, lxProcproducFaltafw, lxProcproducFecimpo, lxProcproducSaltafw, lxProcproducHoraimpo, lxProcproducHmodifw, lxProcproducSmodifw, lxProcproducUmodifw, lxProcproducUaltafw, lxProcproducZadsfw, lxProcproducValtafw, lxProcproducVmodifw, lxProcproducHoraexpo, lxProcproducHaltafw, lxProcproducBdmodifw, lxProcproducBdaltafw, lxProcproducEsttrans, lxProcproducObs, lxProcproducCodigo, lxProcproducDescrip, lxProcproducRubro, lxProcproducClasif, lxProcproducCodartliqp, lxProcproducCodartliqd
				lxProcproducFecexpo =  .Fechaexpo			lxProcproducFectrans =  .Fechatransferencia			lxProcproducFmodifw =  .Fechamodificacionfw			lxProcproducFaltafw =  .Fechaaltafw			lxProcproducFecimpo =  .Fechaimpo			lxProcproducSaltafw =  .Seriealtafw			lxProcproducHoraimpo =  .Horaimpo			lxProcproducHmodifw =  .Horamodificacionfw			lxProcproducSmodifw =  .Seriemodificacionfw			lxProcproducUmodifw =  .Usuariomodificacionfw			lxProcproducUaltafw =  .Usuarioaltafw			lxProcproducZadsfw =  .Zadsfw			lxProcproducValtafw =  .Versionaltafw			lxProcproducVmodifw =  .Versionmodificacionfw			lxProcproducHoraexpo =  .Horaexpo			lxProcproducHaltafw =  .Horaaltafw			lxProcproducBdmodifw =  .Basededatosmodificacionfw			lxProcproducBdaltafw =  .Basededatosaltafw			lxProcproducEsttrans =  .Estadotransferencia			lxProcproducObs =  .Obs			lxProcproducCodigo =  .Codigo			lxProcproducDescrip =  .Descripcion			lxProcproducRubro =  upper( .Rubro_PK ) 			lxProcproducClasif =  upper( .Clasificacion_PK ) 			lxProcproducCodartliqp =  upper( .ArticuloLiquidacionProduccion_PK ) 			lxProcproducCodartliqd =  upper( .ArticuloLiquidacionDescarte_PK ) 
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()
			lxValorClavePrimaria = .oEntidad.CODIGO
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ZooLogic.PROCPRODUC set "Fecexpo" = <<"'" + this.ConvertirDateSql( lxProcproducFecexpo ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxProcproducFectrans ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxProcproducFmodifw ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxProcproducFaltafw ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxProcproducFecimpo ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxProcproducSaltafw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxProcproducHoraimpo ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxProcproducHmodifw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxProcproducSmodifw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxProcproducUmodifw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxProcproducUaltafw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxProcproducZadsfw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxProcproducValtafw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxProcproducVmodifw ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxProcproducHoraexpo ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxProcproducHaltafw ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxProcproducBdmodifw ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxProcproducBdaltafw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxProcproducEsttrans ) + "'">>,"Obs" = <<"'" + this.FormatearTextoSql( lxProcproducObs ) + "'">>,"Codigo" = <<"'" + this.FormatearTextoSql( lxProcproducCodigo ) + "'">>,"Descrip" = <<"'" + this.FormatearTextoSql( lxProcproducDescrip ) + "'">>,"Rubro" = <<"'" + this.FormatearTextoSql( lxProcproducRubro ) + "'">>,"Clasif" = <<"'" + this.FormatearTextoSql( lxProcproducClasif ) + "'">>,"Codartliqp" = <<"'" + this.FormatearTextoSql( lxProcproducCodartliqp ) + "'">>,"Codartliqd" = <<"'" + this.FormatearTextoSql( lxProcproducCodartliqd ) + "'">> where "Codigo" = <<"'" + this.FormatearTextoSql( lxProcproducCodigo ) + "'">> and  PROCPRODUC.CODIGO != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			this.ComprobarResultadoDeEjecucionDelUpdate()
		this.ComprobarTransaccion()
			this.oConexion.EjecutarSql( 'delete from ZooLogic.PROCPRMAQ where "CodProcMaq" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ProcesoMaquina
				if this.oEntidad.ProcesoMaquina.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxMaquina_PK = loItem.Maquina_PK
					lxMaquinadescripcion = loItem.Maquinadescripcion
					lxTipomaquinaria = loItem.Tipomaquinaria
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.PROCPRMAQ("NROITEM","CodProcMaq","Maquina","Detalle","TipoMaquin" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxMaquina_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxMaquinadescripcion ) + "'">>, <<lxTipomaquinaria>> ) 
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 Codigo from ZooLogic.PROCPRODUC where " + this.ConvertirFuncionesSql( " PROCPRODUC.CODIGO != ''" ) )
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
			Local lxProcproducCodigo
			lxProcproducCodigo = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Obs" as "Obs", "Codigo" as "Codigo", "Descrip" as "Descripcion", "Rubro" as "Rubro", "Clasif" as "Clasificacion", "Codartliqp" as "Articuloliquidacionproduccion", "Codartliqd" as "Articuloliquidaciondescarte" from ZooLogic.PROCPRODUC where "Codigo" = <<"'" + this.FormatearTextoSql( lxProcproducCodigo ) + "'">> and  PROCPRODUC.CODIGO != ''
			endtext
			use in select('c_PROCESOPRODUCCION')
			this.oConexion.EjecutarSql( lcSentencia, 'c_PROCESOPRODUCCION', set( 'Datasession' ) )

			if reccount( 'c_PROCESOPRODUCCION' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codprocmaq" as "Codigo", "Maquina" as "Maquina", "Detalle" as "Maquinadescripcion", "Tipomaquin" as "Tipomaquinaria" from ZooLogic.PROCPRMAQ where CodProcMaq = <<"'" + this.FormatearTextoSql( c_PROCESOPRODUCCION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ProcesoMaquina')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ProcesoMaquina', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ProcesoMaquina
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxProcproducCodigo as Variant
		llRetorno = .t.
		lxProcproducCodigo = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.PROCPRODUC where "Codigo" = <<"'" + this.FormatearTextoSql( lxProcproducCodigo ) + "'">> and  PROCPRODUC.CODIGO != ''
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
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Obs" as "Obs", "Codigo" as "Codigo", "Descrip" as "Descripcion", "Rubro" as "Rubro", "Clasif" as "Clasificacion", "Codartliqp" as "Articuloliquidacionproduccion", "Codartliqd" as "Articuloliquidaciondescarte" from ZooLogic.PROCPRODUC where  PROCPRODUC.CODIGO != '' order by Codigo
			endtext
			use in select('c_PROCESOPRODUCCION')
			this.oConexion.EjecutarSql( lcSentencia, 'c_PROCESOPRODUCCION', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codprocmaq" as "Codigo", "Maquina" as "Maquina", "Detalle" as "Maquinadescripcion", "Tipomaquin" as "Tipomaquinaria" from ZooLogic.PROCPRMAQ where CodProcMaq = <<"'" + this.FormatearTextoSql( c_PROCESOPRODUCCION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ProcesoMaquina')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ProcesoMaquina', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ProcesoMaquina
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
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Obs" as "Obs", "Codigo" as "Codigo", "Descrip" as "Descripcion", "Rubro" as "Rubro", "Clasif" as "Clasificacion", "Codartliqp" as "Articuloliquidacionproduccion", "Codartliqd" as "Articuloliquidaciondescarte" from ZooLogic.PROCPRODUC where  funciones.padr( Codigo, 15, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  PROCPRODUC.CODIGO != '' order by Codigo
			endtext
			use in select('c_PROCESOPRODUCCION')
			this.oConexion.EjecutarSql( lcSentencia, 'c_PROCESOPRODUCCION', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codprocmaq" as "Codigo", "Maquina" as "Maquina", "Detalle" as "Maquinadescripcion", "Tipomaquin" as "Tipomaquinaria" from ZooLogic.PROCPRMAQ where CodProcMaq = <<"'" + this.FormatearTextoSql( c_PROCESOPRODUCCION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ProcesoMaquina')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ProcesoMaquina', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ProcesoMaquina
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
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Obs" as "Obs", "Codigo" as "Codigo", "Descrip" as "Descripcion", "Rubro" as "Rubro", "Clasif" as "Clasificacion", "Codartliqp" as "Articuloliquidacionproduccion", "Codartliqd" as "Articuloliquidaciondescarte" from ZooLogic.PROCPRODUC where  funciones.padr( Codigo, 15, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  PROCPRODUC.CODIGO != '' order by Codigo desc
			endtext
			use in select('c_PROCESOPRODUCCION')
			this.oConexion.EjecutarSql( lcSentencia, 'c_PROCESOPRODUCCION', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codprocmaq" as "Codigo", "Maquina" as "Maquina", "Detalle" as "Maquinadescripcion", "Tipomaquin" as "Tipomaquinaria" from ZooLogic.PROCPRMAQ where CodProcMaq = <<"'" + this.FormatearTextoSql( c_PROCESOPRODUCCION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ProcesoMaquina')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ProcesoMaquina', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ProcesoMaquina
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
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Obs" as "Obs", "Codigo" as "Codigo", "Descrip" as "Descripcion", "Rubro" as "Rubro", "Clasif" as "Clasificacion", "Codartliqp" as "Articuloliquidacionproduccion", "Codartliqd" as "Articuloliquidaciondescarte" from ZooLogic.PROCPRODUC where  PROCPRODUC.CODIGO != '' order by Codigo desc
			endtext
			use in select('c_PROCESOPRODUCCION')
			this.oConexion.EjecutarSql( lcSentencia, 'c_PROCESOPRODUCCION', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codprocmaq" as "Codigo", "Maquina" as "Maquina", "Detalle" as "Maquinadescripcion", "Tipomaquin" as "Tipomaquinaria" from ZooLogic.PROCPRMAQ where CodProcMaq = <<"'" + this.FormatearTextoSql( c_PROCESOPRODUCCION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ProcesoMaquina')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ProcesoMaquina', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ProcesoMaquina
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
			lcXml = this.oConexion.EjecutarSql( "select Fecexpo,Fectrans,Fmodifw,Faltafw,Fecimpo,Saltafw,Horaimpo,Hmodifw,Smodifw,Umodifw,Ualtafw,Za" + ;
"dsfw,Valtafw,Vmodifw,Horaexpo,Haltafw,Bdmodifw,Bdaltafw,Esttrans,Obs,Codigo,Descrip,Rubro,Clasif,Cod" + ;
"artliqp,Codartliqd" + ;
" from ZooLogic.PROCPRODUC where  PROCPRODUC.CODIGO != '' and " + lcFiltro )
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
			local  lxProcproducFecexpo, lxProcproducFectrans, lxProcproducFmodifw, lxProcproducFaltafw, lxProcproducFecimpo, lxProcproducSaltafw, lxProcproducHoraimpo, lxProcproducHmodifw, lxProcproducSmodifw, lxProcproducUmodifw, lxProcproducUaltafw, lxProcproducZadsfw, lxProcproducValtafw, lxProcproducVmodifw, lxProcproducHoraexpo, lxProcproducHaltafw, lxProcproducBdmodifw, lxProcproducBdaltafw, lxProcproducEsttrans, lxProcproducObs, lxProcproducCodigo, lxProcproducDescrip, lxProcproducRubro, lxProcproducClasif, lxProcproducCodartliqp, lxProcproducCodartliqd
				lxProcproducFecexpo = ctod( '  /  /    ' )			lxProcproducFectrans = ctod( '  /  /    ' )			lxProcproducFmodifw = ctod( '  /  /    ' )			lxProcproducFaltafw = ctod( '  /  /    ' )			lxProcproducFecimpo = ctod( '  /  /    ' )			lxProcproducSaltafw = []			lxProcproducHoraimpo = []			lxProcproducHmodifw = []			lxProcproducSmodifw = []			lxProcproducUmodifw = []			lxProcproducUaltafw = []			lxProcproducZadsfw = []			lxProcproducValtafw = []			lxProcproducVmodifw = []			lxProcproducHoraexpo = []			lxProcproducHaltafw = []			lxProcproducBdmodifw = []			lxProcproducBdaltafw = []			lxProcproducEsttrans = []			lxProcproducObs = []			lxProcproducCodigo = []			lxProcproducDescrip = []			lxProcproducRubro = []			lxProcproducClasif = []			lxProcproducCodartliqp = []			lxProcproducCodartliqd = []
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.PROCPRMAQ where "CodProcMaq" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( [delete from ZooLogic.PROCPRODUC where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'PROCPRODUC' + '_' + tcCampo
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
		lcWhere = " Where  PROCPRODUC.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Obs" as "Obs", "Codigo" as "Codigo", "Descrip" as "Descripcion", "Rubro" as "Rubro", "Clasif" as "Clasificacion", "Codartliqp" as "Articuloliquidacionproduccion", "Codartliqd" as "Articuloliquidaciondescarte"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'PROCPRODUC', '', tnTope )
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
	Function ObtenerDatosDetalleProcesoMaquina( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  PROCPRMAQ.CODPROCMAQ != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Nroitem" as "Nroitem", "Codprocmaq" as "Codigo", "Maquina" as "Maquina", "Detalle" as "Maquinadescripcion", "Tipomaquin" as "Tipomaquinaria"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleProcesoMaquina( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'PROCPRMAQ', 'ProcesoMaquina', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleProcesoMaquina( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleProcesoMaquina( lcAtributo )
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
				Case lcAtributo == 'OBS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'OBS AS OBS'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'DESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCRIP AS DESCRIPCION'
				Case lcAtributo == 'RUBRO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RUBRO AS RUBRO'
				Case lcAtributo == 'CLASIFICACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLASIF AS CLASIFICACION'
				Case lcAtributo == 'ARTICULOLIQUIDACIONPRODUCCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODARTLIQP AS ARTICULOLIQUIDACIONPRODUCCION'
				Case lcAtributo == 'ARTICULOLIQUIDACIONDESCARTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODARTLIQD AS ARTICULOLIQUIDACIONDESCARTE'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleProcesoMaquina( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODPROCMAQ AS CODIGO'
				Case lcAtributo == 'MAQUINA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MAQUINA AS MAQUINA'
				Case lcAtributo == 'MAQUINADESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DETALLE AS MAQUINADESCRIPCION'
				Case lcAtributo == 'TIPOMAQUINARIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPOMAQUIN AS TIPOMAQUINARIA'
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
			Case upper( alltrim( tcAtributo ) ) == 'OBS'
				lcCampo = 'OBS'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCION'
				lcCampo = 'DESCRIP'
			Case upper( alltrim( tcAtributo ) ) == 'RUBRO'
				lcCampo = 'RUBRO'
			Case upper( alltrim( tcAtributo ) ) == 'CLASIFICACION'
				lcCampo = 'CLASIF'
			Case upper( alltrim( tcAtributo ) ) == 'ARTICULOLIQUIDACIONPRODUCCION'
				lcCampo = 'CODARTLIQP'
			Case upper( alltrim( tcAtributo ) ) == 'ARTICULOLIQUIDACIONDESCARTE'
				lcCampo = 'CODARTLIQD'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleProcesoMaquina( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODPROCMAQ'
			Case upper( alltrim( tcAtributo ) ) == 'MAQUINA'
				lcCampo = 'MAQUINA'
			Case upper( alltrim( tcAtributo ) ) == 'MAQUINADESCRIPCION'
				lcCampo = 'DETALLE'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOMAQUINARIA'
				lcCampo = 'TIPOMAQUIN'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerTablaDetalle( tcDetalle as string ) as String
		local lcRetorno as string
		lcRetorno = ''
		if upper( alltrim( tcDetalle ) ) == 'PROCESOMAQUINA'
			lcRetorno = 'PROCPRMAQ'
		EndIf
		return lcRetorno
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasInsert() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcSentencia as string, loItem as object
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxProcproducFecexpo, lxProcproducFectrans, lxProcproducFmodifw, lxProcproducFaltafw, lxProcproducFecimpo, lxProcproducSaltafw, lxProcproducHoraimpo, lxProcproducHmodifw, lxProcproducSmodifw, lxProcproducUmodifw, lxProcproducUaltafw, lxProcproducZadsfw, lxProcproducValtafw, lxProcproducVmodifw, lxProcproducHoraexpo, lxProcproducHaltafw, lxProcproducBdmodifw, lxProcproducBdaltafw, lxProcproducEsttrans, lxProcproducObs, lxProcproducCodigo, lxProcproducDescrip, lxProcproducRubro, lxProcproducClasif, lxProcproducCodartliqp, lxProcproducCodartliqd
				lxProcproducFecexpo =  .Fechaexpo			lxProcproducFectrans =  .Fechatransferencia			lxProcproducFmodifw =  .Fechamodificacionfw			lxProcproducFaltafw =  .Fechaaltafw			lxProcproducFecimpo =  .Fechaimpo			lxProcproducSaltafw =  .Seriealtafw			lxProcproducHoraimpo =  .Horaimpo			lxProcproducHmodifw =  .Horamodificacionfw			lxProcproducSmodifw =  .Seriemodificacionfw			lxProcproducUmodifw =  .Usuariomodificacionfw			lxProcproducUaltafw =  .Usuarioaltafw			lxProcproducZadsfw =  .Zadsfw			lxProcproducValtafw =  .Versionaltafw			lxProcproducVmodifw =  .Versionmodificacionfw			lxProcproducHoraexpo =  .Horaexpo			lxProcproducHaltafw =  .Horaaltafw			lxProcproducBdmodifw =  .Basededatosmodificacionfw			lxProcproducBdaltafw =  .Basededatosaltafw			lxProcproducEsttrans =  .Estadotransferencia			lxProcproducObs =  .Obs			lxProcproducCodigo =  .Codigo			lxProcproducDescrip =  .Descripcion			lxProcproducRubro =  upper( .Rubro_PK ) 			lxProcproducClasif =  upper( .Clasificacion_PK ) 			lxProcproducCodartliqp =  upper( .ArticuloLiquidacionProduccion_PK ) 			lxProcproducCodartliqd =  upper( .ArticuloLiquidacionDescarte_PK ) 
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.PROCPRODUC ( "Fecexpo","Fectrans","Fmodifw","Faltafw","Fecimpo","Saltafw","Horaimpo","Hmodifw","Smodifw","Umodifw","Ualtafw","Zadsfw","Valtafw","Vmodifw","Horaexpo","Haltafw","Bdmodifw","Bdaltafw","Esttrans","Obs","Codigo","Descrip","Rubro","Clasif","Codartliqp","Codartliqd" ) values ( <<"'" + this.ConvertirDateSql( lxProcproducFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxProcproducFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxProcproducFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxProcproducFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxProcproducFecimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProcproducSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProcproducHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProcproducHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProcproducSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProcproducUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProcproducUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProcproducZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProcproducValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProcproducVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProcproducHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProcproducHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProcproducBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProcproducBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProcproducEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProcproducObs ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProcproducCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProcproducDescrip ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProcproducRubro ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProcproducClasif ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProcproducCodartliqp ) + "'" >>, <<"'" + this.FormatearTextoSql( lxProcproducCodartliqd ) + "'" >> )
		endtext
		loColeccion.cTabla = 'PROCPRODUC' 
		loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		With this
			local lcValorClavePrimariaString as String
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ProcesoMaquina
				if this.oEntidad.ProcesoMaquina.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxMaquina_PK = loItem.Maquina_PK
					lxMaquinadescripcion = loItem.Maquinadescripcion
					lxTipomaquinaria = loItem.Tipomaquinaria
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.PROCPRMAQ("NROITEM","CodProcMaq","Maquina","Detalle","TipoMaquin" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxMaquina_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxMaquinadescripcion ) + "'">>, <<lxTipomaquinaria>> ) 
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
			local  lxProcproducFecexpo, lxProcproducFectrans, lxProcproducFmodifw, lxProcproducFaltafw, lxProcproducFecimpo, lxProcproducSaltafw, lxProcproducHoraimpo, lxProcproducHmodifw, lxProcproducSmodifw, lxProcproducUmodifw, lxProcproducUaltafw, lxProcproducZadsfw, lxProcproducValtafw, lxProcproducVmodifw, lxProcproducHoraexpo, lxProcproducHaltafw, lxProcproducBdmodifw, lxProcproducBdaltafw, lxProcproducEsttrans, lxProcproducObs, lxProcproducCodigo, lxProcproducDescrip, lxProcproducRubro, lxProcproducClasif, lxProcproducCodartliqp, lxProcproducCodartliqd
				lxProcproducFecexpo =  .Fechaexpo			lxProcproducFectrans =  .Fechatransferencia			lxProcproducFmodifw =  .Fechamodificacionfw			lxProcproducFaltafw =  .Fechaaltafw			lxProcproducFecimpo =  .Fechaimpo			lxProcproducSaltafw =  .Seriealtafw			lxProcproducHoraimpo =  .Horaimpo			lxProcproducHmodifw =  .Horamodificacionfw			lxProcproducSmodifw =  .Seriemodificacionfw			lxProcproducUmodifw =  .Usuariomodificacionfw			lxProcproducUaltafw =  .Usuarioaltafw			lxProcproducZadsfw =  .Zadsfw			lxProcproducValtafw =  .Versionaltafw			lxProcproducVmodifw =  .Versionmodificacionfw			lxProcproducHoraexpo =  .Horaexpo			lxProcproducHaltafw =  .Horaaltafw			lxProcproducBdmodifw =  .Basededatosmodificacionfw			lxProcproducBdaltafw =  .Basededatosaltafw			lxProcproducEsttrans =  .Estadotransferencia			lxProcproducObs =  .Obs			lxProcproducCodigo =  .Codigo			lxProcproducDescrip =  .Descripcion			lxProcproducRubro =  upper( .Rubro_PK ) 			lxProcproducClasif =  upper( .Clasificacion_PK ) 			lxProcproducCodartliqp =  upper( .ArticuloLiquidacionProduccion_PK ) 			lxProcproducCodartliqd =  upper( .ArticuloLiquidacionDescarte_PK ) 
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  PROCPRODUC.CODIGO != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.PROCPRODUC set "Fecexpo" = <<"'" + this.ConvertirDateSql( lxProcproducFecexpo ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxProcproducFectrans ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxProcproducFmodifw ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxProcproducFaltafw ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxProcproducFecimpo ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxProcproducSaltafw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxProcproducHoraimpo ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxProcproducHmodifw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxProcproducSmodifw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxProcproducUmodifw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxProcproducUaltafw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxProcproducZadsfw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxProcproducValtafw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxProcproducVmodifw ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxProcproducHoraexpo ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxProcproducHaltafw ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxProcproducBdmodifw ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxProcproducBdaltafw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxProcproducEsttrans ) + "'">>, "Obs" = <<"'" + this.FormatearTextoSql( lxProcproducObs ) + "'">>, "Codigo" = <<"'" + this.FormatearTextoSql( lxProcproducCodigo ) + "'">>, "Descrip" = <<"'" + this.FormatearTextoSql( lxProcproducDescrip ) + "'">>, "Rubro" = <<"'" + this.FormatearTextoSql( lxProcproducRubro ) + "'">>, "Clasif" = <<"'" + this.FormatearTextoSql( lxProcproducClasif ) + "'">>, "Codartliqp" = <<"'" + this.FormatearTextoSql( lxProcproducCodartliqp ) + "'">>, "Codartliqd" = <<"'" + this.FormatearTextoSql( lxProcproducCodartliqd ) + "'">> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'PROCPRODUC' 
		loColeccion.agregar( strtran(  lcSentencia, chr( 9 ), '' ) )
			loColeccion.Agregar([delete from ZooLogic.PROCPRMAQ where "CodProcMaq" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ProcesoMaquina
				if this.oEntidad.ProcesoMaquina.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxMaquina_PK = loItem.Maquina_PK
					lxMaquinadescripcion = loItem.Maquinadescripcion
					lxTipomaquinaria = loItem.Tipomaquinaria
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.PROCPRMAQ("NROITEM","CodProcMaq","Maquina","Detalle","TipoMaquin" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxMaquina_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxMaquinadescripcion ) + "'">>, <<lxTipomaquinaria>> ) 
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

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  PROCPRODUC.CODIGO != '']
		loColeccion.Agregar( 'delete from ZooLogic.PROCPRODUC where ' + lcFiltro )
			loColeccion.Agregar([delete from ZooLogic.PROCPRMAQ where "CodProcMaq" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.cTabla = 'PROCPRODUC' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.PROCPRODUC where  PROCPRODUC.CODIGO != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.PROCPRODUC where Codigo = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  PROCPRODUC.CODIGO != ''" )
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
		lcCursor = This.oEntidad.cPrefijoRecibir + 'PROCESOPRODUCCION'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.PROCPRODUC Where Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'", 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					this.oConexion.EjecutarSql( [UPDATE ZooLogic.PROCPRODUC set  FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, Obs = ] + "'" + this.FormatearTextoSql( &lcCursor..Obs ) + "'"+ [, Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'"+ [, Descrip = ] + "'" + this.FormatearTextoSql( &lcCursor..Descrip ) + "'"+ [, Rubro = ] + "'" + this.FormatearTextoSql( &lcCursor..Rubro ) + "'"+ [, Clasif = ] + "'" + this.FormatearTextoSql( &lcCursor..Clasif ) + "'"+ [, CodArtLiqP = ] + "'" + this.FormatearTextoSql( &lcCursor..CodArtLiqP ) + "'"+ [, CodArtLiqD = ] + "'" + this.FormatearTextoSql( &lcCursor..CodArtLiqD ) + "'" + [ Where Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'" )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
				endIf
			else
				Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
				Text to lcCampos noShow
					 FECEXPO, FECTRANS, FMODIFW, FALTAFW, FECIMPO, SALTAFW, HORAIMPO, HMODIFW, SMODIFW, UMODIFW, UALTAFW, ZADSFW, VALTAFW, VMODIFW, HORAEXPO, HALTAFW, BDMODIFW, BDALTAFW, ESTTRANS, Obs, Codigo, Descrip, Rubro, Clasif, CodArtLiqP, CodArtLiqD
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Obs ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..Descrip ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Rubro ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Clasif ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CodArtLiqP ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CodArtLiqD ) + "'"
lcValoresCampos = substr(lcValoresCampos,2) 

				this.oConexion.EjecutarSql( [Insert into ZooLogic.PROCPRODUC ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
				this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'PROCESOPRODUCCION'
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
			this.oConexion.EjecutarSql( [Delete From ZooLogic.PROCPRMAQ Where CodProcMaq] + lcIn  )
			endfor
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'COMMIT TRANSACTION' )
			endif
		EndIf
	endif
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMPROCESOMAQUINA'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where CodProcMaq in ( select Codigo from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"NROITEM","CodProcMaq","Maquina","Detalle","TipoMaquin"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.PROCPRMAQ ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CodProcMaq ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Maquina    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Detalle    ) + "'" + ',' + transform( cDetallesExistentes.TipoMaquin ) + ' )'  )
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
			Case  lcAlias == lcPrefijo + 'PROCESOPRODUCCION'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'PROCESOPRODUCCION_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'PROCESOPRODUCCION_OBS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMPROCESOMAQUINA'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_PROCPRODUC')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'PROCESOPRODUCCION'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..Codigo
		llCondicion = isnull( lxVar )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad PROCESOPRODUCCION. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'PROCESOPRODUCCION'
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
			lcCursor = This.oEntidad.cPrefijoRecibir + 'PROCESOPRODUCCION'
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_PROCPRODUC') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_PROCPRODUC
Create Table ZooLogic.TablaTrabajo_PROCPRODUC ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fecexpo" datetime  null, 
"fectrans" datetime  null, 
"fmodifw" datetime  null, 
"faltafw" datetime  null, 
"fecimpo" datetime  null, 
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
"obs" varchar(max)  null, 
"codigo" char( 15 )  null, 
"descrip" char( 250 )  null, 
"rubro" char( 15 )  null, 
"clasif" char( 15 )  null, 
"codartliqp" char( 15 )  null, 
"codartliqd" char( 15 )  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_PROCPRODUC' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_PROCPRODUC' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'PROCESOPRODUCCION'
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
			.AgregarMapeo('obs','obs')
			.AgregarMapeo('codigo','codigo')
			.AgregarMapeo('descrip','descrip')
			.AgregarMapeo('rubro','rubro')
			.AgregarMapeo('clasif','clasif')
			.AgregarMapeo('codartliqp','codartliqp')
			.AgregarMapeo('codartliqd','codartliqd')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_PROCPRODUC'
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
				Update t Set t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.OBS = isnull( d.OBS, t.OBS ),t.CODIGO = isnull( d.CODIGO, t.CODIGO ),t.DESCRIP = isnull( d.DESCRIP, t.DESCRIP ),t.RUBRO = isnull( d.RUBRO, t.RUBRO ),t.CLASIF = isnull( d.CLASIF, t.CLASIF ),t.CODARTLIQP = isnull( d.CODARTLIQP, t.CODARTLIQP ),t.CODARTLIQD = isnull( d.CODARTLIQD, t.CODARTLIQD )
					from ZooLogic.PROCPRODUC t inner join deleted d 
							 on t.Codigo = d.Codigo
				-- Fin Updates
				insert into ZooLogic.PROCPRODUC(Fecexpo,Fectrans,Fmodifw,Faltafw,Fecimpo,Saltafw,Horaimpo,Hmodifw,Smodifw,Umodifw,Ualtafw,Zadsfw,Valtafw,Vmodifw,Horaexpo,Haltafw,Bdmodifw,Bdaltafw,Esttrans,Obs,Codigo,Descrip,Rubro,Clasif,Codartliqp,Codartliqd)
					Select isnull( d.FECEXPO,''),isnull( d.FECTRANS,''),isnull( d.FMODIFW,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FECIMPO,''),isnull( d.SALTAFW,''),isnull( d.HORAIMPO,''),isnull( d.HMODIFW,''),isnull( d.SMODIFW,''),isnull( d.UMODIFW,''),isnull( d.UALTAFW,''),isnull( d.ZADSFW,''),isnull( d.VALTAFW,''),isnull( d.VMODIFW,''),isnull( d.HORAEXPO,''),convert( char(8), getdate(), 108 ),isnull( d.BDMODIFW,''),isnull( d.BDALTAFW,''),isnull( d.ESTTRANS,''),isnull( d.OBS,''),isnull( d.CODIGO,''),isnull( d.DESCRIP,''),isnull( d.RUBRO,''),isnull( d.CLASIF,''),isnull( d.CODARTLIQP,''),isnull( d.CODARTLIQD,'')
						From deleted d left join ZooLogic.PROCPRODUC pk 
							 on d.Codigo = pk.Codigo
						Where pk.Codigo Is Null 
				-- Fin Inserts
			End
		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_PROCPRMAQ( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_PROCPRODUC_PROCPRMAQ
ON ZooLogic.TablaTrabajo_PROCPRODUC_PROCPRMAQ
AFTER DELETE
As
Begin
Update t Set 
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.CODPROCMAQ = isnull( d.CODPROCMAQ, t.CODPROCMAQ ),
t.MAQUINA = isnull( d.MAQUINA, t.MAQUINA ),
t.DETALLE = isnull( d.DETALLE, t.DETALLE ),
t.TIPOMAQUIN = isnull( d.TIPOMAQUIN, t.TIPOMAQUIN )
from ZooLogic.PROCPRMAQ t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.PROCPRMAQ
( 
"NROITEM",
"CODPROCMAQ",
"MAQUINA",
"DETALLE",
"TIPOMAQUIN"
 )
Select 
d.NROITEM,
d.CODPROCMAQ,
d.MAQUINA,
d.DETALLE,
d.TIPOMAQUIN
From deleted d left join ZooLogic.PROCPRMAQ pk 
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_PROCPRODUC') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_PROCPRODUC
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_PROCESOPRODUCCION' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_PROCESOPRODUCCION.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_PROCESOPRODUCCION.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_PROCESOPRODUCCION.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_PROCESOPRODUCCION.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_PROCESOPRODUCCION.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Seriealtafw = nvl( c_PROCESOPRODUCCION.Seriealtafw, [] )
					.Horaimpo = nvl( c_PROCESOPRODUCCION.Horaimpo, [] )
					.Horamodificacionfw = nvl( c_PROCESOPRODUCCION.Horamodificacionfw, [] )
					.Seriemodificacionfw = nvl( c_PROCESOPRODUCCION.Seriemodificacionfw, [] )
					.Usuariomodificacionfw = nvl( c_PROCESOPRODUCCION.Usuariomodificacionfw, [] )
					.Usuarioaltafw = nvl( c_PROCESOPRODUCCION.Usuarioaltafw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Versionaltafw = nvl( c_PROCESOPRODUCCION.Versionaltafw, [] )
					.Versionmodificacionfw = nvl( c_PROCESOPRODUCCION.Versionmodificacionfw, [] )
					.Horaexpo = nvl( c_PROCESOPRODUCCION.Horaexpo, [] )
					.Horaaltafw = nvl( c_PROCESOPRODUCCION.Horaaltafw, [] )
					.Basededatosmodificacionfw = nvl( c_PROCESOPRODUCCION.Basededatosmodificacionfw, [] )
					.Basededatosaltafw = nvl( c_PROCESOPRODUCCION.Basededatosaltafw, [] )
					.Estadotransferencia = nvl( c_PROCESOPRODUCCION.Estadotransferencia, [] )
					lcValor = This.ObtenerMemo( 'c_Obs')
					.Obs = lcValor 
					.Procesomaquina.Limpiar()
					.Procesomaquina.SetearEsNavegacion( .lProcesando )
					.Procesomaquina.Cargar()
					.Codigo = nvl( c_PROCESOPRODUCCION.Codigo, [] )
					.Descripcion = nvl( c_PROCESOPRODUCCION.Descripcion, [] )
					.Rubro_PK =  nvl( c_PROCESOPRODUCCION.Rubro, [] )
					.Clasificacion_PK =  nvl( c_PROCESOPRODUCCION.Clasificacion, [] )
					.Articuloliquidacionproduccion_PK =  nvl( c_PROCESOPRODUCCION.Articuloliquidacionproduccion, [] )
					.Articuloliquidaciondescarte_PK =  nvl( c_PROCESOPRODUCCION.Articuloliquidaciondescarte, [] )
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
		
		loDetalle = this.oEntidad.ProcesoMaquina
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
		return c_PROCESOPRODUCCION.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.PROCPRODUC' )
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
								from ZooLogic.PROCPRODUC 
								Where   PROCPRODUC.CODIGO != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "PROCPRODUC", "", lcCursor, set("Datasession") )
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
			"Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Obs" as "Obs", "Codigo" as "Codigo", "Descrip" as "Descripcion", "Rubro" as "Rubro", "Clasif" as "Clasificacion", "Codartliqp" as "Articuloliquidacionproduccion", "Codartliqd" as "Articuloliquidaciondescarte"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.PROCPRODUC 
								Where   PROCPRODUC.CODIGO != ''
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
	Tabla = 'PROCPRODUC'
	Filtro = " PROCPRODUC.CODIGO != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " PROCPRODUC.CODIGO != ''"
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
	<row entidad="PROCESOPRODUCCION                       " atributo="FECHAEXPO                               " tabla="PROCPRODUC     " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROCESOPRODUCCION                       " atributo="FECHATRANSFERENCIA                      " tabla="PROCPRODUC     " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha de novedad                                                                                                                                                " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROCESOPRODUCCION                       " atributo="FECHAMODIFICACIONFW                     " tabla="PROCPRODUC     " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROCESOPRODUCCION                       " atributo="FECHAALTAFW                             " tabla="PROCPRODUC     " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROCESOPRODUCCION                       " atributo="FECHAIMPO                               " tabla="PROCPRODUC     " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROCESOPRODUCCION                       " atributo="SERIEALTAFW                             " tabla="PROCPRODUC     " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROCESOPRODUCCION                       " atributo="HORAIMPO                                " tabla="PROCPRODUC     " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROCESOPRODUCCION                       " atributo="HORAMODIFICACIONFW                      " tabla="PROCPRODUC     " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROCESOPRODUCCION                       " atributo="SERIEMODIFICACIONFW                     " tabla="PROCPRODUC     " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROCESOPRODUCCION                       " atributo="USUARIOMODIFICACIONFW                   " tabla="PROCPRODUC     " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROCESOPRODUCCION                       " atributo="USUARIOALTAFW                           " tabla="PROCPRODUC     " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROCESOPRODUCCION                       " atributo="ZADSFW                                  " tabla="PROCPRODUC     " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROCESOPRODUCCION                       " atributo="VERSIONALTAFW                           " tabla="PROCPRODUC     " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROCESOPRODUCCION                       " atributo="VERSIONMODIFICACIONFW                   " tabla="PROCPRODUC     " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROCESOPRODUCCION                       " atributo="HORAEXPO                                " tabla="PROCPRODUC     " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROCESOPRODUCCION                       " atributo="HORAALTAFW                              " tabla="PROCPRODUC     " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROCESOPRODUCCION                       " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="PROCPRODUC     " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROCESOPRODUCCION                       " atributo="BASEDEDATOSALTAFW                       " tabla="PROCPRODUC     " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROCESOPRODUCCION                       " atributo="ESTADOTRANSFERENCIA                     " tabla="PROCPRODUC     " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado de novedad                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROCESOPRODUCCION                       " atributo="OBS                                     " tabla="PROCPRODUC     " campo="OBS       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="Observaciones                                                                                                                                                   " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROCESOPRODUCCION                       " atributo="PROCESOMAQUINA                          " tabla="PROCPRMAQ      " campo="CODPROCMAQ" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="402" etiqueta="Maquinaria                                                                                                                                                      " dominio="DETALLEITEMPROCESOMAQUINA     " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="0" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROCESOPRODUCCION                       " atributo="CODIGO                                  " tabla="PROCPRODUC     " campo="CODIGO    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="2" etiqueta="Código                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROCESOPRODUCCION                       " atributo="DESCRIPCION                             " tabla="PROCPRODUC     " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="250" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="4" etiqueta="Descripción                                                                                                                                                     " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROCESOPRODUCCION                       " atributo="RUBRO                                   " tabla="PROCPRODUC     " campo="RUBRO     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="RUBROPRODUCCION                         " tipodato="C         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="8" etiqueta="Rubro                                                                                                                                                           " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROCESOPRODUCCION                       " atributo="CLASIFICACION                           " tabla="PROCPRODUC     " campo="CLASIF    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CLASIFICACIONPRODUCCION                 " tipodato="C         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="10" etiqueta="Clasificación                                                                                                                                                   " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROCESOPRODUCCION                       " atributo="ARTICULOLIQUIDACIONPRODUCCION           " tabla="PROCPRODUC     " campo="CODARTLIQP" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="ARTICULO                                " tipodato="C         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="12" etiqueta="Artículo liquidación producción                                                                                                                                 " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROCESOPRODUCCION                       " atributo="ARTICULOLIQUIDACIONDESCARTE             " tabla="PROCPRODUC     " campo="CODARTLIQD" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="ARTICULO                                " tipodato="C         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="12" etiqueta="Artículo liquidación descarte                                                                                                                                   " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="RUBROPRODUCCION                         " atributo="DESCRIPCION                             " tabla="RUBROPROD      " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="9" etiqueta="Detalle Rub.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join RUBROPROD On PROCPRODUC.RUBRO = RUBROPROD.CodCons And  RUBROPROD.CODCONS != ''                                                                                                                                                                     " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLASIFICACIONPRODUCCION                 " atributo="DESCRIPCION                             " tabla="CLASPROD       " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="11" etiqueta="Detalle Cla.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CLASPROD On PROCPRODUC.CLASIF = CLASPROD.CodCons And  CLASPROD.CODCONS != ''                                                                                                                                                                       " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="DESCRIPCION                             " tabla="ART            " campo="ARTDES    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="13" etiqueta="Detalle Art.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join ART On PROCPRODUC.CODARTLIQP = ART.ARTCOD And  ART.ARTCOD != ''                                                                                                                                                                                    " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="DESCRIPCION                             " tabla="ART            " campo="ARTDES    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="13" etiqueta="Detalle Art.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join ART On PROCPRODUC.CODARTLIQD = ART.ARTCOD And  ART.ARTCOD != ''                                                                                                                                                                                    " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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