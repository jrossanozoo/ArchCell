
define class Din_EntidadMODELODEPRODUCCIONAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_MODELODEPRODUCCION'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = []
	cExpresionCCPorCampos = []
	cTagClaveCandidata = ''
	cTagClavePk = '_MDPPK'
	cTablaPrincipal = 'MODELOPROD'
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
			local  lxModeloprodFecimpo, lxModeloprodFectrans, lxModeloprodFmodifw, lxModeloprodFecexpo, lxModeloprodFaltafw, lxModeloprodSaltafw, lxModeloprodEsttrans, lxModeloprodHmodifw, lxModeloprodHoraimpo, lxModeloprodHoraexpo, lxModeloprodBdmodifw, lxModeloprodBdaltafw, lxModeloprodVmodifw, lxModeloprodZadsfw, lxModeloprodValtafw, lxModeloprodUmodifw, lxModeloprodSmodifw, lxModeloprodUaltafw, lxModeloprodHaltafw, lxModeloprodObs, lxModeloprodCodigo, lxModeloprodDescrip, lxModeloprodProducto, lxModeloprodFamilia, lxModeloprodMaterial, lxModeloprodGrupo, lxModeloprodCurvaprod
				lxModeloprodFecimpo =  .Fechaimpo			lxModeloprodFectrans =  .Fechatransferencia			lxModeloprodFmodifw =  .Fechamodificacionfw			lxModeloprodFecexpo =  .Fechaexpo			lxModeloprodFaltafw =  .Fechaaltafw			lxModeloprodSaltafw =  .Seriealtafw			lxModeloprodEsttrans =  .Estadotransferencia			lxModeloprodHmodifw =  .Horamodificacionfw			lxModeloprodHoraimpo =  .Horaimpo			lxModeloprodHoraexpo =  .Horaexpo			lxModeloprodBdmodifw =  .Basededatosmodificacionfw			lxModeloprodBdaltafw =  .Basededatosaltafw			lxModeloprodVmodifw =  .Versionmodificacionfw			lxModeloprodZadsfw =  .Zadsfw			lxModeloprodValtafw =  .Versionaltafw			lxModeloprodUmodifw =  .Usuariomodificacionfw			lxModeloprodSmodifw =  .Seriemodificacionfw			lxModeloprodUaltafw =  .Usuarioaltafw			lxModeloprodHaltafw =  .Horaaltafw			lxModeloprodObs =  .Obs			lxModeloprodCodigo =  .Codigo			lxModeloprodDescrip =  .Descripcion			lxModeloprodProducto =  upper( .ProductoFinal_PK ) 			lxModeloprodFamilia =  upper( .Familia_PK ) 			lxModeloprodMaterial =  upper( .Material_PK ) 			lxModeloprodGrupo =  upper( .Grupo_PK ) 			lxModeloprodCurvaprod =  upper( .CurvaDeProduccion_PK ) 
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxModeloprodCodigo = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.MODELOPROD ( "Fecimpo","Fectrans","Fmodifw","Fecexpo","Faltafw","Saltafw","Esttrans","Hmodifw","Horaimpo","Horaexpo","Bdmodifw","Bdaltafw","Vmodifw","Zadsfw","Valtafw","Umodifw","Smodifw","Ualtafw","Haltafw","Obs","Codigo","Descrip","Producto","Familia","Material","Grupo","Curvaprod" ) values ( <<"'" + this.ConvertirDateSql( lxModeloprodFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxModeloprodFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxModeloprodFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxModeloprodFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxModeloprodFaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModeloprodSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModeloprodEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModeloprodHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModeloprodHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModeloprodHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModeloprodBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModeloprodBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModeloprodVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModeloprodZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModeloprodValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModeloprodUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModeloprodSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModeloprodUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModeloprodHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModeloprodObs ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModeloprodCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModeloprodDescrip ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModeloprodProducto ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModeloprodFamilia ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModeloprodMaterial ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModeloprodGrupo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModeloprodCurvaprod ) + "'" >> )
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
		this.ComprobarTransaccion()
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = lxValorClavePrimaria


			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ModeloSalidas
				if this.oEntidad.ModeloSalidas.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxProceso_PK = loItem.Proceso_PK
					lxColorm_PK = loItem.Colorm_PK
					lxColormdetalle = loItem.Colormdetalle
					lxTallem_PK = loItem.Tallem_PK
					lxTallemdetalle = loItem.Tallemdetalle
					lxSemielaborado_PK = loItem.Semielaborado_PK
					lxSemielaboradodetalle = loItem.Semielaboradodetalle
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxTalle_PK = loItem.Talle_PK
					lxTalledetalle = loItem.Talledetalle
					lxCantidad = loItem.Cantidad
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.MODSAL("NROITEM","CodModSal","Proceso","cColor","cColDet","cTalle","cTalleDet","SemiElab","SemiDeta","iColor","IColDet","iTalle","ITalleDet","Cantidad" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxProceso_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColorm_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColormdetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTallem_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTallemdetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxSemielaborado_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxSemielaboradodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalledetalle ) + "'">>, <<lxCantidad>> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ModeloMaquinas
				if this.oEntidad.ModeloMaquinas.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxProceso_PK = loItem.Proceso_PK
					lxMaquina_PK = loItem.Maquina_PK
					lxMaquinadetalle = loItem.Maquinadetalle
					lxTipomaquinaria = loItem.Tipomaquinaria
					lxUnidaddetiempo = loItem.Unidaddetiempo
					lxTiempo = loItem.Tiempo
					lxDesperdicio = loItem.Desperdicio
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.MODMAQ("NROITEM","CodModMaq","Proceso","Maquina","MaqDeta","Tipo","Unidad","Tiempo","Desperdici" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxProceso_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxMaquina_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxMaquinadetalle ) + "'">>, <<lxTipomaquinaria>>, <<lxUnidaddetiempo>>, <<lxTiempo>>, <<lxDesperdicio>> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ModeloInsumos
				if this.oEntidad.ModeloInsumos.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxProceso_PK = loItem.Proceso_PK
					lxColorm_PK = loItem.Colorm_PK
					lxColormdetalle = loItem.Colormdetalle
					lxTallem_PK = loItem.Tallem_PK
					lxTallemdetalle = loItem.Tallemdetalle
					lxInsumo_PK = loItem.Insumo_PK
					lxInsumodetalle = loItem.Insumodetalle
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxTalle_PK = loItem.Talle_PK
					lxTalledetalle = loItem.Talledetalle
					lxUnidaddemedida_PK = loItem.Unidaddemedida_PK
					lxCantidad = loItem.Cantidad
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.MODINS("NROITEM","CodModIns","Proceso","cColor","cColDet","cTalle","cTalleDet","Insumo","InsDet","iColor","IColDet","iTalle","ITalleDet","UniMed","Cantidad" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxProceso_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColorm_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColormdetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTallem_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTallemdetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxInsumo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxInsumodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalledetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxUnidaddemedida_PK ) + "'">>, <<lxCantidad>> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ModeloProcesos
				if this.oEntidad.ModeloProcesos.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxProceso_PK = loItem.Proceso_PK
					lxProcesodetalle = loItem.Procesodetalle
					lxOrden = loItem.Orden
					lxTaller_PK = loItem.Taller_PK
					lxCantidaddesalida = loItem.Cantidaddesalida
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.MODPROC("NROITEM","CodModProc","Codigo","ProcDet","Orden","Taller","Cantidad" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxProceso_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxProcesodetalle ) + "'">>, <<lxOrden>>, <<"'" + this.FormatearTextoSql( lxTaller_PK ) + "'">>, <<lxCantidaddesalida>> ) 
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
			local  lxModeloprodFecimpo, lxModeloprodFectrans, lxModeloprodFmodifw, lxModeloprodFecexpo, lxModeloprodFaltafw, lxModeloprodSaltafw, lxModeloprodEsttrans, lxModeloprodHmodifw, lxModeloprodHoraimpo, lxModeloprodHoraexpo, lxModeloprodBdmodifw, lxModeloprodBdaltafw, lxModeloprodVmodifw, lxModeloprodZadsfw, lxModeloprodValtafw, lxModeloprodUmodifw, lxModeloprodSmodifw, lxModeloprodUaltafw, lxModeloprodHaltafw, lxModeloprodObs, lxModeloprodCodigo, lxModeloprodDescrip, lxModeloprodProducto, lxModeloprodFamilia, lxModeloprodMaterial, lxModeloprodGrupo, lxModeloprodCurvaprod
				lxModeloprodFecimpo =  .Fechaimpo			lxModeloprodFectrans =  .Fechatransferencia			lxModeloprodFmodifw =  .Fechamodificacionfw			lxModeloprodFecexpo =  .Fechaexpo			lxModeloprodFaltafw =  .Fechaaltafw			lxModeloprodSaltafw =  .Seriealtafw			lxModeloprodEsttrans =  .Estadotransferencia			lxModeloprodHmodifw =  .Horamodificacionfw			lxModeloprodHoraimpo =  .Horaimpo			lxModeloprodHoraexpo =  .Horaexpo			lxModeloprodBdmodifw =  .Basededatosmodificacionfw			lxModeloprodBdaltafw =  .Basededatosaltafw			lxModeloprodVmodifw =  .Versionmodificacionfw			lxModeloprodZadsfw =  .Zadsfw			lxModeloprodValtafw =  .Versionaltafw			lxModeloprodUmodifw =  .Usuariomodificacionfw			lxModeloprodSmodifw =  .Seriemodificacionfw			lxModeloprodUaltafw =  .Usuarioaltafw			lxModeloprodHaltafw =  .Horaaltafw			lxModeloprodObs =  .Obs			lxModeloprodCodigo =  .Codigo			lxModeloprodDescrip =  .Descripcion			lxModeloprodProducto =  upper( .ProductoFinal_PK ) 			lxModeloprodFamilia =  upper( .Familia_PK ) 			lxModeloprodMaterial =  upper( .Material_PK ) 			lxModeloprodGrupo =  upper( .Grupo_PK ) 			lxModeloprodCurvaprod =  upper( .CurvaDeProduccion_PK ) 
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()
			lxValorClavePrimaria = .oEntidad.CODIGO
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ZooLogic.MODELOPROD set "Fecimpo" = <<"'" + this.ConvertirDateSql( lxModeloprodFecimpo ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxModeloprodFectrans ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxModeloprodFmodifw ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxModeloprodFecexpo ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxModeloprodFaltafw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxModeloprodSaltafw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxModeloprodEsttrans ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxModeloprodHmodifw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxModeloprodHoraimpo ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxModeloprodHoraexpo ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxModeloprodBdmodifw ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxModeloprodBdaltafw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxModeloprodVmodifw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxModeloprodZadsfw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxModeloprodValtafw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxModeloprodUmodifw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxModeloprodSmodifw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxModeloprodUaltafw ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxModeloprodHaltafw ) + "'">>,"Obs" = <<"'" + this.FormatearTextoSql( lxModeloprodObs ) + "'">>,"Codigo" = <<"'" + this.FormatearTextoSql( lxModeloprodCodigo ) + "'">>,"Descrip" = <<"'" + this.FormatearTextoSql( lxModeloprodDescrip ) + "'">>,"Producto" = <<"'" + this.FormatearTextoSql( lxModeloprodProducto ) + "'">>,"Familia" = <<"'" + this.FormatearTextoSql( lxModeloprodFamilia ) + "'">>,"Material" = <<"'" + this.FormatearTextoSql( lxModeloprodMaterial ) + "'">>,"Grupo" = <<"'" + this.FormatearTextoSql( lxModeloprodGrupo ) + "'">>,"Curvaprod" = <<"'" + this.FormatearTextoSql( lxModeloprodCurvaprod ) + "'">> where "Codigo" = <<"'" + this.FormatearTextoSql( lxModeloprodCodigo ) + "'">> and  MODELOPROD.CODIGO != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			this.ComprobarResultadoDeEjecucionDelUpdate()
		this.ComprobarTransaccion()
			this.oConexion.EjecutarSql( 'delete from ZooLogic.MODSAL where "CodModSal" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.MODMAQ where "CodModMaq" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.MODINS where "CodModIns" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.MODPROC where "CodModProc" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ModeloSalidas
				if this.oEntidad.ModeloSalidas.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxProceso_PK = loItem.Proceso_PK
					lxColorm_PK = loItem.Colorm_PK
					lxColormdetalle = loItem.Colormdetalle
					lxTallem_PK = loItem.Tallem_PK
					lxTallemdetalle = loItem.Tallemdetalle
					lxSemielaborado_PK = loItem.Semielaborado_PK
					lxSemielaboradodetalle = loItem.Semielaboradodetalle
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxTalle_PK = loItem.Talle_PK
					lxTalledetalle = loItem.Talledetalle
					lxCantidad = loItem.Cantidad
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.MODSAL("NROITEM","CodModSal","Proceso","cColor","cColDet","cTalle","cTalleDet","SemiElab","SemiDeta","iColor","IColDet","iTalle","ITalleDet","Cantidad" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxProceso_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColorm_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColormdetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTallem_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTallemdetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxSemielaborado_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxSemielaboradodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalledetalle ) + "'">>, <<lxCantidad>> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ModeloMaquinas
				if this.oEntidad.ModeloMaquinas.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxProceso_PK = loItem.Proceso_PK
					lxMaquina_PK = loItem.Maquina_PK
					lxMaquinadetalle = loItem.Maquinadetalle
					lxTipomaquinaria = loItem.Tipomaquinaria
					lxUnidaddetiempo = loItem.Unidaddetiempo
					lxTiempo = loItem.Tiempo
					lxDesperdicio = loItem.Desperdicio
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.MODMAQ("NROITEM","CodModMaq","Proceso","Maquina","MaqDeta","Tipo","Unidad","Tiempo","Desperdici" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxProceso_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxMaquina_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxMaquinadetalle ) + "'">>, <<lxTipomaquinaria>>, <<lxUnidaddetiempo>>, <<lxTiempo>>, <<lxDesperdicio>> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ModeloInsumos
				if this.oEntidad.ModeloInsumos.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxProceso_PK = loItem.Proceso_PK
					lxColorm_PK = loItem.Colorm_PK
					lxColormdetalle = loItem.Colormdetalle
					lxTallem_PK = loItem.Tallem_PK
					lxTallemdetalle = loItem.Tallemdetalle
					lxInsumo_PK = loItem.Insumo_PK
					lxInsumodetalle = loItem.Insumodetalle
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxTalle_PK = loItem.Talle_PK
					lxTalledetalle = loItem.Talledetalle
					lxUnidaddemedida_PK = loItem.Unidaddemedida_PK
					lxCantidad = loItem.Cantidad
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.MODINS("NROITEM","CodModIns","Proceso","cColor","cColDet","cTalle","cTalleDet","Insumo","InsDet","iColor","IColDet","iTalle","ITalleDet","UniMed","Cantidad" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxProceso_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColorm_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColormdetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTallem_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTallemdetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxInsumo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxInsumodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalledetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxUnidaddemedida_PK ) + "'">>, <<lxCantidad>> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ModeloProcesos
				if this.oEntidad.ModeloProcesos.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxProceso_PK = loItem.Proceso_PK
					lxProcesodetalle = loItem.Procesodetalle
					lxOrden = loItem.Orden
					lxTaller_PK = loItem.Taller_PK
					lxCantidaddesalida = loItem.Cantidaddesalida
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.MODPROC("NROITEM","CodModProc","Codigo","ProcDet","Orden","Taller","Cantidad" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxProceso_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxProcesodetalle ) + "'">>, <<lxOrden>>, <<"'" + this.FormatearTextoSql( lxTaller_PK ) + "'">>, <<lxCantidaddesalida>> ) 
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 Codigo from ZooLogic.MODELOPROD where " + this.ConvertirFuncionesSql( " MODELOPROD.CODIGO != ''" ) )
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
			Local lxModeloprodCodigo
			lxModeloprodCodigo = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Saltafw" as "Seriealtafw", "Esttrans" as "Estadotransferencia", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Haltafw" as "Horaaltafw", "Obs" as "Obs", "Codigo" as "Codigo", "Descrip" as "Descripcion", "Producto" as "Productofinal", "Familia" as "Familia", "Material" as "Material", "Grupo" as "Grupo", "Curvaprod" as "Curvadeproduccion" from ZooLogic.MODELOPROD where "Codigo" = <<"'" + this.FormatearTextoSql( lxModeloprodCodigo ) + "'">> and  MODELOPROD.CODIGO != ''
			endtext
			use in select('c_MODELODEPRODUCCION')
			this.oConexion.EjecutarSql( lcSentencia, 'c_MODELODEPRODUCCION', set( 'Datasession' ) )

			if reccount( 'c_MODELODEPRODUCCION' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codmodsal" as "Codigo", "Proceso" as "Proceso", "Ccolor" as "Colorm", "Ccoldet" as "Colormdetalle", "Ctalle" as "Tallem", "Ctalledet" as "Tallemdetalle", "Semielab" as "Semielaborado", "Semideta" as "Semielaboradodetalle", "Icolor" as "Color", "Icoldet" as "Colordetalle", "Italle" as "Talle", "Italledet" as "Talledetalle", "Cantidad" as "Cantidad" from ZooLogic.MODSAL where CodModSal = <<"'" + this.FormatearTextoSql( c_MODELODEPRODUCCION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ModeloSalidas')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ModeloSalidas', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ModeloSalidas
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codmodmaq" as "Codigo", "Proceso" as "Proceso", "Maquina" as "Maquina", "Maqdeta" as "Maquinadetalle", "Tipo" as "Tipomaquinaria", "Unidad" as "Unidaddetiempo", "Tiempo" as "Tiempo", "Desperdici" as "Desperdicio" from ZooLogic.MODMAQ where CodModMaq = <<"'" + this.FormatearTextoSql( c_MODELODEPRODUCCION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ModeloMaquinas')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ModeloMaquinas', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ModeloMaquinas
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codmodins" as "Codigo", "Proceso" as "Proceso", "Ccolor" as "Colorm", "Ccoldet" as "Colormdetalle", "Ctalle" as "Tallem", "Ctalledet" as "Tallemdetalle", "Insumo" as "Insumo", "Insdet" as "Insumodetalle", "Icolor" as "Color", "Icoldet" as "Colordetalle", "Italle" as "Talle", "Italledet" as "Talledetalle", "Unimed" as "Unidaddemedida", "Cantidad" as "Cantidad" from ZooLogic.MODINS where CodModIns = <<"'" + this.FormatearTextoSql( c_MODELODEPRODUCCION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ModeloInsumos')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ModeloInsumos', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ModeloInsumos
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codmodproc" as "Codigo", "Codigo" as "Proceso", "Procdet" as "Procesodetalle", "Orden" as "Orden", "Taller" as "Taller", "Cantidad" as "Cantidaddesalida" from ZooLogic.MODPROC where CodModProc = <<"'" + this.FormatearTextoSql( c_MODELODEPRODUCCION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ModeloProcesos')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ModeloProcesos', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ModeloProcesos
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxModeloprodCodigo as Variant
		llRetorno = .t.
		lxModeloprodCodigo = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.MODELOPROD where "Codigo" = <<"'" + this.FormatearTextoSql( lxModeloprodCodigo ) + "'">> and  MODELOPROD.CODIGO != ''
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
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Saltafw" as "Seriealtafw", "Esttrans" as "Estadotransferencia", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Haltafw" as "Horaaltafw", "Obs" as "Obs", "Codigo" as "Codigo", "Descrip" as "Descripcion", "Producto" as "Productofinal", "Familia" as "Familia", "Material" as "Material", "Grupo" as "Grupo", "Curvaprod" as "Curvadeproduccion" from ZooLogic.MODELOPROD where  MODELOPROD.CODIGO != '' order by Codigo
			endtext
			use in select('c_MODELODEPRODUCCION')
			this.oConexion.EjecutarSql( lcSentencia, 'c_MODELODEPRODUCCION', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codmodsal" as "Codigo", "Proceso" as "Proceso", "Ccolor" as "Colorm", "Ccoldet" as "Colormdetalle", "Ctalle" as "Tallem", "Ctalledet" as "Tallemdetalle", "Semielab" as "Semielaborado", "Semideta" as "Semielaboradodetalle", "Icolor" as "Color", "Icoldet" as "Colordetalle", "Italle" as "Talle", "Italledet" as "Talledetalle", "Cantidad" as "Cantidad" from ZooLogic.MODSAL where CodModSal = <<"'" + this.FormatearTextoSql( c_MODELODEPRODUCCION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ModeloSalidas')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ModeloSalidas', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ModeloSalidas
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codmodmaq" as "Codigo", "Proceso" as "Proceso", "Maquina" as "Maquina", "Maqdeta" as "Maquinadetalle", "Tipo" as "Tipomaquinaria", "Unidad" as "Unidaddetiempo", "Tiempo" as "Tiempo", "Desperdici" as "Desperdicio" from ZooLogic.MODMAQ where CodModMaq = <<"'" + this.FormatearTextoSql( c_MODELODEPRODUCCION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ModeloMaquinas')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ModeloMaquinas', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ModeloMaquinas
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codmodins" as "Codigo", "Proceso" as "Proceso", "Ccolor" as "Colorm", "Ccoldet" as "Colormdetalle", "Ctalle" as "Tallem", "Ctalledet" as "Tallemdetalle", "Insumo" as "Insumo", "Insdet" as "Insumodetalle", "Icolor" as "Color", "Icoldet" as "Colordetalle", "Italle" as "Talle", "Italledet" as "Talledetalle", "Unimed" as "Unidaddemedida", "Cantidad" as "Cantidad" from ZooLogic.MODINS where CodModIns = <<"'" + this.FormatearTextoSql( c_MODELODEPRODUCCION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ModeloInsumos')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ModeloInsumos', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ModeloInsumos
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codmodproc" as "Codigo", "Codigo" as "Proceso", "Procdet" as "Procesodetalle", "Orden" as "Orden", "Taller" as "Taller", "Cantidad" as "Cantidaddesalida" from ZooLogic.MODPROC where CodModProc = <<"'" + this.FormatearTextoSql( c_MODELODEPRODUCCION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ModeloProcesos')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ModeloProcesos', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ModeloProcesos
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
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Saltafw" as "Seriealtafw", "Esttrans" as "Estadotransferencia", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Haltafw" as "Horaaltafw", "Obs" as "Obs", "Codigo" as "Codigo", "Descrip" as "Descripcion", "Producto" as "Productofinal", "Familia" as "Familia", "Material" as "Material", "Grupo" as "Grupo", "Curvaprod" as "Curvadeproduccion" from ZooLogic.MODELOPROD where  funciones.padr( Codigo, 15, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  MODELOPROD.CODIGO != '' order by Codigo
			endtext
			use in select('c_MODELODEPRODUCCION')
			this.oConexion.EjecutarSql( lcSentencia, 'c_MODELODEPRODUCCION', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codmodsal" as "Codigo", "Proceso" as "Proceso", "Ccolor" as "Colorm", "Ccoldet" as "Colormdetalle", "Ctalle" as "Tallem", "Ctalledet" as "Tallemdetalle", "Semielab" as "Semielaborado", "Semideta" as "Semielaboradodetalle", "Icolor" as "Color", "Icoldet" as "Colordetalle", "Italle" as "Talle", "Italledet" as "Talledetalle", "Cantidad" as "Cantidad" from ZooLogic.MODSAL where CodModSal = <<"'" + this.FormatearTextoSql( c_MODELODEPRODUCCION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ModeloSalidas')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ModeloSalidas', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ModeloSalidas
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codmodmaq" as "Codigo", "Proceso" as "Proceso", "Maquina" as "Maquina", "Maqdeta" as "Maquinadetalle", "Tipo" as "Tipomaquinaria", "Unidad" as "Unidaddetiempo", "Tiempo" as "Tiempo", "Desperdici" as "Desperdicio" from ZooLogic.MODMAQ where CodModMaq = <<"'" + this.FormatearTextoSql( c_MODELODEPRODUCCION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ModeloMaquinas')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ModeloMaquinas', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ModeloMaquinas
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codmodins" as "Codigo", "Proceso" as "Proceso", "Ccolor" as "Colorm", "Ccoldet" as "Colormdetalle", "Ctalle" as "Tallem", "Ctalledet" as "Tallemdetalle", "Insumo" as "Insumo", "Insdet" as "Insumodetalle", "Icolor" as "Color", "Icoldet" as "Colordetalle", "Italle" as "Talle", "Italledet" as "Talledetalle", "Unimed" as "Unidaddemedida", "Cantidad" as "Cantidad" from ZooLogic.MODINS where CodModIns = <<"'" + this.FormatearTextoSql( c_MODELODEPRODUCCION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ModeloInsumos')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ModeloInsumos', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ModeloInsumos
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codmodproc" as "Codigo", "Codigo" as "Proceso", "Procdet" as "Procesodetalle", "Orden" as "Orden", "Taller" as "Taller", "Cantidad" as "Cantidaddesalida" from ZooLogic.MODPROC where CodModProc = <<"'" + this.FormatearTextoSql( c_MODELODEPRODUCCION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ModeloProcesos')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ModeloProcesos', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ModeloProcesos
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
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Saltafw" as "Seriealtafw", "Esttrans" as "Estadotransferencia", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Haltafw" as "Horaaltafw", "Obs" as "Obs", "Codigo" as "Codigo", "Descrip" as "Descripcion", "Producto" as "Productofinal", "Familia" as "Familia", "Material" as "Material", "Grupo" as "Grupo", "Curvaprod" as "Curvadeproduccion" from ZooLogic.MODELOPROD where  funciones.padr( Codigo, 15, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  MODELOPROD.CODIGO != '' order by Codigo desc
			endtext
			use in select('c_MODELODEPRODUCCION')
			this.oConexion.EjecutarSql( lcSentencia, 'c_MODELODEPRODUCCION', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codmodsal" as "Codigo", "Proceso" as "Proceso", "Ccolor" as "Colorm", "Ccoldet" as "Colormdetalle", "Ctalle" as "Tallem", "Ctalledet" as "Tallemdetalle", "Semielab" as "Semielaborado", "Semideta" as "Semielaboradodetalle", "Icolor" as "Color", "Icoldet" as "Colordetalle", "Italle" as "Talle", "Italledet" as "Talledetalle", "Cantidad" as "Cantidad" from ZooLogic.MODSAL where CodModSal = <<"'" + this.FormatearTextoSql( c_MODELODEPRODUCCION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ModeloSalidas')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ModeloSalidas', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ModeloSalidas
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codmodmaq" as "Codigo", "Proceso" as "Proceso", "Maquina" as "Maquina", "Maqdeta" as "Maquinadetalle", "Tipo" as "Tipomaquinaria", "Unidad" as "Unidaddetiempo", "Tiempo" as "Tiempo", "Desperdici" as "Desperdicio" from ZooLogic.MODMAQ where CodModMaq = <<"'" + this.FormatearTextoSql( c_MODELODEPRODUCCION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ModeloMaquinas')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ModeloMaquinas', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ModeloMaquinas
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codmodins" as "Codigo", "Proceso" as "Proceso", "Ccolor" as "Colorm", "Ccoldet" as "Colormdetalle", "Ctalle" as "Tallem", "Ctalledet" as "Tallemdetalle", "Insumo" as "Insumo", "Insdet" as "Insumodetalle", "Icolor" as "Color", "Icoldet" as "Colordetalle", "Italle" as "Talle", "Italledet" as "Talledetalle", "Unimed" as "Unidaddemedida", "Cantidad" as "Cantidad" from ZooLogic.MODINS where CodModIns = <<"'" + this.FormatearTextoSql( c_MODELODEPRODUCCION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ModeloInsumos')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ModeloInsumos', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ModeloInsumos
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codmodproc" as "Codigo", "Codigo" as "Proceso", "Procdet" as "Procesodetalle", "Orden" as "Orden", "Taller" as "Taller", "Cantidad" as "Cantidaddesalida" from ZooLogic.MODPROC where CodModProc = <<"'" + this.FormatearTextoSql( c_MODELODEPRODUCCION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ModeloProcesos')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ModeloProcesos', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ModeloProcesos
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
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Saltafw" as "Seriealtafw", "Esttrans" as "Estadotransferencia", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Haltafw" as "Horaaltafw", "Obs" as "Obs", "Codigo" as "Codigo", "Descrip" as "Descripcion", "Producto" as "Productofinal", "Familia" as "Familia", "Material" as "Material", "Grupo" as "Grupo", "Curvaprod" as "Curvadeproduccion" from ZooLogic.MODELOPROD where  MODELOPROD.CODIGO != '' order by Codigo desc
			endtext
			use in select('c_MODELODEPRODUCCION')
			this.oConexion.EjecutarSql( lcSentencia, 'c_MODELODEPRODUCCION', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codmodsal" as "Codigo", "Proceso" as "Proceso", "Ccolor" as "Colorm", "Ccoldet" as "Colormdetalle", "Ctalle" as "Tallem", "Ctalledet" as "Tallemdetalle", "Semielab" as "Semielaborado", "Semideta" as "Semielaboradodetalle", "Icolor" as "Color", "Icoldet" as "Colordetalle", "Italle" as "Talle", "Italledet" as "Talledetalle", "Cantidad" as "Cantidad" from ZooLogic.MODSAL where CodModSal = <<"'" + this.FormatearTextoSql( c_MODELODEPRODUCCION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ModeloSalidas')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ModeloSalidas', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ModeloSalidas
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codmodmaq" as "Codigo", "Proceso" as "Proceso", "Maquina" as "Maquina", "Maqdeta" as "Maquinadetalle", "Tipo" as "Tipomaquinaria", "Unidad" as "Unidaddetiempo", "Tiempo" as "Tiempo", "Desperdici" as "Desperdicio" from ZooLogic.MODMAQ where CodModMaq = <<"'" + this.FormatearTextoSql( c_MODELODEPRODUCCION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ModeloMaquinas')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ModeloMaquinas', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ModeloMaquinas
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codmodins" as "Codigo", "Proceso" as "Proceso", "Ccolor" as "Colorm", "Ccoldet" as "Colormdetalle", "Ctalle" as "Tallem", "Ctalledet" as "Tallemdetalle", "Insumo" as "Insumo", "Insdet" as "Insumodetalle", "Icolor" as "Color", "Icoldet" as "Colordetalle", "Italle" as "Talle", "Italledet" as "Talledetalle", "Unimed" as "Unidaddemedida", "Cantidad" as "Cantidad" from ZooLogic.MODINS where CodModIns = <<"'" + this.FormatearTextoSql( c_MODELODEPRODUCCION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ModeloInsumos')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ModeloInsumos', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ModeloInsumos
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codmodproc" as "Codigo", "Codigo" as "Proceso", "Procdet" as "Procesodetalle", "Orden" as "Orden", "Taller" as "Taller", "Cantidad" as "Cantidaddesalida" from ZooLogic.MODPROC where CodModProc = <<"'" + this.FormatearTextoSql( c_MODELODEPRODUCCION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ModeloProcesos')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ModeloProcesos', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ModeloProcesos
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
			lcXml = this.oConexion.EjecutarSql( "select Fecimpo,Fectrans,Fmodifw,Fecexpo,Faltafw,Saltafw,Esttrans,Hmodifw,Horaimpo,Horaexpo,Bdmodifw" + ;
",Bdaltafw,Vmodifw,Zadsfw,Valtafw,Umodifw,Smodifw,Ualtafw,Haltafw,Obs,Codigo,Descrip,Producto,Familia" + ;
",Material,Grupo,Curvaprod" + ;
" from ZooLogic.MODELOPROD where  MODELOPROD.CODIGO != '' and " + lcFiltro )
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
			local  lxModeloprodFecimpo, lxModeloprodFectrans, lxModeloprodFmodifw, lxModeloprodFecexpo, lxModeloprodFaltafw, lxModeloprodSaltafw, lxModeloprodEsttrans, lxModeloprodHmodifw, lxModeloprodHoraimpo, lxModeloprodHoraexpo, lxModeloprodBdmodifw, lxModeloprodBdaltafw, lxModeloprodVmodifw, lxModeloprodZadsfw, lxModeloprodValtafw, lxModeloprodUmodifw, lxModeloprodSmodifw, lxModeloprodUaltafw, lxModeloprodHaltafw, lxModeloprodObs, lxModeloprodCodigo, lxModeloprodDescrip, lxModeloprodProducto, lxModeloprodFamilia, lxModeloprodMaterial, lxModeloprodGrupo, lxModeloprodCurvaprod
				lxModeloprodFecimpo = ctod( '  /  /    ' )			lxModeloprodFectrans = ctod( '  /  /    ' )			lxModeloprodFmodifw = ctod( '  /  /    ' )			lxModeloprodFecexpo = ctod( '  /  /    ' )			lxModeloprodFaltafw = ctod( '  /  /    ' )			lxModeloprodSaltafw = []			lxModeloprodEsttrans = []			lxModeloprodHmodifw = []			lxModeloprodHoraimpo = []			lxModeloprodHoraexpo = []			lxModeloprodBdmodifw = []			lxModeloprodBdaltafw = []			lxModeloprodVmodifw = []			lxModeloprodZadsfw = []			lxModeloprodValtafw = []			lxModeloprodUmodifw = []			lxModeloprodSmodifw = []			lxModeloprodUaltafw = []			lxModeloprodHaltafw = []			lxModeloprodObs = []			lxModeloprodCodigo = []			lxModeloprodDescrip = []			lxModeloprodProducto = []			lxModeloprodFamilia = []			lxModeloprodMaterial = []			lxModeloprodGrupo = []			lxModeloprodCurvaprod = []
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.MODSAL where "CodModSal" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.MODMAQ where "CodModMaq" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.MODINS where "CodModIns" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.MODPROC where "CodModProc" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( [delete from ZooLogic.MODELOPROD where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'MODELOPROD' + '_' + tcCampo
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
		lcWhere = " Where  MODELOPROD.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Saltafw" as "Seriealtafw", "Esttrans" as "Estadotransferencia", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Haltafw" as "Horaaltafw", "Obs" as "Obs", "Codigo" as "Codigo", "Descrip" as "Descripcion", "Producto" as "Productofinal", "Familia" as "Familia", "Material" as "Material", "Grupo" as "Grupo", "Curvaprod" as "Curvadeproduccion"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'MODELOPROD', '', tnTope )
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
	Function ObtenerDatosDetalleModeloSalidas( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  MODSAL.CODMODSAL != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Nroitem" as "Nroitem", "Codmodsal" as "Codigo", "Proceso" as "Proceso", "Ccolor" as "Colorm", "Ccoldet" as "Colormdetalle", "Ctalle" as "Tallem", "Ctalledet" as "Tallemdetalle", "Semielab" as "Semielaborado", "Semideta" as "Semielaboradodetalle", "Icolor" as "Color", "Icoldet" as "Colordetalle", "Italle" as "Talle", "Italledet" as "Talledetalle", "Cantidad" as "Cantidad"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleModeloSalidas( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'MODSAL', 'ModeloSalidas', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleModeloSalidas( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleModeloSalidas( lcAtributo )
		endfor
		lcSelect = substr( lcSelect, 2 )
		return lcSelect
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosDetalleModeloMaquinas( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  MODMAQ.CODMODMAQ != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Nroitem" as "Nroitem", "Codmodmaq" as "Codigo", "Proceso" as "Proceso", "Maquina" as "Maquina", "Maqdeta" as "Maquinadetalle", "Tipo" as "Tipomaquinaria", "Unidad" as "Unidaddetiempo", "Tiempo" as "Tiempo", "Desperdici" as "Desperdicio"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleModeloMaquinas( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'MODMAQ', 'ModeloMaquinas', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleModeloMaquinas( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleModeloMaquinas( lcAtributo )
		endfor
		lcSelect = substr( lcSelect, 2 )
		return lcSelect
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosDetalleModeloInsumos( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  MODINS.CODMODINS != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Nroitem" as "Nroitem", "Codmodins" as "Codigo", "Proceso" as "Proceso", "Ccolor" as "Colorm", "Ccoldet" as "Colormdetalle", "Ctalle" as "Tallem", "Ctalledet" as "Tallemdetalle", "Insumo" as "Insumo", "Insdet" as "Insumodetalle", "Icolor" as "Color", "Icoldet" as "Colordetalle", "Italle" as "Talle", "Italledet" as "Talledetalle", "Unimed" as "Unidaddemedida", "Cantidad" as "Cantidad"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleModeloInsumos( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'MODINS', 'ModeloInsumos', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleModeloInsumos( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleModeloInsumos( lcAtributo )
		endfor
		lcSelect = substr( lcSelect, 2 )
		return lcSelect
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosDetalleModeloProcesos( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  MODPROC.CODMODPROC != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Nroitem" as "Nroitem", "Codmodproc" as "Codigo", "Codigo" as "Proceso", "Procdet" as "Procesodetalle", "Orden" as "Orden", "Taller" as "Taller", "Cantidad" as "Cantidaddesalida"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleModeloProcesos( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'MODPROC', 'ModeloProcesos', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleModeloProcesos( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleModeloProcesos( lcAtributo )
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
				Case lcAtributo == 'FECHAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECEXPO AS FECHAEXPO'
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'OBS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'OBS AS OBS'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'DESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCRIP AS DESCRIPCION'
				Case lcAtributo == 'PRODUCTOFINAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PRODUCTO AS PRODUCTOFINAL'
				Case lcAtributo == 'FAMILIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FAMILIA AS FAMILIA'
				Case lcAtributo == 'MATERIAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MATERIAL AS MATERIAL'
				Case lcAtributo == 'GRUPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'GRUPO AS GRUPO'
				Case lcAtributo == 'CURVADEPRODUCCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CURVAPROD AS CURVADEPRODUCCION'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleModeloSalidas( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODMODSAL AS CODIGO'
				Case lcAtributo == 'PROCESO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PROCESO AS PROCESO'
				Case lcAtributo == 'COLORM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CCOLOR AS COLORM'
				Case lcAtributo == 'COLORMDETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CCOLDET AS COLORMDETALLE'
				Case lcAtributo == 'TALLEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CTALLE AS TALLEM'
				Case lcAtributo == 'TALLEMDETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CTALLEDET AS TALLEMDETALLE'
				Case lcAtributo == 'SEMIELABORADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SEMIELAB AS SEMIELABORADO'
				Case lcAtributo == 'SEMIELABORADODETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SEMIDETA AS SEMIELABORADODETALLE'
				Case lcAtributo == 'COLOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ICOLOR AS COLOR'
				Case lcAtributo == 'COLORDETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ICOLDET AS COLORDETALLE'
				Case lcAtributo == 'TALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ITALLE AS TALLE'
				Case lcAtributo == 'TALLEDETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ITALLEDET AS TALLEDETALLE'
				Case lcAtributo == 'CANTIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CANTIDAD AS CANTIDAD'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleModeloMaquinas( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODMODMAQ AS CODIGO'
				Case lcAtributo == 'PROCESO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PROCESO AS PROCESO'
				Case lcAtributo == 'MAQUINA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MAQUINA AS MAQUINA'
				Case lcAtributo == 'MAQUINADETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MAQDETA AS MAQUINADETALLE'
				Case lcAtributo == 'TIPOMAQUINARIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPO AS TIPOMAQUINARIA'
				Case lcAtributo == 'UNIDADDETIEMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UNIDAD AS UNIDADDETIEMPO'
				Case lcAtributo == 'TIEMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIEMPO AS TIEMPO'
				Case lcAtributo == 'DESPERDICIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESPERDICI AS DESPERDICIO'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleModeloInsumos( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODMODINS AS CODIGO'
				Case lcAtributo == 'PROCESO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PROCESO AS PROCESO'
				Case lcAtributo == 'COLORM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CCOLOR AS COLORM'
				Case lcAtributo == 'COLORMDETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CCOLDET AS COLORMDETALLE'
				Case lcAtributo == 'TALLEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CTALLE AS TALLEM'
				Case lcAtributo == 'TALLEMDETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CTALLEDET AS TALLEMDETALLE'
				Case lcAtributo == 'INSUMO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'INSUMO AS INSUMO'
				Case lcAtributo == 'INSUMODETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'INSDET AS INSUMODETALLE'
				Case lcAtributo == 'COLOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ICOLOR AS COLOR'
				Case lcAtributo == 'COLORDETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ICOLDET AS COLORDETALLE'
				Case lcAtributo == 'TALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ITALLE AS TALLE'
				Case lcAtributo == 'TALLEDETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ITALLEDET AS TALLEDETALLE'
				Case lcAtributo == 'UNIDADDEMEDIDA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UNIMED AS UNIDADDEMEDIDA'
				Case lcAtributo == 'CANTIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CANTIDAD AS CANTIDAD'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleModeloProcesos( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODMODPROC AS CODIGO'
				Case lcAtributo == 'PROCESO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS PROCESO'
				Case lcAtributo == 'PROCESODETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PROCDET AS PROCESODETALLE'
				Case lcAtributo == 'ORDEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ORDEN AS ORDEN'
				Case lcAtributo == 'TALLER'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TALLER AS TALLER'
				Case lcAtributo == 'CANTIDADDESALIDA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CANTIDAD AS CANTIDADDESALIDA'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEXPO'
				lcCampo = 'FECEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'OBS'
				lcCampo = 'OBS'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCION'
				lcCampo = 'DESCRIP'
			Case upper( alltrim( tcAtributo ) ) == 'PRODUCTOFINAL'
				lcCampo = 'PRODUCTO'
			Case upper( alltrim( tcAtributo ) ) == 'FAMILIA'
				lcCampo = 'FAMILIA'
			Case upper( alltrim( tcAtributo ) ) == 'MATERIAL'
				lcCampo = 'MATERIAL'
			Case upper( alltrim( tcAtributo ) ) == 'GRUPO'
				lcCampo = 'GRUPO'
			Case upper( alltrim( tcAtributo ) ) == 'CURVADEPRODUCCION'
				lcCampo = 'CURVAPROD'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleModeloSalidas( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODMODSAL'
			Case upper( alltrim( tcAtributo ) ) == 'PROCESO'
				lcCampo = 'PROCESO'
			Case upper( alltrim( tcAtributo ) ) == 'COLORM'
				lcCampo = 'CCOLOR'
			Case upper( alltrim( tcAtributo ) ) == 'COLORMDETALLE'
				lcCampo = 'CCOLDET'
			Case upper( alltrim( tcAtributo ) ) == 'TALLEM'
				lcCampo = 'CTALLE'
			Case upper( alltrim( tcAtributo ) ) == 'TALLEMDETALLE'
				lcCampo = 'CTALLEDET'
			Case upper( alltrim( tcAtributo ) ) == 'SEMIELABORADO'
				lcCampo = 'SEMIELAB'
			Case upper( alltrim( tcAtributo ) ) == 'SEMIELABORADODETALLE'
				lcCampo = 'SEMIDETA'
			Case upper( alltrim( tcAtributo ) ) == 'COLOR'
				lcCampo = 'ICOLOR'
			Case upper( alltrim( tcAtributo ) ) == 'COLORDETALLE'
				lcCampo = 'ICOLDET'
			Case upper( alltrim( tcAtributo ) ) == 'TALLE'
				lcCampo = 'ITALLE'
			Case upper( alltrim( tcAtributo ) ) == 'TALLEDETALLE'
				lcCampo = 'ITALLEDET'
			Case upper( alltrim( tcAtributo ) ) == 'CANTIDAD'
				lcCampo = 'CANTIDAD'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleModeloMaquinas( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODMODMAQ'
			Case upper( alltrim( tcAtributo ) ) == 'PROCESO'
				lcCampo = 'PROCESO'
			Case upper( alltrim( tcAtributo ) ) == 'MAQUINA'
				lcCampo = 'MAQUINA'
			Case upper( alltrim( tcAtributo ) ) == 'MAQUINADETALLE'
				lcCampo = 'MAQDETA'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOMAQUINARIA'
				lcCampo = 'TIPO'
			Case upper( alltrim( tcAtributo ) ) == 'UNIDADDETIEMPO'
				lcCampo = 'UNIDAD'
			Case upper( alltrim( tcAtributo ) ) == 'TIEMPO'
				lcCampo = 'TIEMPO'
			Case upper( alltrim( tcAtributo ) ) == 'DESPERDICIO'
				lcCampo = 'DESPERDICI'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleModeloInsumos( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODMODINS'
			Case upper( alltrim( tcAtributo ) ) == 'PROCESO'
				lcCampo = 'PROCESO'
			Case upper( alltrim( tcAtributo ) ) == 'COLORM'
				lcCampo = 'CCOLOR'
			Case upper( alltrim( tcAtributo ) ) == 'COLORMDETALLE'
				lcCampo = 'CCOLDET'
			Case upper( alltrim( tcAtributo ) ) == 'TALLEM'
				lcCampo = 'CTALLE'
			Case upper( alltrim( tcAtributo ) ) == 'TALLEMDETALLE'
				lcCampo = 'CTALLEDET'
			Case upper( alltrim( tcAtributo ) ) == 'INSUMO'
				lcCampo = 'INSUMO'
			Case upper( alltrim( tcAtributo ) ) == 'INSUMODETALLE'
				lcCampo = 'INSDET'
			Case upper( alltrim( tcAtributo ) ) == 'COLOR'
				lcCampo = 'ICOLOR'
			Case upper( alltrim( tcAtributo ) ) == 'COLORDETALLE'
				lcCampo = 'ICOLDET'
			Case upper( alltrim( tcAtributo ) ) == 'TALLE'
				lcCampo = 'ITALLE'
			Case upper( alltrim( tcAtributo ) ) == 'TALLEDETALLE'
				lcCampo = 'ITALLEDET'
			Case upper( alltrim( tcAtributo ) ) == 'UNIDADDEMEDIDA'
				lcCampo = 'UNIMED'
			Case upper( alltrim( tcAtributo ) ) == 'CANTIDAD'
				lcCampo = 'CANTIDAD'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleModeloProcesos( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODMODPROC'
			Case upper( alltrim( tcAtributo ) ) == 'PROCESO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'PROCESODETALLE'
				lcCampo = 'PROCDET'
			Case upper( alltrim( tcAtributo ) ) == 'ORDEN'
				lcCampo = 'ORDEN'
			Case upper( alltrim( tcAtributo ) ) == 'TALLER'
				lcCampo = 'TALLER'
			Case upper( alltrim( tcAtributo ) ) == 'CANTIDADDESALIDA'
				lcCampo = 'CANTIDAD'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerTablaDetalle( tcDetalle as string ) as String
		local lcRetorno as string
		lcRetorno = ''
		if upper( alltrim( tcDetalle ) ) == 'MODELOSALIDAS'
			lcRetorno = 'MODSAL'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'MODELOMAQUINAS'
			lcRetorno = 'MODMAQ'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'MODELOINSUMOS'
			lcRetorno = 'MODINS'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'MODELOPROCESOS'
			lcRetorno = 'MODPROC'
		EndIf
		return lcRetorno
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasInsert() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcSentencia as string, loItem as object
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxModeloprodFecimpo, lxModeloprodFectrans, lxModeloprodFmodifw, lxModeloprodFecexpo, lxModeloprodFaltafw, lxModeloprodSaltafw, lxModeloprodEsttrans, lxModeloprodHmodifw, lxModeloprodHoraimpo, lxModeloprodHoraexpo, lxModeloprodBdmodifw, lxModeloprodBdaltafw, lxModeloprodVmodifw, lxModeloprodZadsfw, lxModeloprodValtafw, lxModeloprodUmodifw, lxModeloprodSmodifw, lxModeloprodUaltafw, lxModeloprodHaltafw, lxModeloprodObs, lxModeloprodCodigo, lxModeloprodDescrip, lxModeloprodProducto, lxModeloprodFamilia, lxModeloprodMaterial, lxModeloprodGrupo, lxModeloprodCurvaprod
				lxModeloprodFecimpo =  .Fechaimpo			lxModeloprodFectrans =  .Fechatransferencia			lxModeloprodFmodifw =  .Fechamodificacionfw			lxModeloprodFecexpo =  .Fechaexpo			lxModeloprodFaltafw =  .Fechaaltafw			lxModeloprodSaltafw =  .Seriealtafw			lxModeloprodEsttrans =  .Estadotransferencia			lxModeloprodHmodifw =  .Horamodificacionfw			lxModeloprodHoraimpo =  .Horaimpo			lxModeloprodHoraexpo =  .Horaexpo			lxModeloprodBdmodifw =  .Basededatosmodificacionfw			lxModeloprodBdaltafw =  .Basededatosaltafw			lxModeloprodVmodifw =  .Versionmodificacionfw			lxModeloprodZadsfw =  .Zadsfw			lxModeloprodValtafw =  .Versionaltafw			lxModeloprodUmodifw =  .Usuariomodificacionfw			lxModeloprodSmodifw =  .Seriemodificacionfw			lxModeloprodUaltafw =  .Usuarioaltafw			lxModeloprodHaltafw =  .Horaaltafw			lxModeloprodObs =  .Obs			lxModeloprodCodigo =  .Codigo			lxModeloprodDescrip =  .Descripcion			lxModeloprodProducto =  upper( .ProductoFinal_PK ) 			lxModeloprodFamilia =  upper( .Familia_PK ) 			lxModeloprodMaterial =  upper( .Material_PK ) 			lxModeloprodGrupo =  upper( .Grupo_PK ) 			lxModeloprodCurvaprod =  upper( .CurvaDeProduccion_PK ) 
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.MODELOPROD ( "Fecimpo","Fectrans","Fmodifw","Fecexpo","Faltafw","Saltafw","Esttrans","Hmodifw","Horaimpo","Horaexpo","Bdmodifw","Bdaltafw","Vmodifw","Zadsfw","Valtafw","Umodifw","Smodifw","Ualtafw","Haltafw","Obs","Codigo","Descrip","Producto","Familia","Material","Grupo","Curvaprod" ) values ( <<"'" + this.ConvertirDateSql( lxModeloprodFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxModeloprodFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxModeloprodFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxModeloprodFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxModeloprodFaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModeloprodSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModeloprodEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModeloprodHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModeloprodHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModeloprodHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModeloprodBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModeloprodBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModeloprodVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModeloprodZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModeloprodValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModeloprodUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModeloprodSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModeloprodUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModeloprodHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModeloprodObs ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModeloprodCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModeloprodDescrip ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModeloprodProducto ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModeloprodFamilia ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModeloprodMaterial ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModeloprodGrupo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxModeloprodCurvaprod ) + "'" >> )
		endtext
		loColeccion.cTabla = 'MODELOPROD' 
		loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		With this
			local lcValorClavePrimariaString as String
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ModeloSalidas
				if this.oEntidad.ModeloSalidas.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxProceso_PK = loItem.Proceso_PK
					lxColorm_PK = loItem.Colorm_PK
					lxColormdetalle = loItem.Colormdetalle
					lxTallem_PK = loItem.Tallem_PK
					lxTallemdetalle = loItem.Tallemdetalle
					lxSemielaborado_PK = loItem.Semielaborado_PK
					lxSemielaboradodetalle = loItem.Semielaboradodetalle
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxTalle_PK = loItem.Talle_PK
					lxTalledetalle = loItem.Talledetalle
					lxCantidad = loItem.Cantidad
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.MODSAL("NROITEM","CodModSal","Proceso","cColor","cColDet","cTalle","cTalleDet","SemiElab","SemiDeta","iColor","IColDet","iTalle","ITalleDet","Cantidad" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxProceso_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColorm_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColormdetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTallem_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTallemdetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxSemielaborado_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxSemielaboradodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalledetalle ) + "'">>, <<lxCantidad>> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ModeloMaquinas
				if this.oEntidad.ModeloMaquinas.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxProceso_PK = loItem.Proceso_PK
					lxMaquina_PK = loItem.Maquina_PK
					lxMaquinadetalle = loItem.Maquinadetalle
					lxTipomaquinaria = loItem.Tipomaquinaria
					lxUnidaddetiempo = loItem.Unidaddetiempo
					lxTiempo = loItem.Tiempo
					lxDesperdicio = loItem.Desperdicio
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.MODMAQ("NROITEM","CodModMaq","Proceso","Maquina","MaqDeta","Tipo","Unidad","Tiempo","Desperdici" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxProceso_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxMaquina_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxMaquinadetalle ) + "'">>, <<lxTipomaquinaria>>, <<lxUnidaddetiempo>>, <<lxTiempo>>, <<lxDesperdicio>> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ModeloInsumos
				if this.oEntidad.ModeloInsumos.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxProceso_PK = loItem.Proceso_PK
					lxColorm_PK = loItem.Colorm_PK
					lxColormdetalle = loItem.Colormdetalle
					lxTallem_PK = loItem.Tallem_PK
					lxTallemdetalle = loItem.Tallemdetalle
					lxInsumo_PK = loItem.Insumo_PK
					lxInsumodetalle = loItem.Insumodetalle
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxTalle_PK = loItem.Talle_PK
					lxTalledetalle = loItem.Talledetalle
					lxUnidaddemedida_PK = loItem.Unidaddemedida_PK
					lxCantidad = loItem.Cantidad
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.MODINS("NROITEM","CodModIns","Proceso","cColor","cColDet","cTalle","cTalleDet","Insumo","InsDet","iColor","IColDet","iTalle","ITalleDet","UniMed","Cantidad" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxProceso_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColorm_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColormdetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTallem_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTallemdetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxInsumo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxInsumodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalledetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxUnidaddemedida_PK ) + "'">>, <<lxCantidad>> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ModeloProcesos
				if this.oEntidad.ModeloProcesos.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxProceso_PK = loItem.Proceso_PK
					lxProcesodetalle = loItem.Procesodetalle
					lxOrden = loItem.Orden
					lxTaller_PK = loItem.Taller_PK
					lxCantidaddesalida = loItem.Cantidaddesalida
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.MODPROC("NROITEM","CodModProc","Codigo","ProcDet","Orden","Taller","Cantidad" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxProceso_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxProcesodetalle ) + "'">>, <<lxOrden>>, <<"'" + this.FormatearTextoSql( lxTaller_PK ) + "'">>, <<lxCantidaddesalida>> ) 
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
			local  lxModeloprodFecimpo, lxModeloprodFectrans, lxModeloprodFmodifw, lxModeloprodFecexpo, lxModeloprodFaltafw, lxModeloprodSaltafw, lxModeloprodEsttrans, lxModeloprodHmodifw, lxModeloprodHoraimpo, lxModeloprodHoraexpo, lxModeloprodBdmodifw, lxModeloprodBdaltafw, lxModeloprodVmodifw, lxModeloprodZadsfw, lxModeloprodValtafw, lxModeloprodUmodifw, lxModeloprodSmodifw, lxModeloprodUaltafw, lxModeloprodHaltafw, lxModeloprodObs, lxModeloprodCodigo, lxModeloprodDescrip, lxModeloprodProducto, lxModeloprodFamilia, lxModeloprodMaterial, lxModeloprodGrupo, lxModeloprodCurvaprod
				lxModeloprodFecimpo =  .Fechaimpo			lxModeloprodFectrans =  .Fechatransferencia			lxModeloprodFmodifw =  .Fechamodificacionfw			lxModeloprodFecexpo =  .Fechaexpo			lxModeloprodFaltafw =  .Fechaaltafw			lxModeloprodSaltafw =  .Seriealtafw			lxModeloprodEsttrans =  .Estadotransferencia			lxModeloprodHmodifw =  .Horamodificacionfw			lxModeloprodHoraimpo =  .Horaimpo			lxModeloprodHoraexpo =  .Horaexpo			lxModeloprodBdmodifw =  .Basededatosmodificacionfw			lxModeloprodBdaltafw =  .Basededatosaltafw			lxModeloprodVmodifw =  .Versionmodificacionfw			lxModeloprodZadsfw =  .Zadsfw			lxModeloprodValtafw =  .Versionaltafw			lxModeloprodUmodifw =  .Usuariomodificacionfw			lxModeloprodSmodifw =  .Seriemodificacionfw			lxModeloprodUaltafw =  .Usuarioaltafw			lxModeloprodHaltafw =  .Horaaltafw			lxModeloprodObs =  .Obs			lxModeloprodCodigo =  .Codigo			lxModeloprodDescrip =  .Descripcion			lxModeloprodProducto =  upper( .ProductoFinal_PK ) 			lxModeloprodFamilia =  upper( .Familia_PK ) 			lxModeloprodMaterial =  upper( .Material_PK ) 			lxModeloprodGrupo =  upper( .Grupo_PK ) 			lxModeloprodCurvaprod =  upper( .CurvaDeProduccion_PK ) 
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  MODELOPROD.CODIGO != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.MODELOPROD set "Fecimpo" = <<"'" + this.ConvertirDateSql( lxModeloprodFecimpo ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxModeloprodFectrans ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxModeloprodFmodifw ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxModeloprodFecexpo ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxModeloprodFaltafw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxModeloprodSaltafw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxModeloprodEsttrans ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxModeloprodHmodifw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxModeloprodHoraimpo ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxModeloprodHoraexpo ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxModeloprodBdmodifw ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxModeloprodBdaltafw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxModeloprodVmodifw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxModeloprodZadsfw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxModeloprodValtafw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxModeloprodUmodifw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxModeloprodSmodifw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxModeloprodUaltafw ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxModeloprodHaltafw ) + "'">>, "Obs" = <<"'" + this.FormatearTextoSql( lxModeloprodObs ) + "'">>, "Codigo" = <<"'" + this.FormatearTextoSql( lxModeloprodCodigo ) + "'">>, "Descrip" = <<"'" + this.FormatearTextoSql( lxModeloprodDescrip ) + "'">>, "Producto" = <<"'" + this.FormatearTextoSql( lxModeloprodProducto ) + "'">>, "Familia" = <<"'" + this.FormatearTextoSql( lxModeloprodFamilia ) + "'">>, "Material" = <<"'" + this.FormatearTextoSql( lxModeloprodMaterial ) + "'">>, "Grupo" = <<"'" + this.FormatearTextoSql( lxModeloprodGrupo ) + "'">>, "Curvaprod" = <<"'" + this.FormatearTextoSql( lxModeloprodCurvaprod ) + "'">> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'MODELOPROD' 
		loColeccion.agregar( strtran(  lcSentencia, chr( 9 ), '' ) )
			loColeccion.Agregar([delete from ZooLogic.MODSAL where "CodModSal" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.MODMAQ where "CodModMaq" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.MODINS where "CodModIns" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.MODPROC where "CodModProc" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ModeloSalidas
				if this.oEntidad.ModeloSalidas.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxProceso_PK = loItem.Proceso_PK
					lxColorm_PK = loItem.Colorm_PK
					lxColormdetalle = loItem.Colormdetalle
					lxTallem_PK = loItem.Tallem_PK
					lxTallemdetalle = loItem.Tallemdetalle
					lxSemielaborado_PK = loItem.Semielaborado_PK
					lxSemielaboradodetalle = loItem.Semielaboradodetalle
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxTalle_PK = loItem.Talle_PK
					lxTalledetalle = loItem.Talledetalle
					lxCantidad = loItem.Cantidad
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.MODSAL("NROITEM","CodModSal","Proceso","cColor","cColDet","cTalle","cTalleDet","SemiElab","SemiDeta","iColor","IColDet","iTalle","ITalleDet","Cantidad" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxProceso_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColorm_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColormdetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTallem_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTallemdetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxSemielaborado_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxSemielaboradodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalledetalle ) + "'">>, <<lxCantidad>> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ModeloMaquinas
				if this.oEntidad.ModeloMaquinas.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxProceso_PK = loItem.Proceso_PK
					lxMaquina_PK = loItem.Maquina_PK
					lxMaquinadetalle = loItem.Maquinadetalle
					lxTipomaquinaria = loItem.Tipomaquinaria
					lxUnidaddetiempo = loItem.Unidaddetiempo
					lxTiempo = loItem.Tiempo
					lxDesperdicio = loItem.Desperdicio
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.MODMAQ("NROITEM","CodModMaq","Proceso","Maquina","MaqDeta","Tipo","Unidad","Tiempo","Desperdici" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxProceso_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxMaquina_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxMaquinadetalle ) + "'">>, <<lxTipomaquinaria>>, <<lxUnidaddetiempo>>, <<lxTiempo>>, <<lxDesperdicio>> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ModeloInsumos
				if this.oEntidad.ModeloInsumos.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxProceso_PK = loItem.Proceso_PK
					lxColorm_PK = loItem.Colorm_PK
					lxColormdetalle = loItem.Colormdetalle
					lxTallem_PK = loItem.Tallem_PK
					lxTallemdetalle = loItem.Tallemdetalle
					lxInsumo_PK = loItem.Insumo_PK
					lxInsumodetalle = loItem.Insumodetalle
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxTalle_PK = loItem.Talle_PK
					lxTalledetalle = loItem.Talledetalle
					lxUnidaddemedida_PK = loItem.Unidaddemedida_PK
					lxCantidad = loItem.Cantidad
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.MODINS("NROITEM","CodModIns","Proceso","cColor","cColDet","cTalle","cTalleDet","Insumo","InsDet","iColor","IColDet","iTalle","ITalleDet","UniMed","Cantidad" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxProceso_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColorm_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColormdetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTallem_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTallemdetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxInsumo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxInsumodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalledetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxUnidaddemedida_PK ) + "'">>, <<lxCantidad>> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ModeloProcesos
				if this.oEntidad.ModeloProcesos.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxProceso_PK = loItem.Proceso_PK
					lxProcesodetalle = loItem.Procesodetalle
					lxOrden = loItem.Orden
					lxTaller_PK = loItem.Taller_PK
					lxCantidaddesalida = loItem.Cantidaddesalida
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.MODPROC("NROITEM","CodModProc","Codigo","ProcDet","Orden","Taller","Cantidad" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxProceso_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxProcesodetalle ) + "'">>, <<lxOrden>>, <<"'" + this.FormatearTextoSql( lxTaller_PK ) + "'">>, <<lxCantidaddesalida>> ) 
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

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  MODELOPROD.CODIGO != '']
		loColeccion.Agregar( 'delete from ZooLogic.MODELOPROD where ' + lcFiltro )
			loColeccion.Agregar([delete from ZooLogic.MODSAL where "CodModSal" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.MODMAQ where "CodModMaq" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.MODINS where "CodModIns" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.MODPROC where "CodModProc" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.cTabla = 'MODELOPROD' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.MODELOPROD where  MODELOPROD.CODIGO != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.MODELOPROD where Codigo = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  MODELOPROD.CODIGO != ''" )
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
		lcCursor = This.oEntidad.cPrefijoRecibir + 'MODELODEPRODUCCION'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.MODELOPROD Where Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'", 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					this.oConexion.EjecutarSql( [UPDATE ZooLogic.MODELOPROD set  FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, Obs = ] + "'" + this.FormatearTextoSql( &lcCursor..Obs ) + "'"+ [, Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'"+ [, Descrip = ] + "'" + this.FormatearTextoSql( &lcCursor..Descrip ) + "'"+ [, Producto = ] + "'" + this.FormatearTextoSql( &lcCursor..Producto ) + "'"+ [, Familia = ] + "'" + this.FormatearTextoSql( &lcCursor..Familia ) + "'"+ [, Material = ] + "'" + this.FormatearTextoSql( &lcCursor..Material ) + "'"+ [, Grupo = ] + "'" + this.FormatearTextoSql( &lcCursor..Grupo ) + "'"+ [, CurvaProd = ] + "'" + this.FormatearTextoSql( &lcCursor..CurvaProd ) + "'" + [ Where Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'" )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
				endIf
			else
				Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
				Text to lcCampos noShow
					 FECIMPO, FECTRANS, FMODIFW, FECEXPO, FALTAFW, SALTAFW, ESTTRANS, HMODIFW, HORAIMPO, HORAEXPO, BDMODIFW, BDALTAFW, VMODIFW, ZADSFW, VALTAFW, UMODIFW, SMODIFW, UALTAFW, HALTAFW, Obs, Codigo, Descrip, Producto, Familia, Material, Grupo, CurvaProd
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Obs ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..Descrip ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Producto ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Familia ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Material ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Grupo ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CurvaProd ) + "'"
lcValoresCampos = substr(lcValoresCampos,2) 

				this.oConexion.EjecutarSql( [Insert into ZooLogic.MODELOPROD ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
				this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'MODELODEPRODUCCION'
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
			this.oConexion.EjecutarSql( [Delete From ZooLogic.MODSAL Where CodModSal] + lcIn  )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.MODMAQ Where CodModMaq] + lcIn  )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.MODINS Where CodModIns] + lcIn  )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.MODPROC Where CodModProc] + lcIn  )
			endfor
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'COMMIT TRANSACTION' )
			endif
		EndIf
	endif
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMMODELOSALIDA'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where CodModSal in ( select Codigo from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"NROITEM","CodModSal","Proceso","cColor","cColDet","cTalle","cTalleDet","SemiElab","SemiDeta","iColor","IColDet","iTalle","ITalleDet","Cantidad"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.MODSAL ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CodModSal  ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Proceso    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.cColor     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.cColDet    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.cTalle     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.cTalleDet  ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.SemiElab   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.SemiDeta   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.iColor     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.IColDet    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.iTalle     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ITalleDet  ) + "'" + ',' + transform( cDetallesExistentes.Cantidad   ) + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMMODELOMAQUINA'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where CodModMaq in ( select Codigo from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"NROITEM","CodModMaq","Proceso","Maquina","MaqDeta","Tipo","Unidad","Tiempo","Desperdici"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.MODMAQ ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CodModMaq  ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Proceso    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Maquina    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.MaqDeta    ) + "'" + ',' + transform( cDetallesExistentes.Tipo       ) + ',' + transform( cDetallesExistentes.Unidad     ) + ',' + transform( cDetallesExistentes.Tiempo     ) + ',' + transform( cDetallesExistentes.Desperdici ) + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMMODELOINSUMO'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where CodModIns in ( select Codigo from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"NROITEM","CodModIns","Proceso","cColor","cColDet","cTalle","cTalleDet","Insumo","InsDet","iColor","IColDet","iTalle","ITalleDet","UniMed","Cantidad"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.MODINS ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CodModIns  ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Proceso    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.cColor     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.cColDet    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.cTalle     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.cTalleDet  ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Insumo     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.InsDet     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.iColor     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.IColDet    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.iTalle     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ITalleDet  ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.UniMed     ) + "'" + ',' + transform( cDetallesExistentes.Cantidad   ) + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMMODELOPROCESO'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where CodModProc in ( select Codigo from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"NROITEM","CodModProc","Codigo","ProcDet","Orden","Taller","Cantidad"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.MODPROC ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CodModProc ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Codigo     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ProcDet    ) + "'" + ',' + transform( cDetallesExistentes.Orden      ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Taller     ) + "'" + ',' + transform( cDetallesExistentes.Cantidad   ) + ' )'  )
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
			Case  lcAlias == lcPrefijo + 'MODELODEPRODUCCION'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'MODELODEPRODUCCION_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'MODELODEPRODUCCION_OBS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMMODELOSALIDA'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMMODELOMAQUINA'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMMODELOINSUMO'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMMODELOPROCESO'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_MODELOPROD')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'MODELODEPRODUCCION'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..Codigo
		llCondicion = isnull( lxVar )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad MODELODEPRODUCCION. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'MODELODEPRODUCCION'
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
			lcCursor = This.oEntidad.cPrefijoRecibir + 'MODELODEPRODUCCION'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_MODELOPROD') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_MODELOPROD
Create Table ZooLogic.TablaTrabajo_MODELOPROD ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fecimpo" datetime  null, 
"fectrans" datetime  null, 
"fmodifw" datetime  null, 
"fecexpo" datetime  null, 
"faltafw" datetime  null, 
"saltafw" char( 7 )  null, 
"esttrans" char( 20 )  null, 
"hmodifw" char( 8 )  null, 
"horaimpo" char( 8 )  null, 
"horaexpo" char( 8 )  null, 
"bdmodifw" char( 8 )  null, 
"bdaltafw" char( 8 )  null, 
"vmodifw" char( 13 )  null, 
"zadsfw" varchar(max)  null, 
"valtafw" char( 13 )  null, 
"umodifw" char( 100 )  null, 
"smodifw" char( 7 )  null, 
"ualtafw" char( 100 )  null, 
"haltafw" char( 8 )  null, 
"obs" varchar(max)  null, 
"codigo" char( 15 )  null, 
"descrip" char( 100 )  null, 
"producto" char( 15 )  null, 
"familia" char( 10 )  null, 
"material" char( 10 )  null, 
"grupo" char( 10 )  null, 
"curvaprod" char( 15 )  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_MODELOPROD' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_MODELOPROD' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'MODELODEPRODUCCION'
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
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('obs','obs')
			.AgregarMapeo('codigo','codigo')
			.AgregarMapeo('descrip','descrip')
			.AgregarMapeo('producto','producto')
			.AgregarMapeo('familia','familia')
			.AgregarMapeo('material','material')
			.AgregarMapeo('grupo','grupo')
			.AgregarMapeo('curvaprod','curvaprod')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_MODELOPROD'
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
				Update t Set t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.OBS = isnull( d.OBS, t.OBS ),t.CODIGO = isnull( d.CODIGO, t.CODIGO ),t.DESCRIP = isnull( d.DESCRIP, t.DESCRIP ),t.PRODUCTO = isnull( d.PRODUCTO, t.PRODUCTO ),t.FAMILIA = isnull( d.FAMILIA, t.FAMILIA ),t.MATERIAL = isnull( d.MATERIAL, t.MATERIAL ),t.GRUPO = isnull( d.GRUPO, t.GRUPO ),t.CURVAPROD = isnull( d.CURVAPROD, t.CURVAPROD )
					from ZooLogic.MODELOPROD t inner join deleted d 
							 on t.Codigo = d.Codigo
				-- Fin Updates
				insert into ZooLogic.MODELOPROD(Fecimpo,Fectrans,Fmodifw,Fecexpo,Faltafw,Saltafw,Esttrans,Hmodifw,Horaimpo,Horaexpo,Bdmodifw,Bdaltafw,Vmodifw,Zadsfw,Valtafw,Umodifw,Smodifw,Ualtafw,Haltafw,Obs,Codigo,Descrip,Producto,Familia,Material,Grupo,Curvaprod)
					Select isnull( d.FECIMPO,''),isnull( d.FECTRANS,''),isnull( d.FMODIFW,''),isnull( d.FECEXPO,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.SALTAFW,''),isnull( d.ESTTRANS,''),isnull( d.HMODIFW,''),isnull( d.HORAIMPO,''),isnull( d.HORAEXPO,''),isnull( d.BDMODIFW,''),isnull( d.BDALTAFW,''),isnull( d.VMODIFW,''),isnull( d.ZADSFW,''),isnull( d.VALTAFW,''),isnull( d.UMODIFW,''),isnull( d.SMODIFW,''),isnull( d.UALTAFW,''),convert( char(8), getdate(), 108 ),isnull( d.OBS,''),isnull( d.CODIGO,''),isnull( d.DESCRIP,''),isnull( d.PRODUCTO,''),isnull( d.FAMILIA,''),isnull( d.MATERIAL,''),isnull( d.GRUPO,''),isnull( d.CURVAPROD,'')
						From deleted d left join ZooLogic.MODELOPROD pk 
							 on d.Codigo = pk.Codigo
						Where pk.Codigo Is Null 
				-- Fin Inserts
			End
		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_MODSAL( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_MODELOPROD_MODSAL
ON ZooLogic.TablaTrabajo_MODELOPROD_MODSAL
AFTER DELETE
As
Begin
Update t Set 
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.CODMODSAL = isnull( d.CODMODSAL, t.CODMODSAL ),
t.PROCESO = isnull( d.PROCESO, t.PROCESO ),
t.CCOLOR = isnull( d.CCOLOR, t.CCOLOR ),
t.CCOLDET = isnull( d.CCOLDET, t.CCOLDET ),
t.CTALLE = isnull( d.CTALLE, t.CTALLE ),
t.CTALLEDET = isnull( d.CTALLEDET, t.CTALLEDET ),
t.SEMIELAB = isnull( d.SEMIELAB, t.SEMIELAB ),
t.SEMIDETA = isnull( d.SEMIDETA, t.SEMIDETA ),
t.ICOLOR = isnull( d.ICOLOR, t.ICOLOR ),
t.ICOLDET = isnull( d.ICOLDET, t.ICOLDET ),
t.ITALLE = isnull( d.ITALLE, t.ITALLE ),
t.ITALLEDET = isnull( d.ITALLEDET, t.ITALLEDET ),
t.CANTIDAD = isnull( d.CANTIDAD, t.CANTIDAD )
from ZooLogic.MODSAL t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.MODSAL
( 
"NROITEM",
"CODMODSAL",
"PROCESO",
"CCOLOR",
"CCOLDET",
"CTALLE",
"CTALLEDET",
"SEMIELAB",
"SEMIDETA",
"ICOLOR",
"ICOLDET",
"ITALLE",
"ITALLEDET",
"CANTIDAD"
 )
Select 
d.NROITEM,
d.CODMODSAL,
d.PROCESO,
d.CCOLOR,
d.CCOLDET,
d.CTALLE,
d.CTALLEDET,
d.SEMIELAB,
d.SEMIDETA,
d.ICOLOR,
d.ICOLDET,
d.ITALLE,
d.ITALLEDET,
d.CANTIDAD
From deleted d left join ZooLogic.MODSAL pk 
 on d.CODIGO = pk.CODIGO
Where pk.CODIGO Is Null 
-- Fin Inserts
End

		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_MODMAQ( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_MODELOPROD_MODMAQ
ON ZooLogic.TablaTrabajo_MODELOPROD_MODMAQ
AFTER DELETE
As
Begin
Update t Set 
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.CODMODMAQ = isnull( d.CODMODMAQ, t.CODMODMAQ ),
t.PROCESO = isnull( d.PROCESO, t.PROCESO ),
t.MAQUINA = isnull( d.MAQUINA, t.MAQUINA ),
t.MAQDETA = isnull( d.MAQDETA, t.MAQDETA ),
t.TIPO = isnull( d.TIPO, t.TIPO ),
t.UNIDAD = isnull( d.UNIDAD, t.UNIDAD ),
t.TIEMPO = isnull( d.TIEMPO, t.TIEMPO ),
t.DESPERDICI = isnull( d.DESPERDICI, t.DESPERDICI )
from ZooLogic.MODMAQ t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.MODMAQ
( 
"NROITEM",
"CODMODMAQ",
"PROCESO",
"MAQUINA",
"MAQDETA",
"TIPO",
"UNIDAD",
"TIEMPO",
"DESPERDICI"
 )
Select 
d.NROITEM,
d.CODMODMAQ,
d.PROCESO,
d.MAQUINA,
d.MAQDETA,
d.TIPO,
d.UNIDAD,
d.TIEMPO,
d.DESPERDICI
From deleted d left join ZooLogic.MODMAQ pk 
 on d.CODIGO = pk.CODIGO
Where pk.CODIGO Is Null 
-- Fin Inserts
End

		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_MODINS( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_MODELOPROD_MODINS
ON ZooLogic.TablaTrabajo_MODELOPROD_MODINS
AFTER DELETE
As
Begin
Update t Set 
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.CODMODINS = isnull( d.CODMODINS, t.CODMODINS ),
t.PROCESO = isnull( d.PROCESO, t.PROCESO ),
t.CCOLOR = isnull( d.CCOLOR, t.CCOLOR ),
t.CCOLDET = isnull( d.CCOLDET, t.CCOLDET ),
t.CTALLE = isnull( d.CTALLE, t.CTALLE ),
t.CTALLEDET = isnull( d.CTALLEDET, t.CTALLEDET ),
t.INSUMO = isnull( d.INSUMO, t.INSUMO ),
t.INSDET = isnull( d.INSDET, t.INSDET ),
t.ICOLOR = isnull( d.ICOLOR, t.ICOLOR ),
t.ICOLDET = isnull( d.ICOLDET, t.ICOLDET ),
t.ITALLE = isnull( d.ITALLE, t.ITALLE ),
t.ITALLEDET = isnull( d.ITALLEDET, t.ITALLEDET ),
t.UNIMED = isnull( d.UNIMED, t.UNIMED ),
t.CANTIDAD = isnull( d.CANTIDAD, t.CANTIDAD )
from ZooLogic.MODINS t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.MODINS
( 
"NROITEM",
"CODMODINS",
"PROCESO",
"CCOLOR",
"CCOLDET",
"CTALLE",
"CTALLEDET",
"INSUMO",
"INSDET",
"ICOLOR",
"ICOLDET",
"ITALLE",
"ITALLEDET",
"UNIMED",
"CANTIDAD"
 )
Select 
d.NROITEM,
d.CODMODINS,
d.PROCESO,
d.CCOLOR,
d.CCOLDET,
d.CTALLE,
d.CTALLEDET,
d.INSUMO,
d.INSDET,
d.ICOLOR,
d.ICOLDET,
d.ITALLE,
d.ITALLEDET,
d.UNIMED,
d.CANTIDAD
From deleted d left join ZooLogic.MODINS pk 
 on d.CODIGO = pk.CODIGO
Where pk.CODIGO Is Null 
-- Fin Inserts
End

		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_MODPROC( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_MODELOPROD_MODPROC
ON ZooLogic.TablaTrabajo_MODELOPROD_MODPROC
AFTER DELETE
As
Begin
Update t Set 
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.CODMODPROC = isnull( d.CODMODPROC, t.CODMODPROC ),
t.CODIGO = isnull( d.CODIGO, t.CODIGO ),
t.PROCDET = isnull( d.PROCDET, t.PROCDET ),
t.ORDEN = isnull( d.ORDEN, t.ORDEN ),
t.TALLER = isnull( d.TALLER, t.TALLER ),
t.CANTIDAD = isnull( d.CANTIDAD, t.CANTIDAD )
from ZooLogic.MODPROC t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.MODPROC
( 
"NROITEM",
"CODMODPROC",
"CODIGO",
"PROCDET",
"ORDEN",
"TALLER",
"CANTIDAD"
 )
Select 
d.NROITEM,
d.CODMODPROC,
d.CODIGO,
d.PROCDET,
d.ORDEN,
d.TALLER,
d.CANTIDAD
From deleted d left join ZooLogic.MODPROC pk 
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_MODELOPROD') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_MODELOPROD
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_MODELODEPRODUCCION' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_MODELODEPRODUCCION.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_MODELODEPRODUCCION.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_MODELODEPRODUCCION.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_MODELODEPRODUCCION.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_MODELODEPRODUCCION.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Seriealtafw = nvl( c_MODELODEPRODUCCION.Seriealtafw, [] )
					.Estadotransferencia = nvl( c_MODELODEPRODUCCION.Estadotransferencia, [] )
					.Horamodificacionfw = nvl( c_MODELODEPRODUCCION.Horamodificacionfw, [] )
					.Horaimpo = nvl( c_MODELODEPRODUCCION.Horaimpo, [] )
					.Horaexpo = nvl( c_MODELODEPRODUCCION.Horaexpo, [] )
					.Basededatosmodificacionfw = nvl( c_MODELODEPRODUCCION.Basededatosmodificacionfw, [] )
					.Basededatosaltafw = nvl( c_MODELODEPRODUCCION.Basededatosaltafw, [] )
					.Versionmodificacionfw = nvl( c_MODELODEPRODUCCION.Versionmodificacionfw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Versionaltafw = nvl( c_MODELODEPRODUCCION.Versionaltafw, [] )
					.Usuariomodificacionfw = nvl( c_MODELODEPRODUCCION.Usuariomodificacionfw, [] )
					.Seriemodificacionfw = nvl( c_MODELODEPRODUCCION.Seriemodificacionfw, [] )
					.Usuarioaltafw = nvl( c_MODELODEPRODUCCION.Usuarioaltafw, [] )
					.Horaaltafw = nvl( c_MODELODEPRODUCCION.Horaaltafw, [] )
					lcValor = This.ObtenerMemo( 'c_Obs')
					.Obs = lcValor 
					.Codigo = nvl( c_MODELODEPRODUCCION.Codigo, [] )
					.Modelosalidas.Limpiar()
					.Modelosalidas.SetearEsNavegacion( .lProcesando )
					.Modelosalidas.Cargar()
					.Modelomaquinas.Limpiar()
					.Modelomaquinas.SetearEsNavegacion( .lProcesando )
					.Modelomaquinas.Cargar()
					.Modeloinsumos.Limpiar()
					.Modeloinsumos.SetearEsNavegacion( .lProcesando )
					.Modeloinsumos.Cargar()
					.Descripcion = nvl( c_MODELODEPRODUCCION.Descripcion, [] )
					.Productofinal_PK =  nvl( c_MODELODEPRODUCCION.Productofinal, [] )
					.Familia_PK =  nvl( c_MODELODEPRODUCCION.Familia, [] )
					.Material_PK =  nvl( c_MODELODEPRODUCCION.Material, [] )
					.Grupo_PK =  nvl( c_MODELODEPRODUCCION.Grupo, [] )
					.Curvadeproduccion_PK =  nvl( c_MODELODEPRODUCCION.Curvadeproduccion, [] )
					.Modeloprocesos.Limpiar()
					.Modeloprocesos.SetearEsNavegacion( .lProcesando )
					.Modeloprocesos.Cargar()
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
		
		loDetalle = this.oEntidad.ModeloSalidas
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

		loDetalle = this.oEntidad.ModeloMaquinas
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

		loDetalle = this.oEntidad.ModeloInsumos
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

		loDetalle = this.oEntidad.ModeloProcesos
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
		return c_MODELODEPRODUCCION.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.MODELOPROD' )
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
								from ZooLogic.MODELOPROD 
								Where   MODELOPROD.CODIGO != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "MODELOPROD", "", lcCursor, set("Datasession") )
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
			"Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Saltafw" as "Seriealtafw", "Esttrans" as "Estadotransferencia", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Haltafw" as "Horaaltafw", "Obs" as "Obs", "Codigo" as "Codigo", "Descrip" as "Descripcion", "Producto" as "Productofinal", "Familia" as "Familia", "Material" as "Material", "Grupo" as "Grupo", "Curvaprod" as "Curvadeproduccion"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.MODELOPROD 
								Where   MODELOPROD.CODIGO != ''
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
	Tabla = 'MODELOPROD'
	Filtro = " MODELOPROD.CODIGO != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " MODELOPROD.CODIGO != ''"
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
	<row entidad="MODELODEPRODUCCION                      " atributo="FECHAIMPO                               " tabla="MODELOPROD     " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MODELODEPRODUCCION                      " atributo="FECHATRANSFERENCIA                      " tabla="MODELOPROD     " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha de novedad                                                                                                                                                " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MODELODEPRODUCCION                      " atributo="FECHAMODIFICACIONFW                     " tabla="MODELOPROD     " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MODELODEPRODUCCION                      " atributo="FECHAEXPO                               " tabla="MODELOPROD     " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MODELODEPRODUCCION                      " atributo="FECHAALTAFW                             " tabla="MODELOPROD     " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MODELODEPRODUCCION                      " atributo="SERIEALTAFW                             " tabla="MODELOPROD     " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MODELODEPRODUCCION                      " atributo="ESTADOTRANSFERENCIA                     " tabla="MODELOPROD     " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado de novedad                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MODELODEPRODUCCION                      " atributo="HORAMODIFICACIONFW                      " tabla="MODELOPROD     " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MODELODEPRODUCCION                      " atributo="HORAIMPO                                " tabla="MODELOPROD     " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MODELODEPRODUCCION                      " atributo="HORAEXPO                                " tabla="MODELOPROD     " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MODELODEPRODUCCION                      " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="MODELOPROD     " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MODELODEPRODUCCION                      " atributo="BASEDEDATOSALTAFW                       " tabla="MODELOPROD     " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MODELODEPRODUCCION                      " atributo="VERSIONMODIFICACIONFW                   " tabla="MODELOPROD     " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MODELODEPRODUCCION                      " atributo="ZADSFW                                  " tabla="MODELOPROD     " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MODELODEPRODUCCION                      " atributo="VERSIONALTAFW                           " tabla="MODELOPROD     " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MODELODEPRODUCCION                      " atributo="USUARIOMODIFICACIONFW                   " tabla="MODELOPROD     " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MODELODEPRODUCCION                      " atributo="SERIEMODIFICACIONFW                     " tabla="MODELOPROD     " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MODELODEPRODUCCION                      " atributo="USUARIOALTAFW                           " tabla="MODELOPROD     " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MODELODEPRODUCCION                      " atributo="HORAALTAFW                              " tabla="MODELOPROD     " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MODELODEPRODUCCION                      " atributo="OBS                                     " tabla="MODELOPROD     " campo="OBS       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="Observaciones                                                                                                                                                   " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MODELODEPRODUCCION                      " atributo="CODIGO                                  " tabla="MODELOPROD     " campo="CODIGO    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="2" etiqueta="Código                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MODELODEPRODUCCION                      " atributo="MODELOSALIDAS                           " tabla="MODSAL         " campo="CODMODSAL " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="402" etiqueta="Salidas                                                                                                                                                         " dominio="DETALLEITEMMODELOSALIDA       " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MODELODEPRODUCCION                      " atributo="MODELOMAQUINAS                          " tabla="MODMAQ         " campo="CODMODMAQ " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="404" etiqueta="Maquinarias                                                                                                                                                     " dominio="DETALLEITEMMODELOMAQUINA      " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="4" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MODELODEPRODUCCION                      " atributo="MODELOINSUMOS                           " tabla="MODINS         " campo="CODMODINS " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="406" etiqueta="Insumos                                                                                                                                                         " dominio="DETALLEITEMMODELOINSUMO       " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MODELODEPRODUCCION                      " atributo="DESCRIPCION                             " tabla="MODELOPROD     " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="4" etiqueta="Descripción                                                                                                                                                     " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MODELODEPRODUCCION                      " atributo="PRODUCTOFINAL                           " tabla="MODELOPROD     " campo="PRODUCTO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="ARTICULO                                " tipodato="C         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="6" etiqueta="Producto final                                                                                                                                                  " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MODELODEPRODUCCION                      " atributo="FAMILIA                                 " tabla="MODELOPROD     " campo="FAMILIA   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="FAMILIA                                 " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="8" etiqueta="Familia                                                                                                                                                         " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="4" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MODELODEPRODUCCION                      " atributo="MATERIAL                                " tabla="MODELOPROD     " campo="MATERIAL  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="MATERIAL                                " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="10" etiqueta="Material                                                                                                                                                        " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="5" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MODELODEPRODUCCION                      " atributo="GRUPO                                   " tabla="MODELOPROD     " campo="GRUPO     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="GRUPO                                   " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="12" etiqueta="Grupo                                                                                                                                                           " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="6" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MODELODEPRODUCCION                      " atributo="CURVADEPRODUCCION                       " tabla="MODELOPROD     " campo="CURVAPROD " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CURVADEPRODUCCION                       " tipodato="C         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="6" etiqueta="Curva de producción                                                                                                                                             " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MODELODEPRODUCCION                      " atributo="MODELOPROCESOS                          " tabla="MODPROC        " campo="CODMODPROC" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="408" etiqueta="Procesos                                                                                                                                                        " dominio="DETALLEITEMMODELOPROCESO      " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="8" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="DESCRIPCION                             " tabla="ART            " campo="ARTDES    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="7" etiqueta="Detalle Pro.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join ART On MODELOPROD.PRODUCTO = ART.ARTCOD And  ART.ARTCOD != ''                                                                                                                                                                                      " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FAMILIA                                 " atributo="DESCRIPCION                             " tabla="FAMILIA        " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="9" etiqueta="Detalle Fam.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join FAMILIA On MODELOPROD.FAMILIA = FAMILIA.Cod And  FAMILIA.COD != ''                                                                                                                                                                                 " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MATERIAL                                " atributo="DESCRIPCION                             " tabla="MAT            " campo="MATDES    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="11" etiqueta="Detalle Mat.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join MAT On MODELOPROD.MATERIAL = MAT.MATCOD And  MAT.MATCOD != ''                                                                                                                                                                                      " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="GRUPO                                   " atributo="DESCRIPCION                             " tabla="GRUPO          " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="13" etiqueta="Detalle Gru.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join GRUPO On MODELOPROD.GRUPO = GRUPO.Cod And  GRUPO.COD != ''                                                                                                                                                                                         " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CURVADEPRODUCCION                       " atributo="DESCRIPCION                             " tabla="CURVAPROD      " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="7" etiqueta="Detalle Cur.                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CURVAPROD On MODELOPROD.CURVAPROD = CURVAPROD.Codigo And  CURVAPROD.CODIGO != ''                                                                                                                                                                   " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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